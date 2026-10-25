package sqleq.input;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import org.apache.calcite.rel.RelNode;
import org.apache.calcite.rex.RexDynamicParam;
import org.apache.calcite.rex.RexNode;
import org.apache.calcite.rex.RexShuttle;
import org.apache.calcite.rex.RexSubQuery;
import org.apache.calcite.sql.type.SqlTypeName;

import sqleq.input.PgLexer.Kind;
import sqleq.input.PgLexer.Token;

/**
 * {@code $N} parameters.
 *
 * <p>A parameter has one value per execution, the same everywhere it appears and the same on both
 * sides of the pair. Calcite's own dynamic parameter {@code ?} cannot say that -- each {@code ?} is
 * its own value -- so a pair is checked with {@code $N} spelled as a call of a nullary function
 * {@code qp_N()}, one uninterpreted symbol shared by both sides. The function needs a declared
 * type, and that is what the {@code ?} spelling is for: the pair is planned once with every
 * {@code $N} as {@code ?}, the type Calcite infers for each occurrence is read off the plan, and the
 * occurrences of one {@code N} are unified -- to the wider type where they differ within a family,
 * refused where they do not agree on one.
 */
public final class ParamTypes {
  private static final Set<SqlTypeName> INTS = new HashSet<SqlTypeName>(Arrays.asList(
      SqlTypeName.TINYINT, SqlTypeName.SMALLINT, SqlTypeName.INTEGER, SqlTypeName.BIGINT));
  private static final Set<SqlTypeName> APPROX = new HashSet<SqlTypeName>(Arrays.asList(
      SqlTypeName.FLOAT, SqlTypeName.REAL, SqlTypeName.DOUBLE));
  private static final Set<SqlTypeName> CHARS = new HashSet<SqlTypeName>(Arrays.asList(
      SqlTypeName.CHAR, SqlTypeName.VARCHAR));

  private ParamTypes() {}

  public static boolean hasParams(String sql) throws Unsupported {
    for (Token t : PgLexer.lex(sql)) {
      if (t.kind == Kind.PARAM) {
        return true;
      }
    }
    return false;
  }

  /** The parameter indices a set of statements mention, ascending. */
  public static TreeSet<Integer> params(String... sqls) throws Unsupported {
    TreeSet<Integer> out = new TreeSet<Integer>();
    for (String sql : sqls) {
      for (Token t : PgLexer.lex(sql)) {
        if (t.kind == Kind.PARAM) {
          out.add(t.paramIndex());
        }
      }
    }
    return out;
  }

  /** The {@code N} of each {@code $N} in textual order, which is the order Calcite numbers {@code ?} in. */
  public static List<Integer> occurrences(String sql) throws Unsupported {
    List<Integer> out = new ArrayList<Integer>();
    for (Token t : PgLexer.lex(sql)) {
      if (t.kind == Kind.PARAM) {
        out.add(t.paramIndex());
      }
    }
    return out;
  }

  public static String withQuestionMarks(String sql) throws Unsupported {
    return substitute(sql, null);
  }

  /** {@code $N} spelled as {@code <prefix>N()}. */
  public static String withCalls(String sql, String prefix) throws Unsupported {
    return substitute(sql, prefix);
  }

  private static String substitute(String sql, String prefix) throws Unsupported {
    StringBuilder b = new StringBuilder();
    int at = 0;
    for (Token t : PgLexer.lex(sql)) {
      if (t.kind == Kind.PARAM) {
        b.append(sql, at, t.start);
        b.append(prefix == null ? "?" : prefix + t.paramIndex() + "()");
        at = t.end;
      }
    }
    b.append(sql.substring(at));
    return b.toString();
  }

