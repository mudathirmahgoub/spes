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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_401 Int) (BOUND_VARIABLE_402 Int)) (> BOUND_VARIABLE_401 BOUND_VARIABLE_402)) (nullable.lift (lambda ((BOUND_VARIABLE_393 Int) (BOUND_VARIABLE_394 Int)) (+ BOUND_VARIABLE_393 BOUND_VARIABLE_394)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_401 Int) (BOUND_VARIABLE_402 Int)) (> BOUND_VARIABLE_401 BOUND_VARIABLE_402)) (nullable.lift (lambda ((BOUND_VARIABLE_393 Int) (BOUND_VARIABLE_394 Int)) (+ BOUND_VARIABLE_393 BOUND_VARIABLE_394)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 10)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_451 Int) (BOUND_VARIABLE_452 Int)) (+ BOUND_VARIABLE_451 BOUND_VARIABLE_452)) (nullable.lift (lambda ((BOUND_VARIABLE_445 Int) (BOUND_VARIABLE_446 Int)) (+ BOUND_VARIABLE_445 BOUND_VARIABLE_446)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 0) t))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= q1 (set.map f1 (set.filter p0 (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 30) (nullable.some 3))))))))
(assert (= q2 ((_ rel.project 0) (set.filter p2 (set.singleton (tuple (nullable.some 0)))))))
(check-sat)
;answer: sat
; duration: 139 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (set.union (set.singleton (tuple (nullable.some 21))) (set.singleton (tuple (nullable.some 63))))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; SELECT * FROM (SELECT t.column1 + t.column2 + t.column1 FROM (VALUES  (10, 1),  (30, 3)) AS t WHERE t.column1 + t.column2 > 10) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES (0)) WHERE FALSE) AS t3) AS q2;
;(63)
;(21)

; SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES (0)) WHERE FALSE) AS t3) AS q2 EXCEPT ALL SELECT * FROM (SELECT t.column1 + t.column2 + t.column1 FROM (VALUES  (10, 1),  (30, 3)) AS t WHERE t.column1 + t.column2 > 10) AS q1;

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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_411 Int) (BOUND_VARIABLE_412 Int)) (> BOUND_VARIABLE_411 BOUND_VARIABLE_412)) (nullable.lift (lambda ((BOUND_VARIABLE_403 Int) (BOUND_VARIABLE_404 Int)) (+ BOUND_VARIABLE_403 BOUND_VARIABLE_404)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_411 Int) (BOUND_VARIABLE_412 Int)) (> BOUND_VARIABLE_411 BOUND_VARIABLE_412)) (nullable.lift (lambda ((BOUND_VARIABLE_403 Int) (BOUND_VARIABLE_404 Int)) (+ BOUND_VARIABLE_403 BOUND_VARIABLE_404)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 10)))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 (set.union ((_ rel.project 0 1) (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 30) (nullable.some 3))))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 20) (nullable.some 2)))))))))
(assert (= q2 ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 30) (nullable.some 3))))))
(check-sat)
;answer: sat
; duration: 15 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (set.union (set.singleton (tuple (nullable.some 20) (nullable.some 2))) (set.union (set.singleton (tuple (nullable.some 30) (nullable.some 3))) (set.singleton (tuple (nullable.some 10) (nullable.some 1)))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 30) (nullable.some 3)))
; SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES  (10, 1),  (30, 3)) AS t UNION ALL SELECT * FROM (VALUES  (20, 2)) AS t0) AS t1 WHERE t1.column1 + t1.column2 > 10) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (VALUES  (30, 3)) AS t3) AS q2;
;(20,2)
;(10,1)

; SELECT * FROM (SELECT * FROM (VALUES  (30, 3)) AS t3) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES  (10, 1),  (30, 3)) AS t UNION ALL SELECT * FROM (VALUES  (20, 2)) AS t0) AS t1 WHERE t1.column1 + t1.column2 > 10) AS q1;

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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_409 Int) (BOUND_VARIABLE_410 Int)) (< BOUND_VARIABLE_409 BOUND_VARIABLE_410)) (nullable.lift (lambda ((BOUND_VARIABLE_399 Int) (BOUND_VARIABLE_400 Int)) (- BOUND_VARIABLE_399 BOUND_VARIABLE_400)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_409 Int) (BOUND_VARIABLE_410 Int)) (< BOUND_VARIABLE_409 BOUND_VARIABLE_410)) (nullable.lift (lambda ((BOUND_VARIABLE_399 Int) (BOUND_VARIABLE_400 Int)) (- BOUND_VARIABLE_399 BOUND_VARIABLE_400)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 100)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_459 Int) (BOUND_VARIABLE_460 Int)) (+ BOUND_VARIABLE_459 BOUND_VARIABLE_460)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= q1 (set.map f1 (set.filter p0 (set.union (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 30) (nullable.some 7)))) (set.singleton (tuple (nullable.some 20) (nullable.some 3))))))))
(assert (= q2 ((_ rel.project 0 1 2) (set.union (set.singleton (tuple (nullable.some 11) (nullable.some 1) (nullable.some 10))) (set.singleton (tuple (nullable.some 23) (nullable.some 3) (nullable.some 20)))))))
(check-sat)
;answer: sat
; duration: 14 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (set.union (set.singleton (tuple (nullable.some 37) (nullable.some 7) (nullable.some 30))) (set.union (set.singleton (tuple (nullable.some 23) (nullable.some 3) (nullable.some 20))) (set.singleton (tuple (nullable.some 11) (nullable.some 1) (nullable.some 10)))))
; q2
(get-value (q2))
; (set.union (set.singleton (tuple (nullable.some 23) (nullable.some 3) (nullable.some 20))) (set.singleton (tuple (nullable.some 11) (nullable.some 1) (nullable.some 10))))
; SELECT * FROM (SELECT t.column1 + t.column2 AS X, t.column2 AS B, t.column1 AS A FROM (VALUES  (10, 1),  (30, 7),  (20, 3)) AS t WHERE t.column1 - t.column2 < 100) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (VALUES  (11, 1, 10),  (23, 3, 20)) AS t2) AS q2;
;(37,7,30)

; SELECT * FROM (SELECT * FROM (VALUES  (11, 1, 10),  (23, 3, 20)) AS t2) AS q2 EXCEPT ALL SELECT * FROM (SELECT t.column1 + t.column2 AS X, t.column2 AS B, t.column1 AS A FROM (VALUES  (10, 1),  (30, 7),  (20, 3)) AS t WHERE t.column1 - t.column2 < 100) AS q1;

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: testMergeMinus
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 EXCEPT SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 EXCEPT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 10
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_458 Int) (BOUND_VARIABLE_459 Int)) (= BOUND_VARIABLE_458 BOUND_VARIABLE_459)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_458 Int) (BOUND_VARIABLE_459 Int)) (= BOUND_VARIABLE_458 BOUND_VARIABLE_459)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_477 Int) (BOUND_VARIABLE_478 Int)) (= BOUND_VARIABLE_477 BOUND_VARIABLE_478)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_477 Int) (BOUND_VARIABLE_478 Int)) (= BOUND_VARIABLE_477 BOUND_VARIABLE_478)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_495 Int) (BOUND_VARIABLE_496 Int)) (= BOUND_VARIABLE_495 BOUND_VARIABLE_496)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_495 Int) (BOUND_VARIABLE_496 Int)) (= BOUND_VARIABLE_495 BOUND_VARIABLE_496)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_512 Int) (BOUND_VARIABLE_513 Int)) (= BOUND_VARIABLE_512 BOUND_VARIABLE_513)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_512 Int) (BOUND_VARIABLE_513 Int)) (= BOUND_VARIABLE_512 BOUND_VARIABLE_513)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_532 Int) (BOUND_VARIABLE_533 Int)) (= BOUND_VARIABLE_532 BOUND_VARIABLE_533)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_532 Int) (BOUND_VARIABLE_533 Int)) (= BOUND_VARIABLE_532 BOUND_VARIABLE_533)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))
(assert (= q2 (set.minus (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))
(check-sat)
;answer: sat
; duration: 116 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some (- 3)) (nullable.some "A") (nullable.some "B") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 10) (nullable.some 6))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some (- 3)) (nullable.some "A") (nullable.some "B") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 10) (nullable.some 6)))
; insert into EMP values(-3,'A','B',4,-4,5,-5,10,6)
; SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 EXCEPT SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 EXCEPT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 10) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 EXCEPT SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 EXCEPT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS q2;

; SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 EXCEPT SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 EXCEPT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 EXCEPT SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 EXCEPT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 10) AS q1;
;(-3,A,B,4,-4,5,-5,10,6)

;Model soundness: true
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_386 Int) (BOUND_VARIABLE_387 Int)) (>= BOUND_VARIABLE_386 BOUND_VARIABLE_387)) ((_ tuple.select 0) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_386 Int) (BOUND_VARIABLE_387 Int)) (>= BOUND_VARIABLE_386 BOUND_VARIABLE_387)) ((_ tuple.select 0) t) (nullable.some 30)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= q1 (set.minus ((_ rel.project 0 1) (set.minus ((_ rel.project 0 1) (set.filter p0 (set.singleton (tuple (nullable.some 30) (nullable.some 3))))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 20) (nullable.some 2)))))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 40) (nullable.some 3)))))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p1 (set.singleton (tuple (nullable.some 0) (nullable.some 0)))))))
(check-sat)
;answer: sat
; duration: 12 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 30) (nullable.some 3)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable Int))))
; SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES  (30, 3)) AS t WHERE t.column1 >= 30 EXCEPT SELECT * FROM (VALUES  (20, 2)) AS t1) AS t2 EXCEPT SELECT * FROM (VALUES  (40, 3)) AS t3) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES  (0, 0)) WHERE FALSE) AS t5) AS q2;
;(30,3)

; SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES  (0, 0)) WHERE FALSE) AS t5) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES  (30, 3)) AS t WHERE t.column1 >= 30 EXCEPT SELECT * FROM (VALUES  (20, 2)) AS t1) AS t2 EXCEPT SELECT * FROM (VALUES  (40, 3)) AS t3) AS q1;

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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_403 Int) (BOUND_VARIABLE_404 Int)) (+ BOUND_VARIABLE_403 BOUND_VARIABLE_404)) ((_ tuple.select 0) t) ((_ tuple.select 1) t))))))
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
; SELECT * FROM (SELECT t.column1 + t.column2 FROM (VALUES  (10, 1),  (20, 2)) AS t) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (VALUES  (11),  (23)) AS t1) AS q2;
;(22)

; SELECT * FROM (SELECT * FROM (VALUES  (11),  (23)) AS t1) AS q2 EXCEPT ALL SELECT * FROM (SELECT t.column1 + t.column2 FROM (VALUES  (10, 1),  (20, 2)) AS t) AS q1;
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_411 Int) (BOUND_VARIABLE_412 Int)) (< BOUND_VARIABLE_411 BOUND_VARIABLE_412)) ((_ tuple.select 0) t) (nullable.some 15))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_411 Int) (BOUND_VARIABLE_412 Int)) (< BOUND_VARIABLE_411 BOUND_VARIABLE_412)) ((_ tuple.select 0) t) (nullable.some 15)))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 (set.union (set.singleton (tuple (nullable.some 10) (nullable.some "x"))) (set.singleton (tuple (nullable.some 14) (nullable.some "y"))))))))
(assert (= q2 ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 10) (nullable.some "x"))))))
(check-sat)
;answer: sat
; duration: 7 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (set.union (set.singleton (tuple (nullable.some 14) (nullable.some "y"))) (set.singleton (tuple (nullable.some 10) (nullable.some "x"))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 10) (nullable.some "x")))
; SELECT * FROM (SELECT * FROM (VALUES  (10, 'x'),  (14, 'y')) AS t WHERE t.column1 < 15) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (VALUES  (10, 'x')) AS t1) AS q2;
;(14,y)

; SELECT * FROM (SELECT * FROM (VALUES  (10, 'x')) AS t1) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (VALUES  (10, 'x'),  (14, 'y')) AS t WHERE t.column1 < 15) AS q1;

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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_398 Int) (BOUND_VARIABLE_399 Int)) (= BOUND_VARIABLE_398 BOUND_VARIABLE_399)) ((_ tuple.select 0) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_398 Int) (BOUND_VARIABLE_399 Int)) (= BOUND_VARIABLE_398 BOUND_VARIABLE_399)) ((_ tuple.select 0) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 7))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_435 Bool) (BOUND_VARIABLE_436 Bool)) (and BOUND_VARIABLE_435 BOUND_VARIABLE_436)) (nullable.lift (lambda ((BOUND_VARIABLE_398 Int) (BOUND_VARIABLE_399 Int)) (= BOUND_VARIABLE_398 BOUND_VARIABLE_399)) ((_ tuple.select 0) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 7)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_398 Int) (BOUND_VARIABLE_399 Int)) (= BOUND_VARIABLE_398 BOUND_VARIABLE_399)) ((_ tuple.select 0) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_398 Int) (BOUND_VARIABLE_399 Int)) (= BOUND_VARIABLE_398 BOUND_VARIABLE_399)) ((_ tuple.select 0) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 7))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_435 Bool) (BOUND_VARIABLE_436 Bool)) (and BOUND_VARIABLE_435 BOUND_VARIABLE_436)) (nullable.lift (lambda ((BOUND_VARIABLE_398 Int) (BOUND_VARIABLE_399 Int)) (= BOUND_VARIABLE_398 BOUND_VARIABLE_399)) ((_ tuple.select 0) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 7))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= q1 ((_ rel.project 0) (set.filter p0 DEPT))))
(assert (= q2 ((_ rel.project 0) (set.filter p1 (set.singleton (tuple (nullable.some 0) (nullable.some 0)))))))
(check-sat)
;answer: sat
; duration: 23 ms.
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
; SELECT * FROM (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE DEPT.DEPTNO = 7 AND DEPT.DEPTNO = 7) AS q1 EXCEPT ALL SELECT * FROM (SELECT t1.column1 FROM (SELECT * FROM (VALUES(0, 0)) WHERE FALSE) AS t1) AS q2;
;(7)

; SELECT * FROM (SELECT t1.column1 FROM (SELECT * FROM (VALUES(0, 0)) WHERE FALSE) AS t1) AS q2 EXCEPT ALL SELECT * FROM (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE DEPT.DEPTNO = 7 AND DEPT.DEPTNO = 7) AS q1;

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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_482 Int) (BOUND_VARIABLE_483 Int)) (distinct BOUND_VARIABLE_482 BOUND_VARIABLE_483)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_482 Int) (BOUND_VARIABLE_483 Int)) (distinct BOUND_VARIABLE_482 BOUND_VARIABLE_483)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_531 Int) (BOUND_VARIABLE_532 Int)) (= BOUND_VARIABLE_531 BOUND_VARIABLE_532)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_531 Int) (BOUND_VARIABLE_532 Int)) (= BOUND_VARIABLE_531 BOUND_VARIABLE_532)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ rel.project 1) (set.filter p0 (rel.product EMP DEPT)))))
(assert (= q2 ((_ rel.project 1) (set.filter p1 (rel.product EMP DEPT)))))
(check-sat)
;answer: sat
; duration: 46 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 1) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some (- 3)) (nullable.some (- 1)) (nullable.some 4))))
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 0) (nullable.some "A"))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (as nullable.null (Nullable String))))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable String))))
; insert into EMP values(1,NULL,'',2,-2,3,-3,-1,4)
; insert into DEPT values(0,'A')
; SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO <> DEPT.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT EMP0.ENAME FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO) AS q2;
;(NULL)

; SELECT * FROM (SELECT EMP0.ENAME FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO <> DEPT.DEPTNO) AS q1;

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
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 3) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.some 2) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= q1 (set.union (set.map f0 EMP) (set.map f1 EMP))))
(assert (= q2 (set.map f2 (set.union ((_ rel.project 7 2) EMP) ((_ rel.project 7 2) EMP)))))
(check-sat)
;answer: sat
; duration: 39 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 9) (nullable.some "E") (nullable.some "D") (nullable.some (- 9)) (nullable.some 10) (nullable.some (- 10)) (nullable.some 11) (nullable.some (- 8)) (nullable.some (- 11)))))
; )
; q1
(get-value (q1))
; (set.union (set.singleton (tuple (nullable.some 2) (nullable.some (- 8)) (nullable.some "D"))) (set.singleton (tuple (nullable.some 3) (nullable.some (- 8)) (nullable.some "D"))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 2) (nullable.some (- 8)) (nullable.some "D")))
; insert into EMP values(9,'E','D',-9,10,-10,11,-8,-11)
; SELECT * FROM (SELECT 2, EMP.DEPTNO, EMP.JOB FROM EMP AS EMP UNION ALL SELECT 3, EMP0.DEPTNO, EMP0.JOB FROM EMP AS EMP0) AS q1 EXCEPT ALL SELECT * FROM (SELECT 2, t6.DEPTNO, t6.JOB FROM (SELECT EMP1.DEPTNO, EMP1.JOB FROM EMP AS EMP1 UNION ALL SELECT EMP2.DEPTNO, EMP2.JOB FROM EMP AS EMP2) AS t6) AS q2;
;(3,-8,D)

; SELECT * FROM (SELECT 2, t6.DEPTNO, t6.JOB FROM (SELECT EMP1.DEPTNO, EMP1.JOB FROM EMP AS EMP1 UNION ALL SELECT EMP2.DEPTNO, EMP2.JOB FROM EMP AS EMP2) AS t6) AS q2 EXCEPT ALL SELECT * FROM (SELECT 2, EMP.DEPTNO, EMP.JOB FROM EMP AS EMP UNION ALL SELECT 3, EMP0.DEPTNO, EMP0.JOB FROM EMP AS EMP0) AS q1;
;(2,-8,D)

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
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (ite (and (nullable.is_some (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_445 Int) (BOUND_VARIABLE_446 Int)) (> BOUND_VARIABLE_445 BOUND_VARIABLE_446)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_445 Int) (BOUND_VARIABLE_446 Int)) (> BOUND_VARIABLE_445 BOUND_VARIABLE_446)) ((_ tuple.select 6) t) (nullable.some 1000)))))) (not (nullable.val (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_445 Int) (BOUND_VARIABLE_446 Int)) (> BOUND_VARIABLE_445 BOUND_VARIABLE_446)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_445 Int) (BOUND_VARIABLE_446 Int)) (> BOUND_VARIABLE_445 BOUND_VARIABLE_446)) ((_ tuple.select 6) t) (nullable.some 1000)))))))) (nullable.some false) (ite (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_467 Bool) (BOUND_VARIABLE_468 Bool)) (and BOUND_VARIABLE_467 BOUND_VARIABLE_468)) (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_445 Int) (BOUND_VARIABLE_446 Int)) (> BOUND_VARIABLE_445 BOUND_VARIABLE_446)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_445 Int) (BOUND_VARIABLE_446 Int)) (> BOUND_VARIABLE_445 BOUND_VARIABLE_446)) ((_ tuple.select 6) t) (nullable.some 1000))))) (as nullable.null (Nullable Bool)))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_486 Bool)) (not BOUND_VARIABLE_486)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_486 Bool)) (not BOUND_VARIABLE_486)) ((_ tuple.select 0) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (ite (and (nullable.is_some (ite (and (nullable.is_some (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (> BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (> BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 6) t) (nullable.some 1000)))))) (not (nullable.val (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (> BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (> BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 6) t) (nullable.some 1000)))))))) (nullable.some false) (ite (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_520 Bool) (BOUND_VARIABLE_521 Bool)) (and BOUND_VARIABLE_520 BOUND_VARIABLE_521)) (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (> BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (> BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 6) t) (nullable.some 1000))))) (as nullable.null (Nullable Bool)))))) (nullable.val (ite (and (nullable.is_some (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (> BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (> BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 6) t) (nullable.some 1000)))))) (not (nullable.val (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (> BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (> BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 6) t) (nullable.some 1000)))))))) (nullable.some false) (ite (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_520 Bool) (BOUND_VARIABLE_521 Bool)) (and BOUND_VARIABLE_520 BOUND_VARIABLE_521)) (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (> BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (> BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 6) t) (nullable.some 1000))))) (as nullable.null (Nullable Bool))))))) (nullable.some true) (ite (and (nullable.is_some (nullable.some (not (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (> BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (> BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 6) t) (nullable.some 1000))))))) (nullable.val (nullable.some (not (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (> BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (> BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 6) t) (nullable.some 1000)))))))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_546 Bool) (BOUND_VARIABLE_547 Bool)) (or BOUND_VARIABLE_546 BOUND_VARIABLE_547)) (ite (and (nullable.is_some (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (> BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (> BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 6) t) (nullable.some 1000)))))) (not (nullable.val (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (> BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (> BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 6) t) (nullable.some 1000)))))))) (nullable.some false) (ite (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_520 Bool) (BOUND_VARIABLE_521 Bool)) (and BOUND_VARIABLE_520 BOUND_VARIABLE_521)) (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (> BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (> BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 6) t) (nullable.some 1000))))) (as nullable.null (Nullable Bool))))) (nullable.some (not (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (> BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (> BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 6) t) (nullable.some 1000)))))))))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_562 Bool)) (not BOUND_VARIABLE_562)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_562 Bool)) (not BOUND_VARIABLE_562)) ((_ tuple.select 0) t)))))))
(assert (= q1 ((_ rel.project 0) (set.filter p1 (set.map f0 EMP)))))
(assert (= q2 ((_ rel.project 0) (set.filter p3 (set.map f2 EMP)))))
(check-sat)
;answer: sat
; duration: 1164 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some 43) (nullable.some "[") (nullable.some "\u{5c}") (nullable.some (- 43)) (nullable.some 44) (nullable.some (- 44)) (nullable.some 0) (nullable.some 45) (nullable.some (- 45)))) (set.union (set.singleton (tuple (nullable.some 40) (nullable.some "Y") (nullable.some "Z") (nullable.some (- 40)) (nullable.some 41) (nullable.some (- 41)) (nullable.some 0) (nullable.some 42) (nullable.some (- 42)))) (set.union (set.singleton (tuple (nullable.some 37) (nullable.some "W") (nullable.some "X") (nullable.some (- 37)) (nullable.some 38) (nullable.some (- 38)) (as nullable.null (Nullable Int)) (nullable.some 39) (nullable.some (- 39)))) (set.union (set.singleton (tuple (nullable.some 34) (nullable.some "U") (nullable.some "V") (nullable.some (- 34)) (nullable.some 35) (nullable.some (- 35)) (as nullable.null (Nullable Int)) (nullable.some 36) (nullable.some (- 36)))) (set.union (set.singleton (tuple (nullable.some 31) (nullable.some "S") (nullable.some "T") (nullable.some (- 31)) (nullable.some 32) (nullable.some (- 32)) (nullable.some 0) (nullable.some 33) (nullable.some (- 33)))) (set.union (set.singleton (tuple (nullable.some 28) (nullable.some "Q") (nullable.some "R") (nullable.some (- 28)) (nullable.some 29) (nullable.some (- 29)) (as nullable.null (Nullable Int)) (nullable.some 30) (nullable.some (- 30)))) (set.union (set.singleton (tuple (nullable.some 25) (nullable.some "O") (nullable.some "P") (nullable.some (- 25)) (nullable.some 26) (nullable.some (- 26)) (as nullable.null (Nullable Int)) (nullable.some 27) (nullable.some (- 27)))) (set.union (set.singleton (tuple (nullable.some 22) (nullable.some "M") (nullable.some "N") (nullable.some (- 22)) (nullable.some 23) (nullable.some (- 23)) (as nullable.null (Nullable Int)) (nullable.some 24) (nullable.some (- 24)))) (set.union (set.singleton (tuple (nullable.some 19) (nullable.some "K") (nullable.some "L") (nullable.some (- 19)) (nullable.some 20) (nullable.some (- 20)) (nullable.some 0) (nullable.some 21) (nullable.some (- 21)))) (set.union (set.singleton (tuple (nullable.some 16) (nullable.some "I") (nullable.some "J") (nullable.some (- 16)) (nullable.some 17) (nullable.some (- 17)) (as nullable.null (Nullable Int)) (nullable.some 18) (nullable.some (- 18)))) (set.union (set.singleton (tuple (nullable.some 13) (nullable.some "G") (nullable.some "H") (nullable.some (- 13)) (nullable.some 14) (nullable.some (- 14)) (as nullable.null (Nullable Int)) (nullable.some 15) (nullable.some (- 15)))) (set.union (set.singleton (tuple (nullable.some 10) (nullable.some "E") (nullable.some "F") (nullable.some (- 10)) (nullable.some 11) (nullable.some (- 11)) (nullable.some 0) (nullable.some 12) (nullable.some (- 12)))) (set.union (set.singleton (tuple (nullable.some 7) (nullable.some "C") (nullable.some "D") (nullable.some (- 7)) (nullable.some 8) (nullable.some (- 8)) (as nullable.null (Nullable Int)) (nullable.some 9) (nullable.some (- 9)))) (set.singleton (tuple (nullable.some 1) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 1000) (nullable.some 3) (nullable.some (- 3))))))))))))))))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some false)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Bool))))
; insert into EMP values(43,'[','\',-43,44,-44,0,45,-45),(40,'Y','Z',-40,41,-41,0,42,-42),(37,'W','X',-37,38,-38,NULL,39,-39),(34,'U','V',-34,35,-35,NULL,36,-36),(31,'S','T',-31,32,-32,0,33,-33),(28,'Q','R',-28,29,-29,NULL,30,-30),(25,'O','P',-25,26,-26,NULL,27,-27),(22,'M','N',-22,23,-23,NULL,24,-24),(19,'K','L',-19,20,-20,0,21,-21),(16,'I','J',-16,17,-17,NULL,18,-18),(13,'G','H',-13,14,-14,NULL,15,-15),(10,'E','F',-10,11,-11,0,12,-12),(7,'C','D',-7,8,-8,NULL,9,-9),(1,NULL,'',-1,2,-2,1000,3,-3)
; SELECT * FROM (SELECT * FROM (SELECT CASE WHEN EMP.SAL > 1000 THEN NULL ELSE FALSE END AS CASECOL FROM EMP AS EMP) AS t WHERE NOT t.CASECOL) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT CASE WHEN EMP0.SAL > 1000 THEN NULL ELSE TRUE END AS CASECOL FROM EMP AS EMP0) AS t1 WHERE NOT t1.CASECOL) AS q2;
;(false)
;(false)
;(false)
;(false)
;(false)
;(false)
;(false)
;(false)
;(false)
;(false)
;(false)
;(false)
;(false)
;(false)

; SELECT * FROM (SELECT * FROM (SELECT CASE WHEN EMP0.SAL > 1000 THEN NULL ELSE TRUE END AS CASECOL FROM EMP AS EMP0) AS t1 WHERE NOT t1.CASECOL) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT CASE WHEN EMP.SAL > 1000 THEN NULL ELSE FALSE END AS CASECOL FROM EMP AS EMP) AS t WHERE NOT t.CASECOL) AS q1;

;Model soundness: true
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
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_468 String) (BOUND_VARIABLE_469 String)) (= BOUND_VARIABLE_468 BOUND_VARIABLE_469)) ((_ tuple.select 2) t) ((_ tuple.select 1) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_468 String) (BOUND_VARIABLE_469 String)) (= BOUND_VARIABLE_468 BOUND_VARIABLE_469)) ((_ tuple.select 2) t) ((_ tuple.select 1) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_551 String) (BOUND_VARIABLE_552 String)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 1) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_551 String) (BOUND_VARIABLE_552 String)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 1) t) ((_ tuple.select 10) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (= BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (= BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_575 Bool) (BOUND_VARIABLE_576 Bool)) (and BOUND_VARIABLE_575 BOUND_VARIABLE_576)) (nullable.lift (lambda ((BOUND_VARIABLE_551 String) (BOUND_VARIABLE_552 String)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 1) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (= BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_551 String) (BOUND_VARIABLE_552 String)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 1) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_551 String) (BOUND_VARIABLE_552 String)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 1) t) ((_ tuple.select 10) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (= BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (= BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_575 Bool) (BOUND_VARIABLE_576 Bool)) (and BOUND_VARIABLE_575 BOUND_VARIABLE_576)) (nullable.lift (lambda ((BOUND_VARIABLE_551 String) (BOUND_VARIABLE_552 String)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 1) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (= BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))))))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 2) t)))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_728 String) (BOUND_VARIABLE_729 String)) (= BOUND_VARIABLE_728 BOUND_VARIABLE_729)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_728 String) (BOUND_VARIABLE_729 String)) (= BOUND_VARIABLE_728 BOUND_VARIABLE_729)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_736 Int) (BOUND_VARIABLE_737 Int)) (= BOUND_VARIABLE_736 BOUND_VARIABLE_737)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_736 Int) (BOUND_VARIABLE_737 Int)) (= BOUND_VARIABLE_736 BOUND_VARIABLE_737)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_750 Bool) (BOUND_VARIABLE_751 Bool)) (and BOUND_VARIABLE_750 BOUND_VARIABLE_751)) (nullable.lift (lambda ((BOUND_VARIABLE_728 String) (BOUND_VARIABLE_729 String)) (= BOUND_VARIABLE_728 BOUND_VARIABLE_729)) ((_ tuple.select 9) t) ((_ tuple.select 12) t)) (nullable.lift (lambda ((BOUND_VARIABLE_736 Int) (BOUND_VARIABLE_737 Int)) (= BOUND_VARIABLE_736 BOUND_VARIABLE_737)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_728 String) (BOUND_VARIABLE_729 String)) (= BOUND_VARIABLE_728 BOUND_VARIABLE_729)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_728 String) (BOUND_VARIABLE_729 String)) (= BOUND_VARIABLE_728 BOUND_VARIABLE_729)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_736 Int) (BOUND_VARIABLE_737 Int)) (= BOUND_VARIABLE_736 BOUND_VARIABLE_737)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_736 Int) (BOUND_VARIABLE_737 Int)) (= BOUND_VARIABLE_736 BOUND_VARIABLE_737)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_750 Bool) (BOUND_VARIABLE_751 Bool)) (and BOUND_VARIABLE_750 BOUND_VARIABLE_751)) (nullable.lift (lambda ((BOUND_VARIABLE_728 String) (BOUND_VARIABLE_729 String)) (= BOUND_VARIABLE_728 BOUND_VARIABLE_729)) ((_ tuple.select 9) t) ((_ tuple.select 12) t)) (nullable.lift (lambda ((BOUND_VARIABLE_736 Int) (BOUND_VARIABLE_737 Int)) (= BOUND_VARIABLE_736 BOUND_VARIABLE_737)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))))))))
(assert (= q1 ((_ rel.project 6) (set.filter p2 (rel.product EMP ((_ rel.project 0 1) ((_ rel.project 0 2) (set.filter p1 (set.map f0 DEPT)))))))))
(assert (= q2 ((_ rel.project 6) (set.filter p5 (rel.product (set.map f3 EMP) (set.map f4 DEPT))))))
(check-sat)
;answer: sat
; duration: 228 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 0) (nullable.some ""))))
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 0) (nullable.some "") (as nullable.null (Nullable String)) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 1) (nullable.some 3) (nullable.some (- 3)))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 1)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; insert into DEPT values(0,'')
; insert into EMP values(0,'',NULL,-1,2,-2,1,3,-3)
; SELECT * FROM (SELECT EMP.SAL FROM EMP AS EMP WHERE EMP.EMPNO IN (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE EMP.ENAME = DEPT.NAME)) AS q1 EXCEPT ALL SELECT * FROM (SELECT EMP0.SAL FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.JOB = DEPT0.NAME AND EMP0.EMPNO = DEPT0.DEPTNO) AS q2;
;(1)

