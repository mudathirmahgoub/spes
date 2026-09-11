# SQL Query Equivalence

Checks whether two SQL queries always return the same table. The queries are parsed with
Apache Calcite, translated into an SMT problem, and solved with cvc5.

| result | meaning |
| --- | --- |
| `unsat` | the queries are **equivalent** |
| `sat` | the queries **differ**, and the model is a database that shows how -- written out as a [SQLite file](#look-at-a-counterexample) |
| `unknown` | the solver ran out of time (10 s per query) |

## Setup

You need a JDK, Maven, git and cmake with a C++ toolchain. No database server: a
[counterexample](#look-at-a-counterexample) is replayed in SQLite, which comes with its JDBC
driver as a library, and the `sqlite3` command line is only wanted if you go on to open one of
the files by hand.

```bash
mvn initialize      # one-time: fetches z3, then clones and builds cvc5
mvn test            # build and run the tests
```

`initialize` builds cvc5 from the `bags-map-up-pair` branch of
[mudathirmahgoub/cvc5](https://github.com/mudathirmahgoub/cvc5) into
`~/.cache/cvc5/bags-map-up-pair`, because the primary-key constraints below need a rule that
is not in a released cvc5 yet. Expect it to take a while the first time; afterwards the step
sees the jar and does nothing. Delete that directory to rebuild, change `cvc5.git.branch` in
the pom to track a different branch, or pass `-Dcvc5.home=<install dir>` to use a build of
your own and skip this entirely.

## Compare two queries

```bash
mvn exec:exec \
  -Dq1='SELECT * FROM (VALUES (1),(1)) AS t UNION SELECT * FROM (VALUES (1)) AS u' \
  -Dq2='SELECT * FROM (VALUES (1),(1)) AS t'
```

```
q1        : SELECT * FROM (VALUES (1),(1)) AS t UNION SELECT * FROM (VALUES (1)) AS u
q2        : SELECT * FROM (VALUES (1),(1)) AS t
semantics : bags
smt2 file : single.smt2
result: sat -- the queries are NOT equivalent
elapsed: 65 ms
```

Wrap queries in **single** quotes, or the shell will eat column names like `EXPR$0`.

## Compare a whole file of queries

```bash
mvn exec:exec -Dbatch=testData/no_aggregation.json -Dout=/tmp/out.smt2
```

One line is printed per query pair:

```
; RESULT testEmptyMinus equivalent
```

| verdict | meaning |
| --- | --- |
| `equivalent` | proved equivalent |
| `inequivalent` | a counterexample database was found, and written to `counterexamples/<name>.db` |
| `unknown` | timed out |
| `skipped` | uses a construct the translator does not support |
| `error` | translation failed |
| `filtered` | excluded before parsing (`ORDER BY`) |

Expect around 25 minutes per file: most queries over `EMP`/`DEPT` reach the 10 s limit.

The pairs in `testData/*.json` are written against the default schema; give `-Dschema` a file
of your own to run them, or your own pairs, against other tables.

## Look at a counterexample

`sat` means some database makes the two queries return different tables, and the solver's model
is that database. Every `sat` writes that database out as a SQLite file -- one per inequivalent
pair, named after the pair -- holding the rows, both queries, and the rows they disagree on:

```bash
mvn exec:exec -Dq1='SELECT deptno, name FROM dept' \
              -Dq2='SELECT deptno, name FROM dept WHERE deptno > 3'
```

```
; CREATE TABLE "DEPT" ("DEPTNO" INTEGER, "NAME" TEXT)
; INSERT INTO "DEPT" ("DEPTNO", "NAME") VALUES (3, '')
; counterexample database: counterexamples/commandLine.db
; SELECT * FROM difference
; c1 | c2 | in_q1 | in_q2
; 3 |  | 1 | 0
; counterexample confirmed: sqlite has q1 and q2 disagreeing on 1 row of this database
```

Nothing needs to be set up to look at it afterwards, because the data and the queries are both
in the file:

```bash
sqlite3 counterexamples/commandLine.db 'SELECT * FROM q1'          # 3|
sqlite3 counterexamples/commandLine.db 'SELECT * FROM q2'          # no rows
sqlite3 counterexamples/commandLine.db 'SELECT * FROM difference'
sqlite3 counterexamples/commandLine.db 'SELECT * FROM spes_info'   # what this file is
sqlite3 counterexamples/commandLine.db .schema
```

| object | what it holds |
| --- | --- |
| one table per table the queries read | the counterexample, as the model gave it |
| `q1`, `q2` | the two queries, as views, columns renamed `c1 ... cn` |
| `difference` | the rows they disagree on, and how many copies each query returns there |
| `spes_info` | the pair's name, the semantics, both queries as written, the declared keys |

`difference` counts copies rather than saying `EXCEPT ALL`, which SQLite does not have: under
bag semantics one copy of `(1)` and two copies of `(1)` is a difference, and the
duplicate-eliminating `EXCEPT` would report those two queries as agreeing. Under `-Dsem=sets`
it compares presence instead, since that is what the model was found under.

The queries are the ones you gave, with two adjustments -- both visible in `spes_info` when
they apply. Calcite calls an unaliased expression `EXPR$0` and SQLite calls that column of a
`VALUES` table `column1`, so the name is rewritten; and a table the schema qualified
(`public.emp`) is created unqualified, since SQLite has no schemas. Declared keys are recorded
in `spes_info` rather than put in the DDL: `PRIMARY KEY` in a schema file here does not imply
`NOT NULL` (see [what is read out of a schema file](#what-is-read-out-of-a-schema-file)),
while SQLite's `INTEGER PRIMARY KEY` refuses a null and invents a value in its place, which
would silently replace the counterexample being looked at.

### What the replay tells you

Running the queries checks the translation, not the solver -- the verdict is already decided,
and the replay only says whether a real engine agrees with it. The lines to read are these.

- **`counterexample confirmed`** -- SQLite returns different results for `q1` and `q2` on this
  database. The model is a genuine counterexample.
- **`counterexample NOT confirmed`** -- SQLite returns the same results, so one of the two
  encodings does not mean what its query means. This is the failure a `sat` answer cannot show
  on its own, and it is worth chasing. Under `-Dsem=sets` it can be the approximation instead of
  a bug: that encoding drops multiplicities, reading `EXCEPT ALL` and its relatives as their
  duplicate-eliminating forms, so a model can distinguish two queries that SQL does not.
- **`could not run the queries`** -- SQLite refused one of them, usually a function it does not
  have. The file still holds the data and `spes_info`, and the verdict is unaffected; only the
  second opinion is missing. Two of the 47 pairs `no_aggregation_sat.json` decides land here,
  one writing `SUBSTRING(x FROM 1 FOR 3)` and one `ROW(7 + 8)`; the other 45 are confirmed.

`-Dcex=postgres` runs the same check against a PostgreSQL server on localhost instead, in
temporary tables that go away with the connection and with no file left behind;
`-Dcex=postgres -Dcex.url=<jdbc url>` points it at a server of your own. `-Dcex=none` skips the
replay altogether.

## Choose a schema

Queries are checked against a set of tables. Without any option those tables are Calcite's
`EMP`/`DEPT` test schema, kept in
[schemas/calcite.sql](src/main/resources/schemas/calcite.sql). Point `-Dschema` at a file of
`CREATE TABLE` statements to use your own:

```bash
mvn exec:exec -Dschema=schemas/postgres_example.sql -Ddialect=postgres \
  -Dq1='SELECT empno, deptno FROM emp' \
  -Dq2='SELECT e.empno, e.deptno FROM emp AS e'
```

The run begins by printing what it read:

```
; schema    : classpath:schemas/postgres_example.sql (postgresql): 6 tables -- dept, emp, bonus, account, t, anon
result: unsat -- the queries are EQUIVALENT
```

`-Dschema` takes a path, a classpath resource, or the DDL itself — the last is how SQLSolver's
API passes a schema, and it is useful for a one-off table:

```bash
mvn exec:exec -Dschema='CREATE TABLE r (x INT PRIMARY KEY, y INT)' \
  -Dq1='SELECT x FROM r' -Dq2='SELECT r.x FROM r'
```

```
; schema    : <inline DDL> (calcite): 1 table -- R
result: unsat -- the queries are EQUIVALENT
```

The schema applies to a `-Dbatch` file exactly as it does to a single pair.

### Accents

`-Ddialect` says which SQL the schema **and the queries** are written in — chiefly how a name
that was not quoted is folded, which is the difference between finding a table and not
finding it. `CREATE TABLE emp` registers `EMP` under Calcite's rules and `emp` under
PostgreSQL's; the same rule is then applied to the query, so both find the table either way.

| dialect | also known as | quotes | unquoted names | lookup |
| --- | --- | --- | --- | --- |
| `calcite` (default) | `ansi`, `standard`, `h2` | `"x"` | fold to upper case | case sensitive |
| `postgresql` | `postgres`, `pg`, `redshift` | `"x"` | fold to lower case | case sensitive |
| `mysql` | `mariadb` | `` `x` `` | kept as written | ignores case |
| `sqlite` | `sqlite3` | `"x"` | kept as written | ignores case |
| `sqlserver` | `mssql`, `tsql` | `[x]` | kept as written | ignores case |
| `oracle` | | `"x"` | fold to upper case | case sensitive |
| `spark` | `hive` | `` `x` `` | kept as written | ignores case |
| `bigquery` | `bq` | `` `x` `` | kept as written | ignores case |

The dialect also picks Calcite's conformance level, so MySQL's `!=`, SQL Server's `APPLY` and
PostgreSQL's `GROUP BY` ordinals are accepted where they belong. That cuts both ways, and a
query is not always portable between accents: of the 134 pairs in `calcite_tests.json` that
this project decides quickly, six stop parsing under `postgres` because they name Calcite's
generated `EXPR$0` column unquoted (PostgreSQL folds that to `expr$0`), and one stops under
`mysql` and `sqlite` because `GROUP BY 4` is an ordinal there and a constant under Calcite.
The other 127 are decided identically in all four.

The same six tables are written out in three accents as worked examples — read them for what
each reader tolerates:
[postgres](src/main/resources/schemas/postgres_example.sql) (a `pg_dump`, keys in
`ALTER TABLE`), [mysql](src/main/resources/schemas/mysql_example.sql) (a `mysqldump`, back
quotes and `ENGINE=` trailers), [sqlite](src/main/resources/schemas/sqlite_example.sql)
(`TEXT`, `AUTOINCREMENT`, three quoting styles at once).

### What is read out of a schema file

`CREATE TABLE` gives the columns and their types; `PRIMARY KEY`, `UNIQUE` and
`CREATE UNIQUE INDEX` give the keys, whether written inline, as a table constraint, or in a
later `ALTER TABLE ... ADD CONSTRAINT`. Everything else a dump contains — views, sequences,
triggers, `SET`, non-unique indexes, `/*!40101 ... */` blocks — is skipped, so a
332-table `pg_dump` loads even though a query touches four of its tables.

Three things are worth knowing before trusting a verdict:

- **Declared keys are enforced.** Every `PRIMARY KEY` and `UNIQUE` becomes two quantifier-free
  facts about the table's bag: the key columns hold no null, and
  `setof(project_K(T)) = project_K(T)`, so the bag of key values has no repeats. Both are
  annotated in the generated SMT-LIB, since they come from the schema rather than from either
  query:

  ```smtlib
  ; key DEPT (DEPTNO): column DEPTNO holds no null
  (assert (= (bag.count (tuple (as nullable.null (Nullable Int))) ((_ table.project 0) DEPT)) 0))
  ; key DEPT (DEPTNO): no two rows agree on it, so its values form a set
  (assert (= (bag.setof ((_ table.project 0) DEPT)) ((_ table.project 0) DEPT)))
  ```

  Without them a table is an unconstrained bag and a counterexample can be a database the
  schema forbids — `testWhereInCorrelated` was called inequivalent on a `DEPT` holding two
  copies of `(deptno=0, name='')`. Calcite is not told about keys either: this pipeline
  converts SQL to relational algebra without an optimizer pass, and every query in `testData/`
  parses to the same plan with and without them, so the constraints act on the solver alone.

  A `UNIQUE` key is treated like a `PRIMARY KEY`, which is too strong when its column is
  nullable, since SQL admits repeated nulls there. Drop the constraint from the schema file if
  that matters for your tables.
- **`PRIMARY KEY` is not read as `NOT NULL`.** Only an explicit `NOT NULL` makes a column
  non-null, because leaving a column nullable only widens the set of databases a proof has to
  cover.
- **A type nobody recognises becomes `ANY`,** which every query over that table then fails on
  with `unsupported sql type`. Integer widths are all one integer and `text`/`varchar` are one
  string, since the solver has neither machine words nor fixed-width strings; `DECIMAL`,
  `DATE` and `TIMESTAMP` are read faithfully and then rejected by the translator, which does
  not encode them.

## Options

All options are passed as `-Dname=value`.

| option | description | default |
| --- | --- | --- |
| `q1` | first SQL query | — |
| `q2` | second SQL query | — |
| `batch` | JSON file of query pairs to run instead of `q1`/`q2` | `testData/no_aggregation_sat.json` |
| `sem` | `bags` counts duplicate rows, `sets` ignores them | `bags` |
| `out` | where to write the generated SMT-LIB | `single.smt2` |
| `schema` | schema file, classpath resource, or DDL text | `schemas/calcite.sql` |
| `dialect` | which SQL the schema and queries are written in | `calcite` |
| `cex` | where a counterexample is replayed: `sqlite`, `postgres`, `none` | `sqlite` |
| `cex.dir` | directory the SQLite counterexample files are written to | `counterexamples` |
| `cex.url` | JDBC URL for `-Dcex=postgres` | `jdbc:postgresql://localhost/template1?user=postgres&password=abc` |
| `cvc5.home` | use a cvc5 build of your own instead of the branch build | — |

`sem=sets` is faster and proves more, but treats `UNION ALL` like `UNION`, so use it only
when duplicate rows do not matter.

Give `out` a path outside the repository, otherwise it overwrites the committed results.

Test data lives in `testData/*.json`, each a list of `{name, q1, q2}`.
`no_aggregation.json` holds equivalent pairs; `no_aggregation_sat.json` holds pairs that
were deliberately made inequivalent.

## Looking at the SMT-LIB

Every run writes the problem it sent to the solver, so you can re-run it by hand and ask
what each query actually evaluated to.

This needs the `cvc5` command-line binary, which nothing above requires — the project uses
cvc5 as a library. Grab one from the
[cvc5 releases](https://github.com/cvc5/cvc5/releases) and put it on your `PATH`, or use
`<your cvc5>/build/bin/cvc5` if you built it yourself.

```bash
sed -n '1,/^(check-sat)/p' single.smt2 | grep -v '^(assert (not (= q1 q2)))$' > /tmp/eval.smt2
echo '(get-value (q1 q2))' >> /tmp/eval.smt2
cvc5 /tmp/eval.smt2
```

```
sat
((q1 (bag (tuple (nullable.some 1)) 1)) (q2 (bag (tuple (nullable.some 1)) 2)))
```

q1 has one copy of row `(1)` and q2 has two — which is what SQL says, so the translation is
faithful here.

## Using your own cvc5 build

Only needed if you are changing cvc5 itself. Build it with the Java bindings:

```bash
./configure.sh production --auto-download --java-bindings --prefix=$PWD/build/install
cd build && make -j8 && make install
```

then point any command at it:

```bash
mvn -Dcvc5.home=/path/to/cvc5/build/install exec:exec -Dq1='...' -Dq2='...'
```

## More

- [sql features.md](src/test/java/SimpleQueryTests/sql%20features.md) — which SQL
  constructs are supported, how they are encoded, and benchmark results.
