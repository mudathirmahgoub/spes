# cvc5 main vs bags_to_liastar on the spes SQL benchmarks (timeout 10 s, 8 in parallel)

| batch | semantics | problems | main: sat / unsat / t.o. / err | base: sat / unsat / t.o. / err | branch: sat / unsat / t.o. / err | branch+liastar: sat / unsat / t.o. / err | branch+liastar+elements: sat / unsat / t.o. / err | branch+liastar+dio: sat / unsat / t.o. / err | branch+liastar(gated): sat / unsat / t.o. / err | merged: sat / unsat / t.o. / err | merged+liastar: sat / unsat / t.o. / err | merged+liastar+elements: sat / unsat / t.o. / err | merged+liastar(gated): sat / unsat / t.o. / err |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| bags | bags | 3 | 0 / 3 / 0 / 0 | 0 / 3 / 0 / 0 | 0 / 3 / 0 / 0 | 0 / 3 / 0 / 0 | 0 / 3 / 0 / 0 | 0 / 3 / 0 / 0 | 0 / 3 / 0 / 0 | 0 / 3 / 0 / 0 | 0 / 3 / 0 / 0 | 0 / 3 / 0 / 0 | 0 / 3 / 0 / 0 |
| bags | sets | 3 | 0 / 3 / 0 / 0 | 0 / 3 / 0 / 0 | 0 / 3 / 0 / 0 | 0 / 3 / 0 / 0 | 0 / 3 / 0 / 0 | 0 / 3 / 0 / 0 | 0 / 3 / 0 / 0 | 0 / 3 / 0 / 0 | 0 / 3 / 0 / 0 | 0 / 3 / 0 / 0 | 0 / 3 / 0 / 0 |
| calcite_tests | bags | 124 | 0 / 23 / 101 / 0 | 0 / 23 / 101 / 0 | 0 / 23 / 101 / 0 | 0 / 14 / 110 / 0 | 0 / 15 / 109 / 0 | 0 / 14 / 110 / 0 | 0 / 23 / 101 / 0 | 0 / 23 / 101 / 0 | 0 / 15 / 109 / 0 | 0 / 15 / 109 / 0 | 0 / 23 / 101 / 0 |
| calcite_tests | sets | 124 | 1 / 81 / 39 / 3 | 1 / 75 / 48 / 0 | 1 / 75 / 48 / 0 | 1 / 75 / 48 / 0 | 1 / 75 / 48 / 0 | 1 / 75 / 48 / 0 | 1 / 75 / 48 / 0 | 1 / 81 / 39 / 3 | 1 / 81 / 39 / 3 | 1 / 81 / 39 / 3 | 1 / 81 / 39 / 3 |
| no_aggregation | bags | 88 | 1 / 35 / 52 / 0 | 1 / 35 / 52 / 0 | 1 / 35 / 52 / 0 | 0 / 26 / 61 / 0 | 1 / 26 / 61 / 0 | 0 / 26 / 61 / 0 | 1 / 35 / 52 / 0 | 1 / 35 / 52 / 0 | 0 / 27 / 60 / 0 | 1 / 28 / 59 / 0 | 1 / 35 / 52 / 0 |
| no_aggregation | sets | 88 | 1 / 85 / 2 / 0 | 0 / 81 / 7 / 0 | 0 / 81 / 7 / 0 | 0 / 81 / 7 / 0 | 0 / 81 / 7 / 0 | 0 / 81 / 7 / 0 | 0 / 81 / 7 / 0 | 1 / 85 / 2 / 0 | 1 / 85 / 2 / 0 | 1 / 85 / 2 / 0 | 1 / 85 / 2 / 0 |
| no_aggregation_no_null | bags | 62 | 0 / 18 / 44 / 0 | 0 / 18 / 44 / 0 | 0 / 18 / 44 / 0 | 0 / 9 / 53 / 0 | 0 / 9 / 53 / 0 | 0 / 9 / 53 / 0 | 0 / 18 / 44 / 0 | 0 / 18 / 44 / 0 | 0 / 10 / 52 / 0 | 0 / 10 / 52 / 0 | 0 / 18 / 44 / 0 |
| no_aggregation_no_null | sets | 62 | 0 / 60 / 2 / 0 | 0 / 57 / 5 / 0 | 0 / 57 / 5 / 0 | 0 / 57 / 5 / 0 | 0 / 57 / 5 / 0 | 0 / 57 / 5 / 0 | 0 / 57 / 5 / 0 | 0 / 60 / 2 / 0 | 0 / 60 / 2 / 0 | 0 / 60 / 2 / 0 | 0 / 60 / 2 / 0 |
| no_aggregation_no_null_no_cast | bags | 61 | 0 / 17 / 44 / 0 | 0 / 17 / 44 / 0 | 0 / 17 / 44 / 0 | 0 / 8 / 53 / 0 | 0 / 8 / 53 / 0 | 0 / 8 / 53 / 0 | 0 / 17 / 44 / 0 | 0 / 17 / 44 / 0 | 0 / 9 / 52 / 0 | 0 / 9 / 52 / 0 | 0 / 17 / 44 / 0 |
| no_aggregation_no_null_no_cast | sets | 61 | 0 / 59 / 2 / 0 | 0 / 56 / 5 / 0 | 0 / 56 / 5 / 0 | 0 / 56 / 5 / 0 | 0 / 56 / 5 / 0 | 0 / 56 / 5 / 0 | 0 / 56 / 5 / 0 | 0 / 59 / 2 / 0 | 0 / 59 / 2 / 0 | 0 / 59 / 2 / 0 | 0 / 59 / 2 / 0 |
| no_aggregation_no_null_no_cast_no_outer_join | bags | 49 | 0 / 17 / 32 / 0 | 0 / 17 / 32 / 0 | 0 / 17 / 32 / 0 | 0 / 8 / 41 / 0 | 0 / 9 / 40 / 0 | 0 / 8 / 41 / 0 | 0 / 17 / 32 / 0 | 0 / 17 / 32 / 0 | 0 / 9 / 40 / 0 | 0 / 9 / 40 / 0 | 0 / 17 / 32 / 0 |
| no_aggregation_no_null_no_cast_no_outer_join | sets | 49 | 0 / 49 / 0 / 0 | 0 / 49 / 0 / 0 | 0 / 49 / 0 / 0 | 0 / 49 / 0 / 0 | 0 / 49 / 0 / 0 | 0 / 49 / 0 / 0 | 0 / 49 / 0 / 0 | 0 / 49 / 0 / 0 | 0 / 49 / 0 / 0 | 0 / 49 / 0 / 0 | 0 / 49 / 0 / 0 |
| no_aggregation_sat | bags | 85 | 71 / 0 / 14 / 0 | 59 / 0 / 26 / 0 | 58 / 0 / 27 / 0 | 18 / 0 / 48 / 0 | 37 / 0 / 48 / 0 | 18 / 0 / 47 / 0 | 59 / 0 / 26 / 0 | 70 / 0 / 15 / 0 | 18 / 0 / 48 / 0 | 37 / 0 / 48 / 0 | 70 / 0 / 15 / 0 |
| no_aggregation_sat | sets | 85 | 73 / 8 / 4 / 0 | 32 / 8 / 45 / 0 | 32 / 8 / 45 / 0 | 32 / 8 / 45 / 0 | 32 / 8 / 45 / 0 | 32 / 8 / 45 / 0 | 32 / 8 / 45 / 0 | 73 / 8 / 4 / 0 | 73 / 8 / 4 / 0 | 73 / 8 / 4 / 0 | 73 / 8 / 4 / 0 |
| spark_tests | bags | 79 | 2 / 50 / 27 / 0 | 2 / 49 / 28 / 0 | 2 / 49 / 28 / 0 | 0 / 48 / 30 / 0 | 1 / 47 / 31 / 0 | 0 / 47 / 31 / 0 | 1 / 49 / 28 / 0 | 2 / 50 / 27 / 0 | 0 / 49 / 29 / 0 | 1 / 49 / 29 / 0 | 1 / 50 / 27 / 0 |
| spark_tests | sets | 79 | 3 / 73 / 3 / 0 | 3 / 68 / 8 / 0 | 3 / 68 / 8 / 0 | 3 / 68 / 8 / 0 | 3 / 68 / 8 / 0 | 3 / 68 / 8 / 0 | 3 / 68 / 8 / 0 | 3 / 73 / 3 / 0 | 3 / 73 / 3 / 0 | 3 / 73 / 3 / 0 | 3 / 73 / 3 / 0 |
| **all bags** | bags | 551 | **237** solved: 74 / 163 / 314 / 0 | **224** solved: 62 / 162 / 327 / 0 | **223** solved: 61 / 162 / 328 / 0 | **134** solved: 18 / 116 / 396 / 0 | **156** solved: 39 / 117 / 395 / 0 | **133** solved: 18 / 115 / 396 / 0 | **223** solved: 61 / 162 / 327 / 0 | **236** solved: 73 / 163 / 315 / 0 | **140** solved: 18 / 122 / 390 / 0 | **162** solved: 39 / 123 / 389 / 0 | **235** solved: 72 / 163 / 315 / 0 |
| **all sets** | sets | 551 | **496** solved: 78 / 418 / 52 / 3 | **433** solved: 36 / 397 / 118 / 0 | **433** solved: 36 / 397 / 118 / 0 | **433** solved: 36 / 397 / 118 / 0 | **433** solved: 36 / 397 / 118 / 0 | **433** solved: 36 / 397 / 118 / 0 | **433** solved: 36 / 397 / 118 / 0 | **496** solved: 78 / 418 / 52 / 3 | **496** solved: 78 / 418 / 52 / 3 | **496** solved: 78 / 418 / 52 / 3 | **496** solved: 78 / 418 / 52 / 3 |