; SELECT * FROM (SELECT EMP0.SAL FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.JOB = DEPT0.NAME AND EMP0.EMPNO = DEPT0.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.SAL FROM EMP AS EMP WHERE EMP.EMPNO IN (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE EMP.ENAME = DEPT.NAME)) AS q1;

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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_372 Int) (BOUND_VARIABLE_373 Int)) (> BOUND_VARIABLE_372 BOUND_VARIABLE_373)) (nullable.lift (lambda ((BOUND_VARIABLE_356 Int) (BOUND_VARIABLE_357 Int)) (+ BOUND_VARIABLE_356 BOUND_VARIABLE_357)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_366 Int) (BOUND_VARIABLE_367 Int)) (+ BOUND_VARIABLE_366 BOUND_VARIABLE_367)) (nullable.some 3) (as nullable.null (Nullable Int))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_372 Int) (BOUND_VARIABLE_373 Int)) (> BOUND_VARIABLE_372 BOUND_VARIABLE_373)) (nullable.lift (lambda ((BOUND_VARIABLE_356 Int) (BOUND_VARIABLE_357 Int)) (+ BOUND_VARIABLE_356 BOUND_VARIABLE_357)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_366 Int) (BOUND_VARIABLE_367 Int)) (+ BOUND_VARIABLE_366 BOUND_VARIABLE_367)) (nullable.some 3) (as nullable.null (Nullable Int)))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_442 Int) (BOUND_VARIABLE_443 Int)) (>= BOUND_VARIABLE_442 BOUND_VARIABLE_443)) (nullable.lift (lambda ((BOUND_VARIABLE_436 Int) (BOUND_VARIABLE_437 Int)) (+ BOUND_VARIABLE_436 BOUND_VARIABLE_437)) (nullable.some 1) (nullable.some 2)) (nullable.some 3))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_442 Int) (BOUND_VARIABLE_443 Int)) (>= BOUND_VARIABLE_442 BOUND_VARIABLE_443)) (nullable.lift (lambda ((BOUND_VARIABLE_436 Int) (BOUND_VARIABLE_437 Int)) (+ BOUND_VARIABLE_436 BOUND_VARIABLE_437)) (nullable.some 1) (nullable.some 2)) (nullable.some 3)))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 (set.singleton (tuple (nullable.some 1) (nullable.some 3)))))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p1 (set.singleton (tuple (nullable.some 1) (nullable.some 2)))))))
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
; (set.singleton (tuple (nullable.some 1) (nullable.some 2)))
; SELECT * FROM (SELECT * FROM (VALUES  (1, 3)) AS t WHERE 1 + 2 > 3 + CAST(NULL AS INT)) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (VALUES  (1, 2)) AS t1 WHERE 1 + 2 >= 3) AS q2;

; SELECT * FROM (SELECT * FROM (VALUES  (1, 2)) AS t1 WHERE 1 + 2 >= 3) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (VALUES  (1, 3)) AS t WHERE 1 + 2 > 3 + CAST(NULL AS INT)) AS q1;
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 3) t) (nullable.some 11))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 3) t) (nullable.some 11)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_470 Int) (BOUND_VARIABLE_471 Int)) (= BOUND_VARIABLE_470 BOUND_VARIABLE_471)) ((_ tuple.select 3) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_470 Int) (BOUND_VARIABLE_471 Int)) (= BOUND_VARIABLE_470 BOUND_VARIABLE_471)) ((_ tuple.select 3) t) (nullable.some 10)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 10)))))
(assert (= q1 ((_ rel.project 3) (set.filter p0 EMP))))
(assert (= q2 (set.map f2 (set.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 21 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 10) (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 10)))
; insert into EMP values(0,NULL,'',10,1,-1,2,-2,3)
; SELECT * FROM (SELECT EMP.MGR FROM EMP AS EMP WHERE EMP.MGR = 11) AS q1 EXCEPT ALL SELECT * FROM (SELECT 10 AS MGR FROM EMP AS EMP0 WHERE EMP0.MGR = 10) AS q2;

; SELECT * FROM (SELECT 10 AS MGR FROM EMP AS EMP0 WHERE EMP0.MGR = 10) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.MGR FROM EMP AS EMP WHERE EMP.MGR = 11) AS q1;
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (>= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (>= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_536 Int) (BOUND_VARIABLE_537 Int)) (> BOUND_VARIABLE_536 BOUND_VARIABLE_537)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_536 Int) (BOUND_VARIABLE_537 Int)) (> BOUND_VARIABLE_536 BOUND_VARIABLE_537)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f2 (set.filter p1 (rel.product ((_ rel.project 5) (set.filter p0 EMP)) EMP)))))
(assert (= q2 (set.map f5 (set.filter p4 (rel.product ((_ rel.project 5) (set.filter p3 EMP)) EMP)))))
(check-sat)
;answer: sat
; duration: 553 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some (- 9)) (nullable.some "E") (nullable.some "F") (nullable.some 10) (nullable.some (- 10)) (nullable.some 8) (nullable.some 11) (nullable.some 7) (nullable.some (- 11)))) (set.singleton (tuple (nullable.some 6) (nullable.some "C") (nullable.some "D") (nullable.some (- 6)) (nullable.some (- 7)) (as nullable.null (Nullable Int)) (nullable.some (- 8)) (nullable.some 8) (nullable.some 9)))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 1)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; insert into EMP values(-9,'E','F',10,-10,8,11,7,-11),(6,'C','D',-6,-7,NULL,-8,8,9)
; SELECT * FROM (SELECT 1 FROM (SELECT EMP.COMM AS DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO >= 7) AS t0 INNER JOIN EMP AS EMP0 ON t0.DEPTNO = EMP0.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT EMP1.COMM AS DEPTNO FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t3 INNER JOIN EMP AS EMP2 ON t3.DEPTNO = EMP2.DEPTNO) AS q2;
;(1)

; SELECT * FROM (SELECT 1 FROM (SELECT EMP1.COMM AS DEPTNO FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t3 INNER JOIN EMP AS EMP2 ON t3.DEPTNO = EMP2.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT EMP.COMM AS DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO >= 7) AS t0 INNER JOIN EMP AS EMP0 ON t0.DEPTNO = EMP0.DEPTNO) AS q1;

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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (>= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (>= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_522 Int) (BOUND_VARIABLE_523 Int)) (= BOUND_VARIABLE_522 BOUND_VARIABLE_523)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_522 Int) (BOUND_VARIABLE_523 Int)) (= BOUND_VARIABLE_522 BOUND_VARIABLE_523)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_633 Int) (BOUND_VARIABLE_634 Int)) (= BOUND_VARIABLE_633 BOUND_VARIABLE_634)) ((_ tuple.select 16) t) ((_ tuple.select 25) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_633 Int) (BOUND_VARIABLE_634 Int)) (= BOUND_VARIABLE_633 BOUND_VARIABLE_634)) ((_ tuple.select 16) t) ((_ tuple.select 25) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_671 Int) (BOUND_VARIABLE_672 Int)) (> BOUND_VARIABLE_671 BOUND_VARIABLE_672)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_671 Int) (BOUND_VARIABLE_672 Int)) (> BOUND_VARIABLE_671 BOUND_VARIABLE_672)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_688 Int) (BOUND_VARIABLE_689 Int)) (> BOUND_VARIABLE_688 BOUND_VARIABLE_689)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_688 Int) (BOUND_VARIABLE_689 Int)) (> BOUND_VARIABLE_688 BOUND_VARIABLE_689)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_707 Int) (BOUND_VARIABLE_708 Int)) (= BOUND_VARIABLE_707 BOUND_VARIABLE_708)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_707 Int) (BOUND_VARIABLE_708 Int)) (= BOUND_VARIABLE_707 BOUND_VARIABLE_708)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_723 Int) (BOUND_VARIABLE_724 Int)) (> BOUND_VARIABLE_723 BOUND_VARIABLE_724)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_723 Int) (BOUND_VARIABLE_724 Int)) (> BOUND_VARIABLE_723 BOUND_VARIABLE_724)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_742 Int) (BOUND_VARIABLE_743 Int)) (= BOUND_VARIABLE_742 BOUND_VARIABLE_743)) ((_ tuple.select 16) t) ((_ tuple.select 25) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_742 Int) (BOUND_VARIABLE_743 Int)) (= BOUND_VARIABLE_742 BOUND_VARIABLE_743)) ((_ tuple.select 16) t) ((_ tuple.select 25) t)))))))
(assert (= f9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f3 (set.filter p2 (rel.product (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) EMP)) EMP)))))
(assert (= q2 (set.map f9 (set.filter p8 (rel.product (set.filter p6 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p7 EMP)))))))
(check-sat)
;answer: sat
; duration: 1338 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some (- 25)) (nullable.some "O") (nullable.some "P") (nullable.some 26) (nullable.some (- 26)) (nullable.some 27) (nullable.some (- 27)) (nullable.some 7) (nullable.some 28))) (set.union (set.singleton (tuple (nullable.some (- 19)) (nullable.some "K") (nullable.some "L") (nullable.some 20) (nullable.some (- 20)) (nullable.some 21) (nullable.some (- 21)) (nullable.some 7) (nullable.some 22))) (set.singleton (tuple (nullable.some (- 22)) (nullable.some "M") (nullable.some "N") (nullable.some 23) (nullable.some (- 23)) (nullable.some 24) (nullable.some (- 24)) (nullable.some 7) (nullable.some 25))))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 1)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; insert into EMP values(-25,'O','P',26,-26,27,-27,7,28),(-19,'K','L',20,-20,21,-21,7,22),(-22,'M','N',23,-23,24,-24,7,25)
; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO >= 7) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO INNER JOIN EMP AS EMP1 ON EMP0.DEPTNO = EMP1.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO INNER JOIN (SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 7) AS t3 ON t2.DEPTNO = t3.DEPTNO) AS q2;
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)
;(1)

; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO INNER JOIN (SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 7) AS t3 ON t2.DEPTNO = t3.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO >= 7) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO INNER JOIN EMP AS EMP1 ON EMP0.DEPTNO = EMP1.DEPTNO) AS q1;

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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_554 Int) (BOUND_VARIABLE_555 Int)) (= BOUND_VARIABLE_554 BOUND_VARIABLE_555)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_554 Int) (BOUND_VARIABLE_555 Int)) (= BOUND_VARIABLE_554 BOUND_VARIABLE_555)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_577 Int) (BOUND_VARIABLE_578 Int)) (distinct BOUND_VARIABLE_577 BOUND_VARIABLE_578)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_577 Int) (BOUND_VARIABLE_578 Int)) (distinct BOUND_VARIABLE_577 BOUND_VARIABLE_578)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_592 Bool) (BOUND_VARIABLE_593 Bool)) (and BOUND_VARIABLE_592 BOUND_VARIABLE_593)) (nullable.lift (lambda ((BOUND_VARIABLE_554 Int) (BOUND_VARIABLE_555 Int)) (= BOUND_VARIABLE_554 BOUND_VARIABLE_555)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_577 Int) (BOUND_VARIABLE_578 Int)) (distinct BOUND_VARIABLE_577 BOUND_VARIABLE_578)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_554 Int) (BOUND_VARIABLE_555 Int)) (= BOUND_VARIABLE_554 BOUND_VARIABLE_555)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_554 Int) (BOUND_VARIABLE_555 Int)) (= BOUND_VARIABLE_554 BOUND_VARIABLE_555)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_577 Int) (BOUND_VARIABLE_578 Int)) (distinct BOUND_VARIABLE_577 BOUND_VARIABLE_578)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_577 Int) (BOUND_VARIABLE_578 Int)) (distinct BOUND_VARIABLE_577 BOUND_VARIABLE_578)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_592 Bool) (BOUND_VARIABLE_593 Bool)) (and BOUND_VARIABLE_592 BOUND_VARIABLE_593)) (nullable.lift (lambda ((BOUND_VARIABLE_554 Int) (BOUND_VARIABLE_555 Int)) (= BOUND_VARIABLE_554 BOUND_VARIABLE_555)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_577 Int) (BOUND_VARIABLE_578 Int)) (distinct BOUND_VARIABLE_577 BOUND_VARIABLE_578)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_628 Int) (BOUND_VARIABLE_629 Int)) (= BOUND_VARIABLE_628 BOUND_VARIABLE_629)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_628 Int) (BOUND_VARIABLE_629 Int)) (= BOUND_VARIABLE_628 BOUND_VARIABLE_629)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_647 Int) (BOUND_VARIABLE_648 Int)) (= BOUND_VARIABLE_647 BOUND_VARIABLE_648)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_647 Int) (BOUND_VARIABLE_648 Int)) (= BOUND_VARIABLE_647 BOUND_VARIABLE_648)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)))))))
(assert (= q1 ((_ rel.project 1) (set.filter p0 (rel.product (rel.product EMP DEPT) EMP)))))
(assert (= q2 ((_ rel.project 1) (set.filter p2 (rel.product (set.filter p1 (rel.product EMP DEPT)) EMP)))))
(check-sat)
;answer: sat
; duration: 1145 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some 7) (nullable.some "D") (nullable.some "E") (nullable.some (- 7)) (nullable.some 8) (nullable.some (- 8)) (nullable.some 9) (nullable.some 0) (nullable.some (- 9)))) (set.singleton (tuple (nullable.some 10) (nullable.some "G") (nullable.some "H") (nullable.some (- 10)) (nullable.some 11) (nullable.some (- 11)) (nullable.some 12) (nullable.some 0) (nullable.some (- 12))))))
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 0) (nullable.some "F"))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable String))))
; q2
(get-value (q2))
; (set.union (set.singleton (tuple (nullable.some "G"))) (set.singleton (tuple (nullable.some "D"))))
; insert into EMP values(7,'D','E',-7,8,-8,9,0,-9),(10,'G','H',-10,11,-11,12,0,-12)
; insert into DEPT values(0,'F')
; SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO <> EMP0.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.DEPTNO = DEPT0.DEPTNO INNER JOIN EMP AS EMP2 ON DEPT0.DEPTNO = EMP2.DEPTNO) AS q2;

; SELECT * FROM (SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.DEPTNO = DEPT0.DEPTNO INNER JOIN EMP AS EMP2 ON DEPT0.DEPTNO = EMP2.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO <> EMP0.DEPTNO) AS q1;
;(D)
;(D)
;(G)
;(G)

;Model soundness: true
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_385 Bool)) (not BOUND_VARIABLE_385)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_385 Bool)) (not BOUND_VARIABLE_385)) ((_ tuple.select 0) t)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_406 Bool)) (not BOUND_VARIABLE_406)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_406 Bool)) (not BOUND_VARIABLE_406)) ((_ tuple.select 0) t)))))))
(assert (= q1 ((_ rel.project 0) (set.filter p0 (set.union (set.union (set.singleton (tuple (nullable.some false))) (set.singleton (tuple (nullable.some true)))) (set.singleton (tuple (nullable.some false))))))))
(assert (= q2 ((_ rel.project 0) (set.filter p1 (set.union (set.singleton (tuple (nullable.some false))) (set.singleton (tuple (nullable.some true))))))))
(check-sat)
;answer: unsat
; duration: 16 ms.
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (>= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (>= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_522 Int) (BOUND_VARIABLE_523 Int)) (= BOUND_VARIABLE_522 BOUND_VARIABLE_523)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_522 Int) (BOUND_VARIABLE_523 Int)) (= BOUND_VARIABLE_522 BOUND_VARIABLE_523)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_560 Int) (BOUND_VARIABLE_561 Int)) (> BOUND_VARIABLE_560 BOUND_VARIABLE_561)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_560 Int) (BOUND_VARIABLE_561 Int)) (> BOUND_VARIABLE_560 BOUND_VARIABLE_561)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_577 Int) (BOUND_VARIABLE_578 Int)) (> BOUND_VARIABLE_577 BOUND_VARIABLE_578)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_577 Int) (BOUND_VARIABLE_578 Int)) (> BOUND_VARIABLE_577 BOUND_VARIABLE_578)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_596 Int) (BOUND_VARIABLE_597 Int)) (= BOUND_VARIABLE_596 BOUND_VARIABLE_597)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_596 Int) (BOUND_VARIABLE_597 Int)) (= BOUND_VARIABLE_596 BOUND_VARIABLE_597)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f2 (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) EMP)))))
(assert (= q2 (set.map f6 (set.filter p5 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)))))))
(check-sat)
;answer: sat
; duration: 466 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some (- 16)) (nullable.some "I") (nullable.some "J") (nullable.some 17) (nullable.some (- 17)) (nullable.some 18) (nullable.some (- 18)) (nullable.some 7) (nullable.some 19))) (set.singleton (tuple (nullable.some (- 13)) (nullable.some "G") (nullable.some "H") (nullable.some 14) (nullable.some (- 14)) (nullable.some 15) (nullable.some (- 15)) (nullable.some 7) (nullable.some 16)))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 1)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; insert into EMP values(-16,'I','J',17,-17,18,-18,7,19),(-13,'G','H',14,-14,15,-15,7,16)
; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO >= 7) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO) AS q2;
;(1)
;(1)
;(1)
;(1)

; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO >= 7) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO) AS q1;

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
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Bool)))) (tuple (nullable.some "table")))))
(assert (= f1 (lambda ((t (Tuple (Nullable Bool)))) (tuple (nullable.some "view")))))
(assert (= f2 (lambda ((t (Tuple (Nullable Bool)))) (tuple (nullable.some "foreign table")))))
(assert (= f3 (lambda ((t (Tuple (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_519 String)) (str.to_upper BOUND_VARIABLE_519)) (nullable.lift (lambda ((BOUND_VARIABLE_512 String) (BOUND_VARIABLE_513 String)) (str.++ BOUND_VARIABLE_512 BOUND_VARIABLE_513)) (ite (or (or (nullable.is_null ((_ tuple.select 0) t)) (nullable.is_null (nullable.some 1))) (nullable.is_null (nullable.some 3))) (as nullable.null (Nullable String)) (nullable.some (str.substr (nullable.val ((_ tuple.select 0) t)) 0 3))) (ite (or (nullable.is_null ((_ tuple.select 0) t)) (nullable.is_null (nullable.some 3))) (as nullable.null (Nullable String)) (nullable.some (str.substr (nullable.val ((_ tuple.select 0) t)) 2 (str.len (nullable.val ((_ tuple.select 0) t)))))))) (ite (or (or (nullable.is_null ((_ tuple.select 0) t)) (nullable.is_null (nullable.some 1))) (nullable.is_null (nullable.some 1))) (as nullable.null (Nullable String)) (nullable.some (str.substr (nullable.val ((_ tuple.select 0) t)) 0 1)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable String) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_550 String) (BOUND_VARIABLE_551 String)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 0) t) (nullable.some "TABLE"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_550 String) (BOUND_VARIABLE_551 String)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 0) t) (nullable.some "TABLE")))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Bool)))) (tuple (nullable.some "TABLE") (nullable.some "t")))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p4 (set.map f3 (set.union ((_ rel.project 0) (set.union (set.map f0 (set.singleton (tuple (nullable.some true)))) (set.map f1 (set.singleton (tuple (nullable.some true)))))) (set.map f2 (set.singleton (tuple (nullable.some true))))))))))
(assert (= q2 (set.map f5 (set.singleton (tuple (nullable.some true))))))
(check-sat)
;answer: sat
; duration: 24 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable String) (Nullable String))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some "TABLE") (nullable.some "t")))
; SELECT * FROM (SELECT * FROM (SELECT UPPER(SUBSTRING(t6.X FROM 1 FOR 3) || SUBSTRING(t6.X FROM 3)) AS U, SUBSTRING(t6.X FROM 1 FOR 1) AS S FROM (SELECT * FROM (SELECT 'table' AS X FROM (VALUES  (TRUE)) AS t UNION SELECT 'view' FROM (VALUES  (TRUE)) AS t1) AS t3 UNION SELECT 'foreign table' FROM (VALUES  (TRUE)) AS t4) AS t6) AS t7 WHERE t7.U = 'TABLE') AS q1 EXCEPT ALL SELECT * FROM (SELECT 'TABLE' AS U, 't' AS S FROM (VALUES  (TRUE)) AS t9) AS q2;

; SELECT * FROM (SELECT 'TABLE' AS U, 't' AS S FROM (VALUES  (TRUE)) AS t9) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT UPPER(SUBSTRING(t6.X FROM 1 FOR 3) || SUBSTRING(t6.X FROM 3)) AS U, SUBSTRING(t6.X FROM 1 FOR 1) AS S FROM (SELECT * FROM (SELECT 'table' AS X FROM (VALUES  (TRUE)) AS t UNION SELECT 'view' FROM (VALUES  (TRUE)) AS t1) AS t3 UNION SELECT 'foreign table' FROM (VALUES  (TRUE)) AS t4) AS t6) AS t7 WHERE t7.U = 'TABLE') AS q1;
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_441 Int) (BOUND_VARIABLE_442 Int)) (= BOUND_VARIABLE_441 BOUND_VARIABLE_442)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_441 Int) (BOUND_VARIABLE_442 Int)) (= BOUND_VARIABLE_441 BOUND_VARIABLE_442)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_474 Bool) (BOUND_VARIABLE_475 Bool) (BOUND_VARIABLE_476 Bool) (BOUND_VARIABLE_477 Bool) (BOUND_VARIABLE_478 Bool)) (and BOUND_VARIABLE_474 BOUND_VARIABLE_475 BOUND_VARIABLE_476 BOUND_VARIABLE_477 BOUND_VARIABLE_478)) (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_441 Int) (BOUND_VARIABLE_442 Int)) (= BOUND_VARIABLE_441 BOUND_VARIABLE_442)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_450 Int) (BOUND_VARIABLE_451 Int)) (= BOUND_VARIABLE_450 BOUND_VARIABLE_451)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some (nullable.is_null ((_ tuple.select 3) t))) (nullable.lift (lambda ((BOUND_VARIABLE_458 Int) (BOUND_VARIABLE_459 Int)) (= BOUND_VARIABLE_458 BOUND_VARIABLE_459)) ((_ tuple.select 0) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_441 Int) (BOUND_VARIABLE_442 Int)) (= BOUND_VARIABLE_441 BOUND_VARIABLE_442)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_441 Int) (BOUND_VARIABLE_442 Int)) (= BOUND_VARIABLE_441 BOUND_VARIABLE_442)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_474 Bool) (BOUND_VARIABLE_475 Bool) (BOUND_VARIABLE_476 Bool) (BOUND_VARIABLE_477 Bool) (BOUND_VARIABLE_478 Bool)) (and BOUND_VARIABLE_474 BOUND_VARIABLE_475 BOUND_VARIABLE_476 BOUND_VARIABLE_477 BOUND_VARIABLE_478)) (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_441 Int) (BOUND_VARIABLE_442 Int)) (= BOUND_VARIABLE_441 BOUND_VARIABLE_442)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_450 Int) (BOUND_VARIABLE_451 Int)) (= BOUND_VARIABLE_450 BOUND_VARIABLE_451)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some (nullable.is_null ((_ tuple.select 3) t))) (nullable.lift (lambda ((BOUND_VARIABLE_458 Int) (BOUND_VARIABLE_459 Int)) (= BOUND_VARIABLE_458 BOUND_VARIABLE_459)) ((_ tuple.select 0) t) (nullable.some 10))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 10) ((_ tuple.select 1) t) ((_ tuple.select 2) t) (as nullable.null (Nullable Int)) ((_ tuple.select 4) t) ((_ tuple.select 6) t) ((_ tuple.select 5) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 (set.map f2 (set.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 38 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 10) (nullable.some "A") (nullable.some "B") (as nullable.null (Nullable Int)) (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some 7) (nullable.some (- 5)))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 10) (nullable.some "A") (nullable.some "B") (as nullable.null (Nullable Int)) (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some 7) (nullable.some (- 5))))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; insert into EMP values(10,'A','B',NULL,4,-4,5,7,-5)
; SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 AND EMP.DEPTNO = 7 AND EMP.EMPNO = 10 AND EMP.MGR IS NULL AND EMP.EMPNO = 10) AS q1 EXCEPT ALL SELECT * FROM (SELECT 10 AS EMPNO, t0.ENAME, t0.JOB, CAST(NULL AS INT) AS MGR, t0.HIREDATE, t0.SAL, t0.COMM, t0.DEPTNO, t0.SLACKER FROM (SELECT * FROM EMP WHERE FALSE) AS t0) AS q2;
;(10,A,B,NULL,4,-4,5,7,-5)

; SELECT * FROM (SELECT 10 AS EMPNO, t0.ENAME, t0.JOB, CAST(NULL AS INT) AS MGR, t0.HIREDATE, t0.SAL, t0.COMM, t0.DEPTNO, t0.SLACKER FROM (SELECT * FROM EMP WHERE FALSE) AS t0) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 AND EMP.DEPTNO = 7 AND EMP.EMPNO = 10 AND EMP.MGR IS NULL AND EMP.EMPNO = 10) AS q1;

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
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_null ((_ tuple.select 0) t)) (nullable.is_null ((_ tuple.select 0) t))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int)))) (nullable.is_some ((_ tuple.select 0) t)))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int))))))
(assert (= q1 ((_ rel.project 0) (set.filter p2 ((_ rel.project 0) (set.filter p1 (set.map f0 EMP)))))))
(assert (= q2 (set.map f3 EMP)))
(check-sat)
;answer: sat
; duration: 22 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (as nullable.null (Nullable Int))))
; insert into EMP values(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
; SELECT * FROM (SELECT * FROM (SELECT * FROM (SELECT CAST(NULL AS INT) AS N FROM EMP AS EMP) AS t WHERE t.N IS NULL AND t.N IS NULL) AS t0 WHERE t0.N IS NOT NULL) AS q1 EXCEPT ALL SELECT * FROM (SELECT CAST(NULL AS INT) AS N FROM EMP AS EMP0) AS q2;

; SELECT * FROM (SELECT CAST(NULL AS INT) AS N FROM EMP AS EMP0) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM (SELECT CAST(NULL AS INT) AS N FROM EMP AS EMP) AS t WHERE t.N IS NULL AND t.N IS NULL) AS t0 WHERE t0.N IS NOT NULL) AS q1;
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (>= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (>= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_442 Int) (BOUND_VARIABLE_443 Int)) (<= BOUND_VARIABLE_442 BOUND_VARIABLE_443)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_442 Int) (BOUND_VARIABLE_443 Int)) (<= BOUND_VARIABLE_442 BOUND_VARIABLE_443)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_457 Bool) (BOUND_VARIABLE_458 Bool)) (and BOUND_VARIABLE_457 BOUND_VARIABLE_458)) (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (>= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_442 Int) (BOUND_VARIABLE_443 Int)) (<= BOUND_VARIABLE_442 BOUND_VARIABLE_443)) ((_ tuple.select 0) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (>= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (>= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_442 Int) (BOUND_VARIABLE_443 Int)) (<= BOUND_VARIABLE_442 BOUND_VARIABLE_443)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_442 Int) (BOUND_VARIABLE_443 Int)) (<= BOUND_VARIABLE_442 BOUND_VARIABLE_443)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_457 Bool) (BOUND_VARIABLE_458 Bool)) (and BOUND_VARIABLE_457 BOUND_VARIABLE_458)) (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (>= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_442 Int) (BOUND_VARIABLE_443 Int)) (<= BOUND_VARIABLE_442 BOUND_VARIABLE_443)) ((_ tuple.select 0) t) (nullable.some 10))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= q1 ((_ rel.project 0) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0) (set.filter p1 (set.singleton (tuple (nullable.some 0)))))))
(check-sat)
;answer: sat
; duration: 27 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 10) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 0) (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 10)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; insert into EMP values(10,NULL,'',0,1,-1,2,-2,3)
; SELECT * FROM (SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO >= 10 AND EMP.EMPNO <= 10) AS q1 EXCEPT ALL SELECT * FROM (SELECT t1.column1 FROM (SELECT * FROM (VALUES(0)) WHERE FALSE) AS t1) AS q2;
;(10)

