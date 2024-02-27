; parsing query SELECT t.EXPR$0 + t.EXPR$1 + t.EXPR$0 FROM (VALUES  (10, 1),  (30, 3)) AS t WHERE t.EXPR$0 + t.EXPR$1 > 50
; parsing query SELECT * FROM (SELECT * FROM (VALUES (0)) EXCEPT SELECT * FROM (VALUES (0))) AS t3
;-----------------------------------------------------------
; test name: testEmptyProject2
;Translating sql query: SELECT t.EXPR$0 + t.EXPR$1 + t.EXPR$0 FROM (VALUES  (10, 1),  (30, 3)) AS t WHERE t.EXPR$0 + t.EXPR$1 > 50
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES (0)) EXCEPT SELECT * FROM (VALUES (0))) AS t3
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_388 Int) (BOUND_VARIABLE_389 Int)) (> BOUND_VARIABLE_388 BOUND_VARIABLE_389)) (nullable.lift (lambda ((BOUND_VARIABLE_378 Int) (BOUND_VARIABLE_379 Int)) (+ BOUND_VARIABLE_378 BOUND_VARIABLE_379)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_388 Int) (BOUND_VARIABLE_389 Int)) (> BOUND_VARIABLE_388 BOUND_VARIABLE_389)) (nullable.lift (lambda ((BOUND_VARIABLE_378 Int) (BOUND_VARIABLE_379 Int)) (+ BOUND_VARIABLE_378 BOUND_VARIABLE_379)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 50)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_441 Int) (BOUND_VARIABLE_442 Int)) (+ BOUND_VARIABLE_441 BOUND_VARIABLE_442)) (nullable.lift (lambda ((BOUND_VARIABLE_435 Int) (BOUND_VARIABLE_436 Int)) (+ BOUND_VARIABLE_435 BOUND_VARIABLE_436)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 0) t))))))
(assert (= q1 (bag.map f1 (bag.filter p0 (bag.union_disjoint (bag (tuple (nullable.some 10) (nullable.some 1)) 1) (bag (tuple (nullable.some 30) (nullable.some 3)) 1))))))
(assert (= q2 ((_ table.project 0) (bag.difference_remove ((_ table.project 0) (bag (tuple (nullable.some 0)) 1)) ((_ table.project 0) (bag (tuple (nullable.some 0)) 1))))))
(check-sat)
;answer: unsat
; duration: 27 ms.
(reset)
; parsing query SELECT * FROM (SELECT * FROM (VALUES  (10, 1),  (30, 3)) AS t UNION ALL SELECT * FROM (VALUES  (20, 2)) AS t0) AS t1 WHERE t1.EXPR$0 + t1.EXPR$1 > 30
; parsing query SELECT * FROM (VALUES  (30, 3)) AS t3
;-----------------------------------------------------------
; test name: testEmptyFilterProjectUnion
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES  (10, 1),  (30, 3)) AS t UNION ALL SELECT * FROM (VALUES  (20, 2)) AS t0) AS t1 WHERE t1.EXPR$0 + t1.EXPR$1 > 30
;Translating sql query: SELECT * FROM (VALUES  (30, 3)) AS t3
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_599 Int) (BOUND_VARIABLE_600 Int)) (> BOUND_VARIABLE_599 BOUND_VARIABLE_600)) (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (+ BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_599 Int) (BOUND_VARIABLE_600 Int)) (> BOUND_VARIABLE_599 BOUND_VARIABLE_600)) (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (+ BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 30)))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 (bag.union_disjoint ((_ table.project 0 1) (bag.union_disjoint (bag (tuple (nullable.some 10) (nullable.some 1)) 1) (bag (tuple (nullable.some 30) (nullable.some 3)) 1))) ((_ table.project 0 1) (bag (tuple (nullable.some 20) (nullable.some 2)) 1)))))))
(assert (= q2 ((_ table.project 0 1) (bag (tuple (nullable.some 30) (nullable.some 3)) 1))))
(check-sat)
;answer: unsat
; duration: 8 ms.
(reset)
; parsing query SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 AND EMP.EMPNO = 10 AND EMP.MGR IS NULL AND EMP.EMPNO = 10
; parsing query SELECT 10 AS EMPNO, EMP0.ENAME, EMP0.JOB, CAST(NULL AS INT) AS MGR, EMP0.HIREDATE, EMP0.SAL, EMP0.COMM, 7 AS DEPTNO, EMP0.SLACKER FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 7 AND EMP0.MGR IS NULL AND EMP0.EMPNO = 10
;-----------------------------------------------------------
; test name: testPullNull
;Translating sql query: SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 AND EMP.EMPNO = 10 AND EMP.MGR IS NULL AND EMP.EMPNO = 10
;Translating sql query: SELECT 10 AS EMPNO, EMP0.ENAME, EMP0.JOB, CAST(NULL AS INT) AS MGR, EMP0.HIREDATE, EMP0.SAL, EMP0.COMM, 7 AS DEPTNO, EMP0.SLACKER FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 7 AND EMP0.MGR IS NULL AND EMP0.EMPNO = 10
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(and (nullable.is_some
(nullable.some
(or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_818 Int) (BOUND_VARIABLE_819 Int)) (= BOUND_VARIABLE_818 BOUND_VARIABLE_819))
((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_818 Int) (BOUND_VARIABLE_819 Int))
(= BOUND_VARIABLE_818 BOUND_VARIABLE_819)) ((_ tuple.select 7) t) (nullable.some 7)))))
(and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_825 Int) (BOUND_VARIABLE_826 Int)) (= BOUND_VARIABLE_825 BOUND_VARIABLE_826))
((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_825 Int) (BOUND_VARIABLE_826 Int))
(= BOUND_VARIABLE_825 BOUND_VARIABLE_826)) ((_ tuple.select 0) t) (nullable.some 10))))))
(and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_818 Int) (BOUND_VARIABLE_819 Int))
(= BOUND_VARIABLE_818 BOUND_VARIABLE_819)) ((_ tuple.select 7) t) (nullable.some 7)))
(nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_825 Int) (BOUND_VARIABLE_826 Int)) (= BOUND_VARIABLE_825 BOUND_VARIABLE_826)) ((_ tuple.select 0) t) (nullable.some 10))))
(and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_818 Int) (BOUND_VARIABLE_819 Int)) (= BOUND_VARIABLE_818 BOUND_VARIABLE_819)) ((_ tuple.select 7) t) (nullable.some 7)))
(nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_825 Int) (BOUND_VARIABLE_826 Int)) (= BOUND_VARIABLE_825 BOUND_VARIABLE_826)) ((_ tuple.select 0) t) (nullable.some 10))))))))
(nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_818 Int) (BOUND_VARIABLE_819 Int))
(= BOUND_VARIABLE_818 BOUND_VARIABLE_819)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_818 Int) (BOUND_VARIABLE_819 Int))
(= BOUND_VARIABLE_818 BOUND_VARIABLE_819)) ((_ tuple.select 7) t) (nullable.some 7))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_825 Int) (BOUND_VARIABLE_826 Int))
(= BOUND_VARIABLE_825 BOUND_VARIABLE_826)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_825 Int) (BOUND_VARIABLE_826 Int))
(= BOUND_VARIABLE_825 BOUND_VARIABLE_826)) ((_ tuple.select 0) t) (nullable.some 10)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_818 Int) (BOUND_VARIABLE_819 Int)) (= BOUND_VARIABLE_818 BOUND_VARIABLE_819)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_825 Int) (BOUND_VARIABLE_826 Int)) (= BOUND_VARIABLE_825 BOUND_VARIABLE_826)) ((_ tuple.select 0) t) (nullable.some 10)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_818 Int) (BOUND_VARIABLE_819 Int)) (= BOUND_VARIABLE_818 BOUND_VARIABLE_819)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_825 Int) (BOUND_VARIABLE_826 Int)) (= BOUND_VARIABLE_825 BOUND_VARIABLE_826)) ((_ tuple.select 0) t) (nullable.some 10))))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_869 Int) (BOUND_VARIABLE_870 Int)) (= BOUND_VARIABLE_869 BOUND_VARIABLE_870)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_869 Int) (BOUND_VARIABLE_870 Int)) (= BOUND_VARIABLE_869 BOUND_VARIABLE_870)) ((_ tuple.select 7) t) (nullable.some 7))))) (and (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 3) t)))) (not (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 3) t))))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_869 Int) (BOUND_VARIABLE_870 Int)) (= BOUND_VARIABLE_869 BOUND_VARIABLE_870)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 3) t))))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_869 Int) (BOUND_VARIABLE_870 Int)) (= BOUND_VARIABLE_869 BOUND_VARIABLE_870)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 3) t))))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_869 Int) (BOUND_VARIABLE_870 Int)) (= BOUND_VARIABLE_869 BOUND_VARIABLE_870)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_869 Int) (BOUND_VARIABLE_870 Int)) (= BOUND_VARIABLE_869 BOUND_VARIABLE_870)) ((_ tuple.select 7) t) (nullable.some 7))))) (and (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 3) t)))) (not (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 3) t))))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_869 Int) (BOUND_VARIABLE_870 Int)) (= BOUND_VARIABLE_869 BOUND_VARIABLE_870)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 3) t))))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_869 Int) (BOUND_VARIABLE_870 Int)) (= BOUND_VARIABLE_869 BOUND_VARIABLE_870)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 3) t)))))))))))))
(assert (not (= q1 q2)))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 10) ((_ tuple.select 1) t) ((_ tuple.select 2) t) (as nullable.null (Nullable Int)) ((_ tuple.select 4) t) ((_ tuple.select 6) t) ((_ tuple.select 5) t) (nullable.some 7) ((_ tuple.select 8) t)))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 (bag.map f2 (bag.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 178 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 9) (nullable.some "A") (nullable.some "B") (as nullable.null (Nullable Int)) (nullable.some (- 2)) (nullable.some 3) (nullable.some (- 3)) (as nullable.null (Nullable Int)) (nullable.some 4)) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 9) (nullable.some "A") (nullable.some "B") (as nullable.null (Nullable Int)) (nullable.some (- 2)) (nullable.some 3) (nullable.some (- 3)) (as nullable.null (Nullable Int)) (nullable.some 4)) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; insert into EMP values(9,'A','B',NULL,-2,3,-3,NULL,4)
; SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 AND EMP.EMPNO = 10 AND EMP.MGR IS NULL AND EMP.EMPNO = 10) AS q1 EXCEPT ALL SELECT * FROM (SELECT 10 AS EMPNO, EMP0.ENAME, EMP0.JOB, CAST(NULL AS INT) AS MGR, EMP0.HIREDATE, EMP0.SAL, EMP0.COMM, 7 AS DEPTNO, EMP0.SLACKER FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 7 AND EMP0.MGR IS NULL AND EMP0.EMPNO = 10) AS q2;

; SELECT * FROM (SELECT 10 AS EMPNO, EMP0.ENAME, EMP0.JOB, CAST(NULL AS INT) AS MGR, EMP0.HIREDATE, EMP0.SAL, EMP0.COMM, 7 AS DEPTNO, EMP0.SLACKER FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 7 AND EMP0.MGR IS NULL AND EMP0.EMPNO = 10) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 AND EMP.EMPNO = 10 AND EMP.MGR IS NULL AND EMP.EMPNO = 10) AS q1;

;Model soundness: false
(reset)
; parsing query SELECT t.EXPR$0 + t.EXPR$1 AS X, t.EXPR$1 AS B, t.EXPR$0 AS A FROM (VALUES  (10, 1),  (30, 7),  (20, 3)) AS t WHERE t.EXPR$0 - t.EXPR$1 < 21
; parsing query SELECT * FROM (VALUES  (11, 1, 10),  (23, 3, 20)) AS t2
;-----------------------------------------------------------
; test name: testReduceValuesUnderProjectFilter
;Translating sql query: SELECT t.EXPR$0 + t.EXPR$1 AS X, t.EXPR$1 AS B, t.EXPR$0 AS A FROM (VALUES  (10, 1),  (30, 7),  (20, 3)) AS t WHERE t.EXPR$0 - t.EXPR$1 < 21
;Translating sql query: SELECT * FROM (VALUES  (11, 1, 10),  (23, 3, 20)) AS t2
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_4051 Int) (BOUND_VARIABLE_4052 Int)) (< BOUND_VARIABLE_4051 BOUND_VARIABLE_4052)) (nullable.lift (lambda ((BOUND_VARIABLE_4043 Int) (BOUND_VARIABLE_4044 Int)) (- BOUND_VARIABLE_4043 BOUND_VARIABLE_4044)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 21))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_4051 Int) (BOUND_VARIABLE_4052 Int)) (< BOUND_VARIABLE_4051 BOUND_VARIABLE_4052)) (nullable.lift (lambda ((BOUND_VARIABLE_4043 Int) (BOUND_VARIABLE_4044 Int)) (- BOUND_VARIABLE_4043 BOUND_VARIABLE_4044)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 21)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_4087 Int) (BOUND_VARIABLE_4088 Int)) (+ BOUND_VARIABLE_4087 BOUND_VARIABLE_4088)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= q1 (bag.map f1 (bag.filter p0 (bag.union_disjoint (bag.union_disjoint (bag (tuple (nullable.some 10) (nullable.some 1)) 1) (bag (tuple (nullable.some 30) (nullable.some 7)) 1)) (bag (tuple (nullable.some 20) (nullable.some 3)) 1))))))
(assert (= q2 ((_ table.project 0 1 2) (bag.union_disjoint (bag (tuple (nullable.some 11) (nullable.some 1) (nullable.some 10)) 1) (bag (tuple (nullable.some 23) (nullable.some 3) (nullable.some 20)) 1)))))
(check-sat)
;answer: unsat
; duration: 11 ms.
(reset)
; parsing query SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 EXCEPT SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 EXCEPT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
; parsing query SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 EXCEPT SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 EXCEPT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
;-----------------------------------------------------------
; test name: testMergeMinus
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 EXCEPT SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 EXCEPT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
;Translating sql query: SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 EXCEPT SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 EXCEPT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_4271 Int) (BOUND_VARIABLE_4272 Int)) (= BOUND_VARIABLE_4271 BOUND_VARIABLE_4272)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_4271 Int) (BOUND_VARIABLE_4272 Int)) (= BOUND_VARIABLE_4271 BOUND_VARIABLE_4272)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_4290 Int) (BOUND_VARIABLE_4291 Int)) (= BOUND_VARIABLE_4290 BOUND_VARIABLE_4291)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_4290 Int) (BOUND_VARIABLE_4291 Int)) (= BOUND_VARIABLE_4290 BOUND_VARIABLE_4291)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_4311 Int) (BOUND_VARIABLE_4312 Int)) (= BOUND_VARIABLE_4311 BOUND_VARIABLE_4312)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_4311 Int) (BOUND_VARIABLE_4312 Int)) (= BOUND_VARIABLE_4311 BOUND_VARIABLE_4312)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_4331 Int) (BOUND_VARIABLE_4332 Int)) (= BOUND_VARIABLE_4331 BOUND_VARIABLE_4332)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_4331 Int) (BOUND_VARIABLE_4332 Int)) (= BOUND_VARIABLE_4331 BOUND_VARIABLE_4332)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_4350 Int) (BOUND_VARIABLE_4351 Int)) (= BOUND_VARIABLE_4350 BOUND_VARIABLE_4351)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_4350 Int) (BOUND_VARIABLE_4351 Int)) (= BOUND_VARIABLE_4350 BOUND_VARIABLE_4351)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_4370 Int) (BOUND_VARIABLE_4371 Int)) (= BOUND_VARIABLE_4370 BOUND_VARIABLE_4371)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_4370 Int) (BOUND_VARIABLE_4371 Int)) (= BOUND_VARIABLE_4370 BOUND_VARIABLE_4371)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)))))
(assert (= q2 (bag.difference_remove (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)))))
(check-sat)
;answer: unsat
; duration: 517 ms.
(reset)
; parsing query SELECT * FROM (SELECT * FROM (VALUES  (30, 3)) AS t WHERE t.EXPR$0 > 30 EXCEPT SELECT * FROM (VALUES  (20, 2)) AS t1) AS t2 EXCEPT SELECT * FROM (VALUES  (40, 4)) AS t3
; parsing query SELECT * FROM (SELECT * FROM (VALUES  (0, 0)) except SELECT * FROM (VALUES  (0, 0))) AS t5
;-----------------------------------------------------------
; test name: testEmptyMinus
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES  (30, 3)) AS t WHERE t.EXPR$0 > 30 EXCEPT SELECT * FROM (VALUES  (20, 2)) AS t1) AS t2 EXCEPT SELECT * FROM (VALUES  (40, 4)) AS t3
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES  (0, 0)) except SELECT * FROM (VALUES  (0, 0))) AS t5
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_10778 Int) (BOUND_VARIABLE_10779 Int)) (> BOUND_VARIABLE_10778 BOUND_VARIABLE_10779)) ((_ tuple.select 0) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_10778 Int) (BOUND_VARIABLE_10779 Int)) (> BOUND_VARIABLE_10778 BOUND_VARIABLE_10779)) ((_ tuple.select 0) t) (nullable.some 30)))))))
(assert (= q1 (bag.difference_remove ((_ table.project 0 1) (bag.difference_remove ((_ table.project 0 1) (bag.filter p0 (bag (tuple (nullable.some 30) (nullable.some 3)) 1))) ((_ table.project 0 1) (bag (tuple (nullable.some 20) (nullable.some 2)) 1)))) ((_ table.project 0 1) (bag (tuple (nullable.some 40) (nullable.some 4)) 1)))))
(assert (= q2 ((_ table.project 0 1) (bag.difference_remove ((_ table.project 0 1) (bag (tuple (nullable.some 0) (nullable.some 0)) 1)) ((_ table.project 0 1) (bag (tuple (nullable.some 0) (nullable.some 0)) 1))))))
(check-sat)
;answer: unsat
; duration: 11 ms.
(reset)
; parsing query SELECT t.EXPR$0 + t.EXPR$1 FROM (VALUES  (10, 1),  (20, 3)) AS t
; parsing query SELECT * FROM (VALUES  (11),  (23)) AS t1
;-----------------------------------------------------------
; test name: testReduceValuesUnderProject
;Translating sql query: SELECT t.EXPR$0 + t.EXPR$1 FROM (VALUES  (10, 1),  (20, 3)) AS t
;Translating sql query: SELECT * FROM (VALUES  (11),  (23)) AS t1
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_10898 Int) (BOUND_VARIABLE_10899 Int)) (+ BOUND_VARIABLE_10898 BOUND_VARIABLE_10899)) ((_ tuple.select 0) t) ((_ tuple.select 1) t))))))
(assert (= q1 (bag.map f0 (bag.union_disjoint (bag (tuple (nullable.some 10) (nullable.some 1)) 1) (bag (tuple (nullable.some 20) (nullable.some 3)) 1)))))
(assert (= q2 ((_ table.project 0) (bag.union_disjoint (bag (tuple (nullable.some 11)) 1) (bag (tuple (nullable.some 23)) 1)))))
(check-sat)
;answer: unsat
; duration: 4 ms.
(reset)
; parsing query SELECT * FROM (VALUES  (10, 'x'),  (20, 'y')) AS t WHERE t.EXPR$0 < 15
; parsing query SELECT * FROM (VALUES  (10, 'x')) AS t1
;-----------------------------------------------------------
; test name: testReduceValuesUnderFilter
;Translating sql query: SELECT * FROM (VALUES  (10, 'x'),  (20, 'y')) AS t WHERE t.EXPR$0 < 15
;Translating sql query: SELECT * FROM (VALUES  (10, 'x')) AS t1
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_10994 Int) (BOUND_VARIABLE_10995 Int)) (< BOUND_VARIABLE_10994 BOUND_VARIABLE_10995)) ((_ tuple.select 0) t) (nullable.some 15))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_10994 Int) (BOUND_VARIABLE_10995 Int)) (< BOUND_VARIABLE_10994 BOUND_VARIABLE_10995)) ((_ tuple.select 0) t) (nullable.some 15)))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 (bag.union_disjoint (bag (tuple (nullable.some 10) (nullable.some "x")) 1) (bag (tuple (nullable.some 20) (nullable.some "y")) 1))))))
(assert (= q2 ((_ table.project 0 1) (bag (tuple (nullable.some 10) (nullable.some "x")) 1))))
(check-sat)
;answer: unsat
; duration: 5 ms.
(reset)
; parsing query SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE DEPT.DEPTNO = 7 AND DEPT.DEPTNO = 8
; parsing query SELECT t1.EXPR$0 FROM (SELECT * FROM (VALUES(0, 0)) EXCEPT SELECT * FROM (VALUES(0, 0))) AS t1
;-----------------------------------------------------------
; test name: testReduceConstantsDup
;Translating sql query: SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE DEPT.DEPTNO = 7 AND DEPT.DEPTNO = 8
;Translating sql query: SELECT t1.EXPR$0 FROM (SELECT * FROM (VALUES(0, 0)) EXCEPT SELECT * FROM (VALUES(0, 0))) AS t1
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_11099 Int) (BOUND_VARIABLE_11100 Int)) (= BOUND_VARIABLE_11099 BOUND_VARIABLE_11100)) ((_ tuple.select 0) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_11099 Int) (BOUND_VARIABLE_11100 Int)) (= BOUND_VARIABLE_11099 BOUND_VARIABLE_11100)) ((_ tuple.select 0) t) (nullable.some 7))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_11106 Int) (BOUND_VARIABLE_11107 Int)) (= BOUND_VARIABLE_11106 BOUND_VARIABLE_11107)) ((_ tuple.select 0) t) (nullable.some 8))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_11106 Int) (BOUND_VARIABLE_11107 Int)) (= BOUND_VARIABLE_11106 BOUND_VARIABLE_11107)) ((_ tuple.select 0) t) (nullable.some 8)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_11099 Int) (BOUND_VARIABLE_11100 Int)) (= BOUND_VARIABLE_11099 BOUND_VARIABLE_11100)) ((_ tuple.select 0) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_11106 Int) (BOUND_VARIABLE_11107 Int)) (= BOUND_VARIABLE_11106 BOUND_VARIABLE_11107)) ((_ tuple.select 0) t) (nullable.some 8)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_11099 Int) (BOUND_VARIABLE_11100 Int)) (= BOUND_VARIABLE_11099 BOUND_VARIABLE_11100)) ((_ tuple.select 0) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_11106 Int) (BOUND_VARIABLE_11107 Int)) (= BOUND_VARIABLE_11106 BOUND_VARIABLE_11107)) ((_ tuple.select 0) t) (nullable.some 8)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_11099 Int) (BOUND_VARIABLE_11100 Int)) (= BOUND_VARIABLE_11099 BOUND_VARIABLE_11100)) ((_ tuple.select 0) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_11099 Int) (BOUND_VARIABLE_11100 Int)) (= BOUND_VARIABLE_11099 BOUND_VARIABLE_11100)) ((_ tuple.select 0) t) (nullable.some 7))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_11106 Int) (BOUND_VARIABLE_11107 Int)) (= BOUND_VARIABLE_11106 BOUND_VARIABLE_11107)) ((_ tuple.select 0) t) (nullable.some 8))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_11106 Int) (BOUND_VARIABLE_11107 Int)) (= BOUND_VARIABLE_11106 BOUND_VARIABLE_11107)) ((_ tuple.select 0) t) (nullable.some 8)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_11099 Int) (BOUND_VARIABLE_11100 Int)) (= BOUND_VARIABLE_11099 BOUND_VARIABLE_11100)) ((_ tuple.select 0) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_11106 Int) (BOUND_VARIABLE_11107 Int)) (= BOUND_VARIABLE_11106 BOUND_VARIABLE_11107)) ((_ tuple.select 0) t) (nullable.some 8)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_11099 Int) (BOUND_VARIABLE_11100 Int)) (= BOUND_VARIABLE_11099 BOUND_VARIABLE_11100)) ((_ tuple.select 0) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_11106 Int) (BOUND_VARIABLE_11107 Int)) (= BOUND_VARIABLE_11106 BOUND_VARIABLE_11107)) ((_ tuple.select 0) t) (nullable.some 8))))))))))))
(assert (= q1 ((_ table.project 0) (bag.filter p0 DEPT))))
(assert (= q2 ((_ table.project 0) (bag.difference_remove ((_ table.project 0 1) (bag (tuple (nullable.some 0) (nullable.some 0)) 1)) ((_ table.project 0 1) (bag (tuple (nullable.some 0) (nullable.some 0)) 1))))))
(check-sat)
;answer: sat
; duration: 50 ms.
(get-model)
; (
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 7) (as nullable.null (Nullable String))) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 7)) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; insert into DEPT values(7,NULL)
; SELECT * FROM (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE DEPT.DEPTNO = 7 AND DEPT.DEPTNO = 8) AS q1 EXCEPT ALL SELECT * FROM (SELECT t1.column1 FROM (SELECT * FROM (VALUES(0, 0)) EXCEPT SELECT * FROM (VALUES(0, 0))) AS t1) AS q2;

; SELECT * FROM (SELECT t1.column1 FROM (SELECT * FROM (VALUES(0, 0)) EXCEPT SELECT * FROM (VALUES(0, 0))) AS t1) AS q2 EXCEPT ALL SELECT * FROM (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE DEPT.DEPTNO = 7 AND DEPT.DEPTNO = 8) AS q1;

;Model soundness: false
(reset)
; parsing query SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO
; parsing query SELECT EMP0.ENAME FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO
;-----------------------------------------------------------
; test name: testRemoveSemiJoin
;Translating sql query: SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO
;Translating sql query: SELECT EMP0.ENAME FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Bag (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_12179 Int) (BOUND_VARIABLE_12180 Int)) (= BOUND_VARIABLE_12179 BOUND_VARIABLE_12180)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_12179 Int) (BOUND_VARIABLE_12180 Int)) (= BOUND_VARIABLE_12179 BOUND_VARIABLE_12180)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_12213 Int) (BOUND_VARIABLE_12214 Int)) (= BOUND_VARIABLE_12213 BOUND_VARIABLE_12214)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_12213 Int) (BOUND_VARIABLE_12214 Int)) (= BOUND_VARIABLE_12213 BOUND_VARIABLE_12214)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ table.project 1) (bag.filter p0 (table.product EMP DEPT)))))
(assert (= q2 ((_ table.project 1) (bag.filter p1 (table.product EMP DEPT)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10010 ms.
(reset)
; parsing query SELECT 2, EMP.DEPTNO, EMP.JOB FROM EMP AS EMP UNION ALL SELECT 2, EMP0.DEPTNO, EMP0.JOB FROM EMP AS EMP0
; parsing query SELECT 2, t6.DEPTNO, t6.JOB FROM (SELECT EMP1.DEPTNO, EMP1.JOB FROM EMP AS EMP1 UNION ALL SELECT EMP2.DEPTNO, EMP2.JOB FROM EMP AS EMP2) AS t6
;-----------------------------------------------------------
; test name: testPullConstantThroughUnion
;Translating sql query: SELECT 2, EMP.DEPTNO, EMP.JOB FROM EMP AS EMP UNION ALL SELECT 2, EMP0.DEPTNO, EMP0.JOB FROM EMP AS EMP0
;Translating sql query: SELECT 2, t6.DEPTNO, t6.JOB FROM (SELECT EMP1.DEPTNO, EMP1.JOB FROM EMP AS EMP1 UNION ALL SELECT EMP2.DEPTNO, EMP2.JOB FROM EMP AS EMP2) AS t6
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (not (= q1 q2)))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.some 2) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= q1 (bag.union_disjoint (bag.map f0 EMP) (bag.map f1 EMP))))
(assert (= q2 (bag.map f2 (bag.union_disjoint ((_ table.project 7 2) EMP) ((_ table.project 7 2) EMP)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10110 ms.
(reset)
; parsing query SELECT * FROM (SELECT CASE WHEN EMP.SAL > 1000 THEN NULL ELSE FALSE END AS CASECOL FROM EMP AS EMP) AS t WHERE NOT t.CASECOL
; parsing query SELECT * FROM (SELECT CASE WHEN EMP0.SAL > 1000 THEN NULL ELSE FALSE END AS CASECOL FROM EMP AS EMP0) AS t1 WHERE NOT t1.CASECOL
;-----------------------------------------------------------
; test name: testReduceNot
;Translating sql query: SELECT * FROM (SELECT CASE WHEN EMP.SAL > 1000 THEN NULL ELSE FALSE END AS CASECOL FROM EMP AS EMP) AS t WHERE NOT t.CASECOL
;Translating sql query: SELECT * FROM (SELECT CASE WHEN EMP0.SAL > 1000 THEN NULL ELSE FALSE END AS CASECOL FROM EMP AS EMP0) AS t1 WHERE NOT t1.CASECOL
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Bool))))
(declare-const p1 (-> (Tuple (Nullable Bool)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Bool))))
(declare-const p3 (-> (Tuple (Nullable Bool)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Bool))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Bool))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some (or (or (and (nullable.is_some (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105070 Int) (BOUND_VARIABLE_105071 Int)) (> BOUND_VARIABLE_105070 BOUND_VARIABLE_105071)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105070 Int) (BOUND_VARIABLE_105071 Int)) (> BOUND_VARIABLE_105070 BOUND_VARIABLE_105071)) ((_ tuple.select 6) t) (nullable.some 1000)))))) (not (nullable.val (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105070 Int) (BOUND_VARIABLE_105071 Int)) (> BOUND_VARIABLE_105070 BOUND_VARIABLE_105071)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105070 Int) (BOUND_VARIABLE_105071 Int)) (> BOUND_VARIABLE_105070 BOUND_VARIABLE_105071)) ((_ tuple.select 6) t) (nullable.some 1000)))))))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool)))))) (and (and (nullable.is_some (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105070 Int) (BOUND_VARIABLE_105071 Int)) (> BOUND_VARIABLE_105070 BOUND_VARIABLE_105071)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105070 Int) (BOUND_VARIABLE_105071 Int)) (> BOUND_VARIABLE_105070 BOUND_VARIABLE_105071)) ((_ tuple.select 6) t) (nullable.some 1000)))))) (nullable.is_some (as nullable.null (Nullable Bool)))) (and (nullable.val (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105070 Int) (BOUND_VARIABLE_105071 Int)) (> BOUND_VARIABLE_105070 BOUND_VARIABLE_105071)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105070 Int) (BOUND_VARIABLE_105071 Int)) (> BOUND_VARIABLE_105070 BOUND_VARIABLE_105071)) ((_ tuple.select 6) t) (nullable.some 1000)))))) (nullable.val (as nullable.null (Nullable Bool)))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105107 Bool)) (not BOUND_VARIABLE_105107)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105107 Bool)) (not BOUND_VARIABLE_105107)) ((_ tuple.select 0) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some (or (or (and (nullable.is_some (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105127 Int) (BOUND_VARIABLE_105128 Int)) (> BOUND_VARIABLE_105127 BOUND_VARIABLE_105128)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105127 Int) (BOUND_VARIABLE_105128 Int)) (> BOUND_VARIABLE_105127 BOUND_VARIABLE_105128)) ((_ tuple.select 6) t) (nullable.some 1000)))))) (not (nullable.val (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105127 Int) (BOUND_VARIABLE_105128 Int)) (> BOUND_VARIABLE_105127 BOUND_VARIABLE_105128)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105127 Int) (BOUND_VARIABLE_105128 Int)) (> BOUND_VARIABLE_105127 BOUND_VARIABLE_105128)) ((_ tuple.select 6) t) (nullable.some 1000)))))))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool)))))) (and (and (nullable.is_some (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105127 Int) (BOUND_VARIABLE_105128 Int)) (> BOUND_VARIABLE_105127 BOUND_VARIABLE_105128)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105127 Int) (BOUND_VARIABLE_105128 Int)) (> BOUND_VARIABLE_105127 BOUND_VARIABLE_105128)) ((_ tuple.select 6) t) (nullable.some 1000)))))) (nullable.is_some (as nullable.null (Nullable Bool)))) (and (nullable.val (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105127 Int) (BOUND_VARIABLE_105128 Int)) (> BOUND_VARIABLE_105127 BOUND_VARIABLE_105128)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105127 Int) (BOUND_VARIABLE_105128 Int)) (> BOUND_VARIABLE_105127 BOUND_VARIABLE_105128)) ((_ tuple.select 6) t) (nullable.some 1000)))))) (nullable.val (as nullable.null (Nullable Bool)))))))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105157 Bool)) (not BOUND_VARIABLE_105157)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105157 Bool)) (not BOUND_VARIABLE_105157)) ((_ tuple.select 0) t)))))))
(assert (= q1 ((_ table.project 0) (bag.filter p1 (bag.map f0 EMP)))))
(assert (= q2 ((_ table.project 0) (bag.filter p3 (bag.map f2 EMP)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10113 ms.
(reset)
; parsing query SELECT EMP.SAL FROM EMP AS EMP WHERE EMP.EMPNO IN (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE EMP.JOB = DEPT.NAME)
; parsing query SELECT EMP0.SAL FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.JOB = DEPT0.NAME AND EMP0.EMPNO = DEPT0.DEPTNO
;-----------------------------------------------------------
; test name: testWhereInCorrelated
;Translating sql query: SELECT EMP.SAL FROM EMP AS EMP WHERE EMP.EMPNO IN (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE EMP.JOB = DEPT.NAME)
;Translating sql query: SELECT EMP0.SAL FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.JOB = DEPT0.NAME AND EMP0.EMPNO = DEPT0.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_141127 String) (BOUND_VARIABLE_141128 String)) (= BOUND_VARIABLE_141127 BOUND_VARIABLE_141128)) ((_ tuple.select 2) t) ((_ tuple.select 1) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_141127 String) (BOUND_VARIABLE_141128 String)) (= BOUND_VARIABLE_141127 BOUND_VARIABLE_141128)) ((_ tuple.select 2) t) ((_ tuple.select 1) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_141152 String) (BOUND_VARIABLE_141153 String)) (= BOUND_VARIABLE_141152 BOUND_VARIABLE_141153)) ((_ tuple.select 2) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_141152 String) (BOUND_VARIABLE_141153 String)) (= BOUND_VARIABLE_141152 BOUND_VARIABLE_141153)) ((_ tuple.select 2) t) ((_ tuple.select 10) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_141160 Int) (BOUND_VARIABLE_141161 Int)) (= BOUND_VARIABLE_141160 BOUND_VARIABLE_141161)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_141160 Int) (BOUND_VARIABLE_141161 Int)) (= BOUND_VARIABLE_141160 BOUND_VARIABLE_141161)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_141152 String) (BOUND_VARIABLE_141153 String)) (= BOUND_VARIABLE_141152 BOUND_VARIABLE_141153)) ((_ tuple.select 2) t) ((_ tuple.select 10) t))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_141160 Int) (BOUND_VARIABLE_141161 Int)) (= BOUND_VARIABLE_141160 BOUND_VARIABLE_141161)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_141152 String) (BOUND_VARIABLE_141153 String)) (= BOUND_VARIABLE_141152 BOUND_VARIABLE_141153)) ((_ tuple.select 2) t) ((_ tuple.select 10) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_141160 Int) (BOUND_VARIABLE_141161 Int)) (= BOUND_VARIABLE_141160 BOUND_VARIABLE_141161)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_141152 String) (BOUND_VARIABLE_141153 String)) (= BOUND_VARIABLE_141152 BOUND_VARIABLE_141153)) ((_ tuple.select 2) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_141152 String) (BOUND_VARIABLE_141153 String)) (= BOUND_VARIABLE_141152 BOUND_VARIABLE_141153)) ((_ tuple.select 2) t) ((_ tuple.select 10) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_141160 Int) (BOUND_VARIABLE_141161 Int)) (= BOUND_VARIABLE_141160 BOUND_VARIABLE_141161)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_141160 Int) (BOUND_VARIABLE_141161 Int)) (= BOUND_VARIABLE_141160 BOUND_VARIABLE_141161)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_141152 String) (BOUND_VARIABLE_141153 String)) (= BOUND_VARIABLE_141152 BOUND_VARIABLE_141153)) ((_ tuple.select 2) t) ((_ tuple.select 10) t))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_141160 Int) (BOUND_VARIABLE_141161 Int)) (= BOUND_VARIABLE_141160 BOUND_VARIABLE_141161)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_141152 String) (BOUND_VARIABLE_141153 String)) (= BOUND_VARIABLE_141152 BOUND_VARIABLE_141153)) ((_ tuple.select 2) t) ((_ tuple.select 10) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_141160 Int) (BOUND_VARIABLE_141161 Int)) (= BOUND_VARIABLE_141160 BOUND_VARIABLE_141161)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))))))))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 2) t)))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_141317 String) (BOUND_VARIABLE_141318 String)) (= BOUND_VARIABLE_141317 BOUND_VARIABLE_141318)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_141317 String) (BOUND_VARIABLE_141318 String)) (= BOUND_VARIABLE_141317 BOUND_VARIABLE_141318)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_141325 Int) (BOUND_VARIABLE_141326 Int)) (= BOUND_VARIABLE_141325 BOUND_VARIABLE_141326)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_141325 Int) (BOUND_VARIABLE_141326 Int)) (= BOUND_VARIABLE_141325 BOUND_VARIABLE_141326)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_141317 String) (BOUND_VARIABLE_141318 String)) (= BOUND_VARIABLE_141317 BOUND_VARIABLE_141318)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_141325 Int) (BOUND_VARIABLE_141326 Int)) (= BOUND_VARIABLE_141325 BOUND_VARIABLE_141326)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_141317 String) (BOUND_VARIABLE_141318 String)) (= BOUND_VARIABLE_141317 BOUND_VARIABLE_141318)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_141325 Int) (BOUND_VARIABLE_141326 Int)) (= BOUND_VARIABLE_141325 BOUND_VARIABLE_141326)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_141317 String) (BOUND_VARIABLE_141318 String)) (= BOUND_VARIABLE_141317 BOUND_VARIABLE_141318)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_141317 String) (BOUND_VARIABLE_141318 String)) (= BOUND_VARIABLE_141317 BOUND_VARIABLE_141318)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_141325 Int) (BOUND_VARIABLE_141326 Int)) (= BOUND_VARIABLE_141325 BOUND_VARIABLE_141326)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_141325 Int) (BOUND_VARIABLE_141326 Int)) (= BOUND_VARIABLE_141325 BOUND_VARIABLE_141326)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_141317 String) (BOUND_VARIABLE_141318 String)) (= BOUND_VARIABLE_141317 BOUND_VARIABLE_141318)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_141325 Int) (BOUND_VARIABLE_141326 Int)) (= BOUND_VARIABLE_141325 BOUND_VARIABLE_141326)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_141317 String) (BOUND_VARIABLE_141318 String)) (= BOUND_VARIABLE_141317 BOUND_VARIABLE_141318)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_141325 Int) (BOUND_VARIABLE_141326 Int)) (= BOUND_VARIABLE_141325 BOUND_VARIABLE_141326)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))))))))))
(assert (= q1 ((_ table.project 6) (bag.filter p2 (table.product EMP ((_ table.project 0 1) ((_ table.project 0 2) (bag.filter p1 (bag.map f0 DEPT)))))))))
(assert (= q2 ((_ table.project 6) (bag.filter p5 (table.product (bag.map f3 EMP) (bag.map f4 DEPT))))))
(check-sat)
;answer: sat
; duration: 1687 ms.
(get-model)
; (
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 1) (as nullable.null (Nullable String))) 1))
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 0) (nullable.some "B") (as nullable.null (Nullable String)) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (nullable.some (- 6)) (nullable.some 7)) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 6)) 1)
; insert into DEPT values(1,NULL)
; insert into EMP values(0,'B',NULL,-4,5,-5,6,-6,7)
; SELECT * FROM (SELECT EMP.SAL FROM EMP AS EMP WHERE EMP.EMPNO IN (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE EMP.JOB = DEPT.NAME)) AS q1 EXCEPT ALL SELECT * FROM (SELECT EMP0.SAL FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.JOB = DEPT0.NAME AND EMP0.EMPNO = DEPT0.DEPTNO) AS q2;

; SELECT * FROM (SELECT EMP0.SAL FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.JOB = DEPT0.NAME AND EMP0.EMPNO = DEPT0.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.SAL FROM EMP AS EMP WHERE EMP.EMPNO IN (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE EMP.JOB = DEPT.NAME)) AS q1;

;Model soundness: false
(reset)
; parsing query SELECT * FROM (VALUES  (1, 2)) AS t WHERE 1 + 2 > 3 + CAST(NULL AS INT)
; parsing query SELECT * FROM (VALUES  (1, 2)) AS t1 WHERE 1 + 2 > 3 + CAST(NULL AS INT)
;-----------------------------------------------------------
; test name: testReduceConstantsRequiresExecutor
;Translating sql query: SELECT * FROM (VALUES  (1, 2)) AS t WHERE 1 + 2 > 3 + CAST(NULL AS INT)
;Translating sql query: SELECT * FROM (VALUES  (1, 2)) AS t1 WHERE 1 + 2 > 3 + CAST(NULL AS INT)
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_151317 Int) (BOUND_VARIABLE_151318 Int)) (> BOUND_VARIABLE_151317 BOUND_VARIABLE_151318)) (nullable.lift (lambda ((BOUND_VARIABLE_151304 Int) (BOUND_VARIABLE_151305 Int)) (+ BOUND_VARIABLE_151304 BOUND_VARIABLE_151305)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_151311 Int) (BOUND_VARIABLE_151312 Int)) (+ BOUND_VARIABLE_151311 BOUND_VARIABLE_151312)) (nullable.some 3) (as nullable.null (Nullable Int))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_151317 Int) (BOUND_VARIABLE_151318 Int)) (> BOUND_VARIABLE_151317 BOUND_VARIABLE_151318)) (nullable.lift (lambda ((BOUND_VARIABLE_151304 Int) (BOUND_VARIABLE_151305 Int)) (+ BOUND_VARIABLE_151304 BOUND_VARIABLE_151305)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_151311 Int) (BOUND_VARIABLE_151312 Int)) (+ BOUND_VARIABLE_151311 BOUND_VARIABLE_151312)) (nullable.some 3) (as nullable.null (Nullable Int)))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_151354 Int) (BOUND_VARIABLE_151355 Int)) (> BOUND_VARIABLE_151354 BOUND_VARIABLE_151355)) (nullable.lift (lambda ((BOUND_VARIABLE_151342 Int) (BOUND_VARIABLE_151343 Int)) (+ BOUND_VARIABLE_151342 BOUND_VARIABLE_151343)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_151348 Int) (BOUND_VARIABLE_151349 Int)) (+ BOUND_VARIABLE_151348 BOUND_VARIABLE_151349)) (nullable.some 3) (as nullable.null (Nullable Int))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_151354 Int) (BOUND_VARIABLE_151355 Int)) (> BOUND_VARIABLE_151354 BOUND_VARIABLE_151355)) (nullable.lift (lambda ((BOUND_VARIABLE_151342 Int) (BOUND_VARIABLE_151343 Int)) (+ BOUND_VARIABLE_151342 BOUND_VARIABLE_151343)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_151348 Int) (BOUND_VARIABLE_151349 Int)) (+ BOUND_VARIABLE_151348 BOUND_VARIABLE_151349)) (nullable.some 3) (as nullable.null (Nullable Int)))))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 (bag (tuple (nullable.some 1) (nullable.some 2)) 1)))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p1 (bag (tuple (nullable.some 1) (nullable.some 2)) 1)))))
(check-sat)
;answer: unsat
; duration: 37 ms.
(reset)
; parsing query SELECT EMP.MGR FROM EMP AS EMP WHERE EMP.MGR = 10
; parsing query SELECT 10 AS MGR FROM EMP AS EMP0 WHERE EMP0.MGR = 10
;-----------------------------------------------------------
; test name: testReduceConstantsProjectNullable*
;Translating sql query: SELECT EMP.MGR FROM EMP AS EMP WHERE EMP.MGR = 10
;Translating sql query: SELECT 10 AS MGR FROM EMP AS EMP0 WHERE EMP0.MGR = 10
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_151452 Int) (BOUND_VARIABLE_151453 Int)) (= BOUND_VARIABLE_151452 BOUND_VARIABLE_151453)) ((_ tuple.select 3) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_151452 Int) (BOUND_VARIABLE_151453 Int)) (= BOUND_VARIABLE_151452 BOUND_VARIABLE_151453)) ((_ tuple.select 3) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_151473 Int) (BOUND_VARIABLE_151474 Int)) (= BOUND_VARIABLE_151473 BOUND_VARIABLE_151474)) ((_ tuple.select 3) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_151473 Int) (BOUND_VARIABLE_151474 Int)) (= BOUND_VARIABLE_151473 BOUND_VARIABLE_151474)) ((_ tuple.select 3) t) (nullable.some 10)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 10)))))
(assert (= q1 ((_ table.project 3) (bag.filter p0 EMP))))
(assert (= q2 (bag.map f2 (bag.filter p1 EMP))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10007 ms.
(reset)
; parsing query SELECT 1 FROM (SELECT EMP.COMM AS DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO > 7) AS t0 INNER JOIN EMP AS EMP0 ON t0.DEPTNO = EMP0.DEPTNO
; parsing query SELECT 1 FROM (SELECT EMP1.COMM AS DEPTNO FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t3 INNER JOIN EMP AS EMP2 ON t3.DEPTNO = EMP2.DEPTNO
;-----------------------------------------------------------
; test name: testTransitiveInferencePreventProjectPullUp
;Translating sql query: SELECT 1 FROM (SELECT EMP.COMM AS DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO > 7) AS t0 INNER JOIN EMP AS EMP0 ON t0.DEPTNO = EMP0.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT EMP1.COMM AS DEPTNO FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t3 INNER JOIN EMP AS EMP2 ON t3.DEPTNO = EMP2.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f5 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_184098 Int) (BOUND_VARIABLE_184099 Int)) (> BOUND_VARIABLE_184098 BOUND_VARIABLE_184099)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_184098 Int) (BOUND_VARIABLE_184099 Int)) (> BOUND_VARIABLE_184098 BOUND_VARIABLE_184099)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_184162 Int) (BOUND_VARIABLE_184163 Int)) (= BOUND_VARIABLE_184162 BOUND_VARIABLE_184163)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_184162 Int) (BOUND_VARIABLE_184163 Int)) (= BOUND_VARIABLE_184162 BOUND_VARIABLE_184163)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_184191 Int) (BOUND_VARIABLE_184192 Int)) (> BOUND_VARIABLE_184191 BOUND_VARIABLE_184192)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_184191 Int) (BOUND_VARIABLE_184192 Int)) (> BOUND_VARIABLE_184191 BOUND_VARIABLE_184192)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (not (= q1 q2)))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_184212 Int) (BOUND_VARIABLE_184213 Int)) (= BOUND_VARIABLE_184212 BOUND_VARIABLE_184213)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_184212 Int) (BOUND_VARIABLE_184213 Int)) (= BOUND_VARIABLE_184212 BOUND_VARIABLE_184213)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f2 (bag.filter p1 (table.product ((_ table.project 5) (bag.filter p0 EMP)) EMP)))))
(assert (= q2 (bag.map f5 (bag.filter p4 (table.product ((_ table.project 5) (bag.filter p3 EMP)) EMP)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10089 ms.
(reset)
; parsing query SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO INNER JOIN EMP AS EMP1 ON EMP0.DEPTNO = EMP1.DEPTNO
; parsing query SELECT 1 FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO INNER JOIN (SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 7) AS t3 ON t2.DEPTNO = t3.DEPTNO
;-----------------------------------------------------------
; test name: testTransitiveInferenceJoin3way
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO INNER JOIN EMP AS EMP1 ON EMP0.DEPTNO = EMP1.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO INNER JOIN (SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 7) AS t3 ON t2.DEPTNO = t3.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f9 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_239031 Int) (BOUND_VARIABLE_239032 Int)) (> BOUND_VARIABLE_239031 BOUND_VARIABLE_239032)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_239031 Int) (BOUND_VARIABLE_239032 Int)) (> BOUND_VARIABLE_239031 BOUND_VARIABLE_239032)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_239118 Int) (BOUND_VARIABLE_239119 Int)) (= BOUND_VARIABLE_239118 BOUND_VARIABLE_239119)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_239118 Int) (BOUND_VARIABLE_239119 Int)) (= BOUND_VARIABLE_239118 BOUND_VARIABLE_239119)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_239231 Int) (BOUND_VARIABLE_239232 Int)) (= BOUND_VARIABLE_239231 BOUND_VARIABLE_239232)) ((_ tuple.select 16) t) ((_ tuple.select 25) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_239231 Int) (BOUND_VARIABLE_239232 Int)) (= BOUND_VARIABLE_239231 BOUND_VARIABLE_239232)) ((_ tuple.select 16) t) ((_ tuple.select 25) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_239259 Int) (BOUND_VARIABLE_239260 Int)) (> BOUND_VARIABLE_239259 BOUND_VARIABLE_239260)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_239259 Int) (BOUND_VARIABLE_239260 Int)) (> BOUND_VARIABLE_239259 BOUND_VARIABLE_239260)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_239278 Int) (BOUND_VARIABLE_239279 Int)) (> BOUND_VARIABLE_239278 BOUND_VARIABLE_239279)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_239278 Int) (BOUND_VARIABLE_239279 Int)) (> BOUND_VARIABLE_239278 BOUND_VARIABLE_239279)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_239299 Int) (BOUND_VARIABLE_239300 Int)) (= BOUND_VARIABLE_239299 BOUND_VARIABLE_239300)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_239299 Int) (BOUND_VARIABLE_239300 Int)) (= BOUND_VARIABLE_239299 BOUND_VARIABLE_239300)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_239317 Int) (BOUND_VARIABLE_239318 Int)) (> BOUND_VARIABLE_239317 BOUND_VARIABLE_239318)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_239317 Int) (BOUND_VARIABLE_239318 Int)) (> BOUND_VARIABLE_239317 BOUND_VARIABLE_239318)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (not (= q1 q2)))
(assert (= p8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_239338 Int) (BOUND_VARIABLE_239339 Int)) (= BOUND_VARIABLE_239338 BOUND_VARIABLE_239339)) ((_ tuple.select 16) t) ((_ tuple.select 25) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_239338 Int) (BOUND_VARIABLE_239339 Int)) (= BOUND_VARIABLE_239338 BOUND_VARIABLE_239339)) ((_ tuple.select 16) t) ((_ tuple.select 25) t)))))))
(assert (= f9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f3 (bag.filter p2 (table.product (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) EMP)) EMP)))))
(assert (= q2 (bag.map f9 (bag.filter p8 (table.product (bag.filter p6 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p7 EMP)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10179 ms.
(reset)
; parsing query SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = EMP0.DEPTNO
; parsing query SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.DEPTNO = DEPT0.DEPTNO INNER JOIN EMP AS EMP2 ON DEPT0.DEPTNO = EMP2.DEPTNO
;-----------------------------------------------------------
; test name: testRemoveSemiJoinRight
;Translating sql query: SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = EMP0.DEPTNO
;Translating sql query: SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.DEPTNO = DEPT0.DEPTNO INNER JOIN EMP AS EMP2 ON DEPT0.DEPTNO = EMP2.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_285034 Int) (BOUND_VARIABLE_285035 Int)) (= BOUND_VARIABLE_285034 BOUND_VARIABLE_285035)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_285034 Int) (BOUND_VARIABLE_285035 Int)) (= BOUND_VARIABLE_285034 BOUND_VARIABLE_285035)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_285041 Int) (BOUND_VARIABLE_285042 Int)) (= BOUND_VARIABLE_285041 BOUND_VARIABLE_285042)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_285041 Int) (BOUND_VARIABLE_285042 Int)) (= BOUND_VARIABLE_285041 BOUND_VARIABLE_285042)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_285034 Int) (BOUND_VARIABLE_285035 Int)) (= BOUND_VARIABLE_285034 BOUND_VARIABLE_285035)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_285041 Int) (BOUND_VARIABLE_285042 Int)) (= BOUND_VARIABLE_285041 BOUND_VARIABLE_285042)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_285034 Int) (BOUND_VARIABLE_285035 Int)) (= BOUND_VARIABLE_285034 BOUND_VARIABLE_285035)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_285041 Int) (BOUND_VARIABLE_285042 Int)) (= BOUND_VARIABLE_285041 BOUND_VARIABLE_285042)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_285034 Int) (BOUND_VARIABLE_285035 Int)) (= BOUND_VARIABLE_285034 BOUND_VARIABLE_285035)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_285034 Int) (BOUND_VARIABLE_285035 Int)) (= BOUND_VARIABLE_285034 BOUND_VARIABLE_285035)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_285041 Int) (BOUND_VARIABLE_285042 Int)) (= BOUND_VARIABLE_285041 BOUND_VARIABLE_285042)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_285041 Int) (BOUND_VARIABLE_285042 Int)) (= BOUND_VARIABLE_285041 BOUND_VARIABLE_285042)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_285034 Int) (BOUND_VARIABLE_285035 Int)) (= BOUND_VARIABLE_285034 BOUND_VARIABLE_285035)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_285041 Int) (BOUND_VARIABLE_285042 Int)) (= BOUND_VARIABLE_285041 BOUND_VARIABLE_285042)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_285034 Int) (BOUND_VARIABLE_285035 Int)) (= BOUND_VARIABLE_285034 BOUND_VARIABLE_285035)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_285041 Int) (BOUND_VARIABLE_285042 Int)) (= BOUND_VARIABLE_285041 BOUND_VARIABLE_285042)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_285077 Int) (BOUND_VARIABLE_285078 Int)) (= BOUND_VARIABLE_285077 BOUND_VARIABLE_285078)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_285077 Int) (BOUND_VARIABLE_285078 Int)) (= BOUND_VARIABLE_285077 BOUND_VARIABLE_285078)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_285097 Int) (BOUND_VARIABLE_285098 Int)) (= BOUND_VARIABLE_285097 BOUND_VARIABLE_285098)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_285097 Int) (BOUND_VARIABLE_285098 Int)) (= BOUND_VARIABLE_285097 BOUND_VARIABLE_285098)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)))))))
(assert (= q1 ((_ table.project 1) (bag.filter p0 (table.product (table.product EMP DEPT) EMP)))))
(assert (= q2 ((_ table.project 1) (bag.filter p2 (table.product (bag.filter p1 (table.product EMP DEPT)) EMP)))))
(check-sat)
;answer: sat
; duration: 5633 ms.
(get-model)
; (
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 0) (nullable.some "J")) 1))
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some (- 13)) (nullable.some "I") (nullable.some "K") (nullable.some 14) (nullable.some (- 14)) (nullable.some 15) (nullable.some (- 15)) (nullable.some 1) (nullable.some 16)) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some "I")) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable String))))
; insert into DEPT values(0,'J')
; insert into EMP values(-13,'I','K',14,-14,15,-15,1,16)
; SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = EMP0.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.DEPTNO = DEPT0.DEPTNO INNER JOIN EMP AS EMP2 ON DEPT0.DEPTNO = EMP2.DEPTNO) AS q2;

; SELECT * FROM (SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.DEPTNO = DEPT0.DEPTNO INNER JOIN EMP AS EMP2 ON DEPT0.DEPTNO = EMP2.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = EMP0.DEPTNO) AS q1;

;Model soundness: false
(reset)
; parsing query SELECT * FROM (VALUES  (FALSE),  (TRUE)) AS t WHERE NOT t.EXPR$0
; parsing query SELECT * FROM (VALUES  (FALSE),  (TRUE)) AS t1 WHERE NOT t1.EXPR$0
;-----------------------------------------------------------
; test name: testReduceExpressionsNot
;Translating sql query: SELECT * FROM (VALUES  (FALSE),  (TRUE)) AS t WHERE NOT t.EXPR$0
;Translating sql query: SELECT * FROM (VALUES  (FALSE),  (TRUE)) AS t1 WHERE NOT t1.EXPR$0
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Bool)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Bool))))
(declare-const p1 (-> (Tuple (Nullable Bool)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Bool))))
(assert (= p0 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_321411 Bool)) (not BOUND_VARIABLE_321411)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_321411 Bool)) (not BOUND_VARIABLE_321411)) ((_ tuple.select 0) t)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_321430 Bool)) (not BOUND_VARIABLE_321430)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_321430 Bool)) (not BOUND_VARIABLE_321430)) ((_ tuple.select 0) t)))))))
(assert (= q1 ((_ table.project 0) (bag.filter p0 (bag.union_disjoint (bag (tuple (nullable.some false)) 1) (bag (tuple (nullable.some true)) 1))))))
(assert (= q2 ((_ table.project 0) (bag.filter p1 (bag.union_disjoint (bag (tuple (nullable.some false)) 1) (bag (tuple (nullable.some true)) 1))))))
(check-sat)
;answer: unsat
; duration: 97 ms.
(reset)
; parsing query SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO
; parsing query SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO
;-----------------------------------------------------------
; test name: testTransitiveInferenceProject
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_321538 Int) (BOUND_VARIABLE_321539 Int)) (> BOUND_VARIABLE_321538 BOUND_VARIABLE_321539)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_321538 Int) (BOUND_VARIABLE_321539 Int)) (> BOUND_VARIABLE_321538 BOUND_VARIABLE_321539)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_321559 Int) (BOUND_VARIABLE_321560 Int)) (= BOUND_VARIABLE_321559 BOUND_VARIABLE_321560)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_321559 Int) (BOUND_VARIABLE_321560 Int)) (= BOUND_VARIABLE_321559 BOUND_VARIABLE_321560)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_321586 Int) (BOUND_VARIABLE_321587 Int)) (> BOUND_VARIABLE_321586 BOUND_VARIABLE_321587)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_321586 Int) (BOUND_VARIABLE_321587 Int)) (> BOUND_VARIABLE_321586 BOUND_VARIABLE_321587)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_321605 Int) (BOUND_VARIABLE_321606 Int)) (> BOUND_VARIABLE_321605 BOUND_VARIABLE_321606)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_321605 Int) (BOUND_VARIABLE_321606 Int)) (> BOUND_VARIABLE_321605 BOUND_VARIABLE_321606)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_321626 Int) (BOUND_VARIABLE_321627 Int)) (= BOUND_VARIABLE_321626 BOUND_VARIABLE_321627)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_321626 Int) (BOUND_VARIABLE_321627 Int)) (= BOUND_VARIABLE_321626 BOUND_VARIABLE_321627)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f2 (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) EMP)))))
(assert (= q2 (bag.map f6 (bag.filter p5 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10223 ms.
(reset)
; parsing query SELECT * FROM (SELECT UPPER(SUBSTRING(t6.X FROM 1 FOR 2) || SUBSTRING(t6.X FROM 3)) AS U, SUBSTRING(t6.X FROM 1 FOR 1) AS S FROM (SELECT * FROM (SELECT 'table' AS X FROM (VALUES  (TRUE)) AS t UNION SELECT 'view' FROM (VALUES  (TRUE)) AS t1) AS t3 UNION SELECT 'foreign table' FROM (VALUES  (TRUE)) AS t4) AS t6) AS t7 WHERE t7.U = 'TABLE'
; parsing query SELECT 'TABLE' AS U, 't' AS S FROM (VALUES  (TRUE)) AS t9
;-----------------------------------------------------------
; test name: testReduceConstantsCalc
;Translating sql query: SELECT * FROM (SELECT UPPER(SUBSTRING(t6.X FROM 1 FOR 2) || SUBSTRING(t6.X FROM 3)) AS U, SUBSTRING(t6.X FROM 1 FOR 1) AS S FROM (SELECT * FROM (SELECT 'table' AS X FROM (VALUES  (TRUE)) AS t UNION SELECT 'view' FROM (VALUES  (TRUE)) AS t1) AS t3 UNION SELECT 'foreign table' FROM (VALUES  (TRUE)) AS t4) AS t6) AS t7 WHERE t7.U = 'TABLE'
;Translating sql query: SELECT 'TABLE' AS U, 't' AS S FROM (VALUES  (TRUE)) AS t9
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const q1 (Bag (Tuple (Nullable String) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable String) (Nullable String))))
(declare-const p4 (-> (Tuple (Nullable String) (Nullable String)) Bool))
(declare-const f0 (-> (Tuple (Nullable Bool)) (Tuple (Nullable String))))
(declare-const f1 (-> (Tuple (Nullable Bool)) (Tuple (Nullable String))))
(declare-const f2 (-> (Tuple (Nullable Bool)) (Tuple (Nullable String))))
(declare-const f3 (-> (Tuple (Nullable String)) (Tuple (Nullable String) (Nullable String))))
(declare-const f5 (-> (Tuple (Nullable Bool)) (Tuple (Nullable String) (Nullable String))))
(assert (= f0 (lambda ((t (Tuple (Nullable Bool)))) (tuple (nullable.some "table")))))
(assert (= f1 (lambda ((t (Tuple (Nullable Bool)))) (tuple (nullable.some "view")))))
(assert (= f2 (lambda ((t (Tuple (Nullable Bool)))) (tuple (nullable.some "foreign table")))))
(assert (= f3 (lambda ((t (Tuple (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_401675 String)) (str.to_upper BOUND_VARIABLE_401675)) (nullable.lift (lambda ((BOUND_VARIABLE_401668 String) (BOUND_VARIABLE_401669 String)) (str.++ BOUND_VARIABLE_401668 BOUND_VARIABLE_401669)) (nullable.lift (lambda ((BOUND_VARIABLE_401631 String) (BOUND_VARIABLE_401632 Int) (BOUND_VARIABLE_401633 Int)) (str.substr BOUND_VARIABLE_401631 BOUND_VARIABLE_401632 BOUND_VARIABLE_401633)) ((_ tuple.select 0) t) (nullable.some 0) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_401661 String) (BOUND_VARIABLE_401662 Int) (BOUND_VARIABLE_401663 Int)) (str.substr BOUND_VARIABLE_401661 BOUND_VARIABLE_401662 BOUND_VARIABLE_401663)) ((_ tuple.select 0) t) (nullable.some 2) (nullable.lift (lambda ((BOUND_VARIABLE_401655 String)) (str.len BOUND_VARIABLE_401655)) ((_ tuple.select 0) t))))) (nullable.lift (lambda ((BOUND_VARIABLE_401695 String) (BOUND_VARIABLE_401696 Int) (BOUND_VARIABLE_401697 Int)) (str.substr BOUND_VARIABLE_401695 BOUND_VARIABLE_401696 BOUND_VARIABLE_401697)) ((_ tuple.select 0) t) (nullable.some 0) (nullable.some 1))))))
(assert (not (= q1 q2)))
(assert (= p4 (lambda ((t (Tuple (Nullable String) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_401716 String) (BOUND_VARIABLE_401717 String)) (= BOUND_VARIABLE_401716 BOUND_VARIABLE_401717)) ((_ tuple.select 0) t) (nullable.some "TABLE"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_401716 String) (BOUND_VARIABLE_401717 String)) (= BOUND_VARIABLE_401716 BOUND_VARIABLE_401717)) ((_ tuple.select 0) t) (nullable.some "TABLE")))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Bool)))) (tuple (nullable.some "TABLE") (nullable.some "t")))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p4 (bag.map f3 (bag.union_max ((_ table.project 0) (bag.union_max (bag.map f0 (bag (tuple (nullable.some true)) 1)) (bag.map f1 (bag (tuple (nullable.some true)) 1)))) (bag.map f2 (bag (tuple (nullable.some true)) 1))))))))
(assert (= q2 (bag.map f5 (bag (tuple (nullable.some true)) 1))))
(check-sat)
;answer: unsat
; duration: 267 ms.
(reset)
; parsing query SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 AND EMP.DEPTNO = 8 AND EMP.EMPNO = 10 AND EMP.MGR IS NULL AND EMP.EMPNO = 10
; parsing query SELECT 10 AS EMPNO, t0.ENAME, t0.JOB, CAST(NULL AS INT) AS MGR, t0.HIREDATE, t0.SAL, t0.COMM, t0.DEPTNO, t0.SLACKER FROM (SELECT * FROM EMP WHERE FALSE) AS t0
;-----------------------------------------------------------
; test name: testReduceConstantsDup2
;Translating sql query: SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 AND EMP.DEPTNO = 8 AND EMP.EMPNO = 10 AND EMP.MGR IS NULL AND EMP.EMPNO = 10
;Translating sql query: SELECT 10 AS EMPNO, t0.ENAME, t0.JOB, CAST(NULL AS INT) AS MGR, t0.HIREDATE, t0.SAL, t0.COMM, t0.DEPTNO, t0.SLACKER FROM (SELECT * FROM EMP WHERE FALSE) AS t0
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_402123 Int) (BOUND_VARIABLE_402124 Int)) (= BOUND_VARIABLE_402123 BOUND_VARIABLE_402124)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_402123 Int) (BOUND_VARIABLE_402124 Int)) (= BOUND_VARIABLE_402123 BOUND_VARIABLE_402124)) ((_ tuple.select 7) t) (nullable.some 7))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_402129 Int) (BOUND_VARIABLE_402130 Int)) (= BOUND_VARIABLE_402129 BOUND_VARIABLE_402130)) ((_ tuple.select 7) t) (nullable.some 8))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_402129 Int) (BOUND_VARIABLE_402130 Int)) (= BOUND_VARIABLE_402129 BOUND_VARIABLE_402130)) ((_ tuple.select 7) t) (nullable.some 8)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_402123 Int) (BOUND_VARIABLE_402124 Int)) (= BOUND_VARIABLE_402123 BOUND_VARIABLE_402124)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_402129 Int) (BOUND_VARIABLE_402130 Int)) (= BOUND_VARIABLE_402129 BOUND_VARIABLE_402130)) ((_ tuple.select 7) t) (nullable.some 8)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_402123 Int) (BOUND_VARIABLE_402124 Int)) (= BOUND_VARIABLE_402123 BOUND_VARIABLE_402124)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_402129 Int) (BOUND_VARIABLE_402130 Int)) (= BOUND_VARIABLE_402129 BOUND_VARIABLE_402130)) ((_ tuple.select 7) t) (nullable.some 8)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_402123 Int) (BOUND_VARIABLE_402124 Int)) (= BOUND_VARIABLE_402123 BOUND_VARIABLE_402124)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_402123 Int) (BOUND_VARIABLE_402124 Int)) (= BOUND_VARIABLE_402123 BOUND_VARIABLE_402124)) ((_ tuple.select 7) t) (nullable.some 7))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_402129 Int) (BOUND_VARIABLE_402130 Int)) (= BOUND_VARIABLE_402129 BOUND_VARIABLE_402130)) ((_ tuple.select 7) t) (nullable.some 8))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_402129 Int) (BOUND_VARIABLE_402130 Int)) (= BOUND_VARIABLE_402129 BOUND_VARIABLE_402130)) ((_ tuple.select 7) t) (nullable.some 8)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_402123 Int) (BOUND_VARIABLE_402124 Int)) (= BOUND_VARIABLE_402123 BOUND_VARIABLE_402124)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_402129 Int) (BOUND_VARIABLE_402130 Int)) (= BOUND_VARIABLE_402129 BOUND_VARIABLE_402130)) ((_ tuple.select 7) t) (nullable.some 8)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_402123 Int) (BOUND_VARIABLE_402124 Int)) (= BOUND_VARIABLE_402123 BOUND_VARIABLE_402124)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_402129 Int) (BOUND_VARIABLE_402130 Int)) (= BOUND_VARIABLE_402129 BOUND_VARIABLE_402130)) ((_ tuple.select 7) t) (nullable.some 8))))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (not (= q1 q2)))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 10) ((_ tuple.select 1) t) ((_ tuple.select 2) t) (as nullable.null (Nullable Int)) ((_ tuple.select 4) t) ((_ tuple.select 6) t) ((_ tuple.select 5) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 (bag.map f2 (bag.filter p1 EMP))))
(check-sat)
;answer: unknown (INCOMPLETE)
; duration: 203 ms.
(reset)
; parsing query SELECT * FROM (SELECT * FROM (SELECT CAST(NULL AS INT) AS N FROM EMP AS EMP) AS t WHERE t.N IS NULL AND t.N IS NULL) AS t0 WHERE t0.N IS NULL
; parsing query SELECT CAST(NULL AS INT) AS N FROM EMP AS EMP0
;-----------------------------------------------------------
; test name: testReduceConstantsNull
;Translating sql query: SELECT * FROM (SELECT * FROM (SELECT CAST(NULL AS INT) AS N FROM EMP AS EMP) AS t WHERE t.N IS NULL AND t.N IS NULL) AS t0 WHERE t0.N IS NULL
;Translating sql query: SELECT CAST(NULL AS INT) AS N FROM EMP AS EMP0
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 0) t)))) (not (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 0) t)))))) (and (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 0) t)))) (not (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 0) t))))))) (and (and (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 0) t)))) (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 0) t))))) (and (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 0) t)))) (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 0) t))))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 0) t)))) (not (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 0) t)))))) (and (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 0) t)))) (not (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 0) t))))))) (and (and (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 0) t)))) (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 0) t))))) (and (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 0) t)))) (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 0) t)))))))))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 0) t)))) (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 0) t))))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int))))))
(assert (= q1 ((_ table.project 0) (bag.filter p2 ((_ table.project 0) (bag.filter p1 (bag.map f0 EMP)))))))
(assert (= q2 (bag.map f3 EMP)))
(check-sat)
;answer: unsat
; duration: 92 ms.
(reset)
; parsing query SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO > 10 AND EMP.EMPNO <= 10
; parsing query SELECT t1.EXPR$0 FROM (SELECT * FROM (VALUES(0)) EXCEPT SELECT * FROM (VALUES(0))) AS t1
;-----------------------------------------------------------
; test name: testReduceConstantsNegatedInverted
;Translating sql query: SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO > 10 AND EMP.EMPNO <= 10
;Translating sql query: SELECT t1.EXPR$0 FROM (SELECT * FROM (VALUES(0)) EXCEPT SELECT * FROM (VALUES(0))) AS t1
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_406605 Int) (BOUND_VARIABLE_406606 Int)) (> BOUND_VARIABLE_406605 BOUND_VARIABLE_406606)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_406605 Int) (BOUND_VARIABLE_406606 Int)) (> BOUND_VARIABLE_406605 BOUND_VARIABLE_406606)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_406611 Int) (BOUND_VARIABLE_406612 Int)) (<= BOUND_VARIABLE_406611 BOUND_VARIABLE_406612)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_406611 Int) (BOUND_VARIABLE_406612 Int)) (<= BOUND_VARIABLE_406611 BOUND_VARIABLE_406612)) ((_ tuple.select 0) t) (nullable.some 10)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_406605 Int) (BOUND_VARIABLE_406606 Int)) (> BOUND_VARIABLE_406605 BOUND_VARIABLE_406606)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_406611 Int) (BOUND_VARIABLE_406612 Int)) (<= BOUND_VARIABLE_406611 BOUND_VARIABLE_406612)) ((_ tuple.select 0) t) (nullable.some 10)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_406605 Int) (BOUND_VARIABLE_406606 Int)) (> BOUND_VARIABLE_406605 BOUND_VARIABLE_406606)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_406611 Int) (BOUND_VARIABLE_406612 Int)) (<= BOUND_VARIABLE_406611 BOUND_VARIABLE_406612)) ((_ tuple.select 0) t) (nullable.some 10)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_406605 Int) (BOUND_VARIABLE_406606 Int)) (> BOUND_VARIABLE_406605 BOUND_VARIABLE_406606)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_406605 Int) (BOUND_VARIABLE_406606 Int)) (> BOUND_VARIABLE_406605 BOUND_VARIABLE_406606)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_406611 Int) (BOUND_VARIABLE_406612 Int)) (<= BOUND_VARIABLE_406611 BOUND_VARIABLE_406612)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_406611 Int) (BOUND_VARIABLE_406612 Int)) (<= BOUND_VARIABLE_406611 BOUND_VARIABLE_406612)) ((_ tuple.select 0) t) (nullable.some 10)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_406605 Int) (BOUND_VARIABLE_406606 Int)) (> BOUND_VARIABLE_406605 BOUND_VARIABLE_406606)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_406611 Int) (BOUND_VARIABLE_406612 Int)) (<= BOUND_VARIABLE_406611 BOUND_VARIABLE_406612)) ((_ tuple.select 0) t) (nullable.some 10)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_406605 Int) (BOUND_VARIABLE_406606 Int)) (> BOUND_VARIABLE_406605 BOUND_VARIABLE_406606)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_406611 Int) (BOUND_VARIABLE_406612 Int)) (<= BOUND_VARIABLE_406611 BOUND_VARIABLE_406612)) ((_ tuple.select 0) t) (nullable.some 10))))))))))))
(assert (= q1 ((_ table.project 0) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0) (bag.difference_remove ((_ table.project 0) (bag (tuple (nullable.some 0)) 1)) ((_ table.project 0) (bag (tuple (nullable.some 0)) 1))))))
(check-sat)
;answer: sat
; duration: 57 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 11) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 0) (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3)) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 11)) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; insert into EMP values(11,NULL,'',0,1,-1,2,-2,3)
; SELECT * FROM (SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO > 10 AND EMP.EMPNO <= 10) AS q1 EXCEPT ALL SELECT * FROM (SELECT t1.column1 FROM (SELECT * FROM (VALUES(0)) EXCEPT SELECT * FROM (VALUES(0))) AS t1) AS q2;

; SELECT * FROM (SELECT t1.column1 FROM (SELECT * FROM (VALUES(0)) EXCEPT SELECT * FROM (VALUES(0))) AS t1) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO > 10 AND EMP.EMPNO <= 10) AS q1;

;Model soundness: false
(reset)
; parsing query SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.EMPNO = EMP0.EMPNO
; parsing query SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.DEPTNO = DEPT0.DEPTNO INNER JOIN EMP AS EMP2 ON EMP1.EMPNO = EMP2.EMPNO INNER JOIN DEPT AS DEPT1 ON EMP1.DEPTNO = DEPT1.DEPTNO INNER JOIN EMP AS EMP3 ON EMP1.EMPNO = EMP3.EMPNO
;-----------------------------------------------------------
; test name: testPushSemiJoinPastJoinRuleLeft
;Translating sql query: SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.EMPNO = EMP0.EMPNO
;Translating sql query: SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.DEPTNO = DEPT0.DEPTNO INNER JOIN EMP AS EMP2 ON EMP1.EMPNO = EMP2.EMPNO INNER JOIN DEPT AS DEPT1 ON EMP1.DEPTNO = DEPT1.DEPTNO INNER JOIN EMP AS EMP3 ON EMP1.EMPNO = EMP3.EMPNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_407713 Int) (BOUND_VARIABLE_407714 Int)) (= BOUND_VARIABLE_407713 BOUND_VARIABLE_407714)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_407713 Int) (BOUND_VARIABLE_407714 Int)) (= BOUND_VARIABLE_407713 BOUND_VARIABLE_407714)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_407721 Int) (BOUND_VARIABLE_407722 Int)) (= BOUND_VARIABLE_407721 BOUND_VARIABLE_407722)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_407721 Int) (BOUND_VARIABLE_407722 Int)) (= BOUND_VARIABLE_407721 BOUND_VARIABLE_407722)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_407713 Int) (BOUND_VARIABLE_407714 Int)) (= BOUND_VARIABLE_407713 BOUND_VARIABLE_407714)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_407721 Int) (BOUND_VARIABLE_407722 Int)) (= BOUND_VARIABLE_407721 BOUND_VARIABLE_407722)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_407713 Int) (BOUND_VARIABLE_407714 Int)) (= BOUND_VARIABLE_407713 BOUND_VARIABLE_407714)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_407721 Int) (BOUND_VARIABLE_407722 Int)) (= BOUND_VARIABLE_407721 BOUND_VARIABLE_407722)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_407713 Int) (BOUND_VARIABLE_407714 Int)) (= BOUND_VARIABLE_407713 BOUND_VARIABLE_407714)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_407713 Int) (BOUND_VARIABLE_407714 Int)) (= BOUND_VARIABLE_407713 BOUND_VARIABLE_407714)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_407721 Int) (BOUND_VARIABLE_407722 Int)) (= BOUND_VARIABLE_407721 BOUND_VARIABLE_407722)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_407721 Int) (BOUND_VARIABLE_407722 Int)) (= BOUND_VARIABLE_407721 BOUND_VARIABLE_407722)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_407713 Int) (BOUND_VARIABLE_407714 Int)) (= BOUND_VARIABLE_407713 BOUND_VARIABLE_407714)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_407721 Int) (BOUND_VARIABLE_407722 Int)) (= BOUND_VARIABLE_407721 BOUND_VARIABLE_407722)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_407713 Int) (BOUND_VARIABLE_407714 Int)) (= BOUND_VARIABLE_407713 BOUND_VARIABLE_407714)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_407721 Int) (BOUND_VARIABLE_407722 Int)) (= BOUND_VARIABLE_407721 BOUND_VARIABLE_407722)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_407755 Int) (BOUND_VARIABLE_407756 Int)) (= BOUND_VARIABLE_407755 BOUND_VARIABLE_407756)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_407755 Int) (BOUND_VARIABLE_407756 Int)) (= BOUND_VARIABLE_407755 BOUND_VARIABLE_407756)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_407775 Int) (BOUND_VARIABLE_407776 Int)) (= BOUND_VARIABLE_407775 BOUND_VARIABLE_407776)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_407775 Int) (BOUND_VARIABLE_407776 Int)) (= BOUND_VARIABLE_407775 BOUND_VARIABLE_407776)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_407872 Int) (BOUND_VARIABLE_407873 Int)) (= BOUND_VARIABLE_407872 BOUND_VARIABLE_407873)) ((_ tuple.select 7) t) ((_ tuple.select 20) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_407872 Int) (BOUND_VARIABLE_407873 Int)) (= BOUND_VARIABLE_407872 BOUND_VARIABLE_407873)) ((_ tuple.select 7) t) ((_ tuple.select 20) t)))))))
(assert (not (= q1 q2)))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_407997 Int) (BOUND_VARIABLE_407998 Int)) (= BOUND_VARIABLE_407997 BOUND_VARIABLE_407998)) ((_ tuple.select 0) t) ((_ tuple.select 22) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_407997 Int) (BOUND_VARIABLE_407998 Int)) (= BOUND_VARIABLE_407997 BOUND_VARIABLE_407998)) ((_ tuple.select 0) t) ((_ tuple.select 22) t)))))))
(assert (= q1 ((_ table.project 1) (bag.filter p0 (table.product (table.product EMP DEPT) EMP)))))
(assert (= q2 ((_ table.project 1) (bag.filter p4 (table.product (bag.filter p3 (table.product (bag.filter p2 (table.product (bag.filter p1 (table.product EMP DEPT)) EMP)) DEPT)) EMP)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10024 ms.
(reset)
; parsing query SELECT 1 FROM EMP AS EMP INNER JOIN DEPT AS DEPT ON EMP.DEPTNO = DEPT.DEPTNO
; parsing query SELECT 1 FROM EMP AS EMP0, DEPT AS DEPT0 WHERE EMP0.DEPTNO = DEPT0.DEPTNO
;-----------------------------------------------------------
; test name: testExtractJoinFilterRule
;Translating sql query: SELECT 1 FROM EMP AS EMP INNER JOIN DEPT AS DEPT ON EMP.DEPTNO = DEPT.DEPTNO
;Translating sql query: SELECT 1 FROM EMP AS EMP0, DEPT AS DEPT0 WHERE EMP0.DEPTNO = DEPT0.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_490475 Int) (BOUND_VARIABLE_490476 Int)) (= BOUND_VARIABLE_490475 BOUND_VARIABLE_490476)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_490475 Int) (BOUND_VARIABLE_490476 Int)) (= BOUND_VARIABLE_490475 BOUND_VARIABLE_490476)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (tuple (nullable.some 1)))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_490503 Int) (BOUND_VARIABLE_490504 Int)) (= BOUND_VARIABLE_490503 BOUND_VARIABLE_490504)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_490503 Int) (BOUND_VARIABLE_490504 Int)) (= BOUND_VARIABLE_490503 BOUND_VARIABLE_490504)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f1 (bag.filter p0 (table.product EMP DEPT)))))
(assert (= q2 (bag.map f3 (bag.filter p2 (table.product EMP DEPT)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10342 ms.
(reset)
; parsing query SELECT 1 FROM EMP AS EMP FULL JOIN EMP AS EMP0 ON EMP.DEPTNO = EMP0.DEPTNO WHERE EMP.DEPTNO > 7 AND EMP0.DEPTNO > 9
; parsing query SELECT 1 FROM EMP AS EMP1 FULL JOIN EMP AS EMP2 ON EMP1.DEPTNO = EMP2.DEPTNO WHERE EMP1.DEPTNO > 7 AND EMP2.DEPTNO > 9
;-----------------------------------------------------------
; test name: testTransitiveInferenceFullOuterJoin
;Translating sql query: SELECT 1 FROM EMP AS EMP FULL JOIN EMP AS EMP0 ON EMP.DEPTNO = EMP0.DEPTNO WHERE EMP.DEPTNO > 7 AND EMP0.DEPTNO > 9
;Translating sql query: SELECT 1 FROM EMP AS EMP1 FULL JOIN EMP AS EMP2 ON EMP1.DEPTNO = EMP2.DEPTNO WHERE EMP1.DEPTNO > 7 AND EMP2.DEPTNO > 9
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const rightJoin7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f9 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const leftJoin1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const rightJoin2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const leftJoin6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_533485 Int) (BOUND_VARIABLE_533486 Int)) (= BOUND_VARIABLE_533485 BOUND_VARIABLE_533486)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_533485 Int) (BOUND_VARIABLE_533486 Int)) (= BOUND_VARIABLE_533485 BOUND_VARIABLE_533486)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_533548 Int) (BOUND_VARIABLE_533549 Int)) (> BOUND_VARIABLE_533548 BOUND_VARIABLE_533549)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_533548 Int) (BOUND_VARIABLE_533549 Int)) (> BOUND_VARIABLE_533548 BOUND_VARIABLE_533549)) ((_ tuple.select 7) t) (nullable.some 7))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_533555 Int) (BOUND_VARIABLE_533556 Int)) (> BOUND_VARIABLE_533555 BOUND_VARIABLE_533556)) ((_ tuple.select 16) t) (nullable.some 9))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_533555 Int) (BOUND_VARIABLE_533556 Int)) (> BOUND_VARIABLE_533555 BOUND_VARIABLE_533556)) ((_ tuple.select 16) t) (nullable.some 9)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_533548 Int) (BOUND_VARIABLE_533549 Int)) (> BOUND_VARIABLE_533548 BOUND_VARIABLE_533549)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_533555 Int) (BOUND_VARIABLE_533556 Int)) (> BOUND_VARIABLE_533555 BOUND_VARIABLE_533556)) ((_ tuple.select 16) t) (nullable.some 9)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_533548 Int) (BOUND_VARIABLE_533549 Int)) (> BOUND_VARIABLE_533548 BOUND_VARIABLE_533549)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_533555 Int) (BOUND_VARIABLE_533556 Int)) (> BOUND_VARIABLE_533555 BOUND_VARIABLE_533556)) ((_ tuple.select 16) t) (nullable.some 9)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_533548 Int) (BOUND_VARIABLE_533549 Int)) (> BOUND_VARIABLE_533548 BOUND_VARIABLE_533549)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_533548 Int) (BOUND_VARIABLE_533549 Int)) (> BOUND_VARIABLE_533548 BOUND_VARIABLE_533549)) ((_ tuple.select 7) t) (nullable.some 7))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_533555 Int) (BOUND_VARIABLE_533556 Int)) (> BOUND_VARIABLE_533555 BOUND_VARIABLE_533556)) ((_ tuple.select 16) t) (nullable.some 9))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_533555 Int) (BOUND_VARIABLE_533556 Int)) (> BOUND_VARIABLE_533555 BOUND_VARIABLE_533556)) ((_ tuple.select 16) t) (nullable.some 9)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_533548 Int) (BOUND_VARIABLE_533549 Int)) (> BOUND_VARIABLE_533548 BOUND_VARIABLE_533549)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_533555 Int) (BOUND_VARIABLE_533556 Int)) (> BOUND_VARIABLE_533555 BOUND_VARIABLE_533556)) ((_ tuple.select 16) t) (nullable.some 9)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_533548 Int) (BOUND_VARIABLE_533549 Int)) (> BOUND_VARIABLE_533548 BOUND_VARIABLE_533549)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_533555 Int) (BOUND_VARIABLE_533556 Int)) (> BOUND_VARIABLE_533555 BOUND_VARIABLE_533556)) ((_ tuple.select 16) t) (nullable.some 9))))))))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_533596 Int) (BOUND_VARIABLE_533597 Int)) (= BOUND_VARIABLE_533596 BOUND_VARIABLE_533597)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_533596 Int) (BOUND_VARIABLE_533597 Int)) (= BOUND_VARIABLE_533596 BOUND_VARIABLE_533597)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= leftJoin6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (not (= q1 q2)))
(assert (= p8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_533656 Int) (BOUND_VARIABLE_533657 Int)) (> BOUND_VARIABLE_533656 BOUND_VARIABLE_533657)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_533656 Int) (BOUND_VARIABLE_533657 Int)) (> BOUND_VARIABLE_533656 BOUND_VARIABLE_533657)) ((_ tuple.select 7) t) (nullable.some 7))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_533663 Int) (BOUND_VARIABLE_533664 Int)) (> BOUND_VARIABLE_533663 BOUND_VARIABLE_533664)) ((_ tuple.select 16) t) (nullable.some 9))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_533663 Int) (BOUND_VARIABLE_533664 Int)) (> BOUND_VARIABLE_533663 BOUND_VARIABLE_533664)) ((_ tuple.select 16) t) (nullable.some 9)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_533656 Int) (BOUND_VARIABLE_533657 Int)) (> BOUND_VARIABLE_533656 BOUND_VARIABLE_533657)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_533663 Int) (BOUND_VARIABLE_533664 Int)) (> BOUND_VARIABLE_533663 BOUND_VARIABLE_533664)) ((_ tuple.select 16) t) (nullable.some 9)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_533656 Int) (BOUND_VARIABLE_533657 Int)) (> BOUND_VARIABLE_533656 BOUND_VARIABLE_533657)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_533663 Int) (BOUND_VARIABLE_533664 Int)) (> BOUND_VARIABLE_533663 BOUND_VARIABLE_533664)) ((_ tuple.select 16) t) (nullable.some 9)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_533656 Int) (BOUND_VARIABLE_533657 Int)) (> BOUND_VARIABLE_533656 BOUND_VARIABLE_533657)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_533656 Int) (BOUND_VARIABLE_533657 Int)) (> BOUND_VARIABLE_533656 BOUND_VARIABLE_533657)) ((_ tuple.select 7) t) (nullable.some 7))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_533663 Int) (BOUND_VARIABLE_533664 Int)) (> BOUND_VARIABLE_533663 BOUND_VARIABLE_533664)) ((_ tuple.select 16) t) (nullable.some 9))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_533663 Int) (BOUND_VARIABLE_533664 Int)) (> BOUND_VARIABLE_533663 BOUND_VARIABLE_533664)) ((_ tuple.select 16) t) (nullable.some 9)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_533656 Int) (BOUND_VARIABLE_533657 Int)) (> BOUND_VARIABLE_533656 BOUND_VARIABLE_533657)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_533663 Int) (BOUND_VARIABLE_533664 Int)) (> BOUND_VARIABLE_533663 BOUND_VARIABLE_533664)) ((_ tuple.select 16) t) (nullable.some 9)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_533656 Int) (BOUND_VARIABLE_533657 Int)) (> BOUND_VARIABLE_533656 BOUND_VARIABLE_533657)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_533663 Int) (BOUND_VARIABLE_533664 Int)) (> BOUND_VARIABLE_533663 BOUND_VARIABLE_533664)) ((_ tuple.select 16) t) (nullable.some 9))))))))))))
(assert (= f9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f4 (bag.filter p3 (bag.union_disjoint (bag.union_disjoint (bag.map leftJoin1 (bag.difference_remove EMP ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 (table.product EMP EMP))))) (bag.map rightJoin2 (bag.difference_remove EMP ((_ table.project 9 10 11 12 13 14 15 16 17) (bag.filter p0 (table.product EMP EMP)))))) (bag.filter p0 (table.product EMP EMP)))))))
(assert (= q2 (bag.map f9 (bag.filter p8 (bag.union_disjoint (bag.union_disjoint (bag.map leftJoin6 (bag.difference_remove EMP ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 (table.product EMP EMP))))) (bag.map rightJoin7 (bag.difference_remove EMP ((_ table.project 9 10 11 12 13 14 15 16 17) (bag.filter p5 (table.product EMP EMP)))))) (bag.filter p5 (table.product EMP EMP)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10163 ms.
(reset)
; parsing query SELECT EMP.SAL FROM EMP AS EMP WHERE EMP.EMPNO IN (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE EMP.JOB = DEPT.NAME) AND EMP.EMPNO IN (SELECT EMP0.EMPNO FROM EMP AS EMP0 WHERE EMP.ENAME = EMP0.ENAME)
; parsing query SELECT EMP1.SAL FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.JOB = DEPT0.NAME AND EMP1.EMPNO = DEPT0.DEPTNO INNER JOIN (SELECT EMP2.EMPNO, EMP2.ENAME FROM EMP AS EMP2) AS t5 ON EMP1.ENAME = t5.ENAME AND EMP1.EMPNO = t5.EMPNO
;-----------------------------------------------------------
; test name: testDecorrelateTwoIn
;Translating sql query: SELECT EMP.SAL FROM EMP AS EMP WHERE EMP.EMPNO IN (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE EMP.JOB = DEPT.NAME) AND EMP.EMPNO IN (SELECT EMP0.EMPNO FROM EMP AS EMP0 WHERE EMP.ENAME = EMP0.ENAME)
;Translating sql query: SELECT EMP1.SAL FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.JOB = DEPT0.NAME AND EMP1.EMPNO = DEPT0.DEPTNO INNER JOIN (SELECT EMP2.EMPNO, EMP2.ENAME FROM EMP AS EMP2) AS t5 ON EMP1.ENAME = t5.ENAME AND EMP1.EMPNO = t5.EMPNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const f10 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String))))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)) Bool))
(declare-const p8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f7 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String))))
(declare-const p11 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)) Bool))
(declare-const f9 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_585908 String) (BOUND_VARIABLE_585909 String)) (= BOUND_VARIABLE_585908 BOUND_VARIABLE_585909)) ((_ tuple.select 2) t) ((_ tuple.select 1) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_585908 String) (BOUND_VARIABLE_585909 String)) (= BOUND_VARIABLE_585908 BOUND_VARIABLE_585909)) ((_ tuple.select 2) t) ((_ tuple.select 1) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_585931 String) (BOUND_VARIABLE_585932 String)) (= BOUND_VARIABLE_585931 BOUND_VARIABLE_585932)) ((_ tuple.select 2) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_585931 String) (BOUND_VARIABLE_585932 String)) (= BOUND_VARIABLE_585931 BOUND_VARIABLE_585932)) ((_ tuple.select 2) t) ((_ tuple.select 10) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_585939 Int) (BOUND_VARIABLE_585940 Int)) (= BOUND_VARIABLE_585939 BOUND_VARIABLE_585940)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_585939 Int) (BOUND_VARIABLE_585940 Int)) (= BOUND_VARIABLE_585939 BOUND_VARIABLE_585940)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_585931 String) (BOUND_VARIABLE_585932 String)) (= BOUND_VARIABLE_585931 BOUND_VARIABLE_585932)) ((_ tuple.select 2) t) ((_ tuple.select 10) t))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_585939 Int) (BOUND_VARIABLE_585940 Int)) (= BOUND_VARIABLE_585939 BOUND_VARIABLE_585940)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_585931 String) (BOUND_VARIABLE_585932 String)) (= BOUND_VARIABLE_585931 BOUND_VARIABLE_585932)) ((_ tuple.select 2) t) ((_ tuple.select 10) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_585939 Int) (BOUND_VARIABLE_585940 Int)) (= BOUND_VARIABLE_585939 BOUND_VARIABLE_585940)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_585931 String) (BOUND_VARIABLE_585932 String)) (= BOUND_VARIABLE_585931 BOUND_VARIABLE_585932)) ((_ tuple.select 2) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_585931 String) (BOUND_VARIABLE_585932 String)) (= BOUND_VARIABLE_585931 BOUND_VARIABLE_585932)) ((_ tuple.select 2) t) ((_ tuple.select 10) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_585939 Int) (BOUND_VARIABLE_585940 Int)) (= BOUND_VARIABLE_585939 BOUND_VARIABLE_585940)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_585939 Int) (BOUND_VARIABLE_585940 Int)) (= BOUND_VARIABLE_585939 BOUND_VARIABLE_585940)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_585931 String) (BOUND_VARIABLE_585932 String)) (= BOUND_VARIABLE_585931 BOUND_VARIABLE_585932)) ((_ tuple.select 2) t) ((_ tuple.select 10) t))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_585939 Int) (BOUND_VARIABLE_585940 Int)) (= BOUND_VARIABLE_585939 BOUND_VARIABLE_585940)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_585931 String) (BOUND_VARIABLE_585932 String)) (= BOUND_VARIABLE_585931 BOUND_VARIABLE_585932)) ((_ tuple.select 2) t) ((_ tuple.select 10) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_585939 Int) (BOUND_VARIABLE_585940 Int)) (= BOUND_VARIABLE_585939 BOUND_VARIABLE_585940)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))))))))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 1) t)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_585990 String) (BOUND_VARIABLE_585991 String)) (= BOUND_VARIABLE_585990 BOUND_VARIABLE_585991)) ((_ tuple.select 9) t) ((_ tuple.select 1) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_585990 String) (BOUND_VARIABLE_585991 String)) (= BOUND_VARIABLE_585990 BOUND_VARIABLE_585991)) ((_ tuple.select 9) t) ((_ tuple.select 1) t)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_586064 String) (BOUND_VARIABLE_586065 String)) (= BOUND_VARIABLE_586064 BOUND_VARIABLE_586065)) ((_ tuple.select 1) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_586064 String) (BOUND_VARIABLE_586065 String)) (= BOUND_VARIABLE_586064 BOUND_VARIABLE_586065)) ((_ tuple.select 1) t) ((_ tuple.select 12) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_586072 Int) (BOUND_VARIABLE_586073 Int)) (= BOUND_VARIABLE_586072 BOUND_VARIABLE_586073)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_586072 Int) (BOUND_VARIABLE_586073 Int)) (= BOUND_VARIABLE_586072 BOUND_VARIABLE_586073)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_586064 String) (BOUND_VARIABLE_586065 String)) (= BOUND_VARIABLE_586064 BOUND_VARIABLE_586065)) ((_ tuple.select 1) t) ((_ tuple.select 12) t))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_586072 Int) (BOUND_VARIABLE_586073 Int)) (= BOUND_VARIABLE_586072 BOUND_VARIABLE_586073)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_586064 String) (BOUND_VARIABLE_586065 String)) (= BOUND_VARIABLE_586064 BOUND_VARIABLE_586065)) ((_ tuple.select 1) t) ((_ tuple.select 12) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_586072 Int) (BOUND_VARIABLE_586073 Int)) (= BOUND_VARIABLE_586072 BOUND_VARIABLE_586073)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_586064 String) (BOUND_VARIABLE_586065 String)) (= BOUND_VARIABLE_586064 BOUND_VARIABLE_586065)) ((_ tuple.select 1) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_586064 String) (BOUND_VARIABLE_586065 String)) (= BOUND_VARIABLE_586064 BOUND_VARIABLE_586065)) ((_ tuple.select 1) t) ((_ tuple.select 12) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_586072 Int) (BOUND_VARIABLE_586073 Int)) (= BOUND_VARIABLE_586072 BOUND_VARIABLE_586073)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_586072 Int) (BOUND_VARIABLE_586073 Int)) (= BOUND_VARIABLE_586072 BOUND_VARIABLE_586073)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_586064 String) (BOUND_VARIABLE_586065 String)) (= BOUND_VARIABLE_586064 BOUND_VARIABLE_586065)) ((_ tuple.select 1) t) ((_ tuple.select 12) t))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_586072 Int) (BOUND_VARIABLE_586073 Int)) (= BOUND_VARIABLE_586072 BOUND_VARIABLE_586073)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_586064 String) (BOUND_VARIABLE_586065 String)) (= BOUND_VARIABLE_586064 BOUND_VARIABLE_586065)) ((_ tuple.select 1) t) ((_ tuple.select 12) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_586072 Int) (BOUND_VARIABLE_586073 Int)) (= BOUND_VARIABLE_586072 BOUND_VARIABLE_586073)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))))))))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 2) t)))))
(assert (= f7 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_586137 String) (BOUND_VARIABLE_586138 String)) (= BOUND_VARIABLE_586137 BOUND_VARIABLE_586138)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_586137 String) (BOUND_VARIABLE_586138 String)) (= BOUND_VARIABLE_586137 BOUND_VARIABLE_586138)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_586145 Int) (BOUND_VARIABLE_586146 Int)) (= BOUND_VARIABLE_586145 BOUND_VARIABLE_586146)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_586145 Int) (BOUND_VARIABLE_586146 Int)) (= BOUND_VARIABLE_586145 BOUND_VARIABLE_586146)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_586137 String) (BOUND_VARIABLE_586138 String)) (= BOUND_VARIABLE_586137 BOUND_VARIABLE_586138)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_586145 Int) (BOUND_VARIABLE_586146 Int)) (= BOUND_VARIABLE_586145 BOUND_VARIABLE_586146)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_586137 String) (BOUND_VARIABLE_586138 String)) (= BOUND_VARIABLE_586137 BOUND_VARIABLE_586138)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_586145 Int) (BOUND_VARIABLE_586146 Int)) (= BOUND_VARIABLE_586145 BOUND_VARIABLE_586146)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_586137 String) (BOUND_VARIABLE_586138 String)) (= BOUND_VARIABLE_586137 BOUND_VARIABLE_586138)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_586137 String) (BOUND_VARIABLE_586138 String)) (= BOUND_VARIABLE_586137 BOUND_VARIABLE_586138)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_586145 Int) (BOUND_VARIABLE_586146 Int)) (= BOUND_VARIABLE_586145 BOUND_VARIABLE_586146)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_586145 Int) (BOUND_VARIABLE_586146 Int)) (= BOUND_VARIABLE_586145 BOUND_VARIABLE_586146)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_586137 String) (BOUND_VARIABLE_586138 String)) (= BOUND_VARIABLE_586137 BOUND_VARIABLE_586138)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_586145 Int) (BOUND_VARIABLE_586146 Int)) (= BOUND_VARIABLE_586145 BOUND_VARIABLE_586146)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_586137 String) (BOUND_VARIABLE_586138 String)) (= BOUND_VARIABLE_586137 BOUND_VARIABLE_586138)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_586145 Int) (BOUND_VARIABLE_586146 Int)) (= BOUND_VARIABLE_586145 BOUND_VARIABLE_586146)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))))))))))
(assert (= f9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 10) t) ((_ tuple.select 11) t) ((_ tuple.select 1) t)))))
(assert (= f10 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (not (= q1 q2)))
(assert (= p11 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_586315 String) (BOUND_VARIABLE_586316 String)) (= BOUND_VARIABLE_586315 BOUND_VARIABLE_586316)) ((_ tuple.select 11) t) ((_ tuple.select 14) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_586315 String) (BOUND_VARIABLE_586316 String)) (= BOUND_VARIABLE_586315 BOUND_VARIABLE_586316)) ((_ tuple.select 11) t) ((_ tuple.select 14) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_586323 Int) (BOUND_VARIABLE_586324 Int)) (= BOUND_VARIABLE_586323 BOUND_VARIABLE_586324)) ((_ tuple.select 0) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_586323 Int) (BOUND_VARIABLE_586324 Int)) (= BOUND_VARIABLE_586323 BOUND_VARIABLE_586324)) ((_ tuple.select 0) t) ((_ tuple.select 12) t)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_586315 String) (BOUND_VARIABLE_586316 String)) (= BOUND_VARIABLE_586315 BOUND_VARIABLE_586316)) ((_ tuple.select 11) t) ((_ tuple.select 14) t))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_586323 Int) (BOUND_VARIABLE_586324 Int)) (= BOUND_VARIABLE_586323 BOUND_VARIABLE_586324)) ((_ tuple.select 0) t) ((_ tuple.select 12) t)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_586315 String) (BOUND_VARIABLE_586316 String)) (= BOUND_VARIABLE_586315 BOUND_VARIABLE_586316)) ((_ tuple.select 11) t) ((_ tuple.select 14) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_586323 Int) (BOUND_VARIABLE_586324 Int)) (= BOUND_VARIABLE_586323 BOUND_VARIABLE_586324)) ((_ tuple.select 0) t) ((_ tuple.select 12) t)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_586315 String) (BOUND_VARIABLE_586316 String)) (= BOUND_VARIABLE_586315 BOUND_VARIABLE_586316)) ((_ tuple.select 11) t) ((_ tuple.select 14) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_586315 String) (BOUND_VARIABLE_586316 String)) (= BOUND_VARIABLE_586315 BOUND_VARIABLE_586316)) ((_ tuple.select 11) t) ((_ tuple.select 14) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_586323 Int) (BOUND_VARIABLE_586324 Int)) (= BOUND_VARIABLE_586323 BOUND_VARIABLE_586324)) ((_ tuple.select 0) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_586323 Int) (BOUND_VARIABLE_586324 Int)) (= BOUND_VARIABLE_586323 BOUND_VARIABLE_586324)) ((_ tuple.select 0) t) ((_ tuple.select 12) t)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_586315 String) (BOUND_VARIABLE_586316 String)) (= BOUND_VARIABLE_586315 BOUND_VARIABLE_586316)) ((_ tuple.select 11) t) ((_ tuple.select 14) t))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_586323 Int) (BOUND_VARIABLE_586324 Int)) (= BOUND_VARIABLE_586323 BOUND_VARIABLE_586324)) ((_ tuple.select 0) t) ((_ tuple.select 12) t)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_586315 String) (BOUND_VARIABLE_586316 String)) (= BOUND_VARIABLE_586315 BOUND_VARIABLE_586316)) ((_ tuple.select 11) t) ((_ tuple.select 14) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_586323 Int) (BOUND_VARIABLE_586324 Int)) (= BOUND_VARIABLE_586323 BOUND_VARIABLE_586324)) ((_ tuple.select 0) t) ((_ tuple.select 12) t))))))))))))
(assert (= q1 ((_ table.project 6) (bag.filter p5 (table.product (bag.filter p2 (table.product EMP ((_ table.project 0 1) ((_ table.project 0 2) (bag.filter p1 (bag.map f0 DEPT)))))) ((_ table.project 0 1) ((_ table.project 0 9) (bag.filter p4 (bag.map f3 EMP)))))))))
(assert (= q2 ((_ table.project 6) (bag.filter p11 (table.product (bag.map f9 (bag.filter p8 (table.product (bag.map f6 EMP) (bag.map f7 DEPT)))) (bag.map f10 EMP))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10258 ms.
(reset)
; parsing query SELECT t.NAME FROM (SELECT * FROM DEPT AS DEPT WHERE DEPT.DEPTNO = 10) AS t WHERE t.DEPTNO = 10
; parsing query SELECT DEPT0.NAME FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO = 10
;-----------------------------------------------------------
; test name: testMergeFilter
;Translating sql query: SELECT t.NAME FROM (SELECT * FROM DEPT AS DEPT WHERE DEPT.DEPTNO = 10) AS t WHERE t.DEPTNO = 10
;Translating sql query: SELECT DEPT0.NAME FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO = 10
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Bag (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_624203 Int) (BOUND_VARIABLE_624204 Int)) (= BOUND_VARIABLE_624203 BOUND_VARIABLE_624204)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_624203 Int) (BOUND_VARIABLE_624204 Int)) (= BOUND_VARIABLE_624203 BOUND_VARIABLE_624204)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_624223 Int) (BOUND_VARIABLE_624224 Int)) (= BOUND_VARIABLE_624223 BOUND_VARIABLE_624224)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_624223 Int) (BOUND_VARIABLE_624224 Int)) (= BOUND_VARIABLE_624223 BOUND_VARIABLE_624224)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_624242 Int) (BOUND_VARIABLE_624243 Int)) (= BOUND_VARIABLE_624242 BOUND_VARIABLE_624243)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_624242 Int) (BOUND_VARIABLE_624243 Int)) (= BOUND_VARIABLE_624242 BOUND_VARIABLE_624243)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= q1 ((_ table.project 1) (bag.filter p1 ((_ table.project 0 1) (bag.filter p0 DEPT))))))
(assert (= q2 ((_ table.project 1) (bag.filter p2 DEPT))))
(check-sat)
;answer: unsat
; duration: 1130 ms.
(reset)
; parsing query SELECT t.SAL FROM (SELECT * FROM EMP AS EMP UNION ALL SELECT * FROM EMP AS EMP0) AS t
; parsing query SELECT EMP1.SAL FROM EMP AS EMP1 UNION ALL SELECT EMP2.SAL FROM EMP AS EMP2
;-----------------------------------------------------------
; test name: testPushProjectPastSetOp
;Translating sql query: SELECT t.SAL FROM (SELECT * FROM EMP AS EMP UNION ALL SELECT * FROM EMP AS EMP0) AS t
;Translating sql query: SELECT EMP1.SAL FROM EMP AS EMP1 UNION ALL SELECT EMP2.SAL FROM EMP AS EMP2
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= q1 ((_ table.project 6) (bag.union_disjoint ((_ table.project 0 1 2 3 4 5 6 7 8) EMP) ((_ table.project 0 1 2 3 4 5 6 7 8) EMP)))))
(assert (= q2 (bag.union_disjoint ((_ table.project 6) EMP) ((_ table.project 6) EMP))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10017 ms.
(reset)
; parsing query SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 EXCEPT SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20 EXCEPT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS t2
; parsing query SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 EXCEPT SELECT * FROM (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 EXCEPT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS t7
;-----------------------------------------------------------
; test name: testMergeMinusRightDeep
;Translating sql query: SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 EXCEPT SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20 EXCEPT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS t2
;Translating sql query: SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 EXCEPT SELECT * FROM (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 EXCEPT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS t7
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_670466 Int) (BOUND_VARIABLE_670467 Int)) (= BOUND_VARIABLE_670466 BOUND_VARIABLE_670467)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_670466 Int) (BOUND_VARIABLE_670467 Int)) (= BOUND_VARIABLE_670466 BOUND_VARIABLE_670467)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_670486 Int) (BOUND_VARIABLE_670487 Int)) (= BOUND_VARIABLE_670486 BOUND_VARIABLE_670487)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_670486 Int) (BOUND_VARIABLE_670487 Int)) (= BOUND_VARIABLE_670486 BOUND_VARIABLE_670487)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_670505 Int) (BOUND_VARIABLE_670506 Int)) (= BOUND_VARIABLE_670505 BOUND_VARIABLE_670506)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_670505 Int) (BOUND_VARIABLE_670506 Int)) (= BOUND_VARIABLE_670505 BOUND_VARIABLE_670506)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_670527 Int) (BOUND_VARIABLE_670528 Int)) (= BOUND_VARIABLE_670527 BOUND_VARIABLE_670528)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_670527 Int) (BOUND_VARIABLE_670528 Int)) (= BOUND_VARIABLE_670527 BOUND_VARIABLE_670528)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_670546 Int) (BOUND_VARIABLE_670547 Int)) (= BOUND_VARIABLE_670546 BOUND_VARIABLE_670547)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_670546 Int) (BOUND_VARIABLE_670547 Int)) (= BOUND_VARIABLE_670546 BOUND_VARIABLE_670547)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_670565 Int) (BOUND_VARIABLE_670566 Int)) (= BOUND_VARIABLE_670565 BOUND_VARIABLE_670566)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_670565 Int) (BOUND_VARIABLE_670566 Int)) (= BOUND_VARIABLE_670565 BOUND_VARIABLE_670566)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)))))))
(assert (= q2 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)))))))
(check-sat)
;answer: unsat
; duration: 607 ms.
(reset)
; parsing query SELECT * FROM (SELECT * FROM EMP AS EMP WHERE FALSE) AS t INNER JOIN DEPT AS DEPT ON t.DEPTNO = DEPT.DEPTNO
; parsing query SELECT * FROM (SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0,0,'')) EXCEPT SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0,0,''))) AS t0
;-----------------------------------------------------------
; test name: testEmptyJoin
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE FALSE) AS t INNER JOIN DEPT AS DEPT ON t.DEPTNO = DEPT.DEPTNO
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0,0,'')) EXCEPT SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0,0,''))) AS t0
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_677232 Int) (BOUND_VARIABLE_677233 Int)) (= BOUND_VARIABLE_677232 BOUND_VARIABLE_677233)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_677232 Int) (BOUND_VARIABLE_677233 Int)) (= BOUND_VARIABLE_677232 BOUND_VARIABLE_677233)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) DEPT)))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some "")) 1)) ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some "")) 1))))))
(check-sat)
;answer: unsat
; duration: 90 ms.
(reset)
; parsing query SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND EMP.EMPNO IS NULL
; parsing query SELECT t1.EXPR$0 FROM (SELECT * FROM (VALUES(0)) EXCEPT SELECT * FROM (VALUES(0))) AS t1
;-----------------------------------------------------------
; test name: testReduceConstantsIsNull
;Translating sql query: SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND EMP.EMPNO IS NULL
;Translating sql query: SELECT t1.EXPR$0 FROM (SELECT * FROM (VALUES(0)) EXCEPT SELECT * FROM (VALUES(0))) AS t1
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_678357 Int) (BOUND_VARIABLE_678358 Int)) (= BOUND_VARIABLE_678357 BOUND_VARIABLE_678358)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_678357 Int) (BOUND_VARIABLE_678358 Int)) (= BOUND_VARIABLE_678357 BOUND_VARIABLE_678358)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 0) t)))) (not (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 0) t))))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_678357 Int) (BOUND_VARIABLE_678358 Int)) (= BOUND_VARIABLE_678357 BOUND_VARIABLE_678358)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 0) t))))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_678357 Int) (BOUND_VARIABLE_678358 Int)) (= BOUND_VARIABLE_678357 BOUND_VARIABLE_678358)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 0) t))))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_678357 Int) (BOUND_VARIABLE_678358 Int)) (= BOUND_VARIABLE_678357 BOUND_VARIABLE_678358)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_678357 Int) (BOUND_VARIABLE_678358 Int)) (= BOUND_VARIABLE_678357 BOUND_VARIABLE_678358)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 0) t)))) (not (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 0) t))))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_678357 Int) (BOUND_VARIABLE_678358 Int)) (= BOUND_VARIABLE_678357 BOUND_VARIABLE_678358)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 0) t))))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_678357 Int) (BOUND_VARIABLE_678358 Int)) (= BOUND_VARIABLE_678357 BOUND_VARIABLE_678358)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 0) t)))))))))))))
(assert (= q1 ((_ table.project 0) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0) (bag.difference_remove ((_ table.project 0) (bag (tuple (nullable.some 0)) 1)) ((_ table.project 0) (bag (tuple (nullable.some 0)) 1))))))
(check-sat)
;answer: sat
; duration: 50 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 10) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 0) (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3)) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 10)) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; insert into EMP values(10,NULL,'',0,1,-1,2,-2,3)
; SELECT * FROM (SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND EMP.EMPNO IS NULL) AS q1 EXCEPT ALL SELECT * FROM (SELECT t1.column1 FROM (SELECT * FROM (VALUES(0)) EXCEPT SELECT * FROM (VALUES(0))) AS t1) AS q2;

; SELECT * FROM (SELECT t1.column1 FROM (SELECT * FROM (VALUES(0)) EXCEPT SELECT * FROM (VALUES(0))) AS t1) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND EMP.EMPNO IS NULL) AS q1;

;Model soundness: false
(reset)
; parsing query SELECT 1 FROM EMP AS EMP INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 7) AS t ON EMP.DEPTNO = t.DEPTNO
; parsing query SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO
;-----------------------------------------------------------
; test name: testTransitiveInferenceJoin
;Translating sql query: SELECT 1 FROM EMP AS EMP INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 7) AS t ON EMP.DEPTNO = t.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_679325 Int) (BOUND_VARIABLE_679326 Int)) (> BOUND_VARIABLE_679325 BOUND_VARIABLE_679326)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_679325 Int) (BOUND_VARIABLE_679326 Int)) (> BOUND_VARIABLE_679325 BOUND_VARIABLE_679326)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_679346 Int) (BOUND_VARIABLE_679347 Int)) (= BOUND_VARIABLE_679346 BOUND_VARIABLE_679347)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_679346 Int) (BOUND_VARIABLE_679347 Int)) (= BOUND_VARIABLE_679346 BOUND_VARIABLE_679347)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_679372 Int) (BOUND_VARIABLE_679373 Int)) (> BOUND_VARIABLE_679372 BOUND_VARIABLE_679373)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_679372 Int) (BOUND_VARIABLE_679373 Int)) (> BOUND_VARIABLE_679372 BOUND_VARIABLE_679373)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_679391 Int) (BOUND_VARIABLE_679392 Int)) (> BOUND_VARIABLE_679391 BOUND_VARIABLE_679392)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_679391 Int) (BOUND_VARIABLE_679392 Int)) (> BOUND_VARIABLE_679391 BOUND_VARIABLE_679392)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_679412 Int) (BOUND_VARIABLE_679413 Int)) (= BOUND_VARIABLE_679412 BOUND_VARIABLE_679413)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_679412 Int) (BOUND_VARIABLE_679413 Int)) (= BOUND_VARIABLE_679412 BOUND_VARIABLE_679413)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f2 (bag.filter p1 (table.product EMP ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)))))))
(assert (= q2 (bag.map f6 (bag.filter p5 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10011 ms.
(reset)
; parsing query SELECT 1 FROM DEPT AS DEPT FULL JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE EMP.SAL > 100
; parsing query SELECT 1 FROM DEPT AS DEPT0 RIGHT JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL > 100) AS t1 ON DEPT0.DEPTNO = t1.DEPTNO
;-----------------------------------------------------------
; test name: testFullOuterJoinSimplificationToRightOuter
;Translating sql query: SELECT 1 FROM DEPT AS DEPT FULL JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE EMP.SAL > 100
;Translating sql query: SELECT 1 FROM DEPT AS DEPT0 RIGHT JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL > 100) AS t1 ON DEPT0.DEPTNO = t1.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const rightJoin7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const f8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const leftJoin1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const rightJoin2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_765982 Int) (BOUND_VARIABLE_765983 Int)) (= BOUND_VARIABLE_765982 BOUND_VARIABLE_765983)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_765982 Int) (BOUND_VARIABLE_765983 Int)) (= BOUND_VARIABLE_765982 BOUND_VARIABLE_765983)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_766042 Int) (BOUND_VARIABLE_766043 Int)) (> BOUND_VARIABLE_766042 BOUND_VARIABLE_766043)) ((_ tuple.select 8) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_766042 Int) (BOUND_VARIABLE_766043 Int)) (> BOUND_VARIABLE_766042 BOUND_VARIABLE_766043)) ((_ tuple.select 8) t) (nullable.some 100)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_766069 Int) (BOUND_VARIABLE_766070 Int)) (> BOUND_VARIABLE_766069 BOUND_VARIABLE_766070)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_766069 Int) (BOUND_VARIABLE_766070 Int)) (> BOUND_VARIABLE_766069 BOUND_VARIABLE_766070)) ((_ tuple.select 6) t) (nullable.some 100)))))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_766090 Int) (BOUND_VARIABLE_766091 Int)) (= BOUND_VARIABLE_766090 BOUND_VARIABLE_766091)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_766090 Int) (BOUND_VARIABLE_766091 Int)) (= BOUND_VARIABLE_766090 BOUND_VARIABLE_766091)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f4 (bag.filter p3 (bag.union_disjoint (bag.union_disjoint (bag.map leftJoin1 (bag.difference_remove DEPT ((_ table.project 0 1) (bag.filter p0 (table.product DEPT EMP))))) (bag.map rightJoin2 (bag.difference_remove EMP ((_ table.project 2 3 4 5 6 7 8 9 10) (bag.filter p0 (table.product DEPT EMP)))))) (bag.filter p0 (table.product DEPT EMP)))))))
(assert (= q2 (bag.map f8 (bag.union_disjoint (bag.map rightJoin7 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)) ((_ table.project 2 3 4 5 6 7 8 9 10) (bag.filter p6 (table.product DEPT ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP))))))) (bag.filter p6 (table.product DEPT ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP))))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10288 ms.
(reset)
; parsing query SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND NOT EMP.EMPNO = 10
; parsing query SELECT t1.EXPR$0 FROM (SELECT * FROM (VALUES(0)) EXCEPT SELECT * FROM (VALUES(0))) AS t1
;-----------------------------------------------------------
; test name: testReduceConstantsNegated
;Translating sql query: SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND NOT EMP.EMPNO = 10
;Translating sql query: SELECT t1.EXPR$0 FROM (SELECT * FROM (VALUES(0)) EXCEPT SELECT * FROM (VALUES(0))) AS t1
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_808277 Int) (BOUND_VARIABLE_808278 Int)) (= BOUND_VARIABLE_808277 BOUND_VARIABLE_808278)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_808277 Int) (BOUND_VARIABLE_808278 Int)) (= BOUND_VARIABLE_808277 BOUND_VARIABLE_808278)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_808289 Bool)) (not BOUND_VARIABLE_808289)) (nullable.lift (lambda ((BOUND_VARIABLE_808283 Int) (BOUND_VARIABLE_808284 Int)) (= BOUND_VARIABLE_808283 BOUND_VARIABLE_808284)) ((_ tuple.select 0) t) (nullable.some 10)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_808289 Bool)) (not BOUND_VARIABLE_808289)) (nullable.lift (lambda ((BOUND_VARIABLE_808283 Int) (BOUND_VARIABLE_808284 Int)) (= BOUND_VARIABLE_808283 BOUND_VARIABLE_808284)) ((_ tuple.select 0) t) (nullable.some 10))))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_808277 Int) (BOUND_VARIABLE_808278 Int)) (= BOUND_VARIABLE_808277 BOUND_VARIABLE_808278)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_808289 Bool)) (not BOUND_VARIABLE_808289)) (nullable.lift (lambda ((BOUND_VARIABLE_808283 Int) (BOUND_VARIABLE_808284 Int)) (= BOUND_VARIABLE_808283 BOUND_VARIABLE_808284)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_808277 Int) (BOUND_VARIABLE_808278 Int)) (= BOUND_VARIABLE_808277 BOUND_VARIABLE_808278)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_808289 Bool)) (not BOUND_VARIABLE_808289)) (nullable.lift (lambda ((BOUND_VARIABLE_808283 Int) (BOUND_VARIABLE_808284 Int)) (= BOUND_VARIABLE_808283 BOUND_VARIABLE_808284)) ((_ tuple.select 0) t) (nullable.some 10))))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_808277 Int) (BOUND_VARIABLE_808278 Int)) (= BOUND_VARIABLE_808277 BOUND_VARIABLE_808278)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_808277 Int) (BOUND_VARIABLE_808278 Int)) (= BOUND_VARIABLE_808277 BOUND_VARIABLE_808278)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_808289 Bool)) (not BOUND_VARIABLE_808289)) (nullable.lift (lambda ((BOUND_VARIABLE_808283 Int) (BOUND_VARIABLE_808284 Int)) (= BOUND_VARIABLE_808283 BOUND_VARIABLE_808284)) ((_ tuple.select 0) t) (nullable.some 10)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_808289 Bool)) (not BOUND_VARIABLE_808289)) (nullable.lift (lambda ((BOUND_VARIABLE_808283 Int) (BOUND_VARIABLE_808284 Int)) (= BOUND_VARIABLE_808283 BOUND_VARIABLE_808284)) ((_ tuple.select 0) t) (nullable.some 10))))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_808277 Int) (BOUND_VARIABLE_808278 Int)) (= BOUND_VARIABLE_808277 BOUND_VARIABLE_808278)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_808289 Bool)) (not BOUND_VARIABLE_808289)) (nullable.lift (lambda ((BOUND_VARIABLE_808283 Int) (BOUND_VARIABLE_808284 Int)) (= BOUND_VARIABLE_808283 BOUND_VARIABLE_808284)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_808277 Int) (BOUND_VARIABLE_808278 Int)) (= BOUND_VARIABLE_808277 BOUND_VARIABLE_808278)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_808289 Bool)) (not BOUND_VARIABLE_808289)) (nullable.lift (lambda ((BOUND_VARIABLE_808283 Int) (BOUND_VARIABLE_808284 Int)) (= BOUND_VARIABLE_808283 BOUND_VARIABLE_808284)) ((_ tuple.select 0) t) (nullable.some 10)))))))))))))
(assert (= q1 ((_ table.project 0) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0) (bag.difference_remove ((_ table.project 0) (bag (tuple (nullable.some 0)) 1)) ((_ table.project 0) (bag (tuple (nullable.some 0)) 1))))))
(check-sat)
;answer: sat
; duration: 222 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 10) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 0) (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3)) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 10)) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; insert into EMP values(10,NULL,'',0,1,-1,2,-2,3)
; SELECT * FROM (SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND NOT EMP.EMPNO = 10) AS q1 EXCEPT ALL SELECT * FROM (SELECT t1.column1 FROM (SELECT * FROM (VALUES(0)) EXCEPT SELECT * FROM (VALUES(0))) AS t1) AS q2;

; SELECT * FROM (SELECT t1.column1 FROM (SELECT * FROM (VALUES(0)) EXCEPT SELECT * FROM (VALUES(0))) AS t1) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND NOT EMP.EMPNO = 10) AS q1;

;Model soundness: false
(reset)
; parsing query SELECT CASE WHEN 1 = 2 THEN CAST(t0.EXPR$0 AS INTEGER) ELSE 2 END FROM (VALUES  (1)) AS t LEFT JOIN (VALUES  (1)) AS t0 ON TRUE
; parsing query SELECT CAST(2 AS INTEGER) FROM (VALUES  (1)) AS t2 LEFT JOIN (VALUES  (1)) AS t3 ON TRUE
;-----------------------------------------------------------
; test name: testReduceNullableCase
;Translating sql query: SELECT CASE WHEN 1 = 2 THEN CAST(t0.EXPR$0 AS INTEGER) ELSE 2 END FROM (VALUES  (1)) AS t LEFT JOIN (VALUES  (1)) AS t0 ON TRUE
;Translating sql query: SELECT CAST(2 AS INTEGER) FROM (VALUES  (1)) AS t2 LEFT JOIN (VALUES  (1)) AS t3 ON TRUE
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const leftJoin0 (-> (Tuple (Nullable Int)) (Tuple (Nullable Int) (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const leftJoin2 (-> (Tuple (Nullable Int)) (Tuple (Nullable Int) (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= leftJoin0 (lambda ((t (Tuple (Nullable Int)))) (tuple ((_ tuple.select 0) t) (as nullable.null (Nullable Int))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2)))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int)))) (tuple ((_ tuple.select 0) t) (as nullable.null (Nullable Int))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2)))))
(assert (= q1 (bag.map f1 (bag.union_disjoint (bag.map leftJoin0 (bag.difference_remove (bag (tuple (nullable.some 1)) 1) ((_ table.project 0) (table.product (bag (tuple (nullable.some 1)) 1) (bag (tuple (nullable.some 1)) 1))))) (table.product (bag (tuple (nullable.some 1)) 1) (bag (tuple (nullable.some 1)) 1))))))
(assert (= q2 (bag.map f3 (bag.union_disjoint (bag.map leftJoin2 (bag.difference_remove (bag (tuple (nullable.some 1)) 1) ((_ table.project 0) (table.product (bag (tuple (nullable.some 1)) 1) (bag (tuple (nullable.some 1)) 1))))) (table.product (bag (tuple (nullable.some 1)) 1) (bag (tuple (nullable.some 1)) 1))))))
(check-sat)
;answer: unsat
; duration: 6 ms.
(reset)
; parsing query SELECT 1 FROM EMP AS EMP INNER JOIN EMP AS EMP0 ON EMP.DEPTNO = EMP0.DEPTNO
; parsing query SELECT 1 FROM EMP AS EMP1 INNER JOIN EMP AS EMP2 ON EMP1.DEPTNO = EMP2.DEPTNO
;-----------------------------------------------------------
; test name: testTransitiveInferenceConstantEquiPredicate
;Translating sql query: SELECT 1 FROM EMP AS EMP INNER JOIN EMP AS EMP0 ON EMP.DEPTNO = EMP0.DEPTNO
;Translating sql query: SELECT 1 FROM EMP AS EMP1 INNER JOIN EMP AS EMP2 ON EMP1.DEPTNO = EMP2.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_809582 Int) (BOUND_VARIABLE_809583 Int)) (= BOUND_VARIABLE_809582 BOUND_VARIABLE_809583)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_809582 Int) (BOUND_VARIABLE_809583 Int)) (= BOUND_VARIABLE_809582 BOUND_VARIABLE_809583)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_809609 Int) (BOUND_VARIABLE_809610 Int)) (= BOUND_VARIABLE_809609 BOUND_VARIABLE_809610)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_809609 Int) (BOUND_VARIABLE_809610 Int)) (= BOUND_VARIABLE_809609 BOUND_VARIABLE_809610)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f1 (bag.filter p0 (table.product EMP EMP)))))
(assert (= q2 (bag.map f3 (bag.filter p2 (table.product EMP EMP)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10010 ms.
(reset)
; parsing query SELECT t.EXPR$0 + t.EXPR$1 AS X, t.EXPR$1 AS B, t.EXPR$0 AS A FROM (VALUES  (10, 1),  (30, 7)) AS t WHERE t.EXPR$0 - t.EXPR$1 < 0
; parsing query SELECT * FROM (SELECT * FROM (VALUES(0,0,0)) EXCEPT SELECT * FROM (VALUES(0,0,0))) AS t2
;-----------------------------------------------------------
; test name: testReduceValuesToEmpty
;Translating sql query: SELECT t.EXPR$0 + t.EXPR$1 AS X, t.EXPR$1 AS B, t.EXPR$0 AS A FROM (VALUES  (10, 1),  (30, 7)) AS t WHERE t.EXPR$0 - t.EXPR$1 < 0
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES(0,0,0)) EXCEPT SELECT * FROM (VALUES(0,0,0))) AS t2
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_861087 Int) (BOUND_VARIABLE_861088 Int)) (< BOUND_VARIABLE_861087 BOUND_VARIABLE_861088)) (nullable.lift (lambda ((BOUND_VARIABLE_861080 Int) (BOUND_VARIABLE_861081 Int)) (- BOUND_VARIABLE_861080 BOUND_VARIABLE_861081)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_861087 Int) (BOUND_VARIABLE_861088 Int)) (< BOUND_VARIABLE_861087 BOUND_VARIABLE_861088)) (nullable.lift (lambda ((BOUND_VARIABLE_861080 Int) (BOUND_VARIABLE_861081 Int)) (- BOUND_VARIABLE_861080 BOUND_VARIABLE_861081)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 0)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_861107 Int) (BOUND_VARIABLE_861108 Int)) (+ BOUND_VARIABLE_861107 BOUND_VARIABLE_861108)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= q1 (bag.map f1 (bag.filter p0 (bag.union_disjoint (bag (tuple (nullable.some 10) (nullable.some 1)) 1) (bag (tuple (nullable.some 30) (nullable.some 7)) 1))))))
(assert (= q2 ((_ table.project 0 1 2) (bag.difference_remove ((_ table.project 0 1 2) (bag (tuple (nullable.some 0) (nullable.some 0) (nullable.some 0)) 1)) ((_ table.project 0 1 2) (bag (tuple (nullable.some 0) (nullable.some 0) (nullable.some 0)) 1))))))
(check-sat)
;answer: unsat
; duration: 227 ms.
(reset)
; parsing query SELECT EMP.EMPNO + EMP.DEPTNO FROM EMP AS EMP WHERE EMP.SAL = 10 * EMP.COMM AND UPPER(EMP.ENAME) = 'FOO'
; parsing query SELECT t1.EMPNO + t1.DEPTNO FROM (SELECT EMP0.EMPNO, EMP0.ENAME, EMP0.SAL, EMP0.COMM, EMP0.DEPTNO FROM EMP AS EMP0) AS t1 WHERE t1.SAL = 10 * t1.COMM AND UPPER(t1.ENAME) = 'FOO'
;-----------------------------------------------------------
; test name: testPushProjectPastFilter
;Translating sql query: SELECT EMP.EMPNO + EMP.DEPTNO FROM EMP AS EMP WHERE EMP.SAL = 10 * EMP.COMM AND UPPER(EMP.ENAME) = 'FOO'
;Translating sql query: SELECT t1.EMPNO + t1.DEPTNO FROM (SELECT EMP0.EMPNO, EMP0.ENAME, EMP0.SAL, EMP0.COMM, EMP0.DEPTNO FROM EMP AS EMP0) AS t1 WHERE t1.SAL = 10 * t1.COMM AND UPPER(t1.ENAME) = 'FOO'
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_861252 Int) (BOUND_VARIABLE_861253 Int)) (= BOUND_VARIABLE_861252 BOUND_VARIABLE_861253)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_861246 Int) (BOUND_VARIABLE_861247 Int)) (* BOUND_VARIABLE_861246 BOUND_VARIABLE_861247)) (nullable.some 10) ((_ tuple.select 5) t)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_861252 Int) (BOUND_VARIABLE_861253 Int)) (= BOUND_VARIABLE_861252 BOUND_VARIABLE_861253)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_861246 Int) (BOUND_VARIABLE_861247 Int)) (* BOUND_VARIABLE_861246 BOUND_VARIABLE_861247)) (nullable.some 10) ((_ tuple.select 5) t)))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_861267 String) (BOUND_VARIABLE_861268 String)) (= BOUND_VARIABLE_861267 BOUND_VARIABLE_861268)) (nullable.lift (lambda ((BOUND_VARIABLE_861259 String)) (str.to_upper BOUND_VARIABLE_861259)) ((_ tuple.select 1) t)) (nullable.some "FOO"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_861267 String) (BOUND_VARIABLE_861268 String)) (= BOUND_VARIABLE_861267 BOUND_VARIABLE_861268)) (nullable.lift (lambda ((BOUND_VARIABLE_861259 String)) (str.to_upper BOUND_VARIABLE_861259)) ((_ tuple.select 1) t)) (nullable.some "FOO")))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_861252 Int) (BOUND_VARIABLE_861253 Int)) (= BOUND_VARIABLE_861252 BOUND_VARIABLE_861253)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_861246 Int) (BOUND_VARIABLE_861247 Int)) (* BOUND_VARIABLE_861246 BOUND_VARIABLE_861247)) (nullable.some 10) ((_ tuple.select 5) t)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_861267 String) (BOUND_VARIABLE_861268 String)) (= BOUND_VARIABLE_861267 BOUND_VARIABLE_861268)) (nullable.lift (lambda ((BOUND_VARIABLE_861259 String)) (str.to_upper BOUND_VARIABLE_861259)) ((_ tuple.select 1) t)) (nullable.some "FOO")))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_861252 Int) (BOUND_VARIABLE_861253 Int)) (= BOUND_VARIABLE_861252 BOUND_VARIABLE_861253)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_861246 Int) (BOUND_VARIABLE_861247 Int)) (* BOUND_VARIABLE_861246 BOUND_VARIABLE_861247)) (nullable.some 10) ((_ tuple.select 5) t)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_861267 String) (BOUND_VARIABLE_861268 String)) (= BOUND_VARIABLE_861267 BOUND_VARIABLE_861268)) (nullable.lift (lambda ((BOUND_VARIABLE_861259 String)) (str.to_upper BOUND_VARIABLE_861259)) ((_ tuple.select 1) t)) (nullable.some "FOO")))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_861252 Int) (BOUND_VARIABLE_861253 Int)) (= BOUND_VARIABLE_861252 BOUND_VARIABLE_861253)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_861246 Int) (BOUND_VARIABLE_861247 Int)) (* BOUND_VARIABLE_861246 BOUND_VARIABLE_861247)) (nullable.some 10) ((_ tuple.select 5) t)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_861252 Int) (BOUND_VARIABLE_861253 Int)) (= BOUND_VARIABLE_861252 BOUND_VARIABLE_861253)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_861246 Int) (BOUND_VARIABLE_861247 Int)) (* BOUND_VARIABLE_861246 BOUND_VARIABLE_861247)) (nullable.some 10) ((_ tuple.select 5) t)))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_861267 String) (BOUND_VARIABLE_861268 String)) (= BOUND_VARIABLE_861267 BOUND_VARIABLE_861268)) (nullable.lift (lambda ((BOUND_VARIABLE_861259 String)) (str.to_upper BOUND_VARIABLE_861259)) ((_ tuple.select 1) t)) (nullable.some "FOO"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_861267 String) (BOUND_VARIABLE_861268 String)) (= BOUND_VARIABLE_861267 BOUND_VARIABLE_861268)) (nullable.lift (lambda ((BOUND_VARIABLE_861259 String)) (str.to_upper BOUND_VARIABLE_861259)) ((_ tuple.select 1) t)) (nullable.some "FOO")))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_861252 Int) (BOUND_VARIABLE_861253 Int)) (= BOUND_VARIABLE_861252 BOUND_VARIABLE_861253)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_861246 Int) (BOUND_VARIABLE_861247 Int)) (* BOUND_VARIABLE_861246 BOUND_VARIABLE_861247)) (nullable.some 10) ((_ tuple.select 5) t)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_861267 String) (BOUND_VARIABLE_861268 String)) (= BOUND_VARIABLE_861267 BOUND_VARIABLE_861268)) (nullable.lift (lambda ((BOUND_VARIABLE_861259 String)) (str.to_upper BOUND_VARIABLE_861259)) ((_ tuple.select 1) t)) (nullable.some "FOO")))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_861252 Int) (BOUND_VARIABLE_861253 Int)) (= BOUND_VARIABLE_861252 BOUND_VARIABLE_861253)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_861246 Int) (BOUND_VARIABLE_861247 Int)) (* BOUND_VARIABLE_861246 BOUND_VARIABLE_861247)) (nullable.some 10) ((_ tuple.select 5) t)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_861267 String) (BOUND_VARIABLE_861268 String)) (= BOUND_VARIABLE_861267 BOUND_VARIABLE_861268)) (nullable.lift (lambda ((BOUND_VARIABLE_861259 String)) (str.to_upper BOUND_VARIABLE_861259)) ((_ tuple.select 1) t)) (nullable.some "FOO"))))))))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_861300 Int) (BOUND_VARIABLE_861301 Int)) (+ BOUND_VARIABLE_861300 BOUND_VARIABLE_861301)) ((_ tuple.select 0) t) ((_ tuple.select 7) t))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_861351 Int) (BOUND_VARIABLE_861352 Int)) (= BOUND_VARIABLE_861351 BOUND_VARIABLE_861352)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_861345 Int) (BOUND_VARIABLE_861346 Int)) (* BOUND_VARIABLE_861345 BOUND_VARIABLE_861346)) (nullable.some 10) ((_ tuple.select 3) t)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_861351 Int) (BOUND_VARIABLE_861352 Int)) (= BOUND_VARIABLE_861351 BOUND_VARIABLE_861352)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_861345 Int) (BOUND_VARIABLE_861346 Int)) (* BOUND_VARIABLE_861345 BOUND_VARIABLE_861346)) (nullable.some 10) ((_ tuple.select 3) t)))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_861363 String) (BOUND_VARIABLE_861364 String)) (= BOUND_VARIABLE_861363 BOUND_VARIABLE_861364)) (nullable.lift (lambda ((BOUND_VARIABLE_861358 String)) (str.to_upper BOUND_VARIABLE_861358)) ((_ tuple.select 1) t)) (nullable.some "FOO"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_861363 String) (BOUND_VARIABLE_861364 String)) (= BOUND_VARIABLE_861363 BOUND_VARIABLE_861364)) (nullable.lift (lambda ((BOUND_VARIABLE_861358 String)) (str.to_upper BOUND_VARIABLE_861358)) ((_ tuple.select 1) t)) (nullable.some "FOO")))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_861351 Int) (BOUND_VARIABLE_861352 Int)) (= BOUND_VARIABLE_861351 BOUND_VARIABLE_861352)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_861345 Int) (BOUND_VARIABLE_861346 Int)) (* BOUND_VARIABLE_861345 BOUND_VARIABLE_861346)) (nullable.some 10) ((_ tuple.select 3) t)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_861363 String) (BOUND_VARIABLE_861364 String)) (= BOUND_VARIABLE_861363 BOUND_VARIABLE_861364)) (nullable.lift (lambda ((BOUND_VARIABLE_861358 String)) (str.to_upper BOUND_VARIABLE_861358)) ((_ tuple.select 1) t)) (nullable.some "FOO")))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_861351 Int) (BOUND_VARIABLE_861352 Int)) (= BOUND_VARIABLE_861351 BOUND_VARIABLE_861352)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_861345 Int) (BOUND_VARIABLE_861346 Int)) (* BOUND_VARIABLE_861345 BOUND_VARIABLE_861346)) (nullable.some 10) ((_ tuple.select 3) t)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_861363 String) (BOUND_VARIABLE_861364 String)) (= BOUND_VARIABLE_861363 BOUND_VARIABLE_861364)) (nullable.lift (lambda ((BOUND_VARIABLE_861358 String)) (str.to_upper BOUND_VARIABLE_861358)) ((_ tuple.select 1) t)) (nullable.some "FOO")))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_861351 Int) (BOUND_VARIABLE_861352 Int)) (= BOUND_VARIABLE_861351 BOUND_VARIABLE_861352)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_861345 Int) (BOUND_VARIABLE_861346 Int)) (* BOUND_VARIABLE_861345 BOUND_VARIABLE_861346)) (nullable.some 10) ((_ tuple.select 3) t)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_861351 Int) (BOUND_VARIABLE_861352 Int)) (= BOUND_VARIABLE_861351 BOUND_VARIABLE_861352)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_861345 Int) (BOUND_VARIABLE_861346 Int)) (* BOUND_VARIABLE_861345 BOUND_VARIABLE_861346)) (nullable.some 10) ((_ tuple.select 3) t)))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_861363 String) (BOUND_VARIABLE_861364 String)) (= BOUND_VARIABLE_861363 BOUND_VARIABLE_861364)) (nullable.lift (lambda ((BOUND_VARIABLE_861358 String)) (str.to_upper BOUND_VARIABLE_861358)) ((_ tuple.select 1) t)) (nullable.some "FOO"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_861363 String) (BOUND_VARIABLE_861364 String)) (= BOUND_VARIABLE_861363 BOUND_VARIABLE_861364)) (nullable.lift (lambda ((BOUND_VARIABLE_861358 String)) (str.to_upper BOUND_VARIABLE_861358)) ((_ tuple.select 1) t)) (nullable.some "FOO")))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_861351 Int) (BOUND_VARIABLE_861352 Int)) (= BOUND_VARIABLE_861351 BOUND_VARIABLE_861352)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_861345 Int) (BOUND_VARIABLE_861346 Int)) (* BOUND_VARIABLE_861345 BOUND_VARIABLE_861346)) (nullable.some 10) ((_ tuple.select 3) t)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_861363 String) (BOUND_VARIABLE_861364 String)) (= BOUND_VARIABLE_861363 BOUND_VARIABLE_861364)) (nullable.lift (lambda ((BOUND_VARIABLE_861358 String)) (str.to_upper BOUND_VARIABLE_861358)) ((_ tuple.select 1) t)) (nullable.some "FOO")))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_861351 Int) (BOUND_VARIABLE_861352 Int)) (= BOUND_VARIABLE_861351 BOUND_VARIABLE_861352)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_861345 Int) (BOUND_VARIABLE_861346 Int)) (* BOUND_VARIABLE_861345 BOUND_VARIABLE_861346)) (nullable.some 10) ((_ tuple.select 3) t)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_861363 String) (BOUND_VARIABLE_861364 String)) (= BOUND_VARIABLE_861363 BOUND_VARIABLE_861364)) (nullable.lift (lambda ((BOUND_VARIABLE_861358 String)) (str.to_upper BOUND_VARIABLE_861358)) ((_ tuple.select 1) t)) (nullable.some "FOO"))))))))))))
(assert (not (= q1 q2)))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_861397 Int) (BOUND_VARIABLE_861398 Int)) (+ BOUND_VARIABLE_861397 BOUND_VARIABLE_861398)) ((_ tuple.select 0) t) ((_ tuple.select 4) t))))))
(assert (= q1 (bag.map f1 (bag.filter p0 EMP))))
(assert (= q2 (bag.map f3 (bag.filter p2 ((_ table.project 0 1 6 5 7) EMP)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10010 ms.
(reset)
; parsing query SELECT * FROM DEPT AS DEPT INNER JOIN (SELECT EMP.DEPTNO FROM EMP AS EMP) AS t ON DEPT.DEPTNO = t.DEPTNO WHERE DEPT.DEPTNO <= 10
; parsing query SELECT * FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO <= 10) AS t1 INNER JOIN (SELECT EMP0.DEPTNO FROM EMP AS EMP0) AS t2 ON t1.DEPTNO = t2.DEPTNO
;-----------------------------------------------------------
; test name: testPushFilterThroughSemiJoin
;Translating sql query: SELECT * FROM DEPT AS DEPT INNER JOIN (SELECT EMP.DEPTNO FROM EMP AS EMP) AS t ON DEPT.DEPTNO = t.DEPTNO WHERE DEPT.DEPTNO <= 10
;Translating sql query: SELECT * FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO <= 10) AS t1 INNER JOIN (SELECT EMP0.DEPTNO FROM EMP AS EMP0) AS t2 ON t1.DEPTNO = t2.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_897670 Int) (BOUND_VARIABLE_897671 Int)) (= BOUND_VARIABLE_897670 BOUND_VARIABLE_897671)) ((_ tuple.select 0) t) ((_ tuple.select 2) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_897670 Int) (BOUND_VARIABLE_897671 Int)) (= BOUND_VARIABLE_897670 BOUND_VARIABLE_897671)) ((_ tuple.select 0) t) ((_ tuple.select 2) t)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_897690 Int) (BOUND_VARIABLE_897691 Int)) (<= BOUND_VARIABLE_897690 BOUND_VARIABLE_897691)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_897690 Int) (BOUND_VARIABLE_897691 Int)) (<= BOUND_VARIABLE_897690 BOUND_VARIABLE_897691)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_897709 Int) (BOUND_VARIABLE_897710 Int)) (<= BOUND_VARIABLE_897709 BOUND_VARIABLE_897710)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_897709 Int) (BOUND_VARIABLE_897710 Int)) (<= BOUND_VARIABLE_897709 BOUND_VARIABLE_897710)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_897730 Int) (BOUND_VARIABLE_897731 Int)) (= BOUND_VARIABLE_897730 BOUND_VARIABLE_897731)) ((_ tuple.select 0) t) ((_ tuple.select 2) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_897730 Int) (BOUND_VARIABLE_897731 Int)) (= BOUND_VARIABLE_897730 BOUND_VARIABLE_897731)) ((_ tuple.select 0) t) ((_ tuple.select 2) t)))))))
(assert (= q1 ((_ table.project 0 1 2) (bag.filter p1 (bag.filter p0 (table.product DEPT ((_ table.project 7) EMP)))))))
(assert (= q2 ((_ table.project 0 1 2) (bag.filter p3 (table.product ((_ table.project 0 1) (bag.filter p2 DEPT)) ((_ table.project 7) EMP))))))
(check-sat)
;answer: unsat
; duration: 660 ms.
(reset)
; parsing query SELECT 1 FROM (SELECT * FROM (SELECT EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO > 7 UNION ALL SELECT EMP0.DEPTNO FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 10) AS t3 UNION ALL SELECT EMP1.DEPTNO FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 1) AS t6 INNER JOIN EMP AS EMP2 ON t6.DEPTNO = EMP2.DEPTNO
; parsing query SELECT 1 FROM (SELECT * FROM (SELECT EMP3.DEPTNO FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 7 UNION ALL SELECT EMP4.DEPTNO FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 10) AS t12 UNION ALL SELECT EMP5.DEPTNO FROM EMP AS EMP5 WHERE EMP5.DEPTNO > 1) AS t15 INNER JOIN (SELECT * FROM EMP AS EMP6 WHERE EMP6.DEPTNO > 7 OR EMP6.DEPTNO > 10 OR EMP6.DEPTNO > 1) AS t16 ON t15.DEPTNO = t16.DEPTNO
;-----------------------------------------------------------
; test name: testTransitiveInferenceUnion3way
;Translating sql query: SELECT 1 FROM (SELECT * FROM (SELECT EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO > 7 UNION ALL SELECT EMP0.DEPTNO FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 10) AS t3 UNION ALL SELECT EMP1.DEPTNO FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 1) AS t6 INNER JOIN EMP AS EMP2 ON t6.DEPTNO = EMP2.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT * FROM (SELECT EMP3.DEPTNO FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 7 UNION ALL SELECT EMP4.DEPTNO FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 10) AS t12 UNION ALL SELECT EMP5.DEPTNO FROM EMP AS EMP5 WHERE EMP5.DEPTNO > 1) AS t15 INNER JOIN (SELECT * FROM EMP AS EMP6 WHERE EMP6.DEPTNO > 7 OR EMP6.DEPTNO > 10 OR EMP6.DEPTNO > 1) AS t16 ON t15.DEPTNO = t16.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f10 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p9 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_902732 Int) (BOUND_VARIABLE_902733 Int)) (> BOUND_VARIABLE_902732 BOUND_VARIABLE_902733)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_902732 Int) (BOUND_VARIABLE_902733 Int)) (> BOUND_VARIABLE_902732 BOUND_VARIABLE_902733)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_902752 Int) (BOUND_VARIABLE_902753 Int)) (> BOUND_VARIABLE_902752 BOUND_VARIABLE_902753)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_902752 Int) (BOUND_VARIABLE_902753 Int)) (> BOUND_VARIABLE_902752 BOUND_VARIABLE_902753)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_902773 Int) (BOUND_VARIABLE_902774 Int)) (> BOUND_VARIABLE_902773 BOUND_VARIABLE_902774)) ((_ tuple.select 7) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_902773 Int) (BOUND_VARIABLE_902774 Int)) (> BOUND_VARIABLE_902773 BOUND_VARIABLE_902774)) ((_ tuple.select 7) t) (nullable.some 1)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_902795 Int) (BOUND_VARIABLE_902796 Int)) (= BOUND_VARIABLE_902795 BOUND_VARIABLE_902796)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_902795 Int) (BOUND_VARIABLE_902796 Int)) (= BOUND_VARIABLE_902795 BOUND_VARIABLE_902796)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_902821 Int) (BOUND_VARIABLE_902822 Int)) (> BOUND_VARIABLE_902821 BOUND_VARIABLE_902822)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_902821 Int) (BOUND_VARIABLE_902822 Int)) (> BOUND_VARIABLE_902821 BOUND_VARIABLE_902822)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_902840 Int) (BOUND_VARIABLE_902841 Int)) (> BOUND_VARIABLE_902840 BOUND_VARIABLE_902841)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_902840 Int) (BOUND_VARIABLE_902841 Int)) (> BOUND_VARIABLE_902840 BOUND_VARIABLE_902841)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_902861 Int) (BOUND_VARIABLE_902862 Int)) (> BOUND_VARIABLE_902861 BOUND_VARIABLE_902862)) ((_ tuple.select 7) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_902861 Int) (BOUND_VARIABLE_902862 Int)) (> BOUND_VARIABLE_902861 BOUND_VARIABLE_902862)) ((_ tuple.select 7) t) (nullable.some 1)))))))
(assert (= p8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_902881 Int) (BOUND_VARIABLE_902882 Int)) (> BOUND_VARIABLE_902881 BOUND_VARIABLE_902882)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_902881 Int) (BOUND_VARIABLE_902882 Int)) (> BOUND_VARIABLE_902881 BOUND_VARIABLE_902882)) ((_ tuple.select 7) t) (nullable.some 7)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_902887 Int) (BOUND_VARIABLE_902888 Int)) (> BOUND_VARIABLE_902887 BOUND_VARIABLE_902888)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_902887 Int) (BOUND_VARIABLE_902888 Int)) (> BOUND_VARIABLE_902887 BOUND_VARIABLE_902888)) ((_ tuple.select 7) t) (nullable.some 10))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_902881 Int) (BOUND_VARIABLE_902882 Int)) (> BOUND_VARIABLE_902881 BOUND_VARIABLE_902882)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_902887 Int) (BOUND_VARIABLE_902888 Int)) (> BOUND_VARIABLE_902887 BOUND_VARIABLE_902888)) ((_ tuple.select 7) t) (nullable.some 10)))) (or (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_902881 Int) (BOUND_VARIABLE_902882 Int)) (> BOUND_VARIABLE_902881 BOUND_VARIABLE_902882)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_902887 Int) (BOUND_VARIABLE_902888 Int)) (> BOUND_VARIABLE_902887 BOUND_VARIABLE_902888)) ((_ tuple.select 7) t) (nullable.some 10)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_902881 Int) (BOUND_VARIABLE_902882 Int)) (> BOUND_VARIABLE_902881 BOUND_VARIABLE_902882)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_902881 Int) (BOUND_VARIABLE_902882 Int)) (> BOUND_VARIABLE_902881 BOUND_VARIABLE_902882)) ((_ tuple.select 7) t) (nullable.some 7)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_902887 Int) (BOUND_VARIABLE_902888 Int)) (> BOUND_VARIABLE_902887 BOUND_VARIABLE_902888)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_902887 Int) (BOUND_VARIABLE_902888 Int)) (> BOUND_VARIABLE_902887 BOUND_VARIABLE_902888)) ((_ tuple.select 7) t) (nullable.some 10))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_902881 Int) (BOUND_VARIABLE_902882 Int)) (> BOUND_VARIABLE_902881 BOUND_VARIABLE_902882)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_902887 Int) (BOUND_VARIABLE_902888 Int)) (> BOUND_VARIABLE_902887 BOUND_VARIABLE_902888)) ((_ tuple.select 7) t) (nullable.some 10)))) (or (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_902881 Int) (BOUND_VARIABLE_902882 Int)) (> BOUND_VARIABLE_902881 BOUND_VARIABLE_902882)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_902887 Int) (BOUND_VARIABLE_902888 Int)) (> BOUND_VARIABLE_902887 BOUND_VARIABLE_902888)) ((_ tuple.select 7) t) (nullable.some 10))))))))))))
(assert (not (= q1 q2)))
(assert (= p9 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_902926 Int) (BOUND_VARIABLE_902927 Int)) (= BOUND_VARIABLE_902926 BOUND_VARIABLE_902927)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_902926 Int) (BOUND_VARIABLE_902927 Int)) (= BOUND_VARIABLE_902926 BOUND_VARIABLE_902927)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f10 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f4 (bag.filter p3 (table.product (bag.union_disjoint ((_ table.project 0) (bag.union_disjoint ((_ table.project 7) (bag.filter p0 EMP)) ((_ table.project 7) (bag.filter p1 EMP)))) ((_ table.project 7) (bag.filter p2 EMP))) EMP)))))
(assert (= q2 (bag.map f10 (bag.filter p9 (table.product (bag.union_disjoint ((_ table.project 0) (bag.union_disjoint ((_ table.project 7) (bag.filter p5 EMP)) ((_ table.project 7) (bag.filter p6 EMP)))) ((_ table.project 7) (bag.filter p7 EMP))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p8 EMP)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10018 ms.
(reset)
; parsing query SELECT * FROM (SELECT * FROM EMP AS EMP WHERE FALSE) AS t RIGHT JOIN DEPT AS DEPT ON t.DEPTNO = DEPT.DEPTNO
; parsing query SELECT * FROM (SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0)) EXCEPT SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0))) AS t0 RIGHT JOIN DEPT AS DEPT0 ON t0.EXPR$7 = DEPT0.DEPTNO
;-----------------------------------------------------------
; test name: testEmptyJoinRight
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE FALSE) AS t RIGHT JOIN DEPT AS DEPT ON t.DEPTNO = DEPT.DEPTNO
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0)) EXCEPT SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0))) AS t0 RIGHT JOIN DEPT AS DEPT0 ON t0.EXPR$7 = DEPT0.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const rightJoin2 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const rightJoin5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_961154 Int) (BOUND_VARIABLE_961155 Int)) (= BOUND_VARIABLE_961154 BOUND_VARIABLE_961155)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_961154 Int) (BOUND_VARIABLE_961155 Int)) (= BOUND_VARIABLE_961154 BOUND_VARIABLE_961155)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (not (= q1 q2)))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_961254 Int) (BOUND_VARIABLE_961255 Int)) (= BOUND_VARIABLE_961254 BOUND_VARIABLE_961255)) ((_ tuple.select 7) t) ((_ tuple.select 11) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_961254 Int) (BOUND_VARIABLE_961255 Int)) (= BOUND_VARIABLE_961254 BOUND_VARIABLE_961255)) ((_ tuple.select 7) t) ((_ tuple.select 11) t)))))))
(assert (= rightJoin5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map rightJoin2 (bag.difference_remove DEPT ((_ table.project 9 10) (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) DEPT))))) (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) DEPT))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map rightJoin5 (bag.difference_remove (bag.map f3 DEPT) ((_ table.project 9 10 11) (bag.filter p4 (table.product (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0)) 1)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0)) 1))) (bag.map f3 DEPT)))))) (bag.filter p4 (table.product (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0)) 1)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0)) 1))) (bag.map f3 DEPT)))))))
(check-sat)
;answer: unsat
; duration: 1356 ms.
(reset)
; parsing query SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7) AS t LEFT JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO WHERE EMP0.DEPTNO > 9
; parsing query SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t2 LEFT JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t3 ON t2.DEPTNO = t3.DEPTNO WHERE t3.DEPTNO > 9
;-----------------------------------------------------------
; test name: testTransitiveInferenceLeftOuterJoin
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7) AS t LEFT JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO WHERE EMP0.DEPTNO > 9
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t2 LEFT JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t3 ON t2.DEPTNO = t3.DEPTNO WHERE t3.DEPTNO > 9
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f10 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p9 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const leftJoin2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const leftJoin8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_969321 Int) (BOUND_VARIABLE_969322 Int)) (> BOUND_VARIABLE_969321 BOUND_VARIABLE_969322)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_969321 Int) (BOUND_VARIABLE_969322 Int)) (> BOUND_VARIABLE_969321 BOUND_VARIABLE_969322)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_969343 Int) (BOUND_VARIABLE_969344 Int)) (= BOUND_VARIABLE_969343 BOUND_VARIABLE_969344)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_969343 Int) (BOUND_VARIABLE_969344 Int)) (= BOUND_VARIABLE_969343 BOUND_VARIABLE_969344)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_969382 Int) (BOUND_VARIABLE_969383 Int)) (> BOUND_VARIABLE_969382 BOUND_VARIABLE_969383)) ((_ tuple.select 16) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_969382 Int) (BOUND_VARIABLE_969383 Int)) (> BOUND_VARIABLE_969382 BOUND_VARIABLE_969383)) ((_ tuple.select 16) t) (nullable.some 9)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_969408 Int) (BOUND_VARIABLE_969409 Int)) (> BOUND_VARIABLE_969408 BOUND_VARIABLE_969409)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_969408 Int) (BOUND_VARIABLE_969409 Int)) (> BOUND_VARIABLE_969408 BOUND_VARIABLE_969409)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_969427 Int) (BOUND_VARIABLE_969428 Int)) (> BOUND_VARIABLE_969427 BOUND_VARIABLE_969428)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_969427 Int) (BOUND_VARIABLE_969428 Int)) (> BOUND_VARIABLE_969427 BOUND_VARIABLE_969428)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_969448 Int) (BOUND_VARIABLE_969449 Int)) (= BOUND_VARIABLE_969448 BOUND_VARIABLE_969449)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_969448 Int) (BOUND_VARIABLE_969449 Int)) (= BOUND_VARIABLE_969448 BOUND_VARIABLE_969449)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= leftJoin8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (not (= q1 q2)))
(assert (= p9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_969487 Int) (BOUND_VARIABLE_969488 Int)) (> BOUND_VARIABLE_969487 BOUND_VARIABLE_969488)) ((_ tuple.select 16) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_969487 Int) (BOUND_VARIABLE_969488 Int)) (> BOUND_VARIABLE_969487 BOUND_VARIABLE_969488)) ((_ tuple.select 16) t) (nullable.some 9)))))))
(assert (= f10 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f4 (bag.filter p3 (bag.union_disjoint (bag.map leftJoin2 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) EMP))))) (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) EMP)))))))
(assert (= q2 (bag.map f10 (bag.filter p9 (bag.union_disjoint (bag.map leftJoin8 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p7 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p6 EMP))))))) (bag.filter p7 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p6 EMP)))))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10019 ms.
(reset)
; parsing query SELECT CAST(CASE WHEN NULL IS NULL THEN 2 IS NULL WHEN 2 IS NULL THEN NULL IS NULL ELSE NULL = 2 END AS BOOLEAN) FROM (VALUES  (0)) AS t
; parsing query SELECT FALSE FROM (VALUES  (0)) AS t2
;-----------------------------------------------------------
; test name: testReduceConstants2
;Translating sql query: SELECT CAST(CASE WHEN NULL IS NULL THEN 2 IS NULL WHEN 2 IS NULL THEN NULL IS NULL ELSE NULL = 2 END AS BOOLEAN) FROM (VALUES  (0)) AS t
;Translating sql query: SELECT FALSE FROM (VALUES  (0)) AS t2
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const q1 (Bag (Tuple (Nullable Bool))))
(declare-const q2 (Bag (Tuple (Nullable Bool))))
(declare-const f0 (-> (Tuple (Nullable Int)) (Tuple (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable Int)) (Tuple (Nullable Bool))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int)))) (tuple (nullable.some false)))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int)))) (tuple (nullable.some false)))))
(assert (= q1 (bag.map f0 (bag (tuple (nullable.some 0)) 1))))
(assert (= q2 (bag.map f1 (bag (tuple (nullable.some 0)) 1))))
(check-sat)
;answer: unsat
; duration: 187 ms.
(reset)
; parsing query SELECT EMP.SAL FROM EMP AS EMP, (SELECT * FROM EMP AS EMP0 UNION ALL SELECT * FROM EMP AS EMP1) AS t
; parsing query SELECT t1.SAL FROM (SELECT * FROM EMP AS EMP2, EMP AS EMP3 UNION ALL SELECT * FROM EMP AS EMP4, EMP AS EMP5) AS t1
;-----------------------------------------------------------
; test name: testPushJoinThroughUnionOnRight
;Translating sql query: SELECT EMP.SAL FROM EMP AS EMP, (SELECT * FROM EMP AS EMP0 UNION ALL SELECT * FROM EMP AS EMP1) AS t
;Translating sql query: SELECT t1.SAL FROM (SELECT * FROM EMP AS EMP2, EMP AS EMP3 UNION ALL SELECT * FROM EMP AS EMP4, EMP AS EMP5) AS t1
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= q1 ((_ table.project 6) (table.product EMP (bag.union_disjoint ((_ table.project 0 1 2 3 4 5 6 7 8) EMP) ((_ table.project 0 1 2 3 4 5 6 7 8) EMP))))))
(assert (= q2 ((_ table.project 6) (bag.union_disjoint ((_ table.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) (table.product EMP EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) (table.product EMP EMP))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 11958 ms.
(reset)
; parsing query SELECT 1 FROM DEPT AS DEPT FULL JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charlie' AND EMP.SAL > 100
; parsing query SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL > 100) AS t2 ON t1.DEPTNO = t2.DEPTNO
;-----------------------------------------------------------
; test name: testFullOuterJoinSimplificationToInner
;Translating sql query: SELECT 1 FROM DEPT AS DEPT FULL JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charlie' AND EMP.SAL > 100
;Translating sql query: SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL > 100) AS t2 ON t1.DEPTNO = t2.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const f8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const leftJoin1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const rightJoin2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1164451 Int) (BOUND_VARIABLE_1164452 Int)) (= BOUND_VARIABLE_1164451 BOUND_VARIABLE_1164452)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1164451 Int) (BOUND_VARIABLE_1164452 Int)) (= BOUND_VARIABLE_1164451 BOUND_VARIABLE_1164452)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1164507 String) (BOUND_VARIABLE_1164508 String)) (= BOUND_VARIABLE_1164507 BOUND_VARIABLE_1164508)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1164507 String) (BOUND_VARIABLE_1164508 String)) (= BOUND_VARIABLE_1164507 BOUND_VARIABLE_1164508)) ((_ tuple.select 1) t) (nullable.some "Charlie"))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1164514 Int) (BOUND_VARIABLE_1164515 Int)) (> BOUND_VARIABLE_1164514 BOUND_VARIABLE_1164515)) ((_ tuple.select 8) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1164514 Int) (BOUND_VARIABLE_1164515 Int)) (> BOUND_VARIABLE_1164514 BOUND_VARIABLE_1164515)) ((_ tuple.select 8) t) (nullable.some 100)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1164507 String) (BOUND_VARIABLE_1164508 String)) (= BOUND_VARIABLE_1164507 BOUND_VARIABLE_1164508)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1164514 Int) (BOUND_VARIABLE_1164515 Int)) (> BOUND_VARIABLE_1164514 BOUND_VARIABLE_1164515)) ((_ tuple.select 8) t) (nullable.some 100)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1164507 String) (BOUND_VARIABLE_1164508 String)) (= BOUND_VARIABLE_1164507 BOUND_VARIABLE_1164508)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1164514 Int) (BOUND_VARIABLE_1164515 Int)) (> BOUND_VARIABLE_1164514 BOUND_VARIABLE_1164515)) ((_ tuple.select 8) t) (nullable.some 100)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1164507 String) (BOUND_VARIABLE_1164508 String)) (= BOUND_VARIABLE_1164507 BOUND_VARIABLE_1164508)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1164507 String) (BOUND_VARIABLE_1164508 String)) (= BOUND_VARIABLE_1164507 BOUND_VARIABLE_1164508)) ((_ tuple.select 1) t) (nullable.some "Charlie"))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1164514 Int) (BOUND_VARIABLE_1164515 Int)) (> BOUND_VARIABLE_1164514 BOUND_VARIABLE_1164515)) ((_ tuple.select 8) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1164514 Int) (BOUND_VARIABLE_1164515 Int)) (> BOUND_VARIABLE_1164514 BOUND_VARIABLE_1164515)) ((_ tuple.select 8) t) (nullable.some 100)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1164507 String) (BOUND_VARIABLE_1164508 String)) (= BOUND_VARIABLE_1164507 BOUND_VARIABLE_1164508)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1164514 Int) (BOUND_VARIABLE_1164515 Int)) (> BOUND_VARIABLE_1164514 BOUND_VARIABLE_1164515)) ((_ tuple.select 8) t) (nullable.some 100)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1164507 String) (BOUND_VARIABLE_1164508 String)) (= BOUND_VARIABLE_1164507 BOUND_VARIABLE_1164508)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1164514 Int) (BOUND_VARIABLE_1164515 Int)) (> BOUND_VARIABLE_1164514 BOUND_VARIABLE_1164515)) ((_ tuple.select 8) t) (nullable.some 100))))))))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1164554 String) (BOUND_VARIABLE_1164555 String)) (= BOUND_VARIABLE_1164554 BOUND_VARIABLE_1164555)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1164554 String) (BOUND_VARIABLE_1164555 String)) (= BOUND_VARIABLE_1164554 BOUND_VARIABLE_1164555)) ((_ tuple.select 1) t) (nullable.some "Charlie")))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1164574 Int) (BOUND_VARIABLE_1164575 Int)) (> BOUND_VARIABLE_1164574 BOUND_VARIABLE_1164575)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1164574 Int) (BOUND_VARIABLE_1164575 Int)) (> BOUND_VARIABLE_1164574 BOUND_VARIABLE_1164575)) ((_ tuple.select 6) t) (nullable.some 100)))))))
(assert (not (= q1 q2)))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1164595 Int) (BOUND_VARIABLE_1164596 Int)) (= BOUND_VARIABLE_1164595 BOUND_VARIABLE_1164596)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1164595 Int) (BOUND_VARIABLE_1164596 Int)) (= BOUND_VARIABLE_1164595 BOUND_VARIABLE_1164596)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f4 (bag.filter p3 (bag.union_disjoint (bag.union_disjoint (bag.map leftJoin1 (bag.difference_remove DEPT ((_ table.project 0 1) (bag.filter p0 (table.product DEPT EMP))))) (bag.map rightJoin2 (bag.difference_remove EMP ((_ table.project 2 3 4 5 6 7 8 9 10) (bag.filter p0 (table.product DEPT EMP)))))) (bag.filter p0 (table.product DEPT EMP)))))))
(assert (= q2 (bag.map f8 (bag.filter p7 (table.product ((_ table.project 0 1) (bag.filter p5 DEPT)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p6 EMP)))))))
(check-sat)
;answer: unknown (INCOMPLETE)
; duration: 1526 ms.
(reset)
; parsing query SELECT EMP.SAL FROM EMP AS EMP WHERE CASE WHEN EMP.SAL = 1000 THEN NULL ELSE 1 END IS NULL OR CASE WHEN EMP.SAL = 2000 THEN NULL ELSE 1 END IS NULL
; parsing query SELECT EMP0.SAL FROM EMP AS EMP0 WHERE EMP0.SAL = 1000 OR EMP0.SAL = 2000
;-----------------------------------------------------------
; test name: testReduceOrCaseWhen
;Translating sql query: SELECT EMP.SAL FROM EMP AS EMP WHERE CASE WHEN EMP.SAL = 1000 THEN NULL ELSE 1 END IS NULL OR CASE WHEN EMP.SAL = 2000 THEN NULL ELSE 1 END IS NULL
;Translating sql query: SELECT EMP0.SAL FROM EMP AS EMP0 WHERE EMP0.SAL = 1000 OR EMP0.SAL = 2000
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1171118 Int) (BOUND_VARIABLE_1171119 Int)) (= BOUND_VARIABLE_1171118 BOUND_VARIABLE_1171119)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1171118 Int) (BOUND_VARIABLE_1171119 Int)) (= BOUND_VARIABLE_1171118 BOUND_VARIABLE_1171119)) ((_ tuple.select 6) t) (nullable.some 1000)))) (as nullable.null (Nullable Int)) (nullable.some 1))))) (nullable.val (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1171118 Int) (BOUND_VARIABLE_1171119 Int)) (= BOUND_VARIABLE_1171118 BOUND_VARIABLE_1171119)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1171118 Int) (BOUND_VARIABLE_1171119 Int)) (= BOUND_VARIABLE_1171118 BOUND_VARIABLE_1171119)) ((_ tuple.select 6) t) (nullable.some 1000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))))) (and (nullable.is_some (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1171142 Int) (BOUND_VARIABLE_1171143 Int)) (= BOUND_VARIABLE_1171142 BOUND_VARIABLE_1171143)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1171142 Int) (BOUND_VARIABLE_1171143 Int)) (= BOUND_VARIABLE_1171142 BOUND_VARIABLE_1171143)) ((_ tuple.select 6) t) (nullable.some 2000)))) (as nullable.null (Nullable Int)) (nullable.some 1))))) (nullable.val (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1171142 Int) (BOUND_VARIABLE_1171143 Int)) (= BOUND_VARIABLE_1171142 BOUND_VARIABLE_1171143)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1171142 Int) (BOUND_VARIABLE_1171143 Int)) (= BOUND_VARIABLE_1171142 BOUND_VARIABLE_1171143)) ((_ tuple.select 6) t) (nullable.some 2000)))) (as nullable.null (Nullable Int)) (nullable.some 1))))))) (and (and (nullable.is_some (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1171118 Int) (BOUND_VARIABLE_1171119 Int)) (= BOUND_VARIABLE_1171118 BOUND_VARIABLE_1171119)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1171118 Int) (BOUND_VARIABLE_1171119 Int)) (= BOUND_VARIABLE_1171118 BOUND_VARIABLE_1171119)) ((_ tuple.select 6) t) (nullable.some 1000)))) (as nullable.null (Nullable Int)) (nullable.some 1))))) (nullable.is_some (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1171142 Int) (BOUND_VARIABLE_1171143 Int)) (= BOUND_VARIABLE_1171142 BOUND_VARIABLE_1171143)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1171142 Int) (BOUND_VARIABLE_1171143 Int)) (= BOUND_VARIABLE_1171142 BOUND_VARIABLE_1171143)) ((_ tuple.select 6) t) (nullable.some 2000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))))) (or (nullable.val (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1171118 Int) (BOUND_VARIABLE_1171119 Int)) (= BOUND_VARIABLE_1171118 BOUND_VARIABLE_1171119)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1171118 Int) (BOUND_VARIABLE_1171119 Int)) (= BOUND_VARIABLE_1171118 BOUND_VARIABLE_1171119)) ((_ tuple.select 6) t) (nullable.some 1000)))) (as nullable.null (Nullable Int)) (nullable.some 1))))) (nullable.val (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1171142 Int) (BOUND_VARIABLE_1171143 Int)) (= BOUND_VARIABLE_1171142 BOUND_VARIABLE_1171143)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1171142 Int) (BOUND_VARIABLE_1171143 Int)) (= BOUND_VARIABLE_1171142 BOUND_VARIABLE_1171143)) ((_ tuple.select 6) t) (nullable.some 2000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1171118 Int) (BOUND_VARIABLE_1171119 Int)) (= BOUND_VARIABLE_1171118 BOUND_VARIABLE_1171119)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1171118 Int) (BOUND_VARIABLE_1171119 Int)) (= BOUND_VARIABLE_1171118 BOUND_VARIABLE_1171119)) ((_ tuple.select 6) t) (nullable.some 1000)))) (as nullable.null (Nullable Int)) (nullable.some 1))))) (nullable.val (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1171118 Int) (BOUND_VARIABLE_1171119 Int)) (= BOUND_VARIABLE_1171118 BOUND_VARIABLE_1171119)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1171118 Int) (BOUND_VARIABLE_1171119 Int)) (= BOUND_VARIABLE_1171118 BOUND_VARIABLE_1171119)) ((_ tuple.select 6) t) (nullable.some 1000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))))) (and (nullable.is_some (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1171142 Int) (BOUND_VARIABLE_1171143 Int)) (= BOUND_VARIABLE_1171142 BOUND_VARIABLE_1171143)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1171142 Int) (BOUND_VARIABLE_1171143 Int)) (= BOUND_VARIABLE_1171142 BOUND_VARIABLE_1171143)) ((_ tuple.select 6) t) (nullable.some 2000)))) (as nullable.null (Nullable Int)) (nullable.some 1))))) (nullable.val (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1171142 Int) (BOUND_VARIABLE_1171143 Int)) (= BOUND_VARIABLE_1171142 BOUND_VARIABLE_1171143)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1171142 Int) (BOUND_VARIABLE_1171143 Int)) (= BOUND_VARIABLE_1171142 BOUND_VARIABLE_1171143)) ((_ tuple.select 6) t) (nullable.some 2000)))) (as nullable.null (Nullable Int)) (nullable.some 1))))))) (and (and (nullable.is_some (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1171118 Int) (BOUND_VARIABLE_1171119 Int)) (= BOUND_VARIABLE_1171118 BOUND_VARIABLE_1171119)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1171118 Int) (BOUND_VARIABLE_1171119 Int)) (= BOUND_VARIABLE_1171118 BOUND_VARIABLE_1171119)) ((_ tuple.select 6) t) (nullable.some 1000)))) (as nullable.null (Nullable Int)) (nullable.some 1))))) (nullable.is_some (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1171142 Int) (BOUND_VARIABLE_1171143 Int)) (= BOUND_VARIABLE_1171142 BOUND_VARIABLE_1171143)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1171142 Int) (BOUND_VARIABLE_1171143 Int)) (= BOUND_VARIABLE_1171142 BOUND_VARIABLE_1171143)) ((_ tuple.select 6) t) (nullable.some 2000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))))) (or (nullable.val (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1171118 Int) (BOUND_VARIABLE_1171119 Int)) (= BOUND_VARIABLE_1171118 BOUND_VARIABLE_1171119)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1171118 Int) (BOUND_VARIABLE_1171119 Int)) (= BOUND_VARIABLE_1171118 BOUND_VARIABLE_1171119)) ((_ tuple.select 6) t) (nullable.some 1000)))) (as nullable.null (Nullable Int)) (nullable.some 1))))) (nullable.val (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1171142 Int) (BOUND_VARIABLE_1171143 Int)) (= BOUND_VARIABLE_1171142 BOUND_VARIABLE_1171143)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1171142 Int) (BOUND_VARIABLE_1171143 Int)) (= BOUND_VARIABLE_1171142 BOUND_VARIABLE_1171143)) ((_ tuple.select 6) t) (nullable.some 2000)))) (as nullable.null (Nullable Int)) (nullable.some 1))))))))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1171179 Int) (BOUND_VARIABLE_1171180 Int)) (= BOUND_VARIABLE_1171179 BOUND_VARIABLE_1171180)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1171179 Int) (BOUND_VARIABLE_1171180 Int)) (= BOUND_VARIABLE_1171179 BOUND_VARIABLE_1171180)) ((_ tuple.select 6) t) (nullable.some 1000)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1171185 Int) (BOUND_VARIABLE_1171186 Int)) (= BOUND_VARIABLE_1171185 BOUND_VARIABLE_1171186)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1171185 Int) (BOUND_VARIABLE_1171186 Int)) (= BOUND_VARIABLE_1171185 BOUND_VARIABLE_1171186)) ((_ tuple.select 6) t) (nullable.some 2000))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1171179 Int) (BOUND_VARIABLE_1171180 Int)) (= BOUND_VARIABLE_1171179 BOUND_VARIABLE_1171180)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1171185 Int) (BOUND_VARIABLE_1171186 Int)) (= BOUND_VARIABLE_1171185 BOUND_VARIABLE_1171186)) ((_ tuple.select 6) t) (nullable.some 2000)))) (or (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1171179 Int) (BOUND_VARIABLE_1171180 Int)) (= BOUND_VARIABLE_1171179 BOUND_VARIABLE_1171180)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1171185 Int) (BOUND_VARIABLE_1171186 Int)) (= BOUND_VARIABLE_1171185 BOUND_VARIABLE_1171186)) ((_ tuple.select 6) t) (nullable.some 2000)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1171179 Int) (BOUND_VARIABLE_1171180 Int)) (= BOUND_VARIABLE_1171179 BOUND_VARIABLE_1171180)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1171179 Int) (BOUND_VARIABLE_1171180 Int)) (= BOUND_VARIABLE_1171179 BOUND_VARIABLE_1171180)) ((_ tuple.select 6) t) (nullable.some 1000)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1171185 Int) (BOUND_VARIABLE_1171186 Int)) (= BOUND_VARIABLE_1171185 BOUND_VARIABLE_1171186)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1171185 Int) (BOUND_VARIABLE_1171186 Int)) (= BOUND_VARIABLE_1171185 BOUND_VARIABLE_1171186)) ((_ tuple.select 6) t) (nullable.some 2000))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1171179 Int) (BOUND_VARIABLE_1171180 Int)) (= BOUND_VARIABLE_1171179 BOUND_VARIABLE_1171180)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1171185 Int) (BOUND_VARIABLE_1171186 Int)) (= BOUND_VARIABLE_1171185 BOUND_VARIABLE_1171186)) ((_ tuple.select 6) t) (nullable.some 2000)))) (or (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1171179 Int) (BOUND_VARIABLE_1171180 Int)) (= BOUND_VARIABLE_1171179 BOUND_VARIABLE_1171180)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1171185 Int) (BOUND_VARIABLE_1171186 Int)) (= BOUND_VARIABLE_1171185 BOUND_VARIABLE_1171186)) ((_ tuple.select 6) t) (nullable.some 2000))))))))))))
(assert (= q1 ((_ table.project 6) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 6) (bag.filter p1 EMP))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10016 ms.
(reset)
; parsing query SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION ALL SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION ALL SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
; parsing query SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 UNION ALL SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION ALL SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
;-----------------------------------------------------------
; test name: testMergeUnionAll
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION ALL SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION ALL SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
;Translating sql query: SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 UNION ALL SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION ALL SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1213059 Int) (BOUND_VARIABLE_1213060 Int)) (= BOUND_VARIABLE_1213059 BOUND_VARIABLE_1213060)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1213059 Int) (BOUND_VARIABLE_1213060 Int)) (= BOUND_VARIABLE_1213059 BOUND_VARIABLE_1213060)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1213079 Int) (BOUND_VARIABLE_1213080 Int)) (= BOUND_VARIABLE_1213079 BOUND_VARIABLE_1213080)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1213079 Int) (BOUND_VARIABLE_1213080 Int)) (= BOUND_VARIABLE_1213079 BOUND_VARIABLE_1213080)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1213100 Int) (BOUND_VARIABLE_1213101 Int)) (= BOUND_VARIABLE_1213100 BOUND_VARIABLE_1213101)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1213100 Int) (BOUND_VARIABLE_1213101 Int)) (= BOUND_VARIABLE_1213100 BOUND_VARIABLE_1213101)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1213120 Int) (BOUND_VARIABLE_1213121 Int)) (= BOUND_VARIABLE_1213120 BOUND_VARIABLE_1213121)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1213120 Int) (BOUND_VARIABLE_1213121 Int)) (= BOUND_VARIABLE_1213120 BOUND_VARIABLE_1213121)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1213139 Int) (BOUND_VARIABLE_1213140 Int)) (= BOUND_VARIABLE_1213139 BOUND_VARIABLE_1213140)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1213139 Int) (BOUND_VARIABLE_1213140 Int)) (= BOUND_VARIABLE_1213139 BOUND_VARIABLE_1213140)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1213159 Int) (BOUND_VARIABLE_1213160 Int)) (= BOUND_VARIABLE_1213159 BOUND_VARIABLE_1213160)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1213159 Int) (BOUND_VARIABLE_1213160 Int)) (= BOUND_VARIABLE_1213159 BOUND_VARIABLE_1213160)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (bag.union_disjoint ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.union_disjoint ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)))))
(assert (= q2 (bag.union_disjoint (bag.union_disjoint ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)))))
(check-sat)
;answer: unsat
; duration: 1005 ms.
(reset)
; parsing query SELECT 1 FROM DEPT AS DEPT LEFT JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE EMP.SAL > 100
; parsing query SELECT 1 FROM DEPT AS DEPT0 INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL > 100) AS t1 ON DEPT0.DEPTNO = t1.DEPTNO
;-----------------------------------------------------------
; test name: testLeftOuterJoinSimplificationToInner
;Translating sql query: SELECT 1 FROM DEPT AS DEPT LEFT JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE EMP.SAL > 100
;Translating sql query: SELECT 1 FROM DEPT AS DEPT0 INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL > 100) AS t1 ON DEPT0.DEPTNO = t1.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const leftJoin1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1221579 Int) (BOUND_VARIABLE_1221580 Int)) (= BOUND_VARIABLE_1221579 BOUND_VARIABLE_1221580)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1221579 Int) (BOUND_VARIABLE_1221580 Int)) (= BOUND_VARIABLE_1221579 BOUND_VARIABLE_1221580)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1221612 Int) (BOUND_VARIABLE_1221613 Int)) (> BOUND_VARIABLE_1221612 BOUND_VARIABLE_1221613)) ((_ tuple.select 8) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1221612 Int) (BOUND_VARIABLE_1221613 Int)) (> BOUND_VARIABLE_1221612 BOUND_VARIABLE_1221613)) ((_ tuple.select 8) t) (nullable.some 100)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1221638 Int) (BOUND_VARIABLE_1221639 Int)) (> BOUND_VARIABLE_1221638 BOUND_VARIABLE_1221639)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1221638 Int) (BOUND_VARIABLE_1221639 Int)) (> BOUND_VARIABLE_1221638 BOUND_VARIABLE_1221639)) ((_ tuple.select 6) t) (nullable.some 100)))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1221659 Int) (BOUND_VARIABLE_1221660 Int)) (= BOUND_VARIABLE_1221659 BOUND_VARIABLE_1221660)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1221659 Int) (BOUND_VARIABLE_1221660 Int)) (= BOUND_VARIABLE_1221659 BOUND_VARIABLE_1221660)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f3 (bag.filter p2 (bag.union_disjoint (bag.map leftJoin1 (bag.difference_remove DEPT ((_ table.project 0 1) (bag.filter p0 (table.product DEPT EMP))))) (bag.filter p0 (table.product DEPT EMP)))))))
(assert (= q2 (bag.map f6 (bag.filter p5 (table.product DEPT ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10022 ms.
(reset)
; parsing query SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES  (30, 3)) AS t EXCEPT SELECT * FROM (VALUES  (20, 2)) AS t0 WHERE t0.EXPR$0 > 30) AS t2 EXCEPT SELECT * FROM (VALUES  (40, 4)) AS t3) AS t4 EXCEPT SELECT * FROM (VALUES  (50, 5)) AS t5 WHERE t5.EXPR$0 > 50
; parsing query SELECT * FROM (VALUES  (30, 3)) AS t8 EXCEPT SELECT * FROM (VALUES  (40, 4)) AS t9
;-----------------------------------------------------------
; test name: testEmptyMinus2
;Translating sql query: SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES  (30, 3)) AS t EXCEPT SELECT * FROM (VALUES  (20, 2)) AS t0 WHERE t0.EXPR$0 > 30) AS t2 EXCEPT SELECT * FROM (VALUES  (40, 4)) AS t3) AS t4 EXCEPT SELECT * FROM (VALUES  (50, 5)) AS t5 WHERE t5.EXPR$0 > 50
;Translating sql query: SELECT * FROM (VALUES  (30, 3)) AS t8 EXCEPT SELECT * FROM (VALUES  (40, 4)) AS t9
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1263151 Int) (BOUND_VARIABLE_1263152 Int)) (> BOUND_VARIABLE_1263151 BOUND_VARIABLE_1263152)) ((_ tuple.select 0) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1263151 Int) (BOUND_VARIABLE_1263152 Int)) (> BOUND_VARIABLE_1263151 BOUND_VARIABLE_1263152)) ((_ tuple.select 0) t) (nullable.some 30)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1263183 Int) (BOUND_VARIABLE_1263184 Int)) (> BOUND_VARIABLE_1263183 BOUND_VARIABLE_1263184)) ((_ tuple.select 0) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1263183 Int) (BOUND_VARIABLE_1263184 Int)) (> BOUND_VARIABLE_1263183 BOUND_VARIABLE_1263184)) ((_ tuple.select 0) t) (nullable.some 50)))))))
(assert (= q1 (bag.difference_remove ((_ table.project 0 1) (bag.difference_remove ((_ table.project 0 1) (bag.difference_remove ((_ table.project 0 1) (bag (tuple (nullable.some 30) (nullable.some 3)) 1)) ((_ table.project 0 1) (bag.filter p0 (bag (tuple (nullable.some 20) (nullable.some 2)) 1))))) ((_ table.project 0 1) (bag (tuple (nullable.some 40) (nullable.some 4)) 1)))) ((_ table.project 0 1) (bag.filter p1 (bag (tuple (nullable.some 50) (nullable.some 5)) 1))))))
(assert (= q2 (bag.difference_remove ((_ table.project 0 1) (bag (tuple (nullable.some 30) (nullable.some 3)) 1)) ((_ table.project 0 1) (bag (tuple (nullable.some 40) (nullable.some 4)) 1)))))
(check-sat)
;answer: unsat
; duration: 153 ms.
(reset)
; parsing query SELECT 1 + 2, t0.DEPTNO + (3 + 4), 5 + 6 + t0.DEPTNO, CAST(NULL AS INT), CASE WHEN 2 IS NOT NULL THEN 2 ELSE NULL END, ROW(7 + 8) FROM (SELECT DEPT.DEPTNO, DEPT.NAME, t.EMPNO, t.ENAME, t.JOB, t.MGR, t.HIREDATE, t.SAL, t.COMM, t.DEPTNO AS DEPTNO0, t.SLACKER FROM DEPT AS DEPT INNER JOIN (SELECT EMP.EMPNO, EMP.ENAME, EMP.JOB, EMP.MGR, EMP.HIREDATE, EMP.SAL, EMP.COMM, EMP.DEPTNO, EMP.SLACKER, EMP.DEPTNO + (5 - 5) AS f9 FROM EMP AS EMP) AS t ON DEPT.DEPTNO = t.f9) AS t0 WHERE t0.DEPTNO = 7 + 8 AND t0.DEPTNO = 8 + 7 AND t0.DEPTNO = CASE WHEN 2 IS NOT NULL THEN 2 ELSE NULL END
; parsing query SELECT 3, 22, 26, CAST(NULL AS INT), CAST(2 AS INTEGER), ROW(15) FROM (SELECT * FROM (VALUES(0,0,0,0,0,0)) WHERE FALSE) AS t3
;-----------------------------------------------------------
; test name: testReduceConstants
;Translating sql query: SELECT 1 + 2, t0.DEPTNO + (3 + 4), 5 + 6 + t0.DEPTNO, CAST(NULL AS INT), CASE WHEN 2 IS NOT NULL THEN 2 ELSE NULL END, ROW(7 + 8) FROM (SELECT DEPT.DEPTNO, DEPT.NAME, t.EMPNO, t.ENAME, t.JOB, t.MGR, t.HIREDATE, t.SAL, t.COMM, t.DEPTNO AS DEPTNO0, t.SLACKER FROM DEPT AS DEPT INNER JOIN (SELECT EMP.EMPNO, EMP.ENAME, EMP.JOB, EMP.MGR, EMP.HIREDATE, EMP.SAL, EMP.COMM, EMP.DEPTNO, EMP.SLACKER, EMP.DEPTNO + (5 - 5) AS f9 FROM EMP AS EMP) AS t ON DEPT.DEPTNO = t.f9) AS t0 WHERE t0.DEPTNO = 7 + 8 AND t0.DEPTNO = 8 + 7 AND t0.DEPTNO = CASE WHEN 2 IS NOT NULL THEN 2 ELSE NULL END
;Translating sql query: SELECT 3, 22, 26, CAST(NULL AS INT), CAST(2 AS INTEGER), ROW(15) FROM (SELECT * FROM (VALUES(0,0,0,0,0,0)) WHERE FALSE) AS t3
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const f6 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 6) t) ((_ tuple.select 5) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_1263412 Int) (BOUND_VARIABLE_1263413 Int)) (+ BOUND_VARIABLE_1263412 BOUND_VARIABLE_1263413)) ((_ tuple.select 7) t) (nullable.lift (lambda ((BOUND_VARIABLE_1263406 Int) (BOUND_VARIABLE_1263407 Int)) (- BOUND_VARIABLE_1263406 BOUND_VARIABLE_1263407)) (nullable.some 5) (nullable.some 5)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1263482 Int) (BOUND_VARIABLE_1263483 Int)) (= BOUND_VARIABLE_1263482 BOUND_VARIABLE_1263483)) ((_ tuple.select 2) t) ((_ tuple.select 12) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1263482 Int) (BOUND_VARIABLE_1263483 Int)) (= BOUND_VARIABLE_1263482 BOUND_VARIABLE_1263483)) ((_ tuple.select 2) t) ((_ tuple.select 12) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1263509 Int) (BOUND_VARIABLE_1263510 Int)) (= BOUND_VARIABLE_1263509 BOUND_VARIABLE_1263510)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_1263503 Int) (BOUND_VARIABLE_1263504 Int)) (+ BOUND_VARIABLE_1263503 BOUND_VARIABLE_1263504)) (nullable.some 7) (nullable.some 8)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1263509 Int) (BOUND_VARIABLE_1263510 Int)) (= BOUND_VARIABLE_1263509 BOUND_VARIABLE_1263510)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_1263503 Int) (BOUND_VARIABLE_1263504 Int)) (+ BOUND_VARIABLE_1263503 BOUND_VARIABLE_1263504)) (nullable.some 7) (nullable.some 8)))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1263521 Int) (BOUND_VARIABLE_1263522 Int)) (= BOUND_VARIABLE_1263521 BOUND_VARIABLE_1263522)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_1263515 Int) (BOUND_VARIABLE_1263516 Int)) (+ BOUND_VARIABLE_1263515 BOUND_VARIABLE_1263516)) (nullable.some 8) (nullable.some 7)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1263521 Int) (BOUND_VARIABLE_1263522 Int)) (= BOUND_VARIABLE_1263521 BOUND_VARIABLE_1263522)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_1263515 Int) (BOUND_VARIABLE_1263516 Int)) (+ BOUND_VARIABLE_1263515 BOUND_VARIABLE_1263516)) (nullable.some 8) (nullable.some 7))))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1263509 Int) (BOUND_VARIABLE_1263510 Int)) (= BOUND_VARIABLE_1263509 BOUND_VARIABLE_1263510)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_1263503 Int) (BOUND_VARIABLE_1263504 Int)) (+ BOUND_VARIABLE_1263503 BOUND_VARIABLE_1263504)) (nullable.some 7) (nullable.some 8)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1263521 Int) (BOUND_VARIABLE_1263522 Int)) (= BOUND_VARIABLE_1263521 BOUND_VARIABLE_1263522)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_1263515 Int) (BOUND_VARIABLE_1263516 Int)) (+ BOUND_VARIABLE_1263515 BOUND_VARIABLE_1263516)) (nullable.some 8) (nullable.some 7))))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1263509 Int) (BOUND_VARIABLE_1263510 Int)) (= BOUND_VARIABLE_1263509 BOUND_VARIABLE_1263510)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_1263503 Int) (BOUND_VARIABLE_1263504 Int)) (+ BOUND_VARIABLE_1263503 BOUND_VARIABLE_1263504)) (nullable.some 7) (nullable.some 8)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1263521 Int) (BOUND_VARIABLE_1263522 Int)) (= BOUND_VARIABLE_1263521 BOUND_VARIABLE_1263522)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_1263515 Int) (BOUND_VARIABLE_1263516 Int)) (+ BOUND_VARIABLE_1263515 BOUND_VARIABLE_1263516)) (nullable.some 8) (nullable.some 7))))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1263509 Int) (BOUND_VARIABLE_1263510 Int)) (= BOUND_VARIABLE_1263509 BOUND_VARIABLE_1263510)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_1263503 Int) (BOUND_VARIABLE_1263504 Int)) (+ BOUND_VARIABLE_1263503 BOUND_VARIABLE_1263504)) (nullable.some 7) (nullable.some 8)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1263509 Int) (BOUND_VARIABLE_1263510 Int)) (= BOUND_VARIABLE_1263509 BOUND_VARIABLE_1263510)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_1263503 Int) (BOUND_VARIABLE_1263504 Int)) (+ BOUND_VARIABLE_1263503 BOUND_VARIABLE_1263504)) (nullable.some 7) (nullable.some 8)))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1263521 Int) (BOUND_VARIABLE_1263522 Int)) (= BOUND_VARIABLE_1263521 BOUND_VARIABLE_1263522)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_1263515 Int) (BOUND_VARIABLE_1263516 Int)) (+ BOUND_VARIABLE_1263515 BOUND_VARIABLE_1263516)) (nullable.some 8) (nullable.some 7)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1263521 Int) (BOUND_VARIABLE_1263522 Int)) (= BOUND_VARIABLE_1263521 BOUND_VARIABLE_1263522)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_1263515 Int) (BOUND_VARIABLE_1263516 Int)) (+ BOUND_VARIABLE_1263515 BOUND_VARIABLE_1263516)) (nullable.some 8) (nullable.some 7))))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1263509 Int) (BOUND_VARIABLE_1263510 Int)) (= BOUND_VARIABLE_1263509 BOUND_VARIABLE_1263510)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_1263503 Int) (BOUND_VARIABLE_1263504 Int)) (+ BOUND_VARIABLE_1263503 BOUND_VARIABLE_1263504)) (nullable.some 7) (nullable.some 8)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1263521 Int) (BOUND_VARIABLE_1263522 Int)) (= BOUND_VARIABLE_1263521 BOUND_VARIABLE_1263522)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_1263515 Int) (BOUND_VARIABLE_1263516 Int)) (+ BOUND_VARIABLE_1263515 BOUND_VARIABLE_1263516)) (nullable.some 8) (nullable.some 7))))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1263509 Int) (BOUND_VARIABLE_1263510 Int)) (= BOUND_VARIABLE_1263509 BOUND_VARIABLE_1263510)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_1263503 Int) (BOUND_VARIABLE_1263504 Int)) (+ BOUND_VARIABLE_1263503 BOUND_VARIABLE_1263504)) (nullable.some 7) (nullable.some 8)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1263521 Int) (BOUND_VARIABLE_1263522 Int)) (= BOUND_VARIABLE_1263521 BOUND_VARIABLE_1263522)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_1263515 Int) (BOUND_VARIABLE_1263516 Int)) (+ BOUND_VARIABLE_1263515 BOUND_VARIABLE_1263516)) (nullable.some 8) (nullable.some 7)))))))))))))
(assert (not (= q1 q2)))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_1263588 Int) (BOUND_VARIABLE_1263589 Int)) (+ BOUND_VARIABLE_1263588 BOUND_VARIABLE_1263589)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_1263603 Int) (BOUND_VARIABLE_1263604 Int)) (+ BOUND_VARIABLE_1263603 BOUND_VARIABLE_1263604)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_1263597 Int) (BOUND_VARIABLE_1263598 Int)) (+ BOUND_VARIABLE_1263597 BOUND_VARIABLE_1263598)) (nullable.some 3) (nullable.some 4))) (nullable.lift (lambda ((BOUND_VARIABLE_1263615 Int) (BOUND_VARIABLE_1263616 Int)) (+ BOUND_VARIABLE_1263615 BOUND_VARIABLE_1263616)) (nullable.lift (lambda ((BOUND_VARIABLE_1263609 Int) (BOUND_VARIABLE_1263610 Int)) (+ BOUND_VARIABLE_1263609 BOUND_VARIABLE_1263610)) (nullable.some 5) (nullable.some 6)) ((_ tuple.select 0) t)) (as nullable.null (Nullable Int)) (nullable.some 2) (nullable.lift (lambda ((BOUND_VARIABLE_1263621 Int) (BOUND_VARIABLE_1263622 Int)) (+ BOUND_VARIABLE_1263621 BOUND_VARIABLE_1263622)) (nullable.some 7) (nullable.some 8))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 3) (nullable.some 22) (nullable.some 26) (as nullable.null (Nullable Int)) (nullable.some 2) (nullable.some 15)))))
(assert (= q1 (bag.map f4 (bag.filter p3 ((_ table.project 0 1 3 4 5 6 7 8 9 10 11) (bag.filter p2 (table.product (bag.map f0 DEPT) (bag.map f1 EMP))))))))
(assert (= q2 (bag.map f6 (bag.filter p5 (bag (tuple (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0)) 1)))))
(check-sat)
;answer: sat
; duration: 303 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 1) (nullable.some (- 1)) (nullable.some (- 3)) (nullable.some (- 2)) (nullable.some 15) (nullable.some 4)) 1))
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 15) (nullable.some "A")) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 3) (nullable.some 22) (nullable.some 26) (as nullable.null (Nullable Int)) (nullable.some 2) (nullable.some 15)) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; insert into EMP values(0,NULL,'',1,-1,-3,-2,15,4)
; insert into DEPT values(15,'A')
; SELECT * FROM (SELECT 1 + 2, t0.DEPTNO + (3 + 4), 5 + 6 + t0.DEPTNO, CAST(NULL AS INT), CASE WHEN 2 IS NOT NULL THEN 2 ELSE NULL END, ROW(7 + 8) FROM (SELECT DEPT.DEPTNO, DEPT.NAME, t.EMPNO, t.ENAME, t.JOB, t.MGR, t.HIREDATE, t.SAL, t.COMM, t.DEPTNO AS DEPTNO0, t.SLACKER FROM DEPT AS DEPT INNER JOIN (SELECT EMP.EMPNO, EMP.ENAME, EMP.JOB, EMP.MGR, EMP.HIREDATE, EMP.SAL, EMP.COMM, EMP.DEPTNO, EMP.SLACKER, EMP.DEPTNO + (5 - 5) AS f9 FROM EMP AS EMP) AS t ON DEPT.DEPTNO = t.f9) AS t0 WHERE t0.DEPTNO = 7 + 8 AND t0.DEPTNO = 8 + 7 AND t0.DEPTNO = CASE WHEN 2 IS NOT NULL THEN 2 ELSE NULL END) AS q1 EXCEPT ALL SELECT * FROM (SELECT 3, 22, 26, CAST(NULL AS INT), CAST(2 AS INTEGER), ROW(15) FROM (SELECT * FROM (VALUES(0,0,0,0,0,0)) WHERE FALSE) AS t3) AS q2;

; SELECT * FROM (SELECT 3, 22, 26, CAST(NULL AS INT), CAST(2 AS INTEGER), ROW(15) FROM (SELECT * FROM (VALUES(0,0,0,0,0,0)) WHERE FALSE) AS t3) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 + 2, t0.DEPTNO + (3 + 4), 5 + 6 + t0.DEPTNO, CAST(NULL AS INT), CASE WHEN 2 IS NOT NULL THEN 2 ELSE NULL END, ROW(7 + 8) FROM (SELECT DEPT.DEPTNO, DEPT.NAME, t.EMPNO, t.ENAME, t.JOB, t.MGR, t.HIREDATE, t.SAL, t.COMM, t.DEPTNO AS DEPTNO0, t.SLACKER FROM DEPT AS DEPT INNER JOIN (SELECT EMP.EMPNO, EMP.ENAME, EMP.JOB, EMP.MGR, EMP.HIREDATE, EMP.SAL, EMP.COMM, EMP.DEPTNO, EMP.SLACKER, EMP.DEPTNO + (5 - 5) AS f9 FROM EMP AS EMP) AS t ON DEPT.DEPTNO = t.f9) AS t0 WHERE t0.DEPTNO = 7 + 8 AND t0.DEPTNO = 8 + 7 AND t0.DEPTNO = CASE WHEN 2 IS NOT NULL THEN 2 ELSE NULL END) AS q1;

;Model soundness: false
(reset)
; parsing query SELECT * FROM (SELECT DEPT.DEPTNO, EMP.ENAME FROM EMP AS EMP INNER JOIN DEPT AS DEPT ON EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = 10) AS t WHERE t.DEPTNO = 10
; parsing query SELECT t1.DEPTNO, EMP0.ENAME FROM EMP AS EMP0 INNER JOIN (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO = 10) AS t1 ON EMP0.DEPTNO = t1.DEPTNO
;-----------------------------------------------------------
; test name: testMergeJoinFilter
;Translating sql query: SELECT * FROM (SELECT DEPT.DEPTNO, EMP.ENAME FROM EMP AS EMP INNER JOIN DEPT AS DEPT ON EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = 10) AS t WHERE t.DEPTNO = 10
;Translating sql query: SELECT t1.DEPTNO, EMP0.ENAME FROM EMP AS EMP0 INNER JOIN (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO = 10) AS t1 ON EMP0.DEPTNO = t1.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1267105 Int) (BOUND_VARIABLE_1267106 Int)) (= BOUND_VARIABLE_1267105 BOUND_VARIABLE_1267106)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1267105 Int) (BOUND_VARIABLE_1267106 Int)) (= BOUND_VARIABLE_1267105 BOUND_VARIABLE_1267106)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1267112 Int) (BOUND_VARIABLE_1267113 Int)) (= BOUND_VARIABLE_1267112 BOUND_VARIABLE_1267113)) ((_ tuple.select 11) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1267112 Int) (BOUND_VARIABLE_1267113 Int)) (= BOUND_VARIABLE_1267112 BOUND_VARIABLE_1267113)) ((_ tuple.select 11) t) (nullable.some 10)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1267105 Int) (BOUND_VARIABLE_1267106 Int)) (= BOUND_VARIABLE_1267105 BOUND_VARIABLE_1267106)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1267112 Int) (BOUND_VARIABLE_1267113 Int)) (= BOUND_VARIABLE_1267112 BOUND_VARIABLE_1267113)) ((_ tuple.select 11) t) (nullable.some 10)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1267105 Int) (BOUND_VARIABLE_1267106 Int)) (= BOUND_VARIABLE_1267105 BOUND_VARIABLE_1267106)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1267112 Int) (BOUND_VARIABLE_1267113 Int)) (= BOUND_VARIABLE_1267112 BOUND_VARIABLE_1267113)) ((_ tuple.select 11) t) (nullable.some 10)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1267105 Int) (BOUND_VARIABLE_1267106 Int)) (= BOUND_VARIABLE_1267105 BOUND_VARIABLE_1267106)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1267105 Int) (BOUND_VARIABLE_1267106 Int)) (= BOUND_VARIABLE_1267105 BOUND_VARIABLE_1267106)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1267112 Int) (BOUND_VARIABLE_1267113 Int)) (= BOUND_VARIABLE_1267112 BOUND_VARIABLE_1267113)) ((_ tuple.select 11) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1267112 Int) (BOUND_VARIABLE_1267113 Int)) (= BOUND_VARIABLE_1267112 BOUND_VARIABLE_1267113)) ((_ tuple.select 11) t) (nullable.some 10)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1267105 Int) (BOUND_VARIABLE_1267106 Int)) (= BOUND_VARIABLE_1267105 BOUND_VARIABLE_1267106)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1267112 Int) (BOUND_VARIABLE_1267113 Int)) (= BOUND_VARIABLE_1267112 BOUND_VARIABLE_1267113)) ((_ tuple.select 11) t) (nullable.some 10)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1267105 Int) (BOUND_VARIABLE_1267106 Int)) (= BOUND_VARIABLE_1267105 BOUND_VARIABLE_1267106)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1267112 Int) (BOUND_VARIABLE_1267113 Int)) (= BOUND_VARIABLE_1267112 BOUND_VARIABLE_1267113)) ((_ tuple.select 11) t) (nullable.some 10))))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1267147 Int) (BOUND_VARIABLE_1267148 Int)) (= BOUND_VARIABLE_1267147 BOUND_VARIABLE_1267148)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1267147 Int) (BOUND_VARIABLE_1267148 Int)) (= BOUND_VARIABLE_1267147 BOUND_VARIABLE_1267148)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1267166 Int) (BOUND_VARIABLE_1267167 Int)) (= BOUND_VARIABLE_1267166 BOUND_VARIABLE_1267167)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1267166 Int) (BOUND_VARIABLE_1267167 Int)) (= BOUND_VARIABLE_1267166 BOUND_VARIABLE_1267167)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1267187 Int) (BOUND_VARIABLE_1267188 Int)) (= BOUND_VARIABLE_1267187 BOUND_VARIABLE_1267188)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1267187 Int) (BOUND_VARIABLE_1267188 Int)) (= BOUND_VARIABLE_1267187 BOUND_VARIABLE_1267188)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p2 ((_ table.project 9 1) (bag.filter p1 (table.product EMP (bag.map f0 DEPT))))))))
(assert (= q2 ((_ table.project 9 1) (bag.filter p4 (table.product EMP ((_ table.project 0 1) (bag.filter p3 DEPT)))))))
(check-sat)
;answer: unknown (INCOMPLETE)
; duration: 452 ms.
(reset)
; parsing query SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
; parsing query SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
;-----------------------------------------------------------
; test name: testMergeUnionDistinct
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
;Translating sql query: SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1271098 Int) (BOUND_VARIABLE_1271099 Int)) (= BOUND_VARIABLE_1271098 BOUND_VARIABLE_1271099)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1271098 Int) (BOUND_VARIABLE_1271099 Int)) (= BOUND_VARIABLE_1271098 BOUND_VARIABLE_1271099)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1271117 Int) (BOUND_VARIABLE_1271118 Int)) (= BOUND_VARIABLE_1271117 BOUND_VARIABLE_1271118)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1271117 Int) (BOUND_VARIABLE_1271118 Int)) (= BOUND_VARIABLE_1271117 BOUND_VARIABLE_1271118)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1271138 Int) (BOUND_VARIABLE_1271139 Int)) (= BOUND_VARIABLE_1271138 BOUND_VARIABLE_1271139)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1271138 Int) (BOUND_VARIABLE_1271139 Int)) (= BOUND_VARIABLE_1271138 BOUND_VARIABLE_1271139)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1271158 Int) (BOUND_VARIABLE_1271159 Int)) (= BOUND_VARIABLE_1271158 BOUND_VARIABLE_1271159)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1271158 Int) (BOUND_VARIABLE_1271159 Int)) (= BOUND_VARIABLE_1271158 BOUND_VARIABLE_1271159)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1271177 Int) (BOUND_VARIABLE_1271178 Int)) (= BOUND_VARIABLE_1271177 BOUND_VARIABLE_1271178)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1271177 Int) (BOUND_VARIABLE_1271178 Int)) (= BOUND_VARIABLE_1271177 BOUND_VARIABLE_1271178)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1271197 Int) (BOUND_VARIABLE_1271198 Int)) (= BOUND_VARIABLE_1271197 BOUND_VARIABLE_1271198)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1271197 Int) (BOUND_VARIABLE_1271198 Int)) (= BOUND_VARIABLE_1271197 BOUND_VARIABLE_1271198)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (bag.union_max ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.union_max ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)))))
(assert (= q2 (bag.union_max (bag.union_max ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)))))
(check-sat)
;answer: unsat
; duration: 889 ms.
(reset)
; parsing query SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 OR EMP.DEPTNO = 9 OR EMP.COMM > 10) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO
; parsing query SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 7 OR EMP1.DEPTNO = 9 OR EMP1.COMM > 10) AS t1 INNER JOIN EMP AS EMP2 ON t1.DEPTNO = EMP2.DEPTNO
;-----------------------------------------------------------
; test name: testTransitiveInferenceNoPullUpExprs
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 OR EMP.DEPTNO = 9 OR EMP.COMM > 10) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 7 OR EMP1.DEPTNO = 9 OR EMP1.COMM > 10) AS t1 INNER JOIN EMP AS EMP2 ON t1.DEPTNO = EMP2.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1278391 Int) (BOUND_VARIABLE_1278392 Int)) (= BOUND_VARIABLE_1278391 BOUND_VARIABLE_1278392)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1278391 Int) (BOUND_VARIABLE_1278392 Int)) (= BOUND_VARIABLE_1278391 BOUND_VARIABLE_1278392)) ((_ tuple.select 7) t) (nullable.some 7)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1278397 Int) (BOUND_VARIABLE_1278398 Int)) (= BOUND_VARIABLE_1278397 BOUND_VARIABLE_1278398)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1278397 Int) (BOUND_VARIABLE_1278398 Int)) (= BOUND_VARIABLE_1278397 BOUND_VARIABLE_1278398)) ((_ tuple.select 7) t) (nullable.some 9))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1278391 Int) (BOUND_VARIABLE_1278392 Int)) (= BOUND_VARIABLE_1278391 BOUND_VARIABLE_1278392)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1278397 Int) (BOUND_VARIABLE_1278398 Int)) (= BOUND_VARIABLE_1278397 BOUND_VARIABLE_1278398)) ((_ tuple.select 7) t) (nullable.some 9)))) (or (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1278391 Int) (BOUND_VARIABLE_1278392 Int)) (= BOUND_VARIABLE_1278391 BOUND_VARIABLE_1278392)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1278397 Int) (BOUND_VARIABLE_1278398 Int)) (= BOUND_VARIABLE_1278397 BOUND_VARIABLE_1278398)) ((_ tuple.select 7) t) (nullable.some 9)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1278391 Int) (BOUND_VARIABLE_1278392 Int)) (= BOUND_VARIABLE_1278391 BOUND_VARIABLE_1278392)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1278391 Int) (BOUND_VARIABLE_1278392 Int)) (= BOUND_VARIABLE_1278391 BOUND_VARIABLE_1278392)) ((_ tuple.select 7) t) (nullable.some 7)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1278397 Int) (BOUND_VARIABLE_1278398 Int)) (= BOUND_VARIABLE_1278397 BOUND_VARIABLE_1278398)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1278397 Int) (BOUND_VARIABLE_1278398 Int)) (= BOUND_VARIABLE_1278397 BOUND_VARIABLE_1278398)) ((_ tuple.select 7) t) (nullable.some 9))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1278391 Int) (BOUND_VARIABLE_1278392 Int)) (= BOUND_VARIABLE_1278391 BOUND_VARIABLE_1278392)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1278397 Int) (BOUND_VARIABLE_1278398 Int)) (= BOUND_VARIABLE_1278397 BOUND_VARIABLE_1278398)) ((_ tuple.select 7) t) (nullable.some 9)))) (or (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1278391 Int) (BOUND_VARIABLE_1278392 Int)) (= BOUND_VARIABLE_1278391 BOUND_VARIABLE_1278392)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1278397 Int) (BOUND_VARIABLE_1278398 Int)) (= BOUND_VARIABLE_1278397 BOUND_VARIABLE_1278398)) ((_ tuple.select 7) t) (nullable.some 9))))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1278438 Int) (BOUND_VARIABLE_1278439 Int)) (= BOUND_VARIABLE_1278438 BOUND_VARIABLE_1278439)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1278438 Int) (BOUND_VARIABLE_1278439 Int)) (= BOUND_VARIABLE_1278438 BOUND_VARIABLE_1278439)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1278464 Int) (BOUND_VARIABLE_1278465 Int)) (= BOUND_VARIABLE_1278464 BOUND_VARIABLE_1278465)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1278464 Int) (BOUND_VARIABLE_1278465 Int)) (= BOUND_VARIABLE_1278464 BOUND_VARIABLE_1278465)) ((_ tuple.select 7) t) (nullable.some 7)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1278470 Int) (BOUND_VARIABLE_1278471 Int)) (= BOUND_VARIABLE_1278470 BOUND_VARIABLE_1278471)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1278470 Int) (BOUND_VARIABLE_1278471 Int)) (= BOUND_VARIABLE_1278470 BOUND_VARIABLE_1278471)) ((_ tuple.select 7) t) (nullable.some 9))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1278464 Int) (BOUND_VARIABLE_1278465 Int)) (= BOUND_VARIABLE_1278464 BOUND_VARIABLE_1278465)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1278470 Int) (BOUND_VARIABLE_1278471 Int)) (= BOUND_VARIABLE_1278470 BOUND_VARIABLE_1278471)) ((_ tuple.select 7) t) (nullable.some 9)))) (or (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1278464 Int) (BOUND_VARIABLE_1278465 Int)) (= BOUND_VARIABLE_1278464 BOUND_VARIABLE_1278465)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1278470 Int) (BOUND_VARIABLE_1278471 Int)) (= BOUND_VARIABLE_1278470 BOUND_VARIABLE_1278471)) ((_ tuple.select 7) t) (nullable.some 9)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1278464 Int) (BOUND_VARIABLE_1278465 Int)) (= BOUND_VARIABLE_1278464 BOUND_VARIABLE_1278465)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1278464 Int) (BOUND_VARIABLE_1278465 Int)) (= BOUND_VARIABLE_1278464 BOUND_VARIABLE_1278465)) ((_ tuple.select 7) t) (nullable.some 7)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1278470 Int) (BOUND_VARIABLE_1278471 Int)) (= BOUND_VARIABLE_1278470 BOUND_VARIABLE_1278471)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1278470 Int) (BOUND_VARIABLE_1278471 Int)) (= BOUND_VARIABLE_1278470 BOUND_VARIABLE_1278471)) ((_ tuple.select 7) t) (nullable.some 9))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1278464 Int) (BOUND_VARIABLE_1278465 Int)) (= BOUND_VARIABLE_1278464 BOUND_VARIABLE_1278465)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1278470 Int) (BOUND_VARIABLE_1278471 Int)) (= BOUND_VARIABLE_1278470 BOUND_VARIABLE_1278471)) ((_ tuple.select 7) t) (nullable.some 9)))) (or (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1278464 Int) (BOUND_VARIABLE_1278465 Int)) (= BOUND_VARIABLE_1278464 BOUND_VARIABLE_1278465)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1278470 Int) (BOUND_VARIABLE_1278471 Int)) (= BOUND_VARIABLE_1278470 BOUND_VARIABLE_1278471)) ((_ tuple.select 7) t) (nullable.some 9))))))))))))
(assert (not (= q1 q2)))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1278510 Int) (BOUND_VARIABLE_1278511 Int)) (= BOUND_VARIABLE_1278510 BOUND_VARIABLE_1278511)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1278510 Int) (BOUND_VARIABLE_1278511 Int)) (= BOUND_VARIABLE_1278510 BOUND_VARIABLE_1278511)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f2 (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) EMP)))))
(assert (= q2 (bag.map f5 (bag.filter p4 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) EMP)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10068 ms.
(reset)
; parsing query SELECT t.EXPR$0 + t.EXPR$1 + t.EXPR$0 FROM (VALUES  (10, 1),  (30, 3)) AS t WHERE t.EXPR$0 + t.EXPR$1 > 50
; parsing query SELECT t3.EXPR$0 + t3.EXPR$1 + t3.EXPR$0 FROM (SELECT * FROM (VALUES(0,0)) EXCEPT SELECT * FROM (VALUES(0,0))) AS t3
;-----------------------------------------------------------
; test name: testEmptyProject
;Translating sql query: SELECT t.EXPR$0 + t.EXPR$1 + t.EXPR$0 FROM (VALUES  (10, 1),  (30, 3)) AS t WHERE t.EXPR$0 + t.EXPR$1 > 50
;Translating sql query: SELECT t3.EXPR$0 + t3.EXPR$1 + t3.EXPR$0 FROM (SELECT * FROM (VALUES(0,0)) EXCEPT SELECT * FROM (VALUES(0,0))) AS t3
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357494 Int) (BOUND_VARIABLE_1357495 Int)) (> BOUND_VARIABLE_1357494 BOUND_VARIABLE_1357495)) (nullable.lift (lambda ((BOUND_VARIABLE_1357488 Int) (BOUND_VARIABLE_1357489 Int)) (+ BOUND_VARIABLE_1357488 BOUND_VARIABLE_1357489)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357494 Int) (BOUND_VARIABLE_1357495 Int)) (> BOUND_VARIABLE_1357494 BOUND_VARIABLE_1357495)) (nullable.lift (lambda ((BOUND_VARIABLE_1357488 Int) (BOUND_VARIABLE_1357489 Int)) (+ BOUND_VARIABLE_1357488 BOUND_VARIABLE_1357489)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 50)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_1357520 Int) (BOUND_VARIABLE_1357521 Int)) (+ BOUND_VARIABLE_1357520 BOUND_VARIABLE_1357521)) (nullable.lift (lambda ((BOUND_VARIABLE_1357514 Int) (BOUND_VARIABLE_1357515 Int)) (+ BOUND_VARIABLE_1357514 BOUND_VARIABLE_1357515)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 0) t))))))
(assert (not (= q1 q2)))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_1357544 Int) (BOUND_VARIABLE_1357545 Int)) (+ BOUND_VARIABLE_1357544 BOUND_VARIABLE_1357545)) (nullable.lift (lambda ((BOUND_VARIABLE_1357538 Int) (BOUND_VARIABLE_1357539 Int)) (+ BOUND_VARIABLE_1357538 BOUND_VARIABLE_1357539)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 0) t))))))
(assert (= q1 (bag.map f1 (bag.filter p0 (bag.union_disjoint (bag (tuple (nullable.some 10) (nullable.some 1)) 1) (bag (tuple (nullable.some 30) (nullable.some 3)) 1))))))
(assert (= q2 (bag.map f2 (bag.difference_remove ((_ table.project 0 1) (bag (tuple (nullable.some 0) (nullable.some 0)) 1)) ((_ table.project 0 1) (bag (tuple (nullable.some 0) (nullable.some 0)) 1))))))
(check-sat)
;answer: unsat
; duration: 223 ms.
(reset)
; parsing query SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 OR EMP.DEPTNO = 9 OR EMP.DEPTNO > 10) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO
; parsing query SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 7 OR EMP1.DEPTNO = 9 OR EMP1.DEPTNO > 10) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 7 OR EMP2.DEPTNO = 9 OR EMP2.DEPTNO > 10) AS t2 ON t1.DEPTNO = t2.DEPTNO
;-----------------------------------------------------------
; test name: testTransitiveInferenceConjunctInPullUp
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 OR EMP.DEPTNO = 9 OR EMP.DEPTNO > 10) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 7 OR EMP1.DEPTNO = 9 OR EMP1.DEPTNO > 10) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 7 OR EMP2.DEPTNO = 9 OR EMP2.DEPTNO > 10) AS t2 ON t1.DEPTNO = t2.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357659 Int) (BOUND_VARIABLE_1357660 Int)) (= BOUND_VARIABLE_1357659 BOUND_VARIABLE_1357660)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357659 Int) (BOUND_VARIABLE_1357660 Int)) (= BOUND_VARIABLE_1357659 BOUND_VARIABLE_1357660)) ((_ tuple.select 7) t) (nullable.some 7)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357665 Int) (BOUND_VARIABLE_1357666 Int)) (= BOUND_VARIABLE_1357665 BOUND_VARIABLE_1357666)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357665 Int) (BOUND_VARIABLE_1357666 Int)) (= BOUND_VARIABLE_1357665 BOUND_VARIABLE_1357666)) ((_ tuple.select 7) t) (nullable.some 9))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357659 Int) (BOUND_VARIABLE_1357660 Int)) (= BOUND_VARIABLE_1357659 BOUND_VARIABLE_1357660)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357665 Int) (BOUND_VARIABLE_1357666 Int)) (= BOUND_VARIABLE_1357665 BOUND_VARIABLE_1357666)) ((_ tuple.select 7) t) (nullable.some 9)))) (or (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357659 Int) (BOUND_VARIABLE_1357660 Int)) (= BOUND_VARIABLE_1357659 BOUND_VARIABLE_1357660)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357665 Int) (BOUND_VARIABLE_1357666 Int)) (= BOUND_VARIABLE_1357665 BOUND_VARIABLE_1357666)) ((_ tuple.select 7) t) (nullable.some 9)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357659 Int) (BOUND_VARIABLE_1357660 Int)) (= BOUND_VARIABLE_1357659 BOUND_VARIABLE_1357660)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357659 Int) (BOUND_VARIABLE_1357660 Int)) (= BOUND_VARIABLE_1357659 BOUND_VARIABLE_1357660)) ((_ tuple.select 7) t) (nullable.some 7)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357665 Int) (BOUND_VARIABLE_1357666 Int)) (= BOUND_VARIABLE_1357665 BOUND_VARIABLE_1357666)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357665 Int) (BOUND_VARIABLE_1357666 Int)) (= BOUND_VARIABLE_1357665 BOUND_VARIABLE_1357666)) ((_ tuple.select 7) t) (nullable.some 9))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357659 Int) (BOUND_VARIABLE_1357660 Int)) (= BOUND_VARIABLE_1357659 BOUND_VARIABLE_1357660)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357665 Int) (BOUND_VARIABLE_1357666 Int)) (= BOUND_VARIABLE_1357665 BOUND_VARIABLE_1357666)) ((_ tuple.select 7) t) (nullable.some 9)))) (or (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357659 Int) (BOUND_VARIABLE_1357660 Int)) (= BOUND_VARIABLE_1357659 BOUND_VARIABLE_1357660)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357665 Int) (BOUND_VARIABLE_1357666 Int)) (= BOUND_VARIABLE_1357665 BOUND_VARIABLE_1357666)) ((_ tuple.select 7) t) (nullable.some 9))))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357704 Int) (BOUND_VARIABLE_1357705 Int)) (= BOUND_VARIABLE_1357704 BOUND_VARIABLE_1357705)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357704 Int) (BOUND_VARIABLE_1357705 Int)) (= BOUND_VARIABLE_1357704 BOUND_VARIABLE_1357705)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357730 Int) (BOUND_VARIABLE_1357731 Int)) (= BOUND_VARIABLE_1357730 BOUND_VARIABLE_1357731)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357730 Int) (BOUND_VARIABLE_1357731 Int)) (= BOUND_VARIABLE_1357730 BOUND_VARIABLE_1357731)) ((_ tuple.select 7) t) (nullable.some 7)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357736 Int) (BOUND_VARIABLE_1357737 Int)) (= BOUND_VARIABLE_1357736 BOUND_VARIABLE_1357737)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357736 Int) (BOUND_VARIABLE_1357737 Int)) (= BOUND_VARIABLE_1357736 BOUND_VARIABLE_1357737)) ((_ tuple.select 7) t) (nullable.some 9))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357730 Int) (BOUND_VARIABLE_1357731 Int)) (= BOUND_VARIABLE_1357730 BOUND_VARIABLE_1357731)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357736 Int) (BOUND_VARIABLE_1357737 Int)) (= BOUND_VARIABLE_1357736 BOUND_VARIABLE_1357737)) ((_ tuple.select 7) t) (nullable.some 9)))) (or (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357730 Int) (BOUND_VARIABLE_1357731 Int)) (= BOUND_VARIABLE_1357730 BOUND_VARIABLE_1357731)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357736 Int) (BOUND_VARIABLE_1357737 Int)) (= BOUND_VARIABLE_1357736 BOUND_VARIABLE_1357737)) ((_ tuple.select 7) t) (nullable.some 9)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357730 Int) (BOUND_VARIABLE_1357731 Int)) (= BOUND_VARIABLE_1357730 BOUND_VARIABLE_1357731)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357730 Int) (BOUND_VARIABLE_1357731 Int)) (= BOUND_VARIABLE_1357730 BOUND_VARIABLE_1357731)) ((_ tuple.select 7) t) (nullable.some 7)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357736 Int) (BOUND_VARIABLE_1357737 Int)) (= BOUND_VARIABLE_1357736 BOUND_VARIABLE_1357737)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357736 Int) (BOUND_VARIABLE_1357737 Int)) (= BOUND_VARIABLE_1357736 BOUND_VARIABLE_1357737)) ((_ tuple.select 7) t) (nullable.some 9))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357730 Int) (BOUND_VARIABLE_1357731 Int)) (= BOUND_VARIABLE_1357730 BOUND_VARIABLE_1357731)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357736 Int) (BOUND_VARIABLE_1357737 Int)) (= BOUND_VARIABLE_1357736 BOUND_VARIABLE_1357737)) ((_ tuple.select 7) t) (nullable.some 9)))) (or (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357730 Int) (BOUND_VARIABLE_1357731 Int)) (= BOUND_VARIABLE_1357730 BOUND_VARIABLE_1357731)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357736 Int) (BOUND_VARIABLE_1357737 Int)) (= BOUND_VARIABLE_1357736 BOUND_VARIABLE_1357737)) ((_ tuple.select 7) t) (nullable.some 9))))))))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357773 Int) (BOUND_VARIABLE_1357774 Int)) (= BOUND_VARIABLE_1357773 BOUND_VARIABLE_1357774)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357773 Int) (BOUND_VARIABLE_1357774 Int)) (= BOUND_VARIABLE_1357773 BOUND_VARIABLE_1357774)) ((_ tuple.select 7) t) (nullable.some 7)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357779 Int) (BOUND_VARIABLE_1357780 Int)) (= BOUND_VARIABLE_1357779 BOUND_VARIABLE_1357780)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357779 Int) (BOUND_VARIABLE_1357780 Int)) (= BOUND_VARIABLE_1357779 BOUND_VARIABLE_1357780)) ((_ tuple.select 7) t) (nullable.some 9))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357773 Int) (BOUND_VARIABLE_1357774 Int)) (= BOUND_VARIABLE_1357773 BOUND_VARIABLE_1357774)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357779 Int) (BOUND_VARIABLE_1357780 Int)) (= BOUND_VARIABLE_1357779 BOUND_VARIABLE_1357780)) ((_ tuple.select 7) t) (nullable.some 9)))) (or (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357773 Int) (BOUND_VARIABLE_1357774 Int)) (= BOUND_VARIABLE_1357773 BOUND_VARIABLE_1357774)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357779 Int) (BOUND_VARIABLE_1357780 Int)) (= BOUND_VARIABLE_1357779 BOUND_VARIABLE_1357780)) ((_ tuple.select 7) t) (nullable.some 9)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357773 Int) (BOUND_VARIABLE_1357774 Int)) (= BOUND_VARIABLE_1357773 BOUND_VARIABLE_1357774)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357773 Int) (BOUND_VARIABLE_1357774 Int)) (= BOUND_VARIABLE_1357773 BOUND_VARIABLE_1357774)) ((_ tuple.select 7) t) (nullable.some 7)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357779 Int) (BOUND_VARIABLE_1357780 Int)) (= BOUND_VARIABLE_1357779 BOUND_VARIABLE_1357780)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357779 Int) (BOUND_VARIABLE_1357780 Int)) (= BOUND_VARIABLE_1357779 BOUND_VARIABLE_1357780)) ((_ tuple.select 7) t) (nullable.some 9))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357773 Int) (BOUND_VARIABLE_1357774 Int)) (= BOUND_VARIABLE_1357773 BOUND_VARIABLE_1357774)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357779 Int) (BOUND_VARIABLE_1357780 Int)) (= BOUND_VARIABLE_1357779 BOUND_VARIABLE_1357780)) ((_ tuple.select 7) t) (nullable.some 9)))) (or (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357773 Int) (BOUND_VARIABLE_1357774 Int)) (= BOUND_VARIABLE_1357773 BOUND_VARIABLE_1357774)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357779 Int) (BOUND_VARIABLE_1357780 Int)) (= BOUND_VARIABLE_1357779 BOUND_VARIABLE_1357780)) ((_ tuple.select 7) t) (nullable.some 9))))))))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1357818 Int) (BOUND_VARIABLE_1357819 Int)) (= BOUND_VARIABLE_1357818 BOUND_VARIABLE_1357819)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1357818 Int) (BOUND_VARIABLE_1357819 Int)) (= BOUND_VARIABLE_1357818 BOUND_VARIABLE_1357819)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f2 (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) EMP)))))
(assert (= q2 (bag.map f6 (bag.filter p5 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10074 ms.
(reset)
; parsing query SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME = 'foo'
; parsing query SELECT t1.ENAME FROM (SELECT EMP0.DEPTNO,EMP0.ENAME FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO WHERE EMP0.ENAME = 'foo') AS t1 INNER JOIN DEPT AS DEPT1 ON t1.DEPTNO = DEPT1.DEPTNO
;-----------------------------------------------------------
; test name: testPushSemiJoinPastFilter
;Translating sql query: SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME = 'foo'
;Translating sql query: SELECT t1.ENAME FROM (SELECT EMP0.DEPTNO,EMP0.ENAME FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO WHERE EMP0.ENAME = 'foo') AS t1 INNER JOIN DEPT AS DEPT1 ON t1.DEPTNO = DEPT1.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Bag (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1426681 Int) (BOUND_VARIABLE_1426682 Int)) (= BOUND_VARIABLE_1426681 BOUND_VARIABLE_1426682)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1426681 Int) (BOUND_VARIABLE_1426682 Int)) (= BOUND_VARIABLE_1426681 BOUND_VARIABLE_1426682)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1426690 String) (BOUND_VARIABLE_1426691 String)) (= BOUND_VARIABLE_1426690 BOUND_VARIABLE_1426691)) ((_ tuple.select 1) t) (nullable.some "foo"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1426690 String) (BOUND_VARIABLE_1426691 String)) (= BOUND_VARIABLE_1426690 BOUND_VARIABLE_1426691)) ((_ tuple.select 1) t) (nullable.some "foo")))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1426681 Int) (BOUND_VARIABLE_1426682 Int)) (= BOUND_VARIABLE_1426681 BOUND_VARIABLE_1426682)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1426690 String) (BOUND_VARIABLE_1426691 String)) (= BOUND_VARIABLE_1426690 BOUND_VARIABLE_1426691)) ((_ tuple.select 1) t) (nullable.some "foo")))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1426681 Int) (BOUND_VARIABLE_1426682 Int)) (= BOUND_VARIABLE_1426681 BOUND_VARIABLE_1426682)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1426690 String) (BOUND_VARIABLE_1426691 String)) (= BOUND_VARIABLE_1426690 BOUND_VARIABLE_1426691)) ((_ tuple.select 1) t) (nullable.some "foo")))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1426681 Int) (BOUND_VARIABLE_1426682 Int)) (= BOUND_VARIABLE_1426681 BOUND_VARIABLE_1426682)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1426681 Int) (BOUND_VARIABLE_1426682 Int)) (= BOUND_VARIABLE_1426681 BOUND_VARIABLE_1426682)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1426690 String) (BOUND_VARIABLE_1426691 String)) (= BOUND_VARIABLE_1426690 BOUND_VARIABLE_1426691)) ((_ tuple.select 1) t) (nullable.some "foo"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1426690 String) (BOUND_VARIABLE_1426691 String)) (= BOUND_VARIABLE_1426690 BOUND_VARIABLE_1426691)) ((_ tuple.select 1) t) (nullable.some "foo")))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1426681 Int) (BOUND_VARIABLE_1426682 Int)) (= BOUND_VARIABLE_1426681 BOUND_VARIABLE_1426682)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1426690 String) (BOUND_VARIABLE_1426691 String)) (= BOUND_VARIABLE_1426690 BOUND_VARIABLE_1426691)) ((_ tuple.select 1) t) (nullable.some "foo")))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1426681 Int) (BOUND_VARIABLE_1426682 Int)) (= BOUND_VARIABLE_1426681 BOUND_VARIABLE_1426682)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1426690 String) (BOUND_VARIABLE_1426691 String)) (= BOUND_VARIABLE_1426690 BOUND_VARIABLE_1426691)) ((_ tuple.select 1) t) (nullable.some "foo"))))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1426725 Int) (BOUND_VARIABLE_1426726 Int)) (= BOUND_VARIABLE_1426725 BOUND_VARIABLE_1426726)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1426725 Int) (BOUND_VARIABLE_1426726 Int)) (= BOUND_VARIABLE_1426725 BOUND_VARIABLE_1426726)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1426743 String) (BOUND_VARIABLE_1426744 String)) (= BOUND_VARIABLE_1426743 BOUND_VARIABLE_1426744)) ((_ tuple.select 1) t) (nullable.some "foo"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1426743 String) (BOUND_VARIABLE_1426744 String)) (= BOUND_VARIABLE_1426743 BOUND_VARIABLE_1426744)) ((_ tuple.select 1) t) (nullable.some "foo")))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1426788 Int) (BOUND_VARIABLE_1426789 Int)) (= BOUND_VARIABLE_1426788 BOUND_VARIABLE_1426789)) ((_ tuple.select 0) t) ((_ tuple.select 2) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1426788 Int) (BOUND_VARIABLE_1426789 Int)) (= BOUND_VARIABLE_1426788 BOUND_VARIABLE_1426789)) ((_ tuple.select 0) t) ((_ tuple.select 2) t)))))))
(assert (= q1 ((_ table.project 1) (bag.filter p0 (table.product EMP DEPT)))))
(assert (= q2 ((_ table.project 1) (bag.filter p3 (table.product ((_ table.project 7 1) (bag.filter p2 (bag.filter p1 (table.product EMP DEPT)))) DEPT)))))
(check-sat)
;answer: sat
; duration: 2962 ms.
(get-model)
; (
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 0) (nullable.some "M")) 1))
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some (- 16)) (nullable.some "foo") (nullable.some "L") (nullable.some 17) (nullable.some (- 17)) (nullable.some 18) (nullable.some (- 18)) (nullable.some (- 1)) (nullable.some 19)) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some "foo")) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable String))))
; insert into DEPT values(0,'M')
; insert into EMP values(-16,'foo','L',17,-17,18,-18,-1,19)
; SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME = 'foo') AS q1 EXCEPT ALL SELECT * FROM (SELECT t1.ENAME FROM (SELECT EMP0.DEPTNO,EMP0.ENAME FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO WHERE EMP0.ENAME = 'foo') AS t1 INNER JOIN DEPT AS DEPT1 ON t1.DEPTNO = DEPT1.DEPTNO) AS q2;

; SELECT * FROM (SELECT t1.ENAME FROM (SELECT EMP0.DEPTNO,EMP0.ENAME FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO WHERE EMP0.ENAME = 'foo') AS t1 INNER JOIN DEPT AS DEPT1 ON t1.DEPTNO = DEPT1.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME = 'foo') AS q1;

;Model soundness: false
(reset)
; parsing query SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10) AS t WHERE t.DEPTNO + 5 > t.EMPNO
; parsing query SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 10) AS t1 WHERE 15 > t1.EMPNO
;-----------------------------------------------------------
; test name: testPullConstantIntoFilter
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10) AS t WHERE t.DEPTNO + 5 > t.EMPNO
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 10) AS t1 WHERE 15 > t1.EMPNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1442552 Int) (BOUND_VARIABLE_1442553 Int)) (= BOUND_VARIABLE_1442552 BOUND_VARIABLE_1442553)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1442552 Int) (BOUND_VARIABLE_1442553 Int)) (= BOUND_VARIABLE_1442552 BOUND_VARIABLE_1442553)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1442579 Int) (BOUND_VARIABLE_1442580 Int)) (> BOUND_VARIABLE_1442579 BOUND_VARIABLE_1442580)) (nullable.lift (lambda ((BOUND_VARIABLE_1442572 Int) (BOUND_VARIABLE_1442573 Int)) (+ BOUND_VARIABLE_1442572 BOUND_VARIABLE_1442573)) ((_ tuple.select 7) t) (nullable.some 5)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1442579 Int) (BOUND_VARIABLE_1442580 Int)) (> BOUND_VARIABLE_1442579 BOUND_VARIABLE_1442580)) (nullable.lift (lambda ((BOUND_VARIABLE_1442572 Int) (BOUND_VARIABLE_1442573 Int)) (+ BOUND_VARIABLE_1442572 BOUND_VARIABLE_1442573)) ((_ tuple.select 7) t) (nullable.some 5)) ((_ tuple.select 0) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1442598 Int) (BOUND_VARIABLE_1442599 Int)) (= BOUND_VARIABLE_1442598 BOUND_VARIABLE_1442599)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1442598 Int) (BOUND_VARIABLE_1442599 Int)) (= BOUND_VARIABLE_1442598 BOUND_VARIABLE_1442599)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1442617 Int) (BOUND_VARIABLE_1442618 Int)) (> BOUND_VARIABLE_1442617 BOUND_VARIABLE_1442618)) (nullable.some 15) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1442617 Int) (BOUND_VARIABLE_1442618 Int)) (> BOUND_VARIABLE_1442617 BOUND_VARIABLE_1442618)) (nullable.some 15) ((_ tuple.select 0) t)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP))))))
(check-sat)
;answer: unsat
; duration: 312 ms.
(reset)
; parsing query SELECT 1 FROM (SELECT EMP.COMM AS DEPTNO FROM EMP AS EMP WHERE EMP.COMM > 7) AS t0 INNER JOIN EMP AS EMP0 ON t0.DEPTNO = EMP0.DEPTNO
; parsing query SELECT 1 FROM (SELECT EMP1.COMM AS DEPTNO FROM EMP AS EMP1 WHERE EMP1.COMM > 7) AS t3 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t4 ON t3.DEPTNO = t4.DEPTNO
;-----------------------------------------------------------
; test name: testTransitiveInferencePullUpThruAlias
;Translating sql query: SELECT 1 FROM (SELECT EMP.COMM AS DEPTNO FROM EMP AS EMP WHERE EMP.COMM > 7) AS t0 INNER JOIN EMP AS EMP0 ON t0.DEPTNO = EMP0.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT EMP1.COMM AS DEPTNO FROM EMP AS EMP1 WHERE EMP1.COMM > 7) AS t3 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t4 ON t3.DEPTNO = t4.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f6 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1446120 Int) (BOUND_VARIABLE_1446121 Int)) (> BOUND_VARIABLE_1446120 BOUND_VARIABLE_1446121)) ((_ tuple.select 5) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1446120 Int) (BOUND_VARIABLE_1446121 Int)) (> BOUND_VARIABLE_1446120 BOUND_VARIABLE_1446121)) ((_ tuple.select 5) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1446141 Int) (BOUND_VARIABLE_1446142 Int)) (= BOUND_VARIABLE_1446141 BOUND_VARIABLE_1446142)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1446141 Int) (BOUND_VARIABLE_1446142 Int)) (= BOUND_VARIABLE_1446141 BOUND_VARIABLE_1446142)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1446167 Int) (BOUND_VARIABLE_1446168 Int)) (> BOUND_VARIABLE_1446167 BOUND_VARIABLE_1446168)) ((_ tuple.select 5) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1446167 Int) (BOUND_VARIABLE_1446168 Int)) (> BOUND_VARIABLE_1446167 BOUND_VARIABLE_1446168)) ((_ tuple.select 5) t) (nullable.some 7)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1446186 Int) (BOUND_VARIABLE_1446187 Int)) (> BOUND_VARIABLE_1446186 BOUND_VARIABLE_1446187)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1446186 Int) (BOUND_VARIABLE_1446187 Int)) (> BOUND_VARIABLE_1446186 BOUND_VARIABLE_1446187)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1446207 Int) (BOUND_VARIABLE_1446208 Int)) (= BOUND_VARIABLE_1446207 BOUND_VARIABLE_1446208)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1446207 Int) (BOUND_VARIABLE_1446208 Int)) (= BOUND_VARIABLE_1446207 BOUND_VARIABLE_1446208)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f2 (bag.filter p1 (table.product ((_ table.project 5) (bag.filter p0 EMP)) EMP)))))
(assert (= q2 (bag.map f6 (bag.filter p5 (table.product ((_ table.project 5) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10044 ms.
(reset)
; parsing query SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS t2
; parsing query SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 UNION SELECT * FROM (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS t7
;-----------------------------------------------------------
; test name: testMergeSetOpMixed
;Translating sql query: SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS t2
;Translating sql query: SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 UNION SELECT * FROM (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS t7
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1496294 Int) (BOUND_VARIABLE_1496295 Int)) (= BOUND_VARIABLE_1496294 BOUND_VARIABLE_1496295)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1496294 Int) (BOUND_VARIABLE_1496295 Int)) (= BOUND_VARIABLE_1496294 BOUND_VARIABLE_1496295)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1496314 Int) (BOUND_VARIABLE_1496315 Int)) (= BOUND_VARIABLE_1496314 BOUND_VARIABLE_1496315)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1496314 Int) (BOUND_VARIABLE_1496315 Int)) (= BOUND_VARIABLE_1496314 BOUND_VARIABLE_1496315)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1496333 Int) (BOUND_VARIABLE_1496334 Int)) (= BOUND_VARIABLE_1496333 BOUND_VARIABLE_1496334)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1496333 Int) (BOUND_VARIABLE_1496334 Int)) (= BOUND_VARIABLE_1496333 BOUND_VARIABLE_1496334)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1496355 Int) (BOUND_VARIABLE_1496356 Int)) (= BOUND_VARIABLE_1496355 BOUND_VARIABLE_1496356)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1496355 Int) (BOUND_VARIABLE_1496356 Int)) (= BOUND_VARIABLE_1496355 BOUND_VARIABLE_1496356)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1496374 Int) (BOUND_VARIABLE_1496375 Int)) (= BOUND_VARIABLE_1496374 BOUND_VARIABLE_1496375)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1496374 Int) (BOUND_VARIABLE_1496375 Int)) (= BOUND_VARIABLE_1496374 BOUND_VARIABLE_1496375)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1496393 Int) (BOUND_VARIABLE_1496394 Int)) (= BOUND_VARIABLE_1496393 BOUND_VARIABLE_1496394)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1496393 Int) (BOUND_VARIABLE_1496394 Int)) (= BOUND_VARIABLE_1496393 BOUND_VARIABLE_1496394)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (bag.union_max ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.inter_min ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)))))))
(assert (= q2 (bag.union_max ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.inter_min ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)))))))
(check-sat)
;answer: unsat
; duration: 873 ms.
(reset)
; parsing query SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND EMP.EMPNO IS NOT NULL
; parsing query SELECT EMP0.EMPNO FROM EMP AS EMP0 WHERE EMP0.EMPNO = 10
;-----------------------------------------------------------
; test name: testReduceConstantsIsNotNull
;Translating sql query: SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND EMP.EMPNO IS NOT NULL
;Translating sql query: SELECT EMP0.EMPNO FROM EMP AS EMP0 WHERE EMP0.EMPNO = 10
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1503103 Int) (BOUND_VARIABLE_1503104 Int)) (= BOUND_VARIABLE_1503103 BOUND_VARIABLE_1503104)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1503103 Int) (BOUND_VARIABLE_1503104 Int)) (= BOUND_VARIABLE_1503103 BOUND_VARIABLE_1503104)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.some (nullable.is_some ((_ tuple.select 0) t)))) (not (nullable.val (nullable.some (nullable.is_some ((_ tuple.select 0) t))))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1503103 Int) (BOUND_VARIABLE_1503104 Int)) (= BOUND_VARIABLE_1503103 BOUND_VARIABLE_1503104)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_some (nullable.some (nullable.is_some ((_ tuple.select 0) t))))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1503103 Int) (BOUND_VARIABLE_1503104 Int)) (= BOUND_VARIABLE_1503103 BOUND_VARIABLE_1503104)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.some (nullable.is_some ((_ tuple.select 0) t))))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1503103 Int) (BOUND_VARIABLE_1503104 Int)) (= BOUND_VARIABLE_1503103 BOUND_VARIABLE_1503104)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1503103 Int) (BOUND_VARIABLE_1503104 Int)) (= BOUND_VARIABLE_1503103 BOUND_VARIABLE_1503104)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.some (nullable.is_some ((_ tuple.select 0) t)))) (not (nullable.val (nullable.some (nullable.is_some ((_ tuple.select 0) t))))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1503103 Int) (BOUND_VARIABLE_1503104 Int)) (= BOUND_VARIABLE_1503103 BOUND_VARIABLE_1503104)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_some (nullable.some (nullable.is_some ((_ tuple.select 0) t))))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1503103 Int) (BOUND_VARIABLE_1503104 Int)) (= BOUND_VARIABLE_1503103 BOUND_VARIABLE_1503104)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.some (nullable.is_some ((_ tuple.select 0) t)))))))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1503139 Int) (BOUND_VARIABLE_1503140 Int)) (= BOUND_VARIABLE_1503139 BOUND_VARIABLE_1503140)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1503139 Int) (BOUND_VARIABLE_1503140 Int)) (= BOUND_VARIABLE_1503139 BOUND_VARIABLE_1503140)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= q1 ((_ table.project 0) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0) (bag.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 377 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (as nullable.null (Nullable Int)) (nullable.some "E") (nullable.some "F") (nullable.some (- 10)) (nullable.some 11) (nullable.some (- 11)) (nullable.some 12) (nullable.some (- 12)) (nullable.some 13)) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (as nullable.null (Nullable Int))) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; insert into EMP values(NULL,'E','F',-10,11,-11,12,-12,13)
; SELECT * FROM (SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND EMP.EMPNO IS NOT NULL) AS q1 EXCEPT ALL SELECT * FROM (SELECT EMP0.EMPNO FROM EMP AS EMP0 WHERE EMP0.EMPNO = 10) AS q2;

; SELECT * FROM (SELECT EMP0.EMPNO FROM EMP AS EMP0 WHERE EMP0.EMPNO = 10) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND EMP.EMPNO IS NOT NULL) AS q1;

;Model soundness: false
(reset)
; parsing query SELECT * FROM (SELECT * FROM (VALUES  (30, 3)) AS t INTERSECT SELECT * FROM (VALUES  (10, 1),  (30, 3)) AS t0 WHERE t0.EXPR$0 > 50) AS t2 INTERSECT SELECT * FROM (VALUES  (30, 3)) AS t3
; parsing query SELECT * FROM (SELECT * FROM (VALUES(0,0)) EXCEPT SELECT * FROM (VALUES(0,0))) AS t5
;-----------------------------------------------------------
; test name: testEmptyIntersect
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES  (30, 3)) AS t INTERSECT SELECT * FROM (VALUES  (10, 1),  (30, 3)) AS t0 WHERE t0.EXPR$0 > 50) AS t2 INTERSECT SELECT * FROM (VALUES  (30, 3)) AS t3
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES(0,0)) EXCEPT SELECT * FROM (VALUES(0,0))) AS t5
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1507300 Int) (BOUND_VARIABLE_1507301 Int)) (> BOUND_VARIABLE_1507300 BOUND_VARIABLE_1507301)) ((_ tuple.select 0) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1507300 Int) (BOUND_VARIABLE_1507301 Int)) (> BOUND_VARIABLE_1507300 BOUND_VARIABLE_1507301)) ((_ tuple.select 0) t) (nullable.some 50)))))))
(assert (= q1 (bag.inter_min ((_ table.project 0 1) (bag.inter_min ((_ table.project 0 1) (bag (tuple (nullable.some 30) (nullable.some 3)) 1)) ((_ table.project 0 1) (bag.filter p0 (bag.union_disjoint (bag (tuple (nullable.some 10) (nullable.some 1)) 1) (bag (tuple (nullable.some 30) (nullable.some 3)) 1)))))) ((_ table.project 0 1) (bag (tuple (nullable.some 30) (nullable.some 3)) 1)))))
(assert (= q2 ((_ table.project 0 1) (bag.difference_remove ((_ table.project 0 1) (bag (tuple (nullable.some 0) (nullable.some 0)) 1)) ((_ table.project 0 1) (bag (tuple (nullable.some 0) (nullable.some 0)) 1))))))
(check-sat)
;answer: unsat
; duration: 10 ms.
(reset)
; parsing query SELECT EMP.DEPTNO, EMP.DEPTNO + 1, EMP.EMPNO + EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO = 10
; parsing query SELECT 10 AS DEPTNO, 11, EMP0.EMPNO + 10 FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 10
;-----------------------------------------------------------
; test name: testPullConstantIntoProject
;Translating sql query: SELECT EMP.DEPTNO, EMP.DEPTNO + 1, EMP.EMPNO + EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO = 10
;Translating sql query: SELECT 10 AS DEPTNO, 11, EMP0.EMPNO + 10 FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 10
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1507419 Int) (BOUND_VARIABLE_1507420 Int)) (= BOUND_VARIABLE_1507419 BOUND_VARIABLE_1507420)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1507419 Int) (BOUND_VARIABLE_1507420 Int)) (= BOUND_VARIABLE_1507419 BOUND_VARIABLE_1507420)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 7) t) (nullable.lift (lambda ((BOUND_VARIABLE_1507438 Int) (BOUND_VARIABLE_1507439 Int)) (+ BOUND_VARIABLE_1507438 BOUND_VARIABLE_1507439)) ((_ tuple.select 7) t) (nullable.some 1)) (nullable.lift (lambda ((BOUND_VARIABLE_1507445 Int) (BOUND_VARIABLE_1507446 Int)) (+ BOUND_VARIABLE_1507445 BOUND_VARIABLE_1507446)) ((_ tuple.select 0) t) ((_ tuple.select 7) t))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1507462 Int) (BOUND_VARIABLE_1507463 Int)) (= BOUND_VARIABLE_1507462 BOUND_VARIABLE_1507463)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1507462 Int) (BOUND_VARIABLE_1507463 Int)) (= BOUND_VARIABLE_1507462 BOUND_VARIABLE_1507463)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 10) (nullable.some 11) (nullable.lift (lambda ((BOUND_VARIABLE_1507480 Int) (BOUND_VARIABLE_1507481 Int)) (+ BOUND_VARIABLE_1507480 BOUND_VARIABLE_1507481)) ((_ tuple.select 0) t) (nullable.some 10))))))
(assert (= q1 (bag.map f1 (bag.filter p0 EMP))))
(assert (= q2 (bag.map f3 (bag.filter p2 EMP))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10006 ms.
(reset)
; parsing query SELECT * FROM (SELECT EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO < 4) AS t0 INNER JOIN (SELECT EMP0.DEPTNO FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 7 UNION ALL SELECT EMP1.DEPTNO FROM EMP AS EMP1) AS t4 ON t0.DEPTNO = t4.DEPTNO
; parsing query SELECT * FROM (SELECT EMP2.DEPTNO FROM EMP AS EMP2 WHERE EMP2.DEPTNO < 4) AS t6 INNER JOIN (SELECT * FROM (SELECT EMP3.DEPTNO FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 7 UNION ALL SELECT EMP4.DEPTNO FROM EMP AS EMP4) AS t10 WHERE t10.DEPTNO < 4) AS t11 ON t6.DEPTNO = t11.DEPTNO
;-----------------------------------------------------------
; test name: testTransitiveInferenceUnionAlwaysTrue
;Translating sql query: SELECT * FROM (SELECT EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO < 4) AS t0 INNER JOIN (SELECT EMP0.DEPTNO FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 7 UNION ALL SELECT EMP1.DEPTNO FROM EMP AS EMP1) AS t4 ON t0.DEPTNO = t4.DEPTNO
;Translating sql query: SELECT * FROM (SELECT EMP2.DEPTNO FROM EMP AS EMP2 WHERE EMP2.DEPTNO < 4) AS t6 INNER JOIN (SELECT * FROM (SELECT EMP3.DEPTNO FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 7 UNION ALL SELECT EMP4.DEPTNO FROM EMP AS EMP4) AS t10 WHERE t10.DEPTNO < 4) AS t11 ON t6.DEPTNO = t11.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1554949 Int) (BOUND_VARIABLE_1554950 Int)) (< BOUND_VARIABLE_1554949 BOUND_VARIABLE_1554950)) ((_ tuple.select 7) t) (nullable.some 4))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1554949 Int) (BOUND_VARIABLE_1554950 Int)) (< BOUND_VARIABLE_1554949 BOUND_VARIABLE_1554950)) ((_ tuple.select 7) t) (nullable.some 4)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1554969 Int) (BOUND_VARIABLE_1554970 Int)) (> BOUND_VARIABLE_1554969 BOUND_VARIABLE_1554970)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1554969 Int) (BOUND_VARIABLE_1554970 Int)) (> BOUND_VARIABLE_1554969 BOUND_VARIABLE_1554970)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1554992 Int) (BOUND_VARIABLE_1554993 Int)) (= BOUND_VARIABLE_1554992 BOUND_VARIABLE_1554993)) ((_ tuple.select 0) t) ((_ tuple.select 1) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1554992 Int) (BOUND_VARIABLE_1554993 Int)) (= BOUND_VARIABLE_1554992 BOUND_VARIABLE_1554993)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1555011 Int) (BOUND_VARIABLE_1555012 Int)) (< BOUND_VARIABLE_1555011 BOUND_VARIABLE_1555012)) ((_ tuple.select 7) t) (nullable.some 4))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1555011 Int) (BOUND_VARIABLE_1555012 Int)) (< BOUND_VARIABLE_1555011 BOUND_VARIABLE_1555012)) ((_ tuple.select 7) t) (nullable.some 4)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1555030 Int) (BOUND_VARIABLE_1555031 Int)) (> BOUND_VARIABLE_1555030 BOUND_VARIABLE_1555031)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1555030 Int) (BOUND_VARIABLE_1555031 Int)) (> BOUND_VARIABLE_1555030 BOUND_VARIABLE_1555031)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1555050 Int) (BOUND_VARIABLE_1555051 Int)) (< BOUND_VARIABLE_1555050 BOUND_VARIABLE_1555051)) ((_ tuple.select 0) t) (nullable.some 4))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1555050 Int) (BOUND_VARIABLE_1555051 Int)) (< BOUND_VARIABLE_1555050 BOUND_VARIABLE_1555051)) ((_ tuple.select 0) t) (nullable.some 4)))))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1555071 Int) (BOUND_VARIABLE_1555072 Int)) (= BOUND_VARIABLE_1555071 BOUND_VARIABLE_1555072)) ((_ tuple.select 0) t) ((_ tuple.select 1) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1555071 Int) (BOUND_VARIABLE_1555072 Int)) (= BOUND_VARIABLE_1555071 BOUND_VARIABLE_1555072)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p2 (table.product ((_ table.project 7) (bag.filter p0 EMP)) (bag.union_disjoint ((_ table.project 7) (bag.filter p1 EMP)) ((_ table.project 7) EMP)))))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p6 (table.product ((_ table.project 7) (bag.filter p3 EMP)) ((_ table.project 0) (bag.filter p5 (bag.union_disjoint ((_ table.project 7) (bag.filter p4 EMP)) ((_ table.project 7) EMP)))))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10240 ms.
(reset)
; parsing query SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 INTERSECT SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 INTERSECT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
; parsing query SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 INTERSECT SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
;-----------------------------------------------------------
; test name: testMergeIntersect
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 INTERSECT SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 INTERSECT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
;Translating sql query: SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 INTERSECT SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1622993 Int) (BOUND_VARIABLE_1622994 Int)) (= BOUND_VARIABLE_1622993 BOUND_VARIABLE_1622994)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1622993 Int) (BOUND_VARIABLE_1622994 Int)) (= BOUND_VARIABLE_1622993 BOUND_VARIABLE_1622994)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1623013 Int) (BOUND_VARIABLE_1623014 Int)) (= BOUND_VARIABLE_1623013 BOUND_VARIABLE_1623014)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1623013 Int) (BOUND_VARIABLE_1623014 Int)) (= BOUND_VARIABLE_1623013 BOUND_VARIABLE_1623014)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1623034 Int) (BOUND_VARIABLE_1623035 Int)) (= BOUND_VARIABLE_1623034 BOUND_VARIABLE_1623035)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1623034 Int) (BOUND_VARIABLE_1623035 Int)) (= BOUND_VARIABLE_1623034 BOUND_VARIABLE_1623035)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1623054 Int) (BOUND_VARIABLE_1623055 Int)) (= BOUND_VARIABLE_1623054 BOUND_VARIABLE_1623055)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1623054 Int) (BOUND_VARIABLE_1623055 Int)) (= BOUND_VARIABLE_1623054 BOUND_VARIABLE_1623055)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1623073 Int) (BOUND_VARIABLE_1623074 Int)) (= BOUND_VARIABLE_1623073 BOUND_VARIABLE_1623074)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1623073 Int) (BOUND_VARIABLE_1623074 Int)) (= BOUND_VARIABLE_1623073 BOUND_VARIABLE_1623074)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1623093 Int) (BOUND_VARIABLE_1623094 Int)) (= BOUND_VARIABLE_1623093 BOUND_VARIABLE_1623094)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1623093 Int) (BOUND_VARIABLE_1623094 Int)) (= BOUND_VARIABLE_1623093 BOUND_VARIABLE_1623094)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (bag.inter_min ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.inter_min ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)))))
(assert (= q2 (bag.inter_min (bag.inter_min ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)))))
(check-sat)
;answer: unsat
; duration: 943 ms.
(reset)
; parsing query SELECT 1 FROM EMP AS EMP INNER JOIN DEPT AS DEPT ON EMP.DEPTNO = DEPT.DEPTNO
; parsing query SELECT 1 FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO INNER JOIN DEPT AS DEPT1 ON EMP0.DEPTNO = DEPT1.DEPTNO
;-----------------------------------------------------------
; test name: testAddRedundantSemiJoinRule
;Translating sql query: SELECT 1 FROM EMP AS EMP INNER JOIN DEPT AS DEPT ON EMP.DEPTNO = DEPT.DEPTNO
;Translating sql query: SELECT 1 FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO INNER JOIN DEPT AS DEPT1 ON EMP0.DEPTNO = DEPT1.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1629332 Int) (BOUND_VARIABLE_1629333 Int)) (= BOUND_VARIABLE_1629332 BOUND_VARIABLE_1629333)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1629332 Int) (BOUND_VARIABLE_1629333 Int)) (= BOUND_VARIABLE_1629332 BOUND_VARIABLE_1629333)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (tuple (nullable.some 1)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1629359 Int) (BOUND_VARIABLE_1629360 Int)) (= BOUND_VARIABLE_1629359 BOUND_VARIABLE_1629360)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1629359 Int) (BOUND_VARIABLE_1629360 Int)) (= BOUND_VARIABLE_1629359 BOUND_VARIABLE_1629360)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1629379 Int) (BOUND_VARIABLE_1629380 Int)) (= BOUND_VARIABLE_1629379 BOUND_VARIABLE_1629380)) ((_ tuple.select 7) t) ((_ tuple.select 11) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1629379 Int) (BOUND_VARIABLE_1629380 Int)) (= BOUND_VARIABLE_1629379 BOUND_VARIABLE_1629380)) ((_ tuple.select 7) t) ((_ tuple.select 11) t)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f1 (bag.filter p0 (table.product EMP DEPT)))))
(assert (= q2 (bag.map f4 (bag.filter p3 (table.product (bag.filter p2 (table.product EMP DEPT)) DEPT)))))
(check-sat)
;answer: unknown (INCOMPLETE)
; duration: 2831 ms.
(reset)
; parsing query SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME = 'foo'
; parsing query SELECT t1.ENAME FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.ENAME = 'foo') AS t1 INNER JOIN DEPT AS DEPT0 ON t1.DEPTNO = DEPT0.DEPTNO
;-----------------------------------------------------------
; test name: testRemoveSemiJoinWithFilter
;Translating sql query: SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME = 'foo'
;Translating sql query: SELECT t1.ENAME FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.ENAME = 'foo') AS t1 INNER JOIN DEPT AS DEPT0 ON t1.DEPTNO = DEPT0.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Bag (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1655044 Int) (BOUND_VARIABLE_1655045 Int)) (= BOUND_VARIABLE_1655044 BOUND_VARIABLE_1655045)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1655044 Int) (BOUND_VARIABLE_1655045 Int)) (= BOUND_VARIABLE_1655044 BOUND_VARIABLE_1655045)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1655051 String) (BOUND_VARIABLE_1655052 String)) (= BOUND_VARIABLE_1655051 BOUND_VARIABLE_1655052)) ((_ tuple.select 1) t) (nullable.some "foo"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1655051 String) (BOUND_VARIABLE_1655052 String)) (= BOUND_VARIABLE_1655051 BOUND_VARIABLE_1655052)) ((_ tuple.select 1) t) (nullable.some "foo")))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1655044 Int) (BOUND_VARIABLE_1655045 Int)) (= BOUND_VARIABLE_1655044 BOUND_VARIABLE_1655045)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1655051 String) (BOUND_VARIABLE_1655052 String)) (= BOUND_VARIABLE_1655051 BOUND_VARIABLE_1655052)) ((_ tuple.select 1) t) (nullable.some "foo")))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1655044 Int) (BOUND_VARIABLE_1655045 Int)) (= BOUND_VARIABLE_1655044 BOUND_VARIABLE_1655045)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1655051 String) (BOUND_VARIABLE_1655052 String)) (= BOUND_VARIABLE_1655051 BOUND_VARIABLE_1655052)) ((_ tuple.select 1) t) (nullable.some "foo")))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1655044 Int) (BOUND_VARIABLE_1655045 Int)) (= BOUND_VARIABLE_1655044 BOUND_VARIABLE_1655045)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1655044 Int) (BOUND_VARIABLE_1655045 Int)) (= BOUND_VARIABLE_1655044 BOUND_VARIABLE_1655045)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1655051 String) (BOUND_VARIABLE_1655052 String)) (= BOUND_VARIABLE_1655051 BOUND_VARIABLE_1655052)) ((_ tuple.select 1) t) (nullable.some "foo"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1655051 String) (BOUND_VARIABLE_1655052 String)) (= BOUND_VARIABLE_1655051 BOUND_VARIABLE_1655052)) ((_ tuple.select 1) t) (nullable.some "foo")))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1655044 Int) (BOUND_VARIABLE_1655045 Int)) (= BOUND_VARIABLE_1655044 BOUND_VARIABLE_1655045)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1655051 String) (BOUND_VARIABLE_1655052 String)) (= BOUND_VARIABLE_1655051 BOUND_VARIABLE_1655052)) ((_ tuple.select 1) t) (nullable.some "foo")))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1655044 Int) (BOUND_VARIABLE_1655045 Int)) (= BOUND_VARIABLE_1655044 BOUND_VARIABLE_1655045)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1655051 String) (BOUND_VARIABLE_1655052 String)) (= BOUND_VARIABLE_1655051 BOUND_VARIABLE_1655052)) ((_ tuple.select 1) t) (nullable.some "foo"))))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1655085 String) (BOUND_VARIABLE_1655086 String)) (= BOUND_VARIABLE_1655085 BOUND_VARIABLE_1655086)) ((_ tuple.select 1) t) (nullable.some "foo"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1655085 String) (BOUND_VARIABLE_1655086 String)) (= BOUND_VARIABLE_1655085 BOUND_VARIABLE_1655086)) ((_ tuple.select 1) t) (nullable.some "foo")))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1655106 Int) (BOUND_VARIABLE_1655107 Int)) (= BOUND_VARIABLE_1655106 BOUND_VARIABLE_1655107)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1655106 Int) (BOUND_VARIABLE_1655107 Int)) (= BOUND_VARIABLE_1655106 BOUND_VARIABLE_1655107)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ table.project 1) (bag.filter p0 (table.product EMP DEPT)))))
(assert (= q2 ((_ table.project 1) (bag.filter p2 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)) DEPT)))))
(check-sat)
;answer: unknown (INCOMPLETE)
; duration: 1207 ms.
(reset)
; parsing query SELECT 1 FROM DEPT AS DEPT RIGHT JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charlie'
; parsing query SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 INNER JOIN EMP AS EMP0 ON t1.DEPTNO = EMP0.DEPTNO
;-----------------------------------------------------------
; test name: testRightOuterJoinSimplificationToInner
;Translating sql query: SELECT 1 FROM DEPT AS DEPT RIGHT JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charlie'
;Translating sql query: SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 INNER JOIN EMP AS EMP0 ON t1.DEPTNO = EMP0.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const rightJoin1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1662249 Int) (BOUND_VARIABLE_1662250 Int)) (= BOUND_VARIABLE_1662249 BOUND_VARIABLE_1662250)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1662249 Int) (BOUND_VARIABLE_1662250 Int)) (= BOUND_VARIABLE_1662249 BOUND_VARIABLE_1662250)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1662289 String) (BOUND_VARIABLE_1662290 String)) (= BOUND_VARIABLE_1662289 BOUND_VARIABLE_1662290)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1662289 String) (BOUND_VARIABLE_1662290 String)) (= BOUND_VARIABLE_1662289 BOUND_VARIABLE_1662290)) ((_ tuple.select 1) t) (nullable.some "Charlie")))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1662315 String) (BOUND_VARIABLE_1662316 String)) (= BOUND_VARIABLE_1662315 BOUND_VARIABLE_1662316)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1662315 String) (BOUND_VARIABLE_1662316 String)) (= BOUND_VARIABLE_1662315 BOUND_VARIABLE_1662316)) ((_ tuple.select 1) t) (nullable.some "Charlie")))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1662336 Int) (BOUND_VARIABLE_1662337 Int)) (= BOUND_VARIABLE_1662336 BOUND_VARIABLE_1662337)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1662336 Int) (BOUND_VARIABLE_1662337 Int)) (= BOUND_VARIABLE_1662336 BOUND_VARIABLE_1662337)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f3 (bag.filter p2 (bag.union_disjoint (bag.map rightJoin1 (bag.difference_remove EMP ((_ table.project 2 3 4 5 6 7 8 9 10) (bag.filter p0 (table.product DEPT EMP))))) (bag.filter p0 (table.product DEPT EMP)))))))
(assert (= q2 (bag.map f6 (bag.filter p5 (table.product ((_ table.project 0 1) (bag.filter p4 DEPT)) EMP)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10028 ms.
(reset)
; parsing query SELECT DEPT.DEPTNO, EMP.DEPTNO AS DEPTNO0 FROM DEPT AS DEPT, EMP AS EMP WHERE DEPT.DEPTNO + 10 = EMP.DEPTNO * 2
; parsing query SELECT t1.DEPTNO, t2.DEPTNO AS DEPTNO0 FROM (SELECT DEPT0.DEPTNO, DEPT0.NAME, DEPT0.DEPTNO + 10 AS f2 FROM DEPT AS DEPT0) AS t1 INNER JOIN (SELECT EMP0.EMPNO, EMP0.ENAME, EMP0.JOB, EMP0.MGR, EMP0.HIREDATE, EMP0.SAL, EMP0.COMM, EMP0.DEPTNO, EMP0.SLACKER, EMP0.DEPTNO * 2 AS f9 FROM EMP AS EMP0) AS t2 ON t1.f2 = t2.f9
;-----------------------------------------------------------
; test name: testPushJoinCondDownToProject
;Translating sql query: SELECT DEPT.DEPTNO, EMP.DEPTNO AS DEPTNO0 FROM DEPT AS DEPT, EMP AS EMP WHERE DEPT.DEPTNO + 10 = EMP.DEPTNO * 2
;Translating sql query: SELECT t1.DEPTNO, t2.DEPTNO AS DEPTNO0 FROM (SELECT DEPT0.DEPTNO, DEPT0.NAME, DEPT0.DEPTNO + 10 AS f2 FROM DEPT AS DEPT0) AS t1 INNER JOIN (SELECT EMP0.EMPNO, EMP0.ENAME, EMP0.JOB, EMP0.MGR, EMP0.HIREDATE, EMP0.SAL, EMP0.COMM, EMP0.DEPTNO, EMP0.SLACKER, EMP0.DEPTNO * 2 AS f9 FROM EMP AS EMP0) AS t2 ON t1.f2 = t2.f9
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1704854 Int) (BOUND_VARIABLE_1704855 Int)) (= BOUND_VARIABLE_1704854 BOUND_VARIABLE_1704855)) (nullable.lift (lambda ((BOUND_VARIABLE_1704841 Int) (BOUND_VARIABLE_1704842 Int)) (+ BOUND_VARIABLE_1704841 BOUND_VARIABLE_1704842)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1704848 Int) (BOUND_VARIABLE_1704849 Int)) (* BOUND_VARIABLE_1704848 BOUND_VARIABLE_1704849)) ((_ tuple.select 9) t) (nullable.some 2)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1704854 Int) (BOUND_VARIABLE_1704855 Int)) (= BOUND_VARIABLE_1704854 BOUND_VARIABLE_1704855)) (nullable.lift (lambda ((BOUND_VARIABLE_1704841 Int) (BOUND_VARIABLE_1704842 Int)) (+ BOUND_VARIABLE_1704841 BOUND_VARIABLE_1704842)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1704848 Int) (BOUND_VARIABLE_1704849 Int)) (* BOUND_VARIABLE_1704848 BOUND_VARIABLE_1704849)) ((_ tuple.select 9) t) (nullable.some 2))))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (nullable.lift (lambda ((BOUND_VARIABLE_1704876 Int) (BOUND_VARIABLE_1704877 Int)) (+ BOUND_VARIABLE_1704876 BOUND_VARIABLE_1704877)) ((_ tuple.select 0) t) (nullable.some 10))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 6) t) ((_ tuple.select 5) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_1704900 Int) (BOUND_VARIABLE_1704901 Int)) (* BOUND_VARIABLE_1704900 BOUND_VARIABLE_1704901)) ((_ tuple.select 7) t) (nullable.some 2))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1704918 Int) (BOUND_VARIABLE_1704919 Int)) (= BOUND_VARIABLE_1704918 BOUND_VARIABLE_1704919)) ((_ tuple.select 2) t) ((_ tuple.select 12) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1704918 Int) (BOUND_VARIABLE_1704919 Int)) (= BOUND_VARIABLE_1704918 BOUND_VARIABLE_1704919)) ((_ tuple.select 2) t) ((_ tuple.select 12) t)))))))
(assert (= q1 ((_ table.project 0 9) (bag.filter p0 (table.product DEPT EMP)))))
(assert (= q2 ((_ table.project 0 10) (bag.filter p3 (table.product (bag.map f1 DEPT) (bag.map f2 EMP))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10272 ms.
(reset)
; parsing query SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = EMP0.DEPTNO AND DEPT.NAME = 'foo'
; parsing query SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'foo') AS t1 ON EMP1.DEPTNO = t1.DEPTNO INNER JOIN EMP AS EMP2 ON t1.DEPTNO = EMP2.DEPTNO
;-----------------------------------------------------------
; test name: testRemoveSemiJoinRightWithFilter
;Translating sql query: SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = EMP0.DEPTNO AND DEPT.NAME = 'foo'
;Translating sql query: SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'foo') AS t1 ON EMP1.DEPTNO = t1.DEPTNO INNER JOIN EMP AS EMP2 ON t1.DEPTNO = EMP2.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1750853 Int) (BOUND_VARIABLE_1750854 Int)) (= BOUND_VARIABLE_1750853 BOUND_VARIABLE_1750854)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1750853 Int) (BOUND_VARIABLE_1750854 Int)) (= BOUND_VARIABLE_1750853 BOUND_VARIABLE_1750854)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1750860 Int) (BOUND_VARIABLE_1750861 Int)) (= BOUND_VARIABLE_1750860 BOUND_VARIABLE_1750861)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1750860 Int) (BOUND_VARIABLE_1750861 Int)) (= BOUND_VARIABLE_1750860 BOUND_VARIABLE_1750861)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1750853 Int) (BOUND_VARIABLE_1750854 Int)) (= BOUND_VARIABLE_1750853 BOUND_VARIABLE_1750854)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1750860 Int) (BOUND_VARIABLE_1750861 Int)) (= BOUND_VARIABLE_1750860 BOUND_VARIABLE_1750861)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1750853 Int) (BOUND_VARIABLE_1750854 Int)) (= BOUND_VARIABLE_1750853 BOUND_VARIABLE_1750854)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1750860 Int) (BOUND_VARIABLE_1750861 Int)) (= BOUND_VARIABLE_1750860 BOUND_VARIABLE_1750861)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1750853 Int) (BOUND_VARIABLE_1750854 Int)) (= BOUND_VARIABLE_1750853 BOUND_VARIABLE_1750854)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1750853 Int) (BOUND_VARIABLE_1750854 Int)) (= BOUND_VARIABLE_1750853 BOUND_VARIABLE_1750854)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1750860 Int) (BOUND_VARIABLE_1750861 Int)) (= BOUND_VARIABLE_1750860 BOUND_VARIABLE_1750861)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1750860 Int) (BOUND_VARIABLE_1750861 Int)) (= BOUND_VARIABLE_1750860 BOUND_VARIABLE_1750861)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1750853 Int) (BOUND_VARIABLE_1750854 Int)) (= BOUND_VARIABLE_1750853 BOUND_VARIABLE_1750854)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1750860 Int) (BOUND_VARIABLE_1750861 Int)) (= BOUND_VARIABLE_1750860 BOUND_VARIABLE_1750861)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1750853 Int) (BOUND_VARIABLE_1750854 Int)) (= BOUND_VARIABLE_1750853 BOUND_VARIABLE_1750854)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1750860 Int) (BOUND_VARIABLE_1750861 Int)) (= BOUND_VARIABLE_1750860 BOUND_VARIABLE_1750861)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1750901 String) (BOUND_VARIABLE_1750902 String)) (= BOUND_VARIABLE_1750901 BOUND_VARIABLE_1750902)) ((_ tuple.select 1) t) (nullable.some "foo"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1750901 String) (BOUND_VARIABLE_1750902 String)) (= BOUND_VARIABLE_1750901 BOUND_VARIABLE_1750902)) ((_ tuple.select 1) t) (nullable.some "foo")))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1750922 Int) (BOUND_VARIABLE_1750923 Int)) (= BOUND_VARIABLE_1750922 BOUND_VARIABLE_1750923)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1750922 Int) (BOUND_VARIABLE_1750923 Int)) (= BOUND_VARIABLE_1750922 BOUND_VARIABLE_1750923)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1750942 Int) (BOUND_VARIABLE_1750943 Int)) (= BOUND_VARIABLE_1750942 BOUND_VARIABLE_1750943)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1750942 Int) (BOUND_VARIABLE_1750943 Int)) (= BOUND_VARIABLE_1750942 BOUND_VARIABLE_1750943)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)))))))
(assert (= q1 ((_ table.project 1) (bag.filter p0 (table.product (table.product EMP DEPT) EMP)))))
(assert (= q2 ((_ table.project 1) (bag.filter p3 (table.product (bag.filter p2 (table.product EMP ((_ table.project 0 1) (bag.filter p1 DEPT)))) EMP)))))
(check-sat)
;answer: unknown (INCOMPLETE)
; duration: 7556 ms.
(reset)
; parsing query SELECT 1 FROM DEPT AS DEPT FULL JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charlie'
; parsing query SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 LEFT JOIN EMP AS EMP0 ON t1.DEPTNO = EMP0.DEPTNO
;-----------------------------------------------------------
; test name: testFullOuterJoinSimplificationToLeftOuter
;Translating sql query: SELECT 1 FROM DEPT AS DEPT FULL JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charlie'
;Translating sql query: SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 LEFT JOIN EMP AS EMP0 ON t1.DEPTNO = EMP0.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const f8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const leftJoin1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const rightJoin2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const leftJoin7 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1790733 Int) (BOUND_VARIABLE_1790734 Int)) (= BOUND_VARIABLE_1790733 BOUND_VARIABLE_1790734)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1790733 Int) (BOUND_VARIABLE_1790734 Int)) (= BOUND_VARIABLE_1790733 BOUND_VARIABLE_1790734)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1790787 String) (BOUND_VARIABLE_1790788 String)) (= BOUND_VARIABLE_1790787 BOUND_VARIABLE_1790788)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1790787 String) (BOUND_VARIABLE_1790788 String)) (= BOUND_VARIABLE_1790787 BOUND_VARIABLE_1790788)) ((_ tuple.select 1) t) (nullable.some "Charlie")))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1790813 String) (BOUND_VARIABLE_1790814 String)) (= BOUND_VARIABLE_1790813 BOUND_VARIABLE_1790814)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1790813 String) (BOUND_VARIABLE_1790814 String)) (= BOUND_VARIABLE_1790813 BOUND_VARIABLE_1790814)) ((_ tuple.select 1) t) (nullable.some "Charlie")))))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1790834 Int) (BOUND_VARIABLE_1790835 Int)) (= BOUND_VARIABLE_1790834 BOUND_VARIABLE_1790835)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1790834 Int) (BOUND_VARIABLE_1790835 Int)) (= BOUND_VARIABLE_1790834 BOUND_VARIABLE_1790835)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f4 (bag.filter p3 (bag.union_disjoint (bag.union_disjoint (bag.map leftJoin1 (bag.difference_remove DEPT ((_ table.project 0 1) (bag.filter p0 (table.product DEPT EMP))))) (bag.map rightJoin2 (bag.difference_remove EMP ((_ table.project 2 3 4 5 6 7 8 9 10) (bag.filter p0 (table.product DEPT EMP)))))) (bag.filter p0 (table.product DEPT EMP)))))))
(assert (= q2 (bag.map f8 (bag.union_disjoint (bag.map leftJoin7 (bag.difference_remove ((_ table.project 0 1) (bag.filter p5 DEPT)) ((_ table.project 0 1) (bag.filter p6 (table.product ((_ table.project 0 1) (bag.filter p5 DEPT)) EMP))))) (bag.filter p6 (table.product ((_ table.project 0 1) (bag.filter p5 DEPT)) EMP))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10430 ms.
(reset)
; parsing query SELECT 1 FROM (SELECT EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO > 7 UNION ALL SELECT EMP0.DEPTNO FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 10) AS t3 INNER JOIN EMP AS EMP1 ON t3.DEPTNO = EMP1.DEPTNO
; parsing query SELECT 1 FROM (SELECT EMP2.DEPTNO FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7 UNION ALL SELECT EMP3.DEPTNO FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 10) AS t9 INNER JOIN (SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 7 OR EMP4.DEPTNO > 10) AS t10 ON t9.DEPTNO = t10.DEPTNO
;-----------------------------------------------------------
; test name: testTransitiveInferenceUnion
;Translating sql query: SELECT 1 FROM (SELECT EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO > 7 UNION ALL SELECT EMP0.DEPTNO FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 10) AS t3 INNER JOIN EMP AS EMP1 ON t3.DEPTNO = EMP1.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT EMP2.DEPTNO FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7 UNION ALL SELECT EMP3.DEPTNO FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 10) AS t9 INNER JOIN (SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 7 OR EMP4.DEPTNO > 10) AS t10 ON t9.DEPTNO = t10.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f8 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1832776 Int) (BOUND_VARIABLE_1832777 Int)) (> BOUND_VARIABLE_1832776 BOUND_VARIABLE_1832777)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1832776 Int) (BOUND_VARIABLE_1832777 Int)) (> BOUND_VARIABLE_1832776 BOUND_VARIABLE_1832777)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1832796 Int) (BOUND_VARIABLE_1832797 Int)) (> BOUND_VARIABLE_1832796 BOUND_VARIABLE_1832797)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1832796 Int) (BOUND_VARIABLE_1832797 Int)) (> BOUND_VARIABLE_1832796 BOUND_VARIABLE_1832797)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1832818 Int) (BOUND_VARIABLE_1832819 Int)) (= BOUND_VARIABLE_1832818 BOUND_VARIABLE_1832819)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1832818 Int) (BOUND_VARIABLE_1832819 Int)) (= BOUND_VARIABLE_1832818 BOUND_VARIABLE_1832819)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1832844 Int) (BOUND_VARIABLE_1832845 Int)) (> BOUND_VARIABLE_1832844 BOUND_VARIABLE_1832845)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1832844 Int) (BOUND_VARIABLE_1832845 Int)) (> BOUND_VARIABLE_1832844 BOUND_VARIABLE_1832845)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1832863 Int) (BOUND_VARIABLE_1832864 Int)) (> BOUND_VARIABLE_1832863 BOUND_VARIABLE_1832864)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1832863 Int) (BOUND_VARIABLE_1832864 Int)) (> BOUND_VARIABLE_1832863 BOUND_VARIABLE_1832864)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1832883 Int) (BOUND_VARIABLE_1832884 Int)) (> BOUND_VARIABLE_1832883 BOUND_VARIABLE_1832884)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1832883 Int) (BOUND_VARIABLE_1832884 Int)) (> BOUND_VARIABLE_1832883 BOUND_VARIABLE_1832884)) ((_ tuple.select 7) t) (nullable.some 7)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1832889 Int) (BOUND_VARIABLE_1832890 Int)) (> BOUND_VARIABLE_1832889 BOUND_VARIABLE_1832890)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1832889 Int) (BOUND_VARIABLE_1832890 Int)) (> BOUND_VARIABLE_1832889 BOUND_VARIABLE_1832890)) ((_ tuple.select 7) t) (nullable.some 10))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1832883 Int) (BOUND_VARIABLE_1832884 Int)) (> BOUND_VARIABLE_1832883 BOUND_VARIABLE_1832884)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1832889 Int) (BOUND_VARIABLE_1832890 Int)) (> BOUND_VARIABLE_1832889 BOUND_VARIABLE_1832890)) ((_ tuple.select 7) t) (nullable.some 10)))) (or (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1832883 Int) (BOUND_VARIABLE_1832884 Int)) (> BOUND_VARIABLE_1832883 BOUND_VARIABLE_1832884)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1832889 Int) (BOUND_VARIABLE_1832890 Int)) (> BOUND_VARIABLE_1832889 BOUND_VARIABLE_1832890)) ((_ tuple.select 7) t) (nullable.some 10)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1832883 Int) (BOUND_VARIABLE_1832884 Int)) (> BOUND_VARIABLE_1832883 BOUND_VARIABLE_1832884)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1832883 Int) (BOUND_VARIABLE_1832884 Int)) (> BOUND_VARIABLE_1832883 BOUND_VARIABLE_1832884)) ((_ tuple.select 7) t) (nullable.some 7)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1832889 Int) (BOUND_VARIABLE_1832890 Int)) (> BOUND_VARIABLE_1832889 BOUND_VARIABLE_1832890)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1832889 Int) (BOUND_VARIABLE_1832890 Int)) (> BOUND_VARIABLE_1832889 BOUND_VARIABLE_1832890)) ((_ tuple.select 7) t) (nullable.some 10))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1832883 Int) (BOUND_VARIABLE_1832884 Int)) (> BOUND_VARIABLE_1832883 BOUND_VARIABLE_1832884)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1832889 Int) (BOUND_VARIABLE_1832890 Int)) (> BOUND_VARIABLE_1832889 BOUND_VARIABLE_1832890)) ((_ tuple.select 7) t) (nullable.some 10)))) (or (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1832883 Int) (BOUND_VARIABLE_1832884 Int)) (> BOUND_VARIABLE_1832883 BOUND_VARIABLE_1832884)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1832889 Int) (BOUND_VARIABLE_1832890 Int)) (> BOUND_VARIABLE_1832889 BOUND_VARIABLE_1832890)) ((_ tuple.select 7) t) (nullable.some 10))))))))))))
(assert (not (= q1 q2)))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1832922 Int) (BOUND_VARIABLE_1832923 Int)) (= BOUND_VARIABLE_1832922 BOUND_VARIABLE_1832923)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1832922 Int) (BOUND_VARIABLE_1832923 Int)) (= BOUND_VARIABLE_1832922 BOUND_VARIABLE_1832923)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f3 (bag.filter p2 (table.product (bag.union_disjoint ((_ table.project 7) (bag.filter p0 EMP)) ((_ table.project 7) (bag.filter p1 EMP))) EMP)))))
(assert (= q2 (bag.map f8 (bag.filter p7 (table.product (bag.union_disjoint ((_ table.project 7) (bag.filter p4 EMP)) ((_ table.project 7) (bag.filter p5 EMP))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p6 EMP)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10224 ms.
(reset)
; parsing query SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.EMPNO = 10) AS t LEFT JOIN DEPT AS DEPT ON t.EMPNO = DEPT.DEPTNO
; parsing query SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.EMPNO = 10) AS t0 LEFT JOIN (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO = 10) AS t1 ON TRUE
;-----------------------------------------------------------
; test name: testPullConstantIntoJoin
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.EMPNO = 10) AS t LEFT JOIN DEPT AS DEPT ON t.EMPNO = DEPT.DEPTNO
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.EMPNO = 10) AS t0 LEFT JOIN (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO = 10) AS t1 ON TRUE
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const leftJoin2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const leftJoin5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1874790 Int) (BOUND_VARIABLE_1874791 Int)) (= BOUND_VARIABLE_1874790 BOUND_VARIABLE_1874791)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1874790 Int) (BOUND_VARIABLE_1874791 Int)) (= BOUND_VARIABLE_1874790 BOUND_VARIABLE_1874791)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1874813 Int) (BOUND_VARIABLE_1874814 Int)) (= BOUND_VARIABLE_1874813 BOUND_VARIABLE_1874814)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1874813 Int) (BOUND_VARIABLE_1874814 Int)) (= BOUND_VARIABLE_1874813 BOUND_VARIABLE_1874814)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1874854 Int) (BOUND_VARIABLE_1874855 Int)) (= BOUND_VARIABLE_1874854 BOUND_VARIABLE_1874855)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1874854 Int) (BOUND_VARIABLE_1874855 Int)) (= BOUND_VARIABLE_1874854 BOUND_VARIABLE_1874855)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1874873 Int) (BOUND_VARIABLE_1874874 Int)) (= BOUND_VARIABLE_1874873 BOUND_VARIABLE_1874874)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1874873 Int) (BOUND_VARIABLE_1874874 Int)) (= BOUND_VARIABLE_1874873 BOUND_VARIABLE_1874874)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= leftJoin5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map leftJoin2 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) DEPT))))) (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) DEPT))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map leftJoin5 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1) (bag.filter p4 DEPT)))))) (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1) (bag.filter p4 DEPT)))))))
(check-sat)
;answer: unsat
; duration: 2510 ms.
(reset)
; parsing query SELECT 1 FROM DEPT AS DEPT LEFT JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO
; parsing query SELECT 1 FROM EMP AS EMP0 RIGHT JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO
;-----------------------------------------------------------
; test name: testSwapOuterJoin
;Translating sql query: SELECT 1 FROM DEPT AS DEPT LEFT JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO
;Translating sql query: SELECT 1 FROM EMP AS EMP0 RIGHT JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const leftJoin1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const rightJoin4 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1887684 Int) (BOUND_VARIABLE_1887685 Int)) (= BOUND_VARIABLE_1887684 BOUND_VARIABLE_1887685)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1887684 Int) (BOUND_VARIABLE_1887685 Int)) (= BOUND_VARIABLE_1887684 BOUND_VARIABLE_1887685)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1887727 Int) (BOUND_VARIABLE_1887728 Int)) (= BOUND_VARIABLE_1887727 BOUND_VARIABLE_1887728)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1887727 Int) (BOUND_VARIABLE_1887728 Int)) (= BOUND_VARIABLE_1887727 BOUND_VARIABLE_1887728)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f2 (bag.union_disjoint (bag.map leftJoin1 (bag.difference_remove DEPT ((_ table.project 0 1) (bag.filter p0 (table.product DEPT EMP))))) (bag.filter p0 (table.product DEPT EMP))))))
(assert (= q2 (bag.map f5 (bag.union_disjoint (bag.map rightJoin4 (bag.difference_remove DEPT ((_ table.project 9 10) (bag.filter p3 (table.product EMP DEPT))))) (bag.filter p3 (table.product EMP DEPT))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10074 ms.
(reset)
; parsing query SELECT t.SAL FROM (SELECT * FROM EMP AS EMP UNION ALL SELECT * FROM EMP AS EMP0) AS t, EMP AS EMP1
; parsing query SELECT t1.SAL FROM (SELECT * FROM EMP AS EMP2, EMP AS EMP3 UNION ALL SELECT * FROM EMP AS EMP4, EMP AS EMP5) AS t1
;-----------------------------------------------------------
; test name: testPushJoinThroughUnionOnLeft
;Translating sql query: SELECT t.SAL FROM (SELECT * FROM EMP AS EMP UNION ALL SELECT * FROM EMP AS EMP0) AS t, EMP AS EMP1
;Translating sql query: SELECT t1.SAL FROM (SELECT * FROM EMP AS EMP2, EMP AS EMP3 UNION ALL SELECT * FROM EMP AS EMP4, EMP AS EMP5) AS t1
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= q1 ((_ table.project 6) (table.product (bag.union_disjoint ((_ table.project 0 1 2 3 4 5 6 7 8) EMP) ((_ table.project 0 1 2 3 4 5 6 7 8) EMP)) EMP))))
(assert (= q2 ((_ table.project 6) (bag.union_disjoint ((_ table.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) (table.product EMP EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) (table.product EMP EMP))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 12552 ms.
(reset)
; parsing query SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION ALL SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
; parsing query SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
;-----------------------------------------------------------
; test name: testMergeUnionMixed2
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION ALL SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
;Translating sql query: SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2105119 Int) (BOUND_VARIABLE_2105120 Int)) (= BOUND_VARIABLE_2105119 BOUND_VARIABLE_2105120)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2105119 Int) (BOUND_VARIABLE_2105120 Int)) (= BOUND_VARIABLE_2105119 BOUND_VARIABLE_2105120)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2105139 Int) (BOUND_VARIABLE_2105140 Int)) (= BOUND_VARIABLE_2105139 BOUND_VARIABLE_2105140)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2105139 Int) (BOUND_VARIABLE_2105140 Int)) (= BOUND_VARIABLE_2105139 BOUND_VARIABLE_2105140)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2105160 Int) (BOUND_VARIABLE_2105161 Int)) (= BOUND_VARIABLE_2105160 BOUND_VARIABLE_2105161)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2105160 Int) (BOUND_VARIABLE_2105161 Int)) (= BOUND_VARIABLE_2105160 BOUND_VARIABLE_2105161)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2105180 Int) (BOUND_VARIABLE_2105181 Int)) (= BOUND_VARIABLE_2105180 BOUND_VARIABLE_2105181)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2105180 Int) (BOUND_VARIABLE_2105181 Int)) (= BOUND_VARIABLE_2105180 BOUND_VARIABLE_2105181)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2105199 Int) (BOUND_VARIABLE_2105200 Int)) (= BOUND_VARIABLE_2105199 BOUND_VARIABLE_2105200)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2105199 Int) (BOUND_VARIABLE_2105200 Int)) (= BOUND_VARIABLE_2105199 BOUND_VARIABLE_2105200)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2105219 Int) (BOUND_VARIABLE_2105220 Int)) (= BOUND_VARIABLE_2105219 BOUND_VARIABLE_2105220)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2105219 Int) (BOUND_VARIABLE_2105220 Int)) (= BOUND_VARIABLE_2105219 BOUND_VARIABLE_2105220)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (bag.union_max ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.union_disjoint ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)))))
(assert (= q2 (bag.union_max (bag.union_max ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)))))
(check-sat)
;answer: unsat
; duration: 1742 ms.
(reset)
; parsing query SELECT * FROM (VALUES  (1, 2)) AS t WHERE 1 + 2 > 3 + CAST(NULL AS INT)
; parsing query SELECT * FROM (SELECT * FROM (VALUES(0, 0)) WHERE FALSE) AS t1
;-----------------------------------------------------------
; test name: testReduceConstantsEliminatesFilter
;Translating sql query: SELECT * FROM (VALUES  (1, 2)) AS t WHERE 1 + 2 > 3 + CAST(NULL AS INT)
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES(0, 0)) WHERE FALSE) AS t1
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2112075 Int) (BOUND_VARIABLE_2112076 Int)) (> BOUND_VARIABLE_2112075 BOUND_VARIABLE_2112076)) (nullable.lift (lambda ((BOUND_VARIABLE_2112063 Int) (BOUND_VARIABLE_2112064 Int)) (+ BOUND_VARIABLE_2112063 BOUND_VARIABLE_2112064)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_2112069 Int) (BOUND_VARIABLE_2112070 Int)) (+ BOUND_VARIABLE_2112069 BOUND_VARIABLE_2112070)) (nullable.some 3) (as nullable.null (Nullable Int))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2112075 Int) (BOUND_VARIABLE_2112076 Int)) (> BOUND_VARIABLE_2112075 BOUND_VARIABLE_2112076)) (nullable.lift (lambda ((BOUND_VARIABLE_2112063 Int) (BOUND_VARIABLE_2112064 Int)) (+ BOUND_VARIABLE_2112063 BOUND_VARIABLE_2112064)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_2112069 Int) (BOUND_VARIABLE_2112070 Int)) (+ BOUND_VARIABLE_2112069 BOUND_VARIABLE_2112070)) (nullable.some 3) (as nullable.null (Nullable Int)))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 (bag (tuple (nullable.some 1) (nullable.some 2)) 1)))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p1 (bag (tuple (nullable.some 0) (nullable.some 0)) 1)))))
(check-sat)
;answer: unsat
; duration: 12 ms.
(reset)
; parsing query SELECT EMP.MGR FROM EMP AS EMP WHERE CASE WHEN EMP.MGR < 10 THEN TRUE ELSE FALSE END
; parsing query SELECT * FROM (SELECT EMP0.MGR FROM EMP AS EMP0) AS t2 WHERE t2.MGR < 10
;-----------------------------------------------------------
; test name: testPushProjectPastFilter2*
;Translating sql query: SELECT EMP.MGR FROM EMP AS EMP WHERE CASE WHEN EMP.MGR < 10 THEN TRUE ELSE FALSE END
;Translating sql query: SELECT * FROM (SELECT EMP0.MGR FROM EMP AS EMP0) AS t2 WHERE t2.MGR < 10
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2112175 Int) (BOUND_VARIABLE_2112176 Int)) (< BOUND_VARIABLE_2112175 BOUND_VARIABLE_2112176)) ((_ tuple.select 3) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2112175 Int) (BOUND_VARIABLE_2112176 Int)) (< BOUND_VARIABLE_2112175 BOUND_VARIABLE_2112176)) ((_ tuple.select 3) t) (nullable.some 10)))) (nullable.some true) (nullable.some false))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2112175 Int) (BOUND_VARIABLE_2112176 Int)) (< BOUND_VARIABLE_2112175 BOUND_VARIABLE_2112176)) ((_ tuple.select 3) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2112175 Int) (BOUND_VARIABLE_2112176 Int)) (< BOUND_VARIABLE_2112175 BOUND_VARIABLE_2112176)) ((_ tuple.select 3) t) (nullable.some 10)))) (nullable.some true) (nullable.some false)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2112201 Int) (BOUND_VARIABLE_2112202 Int)) (< BOUND_VARIABLE_2112201 BOUND_VARIABLE_2112202)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2112201 Int) (BOUND_VARIABLE_2112202 Int)) (< BOUND_VARIABLE_2112201 BOUND_VARIABLE_2112202)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= q1 ((_ table.project 3) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0) (bag.filter p1 ((_ table.project 3) EMP)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10004 ms.
(reset)
; parsing query SELECT t0.SAL FROM (SELECT * FROM (SELECT EMP.SAL, EMP.DEPTNO FROM EMP AS EMP) AS t WHERE t.DEPTNO = 200) AS t0 INNER JOIN (SELECT t1.DEPTNO FROM (SELECT EMP0.SAL, EMP0.DEPTNO FROM EMP AS EMP0) AS t1 WHERE t1.SAL = 100) AS t3 ON t0.DEPTNO = t3.DEPTNO
; parsing query SELECT t6.SAL FROM (SELECT * FROM (SELECT EMP1.SAL, EMP1.DEPTNO FROM EMP AS EMP1) AS t5 WHERE t5.DEPTNO = 200) AS t6 INNER JOIN (SELECT t7.DEPTNO FROM (SELECT EMP2.SAL, EMP2.DEPTNO FROM EMP AS EMP2) AS t7 WHERE t7.SAL = 100) AS t9 ON t6.DEPTNO = t9.DEPTNO
;-----------------------------------------------------------
; test name: testSemiJoinReduceConstants
;Translating sql query: SELECT t0.SAL FROM (SELECT * FROM (SELECT EMP.SAL, EMP.DEPTNO FROM EMP AS EMP) AS t WHERE t.DEPTNO = 200) AS t0 INNER JOIN (SELECT t1.DEPTNO FROM (SELECT EMP0.SAL, EMP0.DEPTNO FROM EMP AS EMP0) AS t1 WHERE t1.SAL = 100) AS t3 ON t0.DEPTNO = t3.DEPTNO
;Translating sql query: SELECT t6.SAL FROM (SELECT * FROM (SELECT EMP1.SAL, EMP1.DEPTNO FROM EMP AS EMP1) AS t5 WHERE t5.DEPTNO = 200) AS t6 INNER JOIN (SELECT t7.DEPTNO FROM (SELECT EMP2.SAL, EMP2.DEPTNO FROM EMP AS EMP2) AS t7 WHERE t7.SAL = 100) AS t9 ON t6.DEPTNO = t9.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2150359 Int) (BOUND_VARIABLE_2150360 Int)) (= BOUND_VARIABLE_2150359 BOUND_VARIABLE_2150360)) ((_ tuple.select 1) t) (nullable.some 200))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2150359 Int) (BOUND_VARIABLE_2150360 Int)) (= BOUND_VARIABLE_2150359 BOUND_VARIABLE_2150360)) ((_ tuple.select 1) t) (nullable.some 200)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2150379 Int) (BOUND_VARIABLE_2150380 Int)) (= BOUND_VARIABLE_2150379 BOUND_VARIABLE_2150380)) ((_ tuple.select 0) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2150379 Int) (BOUND_VARIABLE_2150380 Int)) (= BOUND_VARIABLE_2150379 BOUND_VARIABLE_2150380)) ((_ tuple.select 0) t) (nullable.some 100)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2150400 Int) (BOUND_VARIABLE_2150401 Int)) (= BOUND_VARIABLE_2150400 BOUND_VARIABLE_2150401)) ((_ tuple.select 1) t) ((_ tuple.select 2) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2150400 Int) (BOUND_VARIABLE_2150401 Int)) (= BOUND_VARIABLE_2150400 BOUND_VARIABLE_2150401)) ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2150420 Int) (BOUND_VARIABLE_2150421 Int)) (= BOUND_VARIABLE_2150420 BOUND_VARIABLE_2150421)) ((_ tuple.select 1) t) (nullable.some 200))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2150420 Int) (BOUND_VARIABLE_2150421 Int)) (= BOUND_VARIABLE_2150420 BOUND_VARIABLE_2150421)) ((_ tuple.select 1) t) (nullable.some 200)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2150439 Int) (BOUND_VARIABLE_2150440 Int)) (= BOUND_VARIABLE_2150439 BOUND_VARIABLE_2150440)) ((_ tuple.select 0) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2150439 Int) (BOUND_VARIABLE_2150440 Int)) (= BOUND_VARIABLE_2150439 BOUND_VARIABLE_2150440)) ((_ tuple.select 0) t) (nullable.some 100)))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2150460 Int) (BOUND_VARIABLE_2150461 Int)) (= BOUND_VARIABLE_2150460 BOUND_VARIABLE_2150461)) ((_ tuple.select 1) t) ((_ tuple.select 2) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2150460 Int) (BOUND_VARIABLE_2150461 Int)) (= BOUND_VARIABLE_2150460 BOUND_VARIABLE_2150461)) ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))))
(assert (= q1 ((_ table.project 0) (bag.filter p2 (table.product ((_ table.project 0 1) (bag.filter p0 ((_ table.project 6 7) EMP))) ((_ table.project 1) (bag.filter p1 ((_ table.project 6 7) EMP))))))))
(assert (= q2 ((_ table.project 0) (bag.filter p5 (table.product ((_ table.project 0 1) (bag.filter p3 ((_ table.project 6 7) EMP))) ((_ table.project 1) (bag.filter p4 ((_ table.project 6 7) EMP))))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10407 ms.
(reset)
; parsing query SELECT * FROM (SELECT * FROM EMP AS EMP WHERE FALSE) AS t LEFT JOIN DEPT AS DEPT ON t.DEPTNO = DEPT.DEPTNO
; parsing query SELECT * FROM (SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0,0,'')) EXCEPT SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0,0,''))) AS t0
;-----------------------------------------------------------
; test name: testEmptyJoinLeft
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE FALSE) AS t LEFT JOIN DEPT AS DEPT ON t.DEPTNO = DEPT.DEPTNO
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0,0,'')) EXCEPT SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0,0,''))) AS t0
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const leftJoin2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2205994 Int) (BOUND_VARIABLE_2205995 Int)) (= BOUND_VARIABLE_2205994 BOUND_VARIABLE_2205995)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2205994 Int) (BOUND_VARIABLE_2205995 Int)) (= BOUND_VARIABLE_2205994 BOUND_VARIABLE_2205995)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map leftJoin2 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) DEPT))))) (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) DEPT))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some "")) 1)) ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some "")) 1))))))
(check-sat)
;answer: unsat
; duration: 437 ms.
(reset)
; parsing query SELECT EMP.SAL FROM EMP AS EMP WHERE CASE WHEN EMP.SAL = 1000 THEN CASE WHEN EMP.SAL = 1000 THEN NULL ELSE 1 END IS NULL ELSE CASE WHEN EMP.SAL = 2000 THEN NULL ELSE 1 END IS NULL END IS TRUE
; parsing query SELECT EMP0.SAL FROM EMP AS EMP0 WHERE CASE WHEN EMP0.SAL = 1000 THEN EMP0.SAL = 1000 ELSE EMP0.SAL = 2000 END
;-----------------------------------------------------------
; test name: testReduceNestedCaseWhen
;Translating sql query: SELECT EMP.SAL FROM EMP AS EMP WHERE CASE WHEN EMP.SAL = 1000 THEN CASE WHEN EMP.SAL = 1000 THEN NULL ELSE 1 END IS NULL ELSE CASE WHEN EMP.SAL = 2000 THEN NULL ELSE 1 END IS NULL END IS TRUE
;Translating sql query: SELECT EMP0.SAL FROM EMP AS EMP0 WHERE CASE WHEN EMP0.SAL = 1000 THEN EMP0.SAL = 1000 ELSE EMP0.SAL = 2000 END
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2207888 Int) (BOUND_VARIABLE_2207889 Int)) (= BOUND_VARIABLE_2207888 BOUND_VARIABLE_2207889)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2207888 Int) (BOUND_VARIABLE_2207889 Int)) (= BOUND_VARIABLE_2207888 BOUND_VARIABLE_2207889)) ((_ tuple.select 6) t) (nullable.some 1000)))) (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2207904 Int) (BOUND_VARIABLE_2207905 Int)) (= BOUND_VARIABLE_2207904 BOUND_VARIABLE_2207905)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2207904 Int) (BOUND_VARIABLE_2207905 Int)) (= BOUND_VARIABLE_2207904 BOUND_VARIABLE_2207905)) ((_ tuple.select 6) t) (nullable.some 1000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))) (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2207926 Int) (BOUND_VARIABLE_2207927 Int)) (= BOUND_VARIABLE_2207926 BOUND_VARIABLE_2207927)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2207926 Int) (BOUND_VARIABLE_2207927 Int)) (= BOUND_VARIABLE_2207926 BOUND_VARIABLE_2207927)) ((_ tuple.select 6) t) (nullable.some 2000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2207888 Int) (BOUND_VARIABLE_2207889 Int)) (= BOUND_VARIABLE_2207888 BOUND_VARIABLE_2207889)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2207888 Int) (BOUND_VARIABLE_2207889 Int)) (= BOUND_VARIABLE_2207888 BOUND_VARIABLE_2207889)) ((_ tuple.select 6) t) (nullable.some 1000)))) (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2207904 Int) (BOUND_VARIABLE_2207905 Int)) (= BOUND_VARIABLE_2207904 BOUND_VARIABLE_2207905)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2207904 Int) (BOUND_VARIABLE_2207905 Int)) (= BOUND_VARIABLE_2207904 BOUND_VARIABLE_2207905)) ((_ tuple.select 6) t) (nullable.some 1000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))) (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2207926 Int) (BOUND_VARIABLE_2207927 Int)) (= BOUND_VARIABLE_2207926 BOUND_VARIABLE_2207927)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2207926 Int) (BOUND_VARIABLE_2207927 Int)) (= BOUND_VARIABLE_2207926 BOUND_VARIABLE_2207927)) ((_ tuple.select 6) t) (nullable.some 2000)))) (as nullable.null (Nullable Int)) (nullable.some 1))))))))) (nullable.val (nullable.some (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2207888 Int) (BOUND_VARIABLE_2207889 Int)) (= BOUND_VARIABLE_2207888 BOUND_VARIABLE_2207889)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2207888 Int) (BOUND_VARIABLE_2207889 Int)) (= BOUND_VARIABLE_2207888 BOUND_VARIABLE_2207889)) ((_ tuple.select 6) t) (nullable.some 1000)))) (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2207904 Int) (BOUND_VARIABLE_2207905 Int)) (= BOUND_VARIABLE_2207904 BOUND_VARIABLE_2207905)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2207904 Int) (BOUND_VARIABLE_2207905 Int)) (= BOUND_VARIABLE_2207904 BOUND_VARIABLE_2207905)) ((_ tuple.select 6) t) (nullable.some 1000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))) (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2207926 Int) (BOUND_VARIABLE_2207927 Int)) (= BOUND_VARIABLE_2207926 BOUND_VARIABLE_2207927)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2207926 Int) (BOUND_VARIABLE_2207927 Int)) (= BOUND_VARIABLE_2207926 BOUND_VARIABLE_2207927)) ((_ tuple.select 6) t) (nullable.some 2000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2207888 Int) (BOUND_VARIABLE_2207889 Int)) (= BOUND_VARIABLE_2207888 BOUND_VARIABLE_2207889)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2207888 Int) (BOUND_VARIABLE_2207889 Int)) (= BOUND_VARIABLE_2207888 BOUND_VARIABLE_2207889)) ((_ tuple.select 6) t) (nullable.some 1000)))) (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2207904 Int) (BOUND_VARIABLE_2207905 Int)) (= BOUND_VARIABLE_2207904 BOUND_VARIABLE_2207905)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2207904 Int) (BOUND_VARIABLE_2207905 Int)) (= BOUND_VARIABLE_2207904 BOUND_VARIABLE_2207905)) ((_ tuple.select 6) t) (nullable.some 1000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))) (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2207926 Int) (BOUND_VARIABLE_2207927 Int)) (= BOUND_VARIABLE_2207926 BOUND_VARIABLE_2207927)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2207926 Int) (BOUND_VARIABLE_2207927 Int)) (= BOUND_VARIABLE_2207926 BOUND_VARIABLE_2207927)) ((_ tuple.select 6) t) (nullable.some 2000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))))))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2207959 Int) (BOUND_VARIABLE_2207960 Int)) (= BOUND_VARIABLE_2207959 BOUND_VARIABLE_2207960)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2207959 Int) (BOUND_VARIABLE_2207960 Int)) (= BOUND_VARIABLE_2207959 BOUND_VARIABLE_2207960)) ((_ tuple.select 6) t) (nullable.some 1000)))) (nullable.lift (lambda ((BOUND_VARIABLE_2207965 Int) (BOUND_VARIABLE_2207966 Int)) (= BOUND_VARIABLE_2207965 BOUND_VARIABLE_2207966)) ((_ tuple.select 6) t) (nullable.some 1000)) (nullable.lift (lambda ((BOUND_VARIABLE_2207971 Int) (BOUND_VARIABLE_2207972 Int)) (= BOUND_VARIABLE_2207971 BOUND_VARIABLE_2207972)) ((_ tuple.select 6) t) (nullable.some 2000)))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2207959 Int) (BOUND_VARIABLE_2207960 Int)) (= BOUND_VARIABLE_2207959 BOUND_VARIABLE_2207960)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2207959 Int) (BOUND_VARIABLE_2207960 Int)) (= BOUND_VARIABLE_2207959 BOUND_VARIABLE_2207960)) ((_ tuple.select 6) t) (nullable.some 1000)))) (nullable.lift (lambda ((BOUND_VARIABLE_2207965 Int) (BOUND_VARIABLE_2207966 Int)) (= BOUND_VARIABLE_2207965 BOUND_VARIABLE_2207966)) ((_ tuple.select 6) t) (nullable.some 1000)) (nullable.lift (lambda ((BOUND_VARIABLE_2207971 Int) (BOUND_VARIABLE_2207972 Int)) (= BOUND_VARIABLE_2207971 BOUND_VARIABLE_2207972)) ((_ tuple.select 6) t) (nullable.some 2000))))))))
(assert (= q1 ((_ table.project 6) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 6) (bag.filter p1 EMP))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10011 ms.
(reset)
; parsing query SELECT 1 FROM EMP AS EMP RIGHT JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 9) AS t ON EMP.DEPTNO = t.DEPTNO WHERE EMP.DEPTNO > 7
; parsing query SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 9) AS t2 RIGHT JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 9) AS t3 ON t2.DEPTNO = t3.DEPTNO WHERE t2.DEPTNO > 7
;-----------------------------------------------------------
; test name: testTransitiveInferenceRightOuterJoin
;Translating sql query: SELECT 1 FROM EMP AS EMP RIGHT JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 9) AS t ON EMP.DEPTNO = t.DEPTNO WHERE EMP.DEPTNO > 7
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 9) AS t2 RIGHT JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 9) AS t3 ON t2.DEPTNO = t3.DEPTNO WHERE t2.DEPTNO > 7
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f10 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p9 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const rightJoin2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const rightJoin8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2247412 Int) (BOUND_VARIABLE_2247413 Int)) (> BOUND_VARIABLE_2247412 BOUND_VARIABLE_2247413)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2247412 Int) (BOUND_VARIABLE_2247413 Int)) (> BOUND_VARIABLE_2247412 BOUND_VARIABLE_2247413)) ((_ tuple.select 7) t) (nullable.some 9)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2247434 Int) (BOUND_VARIABLE_2247435 Int)) (= BOUND_VARIABLE_2247434 BOUND_VARIABLE_2247435)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2247434 Int) (BOUND_VARIABLE_2247435 Int)) (= BOUND_VARIABLE_2247434 BOUND_VARIABLE_2247435)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2247473 Int) (BOUND_VARIABLE_2247474 Int)) (> BOUND_VARIABLE_2247473 BOUND_VARIABLE_2247474)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2247473 Int) (BOUND_VARIABLE_2247474 Int)) (> BOUND_VARIABLE_2247473 BOUND_VARIABLE_2247474)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2247499 Int) (BOUND_VARIABLE_2247500 Int)) (> BOUND_VARIABLE_2247499 BOUND_VARIABLE_2247500)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2247499 Int) (BOUND_VARIABLE_2247500 Int)) (> BOUND_VARIABLE_2247499 BOUND_VARIABLE_2247500)) ((_ tuple.select 7) t) (nullable.some 9)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2247518 Int) (BOUND_VARIABLE_2247519 Int)) (> BOUND_VARIABLE_2247518 BOUND_VARIABLE_2247519)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2247518 Int) (BOUND_VARIABLE_2247519 Int)) (> BOUND_VARIABLE_2247518 BOUND_VARIABLE_2247519)) ((_ tuple.select 7) t) (nullable.some 9)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2247539 Int) (BOUND_VARIABLE_2247540 Int)) (= BOUND_VARIABLE_2247539 BOUND_VARIABLE_2247540)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2247539 Int) (BOUND_VARIABLE_2247540 Int)) (= BOUND_VARIABLE_2247539 BOUND_VARIABLE_2247540)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= rightJoin8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (not (= q1 q2)))
(assert (= p9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2247578 Int) (BOUND_VARIABLE_2247579 Int)) (> BOUND_VARIABLE_2247578 BOUND_VARIABLE_2247579)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2247578 Int) (BOUND_VARIABLE_2247579 Int)) (> BOUND_VARIABLE_2247578 BOUND_VARIABLE_2247579)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= f10 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f4 (bag.filter p3 (bag.union_disjoint (bag.map rightJoin2 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 9 10 11 12 13 14 15 16 17) (bag.filter p1 (table.product EMP ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))))) (bag.filter p1 (table.product EMP ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)))))))))
(assert (= q2 (bag.map f10 (bag.filter p9 (bag.union_disjoint (bag.map rightJoin8 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p6 EMP)) ((_ table.project 9 10 11 12 13 14 15 16 17) (bag.filter p7 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p6 EMP))))))) (bag.filter p7 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p6 EMP)))))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10144 ms.
(reset)
; parsing query SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7 AND EMP.COMM = EMP.DEPTNO AND EMP.COMM + EMP.DEPTNO > EMP.COMM / 2) AS t INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL = EMP0.DEPTNO) AS t0 ON t.DEPTNO = t0.DEPTNO
; parsing query SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7 AND EMP1.COMM = EMP1.DEPTNO AND EMP1.COMM + EMP1.DEPTNO > EMP1.COMM / 2) AS t2 INNER JOIN (SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.SAL = EMP2.DEPTNO) AS t3 WHERE t3.DEPTNO > 7) AS t4 ON t2.DEPTNO = t4.DEPTNO
;-----------------------------------------------------------
; test name: testTransitiveInferenceComplexPredicate
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7 AND EMP.COMM = EMP.DEPTNO AND EMP.COMM + EMP.DEPTNO > EMP.COMM / 2) AS t INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL = EMP0.DEPTNO) AS t0 ON t.DEPTNO = t0.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7 AND EMP1.COMM = EMP1.DEPTNO AND EMP1.COMM + EMP1.DEPTNO > EMP1.COMM / 2) AS t2 INNER JOIN (SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.SAL = EMP2.DEPTNO) AS t3 WHERE t3.DEPTNO > 7) AS t4 ON t2.DEPTNO = t4.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2286233 Int) (BOUND_VARIABLE_2286234 Int)) (> BOUND_VARIABLE_2286233 BOUND_VARIABLE_2286234)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2286233 Int) (BOUND_VARIABLE_2286234 Int)) (> BOUND_VARIABLE_2286233 BOUND_VARIABLE_2286234)) ((_ tuple.select 7) t) (nullable.some 7))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2286240 Int) (BOUND_VARIABLE_2286241 Int)) (= BOUND_VARIABLE_2286240 BOUND_VARIABLE_2286241)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2286240 Int) (BOUND_VARIABLE_2286241 Int)) (= BOUND_VARIABLE_2286240 BOUND_VARIABLE_2286241)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2286233 Int) (BOUND_VARIABLE_2286234 Int)) (> BOUND_VARIABLE_2286233 BOUND_VARIABLE_2286234)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2286240 Int) (BOUND_VARIABLE_2286241 Int)) (= BOUND_VARIABLE_2286240 BOUND_VARIABLE_2286241)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2286233 Int) (BOUND_VARIABLE_2286234 Int)) (> BOUND_VARIABLE_2286233 BOUND_VARIABLE_2286234)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2286240 Int) (BOUND_VARIABLE_2286241 Int)) (= BOUND_VARIABLE_2286240 BOUND_VARIABLE_2286241)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2286233 Int) (BOUND_VARIABLE_2286234 Int)) (> BOUND_VARIABLE_2286233 BOUND_VARIABLE_2286234)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2286233 Int) (BOUND_VARIABLE_2286234 Int)) (> BOUND_VARIABLE_2286233 BOUND_VARIABLE_2286234)) ((_ tuple.select 7) t) (nullable.some 7))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2286240 Int) (BOUND_VARIABLE_2286241 Int)) (= BOUND_VARIABLE_2286240 BOUND_VARIABLE_2286241)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2286240 Int) (BOUND_VARIABLE_2286241 Int)) (= BOUND_VARIABLE_2286240 BOUND_VARIABLE_2286241)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2286233 Int) (BOUND_VARIABLE_2286234 Int)) (> BOUND_VARIABLE_2286233 BOUND_VARIABLE_2286234)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2286240 Int) (BOUND_VARIABLE_2286241 Int)) (= BOUND_VARIABLE_2286240 BOUND_VARIABLE_2286241)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2286233 Int) (BOUND_VARIABLE_2286234 Int)) (> BOUND_VARIABLE_2286233 BOUND_VARIABLE_2286234)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2286240 Int) (BOUND_VARIABLE_2286241 Int)) (= BOUND_VARIABLE_2286240 BOUND_VARIABLE_2286241)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2286309 Int) (BOUND_VARIABLE_2286310 Int)) (= BOUND_VARIABLE_2286309 BOUND_VARIABLE_2286310)) ((_ tuple.select 6) t) ((_ tuple.select 7) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2286309 Int) (BOUND_VARIABLE_2286310 Int)) (= BOUND_VARIABLE_2286309 BOUND_VARIABLE_2286310)) ((_ tuple.select 6) t) ((_ tuple.select 7) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2286330 Int) (BOUND_VARIABLE_2286331 Int)) (= BOUND_VARIABLE_2286330 BOUND_VARIABLE_2286331)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2286330 Int) (BOUND_VARIABLE_2286331 Int)) (= BOUND_VARIABLE_2286330 BOUND_VARIABLE_2286331)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2286356 Int) (BOUND_VARIABLE_2286357 Int)) (> BOUND_VARIABLE_2286356 BOUND_VARIABLE_2286357)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2286356 Int) (BOUND_VARIABLE_2286357 Int)) (> BOUND_VARIABLE_2286356 BOUND_VARIABLE_2286357)) ((_ tuple.select 7) t) (nullable.some 7))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2286363 Int) (BOUND_VARIABLE_2286364 Int)) (= BOUND_VARIABLE_2286363 BOUND_VARIABLE_2286364)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2286363 Int) (BOUND_VARIABLE_2286364 Int)) (= BOUND_VARIABLE_2286363 BOUND_VARIABLE_2286364)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2286356 Int) (BOUND_VARIABLE_2286357 Int)) (> BOUND_VARIABLE_2286356 BOUND_VARIABLE_2286357)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2286363 Int) (BOUND_VARIABLE_2286364 Int)) (= BOUND_VARIABLE_2286363 BOUND_VARIABLE_2286364)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2286356 Int) (BOUND_VARIABLE_2286357 Int)) (> BOUND_VARIABLE_2286356 BOUND_VARIABLE_2286357)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2286363 Int) (BOUND_VARIABLE_2286364 Int)) (= BOUND_VARIABLE_2286363 BOUND_VARIABLE_2286364)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)))))))) (nullable.val (nullable.some (or (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2286356 Int) (BOUND_VARIABLE_2286357 Int)) (> BOUND_VARIABLE_2286356 BOUND_VARIABLE_2286357)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2286356 Int) (BOUND_VARIABLE_2286357 Int)) (> BOUND_VARIABLE_2286356 BOUND_VARIABLE_2286357)) ((_ tuple.select 7) t) (nullable.some 7))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2286363 Int) (BOUND_VARIABLE_2286364 Int)) (= BOUND_VARIABLE_2286363 BOUND_VARIABLE_2286364)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2286363 Int) (BOUND_VARIABLE_2286364 Int)) (= BOUND_VARIABLE_2286363 BOUND_VARIABLE_2286364)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)))))) (and (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2286356 Int) (BOUND_VARIABLE_2286357 Int)) (> BOUND_VARIABLE_2286356 BOUND_VARIABLE_2286357)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2286363 Int) (BOUND_VARIABLE_2286364 Int)) (= BOUND_VARIABLE_2286363 BOUND_VARIABLE_2286364)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)))) (and (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2286356 Int) (BOUND_VARIABLE_2286357 Int)) (> BOUND_VARIABLE_2286356 BOUND_VARIABLE_2286357)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2286363 Int) (BOUND_VARIABLE_2286364 Int)) (= BOUND_VARIABLE_2286363 BOUND_VARIABLE_2286364)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))))))))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2286415 Int) (BOUND_VARIABLE_2286416 Int)) (= BOUND_VARIABLE_2286415 BOUND_VARIABLE_2286416)) ((_ tuple.select 6) t) ((_ tuple.select 7) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2286415 Int) (BOUND_VARIABLE_2286416 Int)) (= BOUND_VARIABLE_2286415 BOUND_VARIABLE_2286416)) ((_ tuple.select 6) t) ((_ tuple.select 7) t)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2286434 Int) (BOUND_VARIABLE_2286435 Int)) (> BOUND_VARIABLE_2286434 BOUND_VARIABLE_2286435)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2286434 Int) (BOUND_VARIABLE_2286435 Int)) (> BOUND_VARIABLE_2286434 BOUND_VARIABLE_2286435)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (not (= q1 q2)))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2286455 Int) (BOUND_VARIABLE_2286456 Int)) (= BOUND_VARIABLE_2286455 BOUND_VARIABLE_2286456)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2286455 Int) (BOUND_VARIABLE_2286456 Int)) (= BOUND_VARIABLE_2286455 BOUND_VARIABLE_2286456)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f3 (bag.filter p2 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)))))))
(assert (= q2 (bag.map f8 (bag.filter p7 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p6 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)))))))))
(check-sat)
;answer: unknown (INCOMPLETE)
; duration: 2711 ms.
(reset)
; parsing query SELECT * FROM (VALUES  (1, 2)) AS t WHERE FALSE
; parsing query SELECT * FROM (SELECT * FROM (VALUES (0,0)) EXCEPT SELECT * FROM (VALUES (0,0))) AS t1
;-----------------------------------------------------------
; test name: testAlreadyFalseEliminatesFilter
;Translating sql query: SELECT * FROM (VALUES  (1, 2)) AS t WHERE FALSE
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES (0,0)) EXCEPT SELECT * FROM (VALUES (0,0))) AS t1
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 (bag (tuple (nullable.some 1) (nullable.some 2)) 1)))))
(assert (= q2 ((_ table.project 0 1) (bag.difference_remove ((_ table.project 0 1) (bag (tuple (nullable.some 0) (nullable.some 0)) 1)) ((_ table.project 0 1) (bag (tuple (nullable.some 0) (nullable.some 0)) 1))))))
(check-sat)
;answer: unsat
; duration: 87 ms.
(reset)
; parsing query SELECT 2, EMP.DEPTNO, EMP.JOB FROM EMP AS EMP UNION ALL SELECT 1, EMP0.DEPTNO, EMP0.JOB FROM EMP AS EMP0
; parsing query SELECT 2, EMP1.DEPTNO, EMP1.JOB FROM EMP AS EMP1 UNION ALL SELECT 1, EMP2.DEPTNO, EMP2.JOB FROM EMP AS EMP2
;-----------------------------------------------------------
; test name: testPullConstantThroughUnion2
;Translating sql query: SELECT 2, EMP.DEPTNO, EMP.JOB FROM EMP AS EMP UNION ALL SELECT 1, EMP0.DEPTNO, EMP0.JOB FROM EMP AS EMP0
;Translating sql query: SELECT 2, EMP1.DEPTNO, EMP1.JOB FROM EMP AS EMP1 UNION ALL SELECT 1, EMP2.DEPTNO, EMP2.JOB FROM EMP AS EMP2
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (not (= q1 q2)))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= q1 (bag.union_disjoint (bag.map f0 EMP) (bag.map f1 EMP))))
(assert (= q2 (bag.union_disjoint (bag.map f2 EMP) (bag.map f3 EMP))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10036 ms.
(reset)
; parsing query SELECT 2, 3 FROM EMP AS EMP UNION ALL SELECT 2, 3 FROM EMP AS EMP0
; parsing query SELECT 2, 3 FROM (SELECT 2 FROM EMP AS EMP1 UNION ALL SELECT 2 FROM EMP AS EMP2) AS t6
;-----------------------------------------------------------
; test name: testPullConstantThroughUnion3
;Translating sql query: SELECT 2, 3 FROM EMP AS EMP UNION ALL SELECT 2, 3 FROM EMP AS EMP0
;Translating sql query: SELECT 2, 3 FROM (SELECT 2 FROM EMP AS EMP1 UNION ALL SELECT 2 FROM EMP AS EMP2) AS t6
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f4 (-> (Tuple (Nullable Int)) (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2) (nullable.some 3)))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2) (nullable.some 3)))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2)))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2)))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int)))) (tuple (nullable.some 2) (nullable.some 3)))))
(assert (= q1 (bag.union_disjoint (bag.map f0 EMP) (bag.map f1 EMP))))
(assert (= q2 (bag.map f4 (bag.union_disjoint (bag.map f2 EMP) (bag.map f3 EMP)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10448 ms.
(reset)
; parsing query SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION ALL SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
; parsing query SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20) AS t6 UNION ALL SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
;-----------------------------------------------------------
; test name: testMergeUnionMixed
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION ALL SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20) AS t6 UNION ALL SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2407181 Int) (BOUND_VARIABLE_2407182 Int)) (= BOUND_VARIABLE_2407181 BOUND_VARIABLE_2407182)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2407181 Int) (BOUND_VARIABLE_2407182 Int)) (= BOUND_VARIABLE_2407181 BOUND_VARIABLE_2407182)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2407201 Int) (BOUND_VARIABLE_2407202 Int)) (= BOUND_VARIABLE_2407201 BOUND_VARIABLE_2407202)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2407201 Int) (BOUND_VARIABLE_2407202 Int)) (= BOUND_VARIABLE_2407201 BOUND_VARIABLE_2407202)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2407222 Int) (BOUND_VARIABLE_2407223 Int)) (= BOUND_VARIABLE_2407222 BOUND_VARIABLE_2407223)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2407222 Int) (BOUND_VARIABLE_2407223 Int)) (= BOUND_VARIABLE_2407222 BOUND_VARIABLE_2407223)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2407242 Int) (BOUND_VARIABLE_2407243 Int)) (= BOUND_VARIABLE_2407242 BOUND_VARIABLE_2407243)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2407242 Int) (BOUND_VARIABLE_2407243 Int)) (= BOUND_VARIABLE_2407242 BOUND_VARIABLE_2407243)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2407261 Int) (BOUND_VARIABLE_2407262 Int)) (= BOUND_VARIABLE_2407261 BOUND_VARIABLE_2407262)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2407261 Int) (BOUND_VARIABLE_2407262 Int)) (= BOUND_VARIABLE_2407261 BOUND_VARIABLE_2407262)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2407282 Int) (BOUND_VARIABLE_2407283 Int)) (= BOUND_VARIABLE_2407282 BOUND_VARIABLE_2407283)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2407282 Int) (BOUND_VARIABLE_2407283 Int)) (= BOUND_VARIABLE_2407282 BOUND_VARIABLE_2407283)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (bag.union_disjoint ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.union_max ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)))))
(assert (= q2 (bag.union_disjoint ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.union_max ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)))))
(check-sat)
;answer: unsat
; duration: 705 ms.
(reset)

Process finished with exit code 0
