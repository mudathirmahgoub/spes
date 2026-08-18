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

## Not supported

These raise `UnsupportedOperationException`, which the batch driver records as
"skipped" and moves past. Refusing to translate is deliberate: a silently wrong
encoding would show up as a bogus `unsat`.

- `ORDER BY` -- filtered out upstream by `Cvc5Analysis.isSupported`.
- `LIMIT` / `OFFSET` / `FETCH` -- these produce a `LogicalSort`, which has no encoding.
- Aggregates other than `COUNT`/`SUM`/`SUM0`/`MIN`/`MAX`, e.g. `AVG`.
- A `DISTINCT` aggregate alongside any other aggregate -- each would need its own
  de-duplicated input.
- Multi-argument aggregates, and the aggregate `FILTER (WHERE ...)` clause.
- Aggregates when the translator is built with `isNullable = false`: the fold needs
  a null to mean "nothing seen yet".
- Non-integer numeric results. Integer division yields a `Real` in SMT but the
  tuple sort expects `Int`, so `x / 2` throws a `CVC5ApiException`.
- Type-changing `CAST`, e.g. `CAST(intCol AS VARCHAR(10))`. Because `CAST` is a
  pass-through, the lambda body sort no longer matches the declared return sort
  and cvc5 rejects it.
- Any other type (`DATE`, `TIME`, `TIMESTAMP`, `DECIMAL`, `FLOAT`, ...).
- Any other row operator.
- Window functions, correlated subqueries that survive decorrelation, and table
  functions (`LogicalWindow`, `LogicalCorrelate`, `LogicalTableFunctionScan`).
- `SEMI` and `ANTI` joins. Calcite normally rewrites them into an inner join over an
  aggregate before the translator sees them.

## Accepted but semantically wrong

Nothing currently known, for bag semantics. Every case listed here previously has
been fixed; see the next section.

Under **set semantics** the encoding is deliberately approximate: `UNION ALL`,
`EXCEPT ALL` and `INTERSECT ALL` all collapse onto the set operators, so
multiplicities are lost. That is inherent to the set encoding rather than a bug --
use bag semantics (the default) if duplicates matter.

## Fixed

Duplicate elimination, via a new `Cvc5AbstractTranslator.mkDistinct` hook
(`bag.setof` under bags, the identity under sets):

- **Non-`ALL` set operators under bag semantics.** `UNION` used `bag.union_max`,
  `EXCEPT` a bare `bag.difference_remove`, and `INTERSECT` ignored the `all` flag,
  so none of the three deduplicated.
- **`SELECT DISTINCT` and agg-call-free `GROUP BY` under bag semantics.** Both
  mapped to a bare `table.project`, which sums multiplicities rather than
  deduplicating.
- **`LogicalMinus` / `LogicalIntersect` with more than two inputs** silently dropped
  everything past the second input; both now fold over all inputs.

Aggregates, rewritten around a null-seeded accumulator:

- **`SUM` and `MIN` computed `MAX`.** The `switch` was missing its `break`
  statements, so both fell through and emitted a lambda byte-identical to `MAX`'s.
- **`MIN` / `MAX` seeded the accumulator with `0`,** so `MIN` over positive values
  returned `0` and `MAX` over negatives returned `0`. The accumulator now starts at
  `null` meaning "nothing seen yet", which also gives SQL's rule that `SUM`/`MIN`/
  `MAX` over a group with no non-null value is `NULL`.
- **`COUNT(x)` counted null rows.** It now skips them, while `COUNT(*)` still counts
  every row.
- **`COUNT(DISTINCT x)` was plain `COUNT(x)`.** `table.aggr` folds over every copy in
  the bag, so the input is now projected onto (group keys, argument) and passed
  through `bag.setof` first. Only one distinct call can be served this way; a
  distinct aggregate alongside others is rejected rather than mistranslated.
- **`MIN`/`MAX` on strings used the integer ordering.** They now use `str.<`.
- **The grouping-key indices were computed with the wrong loop bound**
  (`getGroupIndices` iterated to the cardinality rather than the highest set bit),
  so a non-prefix group set such as `{0,2}` produced `[0,0]`. Replaced with
  `ImmutableBitSet.toArray()`.

