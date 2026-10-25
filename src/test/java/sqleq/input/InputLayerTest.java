package sqleq.input;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;

import org.apache.calcite.sql.type.SqlTypeName;
import org.junit.Test;

/** The sqleq input layer, on the shapes its reductions and refusals are defined by. */
public class InputLayerTest {
  private static final String DDL = "create table \"t\" (\"id\" INTEGER PRIMARY KEY, \"a\" INTEGER, \"s\" TEXT, \"d\" INTERVAL DAY);\n";

  private static Frontend.Prepared prepare(String body) throws Unsupported {
    return Frontend.prepare(PairFile.parse("p", "-- truth: equivalent\n" + body));
  }

  private static String refusal(String body) {
    try {
      prepare(body);
      fail("expected a refusal");
      return null;
    } catch (Unsupported u) {
      return u.getMessage();
    }
  }

  @Test
  public void aPairFileIsCutWherePostgresCutsIt() throws Unsupported {
    PairFile pf = PairFile.parse("p", "-- truth: not-equivalent\n-- expect cvc5: model\n-- a prose comment: not a directive\n"
        + "create function f() returns int language sql as $$ select 1; $$;\n"
        + "create table t (a int); -- trailing\nSELECT 'x;y' FROM t;\nSELECT \"a;b\" FROM t;\n");
    assertEquals("not-equivalent", pf.truth());
    assertEquals("model", pf.directives.get("expect cvc5"));
    assertNull(pf.directives.get("a prose comment"));
    assertEquals(2, pf.ddl.size());
    assertEquals(Arrays.asList("SELECT 'x;y' FROM t", "SELECT \"a;b\" FROM t"), pf.statements);
  }

  @Test
  public void theCatalogReadsWhatAProverMayAssume() {
    Catalog c = Catalog.build(Arrays.asList(
        "create domain \"d\" as integer default nextval('s')",
        "create table \"t\" (\"id\" \"serial\", \"k\" INTEGER NOT NULL, \"u\" INTEGER, \"n\" numeric(10,2) default 0, \"x\" \"d\", "
            + "\"w\" INTEGER, \"ts\" timestamp with time zone default now(), unique (\"u\"), unique (\"k\"), "
            + "constraint fk foreign key (\"w\") references \"o\" (\"id\") on delete set null)",
        "create unique index i on \"t\" (\"w\") nulls not distinct",
        "create unique index j on \"t\" (lower(\"k\"))",
        "create trigger tr before insert on \"t\" for each row execute function f()",
        "alter table \"t\" alter column \"u\" set default 7, add column \"z\" text"));
    Catalog.Table t = c.table("t");
    assertEquals(Arrays.asList("id", "k", "u", "n", "x", "w", "ts", "z"), names(t));
    assertTrue(t.column("id").generated);
    assertEquals(Catalog.Type.INTEGER, t.column("id").type);
    assertTrue(t.column("id").notNull);
    assertFalse(t.column("x").rowDetermined);
    assertEquals(Catalog.Type.DECIMAL, t.column("n").type);
    assertEquals("(10,2)", t.column("n").typeArgs);
    assertTrue(t.column("n").rowDetermined);
    assertFalse(t.column("ts").rowDetermined);
    assertEquals(Catalog.Type.TIMESTAMP, t.column("ts").type);
    assertEquals("7", t.column("u").defaultExpr);
    assertTrue(t.hasTrigger);
    // the key over the nullable u is no key; k is NOT NULL; the NULLS NOT DISTINCT index is a key; the expression index is dropped
    assertEquals(Arrays.asList(Collections.singletonList("k"), Collections.singletonList("w")), t.proverKeys());
    assertEquals(1, t.foreignKeys.size());
    assertEquals("o", t.foreignKeys.get(0).refTable);
  }

