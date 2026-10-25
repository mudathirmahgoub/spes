package sqleq.input;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import sqleq.input.PgLexer.Kind;
import sqleq.input.PgLexer.Token;

/**
 * The tables a pair is checked against, read from the PostgreSQL DDL of its pair file.
 *
 * <p>What is read is what the two consumers need: each table's columns in declared order with a
 * type from a small closed vocabulary, {@code NOT NULL}, the primary key and the {@code UNIQUE}
 * constraints and unique indexes, foreign keys, and per column whether its {@code DEFAULT} is a
 * function of the row (an {@code INSERT} that omits a column whose default is a sequence value or
 * {@code now()} cannot be reduced to its source). Triggers and rules are noted so that a DML
 * statement on their table is refused: the statement then no longer writes what it says. Domains
 * are expanded. Everything else -- functions, sequences, types, extensions, check constraints -- is
 * skipped, and a statement that cannot be read at all is skipped with a warning rather than
 * guessed at.
 */
public final class Catalog {
  public enum Type { INTEGER, BIGINT, DECIMAL, DOUBLE, BOOLEAN, STRING, CHAR, DATE, TIME, TIMESTAMP, INTERVAL, BINARY, OPAQUE }

  public static final class Column {
    public String name;
    public String rawType = "";
    public Type type = Type.OPAQUE;
    /** The parenthesised modifier of the type, {@code (10,2)} or empty. */
    public String typeArgs = "";
    public boolean notNull;
    /** The default expression as written, or null. */
    public String defaultExpr;
    /** Whether the value an {@code INSERT} would store for an omitted column is fixed by the row. */
    public boolean rowDetermined = true;
    /** An identity, serial or generated column: a value the statement does not supply. */
    public boolean generated;

    Column(String name) {
      this.name = name;
    }

    void rename(String newName) {
      this.name = newName;
    }

    /**
     * Types whose {@code =} is identity, so the spelling of a stored value is observable; and an
     * interval column with a modifier ({@code interval day}, {@code interval(0)}), which truncates
     * what it stores, so that two {@code =} intervals are stored as two different ones.
     */
    public boolean storesSpelling() {
      return type == Type.STRING || type == Type.CHAR || type == Type.OPAQUE || type == Type.BINARY || truncatingInterval();
    }

    /** An interval column whose declaration carries fields or a precision. */
    public boolean truncatingInterval() {
      return type == Type.INTERVAL && !rawType.trim().toLowerCase(Locale.ROOT).replaceAll("\\s+", " ").equals("interval");
    }
  }

  public static final class Unique {
    public String name;
    public final List<String> columns;
    public boolean nullsNotDistinct;
    /** False for {@code DEFERRABLE INITIALLY DEFERRED} and {@code NOT ENFORCED}: no key within a statement. */
    public boolean enforced = true;

    Unique(String name, List<String> columns, boolean nullsNotDistinct) {
      this.name = name;
      this.columns = new ArrayList<String>(columns);
      this.nullsNotDistinct = nullsNotDistinct;
    }
  }

  public static final class ForeignKey {
    public final List<String> columns;
    public final String refTable;
    /** The referenced columns, or null when the statement names none (the referenced primary key). */
    public final List<String> refColumns;

    ForeignKey(List<String> columns, String refTable, List<String> refColumns) {
      this.columns = columns;
      this.refTable = refTable;
      this.refColumns = refColumns;
    }
  }

  public static final class Table {
    public final String schema;
    public final String name;
    public final List<Column> columns = new ArrayList<Column>();
    public List<String> primaryKey;
    public String primaryKeyName;
    public boolean primaryKeyEnforced = true;
    public final List<Unique> uniques = new ArrayList<Unique>();
    public final List<ForeignKey> foreignKeys = new ArrayList<ForeignKey>();
    public boolean hasTrigger;
    /** Another table {@code INHERITS} this one: its rows are read through this table, and no key survives that. */
    public boolean hasChildren;

    Table(String schema, String name) {
      this.schema = schema;
      this.name = name;
    }

    public Column column(String name) {
      for (Column c : columns) {
        if (c.name.equals(name)) {
          return c;
        }
      }
      return null;
    }

    /**
     * The keys a prover may assume: the primary key, and each {@code UNIQUE} whose columns are all
     * {@code NOT NULL} or which is declared {@code NULLS NOT DISTINCT}. A unique constraint over a
     * nullable column is not a key in Postgres: it admits any number of rows that are null there.
     */
    public List<List<String>> proverKeys() {
      List<List<String>> keys = new ArrayList<List<String>>();
      if (hasChildren) {
        return keys;
      }
      if (primaryKey != null && primaryKeyEnforced) {
        keys.add(primaryKey);
      }
      for (Unique u : uniques) {
        if (!u.enforced) {
          continue;
        }
        boolean key = u.nullsNotDistinct;
        if (!key) {
          key = true;
          for (String c : u.columns) {
            Column col = column(c);
            if (col == null || !col.notNull) {
              key = false;
            }
          }
        }
        if (key && !keys.contains(u.columns)) {
          keys.add(u.columns);
        }
      }
      return keys;
    }
  }