## Disagreements between solved answers
0 disagreements

## check-models failures
- main: 3 -- calcite_tests__sets/testAggregateConstantKeyRule.smt2, calcite_tests__sets/testAggregateConstantKeyRule2.smt2, calcite_tests__sets/testPushFilterPastAgg.smt2
- base: 0
- branch: 0
- branch+liastar: 0
- branch+liastar+elements: 0
- branch+liastar+dio: 0
- branch+liastar(gated): 0
- merged: 3 -- calcite_tests__sets/testAggregateConstantKeyRule.smt2, calcite_tests__sets/testAggregateConstantKeyRule2.smt2, calcite_tests__sets/testPushFilterPastAgg.smt2
- merged+liastar: 3 -- calcite_tests__sets/testAggregateConstantKeyRule.smt2, calcite_tests__sets/testAggregateConstantKeyRule2.smt2, calcite_tests__sets/testPushFilterPastAgg.smt2
- merged+liastar+elements: 3 -- calcite_tests__sets/testAggregateConstantKeyRule.smt2, calcite_tests__sets/testAggregateConstantKeyRule2.smt2, calcite_tests__sets/testPushFilterPastAgg.smt2
- merged+liastar(gated): 3 -- calcite_tests__sets/testAggregateConstantKeyRule.smt2, calcite_tests__sets/testAggregateConstantKeyRule2.smt2, calcite_tests__sets/testPushFilterPastAgg.smt2

## Solved by one configuration and not another
### main vs base: +77 / -1
- gained calcite_tests__sets/testFullOuterJoinSimplificationToLeftOuter.smt2: base=timeout unsat in 0.27s
- gained calcite_tests__sets/testFullOuterJoinSimplificationToRightOuter.smt2: base=timeout unsat in 0.33s
- gained calcite_tests__sets/testPullConstantIntoJoin.smt2: base=timeout unsat in 0.27s
- gained calcite_tests__sets/testSemiJoinRule.smt2: base=timeout unsat in 0.05s
- gained calcite_tests__sets/testSemiJoinRuleFull.smt2: base=timeout unsat in 0.93s
- gained calcite_tests__sets/testSemiJoinRuleRight.smt2: base=timeout unsat in 0.28s
- gained no_aggregation__sets/testEmptyJoinRight.smt2: base=timeout unsat in 0.06s
- gained no_aggregation__sets/testFullOuterJoinSimplificationToLeftOuter.smt2: base=timeout unsat in 0.29s
- gained no_aggregation__sets/testFullOuterJoinSimplificationToRightOuter.smt2: base=timeout unsat in 0.35s
- gained no_aggregation__sets/testPullConstantIntoJoin.smt2: base=timeout unsat in 0.29s
- gained no_aggregation__sets/testPullNull.smt2: base=timeout sat in 0.04s
- gained no_aggregation_no_null__sets/testFullOuterJoinSimplificationToLeftOuter.smt2: base=timeout unsat in 0.27s
- gained no_aggregation_no_null__sets/testFullOuterJoinSimplificationToRightOuter.smt2: base=timeout unsat in 0.32s
- gained no_aggregation_no_null__sets/testPullConstantIntoJoin.smt2: base=timeout unsat in 0.28s
- gained no_aggregation_no_null_no_cast__sets/testFullOuterJoinSimplificationToLeftOuter.smt2: base=timeout unsat in 0.27s
- gained no_aggregation_no_null_no_cast__sets/testFullOuterJoinSimplificationToRightOuter.smt2: base=timeout unsat in 0.31s
- gained no_aggregation_no_null_no_cast__sets/testPullConstantIntoJoin.smt2: base=timeout unsat in 0.28s
- gained no_aggregation_sat__bags/testDecorrelateTwoIn.smt2: base=timeout sat in 5.94s
- gained no_aggregation_sat__bags/testMergeIntersect.smt2: base=timeout sat in 0.31s
- gained no_aggregation_sat__bags/testMergeMinus.smt2: base=timeout sat in 0.39s
- gained no_aggregation_sat__bags/testMergeMinusRightDeep.smt2: base=timeout sat in 0.31s
- gained no_aggregation_sat__bags/testMergeSetOpMixed.smt2: base=timeout sat in 0.55s
- gained no_aggregation_sat__bags/testMergeUnionDistinct.smt2: base=timeout sat in 0.53s
- gained no_aggregation_sat__bags/testMergeUnionMixed.smt2: base=timeout sat in 0.29s
- gained no_aggregation_sat__bags/testMergeUnionMixed2.smt2: base=timeout sat in 0.25s
- gained no_aggregation_sat__bags/testPushJoinThroughUnionOnLeft.smt2: base=timeout sat in 3.25s
- gained no_aggregation_sat__bags/testPushJoinThroughUnionOnRight.smt2: base=timeout sat in 8.28s
- gained no_aggregation_sat__bags/testTransitiveInferenceJoin3way.smt2: base=timeout sat in 6.40s
- gained no_aggregation_sat__bags/testTransitiveInferenceUnion.smt2: base=timeout sat in 3.96s
- gained no_aggregation_sat__bags/testWhereInCorrelated.smt2: base=timeout sat in 1.90s
- gained no_aggregation_sat__sets/testDecorrelateTwoIn.smt2: base=timeout sat in 0.07s
- gained no_aggregation_sat__sets/testEmptyJoin.smt2: base=timeout sat in 0.04s
- gained no_aggregation_sat__sets/testEmptyJoinRight.smt2: base=timeout sat in 0.05s
- gained no_aggregation_sat__sets/testFullOuterJoinSimplificationToInner.smt2: base=timeout sat in 0.05s
- gained no_aggregation_sat__sets/testFullOuterJoinSimplificationToLeftOuter.smt2: base=timeout sat in 0.05s
- gained no_aggregation_sat__sets/testFullOuterJoinSimplificationToRightOuter.smt2: base=timeout sat in 0.44s
- gained no_aggregation_sat__sets/testLeftOuterJoinSimplificationToInner.smt2: base=timeout sat in 0.06s
- gained no_aggregation_sat__sets/testMergeFilter.smt2: base=timeout sat in 0.04s
- gained no_aggregation_sat__sets/testMergeIntersect.smt2: base=timeout sat in 0.05s
- gained no_aggregation_sat__sets/testMergeJoinFilter.smt2: base=timeout sat in 0.05s
- gained no_aggregation_sat__sets/testMergeMinus.smt2: base=timeout sat in 0.04s
- gained no_aggregation_sat__sets/testMergeMinusRightDeep.smt2: base=timeout sat in 0.04s
- gained no_aggregation_sat__sets/testMergeSetOpMixed.smt2: base=timeout sat in 0.05s
- gained no_aggregation_sat__sets/testPullConstantIntoFilter.smt2: base=timeout sat in 0.04s
- gained no_aggregation_sat__sets/testPullConstantIntoJoin.smt2: base=timeout sat in 0.05s
- gained no_aggregation_sat__sets/testPullConstantThroughUnion.smt2: base=timeout sat in 0.04s
- gained no_aggregation_sat__sets/testPullConstantThroughUnion2.smt2: base=timeout sat in 0.04s
- gained no_aggregation_sat__sets/testPushFilterThroughSemiJoin.smt2: base=timeout sat in 0.06s
- gained no_aggregation_sat__sets/testPushJoinThroughUnionOnRight.smt2: base=timeout sat in 0.04s
- gained no_aggregation_sat__sets/testPushProjectPastFilter.smt2: base=timeout sat in 0.08s
- gained no_aggregation_sat__sets/testPushSemiJoinPastJoinRuleLeft.smt2: base=timeout sat in 0.14s
- gained no_aggregation_sat__sets/testRemoveSemiJoin.smt2: base=timeout sat in 0.04s
- gained no_aggregation_sat__sets/testRemoveSemiJoinRight.smt2: base=timeout sat in 0.05s
- gained no_aggregation_sat__sets/testRemoveSemiJoinRightWithFilter.smt2: base=timeout sat in 0.06s
- gained no_aggregation_sat__sets/testRemoveSemiJoinWithFilter.smt2: base=timeout sat in 0.05s
- gained no_aggregation_sat__sets/testRightOuterJoinSimplificationToInner.smt2: base=timeout sat in 0.05s
- gained no_aggregation_sat__sets/testSemiJoinReduceConstants.smt2: base=timeout sat in 0.06s
- gained no_aggregation_sat__sets/testTransitiveInferenceComplexPredicate.smt2: base=timeout sat in 0.08s
- gained no_aggregation_sat__sets/testTransitiveInferenceConjunctInPullUp.smt2: base=timeout sat in 0.06s
- gained no_aggregation_sat__sets/testTransitiveInferenceFullOuterJoin.smt2: base=timeout sat in 0.12s
- gained no_aggregation_sat__sets/testTransitiveInferenceJoin.smt2: base=timeout sat in 0.05s
- gained no_aggregation_sat__sets/testTransitiveInferenceJoin3way.smt2: base=timeout sat in 0.26s
- gained no_aggregation_sat__sets/testTransitiveInferenceLeftOuterJoin.smt2: base=timeout sat in 0.13s
- gained no_aggregation_sat__sets/testTransitiveInferenceNoPullUpExprs.smt2: base=timeout sat in 0.06s
- gained no_aggregation_sat__sets/testTransitiveInferencePreventProjectPullUp.smt2: base=timeout sat in 0.09s
- gained no_aggregation_sat__sets/testTransitiveInferenceProject.smt2: base=timeout sat in 0.08s
- gained no_aggregation_sat__sets/testTransitiveInferencePullUpThruAlias.smt2: base=timeout sat in 0.05s
- gained no_aggregation_sat__sets/testTransitiveInferenceRightOuterJoin.smt2: base=timeout sat in 0.06s
- gained no_aggregation_sat__sets/testTransitiveInferenceUnion.smt2: base=timeout sat in 0.08s
- gained no_aggregation_sat__sets/testTransitiveInferenceUnionAlwaysTrue.smt2: base=timeout sat in 0.08s
- gained no_aggregation_sat__sets/testWhereInCorrelated.smt2: base=timeout sat in 0.05s
- gained spark_tests__bags/6.smt2: base=timeout unsat in 0.59s
- gained spark_tests__sets/108.smt2: base=timeout unsat in 1.10s
- gained spark_tests__sets/50.smt2: base=timeout unsat in 0.11s
- gained spark_tests__sets/56.smt2: base=timeout unsat in 0.84s
- gained spark_tests__sets/70.smt2: base=timeout unsat in 0.17s
- gained spark_tests__sets/86.smt2: base=timeout unsat in 0.07s
- lost no_aggregation_sat__bags/testPushJoinCondDownToProject.smt2: base=sat 6.69s, main=timeout

