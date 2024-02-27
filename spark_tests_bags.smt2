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

(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_456 Int) (BOUND_VARIABLE_457 Int)) (> BOUND_VARIABLE_456 BOUND_VARIABLE_457)) (nullable.lift (lambda ((BOUND_VARIABLE_447 Int) (BOUND_VARIABLE_448 Int)) (+ BOUND_VARIABLE_447 BOUND_VARIABLE_448)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_456 Int) (BOUND_VARIABLE_457 Int)) (> BOUND_VARIABLE_456 BOUND_VARIABLE_457)) (nullable.lift (lambda ((BOUND_VARIABLE_447 Int) (BOUND_VARIABLE_448 Int)) (+ BOUND_VARIABLE_447 BOUND_VARIABLE_448)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 50)))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_494 Int) (BOUND_VARIABLE_495 Int)) (+ BOUND_VARIABLE_494 BOUND_VARIABLE_495)) (nullable.lift (lambda ((BOUND_VARIABLE_488 Int) (BOUND_VARIABLE_489 Int)) (+ BOUND_VARIABLE_488 BOUND_VARIABLE_489)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 0) t))))))
(assert (= q1 (bag.map f3 (bag.filter p2 (bag.union_disjoint (bag (tuple (nullable.some 10) (nullable.some 1)) 1) (bag (tuple (nullable.some 30) (nullable.some 3)) 1))))))
(assert (= q2 ((_ table.project 0) (bag.difference_remove ((_ table.project 0) (bag (tuple (nullable.some 0)) 1)) ((_ table.project 0) (bag (tuple (nullable.some 0)) 1))))))
(check-sat)
;answer: unsat
; duration: 37 ms.
(reset)
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

(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_705 Int) (BOUND_VARIABLE_706 Int)) (> BOUND_VARIABLE_705 BOUND_VARIABLE_706)) (nullable.lift (lambda ((BOUND_VARIABLE_699 Int) (BOUND_VARIABLE_700 Int)) (+ BOUND_VARIABLE_699 BOUND_VARIABLE_700)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_705 Int) (BOUND_VARIABLE_706 Int)) (> BOUND_VARIABLE_705 BOUND_VARIABLE_706)) (nullable.lift (lambda ((BOUND_VARIABLE_699 Int) (BOUND_VARIABLE_700 Int)) (+ BOUND_VARIABLE_699 BOUND_VARIABLE_700)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 30)))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p2 (bag.union_disjoint ((_ table.project 0 1) (bag.union_disjoint (bag (tuple (nullable.some 10) (nullable.some 1)) 1) (bag (tuple (nullable.some 30) (nullable.some 3)) 1))) ((_ table.project 0 1) (bag (tuple (nullable.some 20) (nullable.some 2)) 1)))))))
(assert (= q2 ((_ table.project 0 1) (bag (tuple (nullable.some 30) (nullable.some 3)) 1))))
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
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullableAnd (nullableAnd (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_975 Int) (BOUND_VARIABLE_976 Int)) (= BOUND_VARIABLE_975 BOUND_VARIABLE_976)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_982 Int) (BOUND_VARIABLE_983 Int)) (= BOUND_VARIABLE_982 BOUND_VARIABLE_983)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.some (nullable.is_null ((_ tuple.select 3) t)))) (nullable.lift (lambda ((BOUND_VARIABLE_991 Int) (BOUND_VARIABLE_992 Int)) (= BOUND_VARIABLE_991 BOUND_VARIABLE_992)) ((_ tuple.select 0) t) (nullable.some 10)))) (nullable.val (nullableAnd (nullableAnd (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_975 Int) (BOUND_VARIABLE_976 Int)) (= BOUND_VARIABLE_975 BOUND_VARIABLE_976)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_982 Int) (BOUND_VARIABLE_983 Int)) (= BOUND_VARIABLE_982 BOUND_VARIABLE_983)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.some (nullable.is_null ((_ tuple.select 3) t)))) (nullable.lift (lambda ((BOUND_VARIABLE_991 Int) (BOUND_VARIABLE_992 Int)) (= BOUND_VARIABLE_991 BOUND_VARIABLE_992)) ((_ tuple.select 0) t) (nullable.some 10))))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullableAnd (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_1022 Int) (BOUND_VARIABLE_1023 Int)) (= BOUND_VARIABLE_1022 BOUND_VARIABLE_1023)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.some (nullable.is_null ((_ tuple.select 3) t)))) (nullable.lift (lambda ((BOUND_VARIABLE_1032 Int) (BOUND_VARIABLE_1033 Int)) (= BOUND_VARIABLE_1032 BOUND_VARIABLE_1033)) ((_ tuple.select 0) t) (nullable.some 10)))) (nullable.val (nullableAnd (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_1022 Int) (BOUND_VARIABLE_1023 Int)) (= BOUND_VARIABLE_1022 BOUND_VARIABLE_1023)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.some (nullable.is_null ((_ tuple.select 3) t)))) (nullable.lift (lambda ((BOUND_VARIABLE_1032 Int) (BOUND_VARIABLE_1033 Int)) (= BOUND_VARIABLE_1032 BOUND_VARIABLE_1033)) ((_ tuple.select 0) t) (nullable.some 10))))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 10) ((_ tuple.select 1) t) ((_ tuple.select 2) t) (as nullable.null (Nullable Int)) ((_ tuple.select 4) t) ((_ tuple.select 6) t) ((_ tuple.select 5) t) (nullable.some 7) ((_ tuple.select 8) t)))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP))))
(assert (= q2 (bag.map f4 (bag.filter p3 EMP))))
(check-sat)
;answer: unknown (INCOMPLETE)
; duration: 669 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 10) (nullable.some "A") (nullable.some "B") (as nullable.null (Nullable Int)) (nullable.some (- 2)) (nullable.some 3) (nullable.some (- 3)) (nullable.some 7) (nullable.some 4)) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 10) (nullable.some "A") (nullable.some "B") (as nullable.null (Nullable Int)) (nullable.some (- 2)) (nullable.some 3) (nullable.some (- 3)) (nullable.some 7) (nullable.some 4)) 1)
; q2
(get-value (q2))
; (bag (tuple (nullable.some 10) (nullable.some "A") (nullable.some "B") (as nullable.null (Nullable Int)) (nullable.some (- 2)) (nullable.some (- 3)) (nullable.some 3) (nullable.some 7) (nullable.some 4)) 1)
; insert into EMP values(10,'A','B',NULL,-2,3,-3,7,4)
; SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 AND EMP.EMPNO = 10 AND EMP.MGR IS NULL AND EMP.EMPNO = 10) AS q1 EXCEPT ALL SELECT * FROM (SELECT 10 AS EMPNO, EMP0.ENAME, EMP0.JOB, CAST(NULL AS INT) AS MGR, EMP0.HIREDATE, EMP0.SAL, EMP0.COMM, 7 AS DEPTNO, EMP0.SLACKER FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 7 AND EMP0.MGR IS NULL AND EMP0.EMPNO = 10) AS q2;
;(10,A,B,NULL,-2,3,-3,7,4)

; SELECT * FROM (SELECT 10 AS EMPNO, EMP0.ENAME, EMP0.JOB, CAST(NULL AS INT) AS MGR, EMP0.HIREDATE, EMP0.SAL, EMP0.COMM, 7 AS DEPTNO, EMP0.SLACKER FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 7 AND EMP0.MGR IS NULL AND EMP0.EMPNO = 10) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 AND EMP.EMPNO = 10 AND EMP.MGR IS NULL AND EMP.EMPNO = 10) AS q1;
;(10,A,B,NULL,-2,-3,3,7,4)

;Model soundness: true
(reset)
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

(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_9998 Int) (BOUND_VARIABLE_9999 Int)) (< BOUND_VARIABLE_9998 BOUND_VARIABLE_9999)) (nullable.lift (lambda ((BOUND_VARIABLE_9990 Int) (BOUND_VARIABLE_9991 Int)) (- BOUND_VARIABLE_9990 BOUND_VARIABLE_9991)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 21))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_9998 Int) (BOUND_VARIABLE_9999 Int)) (< BOUND_VARIABLE_9998 BOUND_VARIABLE_9999)) (nullable.lift (lambda ((BOUND_VARIABLE_9990 Int) (BOUND_VARIABLE_9991 Int)) (- BOUND_VARIABLE_9990 BOUND_VARIABLE_9991)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 21)))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_10034 Int) (BOUND_VARIABLE_10035 Int)) (+ BOUND_VARIABLE_10034 BOUND_VARIABLE_10035)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= q1 (bag.map f3 (bag.filter p2 (bag.union_disjoint (bag.union_disjoint (bag (tuple (nullable.some 10) (nullable.some 1)) 1) (bag (tuple (nullable.some 30) (nullable.some 7)) 1)) (bag (tuple (nullable.some 20) (nullable.some 3)) 1))))))
(assert (= q2 ((_ table.project 0 1 2) (bag.union_disjoint (bag (tuple (nullable.some 11) (nullable.some 1) (nullable.some 10)) 1) (bag (tuple (nullable.some 23) (nullable.some 3) (nullable.some 20)) 1)))))
(check-sat)
;answer: unsat
; duration: 16 ms.
(reset)
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_10271 Int) (BOUND_VARIABLE_10272 Int)) (= BOUND_VARIABLE_10271 BOUND_VARIABLE_10272)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_10271 Int) (BOUND_VARIABLE_10272 Int)) (= BOUND_VARIABLE_10271 BOUND_VARIABLE_10272)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_10290 Int) (BOUND_VARIABLE_10291 Int)) (= BOUND_VARIABLE_10290 BOUND_VARIABLE_10291)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_10290 Int) (BOUND_VARIABLE_10291 Int)) (= BOUND_VARIABLE_10290 BOUND_VARIABLE_10291)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_10311 Int) (BOUND_VARIABLE_10312 Int)) (= BOUND_VARIABLE_10311 BOUND_VARIABLE_10312)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_10311 Int) (BOUND_VARIABLE_10312 Int)) (= BOUND_VARIABLE_10311 BOUND_VARIABLE_10312)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_10331 Int) (BOUND_VARIABLE_10332 Int)) (= BOUND_VARIABLE_10331 BOUND_VARIABLE_10332)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_10331 Int) (BOUND_VARIABLE_10332 Int)) (= BOUND_VARIABLE_10331 BOUND_VARIABLE_10332)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_10350 Int) (BOUND_VARIABLE_10351 Int)) (= BOUND_VARIABLE_10350 BOUND_VARIABLE_10351)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_10350 Int) (BOUND_VARIABLE_10351 Int)) (= BOUND_VARIABLE_10350 BOUND_VARIABLE_10351)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_10370 Int) (BOUND_VARIABLE_10371 Int)) (= BOUND_VARIABLE_10370 BOUND_VARIABLE_10371)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_10370 Int) (BOUND_VARIABLE_10371 Int)) (= BOUND_VARIABLE_10370 BOUND_VARIABLE_10371)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)))))
(assert (= q2 (bag.difference_remove (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p6 EMP))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p7 EMP)))))
(check-sat)
;answer: unsat
; duration: 590 ms.
(reset)
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

(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_17018 Int) (BOUND_VARIABLE_17019 Int)) (> BOUND_VARIABLE_17018 BOUND_VARIABLE_17019)) ((_ tuple.select 0) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_17018 Int) (BOUND_VARIABLE_17019 Int)) (> BOUND_VARIABLE_17018 BOUND_VARIABLE_17019)) ((_ tuple.select 0) t) (nullable.some 30)))))))
(assert (= q1 (bag.difference_remove ((_ table.project 0 1) (bag.difference_remove ((_ table.project 0 1) (bag.filter p2 (bag (tuple (nullable.some 30) (nullable.some 3)) 1))) ((_ table.project 0 1) (bag (tuple (nullable.some 20) (nullable.some 2)) 1)))) ((_ table.project 0 1) (bag (tuple (nullable.some 40) (nullable.some 4)) 1)))))
(assert (= q2 ((_ table.project 0 1) (bag.difference_remove ((_ table.project 0 1) (bag (tuple (nullable.some 0) (nullable.some 0)) 1)) ((_ table.project 0 1) (bag (tuple (nullable.some 0) (nullable.some 0)) 1))))))
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
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_17193 Int) (BOUND_VARIABLE_17194 Int)) (+ BOUND_VARIABLE_17193 BOUND_VARIABLE_17194)) ((_ tuple.select 0) t) ((_ tuple.select 1) t))))))
(assert (= q1 (bag.map f2 (bag.union_disjoint (bag (tuple (nullable.some 10) (nullable.some 1)) 1) (bag (tuple (nullable.some 20) (nullable.some 3)) 1)))))
(assert (= q2 ((_ table.project 0) (bag.union_disjoint (bag (tuple (nullable.some 11)) 1) (bag (tuple (nullable.some 23)) 1)))))
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
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_17343 Int) (BOUND_VARIABLE_17344 Int)) (< BOUND_VARIABLE_17343 BOUND_VARIABLE_17344)) ((_ tuple.select 0) t) (nullable.some 15))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_17343 Int) (BOUND_VARIABLE_17344 Int)) (< BOUND_VARIABLE_17343 BOUND_VARIABLE_17344)) ((_ tuple.select 0) t) (nullable.some 15)))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p2 (bag.union_disjoint (bag (tuple (nullable.some 10) (nullable.some "x")) 1) (bag (tuple (nullable.some 20) (nullable.some "y")) 1))))))
(assert (= q2 ((_ table.project 0 1) (bag (tuple (nullable.some 10) (nullable.some "x")) 1))))
(check-sat)
;answer: unsat
; duration: 8 ms.
(reset)
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
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_17504 Int) (BOUND_VARIABLE_17505 Int)) (= BOUND_VARIABLE_17504 BOUND_VARIABLE_17505)) ((_ tuple.select 0) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_17511 Int) (BOUND_VARIABLE_17512 Int)) (= BOUND_VARIABLE_17511 BOUND_VARIABLE_17512)) ((_ tuple.select 0) t) (nullable.some 8)))) (nullable.val (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_17504 Int) (BOUND_VARIABLE_17505 Int)) (= BOUND_VARIABLE_17504 BOUND_VARIABLE_17505)) ((_ tuple.select 0) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_17511 Int) (BOUND_VARIABLE_17512 Int)) (= BOUND_VARIABLE_17511 BOUND_VARIABLE_17512)) ((_ tuple.select 0) t) (nullable.some 8))))))))
(assert (= q1 ((_ table.project 0) (bag.filter p2 DEPT))))
(assert (= q2 ((_ table.project 0) (bag.difference_remove ((_ table.project 0 1) (bag (tuple (nullable.some 0) (nullable.some 0)) 1)) ((_ table.project 0 1) (bag (tuple (nullable.some 0) (nullable.some 0)) 1))))))
(check-sat)
;answer: unsat
; duration: 50 ms.
(reset)
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
(declare-const q1 (Bag (Tuple (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_18670 Int) (BOUND_VARIABLE_18671 Int)) (= BOUND_VARIABLE_18670 BOUND_VARIABLE_18671)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_18670 Int) (BOUND_VARIABLE_18671 Int)) (= BOUND_VARIABLE_18670 BOUND_VARIABLE_18671)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_18704 Int) (BOUND_VARIABLE_18705 Int)) (= BOUND_VARIABLE_18704 BOUND_VARIABLE_18705)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_18704 Int) (BOUND_VARIABLE_18705 Int)) (= BOUND_VARIABLE_18704 BOUND_VARIABLE_18705)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ table.project 1) (bag.filter p2 (table.product EMP DEPT)))))
(assert (= q2 ((_ table.project 1) (bag.filter p3 (table.product EMP DEPT)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10009 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 13) (nullable.some "I") (nullable.some "K") (nullable.some (- 13)) (nullable.some 14) (nullable.some (- 14)) (nullable.some 15) (nullable.some (- 4)) (nullable.some (- 15))) 30))
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag.union_disjoint (bag (tuple (nullable.some (- 4)) (nullable.some "F")) 17) (bag (tuple (nullable.some (- 4)) (nullable.some "H")) 18)))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some "I")) 1050)
; q2
(get-value (q2))
; (bag (tuple (nullable.some "I")) 1050)
; insert into EMP values(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15),(13,'I','K',-13,14,-14,15,-4,-15)
; insert into DEPT values(-4,'F'),(-4,'F'),(-4,'F'),(-4,'F'),(-4,'F'),(-4,'F'),(-4,'F'),(-4,'F'),(-4,'F'),(-4,'F'),(-4,'F'),(-4,'F'),(-4,'F'),(-4,'F'),(-4,'F'),(-4,'F'),(-4,'F'),(-4,'H'),(-4,'H'),(-4,'H'),(-4,'H'),(-4,'H'),(-4,'H'),(-4,'H'),(-4,'H'),(-4,'H'),(-4,'H'),(-4,'H'),(-4,'H'),(-4,'H'),(-4,'H'),(-4,'H'),(-4,'H'),(-4,'H'),(-4,'H')
; SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT EMP0.ENAME FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO) AS q2;

