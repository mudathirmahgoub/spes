package SimpleQueryTests;

import java.io.File;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.apache.calcite.rel.type.RelDataType;
import org.apache.calcite.rel.type.RelDataTypeField;
import org.apache.calcite.sql.type.SqlTypeName;

/**
 * Re-checks a counterexample by running the two queries on an engine that speaks SQL.
 *
 * <p>When the solver answers {@code sat}, its model is a database on which the two queries
 * disagree. That is a claim about SQL and not about SMT, so it is worth asking SQL: this class
 * writes the model out as a SQLite file -- the tables, the rows the model gave them, and both
 * queries as views -- and then asks SQLite whether the two views really do differ. A model the
 * engine cannot tell apart means the encoding of one of the queries is wrong, which is the one
 * failure a {@code sat} answer cannot show on its own.
 *
 * <p>The file is left behind, one per inequivalent pair, so the counterexample can be examined
 * afterwards without running anything from this project:
 *
 * <pre>
 *   sqlite3 counterexamples/testMergeUnionAll.db 'SELECT * FROM q1'
 *   sqlite3 counterexamples/testMergeUnionAll.db 'SELECT * FROM q2'
 *   sqlite3 counterexamples/testMergeUnionAll.db 'SELECT * FROM difference'
 *   sqlite3 counterexamples/testMergeUnionAll.db '.schema'
 * </pre>
 *
 * <p>SQLite is the default because it needs no server and because a file is something you can
 * keep. {@code -Dcex=postgres} runs the same check against a PostgreSQL server on localhost
 * instead, in temporary tables that vanish with the connection, and {@code -Dcex=none} turns
 * the check off.
 */
public final class CounterexampleDatabase
{
  /** Rows of {@code difference} to print; the whole table stays in the file either way. */
  private static final int MAX_PRINTED_ROWS = 20;

  /** Rows per INSERT. SQLite caps the terms in one compound VALUES, and a bag model can be big. */
  private static final int ROWS_PER_INSERT = 100;

  /** Where the counterexample is replayed. */
  public enum Backend
  {
    SQLITE,
    POSTGRES,
    NONE;

    static Backend of(String name)
    {
      String value = name == null ? "" : name.trim().toLowerCase(Locale.ROOT);
      if (value.isEmpty() || value.equals("sqlite") || value.equals("sqlite3"))
      {
        return SQLITE;
      }
      if (value.equals("postgres") || value.equals("postgresql") || value.equals("pg"))
      {
        return POSTGRES;
      }
      if (value.equals("none") || value.equals("off") || value.equals("no"))
      {
        return NONE;
      }
      throw new IllegalArgumentException(
          "unknown counterexample backend '" + name + "': use sqlite, postgres or none");
    }
  }

  /** One table of the counterexample: how to declare it, and the rows the model gave it. */
  public static final class Table
  {
    private final String name;
    private final String schemaName;
    private final List<String> columns = new ArrayList<>();
    private final List<SqlTypeName> types = new ArrayList<>();
    private final List<Boolean> notNull = new ArrayList<>();
    private final List<List<String>> keys;
    private final List<List<Object>> rows;

    /**
     * @param name the table's own name, unqualified, spelled as the schema spelled it
     * @param schemaName the schema the DDL qualified it with, or null
     * @param rowType its columns, with the nullability the encoding declared them with
     * @param keys its declared unique keys, recorded but not enforced -- see {@link #keyNote}
     * @param rows one list of column values per row, nulls included, duplicates repeated
     */
    public Table(String name, String schemaName, RelDataType rowType, List<List<String>> keys,
        List<List<Object>> rows)
    {
      this.name = name;
      this.schemaName = schemaName;
      this.keys = keys == null ? Collections.<List<String>>emptyList() : keys;
      this.rows = rows;
      for (RelDataTypeField field : rowType.getFieldList())
      {
        columns.add(field.getName());
        types.add(field.getType().getSqlTypeName());
        notNull.add(!field.getType().isNullable());
      }
    }

    String qualifiedName()
    {
      return schemaName == null ? name : schemaName + "." + name;
    }
  }

