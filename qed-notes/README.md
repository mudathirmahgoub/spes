# SQL equivalence: U-expressions, Q-expressions, LIA*

Study notes and teaching material on the three main bag-semantics SQL equivalence provers.

## Deliverables

| file | what |
|---|---|
| [tex/sql-equivalence.pdf](tex/sql-equivalence.pdf) | **36-page article.** All three formalisms from scratch, for someone who wants to *implement* them. |
| [tex/slides.pdf](tex/slides.pdf) | **34-frame Beamer deck** (167 overlay pages), same material with build-up overlays and charts. |
| [QED-section2-explained.md](QED-section2-explained.md) | Earlier long-form walkthrough of QED §2 specifically, symbol by symbol, with live PostgreSQL output. |

## Sources covered

- **UDP** — Chu, Murphy, Roesch, Cheung, Suciu. *Axiomatic Foundations and Algorithms for Deciding Semantic Equivalences of SQL Queries.* PVLDB 11(11), 2018. ([arXiv:1802.02229](https://arxiv.org/abs/1802.02229))
- **QED** — Wang, Pan, Cheung. *QED: A Powerful Query Equivalence Decider for SQL.* [PVLDB 17(11):3602](https://www.vldb.org/pvldb/vol17/p3602-wang.pdf), 2024.
- **SQLSolver** — Ding et al. *Proving Query Equivalence Using Linear Integer Arithmetic.* [PACMMOD 1(4), Art. 227](https://dl.acm.org/doi/10.1145/3626768) (SIGMOD), 2023.
- **SPES** — Zhou et al., ICDE 2022 (baseline).

## Supporting artefacts

| file | how it was produced |
|---|---|
| `calcite_plans.txt` | Apache Calcite 1.19 `RelNode` plans for the running example, including `AggregateJoinTransposeRule.EXTENDED` fired with and without a unique key |
| `q1_plan.json`, `q2_plan.json` | PostgreSQL 18 `EXPLAIN (ANALYZE, VERBOSE, BUFFERS, FORMAT JSON)` — open in **pgAdmin → Explain**, or paste into [explain.dalibo.com](https://explain.dalibo.com) |
| `q1_plan.svg`, `q2_plan.svg`, `tex/figs/*.png` | rendered from those JSON plans by `render_plan.py` |
| `render_plan.py` | EXPLAIN-JSON → SVG plan-tree renderer |
| `make_figs.py` | rasterises the SVGs at 3× for LaTeX |

## Building

```bash
export PATH="/Library/TeX/texbin:$PATH"
cd tex
pdflatex sql-equivalence && pdflatex sql-equivalence   # twice, for the ToC/refs
pdflatex slides
```

Regenerating the figures needs the plan JSON in the parent directory:

```bash
python3 render_plan.py && python3 make_figs.py
```

## The running example

Calcite's `AggregateJoinTransposeRule`, used throughout both documents:

```sql
-- Q1: aggregate ABOVE the join
select x, sum(y) as r from R join S on R.x = S.a group by x;

-- Q2: aggregate BELOW the join
select t.x, t.r
from (select x, sum(y) as r from R group by x) t join S on t.x = S.a;
```

Equivalent **iff** `S.a` is distinct. Without the key: `Q1` returns `(1,60)`, `Q2` returns
`(1,30)` twice — wrong in two independent ways. Verified against PostgreSQL; Calcite's own
rule compensates for the missing key by multiplying the aggregate by `COUNT()`, which is
literally the `× S(a)` factor of the U-expression.

## Accuracy

Every algorithm, axiom and number is traced to a specific definition, theorem, algorithm or
table in the source papers, and was re-verified against the paper text after drafting.
Places where a claim is our own inference rather than a paper's statement are marked as
such in the article (see the remarks on UDP's `GROUP BY` de-sugaring, on the primary-key rule
for tables with non-key columns, and on the two QED algorithms differing in whether they
require a term bijection).
