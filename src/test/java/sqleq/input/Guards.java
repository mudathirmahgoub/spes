package sqleq.input;

import java.util.List;

import sqleq.input.PgLexer.Kind;
import sqleq.input.PgLexer.Token;

/**
 * Shapes Calcite plans without the meaning Postgres gives them. Both provers read Calcite's plan,
 * so on these a pair would be decided about a different query than the one in the file. Each is
 * refused here, with the reason.
 */
public final class Guards {
  private Guards() {}

  private static final java.util.Set<String> ORDER_SENSITIVE = new java.util.HashSet<String>(java.util.Arrays.asList(
      "ARRAY_AGG", "STRING_AGG", "JSON_AGG", "JSONB_AGG", "JSON_OBJECT_AGG", "JSONB_OBJECT_AGG", "XMLAGG", "OVER",
      "LIMIT", "FETCH", "OFFSET", "FIRST_VALUE", "LAST_VALUE", "NTH_VALUE", "LAG", "LEAD", "ROW_NUMBER", "RANK",
      "DENSE_RANK", "NTILE", "PERCENTILE_CONT", "PERCENTILE_DISC", "MODE"));
  private static final java.util.Set<String> REPRESENTATIVE = new java.util.HashSet<String>(java.util.Arrays.asList(
      "DISTINCT", "GROUP", "UNION", "INTERSECT", "EXCEPT", "MIN", "MAX", "SUM", "AVG"));

  public static void check(String sql) throws Unsupported {
    check(sql, null);
  }

  /**
   * @param cat the catalog, which decides whether a value's spelling can be seen: with a numeric,
   *     float, interval or opaque column, or a collation, DISTINCT, GROUP BY, a set operation and
   *     MIN/MAX/SUM/AVG pick one spelling among equal values, and so see the order they arrive in
   */
  public static void check(String sql, Catalog cat) throws Unsupported {
    List<Token> t = PgLexer.lex(sql);
    boolean outerJoin = false;
    boolean using = false;
    boolean orderSensitive = false;
    boolean representative = false;
    boolean spellings = false;
    if (cat != null) {
      for (Catalog.Table table : cat.tables()) {
        for (Catalog.Column c : table.columns) {
          if (c.type == Catalog.Type.DECIMAL || c.type == Catalog.Type.DOUBLE || c.type == Catalog.Type.INTERVAL
              || c.type == Catalog.Type.OPAQUE || c.type == Catalog.Type.BINARY) {
            spellings = true;
          }
        }
      }
    }
    for (Token k : t) {
      if (k.kind == Kind.WORD) {
        String w = k.upper();
        if (ORDER_SENSITIVE.contains(w)) {
          orderSensitive = true;
        }
        if (REPRESENTATIVE.contains(w)) {
          representative = true;
        }
        if (w.equals("COLLATE")) {
          spellings = true;
        }
      }
    }
    boolean seesOrder = orderSensitive || (representative && spellings) || cat == null;
    for (int i = 0; i < t.size(); i++) {
      Token k = t.get(i);
      if (k.isWord("TABLESAMPLE")) {
        throw new Unsupported("TABLESAMPLE, which Calcite's planner drops");
      }
      if (k.kind == Kind.NUMBER && (k.text.indexOf('_') >= 0 || k.text.matches("0[bBoOxX].*"))) {
        throw new Unsupported("numeric literal " + k.text + ", which Calcite reads as a number followed by an alias");
      }
      if (k.isWord("FROM")) {
        fromList(t, i + 1);
      }
      if (k.isWord("LEFT") || k.isWord("RIGHT") || k.isWord("FULL")) {
        outerJoin = true;
      }
      if (k.isWord("USING") && i + 1 < t.size() && t.get(i + 1).kind == Kind.LPAREN) {
        using = true;
      }
      if (k.kind == Kind.LPAREN && i + 1 < t.size()
          && (t.get(i + 1).isWord("SELECT") || t.get(i + 1).isWord("WITH") || t.get(i + 1).isWord("VALUES") || t.get(i + 1).isWord("TABLE"))) {
        int close = PgLexer.matching(t, i);
        if (close > 0 && seesOrder) {
          subquery(t, i + 1, close);
        }
      }
    }
    if (outerJoin && using) {
      throw new Unsupported("JOIN ... USING under an outer join: Calcite reads the merged column differently from Postgres");
    }
  }

  /** A FROM list that mixes comma-separated items with explicit JOINs: Postgres binds the JOINs first, Calcite does not always. */
  private static void fromList(List<Token> t, int from) throws Unsupported {
    boolean comma = false;
    boolean join = false;
    int depth = 0;
    for (int i = from; i < t.size(); i++) {
      Token k = t.get(i);
      if (k.kind == Kind.LPAREN) {
        depth++;
      } else if (k.kind == Kind.RPAREN) {
        depth--;
        if (depth < 0) {
          break;
        }
      } else if (depth == 0) {
        if (k.isWord("WHERE") || k.isWord("GROUP") || k.isWord("HAVING") || k.isWord("ORDER") || k.isWord("LIMIT")
            || k.isWord("OFFSET") || k.isWord("FETCH") || k.isWord("UNION") || k.isWord("EXCEPT") || k.isWord("INTERSECT")
            || k.isWord("WINDOW") || k.isWord("FOR") || k.isWord("RETURNING")) {
          break;
        }
        if (k.kind == Kind.COMMA) {
          comma = true;
        } else if (k.isWord("JOIN")) {
          join = true;
        }
      }
    }
    if (comma && join) {
      throw new Unsupported("a FROM list mixing comma-separated items with JOIN: Calcite groups them differently from Postgres");
    }
  }

  /** A parenthesised query whose {@code ORDER BY} has no {@code LIMIT}, {@code OFFSET} or {@code FETCH} to give it meaning. */
  private static void subquery(List<Token> t, int from, int to) throws Unsupported {
    boolean orderBy = false;
    boolean slice = false;
    int depth = 0;
    for (int i = from; i < to; i++) {
      Kind k = t.get(i).kind;
      if (k == Kind.LPAREN) {
        depth++;
      } else if (k == Kind.RPAREN) {
        depth--;
      } else if (depth == 0) {
        if (t.get(i).isWord("ORDER") && i + 1 < to && t.get(i + 1).isWord("BY")) {
          orderBy = true;
        }
        if (t.get(i).isWord("LIMIT") || t.get(i).isWord("OFFSET") || t.get(i).isWord("FETCH")) {
          slice = true;
        }
      }
    }
    if (orderBy && !slice) {
      throw new Unsupported("ORDER BY inside a subquery without LIMIT, which Calcite drops, under a construct that can see the order");
    }
  }
}