  /** What the check found: lines for the caller to print, and the verdict behind them. */
  public static final class Report
  {
    private final boolean confirmed;
    private final boolean checked;
    private final List<String> lines;

    Report(boolean confirmed, boolean checked, List<String> lines)
    {
      this.confirmed = confirmed;
      this.checked = checked;
      this.lines = lines;
    }

    /** Whether the engine agreed that the two queries differ on this database. */
    public boolean isConfirmed()
    {
      return confirmed;
    }

    /** Whether the engine managed to run both queries at all. */
    public boolean isChecked()
    {
      return checked;
    }

    /** What happened, one line at a time, for the caller to write into its own output. */
    public List<String> lines()
    {
      return lines;
    }
  }

  private CounterexampleDatabase() {}

  /** The backend {@code -Dcex} asks for. Resolved eagerly so a typo fails before a long run. */
  public static Backend backend()
  {
    return Backend.of(property("cex", ""));
  }

  /** Where the SQLite files go: {@code -Dcex.dir}, or {@code counterexamples} beside the run. */
  public static File directory()
  {
    return new File(property("cex.dir", "counterexamples"));
  }

  /** One line describing the configuration, for a run to print before it starts. */
  public static String describe()
  {
    Backend backend = backend();
    if (backend == Backend.NONE)
    {
      return "off (-Dcex=none): a sat answer is not replayed on a real engine";
    }
    if (backend == Backend.SQLITE)
    {
      return "sqlite -> " + directory() + File.separator + "<test name>.db";
    }
    return "postgres -> " + postgresUrl().replaceAll("password=[^&]*", "password=***");
  }

  /**
   * Replays a counterexample: builds the database the model describes, runs both queries on it,
   * and reports whether they differ.
   *
   * @param name names the file the counterexample is written to
   * @param columnCount how many columns the two queries return, which is how the views that
   *     hold them get column names of their own
   * @param isSetSemantics whether the model was found under set semantics, in which case rows
   *     are compared by presence rather than by how many copies there are
   */
  public static Report verify(String name, String sql1, String sql2, int columnCount,
      boolean isSetSemantics, List<Table> tables)
  {
    Backend backend = backend();
    List<String> lines = new ArrayList<>();
    if (backend == Backend.NONE)
    {
      lines.add("counterexample: not replayed (-Dcex=none)");
      return new Report(false, false, lines);
    }

    String collision = collidingName(tables);
    if (collision != null)
    {
      // Two tables of the same name in different schemas stay two to the solver. Here they
      // would have to be one, since SQLite has no schemas, so the replay is skipped rather
      // than run against a database that merges them.
      lines.add("counterexample: two tables are called " + collision
          + " and this database cannot keep them apart, so the model was not replayed");
      return new Report(false, false, lines);
    }

    File file = backend == Backend.SQLITE ? file(name) : null;
    if (file != null)
    {
      File parent = file.getParentFile();
      if (parent != null && !parent.isDirectory() && !parent.mkdirs())
      {
        lines.add("counterexample: could not create the directory " + parent);
        return new Report(false, false, lines);
      }
      // a run rebuilds its own file rather than adding to the last run's tables
      if (file.exists() && !file.delete())
      {
        lines.add("counterexample: could not replace " + file);
        return new Report(false, false, lines);
      }
    }

    String query1 = rewrite(sql1, tables, backend);
    String query2 = rewrite(sql2, tables, backend);
    List<String> data = dataStatements(tables, backend);
    List<String> info = backend == Backend.SQLITE
        ? infoStatements(name, sql1, sql2, query1, query2, isSetSemantics, tables, backend)
        : Collections.<String>emptyList();
    List<String> queries = new ArrayList<>();
    queries.add(view("q1", query1, columnCount, backend));
    queries.add(view("q2", query2, columnCount, backend));
    queries.add(differenceView(columnCount, isSetSemantics, backend));

    try (Connection connection = open(backend, file))
    {
      try (Statement statement = connection.createStatement())
      {
        for (String sql : data)
        {
          statement.execute(sql);
          lines.add(sql);
        }
        // Before the views, so that a file whose queries the engine goes on to refuse still
        // says what it holds. Not echoed: it only repeats the two queries.
        for (String sql : info)
        {
          statement.execute(sql);
        }
        if (file != null)
        {
          lines.add("counterexample database: " + file);
        }
        int differing;
        try
        {
          for (String sql : queries)
          {
            statement.execute(sql);
          }
          differing = report(statement, lines, isSetSemantics, backend);
        }
        catch (SQLException e)
        {
          // A query the engine does not accept -- a function it lacks, a name it folds
          // differently, a column count the view did not expect. The data is still worth
          // keeping, so the file stays; only the second opinion is lost, and saying that
          // beats reporting a counterexample the engine never got to look at.
          lines.add("counterexample: " + backendName(backend)
              + " could not run the queries, so the model was not re-checked: " + reason(e));
          return new Report(false, false, lines);
        }
        if (file != null)
        {
          // The driver-backed reader first: it needs nothing that is not already here, and
          // the command line client is named sqlite3 rather than sqlite where it exists at all.
          lines.add("try it: mvn exec:exec -Dcex.show=" + file + "   (or sqlite3 " + file
              + " 'SELECT * FROM difference')");
        }
        return new Report(differing > 0, true, lines);
      }
    }
    catch (SQLException e)
    {
      lines.add("counterexample: could not build the database in " + backendName(backend) + ": "
          + reason(e));
      return new Report(false, false, lines);
    }
  }

