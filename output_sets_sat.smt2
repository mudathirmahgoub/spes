;-----------------------------------------------------------
; test name: testEmptyProject2
;Translating sql query: SELECT t.EXPR$0 + t.EXPR$1 + t.EXPR$0 FROM (VALUES  (10, 1),  (30, 3)) AS t WHERE t.EXPR$0 + t.EXPR$1 > 50
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES (0)) EXCEPT SELECT * FROM (VALUES (0))) AS t3
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)
(set-option :simplification none)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 1) t)) (> (+ (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 1) t))) 50)))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_417 Int) (BOUND_VARIABLE_418 Int)) (+ BOUND_VARIABLE_417 BOUND_VARIABLE_418)) (nullable.lift (lambda ((BOUND_VARIABLE_410 Int) (BOUND_VARIABLE_411 Int)) (+ BOUND_VARIABLE_410 BOUND_VARIABLE_411)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 0) t))))))
(assert (= q1 (set.map f1 (set.filter p0 (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 30) (nullable.some 3))))))))
(assert (= q2 ((_ rel.project 0) (set.minus ((_ rel.project 0) (set.singleton (tuple (nullable.some 0)))) ((_ rel.project 0) (set.singleton (tuple (nullable.some 0))))))))
(check-sat)
;answer: unsat
; duration: 36 ms.
(reset)
;-----------------------------------------------------------
; test name: testEmptyFilterProjectUnion
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES  (10, 1),  (30, 3)) AS t UNION ALL SELECT * FROM (VALUES  (20, 2)) AS t0) AS t1 WHERE t1.EXPR$0 + t1.EXPR$1 > 30
;Translating sql query: SELECT * FROM (VALUES  (30, 3)) AS t3
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)
(set-option :simplification none)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 1) t)) (> (+ (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 1) t))) 30)))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 (set.union ((_ rel.project 0 1) (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 30) (nullable.some 3))))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 20) (nullable.some 2)))))))))
(assert (= q2 ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 30) (nullable.some 3))))))
(check-sat)
;answer: unsat
; duration: 11 ms.
(reset)
;-----------------------------------------------------------
; test name: testPullNull
;Translating sql query: SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 AND EMP.EMPNO = 10 AND EMP.MGR IS NULL AND EMP.EMPNO = 10
;Translating sql query: SELECT 10 AS EMPNO, EMP0.ENAME, EMP0.JOB, CAST(NULL AS INT) AS MGR, EMP0.HIREDATE, EMP0.SAL, EMP0.COMM, 7 AS DEPTNO, EMP0.SLACKER FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 7 AND EMP0.MGR IS NULL AND EMP0.EMPNO = 10
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)
(set-option :simplification none)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 0) t)) (and (= (nullable.val ((_ tuple.select 7) t)) 7) (= (nullable.val ((_ tuple.select 0) t)) 10) (nullable.is_null ((_ tuple.select 3) t)) (= (nullable.val ((_ tuple.select 0) t)) 10))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 0) t)) (and (= (nullable.val ((_ tuple.select 7) t)) 7) (nullable.is_null ((_ tuple.select 3) t)) (= (nullable.val ((_ tuple.select 0) t)) 10))))))
(assert (not (= q1 q2)))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 10) ((_ tuple.select 1) t) ((_ tuple.select 2) t) (as nullable.null (Nullable Int)) ((_ tuple.select 4) t) ((_ tuple.select 6) t) ((_ tuple.select 5) t) (nullable.some 7) ((_ tuple.select 8) t)))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 (set.map f2 (set.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 93 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 10) (nullable.some "A") (nullable.some "B") (as nullable.null (Nullable Int)) (nullable.some 3) (nullable.some (- 3)) (nullable.some 4) (nullable.some 7) (nullable.some (- 4)))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 10) (nullable.some "A") (nullable.some "B") (as nullable.null (Nullable Int)) (nullable.some 3) (nullable.some (- 3)) (nullable.some 4) (nullable.some 7) (nullable.some (- 4))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 10) (nullable.some "A") (nullable.some "B") (as nullable.null (Nullable Int)) (nullable.some 3) (nullable.some 4) (nullable.some (- 3)) (nullable.some 7) (nullable.some (- 4))))
; insert into EMP values(10,'A','B',NULL,3,-3,4,7,-4)
; SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 AND EMP.EMPNO = 10 AND EMP.MGR IS NULL AND EMP.EMPNO = 10 EXCEPT ALL SELECT 10 AS EMPNO, EMP0.ENAME, EMP0.JOB, CAST(NULL AS INT) AS MGR, EMP0.HIREDATE, EMP0.SAL, EMP0.COMM, 7 AS DEPTNO, EMP0.SLACKER FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 7 AND EMP0.MGR IS NULL AND EMP0.EMPNO = 10
;(10,A,B,NULL,3,-3,4,7,-4)