Three-valued logic:

- **`AND` / `OR` only inspected their first two operands.** Calcite flattens
  `a AND b AND c` into one n-ary call, and `nullable.lift` propagates null from any
  operand, so `NULL AND NULL AND FALSE` came out `NULL` where SQL says `FALSE`
  (dually for `OR` and `TRUE`). The dominant value is now tested for across every
  operand.
- **`CASE` with more than one `WHEN`.** Calcite flattens
  `CASE WHEN c1 THEN v1 WHEN c2 THEN v2 ELSE e` into a single five-operand call,
  which was handed to a three-argument `ite`. It is now folded into nested `ite`
  terms, with every condition read two-valued.

Robustness:

- **Empty `VALUES`** passed a tuple sort where `mkEmptyBag`/`mkEmptySet` wants a
  collection sort.
- **`getSort` used `getFieldList() != null` to test for a struct type.** Calcite
  asserts `isStruct()` inside `getFieldList()`, so this only worked while assertions
  were disabled -- and threw `AssertionError` as soon as the unit tests ran with
  `-ea`. Now uses `isStruct()`.
- **An assertion in `mkIsSomeValIfNullable` was inverted**, asserting its argument
  was *not* boolean when it is only ever called on boolean conditions.
- **`System.exit(1)` on an unsupported type or operator** killed the JVM mid-batch.
  Those paths, an unhandled relational operator (which used to return `null` and
  surface later as a `NullPointerException`), an unsupported join type and an
  unsupported literal all now throw `UnsupportedOperationException`, and the batch
  driver records and skips them. One unsupported query no longer hides the results
  of the other 200.
- **`getTableRows`** handed every copy of a duplicated row the same `List` instance
  and called `intValue()` on an unbounded `BigInteger` multiplicity.
- **Dead code:** `isSetSemantics()` was declared abstract, overridden twice and
  never called; `verify` computed a nullability flag and then unconditionally
  overwrote it.

## Building and running

### Setup

A JDK and Maven, then:

