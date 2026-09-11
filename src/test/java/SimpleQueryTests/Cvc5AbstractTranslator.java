package SimpleQueryTests;
import DbSchema.TableDef;
import com.google.common.collect.ImmutableList;
import io.github.cvc5.*;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import org.apache.calcite.adapter.enumerable.EnumerableTableScan;
import org.apache.calcite.rel.RelNode;
import org.apache.calcite.rel.core.AggregateCall;
import org.apache.calcite.rel.logical.LogicalAggregate;
import org.apache.calcite.rel.logical.LogicalFilter;
import org.apache.calcite.rel.logical.LogicalIntersect;
import org.apache.calcite.rel.logical.LogicalJoin;
import org.apache.calcite.rel.logical.LogicalMinus;
import org.apache.calcite.rel.logical.LogicalProject;
import org.apache.calcite.rel.logical.LogicalUnion;
import org.apache.calcite.rel.logical.LogicalValues;
import org.apache.calcite.rel.type.RelDataType;
import org.apache.calcite.rel.type.RelDataTypeFactoryImpl;
import org.apache.calcite.rel.type.RelDataTypeField;
import org.apache.calcite.rex.RexCall;
import org.apache.calcite.rex.RexInputRef;
import org.apache.calcite.rex.RexLiteral;
import org.apache.calcite.rex.RexNode;
import org.apache.calcite.sql.SqlKind;
import org.apache.calcite.sql.type.BasicSqlType;

/**
 * Translates a pair of Calcite relational plans into an SMT problem that is unsatisfiable
 * exactly when the two SQL queries are equivalent.
 *
 * <p>A table becomes a cvc5 collection of tuples and each relational operator becomes a term
 * over that collection. The two queries are bound to constants {@code q1} and {@code q2},
 * {@code (assert (not (= q1 q2)))} is added, and the solver is asked for a model: {@code unsat}
 * means no database distinguishes them, {@code sat} yields a counterexample database, and
 * {@code unknown} means the per-query time limit was reached.
 *
 * <p>Everything specific to the choice between bag and set semantics is deferred to the
 * subclasses through the abstract hooks below -- which collection sort to use, which kind
 * implements each operator, and what duplicate elimination means. See {@link
 * Cvc5BagsTranslator} and {@link Cvc5SetsTranslator}.
 *
 * <p>Nullable columns are modelled with cvc5's {@code Nullable} sort and SQL's three-valued
 * logic is obtained by lifting operators over it, with {@code AND} and {@code OR} handled
 * explicitly so that {@code FALSE AND NULL} is {@code FALSE} and {@code TRUE OR NULL} is
 * {@code TRUE}.
 *
 * <p>Constructs with no faithful encoding raise {@link UnsupportedOperationException} rather
 * than being approximated. That matters: a wrong encoding surfaces as a bogus {@code unsat},
 * which reads as a proof of equivalence.
 */
public abstract class Cvc5AbstractTranslator
{
  protected final PrintWriter writer;
  private StringBuilder prologue = new StringBuilder();
  protected final boolean isNullable;
  public HashMap<EnumerableTableScan, Term> tables = new HashMap<>();
  /** The same scans as {@link #tables}, as the encoding uses them: lifted where a column was NOT NULL. */
  public HashMap<EnumerableTableScan, Term> tableTerms = new HashMap<>();
  public HashMap<String, Term> declaredFunctions = new HashMap<>();
  protected TermManager tm;
  protected Solver solver;
  protected int functionIndex = 0;
  /**
   * What to print above an assertion in the SMT-LIB output, for the assertions that are worth
   * explaining. Only the key constraints use it: they come from the schema rather than from
   * either query, so without a note they look unexplained in the generated file.
   */
  protected final Map<Term, String> assertionComments = new HashMap<>();

  protected Term zero;
  protected Term one;
  protected Term trueTerm;
  protected Term falseTerm;
  protected final long startTime;
  public static long totalTime = 0;
  public static int unsatAnswers = 0;
  public static int satAnswers = 0;
  public static int unknownAnswers = 0;
  /** Counterexamples a real engine ran both queries on, and how many of those it confirmed. */
  public static int replayedCounterexamples = 0;
  public static int confirmedCounterexamples = 0;

  public Cvc5AbstractTranslator(boolean isNullable, PrintWriter writer)
  {
    this.isNullable = isNullable;
    this.writer = writer;
    startTime = System.currentTimeMillis();
  }

  public void reset() throws CVC5ApiException
  {
    tables.clear();
    tableTerms.clear();
    declaredFunctions.clear();
    assertionComments.clear();
    functionIndex = 0;
    Context.deletePointers();
    tm = new TermManager();
    solver = new Solver(tm);
    solver.setLogic("HO_ALL");
    prologue.append("(set-logic HO_ALL)\n");
    setOption("produce-models", "true");
    setOption("check-models", "true");
    setOption("dag-thresh", "0");
    setOption("uf-lazy-ll", "true");
    setOption("fmf-bound", "true");
    setOption("tlimit-per", "10000");
    setOption("strings-exp", "true");
    // setOption("simplification", "none");
    zero = tm.mkInteger(0);
    one = tm.mkInteger(1);
    trueTerm = tm.mkBoolean(true);
    falseTerm = tm.mkBoolean(false);
  }

  private void setOption(String option, String value)
  {
    solver.setOption(option, value);
    prologue.append("(set-option :" + option + " " + value + ")\n");
  }

  /**
   * Asks whether two queries are equivalent.
   *
   * <p>Encodes both, asserts they differ, and checks satisfiability. On {@code sat} the model is
   * turned into a concrete database and both queries are run against it -- see {@link
   * CounterexampleDatabase} -- to confirm the counterexample independently.
   *
   * @return {@code unsat} if the queries are equivalent, {@code sat} if a database distinguishes
   *     them, {@code unknown} on timeout
   */
  public Result translate(String name, RelNode n1, String sql1, RelNode n2, String sql2)
      throws CVC5ApiException
  {
    reset();
    println(";-----------------------------------------------------------");
    println("; test name: " + name);
    enableKeyReasoning(n1, n2);
    Term q1Term = translate(n1, sql1);
    Term q2Term = translate(n2, sql2);
    // declare a variable for q1, q2.
    Term q1 = defineFun(new Term[0], q1Term.getSort(), q1Term, "q1", false);
    Term q2 = defineFun(new Term[0], q2Term.getSort(), q2Term, "q2", false);
    solver.assertFormula(q1.eqTerm(q2).notTerm());
    printSmtProblem();
    Result result = solver.checkSat();
    long stopTime = System.currentTimeMillis();
    long duration = stopTime - startTime;
    totalTime += duration;
    println(";answer: " + result);
    println("; duration: " + duration + " ms.");
    if (result.isSat())
    {
      satAnswers++;
      println("(get-model)");
      Term[] terms = tables.values().toArray(new Term[0]);
      String model = solver.getModel(new Sort[0], terms);
      for (String line : model.split("\n"))
      {
        println("; " + line);
      }

      println("; q1");
      println("(get-value (" + q1 + "))");
      println("; " + solver.getValue(q1));
      println("; q2");
      println("(get-value (" + q2 + "))");
      println("; " + solver.getValue(q2));

      replayCounterexample(name, n1, sql1, sql2);
    }
    if (result.isUnsat())
    {
      unsatAnswers++;
      Cvc5Analysis.cvc5ProvenTests.add(name);
    }
    if (result.isUnknown())
    {
      unknownAnswers++;
      Cvc5Analysis.cvc5ProvenTests.add(name);
    }
    print("(reset)\n");
    return result;
  }