  private static final class Domain {
    final String rawType;
    final String defaultExpr;
    final boolean rowDetermined;
    final boolean notNull;

    Domain(String rawType, String defaultExpr, boolean rowDetermined, boolean notNull) {
      this.rawType = rawType;
      this.defaultExpr = defaultExpr;
      this.rowDetermined = rowDetermined;
      this.notNull = notNull;
    }
  }

  private static final Set<String> CONSTRAINT_WORDS = new HashSet<String>(Arrays.asList(
      "NOT", "NULL", "PRIMARY", "UNIQUE", "REFERENCES", "DEFAULT", "CHECK", "GENERATED", "CONSTRAINT",
      "COLLATE", "DEFERRABLE", "INITIALLY", "COMPRESSION", "STORAGE"));
  private static final Set<String> VOLATILE = new HashSet<String>(Arrays.asList(
      "CURRENT_TIMESTAMP", "CURRENT_DATE", "CURRENT_TIME", "LOCALTIME", "LOCALTIMESTAMP", "NOW", "RANDOM",
      "NEXTVAL", "CLOCK_TIMESTAMP", "STATEMENT_TIMESTAMP", "TRANSACTION_TIMESTAMP", "TIMEOFDAY",
      "GEN_RANDOM_UUID", "UUID_GENERATE_V4", "CURRENT_USER", "SESSION_USER", "USER", "CURRENT_ROLE"));

  private final Map<String, Table> tables = new LinkedHashMap<String, Table>();
  private final Map<String, Domain> domains = new LinkedHashMap<String, Domain>();
  /** Every index by name, unique or not: {@code CREATE INDEX IF NOT EXISTS} on a taken name is a no-op. */
  private boolean collations;
  private final Set<String> publicNames = new HashSet<String>();
  private final Set<String> ambiguous = new HashSet<String>();
  private final Map<String, Unique> indexes = new LinkedHashMap<String, Unique>();
  private final Map<String, Table> indexTables = new LinkedHashMap<String, Table>();
  private final Set<String> triggered = new HashSet<String>();
  public final List<String> warnings = new ArrayList<String>();

  private Catalog() {}

  public static Catalog build(List<String> ddl) {
    Catalog c = new Catalog();
    for (String statement : ddl) {
      try {
        c.read(statement);
      } catch (Unsupported e) {
        c.warnings.add(e.getMessage() + ": " + abbreviate(statement));
      } catch (RuntimeException e) {
        c.warnings.add(e + ": " + abbreviate(statement));
      }
    }
    for (String t : c.triggered) {
      Table table = c.table(t);
      if (table != null) {
        table.hasTrigger = true;
      }
    }
    return c;
  }

  /** The tables, each once, in declaration order. */
  public List<Table> tables() {
    List<Table> out = new ArrayList<Table>();
    Set<Table> seen = new LinkedHashSet<Table>();
    for (Table t : tables.values()) {
      if (seen.add(t)) {
        out.add(t);
      }
    }
    return out;
  }

  /** Whether the DDL declares a collation or collates a column: string equality may then not be identity. */
  public boolean hasCollations() {
    return collations;
  }

  /** Whether a query reaches this table by its bare name; the provers' schemas hold exactly those. */
  public boolean reachableBare(Table t) {
    return tables.get(t.name) == t;
  }

  /** The table a folded name denotes, bare or schema-qualified; null when undeclared. */
  public Table table(String name) {
    Table t = tables.get(name);
    if (t == null && name.indexOf('.') >= 0) {
      t = tables.get(name.substring(name.lastIndexOf('.') + 1));
    }
    return t;
  }

  private static String abbreviate(String s) {
    String one = s.replaceAll("\\s+", " ").trim();
    return one.length() > 60 ? one.substring(0, 57) + "..." : one;
  }

  // ---------------------------------------------------------------- reading one statement

