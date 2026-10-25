package sqleq.input;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;

import sqleq.input.PgLexer.Kind;
import sqleq.input.PgLexer.Token;

/**
 * {@code DELETE}, {@code UPDATE} and {@code INSERT} pairs reduced to the pair of queries that
 * computes their effect, after sqleq's frontend ({@code src/dml.rs} there).
 *
 * <ul>
 *   <li>{@code DELETE FROM T WHERE P} becomes {@code SELECT * FROM T WHERE P}: the deleted bag.
 *       Bag subtraction is cancellative, so two deletes leave equal tables iff they delete equal
 *       bags; the reduction is an iff.
 *   <li>{@code UPDATE T SET c = e WHERE P} becomes a projection of every declared column of
 *       {@code T}, {@code CASE WHEN P THEN e ELSE c END} where assigned, {@code c} where not. Every
 *       column is projected, not only the assigned ones: the comparison is a bag comparison and
 *       dropping a column drops its pairing with the others. With {@code RETURNING} a second,
 *       tagged block holds the matched rows, because final-table equality does not fix them.
 *   <li>{@code INSERT INTO T (cols) S} becomes {@code S}, provided both sides list the same
 *       columns and every omitted column's default is a function of the row. Lists in different
 *       orders are brought to the declared order through a derived table.
 * </ul>
 *
 * <p>Where this port is narrower than the frontend, it refuses: {@code DELETE ... USING},
 * {@code UPDATE ... FROM} and {@code WITH} around a DML statement are not reduced. A value stored
 * into a column whose {@code =} is identity (text, char, json, …) must have its spelling fixed by
 * the statement -- a literal, a parameter, or a column of such a type -- since {@code 2.0} and
 * {@code 2.00} are one numeric and two strings.
 */
public final class Dml {
  public enum Kind { QUERY, DELETE, UPDATE, INSERT }

  public static final class Reduced {
    public final Kind kind;
    public final String q0;
    public final String q1;
    public final List<String> notes;

    Reduced(Kind kind, String q0, String q1, List<String> notes) {
      this.kind = kind;
      this.q0 = q0;
      this.q1 = q1;
      this.notes = notes;
    }
  }

  private static final Set<String> CLAUSE = new HashSet<String>(Arrays.asList(
      "USING", "WHERE", "SET", "RETURNING", "FROM", "VALUES", "SELECT", "WITH", "TABLE", "DEFAULT", "OVERRIDING", "ON"));

  private Dml() {}

  public static Kind kindOf(List<Token> t) throws Unsupported {
    if (t.isEmpty() || t.get(0).kind != PgLexer.Kind.WORD) {
      return Kind.QUERY;
    }
    String w = t.get(0).upper();
    if (w.equals("DELETE")) {
      return Kind.DELETE;
    }
    if (w.equals("UPDATE")) {
      return Kind.UPDATE;
    }
    if (w.equals("INSERT")) {
      return Kind.INSERT;
    }
    if (w.equals("WITH")) {
      int depth = 0;
      for (Token k : t) {
        if (k.kind == PgLexer.Kind.LPAREN) {
          depth++;
        } else if (k.kind == PgLexer.Kind.RPAREN) {
          depth--;
        } else if (depth == 0 && (k.isWord("DELETE") || k.isWord("UPDATE") || k.isWord("INSERT"))) {
          throw new Unsupported("WITH ... " + k.upper() + " (a DML statement under a WITH is not reduced here)");
        }
      }
    }
    return Kind.QUERY;
  }