; SELECT * FROM (SELECT EMP0.ENAME FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO) AS q1;

;Model soundness: false
(reset)
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
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.some 2) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= q1 (bag.union_disjoint (bag.map f2 EMP) (bag.map f3 EMP))))
(assert (= q2 (bag.map f4 (bag.union_disjoint ((_ table.project 7 2) EMP) ((_ table.project 7 2) EMP)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10129 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (nullable.some "B") (nullable.some 0) (nullable.some 1) (nullable.some (- 1)) (nullable.some (- 2)) (nullable.some 7) (nullable.some 3)) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 2) (nullable.some 7) (nullable.some "B")) 2)
; q2
(get-value (q2))
; (bag (tuple (nullable.some 2) (nullable.some 7) (nullable.some "B")) 2)
; insert into EMP values(NULL,NULL,'B',0,1,-1,-2,7,3)
; SELECT * FROM (SELECT 2, EMP.DEPTNO, EMP.JOB FROM EMP AS EMP UNION ALL SELECT 2, EMP0.DEPTNO, EMP0.JOB FROM EMP AS EMP0) AS q1 EXCEPT ALL SELECT * FROM (SELECT 2, t6.DEPTNO, t6.JOB FROM (SELECT EMP1.DEPTNO, EMP1.JOB FROM EMP AS EMP1 UNION ALL SELECT EMP2.DEPTNO, EMP2.JOB FROM EMP AS EMP2) AS t6) AS q2;

; SELECT * FROM (SELECT 2, t6.DEPTNO, t6.JOB FROM (SELECT EMP1.DEPTNO, EMP1.JOB FROM EMP AS EMP1 UNION ALL SELECT EMP2.DEPTNO, EMP2.JOB FROM EMP AS EMP2) AS t6) AS q2 EXCEPT ALL SELECT * FROM (SELECT 2, EMP.DEPTNO, EMP.JOB FROM EMP AS EMP UNION ALL SELECT 2, EMP0.DEPTNO, EMP0.JOB FROM EMP AS EMP0) AS q1;

;Model soundness: false
(reset)
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
(declare-const q2 (Bag (Tuple (Nullable Bool))))
(declare-const p3 (-> (Tuple (Nullable Bool)) Bool))
(declare-const p5 (-> (Tuple (Nullable Bool)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Bool))))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Bool))))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullableAnd (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_107763 Int) (BOUND_VARIABLE_107764 Int)) (> BOUND_VARIABLE_107763 BOUND_VARIABLE_107764)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_107763 Int) (BOUND_VARIABLE_107764 Int)) (> BOUND_VARIABLE_107763 BOUND_VARIABLE_107764)) ((_ tuple.select 6) t) (nullable.some 1000))))) (as nullable.null (Nullable Bool)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_107789 Bool)) (not BOUND_VARIABLE_107789)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_107789 Bool)) (not BOUND_VARIABLE_107789)) ((_ tuple.select 0) t)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullableAnd (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_107809 Int) (BOUND_VARIABLE_107810 Int)) (> BOUND_VARIABLE_107809 BOUND_VARIABLE_107810)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_107809 Int) (BOUND_VARIABLE_107810 Int)) (> BOUND_VARIABLE_107809 BOUND_VARIABLE_107810)) ((_ tuple.select 6) t) (nullable.some 1000))))) (as nullable.null (Nullable Bool)))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p5 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_107833 Bool)) (not BOUND_VARIABLE_107833)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_107833 Bool)) (not BOUND_VARIABLE_107833)) ((_ tuple.select 0) t)))))))
(assert (= q1 ((_ table.project 0) (bag.filter p3 (bag.map f2 EMP)))))
(assert (= q2 ((_ table.project 0) (bag.filter p5 (bag.map f4 EMP)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10137 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag.union_disjoint (bag (tuple (nullable.some (- 3)) (nullable.some "A") (nullable.some "B") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (as nullable.null (Nullable Int)) (nullable.some (- 5)) (nullable.some 6)) 1) (bag (tuple (nullable.some (- 9)) (nullable.some "E") (nullable.some "F") (nullable.some 10) (nullable.some (- 10)) (nullable.some 11) (as nullable.null (Nullable Int)) (nullable.some (- 11)) (nullable.some 12)) 1)))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some false)) 2)
; q2
(get-value (q2))
; (bag (tuple (nullable.some false)) 2)
; insert into EMP values(-3,'A','B',4,-4,5,NULL,-5,6),(-9,'E','F',10,-10,11,NULL,-11,12)
; SELECT * FROM (SELECT * FROM (SELECT CASE WHEN EMP.SAL > 1000 THEN NULL ELSE FALSE END AS CASECOL FROM EMP AS EMP) AS t WHERE NOT t.CASECOL) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT CASE WHEN EMP0.SAL > 1000 THEN NULL ELSE FALSE END AS CASECOL FROM EMP AS EMP0) AS t1 WHERE NOT t1.CASECOL) AS q2;

; SELECT * FROM (SELECT * FROM (SELECT CASE WHEN EMP0.SAL > 1000 THEN NULL ELSE FALSE END AS CASECOL FROM EMP AS EMP0) AS t1 WHERE NOT t1.CASECOL) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT CASE WHEN EMP.SAL > 1000 THEN NULL ELSE FALSE END AS CASECOL FROM EMP AS EMP) AS t WHERE NOT t.CASECOL) AS q1;

;Model soundness: false
(reset)
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const f6 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String))))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)) Bool))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String))))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const f5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_142797 String) (BOUND_VARIABLE_142798 String)) (= BOUND_VARIABLE_142797 BOUND_VARIABLE_142798)) ((_ tuple.select 2) t) ((_ tuple.select 1) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_142797 String) (BOUND_VARIABLE_142798 String)) (= BOUND_VARIABLE_142797 BOUND_VARIABLE_142798)) ((_ tuple.select 2) t) ((_ tuple.select 1) t)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_142822 String) (BOUND_VARIABLE_142823 String)) (= BOUND_VARIABLE_142822 BOUND_VARIABLE_142823)) ((_ tuple.select 2) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_142830 Int) (BOUND_VARIABLE_142831 Int)) (= BOUND_VARIABLE_142830 BOUND_VARIABLE_142831)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))) (nullable.val (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_142822 String) (BOUND_VARIABLE_142823 String)) (= BOUND_VARIABLE_142822 BOUND_VARIABLE_142823)) ((_ tuple.select 2) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_142830 Int) (BOUND_VARIABLE_142831 Int)) (= BOUND_VARIABLE_142830 BOUND_VARIABLE_142831)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 2) t)))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_142979 String) (BOUND_VARIABLE_142980 String)) (= BOUND_VARIABLE_142979 BOUND_VARIABLE_142980)) ((_ tuple.select 9) t) ((_ tuple.select 12) t)) (nullable.lift (lambda ((BOUND_VARIABLE_142987 Int) (BOUND_VARIABLE_142988 Int)) (= BOUND_VARIABLE_142987 BOUND_VARIABLE_142988)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)))) (nullable.val (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_142979 String) (BOUND_VARIABLE_142980 String)) (= BOUND_VARIABLE_142979 BOUND_VARIABLE_142980)) ((_ tuple.select 9) t) ((_ tuple.select 12) t)) (nullable.lift (lambda ((BOUND_VARIABLE_142987 Int) (BOUND_VARIABLE_142988 Int)) (= BOUND_VARIABLE_142987 BOUND_VARIABLE_142988)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))))))
(assert (= q1 ((_ table.project 6) (bag.filter p4 (table.product EMP ((_ table.project 0 1) ((_ table.project 0 2) (bag.filter p3 (bag.map f2 DEPT)))))))))
(assert (= q2 ((_ table.project 6) (bag.filter p7 (table.product (bag.map f5 EMP) (bag.map f6 DEPT))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10099 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))))
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 3) (nullable.some "")) 7))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; insert into DEPT values(3,''),(3,''),(3,''),(3,''),(3,''),(3,''),(3,'')
; SELECT * FROM (SELECT EMP.SAL FROM EMP AS EMP WHERE EMP.EMPNO IN (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE EMP.JOB = DEPT.NAME)) AS q1 EXCEPT ALL SELECT * FROM (SELECT EMP0.SAL FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.JOB = DEPT0.NAME AND EMP0.EMPNO = DEPT0.DEPTNO) AS q2;

; SELECT * FROM (SELECT EMP0.SAL FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.JOB = DEPT0.NAME AND EMP0.EMPNO = DEPT0.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.SAL FROM EMP AS EMP WHERE EMP.EMPNO IN (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE EMP.JOB = DEPT.NAME)) AS q1;

;Model soundness: false
(reset)
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

(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_213696 Int) (BOUND_VARIABLE_213697 Int)) (> BOUND_VARIABLE_213696 BOUND_VARIABLE_213697)) (nullable.lift (lambda ((BOUND_VARIABLE_213683 Int) (BOUND_VARIABLE_213684 Int)) (+ BOUND_VARIABLE_213683 BOUND_VARIABLE_213684)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_213690 Int) (BOUND_VARIABLE_213691 Int)) (+ BOUND_VARIABLE_213690 BOUND_VARIABLE_213691)) (nullable.some 3) (as nullable.null (Nullable Int))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_213696 Int) (BOUND_VARIABLE_213697 Int)) (> BOUND_VARIABLE_213696 BOUND_VARIABLE_213697)) (nullable.lift (lambda ((BOUND_VARIABLE_213683 Int) (BOUND_VARIABLE_213684 Int)) (+ BOUND_VARIABLE_213683 BOUND_VARIABLE_213684)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_213690 Int) (BOUND_VARIABLE_213691 Int)) (+ BOUND_VARIABLE_213690 BOUND_VARIABLE_213691)) (nullable.some 3) (as nullable.null (Nullable Int)))))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_213725 Int) (BOUND_VARIABLE_213726 Int)) (> BOUND_VARIABLE_213725 BOUND_VARIABLE_213726)) (nullable.lift (lambda ((BOUND_VARIABLE_213713 Int) (BOUND_VARIABLE_213714 Int)) (+ BOUND_VARIABLE_213713 BOUND_VARIABLE_213714)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_213719 Int) (BOUND_VARIABLE_213720 Int)) (+ BOUND_VARIABLE_213719 BOUND_VARIABLE_213720)) (nullable.some 3) (as nullable.null (Nullable Int))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_213725 Int) (BOUND_VARIABLE_213726 Int)) (> BOUND_VARIABLE_213725 BOUND_VARIABLE_213726)) (nullable.lift (lambda ((BOUND_VARIABLE_213713 Int) (BOUND_VARIABLE_213714 Int)) (+ BOUND_VARIABLE_213713 BOUND_VARIABLE_213714)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_213719 Int) (BOUND_VARIABLE_213720 Int)) (+ BOUND_VARIABLE_213719 BOUND_VARIABLE_213720)) (nullable.some 3) (as nullable.null (Nullable Int)))))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p2 (bag (tuple (nullable.some 1) (nullable.some 2)) 1)))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p3 (bag (tuple (nullable.some 1) (nullable.some 2)) 1)))))
(check-sat)
;answer: unsat
; duration: 148 ms.
(reset)
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
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_213877 Int) (BOUND_VARIABLE_213878 Int)) (= BOUND_VARIABLE_213877 BOUND_VARIABLE_213878)) ((_ tuple.select 3) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_213877 Int) (BOUND_VARIABLE_213878 Int)) (= BOUND_VARIABLE_213877 BOUND_VARIABLE_213878)) ((_ tuple.select 3) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_213897 Int) (BOUND_VARIABLE_213898 Int)) (= BOUND_VARIABLE_213897 BOUND_VARIABLE_213898)) ((_ tuple.select 3) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_213897 Int) (BOUND_VARIABLE_213898 Int)) (= BOUND_VARIABLE_213897 BOUND_VARIABLE_213898)) ((_ tuple.select 3) t) (nullable.some 10)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 10)))))
(assert (= q1 ((_ table.project 3) (bag.filter p2 EMP))))
(assert (= q2 (bag.map f4 (bag.filter p3 EMP))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10009 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag.union_disjoint (bag (tuple (nullable.some (- 3)) (nullable.some "A") (nullable.some "B") (nullable.some 10) (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6)) 2) (bag.union_disjoint (bag (tuple (nullable.some (- 9)) (nullable.some "E") (nullable.some "F") (nullable.some 10) (nullable.some (- 10)) (nullable.some 11) (nullable.some (- 11)) (nullable.some 12) (nullable.some (- 12))) 1) (bag.union_disjoint (bag (tuple (nullable.some 13) (nullable.some "G") (nullable.some "H") (nullable.some 10) (nullable.some (- 13)) (nullable.some 14) (nullable.some (- 14)) (nullable.some 15) (nullable.some (- 15))) 1) (bag (tuple (nullable.some 16) (nullable.some "I") (nullable.some "J") (nullable.some 10) (nullable.some (- 16)) (nullable.some 17) (nullable.some (- 17)) (nullable.some 18) (nullable.some (- 18))) 2)))))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 10)) 6)
; q2
(get-value (q2))
; (bag (tuple (nullable.some 10)) 6)
; insert into EMP values(-3,'A','B',10,4,-4,5,-5,6),(-3,'A','B',10,4,-4,5,-5,6),(-9,'E','F',10,-10,11,-11,12,-12),(13,'G','H',10,-13,14,-14,15,-15),(16,'I','J',10,-16,17,-17,18,-18),(16,'I','J',10,-16,17,-17,18,-18)
; SELECT * FROM (SELECT EMP.MGR FROM EMP AS EMP WHERE EMP.MGR = 10) AS q1 EXCEPT ALL SELECT * FROM (SELECT 10 AS MGR FROM EMP AS EMP0 WHERE EMP0.MGR = 10) AS q2;