  private void read(String statement) throws Unsupported {
    List<Token> toks = PgLexer.lex(statement);
    Cursor c = new Cursor(toks, statement);
    if (c.tryWord("CREATE")) {
      boolean unique = false;
      while (c.has()) {
        Token p = c.peek();
        if (p.isWord("OR")) {
          c.next();
          c.tryWord("REPLACE");
        } else if (p.isWord("GLOBAL") || p.isWord("LOCAL") || p.isWord("TEMP") || p.isWord("TEMPORARY")
            || p.isWord("UNLOGGED") || p.isWord("CONSTRAINT")) {
          c.next();
        } else if (p.isWord("UNIQUE")) {
          unique = true;
          c.next();
        } else {
          break;
        }
      }
      if (c.tryWord("TABLE")) {
        createTable(c);
      } else if (c.tryWord("INDEX")) {
        createIndex(c, unique);
      } else if (c.tryWord("TRIGGER")) {
        markAfter(c, "ON");
      } else if (c.tryWord("RULE")) {
        markAfter(c, "TO");
      } else if (c.tryWord("DOMAIN")) {
        createDomain(c);
      } else if (c.peekWord("COLLATION")) {
        collations = true;
      } else {
        while (c.has() && (c.peek().isWord("TEMP") || c.peek().isWord("TEMPORARY") || c.peek().isWord("RECURSIVE")
            || c.peek().isWord("MATERIALIZED"))) {
          c.next();
        }
        if (c.tryWord("VIEW")) {
          // a view is not read; a public one takes its bare name from any table of another schema,
          // so a query over it is a query over an undeclared relation and is refused downstream
          c.tryWords("IF", "NOT", "EXISTS");
          List<String> vn = c.ident();
          if (vn != null && (vn.size() == 1 || vn.get(vn.size() - 2).equals("public"))) {
            String bare = vn.get(vn.size() - 1);
            Table shadowed = tables.get(bare);
            if (shadowed != null && !publicNames.contains(bare)) {
              tables.remove(bare);
            }
            publicNames.add(bare);
          }
        }
      }
      return;
    }
    if (c.tryWord("ALTER")) {
      if (c.tryWord("TABLE")) {
        alterTable(c);
      } else if (c.tryWord("INDEX")) {
        alterIndex(c);
      }
      return;
    }
    if (c.tryWord("DROP")) {
      if (c.tryWord("INDEX")) {
        dropIndex(c);
      } else if (c.tryWord("TABLE")) {
        c.tryWords("IF", "EXISTS");
        for (int[] r : PgLexer.splitTopLevel(c.t, c.i, c.t.size())) {
          Cursor one = new Cursor(c.t.subList(r[0], r[1]), c.source);
          List<String> name = one.ident();
          if (name != null) {
            Table t = table(name.get(name.size() - 1));
            if (t != null) {
              tables.values().removeAll(Collections.singleton(t));
            }
          }
        }
      }
    }
  }

  private void alterIndex(Cursor c) {
    c.tryWords("IF", "EXISTS");
    List<String> name = c.ident();
    if (name != null && c.tryWords("RENAME", "TO")) {
      List<String> to = c.ident();
      String from = name.get(name.size() - 1);
      if (to != null && indexes.containsKey(from)) {
        Unique u = indexes.remove(from);
        Table t = indexTables.remove(from);
        String n = to.get(to.size() - 1);
        u.name = n;
        indexes.put(n, u);
        indexTables.put(n, t);
      }
    }
  }

  private void dropIndex(Cursor c) {
    c.tryWord("CONCURRENTLY");
    c.tryWords("IF", "EXISTS");
    for (int[] r : PgLexer.splitTopLevel(c.t, c.i, c.t.size())) {
      Cursor one = new Cursor(c.t.subList(r[0], r[1]), c.source);
      List<String> name = one.ident();
      if (name == null) {
        continue;
      }
      String n = name.get(name.size() - 1);
      Unique u = indexes.remove(n);
      Table t = indexTables.remove(n);
      if (u != null && t != null) {
        t.uniques.remove(u);
      } else if (u == null) {
        // an index this reader never saw: whatever it was, no unique index can be trusted to survive it
        for (Table any : tables()) {
          any.uniques.removeAll(indexes.values());
        }
        indexes.clear();
        indexTables.clear();
        warnings.add("DROP INDEX " + n + " names an index this reader did not record; all unique indexes dropped");
      }
    }
  }

  private void createTable(Cursor c) throws Unsupported {
    c.tryWords("IF", "NOT", "EXISTS");
    List<String> name = c.ident();
    if (name == null) {
      throw new Unsupported("CREATE TABLE without a table name");
    }
    if (!c.has() || c.peek().kind != Kind.LPAREN) {
      throw new Unsupported("CREATE TABLE without a column list");
    }
    int open = c.i;
    int close = PgLexer.matching(c.t, open);
    if (close < 0) {
      throw new Unsupported("unbalanced parentheses");
    }
    Table t = new Table(name.size() > 1 ? name.get(name.size() - 2) : null, name.get(name.size() - 1));
    for (int[] r : PgLexer.splitTopLevel(c.t, open + 1, close)) {
      if (r[1] > r[0]) {
        element(t, new Cursor(c.t.subList(r[0], r[1]), c.source));
      }
    }
    c.i = close + 1;
    if (c.tryWord("INHERITS")) {
      List<String> parents = c.columnList();
      if (parents != null) {
        List<Column> inherited = new ArrayList<Column>();
        for (String pn : parents) {
          Table parent = table(pn);
          if (parent == null) {
            throw new Unsupported("INHERITS from an undeclared table " + pn);
          }
          parent.hasChildren = true;
          for (Column pc : parent.columns) {
            if (t.column(pc.name) == null) {
              inherited.add(copy(pc));
            }
          }
        }
        t.columns.addAll(0, inherited);
      }
    }
    for (Unique u : t.uniques) {
      if (u.name == null) {
        u.name = t.name + "_" + joinNames(u.columns) + "_key";
      }
    }
    if (t.primaryKey != null && t.primaryKeyName == null) {
      t.primaryKeyName = t.name + "_pkey";
    }
    // The bare name reaches a public table, or -- as sqleq's frontend reads a captured schema --
    // the one table of that name in some other schema when there is exactly one and no public
    // table or view takes the name. Two schemas declaring it make the bare name ambiguous.
    boolean isPublic = t.schema == null || t.schema.equals("public");
    if (isPublic) {
      tables.put(t.name, t);
      publicNames.add(t.name);
    } else if (!publicNames.contains(t.name) && !ambiguous.contains(t.name)) {
      Table other = tables.get(t.name);
      if (other != null && other != t) {
        tables.remove(t.name);
        ambiguous.add(t.name);
        warnings.add("tables named " + t.name + " in two schemas; the bare name reaches neither");
      } else {
        tables.put(t.name, t);
      }
    }
    tables.put((isPublic ? "public" : t.schema) + "." + t.name, t);
  }