  public static Reduced reduce(Catalog cat, String s0, String s1) throws Unsupported {
    List<Token> t0 = PgLexer.lex(s0);
    List<Token> t1 = PgLexer.lex(s1);
    Kind k0 = kindOf(t0);
    Kind k1 = kindOf(t1);
    if (k0 != k1) {
      throw new Unsupported("a " + k0 + " paired with a " + k1 + ": both sides must be the same kind of statement");
    }
    List<String> notes = new ArrayList<String>();
    switch (k0) {
      case QUERY:
        return new Reduced(Kind.QUERY, s0, s1, notes);
      case DELETE: {
        Head a = parseDelete(s0, t0);
        Head b = parseDelete(s1, t1);
        common(cat, a, b, "DELETE");
        sameReturning(a, b, "DELETE");
        notes.add("DELETE reduced to the deleted bag");
        return new Reduced(Kind.DELETE, deleteToSelect(a), deleteToSelect(b), notes);
      }
      case UPDATE: {
        Head a = parseUpdate(s0, t0);
        Head b = parseUpdate(s1, t1);
        common(cat, a, b, "UPDATE");
        boolean returning = sameReturning(a, b, "UPDATE");
        Catalog.Table t = declared(cat, a, "UPDATE");
        for (Head h : new Head[] {a, b}) {
          for (String[] set : h.sets) {
            Catalog.Column col = t.column(set[0]);
            if (col == null) {
              throw new Unsupported("UPDATE sets " + set[0] + ", which " + t.name + " does not declare");
            }
            if (col.storesSpelling()) {
              storeEvident(set[1], col, t, h, null, "UPDATE");
            }
          }
        }
        notes.add(returning ? "UPDATE reduced to the new table and the matched rows (two goals)" : "UPDATE reduced to the new table");
        return new Reduced(Kind.UPDATE, updateQuery(t, a, returning), updateQuery(t, b, returning), notes);
      }
      case INSERT: {
        Head a = parseInsert(s0, t0);
        Head b = parseInsert(s1, t1);
        common(cat, a, b, "INSERT");
        sameReturning(a, b, "INSERT");
        Catalog.Table t = declared(cat, a, "INSERT");
        String[] qs = insertPair(t, a, b);
        notes.add("INSERT reduced to the inserted bag");
        return new Reduced(Kind.INSERT, qs[0], qs[1], notes);
      }
      default:
        throw new IllegalStateException();
    }
  }

  // ---------------------------------------------------------------- the parsed head of a statement

  static final class Head {
    String source;
    List<Token> toks;
    String targetText;
    String tableName;
    String aliasText;
    String qual;
    String qualText;
    String where;
    String returning;
    List<String[]> sets = new ArrayList<String[]>();
    List<String> columns;
    List<String> columnsText;
    String sourceText;
    int sourceFrom;
    int sourceTo;
  }

  private static void parseTarget(Head h, Catalog.Cursor c, String kind) throws Unsupported {
    c.tryWord("ONLY");
    int s = c.i;
    List<String> id = c.ident();
    if (id == null) {
      throw new Unsupported(kind + " target is not a table name");
    }
    h.targetText = PgLexer.slice(h.source, h.toks, s, c.i);
    h.tableName = id.get(id.size() - 1);
    h.qualText = h.toks.get(c.i - 1).text;
    h.qual = h.tableName;
    if (c.has() && c.peek().isOp("*")) {
      c.next();
    }
    if (c.tryWord("AS")) {
      Token a = c.next();
      if (!a.isIdent()) {
        throw new Unsupported(kind + " alias is not an identifier");
      }
      alias(h, a);
    } else if (c.has() && c.peek().isIdent() && !CLAUSE.contains(c.peek().upper())) {
      alias(h, c.next());
    }
    if (!kind.equals("INSERT") && c.has() && c.peek().kind == PgLexer.Kind.LPAREN) {
      throw new Unsupported(kind + " alias with a column list");
    }
  }

  private static void alias(Head h, Token a) {
    h.aliasText = a.text;
    h.qual = a.name();
    h.qualText = a.text;
  }

  /** The first {@code word} at nesting depth 0 in {@code [from, size)}, or -1. */
  private static int findWord(List<Token> t, int from, String word) {
    int depth = 0;
    for (int i = from; i < t.size(); i++) {
      PgLexer.Kind k = t.get(i).kind;
      if (k == PgLexer.Kind.LPAREN) {
        depth++;
      } else if (k == PgLexer.Kind.RPAREN) {
        depth--;
      } else if (depth == 0 && t.get(i).isWord(word)) {
        return i;
      }
    }
    return -1;
  }

  private static int findWords(List<Token> t, int from, String first, String second) {
    int depth = 0;
    for (int i = from; i + 1 < t.size(); i++) {
      PgLexer.Kind k = t.get(i).kind;
      if (k == PgLexer.Kind.LPAREN) {
        depth++;
      } else if (k == PgLexer.Kind.RPAREN) {
        depth--;
      } else if (depth == 0 && t.get(i).isWord(first) && t.get(i + 1).isWord(second)) {
        return i;
      }
    }
    return -1;
  }

