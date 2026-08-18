# SQL features

Coverage of the Calcite -> cvc5 translation in `Cvc5AbstractTranslator` and its
`Cvc5BagsTranslator` / `Cvc5SetsTranslator` subclasses.

"Supported" here means the translator handles the construct and produces a term
(no exception) -- see the last section for cases that are accepted but do not
match SQL semantics.

## Supported

1. **Types**: `INTEGER`, `BIGINT`, `VARCHAR`/`CHAR`, `BOOLEAN`. Also the Calcite
   `JavaType` variants `java.lang.Integer` and `java.lang.String`.
2. **Nulls**: every column type can be wrapped in cvc5's `Nullable` sort when the
   translator is built with `isNullable = true`. Three-valued logic is encoded via
   `nullable.lift`, with explicit short-circuit handling for `AND`/`OR` so that
   `FALSE AND NULL = FALSE` and `TRUE OR NULL = TRUE`.
3. **Table values**: `VALUES` clauses with one or more literal tuples, including
   duplicates (bag semantics gives them multiplicity > 1).
4. **`SELECT`**: plain projection, `SELECT *`, and `SELECT DISTINCT`.
   All-`RexInputRef` projections use `table.project` / `relation.project`;
   anything with an expression uses `bag.map` / `set.map`. `SELECT DISTINCT`
   reaches the translator as an aggregate with no aggregate calls and is
   deduplicated via `mkDistinct` (`bag.setof` under bags, identity under sets).
5. **`WHERE` / `HAVING`**: translated to `bag.filter` / `set.filter`.
   `HAVING` arrives as a `LogicalFilter` above the aggregate, so it needs no
   special handling.
6. **Joins**: `INNER`, `LEFT`, `RIGHT`, `FULL`. Outer joins are built as
   product + NULL-padded unmatched rows. Join conditions are arbitrary row
   expressions; a missing condition (`isAlwaysTrue`) degenerates to a cross product.
7. **Set operations**: `UNION`, `UNION ALL`, `EXCEPT`, `EXCEPT ALL`, `INTERSECT`,
   `INTERSECT ALL`, each n-ary. The `ALL` forms map straight onto the multiset
   operators (`bag.union_disjoint`, `bag.difference_subtract`, `bag.inter_min`);
   the non-`ALL` forms wrap that result in `mkDistinct`, since SQL specifies
   distinct rows there:

   | SQL | bags | sets |
   | --- | --- | --- |
   | `UNION ALL` | `bag.union_disjoint` | `set.union` |
   | `UNION` | `bag.setof (bag.union_disjoint ...)` | `set.union` |
   | `EXCEPT ALL` | `bag.difference_subtract` | `set.minus` |
   | `EXCEPT` | `bag.setof (bag.difference_remove ...)` | `set.minus` |
   | `INTERSECT ALL` | `bag.inter_min` | `set.inter` |
   | `INTERSECT` | `bag.setof (bag.inter_min ...)` | `set.inter` |
8. **`GROUP BY`** with `COUNT`, `COUNT(*)`, `SUM`, `MIN`, `MAX`, translated to
   `table.aggr` / `relation.aggr`. A `GROUP BY` with no aggregate calls is
   duplicate removal, and goes through `mkDistinct` like `SELECT DISTINCT`.
