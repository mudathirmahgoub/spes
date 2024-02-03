;-----------------------------------------------------------
; test name: testEmptyProject2
;Translating sql query: SELECT t.EXPR$0 + t.EXPR$1 + t.EXPR$0 FROM (VALUES  (10, 1),  (30, 3)) AS t WHERE t.EXPR$0 + t.EXPR$1 > 10
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES (0)) WHERE FALSE) AS t3
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 1) t)) (> (+ (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 1) t))) 10)))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (+ BOUND_VARIABLE_416 BOUND_VARIABLE_417)) (nullable.lift (lambda ((BOUND_VARIABLE_409 Int) (BOUND_VARIABLE_410 Int)) (+ BOUND_VARIABLE_409 BOUND_VARIABLE_410)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 0) t))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int)))) false)))
(assert (= q1 (set.map f1 (set.filter p0 (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 30) (nullable.some 3))))))))
(assert (= q2 ((_ rel.project 0) (set.filter p2 (set.singleton (tuple (nullable.some 0)))))))
(check-sat)
;answer: sat
; duration: 28 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (set.union (set.singleton (tuple (nullable.some 21))) (set.singleton (tuple (nullable.some 63))))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; SELECT t.column1 + t.column2 + t.column1 FROM (VALUES  (10, 1),  (30, 3)) AS t WHERE t.column1 + t.column2 > 10 EXCEPT ALL SELECT * FROM (SELECT * FROM (VALUES (0)) WHERE FALSE) AS t3
;(63)
;(21)

; SELECT * FROM (SELECT * FROM (VALUES (0)) WHERE FALSE) AS t3 EXCEPT ALL SELECT t.column1 + t.column2 + t.column1 FROM (VALUES  (10, 1),  (30, 3)) AS t WHERE t.column1 + t.column2 > 10

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testEmptyFilterProjectUnion
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES  (10, 1),  (30, 3)) AS t UNION ALL SELECT * FROM (VALUES  (20, 2)) AS t0) AS t1 WHERE t1.EXPR$0 + t1.EXPR$1 > 10
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
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 1) t)) (> (+ (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 1) t))) 10)))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 (set.union ((_ rel.project 0 1) (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 30) (nullable.some 3))))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 20) (nullable.some 2)))))))))
(assert (= q2 ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 30) (nullable.some 3))))))
(check-sat)
;answer: sat
; duration: 11 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (set.union (set.singleton (tuple (nullable.some 20) (nullable.some 2))) (set.union (set.singleton (tuple (nullable.some 30) (nullable.some 3))) (set.singleton (tuple (nullable.some 10) (nullable.some 1)))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 30) (nullable.some 3)))
; SELECT * FROM (SELECT * FROM (VALUES  (10, 1),  (30, 3)) AS t UNION ALL SELECT * FROM (VALUES  (20, 2)) AS t0) AS t1 WHERE t1.column1 + t1.column2 > 10 EXCEPT ALL SELECT * FROM (VALUES  (30, 3)) AS t3
;(20,2)
;(10,1)

; SELECT * FROM (VALUES  (30, 3)) AS t3 EXCEPT ALL SELECT * FROM (SELECT * FROM (VALUES  (10, 1),  (30, 3)) AS t UNION ALL SELECT * FROM (VALUES  (20, 2)) AS t0) AS t1 WHERE t1.column1 + t1.column2 > 10

;Model soundness: true
(reset)
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
; duration: 71 ms.
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
;Translating sql query: SELECT t.EXPR$0 + t.EXPR$1 AS X, t.EXPR$1 AS B, t.EXPR$0 AS A FROM (VALUES  (10, 1),  (30, 7),  (20, 3)) AS t WHERE t.EXPR$0 - t.EXPR$1 < 100
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
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 1) t)) (< (- (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 1) t))) 100)))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_1568 Int) (BOUND_VARIABLE_1569 Int)) (+ BOUND_VARIABLE_1568 BOUND_VARIABLE_1569)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= q1 (set.map f1 (set.filter p0 (set.union (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 30) (nullable.some 7)))) (set.singleton (tuple (nullable.some 20) (nullable.some 3))))))))
(assert (= q2 ((_ rel.project 0 1 2) (set.union (set.singleton (tuple (nullable.some 11) (nullable.some 1) (nullable.some 10))) (set.singleton (tuple (nullable.some 23) (nullable.some 3) (nullable.some 20)))))))
(check-sat)
;answer: sat
; duration: 12 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (set.union (set.singleton (tuple (nullable.some 37) (nullable.some 7) (nullable.some 30))) (set.union (set.singleton (tuple (nullable.some 23) (nullable.some 3) (nullable.some 20))) (set.singleton (tuple (nullable.some 11) (nullable.some 1) (nullable.some 10)))))
; q2
(get-value (q2))
; (set.union (set.singleton (tuple (nullable.some 23) (nullable.some 3) (nullable.some 20))) (set.singleton (tuple (nullable.some 11) (nullable.some 1) (nullable.some 10))))
; SELECT t.column1 + t.column2 AS X, t.column2 AS B, t.column1 AS A FROM (VALUES  (10, 1),  (30, 7),  (20, 3)) AS t WHERE t.column1 - t.column2 < 100 EXCEPT ALL SELECT * FROM (VALUES  (11, 1, 10),  (23, 3, 20)) AS t2
;(37,7,30)

; SELECT * FROM (VALUES  (11, 1, 10),  (23, 3, 20)) AS t2 EXCEPT ALL SELECT t.column1 + t.column2 AS X, t.column2 AS B, t.column1 AS A FROM (VALUES  (10, 1),  (30, 7),  (20, 3)) AS t WHERE t.column1 - t.column2 < 100

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testMergeMinus
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 EXCEPT SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 EXCEPT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 40
;Translating sql query: SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 EXCEPT SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 EXCEPT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

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
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 40)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 10)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 20)))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 30)))))
(assert (= q1 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))
(assert (= q2 (set.minus (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))
(check-sat)
;answer: unsat
; duration: 605 ms.
(reset)
;-----------------------------------------------------------
; test name: testEmptyMinus
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES  (30, 3)) AS t WHERE t.EXPR$0 >= 30 EXCEPT SELECT * FROM (VALUES  (20, 2)) AS t1) AS t2 EXCEPT SELECT * FROM (VALUES  (40, 3)) AS t3
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES  (0, 0)) WHERE FALSE) AS t5
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (>= (nullable.val ((_ tuple.select 0) t)) 30)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) false)))
(assert (= q1 (set.minus ((_ rel.project 0 1) (set.minus ((_ rel.project 0 1) (set.filter p0 (set.singleton (tuple (nullable.some 30) (nullable.some 3))))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 20) (nullable.some 2)))))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 40) (nullable.some 3)))))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p1 (set.singleton (tuple (nullable.some 0) (nullable.some 0)))))))
(check-sat)
;answer: sat
; duration: 10 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 30) (nullable.some 3)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable Int))))
; SELECT * FROM (SELECT * FROM (VALUES  (30, 3)) AS t WHERE t.column1 >= 30 EXCEPT SELECT * FROM (VALUES  (20, 2)) AS t1) AS t2 EXCEPT SELECT * FROM (VALUES  (40, 3)) AS t3 EXCEPT ALL SELECT * FROM (SELECT * FROM (VALUES  (0, 0)) WHERE FALSE) AS t5
;(30,3)

; SELECT * FROM (SELECT * FROM (VALUES  (0, 0)) WHERE FALSE) AS t5 EXCEPT ALL SELECT * FROM (SELECT * FROM (VALUES  (30, 3)) AS t WHERE t.column1 >= 30 EXCEPT SELECT * FROM (VALUES  (20, 2)) AS t1) AS t2 EXCEPT SELECT * FROM (VALUES  (40, 3)) AS t3

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testReduceValuesUnderProject
;Translating sql query: SELECT t.EXPR$0 + t.EXPR$1 FROM (VALUES  (10, 1),  (20, 2)) AS t
;Translating sql query: SELECT * FROM (VALUES  (11),  (23)) AS t1
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_4495 Int) (BOUND_VARIABLE_4496 Int)) (+ BOUND_VARIABLE_4495 BOUND_VARIABLE_4496)) ((_ tuple.select 0) t) ((_ tuple.select 1) t))))))
(assert (= q1 (set.map f0 (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 20) (nullable.some 2)))))))
(assert (= q2 ((_ rel.project 0) (set.union (set.singleton (tuple (nullable.some 11))) (set.singleton (tuple (nullable.some 23)))))))
(check-sat)
;answer: sat
; duration: 6 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (set.union (set.singleton (tuple (nullable.some 22))) (set.singleton (tuple (nullable.some 11))))
; q2
(get-value (q2))
; (set.union (set.singleton (tuple (nullable.some 23))) (set.singleton (tuple (nullable.some 11))))
; SELECT t.column1 + t.column2 FROM (VALUES  (10, 1),  (20, 2)) AS t EXCEPT ALL SELECT * FROM (VALUES  (11),  (23)) AS t1
;(22)

; SELECT * FROM (VALUES  (11),  (23)) AS t1 EXCEPT ALL SELECT t.column1 + t.column2 FROM (VALUES  (10, 1),  (20, 2)) AS t
;(23)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testReduceValuesUnderFilter
;Translating sql query: SELECT * FROM (VALUES  (10, 'x'),  (14, 'y')) AS t WHERE t.EXPR$0 < 15
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
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 0) t)) (< (nullable.val ((_ tuple.select 0) t)) 15)))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 (set.union (set.singleton (tuple (nullable.some 10) (nullable.some "x"))) (set.singleton (tuple (nullable.some 14) (nullable.some "y"))))))))
(assert (= q2 ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 10) (nullable.some "x"))))))
(check-sat)
;answer: sat
; duration: 6 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (set.union (set.singleton (tuple (nullable.some 14) (nullable.some "y"))) (set.singleton (tuple (nullable.some 10) (nullable.some "x"))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 10) (nullable.some "x")))
; SELECT * FROM (VALUES  (10, 'x'),  (14, 'y')) AS t WHERE t.column1 < 15 EXCEPT ALL SELECT * FROM (VALUES  (10, 'x')) AS t1
;(14,y)

; SELECT * FROM (VALUES  (10, 'x')) AS t1 EXCEPT ALL SELECT * FROM (VALUES  (10, 'x'),  (14, 'y')) AS t WHERE t.column1 < 15

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testReduceConstantsDup
;Translating sql query: SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE DEPT.DEPTNO = 7 AND DEPT.DEPTNO = 7
;Translating sql query: SELECT t1.EXPR$0 FROM (SELECT * FROM (VALUES(0, 0)) WHERE FALSE) AS t1
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 0) t)) (and (= (nullable.val ((_ tuple.select 0) t)) 7) (= (nullable.val ((_ tuple.select 0) t)) 7))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) false)))
(assert (= q1 ((_ rel.project 0) (set.filter p0 DEPT))))
(assert (= q2 ((_ rel.project 0) (set.filter p1 (set.singleton (tuple (nullable.some 0) (nullable.some 0)))))))
(check-sat)
;answer: sat
; duration: 13 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 7) (as nullable.null (Nullable String)))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 7)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; insert into DEPT values(7,NULL)
; SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE DEPT.DEPTNO = 7 AND DEPT.DEPTNO = 7 EXCEPT ALL SELECT t1.column1 FROM (SELECT * FROM (VALUES(0, 0)) WHERE FALSE) AS t1
;(7)

; SELECT t1.column1 FROM (SELECT * FROM (VALUES(0, 0)) WHERE FALSE) AS t1 EXCEPT ALL SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE DEPT.DEPTNO = 7 AND DEPT.DEPTNO = 7

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testRemoveSemiJoin
;Translating sql query: SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO <> DEPT.DEPTNO
;Translating sql query: SELECT EMP0.ENAME FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (distinct (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ rel.project 1) (set.filter p0 (rel.product EMP DEPT)))))
(assert (= q2 ((_ rel.project 1) (set.filter p1 (rel.product EMP DEPT)))))
(check-sat)
;answer: sat
; duration: 98 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 0) (nullable.some "D"))))
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some (- 4)) (nullable.some "B") (nullable.some "C") (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (nullable.some (- 6)) (nullable.some (- 1)) (nullable.some 7))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some "B")))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable String))))
; insert into DEPT values(0,'D')
; insert into EMP values(-4,'B','C',5,-5,6,-6,-1,7)
; SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO <> DEPT.DEPTNO EXCEPT ALL SELECT EMP0.ENAME FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO
;(B)

; SELECT EMP0.ENAME FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO EXCEPT ALL SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO <> DEPT.DEPTNO

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testPullConstantThroughUnion
;Translating sql query: SELECT 2, EMP.DEPTNO, EMP.JOB FROM EMP AS EMP UNION ALL SELECT 3, EMP0.DEPTNO, EMP0.JOB FROM EMP AS EMP0
;Translating sql query: SELECT 2, t6.DEPTNO, t6.JOB FROM (SELECT EMP1.DEPTNO, EMP1.JOB FROM EMP AS EMP1 UNION ALL SELECT EMP2.DEPTNO, EMP2.JOB FROM EMP AS EMP2) AS t6
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 3) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (not (= q1 q2)))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.some 2) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= q1 (set.union (set.map f0 EMP) (set.map f1 EMP))))
(assert (= q2 (set.map f2 (set.union ((_ rel.project 7 2) EMP) ((_ rel.project 7 2) EMP)))))
(check-sat)
;answer: sat
; duration: 56 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some 15) (nullable.some "G") (nullable.some "E") (nullable.some (- 15)) (nullable.some 16) (nullable.some (- 16)) (nullable.some 17) (nullable.some (- 11)) (nullable.some (- 17)))) (set.union (set.singleton (tuple (nullable.some 12) (nullable.some "F") (nullable.some "E") (nullable.some (- 12)) (nullable.some 13) (nullable.some (- 13)) (nullable.some 14) (nullable.some (- 11)) (nullable.some (- 14)))) (set.singleton (tuple (nullable.some (- 8)) (nullable.some "D") (nullable.some "E") (nullable.some 9) (nullable.some (- 9)) (nullable.some 10) (nullable.some (- 10)) (nullable.some (- 11)) (nullable.some 11))))))
; )
; q1
(get-value (q1))
; (set.union (set.singleton (tuple (nullable.some 3) (nullable.some (- 11)) (nullable.some "E"))) (set.singleton (tuple (nullable.some 2) (nullable.some (- 11)) (nullable.some "E"))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 2) (nullable.some (- 11)) (nullable.some "E")))
; insert into EMP values(15,'G','E',-15,16,-16,17,-11,-17),(12,'F','E',-12,13,-13,14,-11,-14),(-8,'D','E',9,-9,10,-10,-11,11)
; SELECT 2, EMP.DEPTNO, EMP.JOB FROM EMP AS EMP UNION ALL SELECT 3, EMP0.DEPTNO, EMP0.JOB FROM EMP AS EMP0 EXCEPT ALL SELECT 2, t6.DEPTNO, t6.JOB FROM (SELECT EMP1.DEPTNO, EMP1.JOB FROM EMP AS EMP1 UNION ALL SELECT EMP2.DEPTNO, EMP2.JOB FROM EMP AS EMP2) AS t6
;(3,-11,E)
;(3,-11,E)
;(3,-11,E)

; SELECT 2, t6.DEPTNO, t6.JOB FROM (SELECT EMP1.DEPTNO, EMP1.JOB FROM EMP AS EMP1 UNION ALL SELECT EMP2.DEPTNO, EMP2.JOB FROM EMP AS EMP2) AS t6 EXCEPT ALL SELECT 2, EMP.DEPTNO, EMP.JOB FROM EMP AS EMP UNION ALL SELECT 3, EMP0.DEPTNO, EMP0.JOB FROM EMP AS EMP0
;(2,-11,E)
;(2,-11,E)
;(2,-11,E)
;(3,-11,E)
;(3,-11,E)
;(3,-11,E)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testReduceNot
;Translating sql query: SELECT * FROM (SELECT CASE WHEN EMP.SAL > 1000 THEN NULL ELSE FALSE END AS CASECOL FROM EMP AS EMP) AS t WHERE NOT t.CASECOL
;Translating sql query: SELECT * FROM (SELECT CASE WHEN EMP0.SAL > 1000 THEN NULL ELSE TRUE END AS CASECOL FROM EMP AS EMP0) AS t1 WHERE NOT t1.CASECOL
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Bool))))
(declare-const p1 (-> (Tuple (Nullable Bool)) Bool))
(declare-const q2 (Set (Tuple (Nullable Bool))))
(declare-const p3 (-> (Tuple (Nullable Bool)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Bool))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Bool))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_7251 Bool) (BOUND_VARIABLE_7252 Bool)) (and BOUND_VARIABLE_7251 BOUND_VARIABLE_7252)) (nullable.lift (lambda ((BOUND_VARIABLE_7243 Int) (BOUND_VARIABLE_7244 Int)) (> BOUND_VARIABLE_7243 BOUND_VARIABLE_7244)) ((_ tuple.select 6) t) (nullable.some 1000)) (as nullable.null (Nullable Bool)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some ((_ tuple.select 0) t)) (not (nullable.val ((_ tuple.select 0) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_7308 Bool) (BOUND_VARIABLE_7309 Bool)) (or BOUND_VARIABLE_7308 BOUND_VARIABLE_7309)) (nullable.lift (lambda ((BOUND_VARIABLE_7291 Bool) (BOUND_VARIABLE_7292 Bool)) (and BOUND_VARIABLE_7291 BOUND_VARIABLE_7292)) (nullable.lift (lambda ((BOUND_VARIABLE_7285 Int) (BOUND_VARIABLE_7286 Int)) (> BOUND_VARIABLE_7285 BOUND_VARIABLE_7286)) ((_ tuple.select 6) t) (nullable.some 1000)) (as nullable.null (Nullable Bool))) (nullable.some (not (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_7297 Int) (BOUND_VARIABLE_7298 Int)) (> BOUND_VARIABLE_7297 BOUND_VARIABLE_7298)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_7297 Int) (BOUND_VARIABLE_7298 Int)) (> BOUND_VARIABLE_7297 BOUND_VARIABLE_7298)) ((_ tuple.select 6) t) (nullable.some 1000)))))))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some ((_ tuple.select 0) t)) (not (nullable.val ((_ tuple.select 0) t)))))))
(assert (= q1 ((_ rel.project 0) (set.filter p1 (set.map f0 EMP)))))
(assert (= q2 ((_ rel.project 0) (set.filter p3 (set.map f2 EMP)))))
(check-sat)
;answer: unsat
; duration: 25 ms.
(reset)
;-----------------------------------------------------------
; test name: testWhereInCorrelated
;Translating sql query: SELECT EMP.SAL FROM EMP AS EMP WHERE EMP.EMPNO IN (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE EMP.ENAME = DEPT.NAME)
;Translating sql query: SELECT EMP0.SAL FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.JOB = DEPT0.NAME AND EMP0.EMPNO = DEPT0.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

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
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 1) t)) (nullable.is_some ((_ tuple.select 10) t)) (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 9) t)) (and (= (nullable.val ((_ tuple.select 1) t)) (nullable.val ((_ tuple.select 10) t))) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 9) t))))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 2) t)))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 9) t)) (nullable.is_some ((_ tuple.select 12) t)) (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 10) t)) (and (= (nullable.val ((_ tuple.select 9) t)) (nullable.val ((_ tuple.select 12) t))) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 10) t))))))))
(assert (= q1 ((_ rel.project 6) (set.filter p2 (rel.product EMP ((_ rel.project 0 1) ((_ rel.project 0 2) (set.filter p1 (set.map f0 DEPT)))))))))
(assert (= q2 ((_ rel.project 6) (set.filter p5 (rel.product (set.map f3 EMP) (set.map f4 DEPT))))))
(check-sat)
;answer: sat
; duration: 457 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 0) (nullable.some ""))))
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 3) (nullable.some (- 3)) (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)))) (set.singleton (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (as nullable.null (Nullable Int)) (nullable.some 1) (nullable.some (- 1)) (nullable.some (- 4)) (nullable.some 2) (nullable.some (- 2))))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some (- 4))))
; insert into DEPT values(0,'')
; insert into EMP values(0,NULL,'',3,-3,4,-4,5,-5),(0,NULL,'',NULL,1,-1,-4,2,-2)
; SELECT EMP.SAL FROM EMP AS EMP WHERE EMP.EMPNO IN (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE EMP.ENAME = DEPT.NAME) EXCEPT ALL SELECT EMP0.SAL FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.JOB = DEPT0.NAME AND EMP0.EMPNO = DEPT0.DEPTNO

; SELECT EMP0.SAL FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.JOB = DEPT0.NAME AND EMP0.EMPNO = DEPT0.DEPTNO EXCEPT ALL SELECT EMP.SAL FROM EMP AS EMP WHERE EMP.EMPNO IN (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE EMP.ENAME = DEPT.NAME)
;(-4)
;(-4)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testReduceConstantsRequiresExecutor
;Translating sql query: SELECT * FROM (VALUES  (1, 3)) AS t WHERE 1 + 2 > 3 + CAST(NULL AS INT)
;Translating sql query: SELECT * FROM (VALUES  (1, 2)) AS t1 WHERE 1 + 2 >= 3
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_12914 Int) (BOUND_VARIABLE_12915 Int)) (> BOUND_VARIABLE_12914 BOUND_VARIABLE_12915)) (nullable.some (+ 1 2)) (nullable.lift (lambda ((BOUND_VARIABLE_12907 Int) (BOUND_VARIABLE_12908 Int)) (+ BOUND_VARIABLE_12907 BOUND_VARIABLE_12908)) (nullable.some 3) (as nullable.null (Nullable Int))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_12914 Int) (BOUND_VARIABLE_12915 Int)) (> BOUND_VARIABLE_12914 BOUND_VARIABLE_12915)) (nullable.some (+ 1 2)) (nullable.lift (lambda ((BOUND_VARIABLE_12907 Int) (BOUND_VARIABLE_12908 Int)) (+ BOUND_VARIABLE_12907 BOUND_VARIABLE_12908)) (nullable.some 3) (as nullable.null (Nullable Int)))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (>= (+ 1 2) 3))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 (set.singleton (tuple (nullable.some 1) (nullable.some 3)))))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p1 (set.singleton (tuple (nullable.some 1) (nullable.some 2)))))))
(check-sat)
;answer: sat
; duration: 13 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 1) (nullable.some 2)))
; SELECT * FROM (VALUES  (1, 3)) AS t WHERE 1 + 2 > 3 + CAST(NULL AS INT) EXCEPT ALL SELECT * FROM (VALUES  (1, 2)) AS t1 WHERE 1 + 2 >= 3