### branch vs base: +0 / -1
- lost no_aggregation_sat__bags/testTransitiveInferenceUnionAlwaysTrue.smt2: base=sat 10.02s, branch=timeout

### branch vs main: +1 / -78
- gained no_aggregation_sat__bags/testPushJoinCondDownToProject.smt2: main=timeout sat in 6.73s
- lost calcite_tests__sets/testFullOuterJoinSimplificationToLeftOuter.smt2: main=unsat 0.27s, branch=timeout
- lost calcite_tests__sets/testFullOuterJoinSimplificationToRightOuter.smt2: main=unsat 0.33s, branch=timeout
- lost calcite_tests__sets/testPullConstantIntoJoin.smt2: main=unsat 0.27s, branch=timeout
- lost calcite_tests__sets/testSemiJoinRule.smt2: main=unsat 0.05s, branch=timeout
- lost calcite_tests__sets/testSemiJoinRuleFull.smt2: main=unsat 0.93s, branch=timeout
- lost calcite_tests__sets/testSemiJoinRuleRight.smt2: main=unsat 0.28s, branch=timeout
- lost no_aggregation__sets/testEmptyJoinRight.smt2: main=unsat 0.06s, branch=timeout
- lost no_aggregation__sets/testFullOuterJoinSimplificationToLeftOuter.smt2: main=unsat 0.29s, branch=timeout
- lost no_aggregation__sets/testFullOuterJoinSimplificationToRightOuter.smt2: main=unsat 0.35s, branch=timeout
- lost no_aggregation__sets/testPullConstantIntoJoin.smt2: main=unsat 0.29s, branch=timeout
- lost no_aggregation__sets/testPullNull.smt2: main=sat 0.04s, branch=timeout
- lost no_aggregation_no_null__sets/testFullOuterJoinSimplificationToLeftOuter.smt2: main=unsat 0.27s, branch=timeout
- lost no_aggregation_no_null__sets/testFullOuterJoinSimplificationToRightOuter.smt2: main=unsat 0.32s, branch=timeout
- lost no_aggregation_no_null__sets/testPullConstantIntoJoin.smt2: main=unsat 0.28s, branch=timeout
- lost no_aggregation_no_null_no_cast__sets/testFullOuterJoinSimplificationToLeftOuter.smt2: main=unsat 0.27s, branch=timeout
- lost no_aggregation_no_null_no_cast__sets/testFullOuterJoinSimplificationToRightOuter.smt2: main=unsat 0.31s, branch=timeout
- lost no_aggregation_no_null_no_cast__sets/testPullConstantIntoJoin.smt2: main=unsat 0.28s, branch=timeout
- lost no_aggregation_sat__bags/testDecorrelateTwoIn.smt2: main=sat 5.94s, branch=timeout
- lost no_aggregation_sat__bags/testMergeIntersect.smt2: main=sat 0.31s, branch=timeout
- lost no_aggregation_sat__bags/testMergeMinus.smt2: main=sat 0.39s, branch=timeout
- lost no_aggregation_sat__bags/testMergeMinusRightDeep.smt2: main=sat 0.31s, branch=timeout
- lost no_aggregation_sat__bags/testMergeSetOpMixed.smt2: main=sat 0.55s, branch=timeout
- lost no_aggregation_sat__bags/testMergeUnionDistinct.smt2: main=sat 0.53s, branch=timeout
- lost no_aggregation_sat__bags/testMergeUnionMixed.smt2: main=sat 0.29s, branch=timeout
- lost no_aggregation_sat__bags/testMergeUnionMixed2.smt2: main=sat 0.25s, branch=timeout
- lost no_aggregation_sat__bags/testPushJoinThroughUnionOnLeft.smt2: main=sat 3.25s, branch=timeout
- lost no_aggregation_sat__bags/testPushJoinThroughUnionOnRight.smt2: main=sat 8.28s, branch=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceJoin3way.smt2: main=sat 6.40s, branch=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceUnion.smt2: main=sat 3.96s, branch=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceUnionAlwaysTrue.smt2: main=sat 8.00s, branch=timeout
- lost no_aggregation_sat__bags/testWhereInCorrelated.smt2: main=sat 1.90s, branch=timeout
- lost no_aggregation_sat__sets/testDecorrelateTwoIn.smt2: main=sat 0.07s, branch=timeout
- lost no_aggregation_sat__sets/testEmptyJoin.smt2: main=sat 0.04s, branch=timeout
- lost no_aggregation_sat__sets/testEmptyJoinRight.smt2: main=sat 0.05s, branch=timeout
- lost no_aggregation_sat__sets/testFullOuterJoinSimplificationToInner.smt2: main=sat 0.05s, branch=timeout
- lost no_aggregation_sat__sets/testFullOuterJoinSimplificationToLeftOuter.smt2: main=sat 0.05s, branch=timeout
- lost no_aggregation_sat__sets/testFullOuterJoinSimplificationToRightOuter.smt2: main=sat 0.44s, branch=timeout
- lost no_aggregation_sat__sets/testLeftOuterJoinSimplificationToInner.smt2: main=sat 0.06s, branch=timeout
- lost no_aggregation_sat__sets/testMergeFilter.smt2: main=sat 0.04s, branch=timeout
- lost no_aggregation_sat__sets/testMergeIntersect.smt2: main=sat 0.05s, branch=timeout
- lost no_aggregation_sat__sets/testMergeJoinFilter.smt2: main=sat 0.05s, branch=timeout
- lost no_aggregation_sat__sets/testMergeMinus.smt2: main=sat 0.04s, branch=timeout
- lost no_aggregation_sat__sets/testMergeMinusRightDeep.smt2: main=sat 0.04s, branch=timeout
- lost no_aggregation_sat__sets/testMergeSetOpMixed.smt2: main=sat 0.05s, branch=timeout
- lost no_aggregation_sat__sets/testPullConstantIntoFilter.smt2: main=sat 0.04s, branch=timeout
- lost no_aggregation_sat__sets/testPullConstantIntoJoin.smt2: main=sat 0.05s, branch=timeout
- lost no_aggregation_sat__sets/testPullConstantThroughUnion.smt2: main=sat 0.04s, branch=timeout
- lost no_aggregation_sat__sets/testPullConstantThroughUnion2.smt2: main=sat 0.04s, branch=timeout
- lost no_aggregation_sat__sets/testPushFilterThroughSemiJoin.smt2: main=sat 0.06s, branch=timeout
- lost no_aggregation_sat__sets/testPushJoinThroughUnionOnRight.smt2: main=sat 0.04s, branch=timeout
- lost no_aggregation_sat__sets/testPushProjectPastFilter.smt2: main=sat 0.08s, branch=timeout
- lost no_aggregation_sat__sets/testPushSemiJoinPastJoinRuleLeft.smt2: main=sat 0.14s, branch=timeout
- lost no_aggregation_sat__sets/testRemoveSemiJoin.smt2: main=sat 0.04s, branch=timeout
- lost no_aggregation_sat__sets/testRemoveSemiJoinRight.smt2: main=sat 0.05s, branch=timeout
- lost no_aggregation_sat__sets/testRemoveSemiJoinRightWithFilter.smt2: main=sat 0.06s, branch=timeout
- lost no_aggregation_sat__sets/testRemoveSemiJoinWithFilter.smt2: main=sat 0.05s, branch=timeout
- lost no_aggregation_sat__sets/testRightOuterJoinSimplificationToInner.smt2: main=sat 0.05s, branch=timeout
- lost no_aggregation_sat__sets/testSemiJoinReduceConstants.smt2: main=sat 0.06s, branch=timeout
- lost no_aggregation_sat__sets/testTransitiveInferenceComplexPredicate.smt2: main=sat 0.08s, branch=timeout
- lost no_aggregation_sat__sets/testTransitiveInferenceConjunctInPullUp.smt2: main=sat 0.06s, branch=timeout
- lost no_aggregation_sat__sets/testTransitiveInferenceFullOuterJoin.smt2: main=sat 0.12s, branch=timeout
- lost no_aggregation_sat__sets/testTransitiveInferenceJoin.smt2: main=sat 0.05s, branch=timeout
- lost no_aggregation_sat__sets/testTransitiveInferenceJoin3way.smt2: main=sat 0.26s, branch=timeout
- lost no_aggregation_sat__sets/testTransitiveInferenceLeftOuterJoin.smt2: main=sat 0.13s, branch=timeout
- lost no_aggregation_sat__sets/testTransitiveInferenceNoPullUpExprs.smt2: main=sat 0.06s, branch=timeout
- lost no_aggregation_sat__sets/testTransitiveInferencePreventProjectPullUp.smt2: main=sat 0.09s, branch=timeout
- lost no_aggregation_sat__sets/testTransitiveInferenceProject.smt2: main=sat 0.08s, branch=timeout
- lost no_aggregation_sat__sets/testTransitiveInferencePullUpThruAlias.smt2: main=sat 0.05s, branch=timeout
- lost no_aggregation_sat__sets/testTransitiveInferenceRightOuterJoin.smt2: main=sat 0.06s, branch=timeout
- lost no_aggregation_sat__sets/testTransitiveInferenceUnion.smt2: main=sat 0.08s, branch=timeout
- lost no_aggregation_sat__sets/testTransitiveInferenceUnionAlwaysTrue.smt2: main=sat 0.08s, branch=timeout
- lost no_aggregation_sat__sets/testWhereInCorrelated.smt2: main=sat 0.05s, branch=timeout
- lost spark_tests__bags/6.smt2: main=unsat 0.59s, branch=timeout
- lost spark_tests__sets/108.smt2: main=unsat 1.10s, branch=timeout
- lost spark_tests__sets/50.smt2: main=unsat 0.11s, branch=timeout
- lost spark_tests__sets/56.smt2: main=unsat 0.84s, branch=timeout
- lost spark_tests__sets/70.smt2: main=unsat 0.17s, branch=timeout
- lost spark_tests__sets/86.smt2: main=unsat 0.07s, branch=timeout