  /** One element of a {@code CREATE TABLE} list, or one {@code ALTER TABLE ... ADD} item. */
  private void element(Table t, Cursor e) throws Unsupported {
    String constraintName = null;
    if (e.tryWord("CONSTRAINT")) {
      List<String> cn = e.ident();
      constraintName = cn == null ? null : cn.get(cn.size() - 1);
    }
    Token p = e.peek();
    if (p == null) {
      return;
    }
    if (p.isWord("PRIMARY")) {
      e.next();
      e.tryWord("KEY");
      List<String> cols = e.columnList();
      if (cols != null) {
        t.primaryKey = cols;
        t.primaryKeyName = constraintName;
        t.primaryKeyEnforced = e.enforced();
        for (String col : cols) {
          Column column = t.column(col);
          if (column != null) {
            column.notNull = true;
          }
        }
      }
      return;
    }
    if (p.isWord("UNIQUE")) {
      e.next();
      boolean nnd = e.nullsClause();
      List<String> cols = e.columnList();
      if (cols != null) {
        nnd |= e.nullsClause();
        Unique u = new Unique(constraintName, cols, nnd);
        u.enforced = e.enforced();
        t.uniques.add(u);
      }
      return;
    }
    if (p.isWord("FOREIGN")) {
      e.next();
      e.tryWord("KEY");
      List<String> cols = e.columnList();
      if (cols != null && e.tryWord("REFERENCES")) {
        List<String> ref = e.ident();
        List<String> rcols = e.columnList();
        if (ref != null) {
          t.foreignKeys.add(new ForeignKey(cols, ref.get(ref.size() - 1), rcols));
        }
      }
      return;
    }
    if (p.isWord("LIKE")) {
      // LIKE source: the columns, with NOT NULL and defaults; indexes and constraints only under
      // INCLUDING, which this reader does not copy -- a key dropped costs a proof, never a wrong one
      e.next();
      List<String> src = e.ident();
      Table source = src == null ? null : table(src.get(src.size() - 1));
      if (source == null) {
        throw new Unsupported("LIKE an undeclared table");
      }
      for (Column pc : source.columns) {
        if (t.column(pc.name) == null) {
          t.columns.add(copy(pc));
        }
      }
      while (e.has()) {
        boolean including = e.tryWord("INCLUDING");
        if (!including && !e.tryWord("EXCLUDING")) {
          break;
        }
        Token what = e.has() ? e.next() : null;
        if (what == null) {
          break;
        }
        if (including && (what.isWord("INDEXES") || what.isWord("CONSTRAINTS") || what.isWord("ALL"))) {
          if (source.primaryKey != null && t.primaryKey == null) {
            t.primaryKey = new ArrayList<String>(source.primaryKey);
            t.primaryKeyName = t.name + "_pkey";
            t.primaryKeyEnforced = source.primaryKeyEnforced;
          }
          for (Unique u : source.uniques) {
            Unique v = new Unique(null, u.columns, u.nullsNotDistinct);
            v.enforced = u.enforced;
            t.uniques.add(v);
          }
        }
      }
      return;
    }
    if (p.isWord("CHECK") || p.isWord("EXCLUDE")) {
      return;
    }
    if (!p.isIdent()) {
      return;
    }
    Column col = new Column(e.next().name());
    int typeStart = e.i;
    while (e.has()) {
      Token q = e.peek();
      if (q.kind == Kind.WORD && CONSTRAINT_WORDS.contains(q.upper())) {
        break;
      }
      if (q.kind == Kind.LPAREN) {
        e.skipGroup();
        continue;
      }
      e.next();
    }
    String rawType = PgLexer.join(e.t, typeStart, e.i);
    Domain domain = domainOf(rawType);
    String columnConstraintName = null;
    while (e.has()) {
      Token q = e.next();
      String w = q.upper();
      if (w.equals("CONSTRAINT")) {
        List<String> cn = e.ident();
        columnConstraintName = cn == null ? null : cn.get(cn.size() - 1);
        continue;
      } else if (w.equals("NOT")) {
        if (e.tryWord("NULL")) {
          col.notNull = true;
        }
      } else if (w.equals("PRIMARY")) {
        e.tryWord("KEY");
        col.notNull = true;
        t.primaryKey = Collections.singletonList(col.name);
        t.primaryKeyName = columnConstraintName;
        t.primaryKeyEnforced = e.enforced();
      } else if (w.equals("UNIQUE")) {
        boolean nnd = e.nullsClause();
        Unique u = new Unique(columnConstraintName, Collections.singletonList(col.name), nnd);
        u.enforced = e.enforced();
        t.uniques.add(u);
      } else if (w.equals("REFERENCES")) {
        List<String> ref = e.ident();
        List<String> rcols = e.columnList();
        if (ref != null) {
          t.foreignKeys.add(new ForeignKey(Collections.singletonList(col.name), ref.get(ref.size() - 1), rcols));
        }
        e.skipReferentialActions();
      } else if (w.equals("DEFAULT")) {
        int from = e.i;
        while (e.has()) {
          Token r = e.peek();
          if (r.kind == Kind.WORD && CONSTRAINT_WORDS.contains(r.upper()) && !r.isWord("NULL")) {
            break;
          }
          if (r.kind == Kind.LPAREN) {
            e.skipGroup();
            continue;
          }
          e.next();
        }
        col.defaultExpr = PgLexer.join(e.t, from, e.i);
        col.rowDetermined = rowDetermined(e.t.subList(from, e.i));
      } else if (w.equals("GENERATED")) {
        // GENERATED { ALWAYS | BY DEFAULT } AS IDENTITY [(options)], or GENERATED ALWAYS AS (expr) STORED
        col.generated = true;
        col.rowDetermined = false;
        if (!e.tryWord("ALWAYS")) {
          e.tryWords("BY", "DEFAULT");
        }
        e.tryWord("AS");
        if (e.tryWord("IDENTITY")) {
          col.notNull = true;
          e.skipGroup();
        } else {
          e.skipGroup();
          e.tryWord("STORED");
          e.tryWord("VIRTUAL");
        }
      } else if (w.equals("CHECK")) {
        e.skipGroup();
      } else if (w.equals("COLLATE")) {
        e.ident();
        collations = true;
      }
      columnConstraintName = null;
    }
    applyType(col, domain != null ? domain.rawType : rawType);
    if (domain != null) {
      if (col.defaultExpr == null && domain.defaultExpr != null) {
        col.defaultExpr = domain.defaultExpr;
        col.rowDetermined = domain.rowDetermined;
      }
      if (domain.notNull) {
        col.notNull = true;
      }
    }
    Column existing = t.column(col.name);
    if (existing != null) {
      t.columns.remove(existing);
    }
    t.columns.add(col);
  }