  /**
   * Whether this translator encodes set semantics. The counterexample replay needs it: under
   * sets a row is present or absent, under bags the number of copies is part of the answer.
   */
  protected abstract boolean isSetSemantics();

  /** Expands a collection value from a model into the rows of a counterexample table. */
  protected abstract List<List<Object>> getTableRows(Term tableValue) throws CVC5ApiException;

  /** The kind of the empty-collection value, used to recognise it in a model. */
  protected abstract Kind getEmptyKind();

  protected List<Object> getTupleValues(Term tuple)
  {
    List<Object> tupleValues = new ArrayList<>();
    Term[] fields = tuple.getTupleValue();
    for (int i = 0; i < fields.length; i++)
    {
      if (fields[i].getSort().isNullable())
      {
        Term isSome = solver.simplify(tm.mkNullableIsSome(fields[i]));
        if (isSome.getBooleanValue())
        {
          Term cvc5Value = solver.simplify(tm.mkNullableVal(fields[i]));
          Object javaValue = getFieldValue(cvc5Value);
          tupleValues.add(javaValue);
        }
        else
        {
          tupleValues.add(null);
        }
      }
      else
      {
        Object javaValue = getFieldValue(fields[i]);
        tupleValues.add(javaValue);
      }
    }
    return tupleValues;
  }

  private Object getFieldValue(Term field)
  {
    if (field.isIntegerValue())
    {
      return field.getIntegerValue();
    }
    else if (field.isStringValue())
    {
      return field.getStringValue();
    }
    throw new RuntimeException("Unsupported type: " + field.getSort());
  }

  /**
   * Hands the model to a real SQL engine and prints what it says.
   *
   * <p>The model is a database, so the queries can simply be run on it. Anything the check
   * says is a comment in the output -- it never changes the answer -- but a counterexample the
   * engine cannot reproduce is the one thing a {@code sat} answer cannot catch by itself: it
   * means an encoding does not mean what its query means.
   *
   * @param n1 either plan, read only for how many columns the queries return
   */
  private void replayCounterexample(String name, RelNode n1, String sql1, String sql2)
      throws CVC5ApiException
  {
    List<CounterexampleDatabase.Table> counterexample = new ArrayList<>();
    for (Map.Entry<EnumerableTableScan, Term> entry : tables.entrySet())
    {
      EnumerableTableScan scan = entry.getKey();
      TableDef definition = scan.getTable().unwrap(TableDef.class);
      List<String> path = scan.getTable().getQualifiedName();
      counterexample.add(new CounterexampleDatabase.Table(
          definition != null ? definition.name() : path.get(path.size() - 1),
          definition != null ? definition.schemaName() : null,
          scan.getRowType(),
          definition != null ? definition.keys() : null,
          getTableRows(solver.getValue(entry.getValue()))));
    }
    CounterexampleDatabase.Report report = CounterexampleDatabase.verify(
        name, sql1, sql2, n1.getRowType().getFieldCount(), isSetSemantics(), counterexample);
    for (String line : report.lines())
    {
      println("; " + line);
    }
    if (report.isChecked())
    {
      replayedCounterexamples++;
      if (report.isConfirmed())
      {
        confirmedCounterexamples++;
      }
    }
  }

  protected void println(Object object)
  {
    writer.println(object);
    System.out.println(object);
    writer.flush();
  }
  protected void print(Object object)
  {
    writer.print(object);
    System.out.print(object);
    writer.flush();
  }

  protected void printSmtProblem()
  {
    println(prologue.toString());

    Term[] terms = tables.values().toArray(new Term[0]);
    for (Term term : terms)
    {
      print("(declare-const ");
      print(term + " ");
      println(term.getSort() + ")");
    }
    for (Map.Entry<String, Term> entry : declaredFunctions.entrySet())
    {
      print("(declare-const ");
      print(entry.getKey() + " ");
      println(entry.getValue().getSort() + ")");
    }
    for (Term term : solver.getAssertions())
    {
      String comment = assertionComments.get(term);
      if (comment != null)
      {
        println("; " + comment);
      }
      print("(assert ");
      print(term);
      println(")");
    }
    println("(check-sat)");
  }

  public Term translate(RelNode n, String sql) throws CVC5ApiException
  {
    println(";Translating sql query: " + sql);
    return translate(n);
  }

  /** Dispatches on the relational operator. Anything not handled is refused by name. */
  public Term translate(RelNode n) throws CVC5ApiException
  {
    if (n instanceof EnumerableTableScan)
    {
      return translate((EnumerableTableScan) n);
    }
    if (n instanceof LogicalAggregate)
    {
      return translate((LogicalAggregate) n);
    }
    if (n instanceof LogicalProject)
    {
      return translate((LogicalProject) n);
    }
    if (n instanceof LogicalFilter)
    {
      return translate((LogicalFilter) n);
    }
    if (n instanceof LogicalJoin)
    {
      return translate((LogicalJoin) n);
    }
    if (n instanceof LogicalUnion)
    {
      return translate((LogicalUnion) n);
    }
    if (n instanceof LogicalMinus)
    {
      return translate((LogicalMinus) n);
    }
    if (n instanceof LogicalIntersect)
    {
      return translate((LogicalIntersect) n);
    }
    if (n instanceof LogicalValues)
    {
      return translate((LogicalValues) n);
    }
    // Returning null here used to surface much later as a NullPointerException on the
    // caller's Term; naming the node makes the gap obvious and lets the batch skip it.
    // LogicalSort (ORDER BY, LIMIT, OFFSET), LogicalWindow, LogicalCorrelate and
    // LogicalTableFunctionScan all land here.
    throw new UnsupportedOperationException(
        "unsupported relational operator " + n.getClass().getSimpleName() + ": " + n);
  }

  private Term translate(LogicalIntersect intersect) throws CVC5ApiException
  {
    List<RelNode> inputs = intersect.getInputs();
    Term result = translate(inputs.get(0));
    for (int i = 1; i < inputs.size(); i++)
    {
      result = tm.mkTerm(getIntersectionKind(), result, translate(inputs.get(i)));
    }
    // INTERSECT (without ALL) returns distinct rows
    return intersect.all ? result : mkDistinct(result);
  }

  /** {@code INTERSECT ALL}: bag.inter_min or set.inter. */
  protected abstract Kind getIntersectionKind();

  /**
   * Duplicate removal. Under set semantics this is the identity, since sets carry no
   * duplicates. Under bag semantics it is bag.setof, which caps every multiplicity at 1.
   * Needed wherever SQL specifies distinct results: SELECT DISTINCT, a GROUP BY with no
   * aggregate calls, and the non-ALL forms of UNION / EXCEPT / INTERSECT.
   */
  protected abstract Term mkDistinct(Term table);

  /** {@code EXCEPT} / {@code EXCEPT ALL}; the subclass picks the difference operator. */
  protected abstract Term translate(LogicalMinus minus) throws CVC5ApiException;