### branch+liastar vs branch: +1 / -90
- gained spark_tests__bags/102.smt2: branch=timeout unsat in 0.59s
- lost calcite_tests__bags/testMergeIntersect.smt2: branch=unsat 0.08s, branch+liastar=timeout
- lost calcite_tests__bags/testMergeMinus.smt2: branch=unsat 0.09s, branch+liastar=timeout
- lost calcite_tests__bags/testMergeMinusRightDeep.smt2: branch=unsat 0.06s, branch+liastar=timeout
- lost calcite_tests__bags/testMergeSetOpMixed.smt2: branch=unsat 0.07s, branch+liastar=timeout
- lost calcite_tests__bags/testMergeUnionAll.smt2: branch=unsat 0.10s, branch+liastar=timeout
- lost calcite_tests__bags/testMergeUnionDistinct.smt2: branch=unsat 0.08s, branch+liastar=timeout
- lost calcite_tests__bags/testMergeUnionMixed.smt2: branch=unsat 0.08s, branch+liastar=timeout
- lost calcite_tests__bags/testMergeUnionMixed2.smt2: branch=unsat 0.09s, branch+liastar=timeout
- lost calcite_tests__bags/testPushFilterThroughSemiJoin.smt2: branch=unsat 0.12s, branch+liastar=timeout
- lost no_aggregation__bags/testMergeIntersect.smt2: branch=unsat 0.09s, branch+liastar=timeout
- lost no_aggregation__bags/testMergeMinus.smt2: branch=unsat 0.10s, branch+liastar=timeout
- lost no_aggregation__bags/testMergeMinusRightDeep.smt2: branch=unsat 0.07s, branch+liastar=timeout
- lost no_aggregation__bags/testMergeSetOpMixed.smt2: branch=unsat 0.08s, branch+liastar=timeout
- lost no_aggregation__bags/testMergeUnionAll.smt2: branch=unsat 0.11s, branch+liastar=timeout
- lost no_aggregation__bags/testMergeUnionDistinct.smt2: branch=unsat 0.08s, branch+liastar=timeout
- lost no_aggregation__bags/testMergeUnionMixed.smt2: branch=unsat 0.09s, branch+liastar=timeout
- lost no_aggregation__bags/testMergeUnionMixed2.smt2: branch=unsat 0.10s, branch+liastar=timeout
- lost no_aggregation__bags/testPullNull.smt2: branch=sat 0.13s, branch+liastar=unknown
- lost no_aggregation__bags/testPushFilterThroughSemiJoin.smt2: branch=unsat 0.12s, branch+liastar=timeout
- lost no_aggregation_no_null__bags/testMergeIntersect.smt2: branch=unsat 0.08s, branch+liastar=timeout
- lost no_aggregation_no_null__bags/testMergeMinus.smt2: branch=unsat 0.10s, branch+liastar=timeout
- lost no_aggregation_no_null__bags/testMergeMinusRightDeep.smt2: branch=unsat 0.06s, branch+liastar=timeout
- lost no_aggregation_no_null__bags/testMergeSetOpMixed.smt2: branch=unsat 0.07s, branch+liastar=timeout
- lost no_aggregation_no_null__bags/testMergeUnionAll.smt2: branch=unsat 0.10s, branch+liastar=timeout
- lost no_aggregation_no_null__bags/testMergeUnionDistinct.smt2: branch=unsat 0.08s, branch+liastar=timeout
- lost no_aggregation_no_null__bags/testMergeUnionMixed.smt2: branch=unsat 0.08s, branch+liastar=timeout
- lost no_aggregation_no_null__bags/testMergeUnionMixed2.smt2: branch=unsat 0.09s, branch+liastar=timeout
- lost no_aggregation_no_null__bags/testPushFilterThroughSemiJoin.smt2: branch=unsat 0.11s, branch+liastar=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeIntersect.smt2: branch=unsat 0.08s, branch+liastar=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeMinus.smt2: branch=unsat 0.09s, branch+liastar=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeMinusRightDeep.smt2: branch=unsat 0.06s, branch+liastar=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeSetOpMixed.smt2: branch=unsat 0.07s, branch+liastar=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeUnionAll.smt2: branch=unsat 0.11s, branch+liastar=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeUnionDistinct.smt2: branch=unsat 0.08s, branch+liastar=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeUnionMixed.smt2: branch=unsat 0.08s, branch+liastar=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeUnionMixed2.smt2: branch=unsat 0.09s, branch+liastar=timeout
- lost no_aggregation_no_null_no_cast__bags/testPushFilterThroughSemiJoin.smt2: branch=unsat 0.11s, branch+liastar=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeIntersect.smt2: branch=unsat 0.09s, branch+liastar=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeMinus.smt2: branch=unsat 0.09s, branch+liastar=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeMinusRightDeep.smt2: branch=unsat 0.06s, branch+liastar=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeSetOpMixed.smt2: branch=unsat 0.08s, branch+liastar=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeUnionAll.smt2: branch=unsat 0.11s, branch+liastar=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeUnionDistinct.smt2: branch=unsat 0.08s, branch+liastar=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeUnionMixed.smt2: branch=unsat 0.08s, branch+liastar=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeUnionMixed2.smt2: branch=unsat 0.09s, branch+liastar=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testPushFilterThroughSemiJoin.smt2: branch=unsat 0.11s, branch+liastar=timeout
- lost no_aggregation_sat__bags/testEmptyJoin.smt2: branch=sat 0.15s, branch+liastar=timeout
- lost no_aggregation_sat__bags/testExtractJoinFilterRule.smt2: branch=sat 0.31s, branch+liastar=timeout
- lost no_aggregation_sat__bags/testLeftOuterJoinSimplificationToInner.smt2: branch=sat 4.81s, branch+liastar=timeout
- lost no_aggregation_sat__bags/testMergeFilter.smt2: branch=sat 0.08s, branch+liastar=unknown
- lost no_aggregation_sat__bags/testMergeJoinFilter.smt2: branch=sat 6.89s, branch+liastar=timeout
- lost no_aggregation_sat__bags/testMergeUnionAll.smt2: branch=sat 0.66s, branch+liastar=timeout
- lost no_aggregation_sat__bags/testPullConstantIntoFilter.smt2: branch=sat 0.18s, branch+liastar=unknown
- lost no_aggregation_sat__bags/testPullConstantIntoProject.smt2: branch=sat 0.11s, branch+liastar=unknown
- lost no_aggregation_sat__bags/testPullConstantThroughUnion.smt2: branch=sat 0.10s, branch+liastar=unknown
- lost no_aggregation_sat__bags/testPullConstantThroughUnion2.smt2: branch=sat 0.07s, branch+liastar=unknown
- lost no_aggregation_sat__bags/testPullConstantThroughUnion3.smt2: branch=sat 0.08s, branch+liastar=unknown
- lost no_aggregation_sat__bags/testPushFilterThroughSemiJoin.smt2: branch=sat 0.34s, branch+liastar=timeout
- lost no_aggregation_sat__bags/testPushJoinCondDownToProject.smt2: branch=sat 6.73s, branch+liastar=timeout
- lost no_aggregation_sat__bags/testPushProjectPastFilter.smt2: branch=sat 0.15s, branch+liastar=unknown
- lost no_aggregation_sat__bags/testPushProjectPastFilter2*.smt2: branch=sat 0.12s, branch+liastar=unknown
- lost no_aggregation_sat__bags/testPushProjectPastSetOp.smt2: branch=sat 0.09s, branch+liastar=timeout
- lost no_aggregation_sat__bags/testReduceConstants.smt2: branch=sat 0.54s, branch+liastar=unknown
- lost no_aggregation_sat__bags/testReduceConstantsDup.smt2: branch=sat 0.05s, branch+liastar=unknown
- lost no_aggregation_sat__bags/testReduceConstantsDup2.smt2: branch=sat 0.07s, branch+liastar=unknown
- lost no_aggregation_sat__bags/testReduceConstantsIsNotNull.smt2: branch=sat 0.22s, branch+liastar=unknown
- lost no_aggregation_sat__bags/testReduceConstantsNegated.smt2: branch=sat 0.06s, branch+liastar=unknown
- lost no_aggregation_sat__bags/testReduceConstantsNegatedInverted.smt2: branch=sat 0.06s, branch+liastar=unknown
- lost no_aggregation_sat__bags/testReduceConstantsNull.smt2: branch=sat 0.07s, branch+liastar=unknown
- lost no_aggregation_sat__bags/testReduceConstantsProjectNullable*.smt2: branch=sat 0.10s, branch+liastar=unknown
- lost no_aggregation_sat__bags/testReduceNestedCaseWhen.smt2: branch=sat 0.16s, branch+liastar=unknown
- lost no_aggregation_sat__bags/testReduceNot.smt2: branch=sat 0.07s, branch+liastar=unknown
- lost no_aggregation_sat__bags/testReduceOrCaseWhen.smt2: branch=sat 0.11s, branch+liastar=unknown
- lost no_aggregation_sat__bags/testRemoveSemiJoin.smt2: branch=sat 0.72s, branch+liastar=timeout
- lost no_aggregation_sat__bags/testRemoveSemiJoinRight.smt2: branch=sat 2.07s, branch+liastar=timeout
- lost no_aggregation_sat__bags/testRemoveSemiJoinRightWithFilter.smt2: branch=sat 3.50s, branch+liastar=timeout
- lost no_aggregation_sat__bags/testRemoveSemiJoinWithFilter.smt2: branch=sat 2.19s, branch+liastar=timeout
- lost no_aggregation_sat__bags/testRightOuterJoinSimplificationToInner.smt2: branch=sat 3.17s, branch+liastar=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceComplexPredicate.smt2: branch=sat 1.75s, branch+liastar=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceConjunctInPullUp.smt2: branch=sat 3.47s, branch+liastar=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceConstantEquiPredicate.smt2: branch=sat 0.33s, branch+liastar=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceJoin.smt2: branch=sat 1.47s, branch+liastar=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceNoPullUpExprs.smt2: branch=sat 3.13s, branch+liastar=timeout
- lost no_aggregation_sat__bags/testTransitiveInferencePreventProjectPullUp.smt2: branch=sat 2.79s, branch+liastar=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceProject.smt2: branch=sat 2.26s, branch+liastar=timeout
- lost no_aggregation_sat__bags/testTransitiveInferencePullUpThruAlias.smt2: branch=sat 8.25s, branch+liastar=timeout
- lost spark_tests__bags/105.smt2: branch=unsat 0.25s, branch+liastar=timeout
- lost spark_tests__bags/14.smt2: branch=sat 0.12s, branch+liastar=unknown
- lost spark_tests__bags/39.smt2: branch=sat 0.09s, branch+liastar=timeout
- lost spark_tests__bags/48.smt2: branch=unsat 0.40s, branch+liastar=timeout