  @Test
  public void droppedAndDeferredKeysAreNoKeys() {
    Catalog c = Catalog.build(Arrays.asList(
        "create table \"t\" (\"id\" INTEGER, \"a\" INTEGER NOT NULL, \"b\" INTEGER NOT NULL, \"d\" INTEGER NOT NULL, constraint \"t_pk\" primary key (\"id\"), unique (\"a\"))",
        "alter table \"t\" drop constraint \"t_pk\"",
        "alter table \"t\" drop constraint \"t_a_key\"",
        "create unique index \"i\" on \"t\" (\"b\")",
        "create index \"j\" on \"t\" (\"a\")",
        "create unique index if not exists \"j\" on \"t\" (\"d\")",
        "create unique index \"Ix\" on \"t\" (\"d\")",
        "alter index \"Ix\" rename to \"k\"",
        "drop index \"k\"",
        "alter table \"t\" add constraint \"u\" unique (\"a\") deferrable initially deferred"));
    assertEquals(Collections.singletonList(Collections.singletonList("b")), c.table("t").proverKeys());
    Catalog d = Catalog.build(Arrays.asList(
        "create table \"p\" (\"id\" INTEGER PRIMARY KEY DEFERRABLE INITIALLY DEFERRED, \"q\" INTEGER NOT NULL UNIQUE)",
        "create table \"c\" (\"x\" INTEGER) inherits (\"p\")"));
    assertTrue(d.table("p").proverKeys().isEmpty());
    assertEquals(Arrays.asList("id", "q", "x"), names(d.table("c")));
    assertTrue(d.table("c").proverKeys().isEmpty());
    Catalog e = Catalog.build(Arrays.asList("create table \"p\" (\"id\" INTEGER PRIMARY KEY, \"q\" INTEGER NOT NULL UNIQUE)"));
    assertEquals(2, e.table("p").proverKeys().size());
  }

  @Test
  public void renamesSchemasAndLikeFollowPostgres() {
    Catalog c = Catalog.build(Arrays.asList(
        "create table \"t\" (\"a\" INTEGER NOT NULL, \"b\" INTEGER, primary key (\"a\"))",
        "alter table \"t\" rename column \"a\" to \"c\"",
        "alter table \"t\" rename column \"b\" to \"a\"",
        "create table \"s\".\"u\" (\"id\" INTEGER PRIMARY KEY)",
        "create table \"o\" (\"id\" INTEGER)",
        "create table \"u\" (like \"o\")",
        "alter table \"o\" rename to \"o2\""));
    assertEquals(Arrays.asList("c", "a"), names(c.table("t")));
    assertTrue(c.table("t").column("c").notNull);
    assertFalse(c.table("t").column("a").notNull);
    assertEquals(Collections.singletonList(Collections.singletonList("c")), c.table("t").proverKeys());
    assertEquals(Collections.singletonList("id"), names(c.table("u")));
    Catalog g = Catalog.build(Arrays.asList("create table \"t\" (\"id\" BIGINT GENERATED BY DEFAULT AS IDENTITY, \"a\" INTEGER, \"d\" INTEGER GENERATED ALWAYS AS (\"a\" * 2) STORED)"));
    assertTrue(g.table("t").column("id").notNull);
    assertTrue(g.table("t").column("id").generated);
    assertNull(g.table("t").column("id").defaultExpr);
    assertTrue(g.table("t").column("d").generated);
    assertFalse(g.table("t").column("d").notNull);
    assertTrue(c.table("u").proverKeys().isEmpty());
    Catalog l = Catalog.build(Arrays.asList("create table \"o\" (\"id\" INTEGER PRIMARY KEY, \"k\" INTEGER NOT NULL UNIQUE)",
        "create table \"u\" (like \"o\" including indexes)", "create table \"s\".\"z\" (\"id\" INTEGER PRIMARY KEY)"));
    assertEquals(2, l.table("u").proverKeys().size());
    assertTrue(DdlOut.postgres(l).contains("\"z\"")); // alone in its schema: the bare name reaches it
    Catalog sh = Catalog.build(Arrays.asList("create table \"s\".\"z\" (\"id\" INTEGER PRIMARY KEY)",
        "create table \"z\" (\"id\" INTEGER)", "create table \"s\".\"v\" (\"id\" INTEGER)", "create view \"v\" as select 1 as \"id\"",
        "create table \"s\".\"w\" (\"id\" INTEGER)", "create table \"r\".\"w\" (\"id\" INTEGER)"));
    assertTrue(sh.table("z").proverKeys().isEmpty()); // the public table shadows the other schema's
    assertNull(sh.table("v")); // the view shadows it, and views are not read
    assertNull(sh.table("w")); // two schemas: ambiguous
    assertEquals(1, sh.table("s.w").columns.size());
    assertFalse(DdlOut.mysql(sh).contains("`v`"));
    assertFalse(DdlOut.mysql(sh).contains("`w`"));
    assertEquals(1, c.table("s.u").proverKeys().size());
    assertNull(c.table("o"));
    assertEquals(Collections.singletonList("id"), names(c.table("o2")));
  }