  private static Head parseDelete(String s, List<Token> t) throws Unsupported {
    Head h = new Head();
    h.source = s;
    h.toks = t;
    Catalog.Cursor c = new Catalog.Cursor(t, s);
    c.tryWord("DELETE");
    if (!c.tryWord("FROM")) {
      throw new Unsupported("DELETE without FROM");
    }
    parseTarget(h, c, "DELETE");
    if (findWord(t, c.i, "USING") >= 0) {
      throw new Unsupported("DELETE ... USING");
    }
    int end = t.size();
    int ret = findWord(t, c.i, "RETURNING");
    if (ret >= 0) {
      h.returning = PgLexer.slice(s, t, ret + 1, end);
      end = ret;
    }
    int where = findWord(t, c.i, "WHERE");
    if (where >= 0 && where < end) {
      h.where = PgLexer.slice(s, t, where + 1, end);
      if (where + 2 < end && t.get(where + 1).isWord("CURRENT") && t.get(where + 2).isWord("OF")) {
        throw new Unsupported("WHERE CURRENT OF");
      }
      end = where;
    }
    if (end != c.i) {
      throw new Unsupported("unexpected text in DELETE: " + PgLexer.slice(s, t, c.i, end));
    }
    return h;
  }

  private static Head parseUpdate(String s, List<Token> t) throws Unsupported {
    Head h = new Head();
    h.source = s;
    h.toks = t;
    Catalog.Cursor c = new Catalog.Cursor(t, s);
    c.tryWord("UPDATE");
    parseTarget(h, c, "UPDATE");
    if (!c.tryWord("SET")) {
      throw new Unsupported("UPDATE without SET");
    }
    if (findWord(t, c.i, "FROM") >= 0) {
      throw new Unsupported("UPDATE ... FROM");
    }
    int end = t.size();
    int ret = findWord(t, c.i, "RETURNING");
    if (ret >= 0) {
      h.returning = PgLexer.slice(s, t, ret + 1, end);
      end = ret;
    }
    int where = findWord(t, c.i, "WHERE");
    if (where >= 0 && where < end) {
      h.where = PgLexer.slice(s, t, where + 1, end);
      if (where + 2 < end && t.get(where + 1).isWord("CURRENT") && t.get(where + 2).isWord("OF")) {
        throw new Unsupported("WHERE CURRENT OF");
      }
      end = where;
    }
    Set<String> seen = new HashSet<String>();
    for (int[] r : PgLexer.splitTopLevel(t, c.i, end)) {
      if (r[1] - r[0] < 3) {
        throw new Unsupported("malformed SET assignment");
      }
      Token first = t.get(r[0]);
      if (first.kind == PgLexer.Kind.LPAREN) {
        throw new Unsupported("UPDATE SET (a, b) = ... (row assignment)");
      }
      if (!first.isIdent()) {
        throw new Unsupported("SET target is not a column name");
      }
      if (t.get(r[0] + 1).kind == PgLexer.Kind.DOT) {
        throw new Unsupported("qualified SET target");
      }
      if (!t.get(r[0] + 1).isOp("=")) {
        throw new Unsupported("malformed SET assignment");
      }
      if (r[1] == r[0] + 3 && t.get(r[0] + 2).isWord("DEFAULT")) {
        throw new Unsupported("SET ... = DEFAULT");
      }
      String col = first.name();
      if (!seen.add(col)) {
        throw new Unsupported("SET assigns " + col + " twice");
      }
      h.sets.add(new String[] {col, PgLexer.slice(s, t, r[0] + 2, r[1])});
    }
    if (h.sets.isEmpty()) {
      throw new Unsupported("UPDATE with no assignment");
    }
    return h;
  }