### branch+liastar+elements vs branch: +1 / -68
- gained spark_tests__bags/102.smt2: branch=timeout unsat in 0.62s
- lost calcite_tests__bags/testMergeIntersect.smt2: branch=unsat 0.08s, branch+liastar+elements=timeout
- lost calcite_tests__bags/testMergeMinus.smt2: branch=unsat 0.09s, branch+liastar+elements=timeout
- lost calcite_tests__bags/testMergeMinusRightDeep.smt2: branch=unsat 0.06s, branch+liastar+elements=timeout
- lost calcite_tests__bags/testMergeSetOpMixed.smt2: branch=unsat 0.07s, branch+liastar+elements=timeout
- lost calcite_tests__bags/testMergeUnionAll.smt2: branch=unsat 0.10s, branch+liastar+elements=timeout
- lost calcite_tests__bags/testMergeUnionDistinct.smt2: branch=unsat 0.08s, branch+liastar+elements=timeout
- lost calcite_tests__bags/testMergeUnionMixed.smt2: branch=unsat 0.08s, branch+liastar+elements=timeout
- lost calcite_tests__bags/testMergeUnionMixed2.smt2: branch=unsat 0.09s, branch+liastar+elements=timeout
- lost no_aggregation__bags/testMergeIntersect.smt2: branch=unsat 0.09s, branch+liastar+elements=timeout
- lost no_aggregation__bags/testMergeMinus.smt2: branch=unsat 0.10s, branch+liastar+elements=timeout
- lost no_aggregation__bags/testMergeMinusRightDeep.smt2: branch=unsat 0.07s, branch+liastar+elements=timeout
- lost no_aggregation__bags/testMergeSetOpMixed.smt2: branch=unsat 0.08s, branch+liastar+elements=timeout
- lost no_aggregation__bags/testMergeUnionAll.smt2: branch=unsat 0.11s, branch+liastar+elements=timeout
- lost no_aggregation__bags/testMergeUnionDistinct.smt2: branch=unsat 0.08s, branch+liastar+elements=timeout
- lost no_aggregation__bags/testMergeUnionMixed.smt2: branch=unsat 0.09s, branch+liastar+elements=timeout
- lost no_aggregation__bags/testMergeUnionMixed2.smt2: branch=unsat 0.10s, branch+liastar+elements=timeout
- lost no_aggregation__bags/testPushFilterThroughSemiJoin.smt2: branch=unsat 0.12s, branch+liastar+elements=timeout
- lost no_aggregation_no_null__bags/testMergeIntersect.smt2: branch=unsat 0.08s, branch+liastar+elements=timeout
- lost no_aggregation_no_null__bags/testMergeMinus.smt2: branch=unsat 0.10s, branch+liastar+elements=timeout
- lost no_aggregation_no_null__bags/testMergeMinusRightDeep.smt2: branch=unsat 0.06s, branch+liastar+elements=timeout
- lost no_aggregation_no_null__bags/testMergeSetOpMixed.smt2: branch=unsat 0.07s, branch+liastar+elements=timeout
- lost no_aggregation_no_null__bags/testMergeUnionAll.smt2: branch=unsat 0.10s, branch+liastar+elements=timeout
- lost no_aggregation_no_null__bags/testMergeUnionDistinct.smt2: branch=unsat 0.08s, branch+liastar+elements=timeout
- lost no_aggregation_no_null__bags/testMergeUnionMixed.smt2: branch=unsat 0.08s, branch+liastar+elements=timeout
- lost no_aggregation_no_null__bags/testMergeUnionMixed2.smt2: branch=unsat 0.09s, branch+liastar+elements=timeout
- lost no_aggregation_no_null__bags/testPushFilterThroughSemiJoin.smt2: branch=unsat 0.11s, branch+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeIntersect.smt2: branch=unsat 0.08s, branch+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeMinus.smt2: branch=unsat 0.09s, branch+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeMinusRightDeep.smt2: branch=unsat 0.06s, branch+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeSetOpMixed.smt2: branch=unsat 0.07s, branch+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeUnionAll.smt2: branch=unsat 0.11s, branch+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeUnionDistinct.smt2: branch=unsat 0.08s, branch+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeUnionMixed.smt2: branch=unsat 0.08s, branch+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeUnionMixed2.smt2: branch=unsat 0.09s, branch+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast__bags/testPushFilterThroughSemiJoin.smt2: branch=unsat 0.11s, branch+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeIntersect.smt2: branch=unsat 0.09s, branch+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeMinus.smt2: branch=unsat 0.09s, branch+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeMinusRightDeep.smt2: branch=unsat 0.06s, branch+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeSetOpMixed.smt2: branch=unsat 0.08s, branch+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeUnionAll.smt2: branch=unsat 0.11s, branch+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeUnionDistinct.smt2: branch=unsat 0.08s, branch+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeUnionMixed.smt2: branch=unsat 0.08s, branch+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeUnionMixed2.smt2: branch=unsat 0.09s, branch+liastar+elements=timeout
- lost no_aggregation_sat__bags/testEmptyJoin.smt2: branch=sat 0.15s, branch+liastar+elements=timeout
- lost no_aggregation_sat__bags/testExtractJoinFilterRule.smt2: branch=sat 0.31s, branch+liastar+elements=timeout
- lost no_aggregation_sat__bags/testLeftOuterJoinSimplificationToInner.smt2: branch=sat 4.81s, branch+liastar+elements=timeout
- lost no_aggregation_sat__bags/testMergeJoinFilter.smt2: branch=sat 6.89s, branch+liastar+elements=timeout
- lost no_aggregation_sat__bags/testMergeUnionAll.smt2: branch=sat 0.66s, branch+liastar+elements=timeout
- lost no_aggregation_sat__bags/testPushFilterThroughSemiJoin.smt2: branch=sat 0.34s, branch+liastar+elements=timeout
- lost no_aggregation_sat__bags/testPushJoinCondDownToProject.smt2: branch=sat 6.73s, branch+liastar+elements=timeout
- lost no_aggregation_sat__bags/testReduceConstants.smt2: branch=sat 0.54s, branch+liastar+elements=timeout
- lost no_aggregation_sat__bags/testRemoveSemiJoin.smt2: branch=sat 0.72s, branch+liastar+elements=timeout
- lost no_aggregation_sat__bags/testRemoveSemiJoinRight.smt2: branch=sat 2.07s, branch+liastar+elements=timeout
- lost no_aggregation_sat__bags/testRemoveSemiJoinRightWithFilter.smt2: branch=sat 3.50s, branch+liastar+elements=timeout
- lost no_aggregation_sat__bags/testRemoveSemiJoinWithFilter.smt2: branch=sat 2.19s, branch+liastar+elements=timeout
- lost no_aggregation_sat__bags/testRightOuterJoinSimplificationToInner.smt2: branch=sat 3.17s, branch+liastar+elements=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceComplexPredicate.smt2: branch=sat 1.75s, branch+liastar+elements=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceConjunctInPullUp.smt2: branch=sat 3.47s, branch+liastar+elements=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceConstantEquiPredicate.smt2: branch=sat 0.33s, branch+liastar+elements=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceJoin.smt2: branch=sat 1.47s, branch+liastar+elements=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceNoPullUpExprs.smt2: branch=sat 3.13s, branch+liastar+elements=timeout
- lost no_aggregation_sat__bags/testTransitiveInferencePreventProjectPullUp.smt2: branch=sat 2.79s, branch+liastar+elements=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceProject.smt2: branch=sat 2.26s, branch+liastar+elements=timeout
- lost no_aggregation_sat__bags/testTransitiveInferencePullUpThruAlias.smt2: branch=sat 8.25s, branch+liastar+elements=timeout
- lost spark_tests__bags/104.smt2: branch=unsat 0.14s, branch+liastar+elements=timeout
- lost spark_tests__bags/105.smt2: branch=unsat 0.25s, branch+liastar+elements=timeout
- lost spark_tests__bags/39.smt2: branch=sat 0.09s, branch+liastar+elements=timeout
- lost spark_tests__bags/48.smt2: branch=unsat 0.40s, branch+liastar+elements=timeout