  @Test
  public void shapesCalciteDropsAreRefused() throws Unsupported {
    assertTrue(refusal(DDL + "SELECT id FROM t TABLESAMPLE BERNOULLI (0);\nSELECT id FROM t;\n").contains("TABLESAMPLE"));
    assertTrue(refusal(DDL + "SELECT array_agg(a) FROM (SELECT a FROM t ORDER BY id) AS s;\nSELECT array_agg(a) FROM t;\n").contains("ORDER BY inside a subquery"));
    assertTrue(refusal(DDL + "SELECT a FROM (SELECT a FROM t ORDER BY id) AS s LIMIT 1;\nSELECT a FROM t LIMIT 1;\n").contains("ORDER BY inside a subquery"));
    String fl = "create table \"f\" (\"x\" DOUBLE PRECISION, \"y\" INTEGER);\n";
    assertTrue(refusal(fl + "SELECT sum(x) FROM (SELECT x FROM f ORDER BY y) AS s;\nSELECT sum(x) FROM f;\n").contains("ORDER BY inside a subquery"));
    assertTrue(refusal(fl + "SELECT DISTINCT x FROM (SELECT x FROM f ORDER BY y) AS s;\nSELECT DISTINCT x FROM f;\n").contains("ORDER BY inside a subquery"));
    // integer columns only and a sum, a join or a UNION ALL downstream: nothing can see the order, as in Calcite's test pairs
    String ints = "create table \"t\" (\"id\" INTEGER PRIMARY KEY, \"a\" INTEGER, \"b\" INTEGER NOT NULL);\n";
    prepare(ints + "SELECT sum(a) FROM (SELECT a FROM t ORDER BY id) AS s;\nSELECT sum(a) FROM t;\n");
    prepare(ints + "SELECT * FROM t AS e RIGHT JOIN (SELECT * FROM t ORDER BY b) AS d ON e.id = d.id;\nSELECT * FROM t AS e RIGHT JOIN t AS d ON e.id = d.id;\n");
    prepare(ints + "SELECT * FROM ((SELECT a FROM t ORDER BY a) UNION ALL (SELECT a FROM t ORDER BY a)) AS u;\nSELECT * FROM (SELECT a FROM t UNION ALL SELECT a FROM t) AS u;\n");
    // the interval column of DDL makes a sum pick one spelling among equal values: refused there
    assertTrue(refusal(DDL + "SELECT sum(a) FROM (SELECT a FROM t ORDER BY id) AS s;\nSELECT sum(a) FROM t;\n").contains("ORDER BY inside a subquery"));
    prepare(DDL + "SELECT sum(a) FROM (SELECT a FROM t ORDER BY id LIMIT 2) AS s;\nSELECT sum(a) FROM t;\n");
    assertTrue(refusal(DDL + "SELECT 1 FROM t LEFT JOIN t AS u USING (id);\nSELECT 1 FROM t LEFT JOIN t AS u ON t.id = u.id;\n").contains("USING"));
    assertTrue(refusal(DDL + "SELECT 0b101 FROM t;\nSELECT 0 FROM t;\n").contains("numeric literal"));
    assertTrue(refusal(DDL + "SELECT 1 FROM t, t AS u FULL JOIN t AS v ON u.id = v.id;\nSELECT 1 FROM t;\n").contains("FROM list"));
    List<PgLexer.Token> toks = PgLexer.lex("SELECT 0b101, 1_000, 0x1F FROM t");
    assertEquals("0b101", toks.get(1).text);
    assertEquals("1_000", toks.get(3).text);
    assertEquals("0x1F", toks.get(5).text);
  }

