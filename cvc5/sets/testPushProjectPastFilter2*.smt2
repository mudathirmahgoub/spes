; test name: testPushProjectPastFilter2*
;Translating sql query: SELECT EMP.MGR FROM EMP AS EMP WHERE CASE WHEN EMP.MGR < 10 THEN TRUE ELSE FALSE END
;Translating sql query: SELECT * FROM (SELECT EMP0.MGR FROM EMP AS EMP0) AS t2 WHERE t2.MGR < 10
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 3) t)) (ite (< (nullable.val ((_ tuple.select 3) t)) 10) true false)))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (< (nullable.val ((_ tuple.select 0) t)) 10)))))
(assert (= q1 ((_ rel.project 3) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0) (set.filter p1 ((_ rel.project 3) EMP)))))
(check-sat)
;answer: unsat
; duration: 34 ms.
(reset)
