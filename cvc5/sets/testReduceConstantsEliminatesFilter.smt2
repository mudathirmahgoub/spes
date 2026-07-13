; test name: testReduceConstantsEliminatesFilter
;Translating sql query: SELECT * FROM (VALUES  (1, 2)) AS t WHERE 1 + 2 > 3 + CAST(NULL AS INT)
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES(0, 0)) WHERE FALSE) AS t1
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_536059 Int) (BOUND_VARIABLE_536060 Int)) (> BOUND_VARIABLE_536059 BOUND_VARIABLE_536060)) (nullable.some (+ 1 2)) (nullable.lift (lambda ((BOUND_VARIABLE_536053 Int) (BOUND_VARIABLE_536054 Int)) (+ BOUND_VARIABLE_536053 BOUND_VARIABLE_536054)) (nullable.some 3) (as nullable.null (Nullable Int))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_536059 Int) (BOUND_VARIABLE_536060 Int)) (> BOUND_VARIABLE_536059 BOUND_VARIABLE_536060)) (nullable.some (+ 1 2)) (nullable.lift (lambda ((BOUND_VARIABLE_536053 Int) (BOUND_VARIABLE_536054 Int)) (+ BOUND_VARIABLE_536053 BOUND_VARIABLE_536054)) (nullable.some 3) (as nullable.null (Nullable Int)))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) false)))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 (set.singleton (tuple (nullable.some 1) (nullable.some 2)))))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p1 (set.singleton (tuple (nullable.some 0) (nullable.some 0)))))))
(check-sat)
;answer: unsat
; duration: 10 ms.
(reset)