  @Test
  public void aDeleteBecomesTheDeletedBag() throws Unsupported {
    Frontend.Prepared p = prepare(DDL + "DELETE FROM t WHERE a = 1 RETURNING id, *;\nDELETE FROM t AS x WHERE x.a = 1 RETURNING x.id, x.*;\n");
    assertEquals(Dml.Kind.DELETE, p.kind);
    assertEquals("SELECT * FROM t WHERE a = 1", p.q0);
    assertEquals("SELECT * FROM t AS x WHERE x.a = 1", p.q1);
  }

  @Test
  public void anUpdateProjectsEveryDeclaredColumn() throws Unsupported {
    Frontend.Prepared p = prepare(DDL + "UPDATE t SET a = a + 1 WHERE id = 3;\nUPDATE t SET a = 1 + a WHERE id = 3;\n");
    assertEquals("SELECT t.\"id\" AS \"id\", CASE WHEN (id = 3) THEN (a + 1) ELSE t.\"a\" END AS \"a\", t.\"s\" AS \"s\", t.\"d\" AS \"d\" FROM t", p.q0);
    Frontend.Prepared r = prepare(DDL + "UPDATE t SET a = a WHERE true RETURNING a;\nUPDATE t SET a = a WHERE false RETURNING a;\n");
    assertTrue(r.q0.startsWith("SELECT 0 AS q_goal, "));
    assertTrue(r.q0.contains(" UNION ALL SELECT 1 AS q_goal, "));
    assertTrue(r.q0.endsWith(" FROM t WHERE true"));
    assertTrue(r.q1.endsWith(" FROM t WHERE false"));
  }

  @Test
  public void anInsertBecomesItsSource() throws Unsupported {
    Frontend.Prepared p = prepare(DDL + "INSERT INTO t (id, a) VALUES (1, 2), (3, 4);\nINSERT INTO t (id, a) SELECT id, a FROM t WHERE a > 0;\n");
    assertEquals("VALUES (1, 2), (3, 4)", p.q0);
    assertEquals("SELECT id, a FROM t WHERE a > 0", p.q1);
    Frontend.Prepared v = prepare(DDL + "INSERT INTO t (id, a) VALUES ($1, $2);\nINSERT INTO t (id, a) VALUES ($1, $2 + 0);\n");
    assertEquals("VALUES (CAST($1 AS INTEGER), CAST($2 AS INTEGER))", v.q0);
    assertEquals("VALUES (CAST($1 AS INTEGER), $2 + 0)", v.q1);
    Frontend.Prepared r = prepare(DDL + "INSERT INTO t (id, a) VALUES (1, 2);\nINSERT INTO t (a, id) VALUES (1, 2);\n");
    assertEquals("SELECT \"id\", \"a\" FROM (VALUES (1, 2)) AS q_src(\"id\", \"a\")", r.q0);
    assertEquals("SELECT \"id\", \"a\" FROM (VALUES (1, 2)) AS q_src(\"a\", \"id\")", r.q1);
  }