  private Domain domainOf(String rawType) {
    String key = rawType.trim();
    if (key.startsWith("\"") && key.endsWith("\"") && key.length() >= 2) {
      key = key.substring(1, key.length() - 1).replace("\"\"", "\"");
    } else {
      key = key.toLowerCase(Locale.ROOT);
    }
    return domains.get(key);
  }

  private static boolean rowDetermined(List<Token> expr) {
    for (Token t : expr) {
      if (t.kind == Kind.LPAREN || (t.kind == Kind.OTHER && t.text.equals("["))) {
        return false;
      }
      if (t.kind == Kind.WORD && VOLATILE.contains(t.upper())) {
        return false;
      }
    }
    return true;
  }

  private void alterTable(Cursor c) throws Unsupported {
    c.tryWord("ONLY");
    c.tryWords("IF", "EXISTS");
    List<String> name = c.ident();
    if (name == null) {
      return;
    }
    Table t = table(name.get(name.size() - 1));
    if (t == null) {
      return;
    }
    for (int[] r : PgLexer.splitTopLevel(c.t, c.i, c.t.size())) {
      if (r[1] <= r[0]) {
        continue;
      }
      Cursor a = new Cursor(c.t.subList(r[0], r[1]), c.source);
      if (a.tryWord("RENAME")) {
        if (a.tryWord("TO")) {
          List<String> to = a.ident();
          if (to != null) {
            tables.values().removeAll(Collections.singleton(t));
            Table renamed = new Table(t.schema, to.get(to.size() - 1));
            renamed.columns.addAll(t.columns);
            renamed.primaryKey = t.primaryKey;
            renamed.primaryKeyName = t.primaryKeyName;
            renamed.primaryKeyEnforced = t.primaryKeyEnforced;
            renamed.uniques.addAll(t.uniques);
            renamed.foreignKeys.addAll(t.foreignKeys);
            renamed.hasTrigger = t.hasTrigger;
            renamed.hasChildren = t.hasChildren;
            if (renamed.schema == null || renamed.schema.equals("public")) {
              tables.put(renamed.name, renamed);
              publicNames.add(renamed.name);
            } else if (!publicNames.contains(renamed.name) && !tables.containsKey(renamed.name)) {
              tables.put(renamed.name, renamed);
            }
            tables.put((renamed.schema == null ? "public" : renamed.schema) + "." + renamed.name, renamed);
            t = renamed;
          }
          continue;
        }
        a.tryWord("COLUMN");
        List<String> from = a.ident();
        if (from == null || !a.tryWord("TO")) {
          continue;
        }
        List<String> to = a.ident();
        Column col = t.column(from.get(from.size() - 1));
        if (to == null || col == null) {
          continue;
        }
        String newName = to.get(to.size() - 1);
        Column renamed = copy(col);
        renamed.rename(newName);
        t.columns.set(t.columns.indexOf(col), renamed);
        if (t.primaryKey != null) {
          t.primaryKey = renameIn(t.primaryKey, col.name, newName);
        }
        for (Unique u : t.uniques) {
          List<String> cols = renameIn(u.columns, col.name, newName);
          u.columns.clear();
          u.columns.addAll(cols);
        }
        continue;
      }
      if (a.tryWord("ADD")) {
        a.tryWord("COLUMN");
        a.tryWords("IF", "NOT", "EXISTS");
        element(t, a);
        for (Unique u : t.uniques) {
          if (u.name == null) {
            u.name = t.name + "_" + joinNames(u.columns) + "_key";
          }
        }
        if (t.primaryKey != null && t.primaryKeyName == null) {
          t.primaryKeyName = t.name + "_pkey";
        }
      } else if (a.tryWords("DROP", "CONSTRAINT")) {
        a.tryWords("IF", "EXISTS");
        List<String> cn = a.ident();
        if (cn == null) {
          continue;
        }
        String n = cn.get(cn.size() - 1);
        boolean found = false;
        if (n.equals(t.primaryKeyName)) {
          t.primaryKey = null;
          t.primaryKeyName = null;
          found = true;
        }
        for (java.util.Iterator<Unique> it = t.uniques.iterator(); it.hasNext();) {
          if (n.equals(it.next().name)) {
            it.remove();
            found = true;
          }
        }
        if (!found) {
          // a constraint this reader did not record under that name: no key of the table can be trusted
          t.primaryKey = null;
          t.uniques.clear();
          warnings.add("DROP CONSTRAINT " + n + " on " + t.name + " names no recorded key; all keys of " + t.name + " dropped");
        }
      } else if (a.tryWord("ALTER")) {
        a.tryWord("COLUMN");
        List<String> cn = a.ident();
        Column col = cn == null ? null : t.column(cn.get(cn.size() - 1));
        if (col == null) {
          continue;
        }
        if (a.tryWords("SET", "DEFAULT")) {
          col.defaultExpr = PgLexer.join(a.t, a.i, a.t.size());
          col.rowDetermined = rowDetermined(a.t.subList(a.i, a.t.size()));
        } else if (a.tryWords("DROP", "DEFAULT")) {
          col.defaultExpr = null;
          col.rowDetermined = true;
        } else if (a.tryWords("SET", "NOT", "NULL")) {
          col.notNull = true;
        } else if (a.tryWords("DROP", "NOT", "NULL")) {
          col.notNull = false;
        } else if (a.tryWords("ADD", "GENERATED")) {
          col.generated = true;
          col.rowDetermined = false;
          col.notNull = true;
        }
      } else if (a.tryWord("DROP")) {
        a.tryWord("COLUMN");
        a.tryWords("IF", "EXISTS");
        List<String> cn = a.ident();
        if (cn != null) {
          Column col = t.column(cn.get(cn.size() - 1));
          if (col != null) {
            t.columns.remove(col);
          }
        }
      }
    }
  }