9. **Row expressions**:
   - comparison: `=`, `<>`, `>`, `<`, `>=`, `<=` (string operands are routed to
     `str.<` / `str.<=` with operands swapped where needed)
   - arithmetic: `+`, `-`, `*`, `/`
   - boolean: `AND`, `OR`, `NOT`
   - null tests: `IS NULL`, `IS NOT NULL`, `IS TRUE`, `IS NOT TRUE`
   - string: `||`, `UPPER`, `SUBSTRING` (2- and 3-argument forms, with SQL's
     1-based index converted to SMT's 0-based)
   - `CASE` -> `ite`
   - `CAST` -> pass-through (the operand is translated and the cast is dropped)
10. **Subqueries** that Calcite rewrites into the above before the translator sees
    them: `IN` and `EXISTS` both become joins over an aggregate.

## Not supported (throws or aborts)

- `ORDER BY` -- filtered out upstream by `Cvc5Analysis.isSupported`.
- `LIMIT` / `OFFSET` / `FETCH` -- produce a `LogicalSort`, which
  `translate(RelNode)` does not handle; it returns `null` and the caller fails
  with a `NullPointerException`.
- Aggregates other than `COUNT`/`SUM`/`MIN`/`MAX`, e.g. `AVG` -- the `switch`
  falls to `default: break`, leaving a `null` tuple element and throwing a
  `NullPointerException`.
- Non-integer numeric results. Integer division yields a `Real` in SMT but the
  tuple sort expects `Int`, so `x / 2` throws a `CVC5ApiException`.
- Type-changing `CAST`, e.g. `CAST(intCol AS VARCHAR(10))`. Because `CAST` is a
  pass-through, the lambda body sort no longer matches the declared return sort
  and cvc5 rejects it.
- Any other type (`DATE`, `TIME`, `TIMESTAMP`, `DECIMAL`, `FLOAT`, ...) -- rejected
  in `getFieldSort`.
- Any other row operator -- `translateRowExpr` prints the call and calls
  `System.exit(1)`.
- Window functions, correlated subqueries that survive decorrelation, and
  table functions (`LogicalWindow`, `LogicalCorrelate`,
  `LogicalTableFunctionScan`) -- unhandled `RelNode` types, same `null` path as
  `LogicalSort`.

## Accepted but semantically wrong

These do not raise an error, so they are easy to mistake for working support.
All of them are in the aggregate translation in `Cvc5AbstractTranslator`.

- **`SUM` and `MIN`.** The aggregate `switch` is missing `break` statements, so
  both fall through into `MAX` and emit a lambda body byte-identical to `MAX`'s.
  `SUM(x)` over `{2, 3}` returns `3`, not `5`.
- **`MIN` / `MAX` seed value.** The accumulator starts at `0`, so `MIN` over
  positive values returns `0` and `MAX` over negative values returns `0`.
- **`COUNT(DISTINCT x)`** is translated as plain `COUNT(x)`; `AggregateCall.isDistinct()`
  is never consulted. The same applies to the aggregate `FILTER (WHERE ...)` clause.

Each of these makes the tool report `unsat` -- a claimed proof of equivalence --
for query pairs that are not equivalent in SQL.

## Fixed

Previously in the section above, corrected by introducing
`Cvc5AbstractTranslator.mkDistinct` (`bag.setof` under bag semantics, the identity
under set semantics):

- **Non-`ALL` set operators under bag semantics.** `UNION` used `bag.union_max`,
  `EXCEPT` used a bare `bag.difference_remove`, and `INTERSECT` ignored the `all`
  flag entirely, so none of the three deduplicated.
- **`SELECT DISTINCT` and agg-call-free `GROUP BY` under bag semantics.** Both
  mapped to a bare `table.project`, which sums multiplicities in bags rather than
  deduplicating.
- **`LogicalMinus` / `LogicalIntersect` with more than two inputs** silently
  dropped everything past the second input; both now fold over all inputs.

## Building and running

### Setup

A JDK and Maven, then:

```bash
mvn initialize      # one-time: fetches z3 and installs it locally
mvn test-compile
```

`mvn initialize` downloads the z3 release archive for your platform into
`~/.cache/z3` and installs its jar into your local Maven repository. It has to be a
separate invocation the first time, because Maven resolves the dependency graph
before the `initialize` phase runs, so the jar has to exist before `test-compile`
can see it. Afterwards it is a no-op and you can ignore it.

Where the two solvers come from:

- **z3** from the [GitHub release](https://github.com/Z3Prover/z3/releases),
  currently **5.1.0**. Maven Central only has `z3-turnkey`, which lags well behind
  (4.14.1, June 2025), so the release archive is used instead. The natives are
  loaded from `~/.cache/z3/.../bin` via `DYLD_LIBRARY_PATH` / `LD_LIBRARY_PATH`,
  which the build sets for you.
- **cvc5** from Maven Central (`io.github.cvc5:cvc5`), whose platform classifier
  jar carries `libcvc5jni`; cvc5 extracts it from the classpath itself. The
  classifier is chosen automatically by `os-maven-plugin`.

To move to a newer z3, bump `z3.version` in `pom.xml` and the `z3.dir` for your
platform -- z3 puts an OS version in the archive name (`-osx-13.3`,
`-glibc-2.39`) and it moves between releases, so check the release page. Then
re-run `mvn initialize`. For cvc5, bump `cvc5.version`.

To build against a local cvc5 checkout instead -- what you want when developing
cvc5 itself -- pass `-Dcvc5.home`. That deactivates the Maven Central artifacts
entirely, so local Java classes are never paired with a mismatched native library:

```bash
mvn -Dcvc5.home=/path/to/cvc5/build/install test-compile
```

### Running a single pair

```bash
mvn exec:exec -Dq1='<query1>' -Dq2='<query2>' [-Dsem=sets] [-Dout=my.smt2]
```

`sem` defaults to `bags`, `out` to `single.smt2`. The output reads `unsat` = proved
equivalent, `sat` = counterexample found, `unknown` = solver hit `tlimit-per`.

```bash
mvn -q exec:exec \
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

Use **single** quotes. Column names like `EXPR$0` are otherwise eaten by the shell.

Two Maven details worth knowing. It has to be `exec:exec`, not `exec:java`:
`java.library.path` is read once at JVM start, so cvc5's JNI library only loads in
a freshly forked JVM. And Maven reads stdin, so inside a `while read` loop you must
redirect it (`mvn ... </dev/null`) or the loop will consume only its first line.

### Running the JSON batch

With no `-Dq1`/`-Dq2`, the same command runs the file named at the top of `main`
(`testData/no_aggregation_sat.json`) and writes `min_bags_sat.smt2`:

```bash
mvn exec:exec
```

Expect this to take a while: the per-query limit is 10 s (`tlimit-per`) and most
queries over `EMP`/`DEPT` hit it.

### Inspecting the generated SMT-LIB

Every run writes the full problem it handed to cvc5. To evaluate `q1` and `q2`
concretely instead of just asking whether they differ, drop the disequality and ask
for their values:

```bash
grep -v '^(assert (not (= q1 q2)))$' single.smt2 > /tmp/eval.smt2
echo '(get-value (q1 q2))' >> /tmp/eval.smt2
cvc5 --tlimit=5000 /tmp/eval.smt2
```
```
sat
((q1 (bag (tuple (nullable.some 1)) 1)) (q2 (bag (tuple (nullable.some 1)) 2)))
```

That reads as: q1 has one copy of row `(1)`, q2 has two -- which is what SQL says,
so the translation is faithful here.

## Test queries

Every pair below is ground (all `VALUES`, no table constants), so cvc5 answers in
milliseconds and you can check the expected rows by hand. To see what was actually
sent to the solver, drop the `(assert (not (= q1 q2)))` line from the generated
`.smt2`, append `(get-value (q1 q2))`, and run `cvc5 --tlimit=5000 single.smt2`.

### Regression pairs -- NOT equivalent, expect `sat`

These are the counterexamples that exposed the duplicate-elimination bugs. The
first four now pass; **B5-B7 still wrongly report `unsat`** and are the open
aggregate bugs listed above.

| # | q1 | q2 | q1 rows | q2 rows | expected |
| --- | --- | --- | --- | --- | --- |
| B1 | `SELECT * FROM (VALUES (1),(1)) AS t UNION SELECT * FROM (VALUES (1)) AS u` | `SELECT * FROM (VALUES (1),(1)) AS t` | 1 | 2 | `sat` |
| B2 | `SELECT * FROM (VALUES (1),(1)) AS t EXCEPT SELECT * FROM (VALUES (2)) AS u` | `SELECT * FROM (VALUES (1),(1)) AS t` | 1 | 2 | `sat` |
| B3 | `SELECT * FROM (VALUES (1),(1)) AS t INTERSECT SELECT * FROM (VALUES (1),(1)) AS u` | `SELECT * FROM (VALUES (1),(1)) AS t INTERSECT ALL SELECT * FROM (VALUES (1),(1)) AS u` | 1 | 2 | `sat` |
| B4 | `SELECT DISTINCT t.EXPR$0 FROM (VALUES (1),(1)) AS t` | `SELECT t.EXPR$0 FROM (VALUES (1),(1)) AS t` | 1 | 2 | `sat` |
| B5 | `SELECT t.EXPR$0, SUM(t.EXPR$1) FROM (VALUES (1,2),(1,3)) AS t GROUP BY t.EXPR$0` | `SELECT t.EXPR$0, MAX(t.EXPR$1) FROM (VALUES (1,2),(1,3)) AS t GROUP BY t.EXPR$0` | `(1,5)` | `(1,3)` | `sat` -- **currently `unsat`** |
| B6 | `SELECT t.EXPR$0, MIN(t.EXPR$1) FROM (VALUES (1,2),(1,3)) AS t GROUP BY t.EXPR$0` | `SELECT t.EXPR$0, MAX(t.EXPR$1) FROM (VALUES (1,2),(1,3)) AS t GROUP BY t.EXPR$0` | `(1,2)` | `(1,3)` | `sat` -- **currently `unsat`** |
| B7 | `SELECT t.EXPR$0, COUNT(DISTINCT t.EXPR$1) FROM (VALUES (1,2),(1,2)) AS t GROUP BY t.EXPR$0` | `SELECT t.EXPR$0, COUNT(t.EXPR$1) FROM (VALUES (1,2),(1,2)) AS t GROUP BY t.EXPR$0` | `(1,1)` | `(1,2)` | `sat` -- **currently `unsat`** |

### Regression pairs -- equivalent, expect `unsat`

These guard against over-applying `bag.setof`: the non-`ALL` operators must
deduplicate, the `ALL` operators must not.

| # | q1 | q2 | property |
| --- | --- | --- | --- |
| P1 | `SELECT * FROM (VALUES (1),(2)) AS t UNION SELECT * FROM (VALUES (2),(3)) AS u` | `SELECT * FROM (VALUES (2),(3)) AS u UNION SELECT * FROM (VALUES (1),(2)) AS t` | `UNION` is commutative |
| P2 | `SELECT DISTINCT t.EXPR$0 FROM (VALUES (1),(1),(2)) AS t` | `SELECT t.EXPR$0 FROM (VALUES (1),(1),(2)) AS t GROUP BY t.EXPR$0` | `DISTINCT` = bare `GROUP BY` |
| P3 | `SELECT * FROM (VALUES (1),(2)) AS t UNION SELECT * FROM (VALUES (2),(3)) AS u` | `SELECT DISTINCT v.EXPR$0 FROM (SELECT * FROM (VALUES (1),(2)) AS t UNION ALL SELECT * FROM (VALUES (2),(3)) AS u) AS v` | `UNION` = `DISTINCT (UNION ALL)` |
| P4 | `SELECT * FROM (VALUES (1),(1),(2)) AS t INTERSECT SELECT * FROM (VALUES (1),(1),(2)) AS u` | `SELECT DISTINCT t.EXPR$0 FROM (VALUES (1),(1),(2)) AS t` | `A INTERSECT A` = `DISTINCT A` |
| P5 | `SELECT * FROM (VALUES (1),(1),(2)) AS t EXCEPT SELECT * FROM (VALUES (99)) AS u` | `SELECT DISTINCT t.EXPR$0 FROM (VALUES (1),(1),(2)) AS t` | `EXCEPT` over disjoint = `DISTINCT A` |
| P6 | `SELECT * FROM (VALUES (1)) AS t UNION ALL SELECT * FROM (VALUES (1)) AS u` | `SELECT * FROM (VALUES (1),(1)) AS t` | `UNION ALL` keeps multiplicity |
| P7 | `SELECT * FROM (VALUES (1),(1),(1)) AS t EXCEPT ALL SELECT * FROM (VALUES (1)) AS u` | `SELECT * FROM (VALUES (1),(1)) AS t` | `EXCEPT ALL` subtracts multiplicity |

### Feature-probe queries

Single queries used to establish what the translator accepts. Pair each with
itself to run it.

| Query | Outcome |
| --- | --- |
| `SELECT t.ENAME, SUM(t.EMPNO) FROM EMP t GROUP BY t.ENAME` | accepted; emits a `MAX` lambda |
| `SELECT t.ENAME, AVG(t.EMPNO) FROM EMP t GROUP BY t.ENAME` | `NullPointerException` |
| `SELECT t.ENAME FROM EMP t ORDER BY t.ENAME` | skipped by `isSupported` |
| `SELECT t.ENAME FROM EMP t FETCH NEXT 3 ROWS ONLY` | `NullPointerException` (`LogicalSort`) |
| `SELECT CAST(t.EMPNO AS VARCHAR(10)) FROM EMP t` | `CVC5ApiException` (sort mismatch) |
| `SELECT t.EMPNO / 2 FROM EMP t` | `CVC5ApiException` (`Real` vs `Int`) |
| `SELECT t.EMPNO + 1, t.ENAME \|\| 'x', UPPER(t.ENAME), SUBSTRING(t.ENAME FROM 2 FOR 3) FROM EMP t` | accepted |
| `SELECT CASE WHEN t.EMPNO > 5 THEN 1 ELSE 2 END FROM EMP t` | accepted |
| `SELECT * FROM EMP t WHERE t.COMM IS NULL AND t.SAL IS NOT NULL` | accepted |
| `SELECT * FROM EMP t LEFT JOIN DEPT d ON t.DEPTNO = d.DEPTNO` | accepted |
| `SELECT * FROM EMP t WHERE t.EMPNO IN (SELECT d.DEPTNO FROM DEPT d)` | accepted (becomes a join) |
| `SELECT * FROM EMP t WHERE EXISTS (SELECT * FROM DEPT d WHERE d.DEPTNO = t.DEPTNO)` | accepted (becomes a join) |

## Commands for the regression pairs

Copy-pasteable from the repository root. Each prints one `result:` line.

### NOT equivalent -- expect `sat`

```bash
# B1  UNION must deduplicate
mvn -q exec:exec \
  -Dq1='SELECT * FROM (VALUES (1),(1)) AS t UNION SELECT * FROM (VALUES (1)) AS u' \
  -Dq2='SELECT * FROM (VALUES (1),(1)) AS t'

# B2  EXCEPT must deduplicate
mvn -q exec:exec \
  -Dq1='SELECT * FROM (VALUES (1),(1)) AS t EXCEPT SELECT * FROM (VALUES (2)) AS u' \
  -Dq2='SELECT * FROM (VALUES (1),(1)) AS t'

# B3  INTERSECT must differ from INTERSECT ALL
mvn -q exec:exec \
  -Dq1='SELECT * FROM (VALUES (1),(1)) AS t INTERSECT SELECT * FROM (VALUES (1),(1)) AS u' \
  -Dq2='SELECT * FROM (VALUES (1),(1)) AS t INTERSECT ALL SELECT * FROM (VALUES (1),(1)) AS u'

# B4  SELECT DISTINCT must deduplicate
mvn -q exec:exec \
  -Dq1='SELECT DISTINCT t.EXPR$0 FROM (VALUES (1),(1)) AS t' \
  -Dq2='SELECT t.EXPR$0 FROM (VALUES (1),(1)) AS t'

# B5  SUM must not be MAX          -- STILL FAILS (reports unsat)
mvn -q exec:exec \
  -Dq1='SELECT t.EXPR$0, SUM(t.EXPR$1) FROM (VALUES (1,2),(1,3)) AS t GROUP BY t.EXPR$0' \
  -Dq2='SELECT t.EXPR$0, MAX(t.EXPR$1) FROM (VALUES (1,2),(1,3)) AS t GROUP BY t.EXPR$0'

# B6  MIN must not be MAX          -- STILL FAILS (reports unsat)
mvn -q exec:exec \
  -Dq1='SELECT t.EXPR$0, MIN(t.EXPR$1) FROM (VALUES (1,2),(1,3)) AS t GROUP BY t.EXPR$0' \
  -Dq2='SELECT t.EXPR$0, MAX(t.EXPR$1) FROM (VALUES (1,2),(1,3)) AS t GROUP BY t.EXPR$0'

# B7  COUNT(DISTINCT x) must not be COUNT(x)  -- STILL FAILS (reports unsat)
mvn -q exec:exec \
  -Dq1='SELECT t.EXPR$0, COUNT(DISTINCT t.EXPR$1) FROM (VALUES (1,2),(1,2)) AS t GROUP BY t.EXPR$0' \
  -Dq2='SELECT t.EXPR$0, COUNT(t.EXPR$1) FROM (VALUES (1,2),(1,2)) AS t GROUP BY t.EXPR$0'
```

### Equivalent -- expect `unsat`

```bash
# P1  UNION is commutative
mvn -q exec:exec \
  -Dq1='SELECT * FROM (VALUES (1),(2)) AS t UNION SELECT * FROM (VALUES (2),(3)) AS u' \
  -Dq2='SELECT * FROM (VALUES (2),(3)) AS u UNION SELECT * FROM (VALUES (1),(2)) AS t'

# P2  DISTINCT equals a bare GROUP BY
mvn -q exec:exec \
  -Dq1='SELECT DISTINCT t.EXPR$0 FROM (VALUES (1),(1),(2)) AS t' \
  -Dq2='SELECT t.EXPR$0 FROM (VALUES (1),(1),(2)) AS t GROUP BY t.EXPR$0'

# P3  UNION equals DISTINCT of UNION ALL
mvn -q exec:exec \
  -Dq1='SELECT * FROM (VALUES (1),(2)) AS t UNION SELECT * FROM (VALUES (2),(3)) AS u' \
  -Dq2='SELECT DISTINCT v.EXPR$0 FROM (SELECT * FROM (VALUES (1),(2)) AS t UNION ALL SELECT * FROM (VALUES (2),(3)) AS u) AS v'

# P4  A INTERSECT A equals DISTINCT A
mvn -q exec:exec \
  -Dq1='SELECT * FROM (VALUES (1),(1),(2)) AS t INTERSECT SELECT * FROM (VALUES (1),(1),(2)) AS u' \
  -Dq2='SELECT DISTINCT t.EXPR$0 FROM (VALUES (1),(1),(2)) AS t'

# P5  EXCEPT over disjoint inputs equals DISTINCT A
mvn -q exec:exec \
  -Dq1='SELECT * FROM (VALUES (1),(1),(2)) AS t EXCEPT SELECT * FROM (VALUES (99)) AS u' \
  -Dq2='SELECT DISTINCT t.EXPR$0 FROM (VALUES (1),(1),(2)) AS t'

# P6  UNION ALL keeps multiplicity
mvn -q exec:exec \
  -Dq1='SELECT * FROM (VALUES (1)) AS t UNION ALL SELECT * FROM (VALUES (1)) AS u' \
  -Dq2='SELECT * FROM (VALUES (1),(1)) AS t'

# P7  EXCEPT ALL subtracts multiplicity
mvn -q exec:exec \
  -Dq1='SELECT * FROM (VALUES (1),(1),(1)) AS t EXCEPT ALL SELECT * FROM (VALUES (1)) AS u' \
  -Dq2='SELECT * FROM (VALUES (1),(1)) AS t'
```

### Run them all at once

```bash
run_all() {
  while IFS='|' read -r name expected q1 q2; do
    [ -z "$name" ] && continue
    # </dev/null keeps Maven from swallowing the rest of the heredoc
    got=$(mvn -q exec:exec -Dq1="$q1" -Dq2="$q2" </dev/null 2>/dev/null \
          | sed -n 's/^result: \([a-z]*\).*/\1/p')
    [ "$got" = "$expected" ] && v=PASS || v=FAIL
    printf '%-4s %-6s got=%-8s %s\n' "$name" "$expected" "$got" "$v"
  done <<'PAIRS'
B1|sat|SELECT * FROM (VALUES (1),(1)) AS t UNION SELECT * FROM (VALUES (1)) AS u|SELECT * FROM (VALUES (1),(1)) AS t
B2|sat|SELECT * FROM (VALUES (1),(1)) AS t EXCEPT SELECT * FROM (VALUES (2)) AS u|SELECT * FROM (VALUES (1),(1)) AS t
B3|sat|SELECT * FROM (VALUES (1),(1)) AS t INTERSECT SELECT * FROM (VALUES (1),(1)) AS u|SELECT * FROM (VALUES (1),(1)) AS t INTERSECT ALL SELECT * FROM (VALUES (1),(1)) AS u
B4|sat|SELECT DISTINCT t.EXPR$0 FROM (VALUES (1),(1)) AS t|SELECT t.EXPR$0 FROM (VALUES (1),(1)) AS t
B5|sat|SELECT t.EXPR$0, SUM(t.EXPR$1) FROM (VALUES (1,2),(1,3)) AS t GROUP BY t.EXPR$0|SELECT t.EXPR$0, MAX(t.EXPR$1) FROM (VALUES (1,2),(1,3)) AS t GROUP BY t.EXPR$0
B6|sat|SELECT t.EXPR$0, MIN(t.EXPR$1) FROM (VALUES (1,2),(1,3)) AS t GROUP BY t.EXPR$0|SELECT t.EXPR$0, MAX(t.EXPR$1) FROM (VALUES (1,2),(1,3)) AS t GROUP BY t.EXPR$0
B7|sat|SELECT t.EXPR$0, COUNT(DISTINCT t.EXPR$1) FROM (VALUES (1,2),(1,2)) AS t GROUP BY t.EXPR$0|SELECT t.EXPR$0, COUNT(t.EXPR$1) FROM (VALUES (1,2),(1,2)) AS t GROUP BY t.EXPR$0
P1|unsat|SELECT * FROM (VALUES (1),(2)) AS t UNION SELECT * FROM (VALUES (2),(3)) AS u|SELECT * FROM (VALUES (2),(3)) AS u UNION SELECT * FROM (VALUES (1),(2)) AS t
P2|unsat|SELECT DISTINCT t.EXPR$0 FROM (VALUES (1),(1),(2)) AS t|SELECT t.EXPR$0 FROM (VALUES (1),(1),(2)) AS t GROUP BY t.EXPR$0
P3|unsat|SELECT * FROM (VALUES (1),(2)) AS t UNION SELECT * FROM (VALUES (2),(3)) AS u|SELECT DISTINCT v.EXPR$0 FROM (SELECT * FROM (VALUES (1),(2)) AS t UNION ALL SELECT * FROM (VALUES (2),(3)) AS u) AS v
P4|unsat|SELECT * FROM (VALUES (1),(1),(2)) AS t INTERSECT SELECT * FROM (VALUES (1),(1),(2)) AS u|SELECT DISTINCT t.EXPR$0 FROM (VALUES (1),(1),(2)) AS t
P5|unsat|SELECT * FROM (VALUES (1),(1),(2)) AS t EXCEPT SELECT * FROM (VALUES (99)) AS u|SELECT DISTINCT t.EXPR$0 FROM (VALUES (1),(1),(2)) AS t
P6|unsat|SELECT * FROM (VALUES (1)) AS t UNION ALL SELECT * FROM (VALUES (1)) AS u|SELECT * FROM (VALUES (1),(1)) AS t
P7|unsat|SELECT * FROM (VALUES (1),(1),(1)) AS t EXCEPT ALL SELECT * FROM (VALUES (1)) AS u|SELECT * FROM (VALUES (1),(1)) AS t
PAIRS
}

run_all
```

Current output -- B5-B7 are the three open aggregate bugs:

```
B1   sat    got=sat      PASS
B2   sat    got=sat      PASS
B3   sat    got=sat      PASS
B4   sat    got=sat      PASS
B5   sat    got=unsat    FAIL
B6   sat    got=unsat    FAIL
B7   sat    got=unsat    FAIL
P1   unsat  got=unsat    PASS
P2   unsat  got=unsat    PASS
P3   unsat  got=unsat    PASS
P4   unsat  got=unsat    PASS
P5   unsat  got=unsat    PASS
P6   unsat  got=unsat    PASS
P7   unsat  got=unsat    PASS
```
