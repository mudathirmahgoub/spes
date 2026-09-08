package DbSchema;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;

/**
 * Reads {@code CREATE TABLE} statements out of a schema file.
 *
 * <p>The input is whatever a database happened to write: a hand-typed file like SQLSolver's
 * {@code example_schema.sql}, a {@code pg_dump} with sequences and {@code ALTER TABLE ... ADD
 * CONSTRAINT}, or a {@code mysqldump} with {@code /*!40101 ... *}{@code /} comments and
 * {@code ENGINE=InnoDB} trailers. Anything that is not a table definition -- views, indexes on
 * expressions, triggers, {@code SET}, {@code CREATE EXTENSION} -- is skipped rather than
 * rejected, because a schema is usually much bigger than the part a query touches.
 *
 * <p>Three statements are understood:
 *
 * <ul>
 *   <li>{@code CREATE TABLE} -- columns, and {@code PRIMARY KEY}/{@code UNIQUE} constraints;
 *   <li>{@code ALTER TABLE ... ADD [CONSTRAINT c] PRIMARY KEY|UNIQUE (cols)} -- how a
 *       PostgreSQL dump states its keys;
 *   <li>{@code CREATE UNIQUE INDEX ... ON t (cols)} -- the other way to state a key.
 * </ul>
 *
 * <p>A declared key is an <em>assumption</em>: it lets the validator drop a {@code DISTINCT}
 * the key makes redundant. A declared {@code NOT NULL} is one too. Neither is invented --
 * in particular {@code PRIMARY KEY} is not read as implying {@code NOT NULL}, since leaving a
 * column nullable only widens the set of databases a proof has to hold for.
 */
final class DdlParser
{
  private static final Set<String> CONSTRAINT_STARTS = new HashSet<>(Arrays.asList("PRIMARY",
      "UNIQUE", "FOREIGN", "CHECK", "CONSTRAINT", "KEY", "INDEX", "FULLTEXT", "SPATIAL",
      "EXCLUDE", "PERIOD", "LIKE"));

  /** Words that continue a type name wherever they appear in one, rather than ending it. */
  private static final Set<String> TYPE_TAILS =
      new HashSet<>(Arrays.asList("VARYING", "PRECISION", "UNSIGNED", "SIGNED", "ZEROFILL"));

  private final Dialect dialect;
  private final List<TableDef> tables = new ArrayList<>();
  private final List<String> warnings = new ArrayList<>();
  /** Keys named by later statements, kept until the table they belong to is known. */
  private final List<String[]> pendingKeys = new ArrayList<>();
  private final List<List<String>> pendingKeyColumns = new ArrayList<>();

  DdlParser(Dialect dialect)
  {
    this.dialect = dialect;
  }

  List<String> warnings()
  {
    return warnings;
  }

  List<TableDef> parse(String ddl)
  {
    for (List<Token> statement : Lexer.statements(ddl, dialect))
    {
      try
      {
        parseStatement(statement);
      }
      catch (RuntimeException e)
      {
        warnings.add("skipped a statement that could not be read (" + e.getMessage() + "): "
            + preview(statement));
      }
    }
    applyPendingKeys();
    return tables;
  }

  private static String preview(List<Token> statement)
  {
    StringBuilder text = new StringBuilder();
    for (int i = 0; i < Math.min(8, statement.size()); i++)
    {
      text.append(statement.get(i).text).append(' ');
    }
    return text.toString().trim() + (statement.size() > 8 ? " ..." : "");
  }

  private void parseStatement(List<Token> tokens)
  {
    if (tokens.isEmpty())
    {
      return;
    }
    Cursor cursor = new Cursor(tokens);
    if (cursor.tryKeyword("CREATE"))
    {
      // CREATE [OR REPLACE] [GLOBAL|LOCAL] [TEMP|TEMPORARY|UNLOGGED|EXTERNAL|VIRTUAL] TABLE
      cursor.tryKeywords("OR", "REPLACE");
      cursor.tryAnyKeyword("GLOBAL", "LOCAL");
      cursor.tryAnyKeyword("TEMP", "TEMPORARY", "UNLOGGED", "EXTERNAL", "VIRTUAL", "FOREIGN");
      if (cursor.tryKeyword("TABLE"))
      {
        parseCreateTable(cursor);
      }
      else if (cursor.tryKeyword("UNIQUE"))
      {
        if (cursor.tryKeyword("INDEX"))
        {
          parseCreateUniqueIndex(cursor);
        }
      }
      return;
    }
    if (cursor.tryKeyword("ALTER") && cursor.tryKeyword("TABLE"))
    {
      parseAlterTable(cursor);
    }
  }

  // ------------------------------------------------------------------
  // CREATE TABLE
  // ------------------------------------------------------------------

