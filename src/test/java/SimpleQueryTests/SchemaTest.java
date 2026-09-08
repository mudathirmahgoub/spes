package SimpleQueryTests;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import DbSchema.ColumnDef;
import DbSchema.DatabaseSchema;
import DbSchema.Dialect;
import DbSchema.TableDef;
import io.github.cvc5.Result;
import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import org.apache.calcite.rel.RelNode;
import org.apache.calcite.sql.type.SqlTypeName;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

/**
 * Tests for reading a schema out of a DDL file and checking queries against it.
 *
 * <p>Two things have to hold for a chosen schema to be usable. The tables have to come out of
 * the file with the columns, types and keys the file gave them -- that is most of what is
 * below. And the accent has to be applied to the schema and to the query in the same way, or
 * a query will not find a table that is right there; the tests that parse a query and look at
 * which table it resolved to are the ones pinning that down.
 */
public class SchemaTest
{
  private PrintStream stdout;

  @Before
  public void silenceParser()
  {
    stdout = System.out;
    System.setOut(new PrintStream(new ByteArrayOutputStream()));
  }

  @After
  public void restoreStdout()
  {
    System.setOut(stdout);
  }

  // ------------------------------------------------------------------
  // helpers
  // ------------------------------------------------------------------

  private static DatabaseSchema parse(String ddl, String dialect)
  {
    return DatabaseSchema.parse(ddl, Dialect.of(dialect));
  }

  private static List<String> columnNames(TableDef table)
  {
    List<String> names = new ArrayList<>();
    for (ColumnDef column : table.columns())
    {
      names.add(column.name());
    }
    return names;
  }

  private static ColumnDef column(TableDef table, String name)
  {
    int ordinal = table.indexOf(name);
    assertTrue("no column " + name + " in " + table, ordinal >= 0);
    return table.columns().get(ordinal);
  }

  /** The qualified name of the single table the query reads, as the plan sees it. */
  private static String scannedTable(DatabaseSchema schema, String sql) throws Exception
  {
    RelNode plan = new simpleParser(schema).getRelNode(sql);
    List<String> names = new ArrayList<>();
    collectTables(plan, names);
    assertEquals("expected exactly one table scan in " + sql, 1, names.size());
    return names.get(0);
  }

  private static void collectTables(RelNode node, List<String> names)
  {
    if (node.getTable() != null)
    {
      names.add(String.join(".", node.getTable().getQualifiedName()));
    }
    for (RelNode input : node.getInputs())
    {
      collectTables(input, names);
    }
  }

  // ------------------------------------------------------------------
  // the built-in schema
  // ------------------------------------------------------------------

  @Test
  public void builtInSchemaHasTheTablesItReplaced()
  {
    DatabaseSchema schema = DatabaseSchema.defaultSchema();
    assertTrue("the built-in schema should load cleanly, got " + schema.warnings(),
        schema.warnings().isEmpty());
    for (String name : Arrays.asList("EMP", "DEPT", "BONUS", "ACCOUNT", "T", "ANON"))
    {
      assertNotNull(name + " is missing from the built-in schema", schema.table(name));
    }
    assertEquals(
        Arrays.asList("EMPNO", "ENAME", "JOB", "MGR", "HIREDATE", "COMM", "SAL", "DEPTNO",
            "SLACKER"),
        columnNames(schema.table("EMP")));
    assertEquals(SqlTypeName.INTEGER, column(schema.table("EMP"), "EMPNO").typeName());
    assertEquals(SqlTypeName.VARCHAR, column(schema.table("EMP"), "ENAME").typeName());
  }

  @Test
  public void builtInSchemaKeepsEveryColumnOfTNotNull()
  {
    // T is the one table of the six whose columns were declared NOT NULL, and queries over it
    // are decided differently if that is lost
    for (ColumnDef column : DatabaseSchema.defaultSchema().table("T").columns())
    {
      assertFalse("T." + column.name() + " should be NOT NULL", column.nullable());
    }
    assertTrue("EMP.EMPNO should be nullable",
        column(DatabaseSchema.defaultSchema().table("EMP"), "EMPNO").nullable());
  }

