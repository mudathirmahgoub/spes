package sqleq.input;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import sqleq.input.PgLexer.Kind;
import sqleq.input.PgLexer.Token;

/**
 * Spelling rewrites from PostgreSQL to the SQL Calcite's parsers read, each meaning-preserving:
 * {@code x::t} becomes {@code CAST(x AS T)}, a Postgres type name in a cast becomes Calcite's
 * ({@code text} to {@code VARCHAR}, {@code int8} to {@code BIGINT}, …), and
 * {@code INTERVAL '1 day'} becomes {@code INTERVAL '1' DAY}. A cast to a type Calcite has no name
 * for (uuid, jsonb, an array, an interval) is refused rather than approximated.
 */
public final class Rewrites {
  private static final Set<String> RESERVED = new HashSet<String>(Arrays.asList(
      "AND", "OR", "NOT", "IN", "ON", "WHEN", "THEN", "ELSE", "SELECT", "FROM", "WHERE", "BY", "AS", "IS", "LIKE",
      "ILIKE", "BETWEEN", "EXISTS", "ANY", "ALL", "SOME", "VALUES", "UNION", "EXCEPT", "INTERSECT", "HAVING", "JOIN",
      "USING", "CASE", "END", "DISTINCT", "OVER", "FILTER", "WITHIN", "GROUP", "ORDER", "LIMIT", "OFFSET"));
  private static final Set<String> TYPE_TAIL = new HashSet<String>(Arrays.asList(
      "PRECISION", "VARYING", "WITH", "WITHOUT", "TIME", "ZONE"));
  private static final Set<String> INTERVAL_TAIL = new HashSet<String>(Arrays.asList(
      "YEAR", "MONTH", "DAY", "HOUR", "MINUTE", "SECOND", "TO"));
  private static final Pattern SIMPLE_INTERVAL = Pattern.compile(
      "(?i)^'\\s*([+-]?\\d+)\\s*(year|month|day|hour|minute|second|week)s?\\s*'$");

  private Rewrites() {}

  public static String rewrite(String sql) throws Unsupported {
    for (int round = 0; round < 64; round++) {
      List<Token> t = PgLexer.lex(sql);
      int at = indexOfOp(t, "::");
      if (at >= 0) {
        sql = rewriteDoubleColon(sql, t, at);
        continue;
      }
      int cast = indexOfPgCast(t);
      if (cast >= 0) {
        sql = rewriteCast(sql, t, cast);
        continue;
      }
      int interval = indexOfPgInterval(t);
      if (interval >= 0) {
        sql = rewriteInterval(sql, t, interval);
        continue;
      }
      return sql;
    }
    throw new Unsupported("rewrite did not converge");
  }

  private static int indexOfOp(List<Token> t, String op) {
    for (int i = 0; i < t.size(); i++) {
      if (t.get(i).isOp(op)) {
        return i;
      }
    }
    return -1;
  }

  private static String rewriteDoubleColon(String sql, List<Token> t, int i) throws Unsupported {
    if (i == 0 || i + 1 >= t.size()) {
      throw new Unsupported("dangling ::");
    }
    Token prev = t.get(i - 1);
    int a;
    if (prev.kind == Kind.RPAREN) {
      a = PgLexer.matchingBack(t, i - 1);
      if (a < 0) {
        throw new Unsupported("unbalanced parentheses before ::");
      }
      if (a > 0 && t.get(a - 1).kind == Kind.WORD && !RESERVED.contains(t.get(a - 1).upper())) {
        a--;
      }
    } else if (prev.isWord("END")) {
      int nest = 0;
      a = -1;
      for (int j = i - 1; j >= 0; j--) {
        if (t.get(j).isWord("END")) {
          nest++;
        } else if (t.get(j).isWord("CASE")) {
          nest--;
          if (nest == 0) {
            a = j;
            break;
          }
        }
      }
      if (a < 0) {
        throw new Unsupported("CASE ... END before :: without a CASE");
      }
    } else if (prev.kind == Kind.WORD || prev.kind == Kind.QUOTED || prev.kind == Kind.STRING || prev.kind == Kind.NUMBER
        || prev.kind == Kind.PARAM) {
      a = i - 1;
      while (a >= 2 && t.get(a - 1).kind == Kind.DOT && t.get(a - 2).isIdent()) {
        a -= 2;
      }
    } else {
      throw new Unsupported("cast operand ending in " + prev.text);
    }
    int b = i + 1;
    StringBuilder type = new StringBuilder();
    if (t.get(b).kind != Kind.WORD) {
      throw new Unsupported("cast to " + t.get(b).text);
    }
    type.append(t.get(b).text);
    boolean interval = t.get(b).isWord("INTERVAL");
    b++;
    while (b < t.size() && t.get(b).kind == Kind.WORD
        && (TYPE_TAIL.contains(t.get(b).upper()) || (interval && INTERVAL_TAIL.contains(t.get(b).upper())))) {
      type.append(' ').append(t.get(b).text);
      b++;
    }
    if (b < t.size() && t.get(b).kind == Kind.LPAREN) {
      int close = PgLexer.matching(t, b);
      if (close < 0) {
        throw new Unsupported("unbalanced parentheses in a cast type");
      }
      type.append(PgLexer.join(t, b, close + 1));
      b = close + 1;
    }
    if (b < t.size() && t.get(b).kind == Kind.OTHER && t.get(b).text.equals("[")) {
      throw new Unsupported("cast to an array type");
    }
    String mapped = castType(type.toString());
    String operand = sql.substring(t.get(a).start, t.get(i - 1).end);
    return sql.substring(0, t.get(a).start) + "CAST(" + operand + " AS " + mapped + ")" + sql.substring(t.get(b - 1).end);
  }

