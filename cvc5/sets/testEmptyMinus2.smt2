; test name: testEmptyMinus2
;Translating sql query: SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES  (30, 3)) AS t EXCEPT SELECT * FROM (VALUES  (20, 2)) AS t0 WHERE t0.EXPR$0 > 30) AS t2 EXCEPT SELECT * FROM (VALUES  (40, 4)) AS t3) AS t4 EXCEPT SELECT * FROM (VALUES  (50, 5)) AS t5 WHERE t5.EXPR$0 > 50
;Translating sql query: SELECT * FROM (VALUES  (30, 3)) AS t8 EXCEPT SELECT * FROM (VALUES  (40, 4)) AS t9
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
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (> (nullable.val ((_ tuple.select 0) t)) 30)))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (> (nullable.val ((_ tuple.select 0) t)) 50)))))
(assert (= q1 (set.minus ((_ rel.project 0 1) (set.minus ((_ rel.project 0 1) (set.minus ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 30) (nullable.some 3)))) ((_ rel.project 0 1) (set.filter p0 (set.singleton (tuple (nullable.some 20) (nullable.some 2))))))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 40) (nullable.some 4)))))) ((_ rel.project 0 1) (set.filter p1 (set.singleton (tuple (nullable.some 50) (nullable.some 5))))))))
(assert (= q2 (set.minus ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 30) (nullable.some 3)))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 40) (nullable.some 4)))))))
(check-sat)
;answer: unsat
; duration: 17 ms.
(reset)