  private void createIndex(Cursor c, boolean unique) {
    c.tryWord("CONCURRENTLY");
    boolean ifNotExists = c.tryWords("IF", "NOT", "EXISTS");
    String indexName = null;
    if (!c.peekWord("ON")) {
      List<String> in = c.ident();
      indexName = in == null ? null : in.get(in.size() - 1);
    }
    if (!c.tryWord("ON")) {
      return;
    }
    c.tryWord("ONLY");
    List<String> tn = c.ident();
    if (tn == null) {
      return;
    }
    Table t = table(tn.get(tn.size() - 1));
    if (t == null) {
      return;
    }
    if (c.tryWord("USING")) {
      c.ident();
    }
    if (!c.has() || c.peek().kind != Kind.LPAREN) {
      return;
    }
    int open = c.i;
    int close = PgLexer.matching(c.t, open);
    if (close < 0) {
      return;
    }
    List<String> cols = new ArrayList<String>();
    List<String> allNames = new ArrayList<String>();
    boolean plain = true;
    for (int[] r : PgLexer.splitTopLevel(c.t, open + 1, close)) {
      Cursor it = new Cursor(c.t.subList(r[0], r[1]), c.source);
      List<String> id = it.ident();
      if (id == null || id.size() != 1) {
        plain = false; // an expression index: dropped, as the frontend drops it
        allNames.add("expr");
        continue;
      }
      allNames.add(id.get(0));
      while (it.has()) {
        if (it.tryWord("ASC") || it.tryWord("DESC")) {
          continue;
        }
        if (it.tryWord("NULLS")) {
          it.next();
          continue;
        }
        if (it.tryWord("COLLATE")) {
          it.ident();
          continue;
        }
        plain = false; // an operator class or anything else: dropped
        break;
      }
      cols.add(id.get(0));
    }
    if (indexName == null) {
      indexName = t.name + "_" + joinNames(allNames) + "_idx";
    }
    if (indexes.containsKey(indexName)) {
      if (ifNotExists) {
        return; // Postgres: the name is taken, nothing is created
      }
      warnings.add("index " + indexName + " created twice");
    }
    c.i = close + 1;
    boolean nnd = false;
    boolean partial = false;
    while (c.has()) {
      if (c.tryWord("INCLUDE") || c.tryWord("WITH")) {
        c.skipGroup();
      } else if (c.peekWord("NULLS")) {
        nnd = c.nullsClause();
      } else if (c.peekWord("WHERE")) {
        partial = true; // a partial index is no key
        break;
      } else if (c.tryWord("TABLESPACE")) {
        c.ident();
      } else {
        c.next();
      }
    }
    Unique u = new Unique(indexName, cols, nnd);
    u.enforced = unique && plain && !partial;
    indexes.put(indexName, u);
    indexTables.put(indexName, t);
    if (u.enforced) {
      t.uniques.add(u);
    }
  }