; SELECT * FROM (SELECT t1.column1 FROM (SELECT * FROM (VALUES(0)) WHERE FALSE) AS t1) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO >= 10 AND EMP.EMPNO <= 10) AS q1;

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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_554 Int) (BOUND_VARIABLE_555 Int)) (= BOUND_VARIABLE_554 BOUND_VARIABLE_555)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_554 Int) (BOUND_VARIABLE_555 Int)) (= BOUND_VARIABLE_554 BOUND_VARIABLE_555)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_578 Int) (BOUND_VARIABLE_579 Int)) (distinct BOUND_VARIABLE_578 BOUND_VARIABLE_579)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_578 Int) (BOUND_VARIABLE_579 Int)) (distinct BOUND_VARIABLE_578 BOUND_VARIABLE_579)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_593 Bool) (BOUND_VARIABLE_594 Bool)) (and BOUND_VARIABLE_593 BOUND_VARIABLE_594)) (nullable.lift (lambda ((BOUND_VARIABLE_554 Int) (BOUND_VARIABLE_555 Int)) (= BOUND_VARIABLE_554 BOUND_VARIABLE_555)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_578 Int) (BOUND_VARIABLE_579 Int)) (distinct BOUND_VARIABLE_578 BOUND_VARIABLE_579)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_554 Int) (BOUND_VARIABLE_555 Int)) (= BOUND_VARIABLE_554 BOUND_VARIABLE_555)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_554 Int) (BOUND_VARIABLE_555 Int)) (= BOUND_VARIABLE_554 BOUND_VARIABLE_555)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_578 Int) (BOUND_VARIABLE_579 Int)) (distinct BOUND_VARIABLE_578 BOUND_VARIABLE_579)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_578 Int) (BOUND_VARIABLE_579 Int)) (distinct BOUND_VARIABLE_578 BOUND_VARIABLE_579)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_593 Bool) (BOUND_VARIABLE_594 Bool)) (and BOUND_VARIABLE_593 BOUND_VARIABLE_594)) (nullable.lift (lambda ((BOUND_VARIABLE_554 Int) (BOUND_VARIABLE_555 Int)) (= BOUND_VARIABLE_554 BOUND_VARIABLE_555)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_578 Int) (BOUND_VARIABLE_579 Int)) (distinct BOUND_VARIABLE_578 BOUND_VARIABLE_579)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_629 Int) (BOUND_VARIABLE_630 Int)) (= BOUND_VARIABLE_629 BOUND_VARIABLE_630)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_629 Int) (BOUND_VARIABLE_630 Int)) (= BOUND_VARIABLE_629 BOUND_VARIABLE_630)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_648 Int) (BOUND_VARIABLE_649 Int)) (= BOUND_VARIABLE_648 BOUND_VARIABLE_649)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_648 Int) (BOUND_VARIABLE_649 Int)) (= BOUND_VARIABLE_648 BOUND_VARIABLE_649)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_743 Int) (BOUND_VARIABLE_744 Int)) (= BOUND_VARIABLE_743 BOUND_VARIABLE_744)) ((_ tuple.select 7) t) ((_ tuple.select 20) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_743 Int) (BOUND_VARIABLE_744 Int)) (= BOUND_VARIABLE_743 BOUND_VARIABLE_744)) ((_ tuple.select 7) t) ((_ tuple.select 20) t)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_866 Int) (BOUND_VARIABLE_867 Int)) (= BOUND_VARIABLE_866 BOUND_VARIABLE_867)) ((_ tuple.select 0) t) ((_ tuple.select 22) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_866 Int) (BOUND_VARIABLE_867 Int)) (= BOUND_VARIABLE_866 BOUND_VARIABLE_867)) ((_ tuple.select 0) t) ((_ tuple.select 22) t)))))))
(assert (= q1 ((_ rel.project 1) (set.filter p0 (rel.product (rel.product EMP DEPT) EMP)))))
(assert (= q2 ((_ rel.project 1) (set.filter p4 (rel.product (set.filter p3 (rel.product (set.filter p2 (rel.product (set.filter p1 (rel.product EMP DEPT)) EMP)) DEPT)) EMP)))))
(check-sat)
;answer: sat
; duration: 1829 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.union (set.singleton (tuple (nullable.some 0) (nullable.some "F"))) (set.singleton (tuple (nullable.some 0) (nullable.some "I")))))
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some 0) (nullable.some "D") (nullable.some "E") (nullable.some (- 6)) (nullable.some 7) (nullable.some (- 7)) (nullable.some 8) (nullable.some 0) (nullable.some (- 8)))) (set.union (set.singleton (tuple (nullable.some 0) (nullable.some "G") (nullable.some "H") (nullable.some 9) (nullable.some (- 9)) (nullable.some 10) (nullable.some (- 10)) (nullable.some 0) (nullable.some 11))) (set.singleton (tuple (nullable.some 0) (nullable.some "J") (nullable.some "K") (nullable.some (- 11)) (nullable.some 12) (nullable.some (- 12)) (nullable.some 13) (nullable.some 0) (nullable.some (- 13)))))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable String))))
; q2
(get-value (q2))
; (set.union (set.singleton (tuple (nullable.some "G"))) (set.union (set.singleton (tuple (nullable.some "J"))) (set.singleton (tuple (nullable.some "D")))))
; insert into DEPT values(0,'F'),(0,'I')
; insert into EMP values(0,'D','E',-6,7,-7,8,0,-8),(0,'G','H',9,-9,10,-10,0,11),(0,'J','K',-11,12,-12,13,0,-13)
; SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.EMPNO <> EMP0.EMPNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.DEPTNO = DEPT0.DEPTNO INNER JOIN EMP AS EMP2 ON EMP1.EMPNO = EMP2.EMPNO INNER JOIN DEPT AS DEPT1 ON EMP1.DEPTNO = DEPT1.DEPTNO INNER JOIN EMP AS EMP3 ON EMP1.EMPNO = EMP3.EMPNO) AS q2;

; SELECT * FROM (SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.DEPTNO = DEPT0.DEPTNO INNER JOIN EMP AS EMP2 ON EMP1.EMPNO = EMP2.EMPNO INNER JOIN DEPT AS DEPT1 ON EMP1.DEPTNO = DEPT1.DEPTNO INNER JOIN EMP AS EMP3 ON EMP1.EMPNO = EMP3.EMPNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.EMPNO <> EMP0.EMPNO) AS q1;
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(D)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(G)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)
;(J)

;Model soundness: true
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_482 Int) (BOUND_VARIABLE_483 Int)) (>= BOUND_VARIABLE_482 BOUND_VARIABLE_483)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_482 Int) (BOUND_VARIABLE_483 Int)) (>= BOUND_VARIABLE_482 BOUND_VARIABLE_483)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (tuple (nullable.some 1)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_537 Int) (BOUND_VARIABLE_538 Int)) (= BOUND_VARIABLE_537 BOUND_VARIABLE_538)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_537 Int) (BOUND_VARIABLE_538 Int)) (= BOUND_VARIABLE_537 BOUND_VARIABLE_538)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f1 (set.filter p0 (rel.product EMP DEPT)))))
(assert (= q2 (set.map f3 (set.filter p2 (rel.product EMP DEPT)))))
(check-sat)
;answer: sat
; duration: 123 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some (- 4)) (nullable.some "B") (nullable.some "C") (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (nullable.some (- 6)) (nullable.some 1) (nullable.some 7))))
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 0) (nullable.some "D"))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 1)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; insert into EMP values(-4,'B','C',5,-5,6,-6,1,7)
; insert into DEPT values(0,'D')
; SELECT * FROM (SELECT 1 FROM EMP AS EMP INNER JOIN DEPT AS DEPT ON EMP.DEPTNO >= DEPT.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM EMP AS EMP0, DEPT AS DEPT0 WHERE EMP0.DEPTNO = DEPT0.DEPTNO) AS q2;
;(1)

; SELECT * FROM (SELECT 1 FROM EMP AS EMP0, DEPT AS DEPT0 WHERE EMP0.DEPTNO = DEPT0.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM EMP AS EMP INNER JOIN DEPT AS DEPT ON EMP.DEPTNO >= DEPT.DEPTNO) AS q1;

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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_485 Int) (BOUND_VARIABLE_486 Int)) (= BOUND_VARIABLE_485 BOUND_VARIABLE_486)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_485 Int) (BOUND_VARIABLE_486 Int)) (= BOUND_VARIABLE_485 BOUND_VARIABLE_486)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_563 Int) (BOUND_VARIABLE_564 Int)) (> BOUND_VARIABLE_563 BOUND_VARIABLE_564)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_563 Int) (BOUND_VARIABLE_564 Int)) (> BOUND_VARIABLE_563 BOUND_VARIABLE_564)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_572 Int) (BOUND_VARIABLE_573 Int)) (>= BOUND_VARIABLE_572 BOUND_VARIABLE_573)) ((_ tuple.select 16) t) (nullable.some 9))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_572 Int) (BOUND_VARIABLE_573 Int)) (>= BOUND_VARIABLE_572 BOUND_VARIABLE_573)) ((_ tuple.select 16) t) (nullable.some 9))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_587 Bool) (BOUND_VARIABLE_588 Bool)) (and BOUND_VARIABLE_587 BOUND_VARIABLE_588)) (nullable.lift (lambda ((BOUND_VARIABLE_563 Int) (BOUND_VARIABLE_564 Int)) (> BOUND_VARIABLE_563 BOUND_VARIABLE_564)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_572 Int) (BOUND_VARIABLE_573 Int)) (>= BOUND_VARIABLE_572 BOUND_VARIABLE_573)) ((_ tuple.select 16) t) (nullable.some 9)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_563 Int) (BOUND_VARIABLE_564 Int)) (> BOUND_VARIABLE_563 BOUND_VARIABLE_564)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_563 Int) (BOUND_VARIABLE_564 Int)) (> BOUND_VARIABLE_563 BOUND_VARIABLE_564)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_572 Int) (BOUND_VARIABLE_573 Int)) (>= BOUND_VARIABLE_572 BOUND_VARIABLE_573)) ((_ tuple.select 16) t) (nullable.some 9))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_572 Int) (BOUND_VARIABLE_573 Int)) (>= BOUND_VARIABLE_572 BOUND_VARIABLE_573)) ((_ tuple.select 16) t) (nullable.some 9))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_587 Bool) (BOUND_VARIABLE_588 Bool)) (and BOUND_VARIABLE_587 BOUND_VARIABLE_588)) (nullable.lift (lambda ((BOUND_VARIABLE_563 Int) (BOUND_VARIABLE_564 Int)) (> BOUND_VARIABLE_563 BOUND_VARIABLE_564)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_572 Int) (BOUND_VARIABLE_573 Int)) (>= BOUND_VARIABLE_572 BOUND_VARIABLE_573)) ((_ tuple.select 16) t) (nullable.some 9))))))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_628 Int) (BOUND_VARIABLE_629 Int)) (= BOUND_VARIABLE_628 BOUND_VARIABLE_629)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_628 Int) (BOUND_VARIABLE_629 Int)) (= BOUND_VARIABLE_628 BOUND_VARIABLE_629)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= leftJoin6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_682 Int) (BOUND_VARIABLE_683 Int)) (> BOUND_VARIABLE_682 BOUND_VARIABLE_683)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_682 Int) (BOUND_VARIABLE_683 Int)) (> BOUND_VARIABLE_682 BOUND_VARIABLE_683)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_689 Int) (BOUND_VARIABLE_690 Int)) (> BOUND_VARIABLE_689 BOUND_VARIABLE_690)) ((_ tuple.select 16) t) (nullable.some 9))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_689 Int) (BOUND_VARIABLE_690 Int)) (> BOUND_VARIABLE_689 BOUND_VARIABLE_690)) ((_ tuple.select 16) t) (nullable.some 9))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_703 Bool) (BOUND_VARIABLE_704 Bool)) (and BOUND_VARIABLE_703 BOUND_VARIABLE_704)) (nullable.lift (lambda ((BOUND_VARIABLE_682 Int) (BOUND_VARIABLE_683 Int)) (> BOUND_VARIABLE_682 BOUND_VARIABLE_683)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_689 Int) (BOUND_VARIABLE_690 Int)) (> BOUND_VARIABLE_689 BOUND_VARIABLE_690)) ((_ tuple.select 16) t) (nullable.some 9)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_682 Int) (BOUND_VARIABLE_683 Int)) (> BOUND_VARIABLE_682 BOUND_VARIABLE_683)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_682 Int) (BOUND_VARIABLE_683 Int)) (> BOUND_VARIABLE_682 BOUND_VARIABLE_683)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_689 Int) (BOUND_VARIABLE_690 Int)) (> BOUND_VARIABLE_689 BOUND_VARIABLE_690)) ((_ tuple.select 16) t) (nullable.some 9))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_689 Int) (BOUND_VARIABLE_690 Int)) (> BOUND_VARIABLE_689 BOUND_VARIABLE_690)) ((_ tuple.select 16) t) (nullable.some 9))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_703 Bool) (BOUND_VARIABLE_704 Bool)) (and BOUND_VARIABLE_703 BOUND_VARIABLE_704)) (nullable.lift (lambda ((BOUND_VARIABLE_682 Int) (BOUND_VARIABLE_683 Int)) (> BOUND_VARIABLE_682 BOUND_VARIABLE_683)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_689 Int) (BOUND_VARIABLE_690 Int)) (> BOUND_VARIABLE_689 BOUND_VARIABLE_690)) ((_ tuple.select 16) t) (nullable.some 9))))))))))
(assert (= f9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f4 (set.filter p3 (set.union (set.union (set.map leftJoin1 (set.minus EMP ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 (rel.product EMP EMP))))) (set.map rightJoin2 (set.minus EMP ((_ rel.project 9 10 11 12 13 14 15 16 17) (set.filter p0 (rel.product EMP EMP)))))) (set.filter p0 (rel.product EMP EMP)))))))
(assert (= q2 (set.map f9 (set.filter p8 (set.union (set.union (set.map leftJoin6 (set.minus EMP ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 (rel.product EMP EMP))))) (set.map rightJoin7 (set.minus EMP ((_ rel.project 9 10 11 12 13 14 15 16 17) (set.filter p5 (rel.product EMP EMP)))))) (set.filter p5 (rel.product EMP EMP)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10019 ms.
(reset)
;-----------------------------------------------------------
; test name: testDecorrelateTwoIn
;Translating sql query: SELECT EMP.SAL FROM EMP AS EMP WHERE EMP.EMPNO IN (SELECT DEPT.DEPTNO FROM DEPT AS DEPT) AND EMP.EMPNO IN (SELECT EMP0.EMPNO FROM EMP AS EMP0 WHERE EMP.ENAME = EMP0.ENAME)
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
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const f7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const f8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)) Bool))
(declare-const p9 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f5 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_495 Int) (BOUND_VARIABLE_496 Int)) (= BOUND_VARIABLE_495 BOUND_VARIABLE_496)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_495 Int) (BOUND_VARIABLE_496 Int)) (= BOUND_VARIABLE_495 BOUND_VARIABLE_496)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 1) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_587 String) (BOUND_VARIABLE_588 String)) (= BOUND_VARIABLE_587 BOUND_VARIABLE_588)) ((_ tuple.select 9) t) ((_ tuple.select 1) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_587 String) (BOUND_VARIABLE_588 String)) (= BOUND_VARIABLE_587 BOUND_VARIABLE_588)) ((_ tuple.select 9) t) ((_ tuple.select 1) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_658 String) (BOUND_VARIABLE_659 String)) (= BOUND_VARIABLE_658 BOUND_VARIABLE_659)) ((_ tuple.select 1) t) ((_ tuple.select 11) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_658 String) (BOUND_VARIABLE_659 String)) (= BOUND_VARIABLE_658 BOUND_VARIABLE_659)) ((_ tuple.select 1) t) ((_ tuple.select 11) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_666 Int) (BOUND_VARIABLE_667 Int)) (= BOUND_VARIABLE_666 BOUND_VARIABLE_667)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_666 Int) (BOUND_VARIABLE_667 Int)) (= BOUND_VARIABLE_666 BOUND_VARIABLE_667)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_681 Bool) (BOUND_VARIABLE_682 Bool)) (and BOUND_VARIABLE_681 BOUND_VARIABLE_682)) (nullable.lift (lambda ((BOUND_VARIABLE_658 String) (BOUND_VARIABLE_659 String)) (= BOUND_VARIABLE_658 BOUND_VARIABLE_659)) ((_ tuple.select 1) t) ((_ tuple.select 11) t)) (nullable.lift (lambda ((BOUND_VARIABLE_666 Int) (BOUND_VARIABLE_667 Int)) (= BOUND_VARIABLE_666 BOUND_VARIABLE_667)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_658 String) (BOUND_VARIABLE_659 String)) (= BOUND_VARIABLE_658 BOUND_VARIABLE_659)) ((_ tuple.select 1) t) ((_ tuple.select 11) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_658 String) (BOUND_VARIABLE_659 String)) (= BOUND_VARIABLE_658 BOUND_VARIABLE_659)) ((_ tuple.select 1) t) ((_ tuple.select 11) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_666 Int) (BOUND_VARIABLE_667 Int)) (= BOUND_VARIABLE_666 BOUND_VARIABLE_667)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_666 Int) (BOUND_VARIABLE_667 Int)) (= BOUND_VARIABLE_666 BOUND_VARIABLE_667)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_681 Bool) (BOUND_VARIABLE_682 Bool)) (and BOUND_VARIABLE_681 BOUND_VARIABLE_682)) (nullable.lift (lambda ((BOUND_VARIABLE_658 String) (BOUND_VARIABLE_659 String)) (= BOUND_VARIABLE_658 BOUND_VARIABLE_659)) ((_ tuple.select 1) t) ((_ tuple.select 11) t)) (nullable.lift (lambda ((BOUND_VARIABLE_666 Int) (BOUND_VARIABLE_667 Int)) (= BOUND_VARIABLE_666 BOUND_VARIABLE_667)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 2) t)))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_801 String) (BOUND_VARIABLE_802 String)) (= BOUND_VARIABLE_801 BOUND_VARIABLE_802)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_801 String) (BOUND_VARIABLE_802 String)) (= BOUND_VARIABLE_801 BOUND_VARIABLE_802)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_809 Int) (BOUND_VARIABLE_810 Int)) (= BOUND_VARIABLE_809 BOUND_VARIABLE_810)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_809 Int) (BOUND_VARIABLE_810 Int)) (= BOUND_VARIABLE_809 BOUND_VARIABLE_810)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_823 Bool) (BOUND_VARIABLE_824 Bool)) (and BOUND_VARIABLE_823 BOUND_VARIABLE_824)) (nullable.lift (lambda ((BOUND_VARIABLE_801 String) (BOUND_VARIABLE_802 String)) (= BOUND_VARIABLE_801 BOUND_VARIABLE_802)) ((_ tuple.select 9) t) ((_ tuple.select 12) t)) (nullable.lift (lambda ((BOUND_VARIABLE_809 Int) (BOUND_VARIABLE_810 Int)) (= BOUND_VARIABLE_809 BOUND_VARIABLE_810)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_801 String) (BOUND_VARIABLE_802 String)) (= BOUND_VARIABLE_801 BOUND_VARIABLE_802)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_801 String) (BOUND_VARIABLE_802 String)) (= BOUND_VARIABLE_801 BOUND_VARIABLE_802)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_809 Int) (BOUND_VARIABLE_810 Int)) (= BOUND_VARIABLE_809 BOUND_VARIABLE_810)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_809 Int) (BOUND_VARIABLE_810 Int)) (= BOUND_VARIABLE_809 BOUND_VARIABLE_810)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_823 Bool) (BOUND_VARIABLE_824 Bool)) (and BOUND_VARIABLE_823 BOUND_VARIABLE_824)) (nullable.lift (lambda ((BOUND_VARIABLE_801 String) (BOUND_VARIABLE_802 String)) (= BOUND_VARIABLE_801 BOUND_VARIABLE_802)) ((_ tuple.select 9) t) ((_ tuple.select 12) t)) (nullable.lift (lambda ((BOUND_VARIABLE_809 Int) (BOUND_VARIABLE_810 Int)) (= BOUND_VARIABLE_809 BOUND_VARIABLE_810)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))))))))
(assert (= f7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 10) t) ((_ tuple.select 11) t) ((_ tuple.select 1) t)))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_976 String) (BOUND_VARIABLE_977 String)) (= BOUND_VARIABLE_976 BOUND_VARIABLE_977)) ((_ tuple.select 11) t) ((_ tuple.select 14) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_976 String) (BOUND_VARIABLE_977 String)) (= BOUND_VARIABLE_976 BOUND_VARIABLE_977)) ((_ tuple.select 11) t) ((_ tuple.select 14) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_984 Int) (BOUND_VARIABLE_985 Int)) (= BOUND_VARIABLE_984 BOUND_VARIABLE_985)) ((_ tuple.select 0) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_984 Int) (BOUND_VARIABLE_985 Int)) (= BOUND_VARIABLE_984 BOUND_VARIABLE_985)) ((_ tuple.select 0) t) ((_ tuple.select 12) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_998 Bool) (BOUND_VARIABLE_999 Bool)) (and BOUND_VARIABLE_998 BOUND_VARIABLE_999)) (nullable.lift (lambda ((BOUND_VARIABLE_976 String) (BOUND_VARIABLE_977 String)) (= BOUND_VARIABLE_976 BOUND_VARIABLE_977)) ((_ tuple.select 11) t) ((_ tuple.select 14) t)) (nullable.lift (lambda ((BOUND_VARIABLE_984 Int) (BOUND_VARIABLE_985 Int)) (= BOUND_VARIABLE_984 BOUND_VARIABLE_985)) ((_ tuple.select 0) t) ((_ tuple.select 12) t)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_976 String) (BOUND_VARIABLE_977 String)) (= BOUND_VARIABLE_976 BOUND_VARIABLE_977)) ((_ tuple.select 11) t) ((_ tuple.select 14) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_976 String) (BOUND_VARIABLE_977 String)) (= BOUND_VARIABLE_976 BOUND_VARIABLE_977)) ((_ tuple.select 11) t) ((_ tuple.select 14) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_984 Int) (BOUND_VARIABLE_985 Int)) (= BOUND_VARIABLE_984 BOUND_VARIABLE_985)) ((_ tuple.select 0) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_984 Int) (BOUND_VARIABLE_985 Int)) (= BOUND_VARIABLE_984 BOUND_VARIABLE_985)) ((_ tuple.select 0) t) ((_ tuple.select 12) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_998 Bool) (BOUND_VARIABLE_999 Bool)) (and BOUND_VARIABLE_998 BOUND_VARIABLE_999)) (nullable.lift (lambda ((BOUND_VARIABLE_976 String) (BOUND_VARIABLE_977 String)) (= BOUND_VARIABLE_976 BOUND_VARIABLE_977)) ((_ tuple.select 11) t) ((_ tuple.select 14) t)) (nullable.lift (lambda ((BOUND_VARIABLE_984 Int) (BOUND_VARIABLE_985 Int)) (= BOUND_VARIABLE_984 BOUND_VARIABLE_985)) ((_ tuple.select 0) t) ((_ tuple.select 12) t))))))))))
(assert (= q1 ((_ rel.project 6) (set.filter p3 (rel.product (set.filter p0 (rel.product EMP ((_ rel.project 0) ((_ rel.project 0) DEPT)))) ((_ rel.project 0 1) ((_ rel.project 0 9) (set.filter p2 (set.map f1 EMP)))))))))
(assert (= q2 ((_ rel.project 6) (set.filter p9 (rel.product (set.map f7 (set.filter p6 (rel.product (set.map f4 EMP) (set.map f5 DEPT)))) (set.map f8 EMP))))))
(check-sat)
;answer: sat
; duration: 513 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 0) (as nullable.null (Nullable String)))))
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some 0) (nullable.some "") (as nullable.null (Nullable String)) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 1) (nullable.some 3) (nullable.some (- 3)))) (set.singleton (tuple (nullable.some 0) (nullable.some "") (as nullable.null (Nullable String)) (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (nullable.some (- 6))))))
; )
; q1
(get-value (q1))
; (set.union (set.singleton (tuple (nullable.some (- 5)))) (set.singleton (tuple (nullable.some 1))))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; insert into DEPT values(0,NULL)
; insert into EMP values(0,'',NULL,-1,2,-2,1,3,-3),(0,'',NULL,4,-4,5,-5,6,-6)
; SELECT * FROM (SELECT EMP.SAL FROM EMP AS EMP WHERE EMP.EMPNO IN (SELECT DEPT.DEPTNO FROM DEPT AS DEPT) AND EMP.EMPNO IN (SELECT EMP0.EMPNO FROM EMP AS EMP0 WHERE EMP.ENAME = EMP0.ENAME)) AS q1 EXCEPT ALL SELECT * FROM (SELECT EMP1.SAL FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.JOB = DEPT0.NAME AND EMP1.EMPNO = DEPT0.DEPTNO INNER JOIN (SELECT EMP2.EMPNO, EMP2.ENAME FROM EMP AS EMP2) AS t5 ON EMP1.ENAME = t5.ENAME AND EMP1.EMPNO = t5.EMPNO) AS q2;
;(-5)
;(1)

; SELECT * FROM (SELECT EMP1.SAL FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.JOB = DEPT0.NAME AND EMP1.EMPNO = DEPT0.DEPTNO INNER JOIN (SELECT EMP2.EMPNO, EMP2.ENAME FROM EMP AS EMP2) AS t5 ON EMP1.ENAME = t5.ENAME AND EMP1.EMPNO = t5.EMPNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.SAL FROM EMP AS EMP WHERE EMP.EMPNO IN (SELECT DEPT.DEPTNO FROM DEPT AS DEPT) AND EMP.EMPNO IN (SELECT EMP0.EMPNO FROM EMP AS EMP0 WHERE EMP.ENAME = EMP0.ENAME)) AS q1;

;Model soundness: true
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_399 Int) (BOUND_VARIABLE_400 Int)) (= BOUND_VARIABLE_399 BOUND_VARIABLE_400)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_399 Int) (BOUND_VARIABLE_400 Int)) (= BOUND_VARIABLE_399 BOUND_VARIABLE_400)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_437 Int) (BOUND_VARIABLE_438 Int)) (= BOUND_VARIABLE_437 BOUND_VARIABLE_438)) ((_ tuple.select 0) t) (nullable.some 11))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_437 Int) (BOUND_VARIABLE_438 Int)) (= BOUND_VARIABLE_437 BOUND_VARIABLE_438)) ((_ tuple.select 0) t) (nullable.some 11)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_467 Int) (BOUND_VARIABLE_468 Int)) (= BOUND_VARIABLE_467 BOUND_VARIABLE_468)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_467 Int) (BOUND_VARIABLE_468 Int)) (= BOUND_VARIABLE_467 BOUND_VARIABLE_468)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= q1 ((_ rel.project 1) (set.filter p1 ((_ rel.project 0 1) (set.filter p0 DEPT))))))
(assert (= q2 ((_ rel.project 1) (set.filter p2 DEPT))))
(check-sat)
;answer: sat
; duration: 63 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 10) (nullable.some "A"))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable String))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some "A")))
; insert into DEPT values(10,'A')
; SELECT * FROM (SELECT t.NAME FROM (SELECT * FROM DEPT AS DEPT WHERE DEPT.DEPTNO = 10) AS t WHERE t.DEPTNO = 11) AS q1 EXCEPT ALL SELECT * FROM (SELECT DEPT0.NAME FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO = 10) AS q2;

; SELECT * FROM (SELECT DEPT0.NAME FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO = 10) AS q2 EXCEPT ALL SELECT * FROM (SELECT t.NAME FROM (SELECT * FROM DEPT AS DEPT WHERE DEPT.DEPTNO = 10) AS t WHERE t.DEPTNO = 11) AS q1;
;(A)

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
; duration: 18 ms.
(reset)
;-----------------------------------------------------------
; test name: testMergeMinusRightDeep
;Translating sql query: SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 EXCEPT SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 10 EXCEPT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS t2
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_456 Int) (BOUND_VARIABLE_457 Int)) (= BOUND_VARIABLE_456 BOUND_VARIABLE_457)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_456 Int) (BOUND_VARIABLE_457 Int)) (= BOUND_VARIABLE_456 BOUND_VARIABLE_457)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_495 Int) (BOUND_VARIABLE_496 Int)) (= BOUND_VARIABLE_495 BOUND_VARIABLE_496)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_495 Int) (BOUND_VARIABLE_496 Int)) (= BOUND_VARIABLE_495 BOUND_VARIABLE_496)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_514 Int) (BOUND_VARIABLE_515 Int)) (= BOUND_VARIABLE_514 BOUND_VARIABLE_515)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_514 Int) (BOUND_VARIABLE_515 Int)) (= BOUND_VARIABLE_514 BOUND_VARIABLE_515)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_531 Int) (BOUND_VARIABLE_532 Int)) (= BOUND_VARIABLE_531 BOUND_VARIABLE_532)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_531 Int) (BOUND_VARIABLE_532 Int)) (= BOUND_VARIABLE_531 BOUND_VARIABLE_532)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))))
(assert (= q2 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))))
(check-sat)
;answer: sat
; duration: 72 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 10) (nullable.some 3))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 10) (nullable.some 3)))
; insert into EMP values(0,NULL,'',1,-1,2,-2,10,3)
; SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 EXCEPT SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 10 EXCEPT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS t2) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 EXCEPT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS t7) AS q2;

; SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 EXCEPT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS t7) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 EXCEPT SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 10 EXCEPT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS t2) AS q1;
;(0,NULL,,1,-1,2,-2,10,3)

;Model soundness: true
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_511 Int) (BOUND_VARIABLE_512 Int)) (= BOUND_VARIABLE_511 BOUND_VARIABLE_512)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_511 Int) (BOUND_VARIABLE_512 Int)) (= BOUND_VARIABLE_511 BOUND_VARIABLE_512)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) DEPT)))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.singleton (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some ""))))))
(check-sat)
;answer: sat
; duration: 68 ms.
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
; SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE FALSE) AS t INNER JOIN DEPT AS DEPT ON t.DEPTNO = DEPT.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0,0,''))) AS t0) AS q2;

; SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0,0,''))) AS t0) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE FALSE) AS t INNER JOIN DEPT AS DEPT ON t.DEPTNO = DEPT.DEPTNO) AS q1;
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (ite (and (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 0) t)))) (not (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 0) t)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_453 Bool) (BOUND_VARIABLE_454 Bool)) (and BOUND_VARIABLE_453 BOUND_VARIABLE_454)) (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some (nullable.is_null ((_ tuple.select 0) t))))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (ite (and (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 0) t)))) (not (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 0) t)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_453 Bool) (BOUND_VARIABLE_454 Bool)) (and BOUND_VARIABLE_453 BOUND_VARIABLE_454)) (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some (nullable.is_null ((_ tuple.select 0) t)))))))))))
(assert (= q1 ((_ rel.project 0) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0) (set.singleton (tuple (nullable.some 0))))))
(check-sat)
;answer: sat
; duration: 25 ms.
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
; SELECT * FROM (SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND EMP.EMPNO IS NULL) AS q1 EXCEPT ALL SELECT * FROM (SELECT t1.column1 FROM (SELECT * FROM (VALUES(0))) AS t1) AS q2;

; SELECT * FROM (SELECT t1.column1 FROM (SELECT * FROM (VALUES(0))) AS t1) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND EMP.EMPNO IS NULL) AS q1;
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (> BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (> BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_522 Int) (BOUND_VARIABLE_523 Int)) (= BOUND_VARIABLE_522 BOUND_VARIABLE_523)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_522 Int) (BOUND_VARIABLE_523 Int)) (= BOUND_VARIABLE_522 BOUND_VARIABLE_523)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_560 Int) (BOUND_VARIABLE_561 Int)) (>= BOUND_VARIABLE_560 BOUND_VARIABLE_561)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_560 Int) (BOUND_VARIABLE_561 Int)) (>= BOUND_VARIABLE_560 BOUND_VARIABLE_561)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_577 Int) (BOUND_VARIABLE_578 Int)) (>= BOUND_VARIABLE_577 BOUND_VARIABLE_578)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_577 Int) (BOUND_VARIABLE_578 Int)) (>= BOUND_VARIABLE_577 BOUND_VARIABLE_578)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_596 Int) (BOUND_VARIABLE_597 Int)) (= BOUND_VARIABLE_596 BOUND_VARIABLE_597)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_596 Int) (BOUND_VARIABLE_597 Int)) (= BOUND_VARIABLE_596 BOUND_VARIABLE_597)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f2 (set.filter p1 (rel.product EMP ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)))))))
(assert (= q2 (set.map f6 (set.filter p5 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)))))))
(check-sat)
;answer: sat
; duration: 211 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some 4) (nullable.some "A") (nullable.some "B") (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (nullable.some 7) (nullable.some (- 6)))) (set.singleton (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some 7) (nullable.some (- 3))))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 1)))
; insert into EMP values(4,'A','B',-4,5,-5,6,7,-6),(0,NULL,'',-1,2,-2,3,7,-3)
; SELECT * FROM (SELECT 1 FROM EMP AS EMP INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 7) AS t ON EMP.DEPTNO = t.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 7) AS t2 ON t1.DEPTNO = t2.DEPTNO) AS q2;

; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 7) AS t2 ON t1.DEPTNO = t2.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM EMP AS EMP INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 7) AS t ON EMP.DEPTNO = t.DEPTNO) AS q1;
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_482 Int) (BOUND_VARIABLE_483 Int)) (= BOUND_VARIABLE_482 BOUND_VARIABLE_483)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_482 Int) (BOUND_VARIABLE_483 Int)) (= BOUND_VARIABLE_482 BOUND_VARIABLE_483)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (>= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 8) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (>= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 8) t) (nullable.some 100)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_592 Int) (BOUND_VARIABLE_593 Int)) (> BOUND_VARIABLE_592 BOUND_VARIABLE_593)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_592 Int) (BOUND_VARIABLE_593 Int)) (> BOUND_VARIABLE_592 BOUND_VARIABLE_593)) ((_ tuple.select 6) t) (nullable.some 100)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_613 Int) (BOUND_VARIABLE_614 Int)) (= BOUND_VARIABLE_613 BOUND_VARIABLE_614)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_613 Int) (BOUND_VARIABLE_614 Int)) (= BOUND_VARIABLE_613 BOUND_VARIABLE_614)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f4 (set.filter p3 (set.union (set.union (set.map leftJoin1 (set.minus DEPT ((_ rel.project 0 1) (set.filter p0 (rel.product DEPT EMP))))) (set.map rightJoin2 (set.minus EMP ((_ rel.project 2 3 4 5 6 7 8 9 10) (set.filter p0 (rel.product DEPT EMP)))))) (set.filter p0 (rel.product DEPT EMP)))))))
(assert (= q2 (set.map f8 (set.union (set.map rightJoin7 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)) ((_ rel.project 2 3 4 5 6 7 8 9 10) (set.filter p6 (rel.product DEPT ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP))))))) (set.filter p6 (rel.product DEPT ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP))))))))
(check-sat)
;answer: sat
; duration: 886 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 0) (nullable.some "["))))
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 31) (nullable.some "\u{5c}") (nullable.some "]") (nullable.some (- 31)) (nullable.some 32) (nullable.some (- 32)) (nullable.some 100) (nullable.some 0) (nullable.some 33))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 1)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; insert into DEPT values(0,'[')
; insert into EMP values(31,'\',']',-31,32,-32,100,0,33)
; SELECT * FROM (SELECT 1 FROM DEPT AS DEPT FULL JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE EMP.SAL >= 100) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM DEPT AS DEPT0 RIGHT JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL > 100) AS t1 ON DEPT0.DEPTNO = t1.DEPTNO) AS q2;
;(1)

; SELECT * FROM (SELECT 1 FROM DEPT AS DEPT0 RIGHT JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL > 100) AS t1 ON DEPT0.DEPTNO = t1.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM DEPT AS DEPT FULL JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE EMP.SAL >= 100) AS q1;

;Model soundness: true
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_450 Bool)) (not BOUND_VARIABLE_450)) (nullable.lift (lambda ((BOUND_VARIABLE_444 Int) (BOUND_VARIABLE_445 Int)) (= BOUND_VARIABLE_444 BOUND_VARIABLE_445)) ((_ tuple.select 0) t) (nullable.some 11)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_450 Bool)) (not BOUND_VARIABLE_450)) (nullable.lift (lambda ((BOUND_VARIABLE_444 Int) (BOUND_VARIABLE_445 Int)) (= BOUND_VARIABLE_444 BOUND_VARIABLE_445)) ((_ tuple.select 0) t) (nullable.some 11)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_465 Bool) (BOUND_VARIABLE_466 Bool)) (and BOUND_VARIABLE_465 BOUND_VARIABLE_466)) (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_450 Bool)) (not BOUND_VARIABLE_450)) (nullable.lift (lambda ((BOUND_VARIABLE_444 Int) (BOUND_VARIABLE_445 Int)) (= BOUND_VARIABLE_444 BOUND_VARIABLE_445)) ((_ tuple.select 0) t) (nullable.some 11))))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_450 Bool)) (not BOUND_VARIABLE_450)) (nullable.lift (lambda ((BOUND_VARIABLE_444 Int) (BOUND_VARIABLE_445 Int)) (= BOUND_VARIABLE_444 BOUND_VARIABLE_445)) ((_ tuple.select 0) t) (nullable.some 11)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_450 Bool)) (not BOUND_VARIABLE_450)) (nullable.lift (lambda ((BOUND_VARIABLE_444 Int) (BOUND_VARIABLE_445 Int)) (= BOUND_VARIABLE_444 BOUND_VARIABLE_445)) ((_ tuple.select 0) t) (nullable.some 11)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_465 Bool) (BOUND_VARIABLE_466 Bool)) (and BOUND_VARIABLE_465 BOUND_VARIABLE_466)) (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_450 Bool)) (not BOUND_VARIABLE_450)) (nullable.lift (lambda ((BOUND_VARIABLE_444 Int) (BOUND_VARIABLE_445 Int)) (= BOUND_VARIABLE_444 BOUND_VARIABLE_445)) ((_ tuple.select 0) t) (nullable.some 11)))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= q1 ((_ rel.project 0) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0) (set.filter p1 (set.singleton (tuple (nullable.some 0)))))))
(check-sat)
;answer: sat
; duration: 43 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 10) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 0) (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 10)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; insert into EMP values(10,NULL,'',0,1,-1,2,-2,3)
; SELECT * FROM (SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND NOT EMP.EMPNO = 11) AS q1 EXCEPT ALL SELECT * FROM (SELECT t1.column1 FROM (SELECT * FROM (VALUES(0)) WHERE FALSE) AS t1) AS q2;
;(10)

; SELECT * FROM (SELECT t1.column1 FROM (SELECT * FROM (VALUES(0)) WHERE FALSE) AS t1) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND NOT EMP.EMPNO = 11) AS q1;

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
; duration: 11 ms.
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_485 Int) (BOUND_VARIABLE_486 Int)) (= BOUND_VARIABLE_485 BOUND_VARIABLE_486)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_485 Int) (BOUND_VARIABLE_486 Int)) (= BOUND_VARIABLE_485 BOUND_VARIABLE_486)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_540 Int) (BOUND_VARIABLE_541 Int)) (distinct BOUND_VARIABLE_540 BOUND_VARIABLE_541)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_540 Int) (BOUND_VARIABLE_541 Int)) (distinct BOUND_VARIABLE_540 BOUND_VARIABLE_541)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f1 (set.filter p0 (rel.product EMP EMP)))))
(assert (= q2 (set.map f3 (set.filter p2 (rel.product EMP EMP)))))
(check-sat)
;answer: sat
; duration: 176 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some (- 10)) (nullable.some "E") (nullable.some "F") (nullable.some 11) (nullable.some (- 11)) (nullable.some 12) (nullable.some (- 12)) (nullable.some 0) (nullable.some 13))) (set.singleton (tuple (nullable.some (- 7)) (nullable.some "C") (nullable.some "D") (nullable.some 8) (nullable.some (- 8)) (nullable.some 9) (nullable.some (- 9)) (nullable.some 0) (nullable.some 10)))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 1)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; insert into EMP values(-10,'E','F',11,-11,12,-12,0,13),(-7,'C','D',8,-8,9,-9,0,10)
; SELECT * FROM (SELECT 1 FROM EMP AS EMP INNER JOIN EMP AS EMP0 ON EMP.DEPTNO = EMP0.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM EMP AS EMP1 INNER JOIN EMP AS EMP2 ON EMP1.DEPTNO <> EMP2.DEPTNO) AS q2;
;(1)
;(1)
;(1)
;(1)

; SELECT * FROM (SELECT 1 FROM EMP AS EMP1 INNER JOIN EMP AS EMP2 ON EMP1.DEPTNO <> EMP2.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM EMP AS EMP INNER JOIN EMP AS EMP0 ON EMP.DEPTNO = EMP0.DEPTNO) AS q1;

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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_400 Int) (BOUND_VARIABLE_401 Int)) (< BOUND_VARIABLE_400 BOUND_VARIABLE_401)) (nullable.lift (lambda ((BOUND_VARIABLE_392 Int) (BOUND_VARIABLE_393 Int)) (- BOUND_VARIABLE_392 BOUND_VARIABLE_393)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_400 Int) (BOUND_VARIABLE_401 Int)) (< BOUND_VARIABLE_400 BOUND_VARIABLE_401)) (nullable.lift (lambda ((BOUND_VARIABLE_392 Int) (BOUND_VARIABLE_393 Int)) (- BOUND_VARIABLE_392 BOUND_VARIABLE_393)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 0) t)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_450 Int) (BOUND_VARIABLE_451 Int)) (+ BOUND_VARIABLE_450 BOUND_VARIABLE_451)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= q1 (set.map f1 (set.filter p0 (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 30) (nullable.some 7))))))))
(assert (= q2 ((_ rel.project 0 1 2) (set.filter p2 (set.singleton (tuple (nullable.some 0) (nullable.some 0) (nullable.some 0)))))))
(check-sat)
;answer: sat
; duration: 14 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (set.union (set.singleton (tuple (nullable.some 11) (nullable.some 1) (nullable.some 10))) (set.singleton (tuple (nullable.some 37) (nullable.some 7) (nullable.some 30))))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
; SELECT * FROM (SELECT t.column1 + t.column2 AS X, t.column2 AS B, t.column1 AS A FROM (VALUES  (10, 1),  (30, 7)) AS t WHERE t.column1 - t.column2 < t.column1) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES(0,0,0)) WHERE FALSE) AS t2) AS q2;
;(37,7,30)
;(11,1,10)

; SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES(0,0,0)) WHERE FALSE) AS t2) AS q2 EXCEPT ALL SELECT * FROM (SELECT t.column1 + t.column2 AS X, t.column2 AS B, t.column1 AS A FROM (VALUES  (10, 1),  (30, 7)) AS t WHERE t.column1 - t.column2 < t.column1) AS q1;

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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_429 Int) (BOUND_VARIABLE_430 Int)) (= BOUND_VARIABLE_429 BOUND_VARIABLE_430)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_421 Int) (BOUND_VARIABLE_422 Int)) (* BOUND_VARIABLE_421 BOUND_VARIABLE_422)) (nullable.some 10) ((_ tuple.select 5) t)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_429 Int) (BOUND_VARIABLE_430 Int)) (= BOUND_VARIABLE_429 BOUND_VARIABLE_430)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_421 Int) (BOUND_VARIABLE_422 Int)) (* BOUND_VARIABLE_421 BOUND_VARIABLE_422)) (nullable.some 10) ((_ tuple.select 5) t)))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_459 String) (BOUND_VARIABLE_460 String)) (= BOUND_VARIABLE_459 BOUND_VARIABLE_460)) (nullable.lift (lambda ((BOUND_VARIABLE_451 String)) (str.to_upper BOUND_VARIABLE_451)) ((_ tuple.select 1) t)) (nullable.some "FO0"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_459 String) (BOUND_VARIABLE_460 String)) (= BOUND_VARIABLE_459 BOUND_VARIABLE_460)) (nullable.lift (lambda ((BOUND_VARIABLE_451 String)) (str.to_upper BOUND_VARIABLE_451)) ((_ tuple.select 1) t)) (nullable.some "FO0"))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_475 Bool) (BOUND_VARIABLE_476 Bool)) (and BOUND_VARIABLE_475 BOUND_VARIABLE_476)) (nullable.lift (lambda ((BOUND_VARIABLE_429 Int) (BOUND_VARIABLE_430 Int)) (= BOUND_VARIABLE_429 BOUND_VARIABLE_430)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_421 Int) (BOUND_VARIABLE_422 Int)) (* BOUND_VARIABLE_421 BOUND_VARIABLE_422)) (nullable.some 10) ((_ tuple.select 5) t))) (nullable.lift (lambda ((BOUND_VARIABLE_459 String) (BOUND_VARIABLE_460 String)) (= BOUND_VARIABLE_459 BOUND_VARIABLE_460)) (nullable.lift (lambda ((BOUND_VARIABLE_451 String)) (str.to_upper BOUND_VARIABLE_451)) ((_ tuple.select 1) t)) (nullable.some "FO0")))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_429 Int) (BOUND_VARIABLE_430 Int)) (= BOUND_VARIABLE_429 BOUND_VARIABLE_430)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_421 Int) (BOUND_VARIABLE_422 Int)) (* BOUND_VARIABLE_421 BOUND_VARIABLE_422)) (nullable.some 10) ((_ tuple.select 5) t)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_429 Int) (BOUND_VARIABLE_430 Int)) (= BOUND_VARIABLE_429 BOUND_VARIABLE_430)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_421 Int) (BOUND_VARIABLE_422 Int)) (* BOUND_VARIABLE_421 BOUND_VARIABLE_422)) (nullable.some 10) ((_ tuple.select 5) t)))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_459 String) (BOUND_VARIABLE_460 String)) (= BOUND_VARIABLE_459 BOUND_VARIABLE_460)) (nullable.lift (lambda ((BOUND_VARIABLE_451 String)) (str.to_upper BOUND_VARIABLE_451)) ((_ tuple.select 1) t)) (nullable.some "FO0"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_459 String) (BOUND_VARIABLE_460 String)) (= BOUND_VARIABLE_459 BOUND_VARIABLE_460)) (nullable.lift (lambda ((BOUND_VARIABLE_451 String)) (str.to_upper BOUND_VARIABLE_451)) ((_ tuple.select 1) t)) (nullable.some "FO0"))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_475 Bool) (BOUND_VARIABLE_476 Bool)) (and BOUND_VARIABLE_475 BOUND_VARIABLE_476)) (nullable.lift (lambda ((BOUND_VARIABLE_429 Int) (BOUND_VARIABLE_430 Int)) (= BOUND_VARIABLE_429 BOUND_VARIABLE_430)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_421 Int) (BOUND_VARIABLE_422 Int)) (* BOUND_VARIABLE_421 BOUND_VARIABLE_422)) (nullable.some 10) ((_ tuple.select 5) t))) (nullable.lift (lambda ((BOUND_VARIABLE_459 String) (BOUND_VARIABLE_460 String)) (= BOUND_VARIABLE_459 BOUND_VARIABLE_460)) (nullable.lift (lambda ((BOUND_VARIABLE_451 String)) (str.to_upper BOUND_VARIABLE_451)) ((_ tuple.select 1) t)) (nullable.some "FO0"))))))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_507 Int) (BOUND_VARIABLE_508 Int)) (+ BOUND_VARIABLE_507 BOUND_VARIABLE_508)) ((_ tuple.select 0) t) ((_ tuple.select 7) t))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (= BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_553 Int) (BOUND_VARIABLE_554 Int)) (* BOUND_VARIABLE_553 BOUND_VARIABLE_554)) (nullable.some 10) ((_ tuple.select 3) t)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (= BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_553 Int) (BOUND_VARIABLE_554 Int)) (* BOUND_VARIABLE_553 BOUND_VARIABLE_554)) (nullable.some 10) ((_ tuple.select 3) t)))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_573 String) (BOUND_VARIABLE_574 String)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) (nullable.lift (lambda ((BOUND_VARIABLE_566 String)) (str.to_upper BOUND_VARIABLE_566)) ((_ tuple.select 1) t)) (nullable.some "FOO"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_573 String) (BOUND_VARIABLE_574 String)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) (nullable.lift (lambda ((BOUND_VARIABLE_566 String)) (str.to_upper BOUND_VARIABLE_566)) ((_ tuple.select 1) t)) (nullable.some "FOO"))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_587 Bool) (BOUND_VARIABLE_588 Bool)) (and BOUND_VARIABLE_587 BOUND_VARIABLE_588)) (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (= BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_553 Int) (BOUND_VARIABLE_554 Int)) (* BOUND_VARIABLE_553 BOUND_VARIABLE_554)) (nullable.some 10) ((_ tuple.select 3) t))) (nullable.lift (lambda ((BOUND_VARIABLE_573 String) (BOUND_VARIABLE_574 String)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) (nullable.lift (lambda ((BOUND_VARIABLE_566 String)) (str.to_upper BOUND_VARIABLE_566)) ((_ tuple.select 1) t)) (nullable.some "FOO")))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (= BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_553 Int) (BOUND_VARIABLE_554 Int)) (* BOUND_VARIABLE_553 BOUND_VARIABLE_554)) (nullable.some 10) ((_ tuple.select 3) t)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (= BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_553 Int) (BOUND_VARIABLE_554 Int)) (* BOUND_VARIABLE_553 BOUND_VARIABLE_554)) (nullable.some 10) ((_ tuple.select 3) t)))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_573 String) (BOUND_VARIABLE_574 String)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) (nullable.lift (lambda ((BOUND_VARIABLE_566 String)) (str.to_upper BOUND_VARIABLE_566)) ((_ tuple.select 1) t)) (nullable.some "FOO"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_573 String) (BOUND_VARIABLE_574 String)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) (nullable.lift (lambda ((BOUND_VARIABLE_566 String)) (str.to_upper BOUND_VARIABLE_566)) ((_ tuple.select 1) t)) (nullable.some "FOO"))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_587 Bool) (BOUND_VARIABLE_588 Bool)) (and BOUND_VARIABLE_587 BOUND_VARIABLE_588)) (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (= BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_553 Int) (BOUND_VARIABLE_554 Int)) (* BOUND_VARIABLE_553 BOUND_VARIABLE_554)) (nullable.some 10) ((_ tuple.select 3) t))) (nullable.lift (lambda ((BOUND_VARIABLE_573 String) (BOUND_VARIABLE_574 String)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) (nullable.lift (lambda ((BOUND_VARIABLE_566 String)) (str.to_upper BOUND_VARIABLE_566)) ((_ tuple.select 1) t)) (nullable.some "FOO"))))))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_607 Int) (BOUND_VARIABLE_608 Int)) (+ BOUND_VARIABLE_607 BOUND_VARIABLE_608)) ((_ tuple.select 0) t) ((_ tuple.select 4) t))))))
(assert (= q1 (set.map f1 (set.filter p0 EMP))))
(assert (= q2 (set.map f3 (set.filter p2 ((_ rel.project 0 1 6 5 7) EMP)))))
(check-sat)
;answer: sat
; duration: 684 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (as nullable.null (Nullable Int)) (nullable.some "foo") (nullable.some "B") (nullable.some (- 2)) (nullable.some 3) (nullable.some 0) (nullable.some 0) (as nullable.null (Nullable Int)) (nullable.some (- 3)))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (as nullable.null (Nullable Int))))
; insert into EMP values(NULL,'foo','B',-2,3,0,0,NULL,-3)
; SELECT * FROM (SELECT EMP.EMPNO + EMP.DEPTNO FROM EMP AS EMP WHERE EMP.SAL = 10 * EMP.COMM AND UPPER(EMP.ENAME) = 'FO0') AS q1 EXCEPT ALL SELECT * FROM (SELECT t1.EMPNO + t1.DEPTNO FROM (SELECT EMP0.EMPNO, EMP0.ENAME, EMP0.SAL, EMP0.COMM, EMP0.DEPTNO FROM EMP AS EMP0) AS t1 WHERE t1.SAL = 10 * t1.COMM AND UPPER(t1.ENAME) = 'FOO') AS q2;

; SELECT * FROM (SELECT t1.EMPNO + t1.DEPTNO FROM (SELECT EMP0.EMPNO, EMP0.ENAME, EMP0.SAL, EMP0.COMM, EMP0.DEPTNO FROM EMP AS EMP0) AS t1 WHERE t1.SAL = 10 * t1.COMM AND UPPER(t1.ENAME) = 'FOO') AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.EMPNO + EMP.DEPTNO FROM EMP AS EMP WHERE EMP.SAL = 10 * EMP.COMM AND UPPER(EMP.ENAME) = 'FO0') AS q1;
;(NULL)

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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_473 Int) (BOUND_VARIABLE_474 Int)) (= BOUND_VARIABLE_473 BOUND_VARIABLE_474)) ((_ tuple.select 0) t) ((_ tuple.select 2) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_473 Int) (BOUND_VARIABLE_474 Int)) (= BOUND_VARIABLE_473 BOUND_VARIABLE_474)) ((_ tuple.select 0) t) ((_ tuple.select 2) t)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_508 Int) (BOUND_VARIABLE_509 Int)) (<= BOUND_VARIABLE_508 BOUND_VARIABLE_509)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_508 Int) (BOUND_VARIABLE_509 Int)) (<= BOUND_VARIABLE_508 BOUND_VARIABLE_509)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_526 Int) (BOUND_VARIABLE_527 Int)) (< BOUND_VARIABLE_526 BOUND_VARIABLE_527)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_526 Int) (BOUND_VARIABLE_527 Int)) (< BOUND_VARIABLE_526 BOUND_VARIABLE_527)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_547 Int) (BOUND_VARIABLE_548 Int)) (= BOUND_VARIABLE_547 BOUND_VARIABLE_548)) ((_ tuple.select 0) t) ((_ tuple.select 2) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_547 Int) (BOUND_VARIABLE_548 Int)) (= BOUND_VARIABLE_547 BOUND_VARIABLE_548)) ((_ tuple.select 0) t) ((_ tuple.select 2) t)))))))
(assert (= q1 ((_ rel.project 0 1 2) (set.filter p1 (set.filter p0 (rel.product DEPT ((_ rel.project 7) EMP)))))))
(assert (= q2 ((_ rel.project 0 1 2) (set.filter p3 (rel.product ((_ rel.project 0 1) (set.filter p2 DEPT)) ((_ rel.project 7) EMP))))))
(check-sat)
;answer: sat
; duration: 110 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 10) (as nullable.null (Nullable String)))))
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 0) (nullable.some "") (nullable.some "A") (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 10) (nullable.some 3))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 10) (as nullable.null (Nullable String)) (nullable.some 10)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
; insert into DEPT values(10,NULL)
; insert into EMP values(0,'','A',1,-1,2,-2,10,3)
; SELECT * FROM (SELECT * FROM DEPT AS DEPT INNER JOIN (SELECT EMP.DEPTNO FROM EMP AS EMP) AS t ON DEPT.DEPTNO = t.DEPTNO WHERE DEPT.DEPTNO <= 10) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO < 10) AS t1 INNER JOIN (SELECT EMP0.DEPTNO FROM EMP AS EMP0) AS t2 ON t1.DEPTNO = t2.DEPTNO) AS q2;
;(10,NULL,10)

; SELECT * FROM (SELECT * FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO < 10) AS t1 INNER JOIN (SELECT EMP0.DEPTNO FROM EMP AS EMP0) AS t2 ON t1.DEPTNO = t2.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM DEPT AS DEPT INNER JOIN (SELECT EMP.DEPTNO FROM EMP AS EMP) AS t ON DEPT.DEPTNO = t.DEPTNO WHERE DEPT.DEPTNO <= 10) AS q1;

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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (> BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (> BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_469 Int) (BOUND_VARIABLE_470 Int)) (> BOUND_VARIABLE_469 BOUND_VARIABLE_470)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_469 Int) (BOUND_VARIABLE_470 Int)) (> BOUND_VARIABLE_469 BOUND_VARIABLE_470)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_490 Int) (BOUND_VARIABLE_491 Int)) (> BOUND_VARIABLE_490 BOUND_VARIABLE_491)) ((_ tuple.select 7) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_490 Int) (BOUND_VARIABLE_491 Int)) (> BOUND_VARIABLE_490 BOUND_VARIABLE_491)) ((_ tuple.select 7) t) (nullable.some 1)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_551 Int) (BOUND_VARIABLE_552 Int)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_551 Int) (BOUND_VARIABLE_552 Int)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_576 Int) (BOUND_VARIABLE_577 Int)) (>= BOUND_VARIABLE_576 BOUND_VARIABLE_577)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_576 Int) (BOUND_VARIABLE_577 Int)) (>= BOUND_VARIABLE_576 BOUND_VARIABLE_577)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (> BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (> BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_612 Int) (BOUND_VARIABLE_613 Int)) (> BOUND_VARIABLE_612 BOUND_VARIABLE_613)) ((_ tuple.select 7) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_612 Int) (BOUND_VARIABLE_613 Int)) (> BOUND_VARIABLE_612 BOUND_VARIABLE_613)) ((_ tuple.select 7) t) (nullable.some 1)))))))
(assert (= p8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_630 Int) (BOUND_VARIABLE_631 Int)) (> BOUND_VARIABLE_630 BOUND_VARIABLE_631)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_630 Int) (BOUND_VARIABLE_631 Int)) (> BOUND_VARIABLE_630 BOUND_VARIABLE_631)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_636 Int) (BOUND_VARIABLE_637 Int)) (> BOUND_VARIABLE_636 BOUND_VARIABLE_637)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_636 Int) (BOUND_VARIABLE_637 Int)) (> BOUND_VARIABLE_636 BOUND_VARIABLE_637)) ((_ tuple.select 7) t) (nullable.some 10)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_655 Bool) (BOUND_VARIABLE_656 Bool) (BOUND_VARIABLE_657 Bool)) (or BOUND_VARIABLE_655 BOUND_VARIABLE_656 BOUND_VARIABLE_657)) (nullable.lift (lambda ((BOUND_VARIABLE_630 Int) (BOUND_VARIABLE_631 Int)) (> BOUND_VARIABLE_630 BOUND_VARIABLE_631)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_636 Int) (BOUND_VARIABLE_637 Int)) (> BOUND_VARIABLE_636 BOUND_VARIABLE_637)) ((_ tuple.select 7) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_642 Int) (BOUND_VARIABLE_643 Int)) (> BOUND_VARIABLE_642 BOUND_VARIABLE_643)) ((_ tuple.select 7) t) (nullable.some 1)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_630 Int) (BOUND_VARIABLE_631 Int)) (> BOUND_VARIABLE_630 BOUND_VARIABLE_631)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_630 Int) (BOUND_VARIABLE_631 Int)) (> BOUND_VARIABLE_630 BOUND_VARIABLE_631)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_636 Int) (BOUND_VARIABLE_637 Int)) (> BOUND_VARIABLE_636 BOUND_VARIABLE_637)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_636 Int) (BOUND_VARIABLE_637 Int)) (> BOUND_VARIABLE_636 BOUND_VARIABLE_637)) ((_ tuple.select 7) t) (nullable.some 10)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_655 Bool) (BOUND_VARIABLE_656 Bool) (BOUND_VARIABLE_657 Bool)) (or BOUND_VARIABLE_655 BOUND_VARIABLE_656 BOUND_VARIABLE_657)) (nullable.lift (lambda ((BOUND_VARIABLE_630 Int) (BOUND_VARIABLE_631 Int)) (> BOUND_VARIABLE_630 BOUND_VARIABLE_631)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_636 Int) (BOUND_VARIABLE_637 Int)) (> BOUND_VARIABLE_636 BOUND_VARIABLE_637)) ((_ tuple.select 7) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_642 Int) (BOUND_VARIABLE_643 Int)) (> BOUND_VARIABLE_642 BOUND_VARIABLE_643)) ((_ tuple.select 7) t) (nullable.some 1))))))))))
(assert (= p9 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_679 Int) (BOUND_VARIABLE_680 Int)) (= BOUND_VARIABLE_679 BOUND_VARIABLE_680)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_679 Int) (BOUND_VARIABLE_680 Int)) (= BOUND_VARIABLE_679 BOUND_VARIABLE_680)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f10 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f4 (set.filter p3 (rel.product (set.union ((_ rel.project 0) (set.union ((_ rel.project 7) (set.filter p0 EMP)) ((_ rel.project 7) (set.filter p1 EMP)))) ((_ rel.project 7) (set.filter p2 EMP))) EMP)))))
(assert (= q2 (set.map f10 (set.filter p9 (rel.product (set.union ((_ rel.project 0) (set.union ((_ rel.project 7) (set.filter p5 EMP)) ((_ rel.project 7) (set.filter p6 EMP)))) ((_ rel.project 7) (set.filter p7 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p8 EMP)))))))
(check-sat)
;answer: unsat
; duration: 551 ms.
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_485 Int) (BOUND_VARIABLE_486 Int)) (= BOUND_VARIABLE_485 BOUND_VARIABLE_486)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_485 Int) (BOUND_VARIABLE_486 Int)) (= BOUND_VARIABLE_485 BOUND_VARIABLE_486)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_631 Int) (BOUND_VARIABLE_632 Int)) (= BOUND_VARIABLE_631 BOUND_VARIABLE_632)) ((_ tuple.select 7) t) ((_ tuple.select 11) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_631 Int) (BOUND_VARIABLE_632 Int)) (= BOUND_VARIABLE_631 BOUND_VARIABLE_632)) ((_ tuple.select 7) t) ((_ tuple.select 11) t)))))))
(assert (= rightJoin5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map rightJoin1 (set.minus DEPT ((_ rel.project 9 10) (set.filter p0 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP) DEPT))))) (set.filter p0 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP) DEPT))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map rightJoin5 (set.minus (set.map f3 DEPT) ((_ rel.project 9 10 11) (set.filter p4 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 (set.singleton (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0))))) (set.map f3 DEPT)))))) (set.filter p4 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 (set.singleton (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0))))) (set.map f3 DEPT)))))))
(check-sat)
;answer: sat
; duration: 155 ms.
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
; SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE TRUE) AS t RIGHT JOIN DEPT AS DEPT ON t.DEPTNO = DEPT.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0)) WHERE FALSE) AS t0 RIGHT JOIN DEPT AS DEPT0 ON t0.column8 = DEPT0.DEPTNO) AS q2;
;(1,A,B,-1,2,-2,3,0,-3,0,)

; SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0)) WHERE FALSE) AS t0 RIGHT JOIN DEPT AS DEPT0 ON t0.column8 = DEPT0.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE TRUE) AS t RIGHT JOIN DEPT AS DEPT ON t.DEPTNO = DEPT.DEPTNO) AS q1;
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (> BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (> BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_522 Int) (BOUND_VARIABLE_523 Int)) (= BOUND_VARIABLE_522 BOUND_VARIABLE_523)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_522 Int) (BOUND_VARIABLE_523 Int)) (= BOUND_VARIABLE_522 BOUND_VARIABLE_523)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_563 Int) (BOUND_VARIABLE_564 Int)) (>= BOUND_VARIABLE_563 BOUND_VARIABLE_564)) ((_ tuple.select 16) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_563 Int) (BOUND_VARIABLE_564 Int)) (>= BOUND_VARIABLE_563 BOUND_VARIABLE_564)) ((_ tuple.select 16) t) (nullable.some 9)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_600 Int) (BOUND_VARIABLE_601 Int)) (> BOUND_VARIABLE_600 BOUND_VARIABLE_601)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_600 Int) (BOUND_VARIABLE_601 Int)) (> BOUND_VARIABLE_600 BOUND_VARIABLE_601)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_617 Int) (BOUND_VARIABLE_618 Int)) (> BOUND_VARIABLE_617 BOUND_VARIABLE_618)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_617 Int) (BOUND_VARIABLE_618 Int)) (> BOUND_VARIABLE_617 BOUND_VARIABLE_618)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_636 Int) (BOUND_VARIABLE_637 Int)) (= BOUND_VARIABLE_636 BOUND_VARIABLE_637)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_636 Int) (BOUND_VARIABLE_637 Int)) (= BOUND_VARIABLE_636 BOUND_VARIABLE_637)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= leftJoin8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= p9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_671 Int) (BOUND_VARIABLE_672 Int)) (> BOUND_VARIABLE_671 BOUND_VARIABLE_672)) ((_ tuple.select 16) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_671 Int) (BOUND_VARIABLE_672 Int)) (> BOUND_VARIABLE_671 BOUND_VARIABLE_672)) ((_ tuple.select 16) t) (nullable.some 9)))))))
(assert (= f10 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f4 (set.filter p3 (set.union (set.map leftJoin2 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) EMP))))) (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) EMP)))))))
(assert (= q2 (set.map f10 (set.filter p9 (set.union (set.map leftJoin8 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p7 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 EMP))))))) (set.filter p7 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 EMP)))))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10021 ms.
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
; duration: 148 ms.
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
;answer: sat
; duration: 78 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some (- 3)) (nullable.some "A") (nullable.some "B") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (nullable.some (- 6)))) (set.singleton (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 0) (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3)))))
; )
; q1
(get-value (q1))
; (set.union (set.singleton (tuple (nullable.some (- 5)))) (set.singleton (tuple (nullable.some 2))))
; q2
(get-value (q2))
; (set.union (set.singleton (tuple (nullable.some (- 3)))) (set.singleton (tuple (as nullable.null (Nullable Int)))))
; insert into EMP values(-3,'A','B',4,-4,5,-5,6,-6),(NULL,NULL,'',0,1,-1,2,-2,3)
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_482 Int) (BOUND_VARIABLE_483 Int)) (= BOUND_VARIABLE_482 BOUND_VARIABLE_483)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_482 Int) (BOUND_VARIABLE_483 Int)) (= BOUND_VARIABLE_482 BOUND_VARIABLE_483)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_555 String) (BOUND_VARIABLE_556 String)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 1) t) (nullable.some "Charli"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_555 String) (BOUND_VARIABLE_556 String)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 1) t) (nullable.some "Charli"))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_565 Int) (BOUND_VARIABLE_566 Int)) (> BOUND_VARIABLE_565 BOUND_VARIABLE_566)) ((_ tuple.select 8) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_565 Int) (BOUND_VARIABLE_566 Int)) (> BOUND_VARIABLE_565 BOUND_VARIABLE_566)) ((_ tuple.select 8) t) (nullable.some 100))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_580 Bool) (BOUND_VARIABLE_581 Bool)) (and BOUND_VARIABLE_580 BOUND_VARIABLE_581)) (nullable.lift (lambda ((BOUND_VARIABLE_555 String) (BOUND_VARIABLE_556 String)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 1) t) (nullable.some "Charli")) (nullable.lift (lambda ((BOUND_VARIABLE_565 Int) (BOUND_VARIABLE_566 Int)) (> BOUND_VARIABLE_565 BOUND_VARIABLE_566)) ((_ tuple.select 8) t) (nullable.some 100)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_555 String) (BOUND_VARIABLE_556 String)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 1) t) (nullable.some "Charli"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_555 String) (BOUND_VARIABLE_556 String)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 1) t) (nullable.some "Charli"))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_565 Int) (BOUND_VARIABLE_566 Int)) (> BOUND_VARIABLE_565 BOUND_VARIABLE_566)) ((_ tuple.select 8) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_565 Int) (BOUND_VARIABLE_566 Int)) (> BOUND_VARIABLE_565 BOUND_VARIABLE_566)) ((_ tuple.select 8) t) (nullable.some 100))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_580 Bool) (BOUND_VARIABLE_581 Bool)) (and BOUND_VARIABLE_580 BOUND_VARIABLE_581)) (nullable.lift (lambda ((BOUND_VARIABLE_555 String) (BOUND_VARIABLE_556 String)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 1) t) (nullable.some "Charli")) (nullable.lift (lambda ((BOUND_VARIABLE_565 Int) (BOUND_VARIABLE_566 Int)) (> BOUND_VARIABLE_565 BOUND_VARIABLE_566)) ((_ tuple.select 8) t) (nullable.some 100))))))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_622 String) (BOUND_VARIABLE_623 String)) (= BOUND_VARIABLE_622 BOUND_VARIABLE_623)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_622 String) (BOUND_VARIABLE_623 String)) (= BOUND_VARIABLE_622 BOUND_VARIABLE_623)) ((_ tuple.select 1) t) (nullable.some "Charlie")))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_640 Int) (BOUND_VARIABLE_641 Int)) (> BOUND_VARIABLE_640 BOUND_VARIABLE_641)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_640 Int) (BOUND_VARIABLE_641 Int)) (> BOUND_VARIABLE_640 BOUND_VARIABLE_641)) ((_ tuple.select 6) t) (nullable.some 100)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_661 Int) (BOUND_VARIABLE_662 Int)) (= BOUND_VARIABLE_661 BOUND_VARIABLE_662)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_661 Int) (BOUND_VARIABLE_662 Int)) (= BOUND_VARIABLE_661 BOUND_VARIABLE_662)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f4 (set.filter p3 (set.union (set.union (set.map leftJoin1 (set.minus DEPT ((_ rel.project 0 1) (set.filter p0 (rel.product DEPT EMP))))) (set.map rightJoin2 (set.minus EMP ((_ rel.project 2 3 4 5 6 7 8 9 10) (set.filter p0 (rel.product DEPT EMP)))))) (set.filter p0 (rel.product DEPT EMP)))))))
(assert (= q2 (set.map f8 (set.filter p7 (rel.product ((_ rel.project 0 1) (set.filter p5 DEPT)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 EMP)))))))
(check-sat)
;answer: sat
; duration: 469 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some 4) (nullable.some "B") (nullable.some "C") (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 101) (nullable.some 0) (nullable.some 6))) (set.singleton (tuple (nullable.some (- 1)) (nullable.some "") (nullable.some "A") (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some 101) (nullable.some 0) (nullable.some (- 3))))))
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.union (set.singleton (tuple (nullable.some 0) (as nullable.null (Nullable String)))) (set.singleton (tuple (nullable.some 0) (nullable.some "Charlie")))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 1)))
; insert into EMP values(4,'B','C',-4,5,-5,101,0,6),(-1,'','A',2,-2,3,101,0,-3)
; insert into DEPT values(0,NULL),(0,'Charlie')
; SELECT * FROM (SELECT 1 FROM DEPT AS DEPT FULL JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charli' AND EMP.SAL > 100) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL > 100) AS t2 ON t1.DEPTNO = t2.DEPTNO) AS q2;

; SELECT * FROM (SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL > 100) AS t2 ON t1.DEPTNO = t2.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM DEPT AS DEPT FULL JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charli' AND EMP.SAL > 100) AS q1;
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (or (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_448 Int) (BOUND_VARIABLE_449 Int)) (= BOUND_VARIABLE_448 BOUND_VARIABLE_449)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_448 Int) (BOUND_VARIABLE_449 Int)) (= BOUND_VARIABLE_448 BOUND_VARIABLE_449)) ((_ tuple.select 6) t) (nullable.some 1000)))) (as nullable.null (Nullable Int)) (nullable.some 1))) (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_471 Int) (BOUND_VARIABLE_472 Int)) (= BOUND_VARIABLE_471 BOUND_VARIABLE_472)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_471 Int) (BOUND_VARIABLE_472 Int)) (= BOUND_VARIABLE_471 BOUND_VARIABLE_472)) ((_ tuple.select 6) t) (nullable.some 2000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_508 Int) (BOUND_VARIABLE_509 Int)) (= BOUND_VARIABLE_508 BOUND_VARIABLE_509)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_508 Int) (BOUND_VARIABLE_509 Int)) (= BOUND_VARIABLE_508 BOUND_VARIABLE_509)) ((_ tuple.select 6) t) (nullable.some 100)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_514 Int) (BOUND_VARIABLE_515 Int)) (= BOUND_VARIABLE_514 BOUND_VARIABLE_515)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_514 Int) (BOUND_VARIABLE_515 Int)) (= BOUND_VARIABLE_514 BOUND_VARIABLE_515)) ((_ tuple.select 6) t) (nullable.some 2000)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_527 Bool) (BOUND_VARIABLE_528 Bool)) (or BOUND_VARIABLE_527 BOUND_VARIABLE_528)) (nullable.lift (lambda ((BOUND_VARIABLE_508 Int) (BOUND_VARIABLE_509 Int)) (= BOUND_VARIABLE_508 BOUND_VARIABLE_509)) ((_ tuple.select 6) t) (nullable.some 100)) (nullable.lift (lambda ((BOUND_VARIABLE_514 Int) (BOUND_VARIABLE_515 Int)) (= BOUND_VARIABLE_514 BOUND_VARIABLE_515)) ((_ tuple.select 6) t) (nullable.some 2000)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_508 Int) (BOUND_VARIABLE_509 Int)) (= BOUND_VARIABLE_508 BOUND_VARIABLE_509)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_508 Int) (BOUND_VARIABLE_509 Int)) (= BOUND_VARIABLE_508 BOUND_VARIABLE_509)) ((_ tuple.select 6) t) (nullable.some 100)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_514 Int) (BOUND_VARIABLE_515 Int)) (= BOUND_VARIABLE_514 BOUND_VARIABLE_515)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_514 Int) (BOUND_VARIABLE_515 Int)) (= BOUND_VARIABLE_514 BOUND_VARIABLE_515)) ((_ tuple.select 6) t) (nullable.some 2000)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_527 Bool) (BOUND_VARIABLE_528 Bool)) (or BOUND_VARIABLE_527 BOUND_VARIABLE_528)) (nullable.lift (lambda ((BOUND_VARIABLE_508 Int) (BOUND_VARIABLE_509 Int)) (= BOUND_VARIABLE_508 BOUND_VARIABLE_509)) ((_ tuple.select 6) t) (nullable.some 100)) (nullable.lift (lambda ((BOUND_VARIABLE_514 Int) (BOUND_VARIABLE_515 Int)) (= BOUND_VARIABLE_514 BOUND_VARIABLE_515)) ((_ tuple.select 6) t) (nullable.some 2000))))))))))
(assert (= q1 ((_ rel.project 6) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 6) (set.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 59 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 1000) (nullable.some 3) (nullable.some (- 3)))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 1000)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; insert into EMP values(0,NULL,'',-1,2,-2,1000,3,-3)
; SELECT * FROM (SELECT EMP.SAL FROM EMP AS EMP WHERE CASE WHEN EMP.SAL = 1000 THEN NULL ELSE 1 END IS NULL OR CASE WHEN EMP.SAL = 2000 THEN NULL ELSE 1 END IS NULL) AS q1 EXCEPT ALL SELECT * FROM (SELECT EMP0.SAL FROM EMP AS EMP0 WHERE EMP0.SAL = 100 OR EMP0.SAL = 2000) AS q2;
;(1000)

; SELECT * FROM (SELECT EMP0.SAL FROM EMP AS EMP0 WHERE EMP0.SAL = 100 OR EMP0.SAL = 2000) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.SAL FROM EMP AS EMP WHERE CASE WHEN EMP.SAL = 1000 THEN NULL ELSE 1 END IS NULL OR CASE WHEN EMP.SAL = 2000 THEN NULL ELSE 1 END IS NULL) AS q1;

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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_458 Int) (BOUND_VARIABLE_459 Int)) (= BOUND_VARIABLE_458 BOUND_VARIABLE_459)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_458 Int) (BOUND_VARIABLE_459 Int)) (= BOUND_VARIABLE_458 BOUND_VARIABLE_459)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_479 Int) (BOUND_VARIABLE_480 Int)) (= BOUND_VARIABLE_479 BOUND_VARIABLE_480)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_479 Int) (BOUND_VARIABLE_480 Int)) (= BOUND_VARIABLE_479 BOUND_VARIABLE_480)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_497 Int) (BOUND_VARIABLE_498 Int)) (= BOUND_VARIABLE_497 BOUND_VARIABLE_498)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_497 Int) (BOUND_VARIABLE_498 Int)) (= BOUND_VARIABLE_497 BOUND_VARIABLE_498)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_514 Int) (BOUND_VARIABLE_515 Int)) (= BOUND_VARIABLE_514 BOUND_VARIABLE_515)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_514 Int) (BOUND_VARIABLE_515 Int)) (= BOUND_VARIABLE_514 BOUND_VARIABLE_515)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_532 Int) (BOUND_VARIABLE_533 Int)) (= BOUND_VARIABLE_532 BOUND_VARIABLE_533)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_532 Int) (BOUND_VARIABLE_533 Int)) (= BOUND_VARIABLE_532 BOUND_VARIABLE_533)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))
(assert (= q2 (set.union (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))
(check-sat)
;answer: sat
; duration: 379 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 19) (nullable.some "K") (nullable.some "L") (nullable.some (- 19)) (nullable.some 20) (nullable.some (- 20)) (nullable.some 21) (nullable.some 10) (nullable.some (- 21)))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 19) (nullable.some "K") (nullable.some "L") (nullable.some (- 19)) (nullable.some 20) (nullable.some (- 20)) (nullable.some 21) (nullable.some 10) (nullable.some (- 21))))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; insert into EMP values(19,'K','L',-19,20,-20,21,10,-21)
; SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION ALL SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION ALL SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 20 UNION ALL SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION ALL SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS q2;
;(19,K,L,-19,20,-20,21,10,-21)

; SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 20 UNION ALL SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION ALL SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION ALL SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION ALL SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS q1;

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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const leftJoin1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_482 Int) (BOUND_VARIABLE_483 Int)) (= BOUND_VARIABLE_482 BOUND_VARIABLE_483)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_482 Int) (BOUND_VARIABLE_483 Int)) (= BOUND_VARIABLE_482 BOUND_VARIABLE_483)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_534 Int) (BOUND_VARIABLE_535 Int)) (> BOUND_VARIABLE_534 BOUND_VARIABLE_535)) ((_ tuple.select 8) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_534 Int) (BOUND_VARIABLE_535 Int)) (> BOUND_VARIABLE_534 BOUND_VARIABLE_535)) ((_ tuple.select 8) t) (nullable.some 1000)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (> BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (> BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 6) t) (nullable.some 100)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_594 Int) (BOUND_VARIABLE_595 Int)) (= BOUND_VARIABLE_594 BOUND_VARIABLE_595)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_594 Int) (BOUND_VARIABLE_595 Int)) (= BOUND_VARIABLE_594 BOUND_VARIABLE_595)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f3 (set.filter p2 (set.union (set.map leftJoin1 (set.minus DEPT ((_ rel.project 0 1) (set.filter p0 (rel.product DEPT EMP))))) (set.filter p0 (rel.product DEPT EMP)))))))
(assert (= q2 (set.map f6 (set.filter p5 (rel.product DEPT ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)))))))
(check-sat)
;answer: sat
; duration: 171 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some 4) (nullable.some "B") (nullable.some "C") (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (as nullable.null (Nullable Int)) (nullable.some 0) (nullable.some 6))) (set.singleton (tuple (nullable.some (- 1)) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some 1000) (nullable.some 0) (nullable.some (- 3))))))
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 0) (nullable.some "A"))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 1)))
; insert into EMP values(4,'B','C',-4,5,-5,NULL,0,6),(-1,NULL,'',2,-2,3,1000,0,-3)
; insert into DEPT values(0,'A')
; SELECT * FROM (SELECT 1 FROM DEPT AS DEPT LEFT JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE EMP.SAL > 1000) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM DEPT AS DEPT0 INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL > 100) AS t1 ON DEPT0.DEPTNO = t1.DEPTNO) AS q2;

; SELECT * FROM (SELECT 1 FROM DEPT AS DEPT0 INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL > 100) AS t1 ON DEPT0.DEPTNO = t1.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM DEPT AS DEPT LEFT JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE EMP.SAL > 1000) AS q1;
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_394 Int) (BOUND_VARIABLE_395 Int)) (> BOUND_VARIABLE_394 BOUND_VARIABLE_395)) ((_ tuple.select 0) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_394 Int) (BOUND_VARIABLE_395 Int)) (> BOUND_VARIABLE_394 BOUND_VARIABLE_395)) ((_ tuple.select 0) t) (nullable.some 30)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_445 Int) (BOUND_VARIABLE_446 Int)) (> BOUND_VARIABLE_445 BOUND_VARIABLE_446)) ((_ tuple.select 0) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_445 Int) (BOUND_VARIABLE_446 Int)) (> BOUND_VARIABLE_445 BOUND_VARIABLE_446)) ((_ tuple.select 0) t) (nullable.some 50)))))))
(assert (= q1 (set.minus ((_ rel.project 0 1) (set.minus ((_ rel.project 0 1) (set.minus ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 30) (nullable.some 3)))) ((_ rel.project 0 1) (set.filter p0 (set.singleton (tuple (nullable.some 20) (nullable.some 2))))))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 40) (nullable.some 4)))))) ((_ rel.project 0 1) (set.filter p1 (set.singleton (tuple (nullable.some 50) (nullable.some 5))))))))
(assert (= q2 (set.minus ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 30) (nullable.some 4)))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 40) (nullable.some 40)))))))
(check-sat)
;answer: sat
; duration: 14 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 30) (nullable.some 3)))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 30) (nullable.some 4)))
; SELECT * FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES  (30, 3)) AS t EXCEPT SELECT * FROM (VALUES  (20, 2)) AS t0 WHERE t0.column1 > 30) AS t2 EXCEPT SELECT * FROM (VALUES  (40, 4)) AS t3) AS t4 EXCEPT SELECT * FROM (VALUES  (50, 5)) AS t5 WHERE t5.column1 > 50) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (VALUES  (30, 4)) AS t8 EXCEPT SELECT * FROM (VALUES  (40, 40)) AS t9) AS q2;
;(30,3)

; SELECT * FROM (SELECT * FROM (VALUES  (30, 4)) AS t8 EXCEPT SELECT * FROM (VALUES  (40, 40)) AS t9) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES  (30, 3)) AS t EXCEPT SELECT * FROM (VALUES  (20, 2)) AS t0 WHERE t0.column1 > 30) AS t2 EXCEPT SELECT * FROM (VALUES  (40, 4)) AS t3) AS t4 EXCEPT SELECT * FROM (VALUES  (50, 5)) AS t5 WHERE t5.column1 > 50) AS q1;
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const f6 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 6) t) ((_ tuple.select 5) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_524 Int) (BOUND_VARIABLE_525 Int)) (+ BOUND_VARIABLE_524 BOUND_VARIABLE_525)) ((_ tuple.select 7) t) (nullable.lift (lambda ((BOUND_VARIABLE_517 Int) (BOUND_VARIABLE_518 Int)) (- BOUND_VARIABLE_517 BOUND_VARIABLE_518)) (nullable.some 5) (nullable.some 5)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_592 Int) (BOUND_VARIABLE_593 Int)) (= BOUND_VARIABLE_592 BOUND_VARIABLE_593)) ((_ tuple.select 2) t) ((_ tuple.select 12) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_592 Int) (BOUND_VARIABLE_593 Int)) (= BOUND_VARIABLE_592 BOUND_VARIABLE_593)) ((_ tuple.select 2) t) ((_ tuple.select 12) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_680 Int) (BOUND_VARIABLE_681 Int)) (= BOUND_VARIABLE_680 BOUND_VARIABLE_681)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_674 Int) (BOUND_VARIABLE_675 Int)) (+ BOUND_VARIABLE_674 BOUND_VARIABLE_675)) (nullable.some 7) (nullable.some 8)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_680 Int) (BOUND_VARIABLE_681 Int)) (= BOUND_VARIABLE_680 BOUND_VARIABLE_681)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_674 Int) (BOUND_VARIABLE_675 Int)) (+ BOUND_VARIABLE_674 BOUND_VARIABLE_675)) (nullable.some 7) (nullable.some 8)))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_692 Int) (BOUND_VARIABLE_693 Int)) (= BOUND_VARIABLE_692 BOUND_VARIABLE_693)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_686 Int) (BOUND_VARIABLE_687 Int)) (+ BOUND_VARIABLE_686 BOUND_VARIABLE_687)) (nullable.some 8) (nullable.some 7)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_692 Int) (BOUND_VARIABLE_693 Int)) (= BOUND_VARIABLE_692 BOUND_VARIABLE_693)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_686 Int) (BOUND_VARIABLE_687 Int)) (+ BOUND_VARIABLE_686 BOUND_VARIABLE_687)) (nullable.some 8) (nullable.some 7)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_723 Bool) (BOUND_VARIABLE_724 Bool) (BOUND_VARIABLE_725 Bool)) (and BOUND_VARIABLE_723 BOUND_VARIABLE_724 BOUND_VARIABLE_725)) (nullable.lift (lambda ((BOUND_VARIABLE_680 Int) (BOUND_VARIABLE_681 Int)) (= BOUND_VARIABLE_680 BOUND_VARIABLE_681)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_674 Int) (BOUND_VARIABLE_675 Int)) (+ BOUND_VARIABLE_674 BOUND_VARIABLE_675)) (nullable.some 7) (nullable.some 8))) (nullable.lift (lambda ((BOUND_VARIABLE_692 Int) (BOUND_VARIABLE_693 Int)) (= BOUND_VARIABLE_692 BOUND_VARIABLE_693)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_686 Int) (BOUND_VARIABLE_687 Int)) (+ BOUND_VARIABLE_686 BOUND_VARIABLE_687)) (nullable.some 8) (nullable.some 7))) (nullable.lift (lambda ((BOUND_VARIABLE_708 Int) (BOUND_VARIABLE_709 Int)) (= BOUND_VARIABLE_708 BOUND_VARIABLE_709)) ((_ tuple.select 0) t) (ite (and (nullable.is_some (nullable.some (nullable.is_some (nullable.some 2)))) (nullable.val (nullable.some (nullable.is_some (nullable.some 2))))) (nullable.some 15) (as nullable.null (Nullable Int)))))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_680 Int) (BOUND_VARIABLE_681 Int)) (= BOUND_VARIABLE_680 BOUND_VARIABLE_681)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_674 Int) (BOUND_VARIABLE_675 Int)) (+ BOUND_VARIABLE_674 BOUND_VARIABLE_675)) (nullable.some 7) (nullable.some 8)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_680 Int) (BOUND_VARIABLE_681 Int)) (= BOUND_VARIABLE_680 BOUND_VARIABLE_681)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_674 Int) (BOUND_VARIABLE_675 Int)) (+ BOUND_VARIABLE_674 BOUND_VARIABLE_675)) (nullable.some 7) (nullable.some 8)))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_692 Int) (BOUND_VARIABLE_693 Int)) (= BOUND_VARIABLE_692 BOUND_VARIABLE_693)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_686 Int) (BOUND_VARIABLE_687 Int)) (+ BOUND_VARIABLE_686 BOUND_VARIABLE_687)) (nullable.some 8) (nullable.some 7)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_692 Int) (BOUND_VARIABLE_693 Int)) (= BOUND_VARIABLE_692 BOUND_VARIABLE_693)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_686 Int) (BOUND_VARIABLE_687 Int)) (+ BOUND_VARIABLE_686 BOUND_VARIABLE_687)) (nullable.some 8) (nullable.some 7)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_723 Bool) (BOUND_VARIABLE_724 Bool) (BOUND_VARIABLE_725 Bool)) (and BOUND_VARIABLE_723 BOUND_VARIABLE_724 BOUND_VARIABLE_725)) (nullable.lift (lambda ((BOUND_VARIABLE_680 Int) (BOUND_VARIABLE_681 Int)) (= BOUND_VARIABLE_680 BOUND_VARIABLE_681)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_674 Int) (BOUND_VARIABLE_675 Int)) (+ BOUND_VARIABLE_674 BOUND_VARIABLE_675)) (nullable.some 7) (nullable.some 8))) (nullable.lift (lambda ((BOUND_VARIABLE_692 Int) (BOUND_VARIABLE_693 Int)) (= BOUND_VARIABLE_692 BOUND_VARIABLE_693)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_686 Int) (BOUND_VARIABLE_687 Int)) (+ BOUND_VARIABLE_686 BOUND_VARIABLE_687)) (nullable.some 8) (nullable.some 7))) (nullable.lift (lambda ((BOUND_VARIABLE_708 Int) (BOUND_VARIABLE_709 Int)) (= BOUND_VARIABLE_708 BOUND_VARIABLE_709)) ((_ tuple.select 0) t) (ite (and (nullable.is_some (nullable.some (nullable.is_some (nullable.some 2)))) (nullable.val (nullable.some (nullable.is_some (nullable.some 2))))) (nullable.some 15) (as nullable.null (Nullable Int))))))))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_770 Int) (BOUND_VARIABLE_771 Int)) (+ BOUND_VARIABLE_770 BOUND_VARIABLE_771)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_785 Int) (BOUND_VARIABLE_786 Int)) (+ BOUND_VARIABLE_785 BOUND_VARIABLE_786)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_779 Int) (BOUND_VARIABLE_780 Int)) (+ BOUND_VARIABLE_779 BOUND_VARIABLE_780)) (nullable.some 3) (nullable.some 3))) (nullable.lift (lambda ((BOUND_VARIABLE_799 Int) (BOUND_VARIABLE_800 Int)) (+ BOUND_VARIABLE_799 BOUND_VARIABLE_800)) (nullable.lift (lambda ((BOUND_VARIABLE_793 Int) (BOUND_VARIABLE_794 Int)) (+ BOUND_VARIABLE_793 BOUND_VARIABLE_794)) (nullable.some 5) (nullable.some 6)) ((_ tuple.select 0) t)) (as nullable.null (Nullable Int)) (nullable.some 2) (nullable.lift (lambda ((BOUND_VARIABLE_805 Int) (BOUND_VARIABLE_806 Int)) (+ BOUND_VARIABLE_805 BOUND_VARIABLE_806)) (nullable.some 7) (nullable.some 8))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 3) (nullable.some 22) (nullable.some 26) (as nullable.null (Nullable Int)) (nullable.some 2) (nullable.some 15)))))
(assert (= q1 (set.map f4 (set.filter p3 ((_ rel.project 0 1 3 4 5 6 7 8 9 10 11) (set.filter p2 (rel.product (set.map f0 DEPT) (set.map f1 EMP))))))))
(assert (= q2 (set.map f6 (set.filter p5 (set.singleton (tuple (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10017 ms.
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
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_516 Int) (BOUND_VARIABLE_517 Int)) (= BOUND_VARIABLE_516 BOUND_VARIABLE_517)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_516 Int) (BOUND_VARIABLE_517 Int)) (= BOUND_VARIABLE_516 BOUND_VARIABLE_517)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_540 Int) (BOUND_VARIABLE_541 Int)) (= BOUND_VARIABLE_540 BOUND_VARIABLE_541)) ((_ tuple.select 11) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_540 Int) (BOUND_VARIABLE_541 Int)) (= BOUND_VARIABLE_540 BOUND_VARIABLE_541)) ((_ tuple.select 11) t) (nullable.some 10))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_555 Bool) (BOUND_VARIABLE_556 Bool)) (and BOUND_VARIABLE_555 BOUND_VARIABLE_556)) (nullable.lift (lambda ((BOUND_VARIABLE_516 Int) (BOUND_VARIABLE_517 Int)) (= BOUND_VARIABLE_516 BOUND_VARIABLE_517)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_540 Int) (BOUND_VARIABLE_541 Int)) (= BOUND_VARIABLE_540 BOUND_VARIABLE_541)) ((_ tuple.select 11) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_516 Int) (BOUND_VARIABLE_517 Int)) (= BOUND_VARIABLE_516 BOUND_VARIABLE_517)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_516 Int) (BOUND_VARIABLE_517 Int)) (= BOUND_VARIABLE_516 BOUND_VARIABLE_517)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_540 Int) (BOUND_VARIABLE_541 Int)) (= BOUND_VARIABLE_540 BOUND_VARIABLE_541)) ((_ tuple.select 11) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_540 Int) (BOUND_VARIABLE_541 Int)) (= BOUND_VARIABLE_540 BOUND_VARIABLE_541)) ((_ tuple.select 11) t) (nullable.some 10))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_555 Bool) (BOUND_VARIABLE_556 Bool)) (and BOUND_VARIABLE_555 BOUND_VARIABLE_556)) (nullable.lift (lambda ((BOUND_VARIABLE_516 Int) (BOUND_VARIABLE_517 Int)) (= BOUND_VARIABLE_516 BOUND_VARIABLE_517)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_540 Int) (BOUND_VARIABLE_541 Int)) (= BOUND_VARIABLE_540 BOUND_VARIABLE_541)) ((_ tuple.select 11) t) (nullable.some 10))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_578 Int) (BOUND_VARIABLE_579 Int)) (= BOUND_VARIABLE_578 BOUND_VARIABLE_579)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_578 Int) (BOUND_VARIABLE_579 Int)) (= BOUND_VARIABLE_578 BOUND_VARIABLE_579)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_597 Int) (BOUND_VARIABLE_598 Int)) (>= BOUND_VARIABLE_597 BOUND_VARIABLE_598)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_597 Int) (BOUND_VARIABLE_598 Int)) (>= BOUND_VARIABLE_597 BOUND_VARIABLE_598)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_660 Int) (BOUND_VARIABLE_661 Int)) (= BOUND_VARIABLE_660 BOUND_VARIABLE_661)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_660 Int) (BOUND_VARIABLE_661 Int)) (= BOUND_VARIABLE_660 BOUND_VARIABLE_661)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p2 ((_ rel.project 9 1) (set.filter p1 (rel.product EMP (set.map f0 DEPT))))))))
(assert (= q2 ((_ rel.project 9 1) (set.filter p4 (rel.product EMP ((_ rel.project 0 1) (set.filter p3 DEPT)))))))
(check-sat)
;answer: sat
; duration: 654 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some (- 3)) (nullable.some "D") (nullable.some "E") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 11) (nullable.some 6))))
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 11) (nullable.some "F"))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 11) (nullable.some "D")))
; insert into EMP values(-3,'D','E',4,-4,5,-5,11,6)
; insert into DEPT values(11,'F')
; SELECT * FROM (SELECT * FROM (SELECT DEPT.DEPTNO, EMP.ENAME FROM EMP AS EMP INNER JOIN DEPT AS DEPT ON EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = 10) AS t WHERE t.DEPTNO = 10) AS q1 EXCEPT ALL SELECT * FROM (SELECT t1.DEPTNO, EMP0.ENAME FROM EMP AS EMP0 INNER JOIN (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO >= 10) AS t1 ON EMP0.DEPTNO = t1.DEPTNO) AS q2;

