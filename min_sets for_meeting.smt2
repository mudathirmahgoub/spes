;-----------------------------------------------------------
; test name: testPushMinThroughUnion
; q1
;SELECT t.ENAME, MIN(t.EMPNO) 
; FROM (SELECT * FROM EMP AS EMP UNION ALL SELECT * FROM EMP AS EMP0) 
; AS t GROUP BY t.ENAME
;
; q2
; SELECT t6.ENAME, MIN(T6.EMPNO) 
; FROM (SELECT EMP1.ENAME, MIN(EMP1.EMPNO) AS EMPNO 
; FROM EMP AS EMP1 GROUP BY EMP1.ENAME 
; UNION ALL SELECT EMP2.ENAME, MIN(EMP2.EMPNO) 
; FROM EMP AS EMP2 GROUP BY EMP2.ENAME) AS t6 GROUP BY t6.ENAME
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
;; (set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable String) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable String) (Nullable Int))))
(declare-const aggr5 (-> (Set (Tuple (Nullable String) (Nullable Int))) (Tuple (Nullable String) (Nullable Int))))
(declare-const aggr4 (-> (Set (Tuple (Nullable String) (Nullable Int))) (Tuple (Nullable String) (Nullable Int))))
(declare-const aggr3 (-> (Set (Tuple (Nullable String) (Nullable Int))) (Tuple (Nullable String) (Nullable Int))))
(declare-const aggr2 (-> (Set (Tuple (Nullable String) (Nullable Int))) (Tuple (Nullable String) (Nullable Int))))
(declare-const leq0 (-> (Nullable Int) (Nullable Int) Bool))
(assert (not (= q1 q2)))
(assert (= leq0 (lambda ((x (Nullable Int)) (y (Nullable Int))) (ite (and (nullable.is_null x) (nullable.is_null y)) true (ite (nullable.is_null x) false (<= (nullable.val x) (nullable.val y)))))))
(assert (= aggr2 (lambda ((s (Set (Tuple (Nullable String) (Nullable Int))))) (tuple (ite (set.is_empty s) (as nullable.null (Nullable String)) ((_ tuple.select 0) (set.choose s))) ((_ rel.min 1) leq0 s (as nullable.null (Nullable Int)))))))
(assert (= q1 (set.map aggr2 ((_ rel.group 0) ((_ rel.project 1 0) (set.union EMP EMP))))))
(assert (= q2 
  (set.union (set.map aggr2 ((_ rel.group 0) ((_ rel.project 1 0) EMP))) 
  (set.map aggr2 ((_ rel.group 0) ((_ rel.project 1 0) ((_ rel.project 0 1 2) EMP)))))))
(check-sat)
