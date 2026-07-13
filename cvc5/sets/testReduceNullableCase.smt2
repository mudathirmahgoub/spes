; test name: testReduceNullableCase
;Translating sql query: SELECT CASE WHEN 1 = 2 THEN CAST(t0.EXPR$0 AS INTEGER) ELSE 2 END FROM (VALUES  (1)) AS t LEFT JOIN (VALUES  (1)) AS t0 ON TRUE
;Translating sql query: SELECT CAST(2 AS INTEGER) FROM (VALUES  (1)) AS t2 LEFT JOIN (VALUES  (1)) AS t3 ON TRUE
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)

(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const leftJoin0 (-> (Tuple (Nullable Int)) (Tuple (Nullable Int) (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const leftJoin2 (-> (Tuple (Nullable Int)) (Tuple (Nullable Int) (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= leftJoin0 (lambda ((t (Tuple (Nullable Int)))) (tuple ((_ tuple.select 0) t) (as nullable.null (Nullable Int))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2)))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int)))) (tuple ((_ tuple.select 0) t) (as nullable.null (Nullable Int))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2)))))
(assert (= q1 (set.map f1 (set.union (set.map leftJoin0 (set.minus (set.singleton (tuple (nullable.some 1))) ((_ rel.project 0) (rel.product (set.singleton (tuple (nullable.some 1))) (set.singleton (tuple (nullable.some 1))))))) (rel.product (set.singleton (tuple (nullable.some 1))) (set.singleton (tuple (nullable.some 1))))))))
(assert (= q2 (set.map f3 (set.union (set.map leftJoin2 (set.minus (set.singleton (tuple (nullable.some 1))) ((_ rel.project 0) (rel.product (set.singleton (tuple (nullable.some 1))) (set.singleton (tuple (nullable.some 1))))))) (rel.product (set.singleton (tuple (nullable.some 1))) (set.singleton (tuple (nullable.some 1))))))))
(check-sat)
;answer: unsat
; duration: 7 ms.
(reset)