### branch+liastar+elements vs branch+liastar: +23 / -1
- gained calcite_tests__bags/testPushFilterThroughSemiJoin.smt2: branch+liastar=timeout unsat in 9.88s
- gained no_aggregation__bags/testPullNull.smt2: branch+liastar=unknown sat in 0.68s
- gained no_aggregation_no_null_no_cast_no_outer_join__bags/testPushFilterThroughSemiJoin.smt2: branch+liastar=timeout unsat in 9.69s
- gained no_aggregation_sat__bags/testMergeFilter.smt2: branch+liastar=unknown sat in 2.72s
- gained no_aggregation_sat__bags/testPullConstantIntoFilter.smt2: branch+liastar=unknown sat in 0.49s
- gained no_aggregation_sat__bags/testPullConstantIntoProject.smt2: branch+liastar=unknown sat in 2.98s
- gained no_aggregation_sat__bags/testPullConstantThroughUnion.smt2: branch+liastar=unknown sat in 3.80s
- gained no_aggregation_sat__bags/testPullConstantThroughUnion2.smt2: branch+liastar=unknown sat in 0.51s
- gained no_aggregation_sat__bags/testPullConstantThroughUnion3.smt2: branch+liastar=unknown sat in 2.48s
- gained no_aggregation_sat__bags/testPushProjectPastFilter.smt2: branch+liastar=unknown sat in 7.02s
- gained no_aggregation_sat__bags/testPushProjectPastFilter2*.smt2: branch+liastar=unknown sat in 1.45s
- gained no_aggregation_sat__bags/testPushProjectPastSetOp.smt2: branch+liastar=timeout sat in 1.57s
- gained no_aggregation_sat__bags/testReduceConstantsDup.smt2: branch+liastar=unknown sat in 0.26s
- gained no_aggregation_sat__bags/testReduceConstantsDup2.smt2: branch+liastar=unknown sat in 0.32s
- gained no_aggregation_sat__bags/testReduceConstantsIsNotNull.smt2: branch+liastar=unknown sat in 3.91s
- gained no_aggregation_sat__bags/testReduceConstantsNegated.smt2: branch+liastar=unknown sat in 0.27s
- gained no_aggregation_sat__bags/testReduceConstantsNegatedInverted.smt2: branch+liastar=unknown sat in 0.27s
- gained no_aggregation_sat__bags/testReduceConstantsNull.smt2: branch+liastar=unknown sat in 1.35s
- gained no_aggregation_sat__bags/testReduceConstantsProjectNullable*.smt2: branch+liastar=unknown sat in 2.73s
- gained no_aggregation_sat__bags/testReduceNestedCaseWhen.smt2: branch+liastar=unknown sat in 2.12s
- gained no_aggregation_sat__bags/testReduceNot.smt2: branch+liastar=unknown sat in 1.11s
- gained no_aggregation_sat__bags/testReduceOrCaseWhen.smt2: branch+liastar=unknown sat in 2.12s
- gained spark_tests__bags/14.smt2: branch+liastar=unknown sat in 0.82s
- lost spark_tests__bags/104.smt2: branch+liastar=unsat 6.50s, branch+liastar+elements=timeout

### branch+liastar+dio vs branch+liastar: +0 / -1
- lost spark_tests__bags/81.smt2: branch+liastar=unsat 1.81s, branch+liastar+dio=timeout

### branch+liastar(gated) vs branch: +1 / -1
- gained no_aggregation_sat__bags/testTransitiveInferenceUnionAlwaysTrue.smt2: branch=timeout sat in 9.98s
- lost spark_tests__bags/39.smt2: branch=sat 0.09s, branch+liastar(gated)=unknown

### merged vs main: +0 / -1
- lost no_aggregation_sat__bags/testTransitiveInferencePullUpThruAlias.smt2: main=sat 10.01s, merged=timeout

