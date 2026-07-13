; test name: testPushProjectPastSetOp
;Translating sql query: SELECT t.SAL FROM (SELECT * FROM EMP AS EMP UNION ALL SELECT * FROM EMP AS EMP0) AS t
;Translating sql query: SELECT EMP1.SAL FROM EMP AS EMP1 UNION ALL SELECT EMP2.SAL FROM EMP AS EMP2
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= q1 ((_ rel.project 6) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP) ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP)))))
(assert (= q2 (set.union ((_ rel.project 6) EMP) ((_ rel.project 6) EMP))))
(check-sat)
;answer: unsat
; duration: 18 ms.
(reset)
