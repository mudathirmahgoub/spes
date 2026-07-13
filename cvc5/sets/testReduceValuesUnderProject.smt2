; test name: testReduceValuesUnderProject
;Translating sql query: SELECT t.EXPR$0 + t.EXPR$1 FROM (VALUES  (10, 1),  (20, 3)) AS t
;Translating sql query: SELECT * FROM (VALUES  (11),  (23)) AS t1
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
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_4621 Int) (BOUND_VARIABLE_4622 Int)) (+ BOUND_VARIABLE_4621 BOUND_VARIABLE_4622)) ((_ tuple.select 0) t) ((_ tuple.select 1) t))))))
(assert (= q1 (set.map f0 (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 20) (nullable.some 3)))))))
(assert (= q2 ((_ rel.project 0) (set.union (set.singleton (tuple (nullable.some 11))) (set.singleton (tuple (nullable.some 23)))))))
(check-sat)
;answer: unsat
; duration: 4 ms.
(reset)