  private Term translate(LogicalAggregate aggregate) throws CVC5ApiException
  {
    Term child = translate(aggregate.getInput());
    int[] indices = aggregate.getGroupSet().toArray();
    List<AggregateCall> calls = aggregate.getAggCallList();
    if (calls.isEmpty())
    {
      // duplicate removal of a projection: SELECT DISTINCT, or GROUP BY with no aggregates

      // (bag.setof ((_ table.project indices) child))
      Op op = tm.mkOp(getProjectKind(), indices);
      return mkDistinct(tm.mkTerm(op, child));
    }

    // The argument column of each call, or -1 for COUNT(*).
    int[] argIndices = new int[calls.size()];
    for (int j = 0; j < calls.size(); j++)
    {
      AggregateCall call = calls.get(j);
      checkSupported(call);
      argIndices[j] = call.getArgList().isEmpty() ? -1 : call.getArgList().get(0);
    }

    if (calls.stream().anyMatch(AggregateCall::isDistinct))
    {
      // table.aggr folds over every copy in the bag, so a DISTINCT aggregate needs its
      // duplicates removed first. Projecting onto (group keys, argument) and applying
      // bag.setof does that, but it only serves one call: a second aggregate would need
      // its own, differently de-duplicated, input.
      if (calls.size() != 1 || argIndices[0] < 0)
      {
        throw new UnsupportedOperationException(
            "DISTINCT aggregate alongside other aggregates is not supported: " + calls);
      }
      int groupCount = indices.length;
      int[] keep = Arrays.copyOf(indices, groupCount + 1);
      keep[groupCount] = argIndices[0];
      child = mkDistinct(tm.mkTerm(tm.mkOp(getProjectKind(), keep), child));
      indices = IntStream.range(0, groupCount).toArray();
      argIndices[0] = groupCount;
    }

    // construct a lambda function that handles all aggregate functions
    Sort xTupleSort = getElementSort(child.getSort());
    Term x = tm.mkVar(xTupleSort, "x");
    String name = String.join("_", calls.stream().map(s -> s.getAggregation().getName()).toList())
                      .toLowerCase();
    Sort yTupleSort = getSort(aggregate.getRowType());
    Term y = tm.mkVar(yTupleSort, "y");
    int yTupleLength = yTupleSort.getTupleLength();
    Sort[] yTupleSorts = yTupleSort.getTupleSorts();
    Term[] tupleElements = new Term[yTupleLength];
    Term[] initialValues = new Term[yTupleLength];
    // add grouping elements
    int yIndex = 0;
    for (int index : indices)
    {
      tupleElements[yIndex] = mkTupleSelect(xTupleSort, x, index);
      // never read: the first element of each group overwrites it. It only has to typecheck.
      initialValues[yIndex] = mkNullOfSort(yTupleSorts[yIndex]);
      yIndex++;
    }

    // add aggregate functions
    for (int j = 0; j < calls.size(); j++)
    {
      Term arg = argIndices[j] < 0 ? null : mkTupleSelect(xTupleSort, x, argIndices[j]);
      Term acc = mkTupleSelect(yTupleSort, y, yIndex);
      mkAggregateFun(calls.get(j), arg, acc, tupleElements, initialValues, yIndex);
      yIndex++;
    }

    Term body = tm.mkTuple(tupleElements);
    Term initialValue = tm.mkTuple(initialValues);
    Term f = defineFun(new Term[] {x, y}, yTupleSort, body, name, true);
    Op op = tm.mkOp(getAggregateKind(), indices);
    Term aggregated = tm.mkTerm(op, new Term[] {f, initialValue, child});
    if (indices.length == 0)
    {
      // No GROUP BY: SQL asks for exactly one row even when there is nothing to aggregate --
      // SELECT COUNT(*) FROM empty is 0, not no rows -- which is what the fold of a single
      // empty group gives.
      return aggregated;
    }
    // GROUP BY over an empty table has no groups, so SQL answers with no rows. table.aggr
    // does not: it reduces to a fold over (table.group A), and cvc5 gives the empty table a
    // partition holding one empty part rather than no parts at all --
    //     if (parts.empty()) { ... add an empty part ... }   in BagsUtils::evaluateGroup
    // -- and folding that one part yields a row built out of the initial value. That phantom
    // row is a whole counterexample on its own: it made queries that agree on every database
    // look different on the empty one. Nothing else in the operator misbehaves, and a part
    // can only be missing when the input has no rows, so guarding that one case is enough.
    Term empty = mkEmptyTable(child.getSort());
    Term emptyResult = mkEmptyTable(mkTableSort(yTupleSort));
    return tm.mkTerm(Kind.ITE, child.eqTerm(empty), emptyResult, aggregated);
  }

  private void checkSupported(AggregateCall call)
  {
    if (call.hasFilter())
    {
      throw new UnsupportedOperationException("aggregate FILTER is not supported: " + call);
    }
    if (call.getArgList().size() > 1)
    {
      throw new UnsupportedOperationException("multi-argument aggregate: " + call);
    }
    switch (call.getAggregation().kind)
    {
      case COUNT:
      case SUM:
      case SUM0:
      case MIN:
      case MAX: break;
      default: throw new UnsupportedOperationException("unsupported aggregate: " + call);
    }
    if (!isNullable)
    {
      // SUM/MIN/MAX seed the fold with null to mean "no value yet", and the grouping
      // columns need a null placeholder too, so the tuple sorts have to be nullable.
      throw new UnsupportedOperationException("aggregates require nullable sorts: " + call);
    }
  }

  /**
   * Builds one accumulator slot of the fold performed by table.aggr / relation.aggr.
   *
   * <p>{@code arg} is the aggregated column of the current row, null for COUNT(*).
   * {@code acc} is the running value, still wrapped in its Nullable sort. SQL aggregates
   * skip null inputs, and SUM/MIN/MAX over a group with no non-null value are null, so
   * those seed the accumulator with null rather than zero and treat a null accumulator as
   * "nothing seen yet". COUNT is different: it starts at zero and never returns null.
   */
  private void mkAggregateFun(
      AggregateCall call, Term arg, Term acc, Term[] tupleElements, Term[] initialValues, int yIndex)
  {
    Sort accSort = acc.getSort();
    switch (call.getAggregation().kind)
    {
      case COUNT:
      {
        Term incremented = tm.mkTerm(Kind.ADD, mkVal(acc), one);
        // COUNT(*) counts every row, COUNT(x) skips the rows where x is null
        Term result = arg == null
            ? incremented
            : tm.mkTerm(Kind.ITE, mkIsNull(arg), mkVal(acc), incremented);
        tupleElements[yIndex] = mkSome(accSort, result);
        initialValues[yIndex] = mkSome(accSort, zero);
        return;
      }
      case SUM:
      case SUM0:
      case MIN:
      case MAX:
      {
        Term combined;
        switch (call.getAggregation().kind)
        {
          case MIN: combined = tm.mkTerm(Kind.ITE, mkLess(arg, acc), arg, acc); break;
          case MAX: combined = tm.mkTerm(Kind.ITE, mkLess(acc, arg), arg, acc); break;
          default:
            combined = mkSome(accSort, tm.mkTerm(Kind.ADD, mkVal(arg), mkVal(acc)));
        }
        // a null row leaves the accumulator alone; the first non-null row seeds it
        tupleElements[yIndex] = tm.mkTerm(Kind.ITE,
            mkIsNull(arg),
            acc,
            tm.mkTerm(Kind.ITE, mkIsNull(acc), arg, combined));
        // SUM0 is Calcite's null-free SUM: it returns 0 rather than null for an empty group
        initialValues[yIndex] = call.getAggregation().kind == SqlKind.SUM0
            ? mkSome(accSort, zero)
            : mkNullOfSort(accSort);
        return;
      }
      default: throw new UnsupportedOperationException("unsupported aggregate: " + call);
    }
  }

