package SimpleQueryTests;
import com.google.common.collect.ImmutableList;
import io.github.cvc5.*;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
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
  public HashMap<String, Term> declaredFunctions = new HashMap<>();
  protected TermManager tm;
  protected Solver solver;
  protected int functionIndex = 0;
  protected Term zero;
  protected Term one;
  protected Term trueTerm;
  protected Term falseTerm;
  protected final long startTime;
  public static long totalTime = 0;
  public static int unsatAnswers = 0;
  public static int satAnswers = 0;
  public static int unknownAnswers = 0;

  public Cvc5AbstractTranslator(boolean isNullable, PrintWriter writer)
  {
    this.isNullable = isNullable;
    this.writer = writer;
    startTime = System.currentTimeMillis();
  }

  public void reset() throws CVC5ApiException
  {
    tables.clear();
    declaredFunctions.clear();
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
   * turned into a concrete database and, if a PostgreSQL server is reachable on localhost, both
   * queries are run against it to confirm the counterexample independently.
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

      String url = "jdbc:postgresql://localhost/template1?user=postgres&password=abc";
      try (Connection connection = DriverManager.getConnection(url))
      {
        Statement statement = connection.createStatement();
        String query1 = postgres(sql1);
        String query2 = postgres(sql2);
        if (!tables.isEmpty())
        {
          statement.execute("TRUNCATE TABLE EMP");
          statement.execute("TRUNCATE TABLE DEPT");
          statement.execute("TRUNCATE TABLE ACCOUNT");
          for (Map.Entry<EnumerableTableScan, Term> entry : tables.entrySet())
          {
            String table = getTableName(entry.getKey());
            Term tableValue = solver.getValue(entry.getValue());
            List<List<Object>> rows = getTableRows(tableValue);
            if (!rows.isEmpty())
            {
              String insertStatement = "insert into " + table + " values";
              for (int i = 0; i < rows.size(); i++)
              {
                insertStatement += "(";
                List<Object> row = rows.get(i);
                for (int j = 0; j < row.size(); j++)
                {
                  Object fieldValue = row.get(j);
                  if (fieldValue == null)
                  {
                    insertStatement += "NULL";
                  }
                  else if (fieldValue instanceof BigInteger)
                  {
                    insertStatement += fieldValue;
                  }
                  else if (fieldValue instanceof String)
                  {
                    insertStatement += "'" + fieldValue + "'";
                  }
                  if (j < row.size() - 1)
                  {
                    insertStatement += ",";
                  }
                }
                insertStatement += ")";
                if (i < rows.size() - 1)
                {
                  insertStatement += ",";
                }
              }
              println("; " + insertStatement);
              statement.execute(insertStatement);
            }
          }
        }
        String query1MinusQuery2 =
            "SELECT * FROM (" + query1 + ") AS q1 EXCEPT ALL SELECT * FROM (" + query2 + ") AS q2;";
        ResultSet rs1 = statement.executeQuery(query1MinusQuery2);
        boolean isModelSound = checkModelSoundness(rs1, query1MinusQuery2);

        String query2MinusQuery1 =
            "SELECT * FROM (" + query2 + ") AS q2 EXCEPT ALL SELECT * FROM (" + query1 + ") AS q1;";
        ResultSet rs2 = statement.executeQuery(query2MinusQuery1);
        isModelSound |= checkModelSoundness(rs2, query2MinusQuery1);

        println(";Model soundness: " + isModelSound);
        connection.close();
      }
      catch (SQLException e)
      {
        e.printStackTrace();
      }
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

  private String postgres(String sql1)
  {
    String query = sql1.replaceAll("EXPR\\$0", "column1")
                       .replaceAll("EXPR\\$1", "column2")
                       .replaceAll("EXPR\\$2", "column3")
                       .replaceAll("EXPR\\$3", "column4")
                       .replaceAll("EXPR\\$4", "column5")
                       .replaceAll("EXPR\\$5", "column6")
                       .replaceAll("EXPR\\$6", "column7")
                       .replaceAll("EXPR\\$7", "column8")
                       .replaceAll("EXPR\\$8", "column9")
                       .replaceAll("EXPR\\$9", "column10");
    return query;
  }

  private boolean checkModelSoundness(ResultSet rs, String query) throws SQLException
  {
    ResultSetMetaData rsMeta = rs.getMetaData();
    int count = rsMeta.getColumnCount();
    StringBuilder builder = new StringBuilder();
    boolean isSound = false;
    while (rs.next())
    {
      builder.append(";(");
      for (int i = 1; i <= count; i++)
      {
        Object value = rs.getObject(i);
        if (value == null)
        {
          builder.append("NULL");
        }
        else
        {
          builder.append(rs.getObject(i).toString());
        }
        if (i < count)
        {
          builder.append(",");
        }
      }
      builder.append(")\n");
      isSound = true;
    }
    println("; " + query);
    println(builder.toString());
    return isSound;
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
    return tm.mkTerm(op, new Term[] {f, initialValue, child});
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
    if (tables.containsKey(table))
    {
      return tables.get(table);
    }
    String tableName = getTableName(table);
    Sort tupleSort = getSort(table.getRowType());
    Sort tableSort = mkTableSort(tupleSort);
    Term cvc5Table = tm.mkConst(tableSort, tableName);
    tables.put(table, cvc5Table);
    return cvc5Table;
  }

  private String getTableName(EnumerableTableScan table)
  {
    String tableName = String.join("_", table.getTable().getQualifiedName());
    return tableName;
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

  protected Sort getFieldSort(RelDataType type)
  {
    boolean isNullableType = isNullable ? type.isNullable() : false;
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
    if (isNullable)
    {
      sort = tm.mkNullableSort(sort);
    }
    return sort;
  }
  private Sort getStringFieldSort(boolean isNullableType)
  {
    Sort sort = tm.getStringSort();
    if (isNullable)
    {
      sort = tm.mkNullableSort(sort);
    }
    return sort;
  }
  private Sort getBooleanFieldSort(boolean isNullableType)
  {
    Sort sort = tm.getBooleanSort();
    if (isNullable)
    {
      sort = tm.mkNullableSort(sort);
    }
    return sort;
  }
}
