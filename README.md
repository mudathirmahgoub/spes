# SQL Query Equivalence

Checks whether two SQL queries always return the same table. The queries are parsed with
Apache Calcite, translated into an SMT problem, and solved with cvc5.

| result | meaning |
| --- | --- |
| `unsat` | the queries are **equivalent** |
| `sat` | the queries **differ**, and the model is a database that shows how |
| `unknown` | the solver ran out of time (10 s per query) |

## Setup

You need a JDK and Maven. Nothing else — the solvers are downloaded for you.

```bash
mvn initialize      # one-time, fetches z3
mvn test            # build and run the tests
```

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
| `inequivalent` | a counterexample database was found |
| `unknown` | timed out |
| `skipped` | uses a construct the translator does not support |
| `error` | translation failed |
| `filtered` | excluded before parsing (`ORDER BY`) |

Expect around 25 minutes per file: most queries over `EMP`/`DEPT` reach the 10 s limit.

## Options

All options are passed as `-Dname=value`.

| option | description | default |
| --- | --- | --- |
| `q1` | first SQL query | — |
| `q2` | second SQL query | — |
| `batch` | JSON file of query pairs to run instead of `q1`/`q2` | `testData/no_aggregation_sat.json` |
| `sem` | `bags` counts duplicate rows, `sets` ignores them | `bags` |
| `out` | where to write the generated SMT-LIB | `single.smt2` |
| `cvc5.home` | use a local cvc5 build instead of the released one | — |

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