  // ------------------------------------------------------------------
  // running the two queries
  // ------------------------------------------------------------------

  /** Reads {@code difference}, prints what it holds, and returns how many rows it holds. */
  private static int report(Statement statement, List<String> lines, boolean isSetSemantics,
      Backend backend) throws SQLException
  {
    lines.add("SELECT * FROM difference");
    Rows rows = read(statement, "SELECT * FROM difference", MAX_PRINTED_ROWS);
    lines.addAll(rows.lines);
    if (rows.count > 0)
    {
      lines.add("counterexample confirmed: " + backendName(backend) + " has q1 and q2 disagreeing"
          + " on " + rows.count + (rows.count == 1 ? " row" : " rows") + " of this database");
    }
    else
    {
      // The solver said these queries differ on this database and the engine says they do not.
      // One of the two encodings does not mean what its query means.
      lines.add("counterexample NOT confirmed: " + backendName(backend) + " returns the same"
          + (isSetSemantics ? " rows" : " rows with the same multiplicities")
          + " for q1 and q2 on this database, so an encoding is suspect");
    }
    return rows.count;
  }

  /** A query's result as text: a header line, then a line per row, and how many rows there were. */
  private static final class Rows
  {
    final List<String> lines = new ArrayList<>();
    int count;
  }

  /** Runs a query and lays its result out as text, writing at most {@code maxRows} of them. */
  private static Rows read(Statement statement, String sql, int maxRows) throws SQLException
  {
    Rows rows = new Rows();
    try (ResultSet rs = statement.executeQuery(sql))
    {
      ResultSetMetaData meta = rs.getMetaData();
      StringBuilder header = new StringBuilder();
      for (int i = 1; i <= meta.getColumnCount(); i++)
      {
        header.append(i > 1 ? " | " : "").append(meta.getColumnName(i));
      }
      rows.lines.add(header.toString());
      while (rs.next())
      {
        rows.count++;
        if (rows.count <= maxRows)
        {
          StringBuilder row = new StringBuilder();
          for (int i = 1; i <= meta.getColumnCount(); i++)
          {
            Object value = rs.getObject(i);
            row.append(i > 1 ? " | " : "").append(value == null ? "NULL" : value.toString());
          }
          rows.lines.add(row.toString());
        }
      }
      if (rows.count > maxRows)
      {
        rows.lines.add("... and " + (rows.count - maxRows) + " more rows");
      }
    }
    return rows;
  }

  // ------------------------------------------------------------------
  // reading a file back
  // ------------------------------------------------------------------

  /** Rows of a counterexample table to print when a file is read back. */
  private static final int MAX_SHOWN_ROWS = 100;