  private void markAfter(Cursor c, String keyword) {
    int depth = 0;
    for (; c.has(); c.next()) {
      Token p = c.peek();
      if (p.kind == Kind.LPAREN) {
        depth++;
      } else if (p.kind == Kind.RPAREN) {
        depth--;
      } else if (depth == 0 && p.isWord(keyword)) {
        c.next();
        List<String> name = c.ident();
        if (name != null) {
          triggered.add(name.get(name.size() - 1));
        }
        return;
      }
    }
  }

  private void createDomain(Cursor c) {
    List<String> name = c.ident();
    if (name == null) {
      return;
    }
    c.tryWord("AS");
    int typeStart = c.i;
    while (c.has()) {
      Token q = c.peek();
      if (q.kind == Kind.WORD && CONSTRAINT_WORDS.contains(q.upper())) {
        break;
      }
      if (q.kind == Kind.LPAREN) {
        c.skipGroup();
        continue;
      }
      c.next();
    }
    String rawType = PgLexer.join(c.t, typeStart, c.i);
    String def = null;
    boolean det = true;
    boolean notNull = false;
    while (c.has()) {
      Token q = c.next();
      if (q.isWord("DEFAULT")) {
        int from = c.i;
        while (c.has()) {
          Token r = c.peek();
          if (r.kind == Kind.WORD && CONSTRAINT_WORDS.contains(r.upper()) && !r.isWord("NULL")) {
            break;
          }
          if (r.kind == Kind.LPAREN) {
            c.skipGroup();
            continue;
          }
          c.next();
        }
        def = PgLexer.join(c.t, from, c.i);
        det = rowDetermined(c.t.subList(from, c.i));
      } else if (q.isWord("NOT")) {
        if (c.tryWord("NULL")) {
          notNull = true;
        }
      } else if (q.isWord("CHECK")) {
        c.skipGroup();
      } else if (q.isWord("CONSTRAINT") || q.isWord("COLLATE")) {
        c.ident();
      }
    }
    domains.put(name.get(name.size() - 1), new Domain(rawType, def, det, notNull));
  }

  private static List<String> renameIn(List<String> names, String from, String to) {
    List<String> out = new ArrayList<String>();
    for (String n : names) {
      out.add(n.equals(from) ? to : n);
    }
    return out;
  }

  private static String joinNames(List<String> names) {
    StringBuilder b = new StringBuilder();
    for (String n : names) {
      b.append(b.length() == 0 ? "" : "_").append(n);
    }
    return b.toString();
  }

  private static Column copy(Column c) {
    Column d = new Column(c.name);
    d.rawType = c.rawType;
    d.type = c.type;
    d.typeArgs = c.typeArgs;
    d.notNull = c.notNull;
    d.defaultExpr = c.defaultExpr;
    d.rowDetermined = c.rowDetermined;
    d.generated = c.generated;
    return d;
  }

  // ---------------------------------------------------------------- types

  /** Reads a declared type into the closed vocabulary; serial types also set the column's defaults. */
  static void applyType(Column col, String raw) {
    col.rawType = raw.trim();
    String low;
    if (col.rawType.startsWith("\"")) {
      // a quoted type name denotes the type spelled exactly so: "serial" is serial, "Serial" is not
      int q = col.rawType.indexOf('"', 1);
      low = q > 0 ? col.rawType.substring(1, q).replace("\"\"", "\"") + col.rawType.substring(q + 1) : col.rawType;
    } else {
      low = col.rawType.toLowerCase(Locale.ROOT);
    }
    low = low.replaceAll("\\s+", " ").trim();
    if (low.startsWith("pg_catalog.")) {
      low = low.substring("pg_catalog.".length());
    }
    String args = "";
    int p = low.indexOf('(');
    if (p >= 0) {
      int q = low.indexOf(')', p);
      if (q > p) {
        args = low.substring(p, q + 1).replaceAll("\\s+", "");
        low = (low.substring(0, p) + low.substring(q + 1)).replaceAll("\\s+", " ").trim();
      }
    }
    col.typeArgs = args;
    if (low.endsWith("[]") || low.indexOf('[') >= 0 || low.endsWith(" array")) {
      col.type = Type.OPAQUE;
      col.typeArgs = "";
      return;
    }
    low = low.replace(" without time zone", "").replace(" with time zone", "").trim();
    if (low.startsWith("interval")) {
      col.type = Type.INTERVAL;
      return;
    }
    if (low.equals("int") || low.equals("integer") || low.equals("int4") || low.equals("smallint") || low.equals("int2")) {
      col.type = Type.INTEGER;
    } else if (low.equals("bigint") || low.equals("int8")) {
      col.type = Type.BIGINT;
    } else if (low.equals("serial") || low.equals("serial4") || low.equals("smallserial") || low.equals("serial2")) {
      col.type = Type.INTEGER;
      serial(col);
    } else if (low.equals("bigserial") || low.equals("serial8")) {
      col.type = Type.BIGINT;
      serial(col);
    } else if (low.equals("numeric") || low.equals("decimal") || low.equals("money")) {
      col.type = Type.DECIMAL;
    } else if (low.equals("real") || low.equals("float4") || low.equals("double precision") || low.equals("float8") || low.equals("float")) {
      col.type = Type.DOUBLE;
    } else if (low.equals("boolean") || low.equals("bool")) {
      col.type = Type.BOOLEAN;
    } else if (low.equals("text") || low.equals("varchar") || low.equals("character varying") || low.equals("name")) {
      col.type = Type.STRING;
    } else if (low.equals("date")) {
      col.type = Type.DATE;
    } else if (low.equals("time") || low.equals("timetz")) {
      col.type = Type.TIME;
    } else if (low.equals("timestamp") || low.equals("timestamptz")) {
      col.type = Type.TIMESTAMP;
    } else if (low.equals("bytea")) {
      col.type = Type.BINARY;
    } else {
      col.type = Type.OPAQUE;
      col.typeArgs = "";
    }
  }