  /** Records the type of every dynamic parameter in a plan, keyed by the {@code N} its occurrence stands for. */
  public static void collect(RelNode rel, final List<Integer> occurrences, final Map<Integer, List<SqlTypeName>> into)
      throws Unsupported {
    final List<Unsupported> failure = new ArrayList<Unsupported>();
    RexShuttle shuttle = new RexShuttle() {
      @Override
      public RexNode visitDynamicParam(RexDynamicParam p) {
        if (p.getIndex() >= occurrences.size()) {
          failure.add(new Unsupported("dynamic parameter " + p.getIndex() + " beyond the $N occurrences"));
          return p;
        }
        int n = occurrences.get(p.getIndex());
        List<SqlTypeName> types = into.get(n);
        if (types == null) {
          types = new ArrayList<SqlTypeName>();
          into.put(n, types);
        }
        types.add(p.getType().getSqlTypeName());
        return p;
      }

      @Override
      public RexNode visitSubQuery(RexSubQuery subQuery) {
        try {
          collect(subQuery.rel, occurrences, into);
        } catch (Unsupported e) {
          failure.add(e);
        }
        return super.visitSubQuery(subQuery);
      }
    };
    rel.accept(shuttle);
    for (RelNode input : rel.getInputs()) {
      collect(input, occurrences, into);
    }
    if (!failure.isEmpty()) {
      throw failure.get(0);
    }
  }

  /** One type per parameter from the types its occurrences were given. */
  public static Map<Integer, SqlTypeName> unify(Set<Integer> params, Map<Integer, List<SqlTypeName>> seen) throws Unsupported {
    Map<Integer, SqlTypeName> out = new LinkedHashMap<Integer, SqlTypeName>();
    for (Integer n : params) {
      List<SqlTypeName> types = seen.get(n);
      if (types == null || types.isEmpty()) {
        throw new Unsupported("$" + n + ": no type inferred (the parameter reaches no typed position)");
      }
      Set<SqlTypeName> s = new HashSet<SqlTypeName>(types);
      for (SqlTypeName t : s) {
        // UNKNOWN by name: the constant exists in recent Calcite only, and both Calcites are served here
        if (t == SqlTypeName.NULL || t == SqlTypeName.ANY || t.name().equals("UNKNOWN") || t == SqlTypeName.OTHER
            || t == SqlTypeName.ARRAY || t == SqlTypeName.MULTISET || t == SqlTypeName.ROW || t == SqlTypeName.SYMBOL) {
          throw new Unsupported("$" + n + ": untyped use (" + t + ")");
        }
      }
      out.put(n, widest(n, s));
    }
    return out;
  }

  private static SqlTypeName widest(int n, Set<SqlTypeName> s) throws Unsupported {
    if (INTS.containsAll(s)) {
      return s.contains(SqlTypeName.BIGINT) ? SqlTypeName.BIGINT : SqlTypeName.INTEGER;
    }
    Set<SqlTypeName> exact = new HashSet<SqlTypeName>(INTS);
    exact.add(SqlTypeName.DECIMAL);
    if (exact.containsAll(s)) {
      return SqlTypeName.DECIMAL;
    }
    Set<SqlTypeName> numeric = new HashSet<SqlTypeName>(exact);
    numeric.addAll(APPROX);
    if (numeric.containsAll(s)) {
      return SqlTypeName.DOUBLE;
    }
    if (CHARS.containsAll(s)) {
      return SqlTypeName.VARCHAR;
    }
    Set<SqlTypeName> timestamps = new HashSet<SqlTypeName>(Arrays.asList(
        SqlTypeName.TIMESTAMP, SqlTypeName.TIMESTAMP_WITH_LOCAL_TIME_ZONE));
    if (timestamps.containsAll(s)) {
      return SqlTypeName.TIMESTAMP;
    }
    if (s.size() == 1) {
      SqlTypeName t = s.iterator().next();
      if (t == SqlTypeName.BOOLEAN || t == SqlTypeName.DATE || t == SqlTypeName.TIME) {
        return t;
      }
      if (t == SqlTypeName.BINARY || t == SqlTypeName.VARBINARY) {
        return SqlTypeName.VARBINARY;
      }
      if (t.getFamily() != null && t.getFamily().toString().startsWith("INTERVAL")) {
        return t;
      }
    }
    throw new Unsupported("$" + n + ": conflicting types " + s);
  }
}