; SELECT * FROM (VALUES  (1, 2)) AS t1 WHERE 1 + 2 >= 3 EXCEPT ALL SELECT * FROM (VALUES  (1, 3)) AS t WHERE 1 + 2 > 3 + CAST(NULL AS INT)
;(1,2)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testReduceConstantsProjectNullable*
;Translating sql query: SELECT EMP.MGR FROM EMP AS EMP WHERE EMP.MGR = 11
;Translating sql query: SELECT 10 AS MGR FROM EMP AS EMP0 WHERE EMP0.MGR = 10
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 3) t)) (= (nullable.val ((_ tuple.select 3) t)) 11)))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 3) t)) (= (nullable.val ((_ tuple.select 3) t)) 10)))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 10)))))
(assert (= q1 ((_ rel.project 3) (set.filter p0 EMP))))
(assert (= q2 (set.map f2 (set.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 54 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some (- 13)) (nullable.some "G") (nullable.some "H") (nullable.some 10) (nullable.some 14) (nullable.some (- 14)) (nullable.some 15) (nullable.some (- 15)) (nullable.some 16))) (set.singleton (tuple (nullable.some (- 3)) (nullable.some "A") (nullable.some "B") (nullable.some 10) (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6)))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 10)))
; insert into EMP values(-13,'G','H',10,14,-14,15,-15,16),(-3,'A','B',10,4,-4,5,-5,6)
; SELECT EMP.MGR FROM EMP AS EMP WHERE EMP.MGR = 11 EXCEPT ALL SELECT 10 AS MGR FROM EMP AS EMP0 WHERE EMP0.MGR = 10

; SELECT 10 AS MGR FROM EMP AS EMP0 WHERE EMP0.MGR = 10 EXCEPT ALL SELECT EMP.MGR FROM EMP AS EMP WHERE EMP.MGR = 11
;(10)
;(10)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testTransitiveInferencePreventProjectPullUp
;Translating sql query: SELECT 1 FROM (SELECT EMP.COMM AS DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO >= 7) AS t0 INNER JOIN EMP AS EMP0 ON t0.DEPTNO = EMP0.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT EMP1.COMM AS DEPTNO FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t3 INNER JOIN EMP AS EMP2 ON t3.DEPTNO = EMP2.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f5 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (>= (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 8) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 8) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (> (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (not (= q1 q2)))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 8) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 8) t)))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f2 (set.filter p1 (rel.product ((_ rel.project 5) (set.filter p0 EMP)) EMP)))))
(assert (= q2 (set.map f5 (set.filter p4 (rel.product ((_ rel.project 5) (set.filter p3 EMP)) EMP)))))
(check-sat)
;answer: sat
; duration: 3886 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some (- 71)) (nullable.some "s") (nullable.some "t") (nullable.some 72) (nullable.some (- 72)) (nullable.some 10) (nullable.some 73) (nullable.some 8) (nullable.some (- 73)))) (set.union (set.singleton (tuple (nullable.some 69) (nullable.some "q") (nullable.some "r") (nullable.some (- 69)) (nullable.some 70) (nullable.some 10) (nullable.some (- 70)) (nullable.some 8) (nullable.some 71))) (set.union (set.singleton (tuple (nullable.some (- 66)) (nullable.some "o") (nullable.some "p") (nullable.some 67) (nullable.some (- 67)) (nullable.some 8) (nullable.some 68) (nullable.some 7) (nullable.some (- 68)))) (set.union (set.singleton (tuple (nullable.some 64) (nullable.some "m") (nullable.some "n") (nullable.some (- 64)) (nullable.some 65) (nullable.some 8) (nullable.some (- 65)) (nullable.some 7) (nullable.some 66))) (set.union (set.singleton (tuple (nullable.some (- 61)) (nullable.some "k") (nullable.some "l") (nullable.some 62) (nullable.some (- 62)) (nullable.some 10) (nullable.some 63) (nullable.some 8) (nullable.some (- 63)))) (set.union (set.singleton (tuple (nullable.some 59) (nullable.some "i") (nullable.some "j") (nullable.some (- 59)) (nullable.some 60) (nullable.some 10) (nullable.some (- 60)) (nullable.some 8) (nullable.some 61))) (set.union (set.singleton (tuple (nullable.some (- 51)) (nullable.some "c") (nullable.some "d") (nullable.some 52) (nullable.some (- 52)) (nullable.some 10) (nullable.some 53) (nullable.some 8) (nullable.some (- 53)))) (set.union (set.singleton (tuple (nullable.some 49) (nullable.some "a") (nullable.some "b") (nullable.some (- 49)) (nullable.some 50) (nullable.some 10) (nullable.some (- 50)) (nullable.some 8) (nullable.some 51))) (set.union (set.singleton (tuple (nullable.some (- 46)) (nullable.some "_") (nullable.some "`") (nullable.some 47) (nullable.some (- 47)) (nullable.some 8) (nullable.some 48) (nullable.some 7) (nullable.some (- 48)))) (set.union (set.singleton (tuple (nullable.some 44) (nullable.some "]") (nullable.some "^") (nullable.some (- 44)) (nullable.some 45) (nullable.some 8) (nullable.some (- 45)) (nullable.some 7) (nullable.some 46))) (set.union (set.singleton (tuple (nullable.some (- 41)) (nullable.some "[") (nullable.some "\u{5c}") (nullable.some 42) (nullable.some (- 42)) (nullable.some 10) (nullable.some 43) (nullable.some 8) (nullable.some (- 43)))) (set.union (set.singleton (tuple (nullable.some 39) (nullable.some "Y") (nullable.some "Z") (nullable.some (- 39)) (nullable.some 40) (nullable.some 10) (nullable.some (- 40)) (nullable.some 8) (nullable.some 41))) (set.union (set.singleton (tuple (nullable.some 34) (nullable.some "U") (nullable.some "V") (nullable.some (- 34)) (nullable.some 35) (nullable.some 10) (nullable.some (- 35)) (nullable.some 8) (nullable.some 36))) (set.singleton (tuple (nullable.some (- 36)) (nullable.some "W") (nullable.some "X") (nullable.some 37) (nullable.some (- 37)) (nullable.some 10) (nullable.some 38) (nullable.some 8) (nullable.some (- 38))))))))))))))))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 1)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; insert into EMP values(-71,'s','t',72,-72,10,73,8,-73),(69,'q','r',-69,70,10,-70,8,71),(-66,'o','p',67,-67,8,68,7,-68),(64,'m','n',-64,65,8,-65,7,66),(-61,'k','l',62,-62,10,63,8,-63),(59,'i','j',-59,60,10,-60,8,61),(-51,'c','d',52,-52,10,53,8,-53),(49,'a','b',-49,50,10,-50,8,51),(-46,'_','`',47,-47,8,48,7,-48),(44,']','^',-44,45,8,-45,7,46),(-41,'[','\',42,-42,10,43,8,-43),(39,'Y','Z',-39,40,10,-40,8,41),(34,'U','V',-34,35,10,-35,8,36),(-36,'W','X',37,-37,10,38,8,-38)
; SELECT 1 FROM (SELECT EMP.COMM AS DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO >= 7) AS t0 INNER JOIN EMP AS EMP0 ON t0.DEPTNO = EMP0.DEPTNO EXCEPT ALL SELECT 1 FROM (SELECT EMP1.COMM AS DEPTNO FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t3 INNER JOIN EMP AS EMP2 ON t3.DEPTNO = EMP2.DEPTNO
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)

; SELECT 1 FROM (SELECT EMP1.COMM AS DEPTNO FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t3 INNER JOIN EMP AS EMP2 ON t3.DEPTNO = EMP2.DEPTNO EXCEPT ALL SELECT 1 FROM (SELECT EMP.COMM AS DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO >= 7) AS t0 INNER JOIN EMP AS EMP0 ON t0.DEPTNO = EMP0.DEPTNO

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testTransitiveInferenceJoin3way
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO >= 7) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO INNER JOIN EMP AS EMP1 ON EMP0.DEPTNO = EMP1.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO INNER JOIN (SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 7) AS t3 ON t2.DEPTNO = t3.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (>= (nullable.val ((_ tuple.select 7) t)) 7)))))
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
;answer: sat
; duration: 10512 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some (- 169)) (nullable.some "\u{8e}") (nullable.some "\u{8f}") (nullable.some 170) (nullable.some (- 170)) (nullable.some 171) (nullable.some (- 171)) (nullable.some 7) (nullable.some 172))) (set.union (set.singleton (tuple (nullable.some (- 166)) (nullable.some "\u{8c}") (nullable.some "\u{8d}") (nullable.some 167) (nullable.some (- 167)) (nullable.some 168) (nullable.some (- 168)) (nullable.some 7) (nullable.some 169))) (set.union (set.singleton (tuple (nullable.some (- 163)) (nullable.some "\u{8a}") (nullable.some "\u{8b}") (nullable.some 164) (nullable.some (- 164)) (nullable.some 165) (nullable.some (- 165)) (nullable.some 7) (nullable.some 166))) (set.union (set.singleton (tuple (nullable.some (- 160)) (nullable.some "\u{88}") (nullable.some "\u{89}") (nullable.some 161) (nullable.some (- 161)) (nullable.some 162) (nullable.some (- 162)) (nullable.some 7) (nullable.some 163))) (set.union (set.singleton (tuple (nullable.some (- 121)) (nullable.some "0") (nullable.some "1") (nullable.some 122) (nullable.some (- 122)) (nullable.some 123) (nullable.some (- 123)) (nullable.some 7) (nullable.some 124))) (set.singleton (tuple (nullable.some (- 118)) (nullable.some ".") (nullable.some "/") (nullable.some 119) (nullable.some (- 119)) (nullable.some 120) (nullable.some (- 120)) (nullable.some 7) (nullable.some 121)))))))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 1)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; insert into EMP values(-169,'','',170,-170,171,-171,7,172),(-166,'','',167,-167,168,-168,7,169),(-163,'','',164,-164,165,-165,7,166),(-160,'','',161,-161,162,-162,7,163),(-121,'0','1',122,-122,123,-123,7,124),(-118,'.','/',119,-119,120,-120,7,121)
; SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO >= 7) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO INNER JOIN EMP AS EMP1 ON EMP0.DEPTNO = EMP1.DEPTNO EXCEPT ALL SELECT 1 FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO INNER JOIN (SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 7) AS t3 ON t2.DEPTNO = t3.DEPTNO
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)

; SELECT 1 FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO INNER JOIN (SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 7) AS t3 ON t2.DEPTNO = t3.DEPTNO EXCEPT ALL SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO >= 7) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO INNER JOIN EMP AS EMP1 ON EMP0.DEPTNO = EMP1.DEPTNO

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testRemoveSemiJoinRight
;Translating sql query: SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO <> EMP0.DEPTNO
;Translating sql query: SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.DEPTNO = DEPT0.DEPTNO INNER JOIN EMP AS EMP2 ON DEPT0.DEPTNO = EMP2.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (nullable.is_some ((_ tuple.select 9) t)) (nullable.is_some ((_ tuple.select 18) t)) (and (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t))) (distinct (nullable.val ((_ tuple.select 9) t)) (nullable.val ((_ tuple.select 18) t))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 9) t)) (nullable.is_some ((_ tuple.select 18) t)) (= (nullable.val ((_ tuple.select 9) t)) (nullable.val ((_ tuple.select 18) t)))))))
(assert (= q1 ((_ rel.project 1) (set.filter p0 (rel.product (rel.product EMP DEPT) EMP)))))
(assert (= q2 ((_ rel.project 1) (set.filter p2 (rel.product (set.filter p1 (rel.product EMP DEPT)) EMP)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10468 ms.
(reset)
;-----------------------------------------------------------
; test name: testReduceExpressionsNot
;Translating sql query: SELECT * FROM (VALUES  (FALSE),  (TRUE), (FALSE)) AS t WHERE NOT t.EXPR$0
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
(declare-const q1 (Set (Tuple (Nullable Bool))))
(declare-const p1 (-> (Tuple (Nullable Bool)) Bool))
(declare-const q2 (Set (Tuple (Nullable Bool))))
(assert (= p0 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some ((_ tuple.select 0) t)) (not (nullable.val ((_ tuple.select 0) t)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some ((_ tuple.select 0) t)) (not (nullable.val ((_ tuple.select 0) t)))))))
(assert (= q1 ((_ rel.project 0) (set.filter p0 (set.union (set.union (set.singleton (tuple (nullable.some false))) (set.singleton (tuple (nullable.some true)))) (set.singleton (tuple (nullable.some false))))))))
(assert (= q2 ((_ rel.project 0) (set.filter p1 (set.union (set.singleton (tuple (nullable.some false))) (set.singleton (tuple (nullable.some true))))))))
(check-sat)
;answer: unsat
; duration: 963 ms.
(reset)
;-----------------------------------------------------------
; test name: testTransitiveInferenceProject
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO >= 7) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (>= (nullable.val ((_ tuple.select 7) t)) 7)))))
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
;answer: sat
; duration: 2117 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some (- 88)) (nullable.some "y") (nullable.some "z") (nullable.some 89) (nullable.some (- 89)) (nullable.some 90) (nullable.some (- 90)) (nullable.some 7) (nullable.some 91))) (set.union (set.singleton (tuple (nullable.some (- 85)) (nullable.some "w") (nullable.some "x") (nullable.some 86) (nullable.some (- 86)) (nullable.some 87) (nullable.some (- 87)) (nullable.some 7) (nullable.some 88))) (set.union (set.singleton (tuple (nullable.some (- 82)) (nullable.some "u") (nullable.some "v") (nullable.some 83) (nullable.some (- 83)) (nullable.some 84) (nullable.some (- 84)) (nullable.some 7) (nullable.some 85))) (set.singleton (tuple (nullable.some (- 79)) (nullable.some "s") (nullable.some "t") (nullable.some 80) (nullable.some (- 80)) (nullable.some 81) (nullable.some (- 81)) (nullable.some 7) (nullable.some 82)))))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 1)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; insert into EMP values(-88,'y','z',89,-89,90,-90,7,91),(-85,'w','x',86,-86,87,-87,7,88),(-82,'u','v',83,-83,84,-84,7,85),(-79,'s','t',80,-80,81,-81,7,82)
; SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO >= 7) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO EXCEPT ALL SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)

; SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO EXCEPT ALL SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO >= 7) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testReduceConstantsCalc
;Translating sql query: SELECT * FROM (SELECT UPPER(SUBSTRING(t6.X FROM 1 FOR 3) || SUBSTRING(t6.X FROM 3)) AS U, SUBSTRING(t6.X FROM 1 FOR 1) AS S FROM (SELECT * FROM (SELECT 'table' AS X FROM (VALUES  (TRUE)) AS t UNION SELECT 'view' FROM (VALUES  (TRUE)) AS t1) AS t3 UNION SELECT 'foreign table' FROM (VALUES  (TRUE)) AS t4) AS t6) AS t7 WHERE t7.U = 'TABLE'
;Translating sql query: SELECT 'TABLE' AS U, 't' AS S FROM (VALUES  (TRUE)) AS t9
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

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
(assert (= f3 (lambda ((t (Tuple (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_287806 String)) (str.to_upper BOUND_VARIABLE_287806)) (nullable.lift (lambda ((BOUND_VARIABLE_287799 String) (BOUND_VARIABLE_287800 String)) (str.++ BOUND_VARIABLE_287799 BOUND_VARIABLE_287800)) (nullable.lift (lambda ((BOUND_VARIABLE_287778 String) (BOUND_VARIABLE_287779 Int) (BOUND_VARIABLE_287780 Int)) (str.substr BOUND_VARIABLE_287778 BOUND_VARIABLE_287779 BOUND_VARIABLE_287780)) ((_ tuple.select 0) t) (nullable.some 0) (nullable.some (nullable.val (nullable.some 3)))) (nullable.lift (lambda ((BOUND_VARIABLE_287792 String) (BOUND_VARIABLE_287793 Int) (BOUND_VARIABLE_287794 Int)) (str.substr BOUND_VARIABLE_287792 BOUND_VARIABLE_287793 BOUND_VARIABLE_287794)) ((_ tuple.select 0) t) (nullable.some 2) (nullable.some (str.len (nullable.val ((_ tuple.select 0) t))))))) (nullable.lift (lambda ((BOUND_VARIABLE_287813 String) (BOUND_VARIABLE_287814 Int) (BOUND_VARIABLE_287815 Int)) (str.substr BOUND_VARIABLE_287813 BOUND_VARIABLE_287814 BOUND_VARIABLE_287815)) ((_ tuple.select 0) t) (nullable.some 0) (nullable.some (nullable.val (nullable.some 1))))))))
(assert (not (= q1 q2)))
(assert (= p4 (lambda ((t (Tuple (Nullable String) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 0) t)) (= (nullable.val ((_ tuple.select 0) t)) "TABLE")))))
(assert (= f5 (lambda ((t (Tuple (Nullable Bool)))) (tuple (nullable.some "TABLE") (nullable.some "t")))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p4 (set.map f3 (set.union ((_ rel.project 0) (set.union (set.map f0 (set.singleton (tuple (nullable.some true)))) (set.map f1 (set.singleton (tuple (nullable.some true)))))) (set.map f2 (set.singleton (tuple (nullable.some true))))))))))
(assert (= q2 (set.map f5 (set.singleton (tuple (nullable.some true))))))
(check-sat)
;answer: sat
; duration: 76 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable String) (Nullable String))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some "TABLE") (nullable.some "t")))
; SELECT * FROM (SELECT UPPER(SUBSTRING(t6.X FROM 1 FOR 3) || SUBSTRING(t6.X FROM 3)) AS U, SUBSTRING(t6.X FROM 1 FOR 1) AS S FROM (SELECT * FROM (SELECT 'table' AS X FROM (VALUES  (TRUE)) AS t UNION SELECT 'view' FROM (VALUES  (TRUE)) AS t1) AS t3 UNION SELECT 'foreign table' FROM (VALUES  (TRUE)) AS t4) AS t6) AS t7 WHERE t7.U = 'TABLE' EXCEPT ALL SELECT 'TABLE' AS U, 't' AS S FROM (VALUES  (TRUE)) AS t9

; SELECT 'TABLE' AS U, 't' AS S FROM (VALUES  (TRUE)) AS t9 EXCEPT ALL SELECT * FROM (SELECT UPPER(SUBSTRING(t6.X FROM 1 FOR 3) || SUBSTRING(t6.X FROM 3)) AS U, SUBSTRING(t6.X FROM 1 FOR 1) AS S FROM (SELECT * FROM (SELECT 'table' AS X FROM (VALUES  (TRUE)) AS t UNION SELECT 'view' FROM (VALUES  (TRUE)) AS t1) AS t3 UNION SELECT 'foreign table' FROM (VALUES  (TRUE)) AS t4) AS t6) AS t7 WHERE t7.U = 'TABLE'
;(TABLE,t)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testReduceConstantsDup2
;Translating sql query: SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 AND EMP.DEPTNO = 7 AND EMP.EMPNO = 10 AND EMP.MGR IS NULL AND EMP.EMPNO = 10
;Translating sql query: SELECT 10 AS EMPNO, t0.ENAME, t0.JOB, CAST(NULL AS INT) AS MGR, t0.HIREDATE, t0.SAL, t0.COMM, t0.DEPTNO, t0.SLACKER FROM (SELECT * FROM EMP WHERE FALSE) AS t0
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 0) t)) (and (= (nullable.val ((_ tuple.select 7) t)) 7) (= (nullable.val ((_ tuple.select 7) t)) 7) (= (nullable.val ((_ tuple.select 0) t)) 10) (nullable.is_null ((_ tuple.select 3) t)) (= (nullable.val ((_ tuple.select 0) t)) 10))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) false)))
(assert (not (= q1 q2)))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 10) ((_ tuple.select 1) t) ((_ tuple.select 2) t) (as nullable.null (Nullable Int)) ((_ tuple.select 4) t) ((_ tuple.select 6) t) ((_ tuple.select 5) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 (set.map f2 (set.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 38 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 10) (nullable.some "E") (nullable.some "F") (as nullable.null (Nullable Int)) (nullable.some (- 8)) (nullable.some 9) (nullable.some (- 9)) (nullable.some 7) (nullable.some (- 10)))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 10) (nullable.some "E") (nullable.some "F") (as nullable.null (Nullable Int)) (nullable.some (- 8)) (nullable.some 9) (nullable.some (- 9)) (nullable.some 7) (nullable.some (- 10))))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; insert into EMP values(10,'E','F',NULL,-8,9,-9,7,-10)
; SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 AND EMP.DEPTNO = 7 AND EMP.EMPNO = 10 AND EMP.MGR IS NULL AND EMP.EMPNO = 10 EXCEPT ALL SELECT 10 AS EMPNO, t0.ENAME, t0.JOB, CAST(NULL AS INT) AS MGR, t0.HIREDATE, t0.SAL, t0.COMM, t0.DEPTNO, t0.SLACKER FROM (SELECT * FROM EMP WHERE FALSE) AS t0
;(10,E,F,NULL,-8,9,-9,7,-10)

; SELECT 10 AS EMPNO, t0.ENAME, t0.JOB, CAST(NULL AS INT) AS MGR, t0.HIREDATE, t0.SAL, t0.COMM, t0.DEPTNO, t0.SLACKER FROM (SELECT * FROM EMP WHERE FALSE) AS t0 EXCEPT ALL SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 AND EMP.DEPTNO = 7 AND EMP.EMPNO = 10 AND EMP.MGR IS NULL AND EMP.EMPNO = 10

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testReduceConstantsNull
;Translating sql query: SELECT * FROM (SELECT * FROM (SELECT CAST(NULL AS INT) AS N FROM EMP AS EMP) AS t WHERE t.N IS NULL AND t.N IS NULL) AS t0 WHERE t0.N IS NOT NULL
;Translating sql query: SELECT CAST(NULL AS INT) AS N FROM EMP AS EMP0
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

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
(assert (= p2 (lambda ((t (Tuple (Nullable Int)))) (nullable.is_some ((_ tuple.select 0) t)))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int))))))
(assert (= q1 ((_ rel.project 0) (set.filter p2 ((_ rel.project 0) (set.filter p1 (set.map f0 EMP)))))))
(assert (= q2 (set.map f3 EMP)))
(check-sat)
;answer: sat
; duration: 51 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (nullable.some 0))) (set.singleton (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (as nullable.null (Nullable Int))))
; insert into EMP values(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
; SELECT * FROM (SELECT * FROM (SELECT CAST(NULL AS INT) AS N FROM EMP AS EMP) AS t WHERE t.N IS NULL AND t.N IS NULL) AS t0 WHERE t0.N IS NOT NULL EXCEPT ALL SELECT CAST(NULL AS INT) AS N FROM EMP AS EMP0

; SELECT CAST(NULL AS INT) AS N FROM EMP AS EMP0 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT CAST(NULL AS INT) AS N FROM EMP AS EMP) AS t WHERE t.N IS NULL AND t.N IS NULL) AS t0 WHERE t0.N IS NOT NULL
;(NULL)
;(NULL)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testReduceConstantsNegatedInverted
;Translating sql query: SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO >= 10 AND EMP.EMPNO <= 10
;Translating sql query: SELECT t1.EXPR$0 FROM (SELECT * FROM (VALUES(0)) WHERE FALSE) AS t1
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 0) t)) (and (>= (nullable.val ((_ tuple.select 0) t)) 10) (<= (nullable.val ((_ tuple.select 0) t)) 10))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int)))) false)))
(assert (= q1 ((_ rel.project 0) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0) (set.filter p1 (set.singleton (tuple (nullable.some 0)))))))
(check-sat)
;answer: sat
; duration: 16 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 10) (as nullable.null (Nullable String)) (nullable.some "") (as nullable.null (Nullable Int)) (nullable.some 0) (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 10)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; insert into EMP values(10,NULL,'',NULL,0,1,-1,2,-2)
; SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO >= 10 AND EMP.EMPNO <= 10 EXCEPT ALL SELECT t1.column1 FROM (SELECT * FROM (VALUES(0)) WHERE FALSE) AS t1
;(10)