  @Test
  public void theReductionsRefuseWhatTheyDoNotModel() {
    assertTrue(refusal(DDL + "DELETE FROM t WHERE a = 1;\nSELECT * FROM t WHERE a = 1;\n").contains("same kind"));
    assertTrue(refusal(DDL + "DELETE FROM t USING t AS u WHERE t.a = u.a;\nDELETE FROM t USING t AS u WHERE t.a = u.a;\n").contains("USING"));
    assertTrue(refusal(DDL + "UPDATE t SET a = 1 FROM t AS u WHERE t.a = u.a;\nUPDATE t SET a = 1 FROM t AS u WHERE t.a = u.a;\n").contains("FROM"));
    assertTrue(refusal(DDL + "UPDATE t SET a = DEFAULT;\nUPDATE t SET a = DEFAULT;\n").contains("DEFAULT"));
    assertTrue(refusal(DDL + "INSERT INTO t VALUES (1, 2);\nINSERT INTO t (id, a) VALUES (1, 2);\n").contains("without a column list"));
    assertTrue(refusal(DDL + "INSERT INTO t (id) VALUES (1) ON CONFLICT DO NOTHING;\nINSERT INTO t (id) VALUES (1) ON CONFLICT DO NOTHING;\n").contains("ON CONFLICT"));
    assertTrue(refusal(DDL + "DELETE FROM t WHERE a = 1 RETURNING id;\nDELETE FROM t WHERE a = 1;\n").contains("RETURNING"));
    assertTrue(refusal("create table \"t\" (\"id\" serial, \"a\" INTEGER);\nINSERT INTO t (a) VALUES (1), (2);\nINSERT INTO t (a) VALUES (2), (1);\n").contains("omits id"));
    assertTrue(refusal("create table \"t\" (\"id\" INTEGER, \"a\" INTEGER);\ncreate trigger tr before insert on \"t\" for each row execute function f();\n"
        + "INSERT INTO t (id, a) VALUES (1, 2);\nINSERT INTO t (id, a) VALUES (1, 2);\n").contains("trigger"));
    assertTrue(refusal(DDL + "UPDATE t SET s = a;\nUPDATE t SET s = a;\n").contains("spelling"));
    assertTrue(refusal(DDL + "INSERT INTO t (id, s) VALUES (1, 2.0);\nINSERT INTO t (id, s) VALUES (1, 2.00);\n").contains("spelling"));
    assertTrue(refusal(DDL + "UPDATE t SET d = d;\nUPDATE t SET d = d;\n").contains("spelling"));
    assertTrue(refusal(DDL + "WITH c AS (SELECT 1) DELETE FROM t WHERE a IN (SELECT * FROM c);\nDELETE FROM t WHERE a = 1;\n").contains("WITH"));
  }

  @Test
  public void aStoreIsAllowedWhereItsSpellingIsFixed() throws Unsupported {
    Frontend.Prepared p = prepare(DDL + "UPDATE t SET s = 'x' WHERE id = $1;\nUPDATE t SET s = s WHERE id = $1 AND false;\n");
    assertEquals(Dml.Kind.UPDATE, p.kind);
    Frontend.Prepared q = prepare(DDL + "INSERT INTO t (id, s) VALUES (1, 'x'), (2, NULL);\nINSERT INTO t (id, s) SELECT id, s FROM t;\n");
    assertEquals(Dml.Kind.INSERT, q.kind);
  }

