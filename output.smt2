;-----------------------------------------------------------
; test name: testMergeMinus
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 EXCEPT SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 EXCEPT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
;Translating sql query: SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 EXCEPT SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 EXCEPT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p2 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p3 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p4 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p5 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 10))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 20))))
(assert (= p2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 30))))
(assert (= p3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 10))))
(assert (= p4 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 20))))
(assert (not (= (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP))) (set.minus (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP))))))
(assert (= p5 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 30))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testRemoveSemiJoin
;Translating sql query: SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO
;Translating sql query: SELECT EMP0.ENAME FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const DEPT (Set (Tuple Int String)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int Int String) Bool))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int Int String) Bool))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String))) (= ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))
(assert (not (= ((_ rel.project 1) (set.filter p0 (rel.product EMP DEPT))) ((_ rel.project 1) (set.filter p1 (rel.product EMP DEPT))))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String))) (= ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testPullConstantThroughUnion
;Translating sql query: SELECT 2, EMP.DEPTNO, EMP.JOB FROM EMP AS EMP UNION ALL SELECT 2, EMP0.DEPTNO, EMP0.JOB FROM EMP AS EMP0
;Translating sql query: SELECT 2, t6.DEPTNO, t6.JOB FROM (SELECT EMP1.DEPTNO, EMP1.JOB FROM EMP AS EMP1 UNION ALL SELECT EMP2.DEPTNO, EMP2.JOB FROM EMP AS EMP2) AS t6
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const f0 (-> (Tuple Int String String Int Int Int Int Int Int) (Tuple Int Int String)))
(declare-const f1 (-> (Tuple Int String String Int Int Int Int Int Int) (Tuple Int Int String)))
(declare-const f2 (-> (Tuple Int String) (Tuple Int Int String)))
(assert (= f0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (tuple 2 ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (tuple 2 ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (not (= (set.union (set.map f0 EMP) (set.map f1 EMP)) (set.map f2 (set.union ((_ rel.project 7 2) EMP) ((_ rel.project 7 2) EMP))))))
(assert (= f2 (lambda ((t (Tuple Int String))) (tuple 2 ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testWhereInCorrelated
;Translating sql query: SELECT EMP.SAL FROM EMP AS EMP WHERE EMP.EMPNO IN (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE EMP.JOB = DEPT.NAME)
;Translating sql query: SELECT EMP0.SAL FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.JOB = DEPT0.NAME AND EMP0.EMPNO = DEPT0.DEPTNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const DEPT (Set (Tuple Int String)))
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p1 (-> (Tuple Int String String) Bool))
(declare-const p2 (-> (Tuple Int String String Int Int Int Int Int Int Int String) Bool))
(declare-const p5 (-> (Tuple Int String String Int Int Int Int Int Int String Int String String) Bool))
(declare-const f0 (-> (Tuple Int String) (Tuple Int String String)))
(declare-const f3 (-> (Tuple Int String String Int Int Int Int Int Int) (Tuple Int String String Int Int Int Int Int Int String)))
(declare-const f4 (-> (Tuple Int String) (Tuple Int String String)))
(assert (= f0 (lambda ((t (Tuple Int String))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p1 (lambda ((t (Tuple Int String String))) (= ((_ tuple.select 2) t) ((_ tuple.select 1) t)))))
(assert (= p2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String))) (and (= ((_ tuple.select 2) t) ((_ tuple.select 10) t)) (= ((_ tuple.select 0) t) ((_ tuple.select 9) t))))))
(assert (= f3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 2) t)))))
(assert (= f4 (lambda ((t (Tuple Int String))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (not (= ((_ rel.project 6) (set.filter p2 (rel.product EMP ((_ rel.project 0 1) ((_ rel.project 0 2) (set.filter p1 (set.map f0 DEPT))))))) ((_ rel.project 6) (set.filter p5 (rel.product (set.map f3 EMP) (set.map f4 DEPT)))))))
(assert (= p5 (lambda ((t (Tuple Int String String Int Int Int Int Int Int String Int String String))) (and (= ((_ tuple.select 9) t) ((_ tuple.select 12) t)) (= ((_ tuple.select 0) t) ((_ tuple.select 10) t))))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testReduceConstantsProjectNullable*
;Translating sql query: SELECT EMP.MGR FROM EMP AS EMP WHERE EMP.MGR = 10
;Translating sql query: SELECT 10 AS MGR FROM EMP AS EMP0 WHERE EMP0.MGR = 10
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const f2 (-> (Tuple Int String String Int Int Int Int Int Int) (Tuple Int)))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 3) t) 10))))
(assert (not (= ((_ rel.project 3) (set.filter p0 EMP)) (set.map f2 (set.filter p1 EMP)))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 3) t) 10))))
(assert (= f2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (tuple 10))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testTransitiveInferencePreventProjectPullUp
;Translating sql query: SELECT 1 FROM (SELECT EMP.COMM AS DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO > 7) AS t0 INNER JOIN EMP AS EMP0 ON t0.DEPTNO = EMP0.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT EMP1.COMM AS DEPTNO FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t3 INNER JOIN EMP AS EMP2 ON t3.DEPTNO = EMP2.DEPTNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p1 (-> (Tuple Int Int String String Int Int Int Int Int Int) Bool))
(declare-const p3 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p4 (-> (Tuple Int Int String String Int Int Int Int Int Int) Bool))
(declare-const f2 (-> (Tuple Int Int String String Int Int Int Int Int Int) (Tuple Int)))
(declare-const f5 (-> (Tuple Int Int String String Int Int Int Int Int Int) (Tuple Int)))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 7))))
(assert (= p1 (lambda ((t (Tuple Int Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))
(assert (= f2 (lambda ((t (Tuple Int Int String String Int Int Int Int Int Int))) (tuple 1))))
(assert (= p3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 7))))
(assert (not (= (set.map f2 (set.filter p1 (rel.product ((_ rel.project 5) (set.filter p0 EMP)) EMP))) (set.map f5 (set.filter p4 (rel.product ((_ rel.project 5) (set.filter p3 EMP)) EMP))))))
(assert (= p4 (lambda ((t (Tuple Int Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))
(assert (= f5 (lambda ((t (Tuple Int Int String String Int Int Int Int Int Int))) (tuple 1))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testTransitiveInferenceJoin3way
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO INNER JOIN EMP AS EMP1 ON EMP0.DEPTNO = EMP1.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO INNER JOIN (SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 7) AS t3 ON t2.DEPTNO = t3.DEPTNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) Bool))
(declare-const p2 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) Bool))
(declare-const f9 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) (Tuple Int)))
(declare-const p4 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p5 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p6 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) Bool))
(declare-const p7 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p8 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) Bool))
(declare-const f3 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) (Tuple Int)))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 7))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))
(assert (= p2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 16) t) ((_ tuple.select 25) t)))))
(assert (= f3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (tuple 1))))
(assert (= p4 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 7))))
(assert (= p5 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 7))))
(assert (= p6 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))
(assert (= p7 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 7))))
(assert (not (= (set.map f3 (set.filter p2 (rel.product (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) EMP)) EMP))) (set.map f9 (set.filter p8 (rel.product (set.filter p6 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p7 EMP))))))))
(assert (= p8 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 16) t) ((_ tuple.select 25) t)))))
(assert (= f9 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (tuple 1))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testRemoveSemiJoinRight
;Translating sql query: SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = EMP0.DEPTNO
;Translating sql query: SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.DEPTNO = DEPT0.DEPTNO INNER JOIN EMP AS EMP2 ON DEPT0.DEPTNO = EMP2.DEPTNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const DEPT (Set (Tuple Int String)))
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int Int String Int String String Int Int Int Int Int Int) Bool))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int Int String) Bool))
(declare-const p2 (-> (Tuple Int String String Int Int Int Int Int Int Int String Int String String Int Int Int Int Int Int) Bool))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String Int String String Int Int Int Int Int Int))) (and (= ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (= ((_ tuple.select 9) t) ((_ tuple.select 18) t))))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String))) (= ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))
(assert (not (= ((_ rel.project 1) (set.filter p0 (rel.product (rel.product EMP DEPT) EMP))) ((_ rel.project 1) (set.filter p2 (rel.product (set.filter p1 (rel.product EMP DEPT)) EMP))))))
(assert (= p2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 9) t) ((_ tuple.select 18) t)))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testTransitiveInferenceProject
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const f6 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) (Tuple Int)))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) Bool))
(declare-const p3 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p4 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p5 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) Bool))
(declare-const f2 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) (Tuple Int)))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 7))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))
(assert (= f2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (tuple 1))))
(assert (= p3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 7))))
(assert (= p4 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 7))))
(assert (not (= (set.map f2 (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) EMP))) (set.map f6 (set.filter p5 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))))))))
(assert (= p5 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))
(assert (= f6 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (tuple 1))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testPushSemiJoinPastJoinRuleLeft
;Translating sql query: SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.EMPNO = EMP0.EMPNO
;Translating sql query: SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.DEPTNO = DEPT0.DEPTNO INNER JOIN EMP AS EMP2 ON EMP1.EMPNO = EMP2.EMPNO INNER JOIN DEPT AS DEPT1 ON EMP1.DEPTNO = DEPT1.DEPTNO INNER JOIN EMP AS EMP3 ON EMP1.EMPNO = EMP3.EMPNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const DEPT (Set (Tuple Int String)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int Int String Int String String Int Int Int Int Int Int) Bool))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int Int String) Bool))
(declare-const p2 (-> (Tuple Int String String Int Int Int Int Int Int Int String Int String String Int Int Int Int Int Int) Bool))
(declare-const p3 (-> (Tuple Int String String Int Int Int Int Int Int Int String Int String String Int Int Int Int Int Int Int String) Bool))
(declare-const p4 (-> (Tuple Int String String Int Int Int Int Int Int Int String Int String String Int Int Int Int Int Int Int String Int String String Int Int Int Int Int Int) Bool))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String Int String String Int Int Int Int Int Int))) (and (= ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (= ((_ tuple.select 0) t) ((_ tuple.select 11) t))))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String))) (= ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))
(assert (= p2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 0) t) ((_ tuple.select 11) t)))))
(assert (= p3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String Int String String Int Int Int Int Int Int Int String))) (= ((_ tuple.select 7) t) ((_ tuple.select 20) t)))))
(assert (not (= ((_ rel.project 1) (set.filter p0 (rel.product (rel.product EMP DEPT) EMP))) ((_ rel.project 1) (set.filter p4 (rel.product (set.filter p3 (rel.product (set.filter p2 (rel.product (set.filter p1 (rel.product EMP DEPT)) EMP)) DEPT)) EMP))))))
(assert (= p4 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String Int String String Int Int Int Int Int Int Int String Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 0) t) ((_ tuple.select 22) t)))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testExtractJoinFilterRule
;Translating sql query: SELECT 1 FROM EMP AS EMP INNER JOIN DEPT AS DEPT ON EMP.DEPTNO = DEPT.DEPTNO
;Translating sql query: SELECT 1 FROM EMP AS EMP0, DEPT AS DEPT0 WHERE EMP0.DEPTNO = DEPT0.DEPTNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const DEPT (Set (Tuple Int String)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int Int String) Bool))
(declare-const p2 (-> (Tuple Int String String Int Int Int Int Int Int Int String) Bool))
(declare-const f1 (-> (Tuple Int String String Int Int Int Int Int Int Int String) (Tuple Int)))
(declare-const f3 (-> (Tuple Int String String Int Int Int Int Int Int Int String) (Tuple Int)))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String))) (= ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))
(assert (= f1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String))) (tuple 1))))
(assert (not (= (set.map f1 (set.filter p0 (rel.product EMP DEPT))) (set.map f3 (set.filter p2 (rel.product EMP DEPT))))))
(assert (= p2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String))) (= ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))
(assert (= f3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String))) (tuple 1))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testDecorrelateTwoIn
;Translating sql query: SELECT EMP.SAL FROM EMP AS EMP WHERE EMP.EMPNO IN (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE EMP.JOB = DEPT.NAME) AND EMP.EMPNO IN (SELECT EMP0.EMPNO FROM EMP AS EMP0 WHERE EMP.ENAME = EMP0.ENAME)
;Translating sql query: SELECT EMP1.SAL FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.JOB = DEPT0.NAME AND EMP1.EMPNO = DEPT0.DEPTNO INNER JOIN (SELECT EMP2.EMPNO, EMP2.ENAME FROM EMP AS EMP2) AS t5 ON EMP1.ENAME = t5.ENAME AND EMP1.EMPNO = t5.EMPNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const DEPT (Set (Tuple Int String)))
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const f6 (-> (Tuple Int String String Int Int Int Int Int Int) (Tuple Int String String Int Int Int Int Int Int String)))
(declare-const p1 (-> (Tuple Int String String) Bool))
(declare-const f7 (-> (Tuple Int String) (Tuple Int String String)))
(declare-const p11 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int String String) Bool))
(declare-const p2 (-> (Tuple Int String String Int Int Int Int Int Int Int String) Bool))
(declare-const f9 (-> (Tuple Int String String Int Int Int Int Int Int String Int String String) (Tuple Int String String Int Int Int Int Int Int Int String String)))
(declare-const p4 (-> (Tuple Int String String Int Int Int Int Int Int String) Bool))
(declare-const f10 (-> (Tuple Int String String Int Int Int Int Int Int) (Tuple Int String String)))
(declare-const p5 (-> (Tuple Int String String Int Int Int Int Int Int Int String Int String) Bool))
(declare-const p8 (-> (Tuple Int String String Int Int Int Int Int Int String Int String String) Bool))
(declare-const f0 (-> (Tuple Int String) (Tuple Int String String)))
(declare-const f3 (-> (Tuple Int String String Int Int Int Int Int Int) (Tuple Int String String Int Int Int Int Int Int String)))
(assert (= f0 (lambda ((t (Tuple Int String))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p1 (lambda ((t (Tuple Int String String))) (= ((_ tuple.select 2) t) ((_ tuple.select 1) t)))))
(assert (= p2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String))) (and (= ((_ tuple.select 2) t) ((_ tuple.select 10) t)) (= ((_ tuple.select 0) t) ((_ tuple.select 9) t))))))
(assert (= f3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 1) t)))))
(assert (= p4 (lambda ((t (Tuple Int String String Int Int Int Int Int Int String))) (= ((_ tuple.select 9) t) ((_ tuple.select 1) t)))))
(assert (= p5 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String Int String))) (and (= ((_ tuple.select 1) t) ((_ tuple.select 12) t)) (= ((_ tuple.select 0) t) ((_ tuple.select 11) t))))))
(assert (= f6 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 2) t)))))
(assert (= f7 (lambda ((t (Tuple Int String))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p8 (lambda ((t (Tuple Int String String Int Int Int Int Int Int String Int String String))) (and (= ((_ tuple.select 9) t) ((_ tuple.select 12) t)) (= ((_ tuple.select 0) t) ((_ tuple.select 10) t))))))
(assert (= f9 (lambda ((t (Tuple Int String String Int Int Int Int Int Int String Int String String))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 10) t) ((_ tuple.select 11) t) ((_ tuple.select 1) t)))))
(assert (= f10 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (not (= ((_ rel.project 6) (set.filter p5 (rel.product (set.filter p2 (rel.product EMP ((_ rel.project 0 1) ((_ rel.project 0 2) (set.filter p1 (set.map f0 DEPT)))))) ((_ rel.project 0 1) ((_ rel.project 0 9) (set.filter p4 (set.map f3 EMP))))))) ((_ rel.project 6) (set.filter p11 (rel.product (set.map f9 (set.filter p8 (rel.product (set.map f6 EMP) (set.map f7 DEPT)))) (set.map f10 EMP)))))))
(assert (= p11 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int String String))) (and (= ((_ tuple.select 11) t) ((_ tuple.select 14) t)) (= ((_ tuple.select 0) t) ((_ tuple.select 12) t))))))
(check-sat)
;answer: unknown (TIMEOUT)
;-----------------------------------------------------------
; test name: testMergeFilter
;Translating sql query: SELECT t.NAME FROM (SELECT * FROM DEPT AS DEPT WHERE DEPT.DEPTNO = 10) AS t WHERE t.DEPTNO = 10
;Translating sql query: SELECT DEPT0.NAME FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO = 10
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const DEPT (Set (Tuple Int String)))
(declare-const p0 (-> (Tuple Int String) Bool))
(declare-const p1 (-> (Tuple Int String) Bool))
(declare-const p2 (-> (Tuple Int String) Bool))
(assert (= p0 (lambda ((t (Tuple Int String))) (= ((_ tuple.select 0) t) 10))))
(assert (= p1 (lambda ((t (Tuple Int String))) (= ((_ tuple.select 0) t) 10))))
(assert (not (= ((_ rel.project 1) (set.filter p1 ((_ rel.project 0 1) (set.filter p0 DEPT)))) ((_ rel.project 1) (set.filter p2 DEPT)))))
(assert (= p2 (lambda ((t (Tuple Int String))) (= ((_ tuple.select 0) t) 10))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testPushProjectPastSetOp
;Translating sql query: SELECT t.SAL FROM (SELECT * FROM EMP AS EMP UNION ALL SELECT * FROM EMP AS EMP0) AS t
;Translating sql query: SELECT EMP1.SAL FROM EMP AS EMP1 UNION ALL SELECT EMP2.SAL FROM EMP AS EMP2
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(assert (not (= ((_ rel.project 6) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP) ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP))) (set.union ((_ rel.project 6) EMP) ((_ rel.project 6) EMP)))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testMergeMinusRightDeep
;Translating sql query: SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 EXCEPT SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20 EXCEPT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS t2
;Translating sql query: SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 EXCEPT SELECT * FROM (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 EXCEPT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS t7
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p2 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p3 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p4 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p5 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 10))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 20))))
(assert (= p2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 30))))
(assert (= p3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 10))))
(assert (= p4 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 20))))
(assert (not (= (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP))))) (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP))))))))
(assert (= p5 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 30))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testTransitiveInferenceJoin
;Translating sql query: SELECT 1 FROM EMP AS EMP INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 7) AS t ON EMP.DEPTNO = t.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const f6 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) (Tuple Int)))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) Bool))
(declare-const p3 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p4 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p5 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) Bool))
(declare-const f2 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) (Tuple Int)))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 7))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))
(assert (= f2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (tuple 1))))
(assert (= p3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 7))))
(assert (= p4 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 7))))
(assert (not (= (set.map f2 (set.filter p1 (rel.product EMP ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))) (set.map f6 (set.filter p5 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))))))))
(assert (= p5 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))
(assert (= f6 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (tuple 1))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testTransitiveInferenceConstantEquiPredicate
;Translating sql query: SELECT 1 FROM EMP AS EMP INNER JOIN EMP AS EMP0 ON EMP.DEPTNO = EMP0.DEPTNO
;Translating sql query: SELECT 1 FROM EMP AS EMP1 INNER JOIN EMP AS EMP2 ON EMP1.DEPTNO = EMP2.DEPTNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) Bool))
(declare-const p2 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) Bool))
(declare-const f1 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) (Tuple Int)))
(declare-const f3 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) (Tuple Int)))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))
(assert (= f1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (tuple 1))))
(assert (not (= (set.map f1 (set.filter p0 (rel.product EMP EMP))) (set.map f3 (set.filter p2 (rel.product EMP EMP))))))
(assert (= p2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))
(assert (= f3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (tuple 1))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testPushFilterThroughSemiJoin
;Translating sql query: SELECT * FROM DEPT AS DEPT INNER JOIN (SELECT EMP.DEPTNO FROM EMP AS EMP) AS t ON DEPT.DEPTNO = t.DEPTNO WHERE DEPT.DEPTNO <= 10
;Translating sql query: SELECT * FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO <= 10) AS t1 INNER JOIN (SELECT EMP0.DEPTNO FROM EMP AS EMP0) AS t2 ON t1.DEPTNO = t2.DEPTNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const DEPT (Set (Tuple Int String)))
(declare-const p0 (-> (Tuple Int String Int) Bool))
(declare-const p1 (-> (Tuple Int String Int) Bool))
(declare-const p2 (-> (Tuple Int String) Bool))
(declare-const p3 (-> (Tuple Int String Int) Bool))
(assert (= p0 (lambda ((t (Tuple Int String Int))) (= ((_ tuple.select 0) t) ((_ tuple.select 2) t)))))
(assert (= p1 (lambda ((t (Tuple Int String Int))) (<= ((_ tuple.select 0) t) 10))))
(assert (= p2 (lambda ((t (Tuple Int String))) (<= ((_ tuple.select 0) t) 10))))
(assert (not (= ((_ rel.project 0 1 2) (set.filter p1 (set.filter p0 (rel.product DEPT ((_ rel.project 7) EMP))))) ((_ rel.project 0 1 2) (set.filter p3 (rel.product ((_ rel.project 0 1) (set.filter p2 DEPT)) ((_ rel.project 7) EMP)))))))
(assert (= p3 (lambda ((t (Tuple Int String Int))) (= ((_ tuple.select 0) t) ((_ tuple.select 2) t)))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testTransitiveInferenceUnion3way
;Translating sql query: SELECT 1 FROM (SELECT * FROM (SELECT EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO > 7 UNION ALL SELECT EMP0.DEPTNO FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 10) AS t3 UNION ALL SELECT EMP1.DEPTNO FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 1) AS t6 INNER JOIN EMP AS EMP2 ON t6.DEPTNO = EMP2.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT * FROM (SELECT EMP3.DEPTNO FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 7 UNION ALL SELECT EMP4.DEPTNO FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 10) AS t12 UNION ALL SELECT EMP5.DEPTNO FROM EMP AS EMP5 WHERE EMP5.DEPTNO > 1) AS t15 INNER JOIN (SELECT * FROM EMP AS EMP6 WHERE EMP6.DEPTNO > 7 OR EMP6.DEPTNO > 10 OR EMP6.DEPTNO > 1) AS t16 ON t15.DEPTNO = t16.DEPTNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p2 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p3 (-> (Tuple Int Int String String Int Int Int Int Int Int) Bool))
(declare-const f10 (-> (Tuple Int Int String String Int Int Int Int Int Int) (Tuple Int)))
(declare-const p5 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p6 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p7 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p8 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p9 (-> (Tuple Int Int String String Int Int Int Int Int Int) Bool))
(declare-const f4 (-> (Tuple Int Int String String Int Int Int Int Int Int) (Tuple Int)))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 7))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 10))))
(assert (= p2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 1))))
(assert (= p3 (lambda ((t (Tuple Int Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))
(assert (= f4 (lambda ((t (Tuple Int Int String String Int Int Int Int Int Int))) (tuple 1))))
(assert (= p5 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 7))))
(assert (= p6 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 10))))
(assert (= p7 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 1))))
(assert (= p8 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (or (> ((_ tuple.select 7) t) 7) (> ((_ tuple.select 7) t) 10) (> ((_ tuple.select 7) t) 1)))))
(assert (not (= (set.map f4 (set.filter p3 (rel.product (set.union ((_ rel.project 0) (set.union ((_ rel.project 7) (set.filter p0 EMP)) ((_ rel.project 7) (set.filter p1 EMP)))) ((_ rel.project 7) (set.filter p2 EMP))) EMP))) (set.map f10 (set.filter p9 (rel.product (set.union ((_ rel.project 0) (set.union ((_ rel.project 7) (set.filter p5 EMP)) ((_ rel.project 7) (set.filter p6 EMP)))) ((_ rel.project 7) (set.filter p7 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p8 EMP))))))))
(assert (= p9 (lambda ((t (Tuple Int Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))
(assert (= f10 (lambda ((t (Tuple Int Int String String Int Int Int Int Int Int))) (tuple 1))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testPushJoinThroughUnionOnRight
;Translating sql query: SELECT EMP.SAL FROM EMP AS EMP, (SELECT * FROM EMP AS EMP0 UNION ALL SELECT * FROM EMP AS EMP1) AS t
;Translating sql query: SELECT t1.SAL FROM (SELECT * FROM EMP AS EMP2, EMP AS EMP3 UNION ALL SELECT * FROM EMP AS EMP4, EMP AS EMP5) AS t1
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(assert (not (= ((_ rel.project 6) (rel.product EMP (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP) ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP)))) ((_ rel.project 6) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) (rel.product EMP EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) (rel.product EMP EMP)))))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testMergeUnionAll
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION ALL SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION ALL SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
;Translating sql query: SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 UNION ALL SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION ALL SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p2 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p3 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p4 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p5 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 10))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 20))))
(assert (= p2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 30))))
(assert (= p3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 10))))
(assert (= p4 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 20))))
(assert (not (= (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP))) (set.union (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP))))))
(assert (= p5 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 30))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testMergeJoinFilter
;Translating sql query: SELECT * FROM (SELECT DEPT.DEPTNO, EMP.ENAME FROM EMP AS EMP INNER JOIN DEPT AS DEPT ON EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = 10) AS t WHERE t.DEPTNO = 10
;Translating sql query: SELECT t1.DEPTNO, EMP0.ENAME FROM EMP AS EMP0 INNER JOIN (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO = 10) AS t1 ON EMP0.DEPTNO = t1.DEPTNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const DEPT (Set (Tuple Int String)))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int Int String Int) Bool))
(declare-const p2 (-> (Tuple Int String) Bool))
(declare-const p3 (-> (Tuple Int String) Bool))
(declare-const p4 (-> (Tuple Int String String Int Int Int Int Int Int Int String) Bool))
(declare-const f0 (-> (Tuple Int String) (Tuple Int String Int)))
(assert (= f0 (lambda ((t (Tuple Int String))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String Int))) (and (= ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (= ((_ tuple.select 11) t) 10)))))
(assert (= p2 (lambda ((t (Tuple Int String))) (= ((_ tuple.select 0) t) 10))))
(assert (= p3 (lambda ((t (Tuple Int String))) (= ((_ tuple.select 0) t) 10))))
(assert (not (= ((_ rel.project 0 1) (set.filter p2 ((_ rel.project 9 1) (set.filter p1 (rel.product EMP (set.map f0 DEPT)))))) ((_ rel.project 9 1) (set.filter p4 (rel.product EMP ((_ rel.project 0 1) (set.filter p3 DEPT))))))))
(assert (= p4 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String))) (= ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testMergeUnionDistinct
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
;Translating sql query: SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p2 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p3 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p4 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p5 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 10))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 20))))
(assert (= p2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 30))))
(assert (= p3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 10))))
(assert (= p4 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 20))))
(assert (not (= (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP))) (set.union (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP))))))
(assert (= p5 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 30))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testTransitiveInferenceNoPullUpExprs
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 OR EMP.DEPTNO = 9 OR EMP.COMM > 10) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 7 OR EMP1.DEPTNO = 9 OR EMP1.COMM > 10) AS t1 INNER JOIN EMP AS EMP2 ON t1.DEPTNO = EMP2.DEPTNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) Bool))
(declare-const p3 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p4 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) Bool))
(declare-const f2 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) (Tuple Int)))
(declare-const f5 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) (Tuple Int)))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (or (= ((_ tuple.select 7) t) 7) (= ((_ tuple.select 7) t) 9) (> ((_ tuple.select 5) t) 10)))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))
(assert (= f2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (tuple 1))))
(assert (= p3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (or (= ((_ tuple.select 7) t) 7) (= ((_ tuple.select 7) t) 9) (> ((_ tuple.select 5) t) 10)))))
(assert (not (= (set.map f2 (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) EMP))) (set.map f5 (set.filter p4 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) EMP))))))
(assert (= p4 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))
(assert (= f5 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (tuple 1))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testTransitiveInferenceConjunctInPullUp
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 OR EMP.DEPTNO = 9 OR EMP.DEPTNO > 10) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 7 OR EMP1.DEPTNO = 9 OR EMP1.DEPTNO > 10) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 7 OR EMP2.DEPTNO = 9 OR EMP2.DEPTNO > 10) AS t2 ON t1.DEPTNO = t2.DEPTNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const f6 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) (Tuple Int)))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) Bool))
(declare-const p3 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p4 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p5 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) Bool))
(declare-const f2 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) (Tuple Int)))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (or (= ((_ tuple.select 7) t) 7) (= ((_ tuple.select 7) t) 9) (> ((_ tuple.select 7) t) 10)))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))
(assert (= f2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (tuple 1))))
(assert (= p3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (or (= ((_ tuple.select 7) t) 7) (= ((_ tuple.select 7) t) 9) (> ((_ tuple.select 7) t) 10)))))
(assert (= p4 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (or (= ((_ tuple.select 7) t) 7) (= ((_ tuple.select 7) t) 9) (> ((_ tuple.select 7) t) 10)))))
(assert (not (= (set.map f2 (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) EMP))) (set.map f6 (set.filter p5 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))))))))
(assert (= p5 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))
(assert (= f6 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (tuple 1))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testPushSemiJoinPastFilter
;Translating sql query: SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME = 'foo'
;Translating sql query: SELECT t1.ENAME FROM (SELECT EMP0.DEPTNO,EMP0.ENAME FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO WHERE EMP0.ENAME = 'foo') AS t1 INNER JOIN DEPT AS DEPT1 ON t1.DEPTNO = DEPT1.DEPTNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const DEPT (Set (Tuple Int String)))
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int Int String) Bool))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int Int String) Bool))
(declare-const p2 (-> (Tuple Int String String Int Int Int Int Int Int Int String) Bool))
(declare-const p3 (-> (Tuple Int String Int String) Bool))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String))) (and (= ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (= ((_ tuple.select 1) t) "foo")))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String))) (= ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))
(assert (= p2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String))) (= ((_ tuple.select 1) t) "foo"))))
(assert (not (= ((_ rel.project 1) (set.filter p0 (rel.product EMP DEPT))) ((_ rel.project 1) (set.filter p3 (rel.product ((_ rel.project 7 1) (set.filter p2 (set.filter p1 (rel.product EMP DEPT)))) DEPT))))))
(assert (= p3 (lambda ((t (Tuple Int String Int String))) (= ((_ tuple.select 0) t) ((_ tuple.select 2) t)))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testPullConstantIntoFilter
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10) AS t WHERE t.DEPTNO + 5 > t.EMPNO
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 10) AS t1 WHERE 15 > t1.EMPNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p2 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p3 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 10))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> (+ ((_ tuple.select 7) t) 5) ((_ tuple.select 0) t)))))
(assert (= p2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 10))))
(assert (not (= ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))))
(assert (= p3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> 15 ((_ tuple.select 0) t)))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testTransitiveInferencePullUpThruAlias
;Translating sql query: SELECT 1 FROM (SELECT EMP.COMM AS DEPTNO FROM EMP AS EMP WHERE EMP.COMM > 7) AS t0 INNER JOIN EMP AS EMP0 ON t0.DEPTNO = EMP0.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT EMP1.COMM AS DEPTNO FROM EMP AS EMP1 WHERE EMP1.COMM > 7) AS t3 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t4 ON t3.DEPTNO = t4.DEPTNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const f6 (-> (Tuple Int Int String String Int Int Int Int Int Int) (Tuple Int)))
(declare-const p1 (-> (Tuple Int Int String String Int Int Int Int Int Int) Bool))
(declare-const p3 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p4 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p5 (-> (Tuple Int Int String String Int Int Int Int Int Int) Bool))
(declare-const f2 (-> (Tuple Int Int String String Int Int Int Int Int Int) (Tuple Int)))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 5) t) 7))))
(assert (= p1 (lambda ((t (Tuple Int Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))
(assert (= f2 (lambda ((t (Tuple Int Int String String Int Int Int Int Int Int))) (tuple 1))))
(assert (= p3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 5) t) 7))))
(assert (= p4 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 7))))
(assert (not (= (set.map f2 (set.filter p1 (rel.product ((_ rel.project 5) (set.filter p0 EMP)) EMP))) (set.map f6 (set.filter p5 (rel.product ((_ rel.project 5) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))))))))
(assert (= p5 (lambda ((t (Tuple Int Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))
(assert (= f6 (lambda ((t (Tuple Int Int String String Int Int Int Int Int Int))) (tuple 1))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testMergeSetOpMixed
;Translating sql query: SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS t2
;Translating sql query: SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 UNION SELECT * FROM (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS t7
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p2 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p3 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p4 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p5 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 10))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 20))))
(assert (= p2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 30))))
(assert (= p3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 10))))
(assert (= p4 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 20))))
(assert (not (= (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.inter ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP))))) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.inter ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP))))))))
(assert (= p5 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 30))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testTransitiveInferenceUnionAlwaysTrue
;Translating sql query: SELECT * FROM (SELECT EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO < 4) AS t0 INNER JOIN (SELECT EMP0.DEPTNO FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 7 UNION ALL SELECT EMP1.DEPTNO FROM EMP AS EMP1) AS t4 ON t0.DEPTNO = t4.DEPTNO
;Translating sql query: SELECT * FROM (SELECT EMP2.DEPTNO FROM EMP AS EMP2 WHERE EMP2.DEPTNO < 4) AS t6 INNER JOIN (SELECT * FROM (SELECT EMP3.DEPTNO FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 7 UNION ALL SELECT EMP4.DEPTNO FROM EMP AS EMP4) AS t10 WHERE t10.DEPTNO < 4) AS t11 ON t6.DEPTNO = t11.DEPTNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p2 (-> (Tuple Int Int) Bool))
(declare-const p3 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p4 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p5 (-> (Tuple Int) Bool))
(declare-const p6 (-> (Tuple Int Int) Bool))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (< ((_ tuple.select 7) t) 4))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 7))))
(assert (= p2 (lambda ((t (Tuple Int Int))) (= ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= p3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (< ((_ tuple.select 7) t) 4))))
(assert (= p4 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 7))))
(assert (= p5 (lambda ((t (Tuple Int))) (< ((_ tuple.select 0) t) 4))))
(assert (not (= ((_ rel.project 0 1) (set.filter p2 (rel.product ((_ rel.project 7) (set.filter p0 EMP)) (set.union ((_ rel.project 7) (set.filter p1 EMP)) ((_ rel.project 7) EMP))))) ((_ rel.project 0 1) (set.filter p6 (rel.product ((_ rel.project 7) (set.filter p3 EMP)) ((_ rel.project 0) (set.filter p5 (set.union ((_ rel.project 7) (set.filter p4 EMP)) ((_ rel.project 7) EMP))))))))))
(assert (= p6 (lambda ((t (Tuple Int Int))) (= ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testMergeIntersect
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 INTERSECT SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 INTERSECT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
;Translating sql query: SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 INTERSECT SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p2 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p3 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p4 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p5 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 10))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 20))))
(assert (= p2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 30))))
(assert (= p3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 10))))
(assert (= p4 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 20))))
(assert (not (= (set.inter ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.inter ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP))) (set.inter (set.inter ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP))))))
(assert (= p5 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 30))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testAddRedundantSemiJoinRule
;Translating sql query: SELECT 1 FROM EMP AS EMP INNER JOIN DEPT AS DEPT ON EMP.DEPTNO = DEPT.DEPTNO
;Translating sql query: SELECT 1 FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO INNER JOIN DEPT AS DEPT1 ON EMP0.DEPTNO = DEPT1.DEPTNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const DEPT (Set (Tuple Int String)))
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int Int String) Bool))
(declare-const p2 (-> (Tuple Int String String Int Int Int Int Int Int Int String) Bool))
(declare-const p3 (-> (Tuple Int String String Int Int Int Int Int Int Int String Int String) Bool))
(declare-const f1 (-> (Tuple Int String String Int Int Int Int Int Int Int String) (Tuple Int)))
(declare-const f4 (-> (Tuple Int String String Int Int Int Int Int Int Int String Int String) (Tuple Int)))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String))) (= ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))
(assert (= f1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String))) (tuple 1))))
(assert (= p2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String))) (= ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))
(assert (not (= (set.map f1 (set.filter p0 (rel.product EMP DEPT))) (set.map f4 (set.filter p3 (rel.product (set.filter p2 (rel.product EMP DEPT)) DEPT))))))
(assert (= p3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String Int String))) (= ((_ tuple.select 7) t) ((_ tuple.select 11) t)))))
(assert (= f4 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String Int String))) (tuple 1))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testRemoveSemiJoinWithFilter
;Translating sql query: SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME = 'foo'
;Translating sql query: SELECT t1.ENAME FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.ENAME = 'foo') AS t1 INNER JOIN DEPT AS DEPT0 ON t1.DEPTNO = DEPT0.DEPTNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const DEPT (Set (Tuple Int String)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int Int String) Bool))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p2 (-> (Tuple Int String String Int Int Int Int Int Int Int String) Bool))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String))) (and (= ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (= ((_ tuple.select 1) t) "foo")))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 1) t) "foo"))))
(assert (not (= ((_ rel.project 1) (set.filter p0 (rel.product EMP DEPT))) ((_ rel.project 1) (set.filter p2 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)) DEPT))))))
(assert (= p2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String))) (= ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testRemoveSemiJoinRightWithFilter
;Translating sql query: SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = EMP0.DEPTNO AND DEPT.NAME = 'foo'
;Translating sql query: SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'foo') AS t1 ON EMP1.DEPTNO = t1.DEPTNO INNER JOIN EMP AS EMP2 ON t1.DEPTNO = EMP2.DEPTNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const DEPT (Set (Tuple Int String)))
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int Int String Int String String Int Int Int Int Int Int) Bool))
(declare-const p1 (-> (Tuple Int String) Bool))
(declare-const p2 (-> (Tuple Int String String Int Int Int Int Int Int Int String) Bool))
(declare-const p3 (-> (Tuple Int String String Int Int Int Int Int Int Int String Int String String Int Int Int Int Int Int) Bool))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String Int String String Int Int Int Int Int Int))) (and (= ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (= ((_ tuple.select 9) t) ((_ tuple.select 18) t)) (= ((_ tuple.select 10) t) "foo")))))
(assert (= p1 (lambda ((t (Tuple Int String))) (= ((_ tuple.select 1) t) "foo"))))
(assert (= p2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String))) (= ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))
(assert (not (= ((_ rel.project 1) (set.filter p0 (rel.product (rel.product EMP DEPT) EMP))) ((_ rel.project 1) (set.filter p3 (rel.product (set.filter p2 (rel.product EMP ((_ rel.project 0 1) (set.filter p1 DEPT)))) EMP))))))
(assert (= p3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 9) t) ((_ tuple.select 18) t)))))
(check-sat)
;answer: unknown (TIMEOUT)
;-----------------------------------------------------------
; test name: testTransitiveInferenceUnion
;Translating sql query: SELECT 1 FROM (SELECT EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO > 7 UNION ALL SELECT EMP0.DEPTNO FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 10) AS t3 INNER JOIN EMP AS EMP1 ON t3.DEPTNO = EMP1.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT EMP2.DEPTNO FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7 UNION ALL SELECT EMP3.DEPTNO FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 10) AS t9 INNER JOIN (SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 7 OR EMP4.DEPTNO > 10) AS t10 ON t9.DEPTNO = t10.DEPTNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p2 (-> (Tuple Int Int String String Int Int Int Int Int Int) Bool))
(declare-const f8 (-> (Tuple Int Int String String Int Int Int Int Int Int) (Tuple Int)))
(declare-const p4 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p5 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p6 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p7 (-> (Tuple Int Int String String Int Int Int Int Int Int) Bool))
(declare-const f3 (-> (Tuple Int Int String String Int Int Int Int Int Int) (Tuple Int)))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 7))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 10))))
(assert (= p2 (lambda ((t (Tuple Int Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))
(assert (= f3 (lambda ((t (Tuple Int Int String String Int Int Int Int Int Int))) (tuple 1))))
(assert (= p4 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 7))))
(assert (= p5 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 10))))
(assert (= p6 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (or (> ((_ tuple.select 7) t) 7) (> ((_ tuple.select 7) t) 10)))))
(assert (not (= (set.map f3 (set.filter p2 (rel.product (set.union ((_ rel.project 7) (set.filter p0 EMP)) ((_ rel.project 7) (set.filter p1 EMP))) EMP))) (set.map f8 (set.filter p7 (rel.product (set.union ((_ rel.project 7) (set.filter p4 EMP)) ((_ rel.project 7) (set.filter p5 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 EMP))))))))
(assert (= p7 (lambda ((t (Tuple Int Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))
(assert (= f8 (lambda ((t (Tuple Int Int String String Int Int Int Int Int Int))) (tuple 1))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testPushJoinThroughUnionOnLeft
;Translating sql query: SELECT t.SAL FROM (SELECT * FROM EMP AS EMP UNION ALL SELECT * FROM EMP AS EMP0) AS t, EMP AS EMP1
;Translating sql query: SELECT t1.SAL FROM (SELECT * FROM EMP AS EMP2, EMP AS EMP3 UNION ALL SELECT * FROM EMP AS EMP4, EMP AS EMP5) AS t1
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(assert (not (= ((_ rel.project 6) (rel.product (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP) ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP)) EMP)) ((_ rel.project 6) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) (rel.product EMP EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) (rel.product EMP EMP)))))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testMergeUnionMixed2
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION ALL SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
;Translating sql query: SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p2 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p3 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p4 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p5 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 10))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 20))))
(assert (= p2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 30))))
(assert (= p3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 10))))
(assert (= p4 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 20))))
(assert (not (= (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP))) (set.union (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP))))))
(assert (= p5 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 30))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testPushProjectPastFilter2*
;Translating sql query: SELECT EMP.MGR FROM EMP AS EMP WHERE CASE WHEN EMP.MGR < 10 THEN TRUE ELSE FALSE END
;Translating sql query: SELECT * FROM (SELECT EMP0.MGR FROM EMP AS EMP0) AS t2 WHERE t2.MGR < 10
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p1 (-> (Tuple Int) Bool))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (ite (< ((_ tuple.select 3) t) 10) true false))))
(assert (not (= ((_ rel.project 3) (set.filter p0 EMP)) ((_ rel.project 0) (set.filter p1 ((_ rel.project 3) EMP))))))
(assert (= p1 (lambda ((t (Tuple Int))) (< ((_ tuple.select 0) t) 10))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testSemiJoinReduceConstants
;Translating sql query: SELECT t0.SAL FROM (SELECT * FROM (SELECT EMP.SAL, EMP.DEPTNO FROM EMP AS EMP) AS t WHERE t.DEPTNO = 200) AS t0 INNER JOIN (SELECT t1.DEPTNO FROM (SELECT EMP0.SAL, EMP0.DEPTNO FROM EMP AS EMP0) AS t1 WHERE t1.SAL = 100) AS t3 ON t0.DEPTNO = t3.DEPTNO
;Translating sql query: SELECT t6.SAL FROM (SELECT * FROM (SELECT EMP1.SAL, EMP1.DEPTNO FROM EMP AS EMP1) AS t5 WHERE t5.DEPTNO = 200) AS t6 INNER JOIN (SELECT t7.DEPTNO FROM (SELECT EMP2.SAL, EMP2.DEPTNO FROM EMP AS EMP2) AS t7 WHERE t7.SAL = 100) AS t9 ON t6.DEPTNO = t9.DEPTNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int Int) Bool))
(declare-const p1 (-> (Tuple Int Int) Bool))
(declare-const p2 (-> (Tuple Int Int Int) Bool))
(declare-const p3 (-> (Tuple Int Int) Bool))
(declare-const p4 (-> (Tuple Int Int) Bool))
(declare-const p5 (-> (Tuple Int Int Int) Bool))
(assert (= p0 (lambda ((t (Tuple Int Int))) (= ((_ tuple.select 1) t) 200))))
(assert (= p1 (lambda ((t (Tuple Int Int))) (= ((_ tuple.select 0) t) 100))))
(assert (= p2 (lambda ((t (Tuple Int Int Int))) (= ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))
(assert (= p3 (lambda ((t (Tuple Int Int))) (= ((_ tuple.select 1) t) 200))))
(assert (= p4 (lambda ((t (Tuple Int Int))) (= ((_ tuple.select 0) t) 100))))
(assert (not (= ((_ rel.project 0) (set.filter p2 (rel.product ((_ rel.project 0 1) (set.filter p0 ((_ rel.project 6 7) EMP))) ((_ rel.project 1) (set.filter p1 ((_ rel.project 6 7) EMP)))))) ((_ rel.project 0) (set.filter p5 (rel.product ((_ rel.project 0 1) (set.filter p3 ((_ rel.project 6 7) EMP))) ((_ rel.project 1) (set.filter p4 ((_ rel.project 6 7) EMP)))))))))
(assert (= p5 (lambda ((t (Tuple Int Int Int))) (= ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testTransitiveInferenceComplexPredicate
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7 AND EMP.COMM = EMP.DEPTNO AND EMP.COMM + EMP.DEPTNO > EMP.COMM / 2) AS t INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL = EMP0.DEPTNO) AS t0 ON t.DEPTNO = t0.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7 AND EMP1.COMM = EMP1.DEPTNO AND EMP1.COMM + EMP1.DEPTNO > EMP1.COMM / 2) AS t2 INNER JOIN (SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.SAL = EMP2.DEPTNO) AS t3 WHERE t3.DEPTNO > 7) AS t4 ON t2.DEPTNO = t4.DEPTNO
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p2 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) Bool))
(declare-const f8 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) (Tuple Int)))
(declare-const p4 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p5 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p6 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p7 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) Bool))
(declare-const f3 (-> (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int) (Tuple Int)))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (and (> ((_ tuple.select 7) t) 7) (= ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (> (+ ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (/ ((_ tuple.select 5) t) 2))))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 6) t) ((_ tuple.select 7) t)))))
(assert (= p2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))
(assert (= f3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (tuple 1))))
(assert (= p4 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (and (> ((_ tuple.select 7) t) 7) (= ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (> (+ ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (/ ((_ tuple.select 5) t) 2))))))
(assert (= p5 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 6) t) ((_ tuple.select 7) t)))))
(assert (= p6 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (> ((_ tuple.select 7) t) 7))))
(assert (not (= (set.map f3 (set.filter p2 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))) (set.map f8 (set.filter p7 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP))))))))))
(assert (= p7 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))
(assert (= f8 (lambda ((t (Tuple Int String String Int Int Int Int Int Int Int String String Int Int Int Int Int Int))) (tuple 1))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testPullConstantThroughUnion2
;Translating sql query: SELECT 2, EMP.DEPTNO, EMP.JOB FROM EMP AS EMP UNION ALL SELECT 1, EMP0.DEPTNO, EMP0.JOB FROM EMP AS EMP0
;Translating sql query: SELECT 2, EMP1.DEPTNO, EMP1.JOB FROM EMP AS EMP1 UNION ALL SELECT 1, EMP2.DEPTNO, EMP2.JOB FROM EMP AS EMP2
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const f0 (-> (Tuple Int String String Int Int Int Int Int Int) (Tuple Int Int String)))
(declare-const f1 (-> (Tuple Int String String Int Int Int Int Int Int) (Tuple Int Int String)))
(declare-const f2 (-> (Tuple Int String String Int Int Int Int Int Int) (Tuple Int Int String)))
(declare-const f3 (-> (Tuple Int String String Int Int Int Int Int Int) (Tuple Int Int String)))
(assert (= f0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (tuple 2 ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (tuple 1 ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (tuple 2 ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (not (= (set.union (set.map f0 EMP) (set.map f1 EMP)) (set.union (set.map f2 EMP) (set.map f3 EMP)))))
(assert (= f3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (tuple 1 ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testPullConstantThroughUnion3
;Translating sql query: SELECT 2, 3 FROM EMP AS EMP UNION ALL SELECT 2, 3 FROM EMP AS EMP0
;Translating sql query: SELECT 2, 3 FROM (SELECT 2 FROM EMP AS EMP1 UNION ALL SELECT 2 FROM EMP AS EMP2) AS t6
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const f0 (-> (Tuple Int String String Int Int Int Int Int Int) (Tuple Int Int)))
(declare-const f1 (-> (Tuple Int String String Int Int Int Int Int Int) (Tuple Int Int)))
(declare-const f2 (-> (Tuple Int String String Int Int Int Int Int Int) (Tuple Int)))
(declare-const f3 (-> (Tuple Int String String Int Int Int Int Int Int) (Tuple Int)))
(declare-const f4 (-> (Tuple Int) (Tuple Int Int)))
(assert (not (= (set.union (set.map f0 EMP) (set.map f1 EMP)) (set.map f4 (set.union (set.map f2 EMP) (set.map f3 EMP))))))
(assert (= f0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (tuple 2 3))))
(assert (= f1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (tuple 2 3))))
(assert (= f2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (tuple 2))))
(assert (= f3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (tuple 2))))
(assert (= f4 (lambda ((t (Tuple Int))) (tuple 2 3))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testMergeUnionMixed
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION ALL SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20) AS t6 UNION ALL SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const EMP (Set (Tuple Int String String Int Int Int Int Int Int)))
(declare-const p0 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p1 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p2 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p3 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p4 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(declare-const p5 (-> (Tuple Int String String Int Int Int Int Int Int) Bool))
(assert (= p0 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 10))))
(assert (= p1 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 20))))
(assert (= p2 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 30))))
(assert (= p3 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 10))))
(assert (= p4 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 20))))
(assert (not (= (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP))) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP))))))
(assert (= p5 (lambda ((t (Tuple Int String String Int Int Int Int Int Int))) (= ((_ tuple.select 7) t) 30))))
(check-sat)
;answer: unsat
