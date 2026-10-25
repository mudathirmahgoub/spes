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

  public static void check(String sql) throws Unsupported {
    List<Token> t = PgLexer.lex(sql);
    boolean outerJoin = false;
    boolean using = false;
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
        if (close > 0) {
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
      throw new Unsupported("ORDER BY inside a subquery without LIMIT, which Calcite drops");
    }
  }
}