  /**
   * Prints what one counterexample file holds: what it is, the data, and what each query
   * returns on it.
   *
   * <p>The file is a plain SQLite database and the {@code sqlite3} command line is the better
   * way to explore one. This is here because that command is not everywhere -- it is named
   * {@code sqlite3} rather than {@code sqlite}, and some machines have neither -- while the
   * driver that wrote the file is already a dependency of this project. So one option reads it
   * back without asking for anything else:
   *
   * <pre>
   *   mvn exec:exec -Dcex.show=counterexamples/testEmptyMinus.db
   * </pre>
   */
  public static void show(File file, PrintStream out)
  {
    if (!file.isFile())
    {
      // Opening a missing file would create an empty one and print nothing at all.
      out.println("no such counterexample file: " + file);
      return;
    }
    out.println("counterexample: " + file);
    try (Connection connection = DriverManager.getConnection("jdbc:sqlite:" + file.getPath()))
    {
      try (Statement statement = connection.createStatement())
      {
        for (String name : names(statement, "table"))
        {
          if (name.equals("spes_info"))
          {
            continue;
          }
          print(out, statement, name, "SELECT * FROM " + identifier(name, Backend.SQLITE));
        }
        for (String name : names(statement, "view"))
        {
          print(out, statement, name, "SELECT * FROM " + identifier(name, Backend.SQLITE));
        }
        info(out, statement);
      }
    }
    catch (SQLException e)
    {
      out.println("could not read " + file + ": " + reason(e));
    }
  }

  /** The tables or the views this file holds, in the order they were created. */
  private static List<String> names(Statement statement, String type) throws SQLException
  {
    List<String> names = new ArrayList<>();
    try (ResultSet rs = statement.executeQuery(
             "SELECT name FROM sqlite_master WHERE type = '" + type + "' ORDER BY rowid"))
    {
      while (rs.next())
      {
        names.add(rs.getString(1));
      }
    }
    return names;
  }

  /** One table or view, under a heading saying how many rows it has. */
  private static void print(PrintStream out, Statement statement, String name, String sql)
  {
    out.println();
    Rows rows;
    try
    {
      rows = read(statement, sql, MAX_SHOWN_ROWS);
    }
    catch (SQLException e)
    {
      // A query SQLite cannot run is why a file has no `difference` to read; the file says
      // which query it was, so naming the failure here is enough.
      out.println(name + ": " + reason(e));
      return;
    }
    out.println(name + " (" + rows.count + (rows.count == 1 ? " row)" : " rows)"));
    for (String line : rows.lines)
    {
      out.println("  " + line);
    }
  }

  /** What {@code spes_info} says, which is what the file is a counterexample to. */
  private static void info(PrintStream out, Statement statement) throws SQLException
  {
    out.println();
    try (ResultSet rs = statement.executeQuery("SELECT key, value FROM spes_info ORDER BY rowid"))
    {
      while (rs.next())
      {
        out.println(rs.getString(1) + ": " + rs.getString(2));
      }
    }
  }

  // ------------------------------------------------------------------
  // building the database
  // ------------------------------------------------------------------

  /**
   * The name two of these tables share, if any two do once the schema they are in is dropped.
   * Names are compared without regard to case, which is how SQLite compares them.
   */
  private static String collidingName(List<Table> tables)
  {
    Map<String, String> byName = new LinkedHashMap<>();
    for (Table table : tables)
    {
      String previous = byName.put(table.name.toLowerCase(Locale.ROOT), table.qualifiedName());
      if (previous != null && !previous.equals(table.qualifiedName()))
      {
        return previous + " and " + table.qualifiedName();
      }
    }
    return null;
  }

  /** {@code CREATE TABLE} and {@code INSERT} for every table the counterexample names. */
  private static List<String> dataStatements(List<Table> tables, Backend backend)
  {
    List<String> statements = new ArrayList<>();
    Set<String> created = new LinkedHashSet<>();
    for (Table table : tables)
    {
      // The same table read by both queries is one table here. A name two different tables
      // share never reaches this point -- see collidingName.
      if (!created.add(table.name.toLowerCase(Locale.ROOT)))
      {
        continue;
      }
      StringBuilder create = new StringBuilder();
      create.append(backend == Backend.POSTGRES ? "CREATE TEMP TABLE " : "CREATE TABLE ");
      create.append(identifier(table.name, backend)).append(" (");
      for (int i = 0; i < table.columns.size(); i++)
      {
        create.append(i > 0 ? ", " : "")
            .append(identifier(table.columns.get(i), backend))
            .append(" ")
            .append(columnType(table.types.get(i), backend));
        if (table.notNull.get(i))
        {
          create.append(" NOT NULL");
        }
      }
      create.append(")");
      statements.add(create.toString());
      statements.addAll(insertStatements(table, backend));
    }
    return statements;
  }