  /** {@code a < b} on the unwrapped values, using the string ordering where applicable. */
  private Term mkLess(Term a, Term b)
  {
    Sort sort = a.getSort();
    Sort elementSort = sort.isNullable() ? sort.getNullableElementSort() : sort;
    Kind k = elementSort.isString() ? Kind.STRING_LT : Kind.LT;
    return tm.mkTerm(k, mkVal(a), mkVal(b));
  }

  private Term mkIsNull(Term term)
  {
    return term.getSort().isNullable() ? tm.mkNullableIsNull(term) : falseTerm;
  }

  private Term mkVal(Term term)
  {
    return term.getSort().isNullable() ? tm.mkNullableVal(term) : term;
  }

  private Term mkSome(Sort sort, Term value)
  {
    return sort.isNullable() ? tm.mkNullableSome(value) : value;
  }

  private Term mkNullOfSort(Sort sort)
  {
    if (!sort.isNullable())
    {
      throw new UnsupportedOperationException("a null placeholder needs a nullable sort: " + sort);
    }
    return tm.mkNullableNull(sort);
  }

  private Term mkTupleSelect(Sort tupleSort, Term t, int index)
  {
    Datatype datatype = tupleSort.getDatatype();
    DatatypeConstructor constructor = datatype.getConstructor(0);
    Term selectorTerm = constructor.getSelector(index).getTerm();
    Term selectedTerm = tm.mkTerm(Kind.APPLY_SELECTOR, new Term[] {selectorTerm, t});
    return selectedTerm;
  }

  /** The fold operator: table.aggr or relation.aggr. */
  protected abstract Kind getAggregateKind();


  /** {@code UNION} / {@code UNION ALL}; the subclass picks the union operator. */
  protected abstract Term translate(LogicalUnion n) throws CVC5ApiException;

  /** Column projection: table.project or relation.project. Under bags this sums
   * multiplicities, which is what a plain SQL projection does. */
  protected abstract Kind getProjectKind();

  protected Term translate(LogicalValues values)
  {
    ImmutableList<ImmutableList<RexLiteral>> sqlTuples = values.getTuples();
    Term[] smtTuples = new Term[sqlTuples.size()];
    for (int i = 0; i < sqlTuples.size(); i++)
    {
      ImmutableList<RexLiteral> tuple = sqlTuples.get(i);
      Term[] terms = new Term[tuple.size()];
      for (int j = 0; j < tuple.size(); j++)
      {
        terms[j] = translate(tuple.get(j));
      }
      Term smtTuple = tm.mkTuple(terms);
      Term singleton = mkSingleton(smtTuple);
      smtTuples[i] = singleton;
    }
    if (smtTuples.length == 0)
    {
      // mkEmptyBag/mkEmptySet want the collection sort, not the tuple sort
      Sort sort = mkTableSort(getSort(values.getRowType()));
      Term empty = mkEmptyTable(sort);
      return empty;
    }
    if (smtTuples.length == 1)
    {
      return smtTuples[0];
    }
    Term union = smtTuples[0];
    for (int i = 1; i < smtTuples.length; i++)
    {
      union = tm.mkTerm(getUnionAllKind(), union, smtTuples[i]);
    }
    return union;
  }

  /** Multiset sum, used for {@code UNION ALL}, literal {@code VALUES} and outer-join padding. */
  protected abstract Kind getUnionAllKind();

  /** The empty table. {@code sort} is the collection sort, not the tuple sort. */
  protected abstract Term mkEmptyTable(Sort sort);

  /** A one-row table holding {@code smtTuple}. */
  protected abstract Term mkSingleton(Term smtTuple);

  protected Term translate(LogicalJoin n) throws CVC5ApiException
  {
    Term a = translate(n.getLeft());
    Term b = translate(n.getRight());
    Term product = tm.mkTerm(getProductKind(), a, b);
    if (!n.getCondition().isAlwaysTrue())
    {
      product = applyFilter(n.getCondition(), product);
    }
    switch (n.getJoinType())
    {
      case INNER: return product;
      case LEFT:
      {
        Term left = mkLeft(a, product);
        Term join = tm.mkTerm(getUnionAllKind(), left, product);
        return join;
      }
      case RIGHT:
      {
        Term right = mkRight(b, product);
        Term join = tm.mkTerm(getUnionAllKind(), right, product);
        return join;
      }
      case FULL:
      {
        Term left = mkLeft(a, product);
        Term right = mkRight(b, product);
        Term join = tm.mkTerm(getUnionAllKind(), left, right);
        join = tm.mkTerm(getUnionAllKind(), join, product);
        return join;
      }
      // SEMI and ANTI joins have no encoding here; Calcite usually rewrites them into
      // an inner join over an aggregate before we see them.
      default:
        throw new UnsupportedOperationException("unsupported join type " + n.getJoinType());
    }
  }

  /**
   * The {@code LEFT JOIN} rows that the inner join misses: the rows of {@code a} that no
   * product row projects back onto, each padded with nulls on the right.
   *
   * <p>The difference has to drop a row entirely once it matches anything, rather than
   * subtracting multiplicities, so that a left row matching {@code k} right rows contributes no
   * padded row at all while an unmatched row keeps every one of its copies.
   */
  private Term mkLeft(Term a, Term product) throws CVC5ApiException
  {
    //(set.map
    // (lambda ((t (Tuple)))
    //         (tuple ((_ tuple.select 0) t) .. ((_ tuple.select (m - 1)) t) null ..null))
    //  (set.minus a ((_ set.project 0 .. (m - 1)) product))
    Sort aTupleSort = getElementSort(a.getSort());
    int aTupleLength = aTupleSort.getTupleLength();
    int[] aIndices = IntStream.range(0, aTupleLength).boxed().mapToInt(Integer::intValue).toArray();
    Op op = tm.mkOp(getProjectKind(), aIndices);
    Term projection = tm.mkTerm(op, product);
    Term difference = tm.mkTerm(getDifferenceRemoveKind(), a, projection);

    Sort productTupleSort = getElementSort(product.getSort());
    Datatype aDatatype = aTupleSort.getDatatype();
    DatatypeConstructor aConstructor = aDatatype.getConstructor(0);
    int productTupleLength = productTupleSort.getTupleLength();
    Term[] terms = new Term[productTupleLength];
    Term t = tm.mkVar(aTupleSort, "t");
    // fill a elements
    for (int i = 0; i < aTupleLength; i++)
    {
      Term selectorTerm = aConstructor.getSelector(i).getTerm();
      Term selectedTerm = tm.mkTerm(Kind.APPLY_SELECTOR, new Term[] {selectorTerm, t});
      terms[i] = selectedTerm;
    }
    // fill the remaining elements with nulls
    Sort[] productTupleSorts = productTupleSort.getTupleSorts();
    for (int i = aTupleLength; i < productTupleLength; i++)
    {
      Sort elementSort = productTupleSorts[i];
      terms[i] = tm.mkNullableNull(elementSort);
    }
    Term productTuple = tm.mkTuple(terms);

    Term f = defineFun(new Term[] {t}, productTupleSort, productTuple, "leftJoin", true);
    Term mapF = tm.mkTerm(getMapKind(), f, difference);
    return mapF;
  }

