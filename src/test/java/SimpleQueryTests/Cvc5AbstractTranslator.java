package SimpleQueryTests;
import DbSchema.TableDef;
import io.github.cvc5.*;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import org.apache.calcite.rel.RelFieldCollation;
import org.apache.calcite.rel.RelNode;
import org.apache.calcite.rel.core.AggregateCall;
import org.apache.calcite.rel.core.CorrelationId;
import org.apache.calcite.rel.core.JoinRelType;
import org.apache.calcite.rel.core.TableScan;
import org.apache.calcite.rel.logical.LogicalAggregate;
import org.apache.calcite.rel.logical.LogicalFilter;
import org.apache.calcite.rel.logical.LogicalIntersect;
import org.apache.calcite.rel.logical.LogicalJoin;
import org.apache.calcite.rel.logical.LogicalMinus;
import org.apache.calcite.rel.logical.LogicalProject;
import org.apache.calcite.rel.logical.LogicalSort;
import org.apache.calcite.rel.logical.LogicalUnion;
import org.apache.calcite.rel.logical.LogicalValues;
import org.apache.calcite.rel.type.RelDataType;
import org.apache.calcite.rel.type.RelDataTypeField;
import org.apache.calcite.rex.RexCall;
import org.apache.calcite.rex.RexCorrelVariable;
import org.apache.calcite.rex.RexFieldAccess;
import org.apache.calcite.rex.RexInputRef;
import org.apache.calcite.rex.RexLiteral;
import org.apache.calcite.rex.RexNode;
import org.apache.calcite.rex.RexShuttle;
import org.apache.calcite.rex.RexSubQuery;
import org.apache.calcite.sql.SqlFunction;
import org.apache.calcite.sql.SqlFunctionCategory;
import org.apache.calcite.sql.SqlKind;
import org.apache.calcite.sql.type.SqlTypeName;

/**
 * Translates a pair of Calcite relational plans into an SMT problem that is unsatisfiable
 * exactly when the two SQL queries are equivalent.
 *
 * <p>The encoding is sqleq-cvc5's ({@code sqleq/sqleq-cvc5/src/translate.rs}), decision for
 * decision, over Calcite's plans instead of sqleq's IR; a change to one belongs in the other. A
 * table is a cvc5 collection of tuples and each relational operator a term over it; the two
 * queries are asserted to differ, so {@code unsat} means no database tells them apart,
 * {@code sat} gives a model, and {@code unknown} means the time limit was reached. What the
 * encoding decides:
 *
 * <ul>
 *   <li><b>Every column is {@code Nullable}</b>, and a {@code NOT NULL} column is a constraint on
 *       its table, {@code (= (bag.filter (lambda ((n T)) (= ((_ tuple.select j) n) null)) T)
 *       bag.empty)}, as a key is: {@code (= (bag.setof ((_ table.project K) T)) ((_ table.project
 *       K) T))}.
 *   <li><b>Casts and functions the encoding does not interpret are uninterpreted</b>, never
 *       erased: a cast is a function named by its source and target types, strict (NULL in, NULL
 *       out) like the functions Postgres defines strict, and any other function is one over the
 *       nullable sorts, which assumes nothing about NULL. A cast that keeps every value (to the
 *       type it has, or a wider one of its kind) is the value itself, and an integer read as a
 *       {@code numeric} is {@code to_real}.
 *   <li><b>Conditions are two-valued</b> where a row is kept or dropped: {@code a AND b} keeps a
 *       row when both keep it, {@code a = b} is {@code (and (nullable.is_some a) (= a b))}.
 *       Elsewhere SQL's three-valued logic is spelled out as {@code ite}s, not {@code
 *       nullable.lift}, whose fresh lambda would make two occurrences of one expression two
 *       functions to the bags solver.
 *   <li><b>One bound variable per sort and role</b> ({@code t__0} for a row, {@code x__0} and
 *       {@code y__0} for a fold), so the lambdas the two queries share are one term. Lambdas are
 *       not simplified here: cvc5 rewrites them after its bags-facts pass has read the keys and
 *       {@code NOT NULL} columns off the constraints.
 *   <li><b>GROUP BY</b> is {@code table.aggr}, which gives an empty input no group, and
 *       aggregates without {@code GROUP BY} are one row holding a {@code bag.fold}; {@code
 *       DISTINCT} aggregates fold over their own deduplicated input, joined on the keys; {@code
 *       AVG} is an uninterpreted {@code avg(sum, count)}.
 *   <li><b>Subqueries</b> ({@code EXISTS}, {@code IN} with its three-valued reading, scalar ones,
 *       correlated or not) are encoded where they stand, so the plans are taken from Calcite
 *       without expanding them into joins.
 *   <li><b>Types.</b> Integers, dates, times and timestamps are cvc5 integers, {@code DECIMAL} a
 *       real, strings cvc5 strings by code point; floats, binaries and every other type an
 *       uninterpreted sort {@code Opaque}, intervals {@code Interval}. Arithmetic is native only
 *       over exact numerics: {@code +}, {@code -}, {@code *}, integer {@code /} and {@code %}
 *       truncating toward zero; a {@code DECIMAL} division, which rounds, and any arithmetic over
 *       another type is a strict uninterpreted function.
 * </ul>
 *
 * <p>Constructs with no faithful encoding raise {@link UnsupportedOperationException} rather
 * than being approximated: a wrong encoding surfaces as a bogus {@code unsat}, which reads as a
 * proof of equivalence.
 */
public abstract class Cvc5AbstractTranslator
{
  /** The two queries return rows of different sorts, so there is no equality to check. */
  public static final class Incomparable extends RuntimeException
  {
    Incomparable(String note)
    {
      super(note);
    }
  }

  /** A row in scope: the tuple term, and per column whether it is never NULL. */
  private static final class Row
  {
    final Term var;
    final boolean[] nonnull;

    Row(Term var, boolean[] nonnull)
    {
      this.var = var;
      this.nonnull = nonnull;
    }

    boolean neverNull(int i)
    {
      return i >= 0 && i < nonnull.length && nonnull[i];
    }
  }

  /** An aggregate call as the encoding reads it: the function, its result type, DISTINCT. */
  private static final class Agg
  {
    final String op;
    final RelDataType type;
    final boolean distinct;

    Agg(String op, RelDataType type, boolean distinct)
    {
      this.op = op;
      this.type = type;
      this.distinct = distinct;
    }
  }

  private static final class Var
  {
    final Sort sort;
    final String prefix;
    final int depth;
    final Term term;

    Var(Sort sort, String prefix, int depth, Term term)
    {
      this.sort = sort;
      this.prefix = prefix;
      this.depth = depth;
      this.term = term;
    }
  }

  /** A body over the values of strict arguments. */
  private interface Body
  {
    Term apply(Term[] values) throws CVC5ApiException;
  }

  protected final PrintWriter writer;
  /** Kept for the callers; every column is nullable whatever it says. */
  protected final boolean isNullable;
  /** The table constants by name, in the order first scanned. */
  public final LinkedHashMap<String, Term> tables = new LinkedHashMap<>();
  /** A scan of each table, for its definition and row type in a counterexample. */
  private final Map<String, TableScan> scans = new HashMap<>();
  /** Uninterpreted functions and constants by name, and the uninterpreted sorts. */
  private final Map<String, Term> funs = new HashMap<>();
  private final Map<String, Sort> sorts = new HashMap<>();
  private final List<String> prologue = new ArrayList<>();
  /** Declarations in order, as SMT-LIB text. */
  private final List<String> declarations = new ArrayList<>();
  /** Every assertion but the final disequality, with the comment that explains it. */
  private final List<String> constraintComments = new ArrayList<>();
  private final List<Term> constraints = new ArrayList<>();
  private final List<Var> vars = new ArrayList<>();
  /** The two sides, once encoded. */
  private Term[] sides;
  /** The rows of the queries enclosing the subquery being translated, by correlation variable. */
  private final Map<CorrelationId, Row> outer = new HashMap<>();
  /** How many subqueries enclose the one being translated; its variables are named apart. */
  private int depth = 0;
  /** Whether the schema or the queries collate strings: their order is then not code points'. */
  private boolean collated = false;
  /** Whether no uninterpreted symbol has been declared, so that a model is a database and no more. */
  private boolean exact = true;
  /** The constants standing for the pair's parameters {@code qp_N()}. */
  private final List<Term> parameters = new ArrayList<>();
  protected TermManager tm;
  protected Solver solver;

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

  /**
   * Strings under a collation the encoding does not know: an order between them (a comparison,
   * MIN, MAX, a row slice) is refused rather than read by code point.
   */
  public void setCollated(boolean collated)
  {
    this.collated = collated;
  }

  /**
   * Whether the last problem had no uninterpreted symbol -- no unknown function, cast or opaque
   * sort -- so that a model is a database. Under one a model also fixes the symbol's values, which
   * the real function may not take, and is only a candidate.
   */
  public boolean isExact()
  {
    return exact;
  }

  public void reset() throws CVC5ApiException
  {
    tables.clear();
    scans.clear();
    funs.clear();
    sorts.clear();
    prologue.clear();
    declarations.clear();
    constraintComments.clear();
    constraints.clear();
    vars.clear();
    sides = null;
    outer.clear();
    depth = 0;
    exact = true;
    parameters.clear();
    Context.deletePointers();
    tm = new TermManager();
    solver = new Solver(tm);
    solver.setLogic("HO_ALL");
    prologue.add("(set-logic HO_ALL)");
    setOption("produce-models", "true");
    setOption("check-models", System.getProperty("cvc5.check-models", "true"));
    setOption("uf-lazy-ll", "true");
    setOption("fmf-bound", "true");
    setOption("strings-exp", "true");
    // -Dtlimit=<millis> overrides the per-query limit
    setOption("tlimit-per", System.getProperty("tlimit", "10000"));
    // -Dcvc5.options=k=v,k=v: further options, after the defaults so they can override them
    String extra = System.getProperty("cvc5.options", "");
    for (String option : extra.split(","))
    {
      int eq = option.indexOf('=');
      if (eq > 0)
      {
        setOption(option.substring(0, eq).trim(), option.substring(eq + 1).trim());
      }
    }
  }

  private void setOption(String option, String value)
  {
    solver.setOption(option, value);
    prologue.add("(set-option :" + option + " " + value + ")");
  }