  private void parseCreateTable(Cursor cursor)
  {
    cursor.tryKeywords("IF", "NOT", "EXISTS");
    String[] name = qualifiedName(cursor);
    if (name == null || !cursor.tryPunctuation("("))
    {
      // CREATE TABLE ... AS SELECT, or a name we could not read
      return;
    }
    List<List<Token>> items = cursor.commaSeparatedGroup();

    List<ColumnDef> columns = new ArrayList<>();
    List<List<String>> keys = new ArrayList<>();
    for (List<Token> item : items)
    {
      if (item.isEmpty())
      {
        continue;
      }
      Token first = item.get(0);
      if (!first.quoted && CONSTRAINT_STARTS.contains(first.upper()))
      {
        List<String> key = tableConstraintKey(item);
        if (key != null)
        {
          keys.add(key);
        }
      }
      else
      {
        ColumnDef column = parseColumn(item, keys);
        if (column != null)
        {
          columns.add(column);
        }
      }
    }
    if (columns.isEmpty())
    {
      warnings.add("skipped table " + join(name) + ": no columns could be read");
      return;
    }
    tables.add(new TableDef(name[0], name[1], columns, keys));
  }

  /** @return the columns of a {@code PRIMARY KEY}/{@code UNIQUE} constraint, or null for any other */
  private List<String> tableConstraintKey(List<Token> item)
  {
    Cursor cursor = new Cursor(item);
    if (cursor.tryKeyword("CONSTRAINT"))
    {
      cursor.skipIdentifier(); // the constraint's own name, which we never refer to
    }
    if (cursor.tryKeyword("PRIMARY"))
    {
      cursor.tryKeyword("KEY");
    }
    else if (cursor.tryKeyword("UNIQUE"))
    {
      cursor.tryAnyKeyword("KEY", "INDEX");
    }
    else
    {
      return null; // FOREIGN KEY, CHECK, a plain (non-unique) KEY/INDEX: nothing we act on
    }
    cursor.skipUntilPunctuation("("); // an optional index name, and MySQL's USING BTREE
    if (!cursor.tryPunctuation("("))
    {
      return null;
    }
    return keyColumns(cursor.commaSeparatedGroup());
  }

  /**
   * @return the plain column names of a key, or null if any part of it is an expression, a
   *     prefix length or a sort direction -- none of which we can turn into a column ordinal
   */
  private List<String> keyColumns(List<List<Token>> items)
  {
    List<String> names = new ArrayList<>();
    for (List<Token> item : items)
    {
      if (item.size() != 1 || !item.get(0).isIdentifier())
      {
        return null;
      }
      names.add(identifier(item.get(0)));
    }
    return names.isEmpty() ? null : names;
  }

  /** Parses one column definition, appending to {@code keys} if it is declared a key inline. */
  private ColumnDef parseColumn(List<Token> item, List<List<String>> keys)
  {
    Cursor cursor = new Cursor(item);
    Token nameToken = cursor.next();
    if (!nameToken.isIdentifier())
    {
      return null;
    }
    String name = identifier(nameToken);

    StringBuilder rawType = new StringBuilder(cursor.hasNext() ? cursor.next().text : "");
    while (cursor.hasNext() && isTypeTail(rawType.toString(), cursor.peek()))
    {
      rawType.append(' ').append(cursor.next().text);
    }
    int precision = -1;
    int scale = -1;
    if (cursor.tryPunctuation("("))
    {
      List<List<Token>> args = cursor.commaSeparatedGroup();
      // ENUM('a','b') and SET(...) list values, not a width; only numbers are a width
      if (args.size() >= 1 && args.get(0).size() == 1 && args.get(0).get(0).isNumber())
      {
        precision = Integer.parseInt(args.get(0).get(0).text);
        if (args.size() >= 2 && args.get(1).size() == 1 && args.get(1).get(0).isNumber())
        {
          scale = Integer.parseInt(args.get(1).get(0).text);
        }
      }
    }
    if (cursor.tryPunctuation("["))
    {
      // an array type; there is no array in the encoding, so let it fall through as unknown
      cursor.tryPunctuation("]");
      rawType.append("[]");
    }

    boolean nullable = true;
    while (cursor.hasNext())
    {
      Token token = cursor.next();
      if (token.isPunctuation("("))
      {
        cursor.skipGroup(); // a CHECK, a DEFAULT expression, a REFERENCES column list
        continue;
      }
      if (token.quoted || token.isString())
      {
        continue;
      }
      String word = token.upper();
      if ("NOT".equals(word) && cursor.peekIsKeyword("NULL"))
      {
        cursor.next();
        nullable = false;
      }
      else if ("PRIMARY".equals(word) && cursor.peekIsKeyword("KEY"))
      {
        cursor.next();
        keys.add(Collections.singletonList(name));
      }
      else if ("UNIQUE".equals(word))
      {
        cursor.tryAnyKeyword("KEY", "INDEX");
        keys.add(Collections.singletonList(name));
      }
      else if ("DEFAULT".equals(word) && cursor.hasNext() && !cursor.peek().isPunctuation("("))
      {
        cursor.next(); // the default value, which says nothing about the column's type
      }
    }
    return new ColumnDef(name, rawType.toString(), precision, scale, nullable);
  }