; SELECT * FROM (SELECT 10 AS MGR FROM EMP AS EMP0 WHERE EMP0.MGR = 10) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.MGR FROM EMP AS EMP WHERE EMP.MGR = 10) AS q1;

;Model soundness: false
(reset)
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
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const f7 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_243795 Int) (BOUND_VARIABLE_243796 Int)) (> BOUND_VARIABLE_243795 BOUND_VARIABLE_243796)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_243795 Int) (BOUND_VARIABLE_243796 Int)) (> BOUND_VARIABLE_243795 BOUND_VARIABLE_243796)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_243858 Int) (BOUND_VARIABLE_243859 Int)) (= BOUND_VARIABLE_243858 BOUND_VARIABLE_243859)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_243858 Int) (BOUND_VARIABLE_243859 Int)) (= BOUND_VARIABLE_243858 BOUND_VARIABLE_243859)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_243887 Int) (BOUND_VARIABLE_243888 Int)) (> BOUND_VARIABLE_243887 BOUND_VARIABLE_243888)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_243887 Int) (BOUND_VARIABLE_243888 Int)) (> BOUND_VARIABLE_243887 BOUND_VARIABLE_243888)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_243908 Int) (BOUND_VARIABLE_243909 Int)) (= BOUND_VARIABLE_243908 BOUND_VARIABLE_243909)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_243908 Int) (BOUND_VARIABLE_243909 Int)) (= BOUND_VARIABLE_243908 BOUND_VARIABLE_243909)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f7 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f4 (bag.filter p3 (table.product ((_ table.project 5) (bag.filter p2 EMP)) EMP)))))
(assert (= q2 (bag.map f7 (bag.filter p6 (table.product ((_ table.project 5) (bag.filter p5 EMP)) EMP)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10063 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; SELECT * FROM (SELECT 1 FROM (SELECT EMP.COMM AS DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO > 7) AS t0 INNER JOIN EMP AS EMP0 ON t0.DEPTNO = EMP0.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT EMP1.COMM AS DEPTNO FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t3 INNER JOIN EMP AS EMP2 ON t3.DEPTNO = EMP2.DEPTNO) AS q2;

; SELECT * FROM (SELECT 1 FROM (SELECT EMP1.COMM AS DEPTNO FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t3 INNER JOIN EMP AS EMP2 ON t3.DEPTNO = EMP2.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT EMP.COMM AS DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO > 7) AS t0 INNER JOIN EMP AS EMP0 ON t0.DEPTNO = EMP0.DEPTNO) AS q1;

;Model soundness: false
(reset)
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
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f11 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p9 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p10 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_293238 Int) (BOUND_VARIABLE_293239 Int)) (> BOUND_VARIABLE_293238 BOUND_VARIABLE_293239)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_293238 Int) (BOUND_VARIABLE_293239 Int)) (> BOUND_VARIABLE_293238 BOUND_VARIABLE_293239)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_293324 Int) (BOUND_VARIABLE_293325 Int)) (= BOUND_VARIABLE_293324 BOUND_VARIABLE_293325)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_293324 Int) (BOUND_VARIABLE_293325 Int)) (= BOUND_VARIABLE_293324 BOUND_VARIABLE_293325)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_293437 Int) (BOUND_VARIABLE_293438 Int)) (= BOUND_VARIABLE_293437 BOUND_VARIABLE_293438)) ((_ tuple.select 16) t) ((_ tuple.select 25) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_293437 Int) (BOUND_VARIABLE_293438 Int)) (= BOUND_VARIABLE_293437 BOUND_VARIABLE_293438)) ((_ tuple.select 16) t) ((_ tuple.select 25) t)))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_293465 Int) (BOUND_VARIABLE_293466 Int)) (> BOUND_VARIABLE_293465 BOUND_VARIABLE_293466)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_293465 Int) (BOUND_VARIABLE_293466 Int)) (> BOUND_VARIABLE_293465 BOUND_VARIABLE_293466)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_293484 Int) (BOUND_VARIABLE_293485 Int)) (> BOUND_VARIABLE_293484 BOUND_VARIABLE_293485)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_293484 Int) (BOUND_VARIABLE_293485 Int)) (> BOUND_VARIABLE_293484 BOUND_VARIABLE_293485)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_293505 Int) (BOUND_VARIABLE_293506 Int)) (= BOUND_VARIABLE_293505 BOUND_VARIABLE_293506)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_293505 Int) (BOUND_VARIABLE_293506 Int)) (= BOUND_VARIABLE_293505 BOUND_VARIABLE_293506)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= p9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_293523 Int) (BOUND_VARIABLE_293524 Int)) (> BOUND_VARIABLE_293523 BOUND_VARIABLE_293524)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_293523 Int) (BOUND_VARIABLE_293524 Int)) (> BOUND_VARIABLE_293523 BOUND_VARIABLE_293524)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p10 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_293544 Int) (BOUND_VARIABLE_293545 Int)) (= BOUND_VARIABLE_293544 BOUND_VARIABLE_293545)) ((_ tuple.select 16) t) ((_ tuple.select 25) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_293544 Int) (BOUND_VARIABLE_293545 Int)) (= BOUND_VARIABLE_293544 BOUND_VARIABLE_293545)) ((_ tuple.select 16) t) ((_ tuple.select 25) t)))))))
(assert (= f11 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f5 (bag.filter p4 (table.product (bag.filter p3 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)) EMP)) EMP)))))
(assert (= q2 (bag.map f11 (bag.filter p10 (table.product (bag.filter p8 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p6 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p7 EMP)))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p9 EMP)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10194 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag.union_disjoint (bag (tuple (nullable.some (- 40)) (nullable.some "Y") (nullable.some "Z") (nullable.some 41) (nullable.some (- 41)) (nullable.some 42) (nullable.some (- 42)) (as nullable.null (Nullable Int)) (nullable.some 43)) 22) (bag (tuple (nullable.some (- 34)) (nullable.some "U") (nullable.some "V") (nullable.some 35) (nullable.some (- 35)) (nullable.some 36) (nullable.some (- 36)) (nullable.some (- 89)) (nullable.some 37)) 5)))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; insert into EMP values(-40,'Y','Z',41,-41,42,-42,NULL,43),(-40,'Y','Z',41,-41,42,-42,NULL,43),(-40,'Y','Z',41,-41,42,-42,NULL,43),(-40,'Y','Z',41,-41,42,-42,NULL,43),(-40,'Y','Z',41,-41,42,-42,NULL,43),(-40,'Y','Z',41,-41,42,-42,NULL,43),(-40,'Y','Z',41,-41,42,-42,NULL,43),(-40,'Y','Z',41,-41,42,-42,NULL,43),(-40,'Y','Z',41,-41,42,-42,NULL,43),(-40,'Y','Z',41,-41,42,-42,NULL,43),(-40,'Y','Z',41,-41,42,-42,NULL,43),(-40,'Y','Z',41,-41,42,-42,NULL,43),(-40,'Y','Z',41,-41,42,-42,NULL,43),(-40,'Y','Z',41,-41,42,-42,NULL,43),(-40,'Y','Z',41,-41,42,-42,NULL,43),(-40,'Y','Z',41,-41,42,-42,NULL,43),(-40,'Y','Z',41,-41,42,-42,NULL,43),(-40,'Y','Z',41,-41,42,-42,NULL,43),(-40,'Y','Z',41,-41,42,-42,NULL,43),(-40,'Y','Z',41,-41,42,-42,NULL,43),(-40,'Y','Z',41,-41,42,-42,NULL,43),(-40,'Y','Z',41,-41,42,-42,NULL,43),(-34,'U','V',35,-35,36,-36,-89,37),(-34,'U','V',35,-35,36,-36,-89,37),(-34,'U','V',35,-35,36,-36,-89,37),(-34,'U','V',35,-35,36,-36,-89,37),(-34,'U','V',35,-35,36,-36,-89,37)
; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO INNER JOIN EMP AS EMP1 ON EMP0.DEPTNO = EMP1.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO INNER JOIN (SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 7) AS t3 ON t2.DEPTNO = t3.DEPTNO) AS q2;

; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO INNER JOIN (SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 7) AS t3 ON t2.DEPTNO = t3.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO INNER JOIN EMP AS EMP1 ON EMP0.DEPTNO = EMP1.DEPTNO) AS q1;

;Model soundness: false
(reset)
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Bag (Tuple (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_336573 Int) (BOUND_VARIABLE_336574 Int)) (= BOUND_VARIABLE_336573 BOUND_VARIABLE_336574)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_336580 Int) (BOUND_VARIABLE_336581 Int)) (= BOUND_VARIABLE_336580 BOUND_VARIABLE_336581)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)))) (nullable.val (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_336573 Int) (BOUND_VARIABLE_336574 Int)) (= BOUND_VARIABLE_336573 BOUND_VARIABLE_336574)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_336580 Int) (BOUND_VARIABLE_336581 Int)) (= BOUND_VARIABLE_336580 BOUND_VARIABLE_336581)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_336607 Int) (BOUND_VARIABLE_336608 Int)) (= BOUND_VARIABLE_336607 BOUND_VARIABLE_336608)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_336607 Int) (BOUND_VARIABLE_336608 Int)) (= BOUND_VARIABLE_336607 BOUND_VARIABLE_336608)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_336627 Int) (BOUND_VARIABLE_336628 Int)) (= BOUND_VARIABLE_336627 BOUND_VARIABLE_336628)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_336627 Int) (BOUND_VARIABLE_336628 Int)) (= BOUND_VARIABLE_336627 BOUND_VARIABLE_336628)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)))))))
(assert (= q1 ((_ table.project 1) (bag.filter p2 (table.product (table.product EMP DEPT) EMP)))))
(assert (= q2 ((_ table.project 1) (bag.filter p4 (table.product (bag.filter p3 (table.product EMP DEPT)) EMP)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 27070 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 7) (nullable.some "D") (nullable.some "E") (nullable.some (- 7)) (nullable.some 8) (nullable.some (- 8)) (nullable.some 9) (nullable.some 3) (nullable.some (- 9))) 22))
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 3) (nullable.some "K")) 38))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some "D")) 18392)
; q2
(get-value (q2))
; (bag (tuple (nullable.some "D")) 18392)
; insert into EMP values(7,'D','E',-7,8,-8,9,3,-9),(7,'D','E',-7,8,-8,9,3,-9),(7,'D','E',-7,8,-8,9,3,-9),(7,'D','E',-7,8,-8,9,3,-9),(7,'D','E',-7,8,-8,9,3,-9),(7,'D','E',-7,8,-8,9,3,-9),(7,'D','E',-7,8,-8,9,3,-9),(7,'D','E',-7,8,-8,9,3,-9),(7,'D','E',-7,8,-8,9,3,-9),(7,'D','E',-7,8,-8,9,3,-9),(7,'D','E',-7,8,-8,9,3,-9),(7,'D','E',-7,8,-8,9,3,-9),(7,'D','E',-7,8,-8,9,3,-9),(7,'D','E',-7,8,-8,9,3,-9),(7,'D','E',-7,8,-8,9,3,-9),(7,'D','E',-7,8,-8,9,3,-9),(7,'D','E',-7,8,-8,9,3,-9),(7,'D','E',-7,8,-8,9,3,-9),(7,'D','E',-7,8,-8,9,3,-9),(7,'D','E',-7,8,-8,9,3,-9),(7,'D','E',-7,8,-8,9,3,-9),(7,'D','E',-7,8,-8,9,3,-9)
; insert into DEPT values(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K'),(3,'K')
; SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = EMP0.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.DEPTNO = DEPT0.DEPTNO INNER JOIN EMP AS EMP2 ON DEPT0.DEPTNO = EMP2.DEPTNO) AS q2;

; SELECT * FROM (SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.DEPTNO = DEPT0.DEPTNO INNER JOIN EMP AS EMP2 ON DEPT0.DEPTNO = EMP2.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = EMP0.DEPTNO) AS q1;

;Model soundness: false
(reset)
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