  private static Head parseInsert(String s, List<Token> t) throws Unsupported {
    Head h = new Head();
    h.source = s;
    h.toks = t;
    Catalog.Cursor c = new Catalog.Cursor(t, s);
    c.tryWord("INSERT");
    if (!c.tryWord("INTO")) {
      throw new Unsupported("INSERT without INTO");
    }
    parseTarget(h, c, "INSERT");
    if (c.has() && c.peek().kind == PgLexer.Kind.LPAREN) {
      int close = PgLexer.matching(t, c.i);
      if (close < 0) {
        throw new Unsupported("unbalanced parentheses");
      }
      h.columns = new ArrayList<String>();
      h.columnsText = new ArrayList<String>();
      for (int[] r : PgLexer.splitTopLevel(t, c.i + 1, close)) {
        if (r[1] - r[0] != 1 || !t.get(r[0]).isIdent()) {
          throw new Unsupported("INSERT column is not a bare identifier");
        }
        String col = t.get(r[0]).name();
        if (h.columns.contains(col)) {
          throw new Unsupported("INSERT lists " + col + " twice");
        }
        h.columns.add(col);
        h.columnsText.add(t.get(r[0]).text);
      }
      c.i = close + 1;
    }
    if (c.peekWord("OVERRIDING")) {
      throw new Unsupported("INSERT ... OVERRIDING { SYSTEM | USER } VALUE");
    }
    if (c.tryWords("DEFAULT", "VALUES")) {
      throw new Unsupported("INSERT ... DEFAULT VALUES");
    }
    int end = t.size();
    int ret = findWord(t, c.i, "RETURNING");
    if (ret >= 0) {
      h.returning = PgLexer.slice(s, t, ret + 1, end);
      end = ret;
    }
    if (findWords(t, c.i, "ON", "CONFLICT") >= 0) {
      throw new Unsupported("INSERT ... ON CONFLICT");
    }
    if (end <= c.i) {
      throw new Unsupported("INSERT without a source");
    }
    Token first = t.get(c.i);
    if (!(first.isWord("VALUES") || first.isWord("SELECT") || first.isWord("WITH") || first.isWord("TABLE")
        || first.kind == PgLexer.Kind.LPAREN)) {
      throw new Unsupported("INSERT source starting with " + first.text);
    }
    for (int i = c.i; i < end; i++) {
      if (t.get(i).isWord("DEFAULT")) {
        throw new Unsupported("DEFAULT as a value");
      }
    }
    h.sourceFrom = c.i;
    h.sourceTo = end;
    h.sourceText = PgLexer.slice(s, t, c.i, end);
    return h;
  }

  // ---------------------------------------------------------------- the shared guards

  private static void common(Catalog cat, Head a, Head b, String kind) throws Unsupported {
    if (!a.tableName.equals(b.tableName)) {
      throw new Unsupported(kind + " targets differ: " + a.tableName + " and " + b.tableName);
    }
    Catalog.Table t = cat.table(a.tableName);
    if (t != null && t.hasTrigger) {
      throw new Unsupported(kind + " on " + t.name + ", which a trigger or rule names");
    }
  }

  private static Catalog.Table declared(Catalog cat, Head a, String kind) throws Unsupported {
    Catalog.Table t = cat.table(a.tableName);
    if (t == null) {
      throw new Unsupported("no declared schema for " + kind + " target " + a.tableName);
    }
    return t;
  }

  /** Whether both sides carry the same {@code RETURNING} list; one side only, or two lists, refuse. */
  private static boolean sameReturning(Head a, Head b, String kind) throws Unsupported {
    if (a.returning == null && b.returning == null) {
      return false;
    }
    if (a.returning == null || b.returning == null) {
      throw new Unsupported(kind + " ... RETURNING on one side only");
    }
    if (!canonReturning(a).equals(canonReturning(b))) {
      throw new Unsupported(kind + " ... RETURNING that differs between the two statements");
    }
    return true;
  }

  private static List<String> canonReturning(Head h) throws Unsupported {
    List<Token> t = PgLexer.lex(h.returning);
    List<String> items = new ArrayList<String>();
    for (int[] r : PgLexer.splitTopLevel(t, 0, t.size())) {
      int n = r[1] - r[0];
      if (n == 0) {
        throw new Unsupported("empty RETURNING item");
      }
      Token f = t.get(r[0]);
      if (n == 1 && f.isOp("*")) {
        items.add("*");
      } else if (n == 3 && f.isIdent() && t.get(r[0] + 1).kind == PgLexer.Kind.DOT && t.get(r[0] + 2).isOp("*")
          && f.name().equals(h.qual)) {
        items.add("*");
      } else if (n == 1 && f.isIdent()) {
        items.add("col:" + f.name());
      } else if (n == 3 && f.isIdent() && t.get(r[0] + 1).kind == PgLexer.Kind.DOT && t.get(r[0] + 2).isIdent()
          && f.name().equals(h.qual)) {
        items.add("col:" + t.get(r[0] + 2).name());
      } else {
        StringBuilder b = new StringBuilder("other:");
        for (int i = r[0]; i < r[1]; i++) {
          Token k = t.get(i);
          b.append(' ').append(k.kind == PgLexer.Kind.WORD ? k.text.toLowerCase(Locale.ROOT) : k.text);
        }
        items.add(b.toString());
      }
    }
    return items;
  }

