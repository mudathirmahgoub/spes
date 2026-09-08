package DbSchema;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UncheckedIOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import org.apache.calcite.schema.SchemaPlus;
import org.apache.calcite.schema.impl.AbstractSchema;
import org.apache.calcite.sql.parser.SqlParser;
import org.apache.calcite.tools.Frameworks;

/**
 * The set of tables a query is checked against, read from a DDL file.
 *
 * <p>This replaces the six hand-written {@code Table} classes the project used to be wired to.
 * A schema is now an argument: any file of {@code CREATE TABLE} statements will do, in any of
 * the accents {@link Dialect} knows, and {@link #DEFAULT_SCHEMA the default} is just one such
 * file that happens to describe Calcite's {@code EMP}/{@code DEPT} test tables.
 *
 * <pre>
 *   DatabaseSchema schema = DatabaseSchema.load("schemas/tpch.sql", Dialect.of("postgres"));
 *   RelNode plan = new simpleParser(schema).getRelNode("SELECT * FROM lineitem");
 * </pre>
 *
 * <p>Tables are registered twice when the DDL qualifies them: {@code CREATE TABLE public.emp}
 * can be read as {@code emp} or as {@code public.emp}.
 */
public final class DatabaseSchema
{
  /** The tables the project was hard-wired to before a schema could be chosen. */
  public static final String DEFAULT_SCHEMA = "schemas/calcite.sql";

  private static DatabaseSchema defaultInstance;

  private final Dialect dialect;
  private final List<TableDef> tables;
  private final Map<String, TableDef> byName;
  private final List<String> warnings;
  private final String origin;
  private SchemaPlus rootSchema;

  private DatabaseSchema(
      Dialect dialect, List<TableDef> tables, List<String> warnings, String origin)
  {
    this.dialect = dialect;
    this.tables = Collections.unmodifiableList(new ArrayList<>(tables));
    this.warnings = new ArrayList<>(warnings);
    this.origin = origin;
    this.byName = new LinkedHashMap<>();
    for (TableDef table : tables)
    {
      TableDef clash = byName.put(table.name(), table);
      if (clash != null)
      {
        this.warnings.add("two tables are both named " + table.name() + " ("
            + clash.qualifiedName() + " and " + table.qualifiedName()
            + "); the unqualified name refers to the second");
      }
    }
  }

  /** Reads a schema from DDL text. */
  public static DatabaseSchema parse(String ddl, Dialect dialect)
  {
    return parse(ddl, dialect, "<inline DDL>");
  }

  private static DatabaseSchema parse(String ddl, Dialect dialect, String origin)
  {
    DdlParser parser = new DdlParser(dialect);
    List<TableDef> tables = parser.parse(ddl);
    return new DatabaseSchema(dialect, tables, parser.warnings(), origin);
  }

  /**
   * Reads a schema from a file, a classpath resource, or DDL given literally -- whichever
   * {@code source} turns out to be, tried in that order. The last case is what makes
   * {@code -Dschema='CREATE TABLE r (x INT)'} work.
   */
  public static DatabaseSchema load(String source, Dialect dialect)
  {
    if (source == null || source.trim().isEmpty())
    {
      return defaultSchema();
    }
    Path path = asPath(source);
    if (path != null && Files.isReadable(path))
    {
      try
      {
        return parse(new String(Files.readAllBytes(path), StandardCharsets.UTF_8), dialect,
            path.toString());
      }
      catch (IOException e)
      {
        throw new UncheckedIOException("could not read schema file " + source, e);
      }
    }
    String resource = readResource(source);
    if (resource != null)
    {
      return parse(resource, dialect, "classpath:" + source);
    }
    if (source.toUpperCase(Locale.ROOT).contains("CREATE"))
    {
      return parse(source, dialect, "<inline DDL>");
    }
    throw new IllegalArgumentException("no schema file, classpath resource or DDL text at '"
        + source + "'");
  }

  /** The built-in schema: Calcite's {@code EMP}/{@code DEPT} test tables, in Calcite's accent. */
  public static synchronized DatabaseSchema defaultSchema()
  {
    if (defaultInstance == null)
    {
      String ddl = readResource(DEFAULT_SCHEMA);
      if (ddl == null)
      {
        throw new IllegalStateException("the built-in schema " + DEFAULT_SCHEMA
            + " is missing from the classpath");
      }
      defaultInstance = parse(ddl, Dialect.CALCITE, "classpath:" + DEFAULT_SCHEMA);
    }
    return defaultInstance;
  }

  private static Path asPath(String source)
  {
    try
    {
      return Paths.get(source);
    }
    catch (RuntimeException e)
    {
      return null; // DDL text given literally is not a path on every platform
    }
  }

  private static String readResource(String name)
  {
    ClassLoader loader = DatabaseSchema.class.getClassLoader();
    try (InputStream stream = loader.getResourceAsStream(name))
    {
      if (stream == null)
      {
        return null;
      }
      ByteArrayOutputStream bytes = new ByteArrayOutputStream();
      byte[] buffer = new byte[8192];
      int read;
      while ((read = stream.read(buffer)) > 0)
      {
        bytes.write(buffer, 0, read);
      }
      return new String(bytes.toByteArray(), StandardCharsets.UTF_8);
    }
    catch (IOException e)
    {
      throw new UncheckedIOException("could not read the schema resource " + name, e);
    }
  }

  public Dialect dialect()
  {
    return dialect;
  }

  public List<TableDef> tables()
  {
    return tables;
  }

  /** @return the table of that (already dialect-folded) name, or null */
  public TableDef table(String name)
  {
    return byName.get(name);
  }

  /** What was skipped or looked wrong while reading the file. Empty for a clean schema. */
  public List<String> warnings()
  {
    return Collections.unmodifiableList(warnings);
  }

  /** The Calcite root schema holding these tables; built once and shared by every planner. */
  public synchronized SchemaPlus rootSchema()
  {
    if (rootSchema == null)
    {
      SchemaPlus root = Frameworks.createRootSchema(true);
      Map<String, SchemaPlus> subSchemas = new LinkedHashMap<>();
      for (TableDef table : tables)
      {
        root.add(table.name(), table);
        if (table.schemaName() != null)
        {
          SchemaPlus subSchema = subSchemas.get(table.schemaName());
          if (subSchema == null)
          {
            subSchema = root.add(table.schemaName(), new AbstractSchema());
            subSchemas.put(table.schemaName(), subSchema);
          }
          subSchema.add(table.name(), table);
        }
      }
      rootSchema = root;
    }
    return rootSchema;
  }

  /** How queries against this schema must be parsed for their identifiers to match it. */
  public SqlParser.Config parserConfig()
  {
    return dialect.parserConfig();
  }

  /** A one-line summary for the log line that says which schema a run used. */
  public String describe()
  {
    List<String> names = new ArrayList<>();
    for (TableDef table : tables)
    {
      names.add(table.name());
    }
    return origin + " (" + dialect + "): " + tables.size() + " table"
        + (tables.size() == 1 ? "" : "s") + (names.isEmpty() ? "" : " -- " + String.join(", ", names));
  }

  @Override
  public String toString()
  {
    return describe();
  }
}