(declare-const q1 (Bag (Tuple (Nullable Bool))))
(declare-const q2 (Bag (Tuple (Nullable Bool))))
(declare-const p2 (-> (Tuple (Nullable Bool)) Bool))
(declare-const p3 (-> (Tuple (Nullable Bool)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_630227 Bool)) (not BOUND_VARIABLE_630227)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_630227 Bool)) (not BOUND_VARIABLE_630227)) ((_ tuple.select 0) t)))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p3 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_630245 Bool)) (not BOUND_VARIABLE_630245)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_630245 Bool)) (not BOUND_VARIABLE_630245)) ((_ tuple.select 0) t)))))))
(assert (= q1 ((_ table.project 0) (bag.filter p2 (bag.union_disjoint (bag (tuple (nullable.some false)) 1) (bag (tuple (nullable.some true)) 1))))))
(assert (= q2 ((_ table.project 0) (bag.filter p3 (bag.union_disjoint (bag (tuple (nullable.some false)) 1) (bag (tuple (nullable.some true)) 1))))))
(check-sat)
;answer: unsat
; duration: 1668 ms.
(reset)
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
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_630404 Int) (BOUND_VARIABLE_630405 Int)) (> BOUND_VARIABLE_630404 BOUND_VARIABLE_630405)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_630404 Int) (BOUND_VARIABLE_630405 Int)) (> BOUND_VARIABLE_630404 BOUND_VARIABLE_630405)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_630425 Int) (BOUND_VARIABLE_630426 Int)) (= BOUND_VARIABLE_630425 BOUND_VARIABLE_630426)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_630425 Int) (BOUND_VARIABLE_630426 Int)) (= BOUND_VARIABLE_630425 BOUND_VARIABLE_630426)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_630452 Int) (BOUND_VARIABLE_630453 Int)) (> BOUND_VARIABLE_630452 BOUND_VARIABLE_630453)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_630452 Int) (BOUND_VARIABLE_630453 Int)) (> BOUND_VARIABLE_630452 BOUND_VARIABLE_630453)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_630471 Int) (BOUND_VARIABLE_630472 Int)) (> BOUND_VARIABLE_630471 BOUND_VARIABLE_630472)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_630471 Int) (BOUND_VARIABLE_630472 Int)) (> BOUND_VARIABLE_630471 BOUND_VARIABLE_630472)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_630492 Int) (BOUND_VARIABLE_630493 Int)) (= BOUND_VARIABLE_630492 BOUND_VARIABLE_630493)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_630492 Int) (BOUND_VARIABLE_630493 Int)) (= BOUND_VARIABLE_630492 BOUND_VARIABLE_630493)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f4 (bag.filter p3 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)) EMP)))))
(assert (= q2 (bag.map f8 (bag.filter p7 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p6 EMP)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10014 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO) AS q2;

; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO) AS q1;

;Model soundness: false
(reset)
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
(declare-const f7 (-> (Tuple (Nullable Bool)) (Tuple (Nullable String) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable String) (Nullable String))))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const p6 (-> (Tuple (Nullable String) (Nullable String)) Bool))
(declare-const f2 (-> (Tuple (Nullable Bool)) (Tuple (Nullable String))))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const f3 (-> (Tuple (Nullable Bool)) (Tuple (Nullable String))))
(declare-const f4 (-> (Tuple (Nullable Bool)) (Tuple (Nullable String))))
(declare-const f5 (-> (Tuple (Nullable String)) (Tuple (Nullable String) (Nullable String))))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Bool)))) (tuple (nullable.some "table")))))
(assert (= f3 (lambda ((t (Tuple (Nullable Bool)))) (tuple (nullable.some "view")))))
(assert (= f4 (lambda ((t (Tuple (Nullable Bool)))) (tuple (nullable.some "foreign table")))))
(assert (= f5 (lambda ((t (Tuple (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_693738 String)) (str.to_upper BOUND_VARIABLE_693738)) (nullable.lift (lambda ((BOUND_VARIABLE_693731 String) (BOUND_VARIABLE_693732 String)) (str.++ BOUND_VARIABLE_693731 BOUND_VARIABLE_693732)) (nullable.lift (lambda ((BOUND_VARIABLE_693694 String) (BOUND_VARIABLE_693695 Int) (BOUND_VARIABLE_693696 Int)) (str.substr BOUND_VARIABLE_693694 BOUND_VARIABLE_693695 BOUND_VARIABLE_693696)) ((_ tuple.select 0) t) (nullable.some 0) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_693724 String) (BOUND_VARIABLE_693725 Int) (BOUND_VARIABLE_693726 Int)) (str.substr BOUND_VARIABLE_693724 BOUND_VARIABLE_693725 BOUND_VARIABLE_693726)) ((_ tuple.select 0) t) (nullable.some 2) (nullable.lift (lambda ((BOUND_VARIABLE_693718 String)) (str.len BOUND_VARIABLE_693718)) ((_ tuple.select 0) t))))) (nullable.lift (lambda ((BOUND_VARIABLE_693758 String) (BOUND_VARIABLE_693759 Int) (BOUND_VARIABLE_693760 Int)) (str.substr BOUND_VARIABLE_693758 BOUND_VARIABLE_693759 BOUND_VARIABLE_693760)) ((_ tuple.select 0) t) (nullable.some 0) (nullable.some 1))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p6 (lambda ((t (Tuple (Nullable String) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_693779 String) (BOUND_VARIABLE_693780 String)) (= BOUND_VARIABLE_693779 BOUND_VARIABLE_693780)) ((_ tuple.select 0) t) (nullable.some "TABLE"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_693779 String) (BOUND_VARIABLE_693780 String)) (= BOUND_VARIABLE_693779 BOUND_VARIABLE_693780)) ((_ tuple.select 0) t) (nullable.some "TABLE")))))))
(assert (= f7 (lambda ((t (Tuple (Nullable Bool)))) (tuple (nullable.some "TABLE") (nullable.some "t")))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p6 (bag.map f5 (bag.union_max ((_ table.project 0) (bag.union_max (bag.map f2 (bag (tuple (nullable.some true)) 1)) (bag.map f3 (bag (tuple (nullable.some true)) 1)))) (bag.map f4 (bag (tuple (nullable.some true)) 1))))))))
(assert (= q2 (bag.map f7 (bag (tuple (nullable.some true)) 1))))
(check-sat)
;answer: unsat
; duration: 272 ms.
(reset)
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullableAnd (nullableAnd (nullableAnd (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_694237 Int) (BOUND_VARIABLE_694238 Int)) (= BOUND_VARIABLE_694237 BOUND_VARIABLE_694238)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_694243 Int) (BOUND_VARIABLE_694244 Int)) (= BOUND_VARIABLE_694243 BOUND_VARIABLE_694244)) ((_ tuple.select 7) t) (nullable.some 8))) (nullable.lift (lambda ((BOUND_VARIABLE_694250 Int) (BOUND_VARIABLE_694251 Int)) (= BOUND_VARIABLE_694250 BOUND_VARIABLE_694251)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.some (nullable.is_null ((_ tuple.select 3) t)))) (nullable.lift (lambda ((BOUND_VARIABLE_694259 Int) (BOUND_VARIABLE_694260 Int)) (= BOUND_VARIABLE_694259 BOUND_VARIABLE_694260)) ((_ tuple.select 0) t) (nullable.some 10)))) (nullable.val (nullableAnd (nullableAnd (nullableAnd (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_694237 Int) (BOUND_VARIABLE_694238 Int)) (= BOUND_VARIABLE_694237 BOUND_VARIABLE_694238)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_694243 Int) (BOUND_VARIABLE_694244 Int)) (= BOUND_VARIABLE_694243 BOUND_VARIABLE_694244)) ((_ tuple.select 7) t) (nullable.some 8))) (nullable.lift (lambda ((BOUND_VARIABLE_694250 Int) (BOUND_VARIABLE_694251 Int)) (= BOUND_VARIABLE_694250 BOUND_VARIABLE_694251)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.some (nullable.is_null ((_ tuple.select 3) t)))) (nullable.lift (lambda ((BOUND_VARIABLE_694259 Int) (BOUND_VARIABLE_694260 Int)) (= BOUND_VARIABLE_694259 BOUND_VARIABLE_694260)) ((_ tuple.select 0) t) (nullable.some 10))))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 10) ((_ tuple.select 1) t) ((_ tuple.select 2) t) (as nullable.null (Nullable Int)) ((_ tuple.select 4) t) ((_ tuple.select 6) t) ((_ tuple.select 5) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP))))
(assert (= q2 (bag.map f4 (bag.filter p3 EMP))))
(check-sat)
;answer: unsat
; duration: 820 ms.
(reset)
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
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const f5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullableAnd (nullable.some (nullable.is_null ((_ tuple.select 0) t))) (nullable.some (nullable.is_null ((_ tuple.select 0) t))))) (nullable.val (nullableAnd (nullable.some (nullable.is_null ((_ tuple.select 0) t))) (nullable.some (nullable.is_null ((_ tuple.select 0) t)))))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p4 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 0) t)))) (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 0) t))))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int))))))
(assert (= q1 ((_ table.project 0) (bag.filter p4 ((_ table.project 0) (bag.filter p3 (bag.map f2 EMP)))))))
(assert (= q2 (bag.map f5 EMP)))
(check-sat)
;answer: unsat
; duration: 100 ms.
(reset)
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
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_704319 Int) (BOUND_VARIABLE_704320 Int)) (> BOUND_VARIABLE_704319 BOUND_VARIABLE_704320)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_704325 Int) (BOUND_VARIABLE_704326 Int)) (<= BOUND_VARIABLE_704325 BOUND_VARIABLE_704326)) ((_ tuple.select 0) t) (nullable.some 10)))) (nullable.val (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_704319 Int) (BOUND_VARIABLE_704320 Int)) (> BOUND_VARIABLE_704319 BOUND_VARIABLE_704320)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_704325 Int) (BOUND_VARIABLE_704326 Int)) (<= BOUND_VARIABLE_704325 BOUND_VARIABLE_704326)) ((_ tuple.select 0) t) (nullable.some 10))))))))
(assert (= q1 ((_ table.project 0) (bag.filter p2 EMP))))
(assert (= q2 ((_ table.project 0) (bag.difference_remove ((_ table.project 0) (bag (tuple (nullable.some 0)) 1)) ((_ table.project 0) (bag (tuple (nullable.some 0)) 1))))))
(check-sat)
;answer: unsat
; duration: 56 ms.
(reset)
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
(declare-const q1 (Bag (Tuple (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_705498 Int) (BOUND_VARIABLE_705499 Int)) (= BOUND_VARIABLE_705498 BOUND_VARIABLE_705499)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_705506 Int) (BOUND_VARIABLE_705507 Int)) (= BOUND_VARIABLE_705506 BOUND_VARIABLE_705507)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))) (nullable.val (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_705498 Int) (BOUND_VARIABLE_705499 Int)) (= BOUND_VARIABLE_705498 BOUND_VARIABLE_705499)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_705506 Int) (BOUND_VARIABLE_705507 Int)) (= BOUND_VARIABLE_705506 BOUND_VARIABLE_705507)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_705532 Int) (BOUND_VARIABLE_705533 Int)) (= BOUND_VARIABLE_705532 BOUND_VARIABLE_705533)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_705532 Int) (BOUND_VARIABLE_705533 Int)) (= BOUND_VARIABLE_705532 BOUND_VARIABLE_705533)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_705552 Int) (BOUND_VARIABLE_705553 Int)) (= BOUND_VARIABLE_705552 BOUND_VARIABLE_705553)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_705552 Int) (BOUND_VARIABLE_705553 Int)) (= BOUND_VARIABLE_705552 BOUND_VARIABLE_705553)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_705649 Int) (BOUND_VARIABLE_705650 Int)) (= BOUND_VARIABLE_705649 BOUND_VARIABLE_705650)) ((_ tuple.select 7) t) ((_ tuple.select 20) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_705649 Int) (BOUND_VARIABLE_705650 Int)) (= BOUND_VARIABLE_705649 BOUND_VARIABLE_705650)) ((_ tuple.select 7) t) ((_ tuple.select 20) t)))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_705774 Int) (BOUND_VARIABLE_705775 Int)) (= BOUND_VARIABLE_705774 BOUND_VARIABLE_705775)) ((_ tuple.select 0) t) ((_ tuple.select 22) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_705774 Int) (BOUND_VARIABLE_705775 Int)) (= BOUND_VARIABLE_705774 BOUND_VARIABLE_705775)) ((_ tuple.select 0) t) ((_ tuple.select 22) t)))))))
(assert (= q1 ((_ table.project 1) (bag.filter p2 (table.product (table.product EMP DEPT) EMP)))))
(assert (= q2 ((_ table.project 1) (bag.filter p6 (table.product (bag.filter p5 (table.product (bag.filter p4 (table.product (bag.filter p3 (table.product EMP DEPT)) EMP)) DEPT)) EMP)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10095 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some (- 5)) (nullable.some "G") (nullable.some "H") (nullable.some (- 9)) (nullable.some 10) (nullable.some (- 10)) (nullable.some 11) (as nullable.null (Nullable Int)) (nullable.some (- 11))) 17))
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag.union_disjoint (bag (tuple (nullable.some (- 5)) (nullable.some "I")) 15) (bag (tuple (nullable.some (- 5)) (nullable.some "F")) 28)))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable String))))
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable String))))
; insert into EMP values(-5,'G','H',-9,10,-10,11,NULL,-11),(-5,'G','H',-9,10,-10,11,NULL,-11),(-5,'G','H',-9,10,-10,11,NULL,-11),(-5,'G','H',-9,10,-10,11,NULL,-11),(-5,'G','H',-9,10,-10,11,NULL,-11),(-5,'G','H',-9,10,-10,11,NULL,-11),(-5,'G','H',-9,10,-10,11,NULL,-11),(-5,'G','H',-9,10,-10,11,NULL,-11),(-5,'G','H',-9,10,-10,11,NULL,-11),(-5,'G','H',-9,10,-10,11,NULL,-11),(-5,'G','H',-9,10,-10,11,NULL,-11),(-5,'G','H',-9,10,-10,11,NULL,-11),(-5,'G','H',-9,10,-10,11,NULL,-11),(-5,'G','H',-9,10,-10,11,NULL,-11),(-5,'G','H',-9,10,-10,11,NULL,-11),(-5,'G','H',-9,10,-10,11,NULL,-11),(-5,'G','H',-9,10,-10,11,NULL,-11)
; insert into DEPT values(-5,'I'),(-5,'I'),(-5,'I'),(-5,'I'),(-5,'I'),(-5,'I'),(-5,'I'),(-5,'I'),(-5,'I'),(-5,'I'),(-5,'I'),(-5,'I'),(-5,'I'),(-5,'I'),(-5,'I'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F'),(-5,'F')
; SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.EMPNO = EMP0.EMPNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.DEPTNO = DEPT0.DEPTNO INNER JOIN EMP AS EMP2 ON EMP1.EMPNO = EMP2.EMPNO INNER JOIN DEPT AS DEPT1 ON EMP1.DEPTNO = DEPT1.DEPTNO INNER JOIN EMP AS EMP3 ON EMP1.EMPNO = EMP3.EMPNO) AS q2;

; SELECT * FROM (SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.DEPTNO = DEPT0.DEPTNO INNER JOIN EMP AS EMP2 ON EMP1.EMPNO = EMP2.EMPNO INNER JOIN DEPT AS DEPT1 ON EMP1.DEPTNO = DEPT1.DEPTNO INNER JOIN EMP AS EMP3 ON EMP1.EMPNO = EMP3.EMPNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.EMPNO = EMP0.EMPNO) AS q1;

;Model soundness: false
(reset)
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
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(declare-const f5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_781532 Int) (BOUND_VARIABLE_781533 Int)) (= BOUND_VARIABLE_781532 BOUND_VARIABLE_781533)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_781532 Int) (BOUND_VARIABLE_781533 Int)) (= BOUND_VARIABLE_781532 BOUND_VARIABLE_781533)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (tuple (nullable.some 1)))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_781559 Int) (BOUND_VARIABLE_781560 Int)) (= BOUND_VARIABLE_781559 BOUND_VARIABLE_781560)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_781559 Int) (BOUND_VARIABLE_781560 Int)) (= BOUND_VARIABLE_781559 BOUND_VARIABLE_781560)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f3 (bag.filter p2 (table.product EMP DEPT)))))
(assert (= q2 (bag.map f5 (bag.filter p4 (table.product EMP DEPT)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10342 ms.
(get-model)
; (
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag.union_disjoint (bag (tuple (nullable.some 0) (nullable.some "G")) 1) (bag (tuple (nullable.some 0) (nullable.some "H")) 1)))
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some (- 7)) (nullable.some "E") (nullable.some "F") (nullable.some 8) (nullable.some (- 8)) (nullable.some 9) (nullable.some (- 9)) (nullable.some 0) (nullable.some 10)) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 1)) 2)
; q2
(get-value (q2))
; (bag (tuple (nullable.some 1)) 2)
; insert into DEPT values(0,'G'),(0,'H')
; insert into EMP values(-7,'E','F',8,-8,9,-9,0,10)
; SELECT * FROM (SELECT 1 FROM EMP AS EMP INNER JOIN DEPT AS DEPT ON EMP.DEPTNO = DEPT.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM EMP AS EMP0, DEPT AS DEPT0 WHERE EMP0.DEPTNO = DEPT0.DEPTNO) AS q2;

; SELECT * FROM (SELECT 1 FROM EMP AS EMP0, DEPT AS DEPT0 WHERE EMP0.DEPTNO = DEPT0.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM EMP AS EMP INNER JOIN DEPT AS DEPT ON EMP.DEPTNO = DEPT.DEPTNO) AS q1;