; SELECT t1.column1 FROM (SELECT * FROM (VALUES(0)) WHERE FALSE) AS t1 EXCEPT ALL SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO >= 10 AND EMP.EMPNO <= 10

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testPushSemiJoinPastJoinRuleLeft
;Translating sql query: SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.EMPNO <> EMP0.EMPNO
;Translating sql query: SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.DEPTNO = DEPT0.DEPTNO INNER JOIN EMP AS EMP2 ON EMP1.EMPNO = EMP2.EMPNO INNER JOIN DEPT AS DEPT1 ON EMP1.DEPTNO = DEPT1.DEPTNO INNER JOIN EMP AS EMP3 ON EMP1.EMPNO = EMP3.EMPNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 11) t)) (and (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t))) (distinct (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 11) t))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 11) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 11) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 20) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 20) t)))))))
(assert (not (= q1 q2)))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 22) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 22) t)))))))
(assert (= q1 ((_ rel.project 1) (set.filter p0 (rel.product (rel.product EMP DEPT) EMP)))))
(assert (= q2 ((_ rel.project 1) (set.filter p4 (rel.product (set.filter p3 (rel.product (set.filter p2 (rel.product (set.filter p1 (rel.product EMP DEPT)) EMP)) DEPT)) EMP)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 11132 ms.
(reset)
;-----------------------------------------------------------
; test name: testExtractJoinFilterRule
;Translating sql query: SELECT 1 FROM EMP AS EMP INNER JOIN DEPT AS DEPT ON EMP.DEPTNO >= DEPT.DEPTNO
;Translating sql query: SELECT 1 FROM EMP AS EMP0, DEPT AS DEPT0 WHERE EMP0.DEPTNO = DEPT0.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (>= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (tuple (nullable.some 1)))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f1 (set.filter p0 (rel.product EMP DEPT)))))
(assert (= q2 (set.map f3 (set.filter p2 (rel.product EMP DEPT)))))
(check-sat)
;answer: sat
; duration: 1150 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some (- 7)) (nullable.some "E") (nullable.some "F") (nullable.some 8) (nullable.some (- 8)) (nullable.some 9) (nullable.some (- 9)) (nullable.some 1) (nullable.some 10))) (set.singleton (tuple (nullable.some (- 10)) (nullable.some "H") (nullable.some "I") (nullable.some 11) (nullable.some (- 11)) (nullable.some 12) (nullable.some (- 12)) (nullable.some 1) (nullable.some 13)))))
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.union (set.singleton (tuple (nullable.some 0) (nullable.some "G"))) (set.singleton (tuple (nullable.some 0) (nullable.some "J")))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 1)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; insert into EMP values(-7,'E','F',8,-8,9,-9,1,10),(-10,'H','I',11,-11,12,-12,1,13)
; insert into DEPT values(0,'G'),(0,'J')
; SELECT 1 FROM EMP AS EMP INNER JOIN DEPT AS DEPT ON EMP.DEPTNO >= DEPT.DEPTNO EXCEPT ALL SELECT 1 FROM EMP AS EMP0, DEPT AS DEPT0 WHERE EMP0.DEPTNO = DEPT0.DEPTNO
;(1)
;(1)
;(1)
;(1)

; SELECT 1 FROM EMP AS EMP0, DEPT AS DEPT0 WHERE EMP0.DEPTNO = DEPT0.DEPTNO EXCEPT ALL SELECT 1 FROM EMP AS EMP INNER JOIN DEPT AS DEPT ON EMP.DEPTNO >= DEPT.DEPTNO

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testTransitiveInferenceFullOuterJoin
;Translating sql query: SELECT 1 FROM EMP AS EMP FULL JOIN EMP AS EMP0 ON EMP.DEPTNO = EMP0.DEPTNO WHERE EMP.DEPTNO > 7 AND EMP0.DEPTNO >= 9
;Translating sql query: SELECT 1 FROM EMP AS EMP1 FULL JOIN EMP AS EMP2 ON EMP1.DEPTNO = EMP2.DEPTNO WHERE EMP1.DEPTNO > 7 AND EMP2.DEPTNO > 9
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const rightJoin7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f9 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const leftJoin1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const rightJoin2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const leftJoin6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 16) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 16) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 16) t)) (and (> (nullable.val ((_ tuple.select 7) t)) 7) (>= (nullable.val ((_ tuple.select 16) t)) 9))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 16) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 16) t)))))))
(assert (= leftJoin6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (not (= q1 q2)))
(assert (= p8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 16) t)) (and (> (nullable.val ((_ tuple.select 7) t)) 7) (> (nullable.val ((_ tuple.select 16) t)) 9))))))
(assert (= f9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f4 (set.filter p3 (set.union (set.union (set.map leftJoin1 (set.minus EMP ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 (rel.product EMP EMP))))) (set.map rightJoin2 (set.minus EMP ((_ rel.project 9 10 11 12 13 14 15 16 17) (set.filter p0 (rel.product EMP EMP)))))) (set.filter p0 (rel.product EMP EMP)))))))
(assert (= q2 (set.map f9 (set.filter p8 (set.union (set.union (set.map leftJoin6 (set.minus EMP ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 (rel.product EMP EMP))))) (set.map rightJoin7 (set.minus EMP ((_ rel.project 9 10 11 12 13 14 15 16 17) (set.filter p5 (rel.product EMP EMP)))))) (set.filter p5 (rel.product EMP EMP)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10414 ms.
(reset)
;-----------------------------------------------------------
; test name: testDecorrelateTwoIn
;Translating sql query: SELECT EMP.SAL FROM EMP AS EMP WHERE EMP.EMPNO IN (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE EMP.JOB = DEPT.NAME) AND EMP.EMPNO IN (SELECT EMP0.EMPNO FROM EMP AS EMP0 WHERE EMP.ENAME >= EMP0.ENAME)
;Translating sql query: SELECT EMP1.SAL FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.JOB = DEPT0.NAME AND EMP1.EMPNO = DEPT0.DEPTNO INNER JOIN (SELECT EMP2.EMPNO, EMP2.ENAME FROM EMP AS EMP2) AS t5 ON EMP1.ENAME = t5.ENAME AND EMP1.EMPNO = t5.EMPNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const f12 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String))))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)) Bool))
(declare-const f11 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String))))
(declare-const p10 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)) Bool))
(declare-const f8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f9 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String))))
(declare-const p13 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)) Bool))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 2) t)) (nullable.is_some ((_ tuple.select 1) t)) (= (nullable.val ((_ tuple.select 2) t)) (nullable.val ((_ tuple.select 1) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 2) t)) (nullable.is_some ((_ tuple.select 10) t)) (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 9) t)) (and (= (nullable.val ((_ tuple.select 2) t)) (nullable.val ((_ tuple.select 10) t))) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 9) t))))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 2) t)) (nullable.is_some ((_ tuple.select 1) t)) (= (nullable.val ((_ tuple.select 2) t)) (nullable.val ((_ tuple.select 1) t)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 2) t)) (nullable.is_some ((_ tuple.select 10) t)) (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 9) t)) (and (= (nullable.val ((_ tuple.select 2) t)) (nullable.val ((_ tuple.select 10) t))) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 9) t))))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 9) t)) (nullable.is_some ((_ tuple.select 1) t)) (str.<= (nullable.val ((_ tuple.select 1) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 1) t)) (nullable.is_some ((_ tuple.select 12) t)) (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 11) t)) (and (= (nullable.val ((_ tuple.select 1) t)) (nullable.val ((_ tuple.select 12) t))) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 11) t))))))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 2) t)))))
(assert (= f9 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p10 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 9) t)) (nullable.is_some ((_ tuple.select 12) t)) (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 10) t)) (and (= (nullable.val ((_ tuple.select 9) t)) (nullable.val ((_ tuple.select 12) t))) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 10) t))))))))
(assert (= f11 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 10) t) ((_ tuple.select 11) t) ((_ tuple.select 1) t)))))
(assert (= f12 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (not (= q1 q2)))
(assert (= p13 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 11) t)) (nullable.is_some ((_ tuple.select 14) t)) (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 12) t)) (and (= (nullable.val ((_ tuple.select 11) t)) (nullable.val ((_ tuple.select 14) t))) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 12) t))))))))
(assert (= q1 ((_ rel.project 6) (set.filter p7 (rel.product (set.filter p2 (rel.product EMP ((_ rel.project 0 1) ((_ rel.project 0 2) (set.filter p1 (set.map f0 DEPT)))))) ((_ rel.project 0 1) ((_ rel.project 0 9) (set.filter p6 (rel.product EMP ((_ rel.project 0) ((_ rel.project 1) (set.filter p5 (rel.product EMP ((_ rel.project 0 1) ((_ rel.project 0 2) (set.filter p4 (set.map f3 DEPT)))))))))))))))))
(assert (= q2 ((_ rel.project 6) (set.filter p13 (rel.product (set.map f11 (set.filter p10 (rel.product (set.map f8 EMP) (set.map f9 DEPT)))) (set.map f12 EMP))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10414 ms.
(reset)
;-----------------------------------------------------------
; test name: testMergeFilter
;Translating sql query: SELECT t.NAME FROM (SELECT * FROM DEPT AS DEPT WHERE DEPT.DEPTNO = 10) AS t WHERE t.DEPTNO = 11
;Translating sql query: SELECT DEPT0.NAME FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO = 10
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 0) t)) (= (nullable.val ((_ tuple.select 0) t)) 10)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 0) t)) (= (nullable.val ((_ tuple.select 0) t)) 11)))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 0) t)) (= (nullable.val ((_ tuple.select 0) t)) 10)))))
(assert (= q1 ((_ rel.project 1) (set.filter p1 ((_ rel.project 0 1) (set.filter p0 DEPT))))))
(assert (= q2 ((_ rel.project 1) (set.filter p2 DEPT))))
(check-sat)
;answer: sat
; duration: 213 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 10) (nullable.some "D"))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable String))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some "D")))
; insert into DEPT values(10,'D')
; SELECT t.NAME FROM (SELECT * FROM DEPT AS DEPT WHERE DEPT.DEPTNO = 10) AS t WHERE t.DEPTNO = 11 EXCEPT ALL SELECT DEPT0.NAME FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO = 10

; SELECT DEPT0.NAME FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO = 10 EXCEPT ALL SELECT t.NAME FROM (SELECT * FROM DEPT AS DEPT WHERE DEPT.DEPTNO = 10) AS t WHERE t.DEPTNO = 11
;(D)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testPushProjectPastSetOp
;Translating sql query: SELECT t.SAL FROM (SELECT * FROM EMP AS EMP UNION ALL SELECT * FROM EMP AS EMP0) AS t
;Translating sql query: SELECT EMP1.SAL FROM EMP AS EMP1 UNION SELECT EMP2.SAL FROM EMP AS EMP2
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= q1 ((_ rel.project 6) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP) ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP)))))
(assert (= q2 (set.union ((_ rel.project 6) EMP) ((_ rel.project 6) EMP))))
(check-sat)
;answer: unsat
; duration: 24 ms.
(reset)
;-----------------------------------------------------------
; test name: testMergeMinusRightDeep
;Translating sql query: SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 EXCEPT SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20 EXCEPT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS t2
;Translating sql query: SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 EXCEPT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS t7
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

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
(assert (= q1 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))))
(assert (= q2 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))))
(check-sat)
;answer: unsat
; duration: 490 ms.
(reset)
;-----------------------------------------------------------
; test name: testEmptyJoin
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE FALSE) AS t INNER JOIN DEPT AS DEPT ON t.DEPTNO = DEPT.DEPTNO
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0,0,''))) AS t0
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) false)))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) DEPT)))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.singleton (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some ""))))))
(check-sat)
;answer: sat
; duration: 70 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (as set.empty (Set (Tuple (Nullable Int) (Nullable String)))))
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some "")))
; SELECT * FROM (SELECT * FROM EMP AS EMP WHERE FALSE) AS t INNER JOIN DEPT AS DEPT ON t.DEPTNO = DEPT.DEPTNO EXCEPT ALL SELECT * FROM (SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0,0,''))) AS t0

; SELECT * FROM (SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0,0,''))) AS t0 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP WHERE FALSE) AS t INNER JOIN DEPT AS DEPT ON t.DEPTNO = DEPT.DEPTNO
;(0,,,0,0,0,0,0,0,0,)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testReduceConstantsIsNull
;Translating sql query: SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND EMP.EMPNO IS NULL
;Translating sql query: SELECT t1.EXPR$0 FROM (SELECT * FROM (VALUES(0))) AS t1
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (and (= (nullable.val ((_ tuple.select 0) t)) 10) (nullable.is_null ((_ tuple.select 0) t)))))))
(assert (= q1 ((_ rel.project 0) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0) (set.singleton (tuple (nullable.some 0))))))
(check-sat)
;answer: sat
; duration: 17 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 0)))
; SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND EMP.EMPNO IS NULL EXCEPT ALL SELECT t1.column1 FROM (SELECT * FROM (VALUES(0))) AS t1

; SELECT t1.column1 FROM (SELECT * FROM (VALUES(0))) AS t1 EXCEPT ALL SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND EMP.EMPNO IS NULL
;(0)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testTransitiveInferenceJoin
;Translating sql query: SELECT 1 FROM EMP AS EMP INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 7) AS t ON EMP.DEPTNO = t.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 7) AS t2 ON t1.DEPTNO = t2.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

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
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (>= (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (>= (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 16) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 16) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f2 (set.filter p1 (rel.product EMP ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)))))))
(assert (= q2 (set.map f6 (set.filter p5 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)))))))
(check-sat)
;answer: sat
; duration: 592 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some (- 16)) (nullable.some "I") (nullable.some "J") (nullable.some 17) (nullable.some (- 17)) (nullable.some 18) (nullable.some (- 18)) (nullable.some 7) (nullable.some 19))) (set.union (set.singleton (tuple (nullable.some (- 13)) (nullable.some "G") (nullable.some "H") (nullable.some 14) (nullable.some (- 14)) (nullable.some 15) (nullable.some (- 15)) (nullable.some 7) (nullable.some 16))) (set.union (set.singleton (tuple (nullable.some (- 10)) (nullable.some "E") (nullable.some "F") (nullable.some 11) (nullable.some (- 11)) (nullable.some 12) (nullable.some (- 12)) (nullable.some 7) (nullable.some 13))) (set.singleton (tuple (nullable.some (- 7)) (nullable.some "C") (nullable.some "D") (nullable.some 8) (nullable.some (- 8)) (nullable.some 9) (nullable.some (- 9)) (nullable.some 7) (nullable.some 10)))))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 1)))
; insert into EMP values(-16,'I','J',17,-17,18,-18,7,19),(-13,'G','H',14,-14,15,-15,7,16),(-10,'E','F',11,-11,12,-12,7,13),(-7,'C','D',8,-8,9,-9,7,10)
; SELECT 1 FROM EMP AS EMP INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 7) AS t ON EMP.DEPTNO = t.DEPTNO EXCEPT ALL SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 7) AS t2 ON t1.DEPTNO = t2.DEPTNO

; SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 7) AS t2 ON t1.DEPTNO = t2.DEPTNO EXCEPT ALL SELECT 1 FROM EMP AS EMP INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 7) AS t ON EMP.DEPTNO = t.DEPTNO
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testFullOuterJoinSimplificationToRightOuter
;Translating sql query: SELECT 1 FROM DEPT AS DEPT FULL JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE EMP.SAL >= 100
;Translating sql query: SELECT 1 FROM DEPT AS DEPT0 RIGHT JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL > 100) AS t1 ON DEPT0.DEPTNO = t1.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const rightJoin7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const f8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const leftJoin1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const rightJoin2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 8) t)) (>= (nullable.val ((_ tuple.select 8) t)) 100)))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 6) t)) (> (nullable.val ((_ tuple.select 6) t)) 100)))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= rightJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f4 (set.filter p3 (set.union (set.union (set.map leftJoin1 (set.minus DEPT ((_ rel.project 0 1) (set.filter p0 (rel.product DEPT EMP))))) (set.map rightJoin2 (set.minus EMP ((_ rel.project 2 3 4 5 6 7 8 9 10) (set.filter p0 (rel.product DEPT EMP)))))) (set.filter p0 (rel.product DEPT EMP)))))))
(assert (= q2 (set.map f8 (set.union (set.map rightJoin7 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)) ((_ rel.project 2 3 4 5 6 7 8 9 10) (set.filter p6 (rel.product DEPT ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP))))))) (set.filter p6 (rel.product DEPT ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP))))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10053 ms.
(reset)
;-----------------------------------------------------------
; test name: testReduceConstantsNegated
;Translating sql query: SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND NOT EMP.EMPNO = 11
;Translating sql query: SELECT t1.EXPR$0 FROM (SELECT * FROM (VALUES(0)) WHERE FALSE) AS t1
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 0) t)) (and (= (nullable.val ((_ tuple.select 0) t)) 10) (not (= (nullable.val ((_ tuple.select 0) t)) 11)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int)))) false)))
(assert (= q1 ((_ rel.project 0) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0) (set.filter p1 (set.singleton (tuple (nullable.some 0)))))))
(check-sat)
;answer: sat
; duration: 241 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 10) (as nullable.null (Nullable String)) (nullable.some "") (as nullable.null (Nullable Int)) (nullable.some 0) (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 10)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; insert into EMP values(10,NULL,'',NULL,0,1,-1,2,-2)
; SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND NOT EMP.EMPNO = 11 EXCEPT ALL SELECT t1.column1 FROM (SELECT * FROM (VALUES(0)) WHERE FALSE) AS t1
;(10)

; SELECT t1.column1 FROM (SELECT * FROM (VALUES(0)) WHERE FALSE) AS t1 EXCEPT ALL SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND NOT EMP.EMPNO = 11

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testReduceNullableCase
;Translating sql query: SELECT CASE WHEN 1 = 2 THEN CAST(t0.EXPR$0 AS INTEGER) ELSE 2 END FROM (VALUES  (1),(2)) AS t LEFT JOIN (VALUES  (1)) AS t0 ON TRUE
;Translating sql query: SELECT CAST(2 AS INTEGER) FROM (VALUES  (1)) AS t2 LEFT JOIN (VALUES  (0)) AS t3 ON TRUE
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const leftJoin0 (-> (Tuple (Nullable Int)) (Tuple (Nullable Int) (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const leftJoin2 (-> (Tuple (Nullable Int)) (Tuple (Nullable Int) (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= leftJoin0 (lambda ((t (Tuple (Nullable Int)))) (tuple ((_ tuple.select 0) t) (as nullable.null (Nullable Int))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2)))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int)))) (tuple ((_ tuple.select 0) t) (as nullable.null (Nullable Int))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2)))))
(assert (= q1 (set.map f1 (set.union (set.map leftJoin0 (set.minus (set.union (set.singleton (tuple (nullable.some 1))) (set.singleton (tuple (nullable.some 2)))) ((_ rel.project 0) (rel.product (set.union (set.singleton (tuple (nullable.some 1))) (set.singleton (tuple (nullable.some 2)))) (set.singleton (tuple (nullable.some 1))))))) (rel.product (set.union (set.singleton (tuple (nullable.some 1))) (set.singleton (tuple (nullable.some 2)))) (set.singleton (tuple (nullable.some 1))))))))
(assert (= q2 (set.map f3 (set.union (set.map leftJoin2 (set.minus (set.singleton (tuple (nullable.some 1))) ((_ rel.project 0) (rel.product (set.singleton (tuple (nullable.some 1))) (set.singleton (tuple (nullable.some 0))))))) (rel.product (set.singleton (tuple (nullable.some 1))) (set.singleton (tuple (nullable.some 0))))))))
(check-sat)
;answer: unsat
; duration: 8 ms.
(reset)
;-----------------------------------------------------------
; test name: testTransitiveInferenceConstantEquiPredicate
;Translating sql query: SELECT 1 FROM EMP AS EMP INNER JOIN EMP AS EMP0 ON EMP.DEPTNO = EMP0.DEPTNO
;Translating sql query: SELECT 1 FROM EMP AS EMP1 INNER JOIN EMP AS EMP2 ON EMP1.DEPTNO <> EMP2.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 16) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 16) t)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 16) t)) (distinct (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 16) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f1 (set.filter p0 (rel.product EMP EMP)))))
(assert (= q2 (set.map f3 (set.filter p2 (rel.product EMP EMP)))))
(check-sat)
;answer: sat
; duration: 428 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some 17) (nullable.some "I") (nullable.some "J") (nullable.some (- 17)) (nullable.some 18) (nullable.some (- 18)) (nullable.some 19) (nullable.some 0) (nullable.some (- 19)))) (set.union (set.singleton (tuple (nullable.some 14) (nullable.some "G") (nullable.some "H") (nullable.some (- 14)) (nullable.some 15) (nullable.some (- 15)) (nullable.some 16) (nullable.some 0) (nullable.some (- 16)))) (set.union (set.singleton (tuple (nullable.some 35) (nullable.some "U") (nullable.some "V") (nullable.some (- 35)) (nullable.some 36) (nullable.some (- 36)) (nullable.some 37) (nullable.some 0) (nullable.some (- 37)))) (set.singleton (tuple (nullable.some 32) (nullable.some "S") (nullable.some "T") (nullable.some (- 32)) (nullable.some 33) (nullable.some (- 33)) (nullable.some 34) (nullable.some 0) (nullable.some (- 34))))))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 1)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; insert into EMP values(17,'I','J',-17,18,-18,19,0,-19),(14,'G','H',-14,15,-15,16,0,-16),(35,'U','V',-35,36,-36,37,0,-37),(32,'S','T',-32,33,-33,34,0,-34)
; SELECT 1 FROM EMP AS EMP INNER JOIN EMP AS EMP0 ON EMP.DEPTNO = EMP0.DEPTNO EXCEPT ALL SELECT 1 FROM EMP AS EMP1 INNER JOIN EMP AS EMP2 ON EMP1.DEPTNO <> EMP2.DEPTNO
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)

; SELECT 1 FROM EMP AS EMP1 INNER JOIN EMP AS EMP2 ON EMP1.DEPTNO <> EMP2.DEPTNO EXCEPT ALL SELECT 1 FROM EMP AS EMP INNER JOIN EMP AS EMP0 ON EMP.DEPTNO = EMP0.DEPTNO

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testReduceValuesToEmpty
;Translating sql query: SELECT t.EXPR$0 + t.EXPR$1 AS X, t.EXPR$1 AS B, t.EXPR$0 AS A FROM (VALUES  (10, 1),  (30, 7)) AS t WHERE t.EXPR$0 - t.EXPR$1 < t.EXPR$0
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES(0,0,0)) WHERE FALSE) AS t2
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 1) t)) (nullable.is_some ((_ tuple.select 0) t)) (< (- (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 1) t))) (nullable.val ((_ tuple.select 0) t)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_622234 Int) (BOUND_VARIABLE_622235 Int)) (+ BOUND_VARIABLE_622234 BOUND_VARIABLE_622235)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable Int)))) false)))
(assert (= q1 (set.map f1 (set.filter p0 (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 30) (nullable.some 7))))))))
(assert (= q2 ((_ rel.project 0 1 2) (set.filter p2 (set.singleton (tuple (nullable.some 0) (nullable.some 0) (nullable.some 0)))))))
(check-sat)
;answer: sat
; duration: 71 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (set.union (set.singleton (tuple (nullable.some 11) (nullable.some 1) (nullable.some 10))) (set.singleton (tuple (nullable.some 37) (nullable.some 7) (nullable.some 30))))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
; SELECT t.column1 + t.column2 AS X, t.column2 AS B, t.column1 AS A FROM (VALUES  (10, 1),  (30, 7)) AS t WHERE t.column1 - t.column2 < t.column1 EXCEPT ALL SELECT * FROM (SELECT * FROM (VALUES(0,0,0)) WHERE FALSE) AS t2
;(37,7,30)
;(11,1,10)

