# The cvc5 translator on sqleq's input

The translator (`Cvc5BagsTranslator`, `Cvc5SetsTranslator`) encodes two Calcite plans over a
`DatabaseSchema` and asks cvc5 whether a database distinguishes them. Datadog's
[sqleq](https://github.com/DataDog/sqleq) checks pairs written against PostgreSQL, with `$N`
parameters and `DELETE`/`UPDATE`/`INSERT` pairs among them. The `sqleq` package under
`src/test/java` reads that input and hands the translator what it already takes: a schema and two
plans. The encoding is not changed, with one addition: a call of a function the plan declares and
the DDL does not define (a sqleq `declare` line, or a parameter `qp_N()`) is an uninterpreted
function over nullable sorts, one symbol per name shared by both queries.

```sh
mvn test-compile
bin/sqleq-cvc5 --semantics=bags --timeout=10 --jobs=4 --out=results.csv --smt=problems ~/sqleq/tests/pairs ~/sqleq/examples
bin/sqleq-cvc5 --semantics=sets ...
```

The wrapper takes the cvc5 Java bindings the pom builds (`$CVC5_LIB` overrides their `lib/`
directory) and the classpath Maven resolves. `--smt=DIR` writes each pair's SMT-LIB problem, as the
translator prints it, under `DIR`.

## The input

A pair file is sqleq's: a leading comment block whose `-- key: value` lines are directives
(`truth`, `expect <axis>`, `catalog`, `binding`, `origin`), then PostgreSQL DDL, optional
`declare scalar function NAME(args) returns TYPE;` lines, and exactly two statements. The two are
queries, or two `DELETE`s, two `UPDATE`s or two `INSERT`s. Statements are cut at the semicolons
Postgres cuts them at: `'…'`, `E'…'`, `"…"`, `$$…$$`, `--` and nested `/* */` are all read. Pass
files or directories; a directory is walked for `.sql` files and each pair is named by its path.

## What happens to a pair

1. **Catalog.** The DDL is read into tables with columns in declared order, a type from a closed
   vocabulary (integer, bigint, numeric, double, boolean, text, date, time, timestamp, interval,
   bytea, opaque), `NOT NULL`, the primary key, `UNIQUE` constraints and unique indexes, foreign
   keys, and per column whether its `DEFAULT` is a function of the row. Domains are expanded;
   serial and identity columns are marked as generated; a table a trigger or rule names is marked;
   `INHERITS` copies the parent's columns and takes the parent's keys away (its rows are read through
   the parent). Keys follow the whole script: `ALTER TABLE … DROP CONSTRAINT`, `DROP INDEX`,
   `ALTER INDEX … RENAME`, `CREATE INDEX IF NOT EXISTS` on a taken name, `DEFERRABLE INITIALLY
   DEFERRED` and `NOT ENFORCED` are all read, and a key this reader cannot match is dropped rather
   than kept. A key handed to the prover is the primary key or a `UNIQUE` over `NOT NULL` columns
   (or `NULLS NOT DISTINCT`); a partial or expression index is none. Statements that cannot be read
   are skipped with a note, never guessed at.
2. **DML reduction** (after sqleq's `src/dml.rs`). `DELETE FROM T WHERE P` becomes
   `SELECT * FROM T WHERE P`, the deleted bag: bag subtraction is cancellative, so the reduction is
   an iff. `UPDATE T SET c = e WHERE P` becomes a projection of every declared column of `T`,
   `CASE WHEN P THEN e ELSE c END` where assigned and `c` otherwise; every column is kept because the
   comparison is a bag comparison and dropping one drops its pairing with the rest. With `RETURNING`
   the query has two tagged blocks, the new table and the matched rows, because final-table equality
   does not fix what was returned. `INSERT INTO T (cols) S` becomes `S`, when both sides list the
   same columns (lists in different orders are brought to the declared order through a derived
   table) and every omitted column's default is a function of the row.
3. **Spelling.** `x::t` becomes `CAST(x AS T)` with Calcite's type names (`text` to `VARCHAR`,
   `int8` to `BIGINT`, …), a Postgres type name in a `CAST` is renamed the same way, and
   `INTERVAL '1 day'` becomes `INTERVAL '1' DAY`.
4. **Parameters.** `$N` has one value per execution, the same everywhere and on both sides. The pair
   is planned once with every `$N` as Calcite's `?`, the inferred type of each occurrence is read off
   the plan, and the occurrences of one `N` are unified (the wider type within a family; refused
   where they disagree). Each `$N` is then spelled `qp_N()`, a nullary function declared with that
   type, which the prover reads as one uninterpreted constant shared by both sides.
5. **The prover**, unchanged, on the two queries.

## What is refused, and why

Every refusal is a refusal to guess; a reduction that guessed would make the prover prove a theorem
about a different pair than the one in the file. The note column names the reason.

* A `DELETE` paired with a `SELECT`, or any two statements of different kinds.
* `DELETE … USING`, `UPDATE … FROM`, and a DML statement under a `WITH` (sqleq's frontend handles
  some of these; this port does not).
* `INSERT` without a column list, `INSERT … ON CONFLICT`, `DEFAULT VALUES`, `OVERRIDING`, the
  `DEFAULT` keyword as a value, `SET (a, b) = …`, `WHERE CURRENT OF`.
* `RETURNING` on one side only, or two `RETURNING` lists that differ (compared on a canonical form:
  `*`, `t.*`, `id`, `t.id` and `alias.id` fold).
* A DML statement on a table a trigger or rule names: the statement then no longer writes what it says.
* An `INSERT` that omits a column whose default is a sequence value, `now()`, or any other value not
  fixed by the row.
* A value stored into a column whose `=` is identity (text, char, json, uuid, bytea) unless the
  statement fixes its spelling: a string literal, `NULL`, a parameter, or a column of such a type.
  `2.0` and `2.00` are one numeric and two strings. A store into an interval column with a
  modifier (`interval day`, `interval(0)`) is always refused: the modifier truncates.
* A cast to a type Calcite has no name for: uuid, json, an array, an interval; and a cast to
  `char(n)`, whose Postgres equality ignores trailing blanks. Columns of type `char(n)` and
  `citext` are opaque for the same reason: their `=` is not plain string equality.
* Shapes Calcite plans without the meaning Postgres gives them: `ORDER BY` inside a subquery that
  has no `LIMIT`, `OFFSET` or `FETCH`, when something downstream can see the order (Calcite drops
  the sort; `array_agg`, `string_agg`, a window function or an outer `LIMIT` see it, and so do
  `DISTINCT`, `GROUP BY`, a set operation or `MIN`/`MAX`/`SUM`/`AVG` over a numeric, float,
  interval, opaque or collated column, which pick one spelling among equal values; a join or a
  `UNION ALL` over integers does not), `TABLESAMPLE` (dropped by the planner),
  `JOIN … USING` under an outer join (Calcite's merged column is not Postgres's), a `FROM` list
  that mixes comma-separated items with `JOIN` (grouped differently), and Postgres's numeric
  literal forms `0b101`, `0x1f`, `1_000` (read as a number followed by an alias).
* A parameter whose type Calcite cannot infer (`SELECT $1` with nothing to compare against), or
  whose occurrences disagree (`$1 = 'x' AND $1 = 1`).
* Anything Calcite's parser or validator rejects after all that (`DISTINCT ON`, `->>`, `~`,
  `FOR UPDATE`, a table the DDL does not declare, …), reported as `unsupported` with Calcite's message.

