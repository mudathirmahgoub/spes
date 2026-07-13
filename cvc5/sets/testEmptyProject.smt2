; test name: testEmptyProject
;Translating sql query: SELECT t.EXPR$0 + t.EXPR$1 + t.EXPR$0 FROM (VALUES  (10, 1),  (30, 3)) AS t WHERE t.EXPR$0 + t.EXPR$1 > 50
;Translating sql query: SELECT t3.EXPR$0 + t3.EXPR$1 + t3.EXPR$0 FROM (SELECT * FROM (VALUES(0,0)) EXCEPT SELECT * FROM (VALUES(0,0))) AS t3
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 1) t)) (> (+ (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 1) t))) 50)))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_364474 Int) (BOUND_VARIABLE_364475 Int)) (+ BOUND_VARIABLE_364474 BOUND_VARIABLE_364475)) (nullable.lift (lambda ((BOUND_VARIABLE_364468 Int) (BOUND_VARIABLE_364469 Int)) (+ BOUND_VARIABLE_364468 BOUND_VARIABLE_364469)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 0) t))))))
(assert (not (= q1 q2)))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_364498 Int) (BOUND_VARIABLE_364499 Int)) (+ BOUND_VARIABLE_364498 BOUND_VARIABLE_364499)) (nullable.lift (lambda ((BOUND_VARIABLE_364492 Int) (BOUND_VARIABLE_364493 Int)) (+ BOUND_VARIABLE_364492 BOUND_VARIABLE_364493)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 0) t))))))
(assert (= q1 (set.map f1 (set.filter p0 (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 30) (nullable.some 3))))))))
(assert (= q2 (set.map f2 (set.minus ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 0) (nullable.some 0)))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 0) (nullable.some 0))))))))
(check-sat)
;answer: unsat
; duration: 18 ms.
(reset)