```bash
mvn initialize      # one-time: fetches z3 and installs it locally
mvn test            # build and run the unit tests
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

With no `-Dq1`/`-Dq2` the same command runs a whole benchmark file:

```bash
mvn exec:exec -Dbatch=testData/no_aggregation.json -Dsem=bags -Dout=/tmp/out.smt2
```

All three are optional: `batch` defaults to `testData/no_aggregation_sat.json`, `sem`
to `bags`, `out` to `min_bags_sat.smt2` or `min_sets_sat.smt2`. Point `out` somewhere
outside the repository unless you mean to overwrite the committed results.

Each benchmark prints one machine-readable line, so two runs can be diffed:

```
; RESULT testEmptyMinus equivalent
```

with verdicts `equivalent` (unsat), `inequivalent` (sat), `unknown` (timeout),
`skipped` (a construct the translator refuses), `error` (a genuine failure) and
`filtered` (excluded by `isSupported` before parsing). A run ends with counts of
each. Expect it to take a while: the per-query limit is 10 s (`tlimit-per`) and most
queries over `EMP`/`DEPT` reach it.

### Inspecting the generated SMT-LIB

Every run writes the full problem it handed to cvc5. To evaluate `q1` and `q2`
concretely instead of just asking whether they differ, drop the disequality and ask
for their values:

```bash
sed -n '1,/^(check-sat)/p' single.smt2 | grep -v '^(assert (not (= q1 q2)))$' > /tmp/eval.smt2
echo '(get-value (q1 q2))' >> /tmp/eval.smt2
cvc5 --tlimit=5000 /tmp/eval.smt2
```
```
sat
((q1 (bag (tuple (nullable.some 1)) 1)) (q2 (bag (tuple (nullable.some 1)) 2)))
```

That reads as: q1 has one copy of row `(1)`, q2 has two -- which is what SQL says,
so the translation is faithful here.

## Unit tests

`Cvc5TranslatorTest` runs the translator end to end against cvc5 and is the fastest way to
check nothing has broken:

```bash
mvn test
mvn test -Dtest=Cvc5TranslatorTest#sumAddsValues     # a single case
```

Every test states a fact about SQL and asks the solver to prove or refute it, so a failure
means the encoding disagrees with SQL rather than merely that it changed. Two shapes are used:

- **equivalent, expect `unsat`** -- this is what pins down *what a construct computes*. To
  check that `SUM` over {2, 3} is 5, the test compares the aggregate against the literal table
  `(VALUES (1,5))`. If the encoding computed 3, as it did when `SUM` fell through to `MAX`, the
  solver returns `sat` and the test fails.
- **inequivalent, expect `sat`** -- the regression tests for the soundness bugs. Each of these
  used to return `unsat`, a bogus proof of equivalence.

A third shape asserts that a construct is *refused*: `AVG`, a `DISTINCT` aggregate alongside
another, the aggregate `FILTER` clause and unsupported types must raise
`UnsupportedOperationException` rather than be quietly approximated.

Coverage: literal `VALUES` and multiplicity; all six set operators; `SELECT DISTINCT`;
`COUNT`/`COUNT(*)`/`COUNT(DISTINCT)`/`SUM`/`MIN`/`MAX` including nulls, negatives, strings,
duplicate rows and several aggregates in one `GROUP BY`; `WHERE`; arithmetic, `CASE`, `||`,
`UPPER`, `SUBSTRING`, `IS NULL`; inner, cross, left and right joins; and the difference between
bag and set semantics.

All inputs are literal `VALUES` tables rather than `EMP`/`DEPT`, so every query is ground and
the suite finishes in well under a minute.

## Benchmark results, and how they compare to the LPAR-24 paper

The paper `~/paper-lpar24-bags` reports cvc5 numbers for these same two benchmark files
(Figure 4, `files/05.1_calcite_results.tex`). Reproduced here on the current code.

Caveats before reading the numbers: same 10 s per-query limit, but different hardware
(the paper used a 12th Gen i9-12950HX with 128 GB; this is an Apple-silicon laptop), a
newer cvc5, and a translator with the soundness bugs above fixed. Timeout counts are
sensitive to all three, so the `uk` column is the least comparable.

### Original benchmarks -- `testData/no_aggregation.json`

| tool | | inequivalent | equivalent | unknown | total | source |
| --- | --- | ---: | ---: | ---: | ---: | --- |
| SQLSolver | (b) | 1 | 87 |  | 88 | paper Figure 4a |
| SPES | (b) |  | 54 | 34 | 88 | paper Figure 4a |
| cvc5 | (b) | 2 | 42 | 44 | 88 | paper Figure 4a |
| **cvc5** | **(b)** | **2** | **31** | **55** | **88** | **this run** |
| cvc5 | (s) | 1 | 83 | 4 | 88 | paper Figure 4a |
| **cvc5** | **(s)** | **0** | **61** | **27** | **88** | **this run** |

### Mutated (made inequivalent) benchmarks -- `testData/no_aggregation_sat.json`

| tool | | inequivalent | equivalent | unknown | total | source |
| --- | --- | ---: | ---: | ---: | ---: | --- |
| SQLSolver | (b) | 86 |  |  | 86 | paper Figure 4b |
| SPES | (b) |  |  | 86 | 86 | paper Figure 4b |
| cvc5 | (b) | 81 | 0 | 5 | 86 | paper Figure 4b |
| **cvc5** | **(b)** | **41** | **0** | **44** | **85** | **this run** |
| cvc5 | (s) | 67 | 9 | 10 | 86 | paper Figure 4b |
| **cvc5** | **(s)** | **34** | **7** | **44** | **85** | **this run** |

### Reading the differences

**Nothing became wrong.** On the mutated set, where every benchmark is inequivalent by
construction, the bag encoding reports **0 equivalent** -- no false proofs. That is the
soundness-critical number and it matches the paper.

**Fewer benchmarks are decided, uniformly.** Every row loses decisions to the `unknown`
column: -11 under bags and -22 under sets on the original set, -40 and -33 on the mutated
set. Nothing moves from `equivalent` to `inequivalent` or back.

**The gap is not caused by the fixes above.** Two checks.

`testData/no_aggregation.json` was run three times during this work -- before any fix,
after the duplicate-elimination fix, and on the final code -- and gave 2 / 31 / 55 every
time, with the same two benchmarks reported inequivalent.

For the mutated set, a control build was made with both semantic changes reverted
(`mkDistinct` back to the identity, `AND`/`OR` back to inspecting only two operands) and
run again:

| no_aggregation_sat, bags | inequivalent | equivalent | unknown |
| --- | ---: | ---: | ---: |
| control, both fixes reverted | 39 | 0 | 46 |
| final code | 41 | 0 | 44 |
| paper | 81 | 0 | 5 |

The fixed encoding decides two *more* benchmarks than the unfixed one, so the fixes are not
responsible; both sit far from the paper. Consistent with that, `bag.setof` correlates with
timeouts (11 of the 16 benchmarks that use it time out, against 33 of the 69 that do not)
but only 16 benchmarks use it at all -- solving every one would still leave 33 timeouts
against the paper's 5. What remains is environmental: a different machine, and a cvc5 two
years newer than the paper's.

**`testPullNull` behaves differently.** The paper singles it out as the benchmark cvc5 got
right and both SQLSolver and SPES got wrong, counting it in the `inequivalent` column under
both semantics. Here it times out under both. Its two queries swap the `SAL` and `COMM`
columns, so a counterexample only needs a row where those differ. This too predates the
fixes. The two benchmarks reported inequivalent here are `testAddRedundantSemiJoinRule`
(which the paper also names) and `testPushSemiJoinPastFilter`.

**The benchmark files do not quite match the paper.** `no_aggregation.json` yields exactly
88 translated benchmarks, as the paper says: 97 entries less the 9 containing `ORDER BY`.
But `no_aggregation_sat.json` holds 85 where Figure 4b reports 86. The mutated set drops
three benchmarks from the original 88 -- `testPullNull`, `testAddRedundantSemiJoinRule` and
`testPushSemiJoinPastFilter` -- whereas the text describes excluding the two that SPES
misclassifies. All percentages above are over the file as it stands.

**Bags versus sets agree with the paper qualitatively.** Set semantics decides far more of
the original benchmarks (61 against 31): 29 benchmarks are `unknown` under bags but
`equivalent` under sets, and none go the other way. On the mutated set the two disagree in
both directions, and 7 mutations are invisible to set semantics because they only change
multiplicities -- the paper saw 9.

### Reproducing

```bash
for bench in no_aggregation no_aggregation_sat; do
  for sem in bags sets; do
    mvn -q exec:exec -Dbatch=testData/$bench.json -Dsem=$sem \
        -Dout=/tmp/$bench-$sem.smt2 </dev/null | grep '^; RESULT'
  done