  /** Whether {@code next} continues the type started by {@code soFar} rather than beginning a modifier. */
  private static boolean isTypeTail(String soFar, Token next)
  {
    if (next.quoted || !next.isWord())
    {
      return false;
    }
    String word = next.upper();
    if (TYPE_TAILS.contains(word))
    {
      return true;
    }
    String head = soFar.toUpperCase(Locale.ROOT);
    if ("CHARACTER".equals(word) && head.endsWith("NATIONAL"))
    {
      return true;
    }
    // "timestamp with time zone", "time without time zone", "timestamp with local time zone"
    return ("WITH".equals(word) || "WITHOUT".equals(word) || "LOCAL".equals(word)
               || "ZONE".equals(word) || "TIME".equals(word))
        && (head.startsWith("TIME") || head.startsWith("DATETIME"));
  }

  // ------------------------------------------------------------------
  // ALTER TABLE / CREATE UNIQUE INDEX
  // ------------------------------------------------------------------

  private void parseAlterTable(Cursor cursor)
  {
    cursor.tryKeyword("ONLY");
    cursor.tryKeywords("IF", "EXISTS");
    String[] name = qualifiedName(cursor);
    if (name == null || !cursor.tryKeyword("ADD"))
    {
      return;
    }
    if (cursor.tryKeyword("CONSTRAINT"))
    {
      cursor.skipIdentifier();
    }
    if (cursor.tryKeyword("PRIMARY"))
    {
      cursor.tryKeyword("KEY");
    }
    else if (!cursor.tryKeyword("UNIQUE"))
    {
      return;
    }
    if (!cursor.tryPunctuation("("))
    {
      return;
    }
    addPendingKey(name, keyColumns(cursor.commaSeparatedGroup()));
  }

  private void parseCreateUniqueIndex(Cursor cursor)
  {
    cursor.tryKeywords("IF", "NOT", "EXISTS");
    cursor.skipIdentifier(); // the index name
    if (!cursor.tryKeyword("ON"))
    {
      return;
    }
    String[] name = qualifiedName(cursor);
    if (name == null)
    {
      return;
    }
    cursor.skipUntilPunctuation("(");
    if (!cursor.tryPunctuation("("))
    {
      return;
    }
    List<String> columns = keyColumns(cursor.commaSeparatedGroup());
    if (cursor.remainingHasKeyword("WHERE"))
    {
      // a partial index: unique only among the rows it covers, so not a key of the table
      return;
    }
    addPendingKey(name, columns);
  }

  private void addPendingKey(String[] table, List<String> columns)
  {
    if (columns != null)
    {
      pendingKeys.add(table);
      pendingKeyColumns.add(columns);
    }
  }

  /** Attaches the keys named by ALTER TABLE / CREATE INDEX to the tables they belong to. */
  private void applyPendingKeys()
  {
    for (int i = 0; i < pendingKeys.size(); i++)
    {
      String[] name = pendingKeys.get(i);
      List<String> columns = pendingKeyColumns.get(i);
      TableDef table = find(name);
      if (table == null)
      {
        continue; // a key on a table we skipped
      }
      List<List<String>> keys = new ArrayList<>(table.keys());
      if (keys.contains(columns))
      {
        continue;
      }
      keys.add(columns);
      tables.set(tables.indexOf(table),
          new TableDef(table.schemaName(), table.name(), table.columns(), keys));
    }
  }

  private TableDef find(String[] name)
  {
    for (TableDef table : tables)
    {
      if (table.name().equals(name[1])
          && (name[0] == null || table.schemaName() == null || name[0].equals(table.schemaName())))
      {
        return table;
      }
    }
    return null;
  }

  // ------------------------------------------------------------------
  // shared helpers
  // ------------------------------------------------------------------

  /** @return {schema, table}, with a null schema when the name was not qualified */
  private String[] qualifiedName(Cursor cursor)
  {
    if (!cursor.hasNext() || !cursor.peek().isIdentifier())
    {
      return null;
    }
    List<String> parts = new ArrayList<>();
    parts.add(identifier(cursor.next()));
    while (cursor.tryPunctuation(".") && cursor.hasNext() && cursor.peek().isIdentifier())
    {
      parts.add(identifier(cursor.next()));
    }
    String table = parts.get(parts.size() - 1);
    // catalog.schema.table: the catalog is dropped, nothing here has more than one
    String schema = parts.size() >= 2 ? parts.get(parts.size() - 2) : null;
    return new String[] {schema, table};
  }

  /** Folds an identifier the way the dialect's parser would, so queries can find it again. */
  private String identifier(Token token)
  {
    return dialect.normalize(token.text, token.quoted);
  }

  private static String join(String[] name)
  {
    return name[0] == null ? name[1] : name[0] + "." + name[1];
  }
}