; SELECT 10 AS EMPNO, EMP0.ENAME, EMP0.JOB, CAST(NULL AS INT) AS MGR, EMP0.HIREDATE, EMP0.SAL, EMP0.COMM, 7 AS DEPTNO, EMP0.SLACKER FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 7 AND EMP0.MGR IS NULL AND EMP0.EMPNO = 10 EXCEPT ALL SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 AND EMP.EMPNO = 10 AND EMP.MGR IS NULL AND EMP.EMPNO = 10
;(10,A,B,NULL,3,4,-3,7,-4)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testReduceValuesUnderProjectFilter
;Translating sql query: SELECT t.EXPR$0 + t.EXPR$1 AS X, t.EXPR$1 AS B, t.EXPR$0 AS A FROM (VALUES  (10, 1),  (30, 7),  (20, 3)) AS t WHERE t.EXPR$0 - t.EXPR$1 < 21
;Translating sql query: SELECT * FROM (VALUES  (11, 1, 10),  (23, 3, 20)) AS t2
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)
(set-option :simplification none)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 1) t)) (< (- (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 1) t))) 21)))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_1534 Int) (BOUND_VARIABLE_1535 Int)) (+ BOUND_VARIABLE_1534 BOUND_VARIABLE_1535)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= q1 (set.map f1 (set.filter p0 (set.union (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 30) (nullable.some 7)))) (set.singleton (tuple (nullable.some 20) (nullable.some 3))))))))
(assert (= q2 ((_ rel.project 0 1 2) (set.union (set.singleton (tuple (nullable.some 11) (nullable.some 1) (nullable.some 10))) (set.singleton (tuple (nullable.some 23) (nullable.some 3) (nullable.some 20)))))))
(check-sat)
;answer: unsat
; duration: 17 ms.
(reset)
;-----------------------------------------------------------
; test name: testMergeMinus
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 EXCEPT SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 EXCEPT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
;Translating sql query: SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 EXCEPT SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 EXCEPT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)
(set-option :simplification none)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 10)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 20)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 30)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 10)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 20)))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 30)))))
(assert (= q1 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))
(assert (= q2 (set.minus (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))
(check-sat)
;answer: unsat
; duration: 567 ms.
(reset)
;-----------------------------------------------------------
; test name: testEmptyMinus
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES  (30, 3)) AS t WHERE t.EXPR$0 > 30 EXCEPT SELECT * FROM (VALUES  (20, 2)) AS t1) AS t2 EXCEPT SELECT * FROM (VALUES  (40, 4)) AS t3
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES  (0, 0)) except SELECT * FROM (VALUES  (0, 0))) AS t5
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)
(set-option :simplification none)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (> (nullable.val ((_ tuple.select 0) t)) 30)))))
(assert (= q1 (set.minus ((_ rel.project 0 1) (set.minus ((_ rel.project 0 1) (set.filter p0 (set.singleton (tuple (nullable.some 30) (nullable.some 3))))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 20) (nullable.some 2)))))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 40) (nullable.some 4)))))))
(assert (= q2 ((_ rel.project 0 1) (set.minus ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 0) (nullable.some 0)))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 0) (nullable.some 0))))))))
(check-sat)
;answer: unsat
; duration: 11 ms.
(reset)
;-----------------------------------------------------------
; test name: testReduceValuesUnderProject
;Translating sql query: SELECT t.EXPR$0 + t.EXPR$1 FROM (VALUES  (10, 1),  (20, 3)) AS t
;Translating sql query: SELECT * FROM (VALUES  (11),  (23)) AS t1
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)
(set-option :simplification none)