done
```

Budget about 25 minutes per configuration; most of it is the 10 s limit being reached.

## Test queries

Every pair below is ground (all `VALUES`, no table constants), so cvc5 answers in
milliseconds and you can check the expected rows by hand. To see what was actually
sent to the solver, drop the `(assert (not (= q1 q2)))` line from the generated
`.smt2`, append `(get-value (q1 q2))`, and run `cvc5 --tlimit=5000 single.smt2`.

### Regression pairs -- NOT equivalent, expect `sat`

These are the counterexamples that exposed the duplicate-elimination and aggregate
bugs. All of them now report `sat`; each one used to return `unsat`, a bogus proof
of equivalence.

| # | q1 | q2 | q1 rows | q2 rows | expected |
| --- | --- | --- | --- | --- | --- |
| B1 | `SELECT * FROM (VALUES (1),(1)) AS t UNION SELECT * FROM (VALUES (1)) AS u` | `SELECT * FROM (VALUES (1),(1)) AS t` | 1 | 2 | `sat` |
| B2 | `SELECT * FROM (VALUES (1),(1)) AS t EXCEPT SELECT * FROM (VALUES (2)) AS u` | `SELECT * FROM (VALUES (1),(1)) AS t` | 1 | 2 | `sat` |
| B3 | `SELECT * FROM (VALUES (1),(1)) AS t INTERSECT SELECT * FROM (VALUES (1),(1)) AS u` | `SELECT * FROM (VALUES (1),(1)) AS t INTERSECT ALL SELECT * FROM (VALUES (1),(1)) AS u` | 1 | 2 | `sat` |
| B4 | `SELECT DISTINCT t.EXPR$0 FROM (VALUES (1),(1)) AS t` | `SELECT t.EXPR$0 FROM (VALUES (1),(1)) AS t` | 1 | 2 | `sat` |
| B5 | `SELECT t.EXPR$0, SUM(t.EXPR$1) FROM (VALUES (1,2),(1,3)) AS t GROUP BY t.EXPR$0` | `SELECT t.EXPR$0, MAX(t.EXPR$1) FROM (VALUES (1,2),(1,3)) AS t GROUP BY t.EXPR$0` | `(1,5)` | `(1,3)` | `sat` |
| B6 | `SELECT t.EXPR$0, MIN(t.EXPR$1) FROM (VALUES (1,2),(1,3)) AS t GROUP BY t.EXPR$0` | `SELECT t.EXPR$0, MAX(t.EXPR$1) FROM (VALUES (1,2),(1,3)) AS t GROUP BY t.EXPR$0` | `(1,2)` | `(1,3)` | `sat` |
| B7 | `SELECT t.EXPR$0, COUNT(DISTINCT t.EXPR$1) FROM (VALUES (1,2),(1,2)) AS t GROUP BY t.EXPR$0` | `SELECT t.EXPR$0, COUNT(t.EXPR$1) FROM (VALUES (1,2),(1,2)) AS t GROUP BY t.EXPR$0` | `(1,1)` | `(1,2)` | `sat` |

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
| P8 | `SELECT t.EXPR$0, MIN(t.EXPR$1) FROM (VALUES (1,2),(1,3)) AS t GROUP BY t.EXPR$0` | `SELECT t.EXPR$0, MIN(t.EXPR$1) FROM (VALUES (1,3),(1,2)) AS t GROUP BY t.EXPR$0` | `MIN` is order-independent |
| P9 | `SELECT t.EXPR$0, COUNT(DISTINCT t.EXPR$1) FROM (VALUES (1,2),(1,2)) AS t GROUP BY t.EXPR$0` | `SELECT t.EXPR$0, COUNT(t.EXPR$1) FROM (VALUES (1,2)) AS t GROUP BY t.EXPR$0` | `COUNT(DISTINCT)` = `COUNT` over deduped input |

### Aggregate values -- check these against SQL by hand

Each is a single query; pair it with itself and read the value out of the generated
`.smt2` (see "Inspecting the generated SMT-LIB"). `N` below is
`CAST(NULL AS INTEGER)`, because Calcite rejects a bare `NULL` in `VALUES`.

| Query over `(VALUES ...) AS t GROUP BY t.EXPR$0` | rows | SQL | translator |
| --- | --- | --- | --- |
| `SUM(t.EXPR$1)` | `(1,2),(1,3)` | 5 | 5 |
| `MIN(t.EXPR$1)` | `(1,2),(1,3)` | 2 | 2 |
| `MAX(t.EXPR$1)` | `(1,2),(1,3)` | 3 | 3 |
| `MIN(t.EXPR$1)` | `(1,-5),(1,-3)` | -5 | -5 |
| `SUM(t.EXPR$1)` | `(1,2),(1,2),(1,3)` | 7 | 7 |
| `COUNT(t.EXPR$1)` | `(1,2),(1,2),(1,3)` | 3 | 3 |
| `COUNT(DISTINCT t.EXPR$1)` | `(1,2),(1,2),(1,3)` | 2 | 2 |
| `COUNT(t.EXPR$1)` | `(1,N),(1,3)` | 1 | 1 |
| `COUNT(*)` | `(1,N),(1,3)` | 2 | 2 |
| `SUM(t.EXPR$1)` | `(1,N),(1,3)` | 3 | 3 |
| `MIN(t.EXPR$1)` | `(1,N),(1,3)` | 3 | 3 |
| `SUM(t.EXPR$1)` | `(1,N),(1,N)` | NULL | NULL |
| `MIN(t.EXPR$1)` | `(1,N),(1,N)` | NULL | NULL |
| `COUNT(t.EXPR$1)` | `(1,N),(1,N)` | 0 | 0 |
| `MIN(t.EXPR$1)` | `(1,'pear'),(1,'apple')` | 'apple' | 'apple' |
| `MAX(t.EXPR$1)` | `(1,'pear'),(1,'apple')` | 'pear' | 'pear' |

### Feature-probe queries

Single queries used to establish what the translator accepts. Pair each with
itself to run it.

| Query | Outcome |
| --- | --- |
| `SELECT t.ENAME, SUM(t.EMPNO) FROM EMP t GROUP BY t.ENAME` | accepted |
| `SELECT t.ENAME, AVG(t.EMPNO) FROM EMP t GROUP BY t.ENAME` | rejected: unsupported aggregate |
| `SELECT t.ENAME FROM EMP t ORDER BY t.ENAME` | skipped by `isSupported` |
| `SELECT t.ENAME FROM EMP t FETCH NEXT 3 ROWS ONLY` | rejected: unsupported relational operator `LogicalSort` |
| `SELECT CAST(t.EMPNO AS VARCHAR(10)) FROM EMP t` | error: `CVC5ApiException`, sort mismatch |
| `SELECT t.EMPNO / 2 FROM EMP t` | error: `CVC5ApiException`, `Real` vs `Int` |
| `SELECT t.EMPNO + 1, t.ENAME \|\| 'x', UPPER(t.ENAME), SUBSTRING(t.ENAME FROM 2 FOR 3) FROM EMP t` | accepted |
| `SELECT CASE WHEN t.EMPNO > 5 THEN 1 ELSE 2 END FROM EMP t` | accepted |
| `SELECT * FROM EMP t WHERE t.COMM IS NULL AND t.SAL IS NOT NULL` | accepted |
| `SELECT * FROM EMP t LEFT JOIN DEPT d ON t.DEPTNO = d.DEPTNO` | accepted |
| `SELECT * FROM EMP t WHERE t.EMPNO IN (SELECT d.DEPTNO FROM DEPT d)` | accepted (becomes a join) |
| `SELECT * FROM EMP t WHERE EXISTS (SELECT * FROM DEPT d WHERE d.DEPTNO = t.DEPTNO)` | accepted (becomes a join) |

## Commands for the regression pairs

The same cases as `Cvc5TranslatorTest`, as shell commands, for when you want to look at the
generated SMT-LIB rather than just a pass or fail. Copy-pasteable from the repository root;
each prints one `result:` line.

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

# B5  SUM must not be MAX
mvn -q exec:exec \
  -Dq1='SELECT t.EXPR$0, SUM(t.EXPR$1) FROM (VALUES (1,2),(1,3)) AS t GROUP BY t.EXPR$0' \
  -Dq2='SELECT t.EXPR$0, MAX(t.EXPR$1) FROM (VALUES (1,2),(1,3)) AS t GROUP BY t.EXPR$0'

# B6  MIN must not be MAX
mvn -q exec:exec \
  -Dq1='SELECT t.EXPR$0, MIN(t.EXPR$1) FROM (VALUES (1,2),(1,3)) AS t GROUP BY t.EXPR$0' \
  -Dq2='SELECT t.EXPR$0, MAX(t.EXPR$1) FROM (VALUES (1,2),(1,3)) AS t GROUP BY t.EXPR$0'

# B7  COUNT(DISTINCT x) must not be COUNT(x)
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

Current output:

```
B1   sat    got=sat      PASS
B2   sat    got=sat      PASS
B3   sat    got=sat      PASS
B4   sat    got=sat      PASS
B5   sat    got=sat      PASS
B6   sat    got=sat      PASS
B7   sat    got=sat      PASS
P1   unsat  got=unsat    PASS
P2   unsat  got=unsat    PASS
P3   unsat  got=unsat    PASS
P4   unsat  got=unsat    PASS
P5   unsat  got=unsat    PASS
P6   unsat  got=unsat    PASS
P7   unsat  got=unsat    PASS
```
