;-----------------------------------------------------------
; test name: testPushMinThroughUnion
;Translating sql query: SELECT t.ENAME, MIN(t.EMPNO) FROM (SELECT * FROM EMP AS EMP UNION ALL SELECT * FROM EMP AS EMP0) AS t GROUP BY t.ENAME
;Translating sql query: SELECT t6.ENAME, MIN(T6.EMPNO) FROM (SELECT EMP1.ENAME, MIN(EMP1.EMPNO) AS EMPNO FROM EMP AS EMP1 GROUP BY EMP1.ENAME UNION ALL SELECT EMP2.ENAME, MIN(EMP2.EMPNO) FROM EMP AS EMP2 GROUP BY EMP2.ENAME) AS t6 GROUP BY t6.ENAME
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable String) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable String) (Nullable Int))))
(define-fun leq ((x (Tuple (Nullable String) (Nullable Int))) (y (Tuple (Nullable String) (Nullable Int)))) Bool
  (let ((x1 ((_ tuple.select 1) x)) (y1 ((_ tuple.select 1) y)))
      (ite 
        (and (nullable.is_null x1) (nullable.is_null y1))
        true 
        (ite 
          (nullable.is_null x1)
          false          
          (<= (nullable.val x1) (nullable.val y1))))))


(define-fun witness ((x Int)) Int
  (ite (> x 0) x 1))

(define-fun min ((s (Relation (Nullable String) (Nullable Int)))) (Tuple (Nullable String) (Nullable Int))
  (ite 
    (= s (as set.empty (Relation (Nullable String) (Nullable Int))))
    (tuple (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)))
    (witness5 ((x (Tuple (Nullable String) (Nullable Int))))       
        (and 
          (set.member x s)
          (set.all (lambda ((y (Tuple (Nullable String) (Nullable Int))))
                   (leq x y)) s)))))
(check-sat)