;Model soundness: false
(reset)
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
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f11 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const leftJoin3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const leftJoin8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const rightJoin4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p10 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const rightJoin9 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_818580 Int) (BOUND_VARIABLE_818581 Int)) (= BOUND_VARIABLE_818580 BOUND_VARIABLE_818581)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_818580 Int) (BOUND_VARIABLE_818581 Int)) (= BOUND_VARIABLE_818580 BOUND_VARIABLE_818581)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= leftJoin3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_818642 Int) (BOUND_VARIABLE_818643 Int)) (> BOUND_VARIABLE_818642 BOUND_VARIABLE_818643)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_818649 Int) (BOUND_VARIABLE_818650 Int)) (> BOUND_VARIABLE_818649 BOUND_VARIABLE_818650)) ((_ tuple.select 16) t) (nullable.some 9)))) (nullable.val (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_818642 Int) (BOUND_VARIABLE_818643 Int)) (> BOUND_VARIABLE_818642 BOUND_VARIABLE_818643)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_818649 Int) (BOUND_VARIABLE_818650 Int)) (> BOUND_VARIABLE_818649 BOUND_VARIABLE_818650)) ((_ tuple.select 16) t) (nullable.some 9))))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_818682 Int) (BOUND_VARIABLE_818683 Int)) (= BOUND_VARIABLE_818682 BOUND_VARIABLE_818683)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_818682 Int) (BOUND_VARIABLE_818683 Int)) (= BOUND_VARIABLE_818682 BOUND_VARIABLE_818683)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= leftJoin8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p10 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_818742 Int) (BOUND_VARIABLE_818743 Int)) (> BOUND_VARIABLE_818742 BOUND_VARIABLE_818743)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_818749 Int) (BOUND_VARIABLE_818750 Int)) (> BOUND_VARIABLE_818749 BOUND_VARIABLE_818750)) ((_ tuple.select 16) t) (nullable.some 9)))) (nullable.val (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_818742 Int) (BOUND_VARIABLE_818743 Int)) (> BOUND_VARIABLE_818742 BOUND_VARIABLE_818743)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_818749 Int) (BOUND_VARIABLE_818750 Int)) (> BOUND_VARIABLE_818749 BOUND_VARIABLE_818750)) ((_ tuple.select 16) t) (nullable.some 9))))))))
(assert (= f11 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f6 (bag.filter p5 (bag.union_disjoint (bag.union_disjoint (bag.map leftJoin3 (bag.difference_remove EMP ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 (table.product EMP EMP))))) (bag.map rightJoin4 (bag.difference_remove EMP ((_ table.project 9 10 11 12 13 14 15 16 17) (bag.filter p2 (table.product EMP EMP)))))) (bag.filter p2 (table.product EMP EMP)))))))
(assert (= q2 (bag.map f11 (bag.filter p10 (bag.union_disjoint (bag.union_disjoint (bag.map leftJoin8 (bag.difference_remove EMP ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p7 (table.product EMP EMP))))) (bag.map rightJoin9 (bag.difference_remove EMP ((_ table.project 9 10 11 12 13 14 15 16 17) (bag.filter p7 (table.product EMP EMP)))))) (bag.filter p7 (table.product EMP EMP)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10185 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; SELECT * FROM (SELECT 1 FROM EMP AS EMP FULL JOIN EMP AS EMP0 ON EMP.DEPTNO = EMP0.DEPTNO WHERE EMP.DEPTNO > 7 AND EMP0.DEPTNO > 9) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM EMP AS EMP1 FULL JOIN EMP AS EMP2 ON EMP1.DEPTNO = EMP2.DEPTNO WHERE EMP1.DEPTNO > 7 AND EMP2.DEPTNO > 9) AS q2;

; SELECT * FROM (SELECT 1 FROM EMP AS EMP1 FULL JOIN EMP AS EMP2 ON EMP1.DEPTNO = EMP2.DEPTNO WHERE EMP1.DEPTNO > 7 AND EMP2.DEPTNO > 9) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM EMP AS EMP FULL JOIN EMP AS EMP0 ON EMP.DEPTNO = EMP0.DEPTNO WHERE EMP.DEPTNO > 7 AND EMP0.DEPTNO > 9) AS q1;

;Model soundness: false
(reset)
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
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const f12 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String))))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)) Bool))
(declare-const f11 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String))))
(declare-const p10 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)) Bool))
(declare-const f5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f9 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String))))
(declare-const p13 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_875811 String) (BOUND_VARIABLE_875812 String)) (= BOUND_VARIABLE_875811 BOUND_VARIABLE_875812)) ((_ tuple.select 2) t) ((_ tuple.select 1) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_875811 String) (BOUND_VARIABLE_875812 String)) (= BOUND_VARIABLE_875811 BOUND_VARIABLE_875812)) ((_ tuple.select 2) t) ((_ tuple.select 1) t)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_875834 String) (BOUND_VARIABLE_875835 String)) (= BOUND_VARIABLE_875834 BOUND_VARIABLE_875835)) ((_ tuple.select 2) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_875842 Int) (BOUND_VARIABLE_875843 Int)) (= BOUND_VARIABLE_875842 BOUND_VARIABLE_875843)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))) (nullable.val (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_875834 String) (BOUND_VARIABLE_875835 String)) (= BOUND_VARIABLE_875834 BOUND_VARIABLE_875835)) ((_ tuple.select 2) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_875842 Int) (BOUND_VARIABLE_875843 Int)) (= BOUND_VARIABLE_875842 BOUND_VARIABLE_875843)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 1) t)))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_875885 String) (BOUND_VARIABLE_875886 String)) (= BOUND_VARIABLE_875885 BOUND_VARIABLE_875886)) ((_ tuple.select 9) t) ((_ tuple.select 1) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_875885 String) (BOUND_VARIABLE_875886 String)) (= BOUND_VARIABLE_875885 BOUND_VARIABLE_875886)) ((_ tuple.select 9) t) ((_ tuple.select 1) t)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_875959 String) (BOUND_VARIABLE_875960 String)) (= BOUND_VARIABLE_875959 BOUND_VARIABLE_875960)) ((_ tuple.select 1) t) ((_ tuple.select 12) t)) (nullable.lift (lambda ((BOUND_VARIABLE_875967 Int) (BOUND_VARIABLE_875968 Int)) (= BOUND_VARIABLE_875967 BOUND_VARIABLE_875968)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))) (nullable.val (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_875959 String) (BOUND_VARIABLE_875960 String)) (= BOUND_VARIABLE_875959 BOUND_VARIABLE_875960)) ((_ tuple.select 1) t) ((_ tuple.select 12) t)) (nullable.lift (lambda ((BOUND_VARIABLE_875967 Int) (BOUND_VARIABLE_875968 Int)) (= BOUND_VARIABLE_875967 BOUND_VARIABLE_875968)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))))))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 2) t)))))
(assert (= f9 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p10 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_876024 String) (BOUND_VARIABLE_876025 String)) (= BOUND_VARIABLE_876024 BOUND_VARIABLE_876025)) ((_ tuple.select 9) t) ((_ tuple.select 12) t)) (nullable.lift (lambda ((BOUND_VARIABLE_876032 Int) (BOUND_VARIABLE_876033 Int)) (= BOUND_VARIABLE_876032 BOUND_VARIABLE_876033)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)))) (nullable.val (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_876024 String) (BOUND_VARIABLE_876025 String)) (= BOUND_VARIABLE_876024 BOUND_VARIABLE_876025)) ((_ tuple.select 9) t) ((_ tuple.select 12) t)) (nullable.lift (lambda ((BOUND_VARIABLE_876032 Int) (BOUND_VARIABLE_876033 Int)) (= BOUND_VARIABLE_876032 BOUND_VARIABLE_876033)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))))))
(assert (= f11 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 10) t) ((_ tuple.select 11) t) ((_ tuple.select 1) t)))))
(assert (= f12 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p13 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_876194 String) (BOUND_VARIABLE_876195 String)) (= BOUND_VARIABLE_876194 BOUND_VARIABLE_876195)) ((_ tuple.select 11) t) ((_ tuple.select 14) t)) (nullable.lift (lambda ((BOUND_VARIABLE_876202 Int) (BOUND_VARIABLE_876203 Int)) (= BOUND_VARIABLE_876202 BOUND_VARIABLE_876203)) ((_ tuple.select 0) t) ((_ tuple.select 12) t)))) (nullable.val (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_876194 String) (BOUND_VARIABLE_876195 String)) (= BOUND_VARIABLE_876194 BOUND_VARIABLE_876195)) ((_ tuple.select 11) t) ((_ tuple.select 14) t)) (nullable.lift (lambda ((BOUND_VARIABLE_876202 Int) (BOUND_VARIABLE_876203 Int)) (= BOUND_VARIABLE_876202 BOUND_VARIABLE_876203)) ((_ tuple.select 0) t) ((_ tuple.select 12) t))))))))
(assert (= q1 ((_ table.project 6) (bag.filter p7 (table.product (bag.filter p4 (table.product EMP ((_ table.project 0 1) ((_ table.project 0 2) (bag.filter p3 (bag.map f2 DEPT)))))) ((_ table.project 0 1) ((_ table.project 0 9) (bag.filter p6 (bag.map f5 EMP)))))))))
(assert (= q2 ((_ table.project 6) (bag.filter p13 (table.product (bag.map f11 (bag.filter p10 (table.product (bag.map f8 EMP) (bag.map f9 DEPT)))) (bag.map f12 EMP))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10416 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))))
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String)))))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; SELECT * FROM (SELECT EMP.SAL FROM EMP AS EMP WHERE EMP.EMPNO IN (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE EMP.JOB = DEPT.NAME) AND EMP.EMPNO IN (SELECT EMP0.EMPNO FROM EMP AS EMP0 WHERE EMP.ENAME = EMP0.ENAME)) AS q1 EXCEPT ALL SELECT * FROM (SELECT EMP1.SAL FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.JOB = DEPT0.NAME AND EMP1.EMPNO = DEPT0.DEPTNO INNER JOIN (SELECT EMP2.EMPNO, EMP2.ENAME FROM EMP AS EMP2) AS t5 ON EMP1.ENAME = t5.ENAME AND EMP1.EMPNO = t5.EMPNO) AS q2;

; SELECT * FROM (SELECT EMP1.SAL FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.JOB = DEPT0.NAME AND EMP1.EMPNO = DEPT0.DEPTNO INNER JOIN (SELECT EMP2.EMPNO, EMP2.ENAME FROM EMP AS EMP2) AS t5 ON EMP1.ENAME = t5.ENAME AND EMP1.EMPNO = t5.EMPNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.SAL FROM EMP AS EMP WHERE EMP.EMPNO IN (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE EMP.JOB = DEPT.NAME) AND EMP.EMPNO IN (SELECT EMP0.EMPNO FROM EMP AS EMP0 WHERE EMP.ENAME = EMP0.ENAME)) AS q1;

;Model soundness: false
(reset)
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
(declare-const q1 (Bag (Tuple (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_919481 Int) (BOUND_VARIABLE_919482 Int)) (= BOUND_VARIABLE_919481 BOUND_VARIABLE_919482)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_919481 Int) (BOUND_VARIABLE_919482 Int)) (= BOUND_VARIABLE_919481 BOUND_VARIABLE_919482)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_919500 Int) (BOUND_VARIABLE_919501 Int)) (= BOUND_VARIABLE_919500 BOUND_VARIABLE_919501)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_919500 Int) (BOUND_VARIABLE_919501 Int)) (= BOUND_VARIABLE_919500 BOUND_VARIABLE_919501)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_919519 Int) (BOUND_VARIABLE_919520 Int)) (= BOUND_VARIABLE_919519 BOUND_VARIABLE_919520)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_919519 Int) (BOUND_VARIABLE_919520 Int)) (= BOUND_VARIABLE_919519 BOUND_VARIABLE_919520)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= q1 ((_ table.project 1) (bag.filter p3 ((_ table.project 0 1) (bag.filter p2 DEPT))))))
(assert (= q2 ((_ table.project 1) (bag.filter p4 DEPT))))
(check-sat)
;answer: unsat
; duration: 1596 ms.
(reset)
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
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= q1 ((_ table.project 6) (bag.union_disjoint ((_ table.project 0 1 2 3 4 5 6 7 8) EMP) ((_ table.project 0 1 2 3 4 5 6 7 8) EMP)))))
(assert (= q2 (bag.union_disjoint ((_ table.project 6) EMP) ((_ table.project 6) EMP))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10027 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag.union_disjoint (bag (tuple (nullable.some 3) (nullable.some "A") (nullable.some "B") (nullable.some (- 3)) (nullable.some 4) (nullable.some (- 4)) (nullable.some 6) (nullable.some 5) (nullable.some (- 5))) 1) (bag (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 0) (nullable.some 1) (nullable.some (- 1)) (nullable.some 6) (nullable.some 2) (nullable.some (- 2))) 1)))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 6)) 4)
; q2
(get-value (q2))
; (bag (tuple (nullable.some 6)) 4)
; insert into EMP values(3,'A','B',-3,4,-4,6,5,-5),(NULL,NULL,'',0,1,-1,6,2,-2)
; SELECT * FROM (SELECT t.SAL FROM (SELECT * FROM EMP AS EMP UNION ALL SELECT * FROM EMP AS EMP0) AS t) AS q1 EXCEPT ALL SELECT * FROM (SELECT EMP1.SAL FROM EMP AS EMP1 UNION ALL SELECT EMP2.SAL FROM EMP AS EMP2) AS q2;

; SELECT * FROM (SELECT EMP1.SAL FROM EMP AS EMP1 UNION ALL SELECT EMP2.SAL FROM EMP AS EMP2) AS q2 EXCEPT ALL SELECT * FROM (SELECT t.SAL FROM (SELECT * FROM EMP AS EMP UNION ALL SELECT * FROM EMP AS EMP0) AS t) AS q1;