  // ---------------------------------------------------------------- the reductions

  private static String deleteToSelect(Head h) {
    StringBuilder b = new StringBuilder("SELECT * FROM ").append(h.targetText);
    if (h.aliasText != null) {
      b.append(" AS ").append(h.aliasText);
    }
    if (h.where != null) {
      b.append(" WHERE ").append(h.where);
    }
    return b.toString();
  }

  private static String updateQuery(Catalog.Table t, Head h, boolean returning) {
    StringBuilder proj = new StringBuilder();
    for (Catalog.Column c : t.columns) {
      String ref = h.qualText + "." + DdlOut.dq(c.name);
      String set = null;
      for (String[] s : h.sets) {
        if (s[0].equals(c.name)) {
          set = s[1];
        }
      }
      if (proj.length() > 0) {
        proj.append(", ");
      }
      if (set == null) {
        proj.append(ref);
      } else if (h.where == null) {
        proj.append('(').append(set).append(')');
      } else {
        proj.append("CASE WHEN (").append(h.where).append(") THEN (").append(set).append(") ELSE ").append(ref).append(" END");
      }
      proj.append(" AS ").append(DdlOut.dq(c.name));
    }
    String from = h.targetText + (h.aliasText != null ? " AS " + h.aliasText : "");
    if (!returning) {
      return "SELECT " + proj + " FROM " + from;
    }
    return "SELECT 0 AS q_goal, " + proj + " FROM " + from + " UNION ALL SELECT 1 AS q_goal, " + proj + " FROM " + from
        + (h.where != null ? " WHERE " + h.where : "");
  }

  private static String[] insertPair(Catalog.Table t, Head a, Head b) throws Unsupported {
    if (a.columns == null || b.columns == null) {
      throw new Unsupported("INSERT without a column list");
    }
    if (!new HashSet<String>(a.columns).equals(new HashSet<String>(b.columns))) {
      throw new Unsupported("INSERT column lists differ: " + a.columns + " and " + b.columns);
    }
    for (String col : a.columns) {
      if (t.column(col) == null) {
        throw new Unsupported("INSERT lists " + col + ", which " + t.name + " does not declare");
      }
    }
    for (Catalog.Column c : t.columns) {
      if (!a.columns.contains(c.name) && (c.generated || !c.rowDetermined)) {
        throw new Unsupported("INSERT omits " + c.name + ", whose default (" + c.defaultExpr + ") is not a function of the row");
      }
    }
    for (Head h : new Head[] {a, b}) {
      for (int k = 0; k < h.columns.size(); k++) {
        Catalog.Column col = t.column(h.columns.get(k));
        if (col.storesSpelling()) {
          insertStoreEvident(h, k, col, t);
        }
      }
    }
    for (Head h : new Head[] {a, b}) {
      h.sourceText = typedParams(h, t);
    }
    if (a.columns.equals(b.columns)) {
      return new String[] {a.sourceText, b.sourceText};
    }
    List<String> order = new ArrayList<String>();
    for (Catalog.Column c : t.columns) {
      if (a.columns.contains(c.name)) {
        order.add(DdlOut.dq(c.name));
      }
    }
    return new String[] {reorder(a, order), reorder(b, order)};
  }

  private static String reorder(Head h, List<String> order) {
    StringBuilder cols = new StringBuilder();
    for (String c : h.columns) {
      cols.append(cols.length() == 0 ? "" : ", ").append(DdlOut.dq(c));
    }
    StringBuilder out = new StringBuilder();
    for (String c : order) {
      out.append(out.length() == 0 ? "" : ", ").append(c);
    }
    return "SELECT " + out + " FROM (" + h.sourceText + ") AS q_src(" + cols + ")";
  }