  @Test
  public void everyBuiltInTableDeclaresItsFirstColumnUnique()
  {
    // what the six hand-written classes each claimed through their Statistic
    for (TableDef table : DatabaseSchema.defaultSchema().tables())
    {
      assertEquals(table.name() + " should have one key on its first column",
          Collections.singletonList(Collections.singletonList(table.columns().get(0).name())),
          table.keys());
    }
  }

  // ------------------------------------------------------------------
  // accents
  // ------------------------------------------------------------------

  @Test
  public void calciteFoldsUnquotedNamesUp()
  {
    DatabaseSchema schema = parse("CREATE TABLE emp (empno INT, \"Mixed\" INT)", "calcite");
    assertNotNull(schema.table("EMP"));
    assertEquals(Arrays.asList("EMPNO", "Mixed"), columnNames(schema.table("EMP")));
  }

  @Test
  public void postgresFoldsUnquotedNamesDown() throws Exception
  {
    DatabaseSchema schema =
        parse("CREATE TABLE EMP (EMPNO integer, \"Mixed\" integer)", "postgres");
    assertNotNull(schema.table("emp"));
    assertEquals(Arrays.asList("empno", "Mixed"), columnNames(schema.table("emp")));
    // and a query written in the same accent finds it, whichever case it uses
    assertEquals("emp", scannedTable(schema, "SELECT EMPNO FROM Emp"));
  }

  @Test
  public void mysqlKeepsCaseAndMatchesIgnoringIt() throws Exception
  {
    DatabaseSchema schema = parse("CREATE TABLE `Emp` (`empno` int(11))", "mysql");
    assertNotNull(schema.table("Emp"));
    assertEquals("Emp", scannedTable(schema, "SELECT EMPNO FROM EMP"));
  }

  @Test
  public void sqlServerReadsBracketedNames() throws Exception
  {
    DatabaseSchema schema =
        parse("CREATE TABLE [dbo].[emp] ([empno] int, [full name] nvarchar(max))", "mssql");
    TableDef table = schema.table("emp");
    assertNotNull(table);
    assertEquals("dbo", table.schemaName());
    assertEquals(Arrays.asList("empno", "full name"), columnNames(table));
    // nvarchar(max): a width that is not a number is no width at all
    assertEquals(SqlTypeName.VARCHAR, column(table, "full name").typeName());
  }

  @Test
  public void aliasesNameTheSameAccent()
  {
    assertEquals(Dialect.POSTGRESQL, Dialect.of("pg"));
    assertEquals(Dialect.POSTGRESQL, Dialect.of("PostgreSQL"));
    assertEquals(Dialect.SQLSERVER, Dialect.of("sql-server"));
    assertEquals(Dialect.MYSQL, Dialect.of("MariaDB"));
    assertEquals(Dialect.CALCITE, Dialect.of(null));
  }

  @Test
  public void anUnknownAccentSaysWhichOnesExist()
  {
    try
    {
      Dialect.of("teradata");
      fail("expected an unknown dialect to be rejected");
    }
    catch (IllegalArgumentException e)
    {
      assertTrue(e.getMessage(), e.getMessage().contains("teradata"));
      assertTrue(e.getMessage(), e.getMessage().contains("sqlite"));
    }
  }

  // ------------------------------------------------------------------
  // what a schema file can contain
  // ------------------------------------------------------------------

  @Test
  public void typesAreReadAcrossDialects()
  {
    DatabaseSchema schema = parse("CREATE TABLE a ("
            + "  a bigint, b int4, c mediumint, d character varying(30), e text, f char(25),"
            + "  g boolean, h tinyint(1), i timestamp without time zone, j double precision,"
            + "  k numeric(15, 2), l int unsigned, m nvarchar2(10))",
        "calcite");
    TableDef table = schema.table("A");
    assertEquals(SqlTypeName.BIGINT, column(table, "A").typeName());
    assertEquals(SqlTypeName.INTEGER, column(table, "B").typeName());
    assertEquals(SqlTypeName.INTEGER, column(table, "C").typeName());
    assertEquals(SqlTypeName.VARCHAR, column(table, "D").typeName());
    assertEquals(SqlTypeName.VARCHAR, column(table, "E").typeName());
    assertEquals(SqlTypeName.CHAR, column(table, "F").typeName());
    assertEquals(SqlTypeName.BOOLEAN, column(table, "G").typeName());
    assertEquals(SqlTypeName.INTEGER, column(table, "H").typeName());
    assertEquals(SqlTypeName.TIMESTAMP, column(table, "I").typeName());
    assertEquals(SqlTypeName.DOUBLE, column(table, "J").typeName());
    assertEquals(SqlTypeName.DECIMAL, column(table, "K").typeName());
    assertEquals(SqlTypeName.INTEGER, column(table, "L").typeName());
    assertEquals(SqlTypeName.VARCHAR, column(table, "M").typeName());
  }

