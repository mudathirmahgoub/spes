; test name: testEmptyMinus
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES  (30, 3)) AS t WHERE t.EXPR$0 > 30 EXCEPT SELECT * FROM (VALUES  (20, 2)) AS t1) AS t2 EXCEPT SELECT * FROM (VALUES  (40, 4)) AS t3
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES  (0, 0)) except SELECT * FROM (VALUES  (0, 0))) AS t5
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (> (nullable.val ((_ tuple.select 0) t)) 30)))))
(assert (= q1 (set.minus ((_ rel.project 0 1) (set.minus ((_ rel.project 0 1) (set.filter p0 (set.singleton (tuple (nullable.some 30) (nullable.some 3))))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 20) (nullable.some 2)))))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 40) (nullable.some 4)))))))
(assert (= q2 ((_ rel.project 0 1) (set.minus ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 0) (nullable.some 0)))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 0) (nullable.some 0))))))))
(check-sat)
;answer: unsat
; duration: 7 ms.
(reset)