; SELECT * FROM (SELECT * FROM (VALUES(0,0,0)) WHERE FALSE) AS t2 EXCEPT ALL SELECT t.column1 + t.column2 AS X, t.column2 AS B, t.column1 AS A FROM (VALUES  (10, 1),  (30, 7)) AS t WHERE t.column1 - t.column2 < t.column1

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testPushProjectPastFilter
;Translating sql query: SELECT EMP.EMPNO + EMP.DEPTNO FROM EMP AS EMP WHERE EMP.SAL = 10 * EMP.COMM AND UPPER(EMP.ENAME) = 'FO0'
;Translating sql query: SELECT t1.EMPNO + t1.DEPTNO FROM (SELECT EMP0.EMPNO, EMP0.ENAME, EMP0.SAL, EMP0.COMM, EMP0.DEPTNO FROM EMP AS EMP0) AS t1 WHERE t1.SAL = 10 * t1.COMM AND UPPER(t1.ENAME) = 'FOO'
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 6) t)) (nullable.is_some ((_ tuple.select 5) t)) (nullable.is_some ((_ tuple.select 1) t)) (and (= (nullable.val ((_ tuple.select 6) t)) (* 10 (nullable.val ((_ tuple.select 5) t)))) (= (str.to_upper (nullable.val ((_ tuple.select 1) t))) "FO0"))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_622408 Int) (BOUND_VARIABLE_622409 Int)) (+ BOUND_VARIABLE_622408 BOUND_VARIABLE_622409)) ((_ tuple.select 0) t) ((_ tuple.select 7) t))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 2) t)) (nullable.is_some ((_ tuple.select 3) t)) (nullable.is_some ((_ tuple.select 1) t)) (and (= (nullable.val ((_ tuple.select 2) t)) (* 10 (nullable.val ((_ tuple.select 3) t)))) (= (str.to_upper (nullable.val ((_ tuple.select 1) t))) "FOO"))))))
(assert (not (= q1 q2)))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_622478 Int) (BOUND_VARIABLE_622479 Int)) (+ BOUND_VARIABLE_622478 BOUND_VARIABLE_622479)) ((_ tuple.select 0) t) ((_ tuple.select 4) t))))))
(assert (= q1 (set.map f1 (set.filter p0 EMP))))
(assert (= q2 (set.map f3 (set.filter p2 ((_ rel.project 0 1 6 5 7) EMP)))))
(check-sat)
;answer: sat
; duration: 667 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (as nullable.null (Nullable Int)) (nullable.some "fo0") (nullable.some "B") (nullable.some (- 5)) (nullable.some 6) (nullable.some 0) (nullable.some 0) (as nullable.null (Nullable Int)) (nullable.some (- 6)))) (set.singleton (tuple (as nullable.null (Nullable Int)) (nullable.some "fo0") (nullable.some "A") (nullable.some (- 3)) (nullable.some 4) (nullable.some 0) (nullable.some 0) (as nullable.null (Nullable Int)) (nullable.some 5)))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (as nullable.null (Nullable Int))))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; insert into EMP values(NULL,'fo0','B',-5,6,0,0,NULL,-6),(NULL,'fo0','A',-3,4,0,0,NULL,5)
; SELECT EMP.EMPNO + EMP.DEPTNO FROM EMP AS EMP WHERE EMP.SAL = 10 * EMP.COMM AND UPPER(EMP.ENAME) = 'FO0' EXCEPT ALL SELECT t1.EMPNO + t1.DEPTNO FROM (SELECT EMP0.EMPNO, EMP0.ENAME, EMP0.SAL, EMP0.COMM, EMP0.DEPTNO FROM EMP AS EMP0) AS t1 WHERE t1.SAL = 10 * t1.COMM AND UPPER(t1.ENAME) = 'FOO'
;(NULL)
;(NULL)

; SELECT t1.EMPNO + t1.DEPTNO FROM (SELECT EMP0.EMPNO, EMP0.ENAME, EMP0.SAL, EMP0.COMM, EMP0.DEPTNO FROM EMP AS EMP0) AS t1 WHERE t1.SAL = 10 * t1.COMM AND UPPER(t1.ENAME) = 'FOO' EXCEPT ALL SELECT EMP.EMPNO + EMP.DEPTNO FROM EMP AS EMP WHERE EMP.SAL = 10 * EMP.COMM AND UPPER(EMP.ENAME) = 'FO0'

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testPushFilterThroughSemiJoin
;Translating sql query: SELECT * FROM DEPT AS DEPT INNER JOIN (SELECT EMP.DEPTNO FROM EMP AS EMP) AS t ON DEPT.DEPTNO = t.DEPTNO WHERE DEPT.DEPTNO <= 10
;Translating sql query: SELECT * FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO < 10) AS t1 INNER JOIN (SELECT EMP0.DEPTNO FROM EMP AS EMP0) AS t2 ON t1.DEPTNO = t2.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 2) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 2) t)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (<= (nullable.val ((_ tuple.select 0) t)) 10)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 0) t)) (< (nullable.val ((_ tuple.select 0) t)) 10)))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 2) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 2) t)))))))
(assert (= q1 ((_ rel.project 0 1 2) (set.filter p1 (set.filter p0 (rel.product DEPT ((_ rel.project 7) EMP)))))))
(assert (= q2 ((_ rel.project 0 1 2) (set.filter p3 (rel.product ((_ rel.project 0 1) (set.filter p2 DEPT)) ((_ rel.project 7) EMP))))))
(check-sat)
;answer: sat
; duration: 145 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 10) (nullable.some "E"))))
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some (- 1)) (nullable.some "C") (nullable.some "D") (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some (- 3)) (nullable.some 10) (nullable.some 4))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 10) (nullable.some "E") (nullable.some 10)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
; insert into DEPT values(10,'E')
; insert into EMP values(-1,'C','D',2,-2,3,-3,10,4)
; SELECT * FROM DEPT AS DEPT INNER JOIN (SELECT EMP.DEPTNO FROM EMP AS EMP) AS t ON DEPT.DEPTNO = t.DEPTNO WHERE DEPT.DEPTNO <= 10 EXCEPT ALL SELECT * FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO < 10) AS t1 INNER JOIN (SELECT EMP0.DEPTNO FROM EMP AS EMP0) AS t2 ON t1.DEPTNO = t2.DEPTNO
;(10,E,10)

; SELECT * FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO < 10) AS t1 INNER JOIN (SELECT EMP0.DEPTNO FROM EMP AS EMP0) AS t2 ON t1.DEPTNO = t2.DEPTNO EXCEPT ALL SELECT * FROM DEPT AS DEPT INNER JOIN (SELECT EMP.DEPTNO FROM EMP AS EMP) AS t ON DEPT.DEPTNO = t.DEPTNO WHERE DEPT.DEPTNO <= 10

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testTransitiveInferenceUnion3way
;Translating sql query: SELECT 1 FROM (SELECT * FROM (SELECT EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO > 7 UNION ALL SELECT EMP0.DEPTNO FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 10) AS t3 UNION ALL SELECT EMP1.DEPTNO FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 1) AS t6 INNER JOIN EMP AS EMP2 ON t6.DEPTNO = EMP2.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT * FROM (SELECT EMP3.DEPTNO FROM EMP AS EMP3 WHERE EMP3.DEPTNO >= 7 UNION ALL SELECT EMP4.DEPTNO FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 10) AS t12 UNION ALL SELECT EMP5.DEPTNO FROM EMP AS EMP5 WHERE EMP5.DEPTNO > 1) AS t15 INNER JOIN (SELECT * FROM EMP AS EMP6 WHERE EMP6.DEPTNO > 7 OR EMP6.DEPTNO > 10 OR EMP6.DEPTNO > 1) AS t16 ON t15.DEPTNO = t16.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f10 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p9 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (> (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (> (nullable.val ((_ tuple.select 7) t)) 10)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (> (nullable.val ((_ tuple.select 7) t)) 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 8) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 8) t)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (>= (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (> (nullable.val ((_ tuple.select 7) t)) 10)))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (> (nullable.val ((_ tuple.select 7) t)) 1)))))
(assert (= p8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 7) t)) (or (> (nullable.val ((_ tuple.select 7) t)) 7) (> (nullable.val ((_ tuple.select 7) t)) 10) (> (nullable.val ((_ tuple.select 7) t)) 1))))))
(assert (not (= q1 q2)))
(assert (= p9 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 8) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 8) t)))))))
(assert (= f10 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f4 (set.filter p3 (rel.product (set.union ((_ rel.project 0) (set.union ((_ rel.project 7) (set.filter p0 EMP)) ((_ rel.project 7) (set.filter p1 EMP)))) ((_ rel.project 7) (set.filter p2 EMP))) EMP)))))
(assert (= q2 (set.map f10 (set.filter p9 (rel.product (set.union ((_ rel.project 0) (set.union ((_ rel.project 7) (set.filter p5 EMP)) ((_ rel.project 7) (set.filter p6 EMP)))) ((_ rel.project 7) (set.filter p7 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p8 EMP)))))))
(check-sat)
;answer: unsat
; duration: 4388 ms.
(reset)
;-----------------------------------------------------------
; test name: testEmptyJoinRight
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE TRUE) AS t RIGHT JOIN DEPT AS DEPT ON t.DEPTNO = DEPT.DEPTNO
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0)) WHERE FALSE) AS t0 RIGHT JOIN DEPT AS DEPT0 ON t0.EXPR$7 = DEPT0.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const rightJoin1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const rightJoin5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= rightJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) false)))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (not (= q1 q2)))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 11) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 11) t)))))))
(assert (= rightJoin5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map rightJoin1 (set.minus DEPT ((_ rel.project 9 10) (set.filter p0 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP) DEPT))))) (set.filter p0 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP) DEPT))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map rightJoin5 (set.minus (set.map f3 DEPT) ((_ rel.project 9 10 11) (set.filter p4 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 (set.singleton (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0))))) (set.map f3 DEPT)))))) (set.filter p4 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 (set.singleton (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0))))) (set.map f3 DEPT)))))))
(check-sat)
;answer: sat
; duration: 334 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 0) (nullable.some ""))))
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 1) (nullable.some "A") (nullable.some "B") (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some 0) (nullable.some (- 3)))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 1) (nullable.some "A") (nullable.some "B") (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some 0) (nullable.some (- 3)) (nullable.some 0) (nullable.some "")))
; q2
(get-value (q2))
; (set.singleton (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (nullable.some 0) (nullable.some "")))
; insert into DEPT values(0,'')
; insert into EMP values(1,'A','B',-1,2,-2,3,0,-3)
; SELECT * FROM (SELECT * FROM EMP AS EMP WHERE TRUE) AS t RIGHT JOIN DEPT AS DEPT ON t.DEPTNO = DEPT.DEPTNO EXCEPT ALL SELECT * FROM (SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0)) WHERE FALSE) AS t0 RIGHT JOIN DEPT AS DEPT0 ON t0.column8 = DEPT0.DEPTNO
;(1,A,B,-1,2,-2,3,0,-3,0,)

; SELECT * FROM (SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0)) WHERE FALSE) AS t0 RIGHT JOIN DEPT AS DEPT0 ON t0.column8 = DEPT0.DEPTNO EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP WHERE TRUE) AS t RIGHT JOIN DEPT AS DEPT ON t.DEPTNO = DEPT.DEPTNO
;(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testTransitiveInferenceLeftOuterJoin
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7) AS t LEFT JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO WHERE EMP0.DEPTNO >= 9
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t2 LEFT JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t3 ON t2.DEPTNO = t3.DEPTNO WHERE t3.DEPTNO > 9
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f10 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p9 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const leftJoin2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const leftJoin8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (> (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 16) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 16) t)))))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 16) t)) (>= (nullable.val ((_ tuple.select 16) t)) 9)))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (> (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (> (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 16) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 16) t)))))))
(assert (= leftJoin8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (not (= q1 q2)))
(assert (= p9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 16) t)) (> (nullable.val ((_ tuple.select 16) t)) 9)))))
(assert (= f10 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f4 (set.filter p3 (set.union (set.map leftJoin2 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) EMP))))) (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) EMP)))))))
(assert (= q2 (set.map f10 (set.filter p9 (set.union (set.map leftJoin8 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p7 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 EMP))))))) (set.filter p7 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 EMP)))))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10085 ms.
(reset)
;-----------------------------------------------------------
; test name: testReduceConstants2
;Translating sql query: SELECT CAST(CASE WHEN NULL IS NULL THEN 2 IS NULL WHEN 2 IS NULL THEN NULL IS NULL ELSE NULL = 2 END AS BOOLEAN) FROM (VALUES  (0),(0)) AS t
;Translating sql query: SELECT FALSE FROM (VALUES  (0)) AS t2
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const q1 (Set (Tuple (Nullable Bool))))
(declare-const q2 (Set (Tuple (Nullable Bool))))
(declare-const f0 (-> (Tuple (Nullable Int)) (Tuple (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable Int)) (Tuple (Nullable Bool))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int)))) (tuple (nullable.some false)))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int)))) (tuple (nullable.some false)))))
(assert (= q1 (set.map f0 (set.union (set.singleton (tuple (nullable.some 0))) (set.singleton (tuple (nullable.some 0)))))))
(assert (= q2 (set.map f1 (set.singleton (tuple (nullable.some 0))))))
(check-sat)
;answer: unsat
; duration: 468 ms.
(reset)
;-----------------------------------------------------------
; test name: testPushJoinThroughUnionOnRight
;Translating sql query: SELECT EMP.SAL FROM EMP AS EMP, (SELECT * FROM EMP AS EMP0 UNION ALL SELECT * FROM EMP AS EMP1) AS t
;Translating sql query: SELECT t1.EMPNO FROM (SELECT * FROM EMP AS EMP2, EMP AS EMP3 UNION ALL SELECT * FROM EMP AS EMP4, EMP AS EMP5) AS t1
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= q1 ((_ rel.project 6) (rel.product EMP (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP) ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP))))))
(assert (= q2 ((_ rel.project 0) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) (rel.product EMP EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) (rel.product EMP EMP))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10349 ms.
(reset)
;-----------------------------------------------------------
; test name: testFullOuterJoinSimplificationToInner
;Translating sql query: SELECT 1 FROM DEPT AS DEPT FULL JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charli' AND EMP.SAL > 100
;Translating sql query: SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL > 100) AS t2 ON t1.DEPTNO = t2.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const f8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const leftJoin1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const rightJoin2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 1) t)) (nullable.is_some ((_ tuple.select 8) t)) (and (= (nullable.val ((_ tuple.select 1) t)) "Charli") (> (nullable.val ((_ tuple.select 8) t)) 100))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 1) t)) (= (nullable.val ((_ tuple.select 1) t)) "Charlie")))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 6) t)) (> (nullable.val ((_ tuple.select 6) t)) 100)))))
(assert (not (= q1 q2)))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f4 (set.filter p3 (set.union (set.union (set.map leftJoin1 (set.minus DEPT ((_ rel.project 0 1) (set.filter p0 (rel.product DEPT EMP))))) (set.map rightJoin2 (set.minus EMP ((_ rel.project 2 3 4 5 6 7 8 9 10) (set.filter p0 (rel.product DEPT EMP)))))) (set.filter p0 (rel.product DEPT EMP)))))))
(assert (= q2 (set.map f8 (set.filter p7 (rel.product ((_ rel.project 0 1) (set.filter p5 DEPT)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 EMP)))))))
(check-sat)
;answer: sat
; duration: 10364 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.union (set.singleton (tuple (nullable.some 0) (as nullable.null (Nullable String)))) (set.singleton (tuple (nullable.some 0) (nullable.some "Charlie")))))
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some (- 22)) (nullable.some "Q") (nullable.some "R") (nullable.some 23) (nullable.some (- 23)) (nullable.some 24) (as nullable.null (Nullable Int)) (nullable.some 0) (nullable.some (- 24)))) (set.union (set.singleton (tuple (nullable.some 20) (nullable.some "O") (nullable.some "P") (nullable.some (- 20)) (nullable.some 21) (nullable.some (- 21)) (as nullable.null (Nullable Int)) (nullable.some 0) (nullable.some 22))) (set.union (set.singleton (tuple (nullable.some (- 17)) (nullable.some "M") (nullable.some "N") (nullable.some 18) (nullable.some (- 18)) (nullable.some 19) (as nullable.null (Nullable Int)) (nullable.some 0) (nullable.some (- 19)))) (set.union (set.singleton (tuple (nullable.some 15) (nullable.some "K") (nullable.some "L") (nullable.some (- 15)) (nullable.some 16) (nullable.some (- 16)) (as nullable.null (Nullable Int)) (nullable.some 0) (nullable.some 17))) (set.union (set.singleton (tuple (nullable.some (- 12)) (nullable.some "I") (nullable.some "J") (nullable.some 13) (nullable.some (- 13)) (nullable.some 14) (as nullable.null (Nullable Int)) (nullable.some 0) (nullable.some (- 14)))) (set.union (set.singleton (tuple (nullable.some 10) (nullable.some "G") (nullable.some "H") (nullable.some (- 10)) (nullable.some 11) (nullable.some (- 11)) (nullable.some 101) (nullable.some 0) (nullable.some 12))) (set.singleton (tuple (nullable.some (- 7)) (nullable.some "E") (nullable.some "F") (nullable.some 8) (nullable.some (- 8)) (nullable.some 9) (nullable.some 101) (nullable.some 0) (nullable.some (- 9)))))))))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 1)))
; insert into DEPT values(0,NULL),(0,'Charlie')
; insert into EMP values(-22,'Q','R',23,-23,24,NULL,0,-24),(20,'O','P',-20,21,-21,NULL,0,22),(-17,'M','N',18,-18,19,NULL,0,-19),(15,'K','L',-15,16,-16,NULL,0,17),(-12,'I','J',13,-13,14,NULL,0,-14),(10,'G','H',-10,11,-11,101,0,12),(-7,'E','F',8,-8,9,101,0,-9)
; SELECT 1 FROM DEPT AS DEPT FULL JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charli' AND EMP.SAL > 100 EXCEPT ALL SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL > 100) AS t2 ON t1.DEPTNO = t2.DEPTNO

; SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL > 100) AS t2 ON t1.DEPTNO = t2.DEPTNO EXCEPT ALL SELECT 1 FROM DEPT AS DEPT FULL JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charli' AND EMP.SAL > 100
;(1)
;(1)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testReduceOrCaseWhen
;Translating sql query: SELECT EMP.SAL FROM EMP AS EMP WHERE CASE WHEN EMP.SAL = 1000 THEN NULL ELSE 1 END IS NULL OR CASE WHEN EMP.SAL = 2000 THEN NULL ELSE 1 END IS NULL
;Translating sql query: SELECT EMP0.SAL FROM EMP AS EMP0 WHERE EMP0.SAL = 100 OR EMP0.SAL = 2000
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 6) t)) (nullable.is_some ((_ tuple.select 6) t)) (or (nullable.is_null (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1076117 Int) (BOUND_VARIABLE_1076118 Int)) (= BOUND_VARIABLE_1076117 BOUND_VARIABLE_1076118)) ((_ tuple.select 6) t) (nullable.some 1000))) (as nullable.null (Nullable Int)) (nullable.some 1))) (nullable.is_null (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1076131 Int) (BOUND_VARIABLE_1076132 Int)) (= BOUND_VARIABLE_1076131 BOUND_VARIABLE_1076132)) ((_ tuple.select 6) t) (nullable.some 2000))) (as nullable.null (Nullable Int)) (nullable.some 1))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 6) t)) (nullable.is_some ((_ tuple.select 6) t)) (or (= (nullable.val ((_ tuple.select 6) t)) 100) (= (nullable.val ((_ tuple.select 6) t)) 2000))))))
(assert (= q1 ((_ rel.project 6) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 6) (set.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 334 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 7) (nullable.some "C") (nullable.some "D") (nullable.some (- 7)) (nullable.some 8) (nullable.some (- 8)) (nullable.some 100) (nullable.some 9) (nullable.some (- 9)))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 100)))
; insert into EMP values(7,'C','D',-7,8,-8,100,9,-9)
; SELECT EMP.SAL FROM EMP AS EMP WHERE CASE WHEN EMP.SAL = 1000 THEN NULL ELSE 1 END IS NULL OR CASE WHEN EMP.SAL = 2000 THEN NULL ELSE 1 END IS NULL EXCEPT ALL SELECT EMP0.SAL FROM EMP AS EMP0 WHERE EMP0.SAL = 100 OR EMP0.SAL = 2000

; SELECT EMP0.SAL FROM EMP AS EMP0 WHERE EMP0.SAL = 100 OR EMP0.SAL = 2000 EXCEPT ALL SELECT EMP.SAL FROM EMP AS EMP WHERE CASE WHEN EMP.SAL = 1000 THEN NULL ELSE 1 END IS NULL OR CASE WHEN EMP.SAL = 2000 THEN NULL ELSE 1 END IS NULL
;(100)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testMergeUnionAll
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION ALL SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION ALL SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
;Translating sql query: SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 20 UNION ALL SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION ALL SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

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
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 20)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 20)))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 30)))))
(assert (= q1 (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))
(assert (= q2 (set.union (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))
(check-sat)
;answer: sat
; duration: 924 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some (- 55)) (nullable.some "a") (nullable.some "b") (nullable.some 56) (nullable.some (- 56)) (nullable.some 57) (nullable.some (- 57)) (nullable.some 10) (nullable.some 58))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some (- 55)) (nullable.some "a") (nullable.some "b") (nullable.some 56) (nullable.some (- 56)) (nullable.some 57) (nullable.some (- 57)) (nullable.some 10) (nullable.some 58)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; insert into EMP values(-55,'a','b',56,-56,57,-57,10,58)
; SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION ALL SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION ALL SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30 EXCEPT ALL SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 20 UNION ALL SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION ALL SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
;(-55,a,b,56,-56,57,-57,10,58)

; SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 20 UNION ALL SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION ALL SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION ALL SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION ALL SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testLeftOuterJoinSimplificationToInner
;Translating sql query: SELECT 1 FROM DEPT AS DEPT LEFT JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE EMP.SAL > 1000
;Translating sql query: SELECT 1 FROM DEPT AS DEPT0 INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL > 100) AS t1 ON DEPT0.DEPTNO = t1.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const leftJoin1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 8) t)) (> (nullable.val ((_ tuple.select 8) t)) 1000)))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 6) t)) (> (nullable.val ((_ tuple.select 6) t)) 100)))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f3 (set.filter p2 (set.union (set.map leftJoin1 (set.minus DEPT ((_ rel.project 0 1) (set.filter p0 (rel.product DEPT EMP))))) (set.filter p0 (rel.product DEPT EMP)))))))
(assert (= q2 (set.map f6 (set.filter p5 (rel.product DEPT ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)))))))
(check-sat)
;answer: sat
; duration: 496 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.union (set.singleton (tuple (nullable.some 0) (nullable.some "J"))) (set.singleton (tuple (nullable.some 0) (nullable.some "I")))))
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some (- 11)) (nullable.some "K") (nullable.some "L") (nullable.some 12) (nullable.some (- 12)) (nullable.some 13) (as nullable.null (Nullable Int)) (nullable.some 0) (nullable.some (- 13)))) (set.union (set.singleton (tuple (nullable.some 14) (nullable.some "M") (nullable.some "N") (nullable.some (- 14)) (nullable.some 15) (nullable.some (- 15)) (as nullable.null (Nullable Int)) (nullable.some 0) (nullable.some 16))) (set.union (set.singleton (tuple (nullable.some 9) (nullable.some "G") (nullable.some "H") (nullable.some (- 9)) (nullable.some 10) (nullable.some (- 10)) (nullable.some 1000) (nullable.some 0) (nullable.some 11))) (set.singleton (tuple (nullable.some (- 6)) (nullable.some "E") (nullable.some "F") (nullable.some 7) (nullable.some (- 7)) (nullable.some 8) (nullable.some 1000) (nullable.some 0) (nullable.some (- 8))))))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 1)))
; insert into DEPT values(0,'J'),(0,'I')
; insert into EMP values(-11,'K','L',12,-12,13,NULL,0,-13),(14,'M','N',-14,15,-15,NULL,0,16),(9,'G','H',-9,10,-10,1000,0,11),(-6,'E','F',7,-7,8,1000,0,-8)
; SELECT 1 FROM DEPT AS DEPT LEFT JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE EMP.SAL > 1000 EXCEPT ALL SELECT 1 FROM DEPT AS DEPT0 INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL > 100) AS t1 ON DEPT0.DEPTNO = t1.DEPTNO

; SELECT 1 FROM DEPT AS DEPT0 INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL > 100) AS t1 ON DEPT0.DEPTNO = t1.DEPTNO EXCEPT ALL SELECT 1 FROM DEPT AS DEPT LEFT JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE EMP.SAL > 1000
;(1)
;(1)
;(1)
;(1)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testEmptyMinus2
;Translating sql query: SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES  (30, 3)) AS t EXCEPT SELECT * FROM (VALUES  (20, 2)) AS t0 WHERE t0.EXPR$0 > 30) AS t2 EXCEPT SELECT * FROM (VALUES  (40, 4)) AS t3) AS t4 EXCEPT SELECT * FROM (VALUES  (50, 5)) AS t5 WHERE t5.EXPR$0 > 50
;Translating sql query: SELECT * FROM (VALUES  (30, 4)) AS t8 EXCEPT SELECT * FROM (VALUES  (40, 40)) AS t9
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (> (nullable.val ((_ tuple.select 0) t)) 30)))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (> (nullable.val ((_ tuple.select 0) t)) 50)))))
(assert (= q1 (set.minus ((_ rel.project 0 1) (set.minus ((_ rel.project 0 1) (set.minus ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 30) (nullable.some 3)))) ((_ rel.project 0 1) (set.filter p0 (set.singleton (tuple (nullable.some 20) (nullable.some 2))))))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 40) (nullable.some 4)))))) ((_ rel.project 0 1) (set.filter p1 (set.singleton (tuple (nullable.some 50) (nullable.some 5))))))))
(assert (= q2 (set.minus ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 30) (nullable.some 4)))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 40) (nullable.some 40)))))))
(check-sat)
;answer: sat
; duration: 19 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 30) (nullable.some 3)))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 30) (nullable.some 4)))
; SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES  (30, 3)) AS t EXCEPT SELECT * FROM (VALUES  (20, 2)) AS t0 WHERE t0.column1 > 30) AS t2 EXCEPT SELECT * FROM (VALUES  (40, 4)) AS t3) AS t4 EXCEPT SELECT * FROM (VALUES  (50, 5)) AS t5 WHERE t5.column1 > 50 EXCEPT ALL SELECT * FROM (VALUES  (30, 4)) AS t8 EXCEPT SELECT * FROM (VALUES  (40, 40)) AS t9
;(30,3)

; SELECT * FROM (VALUES  (30, 4)) AS t8 EXCEPT SELECT * FROM (VALUES  (40, 40)) AS t9 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES  (30, 3)) AS t EXCEPT SELECT * FROM (VALUES  (20, 2)) AS t0 WHERE t0.column1 > 30) AS t2 EXCEPT SELECT * FROM (VALUES  (40, 4)) AS t3) AS t4 EXCEPT SELECT * FROM (VALUES  (50, 5)) AS t5 WHERE t5.column1 > 50
;(30,4)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testReduceConstants
;Translating sql query: SELECT 1 + 2, t0.DEPTNO + (3 + 3), 5 + 6 + t0.DEPTNO, CAST(NULL AS INT), CASE WHEN 2 IS NOT NULL THEN 2 ELSE NULL END, ROW(7 + 8) FROM (SELECT DEPT.DEPTNO, DEPT.NAME, t.EMPNO, t.ENAME, t.JOB, t.MGR, t.HIREDATE, t.SAL, t.COMM, t.DEPTNO AS DEPTNO0, t.SLACKER FROM DEPT AS DEPT INNER JOIN (SELECT EMP.EMPNO, EMP.ENAME, EMP.JOB, EMP.MGR, EMP.HIREDATE, EMP.SAL, EMP.COMM, EMP.DEPTNO, EMP.SLACKER, EMP.DEPTNO + (5 - 5) AS f9 FROM EMP AS EMP) AS t ON DEPT.DEPTNO = t.f9) AS t0 WHERE t0.DEPTNO = 7 + 8 AND t0.DEPTNO = 8 + 7 AND t0.DEPTNO = CASE WHEN 2 IS NOT NULL THEN 15 ELSE NULL END
;Translating sql query: SELECT 3, 22, 26, CAST(NULL AS INT), CAST(2 AS INTEGER), ROW(15) FROM (SELECT * FROM (VALUES(0,0,0,0,0,0)) WHERE FALSE) AS t3
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f6 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 6) t) ((_ tuple.select 5) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_1087571 Int) (BOUND_VARIABLE_1087572 Int)) (+ BOUND_VARIABLE_1087571 BOUND_VARIABLE_1087572)) ((_ tuple.select 7) t) (nullable.lift (lambda ((BOUND_VARIABLE_1087565 Int) (BOUND_VARIABLE_1087566 Int)) (- BOUND_VARIABLE_1087565 BOUND_VARIABLE_1087566)) (nullable.some 5) (nullable.some 5)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 2) t)) (nullable.is_some ((_ tuple.select 12) t)) (= (nullable.val ((_ tuple.select 2) t)) (nullable.val ((_ tuple.select 12) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1087676 Bool) (BOUND_VARIABLE_1087677 Bool) (BOUND_VARIABLE_1087678 Bool)) (and BOUND_VARIABLE_1087676 BOUND_VARIABLE_1087677 BOUND_VARIABLE_1087678)) (nullable.some (= (nullable.val ((_ tuple.select 0) t)) (+ 7 8))) (nullable.some (= (nullable.val ((_ tuple.select 0) t)) (+ 8 7))) (nullable.lift (lambda ((BOUND_VARIABLE_1087668 Int) (BOUND_VARIABLE_1087669 Int)) (= BOUND_VARIABLE_1087668 BOUND_VARIABLE_1087669)) (nullable.some (nullable.val ((_ tuple.select 0) t))) (ite (nullable.is_some (nullable.some 2)) (nullable.some 15) (as nullable.null (Nullable Int)))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1087676 Bool) (BOUND_VARIABLE_1087677 Bool) (BOUND_VARIABLE_1087678 Bool)) (and BOUND_VARIABLE_1087676 BOUND_VARIABLE_1087677 BOUND_VARIABLE_1087678)) (nullable.some (= (nullable.val ((_ tuple.select 0) t)) (+ 7 8))) (nullable.some (= (nullable.val ((_ tuple.select 0) t)) (+ 8 7))) (nullable.lift (lambda ((BOUND_VARIABLE_1087668 Int) (BOUND_VARIABLE_1087669 Int)) (= BOUND_VARIABLE_1087668 BOUND_VARIABLE_1087669)) (nullable.some (nullable.val ((_ tuple.select 0) t))) (ite (nullable.is_some (nullable.some 2)) (nullable.some 15) (as nullable.null (Nullable Int))))))))))
(assert (not (= q1 q2)))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_1087719 Int) (BOUND_VARIABLE_1087720 Int)) (+ BOUND_VARIABLE_1087719 BOUND_VARIABLE_1087720)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_1087734 Int) (BOUND_VARIABLE_1087735 Int)) (+ BOUND_VARIABLE_1087734 BOUND_VARIABLE_1087735)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_1087728 Int) (BOUND_VARIABLE_1087729 Int)) (+ BOUND_VARIABLE_1087728 BOUND_VARIABLE_1087729)) (nullable.some 3) (nullable.some 3))) (nullable.lift (lambda ((BOUND_VARIABLE_1087746 Int) (BOUND_VARIABLE_1087747 Int)) (+ BOUND_VARIABLE_1087746 BOUND_VARIABLE_1087747)) (nullable.lift (lambda ((BOUND_VARIABLE_1087740 Int) (BOUND_VARIABLE_1087741 Int)) (+ BOUND_VARIABLE_1087740 BOUND_VARIABLE_1087741)) (nullable.some 5) (nullable.some 6)) ((_ tuple.select 0) t)) (as nullable.null (Nullable Int)) (nullable.some 2) (nullable.lift (lambda ((BOUND_VARIABLE_1087752 Int) (BOUND_VARIABLE_1087753 Int)) (+ BOUND_VARIABLE_1087752 BOUND_VARIABLE_1087753)) (nullable.some 7) (nullable.some 8))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) false)))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 3) (nullable.some 22) (nullable.some 26) (as nullable.null (Nullable Int)) (nullable.some 2) (nullable.some 15)))))
(assert (= q1 (set.map f4 (set.filter p3 ((_ rel.project 0 1 3 4 5 6 7 8 9 10 11) (set.filter p2 (rel.product (set.map f0 DEPT) (set.map f1 EMP))))))))
(assert (= q2 (set.map f6 (set.filter p5 (set.singleton (tuple (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0)))))))
(check-sat)
;answer: sat
; duration: 140 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 15) (as nullable.null (Nullable String)))))
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 0) (nullable.some "") (nullable.some "A") (nullable.some 1) (nullable.some (- 1)) (nullable.some (- 3)) (nullable.some (- 2)) (nullable.some 15) (nullable.some 4))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 3) (nullable.some 21) (nullable.some 26) (as nullable.null (Nullable Int)) (nullable.some 2) (nullable.some 15)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; insert into DEPT values(15,NULL)
; insert into EMP values(0,'','A',1,-1,-3,-2,15,4)
; SELECT 1 + 2, t0.DEPTNO + (3 + 3), 5 + 6 + t0.DEPTNO, CAST(NULL AS INT), CASE WHEN 2 IS NOT NULL THEN 2 ELSE NULL END, ROW(7 + 8) FROM (SELECT DEPT.DEPTNO, DEPT.NAME, t.EMPNO, t.ENAME, t.JOB, t.MGR, t.HIREDATE, t.SAL, t.COMM, t.DEPTNO AS DEPTNO0, t.SLACKER FROM DEPT AS DEPT INNER JOIN (SELECT EMP.EMPNO, EMP.ENAME, EMP.JOB, EMP.MGR, EMP.HIREDATE, EMP.SAL, EMP.COMM, EMP.DEPTNO, EMP.SLACKER, EMP.DEPTNO + (5 - 5) AS f9 FROM EMP AS EMP) AS t ON DEPT.DEPTNO = t.f9) AS t0 WHERE t0.DEPTNO = 7 + 8 AND t0.DEPTNO = 8 + 7 AND t0.DEPTNO = CASE WHEN 2 IS NOT NULL THEN 15 ELSE NULL END EXCEPT ALL SELECT 3, 22, 26, CAST(NULL AS INT), CAST(2 AS INTEGER), ROW(15) FROM (SELECT * FROM (VALUES(0,0,0,0,0,0)) WHERE FALSE) AS t3
;(3,21,26,NULL,2,(15))

; SELECT 3, 22, 26, CAST(NULL AS INT), CAST(2 AS INTEGER), ROW(15) FROM (SELECT * FROM (VALUES(0,0,0,0,0,0)) WHERE FALSE) AS t3 EXCEPT ALL SELECT 1 + 2, t0.DEPTNO + (3 + 3), 5 + 6 + t0.DEPTNO, CAST(NULL AS INT), CASE WHEN 2 IS NOT NULL THEN 2 ELSE NULL END, ROW(7 + 8) FROM (SELECT DEPT.DEPTNO, DEPT.NAME, t.EMPNO, t.ENAME, t.JOB, t.MGR, t.HIREDATE, t.SAL, t.COMM, t.DEPTNO AS DEPTNO0, t.SLACKER FROM DEPT AS DEPT INNER JOIN (SELECT EMP.EMPNO, EMP.ENAME, EMP.JOB, EMP.MGR, EMP.HIREDATE, EMP.SAL, EMP.COMM, EMP.DEPTNO, EMP.SLACKER, EMP.DEPTNO + (5 - 5) AS f9 FROM EMP AS EMP) AS t ON DEPT.DEPTNO = t.f9) AS t0 WHERE t0.DEPTNO = 7 + 8 AND t0.DEPTNO = 8 + 7 AND t0.DEPTNO = CASE WHEN 2 IS NOT NULL THEN 15 ELSE NULL END

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testMergeJoinFilter
;Translating sql query: SELECT * FROM (SELECT DEPT.DEPTNO, EMP.ENAME FROM EMP AS EMP INNER JOIN DEPT AS DEPT ON EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = 10) AS t WHERE t.DEPTNO = 10
;Translating sql query: SELECT t1.DEPTNO, EMP0.ENAME FROM EMP AS EMP0 INNER JOIN (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO >= 10) AS t1 ON EMP0.DEPTNO = t1.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (nullable.is_some ((_ tuple.select 11) t)) (and (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t))) (= (nullable.val ((_ tuple.select 11) t)) 10))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 0) t)) (= (nullable.val ((_ tuple.select 0) t)) 10)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 0) t)) (>= (nullable.val ((_ tuple.select 0) t)) 10)))))
(assert (not (= q1 q2)))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p2 ((_ rel.project 9 1) (set.filter p1 (rel.product EMP (set.map f0 DEPT))))))))
(assert (= q2 ((_ rel.project 9 1) (set.filter p4 (rel.product EMP ((_ rel.project 0 1) (set.filter p3 DEPT)))))))
(check-sat)
;answer: sat
; duration: 328 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some (- 3)) (nullable.some "F") (nullable.some "G") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 11) (nullable.some 6))))
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 11) (nullable.some "H"))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 11) (nullable.some "F")))
; insert into EMP values(-3,'F','G',4,-4,5,-5,11,6)
; insert into DEPT values(11,'H')
; SELECT * FROM (SELECT DEPT.DEPTNO, EMP.ENAME FROM EMP AS EMP INNER JOIN DEPT AS DEPT ON EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = 10) AS t WHERE t.DEPTNO = 10 EXCEPT ALL SELECT t1.DEPTNO, EMP0.ENAME FROM EMP AS EMP0 INNER JOIN (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO >= 10) AS t1 ON EMP0.DEPTNO = t1.DEPTNO

; SELECT t1.DEPTNO, EMP0.ENAME FROM EMP AS EMP0 INNER JOIN (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO >= 10) AS t1 ON EMP0.DEPTNO = t1.DEPTNO EXCEPT ALL SELECT * FROM (SELECT DEPT.DEPTNO, EMP.ENAME FROM EMP AS EMP INNER JOIN DEPT AS DEPT ON EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = 10) AS t WHERE t.DEPTNO = 10
;(11,F)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testMergeUnionDistinct
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
;Translating sql query: SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 10 UNION SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

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
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (>= (nullable.val ((_ tuple.select 7) t)) 10)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 20)))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 30)))))
(assert (= q1 (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))
(assert (= q2 (set.union (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))
(check-sat)
;answer: sat
; duration: 818 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some (- 45)) (nullable.some "[") (nullable.some "\u{5c}") (nullable.some 46) (nullable.some (- 46)) (nullable.some 47) (nullable.some (- 47)) (nullable.some 19) (nullable.some 48))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some (- 45)) (nullable.some "[") (nullable.some "\u{5c}") (nullable.some 46) (nullable.some (- 46)) (nullable.some 47) (nullable.some (- 47)) (nullable.some 19) (nullable.some 48)))
; insert into EMP values(-45,'[','\',46,-46,47,-47,19,48)
; SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30 EXCEPT ALL SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 10 UNION SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30

; SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 10 UNION SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
;(-45,[,\,46,-46,47,-47,19,48)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testTransitiveInferenceNoPullUpExprs
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 OR EMP.DEPTNO = 9 OR EMP.COMM > 10) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7 OR EMP1.DEPTNO = 9 OR EMP1.COMM > 10) AS t1 INNER JOIN EMP AS EMP2 ON t1.DEPTNO = EMP2.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 5) t)) (or (= (nullable.val ((_ tuple.select 7) t)) 7) (= (nullable.val ((_ tuple.select 7) t)) 9) (> (nullable.val ((_ tuple.select 5) t)) 10))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 16) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 16) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 5) t)) (or (>= (nullable.val ((_ tuple.select 7) t)) 7) (= (nullable.val ((_ tuple.select 7) t)) 9) (> (nullable.val ((_ tuple.select 5) t)) 10))))))
(assert (not (= q1 q2)))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 16) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 16) t)))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f2 (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) EMP)))))
(assert (= q2 (set.map f5 (set.filter p4 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) EMP)))))
(check-sat)
;answer: sat
; duration: 692 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some (- 14)) (nullable.some "I") (nullable.some "J") (nullable.some 15) (nullable.some (- 15)) (nullable.some 0) (nullable.some 16) (nullable.some 8) (nullable.some (- 16)))) (set.union (set.singleton (tuple (nullable.some (- 9)) (nullable.some "E") (nullable.some "F") (nullable.some 10) (nullable.some (- 10)) (nullable.some 0) (nullable.some 11) (nullable.some 8) (nullable.some (- 11)))) (set.union (set.singleton (tuple (nullable.some 4) (nullable.some "A") (nullable.some "B") (nullable.some (- 4)) (nullable.some 5) (as nullable.null (Nullable Int)) (nullable.some (- 5)) (nullable.some 8) (nullable.some 6))) (set.singleton (tuple (nullable.some (- 6)) (nullable.some "C") (nullable.some "D") (nullable.some 7) (nullable.some (- 7)) (as nullable.null (Nullable Int)) (nullable.some (- 8)) (nullable.some 8) (nullable.some 9)))))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 1)))
; insert into EMP values(-14,'I','J',15,-15,0,16,8,-16),(-9,'E','F',10,-10,0,11,8,-11),(4,'A','B',-4,5,NULL,-5,8,6),(-6,'C','D',7,-7,NULL,-8,8,9)
; SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 OR EMP.DEPTNO = 9 OR EMP.COMM > 10) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO EXCEPT ALL SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7 OR EMP1.DEPTNO = 9 OR EMP1.COMM > 10) AS t1 INNER JOIN EMP AS EMP2 ON t1.DEPTNO = EMP2.DEPTNO

; SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7 OR EMP1.DEPTNO = 9 OR EMP1.COMM > 10) AS t1 INNER JOIN EMP AS EMP2 ON t1.DEPTNO = EMP2.DEPTNO EXCEPT ALL SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 OR EMP.DEPTNO = 9 OR EMP.COMM > 10) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testEmptyProject
;Translating sql query: SELECT t.EXPR$0 + t.EXPR$1 + t.EXPR$0 FROM (VALUES  (10, 1),  (30, 3)) AS t WHERE t.EXPR$0 + t.EXPR$1 > 0
;Translating sql query: SELECT t3.EXPR$0 + t3.EXPR$1 + t3.EXPR$0 FROM (SELECT * FROM (VALUES(0,0)) WHERE FALSE) AS t3
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 1) t)) (> (+ (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 1) t))) 0)))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_1104357 Int) (BOUND_VARIABLE_1104358 Int)) (+ BOUND_VARIABLE_1104357 BOUND_VARIABLE_1104358)) (nullable.lift (lambda ((BOUND_VARIABLE_1104351 Int) (BOUND_VARIABLE_1104352 Int)) (+ BOUND_VARIABLE_1104351 BOUND_VARIABLE_1104352)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 0) t))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) false)))
(assert (not (= q1 q2)))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_1104390 Int) (BOUND_VARIABLE_1104391 Int)) (+ BOUND_VARIABLE_1104390 BOUND_VARIABLE_1104391)) (nullable.lift (lambda ((BOUND_VARIABLE_1104384 Int) (BOUND_VARIABLE_1104385 Int)) (+ BOUND_VARIABLE_1104384 BOUND_VARIABLE_1104385)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 0) t))))))
(assert (= q1 (set.map f1 (set.filter p0 (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 30) (nullable.some 3))))))))
(assert (= q2 (set.map f3 (set.filter p2 (set.singleton (tuple (nullable.some 0) (nullable.some 0)))))))
(check-sat)
;answer: sat
; duration: 91 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (set.union (set.singleton (tuple (nullable.some 63))) (set.singleton (tuple (nullable.some 21))))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; SELECT t.column1 + t.column2 + t.column1 FROM (VALUES  (10, 1),  (30, 3)) AS t WHERE t.column1 + t.column2 > 0 EXCEPT ALL SELECT t3.column1 + t3.column2 + t3.column1 FROM (SELECT * FROM (VALUES(0,0)) WHERE FALSE) AS t3
;(63)
;(21)