  @Test
  public void notNullIsHonouredButPrimaryKeyDoesNotImplyIt()
  {
    // leaving a key column nullable only widens the set of databases a proof covers
    DatabaseSchema schema =
        parse("CREATE TABLE a (i INT PRIMARY KEY, j INT NOT NULL, k INT DEFAULT NULL)",
            "calcite");
    TableDef table = schema.table("A");
    assertTrue(column(table, "I").nullable());
    assertFalse(column(table, "J").nullable());
    assertTrue(column(table, "K").nullable());
    assertEquals(Collections.singletonList(Collections.singletonList("I")), table.keys());
  }

  @Test
  public void checkConstraintsDoNotLookLikeNotNull()
  {
    DatabaseSchema schema =
        parse("CREATE TABLE a (i INT CHECK (i IS NOT NULL AND i > 0))", "calcite");
    assertTrue(column(schema.table("A"), "I").nullable());
  }

  @Test
  public void keysComeFromEveryPlaceADumpPutsThem()
  {
    DatabaseSchema schema = parse("CREATE TABLE a (i INT, j INT, k INT, l INT, m INT, n INT);"
            + "ALTER TABLE ONLY a ADD CONSTRAINT a_pkey PRIMARY KEY (i);"
            + "CREATE UNIQUE INDEX a_j_idx ON a USING btree (j);"
            + "CREATE INDEX a_k_idx ON a (k);"
            + "CREATE UNIQUE INDEX a_l_idx ON a (l) WHERE (l IS NOT NULL);"
            + "CREATE UNIQUE INDEX a_m_idx ON a (lower(m));",
        "calcite");
    List<List<String>> keys = schema.table("A").keys();
    assertTrue("expected a key on I, got " + keys, keys.contains(Collections.singletonList("I")));
    assertTrue("expected a key on J, got " + keys, keys.contains(Collections.singletonList("J")));
    assertFalse("a non-unique index is not a key, got " + keys,
        keys.contains(Collections.singletonList("K")));
    assertFalse("a partial index is unique only over the rows it covers, got " + keys,
        keys.contains(Collections.singletonList("L")));
    assertFalse("an index over an expression names no column, got " + keys,
        keys.contains(Collections.singletonList("M")));
  }

  @Test
  public void compositeAndTableLevelKeysAreRead()
  {
    DatabaseSchema schema = parse(
        "CREATE TABLE a (i INT, j INT, k INT, PRIMARY KEY (i, j), UNIQUE KEY u (k),"
            + " FOREIGN KEY (k) REFERENCES b (x))",
        "calcite");
    assertEquals(Arrays.asList(Arrays.asList("I", "J"), Collections.singletonList("K")),
        schema.table("A").keys());
  }

  @Test
  public void everythingThatIsNotATableIsSkipped()
  {
    DatabaseSchema schema = parse("-- a comment\n"
            + "SET search_path = public;\n"
            + "CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;\n"
            + "/*!40101 SET NAMES utf8 */;\n"
            + "DROP TABLE IF EXISTS a;\n"
            + "CREATE TABLE a (i INT);\n"
            + "CREATE SEQUENCE a_i_seq START WITH 1;\n"
            + "CREATE VIEW v AS SELECT i FROM a;\n"
            + "CREATE FUNCTION f() RETURNS trigger AS $$ BEGIN RETURN NEW; END; $$ LANGUAGE plpgsql;\n"
            + "CREATE TABLE b (j INT);\n",
        "postgres");
    assertEquals(2, schema.tables().size());
    assertNotNull(schema.table("a"));
    assertNotNull(schema.table("b"));
  }