  /**
   * The rows of one table, in batches.
   *
   * <p>No key constraint is declared, though the schema's keys are recorded in {@code
   * spes_info}: a {@code PRIMARY KEY} here is not read as {@code NOT NULL} -- see the README --
   * whereas SQLite's {@code INTEGER PRIMARY KEY} both rejects a null and invents a value for
   * it, which would quietly change the counterexample being replayed.
   */
  private static List<String> insertStatements(Table table, Backend backend)
  {
    List<String> statements = new ArrayList<>();
    StringBuilder columns = new StringBuilder();
    for (int i = 0; i < table.columns.size(); i++)
    {
      columns.append(i > 0 ? ", " : "").append(identifier(table.columns.get(i), backend));
    }
    for (int start = 0; start < table.rows.size(); start += ROWS_PER_INSERT)
    {
      int end = Math.min(start + ROWS_PER_INSERT, table.rows.size());
      StringBuilder insert = new StringBuilder("INSERT INTO ")
                                 .append(identifier(table.name, backend))
                                 .append(" (")
                                 .append(columns)
                                 .append(") VALUES ");
      for (int r = start; r < end; r++)
      {
        List<Object> row = table.rows.get(r);
        insert.append(r > start ? ", (" : "(");
        for (int c = 0; c < row.size(); c++)
        {
          insert.append(c > 0 ? ", " : "").append(literal(row.get(c), backend));
        }
        insert.append(")");
      }
      statements.add(insert.toString());
    }
    return statements;
  }

  /**
   * One query as a view, with columns renamed to {@code c1 ... cn}.
   *
   * <p>The renaming is what makes the comparison below writable: a query may return two columns
   * of the same name, or a name no engine would accept, and either way the comparison has to be
   * able to say which column it means.
   */
  private static String view(String name, String query, int columnCount, Backend backend)
  {
    return (backend == Backend.POSTGRES ? "CREATE TEMP VIEW " : "CREATE VIEW ") + name + " ("
        + columnList(columnCount, "") + ") AS SELECT * FROM (" + query + ") AS q";
  }

  /** {@code c1, c2, ... cn}, each behind the given qualifier ({@code ""} for none). */
  private static String columnList(int columnCount, String qualifier)
  {
    StringBuilder columns = new StringBuilder();
    for (int i = 1; i <= columnCount; i++)
    {
      columns.append(i > 1 ? ", " : "").append(qualifier).append("c").append(i);
    }
    return columns.toString();
  }

  /**
   * The rows where the two queries disagree, with the number of copies each returns.
   *
   * <p>{@code EXCEPT ALL} would say this in one line, and PostgreSQL has it, but SQLite has
   * only the duplicate-eliminating {@code EXCEPT} -- which under bag semantics is the wrong
   * question. Counting copies of each row asks the right one in both engines, and shows how
   * the queries differ rather than only that they do.
   */
  private static String differenceView(int columnCount, boolean isSetSemantics, Backend backend)
  {
    StringBuilder q1Match = new StringBuilder();
    StringBuilder q2Match = new StringBuilder();
    String sameValue = backend == Backend.POSTGRES ? " IS NOT DISTINCT FROM " : " IS ";
    for (int i = 1; i <= columnCount; i++)
    {
      String column = "c" + i;
      q1Match.append(i > 1 ? " AND " : "").append("q1.").append(column).append(sameValue)
          .append("r.").append(column);
      q2Match.append(i > 1 ? " AND " : "").append("q2.").append(column).append(sameValue)
          .append("r.").append(column);
    }
    String columns = columnList(columnCount, "");
    // UNION, not UNION ALL: this is the set of rows to count copies of, and it compares two
    // nulls equal, which is what a counterexample over a nullable column needs.
    String distinctRows = "SELECT " + columns + " FROM q1 UNION SELECT " + columns + " FROM q2";
    String where = isSetSemantics ? "(in_q1 = 0) <> (in_q2 = 0)" : "in_q1 <> in_q2";
    return (backend == Backend.POSTGRES ? "CREATE TEMP VIEW " : "CREATE VIEW ")
        + "difference AS SELECT * FROM ("
        + "SELECT " + columnList(columnCount, "r.") + ", "
        + "(SELECT COUNT(*) FROM q1 WHERE " + q1Match + ") AS in_q1, "
        + "(SELECT COUNT(*) FROM q2 WHERE " + q2Match + ") AS in_q2 "
        + "FROM (" + distinctRows + ") AS r) AS d WHERE " + where;
  }