  /**
   * Asks whether two queries are equivalent.
   *
   * @return {@code unsat} if the queries are equivalent, {@code sat} if a database distinguishes
   *     them, {@code unknown} on timeout
   * @throws Incomparable if the two queries return rows of different sorts
   */
  public Result translate(String name, RelNode n1, String sql1, RelNode n2, String sql2)
      throws CVC5ApiException
  {
    reset();
    println(";-----------------------------------------------------------");
    println("; test name: " + name);
    println("; q1: " + sql1.replaceAll("\\s+", " ").trim());
    println("; q2: " + sql2.replaceAll("\\s+", " ").trim());
    String note = problem(n1, n2);
    print(smt2());
    if (note != null)
    {
      println("; answer: incomparable, " + note);
      print("(reset)\n");
      throw new Incomparable(note);
    }
    Result result = solver.checkSat();
    long duration = System.currentTimeMillis() - startTime;
    totalTime += duration;
    println("; answer: " + result);
    println("; duration: " + duration + " ms.");
    if (result.isSat())
    {
      satAnswers++;
      String model = solver.getModel(new Sort[0], tables.values().toArray(new Term[0]));
      for (String line : model.split("\n"))
      {
        println("; " + line);
      }
      println("; q1 = " + solver.getValue(sides[0]));
      println("; q2 = " + solver.getValue(sides[1]));
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

  // ── The problem ─────────────────────────────────────────────────────────────────────────────

  /**
   * Encodes both sides and asserts that they differ, or returns a note when their row sorts
   * already differ and there is nothing to assert.
   */
  private String problem(RelNode n1, RelNode n2) throws CVC5ApiException
  {
    Term q1 = rel(n1);
    Term q2 = rel(n2);
    Term[] q = coerceNullColumns(q1, n1, q2, n2);
    q = widen(q[0], q[1]);
    Sort s1 = q[0].getSort();
    Sort s2 = q[1].getSort();
    if (!s1.equals(s2))
    {
      int w1 = width(s1);
      int w2 = width(s2);
      return w1 != w2 ? "the two queries return " + w1 + " and " + w2 + " columns"
                      : "the two queries' columns differ in sort: " + getElementSort(s1) + " against "
              + getElementSort(s2);
    }
    for (Term c : constraints)
    {
      solver.assertFormula(c);
    }
    solver.assertFormula(tm.mkTerm(Kind.NOT, tm.mkTerm(Kind.EQUAL, q[0], q[1])));
    sides = q;
    return null;
  }

  /** The problem as SMT-LIB: the preamble, every declaration, every assertion with its comment. */
  private String smt2()
  {
    StringBuilder b = new StringBuilder();
    for (String line : prologue)
    {
      b.append(line).append('\n');
    }
    for (String line : declarations)
    {
      b.append(line).append('\n');
    }
    for (int i = 0; i < constraints.size(); i++)
    {
      b.append("; ").append(constraintComments.get(i)).append('\n');
      b.append("(assert ").append(constraints.get(i)).append(")\n");
    }
    if (sides != null)
    {
      b.append("; the two queries differ\n");
      b.append("(assert (not (= ").append(sides[0]).append(' ').append(sides[1]).append(")))\n");
    }
    else
    {
      b.append("; the two queries return rows of different shapes\n");
    }
    b.append("(check-sat)\n(get-model)\n");
    return b.toString();
  }

  private void constrain(String comment, Term c)
  {
    constraintComments.add(comment);
    constraints.add(c);
  }

  /**
   * The two sides over one row sort where one side's column is NULL in every row and the other's
   * is of another sort: that side's column is read as the other sort's NULL. A NULL of one type
   * and a NULL of another are the same cell to a comparison of rows.
   */
  private Term[] coerceNullColumns(Term a, RelNode ra, Term b, RelNode rb) throws CVC5ApiException
  {
    Sort[] sa = columnSorts(a);
    Sort[] sb = columnSorts(b);
    if (sa.length != sb.length || Arrays.equals(sa, sb))
    {
      return new Term[] {a, b};
    }
    Map<Integer, Sort> fixA = new HashMap<>();
    Map<Integer, Sort> fixB = new HashMap<>();
    for (int i = 0; i < sa.length; i++)
    {
      if (sa[i].equals(sb[i]))
      {
        continue;
      }
      if (alwaysNull(ra, i))
      {
        fixA.put(i, sb[i]);
      }
      else if (alwaysNull(rb, i))
      {
        fixB.put(i, sa[i]);
      }
    }
    return new Term[] {nullColumns(a, fixA), nullColumns(b, fixB)};
  }

  /**
   * {@code table} with each of {@code columns} replaced by the NULL of the sort given for it:
   * for column 1 read as a string, {@code (bag.map (lambda ((t T)) (tuple ((_ tuple.select 0) t)
   * (as nullable.null (Nullable String)))) table)}.
   */
  private Term nullColumns(Term table, Map<Integer, Sort> columns) throws CVC5ApiException
  {
    if (columns.isEmpty())
    {
      return table;
    }
    Sort elem = elemOf(table);
    Term t = var(elem, "t");
    Term[] cells = new Term[elem.getTupleLength()];
    for (int i = 0; i < cells.length; i++)
    {
      Sort sort = columns.get(i);
      cells[i] = sort != null ? tm.mkNullableNull(sort) : select(t, i);
    }
    return tm.mkTerm(getMapKind(), lambda(new Term[] {t}, tm.mkTuple(cells)), table);
  }

  /**
   * The two sides over one row sort where they differ only in an integer column against a real
   * one: the integer side is read as reals there, as Postgres compares a {@code bigint} with a
   * {@code numeric}. Any other difference is left for the caller to report.
   */
  private Term[] widen(Term a, Term b) throws CVC5ApiException
  {
    Sort[] sa = columnSorts(a);
    Sort[] sb = columnSorts(b);
    if (sa.length != sb.length || Arrays.equals(sa, sb))
    {
      return new Term[] {a, b};
    }
    Sort real = tm.mkNullableSort(tm.getRealSort());
    Sort integer = tm.mkNullableSort(tm.getIntegerSort());
    List<Integer> widenA = new ArrayList<>();
    List<Integer> widenB = new ArrayList<>();
    for (int i = 0; i < sa.length; i++)
    {
      if (sa[i].equals(sb[i]))
      {
        continue;
      }
      if (sa[i].equals(integer) && sb[i].equals(real))
      {
        widenA.add(i);
      }
      else if (sa[i].equals(real) && sb[i].equals(integer))
      {
        widenB.add(i);
      }
      else
      {
        return new Term[] {a, b};
      }
    }
    return new Term[] {widenColumns(a, widenA), widenColumns(b, widenB)};
  }

  private Term widenColumns(Term table, List<Integer> columns) throws CVC5ApiException
  {
    if (columns.isEmpty())
    {
      return table;
    }
    Sort elem = elemOf(table);
    Term t = var(elem, "t");
    Term[] cells = new Term[elem.getTupleLength()];
    for (int i = 0; i < cells.length; i++)
    {
      Term c = select(t, i);
      cells[i] = columns.contains(i) ? lift(Kind.TO_REAL, c) : c;
    }
    return tm.mkTerm(getMapKind(), lambda(new Term[] {t}, tm.mkTuple(cells)), table);
  }

  // ── Sorts ───────────────────────────────────────────────────────────────────────────────────

  /** The sort of a non-null value of {@code type}. */
  private Sort baseSort(RelDataType type)
  {
    SqlTypeName name = type.getSqlTypeName();
    if (SqlTypeName.INTERVAL_TYPES.contains(name))
    {
      return uninterpretedSort("Interval");
    }
    switch (name)
    {
      case TINYINT:
      case SMALLINT:
      case INTEGER:
      case BIGINT:
      case DATE:
      case TIME:
      case TIME_WITH_LOCAL_TIME_ZONE:
      case TIMESTAMP:
      case TIMESTAMP_WITH_LOCAL_TIME_ZONE:
      // a NULL the planner left untyped, read as an integer NULL (see asSort)
      case NULL: return tm.getIntegerSort();
      case DECIMAL: return tm.getRealSort();
      case BOOLEAN: return tm.getBooleanSort();
      case CHAR:
      case VARCHAR: return tm.getStringSort();
      // double precision, whose arithmetic does not associate: equality and order only
      case FLOAT:
      case DOUBLE: return uninterpretedSort("Opaque");
      case REAL:
        throw new UnsupportedOperationException(
            "a value of type real (float4), which Calcite widens to double precision where Postgres does not");
      // Binaries and the rest: the input layer writes every type it does not know as `bytea`, a
      // `box` (whose `=` is not even transitive) as well as a `bytea`, so none is read as one.
      default: throw new UnsupportedOperationException("unsupported sql type: " + type);
    }
  }

  private Sort uninterpretedSort(String name)
  {
    Sort s = sorts.get(name);
    if (s == null)
    {
      exact = false;
      s = tm.mkUninterpretedSort(name);
      declarations.add("(declare-sort " + name + " 0)");
      sorts.put(name, s);
    }
    return s;
  }

  /** The sort of a column of {@code type}: nullable, whatever the type says. */
  private Sort colSort(RelDataType type)
  {
    return tm.mkNullableSort(baseSort(type));
  }

  private Sort rowSort(RelDataType rowType)
  {
    List<RelDataTypeField> fields = rowType.getFieldList();
    Sort[] columns = new Sort[fields.size()];
    for (int i = 0; i < columns.length; i++)
    {
      columns[i] = colSort(fields.get(i).getType());
    }
    return tm.mkTupleSort(columns);
  }

  private int width(Sort table)
  {
    return getElementSort(table).getTupleLength();
  }

  private Sort elemOf(Term t)
  {
    return getElementSort(t.getSort());
  }

  private Sort[] columnSorts(Term t)
  {
    return elemOf(t).getTupleSorts();
  }

  /** The name a type gives a symbol: Postgres resolves a function by its argument types. */
  private static String typeName(RelDataType type)
  {
    return type.getSqlTypeName().getName();
  }

  /** The name with precision and scale, for the target of a cast, which they change. */
  private static String fullTypeName(RelDataType type)
  {
    SqlTypeName name = type.getSqlTypeName();
    StringBuilder b = new StringBuilder(name.getName());
    if (name.allowsPrec() && type.getPrecision() != RelDataType.PRECISION_NOT_SPECIFIED)
    {
      b.append('(').append(type.getPrecision());
      if (name.allowsScale() && type.getScale() != RelDataType.SCALE_NOT_SPECIFIED)
      {
        b.append(',').append(type.getScale());
      }
      b.append(')');
    }
    return b.toString();
  }

  private static boolean isIntegerType(SqlTypeName name)
  {
    return name == SqlTypeName.TINYINT || name == SqlTypeName.SMALLINT || name == SqlTypeName.INTEGER
        || name == SqlTypeName.BIGINT;
  }

  /** An exact numeric: native arithmetic is Postgres's arithmetic only over these. */
  private static boolean isExactNumeric(RelDataType type)
  {
    return isIntegerType(type.getSqlTypeName()) || type.getSqlTypeName() == SqlTypeName.DECIMAL;
  }

  // ── The semantics' hooks (Cvc5BagsTranslator / Cvc5SetsTranslator) ──────────────────────────

  /**
   * Whether this translator encodes set semantics. The counterexample replay needs it: under
   * sets a row is present or absent, under bags the number of copies is part of the answer.
   */
  protected abstract boolean isSetSemantics();

  /** Expands a collection value from a model into the rows of a counterexample table. */
  protected abstract List<List<Object>> getTableRows(Term tableValue) throws CVC5ApiException;

  /** The kind of the empty-collection value, used to recognise it in a model. */
  protected abstract Kind getEmptyKind();

  /** The tuple sort held by a collection sort. */
  protected abstract Sort getElementSort(Sort sort);

  /** Wraps a tuple sort into the collection sort for this semantics. */
  protected abstract Sort mkTableSort(Sort tupleSort);

  /** Column projection: table.project or relation.project. */
  protected abstract Kind getProjectKind();

  /** Cartesian product: table.product or relation.product. */
  protected abstract Kind getProductKind();

  /** {@code GROUP BY}: table.aggr or relation.aggr. */
  protected abstract Kind getAggregateKind();

  /** Aggregates without {@code GROUP BY}: bag.fold or set.fold. */
  protected abstract Kind getFoldKind();

  /** {@code WHERE}: bag.filter or set.filter. */
  protected abstract Kind getFilterKind();

  /** Projection through an expression: bag.map or set.map. */
  protected abstract Kind getMapKind();

  /** Multiset sum: {@code UNION ALL}, literal {@code VALUES} and outer-join padding. */
  protected abstract Kind getUnionAllKind();

  /** The intersection of {@code INTERSECT}: bag.inter_min or set.inter. */
  protected abstract Kind getIntersectionKind();

  /** Difference that drops a row entirely once it matches: {@code EXCEPT}. */
  protected abstract Kind getDifferenceRemoveKind();

  /** Membership: bag.member or set.member. */
  protected abstract Kind getMemberKind();

  /** Cardinality: bag.card or set.card. */
  protected abstract Kind getCardKind();

  /** Some element: bag.choose or set.choose. */
  protected abstract Kind getChooseKind();

  /** The empty table. {@code sort} is the collection sort, not the tuple sort. */
  protected abstract Term mkEmptyTable(Sort sort);

  /** A one-row table holding {@code smtTuple}. */
  protected abstract Term mkSingleton(Term smtTuple);

  /** Duplicate removal: bag.setof caps every multiplicity at one; a set has none to cap. */
  protected abstract Term mkDistinct(Term table);

  private Term isEmpty(Term table)
  {
    return tm.mkTerm(Kind.EQUAL, table, mkEmptyTable(table.getSort()));
  }

  private Term member(Term tuple, Term table)
  {
    return tm.mkTerm(getMemberKind(), tuple, table);
  }

  private Term project(int[] indices, Term table) throws CVC5ApiException
  {
    return tm.mkTerm(tm.mkOp(getProjectKind(), indices), table);
  }

  // ── Terms ───────────────────────────────────────────────────────────────────────────────────

  /**
   * The bound variable of {@code sort} in the role {@code prefix} names, the same one every time,
   * so that two lambdas computing the same thing are one term. A nested lambda over the same sort
   * shadows harmlessly; inside a subquery, which can read the enclosing row, the variables are
   * named apart by depth: {@code t__0}, {@code t__1}.
   */
  private Term var(Sort sort, String prefix)
  {
    for (Var v : vars)
    {
      if (v.depth == depth && v.prefix.equals(prefix) && v.sort.equals(sort))
      {
        return v.term;
      }
    }
    Term v = tm.mkVar(sort, prefix + "__" + depth);
    vars.add(new Var(sort, prefix, depth, v));
    return v;
  }

  /** {@code (lambda vars body)}, the body as it is: cvc5 rewrites it after its bags-facts pass. */
  private Term lambda(Term[] vs, Term body)
  {
    return tm.mkTerm(Kind.LAMBDA, tm.mkTerm(Kind.VARIABLE_LIST, vs), body);
  }

  private Term select(Term tuple, int index)
  {
    Term selector = tuple.getSort().getDatatype().getConstructor(0).getSelector(index).getTerm();
    return tm.mkTerm(Kind.APPLY_SELECTOR, selector, tuple);
  }

  private Term some(Term t)
  {
    return tm.mkNullableSome(t);
  }

  private Term val(Term t)
  {
    return tm.mkNullableVal(t);
  }

  private Term isNull(Term t)
  {
    return tm.mkNullableIsNull(t);
  }

  private Term isSome(Term t)
  {
    return tm.mkNullableIsSome(t);
  }

  private Term ite(Term c, Term a, Term b)
  {
    return tm.mkTerm(Kind.ITE, c, a, b);
  }

  private Term not(Term t)
  {
    return tm.mkTerm(Kind.NOT, t);
  }

  private Term and(List<Term> ts)
  {
    if (ts.isEmpty())
    {
      return tm.mkTrue();
    }
    return ts.size() == 1 ? ts.get(0) : tm.mkTerm(Kind.AND, ts.toArray(new Term[0]));
  }

  private Term or(List<Term> ts)
  {
    if (ts.isEmpty())
    {
      return tm.mkFalse();
    }
    return ts.size() == 1 ? ts.get(0) : tm.mkTerm(Kind.OR, ts.toArray(new Term[0]));
  }

  private Term and(Term... ts)
  {
    return and(Arrays.asList(ts));
  }

  private Term or(Term... ts)
  {
    return or(Arrays.asList(ts));
  }

  /** A nullable boolean read two-valued, as a {@code WHERE} reads it: only some(true) passes. */
  private Term truth(Term t)
  {
    return and(isSome(t), val(t));
  }

  /** A nullable boolean that is some(false): {@code (and (nullable.is_some t) (not (nullable.val t)))}. */
  private Term falsity(Term t)
  {
    return and(isSome(t), not(val(t)));
  }

  /**
   * {@code op} over the values of nullable {@code args}, null when any of them is, spelled out
   * as an {@code ite}: for {@code a + 5},
   * {@code (ite (nullable.is_null a) (as nullable.null (Nullable Int)) (nullable.some (+
   * (nullable.val a) 5)))}, up to the null test of the literal.
   */
  private Term lift(Kind op, Term... args) throws CVC5ApiException
  {
    return strict(args, values -> tm.mkTerm(op, values));
  }

  /** {@code body(values)} over the values of nullable {@code args}, null when any of them is. */
  private Term strict(Term[] args, Body body) throws CVC5ApiException
  {
    List<Term> nulls = new ArrayList<>();
    Term[] values = new Term[args.length];
    for (int i = 0; i < args.length; i++)
    {
      nulls.add(isNull(args[i]));
      values[i] = val(args[i]);
    }
    Term value = some(body.apply(values));
    return ite(or(nulls), tm.mkNullableNull(value.getSort()), value);
  }

  /** An uninterpreted function {@code name}, declared on first use. */
  private Term fun(String name, Sort[] domain, Sort codomain)
  {
    Term f = funs.get(name);
    if (f != null)
    {
      return f;
    }
    exact = false;
    if (domain.length == 0)
    {
      f = tm.mkConst(codomain, name);
      declarations.add("(declare-const " + f + " " + codomain + ")");
    }
    else
    {
      f = solver.declareFun(name, domain, codomain);
      StringBuilder args = new StringBuilder();
      for (Sort s : domain)
      {
        args.append(args.length() == 0 ? "" : " ").append(s);
      }
      declarations.add("(declare-fun " + f + " (" + args + ") " + codomain + ")");
    }
    funs.put(name, f);
    return f;
  }

  private Term apply(Term f, Term[] args)
  {
    if (args.length == 0)
    {
      return f;
    }
    Term[] children = new Term[args.length + 1];
    children[0] = f;
    System.arraycopy(args, 0, children, 1, args.length);
    return tm.mkTerm(Kind.APPLY_UF, children);
  }

  // ── Relations ───────────────────────────────────────────────────────────────────────────────

  /** {@code n} as a collection of tuples. Anything not handled is refused by name. */
  private Term rel(RelNode n) throws CVC5ApiException
  {
    if (n instanceof TableScan)
    {
      return scan((TableScan) n);
    }
    if (n instanceof LogicalFilter)
    {
      LogicalFilter f = (LogicalFilter) n;
      Term src = rel(f.getInput());
      return filter(f.getCondition(), src, neverNullColumns(f.getInput()));
    }
    if (n instanceof LogicalProject)
    {
      return projection((LogicalProject) n);
    }
    if (n instanceof LogicalJoin)
    {
      return join((LogicalJoin) n);
    }
    if (n instanceof LogicalAggregate)
    {
      return group((LogicalAggregate) n);
    }
    if (n instanceof LogicalSort)
    {
      return sort((LogicalSort) n);
    }
    if (n instanceof LogicalValues)
    {
      return values((LogicalValues) n);
    }
    if (n instanceof LogicalUnion)
    {
      LogicalUnion u = (LogicalUnion) n;
      Term all = chain(u.getInputs(), getUnionAllKind());
      return u.all ? all : mkDistinct(all);
    }
    // INTERSECT and EXCEPT return distinct rows; their ALL forms keep multiplicities -- the fewer
    // copies of a row, or the copies the first branch has beyond the second's -- which only bags have.
    if (n instanceof LogicalIntersect)
    {
      LogicalIntersect i = (LogicalIntersect) n;
      if (!i.all)
      {
        return mkDistinct(chain(i.getInputs(), getIntersectionKind()));
      }
      if (isSetSemantics())
      {
        throw new UnsupportedOperationException("INTERSECT ALL under set semantics");
      }
      return chain(i.getInputs(), Kind.BAG_INTER_MIN);
    }
    if (n instanceof LogicalMinus)
    {
      LogicalMinus m = (LogicalMinus) n;
      if (!m.all)
      {
        return mkDistinct(chain(m.getInputs(), getDifferenceRemoveKind()));
      }
      if (isSetSemantics())
      {
        throw new UnsupportedOperationException("EXCEPT ALL under set semantics");
      }
      return chain(m.getInputs(), Kind.BAG_DIFFERENCE_SUBTRACT);
    }
    // LogicalCorrelate, LogicalWindow, LogicalTableFunctionScan and the rest
    throw new UnsupportedOperationException(
        "unsupported relational operator " + n.getRelTypeName() + ": " + n);
  }

  /** The branches of a set operation folded by {@code kind}, which cvc5 needs over one tuple sort. */
  private Term chain(List<RelNode> inputs, Kind kind) throws CVC5ApiException
  {
    Term result = rel(inputs.get(0));
    for (int i = 1; i < inputs.size(); i++)
    {
      Term next = rel(inputs.get(i));
      if (!next.getSort().equals(result.getSort()))
      {
        throw new UnsupportedOperationException("set operation over branches of different row sorts: "
            + elemOf(result) + " against " + elemOf(next));
      }
      result = tm.mkTerm(kind, result, next);
    }
    return result;
  }

  /**
   * A table: a constant of the collection sort, with its {@code NOT NULL} columns and, under
   * bags, its keys asserted on the first scan.
   */
  private Term scan(TableScan scan) throws CVC5ApiException
  {
    String name = getTableName(scan);
    Term known = tables.get(name);
    if (known != null)
    {
      return known;
    }
    RelDataType rowType = scan.getRowType();
    for (RelDataTypeField field : rowType.getFieldList())
    {
      if (field.getType().getSqlTypeName() == SqlTypeName.CHAR)
      {
        throw new UnsupportedOperationException("a column of type char(n), " + field.getName()
            + ": char(n) compares ignoring trailing spaces, which no string equality does");
      }
    }
    Sort row = rowSort(rowType);
    Sort tableSort = mkTableSort(row);
    Term t = tm.mkConst(tableSort, name);
    declarations.add("(declare-const " + t + " " + tableSort + ")");
    tables.put(name, t);
    scans.put(name, scan);
    Sort[] columnSorts = row.getTupleSorts();
    List<RelDataTypeField> fields = rowType.getFieldList();
    // A NOT NULL column holds no null: the bag of its values has no null in it.
    for (int j = 0; j < fields.size(); j++)
    {
      if (!fields.get(j).getType().isNullable())
      {
        constrain(name + ": column " + fields.get(j).getName() + " is NOT NULL", noNullIn(t, j, columnSorts[j]));
      }
    }
    // A key: no two rows agree on it, so its values form a set. Under set semantics a table
    // cannot repeat a row in the first place, and the rest would need cardinalities.
    TableDef definition = scan.getTable().unwrap(TableDef.class);
    if (!isSetSemantics() && definition != null)
    {
      for (List<String> key : definition.keys())
      {
        int[] ordinals = ordinals(definition, key);
        if (ordinals == null)
        {
          continue;
        }
        Term projection = project(ordinals, t);
        Term distinct = tm.mkTerm(Kind.EQUAL, mkDistinct(projection), projection);
        constrain(name + ": key (" + String.join(", ", key) + "): no two rows agree on it, so its values form a set",
            distinct);
      }
    }
    return t;
  }

  private static int[] ordinals(TableDef definition, List<String> key)
  {
    int[] ordinals = new int[key.size()];
    for (int i = 0; i < key.size(); i++)
    {
      ordinals[i] = definition.indexOf(key.get(i));
      if (ordinals[i] < 0)
      {
        return null;
      }
    }
    return ordinals;
  }

  /**
   * Under bags {@code (= (bag.filter (lambda ((n T)) (= ((_ tuple.select j) n) null)) T)
   * bag.empty)}, an emptiness the solver decides with one lemma per row it knows; under sets, that
   * the null tuple is not a member of the projection.
   */
  private Term noNullIn(Term table, int j, Sort colSort) throws CVC5ApiException
  {
    Term nul = tm.mkNullableNull(colSort);
    if (!isSetSemantics())
    {
      Term n = var(elemOf(table), "n");
      Term isNullCell = tm.mkTerm(Kind.EQUAL, select(n, j), nul);
      Term nulls = tm.mkTerm(getFilterKind(), lambda(new Term[] {n}, isNullCell), table);
      return isEmpty(nulls);
    }
    Term column = project(new int[] {j}, table);
    return not(member(tm.mkTuple(new Term[] {nul}), column));
  }

  /**
   * The name the table gets as an SMT constant: from the schema, not from the path the query
   * used to reach the table, so {@code emp} and {@code public.emp} are one constant.
   */
  private static String getTableName(TableScan table)
  {
    TableDef def = table.getTable().unwrap(TableDef.class);
    if (def != null)
    {
      return def.qualifiedName().replace('.', '_');
    }
    return String.join("_", table.getTable().getQualifiedName());
  }

  /** {@code (bag.filter (lambda ((t T)) condition) table)}, the condition read two-valued. */
  private Term filter(RexNode condition, Term table, boolean[] nonnull) throws CVC5ApiException
  {
    Term t = var(elemOf(table), "t");
    Term body = condition(condition, new Row(t, nonnull));
    return tm.mkTerm(getFilterKind(), lambda(new Term[] {t}, body), table);
  }

  /** Column references alone are the cheap {@code table.project}; anything else maps a lambda. */
  private Term projection(LogicalProject project) throws CVC5ApiException
  {
    Term src = rel(project.getInput());
    List<RexNode> exprs = project.getProjects();
    int[] indices = new int[exprs.size()];
    boolean refs = !exprs.isEmpty();
    for (int i = 0; i < exprs.size() && refs; i++)
    {
      if (exprs.get(i) instanceof RexInputRef)
      {
        indices[i] = ((RexInputRef) exprs.get(i)).getIndex();
      }
      else
      {
        refs = false;
      }
    }
    if (refs)
    {
      return project(indices, src);
    }
    Term t = var(elemOf(src), "t");
    Row row = new Row(t, neverNullColumns(project.getInput()));
    Term[] cells = new Term[exprs.size()];
    for (int i = 0; i < cells.length; i++)
    {
      cells[i] = expr(exprs.get(i), row);
    }
    return tm.mkTerm(getMapKind(), lambda(new Term[] {t}, tm.mkTuple(cells)), src);
  }

  private Term values(LogicalValues values) throws CVC5ApiException
  {
    List<RelDataTypeField> fields = values.getRowType().getFieldList();
    Sort tableSort = mkTableSort(rowSort(values.getRowType()));
    if (values.getTuples().isEmpty())
    {
      return mkEmptyTable(tableSort);
    }
    Term union = null;
    for (List<RexLiteral> tuple : values.getTuples())
    {
      Term[] cells = new Term[tuple.size()];
      for (int j = 0; j < cells.length; j++)
      {
        cells[j] = asType(literal(tuple.get(j)), fields.get(j).getType());
      }
      Term row = mkSingleton(tm.mkTuple(cells));
      union = union == null ? row : tm.mkTerm(getUnionAllKind(), union, row);
    }
    return union;
  }

  private Term join(LogicalJoin join) throws CVC5ApiException
  {
    Term a = rel(join.getLeft());
    Term b = rel(join.getRight());
    Term product = tm.mkTerm(getProductKind(), a, b);
    boolean[] left = neverNullColumns(join.getLeft());
    boolean[] right = neverNullColumns(join.getRight());
    boolean[] nonnull = Arrays.copyOf(left, left.length + right.length);
    System.arraycopy(right, 0, nonnull, left.length, right.length);
    RexNode condition = join.getCondition();
    if (!condition.isAlwaysTrue())
    {
      product = filter(condition, product, nonnull);
    }
    switch (join.getJoinType())
    {
      case INNER: return product;
      case LEFT: return tm.mkTerm(getUnionAllKind(), unmatched(a, b, condition, true, nonnull), product);
      case RIGHT: return tm.mkTerm(getUnionAllKind(), unmatched(a, b, condition, false, nonnull), product);
      case FULL:
      {
        Term both = tm.mkTerm(getUnionAllKind(), unmatched(a, b, condition, true, nonnull),
            unmatched(a, b, condition, false, nonnull));
        return tm.mkTerm(getUnionAllKind(), both, product);
      }
      default: throw new UnsupportedOperationException("unsupported join type " + join.getJoinType());
    }
  }

  /**
   * The rows of one side that no row of the other joins with, each padded with nulls on the
   * other side: {@code (bag.filter (lambda ((u U)) (= (bag.filter (lambda ((v V)) cond(u, v))
   * other) bag.empty)) side)}, mapped onto the padded row. A row matching {@code k} rows
   * contributes no padded row while an unmatched one keeps every copy; as a filter, its predicate
   * compares pointwise with another side's.
   */
  private Term unmatched(Term a, Term b, RexNode condition, boolean leftSide, boolean[] nonnull)
      throws CVC5ApiException
  {
    Term side = leftSide ? a : b;
    Term other = leftSide ? b : a;
    Sort sideElem = elemOf(side);
    Sort otherElem = elemOf(other);
    int n = sideElem.getTupleLength();
    Term u = var(sideElem, "u");
    Term v = var(otherElem, "v");
    // the product row, left columns then right columns, from the two candidates
    Term leftVar = leftSide ? u : v;
    Term rightVar = leftSide ? v : u;
    int leftN = elemOf(a).getTupleLength();
    int rightN = elemOf(b).getTupleLength();
    Term[] cells = new Term[leftN + rightN];
    for (int i = 0; i < leftN; i++)
    {
      cells[i] = select(leftVar, i);
    }
    for (int i = 0; i < rightN; i++)
    {
      cells[leftN + i] = select(rightVar, i);
    }
    Term matches = other;
    if (!condition.isAlwaysTrue())
    {
      Term body = condition(condition, new Row(tm.mkTuple(cells), nonnull));
      matches = tm.mkTerm(getFilterKind(), lambda(new Term[] {v}, body), other);
    }
    Term anti = lambda(new Term[] {u}, isEmpty(matches));
    Term unmatched = tm.mkTerm(getFilterKind(), anti, side);
    // pad: the side's columns in place, nulls for the other side's
    Sort[] all = new Sort[leftN + rightN];
    System.arraycopy(columnSorts(a), 0, all, 0, leftN);
    System.arraycopy(columnSorts(b), 0, all, leftN, rightN);
    int offset = leftSide ? 0 : leftN;
    Term t = var(sideElem, "t");
    Term[] padded = new Term[all.length];
    for (int i = 0; i < all.length; i++)
    {
      padded[i] = i >= offset && i < offset + n ? select(t, i - offset) : tm.mkNullableNull(all[i]);
    }
    return tm.mkTerm(getMapKind(), lambda(new Term[] {t}, tm.mkTuple(padded)), unmatched);
  }

  /** Bare ORDER BY changes no multiplicity; a row slice does. */
  private Term sort(LogicalSort sort) throws CVC5ApiException
  {
    // LIMIT 0 keeps no row, whatever the order
    if (sort.fetch instanceof RexLiteral && BigDecimal.ZERO.compareTo(((RexLiteral) sort.fetch).getValueAs(BigDecimal.class)) == 0)
    {
      return mkEmptyTable(rel(sort.getInput()).getSort());
    }
    if (sort.offset != null || sort.fetch != null)
    {
      return rowSlice(sort);
    }
    return rel(sort.getInput());
  }

  /**
   * A row slice, {@code OFFSET o LIMIT l} under an {@code ORDER BY} whose keys contain a key of
   * the rows: no two rows tie, so every row has its place, the number of rows sorted before it,
   * and the slice keeps the rows placed in [o, o + l). Under ties the slice would depend on the
   * order the rows come in, and is refused; so is a slice of a computed size, and one under set
   * semantics. For {@code ORDER BY k LIMIT 2}, k column 0 ascending and NULLs last,
   * {@code (bag.filter (lambda ((x T)) (and (>= (bag.fold (lambda ((z T) (a Int)) (+ a 1)) 0 E) 0)
   * (< (bag.fold (lambda ((z T) (a Int)) (+ a 1)) 0 E) 2))) rows)} with {@code E}, the rows before
   * x, {@code (bag.filter (lambda ((y T)) (ite (nullable.is_null ((_ tuple.select 0) y)) false
   * (ite (nullable.is_null ((_ tuple.select 0) x)) true (< (nullable.val ((_ tuple.select 0) y))
   * (nullable.val ((_ tuple.select 0) x)))))) rows)}.
   */
  private Term rowSlice(LogicalSort sort) throws CVC5ApiException
  {
    long off = constant(sort.offset, 0);
    long lim = constant(sort.fetch, -1);
    List<RelFieldCollation> keys = sort.getCollation().getFieldCollations();
    Set<Integer> sorted = new TreeSet<>();
    for (RelFieldCollation k : keys)
    {
      sorted.add(k.getFieldIndex());
    }
    boolean unique = false;
    for (List<Integer> key : relationKeys(sort.getInput()))
    {
      unique |= sorted.containsAll(key);
    }
    if (isSetSemantics() || !unique)
    {
      throw new UnsupportedOperationException("unsupported-sort: a row slice under ties or set semantics");
    }
    Term rows = rel(sort.getInput());
    Sort elem = elemOf(rows);
    Term x = var(elem, "x");
    Term y = var(elem, "y");
    // y sorts before x: lexicographically by the keys, each in its direction and nulls order
    Term before = tm.mkFalse();
    for (int i = keys.size() - 1; i >= 0; i--)
    {
      RelFieldCollation key = keys.get(i);
      int c = key.getFieldIndex();
      boolean descending = key.getDirection().isDescending();
      RelFieldCollation.NullDirection nulls = key.nullDirection == RelFieldCollation.NullDirection.UNSPECIFIED
          ? key.getDirection().defaultNullDirection()
          : key.nullDirection;
      boolean nullsFirst = nulls == RelFieldCollation.NullDirection.FIRST;
      Term a = select(y, c);
      Term b = select(x, c);
      Term values = descending ? less(val(b), val(a)) : less(val(a), val(b));
      Term nullFirst = nullsFirst ? not(isNull(b)) : tm.mkFalse();
      Term someFirst = nullsFirst ? tm.mkFalse() : tm.mkTrue();
      Term rest = ite(isNull(b), someFirst, values);
      Term lt = ite(isNull(a), nullFirst, rest);
      Term tie = and(tm.mkTerm(Kind.EQUAL, a, b), before);
      before = or(lt, tie);
    }
    Term earlier = tm.mkTerm(getFilterKind(), lambda(new Term[] {y}, before), rows);
    // the place: a fold counting the rows before x
    Term z = var(elem, "z");
    Term acc = var(tm.getIntegerSort(), "a");
    Term count = lambda(new Term[] {z, acc}, tm.mkTerm(Kind.ADD, acc, tm.mkInteger(1)));
    Term place = tm.mkTerm(Kind.BAG_FOLD, count, tm.mkInteger(0), earlier);
    List<Term> kept = new ArrayList<>();
    kept.add(tm.mkTerm(Kind.GEQ, place, tm.mkInteger(off)));
    if (lim >= 0)
    {
      kept.add(tm.mkTerm(Kind.LT, place, tm.mkInteger(off + lim)));
    }
    return tm.mkTerm(getFilterKind(), lambda(new Term[] {x}, and(kept)), rows);
  }

  private static long constant(RexNode e, long absent)
  {
    if (e == null)
    {
      return absent;
    }
    if (e instanceof RexLiteral)
    {
      return ((RexLiteral) e).getValueAs(BigDecimal.class).longValueExact();
    }
    throw new UnsupportedOperationException("unsupported-sort: a row slice of a computed size");
  }

  // ── Aggregation ─────────────────────────────────────────────────────────────────────────────

  private Term group(LogicalAggregate aggregate) throws CVC5ApiException
  {
    RelNode source = aggregate.getInput();
    Term child = rel(source);
    List<AggregateCall> calls = aggregate.getAggCallList();
    boolean grouping = false;
    for (AggregateCall call : calls)
    {
      grouping |= isGrouping(call);
    }
    if (aggregate.getGroupSets().size() == 1 && !grouping)
    {
      return plainGroup(source, child, aggregate.getGroupSet().toArray(), calls);
    }
    return groupingSets(aggregate, child);
  }

  private static boolean isGrouping(AggregateCall call)
  {
    SqlKind kind = call.getAggregation().getKind();
    return kind == SqlKind.GROUPING || kind == SqlKind.GROUPING_ID;
  }

  /**
   * {@code GROUP BY GROUPING SETS (..)} as the {@code UNION ALL} of one plain {@code GROUP BY}
   * per grouping set, as SQL defines it and sqleq's frontend lowers it for sqleq-cvc5: each set
   * groups the rows by its own columns, the grouping columns it leaves out are NULL in its rows,
   * and {@code GROUPING(a, ..)} is the bit mask of the arguments it leaves out, the last argument
   * the lowest bit. For {@code GROUPING SETS ((k), ())} with {@code COUNT(*)}, {@code
   * (bag.union_disjoint (bag.map (lambda ((g__0 G)) (tuple ((_ tuple.select 0) g__0) ((_
   * tuple.select 1) g__0))) A) (bag.map (lambda ((g__0 H)) (tuple (as nullable.null (Nullable
   * Int)) ((_ tuple.select 0) g__0))) B))} with {@code A} the count by {@code k} and {@code B} the
   * count of every row.
   */
  private Term groupingSets(LogicalAggregate aggregate, Term child) throws CVC5ApiException
  {
    RelNode source = aggregate.getInput();
    int[] all = aggregate.getGroupSet().toArray();
    Sort[] sourceSorts = columnSorts(child);
    List<AggregateCall> calls = aggregate.getAggCallList();
    List<AggregateCall> folded = new ArrayList<>();
    for (AggregateCall call : calls)
    {
      if (!isGrouping(call))
      {
        folded.add(call);
      }
      else
      {
        for (int arg : call.getArgList())
        {
          if (!aggregate.getGroupSet().get(arg))
          {
            throw new UnsupportedOperationException("GROUPING of a column that is not a grouping column");
          }
        }
      }
    }
    Term union = null;
    for (org.apache.calcite.util.ImmutableBitSet set : aggregate.getGroupSets())
    {
      int[] keys = set.toArray();
      Term part = keys.length == 0 && folded.isEmpty()
          // the grand total of no aggregate: one row, even over no rows
          ? mkSingleton(tm.mkTuple(new Term[0]))
          : plainGroup(source, child, keys, folded);
      Term g = var(elemOf(part), "g");
      Term[] cells = new Term[all.length + calls.size()];
      for (int i = 0; i < all.length; i++)
      {
        int at = Arrays.binarySearch(keys, all[i]);
        cells[i] = at >= 0 ? select(g, at) : tm.mkNullableNull(sourceSorts[all[i]]);
      }
      int next = keys.length;
      for (int j = 0; j < calls.size(); j++)
      {
        AggregateCall call = calls.get(j);
        if (!isGrouping(call))
        {
          cells[all.length + j] = select(g, next++);
          continue;
        }
        List<Integer> args = call.getArgList();
        long mask = 0;
        for (int i = 0; i < args.size(); i++)
        {
          if (!set.get(args.get(i)))
          {
            mask |= 1L << (args.size() - 1 - i);
          }
        }
        cells[all.length + j] = some(tm.mkInteger(mask));
      }
      Term mapped = tm.mkTerm(getMapKind(), lambda(new Term[] {g}, tm.mkTuple(cells)), part);
      union = union == null ? mapped : tm.mkTerm(getUnionAllKind(), union, mapped);
    }
    return union;
  }

  /** A {@code GROUP BY} of {@code child}, the rows of {@code source}, by the columns {@code indices}. */
  private Term plainGroup(RelNode source, Term child, int[] indices, List<AggregateCall> aggCalls)
      throws CVC5ApiException
  {
    if (aggCalls.isEmpty())
    {
      // SELECT DISTINCT, or GROUP BY with no aggregate: duplicate removal of a projection.
      return mkDistinct(project(indices, child));
    }
    List<Agg> calls = new ArrayList<>();
    Grouped grouped = preproject(child, indices, aggCalls, source.getRowType().getFieldCount());
    child = grouped.child;
    indices = grouped.indices;
    List<List<Integer>> argLists = grouped.args;
    // what is known of the rows' columns: those that copy a column of the input, as it is
    int[] origin = grouped.origin;
    java.util.function.IntPredicate known = c -> c < origin.length && origin[c] >= 0 && neverNull(source, origin[c]);
    // The argument column of each call, or -1 for COUNT(*). A COUNT of a column that is never
    // NULL counts every row, so it is COUNT(*), one fold for both.
    int[] args = new int[aggCalls.size()];
    // the other columns of a COUNT of several, which counts the rows where none is NULL
    int[][] extra = new int[aggCalls.size()][];
    for (int j = 0; j < aggCalls.size(); j++)
    {
      AggregateCall call = aggCalls.get(j);
      Agg agg = new Agg(aggregateName(call), postgresType(call, source), call.isDistinct());
      calls.add(agg);
      List<Integer> cols = argLists.get(j);
      if (cols.size() > 1 && !agg.op.equals("COUNT"))
      {
        throw new UnsupportedOperationException("multi-argument aggregate " + agg.op);
      }
      boolean never = true;
      for (int c : cols)
      {
        never &= known.test(c);
      }
      if (cols.isEmpty() || (agg.op.equals("COUNT") && !agg.distinct && never))
      {
        args[j] = -1;
        extra[j] = new int[0];
      }
      else
      {
        args[j] = cols.get(0);
        extra[j] = cols.subList(1, cols.size()).stream().mapToInt(Integer::intValue).toArray();
      }
    }
    boolean anyDistinct = false;
    for (int j = 0; j < calls.size(); j++)
    {
      if (calls.get(j).distinct)
      {
        anyDistinct = true;
        if (args[j] < 0)
        {
          throw new UnsupportedOperationException("distinct-aggregate without an argument");
        }
      }
    }
    if (anyDistinct)
    {
      if (calls.size() > 1)
      {
        return mixedDistinct(child, indices, calls, args, extra, known);
      }
      // one DISTINCT call: fold over the projection onto (keys, arguments) with duplicates
      // removed, grouped by the keys
      int nk = indices.length;
      Term dedup = mkDistinct(project(keep(indices, args[0], extra[0]), child));
      Agg call = new Agg(calls.get(0).op, calls.get(0).type, false);
      int[][] ex = new int[1][];
      int arg = deduplicatedArgument(call, args[0], extra[0], nk, known, ex);
      return aggregateOver(dedup, range(nk), List.of(call), new int[] {arg}, ex);
    }
    return aggregateOver(child, indices, calls, args, extra);
  }

  /** A {@code GROUP BY}'s input as sqleq's frontend writes it, and where its columns come from. */
  private static final class Grouped
  {
    Term child;
    int[] indices;
    List<List<Integer>> args = new ArrayList<>();
    /** The input column each column copies, -1 for one computed. */
    int[] origin;
  }

  /**
   * The rows a {@code GROUP BY} folds over, as sqleq's frontend writes them: the keys, then every
   * call's arguments, {@code ((_ table.project k a) rows)}. A {@code FILTER} goes into its call's
   * arguments: {@code agg(x) FILTER (WHERE p)} is {@code agg(CASE WHEN p THEN x END)}, which drops
   * exactly the rows {@code p} does not keep from an aggregate that skips NULL inputs, and
   * {@code COUNT(*) FILTER (WHERE p)} counts {@code CASE WHEN p THEN 1 END}, so the rows are
   * {@code (bag.map (lambda ((t T)) (tuple k .. (ite (and (nullable.is_some p) (nullable.val p)) x
   * null))) rows)}. Calcite writes the same projection below a plain aggregate, and the rows are
   * left alone then; not for each of the grouping sets.
   */
  private Grouped preproject(Term child, int[] indices, List<AggregateCall> calls, int width)
      throws CVC5ApiException
  {
    Term t = var(elemOf(child), "t");
    Sort[] sorts = columnSorts(child);
    List<Term> cells = new ArrayList<>();
    List<Integer> origin = new ArrayList<>();
    for (int i : indices)
    {
      cells.add(select(t, i));
      origin.add(i);
    }
    Grouped g = new Grouped();
    boolean computed = false;
    for (AggregateCall call : calls)
    {
      List<Integer> args = new ArrayList<>();
      Term keep = null;
      if (call.hasFilter())
      {
        SqlKind kind = call.getAggregation().getKind();
        if (kind != SqlKind.COUNT && kind != SqlKind.SUM && kind != SqlKind.SUM0 && kind != SqlKind.MIN
            && kind != SqlKind.MAX && kind != SqlKind.AVG)
        {
          throw new UnsupportedOperationException("FILTER on the aggregate " + call.getAggregation().getName());
        }
        computed = true;
        keep = truth(select(t, call.filterArg));
        if (call.getArgList().isEmpty())
        {
          args.add(cells.size());
          Term one = some(tm.mkInteger(1));
          cells.add(ite(keep, one, tm.mkNullableNull(one.getSort())));
          origin.add(-1);
        }
      }
      for (int a : call.getArgList())
      {
        args.add(cells.size());
        cells.add(keep == null ? select(t, a) : ite(keep, select(t, a), tm.mkNullableNull(sorts[a])));
        origin.add(keep == null ? a : -1);
      }
      g.args.add(args);
    }
    boolean identity = !computed && origin.size() == width;
    for (int i = 0; i < origin.size() && identity; i++)
    {
      identity = origin.get(i) == i;
    }
    if (identity || (!computed && origin.isEmpty()))
    {
      // the rows are already the keys and the arguments, or a COUNT(*) without keys reads none
      g.child = child;
      g.indices = indices;
      g.args.clear();
      for (AggregateCall call : calls)
      {
        g.args.add(call.getArgList());
      }
      g.origin = range(width);
      return g;
    }
    g.origin = origin.stream().mapToInt(Integer::intValue).toArray();
    g.child = computed ? tm.mkTerm(getMapKind(), lambda(new Term[] {t}, tm.mkTuple(cells.toArray(new Term[0]))), child)
                       : project(g.origin, child);
    g.indices = range(indices.length);
    return g;
  }

  /**
   * The type Postgres gives an aggregate where Calcite's differs: {@code sum(bigint)} and
   * {@code avg} over any integer are {@code numeric}, which Calcite types as the integers they
   * add, so that {@code SUM(b) / COUNT(*)} would be an integer division it is not.
   */
  private static RelDataType postgresType(AggregateCall call, RelNode source)
  {
    SqlKind kind = call.getAggregation().getKind();
    List<Integer> args = call.getArgList();
    if (args.size() == 1 && (kind == SqlKind.AVG || kind == SqlKind.SUM || kind == SqlKind.SUM0))
    {
      SqlTypeName arg = pgType(source, args.get(0));
      if (isIntegerType(arg))
      {
        org.apache.calcite.rel.type.RelDataTypeFactory types = source.getCluster().getTypeFactory();
        SqlTypeName result = kind == SqlKind.AVG || arg == SqlTypeName.BIGINT ? SqlTypeName.DECIMAL : SqlTypeName.BIGINT;
        return types.createTypeWithNullability(types.createSqlType(result), true);
      }
    }
    return call.getType();
  }

  /**
   * The type Postgres gives column {@code c} of {@code rel}, where it differs from Calcite's: the
   * aggregates {@link #postgresType} retypes, carried through the operators that copy a column.
   * Elsewhere Calcite's.
   */
  private static SqlTypeName pgType(RelNode rel, int c)
  {
    if (rel instanceof LogicalAggregate)
    {
      LogicalAggregate aggregate = (LogicalAggregate) rel;
      int[] keys = aggregate.getGroupSet().toArray();
      if (c < keys.length)
      {
        return pgType(aggregate.getInput(), keys[c]);
      }
      return postgresType(aggregate.getAggCallList().get(c - keys.length), aggregate.getInput()).getSqlTypeName();
    }
    if (rel instanceof LogicalProject)
    {
      RexNode e = ((LogicalProject) rel).getProjects().get(c);
      return e instanceof RexInputRef ? pgType(rel.getInput(0), ((RexInputRef) e).getIndex())
                                      : e.getType().getSqlTypeName();
    }
    if (rel instanceof LogicalFilter || rel instanceof LogicalSort)
    {
      return pgType(rel.getInput(0), c);
    }
    if (rel instanceof LogicalJoin)
    {
      LogicalJoin join = (LogicalJoin) rel;
      int w = join.getLeft().getRowType().getFieldCount();
      return c < w ? pgType(join.getLeft(), c) : pgType(join.getRight(), c - w);
    }
    return rel.getRowType().getFieldList().get(c).getType().getSqlTypeName();
  }

  private static String aggregateName(AggregateCall call)
  {
    switch (call.getAggregation().getKind())
    {
      case COUNT: return "COUNT";
      case SUM: return "SUM";
      // Calcite's SUM that is 0 rather than NULL over no rows
      case SUM0: return "SUM0";
      case MIN: return "MIN";
      case MAX: return "MAX";
      case AVG: return "AVG";
      case SINGLE_VALUE: return "SINGLE_VALUE";
      default: throw new UnsupportedOperationException("aggregate:" + call.getAggregation().getName());
    }
  }

  /** The keys, then the argument and the further columns of a call. */
  private static int[] keep(int[] indices, int argument, int[] extra)
  {
    int[] keep = Arrays.copyOf(indices, indices.length + 1 + extra.length);
    keep[indices.length] = argument;
    System.arraycopy(extra, 0, keep, indices.length + 1, extra.length);
    return keep;
  }

  /**
   * The argument of a call over its deduplicated input, the keys first: over those rows a COUNT
   * of columns that are never NULL counts them all.
   */
  private int deduplicatedArgument(Agg call, int argument, int[] extra, int nk,
      java.util.function.IntPredicate known, int[][] ex)
  {
    boolean never = known.test(argument);
    for (int c : extra)
    {
      never &= known.test(c);
    }
    if (call.op.equals("COUNT") && never)
    {
      ex[0] = new int[0];
      return -1;
    }
    ex[0] = new int[extra.length];
    for (int k = 0; k < extra.length; k++)
    {
      ex[0][k] = nk + 1 + k;
    }
    return nk;
  }

  private static int[] range(int n)
  {
    int[] r = new int[n];
    for (int i = 0; i < n; i++)
    {
      r[i] = i;
    }
    return r;
  }

  /**
   * A {@code GROUP BY} with {@code DISTINCT} calls: {@code table.aggr} folds over every copy of a
   * row, so each {@code DISTINCT} call folds over its own input, the projection onto the keys and
   * its argument with duplicates removed; the plain calls fold over the rows; the groups of all of
   * them are the same key values, joined on the keys (equal as values, NULL included, as grouping
   * compares them). With no key each part is one row and the join is their product. For
   * {@code SELECT k, COUNT(DISTINCT c), SUM(a) FROM t GROUP BY k}, the rows of
   * {@code (bag.filter (lambda ((p W)) (= ((_ tuple.select 0) p) ((_ tuple.select 2) p)))
   * (table.product A B))} mapped to {@code (tuple k count sum)}, with {@code A} the aggregate of
   * {@code SUM(a)} over the rows of {@code t} by {@code k}, and {@code B} that of {@code COUNT(c)}
   * over {@code (bag.setof ((_ table.project 0 1) t))}.
   */
  private Term mixedDistinct(Term child, int[] indices, List<Agg> calls, int[] args, int[][] extra,
      java.util.function.IntPredicate known) throws CVC5ApiException
  {
    int nk = indices.length;
    List<Integer> plain = new ArrayList<>();
    for (int j = 0; j < calls.size(); j++)
    {
      if (!calls.get(j).distinct)
      {
        plain.add(j);
      }
    }
    // the first part: the plain calls over the rows, or the distinct keys when there are none
    Term first;
    if (plain.isEmpty())
    {
      first = mkDistinct(project(indices, child));
    }
    else
    {
      List<Agg> pc = new ArrayList<>();
      int[] pa = new int[plain.size()];
      int[][] pe = new int[plain.size()][];
      for (int n = 0; n < plain.size(); n++)
      {
        pc.add(calls.get(plain.get(n)));
        pa[n] = args[plain.get(n)];
        pe[n] = extra[plain.get(n)];
      }
      first = aggregateOver(child, indices, pc, pa, pe);
    }
    // Without GROUP BY the query has its one row even over no rows, and the distinct keys of no
    // columns are no row then: the parts below, folds without keys, are one row each.
    List<Term> parts = new ArrayList<>();
    if (!(plain.isEmpty() && nk == 0))
    {
      parts.add(first);
    }
    // where each call's value is: (part, column)
    int[][] place = new int[calls.size()][];
    for (int n = 0; n < plain.size(); n++)
    {
      place[plain.get(n)] = new int[] {0, nk + n};
    }
    for (int j = 0; j < calls.size(); j++)
    {
      if (!calls.get(j).distinct)
      {
        continue;
      }
      Term dedup = mkDistinct(project(keep(indices, args[j], extra[j]), child));
      Agg call = new Agg(calls.get(j).op, calls.get(j).type, false);
      int[][] ex = new int[1][];
      int arg = deduplicatedArgument(call, args[j], extra[j], nk, known, ex);
      Term part = aggregateOver(dedup, range(nk), List.of(call), new int[] {arg}, ex);
      place[j] = new int[] {parts.size(), nk};
      parts.add(part);
    }
    // the product of the parts, right-nested, and where each part's columns start in its rows
    Term product = parts.get(parts.size() - 1);
    for (int p = parts.size() - 2; p >= 0; p--)
    {
      product = tm.mkTerm(getProductKind(), parts.get(p), product);
    }
    int[] offsets = new int[parts.size()];
    int at = 0;
    for (int p = 0; p < parts.size(); p++)
    {
      offsets[p] = at;
      at += width(parts.get(p).getSort());
    }
    Term t = var(elemOf(product), "t");
    List<Term> equal = new ArrayList<>();
    for (int p = 1; p < parts.size(); p++)
    {
      for (int k = 0; k < nk; k++)
      {
        equal.add(tm.mkTerm(Kind.EQUAL, select(t, k), select(t, offsets[p] + k)));
      }
    }
    Term joined = equal.isEmpty() ? product
                                  : tm.mkTerm(getFilterKind(), lambda(new Term[] {t}, and(equal)), product);
    Term[] cells = new Term[nk + calls.size()];
    for (int k = 0; k < nk; k++)
    {
      cells[k] = select(t, k);
    }
    for (int j = 0; j < calls.size(); j++)
    {
      cells[nk + j] = select(t, offsets[place[j][0]] + place[j][1]);
    }
    return tm.mkTerm(getMapKind(), lambda(new Term[] {t}, tm.mkTuple(cells)), joined);
  }

  /**
   * {@code GROUP BY} over {@code child} by the columns {@code indices}, the calls folding over
   * every row, each reading column {@code args[j]} (-1 for {@code COUNT(*)}), and {@code extra[j]}
   * the further columns of a {@code COUNT} of several. For {@code SELECT k, COUNT(*) FROM t GROUP
   * BY k}, k column 0, {@code ((_ table.aggr 0) (lambda ((x T) (y U)) (tuple ((_ tuple.select 0)
   * x) (nullable.some (+ (nullable.val ((_ tuple.select 1) y)) 1)))) (tuple (as nullable.null
   * (Nullable Int)) (nullable.some 0)) t)}, with no group, so no row, for an empty {@code t}.
   * For {@code SELECT COUNT(*) FROM t}, one row even for an empty {@code t}: {@code (bag
   * (bag.fold (lambda ((x T) (y U)) (tuple (nullable.some (+ (nullable.val ((_ tuple.select 0)
   * y)) 1)))) (tuple (nullable.some 0)) t) 1)}.
   */
  private Term aggregateOver(Term child, int[] indices, List<Agg> calls, int[] args, int[][] extra)
      throws CVC5ApiException
  {
    Sort xSort = elemOf(child);
    Sort[] xSorts = xSort.getTupleSorts();
    Sort integer = tm.mkNullableSort(tm.getIntegerSort());
    // The accumulator: one slot per key, then the slots of each call (AVG keeps a sum and a
    // count, and is finished off by a map below).
    List<Sort> slotSorts = new ArrayList<>();
    for (int i : indices)
    {
      slotSorts.add(xSorts[i]);
    }
    // A SUM of integers typed as a real adds them as integers, read as a real once at the end.
    boolean[] intSums = new boolean[calls.size()];
    List<Sort[]> slots = new ArrayList<>();
    for (int j = 0; j < calls.size(); j++)
    {
      Agg call = calls.get(j);
      boolean sum = call.op.equals("SUM") || call.op.equals("SUM0");
      intSums[j] = sum && args[j] >= 0 && baseSort(call.type).isReal() && xSorts[args[j]].equals(integer);
      Sort out = intSums[j] ? integer : colSort(call.type);
      Sort[] s = call.op.equals("AVG") ? new Sort[] {out, integer} : new Sort[] {out};
      slotSorts.addAll(Arrays.asList(s));
      slots.add(s);
    }
    Sort ySort = tm.mkTupleSort(slotSorts.toArray(new Sort[0]));
    Term x = var(xSort, "x");
    Term y = var(ySort, "y");
    List<Term> elements = new ArrayList<>();
    List<Term> initial = new ArrayList<>();
    for (int k = 0; k < indices.length; k++)
    {
      // never read: the first row of each group overwrites it. It only has to typecheck.
      elements.add(select(x, indices[k]));
      initial.add(tm.mkNullableNull(slotSorts.get(k)));
    }
    int at = indices.length;
    for (int j = 0; j < calls.size(); j++)
    {
      Agg call = calls.get(j);
      Sort[] s = slots.get(j);
      Term arg = null;
      if (call.op.equals("AVG") && args[j] >= 0)
      {
        // an average over `numeric` is a division, over floats a float sum
        observes("AVG", select(x, args[j]));
      }
      if (args[j] >= 0)
      {
        // COUNT reads only whether the argument is null; the others fold it into the slot.
        arg = call.op.equals("COUNT") ? select(x, args[j]) : asSort(select(x, args[j]), s[0]);
      }
      Term[] accs = new Term[s.length];
      for (int k = 0; k < s.length; k++)
      {
        accs[k] = select(y, at + k);
      }
      if (arg != null && extra[j].length > 0)
      {
        // COUNT of several columns: the rows where none of them is NULL
        List<Term> nulls = new ArrayList<>();
        nulls.add(isNull(arg));
        for (int c : extra[j])
        {
          nulls.add(isNull(select(x, c)));
        }
        Term next = some(tm.mkTerm(Kind.ADD, val(accs[0]), tm.mkInteger(1)));
        elements.add(ite(or(nulls), accs[0], next));
        initial.add(some(tm.mkInteger(0)));
        at += s.length;
        continue;
      }
      aggregateStep(call, arg, accs, s, elements, initial);
      at += s.length;
    }
    Term f = lambda(new Term[] {x, y}, tm.mkTuple(elements.toArray(new Term[0])));
    Term init = tm.mkTuple(initial.toArray(new Term[0]));
    // GROUP BY has a row per group, so none over an empty table, as table.aggr. Without GROUP
    // BY, SQL asks for exactly one row even over no rows -- SELECT COUNT(*) FROM empty is 0 --
    // which is the fold of the whole table.
    Term aggregated = indices.length > 0
        ? tm.mkTerm(tm.mkOp(getAggregateKind(), indices), f, init, child)
        : mkSingleton(tm.mkTerm(getFoldKind(), f, init, child));
    boolean finish = false;
    for (int j = 0; j < calls.size(); j++)
    {
      finish |= slots.get(j).length > 1 || intSums[j];
    }
    if (finish)
    {
      aggregated = finishAggregates(aggregated, indices.length, calls, slots, intSums);
    }
    return aggregated;
  }

  /**
   * One call's step of the fold and its seed: how the slots change on a row whose argument is
   * {@code arg} (null for {@code COUNT(*)}), with {@code accs} the running values. SQL aggregates
   * skip null inputs, and SUM/MIN/MAX over no non-null value are null, so those seed with null and
   * treat a null accumulator as "nothing seen yet"; COUNT starts at zero and never returns null.
   */
  private void aggregateStep(Agg call, Term arg, Term[] accs, Sort[] sorts, List<Term> elements,
      List<Term> initial) throws CVC5ApiException
  {
    Term one = tm.mkInteger(1);
    Term acc = accs[0];
    switch (call.op)
    {
      case "COUNT":
      {
        Term more = some(tm.mkTerm(Kind.ADD, val(acc), one));
        elements.add(arg == null ? more : ite(isNull(arg), acc, more));
        initial.add(some(tm.mkInteger(0)));
        return;
      }
      case "SUM":
      case "SUM0":
      case "MIN":
      case "MAX":
      {
        if (arg == null)
        {
          throw new UnsupportedOperationException(call.op + " without an argument");
        }
        elements.add(foldStep(call.op.equals("SUM0") ? "SUM" : call.op, arg, acc));
        Sort base = sorts[0].getNullableElementSort();
        initial.add(call.op.equals("SUM0") ? some(base.isReal() ? tm.mkReal(0) : tm.mkInteger(0))
                                           : tm.mkNullableNull(sorts[0]));
        return;
      }
      case "SINGLE_VALUE":
      {
        // Calcite's: the value of the group's only row, an error on two or more. A run that
        // answers reads one row, which a fold keeping the last value read returns; NULL over no
        // rows, as a scalar subquery over none is.
        if (arg == null)
        {
          throw new UnsupportedOperationException("SINGLE_VALUE without an argument");
        }
        elements.add(arg);
        initial.add(tm.mkNullableNull(sorts[0]));
        return;
      }
      case "AVG":
      {
        if (arg == null)
        {
          throw new UnsupportedOperationException("AVG without an argument");
        }
        elements.add(foldStep("SUM", arg, acc));
        Term more = some(tm.mkTerm(Kind.ADD, val(accs[1]), one));
        elements.add(ite(isNull(arg), accs[1], more));
        initial.add(tm.mkNullableNull(sorts[0]));
        initial.add(some(tm.mkInteger(0)));
        return;
      }
      default: throw new UnsupportedOperationException("aggregate:" + call.op);
    }
  }

  /**
   * {@code acc} after a row with argument {@code arg}: a null row leaves it alone, the first
   * non-null row seeds it, and a later one combines.
   */
  private Term foldStep(String op, Term arg, Term acc) throws CVC5ApiException
  {
    Term va = val(arg);
    Term vb = val(acc);
    Term combined;
    switch (op)
    {
      case "SUM":
      {
        Sort s = va.getSort();
        if (!s.isInteger() && !s.isReal())
        {
          throw new UnsupportedOperationException("SUM over values of sort " + s);
        }
        combined = some(tm.mkTerm(Kind.ADD, va, vb));
        break;
      }
      case "MIN": combined = ite(less(va, vb), arg, acc); break;
      default: combined = ite(less(vb, va), arg, acc);
    }
    Term seeded = ite(isNull(acc), arg, combined);
    return ite(isNull(arg), acc, seeded);
  }

  /** {@code a < b} on two values of one sort, in the sort's own order. */
  private Term less(Term a, Term b)
  {
    Sort s = a.getSort();
    if (s.isInteger() || s.isReal())
    {
      return tm.mkTerm(Kind.LT, a, b);
    }
    if (s.isString())
    {
      refuseCollatedOrder();
      return tm.mkTerm(Kind.STRING_LT, a, b);
    }
    if (s.isBoolean())
    {
      // FALSE < TRUE, as Postgres orders booleans.
      return and(not(a), b);
    }
    throw new UnsupportedOperationException("an order on values of sort " + s);
  }

  /**
   * The row of a {@code GROUP BY} from its accumulator, where a call kept more than one slot:
   * {@code AVG} becomes {@code avg(sum, count)}, null when the count is zero.
   */
  private Term finishAggregates(Term aggregated, int nkeys, List<Agg> calls, List<Sort[]> slots,
      boolean[] intSums) throws CVC5ApiException
  {
    Term y = var(elemOf(aggregated), "y");
    Term[] cells = new Term[nkeys + calls.size()];
    for (int k = 0; k < nkeys; k++)
    {
      cells[k] = select(y, k);
    }
    int at = nkeys;
    for (int j = 0; j < calls.size(); j++)
    {
      Sort[] s = slots.get(j);
      Term first = select(y, at);
      if (intSums[j])
      {
        cells[nkeys + j] = lift(Kind.TO_REAL, first);
      }
      else if (s.length == 1)
      {
        cells[nkeys + j] = first;
      }
      else
      {
        Term count = select(y, at + 1);
        Sort sumBase = s[0].getNullableElementSort();
        Term avg = fun("avg:" + sumBase, new Sort[] {sumBase, tm.getIntegerSort()}, sumBase);
        Term n = val(count);
        Term none = tm.mkTerm(Kind.EQUAL, n, tm.mkInteger(0));
        Term v = apply(avg, new Term[] {val(first), n});
        cells[nkeys + j] = ite(none, tm.mkNullableNull(first.getSort()), some(v));
      }
      at += s.length;
    }
    return tm.mkTerm(getMapKind(), lambda(new Term[] {y}, tm.mkTuple(cells)), aggregated);
  }

  // ── Conditions ──────────────────────────────────────────────────────────────────────────────

  /**
   * The two-valued reading of a condition, with SQL's {@code AND}, {@code OR} and {@code NOT} read
   * as the Boolean connectives over the truth values of their operands. The same predicate as
   * the truth of the three-valued encoding, but a conjunction stays a conjunction, which lets the
   * solver's rewriter move one conjunct at a time. For {@code a = b AND c},
   * {@code (and (nullable.is_some a) (= a b) (nullable.is_some c) (nullable.val c))}.
   */
  private Term condition(RexNode e, Row row) throws CVC5ApiException
  {
    if (e instanceof RexCall && !(e instanceof RexSubQuery))
    {
      RexCall call = (RexCall) e;
      List<RexNode> operands = call.getOperands();
      switch (call.getKind())
      {
        case AND:
        {
          List<Term> ts = new ArrayList<>();
          for (RexNode o : operands)
          {
            ts.add(condition(o, row));
          }
          return and(ts);
        }
        case OR:
        {
          List<Term> ts = new ArrayList<>();
          for (RexNode o : operands)
          {
            ts.add(condition(o, row));
          }
          return or(ts);
        }
        case NOT:
          if (operands.size() == 1)
          {
            return negatedCondition(operands.get(0), row);
          }
          break;
        case EQUALS:
          if (operands.size() == 2)
          {
            // `a = b` holds exactly when `a` is not NULL and equals `b`: a join on a column is an
            // equation between the two columns the solver's rewriter can read.
            Term[] u = unify("=", expr(operands.get(0), row), expr(operands.get(1), row));
            return and(isSome(u[0]), tm.mkTerm(Kind.EQUAL, u[0], u[1]));
          }
          break;
        default: break;
      }
    }
    return truth(expr(e, row));
  }

  /** The two-valued reading of {@code NOT e}: {@code e} is false, with De Morgan over AND and OR. */
  private Term negatedCondition(RexNode e, Row row) throws CVC5ApiException
  {
    if (e instanceof RexCall && !(e instanceof RexSubQuery))
    {
      RexCall call = (RexCall) e;
      List<RexNode> operands = call.getOperands();
      switch (call.getKind())
      {
        case AND:
        {
          List<Term> ts = new ArrayList<>();
          for (RexNode o : operands)
          {
            ts.add(negatedCondition(o, row));
          }
          return or(ts);
        }
        case OR:
        {
          List<Term> ts = new ArrayList<>();
          for (RexNode o : operands)
          {
            ts.add(negatedCondition(o, row));
          }
          return and(ts);
        }
        case NOT:
          if (operands.size() == 1)
          {
            return condition(operands.get(0), row);
          }
          break;
        default: break;
      }
    }
    return falsity(expr(e, row));
  }

  // ── Expressions ─────────────────────────────────────────────────────────────────────────────

  /** {@code e} over {@code row}, as a term of the nullable sort of {@code e}'s type. */
  private Term expr(RexNode e, Row row) throws CVC5ApiException
  {
    if (e instanceof RexInputRef)
    {
      int i = ((RexInputRef) e).getIndex();
      if (i >= row.var.getSort().getTupleLength())
      {
        throw new UnsupportedOperationException("column-out-of-range: " + e);
      }
      return select(row.var, i);
    }
    if (e instanceof RexFieldAccess)
    {
      // a column of an enclosing query's row: a correlated subquery
      RexFieldAccess access = (RexFieldAccess) e;
      if (access.getReferenceExpr() instanceof RexCorrelVariable)
      {
        Row r = outer.get(((RexCorrelVariable) access.getReferenceExpr()).id);
        if (r != null)
        {
          return select(r.var, access.getField().getIndex());
        }
      }
      throw new UnsupportedOperationException("correlated: " + e);
    }
    if (e instanceof org.apache.calcite.rex.RexOver)
    {
      throw new UnsupportedOperationException("window function: " + e);
    }
    Term t;
    if (e instanceof RexLiteral)
    {
      t = literal((RexLiteral) e);
    }
    else if (e instanceof RexSubQuery)
    {
      t = subquery((RexSubQuery) e, row);
    }
    else if (e instanceof RexCall && e.getKind() == SqlKind.CAST)
    {
      t = cast((RexCall) e, row);
    }
    else if (e instanceof RexCall)
    {
      t = call((RexCall) e, row);
    }
    else
    {
      throw new UnsupportedOperationException("unsupported row expression: " + e);
    }
    return asType(t, e.getType());
  }

  /**
   * A cast that keeps every value -- to the type the value has, or to a wider one of its kind --
   * is the value; an integer read as a {@code numeric} is {@code to_real}; anything else is an
   * uninterpreted strict function named by the two types, {@code cast:INTEGER->VARCHAR(5)}.
   */
  private Term cast(RexCall call, Row row) throws CVC5ApiException
  {
    RexNode operand = call.getOperands().get(0);
    RelDataType from = operand.getType();
    RelDataType to = call.getType();
    if (operand instanceof RexLiteral && ((RexLiteral) operand).getValue() == null)
    {
      return tm.mkNullableNull(colSort(to));
    }
    Term v = expr(operand, row);
    if (valuePreserving(from, to))
    {
      return v;
    }
    Sort out = baseSort(to);
    Sort base = v.getSort().getNullableElementSort();
    if (base.isInteger() && out.isReal())
    {
      // an integer read as a `numeric`: the same value
      return lift(Kind.TO_REAL, v);
    }
    // a cast between number types, or to a boolean, converts by value; anything else may read
    // the spelling
    String c = coarseClass(base);
    boolean byValue = ("numeric".equals(c) || "float".equals(c))
        && (out.isInteger() || out.isReal() || out.isBoolean() || "float".equals(coarseClass(out)));
    if (!byValue)
    {
      observes("CAST to " + fullTypeName(to), v);
    }
    Term f = fun("cast:" + typeName(from) + "->" + fullTypeName(to), new Sort[] {base}, out);
    if (base.isReal() && out.isInteger())
    {
      // `numeric` to an integer rounds, which only a value with a fraction shows: an integral
      // value is itself, the rest is the uninterpreted cast
      return strict(new Term[] {v}, vals -> ite(tm.mkTerm(Kind.IS_INTEGER, vals[0]),
          tm.mkTerm(Kind.TO_INTEGER, vals[0]), apply(f, vals)));
    }
    return strict(new Term[] {v}, vals -> apply(f, vals));
  }

  /**
   * Whether every value of {@code from} is the same value of {@code to}: an integer as an integer
   * (an overflow raises, and a run that answers has none), a boolean as a boolean, a string as a
   * string no shorter, a number as one with no fewer digits on either side of the point.
   */
  private static boolean valuePreserving(RelDataType from, RelDataType to)
  {
    SqlTypeName f = from.getSqlTypeName();
    SqlTypeName t = to.getSqlTypeName();
    if (isIntegerType(f) && isIntegerType(t))
    {
      return true;
    }
    if (f != t)
    {
      return false;
    }
    int pf = from.getPrecision();
    int pt = to.getPrecision();
    switch (f)
    {
      case BOOLEAN:
      case DATE:
      case DOUBLE:
      case FLOAT:
      case REAL: return true;
      case VARCHAR:
        return pt == RelDataType.PRECISION_NOT_SPECIFIED || (pf != RelDataType.PRECISION_NOT_SPECIFIED && pf <= pt);
      // CHAR(n) pads to n
      case CHAR: return pf == pt;
      case DECIMAL:
        return to.getScale() >= from.getScale() && pt - to.getScale() >= pf - from.getScale();
      case TIME:
      case TIMESTAMP: return pt >= pf;
      default: return false;
    }
  }

  private Term literal(RexLiteral literal) throws CVC5ApiException
  {
    RelDataType type = literal.getType();
    if (literal.getValue() == null)
    {
      return tm.mkNullableNull(colSort(type));
    }
    SqlTypeName name = type.getSqlTypeName();
    if (SqlTypeName.INTERVAL_TYPES.contains(name))
    {
      // a constant of the opaque sort: two spellings may or may not be one value
      return some(fun("lit:" + typeName(type) + ":" + literal, new Sort[0], baseSort(type)));
    }
    switch (name)
    {
      case TINYINT:
      case SMALLINT:
      case INTEGER:
      case BIGINT:
        return some(tm.mkInteger(literal.getValueAs(BigDecimal.class).toBigIntegerExact().toString()));
      case DECIMAL: return some(tm.mkReal(literal.getValueAs(BigDecimal.class).toPlainString()));
      case BOOLEAN: return some(tm.mkBoolean(literal.getValueAs(Boolean.class)));
      case CHAR:
      // by code points: cvc5 refuses a character beyond ASCII in a plain string
      case VARCHAR: return some(mkString(literal.getValueAs(String.class)));
      // days since 1970-01-01, milliseconds of the day, milliseconds since 1970: integers in order
      case DATE:
      case TIME: return some(tm.mkInteger(literal.getValueAs(Integer.class)));
      case TIMESTAMP: return some(tm.mkInteger(literal.getValueAs(Long.class)));
      default:
        return some(fun("lit:" + typeName(type) + ":" + literal.getValue(), new Sort[0], baseSort(type)));
    }
  }

  /**
   * {@code t} as a term of the nullable sort of {@code type}: itself when it already is one, a
   * lifted {@code to_real} for an integer read as a real, and a refusal for any other mismatch. An
   * opaque annotation on a value computed from typed operands keeps the computed sort.
   */
  private Term asType(Term t, RelDataType type) throws CVC5ApiException
  {
    Sort want = colSort(type);
    // a `numeric` where Calcite typed an integer: an aggregate Postgres types otherwise
    // (postgresType), or arithmetic over one
    if (t.getSort().getNullableElementSort().isReal() && want.getNullableElementSort().isInteger())
    {
      return t;
    }
    if (want.getNullableElementSort().equals(sorts.get("Opaque"))
        && !t.getSort().getNullableElementSort().isUninterpretedSort())
    {
      return t;
    }
    // the result of a function nobody declared is of its unknown type, whatever Calcite says
    if (t.getSort().getNullableElementSort().equals(sorts.get("Unknown")))
    {
      return t;
    }
    return asSort(t, want);
  }

  private Term asSort(Term t, Sort want) throws CVC5ApiException
  {
    Sort have = t.getSort();
    if (have.equals(want))
    {
      return t;
    }
    // `nullable.null` of another sort: a null is a null of whatever sort
    if (t.getKind() == Kind.APPLY_CONSTRUCTOR && t.getNumChildren() == 1 && want.isNullable())
    {
      return tm.mkNullableNull(want);
    }
    if (have.getNullableElementSort().isInteger() && want.getNullableElementSort().isReal())
    {
      return toReal(t);
    }
    throw new UnsupportedOperationException("a value of sort " + have + " where " + want + " is expected");
  }

  /**
   * The sort of a {@code CASE} or {@code COALESCE} typed {@code ty}: its nullable sort, unless a
   * branch is a {@code numeric} where Calcite typed an integer -- {@code COALESCE(SUM(b), 0)} over
   * a {@code bigint}, a {@code numeric} to Postgres ({@link #postgresType}) -- when it is
   * {@code numeric}, Postgres's common type of the two.
   */
  private Sort resultSort(RelDataType ty, Term[] branches)
  {
    Sort want = colSort(ty);
    if (want.getNullableElementSort().isInteger())
    {
      for (Term b : branches)
      {
        if (b.getSort().getNullableElementSort().isReal())
        {
          return b.getSort();
        }
      }
    }
    return want;
  }

  /**
   * Two operands of a comparison over one sort: numerics widened to reals together, and a typed
   * value beside an opaque one injected into the opaque sort by an uninterpreted function.
   */
  private Term[] unify(String op, Term a, Term b) throws CVC5ApiException
  {
    Term[] p = numericPair(a, b);
    if (p[0].getSort().equals(p[1].getSort()))
    {
      return p;
    }
    Sort sa = p[0].getSort().getNullableElementSort();
    Sort sb = p[1].getSort().getNullableElementSort();
    if (sa.isUninterpretedSort() && !sb.isUninterpretedSort())
    {
      return new Term[] {p[0], readInSort(p[1], sa)};
    }
    if (sb.isUninterpretedSort() && !sa.isUninterpretedSort())
    {
      return new Term[] {readInSort(p[0], sb), p[1]};
    }
    // A number or a boolean beside a string, which Calcite compares as they are. A string literal
    // is read at the other type, as Postgres resolves an untyped literal (`a = '01'` over an
    // integer compares with 1); beside a string column the other value is read as text, where
    // sqleq's frontend writes `CAST(.. AS VARCHAR)`. Both through uninterpreted casts.
    if (sa.isString() != sb.isString())
    {
      Term string = sa.isString() ? p[0] : p[1];
      Term other = sa.isString() ? p[1] : p[0];
      Term[] read = stringLiteral(string)
          ? new Term[] {readInSort(string, other.getSort().getNullableElementSort()), other}
          : new Term[] {string, readInSort(other, string.getSort().getNullableElementSort())};
      return sa.isString() ? read : new Term[] {read[1], read[0]};
    }
    throw new UnsupportedOperationException("`" + op + "` between values of sorts " + sa + " and " + sb);
  }

  /** Whether {@code t} is a string literal, {@code (nullable.some "..")}. */
  private static boolean stringLiteral(Term t) throws CVC5ApiException
  {
    return t.getKind() == Kind.APPLY_CONSTRUCTOR && t.getNumChildren() == 2 && t.getChild(1).isStringValue();
  }

  /** {@code t} read in the sort {@code into}, through a strict uninterpreted function. */
  private Term readInSort(Term t, Sort into) throws CVC5ApiException
  {
    Sort from = t.getSort().getNullableElementSort();
    Term f = fun("as:" + from + "->" + into, new Sort[] {from}, into);
    return strict(new Term[] {t}, v -> apply(f, v));
  }

  /** Two operands of an arithmetic operator over one numeric sort, or a refusal. */
  private Term[] numericOperands(String op, Term a, Term b) throws CVC5ApiException
  {
    Term[] p = numericPair(a, b);
    if (!p[0].getSort().equals(p[1].getSort()) || !numeric(p[0]))
    {
      throw new UnsupportedOperationException("`" + op + "` between values of sorts "
          + p[0].getSort().getNullableElementSort() + " and " + p[1].getSort().getNullableElementSort());
    }
    return p;
  }

  /** Two numeric operands over one sort: an integer beside a real is read as a real. */
  private Term[] numericPair(Term a, Term b) throws CVC5ApiException
  {
    Sort sa = a.getSort().getNullableElementSort();
    Sort sb = b.getSort().getNullableElementSort();
    if (sa.isInteger() && sb.isReal())
    {
      return new Term[] {toReal(a), b};
    }
    if (sa.isReal() && sb.isInteger())
    {
      return new Term[] {a, toReal(b)};
    }
    return new Term[] {a, b};
  }

  /**
   * An integer read as a {@code numeric}. Not a parameter's: the input layer types an untyped
   * parameter from Calcite's plan, and Postgres types it at its first use, which may be this one,
   * as a {@code numeric}.
   */
  private Term toReal(Term t) throws CVC5ApiException
  {
    if (parameters.contains(t))
    {
      throw new UnsupportedOperationException("a parameter " + t + ", inferred as an integer, meets a numeric"
          + " value: Postgres types an untyped parameter at its first use, which may be this one, as a numeric");
    }
    return lift(Kind.TO_REAL, t);
  }

  private static boolean numeric(Term a)
  {
    Sort s = a.getSort().getNullableElementSort();
    return s.isInteger() || s.isReal();
  }

  private static boolean allOf(Term[] args, int from, java.util.function.Predicate<Sort> p)
  {
    for (int i = from; i < args.length; i++)
    {
      if (!p.test(args[i].getSort().getNullableElementSort()))
      {
        return false;
      }
    }
    return true;
  }

  private Term call(RexCall call, Row row) throws CVC5ApiException
  {
    // A flag (TRIM's BOTH, EXTRACT's YEAR) is part of the function's name, not an argument.
    List<RexNode> operand = new ArrayList<>();
    StringBuilder flags = new StringBuilder();
    for (RexNode o : call.getOperands())
    {
      if (o instanceof RexLiteral && ((RexLiteral) o).getTypeName() == SqlTypeName.SYMBOL)
      {
        flags.append('_').append(((RexLiteral) o).getValue());
      }
      else
      {
        operand.add(o);
      }
    }
    String op = call.getOperator().getName() + flags;
    RelDataType ty = call.getType();
    Term[] args = new Term[operand.size()];
    for (int i = 0; i < args.length; i++)
    {
      args[i] = expr(operand.get(i), row);
    }
    int arity = args.length;
    boolean exact = true;
    for (RexNode o : operand)
    {
      exact &= isExactNumeric(o.getType());
    }
    SqlKind kind = call.getKind();
    switch (kind)
    {
      case AND: return shortCircuit(args, Kind.AND, false);
      case OR: return shortCircuit(args, Kind.OR, true);
      case NOT:
        if (arity == 1)
        {
          return lift(Kind.NOT, args);
        }
        break;
      case EQUALS:
      case NOT_EQUALS:
        if (arity == 2)
        {
          return lift(kind == SqlKind.EQUALS ? Kind.EQUAL : Kind.DISTINCT, unify(op, args[0], args[1]));
        }
        break;
      case LESS_THAN:
      case LESS_THAN_OR_EQUAL:
      case GREATER_THAN:
      case GREATER_THAN_OR_EQUAL:
        if (arity == 2)
        {
          Term[] u = unify(op, args[0], args[1]);
          return compare(kind, u[0], u[1]);
        }
        break;
      // Exact arithmetic: `+`, `-` and `*` are exact in Postgres and here; integer `/` and `%`
      // truncate toward zero. Numeric division, which rounds to a scale, and arithmetic over any
      // other type (a float, a date) are strict uninterpreted functions below.
      case PLUS:
      case MINUS:
      case TIMES:
        if (arity == 2 && exact)
        {
          Kind k = kind == SqlKind.PLUS ? Kind.ADD : kind == SqlKind.MINUS ? Kind.SUB : Kind.MULT;
          return lift(k, numericOperands(op, args[0], args[1]));
        }
        break;
      case DIVIDE:
        if (arity == 2 && exact)
        {
          Term[] n = numericOperands(op, args[0], args[1]);
          if (n[0].getSort().getNullableElementSort().isInteger())
          {
            // Postgres truncates integer division toward zero; SMT-LIB's `div` floors.
            return strict(n, v -> truncatingDivision(v[0], v[1]));
          }
          // numeric division, whose scale follows its operands'
          observes("numeric division", n);
        }
        break;
      case MOD:
        if (arity == 2 && exact)
        {
          Term[] n = numericOperands(op, args[0], args[1]);
          if (n[0].getSort().getNullableElementSort().isInteger())
          {
            return strict(n, v -> tm.mkTerm(Kind.SUB, v[0], tm.mkTerm(Kind.MULT, truncatingDivision(v[0], v[1]), v[1])));
          }
        }
        break;
      case MINUS_PREFIX:
        if (arity == 1 && exact)
        {
          return lift(Kind.NEG, args);
        }
        break;
      case PLUS_PREFIX:
        if (arity == 1)
        {
          return args[0];
        }
        break;
      case IS_NULL: return some(isNull(args[0]));
      case IS_NOT_NULL: return some(isSome(args[0]));
      case IS_TRUE: return some(truth(args[0]));
      case IS_NOT_TRUE: return some(not(truth(args[0])));
      case IS_FALSE: return some(falsity(args[0]));
      case IS_NOT_FALSE: return some(not(falsity(args[0])));
      case IS_DISTINCT_FROM:
      case IS_NOT_DISTINCT_FROM:
      {
        Term[] u = unify(op, args[0], args[1]);
        Term na = isNull(u[0]);
        Term nb = isNull(u[1]);
        Term differ = tm.mkTerm(Kind.DISTINCT, val(u[0]), val(u[1]));
        Term distinct = ite(and(na, nb), tm.mkFalse(), ite(or(na, nb), tm.mkTrue(), differ));
        return some(kind == SqlKind.IS_DISTINCT_FROM ? distinct : not(distinct));
      }
      case CASE:
      {
        // Calcite's flattened [cond, then, ..., else], always odd. A null condition takes the
        // else branch.
        if (arity == 0 || arity % 2 == 0)
        {
          throw new UnsupportedOperationException("CASE operand must be [cond, then, ..., else]: " + call);
        }
        Term[] branches = new Term[(arity + 1) / 2];
        for (int i = 1; i < arity; i += 2)
        {
          branches[i / 2] = args[i];
        }
        branches[branches.length - 1] = args[arity - 1];
        Sort want = resultSort(ty, branches);
        Term result = asSort(args[arity - 1], want);
        for (int i = arity - 3; i >= 0; i -= 2)
        {
          result = ite(truth(args[i]), asSort(args[i + 1], want), result);
        }
        return result;
      }
      case COALESCE:
        if (arity >= 1)
        {
          Sort want = resultSort(ty, args);
          Term result = asSort(args[arity - 1], want);
          for (int i = arity - 2; i >= 0; i--)
          {
            Term a = asSort(args[i], want);
            result = ite(isSome(a), a, result);
          }
          return result;
        }
        break;
      case NULLIF:
        if (arity == 2)
        {
          Term[] u = unify(op, args[0], args[1]);
          Term equal = truth(lift(Kind.EQUAL, u));
          return ite(equal, tm.mkNullableNull(u[0].getSort()), u[0]);
        }
        break;
      case LIKE:
        // `x NOT LIKE p` where Calcite keeps it as one operator
        if ((op.equals("LIKE") || op.equals("NOT LIKE")) && arity == 2 && operand.get(1) instanceof RexLiteral
            && ((RexLiteral) operand.get(1)).getValue() != null && allOf(args, 0, Sort::isString))
        {
          Term re = likeRegex(((RexLiteral) operand.get(1)).getValueAs(String.class));
          Term like = strict(new Term[] {args[0]}, v -> tm.mkTerm(Kind.STRING_IN_REGEXP, v[0], re));
          return op.equals("LIKE") ? like : lift(Kind.NOT, like);
        }
        break;
      default: break;
    }
    // Case mapping follows the collation (`upper('i')` is not `'I'` under a Turkish one).
    if (collated && (op.equals("UPPER") || op.equals("LOWER") || op.equals("INITCAP")))
    {
      throw new UnsupportedOperationException(
          op + " over a string where the pair declares a collation: it may read the collation");
    }
    // Interpreted only where Calcite typed the call as cvc5 would.
    boolean string = baseSort(ty).isString();
    switch (op)
    {
      case "||":
        if (string && arity == 2 && allOf(args, 0, Sort::isString))
        {
          return lift(Kind.STRING_CONCAT, args);
        }
        break;
      case "SUBSTRING":
        if (string && (arity == 2 || arity == 3) && args[0].getSort().getNullableElementSort().isString()
            && allOf(args, 1, Sort::isInteger))
        {
          // Postgres counts from 1 and clips: characters a .. a + n - 1 that exist, none for a
          // negative end. cvc5's str.substr counts from 0 and clips the length to the end, so the
          // start is max(a, 1) - 1 and the length (a + n) - max(a, 1); without FOR, the rest.
          return strict(args, v -> {
            Term one = tm.mkInteger(1);
            Term first = ite(tm.mkTerm(Kind.LT, v[1], one), one, v[1]);
            Term start = tm.mkTerm(Kind.SUB, first, one);
            Term length = v.length == 3 ? tm.mkTerm(Kind.SUB, tm.mkTerm(Kind.ADD, v[1], v[2]), first)
                                        : tm.mkTerm(Kind.STRING_LENGTH, v[0]);
            return tm.mkTerm(Kind.STRING_SUBSTR, v[0], start, length);
          });
        }
        break;
      case "UPPER":
        if (string && arity == 1 && allOf(args, 0, Sort::isString))
        {
          return lift(Kind.STRING_TO_UPPER, args);
        }
        break;
      case "LOWER":
        if (string && arity == 1 && allOf(args, 0, Sort::isString))
        {
          return lift(Kind.STRING_TO_LOWER, args);
        }
        break;
      case "ABS":
        if (arity == 1 && exact && numeric(args[0]))
        {
          return lift(Kind.ABS, args);
        }
        break;
      default: break;
    }
    if (!readsByClass(kind, op, operand, args))
    {
      observes(typedSymbol(op, operand, ty), args);
    }
    // A function neither the pair declares nor the encoding knows returns a value of a type the
    // encoding does not know, whatever Calcite types it: Calcite's `ROUND(i, 1)` is an integer,
    // Postgres's a `numeric`. A predicate's truth value is a boolean either way.
    boolean declared = call.getOperator() instanceof SqlFunction
        && ((SqlFunction) call.getOperator()).getFunctionType() == SqlFunctionCategory.USER_DEFINED_FUNCTION;
    Sort codomain = declared || arithmetic(kind) || strictFunction(kind, op, call)
            || ty.getSqlTypeName() == SqlTypeName.BOOLEAN
        ? baseSort(ty)
        : uninterpretedSort("Unknown");
    if (strictFunction(kind, op, call))
    {
      return strictFun(op, ty, operand, args, codomain);
    }
    return opaqueFun(op, ty, operand, args, codomain);
  }

  private void refuseCollatedOrder()
  {
    if (collated)
    {
      throw new UnsupportedOperationException(
          "an order between strings where the pair declares a collation, which code points need not follow");
    }
  }

  /**
   * The class of Postgres values a value of {@code base} stands for, when {@code =} calls more
   * than one value equal: a {@code numeric} ({@code 2.0 = 2.00}), a float ({@code -0 = 0}), an
   * interval ({@code '1 day' = '24 hours'}); null for a sort whose {@code =} is identity.
   */
  private String coarseClass(Sort base)
  {
    if (base.isNullable())
    {
      base = base.getNullableElementSort();
    }
    if (base.isReal())
    {
      return "numeric";
    }
    if (base.equals(sorts.get("Opaque")))
    {
      return "float";
    }
    if (base.equals(sorts.get("Interval")))
    {
      return "interval";
    }
    if (base.equals(sorts.get("Unknown")))
    {
      return "unknown";
    }
    return null;
  }

  /**
   * Refuses {@code what} reading any of {@code args} that stands for a class of values, as
   * sqleq's frontend does ({@code equality.rs}): the solver reads every operation as a function of
   * the class, so from {@code t.x = u.x} it concludes {@code f(t.x) = f(u.x)}, which Postgres does
   * not honour for a cast to text, a numeric division, an {@code AVG} or {@code date + interval}.
   * The operations that give equal results on equal arguments -- comparisons, {@code COUNT},
   * {@code MIN}, {@code MAX}, {@code SUM}, {@code +}, {@code -}, {@code *}, {@code %}, a cast to
   * a number -- do not come here.
   */
  private void observes(String what, Term... args)
  {
    for (Term a : args)
    {
      String c = coarseClass(a.getSort());
      if (c != null)
      {
        if (c.equals("unknown"))
        {
          throw new UnsupportedOperationException("a value of a type the encoding does not know (the result of a"
              + " function nobody declared) read by " + what + ", which is not known to give equal results on"
              + " values = calls equal");
        }
        String example = c.equals("numeric") ? "2.0 and 2.00" : c.equals("float") ? "-0 and 0" : "'1 day' and '24 hours'";
        throw new UnsupportedOperationException("a value of type " + c + " read by " + what
            + ", which is not known to give equal results on values = calls equal, as it does " + example);
      }
    }
  }

  /**
   * {@code a op b} for an order comparison, by the operands' sort: integers and reals in their
   * order, strings by code point, booleans with FALSE before TRUE, and an uninterpreted strict
   * predicate on a sort with no order cvc5 knows.
   */
  private Term compare(SqlKind op, Term a, Term b) throws CVC5ApiException
  {
    Sort s = a.getSort().getNullableElementSort();
    if (s.isInteger() || s.isReal())
    {
      Kind k = op == SqlKind.LESS_THAN ? Kind.LT
          : op == SqlKind.LESS_THAN_OR_EQUAL ? Kind.LEQ
          : op == SqlKind.GREATER_THAN ? Kind.GT
                                         : Kind.GEQ;
      return lift(k, a, b);
    }
    if (s.isString())
    {
      refuseCollatedOrder();
      switch (op)
      {
        case LESS_THAN: return lift(Kind.STRING_LT, a, b);
        case LESS_THAN_OR_EQUAL: return lift(Kind.STRING_LEQ, a, b);
        case GREATER_THAN: return lift(Kind.STRING_LT, b, a);
        default: return lift(Kind.STRING_LEQ, b, a);
      }
    }
    if (s.isBoolean())
    {
      return strict(new Term[] {a, b}, v -> {
        switch (op)
        {
          case LESS_THAN: return less(v[0], v[1]);
          case GREATER_THAN: return less(v[1], v[0]);
          case LESS_THAN_OR_EQUAL: return not(less(v[1], v[0]));
          default: return not(less(v[0], v[1]));
        }
      });
    }
    Term f = fun(op.sql + ":" + s, new Sort[] {s, s}, tm.getBooleanSort());
    return strict(new Term[] {a, b}, v -> apply(f, v));
  }

  /**
   * Postgres's integer division: toward zero. {@code (div |a| |b|)} is that quotient's magnitude,
   * and the sign is the operands'. Division by zero is an error in Postgres; here it is whatever
   * cvc5 makes of {@code div} by zero, which no interpretation of the pair depends on.
   */
  private Term truncatingDivision(Term a, Term b)
  {
    Term zero = tm.mkInteger(0);
    Term q = tm.mkTerm(Kind.INTS_DIVISION, tm.mkTerm(Kind.ABS, a), tm.mkTerm(Kind.ABS, b));
    Term sameSign = tm.mkTerm(Kind.EQUAL, tm.mkTerm(Kind.LT, a, zero), tm.mkTerm(Kind.LT, b, zero));
    return ite(sameSign, q, tm.mkTerm(Kind.NEG, q));
  }

  /**
   * Three-valued {@code AND}/{@code OR} over nullable booleans: the dominant value -- FALSE for
   * AND, TRUE for OR -- wins however many other operands are null, so it is tested for first
   * across every operand, and the lift decides the rest.
   */
  private Term shortCircuit(Term[] args, Kind kind, boolean dominant) throws CVC5ApiException
  {
    if (args.length == 1)
    {
      return args[0];
    }
    List<Term> known = new ArrayList<>();
    for (Term a : args)
    {
      known.add(and(isSome(a), dominant ? val(a) : not(val(a))));
    }
    return ite(or(known), some(tm.mkBoolean(dominant)), lift(kind, args));
  }

  /**
   * {@code s} as a cvc5 string. cvc5 refuses a character beyond printable ASCII in a plain string,
   * so every other character, and the backslash, is written as its SMT-LIB escape: an e with an
   * acute accent as backslash, {@code u{e9}}.
   */
  private Term mkString(String s)
  {
    StringBuilder b = new StringBuilder();
    s.codePoints().forEach(c -> {
      if (c >= 32 && c < 127 && c != '\\')
      {
        b.appendCodePoint(c);
      }
      else
      {
        b.append("\\u{").append(Integer.toHexString(c)).append('}');
      }
    });
    return tm.mkString(b.toString(), true);
  }

  /**
   * {@code pattern} as a regular expression: {@code %} any string, {@code _} any character, a
   * backslash escaping the next character, as Postgres reads {@code LIKE} without {@code ESCAPE}.
   */
  private Term likeRegex(String pattern) throws CVC5ApiException
  {
    List<Term> parts = new ArrayList<>();
    StringBuilder literal = new StringBuilder();
    for (int i = 0; i < pattern.length(); i++)
    {
      char c = pattern.charAt(i);
      if (c == '%' || c == '_')
      {
        if (literal.length() > 0)
        {
          parts.add(tm.mkTerm(Kind.STRING_TO_REGEXP, mkString(literal.toString())));
          literal.setLength(0);
        }
        Term any = tm.mkRegexpAllchar();
        parts.add(c == '%' ? tm.mkTerm(Kind.REGEXP_STAR, any) : any);
      }
      else if (c == '\\')
      {
        literal.append(i + 1 < pattern.length() ? pattern.charAt(++i) : '\\');
      }
      else
      {
        literal.append(c);
      }
    }
    if (literal.length() > 0)
    {
      parts.add(tm.mkTerm(Kind.STRING_TO_REGEXP, mkString(literal.toString())));
    }
    if (parts.isEmpty())
    {
      return tm.mkTerm(Kind.STRING_TO_REGEXP, tm.mkString(""));
    }
    return parts.size() == 1 ? parts.get(0) : tm.mkTerm(Kind.REGEXP_CONCAT, parts.toArray(new Term[0]));
  }

  /**
   * Whether a function the encoding does not interpret gives equal results on arguments {@code =}
   * calls equal: arithmetic ({@code date + interval} aside, as {@code '1 mon'} and {@code '30
   * days'} add differently), and the functions computed from their arguments' values or returning
   * one of them.
   */
  private boolean readsByClass(SqlKind kind, String op, List<RexNode> operand, Term[] args)
  {
    for (Term a : args)
    {
      if ("unknown".equals(coarseClass(a.getSort())))
      {
        // all that is known of such a value is that its `=` is an equivalence: it can be
        // compared, counted, or returned
        return op.equals("GREATEST") || op.equals("LEAST");
      }
    }
    switch (kind)
    {
      case PLUS:
      case MINUS:
      case TIMES:
      case DIVIDE:
      case MOD:
      case MINUS_PREFIX:
      {
        boolean interval = false;
        boolean temporal = false;
        for (RexNode o : operand)
        {
          SqlTypeName t = o.getType().getSqlTypeName();
          interval |= SqlTypeName.INTERVAL_TYPES.contains(t);
          temporal |= t == SqlTypeName.DATE || t == SqlTypeName.TIME || t == SqlTypeName.TIMESTAMP;
        }
        return !(interval && temporal);
      }
      default: break;
    }
    switch (op)
    {
      case "ABS":
      case "CEIL":
      case "FLOOR":
      case "ROUND":
      case "TRUNCATE":
      case "SIGN":
      case "GREATEST":
      case "LEAST": return true;
      default: return false;
    }
  }

  private static boolean arithmetic(SqlKind kind)
  {
    switch (kind)
    {
      case PLUS:
      case MINUS:
      case TIMES:
      case DIVIDE:
      case MOD:
      case MINUS_PREFIX:
      case REINTERPRET: return true;
      default: return false;
    }
  }

  /**
   * The functions the encoding does not interpret but knows to be null exactly when an argument
   * is: arithmetic it does not read natively, and the handful sqleq-cvc5 lists.
   */
  private static boolean strictFunction(SqlKind kind, String op, RexCall call)
  {
    if (arithmetic(kind))
    {
      return true;
    }
    if (call.getOperator() instanceof SqlFunction
        && ((SqlFunction) call.getOperator()).getFunctionType() == SqlFunctionCategory.USER_DEFINED_FUNCTION)
    {
      return false;
    }
    switch (op)
    {
      case "UPPER":
      case "LOWER":
      case "ABS":
      case "SUBSTRING":
      case "TRIM_BOTH":
      case "TRIM_LEADING":
      case "TRIM_TRAILING":
      case "CARDINALITY":
      case "LIKE":
      case "NOT LIKE":
      case "||": return true;
      default: return false;
    }
  }

  /** The name of an uninterpreted symbol for {@code op} over its operands' types: {@code f(INTEGER)->VARCHAR}. */
  private static String typedSymbol(String op, List<RexNode> operand, RelDataType ty)
  {
    StringBuilder b = new StringBuilder(op).append('(');
    for (int i = 0; i < operand.size(); i++)
    {
      b.append(i == 0 ? "" : ",").append(typeName(operand.get(i).getType()));
    }
    return b.append(")->").append(typeName(ty)).toString();
  }

  /**
   * A function the encoding does not interpret but knows to be strict: null exactly when an
   * argument is, and otherwise an uninterpreted function of the argument values.
   */
  private Term strictFun(String op, RelDataType ty, List<RexNode> operand, Term[] args, Sort codomain)
      throws CVC5ApiException
  {
    Sort[] domain = new Sort[args.length];
    for (int i = 0; i < args.length; i++)
    {
      domain[i] = args[i].getSort().getNullableElementSort();
    }
    Term f = fun(typedSymbol(op, operand, ty), domain, codomain);
    if (args.length == 0)
    {
      return some(f);
    }
    return strict(args, v -> apply(f, v));
  }

  /**
   * Any other function: an uninterpreted function over the nullable sorts, so nothing is assumed
   * about how it treats NULL. A function the pair declares, and a parameter {@code qp_N()}, lands
   * here, since a parameter may be bound to NULL.
   */
  private Term opaqueFun(String op, RelDataType ty, List<RexNode> operand, Term[] args, Sort codomain)
  {
    Sort[] domain = new Sort[args.length];
    for (int i = 0; i < args.length; i++)
    {
      domain[i] = args[i].getSort();
    }
    Term f = fun("opaque:" + typedSymbol(op, operand, ty), domain, tm.mkNullableSort(codomain));
    if (args.length == 0 && op.startsWith("qp_"))
    {
      parameters.add(f);
    }
    return apply(f, args);
  }

  // ── Subqueries ──────────────────────────────────────────────────────────────────────────────

  /**
   * A subquery over {@code row}: the correlation variables it reads that no enclosing subquery
   * has bound are this row's, and its own lambdas are named apart from it.
   */
  private Term subquery(RexSubQuery sq, Row row) throws CVC5ApiException
  {
    List<CorrelationId> bound = new ArrayList<>();
    for (Map.Entry<CorrelationId, RelDataType> e : freeCorrelations(sq.rel).entrySet())
    {
      if (outer.containsKey(e.getKey()))
      {
        continue;
      }
      if (!rowSort(e.getValue()).equals(row.var.getSort()))
      {
        throw new UnsupportedOperationException("correlated: " + e.getKey() + " is not the enclosing row");
      }
      outer.put(e.getKey(), row);
      bound.add(e.getKey());
    }
    depth++;
    Term inner;
    try
    {
      inner = rel(sq.rel);
    }
    finally
    {
      depth--;
      for (CorrelationId id : bound)
      {
        outer.remove(id);
      }
    }
    switch (sq.getKind())
    {
      case EXISTS: return some(not(isEmpty(inner)));
      case IN: return inSubquery(sq.getOperands(), inner, sq.rel, row);
      case SCALAR_QUERY:
      {
        Sort[] sorts = columnSorts(inner);
        if (sorts.length != 1)
        {
          throw new UnsupportedOperationException("scalar-subquery-arity: " + sq);
        }
        // At most one row, or Postgres raises an error: the database is one on which the query
        // runs at all.
        Term atMostOne = tm.mkTerm(Kind.LEQ, tm.mkTerm(getCardKind(), inner), tm.mkInteger(1));
        constrain("a scalar subquery returns at most one row", atMostOne);
        if (!isSetSemantics())
        {
          // The column of the row, or NULL where there is none: a fold that keeps the value of
          // the row it reads, seeded with NULL, as SINGLE_VALUE folds its group.
          Term x = var(elemOf(inner), "x");
          Term acc = var(sorts[0], "acc");
          Term f = lambda(new Term[] {x, acc}, select(x, 0));
          return tm.mkTerm(Kind.BAG_FOLD, f, tm.mkNullableNull(sorts[0]), inner);
        }
        Term value = select(tm.mkTerm(getChooseKind(), inner), 0);
        return ite(isEmpty(inner), tm.mkNullableNull(sorts[0]), value);
      }
      default: throw new UnsupportedOperationException("subquery:" + sq.getKind());
    }
  }

  /** The correlation variables {@code rel} reads and does not bind itself, with their row types. */
  private static Map<CorrelationId, RelDataType> freeCorrelations(RelNode rel)
  {
    Map<CorrelationId, RelDataType> found = new LinkedHashMap<>();
    rel.accept(new RexShuttle()
    {
      @Override
      public RexNode visitCorrelVariable(RexCorrelVariable variable)
      {
        found.put(variable.id, variable.getType());
        return variable;
      }

      @Override
      public RexNode visitSubQuery(RexSubQuery subQuery)
      {
        found.putAll(freeCorrelations(subQuery.rel));
        return super.visitSubQuery(subQuery);
      }
    });
    for (RelNode input : rel.getInputs())
    {
      found.putAll(freeCorrelations(input));
    }
    for (CorrelationId id : rel.getVariablesSet())
    {
      found.remove(id);
    }
    return found;
  }

  /** Whether {@code e}, read over {@code row}, is never NULL: a column known not to be, a literal. */
  private static boolean operandNeverNull(RexNode e, Row row)
  {
    if (e instanceof RexInputRef)
    {
      return row.neverNull(((RexInputRef) e).getIndex());
    }
    return e instanceof RexLiteral && ((RexLiteral) e).getValue() != null;
  }

  /**
   * {@code l IN (subquery)}: TRUE iff some row equals the operand; else UNKNOWN iff some row might
   * -- the operand is null and the subquery has a row, or a row of the subquery is null -- else
   * FALSE. The reading that makes {@code NOT IN} reject every row once the subquery holds a null.
   */
  private Term inSubquery(List<RexNode> operand, Term inner, RelNode query, Row row) throws CVC5ApiException
  {
    Sort[] sorts = columnSorts(inner);
    if (sorts.length != operand.size())
    {
      throw new UnsupportedOperationException("IN operand arity does not match subquery width");
    }
    if (operand.size() != 1)
    {
      return inSubqueryTuple(operand, inner, query, row);
    }
    Term l = asSort(expr(operand.get(0), row), sorts[0]);
    Term tuple = tm.mkTuple(new Term[] {l});
    if (operandNeverNull(operand.get(0), row) && neverNull(query, 0))
    {
      // Neither the operand nor a row of the subquery is NULL: IN is TRUE or FALSE.
      return some(member(tuple, inner));
    }
    // A NULL operand equals no row, not even a NULL one: `NULL IN (SELECT NULL)` is UNKNOWN.
    Term matches = and(not(isNull(l)), member(tuple, inner));
    Term innerHasNull = member(tm.mkTuple(new Term[] {tm.mkNullableNull(sorts[0])}), inner);
    Term possible = or(and(isNull(l), not(isEmpty(inner))), innerHasNull);
    Term someTrue = some(tm.mkTrue());
    Term rest = ite(possible, tm.mkNullableNull(someTrue.getSort()), some(tm.mkFalse()));
    return ite(matches, someTrue, rest);
  }

  /**
   * {@code (l1, .., ln) IN (subquery)}: TRUE iff some row equals the operand column by column with
   * no NULL; UNKNOWN iff not, but some row might -- every column equal or one of the pair NULL;
   * FALSE otherwise. Where neither side can be NULL it is plain membership.
   */
  private Term inSubqueryTuple(List<RexNode> operand, Term inner, RelNode query, Row row) throws CVC5ApiException
  {
    Sort[] sorts = columnSorts(inner);
    Term[] ls = new Term[operand.size()];
    boolean never = true;
    for (int c = 0; c < ls.length; c++)
    {
      ls[c] = asSort(expr(operand.get(c), row), sorts[c]);
      never &= operandNeverNull(operand.get(c), row) && neverNull(query, c);
    }
    Term member = member(tm.mkTuple(ls), inner);
    if (never)
    {
      return some(member);
    }
    List<Term> somes = new ArrayList<>();
    for (Term l : ls)
    {
      somes.add(not(isNull(l)));
    }
    Term matches = and(and(somes), member);
    // rows that might match
    depth++;
    Term w = var(elemOf(inner), "w");
    depth--;
    List<Term> cols = new ArrayList<>();
    for (int k = 0; k < ls.length; k++)
    {
      Term c = select(w, k);
      cols.add(or(isNull(ls[k]), isNull(c), tm.mkTerm(Kind.EQUAL, ls[k], c)));
    }
    Term maybe = tm.mkTerm(getFilterKind(), lambda(new Term[] {w}, and(cols)), inner);
    Term possible = not(isEmpty(maybe));
    Term someTrue = some(tm.mkTrue());
    Term rest = ite(possible, tm.mkNullableNull(someTrue.getSort()), some(tm.mkFalse()));
    return ite(matches, someTrue, rest);
  }

  // ── What is known of a plan's columns ───────────────────────────────────────────────────────

  /** Per column of {@code rel}, whether it is never NULL ({@link #neverNull}). */
  private static boolean[] neverNullColumns(RelNode rel)
  {
    boolean[] r = new boolean[rel.getRowType().getFieldCount()];
    for (int c = 0; c < r.length; c++)
    {
      r[c] = neverNull(rel, c);
    }
    return r;
  }

  /**
   * Whether column {@code c} of {@code rel} is never NULL: a NOT NULL column of a table, carried
   * through the operators that copy it (not the padded side of an outer join), a literal other
   * than NULL, or a {@code COUNT}. Conservative: anything else may be.
   */
  private static boolean neverNull(RelNode rel, int c)
  {
    if (rel instanceof TableScan)
    {
      List<RelDataTypeField> fields = rel.getRowType().getFieldList();
      return c < fields.size() && !fields.get(c).getType().isNullable();
    }
    if (rel instanceof LogicalFilter || rel instanceof LogicalSort)
    {
      return neverNull(rel.getInput(0), c);
    }
    if (rel instanceof LogicalProject)
    {
      List<RexNode> exprs = ((LogicalProject) rel).getProjects();
      return c < exprs.size() && exprNeverNull(exprs.get(c), rel.getInput(0));
    }
    if (rel instanceof LogicalJoin)
    {
      LogicalJoin join = (LogicalJoin) rel;
      int w = join.getLeft().getRowType().getFieldCount();
      JoinRelType kind = join.getJoinType();
      if (c < w)
      {
        return (kind == JoinRelType.INNER || kind == JoinRelType.LEFT) && neverNull(join.getLeft(), c);
      }
      return (kind == JoinRelType.INNER || kind == JoinRelType.RIGHT) && neverNull(join.getRight(), c - w);
    }
    if (rel instanceof LogicalAggregate)
    {
      LogicalAggregate aggregate = (LogicalAggregate) rel;
      int[] keys = aggregate.getGroupSet().toArray();
      if (c < keys.length)
      {
        // a grouping set that leaves the column out makes it NULL
        for (org.apache.calcite.util.ImmutableBitSet set : aggregate.getGroupSets())
        {
          if (!set.get(keys[c]))
          {
            return false;
          }
        }
        return neverNull(aggregate.getInput(), keys[c]);
      }
      List<AggregateCall> calls = aggregate.getAggCallList();
      return c - keys.length < calls.size() && (calls.get(c - keys.length).getAggregation().getKind() == SqlKind.COUNT
          || isGrouping(calls.get(c - keys.length)));
    }
    if (rel instanceof LogicalValues)
    {
      for (List<RexLiteral> tuple : ((LogicalValues) rel).getTuples())
      {
        if (c >= tuple.size() || tuple.get(c).getValue() == null)
        {
          return false;
        }
      }
      return true;
    }
    if (rel instanceof LogicalUnion || rel instanceof LogicalIntersect)
    {
      for (RelNode input : rel.getInputs())
      {
        if (!neverNull(input, c))
        {
          return false;
        }
      }
      return true;
    }
    if (rel instanceof LogicalMinus)
    {
      return neverNull(rel.getInput(0), c);
    }
    return false;
  }

  private static boolean exprNeverNull(RexNode e, RelNode source)
  {
    if (e instanceof RexInputRef)
    {
      return neverNull(source, ((RexInputRef) e).getIndex());
    }
    if (e instanceof RexLiteral)
    {
      return ((RexLiteral) e).getValue() != null;
    }
    if (e instanceof RexCall && e.getKind() == SqlKind.CAST)
    {
      return exprNeverNull(((RexCall) e).getOperands().get(0), source);
    }
    // `CASE WHEN TRUE THEN x ..`
    if (e instanceof RexCall && e.getKind() == SqlKind.CASE)
    {
      List<RexNode> operands = ((RexCall) e).getOperands();
      return operands.size() >= 3 && operands.size() % 2 == 1 && operands.get(0).isAlwaysTrue()
          && exprNeverNull(operands.get(1), source);
    }
    return false;
  }

  /**
   * Keys of {@code rel}'s rows, as sets of its columns no two rows agree on: a table's declared
   * keys, kept by filters and sorts and by a projection that copies their columns, and the keys of
   * a {@code GROUP BY} (every column, after duplicate removal). Conservative: anything else has
   * none known.
   */
  private static List<List<Integer>> relationKeys(RelNode rel)
  {
    List<List<Integer>> keys = new ArrayList<>();
    if (rel instanceof TableScan)
    {
      TableDef definition = rel.getTable().unwrap(TableDef.class);
      if (definition != null)
      {
        for (List<String> key : definition.keys())
        {
          int[] ordinals = ordinals(definition, key);
          if (ordinals != null)
          {
            keys.add(Arrays.stream(ordinals).boxed().collect(java.util.stream.Collectors.toList()));
          }
        }
      }
    }
    else if (rel instanceof LogicalFilter || rel instanceof LogicalSort)
    {
      keys.addAll(relationKeys(rel.getInput(0)));
    }
    else if (rel instanceof LogicalProject)
    {
      List<RexNode> target = ((LogicalProject) rel).getProjects();
      for (List<Integer> key : relationKeys(rel.getInput(0)))
      {
        List<Integer> cols = new ArrayList<>();
        for (int c : key)
        {
          for (int p = 0; p < target.size(); p++)
          {
            if (target.get(p) instanceof RexInputRef && ((RexInputRef) target.get(p)).getIndex() == c)
            {
              cols.add(p);
              break;
            }
          }
        }
        if (cols.size() == key.size())
        {
          keys.add(cols);
        }
      }
    }
    else if (rel instanceof LogicalAggregate)
    {
      int n = ((LogicalAggregate) rel).getGroupCount();
      if (n > 0 && ((LogicalAggregate) rel).getGroupSets().size() == 1)
      {
        List<Integer> key = new ArrayList<>();
        for (int i = 0; i < n; i++)
        {
          key.add(i);
        }
        keys.add(key);
      }
    }
    return keys;
  }

  /**
   * Whether column {@code c} of {@code rel} is NULL in every row: a NULL literal (or a cast of
   * one) in a VALUES or a projection, carried through the operators that copy it. Conservative.
   */
  private static boolean alwaysNull(RelNode rel, int c)
  {
    if (rel instanceof LogicalValues)
    {
      for (List<RexLiteral> tuple : ((LogicalValues) rel).getTuples())
      {
        if (c >= tuple.size() || tuple.get(c).getValue() != null)
        {
          return false;
        }
      }
      return true;
    }
    if (rel instanceof LogicalFilter || rel instanceof LogicalSort || rel instanceof LogicalMinus)
    {
      return alwaysNull(rel.getInput(0), c);
    }
    if (rel instanceof LogicalProject)
    {
      List<RexNode> target = ((LogicalProject) rel).getProjects();
      if (c >= target.size())
      {
        return false;
      }
      RexNode e = target.get(c);
      if (e instanceof RexInputRef)
      {
        return alwaysNull(rel.getInput(0), ((RexInputRef) e).getIndex());
      }
      return nullLiteral(e);
    }
    if (rel instanceof LogicalJoin)
    {
      LogicalJoin join = (LogicalJoin) rel;
      int w = join.getLeft().getRowType().getFieldCount();
      return c < w ? alwaysNull(join.getLeft(), c) : alwaysNull(join.getRight(), c - w);
    }
    if (rel instanceof LogicalUnion || rel instanceof LogicalIntersect)
    {
      for (RelNode input : rel.getInputs())
      {
        if (!alwaysNull(input, c))
        {
          return false;
        }
      }
      return true;
    }
    if (rel instanceof LogicalAggregate)
    {
      int[] keys = ((LogicalAggregate) rel).getGroupSet().toArray();
      return c < keys.length && alwaysNull(rel.getInput(0), keys[c]);
    }
    return false;
  }

  private static boolean nullLiteral(RexNode e)
  {
    if (e instanceof RexLiteral)
    {
      return ((RexLiteral) e).getValue() == null;
    }
    return e instanceof RexCall && e.getKind() == SqlKind.CAST && nullLiteral(((RexCall) e).getOperands().get(0));
  }

  // ── Models ──────────────────────────────────────────────────────────────────────────────────

  protected List<Object> getTupleValues(Term tuple)
  {
    List<Object> tupleValues = new ArrayList<>();
    for (Term field : tuple.getTupleValue())
    {
      if (field.getSort().isNullable())
      {
        if (!solver.simplify(tm.mkNullableIsSome(field)).getBooleanValue())
        {
          tupleValues.add(null);
          continue;
        }
        field = solver.simplify(tm.mkNullableVal(field));
      }
      tupleValues.add(getFieldValue(field));
    }
    return tupleValues;
  }

  private static Object getFieldValue(Term field)
  {
    try
    {
      if (field.isIntegerValue())
      {
        return field.getIntegerValue();
      }
      if (field.isStringValue())
      {
        return field.getStringValue();
      }
      if (field.isBooleanValue())
      {
        return field.getBooleanValue();
      }
      if (field.isRealValue())
      {
        return field.getRealValue();
      }
    }
    catch (CVC5ApiException e)
    {
      throw new RuntimeException(e);
    }
    return field.toString();
  }

  /**
   * Hands the model to a real SQL engine and prints what it says: a counterexample the engine
   * cannot reproduce means an encoding does not mean what its query means.
   *
   * @param n1 either plan, read only for how many columns the queries return
   */
  private void replayCounterexample(String name, RelNode n1, String sql1, String sql2)
      throws CVC5ApiException
  {
    List<CounterexampleDatabase.Table> counterexample = new ArrayList<>();
    for (Map.Entry<String, Term> entry : tables.entrySet())
    {
      TableScan scan = scans.get(entry.getKey());
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
}