; SELECT t3.column1 + t3.column2 + t3.column1 FROM (SELECT * FROM (VALUES(0,0)) WHERE FALSE) AS t3 EXCEPT ALL SELECT t.column1 + t.column2 + t.column1 FROM (VALUES  (10, 1),  (30, 3)) AS t WHERE t.column1 + t.column2 > 0

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testTransitiveInferenceConjunctInPullUp
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 OR EMP.DEPTNO = 9 OR EMP.DEPTNO > 10) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7 OR EMP1.DEPTNO = 9 OR EMP1.DEPTNO > 10) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 7 OR EMP2.DEPTNO = 9 OR EMP2.DEPTNO > 10) AS t2 ON t1.DEPTNO = t2.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 7) t)) (or (= (nullable.val ((_ tuple.select 7) t)) 7) (= (nullable.val ((_ tuple.select 7) t)) 9) (> (nullable.val ((_ tuple.select 7) t)) 10))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 16) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 16) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 7) t)) (or (>= (nullable.val ((_ tuple.select 7) t)) 7) (= (nullable.val ((_ tuple.select 7) t)) 9) (> (nullable.val ((_ tuple.select 7) t)) 10))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 7) t)) (or (>= (nullable.val ((_ tuple.select 7) t)) 7) (= (nullable.val ((_ tuple.select 7) t)) 9) (> (nullable.val ((_ tuple.select 7) t)) 10))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 16) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 16) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f2 (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) EMP)))))
(assert (= q2 (set.map f6 (set.filter p5 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)))))))
(check-sat)
;answer: sat
; duration: 672 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some (- 16)) (nullable.some "I") (nullable.some "J") (nullable.some 17) (nullable.some (- 17)) (nullable.some 18) (nullable.some (- 18)) (nullable.some 8) (nullable.some 19))) (set.union (set.singleton (tuple (nullable.some (- 13)) (nullable.some "G") (nullable.some "H") (nullable.some 14) (nullable.some (- 14)) (nullable.some 15) (nullable.some (- 15)) (nullable.some 8) (nullable.some 16))) (set.union (set.singleton (tuple (nullable.some (- 10)) (nullable.some "E") (nullable.some "F") (nullable.some 11) (nullable.some (- 11)) (nullable.some 12) (nullable.some (- 12)) (nullable.some 8) (nullable.some 13))) (set.singleton (tuple (nullable.some 7) (nullable.some "C") (nullable.some "D") (nullable.some (- 7)) (nullable.some (- 8)) (nullable.some 9) (nullable.some (- 9)) (nullable.some 8) (nullable.some 10)))))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 1)))
; insert into EMP values(-16,'I','J',17,-17,18,-18,8,19),(-13,'G','H',14,-14,15,-15,8,16),(-10,'E','F',11,-11,12,-12,8,13),(7,'C','D',-7,-8,9,-9,8,10)
; SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 OR EMP.DEPTNO = 9 OR EMP.DEPTNO > 10) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO EXCEPT ALL SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7 OR EMP1.DEPTNO = 9 OR EMP1.DEPTNO > 10) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 7 OR EMP2.DEPTNO = 9 OR EMP2.DEPTNO > 10) AS t2 ON t1.DEPTNO = t2.DEPTNO

; SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7 OR EMP1.DEPTNO = 9 OR EMP1.DEPTNO > 10) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 7 OR EMP2.DEPTNO = 9 OR EMP2.DEPTNO > 10) AS t2 ON t1.DEPTNO = t2.DEPTNO EXCEPT ALL SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 OR EMP.DEPTNO = 9 OR EMP.DEPTNO > 10) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testPushSemiJoinPastFilter
;Translating sql query: SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME = 'fo0'
;Translating sql query: SELECT t1.ENAME FROM (SELECT EMP0.DEPTNO,EMP0.ENAME FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO WHERE EMP0.ENAME = 'foo') AS t1 INNER JOIN DEPT AS DEPT1 ON t1.DEPTNO = DEPT1.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (nullable.is_some ((_ tuple.select 1) t)) (and (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t))) (= (nullable.val ((_ tuple.select 1) t)) "fo0"))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 1) t)) (= (nullable.val ((_ tuple.select 1) t)) "foo")))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 2) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 2) t)))))))
(assert (= q1 ((_ rel.project 1) (set.filter p0 (rel.product EMP DEPT)))))
(assert (= q2 ((_ rel.project 1) (set.filter p3 (rel.product ((_ rel.project 7 1) (set.filter p2 (set.filter p1 (rel.product EMP DEPT)))) DEPT)))))
(check-sat)
;answer: sat
; duration: 406 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 0) (nullable.some "H"))))
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 10) (nullable.some "fo0") (nullable.some "G") (nullable.some (- 10)) (nullable.some 11) (nullable.some (- 11)) (nullable.some 12) (nullable.some 0) (nullable.some (- 12)))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some "fo0")))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable String))))
; insert into DEPT values(0,'H')
; insert into EMP values(10,'fo0','G',-10,11,-11,12,0,-12)
; SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME = 'fo0' EXCEPT ALL SELECT t1.ENAME FROM (SELECT EMP0.DEPTNO,EMP0.ENAME FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO WHERE EMP0.ENAME = 'foo') AS t1 INNER JOIN DEPT AS DEPT1 ON t1.DEPTNO = DEPT1.DEPTNO
;(fo0)

; SELECT t1.ENAME FROM (SELECT EMP0.DEPTNO,EMP0.ENAME FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO WHERE EMP0.ENAME = 'foo') AS t1 INNER JOIN DEPT AS DEPT1 ON t1.DEPTNO = DEPT1.DEPTNO EXCEPT ALL SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME = 'fo0'

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testPullConstantIntoFilter
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10) AS t WHERE t.DEPTNO + 5 > t.EMPNO
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 10) AS t1 WHERE 15 >= t1.EMPNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 10)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 0) t)) (> (+ (nullable.val ((_ tuple.select 7) t)) 5) (nullable.val ((_ tuple.select 0) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 10)))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (>= 15 (nullable.val ((_ tuple.select 0) t)))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP))))))
(check-sat)
;answer: sat
; duration: 216 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 15) (nullable.some "I") (nullable.some "J") (nullable.some (- 14)) (nullable.some (- 15)) (nullable.some (- 16)) (nullable.some 17) (nullable.some 10) (nullable.some (- 17)))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 15) (nullable.some "I") (nullable.some "J") (nullable.some (- 14)) (nullable.some (- 15)) (nullable.some (- 16)) (nullable.some 17) (nullable.some 10) (nullable.some (- 17))))
; insert into EMP values(15,'I','J',-14,-15,-16,17,10,-17)
; SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10) AS t WHERE t.DEPTNO + 5 > t.EMPNO EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 10) AS t1 WHERE 15 >= t1.EMPNO

; SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 10) AS t1 WHERE 15 >= t1.EMPNO EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10) AS t WHERE t.DEPTNO + 5 > t.EMPNO
;(15,I,J,-14,-15,-16,17,10,-17)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testTransitiveInferencePullUpThruAlias
;Translating sql query: SELECT 1 FROM (SELECT EMP.COMM AS DEPTNO FROM EMP AS EMP WHERE EMP.COMM > 7) AS t0 INNER JOIN EMP AS EMP0 ON t0.DEPTNO = EMP0.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT EMP1.COMM AS DEPTNO FROM EMP AS EMP1 WHERE EMP1.COMM >= 7) AS t3 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 7) AS t4 ON t3.DEPTNO = t4.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f6 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 5) t)) (> (nullable.val ((_ tuple.select 5) t)) 7)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 8) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 8) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 5) t)) (>= (nullable.val ((_ tuple.select 5) t)) 7)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (>= (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 8) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 8) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f2 (set.filter p1 (rel.product ((_ rel.project 5) (set.filter p0 EMP)) EMP)))))
(assert (= q2 (set.map f6 (set.filter p5 (rel.product ((_ rel.project 5) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)))))))
(check-sat)
;answer: sat
; duration: 9603 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some (- 52)) (nullable.some "g") (nullable.some "h") (nullable.some 53) (nullable.some (- 53)) (nullable.some 7) (nullable.some 54) (nullable.some 7) (nullable.some (- 54)))) (set.union (set.singleton (tuple (nullable.some 50) (nullable.some "e") (nullable.some "f") (nullable.some (- 50)) (nullable.some 51) (nullable.some 8) (nullable.some (- 51)) (nullable.some 7) (nullable.some 52))) (set.union (set.singleton (tuple (nullable.some (- 47)) (nullable.some "c") (nullable.some "d") (nullable.some 48) (nullable.some (- 48)) (nullable.some 8) (nullable.some 49) (nullable.some 7) (nullable.some (- 49)))) (set.union (set.singleton (tuple (nullable.some 45) (nullable.some "a") (nullable.some "b") (nullable.some (- 45)) (nullable.some 46) (nullable.some 8) (nullable.some (- 46)) (nullable.some 7) (nullable.some 47))) (set.union (set.singleton (tuple (nullable.some (- 42)) (nullable.some "_") (nullable.some "`") (nullable.some 43) (nullable.some (- 43)) (nullable.some 8) (nullable.some 44) (nullable.some 7) (nullable.some (- 44)))) (set.union (set.singleton (tuple (nullable.some 40) (nullable.some "]") (nullable.some "^") (nullable.some (- 40)) (nullable.some 41) (nullable.some 7) (nullable.some (- 41)) (nullable.some 7) (nullable.some 42))) (set.union (set.singleton (tuple (nullable.some (- 32)) (nullable.some "W") (nullable.some "X") (nullable.some 33) (nullable.some (- 33)) (nullable.some 8) (nullable.some 34) (nullable.some 9) (nullable.some (- 34)))) (set.union (set.singleton (tuple (nullable.some 30) (nullable.some "U") (nullable.some "V") (nullable.some (- 30)) (nullable.some 31) (nullable.some 8) (nullable.some (- 31)) (nullable.some 9) (nullable.some 32))) (set.union (set.singleton (tuple (nullable.some (- 22)) (nullable.some "O") (nullable.some "P") (nullable.some 23) (nullable.some (- 23)) (nullable.some 8) (nullable.some 24) (nullable.some 9) (nullable.some (- 24)))) (set.union (set.singleton (tuple (nullable.some 20) (nullable.some "M") (nullable.some "N") (nullable.some (- 20)) (nullable.some 21) (nullable.some 8) (nullable.some (- 21)) (nullable.some 9) (nullable.some 22))) (set.union (set.singleton (tuple (nullable.some (- 17)) (nullable.some "K") (nullable.some "L") (nullable.some 18) (nullable.some (- 18)) (nullable.some 7) (nullable.some 19) (nullable.some 7) (nullable.some (- 19)))) (set.union (set.singleton (tuple (nullable.some 15) (nullable.some "I") (nullable.some "J") (nullable.some (- 15)) (nullable.some 16) (nullable.some 7) (nullable.some (- 16)) (nullable.some 7) (nullable.some 17))) (set.union (set.singleton (tuple (nullable.some (- 12)) (nullable.some "G") (nullable.some "H") (nullable.some 13) (nullable.some (- 13)) (nullable.some 8) (nullable.some 14) (nullable.some 7) (nullable.some (- 14)))) (set.singleton (tuple (nullable.some 10) (nullable.some "E") (nullable.some "F") (nullable.some (- 10)) (nullable.some 11) (nullable.some 8) (nullable.some (- 11)) (nullable.some 7) (nullable.some 12)))))))))))))))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 1)))
; insert into EMP values(-52,'g','h',53,-53,7,54,7,-54),(50,'e','f',-50,51,8,-51,7,52),(-47,'c','d',48,-48,8,49,7,-49),(45,'a','b',-45,46,8,-46,7,47),(-42,'_','`',43,-43,8,44,7,-44),(40,']','^',-40,41,7,-41,7,42),(-32,'W','X',33,-33,8,34,9,-34),(30,'U','V',-30,31,8,-31,9,32),(-22,'O','P',23,-23,8,24,9,-24),(20,'M','N',-20,21,8,-21,9,22),(-17,'K','L',18,-18,7,19,7,-19),(15,'I','J',-15,16,7,-16,7,17),(-12,'G','H',13,-13,8,14,7,-14),(10,'E','F',-10,11,8,-11,7,12)
; SELECT 1 FROM (SELECT EMP.COMM AS DEPTNO FROM EMP AS EMP WHERE EMP.COMM > 7) AS t0 INNER JOIN EMP AS EMP0 ON t0.DEPTNO = EMP0.DEPTNO EXCEPT ALL SELECT 1 FROM (SELECT EMP1.COMM AS DEPTNO FROM EMP AS EMP1 WHERE EMP1.COMM >= 7) AS t3 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 7) AS t4 ON t3.DEPTNO = t4.DEPTNO