  @Test
  public void postgresSpellingsBecomeCalcites() throws Unsupported {
    assertEquals("SELECT CAST(a AS INTEGER), CAST((a + b) AS DECIMAL(10,2)), CAST(f(x) AS VARCHAR), CAST(t.a AS BIGINT) FROM t",
        Rewrites.rewrite("SELECT a::int, (a + b)::numeric(10,2), f(x)::text, t.a::int8 FROM t"));
    assertEquals("SELECT CAST(CAST(a AS VARCHAR) AS INTEGER) FROM t", Rewrites.rewrite("SELECT a::text::int FROM t"));
    assertEquals("SELECT CAST(x AS VARCHAR), CAST(y AS TIMESTAMP) FROM t",
        Rewrites.rewrite("SELECT CAST(x AS text), CAST(y AS timestamp with time zone) FROM t"));
    assertEquals("SELECT INTERVAL '3' DAY, INTERVAL '14' DAY FROM t", Rewrites.rewrite("SELECT INTERVAL '3 days', INTERVAL '2 weeks' FROM t"));
    assertEquals("SELECT CAST(CASE WHEN a THEN 1 ELSE 2 END AS BIGINT) FROM t",
        Rewrites.rewrite("SELECT CASE WHEN a THEN 1 ELSE 2 END::bigint FROM t"));
    try {
      Rewrites.rewrite("SELECT a::int[] FROM t");
      fail();
    } catch (Unsupported u) {
      assertTrue(u.getMessage().contains("array"));
    }
    try {
      Rewrites.rewrite("SELECT a::uuid FROM t");
      fail();
    } catch (Unsupported u) {
      assertTrue(u.getMessage().contains("uuid"));
    }
  }

  @Test
  public void parametersBecomeOneSharedSymbolOfTheWidestType() throws Unsupported {
    String q = "SELECT id FROM t WHERE n = $1 AND $1 > 0 AND s = $2";
    assertEquals("SELECT id FROM t WHERE n = ? AND ? > 0 AND s = ?", ParamTypes.withQuestionMarks(q));
    assertEquals("SELECT id FROM t WHERE n = qp_1() AND qp_1() > 0 AND s = qp_2()", ParamTypes.withCalls(q, "qp_"));
    assertEquals(Arrays.asList(1, 1, 2), ParamTypes.occurrences(q));
    assertEquals(new TreeSet<Integer>(Arrays.asList(1, 2)), ParamTypes.params(q));
    Map<Integer, List<SqlTypeName>> seen = new HashMap<Integer, List<SqlTypeName>>();
    seen.put(1, Arrays.asList(SqlTypeName.DECIMAL, SqlTypeName.INTEGER));
    seen.put(2, Arrays.asList(SqlTypeName.VARCHAR, SqlTypeName.CHAR));
    Map<Integer, SqlTypeName> types = ParamTypes.unify(new TreeSet<Integer>(Arrays.asList(1, 2)), seen);
    assertEquals(SqlTypeName.DECIMAL, types.get(1));
    assertEquals(SqlTypeName.VARCHAR, types.get(2));
    seen.put(1, Arrays.asList(SqlTypeName.INTEGER, SqlTypeName.VARCHAR));
    try {
      ParamTypes.unify(new TreeSet<Integer>(Arrays.asList(1)), seen);
      fail();
    } catch (Unsupported u) {
      assertTrue(u.getMessage().contains("conflicting"));
    }
  }

  @Test
  public void theDdlIsWrittenBackInEachProversAccent() {
    Catalog c = Catalog.build(Arrays.asList("create table \"t\" (\"id\" INTEGER PRIMARY KEY, \"s\" TEXT, \"n\" numeric(10,2) NOT NULL, \"j\" jsonb, unique (\"n\"))"));
    assertEquals(Catalog.Type.OPAQUE, c.table("t").column("j").type);
    assertEquals("CREATE TABLE `t` (\n  `id` int not null,\n  `s` text,\n  `n` decimal(10,2) not null,\n  `j` blob,\n"
        + "  PRIMARY KEY (`id`),\n  UNIQUE KEY `uk_1` (`n`)\n);\n\n", DdlOut.mysql(c));
    assertEquals("create table \"t\" (\n  \"id\" integer NOT NULL,\n  \"s\" text,\n  \"n\" numeric(10,2) NOT NULL,\n  \"j\" text,\n"
        + "  PRIMARY KEY (\"id\"),\n  UNIQUE (\"n\")\n);\n\n", DdlOut.postgres(c).replace("\"j\" bytea", "\"j\" text"));
  }

  private static List<String> names(Catalog.Table t) {
    List<String> out = new java.util.ArrayList<String>();
    for (Catalog.Column c : t.columns) {
      out.add(c.name);
    }
    return out;
  }
}