A `-- catalog: inferred` pair declares no DDL for some of its tables; both tools need a schema,
so such pairs are refused. `CREATE VIEW` is not read: a query over a view is a query over an
undeclared relation, and is refused by Calcite. A bare table name reaches a `public` table, or the
one table of that name in another schema when there is exactly one and no public table or view
takes the name (sqleq's reading of a captured schema); two schemas declaring the same name make
the bare name reach neither, and only bare-reachable tables are handed to the prover.

## What this layer does not catch

sqleq's pinned pairs include corners of Postgres that are decided by name resolution or by the
type system, which a text-level reader cannot see and Calcite does not model: the implicit output
column names of a derived table (`column1`, `text`, `case`) when the outer query refers to one, an
aggregate whose argument belongs to an outer query level, `ORDER BY` keys that name an output
alias and an input column at once, numeric scale (`1.0` against `1.00`), float equality with signed
zeros, and string order under a collation. Pairs in sqleq's `names/` and `types/` directories pin
these, and a run over them reports `!UNSOUND` proofs there. They belong to the provers' readings of
SQL, not to the input; the per-tool sections below say which are the tool's own.

## Reading the results

One row per pair: `name, truth, verdict, bucket, ms, note`. `truth` is the file's `-- truth:` line
when it has one. `verdict` is the tool's own answer. `bucket` says the same in sqleq's words:

| bucket | meaning |
|---|---|
| `proved` | the prover proved the two queries equivalent |
| `proved-literal` | both sides plan to one Calcite tree; the prover was not asked (sqleq's tier 0) |
| `model` | the prover produced a database on which the two differ (cvc5 only) |
| `no-proof` | the prover found no proof; for SQLSolver this is its `NEQ`, which is not a counterexample |
| `unknown`, `timeout` | the prover gave up, or the time limit was reached |
| `unsupported` | refused by this reader, or rejected by Calcite; the note says where |
| `error` | an exception, or a child process that ended without an answer |

A `proved` or `proved-literal` on a pair whose truth is `not-equivalent` is marked `!UNSOUND` in
the note and listed in the summary; a `model` on an equivalent pair is marked `!false-model`.

Each pair runs in a fresh JVM (`--no-fork` runs in-process), because both provers can hang past
their own time limits; `--jobs=N` runs N pairs at once, `--log=DIR` keeps each child's stderr.

## What is the translator's own here

* The schema is written in Postgres accent for `DatabaseSchema.parse(ddl, Dialect.POSTGRESQL)`, with
  the keys a prover may assume: the primary key, and a `UNIQUE` only when its columns are `NOT NULL`
  or it is `NULLS NOT DISTINCT`. Opaque types (uuid, json, char(n), citext, arrays) are written
  as `bytea`, a type the translator declines, so a pair over them is reported rather than read as
  strings.
* The translator has sorts for integers, strings and booleans. A column or expression of any other
  type (numeric, double, date, timestamp, interval) is reported `unsupported sql type`.
* `tlimit-per` is passed to cvc5 from `--timeout`; cvc5 polls it, so a child may overrun by
  seconds, and the runner kills a child 20 seconds past the limit (`timeout`, "hang").
* The counterexample replay is off by default (`-Dcex=none`); set `-Dcex=...` as `Cvc5Analysis`
  documents to replay a model against a database.
* A `model` refutes the two *plans* under the schema as written here. Where the DDL carried
  something the catalog drops (an expression index, a check constraint, a foreign key), the model
  may not be a database the original schema allows; the `!false-model` mark says so on a pair whose
  truth is `equivalent`.