  /** The mirror image of {@link #mkLeft}: unmatched rows of {@code b}, padded on the left. */
  private Term mkRight(Term b, Term product) throws CVC5ApiException
  {
    //(set.map
    // (lambda ((t (Tuple)))
    //         (tuple null ..null ((_ tuple.select 0) t) .. ((_ tuple.select (n - 1)) t)))
    //  (set.minus b ((_ set.project m .. (n - 1)) product))
    Sort bTupleSort = getElementSort(b.getSort());
    int bTupleLength = bTupleSort.getTupleLength();
    Sort productTupleSort = getElementSort(product.getSort());
    int productTupleLength = productTupleSort.getTupleLength();
    int aTupleLength = productTupleLength - bTupleLength;
    int[] bIndices = IntStream.range(aTupleLength, productTupleLength)
                         .boxed()
                         .mapToInt(Integer::intValue)
                         .toArray();
    Op op = tm.mkOp(getProjectKind(), bIndices);
    Term projection = tm.mkTerm(op, product);
    Term difference = tm.mkTerm(getDifferenceRemoveKind(), b, projection);

    Datatype bDatatype = bTupleSort.getDatatype();
    DatatypeConstructor bConstructor = bDatatype.getConstructor(0);

    Term[] terms = new Term[productTupleLength];
    Term t = tm.mkVar(bTupleSort, "t");
    // fill initial elements with nulls
    Sort[] tupleSorts = productTupleSort.getTupleSorts();
    for (int i = 0; i < aTupleLength; i++)
    {
      Sort elementSort = tupleSorts[i];
      terms[i] = tm.mkNullableNull(elementSort);
    }
    // fill b elements
    for (int i = aTupleLength; i < productTupleLength; i++)
    {
      Term selectorTerm = bConstructor.getSelector(i - aTupleLength).getTerm();
      Term selectedTerm = tm.mkTerm(Kind.APPLY_SELECTOR, new Term[] {selectorTerm, t});
      terms[i] = selectedTerm;
    }
    Term productTuple = tm.mkTuple(terms);

    Term f = defineFun(new Term[] {t}, productTupleSort, productTuple, "rightJoin", true);
    Term mapF = tm.mkTerm(getMapKind(), f, difference);
    return mapF;
  }

  /** Difference that drops a row entirely once it matches, used to find the unmatched
   * rows of an outer join. */
  protected abstract Kind getDifferenceRemoveKind();

  /** The tuple sort held by a collection sort. */
  protected abstract Sort getElementSort(Sort sort);

  /** Cartesian product: table.product or relation.product. */
  protected abstract Kind getProductKind();

  protected Term translate(LogicalFilter n) throws CVC5ApiException
  {
    // (set.filter (lambda (t (Tuple ...) ) ... ) input)
    Term child = translate(n.getInput());
    return applyFilter(n.getCondition(), child);
  }

  protected Term applyFilter(RexNode condition, Term table)
  {
    Sort tupleSort = getElementSort(table.getSort());
    Datatype datatype = tupleSort.getDatatype();
    DatatypeConstructor constructor = datatype.getConstructor(0);
    Term t = tm.mkVar(tupleSort, "t");
    Sort functionType = tm.getBooleanSort();
    Term body = translateRowExpr(condition, constructor, t, "");
    body = mkIsSomeValIfNullable(body);
    Term p = defineFun(new Term[] {t}, functionType, body, "p", true);
    Term ret = tm.mkTerm(getFilterKind(), p, table);
    return ret;
  }

  /** {@code WHERE}: bag.filter or set.filter. */
  protected abstract Kind getFilterKind();

  protected Term defineFun(
      Term[] vars, Sort functionType, Term body, String prefix, boolean includeIndex)
  {
    String name = prefix;
    if (includeIndex)
    {
      name = prefix + functionIndex;
    }
    Term f = solver.defineFun(name, vars, functionType, body, true);
    functionIndex++;
    declaredFunctions.put(name, f);
    return f;
  }

  protected Term declareFun(Sort[] args, Sort functionType, String prefix, boolean includeIndex)
  {
    String name = prefix;
    if (includeIndex)
    {
      name = prefix + functionIndex;
    }
    Term f = solver.declareFun(name, args, functionType);
    functionIndex++;
    declaredFunctions.put(name, f);
    return f;
  }

  /**
   * A projection. When every expression is a plain column reference this is the cheap
   * {@code table.project}; otherwise a lambda is mapped over the table.
   */
  protected Term translate(LogicalProject project) throws CVC5ApiException
  {
    // check whether to use table.project or set.map
    boolean isTableProject = true;
    List<RexNode> exprs = project.getChildExps();
    int[] indices = new int[exprs.size()];
    for (int i = 0; i < exprs.size(); i++)
    {
      RexNode expr = exprs.get(i);
      if (expr instanceof RexInputRef)
      {
        RexInputRef rex = (RexInputRef) expr;
        indices[i] = rex.getIndex();
      }
      else
      {
        isTableProject = false;
      }
    }
    Term child = translate(project.getInput());
    if (isTableProject)
    {
      // ((_ table.project indices) input)
      Op op = tm.mkOp(getProjectKind(), indices);
      Term ret = tm.mkTerm(op, child);
      return ret;
    }
    else
    {
      // (set.map (lambda (t (Tuple ...) ) ... ) input)
      Sort argType = getElementSort(child.getSort());
      Term t = tm.mkVar(argType, "t");
      Sort functionType = getSort(project.getRowType());

      Datatype datatype = t.getSort().getDatatype();
      DatatypeConstructor constructor = datatype.getConstructor(0);
      Term[] terms = new Term[exprs.size()];
      for (int i = 0; i < terms.length; i++)
      {
        terms[i] = translateRowExpr(exprs.get(i), constructor, t, "");
      }
      Term body = tm.mkTuple(terms);
      Term f = defineFun(new Term[] {t}, functionType, body, "f", true);
      Term ret = tm.mkTerm(getMapKind(), f, child);
      return ret;
    }
  }

  /** Projection through an expression: bag.map or set.map. */
  protected abstract Kind getMapKind();