### merged+liastar vs merged: +1 / -97
- gained spark_tests__bags/102.smt2: merged=timeout unsat in 0.57s
- lost calcite_tests__bags/testMergeIntersect.smt2: merged=unsat 0.07s, merged+liastar=timeout
- lost calcite_tests__bags/testMergeMinus.smt2: merged=unsat 0.07s, merged+liastar=timeout
- lost calcite_tests__bags/testMergeMinusRightDeep.smt2: merged=unsat 0.06s, merged+liastar=timeout
- lost calcite_tests__bags/testMergeSetOpMixed.smt2: merged=unsat 0.06s, merged+liastar=timeout
- lost calcite_tests__bags/testMergeUnionAll.smt2: merged=unsat 0.07s, merged+liastar=timeout
- lost calcite_tests__bags/testMergeUnionDistinct.smt2: merged=unsat 0.07s, merged+liastar=timeout
- lost calcite_tests__bags/testMergeUnionMixed.smt2: merged=unsat 0.07s, merged+liastar=timeout
- lost calcite_tests__bags/testMergeUnionMixed2.smt2: merged=unsat 0.07s, merged+liastar=timeout
- lost no_aggregation__bags/testMergeIntersect.smt2: merged=unsat 0.09s, merged+liastar=timeout
- lost no_aggregation__bags/testMergeMinus.smt2: merged=unsat 0.09s, merged+liastar=timeout
- lost no_aggregation__bags/testMergeMinusRightDeep.smt2: merged=unsat 0.07s, merged+liastar=timeout
- lost no_aggregation__bags/testMergeSetOpMixed.smt2: merged=unsat 0.07s, merged+liastar=timeout
- lost no_aggregation__bags/testMergeUnionAll.smt2: merged=unsat 0.07s, merged+liastar=timeout
- lost no_aggregation__bags/testMergeUnionDistinct.smt2: merged=unsat 0.08s, merged+liastar=timeout
- lost no_aggregation__bags/testMergeUnionMixed.smt2: merged=unsat 0.08s, merged+liastar=timeout
- lost no_aggregation__bags/testMergeUnionMixed2.smt2: merged=unsat 0.08s, merged+liastar=timeout
- lost no_aggregation__bags/testPullNull.smt2: merged=sat 0.13s, merged+liastar=unknown
- lost no_aggregation_no_null__bags/testMergeIntersect.smt2: merged=unsat 0.09s, merged+liastar=timeout
- lost no_aggregation_no_null__bags/testMergeMinus.smt2: merged=unsat 0.09s, merged+liastar=timeout
- lost no_aggregation_no_null__bags/testMergeMinusRightDeep.smt2: merged=unsat 0.07s, merged+liastar=timeout
- lost no_aggregation_no_null__bags/testMergeSetOpMixed.smt2: merged=unsat 0.07s, merged+liastar=timeout
- lost no_aggregation_no_null__bags/testMergeUnionAll.smt2: merged=unsat 0.08s, merged+liastar=timeout
- lost no_aggregation_no_null__bags/testMergeUnionDistinct.smt2: merged=unsat 0.08s, merged+liastar=timeout
- lost no_aggregation_no_null__bags/testMergeUnionMixed.smt2: merged=unsat 0.08s, merged+liastar=timeout
- lost no_aggregation_no_null__bags/testMergeUnionMixed2.smt2: merged=unsat 0.09s, merged+liastar=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeIntersect.smt2: merged=unsat 0.09s, merged+liastar=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeMinus.smt2: merged=unsat 0.09s, merged+liastar=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeMinusRightDeep.smt2: merged=unsat 0.07s, merged+liastar=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeSetOpMixed.smt2: merged=unsat 0.08s, merged+liastar=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeUnionAll.smt2: merged=unsat 0.08s, merged+liastar=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeUnionDistinct.smt2: merged=unsat 0.08s, merged+liastar=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeUnionMixed.smt2: merged=unsat 0.08s, merged+liastar=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeUnionMixed2.smt2: merged=unsat 0.09s, merged+liastar=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeIntersect.smt2: merged=unsat 0.09s, merged+liastar=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeMinus.smt2: merged=unsat 0.09s, merged+liastar=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeMinusRightDeep.smt2: merged=unsat 0.07s, merged+liastar=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeSetOpMixed.smt2: merged=unsat 0.07s, merged+liastar=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeUnionAll.smt2: merged=unsat 0.08s, merged+liastar=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeUnionDistinct.smt2: merged=unsat 0.08s, merged+liastar=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeUnionMixed.smt2: merged=unsat 0.08s, merged+liastar=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeUnionMixed2.smt2: merged=unsat 0.08s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testDecorrelateTwoIn.smt2: merged=sat 7.08s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testEmptyJoin.smt2: merged=sat 0.17s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testExtractJoinFilterRule.smt2: merged=sat 0.37s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testLeftOuterJoinSimplificationToInner.smt2: merged=sat 3.26s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testMergeFilter.smt2: merged=sat 0.09s, merged+liastar=unknown
- lost no_aggregation_sat__bags/testMergeIntersect.smt2: merged=sat 0.38s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testMergeJoinFilter.smt2: merged=sat 6.27s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testMergeMinus.smt2: merged=sat 0.46s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testMergeMinusRightDeep.smt2: merged=sat 0.38s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testMergeSetOpMixed.smt2: merged=sat 0.66s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testMergeUnionAll.smt2: merged=sat 0.40s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testMergeUnionDistinct.smt2: merged=sat 0.65s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testMergeUnionMixed.smt2: merged=sat 0.35s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testMergeUnionMixed2.smt2: merged=sat 0.29s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testPullConstantIntoFilter.smt2: merged=sat 0.10s, merged+liastar=unknown
- lost no_aggregation_sat__bags/testPullConstantIntoProject.smt2: merged=sat 0.12s, merged+liastar=unknown
- lost no_aggregation_sat__bags/testPullConstantThroughUnion.smt2: merged=sat 0.11s, merged+liastar=unknown
- lost no_aggregation_sat__bags/testPullConstantThroughUnion2.smt2: merged=sat 0.07s, merged+liastar=unknown
- lost no_aggregation_sat__bags/testPullConstantThroughUnion3.smt2: merged=sat 0.09s, merged+liastar=unknown
- lost no_aggregation_sat__bags/testPushFilterThroughSemiJoin.smt2: merged=sat 0.37s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testPushJoinThroughUnionOnLeft.smt2: merged=sat 3.71s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testPushJoinThroughUnionOnRight.smt2: merged=sat 9.19s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testPushProjectPastFilter.smt2: merged=sat 0.17s, merged+liastar=unknown
- lost no_aggregation_sat__bags/testPushProjectPastFilter2*.smt2: merged=sat 0.13s, merged+liastar=unknown
- lost no_aggregation_sat__bags/testPushProjectPastSetOp.smt2: merged=sat 0.16s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testReduceConstants.smt2: merged=sat 0.62s, merged+liastar=unknown
- lost no_aggregation_sat__bags/testReduceConstantsDup.smt2: merged=sat 0.06s, merged+liastar=unknown
- lost no_aggregation_sat__bags/testReduceConstantsDup2.smt2: merged=sat 0.08s, merged+liastar=unknown
- lost no_aggregation_sat__bags/testReduceConstantsIsNotNull.smt2: merged=sat 0.25s, merged+liastar=unknown
- lost no_aggregation_sat__bags/testReduceConstantsNegated.smt2: merged=sat 0.06s, merged+liastar=unknown
- lost no_aggregation_sat__bags/testReduceConstantsNegatedInverted.smt2: merged=sat 0.06s, merged+liastar=unknown
- lost no_aggregation_sat__bags/testReduceConstantsNull.smt2: merged=sat 0.06s, merged+liastar=unknown
- lost no_aggregation_sat__bags/testReduceConstantsProjectNullable*.smt2: merged=sat 0.11s, merged+liastar=unknown
- lost no_aggregation_sat__bags/testReduceNestedCaseWhen.smt2: merged=sat 0.18s, merged+liastar=unknown
- lost no_aggregation_sat__bags/testReduceNot.smt2: merged=sat 0.08s, merged+liastar=unknown
- lost no_aggregation_sat__bags/testReduceOrCaseWhen.smt2: merged=sat 0.14s, merged+liastar=unknown
- lost no_aggregation_sat__bags/testRemoveSemiJoin.smt2: merged=sat 0.85s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testRemoveSemiJoinRight.smt2: merged=sat 2.42s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testRemoveSemiJoinRightWithFilter.smt2: merged=sat 5.37s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testRemoveSemiJoinWithFilter.smt2: merged=sat 2.06s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testRightOuterJoinSimplificationToInner.smt2: merged=sat 1.69s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceComplexPredicate.smt2: merged=sat 1.65s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceConjunctInPullUp.smt2: merged=sat 1.31s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceConstantEquiPredicate.smt2: merged=sat 0.39s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceJoin.smt2: merged=sat 0.68s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceJoin3way.smt2: merged=sat 7.52s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceNoPullUpExprs.smt2: merged=sat 1.26s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testTransitiveInferencePreventProjectPullUp.smt2: merged=sat 3.24s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceProject.smt2: merged=sat 1.09s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceUnion.smt2: merged=sat 4.62s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceUnionAlwaysTrue.smt2: merged=sat 9.07s, merged+liastar=timeout
- lost no_aggregation_sat__bags/testWhereInCorrelated.smt2: merged=sat 2.26s, merged+liastar=timeout
- lost spark_tests__bags/14.smt2: merged=sat 0.10s, merged+liastar=unknown
- lost spark_tests__bags/39.smt2: merged=sat 0.10s, merged+liastar=timeout
- lost spark_tests__bags/48.smt2: merged=unsat 0.48s, merged+liastar=timeout
- lost spark_tests__bags/6.smt2: merged=unsat 0.71s, merged+liastar=timeout

### merged+liastar(gated) vs merged: +0 / -1
- lost spark_tests__bags/39.smt2: merged=sat 0.10s, merged+liastar(gated)=unknown

### merged+liastar+elements vs merged: +2 / -76
- gained no_aggregation__bags/testEmptyJoinLeft.smt2: merged=timeout unsat in 4.48s
- gained spark_tests__bags/102.smt2: merged=timeout unsat in 0.59s
- lost calcite_tests__bags/testMergeIntersect.smt2: merged=unsat 0.07s, merged+liastar+elements=timeout
- lost calcite_tests__bags/testMergeMinus.smt2: merged=unsat 0.07s, merged+liastar+elements=timeout
- lost calcite_tests__bags/testMergeMinusRightDeep.smt2: merged=unsat 0.06s, merged+liastar+elements=timeout
- lost calcite_tests__bags/testMergeSetOpMixed.smt2: merged=unsat 0.06s, merged+liastar+elements=timeout
- lost calcite_tests__bags/testMergeUnionAll.smt2: merged=unsat 0.07s, merged+liastar+elements=timeout
- lost calcite_tests__bags/testMergeUnionDistinct.smt2: merged=unsat 0.07s, merged+liastar+elements=timeout
- lost calcite_tests__bags/testMergeUnionMixed.smt2: merged=unsat 0.07s, merged+liastar+elements=timeout
- lost calcite_tests__bags/testMergeUnionMixed2.smt2: merged=unsat 0.07s, merged+liastar+elements=timeout
- lost no_aggregation__bags/testMergeIntersect.smt2: merged=unsat 0.09s, merged+liastar+elements=timeout
- lost no_aggregation__bags/testMergeMinus.smt2: merged=unsat 0.09s, merged+liastar+elements=timeout
- lost no_aggregation__bags/testMergeMinusRightDeep.smt2: merged=unsat 0.07s, merged+liastar+elements=timeout
- lost no_aggregation__bags/testMergeSetOpMixed.smt2: merged=unsat 0.07s, merged+liastar+elements=timeout
- lost no_aggregation__bags/testMergeUnionAll.smt2: merged=unsat 0.07s, merged+liastar+elements=timeout
- lost no_aggregation__bags/testMergeUnionDistinct.smt2: merged=unsat 0.08s, merged+liastar+elements=timeout
- lost no_aggregation__bags/testMergeUnionMixed.smt2: merged=unsat 0.08s, merged+liastar+elements=timeout
- lost no_aggregation__bags/testMergeUnionMixed2.smt2: merged=unsat 0.08s, merged+liastar+elements=timeout
- lost no_aggregation_no_null__bags/testMergeIntersect.smt2: merged=unsat 0.09s, merged+liastar+elements=timeout
- lost no_aggregation_no_null__bags/testMergeMinus.smt2: merged=unsat 0.09s, merged+liastar+elements=timeout
- lost no_aggregation_no_null__bags/testMergeMinusRightDeep.smt2: merged=unsat 0.07s, merged+liastar+elements=timeout
- lost no_aggregation_no_null__bags/testMergeSetOpMixed.smt2: merged=unsat 0.07s, merged+liastar+elements=timeout
- lost no_aggregation_no_null__bags/testMergeUnionAll.smt2: merged=unsat 0.08s, merged+liastar+elements=timeout
- lost no_aggregation_no_null__bags/testMergeUnionDistinct.smt2: merged=unsat 0.08s, merged+liastar+elements=timeout
- lost no_aggregation_no_null__bags/testMergeUnionMixed.smt2: merged=unsat 0.08s, merged+liastar+elements=timeout
- lost no_aggregation_no_null__bags/testMergeUnionMixed2.smt2: merged=unsat 0.09s, merged+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeIntersect.smt2: merged=unsat 0.09s, merged+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeMinus.smt2: merged=unsat 0.09s, merged+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeMinusRightDeep.smt2: merged=unsat 0.07s, merged+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeSetOpMixed.smt2: merged=unsat 0.08s, merged+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeUnionAll.smt2: merged=unsat 0.08s, merged+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeUnionDistinct.smt2: merged=unsat 0.08s, merged+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeUnionMixed.smt2: merged=unsat 0.08s, merged+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast__bags/testMergeUnionMixed2.smt2: merged=unsat 0.09s, merged+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeIntersect.smt2: merged=unsat 0.09s, merged+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeMinus.smt2: merged=unsat 0.09s, merged+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeMinusRightDeep.smt2: merged=unsat 0.07s, merged+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeSetOpMixed.smt2: merged=unsat 0.07s, merged+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeUnionAll.smt2: merged=unsat 0.08s, merged+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeUnionDistinct.smt2: merged=unsat 0.08s, merged+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeUnionMixed.smt2: merged=unsat 0.08s, merged+liastar+elements=timeout
- lost no_aggregation_no_null_no_cast_no_outer_join__bags/testMergeUnionMixed2.smt2: merged=unsat 0.08s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testDecorrelateTwoIn.smt2: merged=sat 7.08s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testEmptyJoin.smt2: merged=sat 0.17s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testExtractJoinFilterRule.smt2: merged=sat 0.37s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testLeftOuterJoinSimplificationToInner.smt2: merged=sat 3.26s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testMergeIntersect.smt2: merged=sat 0.38s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testMergeJoinFilter.smt2: merged=sat 6.27s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testMergeMinus.smt2: merged=sat 0.46s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testMergeMinusRightDeep.smt2: merged=sat 0.38s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testMergeSetOpMixed.smt2: merged=sat 0.66s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testMergeUnionAll.smt2: merged=sat 0.40s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testMergeUnionDistinct.smt2: merged=sat 0.65s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testMergeUnionMixed.smt2: merged=sat 0.35s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testMergeUnionMixed2.smt2: merged=sat 0.29s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testPushFilterThroughSemiJoin.smt2: merged=sat 0.37s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testPushJoinThroughUnionOnLeft.smt2: merged=sat 3.71s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testPushJoinThroughUnionOnRight.smt2: merged=sat 9.19s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testReduceConstants.smt2: merged=sat 0.62s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testRemoveSemiJoin.smt2: merged=sat 0.85s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testRemoveSemiJoinRight.smt2: merged=sat 2.42s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testRemoveSemiJoinRightWithFilter.smt2: merged=sat 5.37s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testRemoveSemiJoinWithFilter.smt2: merged=sat 2.06s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testRightOuterJoinSimplificationToInner.smt2: merged=sat 1.69s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceComplexPredicate.smt2: merged=sat 1.65s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceConjunctInPullUp.smt2: merged=sat 1.31s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceConstantEquiPredicate.smt2: merged=sat 0.39s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceJoin.smt2: merged=sat 0.68s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceJoin3way.smt2: merged=sat 7.52s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceNoPullUpExprs.smt2: merged=sat 1.26s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testTransitiveInferencePreventProjectPullUp.smt2: merged=sat 3.24s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceProject.smt2: merged=sat 1.09s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceUnion.smt2: merged=sat 4.62s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testTransitiveInferenceUnionAlwaysTrue.smt2: merged=sat 9.07s, merged+liastar+elements=timeout
- lost no_aggregation_sat__bags/testWhereInCorrelated.smt2: merged=sat 2.26s, merged+liastar+elements=timeout
- lost spark_tests__bags/39.smt2: merged=sat 0.10s, merged+liastar+elements=timeout
- lost spark_tests__bags/48.smt2: merged=unsat 0.48s, merged+liastar+elements=timeout
- lost spark_tests__bags/6.smt2: merged=unsat 0.71s, merged+liastar+elements=timeout