  private static int indexOfPgCast(List<Token> t) {
    for (int i = 0; i + 1 < t.size(); i++) {
      if (!t.get(i).isWord("CAST") || t.get(i + 1).kind != Kind.LPAREN) {
        continue;
      }
      int close = PgLexer.matching(t, i + 1);
      if (close < 0) {
        continue;
      }
      int as = -1;
      int depth = 0;
      for (int j = i + 2; j < close; j++) {
        Kind k = t.get(j).kind;
        if (k == Kind.LPAREN) {
          depth++;
        } else if (k == Kind.RPAREN) {
          depth--;
        } else if (depth == 0 && t.get(j).isWord("AS")) {
          as = j;
        }
      }
      if (as < 0) {
        continue;
      }
      String written = PgLexer.join(t, as + 1, close);
      try {
        String mapped = castType(written);
        if (!mapped.replaceAll("\\s", "").equalsIgnoreCase(written.replaceAll("\\s", ""))) {
          return i;
        }
      } catch (Unsupported e) {
        // Calcite will refuse this cast itself; leave it as written
      }
    }
    return -1;
  }

  private static String rewriteCast(String sql, List<Token> t, int i) throws Unsupported {
    int close = PgLexer.matching(t, i + 1);
    int as = -1;
    int depth = 0;
    for (int j = i + 2; j < close; j++) {
      Kind k = t.get(j).kind;
      if (k == Kind.LPAREN) {
        depth++;
      } else if (k == Kind.RPAREN) {
        depth--;
      } else if (depth == 0 && t.get(j).isWord("AS")) {
        as = j;
      }
    }
    String mapped = castType(PgLexer.join(t, as + 1, close));
    return sql.substring(0, t.get(as + 1).start) + mapped + sql.substring(t.get(close - 1).end);
  }

  /** Calcite's spelling of a Postgres type name in a cast; refused where Calcite has none. */
  static String castType(String written) throws Unsupported {
    String low = written.trim().toLowerCase(Locale.ROOT).replaceAll("\\s+", " ");
    String args = "";
    int p = low.indexOf('(');
    if (p >= 0) {
      int q = low.indexOf(')', p);
      if (q < 0) {
        throw new Unsupported("cast to " + written);
      }
      args = low.substring(p, q + 1).replaceAll("\\s+", "");
      low = (low.substring(0, p) + low.substring(q + 1)).replaceAll("\\s+", " ").trim();
    }
    if (low.indexOf('[') >= 0 || low.endsWith(" array")) {
      throw new Unsupported("cast to an array type");
    }
    low = low.replace(" without time zone", "").replace(" with time zone", "").replace(" with local time zone", "").trim();
    if (low.equals("int") || low.equals("integer") || low.equals("int4") || low.equals("smallint") || low.equals("int2")) {
      return "INTEGER";
    }
    if (low.equals("bigint") || low.equals("int8")) {
      return "BIGINT";
    }
    if (low.equals("numeric") || low.equals("decimal") || low.equals("dec")) {
      return "DECIMAL" + args.toUpperCase(Locale.ROOT);
    }
    if (low.equals("real") || low.equals("float4")) {
      return "REAL";
    }
    if (low.equals("double precision") || low.equals("float8") || low.equals("float") || low.equals("double")) {
      return "DOUBLE";
    }
    if (low.equals("boolean") || low.equals("bool")) {
      return "BOOLEAN";
    }
    if (low.equals("text") || low.equals("varchar") || low.equals("character varying") || low.equals("citext")) {
      return "VARCHAR" + args.toUpperCase(Locale.ROOT);
    }
    if (low.equals("char") || low.equals("character") || low.equals("bpchar")) {
      throw new Unsupported("cast to " + written.trim() + ": Postgres compares char(n) ignoring trailing blanks");
    }
    if (low.equals("date")) {
      return "DATE";
    }
    if (low.equals("time") || low.equals("timetz")) {
      return "TIME" + args.toUpperCase(Locale.ROOT);
    }
    if (low.equals("timestamp") || low.equals("timestamptz")) {
      return "TIMESTAMP" + args.toUpperCase(Locale.ROOT);
    }
    if (low.equals("bytea") || low.equals("varbinary")) {
      return "VARBINARY";
    }
    throw new Unsupported("cast to " + written.trim());
  }

  private static int indexOfPgInterval(List<Token> t) {
    for (int i = 0; i + 1 < t.size(); i++) {
      if (t.get(i).isWord("INTERVAL") && t.get(i + 1).kind == Kind.STRING
          && SIMPLE_INTERVAL.matcher(t.get(i + 1).text).matches()) {
        return i;
      }
    }
    return -1;
  }

  private static String rewriteInterval(String sql, List<Token> t, int i) {
    Matcher m = SIMPLE_INTERVAL.matcher(t.get(i + 1).text);
    m.matches();
    long n = Long.parseLong(m.group(1));
    String unit = m.group(2).toUpperCase(Locale.ROOT);
    if (unit.equals("WEEK")) {
      n *= 7;
      unit = "DAY";
    }
    return sql.substring(0, t.get(i).start) + "INTERVAL '" + n + "' " + unit + sql.substring(t.get(i + 1).end);
  }
}