; SELECT 1 FROM (SELECT EMP1.COMM AS DEPTNO FROM EMP AS EMP1 WHERE EMP1.COMM >= 7) AS t3 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 7) AS t4 ON t3.DEPTNO = t4.DEPTNO EXCEPT ALL SELECT 1 FROM (SELECT EMP.COMM AS DEPTNO FROM EMP AS EMP WHERE EMP.COMM > 7) AS t0 INNER JOIN EMP AS EMP0 ON t0.DEPTNO = EMP0.DEPTNO
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testMergeSetOpMixed
;Translating sql query: SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS t2
;Translating sql query: SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 10 UNION SELECT * FROM (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS t7
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

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
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (>= (nullable.val ((_ tuple.select 7) t)) 10)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 20)))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 30)))))
(assert (= q1 (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.inter ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))))
(assert (= q2 (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.inter ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))))
(check-sat)
;answer: sat
; duration: 957 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some (- 51)) (nullable.some "_") (nullable.some "`") (nullable.some 52) (nullable.some (- 52)) (nullable.some 53) (nullable.some (- 53)) (nullable.some 19) (nullable.some 54))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some (- 51)) (nullable.some "_") (nullable.some "`") (nullable.some 52) (nullable.some (- 52)) (nullable.some 53) (nullable.some (- 53)) (nullable.some 19) (nullable.some 54)))
; insert into EMP values(-51,'_','`',52,-52,53,-53,19,54)
; SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS t2 EXCEPT ALL SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 10 UNION SELECT * FROM (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS t7

; SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 10 UNION SELECT * FROM (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS t7 EXCEPT ALL SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS t2
;(-51,_,`,52,-52,53,-53,19,54)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testReduceConstantsIsNotNull
;Translating sql query: SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND EMP.EMPNO IS NOT NULL
;Translating sql query: SELECT EMP0.EMPNO FROM EMP AS EMP0 WHERE EMP0.EMPNO >= 10
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (and (= (nullable.val ((_ tuple.select 0) t)) 10) (nullable.is_some ((_ tuple.select 0) t)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (>= (nullable.val ((_ tuple.select 0) t)) 10)))))
(assert (= q1 ((_ rel.project 0) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0) (set.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 72 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 11) (nullable.some "C") (nullable.some "D") (nullable.some (- 6)) (nullable.some 7) (nullable.some (- 7)) (nullable.some 8) (nullable.some (- 8)) (nullable.some 9))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 11)))
; insert into EMP values(11,'C','D',-6,7,-7,8,-8,9)
; SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND EMP.EMPNO IS NOT NULL EXCEPT ALL SELECT EMP0.EMPNO FROM EMP AS EMP0 WHERE EMP0.EMPNO >= 10

; SELECT EMP0.EMPNO FROM EMP AS EMP0 WHERE EMP0.EMPNO >= 10 EXCEPT ALL SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND EMP.EMPNO IS NOT NULL
;(11)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testEmptyIntersect
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES  (50, 3)) AS t INTERSECT SELECT * FROM (VALUES  (10, 1),  (50, 3)) AS t0 WHERE t0.EXPR$0 >= 50) AS t2 INTERSECT SELECT * FROM (VALUES  (50, 3)) AS t3
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES(0,0)) WHERE FALSE) AS t5
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (>= (nullable.val ((_ tuple.select 0) t)) 50)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) false)))
(assert (= q1 (set.inter ((_ rel.project 0 1) (set.inter ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 50) (nullable.some 3)))) ((_ rel.project 0 1) (set.filter p0 (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 50) (nullable.some 3)))))))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 50) (nullable.some 3)))))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p1 (set.singleton (tuple (nullable.some 0) (nullable.some 0)))))))
(check-sat)
;answer: sat
; duration: 14 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 50) (nullable.some 3)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable Int))))
; SELECT * FROM (SELECT * FROM (VALUES  (50, 3)) AS t INTERSECT SELECT * FROM (VALUES  (10, 1),  (50, 3)) AS t0 WHERE t0.column1 >= 50) AS t2 INTERSECT SELECT * FROM (VALUES  (50, 3)) AS t3 EXCEPT ALL SELECT * FROM (SELECT * FROM (VALUES(0,0)) WHERE FALSE) AS t5
;(50,3)

; SELECT * FROM (SELECT * FROM (VALUES(0,0)) WHERE FALSE) AS t5 EXCEPT ALL SELECT * FROM (SELECT * FROM (VALUES  (50, 3)) AS t INTERSECT SELECT * FROM (VALUES  (10, 1),  (50, 3)) AS t0 WHERE t0.column1 >= 50) AS t2 INTERSECT SELECT * FROM (VALUES  (50, 3)) AS t3

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testPullConstantIntoProject
;Translating sql query: SELECT EMP.DEPTNO, EMP.DEPTNO + 1, EMP.EMPNO + EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO = 10
;Translating sql query: SELECT 11 AS DEPTNO, 11, EMP0.EMPNO + 10 FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 10
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 10)))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 7) t) (nullable.lift (lambda ((BOUND_VARIABLE_1174818 Int) (BOUND_VARIABLE_1174819 Int)) (+ BOUND_VARIABLE_1174818 BOUND_VARIABLE_1174819)) ((_ tuple.select 7) t) (nullable.some 1)) (nullable.lift (lambda ((BOUND_VARIABLE_1174825 Int) (BOUND_VARIABLE_1174826 Int)) (+ BOUND_VARIABLE_1174825 BOUND_VARIABLE_1174826)) ((_ tuple.select 0) t) ((_ tuple.select 7) t))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 10)))))
(assert (not (= q1 q2)))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 11) (nullable.some 11) (nullable.lift (lambda ((BOUND_VARIABLE_1174855 Int) (BOUND_VARIABLE_1174856 Int)) (+ BOUND_VARIABLE_1174855 BOUND_VARIABLE_1174856)) ((_ tuple.select 0) t) (nullable.some 10))))))
(assert (= q1 (set.map f1 (set.filter p0 EMP))))
(assert (= q2 (set.map f3 (set.filter p2 EMP))))
(check-sat)
;answer: sat
; duration: 66 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (as nullable.null (Nullable Int)) (nullable.some "C") (nullable.some "D") (nullable.some (- 5)) (nullable.some 6) (nullable.some (- 6)) (nullable.some 7) (nullable.some 10) (nullable.some (- 7)))) (set.union (set.singleton (tuple (as nullable.null (Nullable Int)) (nullable.some "A") (nullable.some "B") (nullable.some 3) (nullable.some (- 3)) (nullable.some 4) (nullable.some (- 4)) (nullable.some 10) (nullable.some 5))) (set.singleton (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 0) (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some 10) (nullable.some (- 2)))))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 10) (nullable.some 11) (as nullable.null (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 11) (nullable.some 11) (as nullable.null (Nullable Int))))
; insert into EMP values(NULL,'C','D',-5,6,-6,7,10,-7),(NULL,'A','B',3,-3,4,-4,10,5),(NULL,NULL,'',0,1,-1,2,10,-2)
; SELECT EMP.DEPTNO, EMP.DEPTNO + 1, EMP.EMPNO + EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO = 10 EXCEPT ALL SELECT 11 AS DEPTNO, 11, EMP0.EMPNO + 10 FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 10
;(10,11,NULL)
;(10,11,NULL)
;(10,11,NULL)

; SELECT 11 AS DEPTNO, 11, EMP0.EMPNO + 10 FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 10 EXCEPT ALL SELECT EMP.DEPTNO, EMP.DEPTNO + 1, EMP.EMPNO + EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO = 10
;(11,11,NULL)
;(11,11,NULL)
;(11,11,NULL)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testTransitiveInferenceUnionAlwaysTrue
;Translating sql query: SELECT * FROM (SELECT EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO < 4) AS t0 INNER JOIN (SELECT EMP0.DEPTNO FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 7 UNION ALL SELECT EMP1.DEPTNO FROM EMP AS EMP1) AS t4 ON t0.DEPTNO = t4.DEPTNO
;Translating sql query: SELECT * FROM (SELECT EMP2.DEPTNO FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 4) AS t6 INNER JOIN (SELECT * FROM (SELECT EMP3.DEPTNO FROM EMP AS EMP3 WHERE EMP3.DEPTNO >= 7 UNION ALL SELECT EMP4.DEPTNO FROM EMP AS EMP4) AS t10 WHERE t10.DEPTNO < 4) AS t11 ON t6.DEPTNO = t11.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (< (nullable.val ((_ tuple.select 7) t)) 4)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (> (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 1) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 1) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (>= (nullable.val ((_ tuple.select 7) t)) 4)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (>= (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (< (nullable.val ((_ tuple.select 0) t)) 4)))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 1) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 1) t)))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p2 (rel.product ((_ rel.project 7) (set.filter p0 EMP)) (set.union ((_ rel.project 7) (set.filter p1 EMP)) ((_ rel.project 7) EMP)))))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p6 (rel.product ((_ rel.project 7) (set.filter p3 EMP)) ((_ rel.project 0) (set.filter p5 (set.union ((_ rel.project 7) (set.filter p4 EMP)) ((_ rel.project 7) EMP)))))))))
(check-sat)
;answer: sat
; duration: 679 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some 35) (nullable.some "S") (nullable.some "T") (nullable.some (- 35)) (nullable.some 36) (nullable.some (- 36)) (nullable.some 37) (nullable.some 3) (nullable.some (- 37)))) (set.singleton (tuple (nullable.some 29) (nullable.some "O") (nullable.some "P") (nullable.some (- 29)) (nullable.some 30) (nullable.some (- 30)) (nullable.some 31) (nullable.some 3) (nullable.some (- 31))))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 3) (nullable.some 3)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable Int))))
; insert into EMP values(35,'S','T',-35,36,-36,37,3,-37),(29,'O','P',-29,30,-30,31,3,-31)
; SELECT * FROM (SELECT EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO < 4) AS t0 INNER JOIN (SELECT EMP0.DEPTNO FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 7 UNION ALL SELECT EMP1.DEPTNO FROM EMP AS EMP1) AS t4 ON t0.DEPTNO = t4.DEPTNO EXCEPT ALL SELECT * FROM (SELECT EMP2.DEPTNO FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 4) AS t6 INNER JOIN (SELECT * FROM (SELECT EMP3.DEPTNO FROM EMP AS EMP3 WHERE EMP3.DEPTNO >= 7 UNION ALL SELECT EMP4.DEPTNO FROM EMP AS EMP4) AS t10 WHERE t10.DEPTNO < 4) AS t11 ON t6.DEPTNO = t11.DEPTNO
;(3,3)
;(3,3)
;(3,3)
;(3,3)

; SELECT * FROM (SELECT EMP2.DEPTNO FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 4) AS t6 INNER JOIN (SELECT * FROM (SELECT EMP3.DEPTNO FROM EMP AS EMP3 WHERE EMP3.DEPTNO >= 7 UNION ALL SELECT EMP4.DEPTNO FROM EMP AS EMP4) AS t10 WHERE t10.DEPTNO < 4) AS t11 ON t6.DEPTNO = t11.DEPTNO EXCEPT ALL SELECT * FROM (SELECT EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO < 4) AS t0 INNER JOIN (SELECT EMP0.DEPTNO FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 7 UNION ALL SELECT EMP1.DEPTNO FROM EMP AS EMP1) AS t4 ON t0.DEPTNO = t4.DEPTNO

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testMergeIntersect
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO >= 10 INTERSECT SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 30) AS t1 INTERSECT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 20
;Translating sql query: SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 INTERSECT SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (>= (nullable.val ((_ tuple.select 7) t)) 10)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 30)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (>= (nullable.val ((_ tuple.select 7) t)) 20)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 10)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 20)))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 30)))))
(assert (= q1 (set.inter ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.inter ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))
(assert (= q2 (set.inter (set.inter ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))
(check-sat)
;answer: sat
; duration: 1049 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some (- 51)) (nullable.some "_") (nullable.some "`") (nullable.some 52) (nullable.some (- 52)) (nullable.some 53) (nullable.some (- 53)) (nullable.some 30) (nullable.some 54))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some (- 51)) (nullable.some "_") (nullable.some "`") (nullable.some 52) (nullable.some (- 52)) (nullable.some 53) (nullable.some (- 53)) (nullable.some 30) (nullable.some 54)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; insert into EMP values(-51,'_','`',52,-52,53,-53,30,54)
; SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO >= 10 INTERSECT SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 30) AS t1 INTERSECT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 20 EXCEPT ALL SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 INTERSECT SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
;(-51,_,`,52,-52,53,-53,30,54)

; SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 INTERSECT SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO >= 10 INTERSECT SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 30) AS t1 INTERSECT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 20

;Model soundness: true
(reset)
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (tuple (nullable.some 1)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 11) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 11) t)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f1 (set.filter p0 (rel.product EMP DEPT)))))
(assert (= q2 (set.map f4 (set.filter p3 (rel.product (set.filter p2 (rel.product EMP DEPT)) DEPT)))))
(check-sat)
;answer: unsat
; duration: 250 ms.
(reset)
;-----------------------------------------------------------
; test name: testRemoveSemiJoinWithFilter
;Translating sql query: SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME = 'foo'
;Translating sql query: SELECT t1.ENAME FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.ENAME = 'fo0') AS t1 INNER JOIN DEPT AS DEPT0 ON t1.DEPTNO = DEPT0.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (nullable.is_some ((_ tuple.select 1) t)) (and (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t))) (= (nullable.val ((_ tuple.select 1) t)) "foo"))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 1) t)) (= (nullable.val ((_ tuple.select 1) t)) "fo0")))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ rel.project 1) (set.filter p0 (rel.product EMP DEPT)))))
(assert (= q2 ((_ rel.project 1) (set.filter p2 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)) DEPT)))))
(check-sat)
;answer: sat
; duration: 164 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 10) (nullable.some "fo0") (nullable.some "H") (nullable.some (- 10)) (nullable.some 11) (nullable.some (- 11)) (nullable.some 12) (nullable.some 0) (nullable.some (- 12)))))
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 0) (nullable.some "C"))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable String))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some "fo0")))
; insert into EMP values(10,'fo0','H',-10,11,-11,12,0,-12)
; insert into DEPT values(0,'C')
; SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME = 'foo' EXCEPT ALL SELECT t1.ENAME FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.ENAME = 'fo0') AS t1 INNER JOIN DEPT AS DEPT0 ON t1.DEPTNO = DEPT0.DEPTNO

; SELECT t1.ENAME FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.ENAME = 'fo0') AS t1 INNER JOIN DEPT AS DEPT0 ON t1.DEPTNO = DEPT0.DEPTNO EXCEPT ALL SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME = 'foo'
;(fo0)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testRightOuterJoinSimplificationToInner
;Translating sql query: SELECT 1 FROM DEPT AS DEPT RIGHT JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charli'
;Translating sql query: SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 INNER JOIN EMP AS EMP0 ON t1.DEPTNO = EMP0.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const rightJoin1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= rightJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 1) t)) (= (nullable.val ((_ tuple.select 1) t)) "Charli")))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 1) t)) (= (nullable.val ((_ tuple.select 1) t)) "Charlie")))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f3 (set.filter p2 (set.union (set.map rightJoin1 (set.minus EMP ((_ rel.project 2 3 4 5 6 7 8 9 10) (set.filter p0 (rel.product DEPT EMP))))) (set.filter p0 (rel.product DEPT EMP)))))))
(assert (= q2 (set.map f6 (set.filter p5 (rel.product ((_ rel.project 0 1) (set.filter p4 DEPT)) EMP)))))
(check-sat)
;answer: sat
; duration: 546 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some 25) (nullable.some "O") (nullable.some "P") (nullable.some (- 25)) (nullable.some 26) (nullable.some (- 26)) (nullable.some 27) (nullable.some 0) (nullable.some (- 27)))) (set.singleton (tuple (nullable.some 22) (nullable.some "M") (nullable.some "N") (nullable.some (- 22)) (nullable.some 23) (nullable.some (- 23)) (nullable.some 24) (nullable.some 0) (nullable.some (- 24))))))
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.union (set.singleton (tuple (nullable.some 0) (as nullable.null (Nullable String)))) (set.singleton (tuple (nullable.some 0) (nullable.some "Charlie")))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 1)))
; insert into EMP values(25,'O','P',-25,26,-26,27,0,-27),(22,'M','N',-22,23,-23,24,0,-24)
; insert into DEPT values(0,NULL),(0,'Charlie')
; SELECT 1 FROM DEPT AS DEPT RIGHT JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charli' EXCEPT ALL SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 INNER JOIN EMP AS EMP0 ON t1.DEPTNO = EMP0.DEPTNO

; SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 INNER JOIN EMP AS EMP0 ON t1.DEPTNO = EMP0.DEPTNO EXCEPT ALL SELECT 1 FROM DEPT AS DEPT RIGHT JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charli'
;(1)
;(1)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testPushJoinCondDownToProject
;Translating sql query: SELECT DEPT.DEPTNO, EMP.DEPTNO AS DEPTNO0 FROM DEPT AS DEPT, EMP AS EMP WHERE DEPT.DEPTNO + 10 >= EMP.DEPTNO * 2
;Translating sql query: SELECT t1.DEPTNO, t2.DEPTNO AS DEPTNO0 FROM (SELECT DEPT0.DEPTNO, DEPT0.NAME, DEPT0.DEPTNO + 10 AS f2 FROM DEPT AS DEPT0) AS t1 INNER JOIN (SELECT EMP0.EMPNO, EMP0.ENAME, EMP0.JOB, EMP0.MGR, EMP0.HIREDATE, EMP0.SAL, EMP0.COMM, EMP0.DEPTNO, EMP0.SLACKER, EMP0.DEPTNO * 2 AS f9 FROM EMP AS EMP0) AS t2 ON t1.f2 = t2.f9
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 9) t)) (>= (+ (nullable.val ((_ tuple.select 0) t)) 10) (* (nullable.val ((_ tuple.select 9) t)) 2))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (nullable.lift (lambda ((BOUND_VARIABLE_1197104 Int) (BOUND_VARIABLE_1197105 Int)) (+ BOUND_VARIABLE_1197104 BOUND_VARIABLE_1197105)) ((_ tuple.select 0) t) (nullable.some 10))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 6) t) ((_ tuple.select 5) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_1197128 Int) (BOUND_VARIABLE_1197129 Int)) (* BOUND_VARIABLE_1197128 BOUND_VARIABLE_1197129)) ((_ tuple.select 7) t) (nullable.some 2))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 2) t)) (nullable.is_some ((_ tuple.select 12) t)) (= (nullable.val ((_ tuple.select 2) t)) (nullable.val ((_ tuple.select 12) t)))))))
(assert (= q1 ((_ rel.project 0 9) (set.filter p0 (rel.product DEPT EMP)))))
(assert (= q2 ((_ rel.project 0 10) (set.filter p3 (rel.product (set.map f1 DEPT) (set.map f2 EMP))))))
(check-sat)
;answer: sat
; duration: 397 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some 16) (nullable.some "L") (nullable.some "M") (nullable.some (- 16)) (nullable.some 17) (nullable.some 18) (nullable.some (- 17)) (nullable.some 5) (nullable.some (- 18)))) (set.singleton (tuple (nullable.some 6) (nullable.some "C") (nullable.some "D") (nullable.some (- 6)) (nullable.some 7) (nullable.some 8) (nullable.some (- 7)) (as nullable.null (Nullable Int)) (nullable.some (- 8))))))
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.union (set.singleton (tuple (nullable.some 1) (nullable.some "I"))) (set.singleton (tuple (as nullable.null (Nullable Int)) (nullable.some "B")))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 1) (nullable.some 5)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable Int))))
; insert into EMP values(16,'L','M',-16,17,18,-17,5,-18),(6,'C','D',-6,7,8,-7,NULL,-8)
; insert into DEPT values(1,'I'),(NULL,'B')
; SELECT DEPT.DEPTNO, EMP.DEPTNO AS DEPTNO0 FROM DEPT AS DEPT, EMP AS EMP WHERE DEPT.DEPTNO + 10 >= EMP.DEPTNO * 2 EXCEPT ALL SELECT t1.DEPTNO, t2.DEPTNO AS DEPTNO0 FROM (SELECT DEPT0.DEPTNO, DEPT0.NAME, DEPT0.DEPTNO + 10 AS f2 FROM DEPT AS DEPT0) AS t1 INNER JOIN (SELECT EMP0.EMPNO, EMP0.ENAME, EMP0.JOB, EMP0.MGR, EMP0.HIREDATE, EMP0.SAL, EMP0.COMM, EMP0.DEPTNO, EMP0.SLACKER, EMP0.DEPTNO * 2 AS f9 FROM EMP AS EMP0) AS t2 ON t1.f2 = t2.f9
;(1,5)

; SELECT t1.DEPTNO, t2.DEPTNO AS DEPTNO0 FROM (SELECT DEPT0.DEPTNO, DEPT0.NAME, DEPT0.DEPTNO + 10 AS f2 FROM DEPT AS DEPT0) AS t1 INNER JOIN (SELECT EMP0.EMPNO, EMP0.ENAME, EMP0.JOB, EMP0.MGR, EMP0.HIREDATE, EMP0.SAL, EMP0.COMM, EMP0.DEPTNO, EMP0.SLACKER, EMP0.DEPTNO * 2 AS f9 FROM EMP AS EMP0) AS t2 ON t1.f2 = t2.f9 EXCEPT ALL SELECT DEPT.DEPTNO, EMP.DEPTNO AS DEPTNO0 FROM DEPT AS DEPT, EMP AS EMP WHERE DEPT.DEPTNO + 10 >= EMP.DEPTNO * 2

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testRemoveSemiJoinRightWithFilter
;Translating sql query: SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = EMP0.DEPTNO AND DEPT.NAME = 'foo'
;Translating sql query: SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'fo0') AS t1 ON EMP1.DEPTNO = t1.DEPTNO INNER JOIN EMP AS EMP2 ON t1.DEPTNO = EMP2.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (nullable.is_some ((_ tuple.select 9) t)) (nullable.is_some ((_ tuple.select 18) t)) (nullable.is_some ((_ tuple.select 10) t)) (and (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t))) (= (nullable.val ((_ tuple.select 9) t)) (nullable.val ((_ tuple.select 18) t))) (= (nullable.val ((_ tuple.select 10) t)) "foo"))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 1) t)) (= (nullable.val ((_ tuple.select 1) t)) "fo0")))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 9) t)) (nullable.is_some ((_ tuple.select 18) t)) (= (nullable.val ((_ tuple.select 9) t)) (nullable.val ((_ tuple.select 18) t)))))))
(assert (= q1 ((_ rel.project 1) (set.filter p0 (rel.product (rel.product EMP DEPT) EMP)))))
(assert (= q2 ((_ rel.project 1) (set.filter p3 (rel.product (set.filter p2 (rel.product EMP ((_ rel.project 0 1) (set.filter p1 DEPT)))) EMP)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10045 ms.
(reset)
;-----------------------------------------------------------
; test name: testFullOuterJoinSimplificationToLeftOuter
;Translating sql query: SELECT 1 FROM DEPT AS DEPT FULL JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charli'
;Translating sql query: SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 LEFT JOIN EMP AS EMP0 ON t1.DEPTNO = EMP0.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const f8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const leftJoin1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const rightJoin2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const leftJoin7 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 1) t)) (= (nullable.val ((_ tuple.select 1) t)) "Charli")))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 1) t)) (= (nullable.val ((_ tuple.select 1) t)) "Charlie")))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= leftJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f4 (set.filter p3 (set.union (set.union (set.map leftJoin1 (set.minus DEPT ((_ rel.project 0 1) (set.filter p0 (rel.product DEPT EMP))))) (set.map rightJoin2 (set.minus EMP ((_ rel.project 2 3 4 5 6 7 8 9 10) (set.filter p0 (rel.product DEPT EMP)))))) (set.filter p0 (rel.product DEPT EMP)))))))
(assert (= q2 (set.map f8 (set.union (set.map leftJoin7 (set.minus ((_ rel.project 0 1) (set.filter p5 DEPT)) ((_ rel.project 0 1) (set.filter p6 (rel.product ((_ rel.project 0 1) (set.filter p5 DEPT)) EMP))))) (set.filter p6 (rel.product ((_ rel.project 0 1) (set.filter p5 DEPT)) EMP))))))
(check-sat)
;answer: unknown (INCOMPLETE)
; duration: 1312 ms.
(reset)
;-----------------------------------------------------------
; test name: testTransitiveInferenceUnion
;Translating sql query: SELECT 1 FROM (SELECT EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO >= 7 UNION ALL SELECT EMP0.DEPTNO FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 10) AS t3 INNER JOIN EMP AS EMP1 ON t3.DEPTNO = EMP1.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT EMP2.DEPTNO FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7 UNION ALL SELECT EMP3.DEPTNO FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 10) AS t9 INNER JOIN (SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 7 OR EMP4.DEPTNO > 10) AS t10 ON t9.DEPTNO = t10.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f8 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (>= (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (> (nullable.val ((_ tuple.select 7) t)) 10)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 8) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 8) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (> (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (> (nullable.val ((_ tuple.select 7) t)) 10)))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 7) t)) (or (> (nullable.val ((_ tuple.select 7) t)) 7) (> (nullable.val ((_ tuple.select 7) t)) 10))))))
(assert (not (= q1 q2)))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 8) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 8) t)))))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f3 (set.filter p2 (rel.product (set.union ((_ rel.project 7) (set.filter p0 EMP)) ((_ rel.project 7) (set.filter p1 EMP))) EMP)))))
(assert (= q2 (set.map f8 (set.filter p7 (rel.product (set.union ((_ rel.project 7) (set.filter p4 EMP)) ((_ rel.project 7) (set.filter p5 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 EMP)))))))
(check-sat)
;answer: sat
; duration: 6443 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some (- 134)) (nullable.some "8") (nullable.some "9") (nullable.some 135) (nullable.some (- 135)) (nullable.some 136) (nullable.some (- 136)) (nullable.some 7) (nullable.some 137))) (set.union (set.singleton (tuple (nullable.some (- 131)) (nullable.some "6") (nullable.some "7") (nullable.some 132) (nullable.some (- 132)) (nullable.some 133) (nullable.some (- 133)) (nullable.some 7) (nullable.some 134))) (set.union (set.singleton (tuple (nullable.some (- 101)) (nullable.some """") (nullable.some "#") (nullable.some 102) (nullable.some (- 102)) (nullable.some 103) (nullable.some (- 103)) (nullable.some 7) (nullable.some 104))) (set.singleton (tuple (nullable.some (- 104)) (nullable.some "$") (nullable.some "%") (nullable.some 105) (nullable.some (- 105)) (nullable.some 106) (nullable.some (- 106)) (nullable.some 7) (nullable.some 107)))))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 1)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; insert into EMP values(-134,'8','9',135,-135,136,-136,7,137),(-131,'6','7',132,-132,133,-133,7,134),(-101,'"','#',102,-102,103,-103,7,104),(-104,'$','%',105,-105,106,-106,7,107)
; SELECT 1 FROM (SELECT EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO >= 7 UNION ALL SELECT EMP0.DEPTNO FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 10) AS t3 INNER JOIN EMP AS EMP1 ON t3.DEPTNO = EMP1.DEPTNO EXCEPT ALL SELECT 1 FROM (SELECT EMP2.DEPTNO FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7 UNION ALL SELECT EMP3.DEPTNO FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 10) AS t9 INNER JOIN (SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 7 OR EMP4.DEPTNO > 10) AS t10 ON t9.DEPTNO = t10.DEPTNO
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)

; SELECT 1 FROM (SELECT EMP2.DEPTNO FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7 UNION ALL SELECT EMP3.DEPTNO FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 10) AS t9 INNER JOIN (SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 7 OR EMP4.DEPTNO > 10) AS t10 ON t9.DEPTNO = t10.DEPTNO EXCEPT ALL SELECT 1 FROM (SELECT EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO >= 7 UNION ALL SELECT EMP0.DEPTNO FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 10) AS t3 INNER JOIN EMP AS EMP1 ON t3.DEPTNO = EMP1.DEPTNO

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testPullConstantIntoJoin
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.EMPNO = 10) AS t LEFT JOIN DEPT AS DEPT ON t.EMPNO = DEPT.DEPTNO
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.EMPNO >= 10) AS t0 LEFT JOIN (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO = 10) AS t1 ON TRUE
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const leftJoin2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const leftJoin5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (= (nullable.val ((_ tuple.select 0) t)) 10)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (>= (nullable.val ((_ tuple.select 0) t)) 10)))))
(assert (not (= q1 q2)))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 0) t)) (= (nullable.val ((_ tuple.select 0) t)) 10)))))
(assert (= leftJoin5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map leftJoin2 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) DEPT))))) (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) DEPT))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map leftJoin5 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1) (set.filter p4 DEPT)))))) (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1) (set.filter p4 DEPT)))))))
(check-sat)
;answer: sat
; duration: 571 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 11) (nullable.some "B") (nullable.some "C") (nullable.some (- 3)) (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6))))
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (as set.empty (Set (Tuple (Nullable Int) (Nullable String)))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 11) (nullable.some "B") (nullable.some "C") (nullable.some (- 3)) (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))
; insert into EMP values(11,'B','C',-3,4,-4,5,-5,6)
; SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.EMPNO = 10) AS t LEFT JOIN DEPT AS DEPT ON t.EMPNO = DEPT.DEPTNO EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.EMPNO >= 10) AS t0 LEFT JOIN (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO = 10) AS t1 ON TRUE

; SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.EMPNO >= 10) AS t0 LEFT JOIN (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO = 10) AS t1 ON TRUE EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.EMPNO = 10) AS t LEFT JOIN DEPT AS DEPT ON t.EMPNO = DEPT.DEPTNO
;(11,B,C,-3,4,-4,5,-5,6,NULL,NULL)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testSwapOuterJoin
;Translating sql query: SELECT 1 FROM DEPT AS DEPT LEFT JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO
;Translating sql query: SELECT 1 FROM EMP AS EMP0 RIGHT JOIN DEPT AS DEPT0 ON EMP0.DEPTNO >= DEPT0.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const leftJoin1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const rightJoin4 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 0) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (>= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= rightJoin4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f2 (set.union (set.map leftJoin1 (set.minus DEPT ((_ rel.project 0 1) (set.filter p0 (rel.product DEPT EMP))))) (set.filter p0 (rel.product DEPT EMP))))))
(assert (= q2 (set.map f5 (set.union (set.map rightJoin4 (set.minus DEPT ((_ rel.project 9 10) (set.filter p3 (rel.product EMP DEPT))))) (set.filter p3 (rel.product EMP DEPT))))))
(check-sat)
;answer: unsat
; duration: 675 ms.
(reset)
;-----------------------------------------------------------
; test name: testPushJoinThroughUnionOnLeft
;Translating sql query: SELECT t.SAL FROM (SELECT * FROM EMP AS EMP UNION SELECT * FROM EMP AS EMP0) AS t, EMP AS EMP1
;Translating sql query: SELECT t1.SAL FROM (SELECT * FROM EMP AS EMP2, EMP AS EMP3 UNION ALL SELECT * FROM EMP AS EMP4, EMP AS EMP5) AS t1
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= q1 ((_ rel.project 6) (rel.product (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP) ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP)) EMP))))
(assert (= q2 ((_ rel.project 6) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) (rel.product EMP EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) (rel.product EMP EMP))))))
(check-sat)
;answer: unsat
; duration: 258 ms.
(reset)
;-----------------------------------------------------------
; test name: testMergeUnionMixed2
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
;Translating sql query: SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 20 UNION ALL SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

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
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 20)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 20)))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 30)))))
(assert (= q1 (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))
(assert (= q2 (set.union (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))
(check-sat)
;answer: sat
; duration: 883 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some (- 55)) (nullable.some "a") (nullable.some "b") (nullable.some 56) (nullable.some (- 56)) (nullable.some 57) (nullable.some (- 57)) (nullable.some 10) (nullable.some 58))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some (- 55)) (nullable.some "a") (nullable.some "b") (nullable.some 56) (nullable.some (- 56)) (nullable.some 57) (nullable.some (- 57)) (nullable.some 10) (nullable.some 58)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; insert into EMP values(-55,'a','b',56,-56,57,-57,10,58)
; SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30 EXCEPT ALL SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 20 UNION ALL SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
;(-55,a,b,56,-56,57,-57,10,58)

; SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 20 UNION ALL SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testReduceConstantsEliminatesFilter
;Translating sql query: SELECT * FROM (VALUES  (1, 2)) AS t WHERE 1 + 2 > 3 + CAST(NULL AS INT)
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES(0, 0))) AS t1
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1354905 Int) (BOUND_VARIABLE_1354906 Int)) (> BOUND_VARIABLE_1354905 BOUND_VARIABLE_1354906)) (nullable.some (+ 1 2)) (nullable.lift (lambda ((BOUND_VARIABLE_1354898 Int) (BOUND_VARIABLE_1354899 Int)) (+ BOUND_VARIABLE_1354898 BOUND_VARIABLE_1354899)) (nullable.some 3) (as nullable.null (Nullable Int))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1354905 Int) (BOUND_VARIABLE_1354906 Int)) (> BOUND_VARIABLE_1354905 BOUND_VARIABLE_1354906)) (nullable.some (+ 1 2)) (nullable.lift (lambda ((BOUND_VARIABLE_1354898 Int) (BOUND_VARIABLE_1354899 Int)) (+ BOUND_VARIABLE_1354898 BOUND_VARIABLE_1354899)) (nullable.some 3) (as nullable.null (Nullable Int)))))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 (set.singleton (tuple (nullable.some 1) (nullable.some 2)))))))
(assert (= q2 ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 0) (nullable.some 0))))))
(check-sat)
;answer: sat
; duration: 14 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 0) (nullable.some 0)))
; SELECT * FROM (VALUES  (1, 2)) AS t WHERE 1 + 2 > 3 + CAST(NULL AS INT) EXCEPT ALL SELECT * FROM (SELECT * FROM (VALUES(0, 0))) AS t1

; SELECT * FROM (SELECT * FROM (VALUES(0, 0))) AS t1 EXCEPT ALL SELECT * FROM (VALUES  (1, 2)) AS t WHERE 1 + 2 > 3 + CAST(NULL AS INT)
;(0,0)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testPushProjectPastFilter2*
;Translating sql query: SELECT EMP.MGR FROM EMP AS EMP WHERE CASE WHEN EMP.MGR < 10 THEN TRUE ELSE FALSE END
;Translating sql query: SELECT * FROM (SELECT EMP0.MGR FROM EMP AS EMP0) AS t2 WHERE t2.MGR <= 10
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 3) t)) (ite (< (nullable.val ((_ tuple.select 3) t)) 10) true false)))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (<= (nullable.val ((_ tuple.select 0) t)) 10)))))
(assert (= q1 ((_ rel.project 3) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0) (set.filter p1 ((_ rel.project 3) EMP)))))
(check-sat)
;answer: sat
; duration: 26 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 10) (nullable.some 0) (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 10)))
; insert into EMP values(NULL,NULL,'',10,0,1,-1,2,-2)
; SELECT EMP.MGR FROM EMP AS EMP WHERE CASE WHEN EMP.MGR < 10 THEN TRUE ELSE FALSE END EXCEPT ALL SELECT * FROM (SELECT EMP0.MGR FROM EMP AS EMP0) AS t2 WHERE t2.MGR <= 10

; SELECT * FROM (SELECT EMP0.MGR FROM EMP AS EMP0) AS t2 WHERE t2.MGR <= 10 EXCEPT ALL SELECT EMP.MGR FROM EMP AS EMP WHERE CASE WHEN EMP.MGR < 10 THEN TRUE ELSE FALSE END
;(10)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testSemiJoinReduceConstants
;Translating sql query: SELECT t0.SAL FROM (SELECT * FROM (SELECT EMP.SAL, EMP.DEPTNO FROM EMP AS EMP) AS t WHERE t.DEPTNO = 200) AS t0 INNER JOIN (SELECT t1.DEPTNO FROM (SELECT EMP0.SAL, EMP0.DEPTNO FROM EMP AS EMP0) AS t1 WHERE t1.SAL = 100) AS t3 ON t0.DEPTNO = t3.DEPTNO
;Translating sql query: SELECT t6.SAL FROM (SELECT * FROM (SELECT EMP1.SAL, EMP1.DEPTNO FROM EMP AS EMP1) AS t5 WHERE t5.DEPTNO >= 200) AS t6 INNER JOIN (SELECT t7.DEPTNO FROM (SELECT EMP2.SAL, EMP2.DEPTNO FROM EMP AS EMP2) AS t7 WHERE t7.SAL = 100) AS t9 ON t6.DEPTNO = t9.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 1) t)) (= (nullable.val ((_ tuple.select 1) t)) 200)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (= (nullable.val ((_ tuple.select 0) t)) 100)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 1) t)) (nullable.is_some ((_ tuple.select 2) t)) (= (nullable.val ((_ tuple.select 1) t)) (nullable.val ((_ tuple.select 2) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 1) t)) (>= (nullable.val ((_ tuple.select 1) t)) 200)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 0) t)) (= (nullable.val ((_ tuple.select 0) t)) 100)))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 1) t)) (nullable.is_some ((_ tuple.select 2) t)) (= (nullable.val ((_ tuple.select 1) t)) (nullable.val ((_ tuple.select 2) t)))))))
(assert (= q1 ((_ rel.project 0) (set.filter p2 (rel.product ((_ rel.project 0 1) (set.filter p0 ((_ rel.project 6 7) EMP))) ((_ rel.project 1) (set.filter p1 ((_ rel.project 6 7) EMP))))))))
(assert (= q2 ((_ rel.project 0) (set.filter p5 (rel.product ((_ rel.project 0 1) (set.filter p3 ((_ rel.project 6 7) EMP))) ((_ rel.project 1) (set.filter p4 ((_ rel.project 6 7) EMP))))))))
(check-sat)
;answer: sat
; duration: 1764 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some (- 17)) (nullable.some "I") (nullable.some "J") (nullable.some 18) (nullable.some (- 18)) (nullable.some 19) (as nullable.null (Nullable Int)) (nullable.some 201) (nullable.some (- 19)))) (set.union (set.singleton (tuple (nullable.some 14) (nullable.some "G") (nullable.some "H") (nullable.some (- 14)) (nullable.some 15) (nullable.some (- 15)) (nullable.some 100) (nullable.some 201) (nullable.some 16))) (set.union (set.singleton (tuple (nullable.some (- 11)) (nullable.some "E") (nullable.some "F") (nullable.some 12) (nullable.some (- 12)) (nullable.some 13) (as nullable.null (Nullable Int)) (nullable.some 201) (nullable.some (- 13)))) (set.union (set.singleton (tuple (nullable.some 9) (nullable.some "C") (nullable.some "D") (nullable.some (- 9)) (nullable.some 10) (nullable.some (- 10)) (as nullable.null (Nullable Int)) (nullable.some 201) (nullable.some 11))) (set.union (set.singleton (tuple (nullable.some (- 5)) (nullable.some "A") (nullable.some "B") (nullable.some 6) (nullable.some (- 6)) (nullable.some 7) (nullable.some 100) (nullable.some 200) (nullable.some (- 7)))) (set.singleton (tuple (nullable.some 3) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some (- 3)) (nullable.some 4) (nullable.some (- 4)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 5)))))))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 100)))
; q2
(get-value (q2))
; (set.union (set.singleton (tuple (nullable.some 100))) (set.singleton (tuple (as nullable.null (Nullable Int)))))
; insert into EMP values(-17,'I','J',18,-18,19,NULL,201,-19),(14,'G','H',-14,15,-15,100,201,16),(-11,'E','F',12,-12,13,NULL,201,-13),(9,'C','D',-9,10,-10,NULL,201,11),(-5,'A','B',6,-6,7,100,200,-7),(3,NULL,'',-3,4,-4,2,-2,5)
; SELECT t0.SAL FROM (SELECT * FROM (SELECT EMP.SAL, EMP.DEPTNO FROM EMP AS EMP) AS t WHERE t.DEPTNO = 200) AS t0 INNER JOIN (SELECT t1.DEPTNO FROM (SELECT EMP0.SAL, EMP0.DEPTNO FROM EMP AS EMP0) AS t1 WHERE t1.SAL = 100) AS t3 ON t0.DEPTNO = t3.DEPTNO EXCEPT ALL SELECT t6.SAL FROM (SELECT * FROM (SELECT EMP1.SAL, EMP1.DEPTNO FROM EMP AS EMP1) AS t5 WHERE t5.DEPTNO >= 200) AS t6 INNER JOIN (SELECT t7.DEPTNO FROM (SELECT EMP2.SAL, EMP2.DEPTNO FROM EMP AS EMP2) AS t7 WHERE t7.SAL = 100) AS t9 ON t6.DEPTNO = t9.DEPTNO

; SELECT t6.SAL FROM (SELECT * FROM (SELECT EMP1.SAL, EMP1.DEPTNO FROM EMP AS EMP1) AS t5 WHERE t5.DEPTNO >= 200) AS t6 INNER JOIN (SELECT t7.DEPTNO FROM (SELECT EMP2.SAL, EMP2.DEPTNO FROM EMP AS EMP2) AS t7 WHERE t7.SAL = 100) AS t9 ON t6.DEPTNO = t9.DEPTNO EXCEPT ALL SELECT t0.SAL FROM (SELECT * FROM (SELECT EMP.SAL, EMP.DEPTNO FROM EMP AS EMP) AS t WHERE t.DEPTNO = 200) AS t0 INNER JOIN (SELECT t1.DEPTNO FROM (SELECT EMP0.SAL, EMP0.DEPTNO FROM EMP AS EMP0) AS t1 WHERE t1.SAL = 100) AS t3 ON t0.DEPTNO = t3.DEPTNO
;(NULL)
;(NULL)
;(NULL)
;(100)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testEmptyJoinLeft
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE FALSE) AS t LEFT JOIN DEPT AS DEPT ON t.DEPTNO = DEPT.DEPTNO
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0,0,''))) AS t0
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const leftJoin2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) false)))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 9) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 9) t)))))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map leftJoin2 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) DEPT))))) (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) DEPT))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.singleton (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some ""))))))
(check-sat)
;answer: sat
; duration: 118 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))))
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (as set.empty (Set (Tuple (Nullable Int) (Nullable String)))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some "")))
; SELECT * FROM (SELECT * FROM EMP AS EMP WHERE FALSE) AS t LEFT JOIN DEPT AS DEPT ON t.DEPTNO = DEPT.DEPTNO EXCEPT ALL SELECT * FROM (SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0,0,''))) AS t0

; SELECT * FROM (SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0,0,''))) AS t0 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP WHERE FALSE) AS t LEFT JOIN DEPT AS DEPT ON t.DEPTNO = DEPT.DEPTNO
;(0,,,0,0,0,0,0,0,0,)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testReduceNestedCaseWhen
;Translating sql query: SELECT EMP.SAL FROM EMP AS EMP WHERE CASE WHEN EMP.SAL = 1000 THEN CASE WHEN EMP.SAL = 1000 THEN NULL ELSE 1 END IS NULL ELSE CASE WHEN EMP.SAL = 2000 THEN NULL ELSE 1 END IS NULL END IS TRUE
;Translating sql query: SELECT EMP0.SAL FROM EMP AS EMP0 WHERE CASE WHEN EMP0.SAL = 100 THEN EMP0.SAL = 1000 ELSE EMP0.SAL = 2000 END
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 6) t)) (nullable.is_some ((_ tuple.select 6) t)) (nullable.is_some ((_ tuple.select 6) t)) (ite (= (nullable.val ((_ tuple.select 6) t)) 1000) (nullable.is_null (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1368801 Int) (BOUND_VARIABLE_1368802 Int)) (= BOUND_VARIABLE_1368801 BOUND_VARIABLE_1368802)) ((_ tuple.select 6) t) (nullable.some 1000))) (as nullable.null (Nullable Int)) (nullable.some 1))) (nullable.is_null (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1368812 Int) (BOUND_VARIABLE_1368813 Int)) (= BOUND_VARIABLE_1368812 BOUND_VARIABLE_1368813)) ((_ tuple.select 6) t) (nullable.some 2000))) (as nullable.null (Nullable Int)) (nullable.some 1))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 6) t)) (nullable.is_some ((_ tuple.select 6) t)) (nullable.is_some ((_ tuple.select 6) t)) (ite (= (nullable.val ((_ tuple.select 6) t)) 100) (= (nullable.val ((_ tuple.select 6) t)) 1000) (= (nullable.val ((_ tuple.select 6) t)) 2000))))))
(assert (= q1 ((_ rel.project 6) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 6) (set.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 131 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 4) (nullable.some "A") (nullable.some "B") (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 1000) (nullable.some 6) (nullable.some (- 6)))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 1000)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; insert into EMP values(4,'A','B',-4,5,-5,1000,6,-6)
; SELECT EMP.SAL FROM EMP AS EMP WHERE CASE WHEN EMP.SAL = 1000 THEN CASE WHEN EMP.SAL = 1000 THEN NULL ELSE 1 END IS NULL ELSE CASE WHEN EMP.SAL = 2000 THEN NULL ELSE 1 END IS NULL END IS TRUE EXCEPT ALL SELECT EMP0.SAL FROM EMP AS EMP0 WHERE CASE WHEN EMP0.SAL = 100 THEN EMP0.SAL = 1000 ELSE EMP0.SAL = 2000 END
;(1000)

; SELECT EMP0.SAL FROM EMP AS EMP0 WHERE CASE WHEN EMP0.SAL = 100 THEN EMP0.SAL = 1000 ELSE EMP0.SAL = 2000 END EXCEPT ALL SELECT EMP.SAL FROM EMP AS EMP WHERE CASE WHEN EMP.SAL = 1000 THEN CASE WHEN EMP.SAL = 1000 THEN NULL ELSE 1 END IS NULL ELSE CASE WHEN EMP.SAL = 2000 THEN NULL ELSE 1 END IS NULL END IS TRUE

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testTransitiveInferenceRightOuterJoin
;Translating sql query: SELECT 1 FROM EMP AS EMP RIGHT JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 9) AS t ON EMP.DEPTNO = t.DEPTNO WHERE EMP.DEPTNO > 7
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 9) AS t2 RIGHT JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 9) AS t3 ON t2.DEPTNO = t3.DEPTNO WHERE t2.DEPTNO >= 7
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f10 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p9 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const rightJoin2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const rightJoin8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (> (nullable.val ((_ tuple.select 7) t)) 9)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 16) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 16) t)))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (> (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (>= (nullable.val ((_ tuple.select 7) t)) 9)))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (>= (nullable.val ((_ tuple.select 7) t)) 9)))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 16) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 16) t)))))))
(assert (= rightJoin8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (not (= q1 q2)))
(assert (= p9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (>= (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (= f10 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f4 (set.filter p3 (set.union (set.map rightJoin2 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 9 10 11 12 13 14 15 16 17) (set.filter p1 (rel.product EMP ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))))) (set.filter p1 (rel.product EMP ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)))))))))
(assert (= q2 (set.map f10 (set.filter p9 (set.union (set.map rightJoin8 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 EMP)) ((_ rel.project 9 10 11 12 13 14 15 16 17) (set.filter p7 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 EMP))))))) (set.filter p7 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 EMP)))))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10090 ms.
(reset)
;-----------------------------------------------------------
; test name: testTransitiveInferenceComplexPredicate
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7 AND EMP.COMM = EMP.DEPTNO AND EMP.COMM + EMP.DEPTNO > EMP.COMM / 2) AS t INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL = EMP0.DEPTNO) AS t0 ON t.DEPTNO = t0.DEPTNO
;Translating sql query: SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7 AND EMP1.COMM = EMP1.DEPTNO AND EMP1.COMM + EMP1.DEPTNO > EMP1.COMM / 2) AS t2 INNER JOIN (SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.SAL = EMP2.DEPTNO) AS t3 WHERE t3.DEPTNO >= 7) AS t4 ON t2.DEPTNO = t4.DEPTNO
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 5) t)) (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 5) t)) (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 5) t)) (and (> (nullable.val ((_ tuple.select 7) t)) 7) (= (nullable.val ((_ tuple.select 5) t)) (nullable.val ((_ tuple.select 7) t))) (> (+ (nullable.val ((_ tuple.select 5) t)) (nullable.val ((_ tuple.select 7) t))) (/ (nullable.val ((_ tuple.select 5) t)) 2)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 6) t)) (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 6) t)) (nullable.val ((_ tuple.select 7) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 16) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 16) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 5) t)) (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 5) t)) (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 5) t)) (and (>= (nullable.val ((_ tuple.select 7) t)) 7) (= (nullable.val ((_ tuple.select 5) t)) (nullable.val ((_ tuple.select 7) t))) (> (+ (nullable.val ((_ tuple.select 5) t)) (nullable.val ((_ tuple.select 7) t))) (/ (nullable.val ((_ tuple.select 5) t)) 2)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 6) t)) (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 6) t)) (nullable.val ((_ tuple.select 7) t)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (>= (nullable.val ((_ tuple.select 7) t)) 7)))))
(assert (not (= q1 q2)))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (nullable.is_some ((_ tuple.select 16) t)) (= (nullable.val ((_ tuple.select 7) t)) (nullable.val ((_ tuple.select 16) t)))))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f3 (set.filter p2 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))))))
(assert (= q2 (set.map f8 (set.filter p7 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))))))
(check-sat)
;answer: sat
; duration: 5060 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some (- 32)) (nullable.some "[") (nullable.some "\u{5c}") (nullable.some 33) (nullable.some (- 33)) (nullable.some 7) (nullable.some 7) (nullable.some 7) (nullable.some 34))) (set.union (set.singleton (tuple (nullable.some (- 30)) (nullable.some "Y") (nullable.some "Z") (nullable.some 31) (nullable.some (- 31)) (nullable.some 7) (nullable.some 7) (nullable.some 7) (nullable.some 32))) (set.union (set.singleton (tuple (nullable.some (- 24)) (nullable.some "S") (nullable.some "T") (nullable.some 25) (nullable.some (- 25)) (nullable.some 7) (nullable.some 7) (nullable.some 7) (nullable.some 26))) (set.singleton (tuple (nullable.some (- 22)) (nullable.some "Q") (nullable.some "R") (nullable.some 23) (nullable.some (- 23)) (nullable.some 7) (nullable.some 7) (nullable.some 7) (nullable.some 24)))))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 1)))
; insert into EMP values(-32,'[','\',33,-33,7,7,7,34),(-30,'Y','Z',31,-31,7,7,7,32),(-24,'S','T',25,-25,7,7,7,26),(-22,'Q','R',23,-23,7,7,7,24)
; SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7 AND EMP.COMM = EMP.DEPTNO AND EMP.COMM + EMP.DEPTNO > EMP.COMM / 2) AS t INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL = EMP0.DEPTNO) AS t0 ON t.DEPTNO = t0.DEPTNO EXCEPT ALL SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7 AND EMP1.COMM = EMP1.DEPTNO AND EMP1.COMM + EMP1.DEPTNO > EMP1.COMM / 2) AS t2 INNER JOIN (SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.SAL = EMP2.DEPTNO) AS t3 WHERE t3.DEPTNO >= 7) AS t4 ON t2.DEPTNO = t4.DEPTNO

; SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7 AND EMP1.COMM = EMP1.DEPTNO AND EMP1.COMM + EMP1.DEPTNO > EMP1.COMM / 2) AS t2 INNER JOIN (SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.SAL = EMP2.DEPTNO) AS t3 WHERE t3.DEPTNO >= 7) AS t4 ON t2.DEPTNO = t4.DEPTNO EXCEPT ALL SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7 AND EMP.COMM = EMP.DEPTNO AND EMP.COMM + EMP.DEPTNO > EMP.COMM / 2) AS t INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL = EMP0.DEPTNO) AS t0 ON t.DEPTNO = t0.DEPTNO
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testAlreadyFalseEliminatesFilter
;Translating sql query: SELECT * FROM (VALUES  (1, 2)) AS t WHERE FALSE
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES (0,0))) AS t1
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) false)))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 (set.singleton (tuple (nullable.some 1) (nullable.some 2)))))))
(assert (= q2 ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 0) (nullable.some 0))))))
(check-sat)
;answer: sat
; duration: 200 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 0) (nullable.some 0)))
; SELECT * FROM (VALUES  (1, 2)) AS t WHERE FALSE EXCEPT ALL SELECT * FROM (SELECT * FROM (VALUES (0,0))) AS t1

; SELECT * FROM (SELECT * FROM (VALUES (0,0))) AS t1 EXCEPT ALL SELECT * FROM (VALUES  (1, 2)) AS t WHERE FALSE
;(0,0)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testPullConstantThroughUnion2
;Translating sql query: SELECT 2, EMP.DEPTNO, EMP.JOB FROM EMP AS EMP UNION ALL SELECT 1, EMP0.DEPTNO, EMP0.JOB FROM EMP AS EMP0
;Translating sql query: SELECT 1, EMP1.DEPTNO, EMP1.JOB FROM EMP AS EMP1 UNION ALL SELECT 1, EMP2.DEPTNO, EMP2.JOB FROM EMP AS EMP2
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (not (= q1 q2)))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= q1 (set.union (set.map f0 EMP) (set.map f1 EMP))))
(assert (= q2 (set.union (set.map f2 EMP) (set.map f3 EMP))))
(check-sat)
;answer: sat
; duration: 54 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some (- 17)) (nullable.some "G") (nullable.some "D") (nullable.some 18) (nullable.some (- 18)) (nullable.some 19) (nullable.some (- 19)) (nullable.some 11) (nullable.some 20))) (set.union (set.singleton (tuple (nullable.some (- 14)) (nullable.some "F") (nullable.some "D") (nullable.some 15) (nullable.some (- 15)) (nullable.some 16) (nullable.some (- 16)) (nullable.some 11) (nullable.some 17))) (set.union (set.singleton (tuple (nullable.some (- 11)) (nullable.some "E") (nullable.some "D") (nullable.some 12) (nullable.some (- 12)) (nullable.some 13) (nullable.some (- 13)) (nullable.some 11) (nullable.some 14))) (set.singleton (tuple (nullable.some 8) (nullable.some "C") (nullable.some "D") (nullable.some (- 8)) (nullable.some 9) (nullable.some (- 9)) (nullable.some 10) (nullable.some 11) (nullable.some (- 10))))))))
; )
; q1
(get-value (q1))
; (set.union (set.singleton (tuple (nullable.some 2) (nullable.some 11) (nullable.some "D"))) (set.singleton (tuple (nullable.some 1) (nullable.some 11) (nullable.some "D"))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 1) (nullable.some 11) (nullable.some "D")))
; insert into EMP values(-17,'G','D',18,-18,19,-19,11,20),(-14,'F','D',15,-15,16,-16,11,17),(-11,'E','D',12,-12,13,-13,11,14),(8,'C','D',-8,9,-9,10,11,-10)
; SELECT 2, EMP.DEPTNO, EMP.JOB FROM EMP AS EMP UNION ALL SELECT 1, EMP0.DEPTNO, EMP0.JOB FROM EMP AS EMP0 EXCEPT ALL SELECT 1, EMP1.DEPTNO, EMP1.JOB FROM EMP AS EMP1 UNION ALL SELECT 1, EMP2.DEPTNO, EMP2.JOB FROM EMP AS EMP2
;(2,11,D)
;(2,11,D)
;(2,11,D)
;(2,11,D)
;(1,11,D)
;(1,11,D)
;(1,11,D)
;(1,11,D)

; SELECT 1, EMP1.DEPTNO, EMP1.JOB FROM EMP AS EMP1 UNION ALL SELECT 1, EMP2.DEPTNO, EMP2.JOB FROM EMP AS EMP2 EXCEPT ALL SELECT 2, EMP.DEPTNO, EMP.JOB FROM EMP AS EMP UNION ALL SELECT 1, EMP0.DEPTNO, EMP0.JOB FROM EMP AS EMP0
;(1,11,D)
;(1,11,D)
;(1,11,D)
;(1,11,D)
;(1,11,D)
;(1,11,D)
;(1,11,D)
;(1,11,D)
;(1,11,D)
;(1,11,D)
;(1,11,D)
;(1,11,D)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testPullConstantThroughUnion3
;Translating sql query: SELECT 2, 3 FROM EMP AS EMP UNION SELECT 2, 3 FROM EMP AS EMP0
;Translating sql query: SELECT 2, 3 FROM (SELECT 2 FROM EMP AS EMP1 UNION ALL SELECT 2 FROM EMP AS EMP2) AS t6
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
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
(assert (= q1 (set.union (set.map f0 EMP) (set.map f1 EMP))))
(assert (= q2 (set.map f4 (set.union (set.map f2 EMP) (set.map f3 EMP)))))
(check-sat)
;answer: unsat
; duration: 17 ms.
(reset)
;-----------------------------------------------------------
; test name: testMergeUnionMixed
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION ALL SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 10 UNION SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20) AS t6 UNION ALL SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

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
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (>= (nullable.val ((_ tuple.select 7) t)) 10)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 20)))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some ((_ tuple.select 7) t)) (= (nullable.val ((_ tuple.select 7) t)) 30)))))
(assert (= q1 (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))
(assert (= q2 (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))
(check-sat)
;answer: sat
; duration: 1020 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some (- 51)) (nullable.some "_") (nullable.some "`") (nullable.some 52) (nullable.some (- 52)) (nullable.some 53) (nullable.some (- 53)) (nullable.some 11) (nullable.some 54))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some (- 51)) (nullable.some "_") (nullable.some "`") (nullable.some 52) (nullable.some (- 52)) (nullable.some 53) (nullable.some (- 53)) (nullable.some 11) (nullable.some 54)))
; insert into EMP values(-51,'_','`',52,-52,53,-53,11,54)
; SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION ALL SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 10 UNION SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20) AS t6 UNION ALL SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30

; SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 10 UNION SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20) AS t6 UNION ALL SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION ALL SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30
;(-51,_,`,52,-52,53,-53,11,54)

;Model soundness: true
(reset)
; total time: 169323 ms.