  private static void serial(Column col) {
    col.notNull = true;
    col.generated = true;
    col.rowDetermined = false;
    col.defaultExpr = "nextval(sequence)";
  }

  // ---------------------------------------------------------------- a cursor over tokens

  static final class Cursor {
    final List<Token> t;
    final String source;
    int i;

    Cursor(List<Token> t, String source) {
      this.t = t;
      this.source = source;
    }

    boolean has() {
      return i < t.size();
    }

    Token peek() {
      return has() ? t.get(i) : null;
    }

    Token next() {
      return t.get(i++);
    }

    boolean peekWord(String w) {
      return has() && t.get(i).isWord(w);
    }

    boolean tryWord(String w) {
      if (peekWord(w)) {
        i++;
        return true;
      }
      return false;
    }

    boolean tryWords(String... ws) {
      int save = i;
      for (String w : ws) {
        if (!tryWord(w)) {
          i = save;
          return false;
        }
      }
      return true;
    }

    /** An identifier chain {@code a.b.c} as folded names, or null when not at one. */
    List<String> ident() {
      if (!has() || !t.get(i).isIdent()) {
        return null;
      }
      List<String> parts = new ArrayList<String>();
      parts.add(next().name());
      while (has() && t.get(i).kind == Kind.DOT && i + 1 < t.size() && t.get(i + 1).isIdent()) {
        i++;
        parts.add(next().name());
      }
      return parts;
    }

    boolean skipGroup() {
      if (has() && t.get(i).kind == Kind.LPAREN) {
        int m = PgLexer.matching(t, i);
        i = m < 0 ? t.size() : m + 1;
        return true;
      }
      return false;
    }

    /** A parenthesised list of column names as folded names, or null when not at one. */
    List<String> columnList() {
      if (!has() || t.get(i).kind != Kind.LPAREN) {
        return null;
      }
      int open = i;
      int close = PgLexer.matching(t, open);
      if (close < 0) {
        i = t.size();
        return null;
      }
      List<String> cols = new ArrayList<String>();
      for (int[] r : PgLexer.splitTopLevel(t, open + 1, close)) {
        if (r[1] > r[0] && t.get(r[0]).isIdent()) {
          cols.add(t.get(r[0]).name());
        }
      }
      i = close + 1;
      return cols;
    }

    /**
     * Reads a key constraint's trailing words and says whether it holds within a statement:
     * {@code DEFERRABLE INITIALLY DEFERRED} and {@code NOT ENFORCED} do not.
     */
    boolean enforced() {
      boolean enforced = true;
      while (has()) {
        if (tryWord("NOT")) {
          if (tryWord("ENFORCED")) {
            enforced = false;
          } else {
            tryWord("DEFERRABLE");
            tryWord("VALID");
          }
        } else if (tryWord("DEFERRABLE") || tryWord("ENFORCED")) {
          continue;
        } else if (tryWord("INITIALLY")) {
          if (tryWord("DEFERRED")) {
            enforced = false;
          } else {
            tryWord("IMMEDIATE");
          }
        } else if (peekWord("USING") || peekWord("WITH") || peekWord("INCLUDE")) {
          next();
          skipGroup();
        } else {
          break;
        }
      }
      return enforced;
    }

    /** {@code NULLS [NOT] DISTINCT}; true when {@code NOT} is present. */
    boolean nullsClause() {
      if (tryWord("NULLS")) {
        boolean not = tryWord("NOT");
        tryWord("DISTINCT");
        return not;
      }
      return false;
    }

    void skipReferentialActions() {
      while (has()) {
        if (tryWord("MATCH")) {
          next();
        } else if (tryWord("ON")) {
          if (has()) {
            next();
          }
          if (tryWord("SET")) {
            if (has()) {
              next();
            }
          } else if (tryWord("NO")) {
            tryWord("ACTION");
          } else if (has()) {
            next();
          }
        } else {
          return;
        }
      }
    }
  }
}