  // ---------------------------------------------------------------- stored spellings

  /**
   * A value stored into a column whose {@code =} is identity must have its spelling fixed by the
   * statement: a string literal, {@code NULL}, a parameter, or a column of such a type.
   */
  private static void storeEvident(String expr, Catalog.Column into, Catalog.Table t, Head h, Catalog.Table from, String kind)
      throws Unsupported {
    List<Token> e = PgLexer.lex(expr);
    if (evident(e, into, t, h.qual, from)) {
      return;
    }
    throw new Unsupported(kind + " stores into " + into.name + " (" + into.rawType + ") a value whose spelling the statement does not fix: "
        + expr.trim());
  }

  private static boolean evident(List<Token> e, Catalog.Column into, Catalog.Table t, String qual, Catalog.Table from) {
    if (e.isEmpty() || into.truncatingInterval()) {
      return false; // no spelling survives an interval column's modifier
    }
    Token f = e.get(0);
    if (e.size() == 1 && (f.kind == PgLexer.Kind.STRING || f.kind == PgLexer.Kind.PARAM || f.isWord("NULL"))) {
      return true;
    }
    if (f.kind == PgLexer.Kind.STRING && e.size() >= 3 && e.get(1).isOp("::")) {
      return true;
    }
    if (e.size() == 1 && f.isIdent()) {
      Catalog.Column c = t.column(f.name());
      if (c == null && from != null) {
        c = from.column(f.name());
      }
      return c != null && c.storesSpelling();
    }
    if (e.size() == 3 && f.isIdent() && e.get(1).kind == PgLexer.Kind.DOT && e.get(2).isIdent()) {
      Catalog.Table scope = f.name().equals(qual) ? t : from;
      if (scope == null) {
        return false;
      }
      Catalog.Column c = scope.column(e.get(2).name());
      return c != null && c.storesSpelling();
    }
    return false;
  }

  /** The {@code k}-th value of an {@code INSERT} source, for each row of a {@code VALUES} or a simple {@code SELECT}. */
  private static void insertStoreEvident(Head h, int k, Catalog.Column into, Catalog.Table t) throws Unsupported {
    List<Token> src = h.toks.subList(h.sourceFrom, h.sourceTo);
    if (src.get(0).isWord("VALUES")) {
      for (int[] row : PgLexer.splitTopLevel(src, 1, src.size())) {
        if (row[1] - row[0] < 2 || src.get(row[0]).kind != PgLexer.Kind.LPAREN) {
          throw new Unsupported("INSERT ... VALUES row is not parenthesised");
        }
        int close = PgLexer.matching(src, row[0]);
        List<int[]> items = PgLexer.splitTopLevel(src, row[0] + 1, close);
        if (k >= items.size()) {
          throw new Unsupported("INSERT ... VALUES row shorter than the column list");
        }
        int[] it = items.get(k);
        if (!evident(src.subList(it[0], it[1]), into, t, null, null)) {
          throw new Unsupported("INSERT stores into " + into.name + " (" + into.rawType + ") a value whose spelling the statement does not fix: "
              + PgLexer.join(src, it[0], it[1]));
        }
      }
      return;
    }
    if (src.get(0).isWord("SELECT")) {
      int from = findWord(src, 1, "FROM");
      int listEnd = from >= 0 ? from : src.size();
      int listStart = 1;
      if (listStart < listEnd && src.get(listStart).isWord("DISTINCT")) {
        listStart++;
      }
      if (listStart < listEnd && src.get(listStart).isWord("ALL")) {
        listStart++;
      }
      List<int[]> items = PgLexer.splitTopLevel(src, listStart, listEnd);
      if (items.size() == 1 && items.get(0)[1] - items.get(0)[0] == 1 && src.get(items.get(0)[0]).isOp("*")) {
        throw new Unsupported("INSERT ... SELECT * stores into " + into.name + " (" + into.rawType
            + ") values this reader does not type");
      }
      if (k >= items.size()) {
        throw new Unsupported("INSERT ... SELECT list shorter than the column list");
      }
      Catalog.Table source = null;
      String sourceQual = null;
      if (from >= 0) {
        Catalog.Cursor c = new Catalog.Cursor(src, h.source);
        c.i = from + 1;
        List<String> id = c.ident();
        if (id != null) {
          source = tableOf(h, id);
          sourceQual = id.get(id.size() - 1);
          if (c.tryWord("AS") && c.has() && c.peek().isIdent()) {
            sourceQual = c.next().name();
          } else if (c.has() && c.peek().isIdent() && !c.peek().isWord("WHERE") && !c.peek().isWord("GROUP")
              && !c.peek().isWord("ORDER") && !c.peek().isWord("LIMIT") && !c.peek().isWord("HAVING")
              && !c.peek().isWord("UNION") && !c.peek().isWord("EXCEPT") && !c.peek().isWord("INTERSECT")) {
            sourceQual = c.next().name();
          }
          if (c.has() && !(c.peek().isWord("WHERE") || c.peek().isWord("GROUP") || c.peek().isWord("ORDER")
              || c.peek().isWord("LIMIT") || c.peek().isWord("HAVING") || c.peek().isWord("OFFSET"))) {
            source = null; // a join or anything else: the item's type is not known here
          }
        }
      }
      int[] it = items.get(k);
      List<Token> item = src.subList(it[0], it[1]);
      if (item.size() >= 3 && item.get(item.size() - 2).isWord("AS")) {
        item = item.subList(0, item.size() - 2);
      }
      if (!evident(item, into, source != null ? source : emptyTable(), sourceQual, source)) {
        throw new Unsupported("INSERT stores into " + into.name + " (" + into.rawType + ") a value whose spelling the statement does not fix: "
            + PgLexer.join(src, it[0], it[1]));
      }
      return;
    }
    throw new Unsupported("INSERT stores into " + into.name + " (" + into.rawType + ") from a source whose values this reader does not type");
  }