;Model soundness: false
(reset)
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_964245 Int) (BOUND_VARIABLE_964246 Int)) (= BOUND_VARIABLE_964245 BOUND_VARIABLE_964246)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_964245 Int) (BOUND_VARIABLE_964246 Int)) (= BOUND_VARIABLE_964245 BOUND_VARIABLE_964246)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_964264 Int) (BOUND_VARIABLE_964265 Int)) (= BOUND_VARIABLE_964264 BOUND_VARIABLE_964265)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_964264 Int) (BOUND_VARIABLE_964265 Int)) (= BOUND_VARIABLE_964264 BOUND_VARIABLE_964265)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_964283 Int) (BOUND_VARIABLE_964284 Int)) (= BOUND_VARIABLE_964283 BOUND_VARIABLE_964284)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_964283 Int) (BOUND_VARIABLE_964284 Int)) (= BOUND_VARIABLE_964283 BOUND_VARIABLE_964284)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_964305 Int) (BOUND_VARIABLE_964306 Int)) (= BOUND_VARIABLE_964305 BOUND_VARIABLE_964306)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_964305 Int) (BOUND_VARIABLE_964306 Int)) (= BOUND_VARIABLE_964305 BOUND_VARIABLE_964306)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_964324 Int) (BOUND_VARIABLE_964325 Int)) (= BOUND_VARIABLE_964324 BOUND_VARIABLE_964325)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_964324 Int) (BOUND_VARIABLE_964325 Int)) (= BOUND_VARIABLE_964324 BOUND_VARIABLE_964325)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_964343 Int) (BOUND_VARIABLE_964344 Int)) (= BOUND_VARIABLE_964343 BOUND_VARIABLE_964344)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_964343 Int) (BOUND_VARIABLE_964344 Int)) (= BOUND_VARIABLE_964343 BOUND_VARIABLE_964344)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)))))))
(assert (= q2 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p6 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p7 EMP)))))))
(check-sat)
;answer: unsat
; duration: 716 ms.
(reset)
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

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_970871 Int) (BOUND_VARIABLE_970872 Int)) (= BOUND_VARIABLE_970871 BOUND_VARIABLE_970872)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_970871 Int) (BOUND_VARIABLE_970872 Int)) (= BOUND_VARIABLE_970871 BOUND_VARIABLE_970872)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p3 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)) DEPT)))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some "")) 1)) ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some "")) 1))))))
(check-sat)
;answer: unsat
; duration: 146 ms.
(reset)
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
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_972080 Int) (BOUND_VARIABLE_972081 Int)) (= BOUND_VARIABLE_972080 BOUND_VARIABLE_972081)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some (nullable.is_null ((_ tuple.select 0) t))))) (nullable.val (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_972080 Int) (BOUND_VARIABLE_972081 Int)) (= BOUND_VARIABLE_972080 BOUND_VARIABLE_972081)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some (nullable.is_null ((_ tuple.select 0) t)))))))))
(assert (= q1 ((_ table.project 0) (bag.filter p2 EMP))))
(assert (= q2 ((_ table.project 0) (bag.difference_remove ((_ table.project 0) (bag (tuple (nullable.some 0)) 1)) ((_ table.project 0) (bag (tuple (nullable.some 0)) 1))))))
(check-sat)
;answer: unsat
; duration: 47 ms.
(reset)
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
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_973075 Int) (BOUND_VARIABLE_973076 Int)) (> BOUND_VARIABLE_973075 BOUND_VARIABLE_973076)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_973075 Int) (BOUND_VARIABLE_973076 Int)) (> BOUND_VARIABLE_973075 BOUND_VARIABLE_973076)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_973096 Int) (BOUND_VARIABLE_973097 Int)) (= BOUND_VARIABLE_973096 BOUND_VARIABLE_973097)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_973096 Int) (BOUND_VARIABLE_973097 Int)) (= BOUND_VARIABLE_973096 BOUND_VARIABLE_973097)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_973122 Int) (BOUND_VARIABLE_973123 Int)) (> BOUND_VARIABLE_973122 BOUND_VARIABLE_973123)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_973122 Int) (BOUND_VARIABLE_973123 Int)) (> BOUND_VARIABLE_973122 BOUND_VARIABLE_973123)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_973141 Int) (BOUND_VARIABLE_973142 Int)) (> BOUND_VARIABLE_973141 BOUND_VARIABLE_973142)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_973141 Int) (BOUND_VARIABLE_973142 Int)) (> BOUND_VARIABLE_973141 BOUND_VARIABLE_973142)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_973162 Int) (BOUND_VARIABLE_973163 Int)) (= BOUND_VARIABLE_973162 BOUND_VARIABLE_973163)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_973162 Int) (BOUND_VARIABLE_973163 Int)) (= BOUND_VARIABLE_973162 BOUND_VARIABLE_973163)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f4 (bag.filter p3 (table.product EMP ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)))))))
(assert (= q2 (bag.map f8 (bag.filter p7 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p6 EMP)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10088 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some (- 16)) (nullable.some "I") (nullable.some "J") (nullable.some 17) (nullable.some (- 17)) (nullable.some 18) (nullable.some (- 18)) (nullable.some (- 6)) (nullable.some 19)) 3))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; insert into EMP values(-16,'I','J',17,-17,18,-18,-6,19),(-16,'I','J',17,-17,18,-18,-6,19),(-16,'I','J',17,-17,18,-18,-6,19)
; SELECT * FROM (SELECT 1 FROM EMP AS EMP INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 7) AS t ON EMP.DEPTNO = t.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO) AS q2;

; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM EMP AS EMP INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 7) AS t ON EMP.DEPTNO = t.DEPTNO) AS q1;

;Model soundness: false
(reset)
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

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f10 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const leftJoin3 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const rightJoin4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const rightJoin9 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1058635 Int) (BOUND_VARIABLE_1058636 Int)) (= BOUND_VARIABLE_1058635 BOUND_VARIABLE_1058636)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1058635 Int) (BOUND_VARIABLE_1058636 Int)) (= BOUND_VARIABLE_1058635 BOUND_VARIABLE_1058636)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin3 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1058694 Int) (BOUND_VARIABLE_1058695 Int)) (> BOUND_VARIABLE_1058694 BOUND_VARIABLE_1058695)) ((_ tuple.select 8) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1058694 Int) (BOUND_VARIABLE_1058695 Int)) (> BOUND_VARIABLE_1058694 BOUND_VARIABLE_1058695)) ((_ tuple.select 8) t) (nullable.some 100)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1058721 Int) (BOUND_VARIABLE_1058722 Int)) (> BOUND_VARIABLE_1058721 BOUND_VARIABLE_1058722)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1058721 Int) (BOUND_VARIABLE_1058722 Int)) (> BOUND_VARIABLE_1058721 BOUND_VARIABLE_1058722)) ((_ tuple.select 6) t) (nullable.some 100)))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1058742 Int) (BOUND_VARIABLE_1058743 Int)) (= BOUND_VARIABLE_1058742 BOUND_VARIABLE_1058743)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1058742 Int) (BOUND_VARIABLE_1058743 Int)) (= BOUND_VARIABLE_1058742 BOUND_VARIABLE_1058743)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= f10 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f6 (bag.filter p5 (bag.union_disjoint (bag.union_disjoint (bag.map leftJoin3 (bag.difference_remove DEPT ((_ table.project 0 1) (bag.filter p2 (table.product DEPT EMP))))) (bag.map rightJoin4 (bag.difference_remove EMP ((_ table.project 2 3 4 5 6 7 8 9 10) (bag.filter p2 (table.product DEPT EMP)))))) (bag.filter p2 (table.product DEPT EMP)))))))
(assert (= q2 (bag.map f10 (bag.union_disjoint (bag.map rightJoin9 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p7 EMP)) ((_ table.project 2 3 4 5 6 7 8 9 10) (bag.filter p8 (table.product DEPT ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p7 EMP))))))) (bag.filter p8 (table.product DEPT ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p7 EMP))))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10351 ms.
(get-model)
; (
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag.union_disjoint (bag (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))) 9) (bag (tuple (nullable.some (- 32)) (nullable.some "Q")) 34)))
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 11) (nullable.some "M") (nullable.some "N") (nullable.some (- 11)) (nullable.some 12) (nullable.some (- 12)) (nullable.some (- 31)) (nullable.some (- 32)) (nullable.some 13)) 17))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; insert into DEPT values(NULL,NULL),(NULL,NULL),(NULL,NULL),(NULL,NULL),(NULL,NULL),(NULL,NULL),(NULL,NULL),(NULL,NULL),(NULL,NULL),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q'),(-32,'Q')
; insert into EMP values(11,'M','N',-11,12,-12,-31,-32,13),(11,'M','N',-11,12,-12,-31,-32,13),(11,'M','N',-11,12,-12,-31,-32,13),(11,'M','N',-11,12,-12,-31,-32,13),(11,'M','N',-11,12,-12,-31,-32,13),(11,'M','N',-11,12,-12,-31,-32,13),(11,'M','N',-11,12,-12,-31,-32,13),(11,'M','N',-11,12,-12,-31,-32,13),(11,'M','N',-11,12,-12,-31,-32,13),(11,'M','N',-11,12,-12,-31,-32,13),(11,'M','N',-11,12,-12,-31,-32,13),(11,'M','N',-11,12,-12,-31,-32,13),(11,'M','N',-11,12,-12,-31,-32,13),(11,'M','N',-11,12,-12,-31,-32,13),(11,'M','N',-11,12,-12,-31,-32,13),(11,'M','N',-11,12,-12,-31,-32,13),(11,'M','N',-11,12,-12,-31,-32,13)
; SELECT * FROM (SELECT 1 FROM DEPT AS DEPT FULL JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE EMP.SAL > 100) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM DEPT AS DEPT0 RIGHT JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL > 100) AS t1 ON DEPT0.DEPTNO = t1.DEPTNO) AS q2;

; SELECT * FROM (SELECT 1 FROM DEPT AS DEPT0 RIGHT JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL > 100) AS t1 ON DEPT0.DEPTNO = t1.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM DEPT AS DEPT FULL JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE EMP.SAL > 100) AS q1;

;Model soundness: false
(reset)
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
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_1098203 Int) (BOUND_VARIABLE_1098204 Int)) (= BOUND_VARIABLE_1098203 BOUND_VARIABLE_1098204)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1098215 Bool)) (not BOUND_VARIABLE_1098215)) (nullable.lift (lambda ((BOUND_VARIABLE_1098209 Int) (BOUND_VARIABLE_1098210 Int)) (= BOUND_VARIABLE_1098209 BOUND_VARIABLE_1098210)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.val (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_1098203 Int) (BOUND_VARIABLE_1098204 Int)) (= BOUND_VARIABLE_1098203 BOUND_VARIABLE_1098204)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1098215 Bool)) (not BOUND_VARIABLE_1098215)) (nullable.lift (lambda ((BOUND_VARIABLE_1098209 Int) (BOUND_VARIABLE_1098210 Int)) (= BOUND_VARIABLE_1098209 BOUND_VARIABLE_1098210)) ((_ tuple.select 0) t) (nullable.some 10)))))))))
(assert (= q1 ((_ table.project 0) (bag.filter p2 EMP))))
(assert (= q2 ((_ table.project 0) (bag.difference_remove ((_ table.project 0) (bag (tuple (nullable.some 0)) 1)) ((_ table.project 0) (bag (tuple (nullable.some 0)) 1))))))
(check-sat)
;answer: unsat
; duration: 248 ms.
(reset)
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
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const leftJoin4 (-> (Tuple (Nullable Int)) (Tuple (Nullable Int) (Nullable Int))))
(declare-const leftJoin2 (-> (Tuple (Nullable Int)) (Tuple (Nullable Int) (Nullable Int))))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f5 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int)))) (tuple ((_ tuple.select 0) t) (as nullable.null (Nullable Int))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2)))))
(assert (= leftJoin4 (lambda ((t (Tuple (Nullable Int)))) (tuple ((_ tuple.select 0) t) (as nullable.null (Nullable Int))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2)))))
(assert (= q1 (bag.map f3 (bag.union_disjoint (bag.map leftJoin2 (bag.difference_remove (bag (tuple (nullable.some 1)) 1) ((_ table.project 0) (table.product (bag (tuple (nullable.some 1)) 1) (bag (tuple (nullable.some 1)) 1))))) (table.product (bag (tuple (nullable.some 1)) 1) (bag (tuple (nullable.some 1)) 1))))))
(assert (= q2 (bag.map f5 (bag.union_disjoint (bag.map leftJoin4 (bag.difference_remove (bag (tuple (nullable.some 1)) 1) ((_ table.project 0) (table.product (bag (tuple (nullable.some 1)) 1) (bag (tuple (nullable.some 1)) 1))))) (table.product (bag (tuple (nullable.some 1)) 1) (bag (tuple (nullable.some 1)) 1))))))
(check-sat)
;answer: unsat
; duration: 8 ms.
(reset)
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
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1099610 Int) (BOUND_VARIABLE_1099611 Int)) (= BOUND_VARIABLE_1099610 BOUND_VARIABLE_1099611)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1099610 Int) (BOUND_VARIABLE_1099611 Int)) (= BOUND_VARIABLE_1099610 BOUND_VARIABLE_1099611)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1099637 Int) (BOUND_VARIABLE_1099638 Int)) (= BOUND_VARIABLE_1099637 BOUND_VARIABLE_1099638)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1099637 Int) (BOUND_VARIABLE_1099638 Int)) (= BOUND_VARIABLE_1099637 BOUND_VARIABLE_1099638)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f3 (bag.filter p2 (table.product EMP EMP)))))
(assert (= q2 (bag.map f5 (bag.filter p4 (table.product EMP EMP)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10016 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 16) (nullable.some "I") (nullable.some "J") (nullable.some (- 16)) (nullable.some 17) (nullable.some (- 17)) (nullable.some 18) (nullable.some (- 18)) (nullable.some 19)) 7))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 1)) 49)
; q2
(get-value (q2))
; (bag (tuple (nullable.some 1)) 49)
; insert into EMP values(16,'I','J',-16,17,-17,18,-18,19),(16,'I','J',-16,17,-17,18,-18,19),(16,'I','J',-16,17,-17,18,-18,19),(16,'I','J',-16,17,-17,18,-18,19),(16,'I','J',-16,17,-17,18,-18,19),(16,'I','J',-16,17,-17,18,-18,19),(16,'I','J',-16,17,-17,18,-18,19)
; SELECT * FROM (SELECT 1 FROM EMP AS EMP INNER JOIN EMP AS EMP0 ON EMP.DEPTNO = EMP0.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM EMP AS EMP1 INNER JOIN EMP AS EMP2 ON EMP1.DEPTNO = EMP2.DEPTNO) AS q2;

; SELECT * FROM (SELECT 1 FROM EMP AS EMP1 INNER JOIN EMP AS EMP2 ON EMP1.DEPTNO = EMP2.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM EMP AS EMP INNER JOIN EMP AS EMP0 ON EMP.DEPTNO = EMP0.DEPTNO) AS q1;

;Model soundness: false
(reset)
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