  @Test
  public void aTypeNobodyKnowsDoesNotStopTheRestLoading() throws Exception
  {
    DatabaseSchema schema =
        parse("CREATE TABLE odd (g geometry); CREATE TABLE fine (i INT)", "calcite");
    assertEquals(SqlTypeName.ANY, column(schema.table("ODD"), "G").typeName());
    assertEquals("FINE", scannedTable(schema, "SELECT i FROM fine"));
  }

  @Test
  public void aQualifiedTableIsReachableBothWays() throws Exception
  {
    DatabaseSchema schema = parse("CREATE TABLE public.emp (empno integer)", "postgres");
    assertEquals("public", schema.table("emp").schemaName());
    assertEquals("emp", scannedTable(schema, "SELECT empno FROM emp"));
    assertEquals("public.emp", scannedTable(schema, "SELECT empno FROM public.emp"));
  }

  // ------------------------------------------------------------------
  // the example files, and end to end
  // ------------------------------------------------------------------

  @Test
  public void theExampleSchemasLoadCleanly()
  {
    for (String name : Arrays.asList("postgres", "mysql", "sqlite"))
    {
      DatabaseSchema schema =
          DatabaseSchema.load("schemas/" + name + "_example.sql", Dialect.of(name));
      assertTrue(name + " example: " + schema.warnings(), schema.warnings().isEmpty());
      assertEquals(name + " example should have six tables", 6, schema.tables().size());
      assertNotNull(name + " example is missing emp", schema.table("emp"));
      assertEquals(name + " example: emp should have nine columns", 9,
          schema.table("emp").columns().size());
      assertEquals(name + " example: empno should be the key of emp",
          Collections.singletonList("empno"), schema.table("emp").keys().get(0));
    }
  }

  @Test
  public void sqliteTakesAllThreeQuotingStyles()
  {
    DatabaseSchema schema = DatabaseSchema.load("schemas/sqlite_example.sql", Dialect.SQLITE);
    assertEquals(Arrays.asList("ename", "job", "sal", "comm"),
        columnNames(schema.table("bonus")));
    assertEquals(SqlTypeName.VARCHAR, column(schema.table("bonus"), "job").typeName());
    assertEquals(SqlTypeName.VARCHAR, column(schema.table("account"), "type").typeName());
  }

  @Test
  public void aChosenSchemaDecidesWhichQueriesAreEquivalent() throws Exception
  {
    // SQLSolver's own example, schema and all
    DatabaseSchema schema = DatabaseSchema.parse(
        "CREATE TABLE a ( i INT PRIMARY KEY, j INT, k INT );\n"
            + "CREATE TABLE b ( x INT PRIMARY KEY, y INT, z INT );",
        Dialect.CALCITE);
    assertUnsat("a projection through a subquery changes nothing", "SELECT i, j FROM a",
        "SELECT T.COL1, T.COL2 FROM (SELECT i AS COL1, j AS COL2 FROM a) AS T", schema);
    assertUnsat("the same, over the other table", "SELECT x, y FROM b",
        "SELECT T.COL1, T.COL2 FROM (SELECT x AS COL1, y AS COL2 FROM b) AS T", schema);
  }

  @Test
  public void oneTableReachedTwoWaysIsOneTable() throws Exception
  {
    // if the qualified and unqualified paths made two SMT constants, this would come out sat
    DatabaseSchema schema =
        DatabaseSchema.parse("CREATE TABLE public.r (x INT, y INT)", Dialect.POSTGRESQL);
    assertUnsat("public.r and r are the same table", "SELECT x FROM r",
        "SELECT x FROM public.r", schema);
  }

  @Test
  public void queriesAreCheckedInTheAccentTheyAreWrittenIn() throws Exception
  {
    DatabaseSchema schema = DatabaseSchema.load("schemas/mysql_example.sql", Dialect.MYSQL);
    assertUnsat("back-quoted and bare names reach the same table",
        "SELECT `empno` FROM `emp`", "SELECT empno FROM EMP", schema);
  }

  private static void assertUnsat(String message, String sql1, String sql2,
      DatabaseSchema schema) throws Exception
  {
    PrintWriter writer = new PrintWriter(new StringWriter());
    Result result = Cvc5Analysis.verify(sql1, sql2, "schemaTest", writer, false, schema);
    assertNotNull("query was filtered out before translation", result);
    assertTrue(message + " -- expected unsat (equivalent) but got " + result, result.isUnsat());
  }
}