  protected Term translateRowExpr(
      RexNode expr, DatatypeConstructor constructor, Term t, String operator)
  {
    if (expr instanceof RexInputRef)
    {
      // ((_ tuple.select index) t)
      RexInputRef rex = (RexInputRef) expr;
      int index = rex.getIndex();

      Term selectorTerm = constructor.getSelector(index).getTerm();
      Term selectedTerm = tm.mkTerm(Kind.APPLY_SELECTOR, new Term[] {selectorTerm, t});
      Term simplifiedTerm = solver.simplify(selectedTerm);
      return simplifiedTerm;
    }
    else if (expr instanceof RexLiteral)
    {
      return translate(expr);
    }
    else if (expr instanceof RexCall)
    {
      RexCall call = (RexCall) expr;
      Kind k;
      if (call.op.toString().equals("CAST"))
      {
        Term ret = translateRowExpr(call.getOperands().get(0), constructor, t, "");
        return ret;
      }
      Term[] argTerms = getArgTerms(constructor, t, call);
      boolean needsLifting =
          Arrays.asList(argTerms).stream().anyMatch(a -> a.getSort().isNullable());
      if (needsLifting)
      {
        argTerms = getNullableTerms(needsLifting, argTerms);
      }
      switch (call.op.toString())
      {
        case "=": k = Kind.EQUAL; break;
        case "<>": k = Kind.DISTINCT; break;
        case "+": k = Kind.ADD; break;
        case "-": k = Kind.SUB; break;
        case ">":
        {
          k = Kind.GT;
          Sort sort = getSort(call.operands.get(0).getType());
          if (sort.isString() || (sort.isNullable() && sort.getNullableElementSort().isString()))
          {
            k = Kind.STRING_LT;
            swap(argTerms, 0, 1);
          }
          break;
        }
        case "<":
        {
          k = Kind.LT;
          Sort sort = getSort(call.operands.get(0).getType());
          if (sort.isString() || (sort.isNullable() && sort.getNullableElementSort().isString()))
          {
            k = Kind.STRING_LT;
          }
          break;
        }
        case ">=":
        {
          k = Kind.GEQ;
          Sort sort = getSort(call.operands.get(0).getType());
          if (sort.isString() || (sort.isNullable() && sort.getNullableElementSort().isString()))
          {
            k = Kind.STRING_LEQ;
            swap(argTerms, 0, 1);
          }
          break;
        }
        case "<=":
        {
          k = Kind.LEQ;
          Sort sort = getSort(call.operands.get(0).getType());
          if (sort.isString() || (sort.isNullable() && sort.getNullableElementSort().isString()))
          {
            k = Kind.STRING_LEQ;
          }
          break;
        }
        case "*": k = Kind.MULT; break;
        case "/": k = Kind.DIVISION; break;
        case "AND": return translateAnd(needsLifting, argTerms);
        case "OR": return translateOr(needsLifting, argTerms);
        case "NOT": k = Kind.NOT; break;
        case "UPPER": k = Kind.STRING_TO_UPPER; break;
        case "SUBSTRING": return translateNullableSubstring(needsLifting, argTerms);
        case "||": k = Kind.STRING_CONCAT; break;
        case "CASE":
        {
          // Calcite flattens CASE WHEN c1 THEN v1 WHEN c2 THEN v2 ELSE e into the single call
          // CASE(c1, v1, c2, v2, e), so fold it into nested ite terms from the back. Each
          // condition is read two-valued: a NULL condition takes the else branch.
          if (argTerms.length % 2 == 0)
          {
            throw new UnsupportedOperationException("CASE without an ELSE branch: " + call);
          }
          Term result = argTerms[argTerms.length - 1];
          for (int i = argTerms.length - 3; i >= 0; i -= 2)
          {
            result = tm.mkTerm(Kind.ITE, mkIsSomeValIfNullable(argTerms[i]), argTerms[i + 1], result);
          }
          return result;
        }
        case "IS TRUE": return mkIsSomeValIfNullable(argTerms[0]);
        case "IS NOT TRUE":
        {
          Term term = mkIsSomeValIfNullable(argTerms[0]);
          return term.notTerm();
        }
        case "IS NULL":
        {
          argTerms = getArgTerms(constructor, t, call);
          if (argTerms[0].getSort().isNullable())
          {
            return tm.mkNullableIsNull(argTerms[0]);
          }
          return falseTerm;
        }
        case "IS NOT NULL":
        {
          argTerms = getArgTerms(constructor, t, call);
          if (argTerms[0].getSort().isNullable())
          {
            return tm.mkNullableIsSome(argTerms[0]);
          }
          return trueTerm;
        }
        default:
          throw new UnsupportedOperationException("unsupported operator: " + call);
      }

      if (needsLifting)
      {
        return tm.mkNullableLift(k, argTerms);
      }
      return tm.mkTerm(k, argTerms);
    }
    else
    {
      throw new UnsupportedOperationException("unsupported row expression: " + expr);
    }
  }

  private Term translateNullableSubstring(boolean needsLifting, Term[] argTerms)
  {
    if (needsLifting)
    {
      Term orTerm = tm.mkNullableIsNull(argTerms[0]);
      orTerm = orTerm.orTerm(tm.mkNullableIsNull(argTerms[1]));
      if (argTerms.length == 3)
      {
        orTerm = orTerm.orTerm(tm.mkNullableIsNull(argTerms[2]));
      }
      Term nullString = tm.mkNullableNull(tm.mkNullableSort(tm.getStringSort()));
      
      for (int i = 0; i < argTerms.length; i++)
      {
        argTerms[i] = tm.mkNullableVal(argTerms[i]);
      }
      Term substring = translateSubstring(argTerms);
      Term some = tm.mkNullableSome(substring);
      Term ite = tm.mkTerm(Kind.ITE, orTerm, nullString, some);
      return ite;
    }
    else
    {
      return translateSubstring(argTerms);
    }
  }

  private Term translateSubstring(Term[] argTerms)
  {
    assert (argTerms.length >= 2);
    // decrease stat index by 1 since smt is 0 based, whereas SQL is 1 based
    argTerms[1] = tm.mkTerm(Kind.SUB, argTerms[1], one);
    if (argTerms.length == 2)
    {
      // SELECT SUBSTRING('abcdef' from 2) = bcdef
      Term[] arguments = new Term[3];
      arguments[0] = argTerms[0];
      arguments[1] = argTerms[1];
      Term stringTerm = argTerms[0];
      arguments[2] = tm.mkTerm(Kind.STRING_LENGTH, stringTerm);
      argTerms = arguments;
    }
    System.out.println("substring args: " + Arrays.toString(argTerms));
    System.out.println("substring sorts: " + argTerms[0].getSort());
    System.out.println("substring sorts: " + argTerms[1].getSort());
    System.out.println("substring sorts: " + argTerms[2].getSort());
    Term substring = tm.mkTerm(Kind.STRING_SUBSTR, argTerms);
    substring = solver.simplify(substring);
    return substring;
  }

  private Term translateAnd(boolean needsLifting, Term[] argTerms)
  {
    if (!needsLifting)
    {
      return tm.mkTerm(Kind.AND, argTerms);
    }
    return mkShortCircuit(argTerms, Kind.AND, false);
  }

  private Term translateOr(boolean needsLifting, Term[] argTerms)
  {
    if (!needsLifting)
    {
      return tm.mkTerm(Kind.OR, argTerms);
    }
    return mkShortCircuit(argTerms, Kind.OR, true);
  }

  /**
   * Three-valued {@code AND} / {@code OR} over nullable booleans.
   *
   * <p>Lifting alone is not enough: {@code nullable.lift} propagates null from any operand,
   * but SQL's {@code AND} is {@code FALSE} as soon as *some* operand is {@code FALSE}, however
   * many of the others are {@code NULL} -- and dually for {@code OR} and {@code TRUE}. So the
   * dominant value is tested for first, across every operand, and the lift is used only once
   * no operand is known to be dominant.
   *
   * <p>Calcite flattens {@code a AND b AND c} into a single n-ary call, so this has to scan all
   * the operands rather than just the first two.
   *
   * @param dominant {@code true} for {@code OR}, whose dominant value is {@code TRUE};
   *     {@code false} for {@code AND}, whose dominant value is {@code FALSE}
   */
  private Term mkShortCircuit(Term[] argTerms, Kind kind, boolean dominant)
  {
    if (argTerms.length == 1)
    {
      return argTerms[0];
    }
    Term isDominant = null;
    for (Term arg : argTerms)
    {
      Term value = tm.mkNullableVal(arg);
      Term known = tm.mkNullableIsSome(arg).andTerm(dominant ? value : value.notTerm());
      isDominant = isDominant == null ? known : isDominant.orTerm(known);
    }
    Term dominantValue = tm.mkNullableSome(dominant ? trueTerm : falseTerm);
    return tm.mkTerm(Kind.ITE, isDominant, dominantValue, tm.mkNullableLift(kind, argTerms));
  }

  private Term[] getNullableTerms(boolean needsLifting, Term[] argTerms)
  {
    if (needsLifting)
    {
      for (int i = 0; i < argTerms.length; i++)
      {
        if (!argTerms[i].getSort().isNullable())
        {
          System.out.println("argTerms[" + i + "].getSort() = " + argTerms[i].getSort());
          System.out.println("argTerms[" + i + "] = " + argTerms[i]);
          argTerms[i] = tm.mkNullableSome(argTerms[i]);
        }
      }
    }
    return argTerms;
  }