(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_4631 Int) (BOUND_VARIABLE_4632 Int)) (+ BOUND_VARIABLE_4631 BOUND_VARIABLE_4632)) ((_ tuple.select 0) t) ((_ tuple.select 1) t))))))
(assert (= q1 (set.map f0 (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 20) (nullable.some 3)))))))
(assert (= q2 ((_ rel.project 0) (set.union (set.singleton (tuple (nullable.some 11))) (set.singleton (tuple (nullable.some 23)))))))
(check-sat)
;answer: unsat
; duration: 7 ms.
(reset)
;-----------------------------------------------------------
; test name: testReduceValuesUnderFilter
;Translating sql query: SELECT * FROM (VALUES  (10, 'x'),  (20, 'y')) AS t WHERE t.EXPR$0 < 15
;Translating sql query: SELECT * FROM (VALUES  (10, 'x')) AS t1
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)
(set-option :simplification none)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 0) t)) (< (nullable.val ((_ tuple.select 0) t)) 15)))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 (set.union (set.singleton (tuple (nullable.some 10) (nullable.some "x"))) (set.singleton (tuple (nullable.some 20) (nullable.some "y"))))))))
(assert (= q2 ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 10) (nullable.some "x"))))))
(check-sat)
;answer: unsat
; duration: 6 ms.
(reset)
;-----------------------------------------------------------
; test name: testReduceConstantsDup
;Translating sql query: SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE DEPT.DEPTNO = 7 AND DEPT.DEPTNO = 8
;Translating sql query: SELECT t1.EXPR$0 FROM (SELECT * FROM (VALUES(0, 0)) EXCEPT SELECT * FROM (VALUES(0, 0))) AS t1
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)
(set-option :simplification none)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 0) t)) (and (= (nullable.val ((_ tuple.select 0) t)) 7) (= (nullable.val ((_ tuple.select 0) t)) 8))))))
(assert (= q1 ((_ rel.project 0) (set.filter p0 DEPT))))
(assert (= q2 ((_ rel.project 0) (set.minus ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 0) (nullable.some 0)))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 0) (nullable.some 0))))))))
(check-sat)
;answer: unsat
; duration: 10 ms.
(reset)
;-----------------------------------------------------------
; test name: testRemoveSemiJoin
;Translating sql query: SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO
;Translating sql query: SELECT EMP0.ENAME FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)
(set-option :simplification none)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ rel.project 1) (set.filter p0 (rel.product EMP DEPT)))))
(assert (= q2 ((_ rel.project 1) (set.filter p1 (rel.product EMP DEPT)))))
(check-sat)
;answer: unsat
; duration: 27 ms.
(reset)
;-----------------------------------------------------------
; test name: testPullConstantThroughUnion
;Translating sql query: SELECT 2, EMP.DEPTNO, EMP.JOB FROM EMP AS EMP UNION ALL SELECT 2, EMP0.DEPTNO, EMP0.JOB FROM EMP AS EMP0
;Translating sql query: SELECT 2, t6.DEPTNO, t6.JOB FROM (SELECT EMP1.DEPTNO, EMP1.JOB FROM EMP AS EMP1 UNION ALL SELECT EMP2.DEPTNO, EMP2.JOB FROM EMP AS EMP2) AS t6
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)
(set-option :simplification none)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (not (= q1 q2)))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.some 2) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= q1 (set.union (set.map f0 EMP) (set.map f1 EMP))))
(assert (= q2 (set.map f2 (set.union ((_ rel.project 7 2) EMP) ((_ rel.project 7 2) EMP)))))
(check-sat)
;answer: unsat
; duration: 29 ms.
(reset)
;-----------------------------------------------------------
; test name: testReduceNot
;Translating sql query: SELECT * FROM (SELECT CASE WHEN EMP.SAL > 1000 THEN NULL ELSE FALSE END AS CASECOL FROM EMP AS EMP) AS t WHERE NOT t.CASECOL
;Translating sql query: SELECT * FROM (SELECT CASE WHEN EMP0.SAL > 1000 THEN NULL ELSE FALSE END AS CASECOL FROM EMP AS EMP0) AS t1 WHERE NOT t1.CASECOL
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)
(set-option :simplification none)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Bool))))
(declare-const p1 (-> (Tuple (Nullable Bool)) Bool))
(declare-const q2 (Set (Tuple (Nullable Bool))))
(declare-const p3 (-> (Tuple (Nullable Bool)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Bool))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Bool))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_5930 Bool) (BOUND_VARIABLE_5931 Bool)) (and BOUND_VARIABLE_5930 BOUND_VARIABLE_5931)) (nullable.lift (lambda ((BOUND_VARIABLE_5922 Int) (BOUND_VARIABLE_5923 Int)) (> BOUND_VARIABLE_5922 BOUND_VARIABLE_5923)) ((_ tuple.select 6) t) (nullable.some 1000)) (as nullable.null (Nullable Bool)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some ((_ tuple.select 0) t)) (not (nullable.val ((_ tuple.select 0) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_5970 Bool) (BOUND_VARIABLE_5971 Bool)) (and BOUND_VARIABLE_5970 BOUND_VARIABLE_5971)) (nullable.lift (lambda ((BOUND_VARIABLE_5964 Int) (BOUND_VARIABLE_5965 Int)) (> BOUND_VARIABLE_5964 BOUND_VARIABLE_5965)) ((_ tuple.select 6) t) (nullable.some 1000)) (as nullable.null (Nullable Bool)))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some ((_ tuple.select 0) t)) (not (nullable.val ((_ tuple.select 0) t)))))))
(assert (= q1 ((_ rel.project 0) (set.filter p1 (set.map f0 EMP)))))
(assert (= q2 ((_ rel.project 0) (set.filter p3 (set.map f2 EMP)))))
(check-sat)
;answer: unsat
; duration: 26 ms.
(reset)
;-----------------------------------------------------------
; test name: testWhereInCorrelated
;Translating sql query: SELECT EMP.SAL FROM EMP AS EMP WHERE EMP.EMPNO IN (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE EMP.JOB = DEPT.NAME)
;Translating sql query: SELECT EMP0.SAL FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.JOB = DEPT0.NAME AND EMP0.EMPNO = DEPT0.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)
(set-option :simplification none)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 2) t)) (nullable.is_some ((_ tuple.select 1) t)) (= (nullable.val ((_ tuple.select 2) t)) (nullable.val ((_ tuple.select 1) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 2) t)) (nullable.is_some ((_ tuple.select 10) t)) (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 9) t)) (and (= (nullable.val ((_ tuple.select 2) t)) (nullable.val ((_ tuple.select 10) t))) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 9) t))))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 2) t)))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 9) t)) (nullable.is_some ((_ tuple.select 12) t)) (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 10) t)) (and (= (nullable.val ((_ tuple.select 9) t)) (nullable.val ((_ tuple.select 12) t))) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 10) t))))))))
(assert (= q1 ((_ rel.project 6) (set.filter p2 (rel.product EMP ((_ rel.project 0 1) ((_ rel.project 0 2) (set.filter p1 (set.map f0 DEPT)))))))))
(assert (= q2 ((_ rel.project 6) (set.filter p5 (rel.product (set.map f3 EMP) (set.map f4 DEPT))))))
(check-sat)
;answer: unsat
; duration: 329 ms.
(reset)
;-----------------------------------------------------------
; test name: testReduceConstantsRequiresExecutor
;Translating sql query: SELECT * FROM (VALUES  (1, 2)) AS t WHERE 1 + 2 > 3 + CAST(NULL AS INT)
;Translating sql query: SELECT * FROM (VALUES  (1, 2)) AS t1 WHERE 1 + 2 > 3 + CAST(NULL AS INT)
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)
(set-option :simplification none)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_9991 Int) (BOUND_VARIABLE_9992 Int)) (> BOUND_VARIABLE_9991 BOUND_VARIABLE_9992)) (nullable.some (+ 1 2)) (nullable.lift (lambda ((BOUND_VARIABLE_9984 Int) (BOUND_VARIABLE_9985 Int)) (+ BOUND_VARIABLE_9984 BOUND_VARIABLE_9985)) (nullable.some 3) (as nullable.null (Nullable Int))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_9991 Int) (BOUND_VARIABLE_9992 Int)) (> BOUND_VARIABLE_9991 BOUND_VARIABLE_9992)) (nullable.some (+ 1 2)) (nullable.lift (lambda ((BOUND_VARIABLE_9984 Int) (BOUND_VARIABLE_9985 Int)) (+ BOUND_VARIABLE_9984 BOUND_VARIABLE_9985)) (nullable.some 3) (as nullable.null (Nullable Int)))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_10017 Int) (BOUND_VARIABLE_10018 Int)) (> BOUND_VARIABLE_10017 BOUND_VARIABLE_10018)) (nullable.some (+ 1 2)) (nullable.lift (lambda ((BOUND_VARIABLE_10011 Int) (BOUND_VARIABLE_10012 Int)) (+ BOUND_VARIABLE_10011 BOUND_VARIABLE_10012)) (nullable.some 3) (as nullable.null (Nullable Int))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_10017 Int) (BOUND_VARIABLE_10018 Int)) (> BOUND_VARIABLE_10017 BOUND_VARIABLE_10018)) (nullable.some (+ 1 2)) (nullable.lift (lambda ((BOUND_VARIABLE_10011 Int) (BOUND_VARIABLE_10012 Int)) (+ BOUND_VARIABLE_10011 BOUND_VARIABLE_10012)) (nullable.some 3) (as nullable.null (Nullable Int)))))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 (set.singleton (tuple (nullable.some 1) (nullable.some 2)))))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p1 (set.singleton (tuple (nullable.some 1) (nullable.some 2)))))))
(check-sat)
;answer: unsat
; duration: 13 ms.
(reset)
;-----------------------------------------------------------
; test name: testReduceConstantsProjectNullable*
;Translating sql query: SELECT EMP.MGR FROM EMP AS EMP WHERE EMP.MGR = 10
;Translating sql query: SELECT 10 AS MGR FROM EMP AS EMP0 WHERE EMP0.MGR = 10
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)
(set-option :simplification none)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 3) t)) (= (nullable.val ((_ tuple.select 3) t)) 10)))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 3) t)) (= (nullable.val ((_ tuple.select 3) t)) 10)))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 10)))))
(assert (= q1 ((_ rel.project 3) (set.filter p0 EMP))))
(assert (= q2 (set.map f2 (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 33 ms.
(reset)
;-----------------------------------------------------------
; test name: testTransitiveInferencePreventProjectPullUp
;Translating sql query: SELECT 1 FROM (SELECT EMP.COMM AS DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO > 7) AS t0 INNER JOIN EMP AS EMP0 ON t0.DEPTNO = EMP0.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT EMP1.COMM AS DEPTNO FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t3 INNER JOIN EMP AS EMP2 ON t3.DEPTNO = EMP2.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)
(set-option :simplification none)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f5 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (> (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 8) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 8) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (> (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (not (= q1 q2)))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 8) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 8) t)))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f2 (set.filter p1 (rel.product ((_ rel.project 5) (set.filter p0 EMP)) EMP)))))
(assert (= q2 (set.map f5 (set.filter p4 (rel.product ((_ rel.project 5) (set.filter p3 EMP)) EMP)))))
(check-sat)
;answer: unsat
; duration: 1793 ms.
(reset)
;-----------------------------------------------------------
; test name: testTransitiveInferenceJoin3way
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO INNER JOIN EMP AS EMP1 ON EMP0.DEPTNO = EMP1.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO INNER JOIN (SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 7) AS t3 ON t2.DEPTNO = t3.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)
(set-option :simplification none)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f9 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (> (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 16) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 16) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 16) t)) (nullable.is_some ((_ tuple.select 25) t)) (= (nullable.val ((_ tuple.select 16) t)) (nullable.val ((_ tuple.select 25) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (> (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (> (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 16) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 16) t)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (> (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (not (= q1 q2)))
(assert (= p8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 16) t)) (nullable.is_some ((_ tuple.select 25) t)) (= (nullable.val ((_ tuple.select 16) t)) (nullable.val ((_ tuple.select 25) t)))))))
(assert (= f9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f3 (set.filter p2 (rel.product (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) EMP)) EMP)))))
(assert (= q2 (set.map f9 (set.filter p8 (rel.product (set.filter p6 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p7 EMP)))))))
(check-sat)
;answer: unsat
; duration: 2558 ms.
(reset)
;-----------------------------------------------------------
; test name: testRemoveSemiJoinRight
;Translating sql query: SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = EMP0.DEPTNO
;Translating sql query: SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.DEPTNO = DEPT0.DEPTNO INNER JOIN EMP AS EMP2 ON DEPT0.DEPTNO = EMP2.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)
(set-option :simplification none)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (nullable.is_some ((_ tuple.select 9) t)) (nullable.is_some ((_ tuple.select 18) t)) (and (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t))) (= (nullable.val ((_ tuple.select 9) t)) (nullable.val ((_ tuple.select 18) t))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 9) t)) (nullable.is_some ((_ tuple.select 18) t)) (= (nullable.val ((_ tuple.select 9) t)) (nullable.val ((_ tuple.select 18) t)))))))
(assert (= q1 ((_ rel.project 1) (set.filter p0 (rel.product (rel.product EMP DEPT) EMP)))))
(assert (= q2 ((_ rel.project 1) (set.filter p2 (rel.product (set.filter p1 (rel.product EMP DEPT)) EMP)))))
(check-sat)
;answer: unsat
; duration: 321 ms.
(reset)
;-----------------------------------------------------------
; test name: testReduceExpressionsNot
;Translating sql query: SELECT * FROM (VALUES  (FALSE),  (TRUE)) AS t WHERE NOT t.EXPR$0
;Translating sql query: SELECT * FROM (VALUES  (FALSE),  (TRUE)) AS t1 WHERE NOT t1.EXPR$0
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)
(set-option :simplification none)