(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1144715 Int) (BOUND_VARIABLE_1144716 Int)) (< BOUND_VARIABLE_1144715 BOUND_VARIABLE_1144716)) (nullable.lift (lambda ((BOUND_VARIABLE_1144708 Int) (BOUND_VARIABLE_1144709 Int)) (- BOUND_VARIABLE_1144708 BOUND_VARIABLE_1144709)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1144715 Int) (BOUND_VARIABLE_1144716 Int)) (< BOUND_VARIABLE_1144715 BOUND_VARIABLE_1144716)) (nullable.lift (lambda ((BOUND_VARIABLE_1144708 Int) (BOUND_VARIABLE_1144709 Int)) (- BOUND_VARIABLE_1144708 BOUND_VARIABLE_1144709)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 0)))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_1144734 Int) (BOUND_VARIABLE_1144735 Int)) (+ BOUND_VARIABLE_1144734 BOUND_VARIABLE_1144735)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= q1 (bag.map f3 (bag.filter p2 (bag.union_disjoint (bag (tuple (nullable.some 10) (nullable.some 1)) 1) (bag (tuple (nullable.some 30) (nullable.some 7)) 1))))))
(assert (= q2 ((_ table.project 0 1 2) (bag.difference_remove ((_ table.project 0 1 2) (bag (tuple (nullable.some 0) (nullable.some 0) (nullable.some 0)) 1)) ((_ table.project 0 1 2) (bag (tuple (nullable.some 0) (nullable.some 0) (nullable.some 0)) 1))))))
(check-sat)
;answer: unsat
; duration: 218 ms.
(reset)
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
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_1144930 Int) (BOUND_VARIABLE_1144931 Int)) (= BOUND_VARIABLE_1144930 BOUND_VARIABLE_1144931)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_1144924 Int) (BOUND_VARIABLE_1144925 Int)) (* BOUND_VARIABLE_1144924 BOUND_VARIABLE_1144925)) (nullable.some 10) ((_ tuple.select 5) t))) (nullable.lift (lambda ((BOUND_VARIABLE_1144945 String) (BOUND_VARIABLE_1144946 String)) (= BOUND_VARIABLE_1144945 BOUND_VARIABLE_1144946)) (nullable.lift (lambda ((BOUND_VARIABLE_1144937 String)) (str.to_upper BOUND_VARIABLE_1144937)) ((_ tuple.select 1) t)) (nullable.some "FOO")))) (nullable.val (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_1144930 Int) (BOUND_VARIABLE_1144931 Int)) (= BOUND_VARIABLE_1144930 BOUND_VARIABLE_1144931)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_1144924 Int) (BOUND_VARIABLE_1144925 Int)) (* BOUND_VARIABLE_1144924 BOUND_VARIABLE_1144925)) (nullable.some 10) ((_ tuple.select 5) t))) (nullable.lift (lambda ((BOUND_VARIABLE_1144945 String) (BOUND_VARIABLE_1144946 String)) (= BOUND_VARIABLE_1144945 BOUND_VARIABLE_1144946)) (nullable.lift (lambda ((BOUND_VARIABLE_1144937 String)) (str.to_upper BOUND_VARIABLE_1144937)) ((_ tuple.select 1) t)) (nullable.some "FOO"))))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_1144970 Int) (BOUND_VARIABLE_1144971 Int)) (+ BOUND_VARIABLE_1144970 BOUND_VARIABLE_1144971)) ((_ tuple.select 0) t) ((_ tuple.select 7) t))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_1145021 Int) (BOUND_VARIABLE_1145022 Int)) (= BOUND_VARIABLE_1145021 BOUND_VARIABLE_1145022)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_1145015 Int) (BOUND_VARIABLE_1145016 Int)) (* BOUND_VARIABLE_1145015 BOUND_VARIABLE_1145016)) (nullable.some 10) ((_ tuple.select 3) t))) (nullable.lift (lambda ((BOUND_VARIABLE_1145033 String) (BOUND_VARIABLE_1145034 String)) (= BOUND_VARIABLE_1145033 BOUND_VARIABLE_1145034)) (nullable.lift (lambda ((BOUND_VARIABLE_1145028 String)) (str.to_upper BOUND_VARIABLE_1145028)) ((_ tuple.select 1) t)) (nullable.some "FOO")))) (nullable.val (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_1145021 Int) (BOUND_VARIABLE_1145022 Int)) (= BOUND_VARIABLE_1145021 BOUND_VARIABLE_1145022)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_1145015 Int) (BOUND_VARIABLE_1145016 Int)) (* BOUND_VARIABLE_1145015 BOUND_VARIABLE_1145016)) (nullable.some 10) ((_ tuple.select 3) t))) (nullable.lift (lambda ((BOUND_VARIABLE_1145033 String) (BOUND_VARIABLE_1145034 String)) (= BOUND_VARIABLE_1145033 BOUND_VARIABLE_1145034)) (nullable.lift (lambda ((BOUND_VARIABLE_1145028 String)) (str.to_upper BOUND_VARIABLE_1145028)) ((_ tuple.select 1) t)) (nullable.some "FOO"))))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_1145059 Int) (BOUND_VARIABLE_1145060 Int)) (+ BOUND_VARIABLE_1145059 BOUND_VARIABLE_1145060)) ((_ tuple.select 0) t) ((_ tuple.select 4) t))))))
(assert (= q1 (bag.map f3 (bag.filter p2 EMP))))
(assert (= q2 (bag.map f5 (bag.filter p4 ((_ table.project 0 1 6 5 7) EMP)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10009 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag.union_disjoint (bag (tuple (as nullable.null (Nullable Int)) (nullable.some "foo") (nullable.some "A") (nullable.some (- 2)) (nullable.some 3) (nullable.some 0) (nullable.some 0) (as nullable.null (Nullable Int)) (nullable.some (- 3))) 1) (bag (tuple (as nullable.null (Nullable Int)) (nullable.some "foo") (nullable.some "") (nullable.some 1) (nullable.some (- 1)) (nullable.some 0) (nullable.some 0) (as nullable.null (Nullable Int)) (nullable.some 2)) 1)))
; )
; q1
(get-value (q1))
; (bag (tuple (as nullable.null (Nullable Int))) 2)
; q2
(get-value (q2))
; (bag (tuple (as nullable.null (Nullable Int))) 2)
; insert into EMP values(NULL,'foo','A',-2,3,0,0,NULL,-3),(NULL,'foo','',1,-1,0,0,NULL,2)
; SELECT * FROM (SELECT EMP.EMPNO + EMP.DEPTNO FROM EMP AS EMP WHERE EMP.SAL = 10 * EMP.COMM AND UPPER(EMP.ENAME) = 'FOO') AS q1 EXCEPT ALL SELECT * FROM (SELECT t1.EMPNO + t1.DEPTNO FROM (SELECT EMP0.EMPNO, EMP0.ENAME, EMP0.SAL, EMP0.COMM, EMP0.DEPTNO FROM EMP AS EMP0) AS t1 WHERE t1.SAL = 10 * t1.COMM AND UPPER(t1.ENAME) = 'FOO') AS q2;

; SELECT * FROM (SELECT t1.EMPNO + t1.DEPTNO FROM (SELECT EMP0.EMPNO, EMP0.ENAME, EMP0.SAL, EMP0.COMM, EMP0.DEPTNO FROM EMP AS EMP0) AS t1 WHERE t1.SAL = 10 * t1.COMM AND UPPER(t1.ENAME) = 'FOO') AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.EMPNO + EMP.DEPTNO FROM EMP AS EMP WHERE EMP.SAL = 10 * EMP.COMM AND UPPER(EMP.ENAME) = 'FOO') AS q1;

;Model soundness: false
(reset)
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1193018 Int) (BOUND_VARIABLE_1193019 Int)) (= BOUND_VARIABLE_1193018 BOUND_VARIABLE_1193019)) ((_ tuple.select 0) t) ((_ tuple.select 2) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1193018 Int) (BOUND_VARIABLE_1193019 Int)) (= BOUND_VARIABLE_1193018 BOUND_VARIABLE_1193019)) ((_ tuple.select 0) t) ((_ tuple.select 2) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1193037 Int) (BOUND_VARIABLE_1193038 Int)) (<= BOUND_VARIABLE_1193037 BOUND_VARIABLE_1193038)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1193037 Int) (BOUND_VARIABLE_1193038 Int)) (<= BOUND_VARIABLE_1193037 BOUND_VARIABLE_1193038)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1193057 Int) (BOUND_VARIABLE_1193058 Int)) (<= BOUND_VARIABLE_1193057 BOUND_VARIABLE_1193058)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1193057 Int) (BOUND_VARIABLE_1193058 Int)) (<= BOUND_VARIABLE_1193057 BOUND_VARIABLE_1193058)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1193078 Int) (BOUND_VARIABLE_1193079 Int)) (= BOUND_VARIABLE_1193078 BOUND_VARIABLE_1193079)) ((_ tuple.select 0) t) ((_ tuple.select 2) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1193078 Int) (BOUND_VARIABLE_1193079 Int)) (= BOUND_VARIABLE_1193078 BOUND_VARIABLE_1193079)) ((_ tuple.select 0) t) ((_ tuple.select 2) t)))))))
(assert (= q1 ((_ table.project 0 1 2) (bag.filter p3 (bag.filter p2 (table.product DEPT ((_ table.project 7) EMP)))))))
(assert (= q2 ((_ table.project 0 1 2) (bag.filter p5 (table.product ((_ table.project 0 1) (bag.filter p4 DEPT)) ((_ table.project 7) EMP))))))
(check-sat)
;answer: unsat
; duration: 827 ms.
(reset)
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
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f12 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p9 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p10 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f6 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p11 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1198155 Int) (BOUND_VARIABLE_1198156 Int)) (> BOUND_VARIABLE_1198155 BOUND_VARIABLE_1198156)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1198155 Int) (BOUND_VARIABLE_1198156 Int)) (> BOUND_VARIABLE_1198155 BOUND_VARIABLE_1198156)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1198174 Int) (BOUND_VARIABLE_1198175 Int)) (> BOUND_VARIABLE_1198174 BOUND_VARIABLE_1198175)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1198174 Int) (BOUND_VARIABLE_1198175 Int)) (> BOUND_VARIABLE_1198174 BOUND_VARIABLE_1198175)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1198195 Int) (BOUND_VARIABLE_1198196 Int)) (> BOUND_VARIABLE_1198195 BOUND_VARIABLE_1198196)) ((_ tuple.select 7) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1198195 Int) (BOUND_VARIABLE_1198196 Int)) (> BOUND_VARIABLE_1198195 BOUND_VARIABLE_1198196)) ((_ tuple.select 7) t) (nullable.some 1)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1198217 Int) (BOUND_VARIABLE_1198218 Int)) (= BOUND_VARIABLE_1198217 BOUND_VARIABLE_1198218)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1198217 Int) (BOUND_VARIABLE_1198218 Int)) (= BOUND_VARIABLE_1198217 BOUND_VARIABLE_1198218)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1198243 Int) (BOUND_VARIABLE_1198244 Int)) (> BOUND_VARIABLE_1198243 BOUND_VARIABLE_1198244)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1198243 Int) (BOUND_VARIABLE_1198244 Int)) (> BOUND_VARIABLE_1198243 BOUND_VARIABLE_1198244)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1198262 Int) (BOUND_VARIABLE_1198263 Int)) (> BOUND_VARIABLE_1198262 BOUND_VARIABLE_1198263)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1198262 Int) (BOUND_VARIABLE_1198263 Int)) (> BOUND_VARIABLE_1198262 BOUND_VARIABLE_1198263)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1198283 Int) (BOUND_VARIABLE_1198284 Int)) (> BOUND_VARIABLE_1198283 BOUND_VARIABLE_1198284)) ((_ tuple.select 7) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1198283 Int) (BOUND_VARIABLE_1198284 Int)) (> BOUND_VARIABLE_1198283 BOUND_VARIABLE_1198284)) ((_ tuple.select 7) t) (nullable.some 1)))))))
(assert (= p10 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullableOr (nullableOr (nullable.lift (lambda ((BOUND_VARIABLE_1198303 Int) (BOUND_VARIABLE_1198304 Int)) (> BOUND_VARIABLE_1198303 BOUND_VARIABLE_1198304)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_1198309 Int) (BOUND_VARIABLE_1198310 Int)) (> BOUND_VARIABLE_1198309 BOUND_VARIABLE_1198310)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1198315 Int) (BOUND_VARIABLE_1198316 Int)) (> BOUND_VARIABLE_1198315 BOUND_VARIABLE_1198316)) ((_ tuple.select 7) t) (nullable.some 1)))) (nullable.val (nullableOr (nullableOr (nullable.lift (lambda ((BOUND_VARIABLE_1198303 Int) (BOUND_VARIABLE_1198304 Int)) (> BOUND_VARIABLE_1198303 BOUND_VARIABLE_1198304)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_1198309 Int) (BOUND_VARIABLE_1198310 Int)) (> BOUND_VARIABLE_1198309 BOUND_VARIABLE_1198310)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1198315 Int) (BOUND_VARIABLE_1198316 Int)) (> BOUND_VARIABLE_1198315 BOUND_VARIABLE_1198316)) ((_ tuple.select 7) t) (nullable.some 1))))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p11 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1198344 Int) (BOUND_VARIABLE_1198345 Int)) (= BOUND_VARIABLE_1198344 BOUND_VARIABLE_1198345)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1198344 Int) (BOUND_VARIABLE_1198345 Int)) (= BOUND_VARIABLE_1198344 BOUND_VARIABLE_1198345)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f12 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f6 (bag.filter p5 (table.product (bag.union_disjoint ((_ table.project 0) (bag.union_disjoint ((_ table.project 7) (bag.filter p2 EMP)) ((_ table.project 7) (bag.filter p3 EMP)))) ((_ table.project 7) (bag.filter p4 EMP))) EMP)))))
(assert (= q2 (bag.map f12 (bag.filter p11 (table.product (bag.union_disjoint ((_ table.project 0) (bag.union_disjoint ((_ table.project 7) (bag.filter p7 EMP)) ((_ table.project 7) (bag.filter p8 EMP)))) ((_ table.project 7) (bag.filter p9 EMP))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p10 EMP)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10025 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some (- 67)) (nullable.some "k") (nullable.some "l") (nullable.some 68) (nullable.some (- 68)) (nullable.some 69) (nullable.some (- 69)) (nullable.some 3) (nullable.some 70)) 71))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 1)) 5041)
; q2
(get-value (q2))
; (bag (tuple (nullable.some 1)) 5041)
; insert into EMP values(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70),(-67,'k','l',68,-68,69,-69,3,70)
; SELECT * FROM (SELECT 1 FROM (SELECT * FROM (SELECT EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO > 7 UNION ALL SELECT EMP0.DEPTNO FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 10) AS t3 UNION ALL SELECT EMP1.DEPTNO FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 1) AS t6 INNER JOIN EMP AS EMP2 ON t6.DEPTNO = EMP2.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM (SELECT EMP3.DEPTNO FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 7 UNION ALL SELECT EMP4.DEPTNO FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 10) AS t12 UNION ALL SELECT EMP5.DEPTNO FROM EMP AS EMP5 WHERE EMP5.DEPTNO > 1) AS t15 INNER JOIN (SELECT * FROM EMP AS EMP6 WHERE EMP6.DEPTNO > 7 OR EMP6.DEPTNO > 10 OR EMP6.DEPTNO > 1) AS t16 ON t15.DEPTNO = t16.DEPTNO) AS q2;

; SELECT * FROM (SELECT 1 FROM (SELECT * FROM (SELECT EMP3.DEPTNO FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 7 UNION ALL SELECT EMP4.DEPTNO FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 10) AS t12 UNION ALL SELECT EMP5.DEPTNO FROM EMP AS EMP5 WHERE EMP5.DEPTNO > 1) AS t15 INNER JOIN (SELECT * FROM EMP AS EMP6 WHERE EMP6.DEPTNO > 7 OR EMP6.DEPTNO > 10 OR EMP6.DEPTNO > 1) AS t16 ON t15.DEPTNO = t16.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM (SELECT EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO > 7 UNION ALL SELECT EMP0.DEPTNO FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 10) AS t3 UNION ALL SELECT EMP1.DEPTNO FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 1) AS t6 INNER JOIN EMP AS EMP2 ON t6.DEPTNO = EMP2.DEPTNO) AS q1;