  /**
   * Reads a nullable boolean as a plain one for a context that needs two-valued logic, such as
   * a {@code WHERE} clause: only {@code some(true)} passes, so {@code NULL} filters the row out.
   */
  private Term mkIsSomeValIfNullable(Term term)
  {
    Sort sort = term.getSort();
    assert sort.isBoolean() || (sort.isNullable() && sort.getNullableElementSort().isBoolean())
        : "expected a boolean condition but got " + sort;

    if (sort.isNullable())
    {
      Term isSome = tm.mkNullableIsSome(term);
      Term val = tm.mkNullableVal(term);
      term = isSome.andTerm(val);
    }
    return term;
  }

  private void swap(Term[] argTerms, int i, int j)
  {
    Term temp = argTerms[i];
    argTerms[i] = argTerms[j];
    argTerms[j] = temp;
  }

  protected Term[] getArgTerms(DatatypeConstructor constructor, Term t, RexCall call)
  {
    List<RexNode> operands = call.getOperands();
    Term[] argTerms = new Term[operands.size()];
    for (int i = 0; i < operands.size(); i++)
    {
      argTerms[i] = translateRowExpr(operands.get(i), constructor, t, call.op.toString());
    }
    return argTerms;
  }

  protected Term translate(RexNode expr)
  {
    RexLiteral literal = (RexLiteral) expr;
    String typeString = literal.getType().toString();
    if (typeString.equals("INTEGER") || typeString.equals("BIGINT"))
    {
      if (literal.getValue() == null)
      {
        return tm.mkNullableNull(tm.mkNullableSort(tm.getIntegerSort()));
      }
      int integer = RexLiteral.intValue(literal);
      Term ret = tm.mkInteger(integer);
      if (isNullable)
      {
        ret = tm.mkNullableSome(ret);
      }
      return ret;
    }
    if (typeString.contains("VARCHAR") || typeString.contains("CHAR"))
    {
      if (literal.getValue() == null)
      {
        return tm.mkNullableNull(tm.mkNullableSort(tm.getStringSort()));
      }
      String string = RexLiteral.stringValue(literal);
      Term ret = tm.mkString(string);
      if (isNullable)
      {
        ret = tm.mkNullableSome(ret);
      }
      return ret;
    }
    if (typeString.equals("BOOLEAN"))
    {
      if (literal.getValue() == null)
      {
        return tm.mkNullableNull(tm.mkNullableSort(tm.getBooleanSort()));
      }
      boolean value = RexLiteral.booleanValue(literal);
      Term ret = tm.mkBoolean(value);
      if (isNullable)
      {
        ret = tm.mkNullableSome(ret);
      }
      return ret;
    }
    else
    {
      throw new UnsupportedOperationException(
          "unsupported literal type " + typeString + ": " + literal);
    }
  }

  protected Term translate(EnumerableTableScan table)
  {
    if (tableTerms.containsKey(table))
    {
      return tableTerms.get(table);
    }
    String tableName = getTableName(table);
    Sort tupleSort = getDeclaredSort(table.getRowType());
    Sort tableSort = mkTableSort(tupleSort);
    Term cvc5Table = tm.mkConst(tableSort, tableName);
    tables.put(table, cvc5Table);
    assertKeys(cvc5Table, table.getTable().unwrap(TableDef.class));
    Term lifted = liftToNullable(cvc5Table, tupleSort);
    tableTerms.put(table, lifted);
    return lifted;
  }

  /**
   * Wraps the columns a schema declared {@code NOT NULL} back into nullable form.
   *
   * <p>The constant itself keeps the declared sorts, which is the point: a column with no null
   * in its sort is one the solver cannot put a null in, so a counterexample cannot be a
   * database the schema forbids. Everything downstream of a scan expects nullable columns
   * though, so the rest of the encoding sees {@code map(t -> (some t.0, ...), T)} rather than
   * {@code T}. Where every column is nullable -- the built-in schema, for one -- that map
   * would be the identity and the table is handed on untouched, so a schema that declares no
   * NOT NULL is encoded exactly as before.
   */
  private Term liftToNullable(Term table, Sort tupleSort) throws CVC5ApiException
  {
    Sort[] declared = tupleSort.getTupleSorts();
    boolean anyDeclaredNotNull = false;
    for (Sort sort : declared)
    {
      anyDeclaredNotNull |= !sort.isNullable();
    }
    if (!anyDeclaredNotNull)
    {
      return table;
    }
    DatatypeConstructor constructor = tupleSort.getDatatype().getConstructor(0);
    Term t = tm.mkVar(tupleSort, "t");
    Term[] elements = new Term[declared.length];
    Sort[] liftedSorts = new Sort[declared.length];
    for (int i = 0; i < declared.length; i++)
    {
      Term selected =
          tm.mkTerm(Kind.APPLY_SELECTOR, new Term[] {constructor.getSelector(i).getTerm(), t});
      boolean nullable = declared[i].isNullable();
      elements[i] = nullable ? selected : tm.mkNullableSome(selected);
      liftedSorts[i] = nullable ? declared[i] : tm.mkNullableSort(declared[i]);
    }
    Sort liftedTupleSort = tm.mkTupleSort(liftedSorts);
    Term f = defineFun(new Term[] {t}, liftedTupleSort, tm.mkTuple(elements), "notNull", true);
    return tm.mkTerm(getMapKind(), f, table);
  }

  /**
   * Turns on the cvc5 rule the key constraints depend on, when a query reads a table that has
   * a key.
   *
   * <p>A key is stated as {@code setof(project_K(T)) = project_K(T)}, which caps the
   * multiplicity of every key value at one. Contradicting that takes a lower bound of two, and
   * only {@code bags-map-up-pair} derives one from two distinct rows sharing a key: without it
   * the constraints can still rule a model out, but nothing follows from them. The rule costs
   * a lemma per pair of known elements, so queries over tables without keys are left at cvc5's
   * default. It has to be set here rather than where the keys are asserted, because cvc5
   * refuses an option once the solver has seen its first assertion.
   */
  private void enableKeyReasoning(RelNode... plans)
  {
    // Under set semantics no key constraint is asserted, so there is nothing for it to do.
    if (isSetSemantics())
    {
      return;
    }
    for (RelNode plan : plans)
    {
      if (!hasDeclaredKey(plan))
      {
        continue;
      }
      try
      {
        setOption("bags-map-up-pair", "true");
      }
      catch (RuntimeException e)
      {
        // a cvc5 released before the rule landed: the constraints are still asserted, the
        // solver just has less to derive from them
        println("; note: this cvc5 has no bags-map-up-pair option, so a key constraint"
            + " cannot be contradicted by two rows that share a key");
      }
      return;
    }
  }

  /** Whether any table the plan reads declares a key. */
  private static boolean hasDeclaredKey(RelNode node)
  {
    if (node.getTable() != null)
    {
      TableDef definition = node.getTable().unwrap(TableDef.class);
      if (definition != null && !definition.keys().isEmpty())
      {
        return true;
      }
    }
    for (RelNode input : node.getInputs())
    {
      if (hasDeclaredKey(input))
      {
        return true;
      }
    }
    return false;
  }