  /**
   * In a {@code VALUES} source, a bare {@code $N} is spelled {@code $N::<column type>}: Postgres
   * types it from the target column, and Calcite's inference has nothing else to go on there.
   */
  private static String typedParams(Head h, Catalog.Table t) {
    List<Token> src = h.toks.subList(h.sourceFrom, h.sourceTo);
    if (src.isEmpty() || !src.get(0).isWord("VALUES")) {
      return h.sourceText;
    }
    StringBuilder out = new StringBuilder();
    int at = h.toks.get(h.sourceFrom).start;
    for (int[] row : PgLexer.splitTopLevel(src, 1, src.size())) {
      if (row[1] - row[0] < 2 || src.get(row[0]).kind != PgLexer.Kind.LPAREN) {
        return h.sourceText;
      }
      int close = PgLexer.matching(src, row[0]);
      List<int[]> items = PgLexer.splitTopLevel(src, row[0] + 1, close);
      for (int k = 0; k < items.size() && k < h.columns.size(); k++) {
        int[] it = items.get(k);
        if (it[1] - it[0] == 1 && src.get(it[0]).kind == PgLexer.Kind.PARAM) {
          Catalog.Column col = t.column(h.columns.get(k));
          if (col == null || col.type == Catalog.Type.OPAQUE) {
            continue;
          }
          Token param = src.get(it[0]);
          out.append(h.source, at, param.end).append("::").append(col.rawType);
          at = param.end;
        }
      }
    }
    out.append(h.source, at, h.toks.get(h.sourceTo - 1).end);
    return out.toString();
  }

  private static Catalog.Table emptyTable() {
    return new Catalog.Table(null, "");
  }

  private static Catalog.Table tableOf(Head h, List<String> id) {
    return CatalogHolder.current == null ? null : CatalogHolder.current.table(id.get(id.size() - 1));
  }

  /** The catalog of the pair being reduced, for the one lookup that has no other way to it. */
  static final class CatalogHolder {
    static Catalog current;
  }

  static {
    // nothing
  }

  /** Entry point used by {@link Frontend}: sets the catalog the {@code INSERT ... SELECT} typing consults. */
  public static Reduced reduceWith(Catalog cat, String s0, String s1) throws Unsupported {
    CatalogHolder.current = cat;
    try {
      return reduce(cat, s0, s1);
    } finally {
      CatalogHolder.current = null;
    }
  }
}
