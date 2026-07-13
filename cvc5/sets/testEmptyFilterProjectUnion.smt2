; test name: testEmptyFilterProjectUnion
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES  (10, 1),  (30, 3)) AS t UNION ALL SELECT * FROM (VALUES  (20, 2)) AS t0) AS t1 WHERE t1.EXPR$0 + t1.EXPR$1 > 30
;Translating sql query: SELECT * FROM (VALUES  (30, 3)) AS t3
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 1) t)) (> (+ (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 1) t))) 30)))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 (set.union ((_ rel.project 0 1) (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 30) (nullable.some 3))))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 20) (nullable.some 2)))))))))
(assert (= q2 ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 30) (nullable.some 3))))))
(check-sat)
;answer: unsat
; duration: 10 ms.
(reset)