  /**
   * States a table's declared keys as constraints on its bag, without quantifiers.
   *
   * <p>Two facts per key. {@code setof(project_K(T)) = project_K(T)} says the bag of key values
   * has no repeats, which is uniqueness of the key and duplicate-freedom of the row in one
   * breath. {@code count(null, project_i(T)) = 0} on each key column is what makes that reading
   * the right one: SQL's {@code UNIQUE} admits several nulls, a {@code PRIMARY KEY} none, so
   * without the null exclusion the first fact would say something stronger than SQL does.
   *
   * <p>Without these the tables are unconstrained bags, and the solver answers {@code sat} on
   * databases the schema forbids -- two {@code DEPT} rows sharing a {@code deptno} is enough to
   * make an {@code IN} and its join rewrite differ. Each assertion is annotated in the
   * generated SMT-LIB, since it comes from the schema rather than from either query.
   */
  private void assertKeys(Term table, TableDef definition)
  {
    // Only bags. Under set semantics a table cannot hold a duplicate row in the first place,
    // and the rest of the constraint would need relation cardinalities rather than setof.
    if (definition == null || !table.getSort().isBag())
    {
      return;
    }
    Sort[] columnSorts = table.getSort().getBagElementSort().getTupleSorts();
    try
    {
      for (List<String> key : definition.keys())
      {
        int[] ordinals = new int[key.size()];
        boolean known = true;
        for (int i = 0; i < key.size(); i++)
        {
          ordinals[i] = definition.indexOf(key.get(i));
          known &= ordinals[i] >= 0;
        }
        if (!known)
        {
          continue;
        }
        String columns = String.join(", ", key);
        for (int i = 0; i < ordinals.length; i++)
        {
          int ordinal = ordinals[i];
          if (!columnSorts[ordinal].isNullable())
          {
            continue; // the column has no null to exclude
          }
          Term column = tm.mkTerm(tm.mkOp(Kind.TABLE_PROJECT, new int[] {ordinal}), table);
          Term nullValue = tm.mkTuple(new Term[] {tm.mkNullableNull(columnSorts[ordinal])});
          Term noNull = tm.mkTerm(Kind.BAG_COUNT, nullValue, column).eqTerm(zero);
          assertionComments.put(noNull,
              "key " + definition.qualifiedName() + " (" + columns + "): column "
                  + key.get(i) + " holds no null");
          solver.assertFormula(noNull);
        }
        Term projection = tm.mkTerm(tm.mkOp(Kind.TABLE_PROJECT, ordinals), table);
        Term distinct = tm.mkTerm(Kind.BAG_SETOF, projection).eqTerm(projection);
        assertionComments.put(distinct,
            "key " + definition.qualifiedName() + " (" + columns
                + "): no two rows agree on it, so its values form a set");
        solver.assertFormula(distinct);
      }
    }
    catch (CVC5ApiException e)
    {
      throw new RuntimeException("could not state the keys of " + definition.qualifiedName(), e);
    }
  }

  /**
   * The name the table gets as an SMT constant.
   *
   * <p>It comes from the schema, not from the path the query used to reach the table, so that
   * {@code emp} and {@code public.emp} are one constant rather than two independent ones --
   * and so that two tables of the same name in different schemas stay two.
   */
  private String getTableName(EnumerableTableScan table)
  {
    TableDef def = table.getTable().unwrap(TableDef.class);
    if (def != null)
    {
      return def.qualifiedName().replace('.', '_');
    }
    return String.join("_", table.getTable().getQualifiedName());
  }

  /** Wraps a tuple sort into the collection sort for this semantics. */
  protected abstract Sort mkTableSort(Sort tupleSort);

  protected Sort getSort(RelDataType relDataType)
  {
    // isStruct(), not getFieldList() != null: Calcite asserts isStruct() inside getFieldList(),
    // so the null check only worked because assertions happen to be off outside the test run.
    if (relDataType.isStruct())
    {
      List<Sort> columnSorts = new ArrayList<>();
      for (RelDataTypeField type : relDataType.getFieldList())
      {
        columnSorts.add(getFieldSort(type.getType()));
      }
      Sort tupleSort = tm.mkTupleSort(columnSorts.toArray(new Sort[0]));
      return tupleSort;
    }
    return getFieldSort(relDataType);
  }

  /**
   * The sort of an expression of this type. Uniformly nullable, whatever the type says: the
   * encoding builds nulls into intermediate results everywhere -- an outer join pads with
   * them, an aggregate over no rows is one -- so an expression sort that tracked a column's
   * declared nullability would not match the terms flowing through it. Only a table's own
   * columns are declared honestly, by {@link #getDeclaredSort}.
   */
  protected Sort getFieldSort(RelDataType type)
  {
    return getFieldSort(type, isNullable);
  }

  /**
   * The sort of a column as the schema declares it: {@code NOT NULL} means a sort with no
   * null in it, so the solver cannot answer with a database the schema forbids. Used for the
   * table constant alone; {@link #liftToNullable} puts the columns back into nullable form
   * for everything downstream.
   */
  protected Sort getDeclaredSort(RelDataType relDataType)
  {
    if (!relDataType.isStruct())
    {
      return getFieldSort(relDataType, isNullable && relDataType.isNullable());
    }
    List<Sort> columnSorts = new ArrayList<>();
    for (RelDataTypeField field : relDataType.getFieldList())
    {
      RelDataType type = field.getType();
      columnSorts.add(getFieldSort(type, isNullable && type.isNullable()));
    }
    return tm.mkTupleSort(columnSorts.toArray(new Sort[0]));
  }

  private Sort getFieldSort(RelDataType type, boolean isNullableType)
  {
    if (type instanceof RelDataTypeFactoryImpl.JavaType)
    {
      RelDataTypeFactoryImpl.JavaType javaType = (RelDataTypeFactoryImpl.JavaType) type;
      if (javaType.getJavaClass() == java.lang.Integer.class)
      {
        Sort sort = getIntFieldSort(isNullableType);
        return sort;
      }
      else if (javaType.getJavaClass() == java.lang.String.class)
      {
        Sort sort = getStringFieldSort(isNullableType);
        return sort;
      }
      else
      {
        throw new UnsupportedOperationException("unsupported sql type: " + type);
      }
    }
    else if (type instanceof BasicSqlType)
    {
      BasicSqlType basicSqlType = (BasicSqlType) type;
      String typeString = basicSqlType.getSqlTypeName().toString();
      if (typeString.equals("INTEGER") || typeString.equals("BIGINT"))
      {
        Sort sort = getIntFieldSort(isNullableType);
        return sort;
      }
      else if (typeString.contains("VARCHAR") || typeString.contains("CHAR"))
      {
        Sort sort = getStringFieldSort(isNullableType);
        return sort;
      }
      else if (typeString.equals("BOOLEAN"))
      {
        Sort sort = getBooleanFieldSort(isNullableType);
        return sort;
      }
      else
      {
        throw new UnsupportedOperationException("unsupported sql type: " + type);
      }
    }
    else
    {
      throw new UnsupportedOperationException("unsupported sql type: " + type);
    }
  }

  private Sort getIntFieldSort(boolean isNullableType)
  {
    Sort sort = tm.getIntegerSort();
    if (isNullableType)
    {
      sort = tm.mkNullableSort(sort);
    }
    return sort;
  }
  private Sort getStringFieldSort(boolean isNullableType)
  {
    Sort sort = tm.getStringSort();
    if (isNullableType)
    {
      sort = tm.mkNullableSort(sort);
    }
    return sort;
  }
  private Sort getBooleanFieldSort(boolean isNullableType)
  {
    Sort sort = tm.getBooleanSort();
    if (isNullableType)
    {
      sort = tm.mkNullableSort(sort);
    }
    return sort;
  }
}