  /**
   * A table of everything about the counterexample that is not a row: the two queries as they
   * were written, the semantics they were compared under, and the keys the schema declared.
   * It is here so the file answers "what am I looking at" on its own.
   */
  private static List<String> infoStatements(String name, String sql1, String sql2, String query1,
      String query2, boolean isSetSemantics, List<Table> tables, Backend backend)
  {
    List<String> statements = new ArrayList<>();
    statements.add("CREATE TABLE spes_info (key TEXT, value TEXT)");
    List<String[]> info = new ArrayList<>();
    info.add(new String[] {"test", name});
    info.add(new String[] {"semantics", isSetSemantics ? "sets" : "bags"});
    info.add(new String[] {"q1", sql1});
    info.add(new String[] {"q2", sql2});
    if (!query1.equals(sql1))
    {
      info.add(new String[] {"q1 as run here", query1});
    }
    if (!query2.equals(sql2))
    {
      info.add(new String[] {"q2 as run here", query2});
    }
    for (Table table : tables)
    {
      String note = keyNote(table);
      if (note != null)
      {
        info.add(new String[] {"keys of " + table.name, note});
      }
    }
    info.add(new String[] {"how to use",
        "SELECT * FROM q1; SELECT * FROM q2; SELECT * FROM difference -- the rows they disagree"
            + " on, with how many copies each query returns"});
    StringBuilder insert = new StringBuilder("INSERT INTO spes_info (key, value) VALUES ");
    for (int i = 0; i < info.size(); i++)
    {
      insert.append(i > 0 ? ", (" : "(")
          .append(literal(info.get(i)[0], backend))
          .append(", ")
          .append(literal(info.get(i)[1], backend))
          .append(")");
    }
    statements.add(insert.toString());
    return statements;
  }

  /** The keys the schema declared for a table, which this database records but does not enforce. */
  private static String keyNote(Table table)
  {
    if (table.keys.isEmpty())
    {
      return null;
    }
    StringBuilder note = new StringBuilder();
    for (List<String> key : table.keys)
    {
      note.append(note.length() > 0 ? ", " : "").append("(").append(String.join(", ", key))
          .append(")");
    }
    return note + " -- declared unique, asserted to the solver, not enforced here";
  }

  // ------------------------------------------------------------------
  // spelling SQL the engine accepts
  // ------------------------------------------------------------------

  /** Calcite's name for an unaliased expression, which no engine produces. */
  private static final Pattern EXPR = Pattern.compile("EXPR\\$(\\d+)");

  /**
   * The query as this engine has to read it.
   *
   * <p>Two things are adjusted. Calcite calls an unaliased expression {@code EXPR$0}, and a
   * query that reads such a column by name has to say {@code column1} to an engine that names
   * the columns of a {@code VALUES} table that way -- which both SQLite and PostgreSQL do. And
   * a table the schema qualified with a name of its own ({@code public.emp}) is created
   * unqualified here, since SQLite has no schemas, so the qualification is dropped from the
   * query as well. Only the unquoted spelling is rewritten; {@code "public"."emp"} is left as
   * written.
   */
  private static String rewrite(String sql, List<Table> tables, Backend backend)
  {
    String query = sql.trim();
    while (query.endsWith(";"))
    {
      query = query.substring(0, query.length() - 1).trim();
    }
    StringBuffer expanded = new StringBuffer();
    Matcher matcher = EXPR.matcher(query);
    while (matcher.find())
    {
      matcher.appendReplacement(
          expanded, "column" + (Integer.parseInt(matcher.group(1)) + 1));
    }
    matcher.appendTail(expanded);
    query = expanded.toString();
    for (Table table : tables)
    {
      if (table.schemaName != null)
      {
        query = query.replaceAll("(?i)\\b" + Pattern.quote(table.schemaName) + "\\s*\\.\\s*"
                + Pattern.quote(table.name) + "\\b",
            Matcher.quoteReplacement(identifier(table.name, backend)));
      }
    }
    return query;
  }