(declare-const p0 (-> (Tuple (Nullable Bool)) Bool))
(declare-const q1 (Set (Tuple (Nullable Bool))))
(declare-const p1 (-> (Tuple (Nullable Bool)) Bool))
(declare-const q2 (Set (Tuple (Nullable Bool))))
(assert (= p0 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some ((_ tuple.select 0) t)) (not (nullable.val ((_ tuple.select 0) t)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some ((_ tuple.select 0) t)) (not (nullable.val ((_ tuple.select 0) t)))))))
(assert (= q1 ((_ rel.project 0) (set.filter p0 (set.union (set.singleton (tuple (nullable.some false))) (set.singleton (tuple (nullable.some true))))))))
(assert (= q2 ((_ rel.project 0) (set.filter p1 (set.union (set.singleton (tuple (nullable.some false))) (set.singleton (tuple (nullable.some true))))))))
(check-sat)
;answer: unsat
; duration: 10 ms.
(reset)
;-----------------------------------------------------------
; test name: testTransitiveInferenceProject
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)
(set-option :simplification none)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (> (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 16) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 16) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (> (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (> (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 16) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 16) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f2 (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) EMP)))))
(assert (= q2 (set.map f6 (set.filter p5 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)))))))
(check-sat)
;answer: unsat
; duration: 962 ms.
(reset)
;-----------------------------------------------------------
; test name: testReduceConstantsCalc
;Translating sql query: SELECT * FROM (SELECT UPPER(SUBSTRING(t6.X FROM 1 FOR 2) || SUBSTRING(t6.X FROM 3)) AS U, SUBSTRING(t6.X FROM 1 FOR 1) AS S FROM (SELECT * FROM (SELECT 'table' AS X FROM (VALUES  (TRUE)) AS t UNION SELECT 'view' FROM (VALUES  (TRUE)) AS t1) AS t3 UNION SELECT 'foreign table' FROM (VALUES  (TRUE)) AS t4) AS t6) AS t7 WHERE t7.U = 'TABLE'
;Translating sql query: SELECT 'TABLE' AS U, 't' AS S FROM (VALUES  (TRUE)) AS t9
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)
(set-option :simplification none)

