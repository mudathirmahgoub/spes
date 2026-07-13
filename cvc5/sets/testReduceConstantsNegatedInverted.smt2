; test name: testReduceConstantsNegatedInverted
;Translating sql query: SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO > 10 AND EMP.EMPNO <= 10
;Translating sql query: SELECT t1.EXPR$0 FROM (SELECT * FROM (VALUES(0)) EXCEPT SELECT * FROM (VALUES(0))) AS t1
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
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 0) t)) (and (> (nullable.val ((_ tuple.select 0) t)) 10) (<= (nullable.val ((_ tuple.select 0) t)) 10))))))
(assert (= q1 ((_ rel.project 0) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0) (set.minus ((_ rel.project 0) (set.singleton (tuple (nullable.some 0)))) ((_ rel.project 0) (set.singleton (tuple (nullable.some 0))))))))
(check-sat)
;answer: unsat
; duration: 10 ms.
(reset)