;Model soundness: false
(reset)
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const rightJoin7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const rightJoin4 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f5 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1250742 Int) (BOUND_VARIABLE_1250743 Int)) (= BOUND_VARIABLE_1250742 BOUND_VARIABLE_1250743)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1250742 Int) (BOUND_VARIABLE_1250743 Int)) (= BOUND_VARIABLE_1250742 BOUND_VARIABLE_1250743)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1250842 Int) (BOUND_VARIABLE_1250843 Int)) (= BOUND_VARIABLE_1250842 BOUND_VARIABLE_1250843)) ((_ tuple.select 7) t) ((_ tuple.select 11) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1250842 Int) (BOUND_VARIABLE_1250843 Int)) (= BOUND_VARIABLE_1250842 BOUND_VARIABLE_1250843)) ((_ tuple.select 7) t) ((_ tuple.select 11) t)))))))
(assert (= rightJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map rightJoin4 (bag.difference_remove DEPT ((_ table.project 9 10) (bag.filter p3 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)) DEPT))))) (bag.filter p3 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)) DEPT))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map rightJoin7 (bag.difference_remove (bag.map f5 DEPT) ((_ table.project 9 10 11) (bag.filter p6 (table.product (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0)) 1)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0)) 1))) (bag.map f5 DEPT)))))) (bag.filter p6 (table.product (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0)) 1)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0)) 1))) (bag.map f5 DEPT)))))))
(check-sat)
;answer: unsat
; duration: 1480 ms.
(reset)
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
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f12 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const leftJoin4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p9 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const leftJoin10 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p11 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1258800 Int) (BOUND_VARIABLE_1258801 Int)) (> BOUND_VARIABLE_1258800 BOUND_VARIABLE_1258801)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1258800 Int) (BOUND_VARIABLE_1258801 Int)) (> BOUND_VARIABLE_1258800 BOUND_VARIABLE_1258801)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1258821 Int) (BOUND_VARIABLE_1258822 Int)) (= BOUND_VARIABLE_1258821 BOUND_VARIABLE_1258822)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1258821 Int) (BOUND_VARIABLE_1258822 Int)) (= BOUND_VARIABLE_1258821 BOUND_VARIABLE_1258822)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= leftJoin4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1258860 Int) (BOUND_VARIABLE_1258861 Int)) (> BOUND_VARIABLE_1258860 BOUND_VARIABLE_1258861)) ((_ tuple.select 16) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1258860 Int) (BOUND_VARIABLE_1258861 Int)) (> BOUND_VARIABLE_1258860 BOUND_VARIABLE_1258861)) ((_ tuple.select 16) t) (nullable.some 9)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1258886 Int) (BOUND_VARIABLE_1258887 Int)) (> BOUND_VARIABLE_1258886 BOUND_VARIABLE_1258887)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1258886 Int) (BOUND_VARIABLE_1258887 Int)) (> BOUND_VARIABLE_1258886 BOUND_VARIABLE_1258887)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1258905 Int) (BOUND_VARIABLE_1258906 Int)) (> BOUND_VARIABLE_1258905 BOUND_VARIABLE_1258906)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1258905 Int) (BOUND_VARIABLE_1258906 Int)) (> BOUND_VARIABLE_1258905 BOUND_VARIABLE_1258906)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1258926 Int) (BOUND_VARIABLE_1258927 Int)) (= BOUND_VARIABLE_1258926 BOUND_VARIABLE_1258927)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1258926 Int) (BOUND_VARIABLE_1258927 Int)) (= BOUND_VARIABLE_1258926 BOUND_VARIABLE_1258927)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= leftJoin10 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p11 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1258965 Int) (BOUND_VARIABLE_1258966 Int)) (> BOUND_VARIABLE_1258965 BOUND_VARIABLE_1258966)) ((_ tuple.select 16) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1258965 Int) (BOUND_VARIABLE_1258966 Int)) (> BOUND_VARIABLE_1258965 BOUND_VARIABLE_1258966)) ((_ tuple.select 16) t) (nullable.some 9)))))))
(assert (= f12 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f6 (bag.filter p5 (bag.union_disjoint (bag.map leftJoin4 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)) EMP))))) (bag.filter p3 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)) EMP)))))))
(assert (= q2 (bag.map f12 (bag.filter p11 (bag.union_disjoint (bag.map leftJoin10 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p7 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p9 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p7 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p8 EMP))))))) (bag.filter p9 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p7 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p8 EMP)))))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10079 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7) AS t LEFT JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO WHERE EMP0.DEPTNO > 9) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t2 LEFT JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t3 ON t2.DEPTNO = t3.DEPTNO WHERE t3.DEPTNO > 9) AS q2;

; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t2 LEFT JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t3 ON t2.DEPTNO = t3.DEPTNO WHERE t3.DEPTNO > 9) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7) AS t LEFT JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO WHERE EMP0.DEPTNO > 9) AS q1;

;Model soundness: false
(reset)
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
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const f2 (-> (Tuple (Nullable Int)) (Tuple (Nullable Bool))))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const f3 (-> (Tuple (Nullable Int)) (Tuple (Nullable Bool))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int)))) (tuple (nullable.some false)))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int)))) (tuple (nullable.some false)))))
(assert (= q1 (bag.map f2 (bag (tuple (nullable.some 0)) 1))))
(assert (= q2 (bag.map f3 (bag (tuple (nullable.some 0)) 1))))
(check-sat)
;answer: unsat
; duration: 179 ms.
(reset)
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
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= q1 ((_ table.project 6) (table.product EMP (bag.union_disjoint ((_ table.project 0 1 2 3 4 5 6 7 8) EMP) ((_ table.project 0 1 2 3 4 5 6 7 8) EMP))))))
(assert (= q2 ((_ table.project 6) (bag.union_disjoint ((_ table.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) (table.product EMP EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) (table.product EMP EMP))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 13286 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag.union_disjoint (bag (tuple (nullable.some (- 3)) (nullable.some "A") (nullable.some "B") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (nullable.some (- 6))) 19) (bag (tuple (nullable.some 7) (nullable.some "C") (nullable.some "D") (nullable.some (- 7)) (nullable.some 8) (nullable.some (- 8)) (nullable.some 9) (nullable.some (- 9)) (nullable.some 10)) 29)))
; )
; q1
(get-value (q1))
; (bag.union_disjoint (bag (tuple (nullable.some (- 5))) 1824) (bag (tuple (nullable.some 9)) 2784))
; q2
(get-value (q2))
; (bag.union_disjoint (bag (tuple (nullable.some (- 5))) 1824) (bag (tuple (nullable.some 9)) 2784))
; insert into EMP values(-3,'A','B',4,-4,5,-5,6,-6),(-3,'A','B',4,-4,5,-5,6,-6),(-3,'A','B',4,-4,5,-5,6,-6),(-3,'A','B',4,-4,5,-5,6,-6),(-3,'A','B',4,-4,5,-5,6,-6),(-3,'A','B',4,-4,5,-5,6,-6),(-3,'A','B',4,-4,5,-5,6,-6),(-3,'A','B',4,-4,5,-5,6,-6),(-3,'A','B',4,-4,5,-5,6,-6),(-3,'A','B',4,-4,5,-5,6,-6),(-3,'A','B',4,-4,5,-5,6,-6),(-3,'A','B',4,-4,5,-5,6,-6),(-3,'A','B',4,-4,5,-5,6,-6),(-3,'A','B',4,-4,5,-5,6,-6),(-3,'A','B',4,-4,5,-5,6,-6),(-3,'A','B',4,-4,5,-5,6,-6),(-3,'A','B',4,-4,5,-5,6,-6),(-3,'A','B',4,-4,5,-5,6,-6),(-3,'A','B',4,-4,5,-5,6,-6),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10),(7,'C','D',-7,8,-8,9,-9,10)
(reset)
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
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f10 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p7 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const leftJoin3 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p9 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const rightJoin4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1451017 Int) (BOUND_VARIABLE_1451018 Int)) (= BOUND_VARIABLE_1451017 BOUND_VARIABLE_1451018)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1451017 Int) (BOUND_VARIABLE_1451018 Int)) (= BOUND_VARIABLE_1451017 BOUND_VARIABLE_1451018)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin3 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_1451072 String) (BOUND_VARIABLE_1451073 String)) (= BOUND_VARIABLE_1451072 BOUND_VARIABLE_1451073)) ((_ tuple.select 1) t) (nullable.some "Charlie")) (nullable.lift (lambda ((BOUND_VARIABLE_1451079 Int) (BOUND_VARIABLE_1451080 Int)) (> BOUND_VARIABLE_1451079 BOUND_VARIABLE_1451080)) ((_ tuple.select 8) t) (nullable.some 100)))) (nullable.val (nullableAnd (nullable.lift (lambda ((BOUND_VARIABLE_1451072 String) (BOUND_VARIABLE_1451073 String)) (= BOUND_VARIABLE_1451072 BOUND_VARIABLE_1451073)) ((_ tuple.select 1) t) (nullable.some "Charlie")) (nullable.lift (lambda ((BOUND_VARIABLE_1451079 Int) (BOUND_VARIABLE_1451080 Int)) (> BOUND_VARIABLE_1451079 BOUND_VARIABLE_1451080)) ((_ tuple.select 8) t) (nullable.some 100))))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1451111 String) (BOUND_VARIABLE_1451112 String)) (= BOUND_VARIABLE_1451111 BOUND_VARIABLE_1451112)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1451111 String) (BOUND_VARIABLE_1451112 String)) (= BOUND_VARIABLE_1451111 BOUND_VARIABLE_1451112)) ((_ tuple.select 1) t) (nullable.some "Charlie")))))))
(assert (= p8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1451130 Int) (BOUND_VARIABLE_1451131 Int)) (> BOUND_VARIABLE_1451130 BOUND_VARIABLE_1451131)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1451130 Int) (BOUND_VARIABLE_1451131 Int)) (> BOUND_VARIABLE_1451130 BOUND_VARIABLE_1451131)) ((_ tuple.select 6) t) (nullable.some 100)))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1451151 Int) (BOUND_VARIABLE_1451152 Int)) (= BOUND_VARIABLE_1451151 BOUND_VARIABLE_1451152)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1451151 Int) (BOUND_VARIABLE_1451152 Int)) (= BOUND_VARIABLE_1451151 BOUND_VARIABLE_1451152)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= f10 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f6 (bag.filter p5 (bag.union_disjoint (bag.union_disjoint (bag.map leftJoin3 (bag.difference_remove DEPT ((_ table.project 0 1) (bag.filter p2 (table.product DEPT EMP))))) (bag.map rightJoin4 (bag.difference_remove EMP ((_ table.project 2 3 4 5 6 7 8 9 10) (bag.filter p2 (table.product DEPT EMP)))))) (bag.filter p2 (table.product DEPT EMP)))))))
(assert (= q2 (bag.map f10 (bag.filter p9 (table.product ((_ table.project 0 1) (bag.filter p7 DEPT)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p8 EMP)))))))
(check-sat)
;answer: unsat
; duration: 10362 ms.
(reset)
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
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const nullableOr (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(declare-const nullableAnd (-> (Nullable Bool) (Nullable Bool) (Nullable Bool)))
(assert (= nullableAnd (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some false))) (nullable.some false) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (nullable.some false) (ite (and (nullable.is_null x) (= y (nullable.some true))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (and (nullable.val x) (nullable.val y))))))))))
(assert (= nullableOr (lambda ((x (Nullable Bool)) (y (Nullable Bool))) (ite (and (nullable.is_null x) (= y (nullable.some true))) (nullable.some true) (ite (and (= x (nullable.some true)) (nullable.is_null y)) (nullable.some true) (ite (and (nullable.is_null x) (= y (nullable.some false))) (as nullable.null (Nullable Bool)) (ite (and (= x (nullable.some false)) (nullable.is_null y)) (as nullable.null (Nullable Bool)) (nullable.some (or (nullable.val x) (nullable.val y))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullableOr (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1484319 Int) (BOUND_VARIABLE_1484320 Int)) (= BOUND_VARIABLE_1484319 BOUND_VARIABLE_1484320)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1484319 Int) (BOUND_VARIABLE_1484320 Int)) (= BOUND_VARIABLE_1484319 BOUND_VARIABLE_1484320)) ((_ tuple.select 6) t) (nullable.some 1000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))) (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1484343 Int) (BOUND_VARIABLE_1484344 Int)) (= BOUND_VARIABLE_1484343 BOUND_VARIABLE_1484344)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1484343 Int) (BOUND_VARIABLE_1484344 Int)) (= BOUND_VARIABLE_1484343 BOUND_VARIABLE_1484344)) ((_ tuple.select 6) t) (nullable.some 2000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))))) (nullable.val (nullableOr (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1484319 Int) (BOUND_VARIABLE_1484320 Int)) (= BOUND_VARIABLE_1484319 BOUND_VARIABLE_1484320)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1484319 Int) (BOUND_VARIABLE_1484320 Int)) (= BOUND_VARIABLE_1484319 BOUND_VARIABLE_1484320)) ((_ tuple.select 6) t) (nullable.some 1000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))) (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1484343 Int) (BOUND_VARIABLE_1484344 Int)) (= BOUND_VARIABLE_1484343 BOUND_VARIABLE_1484344)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1484343 Int) (BOUND_VARIABLE_1484344 Int)) (= BOUND_VARIABLE_1484343 BOUND_VARIABLE_1484344)) ((_ tuple.select 6) t) (nullable.some 2000)))) (as nullable.null (Nullable Int)) (nullable.some 1))))))))))
(assert (not (= q1 q2)))
(assert (= (nullable.val (as nullable.null (Nullable Bool))) false))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullableOr (nullable.lift (lambda ((BOUND_VARIABLE_1484374 Int) (BOUND_VARIABLE_1484375 Int)) (= BOUND_VARIABLE_1484374 BOUND_VARIABLE_1484375)) ((_ tuple.select 6) t) (nullable.some 1000)) (nullable.lift (lambda ((BOUND_VARIABLE_1484380 Int) (BOUND_VARIABLE_1484381 Int)) (= BOUND_VARIABLE_1484380 BOUND_VARIABLE_1484381)) ((_ tuple.select 6) t) (nullable.some 2000)))) (nullable.val (nullableOr (nullable.lift (lambda ((BOUND_VARIABLE_1484374 Int) (BOUND_VARIABLE_1484375 Int)) (= BOUND_VARIABLE_1484374 BOUND_VARIABLE_1484375)) ((_ tuple.select 6) t) (nullable.some 1000)) (nullable.lift (lambda ((BOUND_VARIABLE_1484380 Int) (BOUND_VARIABLE_1484381 Int)) (= BOUND_VARIABLE_1484380 BOUND_VARIABLE_1484381)) ((_ tuple.select 6) t) (nullable.some 2000))))))))
(assert (= q1 ((_ table.project 6) (bag.filter p2 EMP))))
(assert (= q2 ((_ table.project 6) (bag.filter p3 EMP))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10216 ms.
(get-model)
