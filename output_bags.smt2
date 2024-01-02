;-----------------------------------------------------------
; test name: testRemoveSemiJoin
;Translating sql query: SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO
;Translating sql query: SELECT EMP0.ENAME FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Bag (Tuple Int String String Int Int Int Int Int Int)))
(declare-const DEPT (Bag (Tuple Int String)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int Int String) Bool))
(declare-const p2 (-> (Tuple Int String String Int Int Int Int Int Int Int String) Bool))
(declare-const f1 (-> (Tuple Int String String Int Int Int Int Int Int Int String) (Tuple String)))
(declare-const f3 (-> (Tuple Int String String Int Int Int Int Int Int Int String) (Tuple String)))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String))) (= ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))
(assert (= f1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String))) (tuple ((_ tuple.select 1) t)))))
(assert (= p2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String))) (= ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))
(assert (not (= (bag.map f1 (bag.filter p0 (table.product EMP DEPT))) (bag.map f3 (bag.filter p2 (table.product EMP DEPT))))))
(assert (= f3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String))) (tuple ((_ tuple.select 1) t)))))
(check-sat)
;answer: unknown (TIMEOUT)
;-----------------------------------------------------------
; test name: testPullConstantThroughUnion
;Translating sql query: SELECT 2, EMP.DEPTNO, EMP.JOB FROM EMP AS EMP UNION ALL SELECT 2, EMP0.DEPTNO, EMP0.JOB FROM EMP AS EMP0
;Translating sql query: SELECT 2, t6.DEPTNO, t6.JOB FROM (SELECT EMP1.DEPTNO, EMP1.JOB FROM EMP AS EMP1 UNION ALL SELECT EMP2.DEPTNO, EMP2.JOB FROM EMP AS EMP2) AS t6
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Bag (Tuple Int String String Int Int Int Int Int Int)))
(declare-const f0 (-> (Tuple Int String String Int Int Int Int Int Int) (Tuple Int Int String)))
(declare-const f1 (-> (Tuple Int String String Int Int Int Int Int Int) (Tuple Int Int String)))
(declare-const f2 (-> (Tuple Int String String Int Int Int Int Int Int) (Tuple Int String)))
(declare-const f3 (-> (Tuple Int String String Int Int Int Int Int Int) (Tuple Int String)))
(declare-const f4 (-> (Tuple Int String) (Tuple Int Int String)))
(assert (= f0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (tuple 2 ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (tuple 2 ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (tuple ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (tuple ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (not (= (bag.union_disjoint (bag.map f0 EMP) (bag.map f1 EMP)) (bag.map f4 (bag.union_disjoint (bag.map f2 EMP) (bag.map f3 EMP))))))
(assert (= f4 (lambda ((t (Tuple Int String))) (tuple 2 ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(check-sat)