  /**
   * A name the engine will resolve to what we created.
   *
   * <p>SQLite compares identifiers without regard to case whether they are quoted or not, so
   * quoting there only protects a name that needs it. PostgreSQL folds an unquoted name down
   * and keeps a quoted one, so a name has to be left unquoted to be found by a query that
   * writes it in a different case -- which is exactly what a Calcite-accented query over a
   * PostgreSQL schema does.
   */
  private static String identifier(String name, Backend backend)
  {
    return backend == Backend.POSTGRES ? name : "\"" + name.replace("\"", "\"\"") + "\"";
  }

  /** How a column of this type is declared to the engine. */
  private static String columnType(SqlTypeName type, Backend backend)
  {
    boolean sqlite = backend != Backend.POSTGRES;
    if (type == null)
    {
      return sqlite ? "TEXT" : "text";
    }
    switch (type)
    {
      case TINYINT:
      case SMALLINT:
      case INTEGER:
      case BIGINT:
        return sqlite ? "INTEGER" : "bigint";
      case BOOLEAN:
        return sqlite ? "INTEGER" : "boolean";
      case FLOAT:
      case REAL:
      case DOUBLE:
        return sqlite ? "REAL" : "double precision";
      case DECIMAL:
        return sqlite ? "NUMERIC" : "numeric";
      case DATE:
        return sqlite ? "TEXT" : "date";
      case TIME:
        return sqlite ? "TEXT" : "time";
      case TIMESTAMP:
        return sqlite ? "TEXT" : "timestamp";
      default:
        // CHAR and VARCHAR included: the encoding has one string type with no width, so
        // declaring a width here could reject a value the solver was allowed to choose.
        return sqlite ? "TEXT" : "text";
    }
  }

  /** One value of the model, as a literal. */
  private static String literal(Object value, Backend backend)
  {
    if (value == null)
    {
      return "NULL";
    }
    if (value instanceof Boolean)
    {
      boolean isTrue = (Boolean) value;
      if (backend == Backend.POSTGRES)
      {
        return isTrue ? "TRUE" : "FALSE";
      }
      return isTrue ? "1" : "0";
    }
    if (value instanceof Number)
    {
      return value.toString();
    }
    return "'" + value.toString().replace("'", "''") + "'";
  }

  // ------------------------------------------------------------------
  // plumbing
  // ------------------------------------------------------------------

  private static Connection open(Backend backend, File file) throws SQLException
  {
    if (backend == Backend.POSTGRES)
    {
      return DriverManager.getConnection(postgresUrl());
    }
    return DriverManager.getConnection("jdbc:sqlite:" + file.getPath());
  }

  /** Where the PostgreSQL backend connects; {@code -Dcex.url} to point it elsewhere. */
  private static String postgresUrl()
  {
    return property("cex.url", "jdbc:postgresql://localhost/template1?user=postgres&password=abc");
  }

  private static String backendName(Backend backend)
  {
    return backend == Backend.POSTGRES ? "postgres" : "sqlite";
  }

  /** The file this counterexample belongs in, named after the test it came from. */
  private static File file(String name)
  {
    String base = name == null || name.trim().isEmpty() ? "counterexample" : name.trim();
    return new File(directory(), base.replaceAll("[^A-Za-z0-9._-]", "_") + ".db");
  }

  /** A JDBC message without the stack trace, which the caller is writing into a comment. */
  private static String reason(SQLException e)
  {
    String message = e.getMessage();
    return message == null ? e.toString() : message.replace('\n', ' ').trim();
  }

  private static String property(String name, String fallback)
  {
    String value = System.getProperty(name);
    return value == null || value.trim().isEmpty() ? fallback : value.trim();
  }
}