## Time on the problems all three solve
564 problems
- main: total 31.1s, median 0.040s, max 0.55s
- base: total 105.2s, median 0.040s, max 5.99s
- branch: total 97.7s, median 0.040s, max 4.60s
- branch+liastar: total 120.9s, median 0.040s, max 7.09s
- branch+liastar+elements: total 134.8s, median 0.045s, max 6.74s
- branch+liastar+dio: total 152.8s, median 0.050s, max 8.94s
- branch+liastar(gated): total 103.8s, median 0.040s, max 4.54s
- merged: total 43.3s, median 0.040s, max 1.66s
- merged+liastar: total 55.2s, median 0.040s, max 5.81s
- merged+liastar+elements: total 48.5s, median 0.040s, max 4.54s
- merged+liastar(gated): total 35.6s, median 0.040s, max 0.80s
- main/base: median ratio 1.00, mean 0.88
  largest slowdowns: no_aggregation__sets/testPullConstantThroughUnion3.smt2 0.04->0.09, no_aggregation__sets/testPullConstantThroughUnion2.smt2 0.04->0.09, spark_tests__bags/15.smt2 0.06->0.07, no_aggregation_sat__sets/testMergeUnionMixed2.smt2 0.06->0.07, no_aggregation_no_null_no_cast_no_outer_join__sets/testPushSemiJoinPastJoinRuleLeft.smt2 0.12->0.13
  largest speedups: no_aggregation__sets/testTransitiveInferenceUnion3way.smt2 5.99->0.13, calcite_tests__sets/testTransitiveInferenceUnion3way.smt2 5.03->0.13, no_aggregation_no_null__sets/testTransitiveInferenceUnion3way.smt2 4.72->0.13, no_aggregation_sat__sets/testTransitiveInferenceUnion3way.smt2 4.53->0.14, no_aggregation_no_null_no_cast_no_outer_join__sets/testTransitiveInferenceUnion3way.smt2 4.34->0.14
- branch/base: median ratio 1.00, mean 0.96
  largest slowdowns: no_aggregation__bags/testReduceConstantsCalc.smt2 0.03->0.11, spark_tests__sets/49.smt2 4.38->4.44, spark_tests__sets/106.smt2 4.25->4.31, no_aggregation_no_null_no_cast_no_outer_join__sets/testSemiJoinReduceConstants.smt2 0.73->0.76, no_aggregation_no_null_no_cast_no_outer_join__sets/testRemoveSemiJoinRightWithFilter.smt2 0.82->0.84
  largest speedups: no_aggregation__sets/testTransitiveInferenceUnion3way.smt2 5.99->4.34, calcite_tests__sets/testTransitiveInferenceUnion3way.smt2 5.03->4.60, calcite_tests__sets/testPushAggregateThroughJoin1.smt2 2.22->1.83, no_aggregation_no_null__sets/testTransitiveInferenceUnion3way.smt2 4.72->4.34, no_aggregation__sets/testSemiJoinReduceConstants.smt2 1.09->0.74
- branch+liastar/branch: median ratio 1.00, mean 1.71
  largest slowdowns: spark_tests__bags/109.smt2 0.09->7.09, spark_tests__bags/69.smt2 0.11->6.00, calcite_tests__bags/testPullFilterThroughAggregateGroupingSets.smt2 0.06->1.53, no_aggregation__bags/testPullConstantIntoFilter.smt2 0.07->0.89, calcite_tests__bags/testPullConstantIntoFilter.smt2 0.06->0.88
  largest speedups: no_aggregation_no_null_no_cast_no_outer_join__sets/testTransitiveInferenceUnion3way.smt2 4.33->3.40, spark_tests__sets/106.smt2 4.31->3.81, no_aggregation__sets/testTransitiveInferenceUnion3way.smt2 4.34->3.90, no_aggregation_no_null_no_cast__sets/testTransitiveInferenceUnion3way.smt2 4.32->3.91, no_aggregation_no_null__sets/testTransitiveInferenceUnion3way.smt2 4.34->3.94
- branch+liastar(gated)/branch: median ratio 1.00, mean 1.24
  largest slowdowns: bags__sets/testReduceConstantsCalc.smt2 0.04->0.81, bags__sets/testEmptyMinus2.smt2 0.04->0.81, bags__sets/testEmptyFilterProjectUnion.smt2 0.04->0.81, bags__bags/testReduceConstantsCalc.smt2 0.04->0.81, bags__bags/testEmptyMinus2.smt2 0.04->0.81
  largest speedups: no_aggregation__bags/testReduceConstantsCalc.smt2 0.11->0.03, calcite_tests__sets/testTransitiveInferenceUnion3way.smt2 4.60->4.53, no_aggregation_no_null_no_cast_no_outer_join__sets/testSemiJoinReduceConstants.smt2 0.76->0.74, no_aggregation_no_null_no_cast_no_outer_join__sets/testPushJoinThroughUnionOnLeft.smt2 0.62->0.60, spark_tests__sets/88.smt2 0.27->0.26
- merged/main: median ratio 1.00, mean 1.56
  largest slowdowns: bags__sets/testEmptyFilterProjectUnion.smt2 0.03->1.66, bags__bags/testReduceConstantsCalc.smt2 0.03->1.66, bags__bags/testEmptyMinus2.smt2 0.03->1.66, bags__sets/testEmptyMinus2.smt2 0.04->1.66, bags__bags/testEmptyFilterProjectUnion.smt2 0.04->1.66
  largest speedups: no_aggregation__sets/testPullConstantThroughUnion3.smt2 0.09->0.03, no_aggregation__sets/testPullConstantThroughUnion2.smt2 0.09->0.03, spark_tests__bags/15.smt2 0.07->0.06, no_aggregation_no_null__sets/testRemoveSemiJoinWithFilter.smt2 0.07->0.06, no_aggregation__sets/testTransitiveInferenceProject.smt2 0.07->0.06
- merged+liastar(gated)/merged: median ratio 1.00, mean 0.99
  largest slowdowns: no_aggregation__sets/testPullConstantThroughUnion.smt2 0.04->0.08, spark_tests__bags/15.smt2 0.06->0.07, no_aggregation__bags/testPullConstantIntoFilter.smt2 0.06->0.07, spark_tests__sets/99.smt2 0.03->0.04, spark_tests__sets/98.smt2 0.03->0.04
  largest speedups: bags__sets/testEmptyMinus2.smt2 1.66->0.79, bags__sets/testEmptyFilterProjectUnion.smt2 1.66->0.79, bags__bags/testEmptyMinus2.smt2 1.66->0.79, bags__bags/testReduceConstantsCalc.smt2 1.66->0.80, bags__bags/testEmptyFilterProjectUnion.smt2 1.66->0.80