; SELECT * FROM (SELECT t1.DEPTNO, EMP0.ENAME FROM EMP AS EMP0 INNER JOIN (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO >= 10) AS t1 ON EMP0.DEPTNO = t1.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT DEPT.DEPTNO, EMP.ENAME FROM EMP AS EMP INNER JOIN DEPT AS DEPT ON EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = 10) AS t WHERE t.DEPTNO = 10) AS q1;
;(11,D)

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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_458 Int) (BOUND_VARIABLE_459 Int)) (= BOUND_VARIABLE_458 BOUND_VARIABLE_459)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_458 Int) (BOUND_VARIABLE_459 Int)) (= BOUND_VARIABLE_458 BOUND_VARIABLE_459)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_479 Int) (BOUND_VARIABLE_480 Int)) (= BOUND_VARIABLE_479 BOUND_VARIABLE_480)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_479 Int) (BOUND_VARIABLE_480 Int)) (= BOUND_VARIABLE_479 BOUND_VARIABLE_480)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_497 Int) (BOUND_VARIABLE_498 Int)) (>= BOUND_VARIABLE_497 BOUND_VARIABLE_498)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_497 Int) (BOUND_VARIABLE_498 Int)) (>= BOUND_VARIABLE_497 BOUND_VARIABLE_498)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_514 Int) (BOUND_VARIABLE_515 Int)) (= BOUND_VARIABLE_514 BOUND_VARIABLE_515)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_514 Int) (BOUND_VARIABLE_515 Int)) (= BOUND_VARIABLE_514 BOUND_VARIABLE_515)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_532 Int) (BOUND_VARIABLE_533 Int)) (= BOUND_VARIABLE_532 BOUND_VARIABLE_533)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_532 Int) (BOUND_VARIABLE_533 Int)) (= BOUND_VARIABLE_532 BOUND_VARIABLE_533)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))
(assert (= q2 (set.union (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))
(check-sat)
;answer: sat
; duration: 127 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some (- 3)) (nullable.some "A") (nullable.some "B") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 19) (nullable.some 6))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some (- 3)) (nullable.some "A") (nullable.some "B") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 19) (nullable.some 6)))
; insert into EMP values(-3,'A','B',4,-4,5,-5,19,6)
; SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 10 UNION SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS q2;

; SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 10 UNION SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS q1;
;(-3,A,B,4,-4,5,-5,19,6)

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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_443 Int) (BOUND_VARIABLE_444 Int)) (= BOUND_VARIABLE_443 BOUND_VARIABLE_444)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_443 Int) (BOUND_VARIABLE_444 Int)) (= BOUND_VARIABLE_443 BOUND_VARIABLE_444)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_465 Bool) (BOUND_VARIABLE_466 Bool) (BOUND_VARIABLE_467 Bool)) (or BOUND_VARIABLE_465 BOUND_VARIABLE_466 BOUND_VARIABLE_467)) (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_443 Int) (BOUND_VARIABLE_444 Int)) (= BOUND_VARIABLE_443 BOUND_VARIABLE_444)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_452 Int) (BOUND_VARIABLE_453 Int)) (> BOUND_VARIABLE_452 BOUND_VARIABLE_453)) ((_ tuple.select 5) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_443 Int) (BOUND_VARIABLE_444 Int)) (= BOUND_VARIABLE_443 BOUND_VARIABLE_444)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_443 Int) (BOUND_VARIABLE_444 Int)) (= BOUND_VARIABLE_443 BOUND_VARIABLE_444)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_465 Bool) (BOUND_VARIABLE_466 Bool) (BOUND_VARIABLE_467 Bool)) (or BOUND_VARIABLE_465 BOUND_VARIABLE_466 BOUND_VARIABLE_467)) (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_443 Int) (BOUND_VARIABLE_444 Int)) (= BOUND_VARIABLE_443 BOUND_VARIABLE_444)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_452 Int) (BOUND_VARIABLE_453 Int)) (> BOUND_VARIABLE_452 BOUND_VARIABLE_453)) ((_ tuple.select 5) t) (nullable.some 10))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_556 Int) (BOUND_VARIABLE_557 Int)) (= BOUND_VARIABLE_556 BOUND_VARIABLE_557)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_556 Int) (BOUND_VARIABLE_557 Int)) (= BOUND_VARIABLE_556 BOUND_VARIABLE_557)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_594 Int) (BOUND_VARIABLE_595 Int)) (>= BOUND_VARIABLE_594 BOUND_VARIABLE_595)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_594 Int) (BOUND_VARIABLE_595 Int)) (>= BOUND_VARIABLE_594 BOUND_VARIABLE_595)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_600 Int) (BOUND_VARIABLE_601 Int)) (= BOUND_VARIABLE_600 BOUND_VARIABLE_601)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_600 Int) (BOUND_VARIABLE_601 Int)) (= BOUND_VARIABLE_600 BOUND_VARIABLE_601)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_619 Bool) (BOUND_VARIABLE_620 Bool) (BOUND_VARIABLE_621 Bool)) (or BOUND_VARIABLE_619 BOUND_VARIABLE_620 BOUND_VARIABLE_621)) (nullable.lift (lambda ((BOUND_VARIABLE_594 Int) (BOUND_VARIABLE_595 Int)) (>= BOUND_VARIABLE_594 BOUND_VARIABLE_595)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_600 Int) (BOUND_VARIABLE_601 Int)) (= BOUND_VARIABLE_600 BOUND_VARIABLE_601)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_607 Int) (BOUND_VARIABLE_608 Int)) (> BOUND_VARIABLE_607 BOUND_VARIABLE_608)) ((_ tuple.select 5) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_594 Int) (BOUND_VARIABLE_595 Int)) (>= BOUND_VARIABLE_594 BOUND_VARIABLE_595)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_594 Int) (BOUND_VARIABLE_595 Int)) (>= BOUND_VARIABLE_594 BOUND_VARIABLE_595)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_600 Int) (BOUND_VARIABLE_601 Int)) (= BOUND_VARIABLE_600 BOUND_VARIABLE_601)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_600 Int) (BOUND_VARIABLE_601 Int)) (= BOUND_VARIABLE_600 BOUND_VARIABLE_601)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_619 Bool) (BOUND_VARIABLE_620 Bool) (BOUND_VARIABLE_621 Bool)) (or BOUND_VARIABLE_619 BOUND_VARIABLE_620 BOUND_VARIABLE_621)) (nullable.lift (lambda ((BOUND_VARIABLE_594 Int) (BOUND_VARIABLE_595 Int)) (>= BOUND_VARIABLE_594 BOUND_VARIABLE_595)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_600 Int) (BOUND_VARIABLE_601 Int)) (= BOUND_VARIABLE_600 BOUND_VARIABLE_601)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_607 Int) (BOUND_VARIABLE_608 Int)) (> BOUND_VARIABLE_607 BOUND_VARIABLE_608)) ((_ tuple.select 5) t) (nullable.some 10))))))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_641 Int) (BOUND_VARIABLE_642 Int)) (= BOUND_VARIABLE_641 BOUND_VARIABLE_642)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_641 Int) (BOUND_VARIABLE_642 Int)) (= BOUND_VARIABLE_641 BOUND_VARIABLE_642)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f2 (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) EMP)))))
(assert (= q2 (set.map f5 (set.filter p4 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) EMP)))))
(check-sat)
;answer: sat
; duration: 235 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some (- 3)) (nullable.some "A") (nullable.some "B") (nullable.some 4) (nullable.some (- 4)) (as nullable.null (Nullable Int)) (nullable.some 5) (nullable.some 8) (nullable.some (- 5)))) (set.singleton (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some (- 1)) (nullable.some 2) (as nullable.null (Nullable Int)) (nullable.some (- 2)) (nullable.some 8) (nullable.some 3)))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 1)))
; insert into EMP values(-3,'A','B',4,-4,NULL,5,8,-5),(0,NULL,'',-1,2,NULL,-2,8,3)
; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 OR EMP.DEPTNO = 9 OR EMP.COMM > 10) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7 OR EMP1.DEPTNO = 9 OR EMP1.COMM > 10) AS t1 INNER JOIN EMP AS EMP2 ON t1.DEPTNO = EMP2.DEPTNO) AS q2;

; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7 OR EMP1.DEPTNO = 9 OR EMP1.COMM > 10) AS t1 INNER JOIN EMP AS EMP2 ON t1.DEPTNO = EMP2.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 OR EMP.DEPTNO = 9 OR EMP.COMM > 10) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO) AS q1;
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_402 Int) (BOUND_VARIABLE_403 Int)) (> BOUND_VARIABLE_402 BOUND_VARIABLE_403)) (nullable.lift (lambda ((BOUND_VARIABLE_393 Int) (BOUND_VARIABLE_394 Int)) (+ BOUND_VARIABLE_393 BOUND_VARIABLE_394)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_402 Int) (BOUND_VARIABLE_403 Int)) (> BOUND_VARIABLE_402 BOUND_VARIABLE_403)) (nullable.lift (lambda ((BOUND_VARIABLE_393 Int) (BOUND_VARIABLE_394 Int)) (+ BOUND_VARIABLE_393 BOUND_VARIABLE_394)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 0)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_452 Int) (BOUND_VARIABLE_453 Int)) (+ BOUND_VARIABLE_452 BOUND_VARIABLE_453)) (nullable.lift (lambda ((BOUND_VARIABLE_446 Int) (BOUND_VARIABLE_447 Int)) (+ BOUND_VARIABLE_446 BOUND_VARIABLE_447)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 0) t))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_487 Int) (BOUND_VARIABLE_488 Int)) (+ BOUND_VARIABLE_487 BOUND_VARIABLE_488)) (nullable.lift (lambda ((BOUND_VARIABLE_481 Int) (BOUND_VARIABLE_482 Int)) (+ BOUND_VARIABLE_481 BOUND_VARIABLE_482)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 0) t))))))
(assert (= q1 (set.map f1 (set.filter p0 (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 30) (nullable.some 3))))))))
(assert (= q2 (set.map f3 (set.filter p2 (set.singleton (tuple (nullable.some 0) (nullable.some 0)))))))
(check-sat)
;answer: sat
; duration: 19 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (set.union (set.singleton (tuple (nullable.some 21))) (set.singleton (tuple (nullable.some 63))))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; SELECT * FROM (SELECT t.column1 + t.column2 + t.column1 FROM (VALUES  (10, 1),  (30, 3)) AS t WHERE t.column1 + t.column2 > 0) AS q1 EXCEPT ALL SELECT * FROM (SELECT t3.column1 + t3.column2 + t3.column1 FROM (SELECT * FROM (VALUES(0,0)) WHERE FALSE) AS t3) AS q2;
;(63)
;(21)

; SELECT * FROM (SELECT t3.column1 + t3.column2 + t3.column1 FROM (SELECT * FROM (VALUES(0,0)) WHERE FALSE) AS t3) AS q2 EXCEPT ALL SELECT * FROM (SELECT t.column1 + t.column2 + t.column1 FROM (VALUES  (10, 1),  (30, 3)) AS t WHERE t.column1 + t.column2 > 0) AS q1;

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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_443 Int) (BOUND_VARIABLE_444 Int)) (= BOUND_VARIABLE_443 BOUND_VARIABLE_444)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_443 Int) (BOUND_VARIABLE_444 Int)) (= BOUND_VARIABLE_443 BOUND_VARIABLE_444)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_464 Bool) (BOUND_VARIABLE_465 Bool) (BOUND_VARIABLE_466 Bool)) (or BOUND_VARIABLE_464 BOUND_VARIABLE_465 BOUND_VARIABLE_466)) (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_443 Int) (BOUND_VARIABLE_444 Int)) (= BOUND_VARIABLE_443 BOUND_VARIABLE_444)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_451 Int) (BOUND_VARIABLE_452 Int)) (> BOUND_VARIABLE_451 BOUND_VARIABLE_452)) ((_ tuple.select 7) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_443 Int) (BOUND_VARIABLE_444 Int)) (= BOUND_VARIABLE_443 BOUND_VARIABLE_444)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_443 Int) (BOUND_VARIABLE_444 Int)) (= BOUND_VARIABLE_443 BOUND_VARIABLE_444)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_464 Bool) (BOUND_VARIABLE_465 Bool) (BOUND_VARIABLE_466 Bool)) (or BOUND_VARIABLE_464 BOUND_VARIABLE_465 BOUND_VARIABLE_466)) (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_443 Int) (BOUND_VARIABLE_444 Int)) (= BOUND_VARIABLE_443 BOUND_VARIABLE_444)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_451 Int) (BOUND_VARIABLE_452 Int)) (> BOUND_VARIABLE_451 BOUND_VARIABLE_452)) ((_ tuple.select 7) t) (nullable.some 10))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (>= BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (>= BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_599 Int) (BOUND_VARIABLE_600 Int)) (= BOUND_VARIABLE_599 BOUND_VARIABLE_600)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_599 Int) (BOUND_VARIABLE_600 Int)) (= BOUND_VARIABLE_599 BOUND_VARIABLE_600)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_617 Bool) (BOUND_VARIABLE_618 Bool) (BOUND_VARIABLE_619 Bool)) (or BOUND_VARIABLE_617 BOUND_VARIABLE_618 BOUND_VARIABLE_619)) (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (>= BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_599 Int) (BOUND_VARIABLE_600 Int)) (= BOUND_VARIABLE_599 BOUND_VARIABLE_600)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_605 Int) (BOUND_VARIABLE_606 Int)) (> BOUND_VARIABLE_605 BOUND_VARIABLE_606)) ((_ tuple.select 7) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (>= BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (>= BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_599 Int) (BOUND_VARIABLE_600 Int)) (= BOUND_VARIABLE_599 BOUND_VARIABLE_600)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_599 Int) (BOUND_VARIABLE_600 Int)) (= BOUND_VARIABLE_599 BOUND_VARIABLE_600)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_617 Bool) (BOUND_VARIABLE_618 Bool) (BOUND_VARIABLE_619 Bool)) (or BOUND_VARIABLE_617 BOUND_VARIABLE_618 BOUND_VARIABLE_619)) (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (>= BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_599 Int) (BOUND_VARIABLE_600 Int)) (= BOUND_VARIABLE_599 BOUND_VARIABLE_600)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_605 Int) (BOUND_VARIABLE_606 Int)) (> BOUND_VARIABLE_605 BOUND_VARIABLE_606)) ((_ tuple.select 7) t) (nullable.some 10))))))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_637 Int) (BOUND_VARIABLE_638 Int)) (>= BOUND_VARIABLE_637 BOUND_VARIABLE_638)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_637 Int) (BOUND_VARIABLE_638 Int)) (>= BOUND_VARIABLE_637 BOUND_VARIABLE_638)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_643 Int) (BOUND_VARIABLE_644 Int)) (= BOUND_VARIABLE_643 BOUND_VARIABLE_644)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_643 Int) (BOUND_VARIABLE_644 Int)) (= BOUND_VARIABLE_643 BOUND_VARIABLE_644)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_661 Bool) (BOUND_VARIABLE_662 Bool) (BOUND_VARIABLE_663 Bool)) (or BOUND_VARIABLE_661 BOUND_VARIABLE_662 BOUND_VARIABLE_663)) (nullable.lift (lambda ((BOUND_VARIABLE_637 Int) (BOUND_VARIABLE_638 Int)) (>= BOUND_VARIABLE_637 BOUND_VARIABLE_638)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_643 Int) (BOUND_VARIABLE_644 Int)) (= BOUND_VARIABLE_643 BOUND_VARIABLE_644)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_649 Int) (BOUND_VARIABLE_650 Int)) (> BOUND_VARIABLE_649 BOUND_VARIABLE_650)) ((_ tuple.select 7) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_637 Int) (BOUND_VARIABLE_638 Int)) (>= BOUND_VARIABLE_637 BOUND_VARIABLE_638)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_637 Int) (BOUND_VARIABLE_638 Int)) (>= BOUND_VARIABLE_637 BOUND_VARIABLE_638)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_643 Int) (BOUND_VARIABLE_644 Int)) (= BOUND_VARIABLE_643 BOUND_VARIABLE_644)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_643 Int) (BOUND_VARIABLE_644 Int)) (= BOUND_VARIABLE_643 BOUND_VARIABLE_644)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_661 Bool) (BOUND_VARIABLE_662 Bool) (BOUND_VARIABLE_663 Bool)) (or BOUND_VARIABLE_661 BOUND_VARIABLE_662 BOUND_VARIABLE_663)) (nullable.lift (lambda ((BOUND_VARIABLE_637 Int) (BOUND_VARIABLE_638 Int)) (>= BOUND_VARIABLE_637 BOUND_VARIABLE_638)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_643 Int) (BOUND_VARIABLE_644 Int)) (= BOUND_VARIABLE_643 BOUND_VARIABLE_644)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_649 Int) (BOUND_VARIABLE_650 Int)) (> BOUND_VARIABLE_649 BOUND_VARIABLE_650)) ((_ tuple.select 7) t) (nullable.some 10))))))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_683 Int) (BOUND_VARIABLE_684 Int)) (= BOUND_VARIABLE_683 BOUND_VARIABLE_684)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_683 Int) (BOUND_VARIABLE_684 Int)) (= BOUND_VARIABLE_683 BOUND_VARIABLE_684)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f2 (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) EMP)))))
(assert (= q2 (set.map f6 (set.filter p5 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)))))))
(check-sat)
;answer: sat
; duration: 353 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some 4) (nullable.some "A") (nullable.some "B") (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (nullable.some 8) (nullable.some (- 6)))) (set.singleton (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some 8) (nullable.some (- 3))))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 1)))
; insert into EMP values(4,'A','B',-4,5,-5,6,8,-6),(0,NULL,'',-1,2,-2,3,8,-3)
; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 OR EMP.DEPTNO = 9 OR EMP.DEPTNO > 10) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7 OR EMP1.DEPTNO = 9 OR EMP1.DEPTNO > 10) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 7 OR EMP2.DEPTNO = 9 OR EMP2.DEPTNO > 10) AS t2 ON t1.DEPTNO = t2.DEPTNO) AS q2;

; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7 OR EMP1.DEPTNO = 9 OR EMP1.DEPTNO > 10) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 7 OR EMP2.DEPTNO = 9 OR EMP2.DEPTNO > 10) AS t2 ON t1.DEPTNO = t2.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 OR EMP.DEPTNO = 9 OR EMP.DEPTNO > 10) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO) AS q1;
;(1)
;(1)
;(1)
;(1)

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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_466 Int) (BOUND_VARIABLE_467 Int)) (> BOUND_VARIABLE_466 BOUND_VARIABLE_467)) (nullable.lift (lambda ((BOUND_VARIABLE_458 Int) (BOUND_VARIABLE_459 Int)) (+ BOUND_VARIABLE_458 BOUND_VARIABLE_459)) ((_ tuple.select 7) t) (nullable.some 5)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_466 Int) (BOUND_VARIABLE_467 Int)) (> BOUND_VARIABLE_466 BOUND_VARIABLE_467)) (nullable.lift (lambda ((BOUND_VARIABLE_458 Int) (BOUND_VARIABLE_459 Int)) (+ BOUND_VARIABLE_458 BOUND_VARIABLE_459)) ((_ tuple.select 7) t) (nullable.some 5)) ((_ tuple.select 0) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_483 Int) (BOUND_VARIABLE_484 Int)) (= BOUND_VARIABLE_483 BOUND_VARIABLE_484)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_483 Int) (BOUND_VARIABLE_484 Int)) (= BOUND_VARIABLE_483 BOUND_VARIABLE_484)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (>= BOUND_VARIABLE_502 BOUND_VARIABLE_503)) (nullable.some 15) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (>= BOUND_VARIABLE_502 BOUND_VARIABLE_503)) (nullable.some 15) ((_ tuple.select 0) t)))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP))))))
(check-sat)
;answer: sat
; duration: 141 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 15) (nullable.some "C") (nullable.some "D") (nullable.some (- 5)) (nullable.some 6) (nullable.some (- 6)) (nullable.some 7) (nullable.some 10) (nullable.some (- 7)))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 15) (nullable.some "C") (nullable.some "D") (nullable.some (- 5)) (nullable.some 6) (nullable.some (- 6)) (nullable.some 7) (nullable.some 10) (nullable.some (- 7))))
; insert into EMP values(15,'C','D',-5,6,-6,7,10,-7)
; SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10) AS t WHERE t.DEPTNO + 5 > t.EMPNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 10) AS t1 WHERE 15 >= t1.EMPNO) AS q2;

; SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 10) AS t1 WHERE 15 >= t1.EMPNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10) AS t WHERE t.DEPTNO + 5 > t.EMPNO) AS q1;
;(15,C,D,-5,6,-6,7,10,-7)

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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (> BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 5) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (> BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 5) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_536 Int) (BOUND_VARIABLE_537 Int)) (>= BOUND_VARIABLE_536 BOUND_VARIABLE_537)) ((_ tuple.select 5) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_536 Int) (BOUND_VARIABLE_537 Int)) (>= BOUND_VARIABLE_536 BOUND_VARIABLE_537)) ((_ tuple.select 5) t) (nullable.some 7)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_553 Int) (BOUND_VARIABLE_554 Int)) (>= BOUND_VARIABLE_553 BOUND_VARIABLE_554)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_553 Int) (BOUND_VARIABLE_554 Int)) (>= BOUND_VARIABLE_553 BOUND_VARIABLE_554)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f2 (set.filter p1 (rel.product ((_ rel.project 5) (set.filter p0 EMP)) EMP)))))
(assert (= q2 (set.map f6 (set.filter p5 (rel.product ((_ rel.project 5) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)))))))
(check-sat)
;answer: sat
; duration: 234 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some (- 3)) (nullable.some "A") (nullable.some "B") (nullable.some 4) (nullable.some (- 4)) (nullable.some 7) (nullable.some 5) (nullable.some 7) (nullable.some (- 5)))) (set.singleton (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some (- 1)) (nullable.some 2) (as nullable.null (Nullable Int)) (nullable.some (- 2)) (nullable.some 7) (nullable.some 3)))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 1)))
; insert into EMP values(-3,'A','B',4,-4,7,5,7,-5),(0,NULL,'',-1,2,NULL,-2,7,3)
; SELECT * FROM (SELECT 1 FROM (SELECT EMP.COMM AS DEPTNO FROM EMP AS EMP WHERE EMP.COMM > 7) AS t0 INNER JOIN EMP AS EMP0 ON t0.DEPTNO = EMP0.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT EMP1.COMM AS DEPTNO FROM EMP AS EMP1 WHERE EMP1.COMM >= 7) AS t3 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 7) AS t4 ON t3.DEPTNO = t4.DEPTNO) AS q2;

; SELECT * FROM (SELECT 1 FROM (SELECT EMP1.COMM AS DEPTNO FROM EMP AS EMP1 WHERE EMP1.COMM >= 7) AS t3 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 7) AS t4 ON t3.DEPTNO = t4.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT EMP.COMM AS DEPTNO FROM EMP AS EMP WHERE EMP.COMM > 7) AS t0 INNER JOIN EMP AS EMP0 ON t0.DEPTNO = EMP0.DEPTNO) AS q1;
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_458 Int) (BOUND_VARIABLE_459 Int)) (= BOUND_VARIABLE_458 BOUND_VARIABLE_459)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_458 Int) (BOUND_VARIABLE_459 Int)) (= BOUND_VARIABLE_458 BOUND_VARIABLE_459)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_477 Int) (BOUND_VARIABLE_478 Int)) (= BOUND_VARIABLE_477 BOUND_VARIABLE_478)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_477 Int) (BOUND_VARIABLE_478 Int)) (= BOUND_VARIABLE_477 BOUND_VARIABLE_478)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_497 Int) (BOUND_VARIABLE_498 Int)) (>= BOUND_VARIABLE_497 BOUND_VARIABLE_498)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_497 Int) (BOUND_VARIABLE_498 Int)) (>= BOUND_VARIABLE_497 BOUND_VARIABLE_498)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_514 Int) (BOUND_VARIABLE_515 Int)) (= BOUND_VARIABLE_514 BOUND_VARIABLE_515)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_514 Int) (BOUND_VARIABLE_515 Int)) (= BOUND_VARIABLE_514 BOUND_VARIABLE_515)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_531 Int) (BOUND_VARIABLE_532 Int)) (= BOUND_VARIABLE_531 BOUND_VARIABLE_532)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_531 Int) (BOUND_VARIABLE_532 Int)) (= BOUND_VARIABLE_531 BOUND_VARIABLE_532)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.inter ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))))
(assert (= q2 (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.inter ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))))
(check-sat)
;answer: sat
; duration: 90 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 10) (nullable.some "E") (nullable.some "F") (nullable.some (- 10)) (nullable.some 11) (nullable.some (- 11)) (nullable.some 12) (nullable.some 30) (nullable.some (- 12)))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 10) (nullable.some "E") (nullable.some "F") (nullable.some (- 10)) (nullable.some 11) (nullable.some (- 11)) (nullable.some 12) (nullable.some 30) (nullable.some (- 12))))
; insert into EMP values(10,'E','F',-10,11,-11,12,30,-12)
; SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS t2) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 10 UNION SELECT * FROM (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS t7) AS q2;

; SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 10 UNION SELECT * FROM (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS t7) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS t2) AS q1;
;(10,E,F,-10,11,-11,12,30,-12)

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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (ite (and (nullable.is_some (nullable.some (nullable.is_some ((_ tuple.select 0) t)))) (not (nullable.val (nullable.some (nullable.is_some ((_ tuple.select 0) t)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_453 Bool) (BOUND_VARIABLE_454 Bool)) (and BOUND_VARIABLE_453 BOUND_VARIABLE_454)) (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some (nullable.is_some ((_ tuple.select 0) t))))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (ite (and (nullable.is_some (nullable.some (nullable.is_some ((_ tuple.select 0) t)))) (not (nullable.val (nullable.some (nullable.is_some ((_ tuple.select 0) t)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_453 Bool) (BOUND_VARIABLE_454 Bool)) (and BOUND_VARIABLE_453 BOUND_VARIABLE_454)) (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some (nullable.is_some ((_ tuple.select 0) t)))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_488 Int) (BOUND_VARIABLE_489 Int)) (>= BOUND_VARIABLE_488 BOUND_VARIABLE_489)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_488 Int) (BOUND_VARIABLE_489 Int)) (>= BOUND_VARIABLE_488 BOUND_VARIABLE_489)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= q1 ((_ rel.project 0) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0) (set.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 68 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 11) (nullable.some "A") (nullable.some "B") (nullable.some (- 3)) (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 11)))
; insert into EMP values(11,'A','B',-3,4,-4,5,-5,6)
; SELECT * FROM (SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND EMP.EMPNO IS NOT NULL) AS q1 EXCEPT ALL SELECT * FROM (SELECT EMP0.EMPNO FROM EMP AS EMP0 WHERE EMP0.EMPNO >= 10) AS q2;

; SELECT * FROM (SELECT EMP0.EMPNO FROM EMP AS EMP0 WHERE EMP0.EMPNO >= 10) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.EMPNO FROM EMP AS EMP WHERE EMP.EMPNO = 10 AND EMP.EMPNO IS NOT NULL) AS q1;
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_395 Int) (BOUND_VARIABLE_396 Int)) (>= BOUND_VARIABLE_395 BOUND_VARIABLE_396)) ((_ tuple.select 0) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_395 Int) (BOUND_VARIABLE_396 Int)) (>= BOUND_VARIABLE_395 BOUND_VARIABLE_396)) ((_ tuple.select 0) t) (nullable.some 50)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= q1 (set.inter ((_ rel.project 0 1) (set.inter ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 50) (nullable.some 3)))) ((_ rel.project 0 1) (set.filter p0 (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 50) (nullable.some 3)))))))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 50) (nullable.some 3)))))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p1 (set.singleton (tuple (nullable.some 0) (nullable.some 0)))))))
(check-sat)
;answer: sat
; duration: 11 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 50) (nullable.some 3)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable Int))))
; SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES  (50, 3)) AS t INTERSECT SELECT * FROM (VALUES  (10, 1),  (50, 3)) AS t0 WHERE t0.column1 >= 50) AS t2 INTERSECT SELECT * FROM (VALUES  (50, 3)) AS t3) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES(0,0)) WHERE FALSE) AS t5) AS q2;
;(50,3)

; SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES(0,0)) WHERE FALSE) AS t5) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES  (50, 3)) AS t INTERSECT SELECT * FROM (VALUES  (10, 1),  (50, 3)) AS t0 WHERE t0.column1 >= 50) AS t2 INTERSECT SELECT * FROM (VALUES  (50, 3)) AS t3) AS q1;

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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 7) t) (nullable.lift (lambda ((BOUND_VARIABLE_471 Int) (BOUND_VARIABLE_472 Int)) (+ BOUND_VARIABLE_471 BOUND_VARIABLE_472)) ((_ tuple.select 7) t) (nullable.some 1)) (nullable.lift (lambda ((BOUND_VARIABLE_479 Int) (BOUND_VARIABLE_480 Int)) (+ BOUND_VARIABLE_479 BOUND_VARIABLE_480)) ((_ tuple.select 0) t) ((_ tuple.select 7) t))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_495 Int) (BOUND_VARIABLE_496 Int)) (= BOUND_VARIABLE_495 BOUND_VARIABLE_496)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_495 Int) (BOUND_VARIABLE_496 Int)) (= BOUND_VARIABLE_495 BOUND_VARIABLE_496)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 11) (nullable.some 11) (nullable.lift (lambda ((BOUND_VARIABLE_513 Int) (BOUND_VARIABLE_514 Int)) (+ BOUND_VARIABLE_513 BOUND_VARIABLE_514)) ((_ tuple.select 0) t) (nullable.some 10))))))
(assert (= q1 (set.map f1 (set.filter p0 EMP))))
(assert (= q2 (set.map f3 (set.filter p2 EMP))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10011 ms.
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (< BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 7) t) (nullable.some 4))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (< BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 7) t) (nullable.some 4)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_469 Int) (BOUND_VARIABLE_470 Int)) (> BOUND_VARIABLE_469 BOUND_VARIABLE_470)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_469 Int) (BOUND_VARIABLE_470 Int)) (> BOUND_VARIABLE_469 BOUND_VARIABLE_470)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_505 Int) (BOUND_VARIABLE_506 Int)) (= BOUND_VARIABLE_505 BOUND_VARIABLE_506)) ((_ tuple.select 0) t) ((_ tuple.select 1) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_505 Int) (BOUND_VARIABLE_506 Int)) (= BOUND_VARIABLE_505 BOUND_VARIABLE_506)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_524 Int) (BOUND_VARIABLE_525 Int)) (>= BOUND_VARIABLE_524 BOUND_VARIABLE_525)) ((_ tuple.select 7) t) (nullable.some 4))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_524 Int) (BOUND_VARIABLE_525 Int)) (>= BOUND_VARIABLE_524 BOUND_VARIABLE_525)) ((_ tuple.select 7) t) (nullable.some 4)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_541 Int) (BOUND_VARIABLE_542 Int)) (>= BOUND_VARIABLE_541 BOUND_VARIABLE_542)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_541 Int) (BOUND_VARIABLE_542 Int)) (>= BOUND_VARIABLE_541 BOUND_VARIABLE_542)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (< BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 0) t) (nullable.some 4))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (< BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 0) t) (nullable.some 4)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_580 Int) (BOUND_VARIABLE_581 Int)) (= BOUND_VARIABLE_580 BOUND_VARIABLE_581)) ((_ tuple.select 0) t) ((_ tuple.select 1) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_580 Int) (BOUND_VARIABLE_581 Int)) (= BOUND_VARIABLE_580 BOUND_VARIABLE_581)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p2 (rel.product ((_ rel.project 7) (set.filter p0 EMP)) (set.union ((_ rel.project 7) (set.filter p1 EMP)) ((_ rel.project 7) EMP)))))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p6 (rel.product ((_ rel.project 7) (set.filter p3 EMP)) ((_ rel.project 0) (set.filter p5 (set.union ((_ rel.project 7) (set.filter p4 EMP)) ((_ rel.project 7) EMP)))))))))
(check-sat)
;answer: sat
; duration: 388 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some 7) (nullable.some "C") (nullable.some "D") (nullable.some (- 7)) (nullable.some 8) (nullable.some (- 8)) (nullable.some 9) (nullable.some 3) (nullable.some (- 9)))) (set.singleton (tuple (nullable.some 4) (nullable.some "A") (nullable.some "B") (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (nullable.some 3) (nullable.some (- 6))))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 3) (nullable.some 3)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable Int))))
; insert into EMP values(7,'C','D',-7,8,-8,9,3,-9),(4,'A','B',-4,5,-5,6,3,-6)
; SELECT * FROM (SELECT * FROM (SELECT EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO < 4) AS t0 INNER JOIN (SELECT EMP0.DEPTNO FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 7 UNION ALL SELECT EMP1.DEPTNO FROM EMP AS EMP1) AS t4 ON t0.DEPTNO = t4.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT EMP2.DEPTNO FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 4) AS t6 INNER JOIN (SELECT * FROM (SELECT EMP3.DEPTNO FROM EMP AS EMP3 WHERE EMP3.DEPTNO >= 7 UNION ALL SELECT EMP4.DEPTNO FROM EMP AS EMP4) AS t10 WHERE t10.DEPTNO < 4) AS t11 ON t6.DEPTNO = t11.DEPTNO) AS q2;
;(3,3)
;(3,3)
;(3,3)
;(3,3)

; SELECT * FROM (SELECT * FROM (SELECT EMP2.DEPTNO FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 4) AS t6 INNER JOIN (SELECT * FROM (SELECT EMP3.DEPTNO FROM EMP AS EMP3 WHERE EMP3.DEPTNO >= 7 UNION ALL SELECT EMP4.DEPTNO FROM EMP AS EMP4) AS t10 WHERE t10.DEPTNO < 4) AS t11 ON t6.DEPTNO = t11.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO < 4) AS t0 INNER JOIN (SELECT EMP0.DEPTNO FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 7 UNION ALL SELECT EMP1.DEPTNO FROM EMP AS EMP1) AS t4 ON t0.DEPTNO = t4.DEPTNO) AS q1;

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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (>= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (>= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_458 Int) (BOUND_VARIABLE_459 Int)) (= BOUND_VARIABLE_458 BOUND_VARIABLE_459)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_458 Int) (BOUND_VARIABLE_459 Int)) (= BOUND_VARIABLE_458 BOUND_VARIABLE_459)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_479 Int) (BOUND_VARIABLE_480 Int)) (>= BOUND_VARIABLE_479 BOUND_VARIABLE_480)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_479 Int) (BOUND_VARIABLE_480 Int)) (>= BOUND_VARIABLE_479 BOUND_VARIABLE_480)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_497 Int) (BOUND_VARIABLE_498 Int)) (= BOUND_VARIABLE_497 BOUND_VARIABLE_498)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_497 Int) (BOUND_VARIABLE_498 Int)) (= BOUND_VARIABLE_497 BOUND_VARIABLE_498)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_514 Int) (BOUND_VARIABLE_515 Int)) (= BOUND_VARIABLE_514 BOUND_VARIABLE_515)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_514 Int) (BOUND_VARIABLE_515 Int)) (= BOUND_VARIABLE_514 BOUND_VARIABLE_515)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_532 Int) (BOUND_VARIABLE_533 Int)) (= BOUND_VARIABLE_532 BOUND_VARIABLE_533)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_532 Int) (BOUND_VARIABLE_533 Int)) (= BOUND_VARIABLE_532 BOUND_VARIABLE_533)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (set.inter ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.inter ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))
(assert (= q2 (set.inter (set.inter ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))
(check-sat)
;answer: sat
; duration: 94 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some (- 6)) (nullable.some "C") (nullable.some "D") (nullable.some 7) (nullable.some (- 7)) (nullable.some 8) (nullable.some (- 8)) (nullable.some 30) (nullable.some 9))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some (- 6)) (nullable.some "C") (nullable.some "D") (nullable.some 7) (nullable.some (- 7)) (nullable.some 8) (nullable.some (- 8)) (nullable.some 30) (nullable.some 9)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; insert into EMP values(-6,'C','D',7,-7,8,-8,30,9)
; SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO >= 10 INTERSECT SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 30) AS t1 INTERSECT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 20) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 INTERSECT SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS q2;
;(-6,C,D,7,-7,8,-8,30,9)

; SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 INTERSECT SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO >= 10 INTERSECT SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 30) AS t1 INTERSECT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 20) AS q1;

;Model soundness: true
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_482 Int) (BOUND_VARIABLE_483 Int)) (= BOUND_VARIABLE_482 BOUND_VARIABLE_483)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_482 Int) (BOUND_VARIABLE_483 Int)) (= BOUND_VARIABLE_482 BOUND_VARIABLE_483)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_507 String) (BOUND_VARIABLE_508 String)) (= BOUND_VARIABLE_507 BOUND_VARIABLE_508)) ((_ tuple.select 1) t) (nullable.some "foo"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_507 String) (BOUND_VARIABLE_508 String)) (= BOUND_VARIABLE_507 BOUND_VARIABLE_508)) ((_ tuple.select 1) t) (nullable.some "foo"))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_523 Bool) (BOUND_VARIABLE_524 Bool)) (and BOUND_VARIABLE_523 BOUND_VARIABLE_524)) (nullable.lift (lambda ((BOUND_VARIABLE_482 Int) (BOUND_VARIABLE_483 Int)) (= BOUND_VARIABLE_482 BOUND_VARIABLE_483)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_507 String) (BOUND_VARIABLE_508 String)) (= BOUND_VARIABLE_507 BOUND_VARIABLE_508)) ((_ tuple.select 1) t) (nullable.some "foo")))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_482 Int) (BOUND_VARIABLE_483 Int)) (= BOUND_VARIABLE_482 BOUND_VARIABLE_483)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_482 Int) (BOUND_VARIABLE_483 Int)) (= BOUND_VARIABLE_482 BOUND_VARIABLE_483)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_507 String) (BOUND_VARIABLE_508 String)) (= BOUND_VARIABLE_507 BOUND_VARIABLE_508)) ((_ tuple.select 1) t) (nullable.some "foo"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_507 String) (BOUND_VARIABLE_508 String)) (= BOUND_VARIABLE_507 BOUND_VARIABLE_508)) ((_ tuple.select 1) t) (nullable.some "foo"))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_523 Bool) (BOUND_VARIABLE_524 Bool)) (and BOUND_VARIABLE_523 BOUND_VARIABLE_524)) (nullable.lift (lambda ((BOUND_VARIABLE_482 Int) (BOUND_VARIABLE_483 Int)) (= BOUND_VARIABLE_482 BOUND_VARIABLE_483)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_507 String) (BOUND_VARIABLE_508 String)) (= BOUND_VARIABLE_507 BOUND_VARIABLE_508)) ((_ tuple.select 1) t) (nullable.some "foo"))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_560 String) (BOUND_VARIABLE_561 String)) (= BOUND_VARIABLE_560 BOUND_VARIABLE_561)) ((_ tuple.select 1) t) (nullable.some "fo0"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_560 String) (BOUND_VARIABLE_561 String)) (= BOUND_VARIABLE_560 BOUND_VARIABLE_561)) ((_ tuple.select 1) t) (nullable.some "fo0")))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_581 Int) (BOUND_VARIABLE_582 Int)) (= BOUND_VARIABLE_581 BOUND_VARIABLE_582)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_581 Int) (BOUND_VARIABLE_582 Int)) (= BOUND_VARIABLE_581 BOUND_VARIABLE_582)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ rel.project 1) (set.filter p0 (rel.product EMP DEPT)))))
(assert (= q2 ((_ rel.project 1) (set.filter p2 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)) DEPT)))))
(check-sat)
;answer: sat
; duration: 71 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 0) (nullable.some "A"))))
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 1) (nullable.some "foo") (nullable.some "") (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some 0) (nullable.some (- 3)))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some "foo")))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable String))))
; insert into DEPT values(0,'A')
; insert into EMP values(1,'foo','',-1,2,-2,3,0,-3)
; SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME = 'foo') AS q1 EXCEPT ALL SELECT * FROM (SELECT t1.ENAME FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.ENAME = 'fo0') AS t1 INNER JOIN DEPT AS DEPT0 ON t1.DEPTNO = DEPT0.DEPTNO) AS q2;
;(foo)

; SELECT * FROM (SELECT t1.ENAME FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.ENAME = 'fo0') AS t1 INNER JOIN DEPT AS DEPT0 ON t1.DEPTNO = DEPT0.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME = 'foo') AS q1;

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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const rightJoin1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_482 Int) (BOUND_VARIABLE_483 Int)) (= BOUND_VARIABLE_482 BOUND_VARIABLE_483)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_482 Int) (BOUND_VARIABLE_483 Int)) (= BOUND_VARIABLE_482 BOUND_VARIABLE_483)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_541 String) (BOUND_VARIABLE_542 String)) (= BOUND_VARIABLE_541 BOUND_VARIABLE_542)) ((_ tuple.select 1) t) (nullable.some "Charli"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_541 String) (BOUND_VARIABLE_542 String)) (= BOUND_VARIABLE_541 BOUND_VARIABLE_542)) ((_ tuple.select 1) t) (nullable.some "Charli")))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_581 String) (BOUND_VARIABLE_582 String)) (= BOUND_VARIABLE_581 BOUND_VARIABLE_582)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_581 String) (BOUND_VARIABLE_582 String)) (= BOUND_VARIABLE_581 BOUND_VARIABLE_582)) ((_ tuple.select 1) t) (nullable.some "Charlie")))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_602 Int) (BOUND_VARIABLE_603 Int)) (= BOUND_VARIABLE_602 BOUND_VARIABLE_603)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_602 Int) (BOUND_VARIABLE_603 Int)) (= BOUND_VARIABLE_602 BOUND_VARIABLE_603)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f3 (set.filter p2 (set.union (set.map rightJoin1 (set.minus EMP ((_ rel.project 2 3 4 5 6 7 8 9 10) (set.filter p0 (rel.product DEPT EMP))))) (set.filter p0 (rel.product DEPT EMP)))))))
(assert (= q2 (set.map f6 (set.filter p5 (rel.product ((_ rel.project 0 1) (set.filter p4 DEPT)) EMP)))))
(check-sat)
;answer: sat
; duration: 166 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.union (set.singleton (tuple (nullable.some 0) (as nullable.null (Nullable String)))) (set.singleton (tuple (nullable.some 0) (nullable.some "Charlie")))))
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some (- 1)) (nullable.some "") (nullable.some "A") (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some (- 3)) (nullable.some 0) (nullable.some 4))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 1)))
; insert into DEPT values(0,NULL),(0,'Charlie')
; insert into EMP values(-1,'','A',2,-2,3,-3,0,4)
; SELECT * FROM (SELECT 1 FROM DEPT AS DEPT RIGHT JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charli') AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 INNER JOIN EMP AS EMP0 ON t1.DEPTNO = EMP0.DEPTNO) AS q2;

; SELECT * FROM (SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 INNER JOIN EMP AS EMP0 ON t1.DEPTNO = EMP0.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM DEPT AS DEPT RIGHT JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charli') AS q1;
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_499 Int) (BOUND_VARIABLE_500 Int)) (>= BOUND_VARIABLE_499 BOUND_VARIABLE_500)) (nullable.lift (lambda ((BOUND_VARIABLE_483 Int) (BOUND_VARIABLE_484 Int)) (+ BOUND_VARIABLE_483 BOUND_VARIABLE_484)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (* BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 9) t) (nullable.some 2)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_499 Int) (BOUND_VARIABLE_500 Int)) (>= BOUND_VARIABLE_499 BOUND_VARIABLE_500)) (nullable.lift (lambda ((BOUND_VARIABLE_483 Int) (BOUND_VARIABLE_484 Int)) (+ BOUND_VARIABLE_483 BOUND_VARIABLE_484)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (* BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 9) t) (nullable.some 2))))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (nullable.lift (lambda ((BOUND_VARIABLE_569 Int) (BOUND_VARIABLE_570 Int)) (+ BOUND_VARIABLE_569 BOUND_VARIABLE_570)) ((_ tuple.select 0) t) (nullable.some 10))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 6) t) ((_ tuple.select 5) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_633 Int) (BOUND_VARIABLE_634 Int)) (* BOUND_VARIABLE_633 BOUND_VARIABLE_634)) ((_ tuple.select 7) t) (nullable.some 2))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_701 Int) (BOUND_VARIABLE_702 Int)) (= BOUND_VARIABLE_701 BOUND_VARIABLE_702)) ((_ tuple.select 2) t) ((_ tuple.select 12) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_701 Int) (BOUND_VARIABLE_702 Int)) (= BOUND_VARIABLE_701 BOUND_VARIABLE_702)) ((_ tuple.select 2) t) ((_ tuple.select 12) t)))))))
(assert (= q1 ((_ rel.project 0 9) (set.filter p0 (rel.product DEPT EMP)))))
(assert (= q2 ((_ rel.project 0 10) (set.filter p3 (rel.product (set.map f1 DEPT) (set.map f2 EMP))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10021 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_554 Int) (BOUND_VARIABLE_555 Int)) (= BOUND_VARIABLE_554 BOUND_VARIABLE_555)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_554 Int) (BOUND_VARIABLE_555 Int)) (= BOUND_VARIABLE_554 BOUND_VARIABLE_555)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_577 Int) (BOUND_VARIABLE_578 Int)) (= BOUND_VARIABLE_577 BOUND_VARIABLE_578)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_577 Int) (BOUND_VARIABLE_578 Int)) (= BOUND_VARIABLE_577 BOUND_VARIABLE_578)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_602 Bool) (BOUND_VARIABLE_603 Bool) (BOUND_VARIABLE_604 Bool)) (and BOUND_VARIABLE_602 BOUND_VARIABLE_603 BOUND_VARIABLE_604)) (nullable.lift (lambda ((BOUND_VARIABLE_554 Int) (BOUND_VARIABLE_555 Int)) (= BOUND_VARIABLE_554 BOUND_VARIABLE_555)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_577 Int) (BOUND_VARIABLE_578 Int)) (= BOUND_VARIABLE_577 BOUND_VARIABLE_578)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)) (nullable.lift (lambda ((BOUND_VARIABLE_586 String) (BOUND_VARIABLE_587 String)) (= BOUND_VARIABLE_586 BOUND_VARIABLE_587)) ((_ tuple.select 10) t) (nullable.some "foo")))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_554 Int) (BOUND_VARIABLE_555 Int)) (= BOUND_VARIABLE_554 BOUND_VARIABLE_555)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_554 Int) (BOUND_VARIABLE_555 Int)) (= BOUND_VARIABLE_554 BOUND_VARIABLE_555)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_577 Int) (BOUND_VARIABLE_578 Int)) (= BOUND_VARIABLE_577 BOUND_VARIABLE_578)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_577 Int) (BOUND_VARIABLE_578 Int)) (= BOUND_VARIABLE_577 BOUND_VARIABLE_578)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_602 Bool) (BOUND_VARIABLE_603 Bool) (BOUND_VARIABLE_604 Bool)) (and BOUND_VARIABLE_602 BOUND_VARIABLE_603 BOUND_VARIABLE_604)) (nullable.lift (lambda ((BOUND_VARIABLE_554 Int) (BOUND_VARIABLE_555 Int)) (= BOUND_VARIABLE_554 BOUND_VARIABLE_555)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_577 Int) (BOUND_VARIABLE_578 Int)) (= BOUND_VARIABLE_577 BOUND_VARIABLE_578)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)) (nullable.lift (lambda ((BOUND_VARIABLE_586 String) (BOUND_VARIABLE_587 String)) (= BOUND_VARIABLE_586 BOUND_VARIABLE_587)) ((_ tuple.select 10) t) (nullable.some "foo"))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_640 String) (BOUND_VARIABLE_641 String)) (= BOUND_VARIABLE_640 BOUND_VARIABLE_641)) ((_ tuple.select 1) t) (nullable.some "fo0"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_640 String) (BOUND_VARIABLE_641 String)) (= BOUND_VARIABLE_640 BOUND_VARIABLE_641)) ((_ tuple.select 1) t) (nullable.some "fo0")))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_661 Int) (BOUND_VARIABLE_662 Int)) (= BOUND_VARIABLE_661 BOUND_VARIABLE_662)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_661 Int) (BOUND_VARIABLE_662 Int)) (= BOUND_VARIABLE_661 BOUND_VARIABLE_662)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_680 Int) (BOUND_VARIABLE_681 Int)) (= BOUND_VARIABLE_680 BOUND_VARIABLE_681)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_680 Int) (BOUND_VARIABLE_681 Int)) (= BOUND_VARIABLE_680 BOUND_VARIABLE_681)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)))))))
(assert (= q1 ((_ rel.project 1) (set.filter p0 (rel.product (rel.product EMP DEPT) EMP)))))
(assert (= q2 ((_ rel.project 1) (set.filter p3 (rel.product (set.filter p2 (rel.product EMP ((_ rel.project 0 1) (set.filter p1 DEPT)))) EMP)))))
(check-sat)
;answer: sat
; duration: 196 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some 1) (nullable.some "") (nullable.some "A") (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some 0) (nullable.some (- 3)))) (set.singleton (tuple (nullable.some 4) (nullable.some "B") (nullable.some "C") (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (nullable.some 0) (nullable.some (- 6))))))
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 0) (nullable.some "foo"))))
; )
; q1
(get-value (q1))
; (set.union (set.singleton (tuple (nullable.some "B"))) (set.singleton (tuple (nullable.some ""))))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable String))))
; insert into EMP values(1,'','A',-1,2,-2,3,0,-3),(4,'B','C',-4,5,-5,6,0,-6)
; insert into DEPT values(0,'foo')
; SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = EMP0.DEPTNO AND DEPT.NAME = 'foo') AS q1 EXCEPT ALL SELECT * FROM (SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'fo0') AS t1 ON EMP1.DEPTNO = t1.DEPTNO INNER JOIN EMP AS EMP2 ON t1.DEPTNO = EMP2.DEPTNO) AS q2;
;(B)
;(B)
;()
;()

; SELECT * FROM (SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'fo0') AS t1 ON EMP1.DEPTNO = t1.DEPTNO INNER JOIN EMP AS EMP2 ON t1.DEPTNO = EMP2.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = EMP0.DEPTNO AND DEPT.NAME = 'foo') AS q1;

;Model soundness: true
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_482 Int) (BOUND_VARIABLE_483 Int)) (= BOUND_VARIABLE_482 BOUND_VARIABLE_483)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_482 Int) (BOUND_VARIABLE_483 Int)) (= BOUND_VARIABLE_482 BOUND_VARIABLE_483)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_555 String) (BOUND_VARIABLE_556 String)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 1) t) (nullable.some "Charli"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_555 String) (BOUND_VARIABLE_556 String)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 1) t) (nullable.some "Charli")))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_595 String) (BOUND_VARIABLE_596 String)) (= BOUND_VARIABLE_595 BOUND_VARIABLE_596)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_595 String) (BOUND_VARIABLE_596 String)) (= BOUND_VARIABLE_595 BOUND_VARIABLE_596)) ((_ tuple.select 1) t) (nullable.some "Charlie")))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_615 Int) (BOUND_VARIABLE_616 Int)) (= BOUND_VARIABLE_615 BOUND_VARIABLE_616)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_615 Int) (BOUND_VARIABLE_616 Int)) (= BOUND_VARIABLE_615 BOUND_VARIABLE_616)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f4 (set.filter p3 (set.union (set.union (set.map leftJoin1 (set.minus DEPT ((_ rel.project 0 1) (set.filter p0 (rel.product DEPT EMP))))) (set.map rightJoin2 (set.minus EMP ((_ rel.project 2 3 4 5 6 7 8 9 10) (set.filter p0 (rel.product DEPT EMP)))))) (set.filter p0 (rel.product DEPT EMP)))))))
(assert (= q2 (set.map f8 (set.union (set.map leftJoin7 (set.minus ((_ rel.project 0 1) (set.filter p5 DEPT)) ((_ rel.project 0 1) (set.filter p6 (rel.product ((_ rel.project 0 1) (set.filter p5 DEPT)) EMP))))) (set.filter p6 (rel.product ((_ rel.project 0 1) (set.filter p5 DEPT)) EMP))))))
(check-sat)
;answer: sat
; duration: 128 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))))
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 0) (nullable.some "Charlie"))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 1)))
; insert into DEPT values(0,'Charlie')
; SELECT * FROM (SELECT 1 FROM DEPT AS DEPT FULL JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charli') AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 LEFT JOIN EMP AS EMP0 ON t1.DEPTNO = EMP0.DEPTNO) AS q2;

; SELECT * FROM (SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 LEFT JOIN EMP AS EMP0 ON t1.DEPTNO = EMP0.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM DEPT AS DEPT FULL JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charli') AS q1;
;(1)

;Model soundness: true
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (>= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (>= BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_469 Int) (BOUND_VARIABLE_470 Int)) (> BOUND_VARIABLE_469 BOUND_VARIABLE_470)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_469 Int) (BOUND_VARIABLE_470 Int)) (> BOUND_VARIABLE_469 BOUND_VARIABLE_470)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_530 Int) (BOUND_VARIABLE_531 Int)) (= BOUND_VARIABLE_530 BOUND_VARIABLE_531)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_530 Int) (BOUND_VARIABLE_531 Int)) (= BOUND_VARIABLE_530 BOUND_VARIABLE_531)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_556 Int) (BOUND_VARIABLE_557 Int)) (> BOUND_VARIABLE_556 BOUND_VARIABLE_557)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_556 Int) (BOUND_VARIABLE_557 Int)) (> BOUND_VARIABLE_556 BOUND_VARIABLE_557)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (> BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (> BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_591 Int) (BOUND_VARIABLE_592 Int)) (> BOUND_VARIABLE_591 BOUND_VARIABLE_592)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_591 Int) (BOUND_VARIABLE_592 Int)) (> BOUND_VARIABLE_591 BOUND_VARIABLE_592)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_597 Int) (BOUND_VARIABLE_598 Int)) (> BOUND_VARIABLE_597 BOUND_VARIABLE_598)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_597 Int) (BOUND_VARIABLE_598 Int)) (> BOUND_VARIABLE_597 BOUND_VARIABLE_598)) ((_ tuple.select 7) t) (nullable.some 10)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_610 Bool) (BOUND_VARIABLE_611 Bool)) (or BOUND_VARIABLE_610 BOUND_VARIABLE_611)) (nullable.lift (lambda ((BOUND_VARIABLE_591 Int) (BOUND_VARIABLE_592 Int)) (> BOUND_VARIABLE_591 BOUND_VARIABLE_592)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_597 Int) (BOUND_VARIABLE_598 Int)) (> BOUND_VARIABLE_597 BOUND_VARIABLE_598)) ((_ tuple.select 7) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_591 Int) (BOUND_VARIABLE_592 Int)) (> BOUND_VARIABLE_591 BOUND_VARIABLE_592)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_591 Int) (BOUND_VARIABLE_592 Int)) (> BOUND_VARIABLE_591 BOUND_VARIABLE_592)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_597 Int) (BOUND_VARIABLE_598 Int)) (> BOUND_VARIABLE_597 BOUND_VARIABLE_598)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_597 Int) (BOUND_VARIABLE_598 Int)) (> BOUND_VARIABLE_597 BOUND_VARIABLE_598)) ((_ tuple.select 7) t) (nullable.some 10)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_610 Bool) (BOUND_VARIABLE_611 Bool)) (or BOUND_VARIABLE_610 BOUND_VARIABLE_611)) (nullable.lift (lambda ((BOUND_VARIABLE_591 Int) (BOUND_VARIABLE_592 Int)) (> BOUND_VARIABLE_591 BOUND_VARIABLE_592)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_597 Int) (BOUND_VARIABLE_598 Int)) (> BOUND_VARIABLE_597 BOUND_VARIABLE_598)) ((_ tuple.select 7) t) (nullable.some 10))))))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_633 Int) (BOUND_VARIABLE_634 Int)) (= BOUND_VARIABLE_633 BOUND_VARIABLE_634)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_633 Int) (BOUND_VARIABLE_634 Int)) (= BOUND_VARIABLE_633 BOUND_VARIABLE_634)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f3 (set.filter p2 (rel.product (set.union ((_ rel.project 7) (set.filter p0 EMP)) ((_ rel.project 7) (set.filter p1 EMP))) EMP)))))
(assert (= q2 (set.map f8 (set.filter p7 (rel.product (set.union ((_ rel.project 7) (set.filter p4 EMP)) ((_ rel.project 7) (set.filter p5 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 EMP)))))))
(check-sat)
;answer: sat
; duration: 381 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some (- 10)) (nullable.some "E") (nullable.some "F") (nullable.some 11) (nullable.some (- 11)) (nullable.some 12) (nullable.some (- 12)) (nullable.some 7) (nullable.some 13))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 1)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; insert into EMP values(-10,'E','F',11,-11,12,-12,7,13)
; SELECT * FROM (SELECT 1 FROM (SELECT EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO >= 7 UNION ALL SELECT EMP0.DEPTNO FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 10) AS t3 INNER JOIN EMP AS EMP1 ON t3.DEPTNO = EMP1.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT EMP2.DEPTNO FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7 UNION ALL SELECT EMP3.DEPTNO FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 10) AS t9 INNER JOIN (SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 7 OR EMP4.DEPTNO > 10) AS t10 ON t9.DEPTNO = t10.DEPTNO) AS q2;
;(1)

; SELECT * FROM (SELECT 1 FROM (SELECT EMP2.DEPTNO FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7 UNION ALL SELECT EMP3.DEPTNO FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 10) AS t9 INNER JOIN (SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 7 OR EMP4.DEPTNO > 10) AS t10 ON t9.DEPTNO = t10.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO >= 7 UNION ALL SELECT EMP0.DEPTNO FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 10) AS t3 INNER JOIN EMP AS EMP1 ON t3.DEPTNO = EMP1.DEPTNO) AS q1;

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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const leftJoin2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const leftJoin5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_520 Int) (BOUND_VARIABLE_521 Int)) (= BOUND_VARIABLE_520 BOUND_VARIABLE_521)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_520 Int) (BOUND_VARIABLE_521 Int)) (= BOUND_VARIABLE_520 BOUND_VARIABLE_521)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_561 Int) (BOUND_VARIABLE_562 Int)) (>= BOUND_VARIABLE_561 BOUND_VARIABLE_562)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_561 Int) (BOUND_VARIABLE_562 Int)) (>= BOUND_VARIABLE_561 BOUND_VARIABLE_562)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_578 Int) (BOUND_VARIABLE_579 Int)) (= BOUND_VARIABLE_578 BOUND_VARIABLE_579)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_578 Int) (BOUND_VARIABLE_579 Int)) (= BOUND_VARIABLE_578 BOUND_VARIABLE_579)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= leftJoin5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map leftJoin2 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) DEPT))))) (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) DEPT))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map leftJoin5 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1) (set.filter p4 DEPT)))))) (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1) (set.filter p4 DEPT)))))))
(check-sat)
;answer: sat
; duration: 185 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (as set.empty (Set (Tuple (Nullable Int) (Nullable String)))))
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 11) (nullable.some "") (nullable.some "A") (nullable.some 0) (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 11) (nullable.some "") (nullable.some "A") (nullable.some 0) (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))
; insert into EMP values(11,'','A',0,1,-1,2,-2,3)
; SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.EMPNO = 10) AS t LEFT JOIN DEPT AS DEPT ON t.EMPNO = DEPT.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.EMPNO >= 10) AS t0 LEFT JOIN (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO = 10) AS t1 ON TRUE) AS q2;

; SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.EMPNO >= 10) AS t0 LEFT JOIN (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO = 10) AS t1 ON TRUE) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.EMPNO = 10) AS t LEFT JOIN DEPT AS DEPT ON t.EMPNO = DEPT.DEPTNO) AS q1;
;(11,,A,0,1,-1,2,-2,3,NULL,NULL)

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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_482 Int) (BOUND_VARIABLE_483 Int)) (= BOUND_VARIABLE_482 BOUND_VARIABLE_483)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_482 Int) (BOUND_VARIABLE_483 Int)) (= BOUND_VARIABLE_482 BOUND_VARIABLE_483)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_599 Int) (BOUND_VARIABLE_600 Int)) (>= BOUND_VARIABLE_599 BOUND_VARIABLE_600)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_599 Int) (BOUND_VARIABLE_600 Int)) (>= BOUND_VARIABLE_599 BOUND_VARIABLE_600)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f2 (set.union (set.map leftJoin1 (set.minus DEPT ((_ rel.project 0 1) (set.filter p0 (rel.product DEPT EMP))))) (set.filter p0 (rel.product DEPT EMP))))))
(assert (= q2 (set.map f5 (set.union (set.map rightJoin4 (set.minus DEPT ((_ rel.project 9 10) (set.filter p3 (rel.product EMP DEPT))))) (set.filter p3 (rel.product EMP DEPT))))))
(check-sat)
;answer: unsat
; duration: 283 ms.
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
; duration: 133 ms.
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_458 Int) (BOUND_VARIABLE_459 Int)) (= BOUND_VARIABLE_458 BOUND_VARIABLE_459)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_458 Int) (BOUND_VARIABLE_459 Int)) (= BOUND_VARIABLE_458 BOUND_VARIABLE_459)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_479 Int) (BOUND_VARIABLE_480 Int)) (= BOUND_VARIABLE_479 BOUND_VARIABLE_480)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_479 Int) (BOUND_VARIABLE_480 Int)) (= BOUND_VARIABLE_479 BOUND_VARIABLE_480)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_497 Int) (BOUND_VARIABLE_498 Int)) (= BOUND_VARIABLE_497 BOUND_VARIABLE_498)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_497 Int) (BOUND_VARIABLE_498 Int)) (= BOUND_VARIABLE_497 BOUND_VARIABLE_498)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_514 Int) (BOUND_VARIABLE_515 Int)) (= BOUND_VARIABLE_514 BOUND_VARIABLE_515)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_514 Int) (BOUND_VARIABLE_515 Int)) (= BOUND_VARIABLE_514 BOUND_VARIABLE_515)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_532 Int) (BOUND_VARIABLE_533 Int)) (= BOUND_VARIABLE_532 BOUND_VARIABLE_533)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_532 Int) (BOUND_VARIABLE_533 Int)) (= BOUND_VARIABLE_532 BOUND_VARIABLE_533)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))
(assert (= q2 (set.union (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))
(check-sat)
;answer: sat
; duration: 392 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 19) (nullable.some "K") (nullable.some "L") (nullable.some (- 19)) (nullable.some 20) (nullable.some (- 20)) (nullable.some 21) (nullable.some 10) (nullable.some (- 21)))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 19) (nullable.some "K") (nullable.some "L") (nullable.some (- 19)) (nullable.some 20) (nullable.some (- 20)) (nullable.some 21) (nullable.some 10) (nullable.some (- 21))))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; insert into EMP values(19,'K','L',-19,20,-20,21,10,-21)
; SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 20 UNION ALL SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS q2;
;(19,K,L,-19,20,-20,21,10,-21)

; SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 20 UNION ALL SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS q1;

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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_372 Int) (BOUND_VARIABLE_373 Int)) (> BOUND_VARIABLE_372 BOUND_VARIABLE_373)) (nullable.lift (lambda ((BOUND_VARIABLE_354 Int) (BOUND_VARIABLE_355 Int)) (+ BOUND_VARIABLE_354 BOUND_VARIABLE_355)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_366 Int) (BOUND_VARIABLE_367 Int)) (+ BOUND_VARIABLE_366 BOUND_VARIABLE_367)) (nullable.some 3) (as nullable.null (Nullable Int))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_372 Int) (BOUND_VARIABLE_373 Int)) (> BOUND_VARIABLE_372 BOUND_VARIABLE_373)) (nullable.lift (lambda ((BOUND_VARIABLE_354 Int) (BOUND_VARIABLE_355 Int)) (+ BOUND_VARIABLE_354 BOUND_VARIABLE_355)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_366 Int) (BOUND_VARIABLE_367 Int)) (+ BOUND_VARIABLE_366 BOUND_VARIABLE_367)) (nullable.some 3) (as nullable.null (Nullable Int)))))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 (set.singleton (tuple (nullable.some 1) (nullable.some 2)))))))
(assert (= q2 ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 0) (nullable.some 0))))))
(check-sat)
;answer: sat
; duration: 17 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 0) (nullable.some 0)))
; SELECT * FROM (SELECT * FROM (VALUES  (1, 2)) AS t WHERE 1 + 2 > 3 + CAST(NULL AS INT)) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES(0, 0))) AS t1) AS q2;

; SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES(0, 0))) AS t1) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (VALUES  (1, 2)) AS t WHERE 1 + 2 > 3 + CAST(NULL AS INT)) AS q1;
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (< BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 3) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (< BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 3) t) (nullable.some 10)))) (nullable.some true) (nullable.some false))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (< BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 3) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (< BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 3) t) (nullable.some 10)))) (nullable.some true) (nullable.some false)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (<= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (<= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= q1 ((_ rel.project 3) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0) (set.filter p1 ((_ rel.project 3) EMP)))))
(check-sat)
;answer: sat
; duration: 77 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some (- 3)) (nullable.some "A") (nullable.some "B") (nullable.some 10) (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 10)))
; insert into EMP values(-3,'A','B',10,4,-4,5,-5,6)
; SELECT * FROM (SELECT EMP.MGR FROM EMP AS EMP WHERE CASE WHEN EMP.MGR < 10 THEN TRUE ELSE FALSE END) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT EMP0.MGR FROM EMP AS EMP0) AS t2 WHERE t2.MGR <= 10) AS q2;

; SELECT * FROM (SELECT * FROM (SELECT EMP0.MGR FROM EMP AS EMP0) AS t2 WHERE t2.MGR <= 10) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.MGR FROM EMP AS EMP WHERE CASE WHEN EMP.MGR < 10 THEN TRUE ELSE FALSE END) AS q1;
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 1) t) (nullable.some 200))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 1) t) (nullable.some 200)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 0) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 0) t) (nullable.some 100)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_525 Int) (BOUND_VARIABLE_526 Int)) (= BOUND_VARIABLE_525 BOUND_VARIABLE_526)) ((_ tuple.select 1) t) ((_ tuple.select 2) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_525 Int) (BOUND_VARIABLE_526 Int)) (= BOUND_VARIABLE_525 BOUND_VARIABLE_526)) ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_544 Int) (BOUND_VARIABLE_545 Int)) (>= BOUND_VARIABLE_544 BOUND_VARIABLE_545)) ((_ tuple.select 1) t) (nullable.some 200))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_544 Int) (BOUND_VARIABLE_545 Int)) (>= BOUND_VARIABLE_544 BOUND_VARIABLE_545)) ((_ tuple.select 1) t) (nullable.some 200)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_561 Int) (BOUND_VARIABLE_562 Int)) (= BOUND_VARIABLE_561 BOUND_VARIABLE_562)) ((_ tuple.select 0) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_561 Int) (BOUND_VARIABLE_562 Int)) (= BOUND_VARIABLE_561 BOUND_VARIABLE_562)) ((_ tuple.select 0) t) (nullable.some 100)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_580 Int) (BOUND_VARIABLE_581 Int)) (= BOUND_VARIABLE_580 BOUND_VARIABLE_581)) ((_ tuple.select 1) t) ((_ tuple.select 2) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_580 Int) (BOUND_VARIABLE_581 Int)) (= BOUND_VARIABLE_580 BOUND_VARIABLE_581)) ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))))
(assert (= q1 ((_ rel.project 0) (set.filter p2 (rel.product ((_ rel.project 0 1) (set.filter p0 ((_ rel.project 6 7) EMP))) ((_ rel.project 1) (set.filter p1 ((_ rel.project 6 7) EMP))))))))
(assert (= q2 ((_ rel.project 0) (set.filter p5 (rel.product ((_ rel.project 0 1) (set.filter p3 ((_ rel.project 6 7) EMP))) ((_ rel.project 1) (set.filter p4 ((_ rel.project 6 7) EMP))))))))
(check-sat)
;answer: sat
; duration: 1800 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some 9) (nullable.some "E") (nullable.some "F") (nullable.some (- 9)) (nullable.some 10) (nullable.some (- 10)) (nullable.some 100) (nullable.some 201) (nullable.some 11))) (set.singleton (tuple (nullable.some (- 6)) (nullable.some "C") (nullable.some "D") (nullable.some 7) (nullable.some (- 7)) (nullable.some 8) (nullable.some 100) (nullable.some 201) (nullable.some (- 8))))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 100)))
; insert into EMP values(9,'E','F',-9,10,-10,100,201,11),(-6,'C','D',7,-7,8,100,201,-8)
; SELECT * FROM (SELECT t0.SAL FROM (SELECT * FROM (SELECT EMP.SAL, EMP.DEPTNO FROM EMP AS EMP) AS t WHERE t.DEPTNO = 200) AS t0 INNER JOIN (SELECT t1.DEPTNO FROM (SELECT EMP0.SAL, EMP0.DEPTNO FROM EMP AS EMP0) AS t1 WHERE t1.SAL = 100) AS t3 ON t0.DEPTNO = t3.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT t6.SAL FROM (SELECT * FROM (SELECT EMP1.SAL, EMP1.DEPTNO FROM EMP AS EMP1) AS t5 WHERE t5.DEPTNO >= 200) AS t6 INNER JOIN (SELECT t7.DEPTNO FROM (SELECT EMP2.SAL, EMP2.DEPTNO FROM EMP AS EMP2) AS t7 WHERE t7.SAL = 100) AS t9 ON t6.DEPTNO = t9.DEPTNO) AS q2;

; SELECT * FROM (SELECT t6.SAL FROM (SELECT * FROM (SELECT EMP1.SAL, EMP1.DEPTNO FROM EMP AS EMP1) AS t5 WHERE t5.DEPTNO >= 200) AS t6 INNER JOIN (SELECT t7.DEPTNO FROM (SELECT EMP2.SAL, EMP2.DEPTNO FROM EMP AS EMP2) AS t7 WHERE t7.SAL = 100) AS t9 ON t6.DEPTNO = t9.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT t0.SAL FROM (SELECT * FROM (SELECT EMP.SAL, EMP.DEPTNO FROM EMP AS EMP) AS t WHERE t.DEPTNO = 200) AS t0 INNER JOIN (SELECT t1.DEPTNO FROM (SELECT EMP0.SAL, EMP0.DEPTNO FROM EMP AS EMP0) AS t1 WHERE t1.SAL = 100) AS t3 ON t0.DEPTNO = t3.DEPTNO) AS q1;
;(100)
;(100)
;(100)
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_511 Int) (BOUND_VARIABLE_512 Int)) (= BOUND_VARIABLE_511 BOUND_VARIABLE_512)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_511 Int) (BOUND_VARIABLE_512 Int)) (= BOUND_VARIABLE_511 BOUND_VARIABLE_512)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map leftJoin2 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) DEPT))))) (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) DEPT))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.singleton (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some ""))))))
(check-sat)
;answer: sat
; duration: 44 ms.
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
; SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE FALSE) AS t LEFT JOIN DEPT AS DEPT ON t.DEPTNO = DEPT.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0,0,''))) AS t0) AS q2;

; SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0,0,''))) AS t0) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE FALSE) AS t LEFT JOIN DEPT AS DEPT ON t.DEPTNO = DEPT.DEPTNO) AS q1;
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 6) t) (nullable.some 1000)))) (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 6) t) (nullable.some 1000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))) (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_477 Int) (BOUND_VARIABLE_478 Int)) (= BOUND_VARIABLE_477 BOUND_VARIABLE_478)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_477 Int) (BOUND_VARIABLE_478 Int)) (= BOUND_VARIABLE_477 BOUND_VARIABLE_478)) ((_ tuple.select 6) t) (nullable.some 2000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 6) t) (nullable.some 1000)))) (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 6) t) (nullable.some 1000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))) (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_477 Int) (BOUND_VARIABLE_478 Int)) (= BOUND_VARIABLE_477 BOUND_VARIABLE_478)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_477 Int) (BOUND_VARIABLE_478 Int)) (= BOUND_VARIABLE_477 BOUND_VARIABLE_478)) ((_ tuple.select 6) t) (nullable.some 2000)))) (as nullable.null (Nullable Int)) (nullable.some 1))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_522 Int) (BOUND_VARIABLE_523 Int)) (= BOUND_VARIABLE_522 BOUND_VARIABLE_523)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_522 Int) (BOUND_VARIABLE_523 Int)) (= BOUND_VARIABLE_522 BOUND_VARIABLE_523)) ((_ tuple.select 6) t) (nullable.some 100)))) (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (= BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 6) t) (nullable.some 1000)) (nullable.lift (lambda ((BOUND_VARIABLE_534 Int) (BOUND_VARIABLE_535 Int)) (= BOUND_VARIABLE_534 BOUND_VARIABLE_535)) ((_ tuple.select 6) t) (nullable.some 2000)))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_522 Int) (BOUND_VARIABLE_523 Int)) (= BOUND_VARIABLE_522 BOUND_VARIABLE_523)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_522 Int) (BOUND_VARIABLE_523 Int)) (= BOUND_VARIABLE_522 BOUND_VARIABLE_523)) ((_ tuple.select 6) t) (nullable.some 100)))) (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (= BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 6) t) (nullable.some 1000)) (nullable.lift (lambda ((BOUND_VARIABLE_534 Int) (BOUND_VARIABLE_535 Int)) (= BOUND_VARIABLE_534 BOUND_VARIABLE_535)) ((_ tuple.select 6) t) (nullable.some 2000))))))))
(assert (= q1 ((_ rel.project 6) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 6) (set.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 53 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 1000) (nullable.some 3) (nullable.some (- 3)))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 1000)))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int))))
; insert into EMP values(0,NULL,'',-1,2,-2,1000,3,-3)
; SELECT * FROM (SELECT EMP.SAL FROM EMP AS EMP WHERE CASE WHEN EMP.SAL = 1000 THEN CASE WHEN EMP.SAL = 1000 THEN NULL ELSE 1 END IS NULL ELSE CASE WHEN EMP.SAL = 2000 THEN NULL ELSE 1 END IS NULL END IS TRUE) AS q1 EXCEPT ALL SELECT * FROM (SELECT EMP0.SAL FROM EMP AS EMP0 WHERE CASE WHEN EMP0.SAL = 100 THEN EMP0.SAL = 1000 ELSE EMP0.SAL = 2000 END) AS q2;
;(1000)

; SELECT * FROM (SELECT EMP0.SAL FROM EMP AS EMP0 WHERE CASE WHEN EMP0.SAL = 100 THEN EMP0.SAL = 1000 ELSE EMP0.SAL = 2000 END) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.SAL FROM EMP AS EMP WHERE CASE WHEN EMP.SAL = 1000 THEN CASE WHEN EMP.SAL = 1000 THEN NULL ELSE 1 END IS NULL ELSE CASE WHEN EMP.SAL = 2000 THEN NULL ELSE 1 END IS NULL END IS TRUE) AS q1;

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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (> BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (> BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 7) t) (nullable.some 9)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_523 Int) (BOUND_VARIABLE_524 Int)) (= BOUND_VARIABLE_523 BOUND_VARIABLE_524)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_523 Int) (BOUND_VARIABLE_524 Int)) (= BOUND_VARIABLE_523 BOUND_VARIABLE_524)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_564 Int) (BOUND_VARIABLE_565 Int)) (> BOUND_VARIABLE_564 BOUND_VARIABLE_565)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_564 Int) (BOUND_VARIABLE_565 Int)) (> BOUND_VARIABLE_564 BOUND_VARIABLE_565)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_601 Int) (BOUND_VARIABLE_602 Int)) (>= BOUND_VARIABLE_601 BOUND_VARIABLE_602)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_601 Int) (BOUND_VARIABLE_602 Int)) (>= BOUND_VARIABLE_601 BOUND_VARIABLE_602)) ((_ tuple.select 7) t) (nullable.some 9)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_618 Int) (BOUND_VARIABLE_619 Int)) (>= BOUND_VARIABLE_618 BOUND_VARIABLE_619)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_618 Int) (BOUND_VARIABLE_619 Int)) (>= BOUND_VARIABLE_618 BOUND_VARIABLE_619)) ((_ tuple.select 7) t) (nullable.some 9)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_637 Int) (BOUND_VARIABLE_638 Int)) (= BOUND_VARIABLE_637 BOUND_VARIABLE_638)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_637 Int) (BOUND_VARIABLE_638 Int)) (= BOUND_VARIABLE_637 BOUND_VARIABLE_638)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= rightJoin8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_672 Int) (BOUND_VARIABLE_673 Int)) (>= BOUND_VARIABLE_672 BOUND_VARIABLE_673)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_672 Int) (BOUND_VARIABLE_673 Int)) (>= BOUND_VARIABLE_672 BOUND_VARIABLE_673)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= f10 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f4 (set.filter p3 (set.union (set.map rightJoin2 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 9 10 11 12 13 14 15 16 17) (set.filter p1 (rel.product EMP ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))))) (set.filter p1 (rel.product EMP ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)))))))))
(assert (= q2 (set.map f10 (set.filter p9 (set.union (set.map rightJoin8 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 EMP)) ((_ rel.project 9 10 11 12 13 14 15 16 17) (set.filter p7 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 EMP))))))) (set.filter p7 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 EMP)))))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10156 ms.
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (> BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (> BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_442 Int) (BOUND_VARIABLE_443 Int)) (= BOUND_VARIABLE_442 BOUND_VARIABLE_443)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_442 Int) (BOUND_VARIABLE_443 Int)) (= BOUND_VARIABLE_442 BOUND_VARIABLE_443)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_493 Bool) (BOUND_VARIABLE_494 Bool) (BOUND_VARIABLE_495 Bool)) (and BOUND_VARIABLE_493 BOUND_VARIABLE_494 BOUND_VARIABLE_495)) (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (> BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_442 Int) (BOUND_VARIABLE_443 Int)) (= BOUND_VARIABLE_442 BOUND_VARIABLE_443)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (nullable.lift (lambda ((BOUND_VARIABLE_477 Int) (BOUND_VARIABLE_478 Real)) (> BOUND_VARIABLE_477 BOUND_VARIABLE_478)) (nullable.lift (lambda ((BOUND_VARIABLE_448 Int) (BOUND_VARIABLE_449 Int)) (+ BOUND_VARIABLE_448 BOUND_VARIABLE_449)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (nullable.lift (lambda ((BOUND_VARIABLE_456 Int) (BOUND_VARIABLE_457 Int)) (/ BOUND_VARIABLE_456 BOUND_VARIABLE_457)) ((_ tuple.select 5) t) (nullable.some 2))))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (> BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (> BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_442 Int) (BOUND_VARIABLE_443 Int)) (= BOUND_VARIABLE_442 BOUND_VARIABLE_443)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_442 Int) (BOUND_VARIABLE_443 Int)) (= BOUND_VARIABLE_442 BOUND_VARIABLE_443)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_493 Bool) (BOUND_VARIABLE_494 Bool) (BOUND_VARIABLE_495 Bool)) (and BOUND_VARIABLE_493 BOUND_VARIABLE_494 BOUND_VARIABLE_495)) (nullable.lift (lambda ((BOUND_VARIABLE_419 Int) (BOUND_VARIABLE_420 Int)) (> BOUND_VARIABLE_419 BOUND_VARIABLE_420)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_442 Int) (BOUND_VARIABLE_443 Int)) (= BOUND_VARIABLE_442 BOUND_VARIABLE_443)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (nullable.lift (lambda ((BOUND_VARIABLE_477 Int) (BOUND_VARIABLE_478 Real)) (> BOUND_VARIABLE_477 BOUND_VARIABLE_478)) (nullable.lift (lambda ((BOUND_VARIABLE_448 Int) (BOUND_VARIABLE_449 Int)) (+ BOUND_VARIABLE_448 BOUND_VARIABLE_449)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (nullable.lift (lambda ((BOUND_VARIABLE_456 Int) (BOUND_VARIABLE_457 Int)) (/ BOUND_VARIABLE_456 BOUND_VARIABLE_457)) ((_ tuple.select 5) t) (nullable.some 2)))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_518 Int) (BOUND_VARIABLE_519 Int)) (= BOUND_VARIABLE_518 BOUND_VARIABLE_519)) ((_ tuple.select 6) t) ((_ tuple.select 7) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_518 Int) (BOUND_VARIABLE_519 Int)) (= BOUND_VARIABLE_518 BOUND_VARIABLE_519)) ((_ tuple.select 6) t) ((_ tuple.select 7) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_602 Int) (BOUND_VARIABLE_603 Int)) (= BOUND_VARIABLE_602 BOUND_VARIABLE_603)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_602 Int) (BOUND_VARIABLE_603 Int)) (= BOUND_VARIABLE_602 BOUND_VARIABLE_603)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_640 Int) (BOUND_VARIABLE_641 Int)) (>= BOUND_VARIABLE_640 BOUND_VARIABLE_641)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_640 Int) (BOUND_VARIABLE_641 Int)) (>= BOUND_VARIABLE_640 BOUND_VARIABLE_641)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_647 Int) (BOUND_VARIABLE_648 Int)) (= BOUND_VARIABLE_647 BOUND_VARIABLE_648)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_647 Int) (BOUND_VARIABLE_648 Int)) (= BOUND_VARIABLE_647 BOUND_VARIABLE_648)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_679 Bool) (BOUND_VARIABLE_680 Bool) (BOUND_VARIABLE_681 Bool)) (and BOUND_VARIABLE_679 BOUND_VARIABLE_680 BOUND_VARIABLE_681)) (nullable.lift (lambda ((BOUND_VARIABLE_640 Int) (BOUND_VARIABLE_641 Int)) (>= BOUND_VARIABLE_640 BOUND_VARIABLE_641)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_647 Int) (BOUND_VARIABLE_648 Int)) (= BOUND_VARIABLE_647 BOUND_VARIABLE_648)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (nullable.lift (lambda ((BOUND_VARIABLE_665 Int) (BOUND_VARIABLE_666 Real)) (> BOUND_VARIABLE_665 BOUND_VARIABLE_666)) (nullable.lift (lambda ((BOUND_VARIABLE_653 Int) (BOUND_VARIABLE_654 Int)) (+ BOUND_VARIABLE_653 BOUND_VARIABLE_654)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (nullable.lift (lambda ((BOUND_VARIABLE_659 Int) (BOUND_VARIABLE_660 Int)) (/ BOUND_VARIABLE_659 BOUND_VARIABLE_660)) ((_ tuple.select 5) t) (nullable.some 2))))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_640 Int) (BOUND_VARIABLE_641 Int)) (>= BOUND_VARIABLE_640 BOUND_VARIABLE_641)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_640 Int) (BOUND_VARIABLE_641 Int)) (>= BOUND_VARIABLE_640 BOUND_VARIABLE_641)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_647 Int) (BOUND_VARIABLE_648 Int)) (= BOUND_VARIABLE_647 BOUND_VARIABLE_648)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_647 Int) (BOUND_VARIABLE_648 Int)) (= BOUND_VARIABLE_647 BOUND_VARIABLE_648)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_679 Bool) (BOUND_VARIABLE_680 Bool) (BOUND_VARIABLE_681 Bool)) (and BOUND_VARIABLE_679 BOUND_VARIABLE_680 BOUND_VARIABLE_681)) (nullable.lift (lambda ((BOUND_VARIABLE_640 Int) (BOUND_VARIABLE_641 Int)) (>= BOUND_VARIABLE_640 BOUND_VARIABLE_641)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_647 Int) (BOUND_VARIABLE_648 Int)) (= BOUND_VARIABLE_647 BOUND_VARIABLE_648)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (nullable.lift (lambda ((BOUND_VARIABLE_665 Int) (BOUND_VARIABLE_666 Real)) (> BOUND_VARIABLE_665 BOUND_VARIABLE_666)) (nullable.lift (lambda ((BOUND_VARIABLE_653 Int) (BOUND_VARIABLE_654 Int)) (+ BOUND_VARIABLE_653 BOUND_VARIABLE_654)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (nullable.lift (lambda ((BOUND_VARIABLE_659 Int) (BOUND_VARIABLE_660 Int)) (/ BOUND_VARIABLE_659 BOUND_VARIABLE_660)) ((_ tuple.select 5) t) (nullable.some 2)))))))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_700 Int) (BOUND_VARIABLE_701 Int)) (= BOUND_VARIABLE_700 BOUND_VARIABLE_701)) ((_ tuple.select 6) t) ((_ tuple.select 7) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_700 Int) (BOUND_VARIABLE_701 Int)) (= BOUND_VARIABLE_700 BOUND_VARIABLE_701)) ((_ tuple.select 6) t) ((_ tuple.select 7) t)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_717 Int) (BOUND_VARIABLE_718 Int)) (>= BOUND_VARIABLE_717 BOUND_VARIABLE_718)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_717 Int) (BOUND_VARIABLE_718 Int)) (>= BOUND_VARIABLE_717 BOUND_VARIABLE_718)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_736 Int) (BOUND_VARIABLE_737 Int)) (= BOUND_VARIABLE_736 BOUND_VARIABLE_737)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_736 Int) (BOUND_VARIABLE_737 Int)) (= BOUND_VARIABLE_736 BOUND_VARIABLE_737)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f3 (set.filter p2 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))))))
(assert (= q2 (set.map f8 (set.filter p7 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))))))
(check-sat)
;answer: sat
; duration: 698 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some 3) (nullable.some "A") (nullable.some "B") (nullable.some (- 3)) (nullable.some 4) (nullable.some 7) (nullable.some 7) (nullable.some 7) (nullable.some (- 4)))) (set.singleton (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some (- 1)) (nullable.some 2) (nullable.some 7) (nullable.some 7) (nullable.some 7) (nullable.some (- 2))))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 1)))
; insert into EMP values(3,'A','B',-3,4,7,7,7,-4),(0,NULL,'',-1,2,7,7,7,-2)
; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7 AND EMP.COMM = EMP.DEPTNO AND EMP.COMM + EMP.DEPTNO > EMP.COMM / 2) AS t INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL = EMP0.DEPTNO) AS t0 ON t.DEPTNO = t0.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7 AND EMP1.COMM = EMP1.DEPTNO AND EMP1.COMM + EMP1.DEPTNO > EMP1.COMM / 2) AS t2 INNER JOIN (SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.SAL = EMP2.DEPTNO) AS t3 WHERE t3.DEPTNO >= 7) AS t4 ON t2.DEPTNO = t4.DEPTNO) AS q2;

; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7 AND EMP1.COMM = EMP1.DEPTNO AND EMP1.COMM + EMP1.DEPTNO > EMP1.COMM / 2) AS t2 INNER JOIN (SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.SAL = EMP2.DEPTNO) AS t3 WHERE t3.DEPTNO >= 7) AS t4 ON t2.DEPTNO = t4.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO > 7 AND EMP.COMM = EMP.DEPTNO AND EMP.COMM + EMP.DEPTNO > EMP.COMM / 2) AS t INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL = EMP0.DEPTNO) AS t0 ON t.DEPTNO = t0.DEPTNO) AS q1;
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 (set.singleton (tuple (nullable.some 1) (nullable.some 2)))))))
(assert (= q2 ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 0) (nullable.some 0))))))
(check-sat)
;answer: sat
; duration: 20 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 0) (nullable.some 0)))
; SELECT * FROM (SELECT * FROM (VALUES  (1, 2)) AS t WHERE FALSE) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES (0,0))) AS t1) AS q2;

; SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES (0,0))) AS t1) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (VALUES  (1, 2)) AS t WHERE FALSE) AS q1;
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
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= q1 (set.union (set.map f0 EMP) (set.map f1 EMP))))
(assert (= q2 (set.union (set.map f2 EMP) (set.map f3 EMP))))
(check-sat)
;answer: sat
; duration: 37 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some (- 8)) (nullable.some "D") (nullable.some "C") (nullable.some 9) (nullable.some (- 9)) (nullable.some 10) (nullable.some (- 10)) (nullable.some 8) (nullable.some 11))))
; )
; q1
(get-value (q1))
; (set.union (set.singleton (tuple (nullable.some 1) (nullable.some 8) (nullable.some "C"))) (set.singleton (tuple (nullable.some 2) (nullable.some 8) (nullable.some "C"))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 1) (nullable.some 8) (nullable.some "C")))
; insert into EMP values(-8,'D','C',9,-9,10,-10,8,11)
; SELECT * FROM (SELECT 2, EMP.DEPTNO, EMP.JOB FROM EMP AS EMP UNION ALL SELECT 1, EMP0.DEPTNO, EMP0.JOB FROM EMP AS EMP0) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1, EMP1.DEPTNO, EMP1.JOB FROM EMP AS EMP1 UNION ALL SELECT 1, EMP2.DEPTNO, EMP2.JOB FROM EMP AS EMP2) AS q2;
;(2,8,C)

; SELECT * FROM (SELECT 1, EMP1.DEPTNO, EMP1.JOB FROM EMP AS EMP1 UNION ALL SELECT 1, EMP2.DEPTNO, EMP2.JOB FROM EMP AS EMP2) AS q2 EXCEPT ALL SELECT * FROM (SELECT 2, EMP.DEPTNO, EMP.JOB FROM EMP AS EMP UNION ALL SELECT 1, EMP0.DEPTNO, EMP0.JOB FROM EMP AS EMP0) AS q1;
;(1,8,C)

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
; duration: 14 ms.
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_420 Int) (BOUND_VARIABLE_421 Int)) (= BOUND_VARIABLE_420 BOUND_VARIABLE_421)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_458 Int) (BOUND_VARIABLE_459 Int)) (= BOUND_VARIABLE_458 BOUND_VARIABLE_459)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_458 Int) (BOUND_VARIABLE_459 Int)) (= BOUND_VARIABLE_458 BOUND_VARIABLE_459)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_479 Int) (BOUND_VARIABLE_480 Int)) (= BOUND_VARIABLE_479 BOUND_VARIABLE_480)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_479 Int) (BOUND_VARIABLE_480 Int)) (= BOUND_VARIABLE_479 BOUND_VARIABLE_480)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_497 Int) (BOUND_VARIABLE_498 Int)) (>= BOUND_VARIABLE_497 BOUND_VARIABLE_498)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_497 Int) (BOUND_VARIABLE_498 Int)) (>= BOUND_VARIABLE_497 BOUND_VARIABLE_498)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_514 Int) (BOUND_VARIABLE_515 Int)) (= BOUND_VARIABLE_514 BOUND_VARIABLE_515)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_514 Int) (BOUND_VARIABLE_515 Int)) (= BOUND_VARIABLE_514 BOUND_VARIABLE_515)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_533 Int) (BOUND_VARIABLE_534 Int)) (= BOUND_VARIABLE_533 BOUND_VARIABLE_534)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_533 Int) (BOUND_VARIABLE_534 Int)) (= BOUND_VARIABLE_533 BOUND_VARIABLE_534)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))
(assert (= q2 (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))
(check-sat)
;answer: sat
; duration: 218 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some (- 9)) (nullable.some "E") (nullable.some "F") (nullable.some 10) (nullable.some (- 10)) (nullable.some 11) (nullable.some (- 11)) (nullable.some 19) (nullable.some 12))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some (- 9)) (nullable.some "E") (nullable.some "F") (nullable.some 10) (nullable.some (- 10)) (nullable.some 11) (nullable.some (- 11)) (nullable.some 19) (nullable.some 12)))
; insert into EMP values(-9,'E','F',10,-10,11,-11,19,12)
; SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION ALL SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 10 UNION SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20) AS t6 UNION ALL SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS q2;

; SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 10 UNION SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20) AS t6 UNION ALL SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION ALL SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS q1;
;(-9,E,F,10,-10,11,-11,19,12)

;Model soundness: true
(reset)
; total time: 80001 ms.
; sat answers    : 72
; unsat answers  : 8
; unknown answers: 6
