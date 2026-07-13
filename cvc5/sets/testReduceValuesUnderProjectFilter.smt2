; test name: testReduceValuesUnderProjectFilter
;Translating sql query: SELECT t.EXPR$0 + t.EXPR$1 AS X, t.EXPR$1 AS B, t.EXPR$0 AS A FROM (VALUES  (10, 1),  (30, 7),  (20, 3)) AS t WHERE t.EXPR$0 - t.EXPR$1 < 21
;Translating sql query: SELECT * FROM (VALUES  (11, 1, 10),  (23, 3, 20)) AS t2
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 1) t)) (< (- (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 1) t))) 21)))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_1524 Int) (BOUND_VARIABLE_1525 Int)) (+ BOUND_VARIABLE_1524 BOUND_VARIABLE_1525)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= q1 (set.map f1 (set.filter p0 (set.union (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 30) (nullable.some 7)))) (set.singleton (tuple (nullable.some 20) (nullable.some 3))))))))
(assert (= q2 ((_ rel.project 0 1 2) (set.union (set.singleton (tuple (nullable.some 11) (nullable.some 1) (nullable.some 10))) (set.singleton (tuple (nullable.some 23) (nullable.some 3) (nullable.some 20)))))))
(check-sat)
;answer: unsat
; duration: 11 ms.
(reset)