(declare-const q1 (Set (Tuple (Nullable String) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable String) (Nullable String))))
(declare-const p4 (-> (Tuple (Nullable String) (Nullable String)) Bool))
(declare-const f0 (-> (Tuple (Nullable Bool)) (Tuple (Nullable String))))
(declare-const f1 (-> (Tuple (Nullable Bool)) (Tuple (Nullable String))))
(declare-const f2 (-> (Tuple (Nullable Bool)) (Tuple (Nullable String))))
(declare-const f3 (-> (Tuple (Nullable String)) (Tuple (Nullable String) (Nullable String))))
(declare-const f5 (-> (Tuple (Nullable Bool)) (Tuple (Nullable String) (Nullable String))))
(assert (= f0 (lambda ((t (Tuple (Nullable Bool)))) (tuple (nullable.some "table")))))
(assert (= f1 (lambda ((t (Tuple (Nullable Bool)))) (tuple (nullable.some "view")))))
(assert (= f2 (lambda ((t (Tuple (Nullable Bool)))) (tuple (nullable.some "foreign table")))))
(assert (= f3 (lambda ((t (Tuple (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_72114 String)) (str.to_upper BOUND_VARIABLE_72114)) (nullable.lift (lambda ((BOUND_VARIABLE_72107 String) (BOUND_VARIABLE_72108 String)) (str.++ BOUND_VARIABLE_72107 BOUND_VARIABLE_72108)) (nullable.lift (lambda ((BOUND_VARIABLE_72085 String) (BOUND_VARIABLE_72086 Int) (BOUND_VARIABLE_72087 Int)) (str.substr BOUND_VARIABLE_72085 BOUND_VARIABLE_72086 BOUND_VARIABLE_72087)) ((_ tuple.select 0) t) (nullable.some 0) (nullable.some (nullable.val (nullable.some 2)))) (nullable.lift (lambda ((BOUND_VARIABLE_72100 String) (BOUND_VARIABLE_72101 Int) (BOUND_VARIABLE_72102 Int)) (str.substr BOUND_VARIABLE_72100 BOUND_VARIABLE_72101 BOUND_VARIABLE_72102)) ((_ tuple.select 0) t) (nullable.some 2) (nullable.some (str.len (nullable.val ((_ tuple.select 0) t))))))) (nullable.lift (lambda ((BOUND_VARIABLE_72121 String) (BOUND_VARIABLE_72122 Int) (BOUND_VARIABLE_72123 Int)) (str.substr BOUND_VARIABLE_72121 BOUND_VARIABLE_72122 BOUND_VARIABLE_72123)) ((_ tuple.select 0) t) (nullable.some 0) (nullable.some (nullable.val (nullable.some 1))))))))
(assert (not (= q1 q2)))
(assert (= p4 (lambda ((t (Tuple (Nullable String) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 0) t)) (= (nullable.val ((_ tuple.select 0) t)) "TABLE")))))
(assert (= f5 (lambda ((t (Tuple (Nullable Bool)))) (tuple (nullable.some "TABLE") (nullable.some "t")))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p4 (set.map f3 (set.union ((_ rel.project 0) (set.union (set.map f0 (set.singleton (tuple (nullable.some true)))) (set.map f1 (set.singleton (tuple (nullable.some true)))))) (set.map f2 (set.singleton (tuple (nullable.some true))))))))))
(assert (= q2 (set.map f5 (set.singleton (tuple (nullable.some true))))))
(check-sat)
;answer: unsat
; duration: 67 ms.
(reset)
;-----------------------------------------------------------
; test name: testReduceConstantsDup2
;Translating sql query: SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 AND EMP.DEPTNO = 8 AND EMP.EMPNO = 10 AND EMP.MGR IS NULL AND EMP.EMPNO = 10
;Translating sql query: SELECT 10 AS EMPNO, t0.ENAME, t0.JOB, CAST(NULL AS INT) AS MGR, t0.HIREDATE, t0.SAL, t0.COMM, t0.DEPTNO, t0.SLACKER FROM (SELECT * FROM EMP WHERE FALSE) AS t0
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)
(set-option :simplification none)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 0) t)) (and (= (nullable.val ((_ tuple.select 7) t)) 7) (= (nullable.val ((_ tuple.select 7) t)) 8) (= (nullable.val ((_ tuple.select 0) t)) 10) (nullable.is_null ((_ tuple.select 3) t)) (= (nullable.val ((_ tuple.select 0) t)) 10))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) false)))
(assert (not (= q1 q2)))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 10) ((_ tuple.select 1) t) ((_ tuple.select 2) t) (as nullable.null (Nullable Int)) ((_ tuple.select 4) t) ((_ tuple.select 6) t) ((_ tuple.select 5) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 (set.map f2 (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 32 ms.
(reset)
;-----------------------------------------------------------
; test name: testReduceConstantsNull
;Translating sql query: SELECT * FROM (SELECT * FROM (SELECT CAST(NULL AS INT) AS N FROM EMP AS EMP) AS t WHERE t.N IS NULL AND t.N IS NULL) AS t0 WHERE t0.N IS NULL
;Translating sql query: SELECT CAST(NULL AS INT) AS N FROM EMP AS EMP0
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)
(set-option :simplification none)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_null ((_ tuple.select 0) t)) (nullable.is_null ((_ tuple.select 0) t))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int)))) (nullable.is_null ((_ tuple.select 0) t)))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int))))))
(assert (= q1 ((_ rel.project 0) (set.filter p2 ((_ rel.project 0) (set.filter p1 (set.map f0 EMP)))))))
(assert (= q2 (set.map f3 EMP)))
(check-sat)
;answer: unsat
; duration: 27 ms.
(reset)
;-----------------------------------------------------------
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
(set-option :simplification none)

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
; duration: 11 ms.
(reset)
;-----------------------------------------------------------
; test name: testPushSemiJoinPastJoinRuleLeft
;Translating sql query: SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.EMPNO = EMP0.EMPNO
;Translating sql query: SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.DEPTNO = DEPT0.DEPTNO INNER JOIN EMP AS EMP2 ON EMP1.EMPNO = EMP2.EMPNO INNER JOIN DEPT AS DEPT1 ON EMP1.DEPTNO = DEPT1.DEPTNO INNER JOIN EMP AS EMP3 ON EMP1.EMPNO = EMP3.EMPNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
(set-option :strings-exp true)
(set-option :simplification none)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 11) t)) (and (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t))) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 11) t))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 11) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 11) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 20) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 20) t)))))))
(assert (not (= q1 q2)))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 22) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 22) t)))))))
(assert (= q1 ((_ rel.project 1) (set.filter p0 (rel.product (rel.product EMP DEPT) EMP)))))
(assert (= q2 ((_ rel.project 1) (set.filter p4 (rel.product (set.filter p3 (rel.product (set.filter p2 (rel.product (set.filter p1 (rel.product EMP DEPT)) EMP)) DEPT)) EMP)))))
(check-sat)
