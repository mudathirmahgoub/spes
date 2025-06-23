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
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_397 Int) (BOUND_VARIABLE_398 Int)) (> BOUND_VARIABLE_397 BOUND_VARIABLE_398)) (nullable.lift (lambda ((BOUND_VARIABLE_389 Int) (BOUND_VARIABLE_390 Int)) (+ BOUND_VARIABLE_389 BOUND_VARIABLE_390)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_397 Int) (BOUND_VARIABLE_398 Int)) (> BOUND_VARIABLE_397 BOUND_VARIABLE_398)) (nullable.lift (lambda ((BOUND_VARIABLE_389 Int) (BOUND_VARIABLE_390 Int)) (+ BOUND_VARIABLE_389 BOUND_VARIABLE_390)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 10)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_447 Int) (BOUND_VARIABLE_448 Int)) (+ BOUND_VARIABLE_447 BOUND_VARIABLE_448)) (nullable.lift (lambda ((BOUND_VARIABLE_441 Int) (BOUND_VARIABLE_442 Int)) (+ BOUND_VARIABLE_441 BOUND_VARIABLE_442)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 0) t))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= q1 (bag.map f1 (bag.filter p0 (bag.union_disjoint (bag (tuple (nullable.some 10) (nullable.some 1)) 1) (bag (tuple (nullable.some 30) (nullable.some 3)) 1))))))
(assert (= q2 ((_ table.project 0) (bag.filter p2 (bag (tuple (nullable.some 0)) 1)))))
(check-sat)
;answer: sat
; duration: 44 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (bag.union_disjoint (bag (tuple (nullable.some 21)) 1) (bag (tuple (nullable.some 63)) 1))
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_407 Int) (BOUND_VARIABLE_408 Int)) (> BOUND_VARIABLE_407 BOUND_VARIABLE_408)) (nullable.lift (lambda ((BOUND_VARIABLE_399 Int) (BOUND_VARIABLE_400 Int)) (+ BOUND_VARIABLE_399 BOUND_VARIABLE_400)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_407 Int) (BOUND_VARIABLE_408 Int)) (> BOUND_VARIABLE_407 BOUND_VARIABLE_408)) (nullable.lift (lambda ((BOUND_VARIABLE_399 Int) (BOUND_VARIABLE_400 Int)) (+ BOUND_VARIABLE_399 BOUND_VARIABLE_400)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 10)))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 (bag.union_disjoint ((_ table.project 0 1) (bag.union_disjoint (bag (tuple (nullable.some 10) (nullable.some 1)) 1) (bag (tuple (nullable.some 30) (nullable.some 3)) 1))) ((_ table.project 0 1) (bag (tuple (nullable.some 20) (nullable.some 2)) 1)))))))
(assert (= q2 ((_ table.project 0 1) (bag (tuple (nullable.some 30) (nullable.some 3)) 1))))
(check-sat)
;answer: sat
; duration: 14 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (bag.union_disjoint (bag (tuple (nullable.some 10) (nullable.some 1)) 1) (bag.union_disjoint (bag (tuple (nullable.some 30) (nullable.some 3)) 1) (bag (tuple (nullable.some 20) (nullable.some 2)) 1)))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 30) (nullable.some 3)) 1)
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_405 Int) (BOUND_VARIABLE_406 Int)) (< BOUND_VARIABLE_405 BOUND_VARIABLE_406)) (nullable.lift (lambda ((BOUND_VARIABLE_395 Int) (BOUND_VARIABLE_396 Int)) (- BOUND_VARIABLE_395 BOUND_VARIABLE_396)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_405 Int) (BOUND_VARIABLE_406 Int)) (< BOUND_VARIABLE_405 BOUND_VARIABLE_406)) (nullable.lift (lambda ((BOUND_VARIABLE_395 Int) (BOUND_VARIABLE_396 Int)) (- BOUND_VARIABLE_395 BOUND_VARIABLE_396)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 100)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_455 Int) (BOUND_VARIABLE_456 Int)) (+ BOUND_VARIABLE_455 BOUND_VARIABLE_456)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= q1 (bag.map f1 (bag.filter p0 (bag.union_disjoint (bag.union_disjoint (bag (tuple (nullable.some 10) (nullable.some 1)) 1) (bag (tuple (nullable.some 30) (nullable.some 7)) 1)) (bag (tuple (nullable.some 20) (nullable.some 3)) 1))))))
(assert (= q2 ((_ table.project 0 1 2) (bag.union_disjoint (bag (tuple (nullable.some 11) (nullable.some 1) (nullable.some 10)) 1) (bag (tuple (nullable.some 23) (nullable.some 3) (nullable.some 20)) 1)))))
(check-sat)
;answer: sat
; duration: 14 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (bag.union_disjoint (bag (tuple (nullable.some 11) (nullable.some 1) (nullable.some 10)) 1) (bag.union_disjoint (bag (tuple (nullable.some 23) (nullable.some 3) (nullable.some 20)) 1) (bag (tuple (nullable.some 37) (nullable.some 7) (nullable.some 30)) 1)))
; q2
(get-value (q2))
; (bag.union_disjoint (bag (tuple (nullable.some 11) (nullable.some 1) (nullable.some 10)) 1) (bag (tuple (nullable.some 23) (nullable.some 3) (nullable.some 20)) 1))
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_473 Int) (BOUND_VARIABLE_474 Int)) (= BOUND_VARIABLE_473 BOUND_VARIABLE_474)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_473 Int) (BOUND_VARIABLE_474 Int)) (= BOUND_VARIABLE_473 BOUND_VARIABLE_474)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_491 Int) (BOUND_VARIABLE_492 Int)) (= BOUND_VARIABLE_491 BOUND_VARIABLE_492)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_491 Int) (BOUND_VARIABLE_492 Int)) (= BOUND_VARIABLE_491 BOUND_VARIABLE_492)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_508 Int) (BOUND_VARIABLE_509 Int)) (= BOUND_VARIABLE_508 BOUND_VARIABLE_509)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_508 Int) (BOUND_VARIABLE_509 Int)) (= BOUND_VARIABLE_508 BOUND_VARIABLE_509)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (= BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (= BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)))))
(assert (= q2 (bag.difference_remove (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)))))
(check-sat)
;answer: sat
; duration: 1503 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag.union_disjoint (bag (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 20) (nullable.some 3)) 1) (bag.union_disjoint (bag (tuple (nullable.some (- 3)) (nullable.some "A") (nullable.some "B") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 20) (nullable.some 6)) 1) (bag.union_disjoint (bag (tuple (nullable.some (- 6)) (nullable.some "C") (nullable.some "D") (nullable.some 7) (nullable.some (- 7)) (nullable.some 8) (nullable.some (- 8)) (nullable.some 20) (nullable.some 9)) 1) (bag (tuple (nullable.some (- 9)) (nullable.some "E") (nullable.some "F") (nullable.some (- 10)) (nullable.some 11) (nullable.some (- 11)) (nullable.some 12) (nullable.some 10) (nullable.some (- 12))) 1)))))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some (- 9)) (nullable.some "E") (nullable.some "F") (nullable.some (- 10)) (nullable.some 11) (nullable.some (- 11)) (nullable.some 12) (nullable.some 10) (nullable.some (- 12))) 1)
; insert into EMP values(0,NULL,'',1,-1,2,-2,20,3),(-3,'A','B',4,-4,5,-5,20,6),(-6,'C','D',7,-7,8,-8,20,9),(-9,'E','F',-10,11,-11,12,10,-12)
; SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 EXCEPT SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 EXCEPT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 10) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 EXCEPT SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 EXCEPT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS q2;

; SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 10 EXCEPT SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 EXCEPT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 EXCEPT SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 EXCEPT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 10) AS q1;
;(-9,E,F,-10,11,-11,12,10,-12)

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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_382 Int) (BOUND_VARIABLE_383 Int)) (>= BOUND_VARIABLE_382 BOUND_VARIABLE_383)) ((_ tuple.select 0) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_382 Int) (BOUND_VARIABLE_383 Int)) (>= BOUND_VARIABLE_382 BOUND_VARIABLE_383)) ((_ tuple.select 0) t) (nullable.some 30)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= q1 (bag.difference_remove ((_ table.project 0 1) (bag.difference_remove ((_ table.project 0 1) (bag.filter p0 (bag (tuple (nullable.some 30) (nullable.some 3)) 1))) ((_ table.project 0 1) (bag (tuple (nullable.some 20) (nullable.some 2)) 1)))) ((_ table.project 0 1) (bag (tuple (nullable.some 40) (nullable.some 3)) 1)))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p1 (bag (tuple (nullable.some 0) (nullable.some 0)) 1)))))
(check-sat)
;answer: sat
; duration: 29 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 30) (nullable.some 3)) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable Int))))
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

(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_399 Int) (BOUND_VARIABLE_400 Int)) (+ BOUND_VARIABLE_399 BOUND_VARIABLE_400)) ((_ tuple.select 0) t) ((_ tuple.select 1) t))))))
(assert (= q1 (bag.map f0 (bag.union_disjoint (bag (tuple (nullable.some 10) (nullable.some 1)) 1) (bag (tuple (nullable.some 20) (nullable.some 2)) 1)))))
(assert (= q2 ((_ table.project 0) (bag.union_disjoint (bag (tuple (nullable.some 11)) 1) (bag (tuple (nullable.some 23)) 1)))))
(check-sat)
;answer: sat
; duration: 7 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (bag.union_disjoint (bag (tuple (nullable.some 11)) 1) (bag (tuple (nullable.some 22)) 1))
; q2
(get-value (q2))
; (bag.union_disjoint (bag (tuple (nullable.some 11)) 1) (bag (tuple (nullable.some 23)) 1))
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_407 Int) (BOUND_VARIABLE_408 Int)) (< BOUND_VARIABLE_407 BOUND_VARIABLE_408)) ((_ tuple.select 0) t) (nullable.some 15))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_407 Int) (BOUND_VARIABLE_408 Int)) (< BOUND_VARIABLE_407 BOUND_VARIABLE_408)) ((_ tuple.select 0) t) (nullable.some 15)))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 (bag.union_disjoint (bag (tuple (nullable.some 10) (nullable.some "x")) 1) (bag (tuple (nullable.some 14) (nullable.some "y")) 1))))))
(assert (= q2 ((_ table.project 0 1) (bag (tuple (nullable.some 10) (nullable.some "x")) 1))))
(check-sat)
;answer: sat
; duration: 8 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (bag.union_disjoint (bag (tuple (nullable.some 10) (nullable.some "x")) 1) (bag (tuple (nullable.some 14) (nullable.some "y")) 1))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 10) (nullable.some "x")) 1)
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

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_394 Int) (BOUND_VARIABLE_395 Int)) (= BOUND_VARIABLE_394 BOUND_VARIABLE_395)) ((_ tuple.select 0) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_394 Int) (BOUND_VARIABLE_395 Int)) (= BOUND_VARIABLE_394 BOUND_VARIABLE_395)) ((_ tuple.select 0) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 7))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_431 Bool) (BOUND_VARIABLE_432 Bool)) (and BOUND_VARIABLE_431 BOUND_VARIABLE_432)) (nullable.lift (lambda ((BOUND_VARIABLE_394 Int) (BOUND_VARIABLE_395 Int)) (= BOUND_VARIABLE_394 BOUND_VARIABLE_395)) ((_ tuple.select 0) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 7)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_394 Int) (BOUND_VARIABLE_395 Int)) (= BOUND_VARIABLE_394 BOUND_VARIABLE_395)) ((_ tuple.select 0) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_394 Int) (BOUND_VARIABLE_395 Int)) (= BOUND_VARIABLE_394 BOUND_VARIABLE_395)) ((_ tuple.select 0) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 7))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_431 Bool) (BOUND_VARIABLE_432 Bool)) (and BOUND_VARIABLE_431 BOUND_VARIABLE_432)) (nullable.lift (lambda ((BOUND_VARIABLE_394 Int) (BOUND_VARIABLE_395 Int)) (= BOUND_VARIABLE_394 BOUND_VARIABLE_395)) ((_ tuple.select 0) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 7))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= q1 ((_ table.project 0) (bag.filter p0 DEPT))))
(assert (= q2 ((_ table.project 0) (bag.filter p1 (bag (tuple (nullable.some 0) (nullable.some 0)) 1)))))
(check-sat)
;answer: sat
; duration: 64 ms.
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Bag (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (distinct BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (distinct BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_527 Int) (BOUND_VARIABLE_528 Int)) (= BOUND_VARIABLE_527 BOUND_VARIABLE_528)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_527 Int) (BOUND_VARIABLE_528 Int)) (= BOUND_VARIABLE_527 BOUND_VARIABLE_528)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ table.project 1) (bag.filter p0 (table.product EMP DEPT)))))
(assert (= q2 ((_ table.project 1) (bag.filter p1 (table.product EMP DEPT)))))
(check-sat)
;answer: sat
; duration: 135 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 1) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some 0) (nullable.some (- 3))) 1))
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 0) (nullable.some "A")) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable String))))
; q2
(get-value (q2))
; (bag (tuple (as nullable.null (Nullable String))) 1)
; insert into EMP values(1,NULL,'',-1,2,-2,3,0,-3)
; insert into DEPT values(0,'A')
; SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO <> DEPT.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT EMP0.ENAME FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO) AS q2;

; SELECT * FROM (SELECT EMP0.ENAME FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO <> DEPT.DEPTNO) AS q1;
;(NULL)

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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 3) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.some 2) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= q1 (bag.union_disjoint (bag.map f0 EMP) (bag.map f1 EMP))))
(assert (= q2 (bag.map f2 (bag.union_disjoint ((_ table.project 7 2) EMP) ((_ table.project 7 2) EMP)))))
(check-sat)
;answer: sat
; duration: 346 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 1) (nullable.some "A") (nullable.some "") (nullable.some (- 1)) (nullable.some (- 2)) (nullable.some (- 3)) (nullable.some 4) (nullable.some 0) (nullable.some (- 4))) 1))
; )
; q1
(get-value (q1))
; (bag.union_disjoint (bag (tuple (nullable.some 3) (nullable.some 0) (nullable.some "")) 1) (bag (tuple (nullable.some 2) (nullable.some 0) (nullable.some "")) 1))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 2) (nullable.some 0) (nullable.some "")) 2)
; insert into EMP values(1,'A','',-1,-2,-3,4,0,-4)
; SELECT * FROM (SELECT 2, EMP.DEPTNO, EMP.JOB FROM EMP AS EMP UNION ALL SELECT 3, EMP0.DEPTNO, EMP0.JOB FROM EMP AS EMP0) AS q1 EXCEPT ALL SELECT * FROM (SELECT 2, t6.DEPTNO, t6.JOB FROM (SELECT EMP1.DEPTNO, EMP1.JOB FROM EMP AS EMP1 UNION ALL SELECT EMP2.DEPTNO, EMP2.JOB FROM EMP AS EMP2) AS t6) AS q2;
;(3,0,)

; SELECT * FROM (SELECT 2, t6.DEPTNO, t6.JOB FROM (SELECT EMP1.DEPTNO, EMP1.JOB FROM EMP AS EMP1 UNION ALL SELECT EMP2.DEPTNO, EMP2.JOB FROM EMP AS EMP2) AS t6) AS q2 EXCEPT ALL SELECT * FROM (SELECT 2, EMP.DEPTNO, EMP.JOB FROM EMP AS EMP UNION ALL SELECT 3, EMP0.DEPTNO, EMP0.JOB FROM EMP AS EMP0) AS q1;
;(2,0,)

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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Bool))))
(declare-const p1 (-> (Tuple (Nullable Bool)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Bool))))
(declare-const p3 (-> (Tuple (Nullable Bool)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Bool))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Bool))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (ite (and (nullable.is_some (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_441 Int) (BOUND_VARIABLE_442 Int)) (> BOUND_VARIABLE_441 BOUND_VARIABLE_442)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_441 Int) (BOUND_VARIABLE_442 Int)) (> BOUND_VARIABLE_441 BOUND_VARIABLE_442)) ((_ tuple.select 6) t) (nullable.some 1000)))))) (not (nullable.val (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_441 Int) (BOUND_VARIABLE_442 Int)) (> BOUND_VARIABLE_441 BOUND_VARIABLE_442)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_441 Int) (BOUND_VARIABLE_442 Int)) (> BOUND_VARIABLE_441 BOUND_VARIABLE_442)) ((_ tuple.select 6) t) (nullable.some 1000)))))))) (nullable.some false) (ite (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_463 Bool) (BOUND_VARIABLE_464 Bool)) (and BOUND_VARIABLE_463 BOUND_VARIABLE_464)) (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_441 Int) (BOUND_VARIABLE_442 Int)) (> BOUND_VARIABLE_441 BOUND_VARIABLE_442)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_441 Int) (BOUND_VARIABLE_442 Int)) (> BOUND_VARIABLE_441 BOUND_VARIABLE_442)) ((_ tuple.select 6) t) (nullable.some 1000))))) (as nullable.null (Nullable Bool)))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_482 Bool)) (not BOUND_VARIABLE_482)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_482 Bool)) (not BOUND_VARIABLE_482)) ((_ tuple.select 0) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (ite (and (nullable.is_some (ite (and (nullable.is_some (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (> BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (> BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000)))))) (not (nullable.val (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (> BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (> BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000)))))))) (nullable.some false) (ite (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_516 Bool) (BOUND_VARIABLE_517 Bool)) (and BOUND_VARIABLE_516 BOUND_VARIABLE_517)) (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (> BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (> BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000))))) (as nullable.null (Nullable Bool)))))) (nullable.val (ite (and (nullable.is_some (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (> BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (> BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000)))))) (not (nullable.val (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (> BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (> BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000)))))))) (nullable.some false) (ite (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_516 Bool) (BOUND_VARIABLE_517 Bool)) (and BOUND_VARIABLE_516 BOUND_VARIABLE_517)) (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (> BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (> BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000))))) (as nullable.null (Nullable Bool))))))) (nullable.some true) (ite (and (nullable.is_some (nullable.some (not (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_524 Int) (BOUND_VARIABLE_525 Int)) (> BOUND_VARIABLE_524 BOUND_VARIABLE_525)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_524 Int) (BOUND_VARIABLE_525 Int)) (> BOUND_VARIABLE_524 BOUND_VARIABLE_525)) ((_ tuple.select 6) t) (nullable.some 1000))))))) (nullable.val (nullable.some (not (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_524 Int) (BOUND_VARIABLE_525 Int)) (> BOUND_VARIABLE_524 BOUND_VARIABLE_525)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_524 Int) (BOUND_VARIABLE_525 Int)) (> BOUND_VARIABLE_524 BOUND_VARIABLE_525)) ((_ tuple.select 6) t) (nullable.some 1000)))))))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_542 Bool) (BOUND_VARIABLE_543 Bool)) (or BOUND_VARIABLE_542 BOUND_VARIABLE_543)) (ite (and (nullable.is_some (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (> BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (> BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000)))))) (not (nullable.val (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (> BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (> BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000)))))))) (nullable.some false) (ite (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_516 Bool) (BOUND_VARIABLE_517 Bool)) (and BOUND_VARIABLE_516 BOUND_VARIABLE_517)) (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (> BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (> BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000))))) (as nullable.null (Nullable Bool))))) (nullable.some (not (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_524 Int) (BOUND_VARIABLE_525 Int)) (> BOUND_VARIABLE_524 BOUND_VARIABLE_525)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_524 Int) (BOUND_VARIABLE_525 Int)) (> BOUND_VARIABLE_524 BOUND_VARIABLE_525)) ((_ tuple.select 6) t) (nullable.some 1000)))))))))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_558 Bool)) (not BOUND_VARIABLE_558)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_558 Bool)) (not BOUND_VARIABLE_558)) ((_ tuple.select 0) t)))))))
(assert (= q1 ((_ table.project 0) (bag.filter p1 (bag.map f0 EMP)))))
(assert (= q2 ((_ table.project 0) (bag.filter p3 (bag.map f2 EMP)))))
(check-sat)
;answer: sat
; duration: 515 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (as nullable.null (Nullable Int)) (nullable.some (- 2)) (nullable.some 3)) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some false)) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Bool))))
; insert into EMP values(0,NULL,'',1,-1,2,NULL,-2,3)
; SELECT * FROM (SELECT * FROM (SELECT CASE WHEN EMP.SAL > 1000 THEN NULL ELSE FALSE END AS CASECOL FROM EMP AS EMP) AS t WHERE NOT t.CASECOL) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT CASE WHEN EMP0.SAL > 1000 THEN NULL ELSE TRUE END AS CASECOL FROM EMP AS EMP0) AS t1 WHERE NOT t1.CASECOL) AS q2;
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
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_464 String) (BOUND_VARIABLE_465 String)) (= BOUND_VARIABLE_464 BOUND_VARIABLE_465)) ((_ tuple.select 2) t) ((_ tuple.select 1) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_464 String) (BOUND_VARIABLE_465 String)) (= BOUND_VARIABLE_464 BOUND_VARIABLE_465)) ((_ tuple.select 2) t) ((_ tuple.select 1) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_547 String) (BOUND_VARIABLE_548 String)) (= BOUND_VARIABLE_547 BOUND_VARIABLE_548)) ((_ tuple.select 1) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_547 String) (BOUND_VARIABLE_548 String)) (= BOUND_VARIABLE_547 BOUND_VARIABLE_548)) ((_ tuple.select 1) t) ((_ tuple.select 10) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_571 Bool) (BOUND_VARIABLE_572 Bool)) (and BOUND_VARIABLE_571 BOUND_VARIABLE_572)) (nullable.lift (lambda ((BOUND_VARIABLE_547 String) (BOUND_VARIABLE_548 String)) (= BOUND_VARIABLE_547 BOUND_VARIABLE_548)) ((_ tuple.select 1) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_547 String) (BOUND_VARIABLE_548 String)) (= BOUND_VARIABLE_547 BOUND_VARIABLE_548)) ((_ tuple.select 1) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_547 String) (BOUND_VARIABLE_548 String)) (= BOUND_VARIABLE_547 BOUND_VARIABLE_548)) ((_ tuple.select 1) t) ((_ tuple.select 10) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_571 Bool) (BOUND_VARIABLE_572 Bool)) (and BOUND_VARIABLE_571 BOUND_VARIABLE_572)) (nullable.lift (lambda ((BOUND_VARIABLE_547 String) (BOUND_VARIABLE_548 String)) (= BOUND_VARIABLE_547 BOUND_VARIABLE_548)) ((_ tuple.select 1) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))))))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 2) t)))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_724 String) (BOUND_VARIABLE_725 String)) (= BOUND_VARIABLE_724 BOUND_VARIABLE_725)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_724 String) (BOUND_VARIABLE_725 String)) (= BOUND_VARIABLE_724 BOUND_VARIABLE_725)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_732 Int) (BOUND_VARIABLE_733 Int)) (= BOUND_VARIABLE_732 BOUND_VARIABLE_733)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_732 Int) (BOUND_VARIABLE_733 Int)) (= BOUND_VARIABLE_732 BOUND_VARIABLE_733)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_746 Bool) (BOUND_VARIABLE_747 Bool)) (and BOUND_VARIABLE_746 BOUND_VARIABLE_747)) (nullable.lift (lambda ((BOUND_VARIABLE_724 String) (BOUND_VARIABLE_725 String)) (= BOUND_VARIABLE_724 BOUND_VARIABLE_725)) ((_ tuple.select 9) t) ((_ tuple.select 12) t)) (nullable.lift (lambda ((BOUND_VARIABLE_732 Int) (BOUND_VARIABLE_733 Int)) (= BOUND_VARIABLE_732 BOUND_VARIABLE_733)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_724 String) (BOUND_VARIABLE_725 String)) (= BOUND_VARIABLE_724 BOUND_VARIABLE_725)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_724 String) (BOUND_VARIABLE_725 String)) (= BOUND_VARIABLE_724 BOUND_VARIABLE_725)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_732 Int) (BOUND_VARIABLE_733 Int)) (= BOUND_VARIABLE_732 BOUND_VARIABLE_733)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_732 Int) (BOUND_VARIABLE_733 Int)) (= BOUND_VARIABLE_732 BOUND_VARIABLE_733)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_746 Bool) (BOUND_VARIABLE_747 Bool)) (and BOUND_VARIABLE_746 BOUND_VARIABLE_747)) (nullable.lift (lambda ((BOUND_VARIABLE_724 String) (BOUND_VARIABLE_725 String)) (= BOUND_VARIABLE_724 BOUND_VARIABLE_725)) ((_ tuple.select 9) t) ((_ tuple.select 12) t)) (nullable.lift (lambda ((BOUND_VARIABLE_732 Int) (BOUND_VARIABLE_733 Int)) (= BOUND_VARIABLE_732 BOUND_VARIABLE_733)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))))))))
(assert (= q1 ((_ table.project 6) (bag.filter p2 (table.product EMP ((_ table.project 0 1) ((_ table.project 0 2) (bag.filter p1 (bag.map f0 DEPT)))))))))
(assert (= q2 ((_ table.project 6) (bag.filter p5 (table.product (bag.map f3 EMP) (bag.map f4 DEPT))))))
(check-sat)
;answer: sat
; duration: 1342 ms.
(get-model)
; (
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 0) (nullable.some "")) 1))
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some (- 3))) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some (- 2))) 1)
; insert into DEPT values(0,'')
; insert into EMP values(0,NULL,'',1,-1,2,-2,3,-3)
; SELECT * FROM (SELECT EMP.SAL FROM EMP AS EMP WHERE EMP.EMPNO IN (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE EMP.ENAME = DEPT.NAME)) AS q1 EXCEPT ALL SELECT * FROM (SELECT EMP0.SAL FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.JOB = DEPT0.NAME AND EMP0.EMPNO = DEPT0.DEPTNO) AS q2;

; SELECT * FROM (SELECT EMP0.SAL FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.JOB = DEPT0.NAME AND EMP0.EMPNO = DEPT0.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.SAL FROM EMP AS EMP WHERE EMP.EMPNO IN (SELECT DEPT.DEPTNO FROM DEPT AS DEPT WHERE EMP.ENAME = DEPT.NAME)) AS q1;
;(-2)

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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_368 Int) (BOUND_VARIABLE_369 Int)) (> BOUND_VARIABLE_368 BOUND_VARIABLE_369)) (nullable.lift (lambda ((BOUND_VARIABLE_352 Int) (BOUND_VARIABLE_353 Int)) (+ BOUND_VARIABLE_352 BOUND_VARIABLE_353)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_362 Int) (BOUND_VARIABLE_363 Int)) (+ BOUND_VARIABLE_362 BOUND_VARIABLE_363)) (nullable.some 3) (as nullable.null (Nullable Int))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_368 Int) (BOUND_VARIABLE_369 Int)) (> BOUND_VARIABLE_368 BOUND_VARIABLE_369)) (nullable.lift (lambda ((BOUND_VARIABLE_352 Int) (BOUND_VARIABLE_353 Int)) (+ BOUND_VARIABLE_352 BOUND_VARIABLE_353)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_362 Int) (BOUND_VARIABLE_363 Int)) (+ BOUND_VARIABLE_362 BOUND_VARIABLE_363)) (nullable.some 3) (as nullable.null (Nullable Int)))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (>= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) (nullable.lift (lambda ((BOUND_VARIABLE_432 Int) (BOUND_VARIABLE_433 Int)) (+ BOUND_VARIABLE_432 BOUND_VARIABLE_433)) (nullable.some 1) (nullable.some 2)) (nullable.some 3))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (>= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) (nullable.lift (lambda ((BOUND_VARIABLE_432 Int) (BOUND_VARIABLE_433 Int)) (+ BOUND_VARIABLE_432 BOUND_VARIABLE_433)) (nullable.some 1) (nullable.some 2)) (nullable.some 3)))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 (bag (tuple (nullable.some 1) (nullable.some 3)) 1)))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p1 (bag (tuple (nullable.some 1) (nullable.some 2)) 1)))))
(check-sat)
;answer: sat
; duration: 27 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 1) (nullable.some 2)) 1)
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 3) t) (nullable.some 11))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 3) t) (nullable.some 11)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_466 Int) (BOUND_VARIABLE_467 Int)) (= BOUND_VARIABLE_466 BOUND_VARIABLE_467)) ((_ tuple.select 3) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_466 Int) (BOUND_VARIABLE_467 Int)) (= BOUND_VARIABLE_466 BOUND_VARIABLE_467)) ((_ tuple.select 3) t) (nullable.some 10)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 10)))))
(assert (= q1 ((_ table.project 3) (bag.filter p0 EMP))))
(assert (= q2 (bag.map f2 (bag.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 108 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 11) (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3)) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 11)) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; insert into EMP values(0,NULL,'',11,1,-1,2,-2,3)
; SELECT * FROM (SELECT EMP.MGR FROM EMP AS EMP WHERE EMP.MGR = 11) AS q1 EXCEPT ALL SELECT * FROM (SELECT 10 AS MGR FROM EMP AS EMP0 WHERE EMP0.MGR = 10) AS q2;
;(11)

; SELECT * FROM (SELECT 10 AS MGR FROM EMP AS EMP0 WHERE EMP0.MGR = 10) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.MGR FROM EMP AS EMP WHERE EMP.MGR = 11) AS q1;

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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f5 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (>= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (>= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (= BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (= BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_532 Int) (BOUND_VARIABLE_533 Int)) (> BOUND_VARIABLE_532 BOUND_VARIABLE_533)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_532 Int) (BOUND_VARIABLE_533 Int)) (> BOUND_VARIABLE_532 BOUND_VARIABLE_533)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_551 Int) (BOUND_VARIABLE_552 Int)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_551 Int) (BOUND_VARIABLE_552 Int)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f2 (bag.filter p1 (table.product ((_ table.project 5) (bag.filter p0 EMP)) EMP)))))
(assert (= q2 (bag.map f5 (bag.filter p4 (table.product ((_ table.project 5) (bag.filter p3 EMP)) EMP)))))
(check-sat)
;answer: sat
; duration: 710 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some (- 1)) (nullable.some 2) (nullable.some 7) (nullable.some (- 2)) (nullable.some 7) (nullable.some 3)) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 1)) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; insert into EMP values(0,NULL,'',-1,2,7,-2,7,3)
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (>= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (>= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_518 Int) (BOUND_VARIABLE_519 Int)) (= BOUND_VARIABLE_518 BOUND_VARIABLE_519)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_518 Int) (BOUND_VARIABLE_519 Int)) (= BOUND_VARIABLE_518 BOUND_VARIABLE_519)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_629 Int) (BOUND_VARIABLE_630 Int)) (= BOUND_VARIABLE_629 BOUND_VARIABLE_630)) ((_ tuple.select 16) t) ((_ tuple.select 25) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_629 Int) (BOUND_VARIABLE_630 Int)) (= BOUND_VARIABLE_629 BOUND_VARIABLE_630)) ((_ tuple.select 16) t) ((_ tuple.select 25) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_667 Int) (BOUND_VARIABLE_668 Int)) (> BOUND_VARIABLE_667 BOUND_VARIABLE_668)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_667 Int) (BOUND_VARIABLE_668 Int)) (> BOUND_VARIABLE_667 BOUND_VARIABLE_668)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_684 Int) (BOUND_VARIABLE_685 Int)) (> BOUND_VARIABLE_684 BOUND_VARIABLE_685)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_684 Int) (BOUND_VARIABLE_685 Int)) (> BOUND_VARIABLE_684 BOUND_VARIABLE_685)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_703 Int) (BOUND_VARIABLE_704 Int)) (= BOUND_VARIABLE_703 BOUND_VARIABLE_704)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_703 Int) (BOUND_VARIABLE_704 Int)) (= BOUND_VARIABLE_703 BOUND_VARIABLE_704)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_719 Int) (BOUND_VARIABLE_720 Int)) (> BOUND_VARIABLE_719 BOUND_VARIABLE_720)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_719 Int) (BOUND_VARIABLE_720 Int)) (> BOUND_VARIABLE_719 BOUND_VARIABLE_720)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_738 Int) (BOUND_VARIABLE_739 Int)) (= BOUND_VARIABLE_738 BOUND_VARIABLE_739)) ((_ tuple.select 16) t) ((_ tuple.select 25) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_738 Int) (BOUND_VARIABLE_739 Int)) (= BOUND_VARIABLE_738 BOUND_VARIABLE_739)) ((_ tuple.select 16) t) ((_ tuple.select 25) t)))))))
(assert (= f9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f3 (bag.filter p2 (table.product (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) EMP)) EMP)))))
(assert (= q2 (bag.map f9 (bag.filter p8 (table.product (bag.filter p6 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p7 EMP)))))))
(check-sat)
;answer: sat
; duration: 8652 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some 7) (nullable.some (- 3))) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 1)) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; insert into EMP values(0,NULL,'',-1,2,-2,3,7,-3)
; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO >= 7) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO INNER JOIN EMP AS EMP1 ON EMP0.DEPTNO = EMP1.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO INNER JOIN (SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO > 7) AS t3 ON t2.DEPTNO = t3.DEPTNO) AS q2;
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (distinct BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (distinct BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_588 Bool) (BOUND_VARIABLE_589 Bool)) (and BOUND_VARIABLE_588 BOUND_VARIABLE_589)) (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (distinct BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (distinct BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (distinct BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_588 Bool) (BOUND_VARIABLE_589 Bool)) (and BOUND_VARIABLE_588 BOUND_VARIABLE_589)) (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (distinct BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_624 Int) (BOUND_VARIABLE_625 Int)) (= BOUND_VARIABLE_624 BOUND_VARIABLE_625)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_624 Int) (BOUND_VARIABLE_625 Int)) (= BOUND_VARIABLE_624 BOUND_VARIABLE_625)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_643 Int) (BOUND_VARIABLE_644 Int)) (= BOUND_VARIABLE_643 BOUND_VARIABLE_644)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_643 Int) (BOUND_VARIABLE_644 Int)) (= BOUND_VARIABLE_643 BOUND_VARIABLE_644)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)))))))
(assert (= q1 ((_ table.project 1) (bag.filter p0 (table.product (table.product EMP DEPT) EMP)))))
(assert (= q2 ((_ table.project 1) (bag.filter p2 (table.product (bag.filter p1 (table.product EMP DEPT)) EMP)))))
(check-sat)
;answer: sat
; duration: 823 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 1) (nullable.some "A") (as nullable.null (Nullable String)) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some 0) (nullable.some (- 3))) 1))
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 0) (nullable.some "")) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable String))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some "A")) 1)
; insert into EMP values(1,'A',NULL,-1,2,-2,3,0,-3)
; insert into DEPT values(0,'')
; SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO <> EMP0.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.DEPTNO = DEPT0.DEPTNO INNER JOIN EMP AS EMP2 ON DEPT0.DEPTNO = EMP2.DEPTNO) AS q2;

; SELECT * FROM (SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN DEPT AS DEPT0 ON EMP1.DEPTNO = DEPT0.DEPTNO INNER JOIN EMP AS EMP2 ON DEPT0.DEPTNO = EMP2.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO <> EMP0.DEPTNO) AS q1;
;(A)

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
(declare-const q1 (Bag (Tuple (Nullable Bool))))
(declare-const p1 (-> (Tuple (Nullable Bool)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Bool))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_381 Bool)) (not BOUND_VARIABLE_381)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_381 Bool)) (not BOUND_VARIABLE_381)) ((_ tuple.select 0) t)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_402 Bool)) (not BOUND_VARIABLE_402)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_402 Bool)) (not BOUND_VARIABLE_402)) ((_ tuple.select 0) t)))))))
(assert (= q1 ((_ table.project 0) (bag.filter p0 (bag.union_disjoint (bag.union_disjoint (bag (tuple (nullable.some false)) 1) (bag (tuple (nullable.some true)) 1)) (bag (tuple (nullable.some false)) 1))))))
(assert (= q2 ((_ table.project 0) (bag.filter p1 (bag.union_disjoint (bag (tuple (nullable.some false)) 1) (bag (tuple (nullable.some true)) 1))))))
(check-sat)
;answer: sat
; duration: 18 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some false)) 2)
; q2
(get-value (q2))
; (bag (tuple (nullable.some false)) 1)
; SELECT * FROM (SELECT * FROM (VALUES  (FALSE),  (TRUE), (FALSE)) AS t WHERE NOT t.column1) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (VALUES  (FALSE),  (TRUE)) AS t1 WHERE NOT t1.column1) AS q2;
;(false)

; SELECT * FROM (SELECT * FROM (VALUES  (FALSE),  (TRUE)) AS t1 WHERE NOT t1.column1) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (VALUES  (FALSE),  (TRUE), (FALSE)) AS t WHERE NOT t.column1) AS q1;

;Model soundness: true
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (>= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (>= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_518 Int) (BOUND_VARIABLE_519 Int)) (= BOUND_VARIABLE_518 BOUND_VARIABLE_519)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_518 Int) (BOUND_VARIABLE_519 Int)) (= BOUND_VARIABLE_518 BOUND_VARIABLE_519)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_556 Int) (BOUND_VARIABLE_557 Int)) (> BOUND_VARIABLE_556 BOUND_VARIABLE_557)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_556 Int) (BOUND_VARIABLE_557 Int)) (> BOUND_VARIABLE_556 BOUND_VARIABLE_557)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (> BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (> BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_592 Int) (BOUND_VARIABLE_593 Int)) (= BOUND_VARIABLE_592 BOUND_VARIABLE_593)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_592 Int) (BOUND_VARIABLE_593 Int)) (= BOUND_VARIABLE_592 BOUND_VARIABLE_593)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f2 (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) EMP)))))
(assert (= q2 (bag.map f6 (bag.filter p5 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)))))))
(check-sat)
;answer: sat
; duration: 1283 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some 7) (nullable.some (- 3))) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 1)) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; insert into EMP values(0,NULL,'',-1,2,-2,3,7,-3)
; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO >= 7) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO > 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO > 7) AS t2 ON t1.DEPTNO = t2.DEPTNO) AS q2;
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

(declare-const q1 (Bag (Tuple (Nullable String) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable String) (Nullable String))))
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
(assert (= f3 (lambda ((t (Tuple (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_515 String)) (str.to_upper BOUND_VARIABLE_515)) (nullable.lift (lambda ((BOUND_VARIABLE_508 String) (BOUND_VARIABLE_509 String)) (str.++ BOUND_VARIABLE_508 BOUND_VARIABLE_509)) (ite (or (or (nullable.is_null ((_ tuple.select 0) t)) (nullable.is_null (nullable.some 1))) (nullable.is_null (nullable.some 3))) (as nullable.null (Nullable String)) (nullable.some (str.substr (nullable.val ((_ tuple.select 0) t)) 0 3))) (ite (or (nullable.is_null ((_ tuple.select 0) t)) (nullable.is_null (nullable.some 3))) (as nullable.null (Nullable String)) (nullable.some (str.substr (nullable.val ((_ tuple.select 0) t)) 2 (str.len (nullable.val ((_ tuple.select 0) t)))))))) (ite (or (or (nullable.is_null ((_ tuple.select 0) t)) (nullable.is_null (nullable.some 1))) (nullable.is_null (nullable.some 1))) (as nullable.null (Nullable String)) (nullable.some (str.substr (nullable.val ((_ tuple.select 0) t)) 0 1)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable String) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_546 String) (BOUND_VARIABLE_547 String)) (= BOUND_VARIABLE_546 BOUND_VARIABLE_547)) ((_ tuple.select 0) t) (nullable.some "TABLE"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_546 String) (BOUND_VARIABLE_547 String)) (= BOUND_VARIABLE_546 BOUND_VARIABLE_547)) ((_ tuple.select 0) t) (nullable.some "TABLE")))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Bool)))) (tuple (nullable.some "TABLE") (nullable.some "t")))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p4 (bag.map f3 (bag.union_max ((_ table.project 0) (bag.union_max (bag.map f0 (bag (tuple (nullable.some true)) 1)) (bag.map f1 (bag (tuple (nullable.some true)) 1)))) (bag.map f2 (bag (tuple (nullable.some true)) 1))))))))
(assert (= q2 (bag.map f5 (bag (tuple (nullable.some true)) 1))))
(check-sat)
;answer: sat
; duration: 29 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable String) (Nullable String))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some "TABLE") (nullable.some "t")) 1)
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_437 Int) (BOUND_VARIABLE_438 Int)) (= BOUND_VARIABLE_437 BOUND_VARIABLE_438)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_437 Int) (BOUND_VARIABLE_438 Int)) (= BOUND_VARIABLE_437 BOUND_VARIABLE_438)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_470 Bool) (BOUND_VARIABLE_471 Bool) (BOUND_VARIABLE_472 Bool) (BOUND_VARIABLE_473 Bool) (BOUND_VARIABLE_474 Bool)) (and BOUND_VARIABLE_470 BOUND_VARIABLE_471 BOUND_VARIABLE_472 BOUND_VARIABLE_473 BOUND_VARIABLE_474)) (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_437 Int) (BOUND_VARIABLE_438 Int)) (= BOUND_VARIABLE_437 BOUND_VARIABLE_438)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_446 Int) (BOUND_VARIABLE_447 Int)) (= BOUND_VARIABLE_446 BOUND_VARIABLE_447)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some (nullable.is_null ((_ tuple.select 3) t))) (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 0) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_437 Int) (BOUND_VARIABLE_438 Int)) (= BOUND_VARIABLE_437 BOUND_VARIABLE_438)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_437 Int) (BOUND_VARIABLE_438 Int)) (= BOUND_VARIABLE_437 BOUND_VARIABLE_438)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_470 Bool) (BOUND_VARIABLE_471 Bool) (BOUND_VARIABLE_472 Bool) (BOUND_VARIABLE_473 Bool) (BOUND_VARIABLE_474 Bool)) (and BOUND_VARIABLE_470 BOUND_VARIABLE_471 BOUND_VARIABLE_472 BOUND_VARIABLE_473 BOUND_VARIABLE_474)) (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_437 Int) (BOUND_VARIABLE_438 Int)) (= BOUND_VARIABLE_437 BOUND_VARIABLE_438)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_446 Int) (BOUND_VARIABLE_447 Int)) (= BOUND_VARIABLE_446 BOUND_VARIABLE_447)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some (nullable.is_null ((_ tuple.select 3) t))) (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 0) t) (nullable.some 10))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 10) ((_ tuple.select 1) t) ((_ tuple.select 2) t) (as nullable.null (Nullable Int)) ((_ tuple.select 4) t) ((_ tuple.select 6) t) ((_ tuple.select 5) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 (bag.map f2 (bag.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 129 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 10) (as nullable.null (Nullable String)) (nullable.some "") (as nullable.null (Nullable Int)) (nullable.some 0) (nullable.some (- 1)) (nullable.some 1) (nullable.some 7) (nullable.some 2)) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 10) (as nullable.null (Nullable String)) (nullable.some "") (as nullable.null (Nullable Int)) (nullable.some 0) (nullable.some (- 1)) (nullable.some 1) (nullable.some 7) (nullable.some 2)) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; insert into EMP values(10,NULL,'',NULL,0,-1,1,7,2)
; SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 AND EMP.DEPTNO = 7 AND EMP.EMPNO = 10 AND EMP.MGR IS NULL AND EMP.EMPNO = 10) AS q1 EXCEPT ALL SELECT * FROM (SELECT 10 AS EMPNO, t0.ENAME, t0.JOB, CAST(NULL AS INT) AS MGR, t0.HIREDATE, t0.SAL, t0.COMM, t0.DEPTNO, t0.SLACKER FROM (SELECT * FROM EMP WHERE FALSE) AS t0) AS q2;
;(10,NULL,,NULL,0,-1,1,7,2)

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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_null ((_ tuple.select 0) t)) (nullable.is_null ((_ tuple.select 0) t))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int)))) (nullable.is_some ((_ tuple.select 0) t)))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int))))))
(assert (= q1 ((_ table.project 0) (bag.filter p2 ((_ table.project 0) (bag.filter p1 (bag.map f0 EMP)))))))
(assert (= q2 (bag.map f3 EMP)))
(check-sat)
;answer: sat
; duration: 290 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (bag (tuple (as nullable.null (Nullable Int))) 1)
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (>= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (>= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (<= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (<= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_453 Bool) (BOUND_VARIABLE_454 Bool)) (and BOUND_VARIABLE_453 BOUND_VARIABLE_454)) (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (>= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (<= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 0) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (>= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (>= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (<= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (<= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_453 Bool) (BOUND_VARIABLE_454 Bool)) (and BOUND_VARIABLE_453 BOUND_VARIABLE_454)) (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (>= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (<= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 0) t) (nullable.some 10))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= q1 ((_ table.project 0) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0) (bag.filter p1 (bag (tuple (nullable.some 0)) 1)))))
(check-sat)
;answer: sat
; duration: 68 ms.
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

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_574 Int) (BOUND_VARIABLE_575 Int)) (distinct BOUND_VARIABLE_574 BOUND_VARIABLE_575)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_574 Int) (BOUND_VARIABLE_575 Int)) (distinct BOUND_VARIABLE_574 BOUND_VARIABLE_575)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_589 Bool) (BOUND_VARIABLE_590 Bool)) (and BOUND_VARIABLE_589 BOUND_VARIABLE_590)) (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_574 Int) (BOUND_VARIABLE_575 Int)) (distinct BOUND_VARIABLE_574 BOUND_VARIABLE_575)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_574 Int) (BOUND_VARIABLE_575 Int)) (distinct BOUND_VARIABLE_574 BOUND_VARIABLE_575)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_574 Int) (BOUND_VARIABLE_575 Int)) (distinct BOUND_VARIABLE_574 BOUND_VARIABLE_575)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_589 Bool) (BOUND_VARIABLE_590 Bool)) (and BOUND_VARIABLE_589 BOUND_VARIABLE_590)) (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_574 Int) (BOUND_VARIABLE_575 Int)) (distinct BOUND_VARIABLE_574 BOUND_VARIABLE_575)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_625 Int) (BOUND_VARIABLE_626 Int)) (= BOUND_VARIABLE_625 BOUND_VARIABLE_626)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_625 Int) (BOUND_VARIABLE_626 Int)) (= BOUND_VARIABLE_625 BOUND_VARIABLE_626)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_644 Int) (BOUND_VARIABLE_645 Int)) (= BOUND_VARIABLE_644 BOUND_VARIABLE_645)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_644 Int) (BOUND_VARIABLE_645 Int)) (= BOUND_VARIABLE_644 BOUND_VARIABLE_645)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_739 Int) (BOUND_VARIABLE_740 Int)) (= BOUND_VARIABLE_739 BOUND_VARIABLE_740)) ((_ tuple.select 7) t) ((_ tuple.select 20) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_739 Int) (BOUND_VARIABLE_740 Int)) (= BOUND_VARIABLE_739 BOUND_VARIABLE_740)) ((_ tuple.select 7) t) ((_ tuple.select 20) t)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_862 Int) (BOUND_VARIABLE_863 Int)) (= BOUND_VARIABLE_862 BOUND_VARIABLE_863)) ((_ tuple.select 0) t) ((_ tuple.select 22) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_862 Int) (BOUND_VARIABLE_863 Int)) (= BOUND_VARIABLE_862 BOUND_VARIABLE_863)) ((_ tuple.select 0) t) ((_ tuple.select 22) t)))))))
(assert (= q1 ((_ table.project 1) (bag.filter p0 (table.product (table.product EMP DEPT) EMP)))))
(assert (= q2 ((_ table.project 1) (bag.filter p4 (table.product (bag.filter p3 (table.product (bag.filter p2 (table.product (bag.filter p1 (table.product EMP DEPT)) EMP)) DEPT)) EMP)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10071 ms.
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

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (>= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (>= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (tuple (nullable.some 1)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_533 Int) (BOUND_VARIABLE_534 Int)) (= BOUND_VARIABLE_533 BOUND_VARIABLE_534)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_533 Int) (BOUND_VARIABLE_534 Int)) (= BOUND_VARIABLE_533 BOUND_VARIABLE_534)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f1 (bag.filter p0 (table.product EMP DEPT)))))
(assert (= q2 (bag.map f3 (bag.filter p2 (table.product EMP DEPT)))))
(check-sat)
;answer: sat
; duration: 277 ms.
(get-model)
; (
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 0) (nullable.some "A")) 1))
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some (- 1)) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some (- 3)) (nullable.some 1) (nullable.some 4)) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 1)) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; insert into DEPT values(0,'A')
; insert into EMP values(-1,NULL,'',2,-2,3,-3,1,4)
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_481 Int) (BOUND_VARIABLE_482 Int)) (= BOUND_VARIABLE_481 BOUND_VARIABLE_482)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_481 Int) (BOUND_VARIABLE_482 Int)) (= BOUND_VARIABLE_481 BOUND_VARIABLE_482)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (> BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (> BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_568 Int) (BOUND_VARIABLE_569 Int)) (>= BOUND_VARIABLE_568 BOUND_VARIABLE_569)) ((_ tuple.select 16) t) (nullable.some 9))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_568 Int) (BOUND_VARIABLE_569 Int)) (>= BOUND_VARIABLE_568 BOUND_VARIABLE_569)) ((_ tuple.select 16) t) (nullable.some 9))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_583 Bool) (BOUND_VARIABLE_584 Bool)) (and BOUND_VARIABLE_583 BOUND_VARIABLE_584)) (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (> BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_568 Int) (BOUND_VARIABLE_569 Int)) (>= BOUND_VARIABLE_568 BOUND_VARIABLE_569)) ((_ tuple.select 16) t) (nullable.some 9)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (> BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (> BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_568 Int) (BOUND_VARIABLE_569 Int)) (>= BOUND_VARIABLE_568 BOUND_VARIABLE_569)) ((_ tuple.select 16) t) (nullable.some 9))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_568 Int) (BOUND_VARIABLE_569 Int)) (>= BOUND_VARIABLE_568 BOUND_VARIABLE_569)) ((_ tuple.select 16) t) (nullable.some 9))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_583 Bool) (BOUND_VARIABLE_584 Bool)) (and BOUND_VARIABLE_583 BOUND_VARIABLE_584)) (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (> BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_568 Int) (BOUND_VARIABLE_569 Int)) (>= BOUND_VARIABLE_568 BOUND_VARIABLE_569)) ((_ tuple.select 16) t) (nullable.some 9))))))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_624 Int) (BOUND_VARIABLE_625 Int)) (= BOUND_VARIABLE_624 BOUND_VARIABLE_625)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_624 Int) (BOUND_VARIABLE_625 Int)) (= BOUND_VARIABLE_624 BOUND_VARIABLE_625)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= leftJoin6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_678 Int) (BOUND_VARIABLE_679 Int)) (> BOUND_VARIABLE_678 BOUND_VARIABLE_679)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_678 Int) (BOUND_VARIABLE_679 Int)) (> BOUND_VARIABLE_678 BOUND_VARIABLE_679)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_685 Int) (BOUND_VARIABLE_686 Int)) (> BOUND_VARIABLE_685 BOUND_VARIABLE_686)) ((_ tuple.select 16) t) (nullable.some 9))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_685 Int) (BOUND_VARIABLE_686 Int)) (> BOUND_VARIABLE_685 BOUND_VARIABLE_686)) ((_ tuple.select 16) t) (nullable.some 9))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_699 Bool) (BOUND_VARIABLE_700 Bool)) (and BOUND_VARIABLE_699 BOUND_VARIABLE_700)) (nullable.lift (lambda ((BOUND_VARIABLE_678 Int) (BOUND_VARIABLE_679 Int)) (> BOUND_VARIABLE_678 BOUND_VARIABLE_679)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_685 Int) (BOUND_VARIABLE_686 Int)) (> BOUND_VARIABLE_685 BOUND_VARIABLE_686)) ((_ tuple.select 16) t) (nullable.some 9)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_678 Int) (BOUND_VARIABLE_679 Int)) (> BOUND_VARIABLE_678 BOUND_VARIABLE_679)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_678 Int) (BOUND_VARIABLE_679 Int)) (> BOUND_VARIABLE_678 BOUND_VARIABLE_679)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_685 Int) (BOUND_VARIABLE_686 Int)) (> BOUND_VARIABLE_685 BOUND_VARIABLE_686)) ((_ tuple.select 16) t) (nullable.some 9))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_685 Int) (BOUND_VARIABLE_686 Int)) (> BOUND_VARIABLE_685 BOUND_VARIABLE_686)) ((_ tuple.select 16) t) (nullable.some 9))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_699 Bool) (BOUND_VARIABLE_700 Bool)) (and BOUND_VARIABLE_699 BOUND_VARIABLE_700)) (nullable.lift (lambda ((BOUND_VARIABLE_678 Int) (BOUND_VARIABLE_679 Int)) (> BOUND_VARIABLE_678 BOUND_VARIABLE_679)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_685 Int) (BOUND_VARIABLE_686 Int)) (> BOUND_VARIABLE_685 BOUND_VARIABLE_686)) ((_ tuple.select 16) t) (nullable.some 9))))))))))
(assert (= f9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f4 (bag.filter p3 (bag.union_disjoint (bag.union_disjoint (bag.map leftJoin1 (bag.difference_remove EMP ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 (table.product EMP EMP))))) (bag.map rightJoin2 (bag.difference_remove EMP ((_ table.project 9 10 11 12 13 14 15 16 17) (bag.filter p0 (table.product EMP EMP)))))) (bag.filter p0 (table.product EMP EMP)))))))
(assert (= q2 (bag.map f9 (bag.filter p8 (bag.union_disjoint (bag.union_disjoint (bag.map leftJoin6 (bag.difference_remove EMP ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 (table.product EMP EMP))))) (bag.map rightJoin7 (bag.difference_remove EMP ((_ table.project 9 10 11 12 13 14 15 16 17) (bag.filter p5 (table.product EMP EMP)))))) (bag.filter p5 (table.product EMP EMP)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 33942 ms.
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const f7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const f8 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)) Bool))
(declare-const p9 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f5 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_491 Int) (BOUND_VARIABLE_492 Int)) (= BOUND_VARIABLE_491 BOUND_VARIABLE_492)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_491 Int) (BOUND_VARIABLE_492 Int)) (= BOUND_VARIABLE_491 BOUND_VARIABLE_492)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 1) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_583 String) (BOUND_VARIABLE_584 String)) (= BOUND_VARIABLE_583 BOUND_VARIABLE_584)) ((_ tuple.select 9) t) ((_ tuple.select 1) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_583 String) (BOUND_VARIABLE_584 String)) (= BOUND_VARIABLE_583 BOUND_VARIABLE_584)) ((_ tuple.select 9) t) ((_ tuple.select 1) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_654 String) (BOUND_VARIABLE_655 String)) (= BOUND_VARIABLE_654 BOUND_VARIABLE_655)) ((_ tuple.select 1) t) ((_ tuple.select 11) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_654 String) (BOUND_VARIABLE_655 String)) (= BOUND_VARIABLE_654 BOUND_VARIABLE_655)) ((_ tuple.select 1) t) ((_ tuple.select 11) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_662 Int) (BOUND_VARIABLE_663 Int)) (= BOUND_VARIABLE_662 BOUND_VARIABLE_663)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_662 Int) (BOUND_VARIABLE_663 Int)) (= BOUND_VARIABLE_662 BOUND_VARIABLE_663)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_677 Bool) (BOUND_VARIABLE_678 Bool)) (and BOUND_VARIABLE_677 BOUND_VARIABLE_678)) (nullable.lift (lambda ((BOUND_VARIABLE_654 String) (BOUND_VARIABLE_655 String)) (= BOUND_VARIABLE_654 BOUND_VARIABLE_655)) ((_ tuple.select 1) t) ((_ tuple.select 11) t)) (nullable.lift (lambda ((BOUND_VARIABLE_662 Int) (BOUND_VARIABLE_663 Int)) (= BOUND_VARIABLE_662 BOUND_VARIABLE_663)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_654 String) (BOUND_VARIABLE_655 String)) (= BOUND_VARIABLE_654 BOUND_VARIABLE_655)) ((_ tuple.select 1) t) ((_ tuple.select 11) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_654 String) (BOUND_VARIABLE_655 String)) (= BOUND_VARIABLE_654 BOUND_VARIABLE_655)) ((_ tuple.select 1) t) ((_ tuple.select 11) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_662 Int) (BOUND_VARIABLE_663 Int)) (= BOUND_VARIABLE_662 BOUND_VARIABLE_663)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_662 Int) (BOUND_VARIABLE_663 Int)) (= BOUND_VARIABLE_662 BOUND_VARIABLE_663)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_677 Bool) (BOUND_VARIABLE_678 Bool)) (and BOUND_VARIABLE_677 BOUND_VARIABLE_678)) (nullable.lift (lambda ((BOUND_VARIABLE_654 String) (BOUND_VARIABLE_655 String)) (= BOUND_VARIABLE_654 BOUND_VARIABLE_655)) ((_ tuple.select 1) t) ((_ tuple.select 11) t)) (nullable.lift (lambda ((BOUND_VARIABLE_662 Int) (BOUND_VARIABLE_663 Int)) (= BOUND_VARIABLE_662 BOUND_VARIABLE_663)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 2) t)))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_797 String) (BOUND_VARIABLE_798 String)) (= BOUND_VARIABLE_797 BOUND_VARIABLE_798)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_797 String) (BOUND_VARIABLE_798 String)) (= BOUND_VARIABLE_797 BOUND_VARIABLE_798)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_805 Int) (BOUND_VARIABLE_806 Int)) (= BOUND_VARIABLE_805 BOUND_VARIABLE_806)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_805 Int) (BOUND_VARIABLE_806 Int)) (= BOUND_VARIABLE_805 BOUND_VARIABLE_806)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_819 Bool) (BOUND_VARIABLE_820 Bool)) (and BOUND_VARIABLE_819 BOUND_VARIABLE_820)) (nullable.lift (lambda ((BOUND_VARIABLE_797 String) (BOUND_VARIABLE_798 String)) (= BOUND_VARIABLE_797 BOUND_VARIABLE_798)) ((_ tuple.select 9) t) ((_ tuple.select 12) t)) (nullable.lift (lambda ((BOUND_VARIABLE_805 Int) (BOUND_VARIABLE_806 Int)) (= BOUND_VARIABLE_805 BOUND_VARIABLE_806)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_797 String) (BOUND_VARIABLE_798 String)) (= BOUND_VARIABLE_797 BOUND_VARIABLE_798)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_797 String) (BOUND_VARIABLE_798 String)) (= BOUND_VARIABLE_797 BOUND_VARIABLE_798)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_805 Int) (BOUND_VARIABLE_806 Int)) (= BOUND_VARIABLE_805 BOUND_VARIABLE_806)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_805 Int) (BOUND_VARIABLE_806 Int)) (= BOUND_VARIABLE_805 BOUND_VARIABLE_806)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_819 Bool) (BOUND_VARIABLE_820 Bool)) (and BOUND_VARIABLE_819 BOUND_VARIABLE_820)) (nullable.lift (lambda ((BOUND_VARIABLE_797 String) (BOUND_VARIABLE_798 String)) (= BOUND_VARIABLE_797 BOUND_VARIABLE_798)) ((_ tuple.select 9) t) ((_ tuple.select 12) t)) (nullable.lift (lambda ((BOUND_VARIABLE_805 Int) (BOUND_VARIABLE_806 Int)) (= BOUND_VARIABLE_805 BOUND_VARIABLE_806)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))))))))
(assert (= f7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 10) t) ((_ tuple.select 11) t) ((_ tuple.select 1) t)))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_972 String) (BOUND_VARIABLE_973 String)) (= BOUND_VARIABLE_972 BOUND_VARIABLE_973)) ((_ tuple.select 11) t) ((_ tuple.select 14) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_972 String) (BOUND_VARIABLE_973 String)) (= BOUND_VARIABLE_972 BOUND_VARIABLE_973)) ((_ tuple.select 11) t) ((_ tuple.select 14) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_980 Int) (BOUND_VARIABLE_981 Int)) (= BOUND_VARIABLE_980 BOUND_VARIABLE_981)) ((_ tuple.select 0) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_980 Int) (BOUND_VARIABLE_981 Int)) (= BOUND_VARIABLE_980 BOUND_VARIABLE_981)) ((_ tuple.select 0) t) ((_ tuple.select 12) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_994 Bool) (BOUND_VARIABLE_995 Bool)) (and BOUND_VARIABLE_994 BOUND_VARIABLE_995)) (nullable.lift (lambda ((BOUND_VARIABLE_972 String) (BOUND_VARIABLE_973 String)) (= BOUND_VARIABLE_972 BOUND_VARIABLE_973)) ((_ tuple.select 11) t) ((_ tuple.select 14) t)) (nullable.lift (lambda ((BOUND_VARIABLE_980 Int) (BOUND_VARIABLE_981 Int)) (= BOUND_VARIABLE_980 BOUND_VARIABLE_981)) ((_ tuple.select 0) t) ((_ tuple.select 12) t)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_972 String) (BOUND_VARIABLE_973 String)) (= BOUND_VARIABLE_972 BOUND_VARIABLE_973)) ((_ tuple.select 11) t) ((_ tuple.select 14) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_972 String) (BOUND_VARIABLE_973 String)) (= BOUND_VARIABLE_972 BOUND_VARIABLE_973)) ((_ tuple.select 11) t) ((_ tuple.select 14) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_980 Int) (BOUND_VARIABLE_981 Int)) (= BOUND_VARIABLE_980 BOUND_VARIABLE_981)) ((_ tuple.select 0) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_980 Int) (BOUND_VARIABLE_981 Int)) (= BOUND_VARIABLE_980 BOUND_VARIABLE_981)) ((_ tuple.select 0) t) ((_ tuple.select 12) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_994 Bool) (BOUND_VARIABLE_995 Bool)) (and BOUND_VARIABLE_994 BOUND_VARIABLE_995)) (nullable.lift (lambda ((BOUND_VARIABLE_972 String) (BOUND_VARIABLE_973 String)) (= BOUND_VARIABLE_972 BOUND_VARIABLE_973)) ((_ tuple.select 11) t) ((_ tuple.select 14) t)) (nullable.lift (lambda ((BOUND_VARIABLE_980 Int) (BOUND_VARIABLE_981 Int)) (= BOUND_VARIABLE_980 BOUND_VARIABLE_981)) ((_ tuple.select 0) t) ((_ tuple.select 12) t))))))))))
(assert (= q1 ((_ table.project 6) (bag.filter p3 (table.product (bag.filter p0 (table.product EMP ((_ table.project 0) ((_ table.project 0) DEPT)))) ((_ table.project 0 1) ((_ table.project 0 9) (bag.filter p2 (bag.map f1 EMP)))))))))
(assert (= q2 ((_ table.project 6) (bag.filter p9 (table.product (bag.map f7 (bag.filter p6 (table.product (bag.map f4 EMP) (bag.map f5 DEPT)))) (bag.map f8 EMP))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10728 ms.
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

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Bag (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_395 Int) (BOUND_VARIABLE_396 Int)) (= BOUND_VARIABLE_395 BOUND_VARIABLE_396)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_395 Int) (BOUND_VARIABLE_396 Int)) (= BOUND_VARIABLE_395 BOUND_VARIABLE_396)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_433 Int) (BOUND_VARIABLE_434 Int)) (= BOUND_VARIABLE_433 BOUND_VARIABLE_434)) ((_ tuple.select 0) t) (nullable.some 11))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_433 Int) (BOUND_VARIABLE_434 Int)) (= BOUND_VARIABLE_433 BOUND_VARIABLE_434)) ((_ tuple.select 0) t) (nullable.some 11)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_463 Int) (BOUND_VARIABLE_464 Int)) (= BOUND_VARIABLE_463 BOUND_VARIABLE_464)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_463 Int) (BOUND_VARIABLE_464 Int)) (= BOUND_VARIABLE_463 BOUND_VARIABLE_464)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= q1 ((_ table.project 1) (bag.filter p1 ((_ table.project 0 1) (bag.filter p0 DEPT))))))
(assert (= q2 ((_ table.project 1) (bag.filter p2 DEPT))))
(check-sat)
;answer: sat
; duration: 213 ms.
(get-model)
; (
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 10) (as nullable.null (Nullable String))) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable String))))
; q2
(get-value (q2))
; (bag (tuple (as nullable.null (Nullable String))) 1)
; insert into DEPT values(10,NULL)
; SELECT * FROM (SELECT t.NAME FROM (SELECT * FROM DEPT AS DEPT WHERE DEPT.DEPTNO = 10) AS t WHERE t.DEPTNO = 11) AS q1 EXCEPT ALL SELECT * FROM (SELECT DEPT0.NAME FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO = 10) AS q2;

; SELECT * FROM (SELECT DEPT0.NAME FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO = 10) AS q2 EXCEPT ALL SELECT * FROM (SELECT t.NAME FROM (SELECT * FROM DEPT AS DEPT WHERE DEPT.DEPTNO = 10) AS t WHERE t.DEPTNO = 11) AS q1;
;(NULL)

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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= q1 ((_ table.project 6) (bag.union_disjoint ((_ table.project 0 1 2 3 4 5 6 7 8) EMP) ((_ table.project 0 1 2 3 4 5 6 7 8) EMP)))))
(assert (= q2 (bag.union_max ((_ table.project 6) EMP) ((_ table.project 6) EMP))))
(check-sat)
;answer: sat
; duration: 542 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (as nullable.null (Nullable Int)) (nullable.some (- 2)) (nullable.some 3)) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (as nullable.null (Nullable Int))) 2)
; q2
(get-value (q2))
; (bag (tuple (as nullable.null (Nullable Int))) 1)
; insert into EMP values(0,NULL,'',1,-1,2,NULL,-2,3)
; SELECT * FROM (SELECT t.SAL FROM (SELECT * FROM EMP AS EMP UNION ALL SELECT * FROM EMP AS EMP0) AS t) AS q1 EXCEPT ALL SELECT * FROM (SELECT EMP1.SAL FROM EMP AS EMP1 UNION SELECT EMP2.SAL FROM EMP AS EMP2) AS q2;
;(NULL)

; SELECT * FROM (SELECT EMP1.SAL FROM EMP AS EMP1 UNION SELECT EMP2.SAL FROM EMP AS EMP2) AS q2 EXCEPT ALL SELECT * FROM (SELECT t.SAL FROM (SELECT * FROM EMP AS EMP UNION ALL SELECT * FROM EMP AS EMP0) AS t) AS q1;

;Model soundness: true
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_452 Int) (BOUND_VARIABLE_453 Int)) (= BOUND_VARIABLE_452 BOUND_VARIABLE_453)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_452 Int) (BOUND_VARIABLE_453 Int)) (= BOUND_VARIABLE_452 BOUND_VARIABLE_453)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_471 Int) (BOUND_VARIABLE_472 Int)) (= BOUND_VARIABLE_471 BOUND_VARIABLE_472)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_471 Int) (BOUND_VARIABLE_472 Int)) (= BOUND_VARIABLE_471 BOUND_VARIABLE_472)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_491 Int) (BOUND_VARIABLE_492 Int)) (= BOUND_VARIABLE_491 BOUND_VARIABLE_492)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_491 Int) (BOUND_VARIABLE_492 Int)) (= BOUND_VARIABLE_491 BOUND_VARIABLE_492)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_527 Int) (BOUND_VARIABLE_528 Int)) (= BOUND_VARIABLE_527 BOUND_VARIABLE_528)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_527 Int) (BOUND_VARIABLE_528 Int)) (= BOUND_VARIABLE_527 BOUND_VARIABLE_528)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)))))))
(assert (= q2 (bag.difference_subtract ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)))))))
(check-sat)
;answer: sat
; duration: 904 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag.union_disjoint (bag (tuple (nullable.some (- 3)) (nullable.some "A") (nullable.some "B") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 30) (nullable.some 6)) 1) (bag.union_disjoint (bag (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 10) (nullable.some 3)) 1) (bag.union_disjoint (bag (tuple (nullable.some (- 6)) (nullable.some "C") (nullable.some "D") (nullable.some 7) (nullable.some (- 7)) (nullable.some 8) (nullable.some (- 8)) (nullable.some 30) (nullable.some 9)) 1) (bag (tuple (nullable.some (- 9)) (nullable.some "E") (nullable.some "F") (nullable.some (- 10)) (nullable.some 11) (nullable.some (- 11)) (nullable.some 12) (nullable.some 30) (nullable.some (- 12))) 1)))))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 10) (nullable.some 3)) 1)
; insert into EMP values(-3,'A','B',4,-4,5,-5,30,6),(0,NULL,'',1,-1,2,-2,10,3),(-6,'C','D',7,-7,8,-8,30,9),(-9,'E','F',-10,11,-11,12,30,-12)
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_507 Int) (BOUND_VARIABLE_508 Int)) (= BOUND_VARIABLE_507 BOUND_VARIABLE_508)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_507 Int) (BOUND_VARIABLE_508 Int)) (= BOUND_VARIABLE_507 BOUND_VARIABLE_508)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) DEPT)))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some "")) 1))))
(check-sat)
;answer: sat
; duration: 2917 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))))
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String)))))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some "")) 1)
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (ite (and (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 0) t)))) (not (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 0) t)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_449 Bool) (BOUND_VARIABLE_450 Bool)) (and BOUND_VARIABLE_449 BOUND_VARIABLE_450)) (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some (nullable.is_null ((_ tuple.select 0) t))))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (ite (and (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 0) t)))) (not (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 0) t)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_449 Bool) (BOUND_VARIABLE_450 Bool)) (and BOUND_VARIABLE_449 BOUND_VARIABLE_450)) (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some (nullable.is_null ((_ tuple.select 0) t)))))))))))
(assert (= q1 ((_ table.project 0) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0) (bag (tuple (nullable.some 0)) 1))))
(check-sat)
;answer: sat
; duration: 64 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 0)) 1)
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_518 Int) (BOUND_VARIABLE_519 Int)) (= BOUND_VARIABLE_518 BOUND_VARIABLE_519)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_518 Int) (BOUND_VARIABLE_519 Int)) (= BOUND_VARIABLE_518 BOUND_VARIABLE_519)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_556 Int) (BOUND_VARIABLE_557 Int)) (>= BOUND_VARIABLE_556 BOUND_VARIABLE_557)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_556 Int) (BOUND_VARIABLE_557 Int)) (>= BOUND_VARIABLE_556 BOUND_VARIABLE_557)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (>= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (>= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_592 Int) (BOUND_VARIABLE_593 Int)) (= BOUND_VARIABLE_592 BOUND_VARIABLE_593)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_592 Int) (BOUND_VARIABLE_593 Int)) (= BOUND_VARIABLE_592 BOUND_VARIABLE_593)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f2 (bag.filter p1 (table.product EMP ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)))))))
(assert (= q2 (bag.map f6 (bag.filter p5 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)))))))
(check-sat)
;answer: sat
; duration: 5155 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some (- 10)) (nullable.some "E") (nullable.some "F") (nullable.some 11) (nullable.some (- 11)) (nullable.some 12) (nullable.some (- 12)) (nullable.some 7) (nullable.some 13)) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 1)) 1)
; insert into EMP values(-10,'E','F',11,-11,12,-12,7,13)
; SELECT * FROM (SELECT 1 FROM EMP AS EMP INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 7) AS t ON EMP.DEPTNO = t.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 7) AS t2 ON t1.DEPTNO = t2.DEPTNO) AS q2;

; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 7) AS t2 ON t1.DEPTNO = t2.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM EMP AS EMP INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO > 7) AS t ON EMP.DEPTNO = t.DEPTNO) AS q1;
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_551 Int) (BOUND_VARIABLE_552 Int)) (>= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 8) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_551 Int) (BOUND_VARIABLE_552 Int)) (>= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 8) t) (nullable.some 100)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_588 Int) (BOUND_VARIABLE_589 Int)) (> BOUND_VARIABLE_588 BOUND_VARIABLE_589)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_588 Int) (BOUND_VARIABLE_589 Int)) (> BOUND_VARIABLE_588 BOUND_VARIABLE_589)) ((_ tuple.select 6) t) (nullable.some 100)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_609 Int) (BOUND_VARIABLE_610 Int)) (= BOUND_VARIABLE_609 BOUND_VARIABLE_610)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_609 Int) (BOUND_VARIABLE_610 Int)) (= BOUND_VARIABLE_609 BOUND_VARIABLE_610)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f4 (bag.filter p3 (bag.union_disjoint (bag.union_disjoint (bag.map leftJoin1 (bag.difference_remove DEPT ((_ table.project 0 1) (bag.filter p0 (table.product DEPT EMP))))) (bag.map rightJoin2 (bag.difference_remove EMP ((_ table.project 2 3 4 5 6 7 8 9 10) (bag.filter p0 (table.product DEPT EMP)))))) (bag.filter p0 (table.product DEPT EMP)))))))
(assert (= q2 (bag.map f8 (bag.union_disjoint (bag.map rightJoin7 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)) ((_ table.project 2 3 4 5 6 7 8 9 10) (bag.filter p6 (table.product DEPT ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP))))))) (bag.filter p6 (table.product DEPT ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP))))))))
(check-sat)
;answer: sat
; duration: 1029 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some (- 4)) (nullable.some "D") (nullable.some "E") (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (nullable.some 100) (as nullable.null (Nullable Int)) (nullable.some (- 6))) 1))
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String)))))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 1)) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; insert into EMP values(-4,'D','E',5,-5,6,100,NULL,-6)
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_446 Bool)) (not BOUND_VARIABLE_446)) (nullable.lift (lambda ((BOUND_VARIABLE_440 Int) (BOUND_VARIABLE_441 Int)) (= BOUND_VARIABLE_440 BOUND_VARIABLE_441)) ((_ tuple.select 0) t) (nullable.some 11)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_446 Bool)) (not BOUND_VARIABLE_446)) (nullable.lift (lambda ((BOUND_VARIABLE_440 Int) (BOUND_VARIABLE_441 Int)) (= BOUND_VARIABLE_440 BOUND_VARIABLE_441)) ((_ tuple.select 0) t) (nullable.some 11)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_461 Bool) (BOUND_VARIABLE_462 Bool)) (and BOUND_VARIABLE_461 BOUND_VARIABLE_462)) (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_446 Bool)) (not BOUND_VARIABLE_446)) (nullable.lift (lambda ((BOUND_VARIABLE_440 Int) (BOUND_VARIABLE_441 Int)) (= BOUND_VARIABLE_440 BOUND_VARIABLE_441)) ((_ tuple.select 0) t) (nullable.some 11))))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_446 Bool)) (not BOUND_VARIABLE_446)) (nullable.lift (lambda ((BOUND_VARIABLE_440 Int) (BOUND_VARIABLE_441 Int)) (= BOUND_VARIABLE_440 BOUND_VARIABLE_441)) ((_ tuple.select 0) t) (nullable.some 11)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_446 Bool)) (not BOUND_VARIABLE_446)) (nullable.lift (lambda ((BOUND_VARIABLE_440 Int) (BOUND_VARIABLE_441 Int)) (= BOUND_VARIABLE_440 BOUND_VARIABLE_441)) ((_ tuple.select 0) t) (nullable.some 11)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_461 Bool) (BOUND_VARIABLE_462 Bool)) (and BOUND_VARIABLE_461 BOUND_VARIABLE_462)) (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_446 Bool)) (not BOUND_VARIABLE_446)) (nullable.lift (lambda ((BOUND_VARIABLE_440 Int) (BOUND_VARIABLE_441 Int)) (= BOUND_VARIABLE_440 BOUND_VARIABLE_441)) ((_ tuple.select 0) t) (nullable.some 11)))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= q1 ((_ table.project 0) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0) (bag.filter p1 (bag (tuple (nullable.some 0)) 1)))))
(check-sat)
;answer: sat
; duration: 83 ms.
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
(assert (= q1 (bag.map f1 (bag.union_disjoint (bag.map leftJoin0 (bag.difference_remove (bag.union_disjoint (bag (tuple (nullable.some 1)) 1) (bag (tuple (nullable.some 2)) 1)) ((_ table.project 0) (table.product (bag.union_disjoint (bag (tuple (nullable.some 1)) 1) (bag (tuple (nullable.some 2)) 1)) (bag (tuple (nullable.some 1)) 1))))) (table.product (bag.union_disjoint (bag (tuple (nullable.some 1)) 1) (bag (tuple (nullable.some 2)) 1)) (bag (tuple (nullable.some 1)) 1))))))
(assert (= q2 (bag.map f3 (bag.union_disjoint (bag.map leftJoin2 (bag.difference_remove (bag (tuple (nullable.some 1)) 1) ((_ table.project 0) (table.product (bag (tuple (nullable.some 1)) 1) (bag (tuple (nullable.some 0)) 1))))) (table.product (bag (tuple (nullable.some 1)) 1) (bag (tuple (nullable.some 0)) 1))))))
(check-sat)
;answer: sat
; duration: 9 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 2)) 2)
; q2
(get-value (q2))
; (bag (tuple (nullable.some 2)) 1)
; SELECT * FROM (SELECT CASE WHEN 1 = 2 THEN CAST(t0.column1 AS INTEGER) ELSE 2 END FROM (VALUES  (1),(2)) AS t LEFT JOIN (VALUES  (1)) AS t0 ON TRUE) AS q1 EXCEPT ALL SELECT * FROM (SELECT CAST(2 AS INTEGER) FROM (VALUES  (1)) AS t2 LEFT JOIN (VALUES  (0)) AS t3 ON TRUE) AS q2;
;(2)

; SELECT * FROM (SELECT CAST(2 AS INTEGER) FROM (VALUES  (1)) AS t2 LEFT JOIN (VALUES  (0)) AS t3 ON TRUE) AS q2 EXCEPT ALL SELECT * FROM (SELECT CASE WHEN 1 = 2 THEN CAST(t0.column1 AS INTEGER) ELSE 2 END FROM (VALUES  (1),(2)) AS t LEFT JOIN (VALUES  (1)) AS t0 ON TRUE) AS q1;

;Model soundness: true
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_481 Int) (BOUND_VARIABLE_482 Int)) (= BOUND_VARIABLE_481 BOUND_VARIABLE_482)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_481 Int) (BOUND_VARIABLE_482 Int)) (= BOUND_VARIABLE_481 BOUND_VARIABLE_482)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_536 Int) (BOUND_VARIABLE_537 Int)) (distinct BOUND_VARIABLE_536 BOUND_VARIABLE_537)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_536 Int) (BOUND_VARIABLE_537 Int)) (distinct BOUND_VARIABLE_536 BOUND_VARIABLE_537)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f1 (bag.filter p0 (table.product EMP EMP)))))
(assert (= q2 (bag.map f3 (bag.filter p2 (table.product EMP EMP)))))
(check-sat)
;answer: sat
; duration: 305 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some (- 1)) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some (- 3)) (nullable.some 0) (nullable.some 4)) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 1)) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; insert into EMP values(-1,NULL,'',2,-2,3,-3,0,4)
; SELECT * FROM (SELECT 1 FROM EMP AS EMP INNER JOIN EMP AS EMP0 ON EMP.DEPTNO = EMP0.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM EMP AS EMP1 INNER JOIN EMP AS EMP2 ON EMP1.DEPTNO <> EMP2.DEPTNO) AS q2;
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_396 Int) (BOUND_VARIABLE_397 Int)) (< BOUND_VARIABLE_396 BOUND_VARIABLE_397)) (nullable.lift (lambda ((BOUND_VARIABLE_388 Int) (BOUND_VARIABLE_389 Int)) (- BOUND_VARIABLE_388 BOUND_VARIABLE_389)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_396 Int) (BOUND_VARIABLE_397 Int)) (< BOUND_VARIABLE_396 BOUND_VARIABLE_397)) (nullable.lift (lambda ((BOUND_VARIABLE_388 Int) (BOUND_VARIABLE_389 Int)) (- BOUND_VARIABLE_388 BOUND_VARIABLE_389)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 0) t)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_446 Int) (BOUND_VARIABLE_447 Int)) (+ BOUND_VARIABLE_446 BOUND_VARIABLE_447)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= q1 (bag.map f1 (bag.filter p0 (bag.union_disjoint (bag (tuple (nullable.some 10) (nullable.some 1)) 1) (bag (tuple (nullable.some 30) (nullable.some 7)) 1))))))
(assert (= q2 ((_ table.project 0 1 2) (bag.filter p2 (bag (tuple (nullable.some 0) (nullable.some 0) (nullable.some 0)) 1)))))
(check-sat)
;answer: sat
; duration: 22 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (bag.union_disjoint (bag (tuple (nullable.some 11) (nullable.some 1) (nullable.some 10)) 1) (bag (tuple (nullable.some 37) (nullable.some 7) (nullable.some 30)) 1))
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_425 Int) (BOUND_VARIABLE_426 Int)) (= BOUND_VARIABLE_425 BOUND_VARIABLE_426)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_417 Int) (BOUND_VARIABLE_418 Int)) (* BOUND_VARIABLE_417 BOUND_VARIABLE_418)) (nullable.some 10) ((_ tuple.select 5) t)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_425 Int) (BOUND_VARIABLE_426 Int)) (= BOUND_VARIABLE_425 BOUND_VARIABLE_426)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_417 Int) (BOUND_VARIABLE_418 Int)) (* BOUND_VARIABLE_417 BOUND_VARIABLE_418)) (nullable.some 10) ((_ tuple.select 5) t)))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_455 String) (BOUND_VARIABLE_456 String)) (= BOUND_VARIABLE_455 BOUND_VARIABLE_456)) (nullable.lift (lambda ((BOUND_VARIABLE_447 String)) (str.to_upper BOUND_VARIABLE_447)) ((_ tuple.select 1) t)) (nullable.some "FO0"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_455 String) (BOUND_VARIABLE_456 String)) (= BOUND_VARIABLE_455 BOUND_VARIABLE_456)) (nullable.lift (lambda ((BOUND_VARIABLE_447 String)) (str.to_upper BOUND_VARIABLE_447)) ((_ tuple.select 1) t)) (nullable.some "FO0"))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_471 Bool) (BOUND_VARIABLE_472 Bool)) (and BOUND_VARIABLE_471 BOUND_VARIABLE_472)) (nullable.lift (lambda ((BOUND_VARIABLE_425 Int) (BOUND_VARIABLE_426 Int)) (= BOUND_VARIABLE_425 BOUND_VARIABLE_426)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_417 Int) (BOUND_VARIABLE_418 Int)) (* BOUND_VARIABLE_417 BOUND_VARIABLE_418)) (nullable.some 10) ((_ tuple.select 5) t))) (nullable.lift (lambda ((BOUND_VARIABLE_455 String) (BOUND_VARIABLE_456 String)) (= BOUND_VARIABLE_455 BOUND_VARIABLE_456)) (nullable.lift (lambda ((BOUND_VARIABLE_447 String)) (str.to_upper BOUND_VARIABLE_447)) ((_ tuple.select 1) t)) (nullable.some "FO0")))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_425 Int) (BOUND_VARIABLE_426 Int)) (= BOUND_VARIABLE_425 BOUND_VARIABLE_426)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_417 Int) (BOUND_VARIABLE_418 Int)) (* BOUND_VARIABLE_417 BOUND_VARIABLE_418)) (nullable.some 10) ((_ tuple.select 5) t)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_425 Int) (BOUND_VARIABLE_426 Int)) (= BOUND_VARIABLE_425 BOUND_VARIABLE_426)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_417 Int) (BOUND_VARIABLE_418 Int)) (* BOUND_VARIABLE_417 BOUND_VARIABLE_418)) (nullable.some 10) ((_ tuple.select 5) t)))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_455 String) (BOUND_VARIABLE_456 String)) (= BOUND_VARIABLE_455 BOUND_VARIABLE_456)) (nullable.lift (lambda ((BOUND_VARIABLE_447 String)) (str.to_upper BOUND_VARIABLE_447)) ((_ tuple.select 1) t)) (nullable.some "FO0"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_455 String) (BOUND_VARIABLE_456 String)) (= BOUND_VARIABLE_455 BOUND_VARIABLE_456)) (nullable.lift (lambda ((BOUND_VARIABLE_447 String)) (str.to_upper BOUND_VARIABLE_447)) ((_ tuple.select 1) t)) (nullable.some "FO0"))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_471 Bool) (BOUND_VARIABLE_472 Bool)) (and BOUND_VARIABLE_471 BOUND_VARIABLE_472)) (nullable.lift (lambda ((BOUND_VARIABLE_425 Int) (BOUND_VARIABLE_426 Int)) (= BOUND_VARIABLE_425 BOUND_VARIABLE_426)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_417 Int) (BOUND_VARIABLE_418 Int)) (* BOUND_VARIABLE_417 BOUND_VARIABLE_418)) (nullable.some 10) ((_ tuple.select 5) t))) (nullable.lift (lambda ((BOUND_VARIABLE_455 String) (BOUND_VARIABLE_456 String)) (= BOUND_VARIABLE_455 BOUND_VARIABLE_456)) (nullable.lift (lambda ((BOUND_VARIABLE_447 String)) (str.to_upper BOUND_VARIABLE_447)) ((_ tuple.select 1) t)) (nullable.some "FO0"))))))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_503 Int) (BOUND_VARIABLE_504 Int)) (+ BOUND_VARIABLE_503 BOUND_VARIABLE_504)) ((_ tuple.select 0) t) ((_ tuple.select 7) t))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_549 Int) (BOUND_VARIABLE_550 Int)) (* BOUND_VARIABLE_549 BOUND_VARIABLE_550)) (nullable.some 10) ((_ tuple.select 3) t)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_549 Int) (BOUND_VARIABLE_550 Int)) (* BOUND_VARIABLE_549 BOUND_VARIABLE_550)) (nullable.some 10) ((_ tuple.select 3) t)))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_569 String) (BOUND_VARIABLE_570 String)) (= BOUND_VARIABLE_569 BOUND_VARIABLE_570)) (nullable.lift (lambda ((BOUND_VARIABLE_562 String)) (str.to_upper BOUND_VARIABLE_562)) ((_ tuple.select 1) t)) (nullable.some "FOO"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_569 String) (BOUND_VARIABLE_570 String)) (= BOUND_VARIABLE_569 BOUND_VARIABLE_570)) (nullable.lift (lambda ((BOUND_VARIABLE_562 String)) (str.to_upper BOUND_VARIABLE_562)) ((_ tuple.select 1) t)) (nullable.some "FOO"))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_583 Bool) (BOUND_VARIABLE_584 Bool)) (and BOUND_VARIABLE_583 BOUND_VARIABLE_584)) (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_549 Int) (BOUND_VARIABLE_550 Int)) (* BOUND_VARIABLE_549 BOUND_VARIABLE_550)) (nullable.some 10) ((_ tuple.select 3) t))) (nullable.lift (lambda ((BOUND_VARIABLE_569 String) (BOUND_VARIABLE_570 String)) (= BOUND_VARIABLE_569 BOUND_VARIABLE_570)) (nullable.lift (lambda ((BOUND_VARIABLE_562 String)) (str.to_upper BOUND_VARIABLE_562)) ((_ tuple.select 1) t)) (nullable.some "FOO")))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_549 Int) (BOUND_VARIABLE_550 Int)) (* BOUND_VARIABLE_549 BOUND_VARIABLE_550)) (nullable.some 10) ((_ tuple.select 3) t)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_549 Int) (BOUND_VARIABLE_550 Int)) (* BOUND_VARIABLE_549 BOUND_VARIABLE_550)) (nullable.some 10) ((_ tuple.select 3) t)))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_569 String) (BOUND_VARIABLE_570 String)) (= BOUND_VARIABLE_569 BOUND_VARIABLE_570)) (nullable.lift (lambda ((BOUND_VARIABLE_562 String)) (str.to_upper BOUND_VARIABLE_562)) ((_ tuple.select 1) t)) (nullable.some "FOO"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_569 String) (BOUND_VARIABLE_570 String)) (= BOUND_VARIABLE_569 BOUND_VARIABLE_570)) (nullable.lift (lambda ((BOUND_VARIABLE_562 String)) (str.to_upper BOUND_VARIABLE_562)) ((_ tuple.select 1) t)) (nullable.some "FOO"))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_583 Bool) (BOUND_VARIABLE_584 Bool)) (and BOUND_VARIABLE_583 BOUND_VARIABLE_584)) (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_549 Int) (BOUND_VARIABLE_550 Int)) (* BOUND_VARIABLE_549 BOUND_VARIABLE_550)) (nullable.some 10) ((_ tuple.select 3) t))) (nullable.lift (lambda ((BOUND_VARIABLE_569 String) (BOUND_VARIABLE_570 String)) (= BOUND_VARIABLE_569 BOUND_VARIABLE_570)) (nullable.lift (lambda ((BOUND_VARIABLE_562 String)) (str.to_upper BOUND_VARIABLE_562)) ((_ tuple.select 1) t)) (nullable.some "FOO"))))))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_603 Int) (BOUND_VARIABLE_604 Int)) (+ BOUND_VARIABLE_603 BOUND_VARIABLE_604)) ((_ tuple.select 0) t) ((_ tuple.select 4) t))))))
(assert (= q1 (bag.map f1 (bag.filter p0 EMP))))
(assert (= q2 (bag.map f3 (bag.filter p2 ((_ table.project 0 1 6 5 7) EMP)))))
(check-sat)
;answer: sat
; duration: 813 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (as nullable.null (Nullable Int)) (nullable.some "foo") (nullable.some "") (nullable.some 1) (nullable.some (- 1)) (nullable.some 0) (nullable.some 0) (as nullable.null (Nullable Int)) (nullable.some 2)) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (bag (tuple (as nullable.null (Nullable Int))) 1)
; insert into EMP values(NULL,'foo','',1,-1,0,0,NULL,2)
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_469 Int) (BOUND_VARIABLE_470 Int)) (= BOUND_VARIABLE_469 BOUND_VARIABLE_470)) ((_ tuple.select 0) t) ((_ tuple.select 2) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_469 Int) (BOUND_VARIABLE_470 Int)) (= BOUND_VARIABLE_469 BOUND_VARIABLE_470)) ((_ tuple.select 0) t) ((_ tuple.select 2) t)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_504 Int) (BOUND_VARIABLE_505 Int)) (<= BOUND_VARIABLE_504 BOUND_VARIABLE_505)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_504 Int) (BOUND_VARIABLE_505 Int)) (<= BOUND_VARIABLE_504 BOUND_VARIABLE_505)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_522 Int) (BOUND_VARIABLE_523 Int)) (< BOUND_VARIABLE_522 BOUND_VARIABLE_523)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_522 Int) (BOUND_VARIABLE_523 Int)) (< BOUND_VARIABLE_522 BOUND_VARIABLE_523)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_543 Int) (BOUND_VARIABLE_544 Int)) (= BOUND_VARIABLE_543 BOUND_VARIABLE_544)) ((_ tuple.select 0) t) ((_ tuple.select 2) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_543 Int) (BOUND_VARIABLE_544 Int)) (= BOUND_VARIABLE_543 BOUND_VARIABLE_544)) ((_ tuple.select 0) t) ((_ tuple.select 2) t)))))))
(assert (= q1 ((_ table.project 0 1 2) (bag.filter p1 (bag.filter p0 (table.product DEPT ((_ table.project 7) EMP)))))))
(assert (= q2 ((_ table.project 0 1 2) (bag.filter p3 (table.product ((_ table.project 0 1) (bag.filter p2 DEPT)) ((_ table.project 7) EMP))))))
(check-sat)
;answer: sat
; duration: 4310 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 0) (nullable.some "C") (nullable.some "D") (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 10) (nullable.some 3)) 2))
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 10) (nullable.some "")) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 10) (nullable.some "") (nullable.some 10)) 2)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
; insert into EMP values(0,'C','D',1,-1,2,-2,10,3),(0,'C','D',1,-1,2,-2,10,3)
; insert into DEPT values(10,'')
; SELECT * FROM (SELECT * FROM DEPT AS DEPT INNER JOIN (SELECT EMP.DEPTNO FROM EMP AS EMP) AS t ON DEPT.DEPTNO = t.DEPTNO WHERE DEPT.DEPTNO <= 10) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.DEPTNO < 10) AS t1 INNER JOIN (SELECT EMP0.DEPTNO FROM EMP AS EMP0) AS t2 ON t1.DEPTNO = t2.DEPTNO) AS q2;
;(10,,10)
;(10,,10)

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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_465 Int) (BOUND_VARIABLE_466 Int)) (> BOUND_VARIABLE_465 BOUND_VARIABLE_466)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_465 Int) (BOUND_VARIABLE_466 Int)) (> BOUND_VARIABLE_465 BOUND_VARIABLE_466)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_486 Int) (BOUND_VARIABLE_487 Int)) (> BOUND_VARIABLE_486 BOUND_VARIABLE_487)) ((_ tuple.select 7) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_486 Int) (BOUND_VARIABLE_487 Int)) (> BOUND_VARIABLE_486 BOUND_VARIABLE_487)) ((_ tuple.select 7) t) (nullable.some 1)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_547 Int) (BOUND_VARIABLE_548 Int)) (= BOUND_VARIABLE_547 BOUND_VARIABLE_548)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_547 Int) (BOUND_VARIABLE_548 Int)) (= BOUND_VARIABLE_547 BOUND_VARIABLE_548)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_572 Int) (BOUND_VARIABLE_573 Int)) (>= BOUND_VARIABLE_572 BOUND_VARIABLE_573)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_572 Int) (BOUND_VARIABLE_573 Int)) (>= BOUND_VARIABLE_572 BOUND_VARIABLE_573)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_589 Int) (BOUND_VARIABLE_590 Int)) (> BOUND_VARIABLE_589 BOUND_VARIABLE_590)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_589 Int) (BOUND_VARIABLE_590 Int)) (> BOUND_VARIABLE_589 BOUND_VARIABLE_590)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_608 Int) (BOUND_VARIABLE_609 Int)) (> BOUND_VARIABLE_608 BOUND_VARIABLE_609)) ((_ tuple.select 7) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_608 Int) (BOUND_VARIABLE_609 Int)) (> BOUND_VARIABLE_608 BOUND_VARIABLE_609)) ((_ tuple.select 7) t) (nullable.some 1)))))))
(assert (= p8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_626 Int) (BOUND_VARIABLE_627 Int)) (> BOUND_VARIABLE_626 BOUND_VARIABLE_627)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_626 Int) (BOUND_VARIABLE_627 Int)) (> BOUND_VARIABLE_626 BOUND_VARIABLE_627)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_632 Int) (BOUND_VARIABLE_633 Int)) (> BOUND_VARIABLE_632 BOUND_VARIABLE_633)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_632 Int) (BOUND_VARIABLE_633 Int)) (> BOUND_VARIABLE_632 BOUND_VARIABLE_633)) ((_ tuple.select 7) t) (nullable.some 10)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_651 Bool) (BOUND_VARIABLE_652 Bool) (BOUND_VARIABLE_653 Bool)) (or BOUND_VARIABLE_651 BOUND_VARIABLE_652 BOUND_VARIABLE_653)) (nullable.lift (lambda ((BOUND_VARIABLE_626 Int) (BOUND_VARIABLE_627 Int)) (> BOUND_VARIABLE_626 BOUND_VARIABLE_627)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_632 Int) (BOUND_VARIABLE_633 Int)) (> BOUND_VARIABLE_632 BOUND_VARIABLE_633)) ((_ tuple.select 7) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_638 Int) (BOUND_VARIABLE_639 Int)) (> BOUND_VARIABLE_638 BOUND_VARIABLE_639)) ((_ tuple.select 7) t) (nullable.some 1)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_626 Int) (BOUND_VARIABLE_627 Int)) (> BOUND_VARIABLE_626 BOUND_VARIABLE_627)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_626 Int) (BOUND_VARIABLE_627 Int)) (> BOUND_VARIABLE_626 BOUND_VARIABLE_627)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_632 Int) (BOUND_VARIABLE_633 Int)) (> BOUND_VARIABLE_632 BOUND_VARIABLE_633)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_632 Int) (BOUND_VARIABLE_633 Int)) (> BOUND_VARIABLE_632 BOUND_VARIABLE_633)) ((_ tuple.select 7) t) (nullable.some 10)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_651 Bool) (BOUND_VARIABLE_652 Bool) (BOUND_VARIABLE_653 Bool)) (or BOUND_VARIABLE_651 BOUND_VARIABLE_652 BOUND_VARIABLE_653)) (nullable.lift (lambda ((BOUND_VARIABLE_626 Int) (BOUND_VARIABLE_627 Int)) (> BOUND_VARIABLE_626 BOUND_VARIABLE_627)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_632 Int) (BOUND_VARIABLE_633 Int)) (> BOUND_VARIABLE_632 BOUND_VARIABLE_633)) ((_ tuple.select 7) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_638 Int) (BOUND_VARIABLE_639 Int)) (> BOUND_VARIABLE_638 BOUND_VARIABLE_639)) ((_ tuple.select 7) t) (nullable.some 1))))))))))
(assert (= p9 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_675 Int) (BOUND_VARIABLE_676 Int)) (= BOUND_VARIABLE_675 BOUND_VARIABLE_676)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_675 Int) (BOUND_VARIABLE_676 Int)) (= BOUND_VARIABLE_675 BOUND_VARIABLE_676)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f10 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f4 (bag.filter p3 (table.product (bag.union_disjoint ((_ table.project 0) (bag.union_disjoint ((_ table.project 7) (bag.filter p0 EMP)) ((_ table.project 7) (bag.filter p1 EMP)))) ((_ table.project 7) (bag.filter p2 EMP))) EMP)))))
(assert (= q2 (bag.map f10 (bag.filter p9 (table.product (bag.union_disjoint ((_ table.project 0) (bag.union_disjoint ((_ table.project 7) (bag.filter p5 EMP)) ((_ table.project 7) (bag.filter p6 EMP)))) ((_ table.project 7) (bag.filter p7 EMP))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p8 EMP)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 25469 ms.
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

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const rightJoin1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const rightJoin5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_481 Int) (BOUND_VARIABLE_482 Int)) (= BOUND_VARIABLE_481 BOUND_VARIABLE_482)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_481 Int) (BOUND_VARIABLE_482 Int)) (= BOUND_VARIABLE_481 BOUND_VARIABLE_482)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_627 Int) (BOUND_VARIABLE_628 Int)) (= BOUND_VARIABLE_627 BOUND_VARIABLE_628)) ((_ tuple.select 7) t) ((_ tuple.select 11) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_627 Int) (BOUND_VARIABLE_628 Int)) (= BOUND_VARIABLE_627 BOUND_VARIABLE_628)) ((_ tuple.select 7) t) ((_ tuple.select 11) t)))))))
(assert (= rightJoin5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map rightJoin1 (bag.difference_remove DEPT ((_ table.project 9 10) (bag.filter p0 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) EMP) DEPT))))) (bag.filter p0 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) EMP) DEPT))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map rightJoin5 (bag.difference_remove (bag.map f3 DEPT) ((_ table.project 9 10 11) (bag.filter p4 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 (bag (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0)) 1))) (bag.map f3 DEPT)))))) (bag.filter p4 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 (bag (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0)) 1))) (bag.map f3 DEPT)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10728 ms.
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_518 Int) (BOUND_VARIABLE_519 Int)) (= BOUND_VARIABLE_518 BOUND_VARIABLE_519)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_518 Int) (BOUND_VARIABLE_519 Int)) (= BOUND_VARIABLE_518 BOUND_VARIABLE_519)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (>= BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 16) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (>= BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 16) t) (nullable.some 9)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_596 Int) (BOUND_VARIABLE_597 Int)) (> BOUND_VARIABLE_596 BOUND_VARIABLE_597)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_596 Int) (BOUND_VARIABLE_597 Int)) (> BOUND_VARIABLE_596 BOUND_VARIABLE_597)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_613 Int) (BOUND_VARIABLE_614 Int)) (> BOUND_VARIABLE_613 BOUND_VARIABLE_614)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_613 Int) (BOUND_VARIABLE_614 Int)) (> BOUND_VARIABLE_613 BOUND_VARIABLE_614)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_632 Int) (BOUND_VARIABLE_633 Int)) (= BOUND_VARIABLE_632 BOUND_VARIABLE_633)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_632 Int) (BOUND_VARIABLE_633 Int)) (= BOUND_VARIABLE_632 BOUND_VARIABLE_633)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= leftJoin8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= p9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_667 Int) (BOUND_VARIABLE_668 Int)) (> BOUND_VARIABLE_667 BOUND_VARIABLE_668)) ((_ tuple.select 16) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_667 Int) (BOUND_VARIABLE_668 Int)) (> BOUND_VARIABLE_667 BOUND_VARIABLE_668)) ((_ tuple.select 16) t) (nullable.some 9)))))))
(assert (= f10 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f4 (bag.filter p3 (bag.union_disjoint (bag.map leftJoin2 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) EMP))))) (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) EMP)))))))
(assert (= q2 (bag.map f10 (bag.filter p9 (bag.union_disjoint (bag.map leftJoin8 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p7 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p6 EMP))))))) (bag.filter p7 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p6 EMP)))))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10352 ms.
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

(declare-const q1 (Bag (Tuple (Nullable Bool))))
(declare-const q2 (Bag (Tuple (Nullable Bool))))
(declare-const f0 (-> (Tuple (Nullable Int)) (Tuple (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable Int)) (Tuple (Nullable Bool))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int)))) (tuple (nullable.some false)))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int)))) (tuple (nullable.some false)))))
(assert (= q1 (bag.map f0 (bag.union_disjoint (bag (tuple (nullable.some 0)) 1) (bag (tuple (nullable.some 0)) 1)))))
(assert (= q2 (bag.map f1 (bag (tuple (nullable.some 0)) 1))))
(check-sat)
;answer: sat
; duration: 117 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some false)) 2)
; q2
(get-value (q2))
; (bag (tuple (nullable.some false)) 1)
; SELECT * FROM (SELECT CAST(CASE WHEN NULL IS NULL THEN 2 IS NULL WHEN 2 IS NULL THEN NULL IS NULL ELSE NULL = 2 END AS BOOLEAN) FROM (VALUES  (0),(0)) AS t) AS q1 EXCEPT ALL SELECT * FROM (SELECT FALSE FROM (VALUES  (0)) AS t2) AS q2;
;(false)

; SELECT * FROM (SELECT FALSE FROM (VALUES  (0)) AS t2) AS q2 EXCEPT ALL SELECT * FROM (SELECT CAST(CASE WHEN NULL IS NULL THEN 2 IS NULL WHEN 2 IS NULL THEN NULL IS NULL ELSE NULL = 2 END AS BOOLEAN) FROM (VALUES  (0),(0)) AS t) AS q1;

;Model soundness: true
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= q1 ((_ table.project 6) (table.product EMP (bag.union_disjoint ((_ table.project 0 1 2 3 4 5 6 7 8) EMP) ((_ table.project 0 1 2 3 4 5 6 7 8) EMP))))))
(assert (= q2 ((_ table.project 0) (bag.union_disjoint ((_ table.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) (table.product EMP EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) (table.product EMP EMP))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 18289 ms.
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_551 String) (BOUND_VARIABLE_552 String)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 1) t) (nullable.some "Charli"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_551 String) (BOUND_VARIABLE_552 String)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 1) t) (nullable.some "Charli"))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_561 Int) (BOUND_VARIABLE_562 Int)) (> BOUND_VARIABLE_561 BOUND_VARIABLE_562)) ((_ tuple.select 8) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_561 Int) (BOUND_VARIABLE_562 Int)) (> BOUND_VARIABLE_561 BOUND_VARIABLE_562)) ((_ tuple.select 8) t) (nullable.some 100))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_576 Bool) (BOUND_VARIABLE_577 Bool)) (and BOUND_VARIABLE_576 BOUND_VARIABLE_577)) (nullable.lift (lambda ((BOUND_VARIABLE_551 String) (BOUND_VARIABLE_552 String)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 1) t) (nullable.some "Charli")) (nullable.lift (lambda ((BOUND_VARIABLE_561 Int) (BOUND_VARIABLE_562 Int)) (> BOUND_VARIABLE_561 BOUND_VARIABLE_562)) ((_ tuple.select 8) t) (nullable.some 100)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_551 String) (BOUND_VARIABLE_552 String)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 1) t) (nullable.some "Charli"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_551 String) (BOUND_VARIABLE_552 String)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 1) t) (nullable.some "Charli"))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_561 Int) (BOUND_VARIABLE_562 Int)) (> BOUND_VARIABLE_561 BOUND_VARIABLE_562)) ((_ tuple.select 8) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_561 Int) (BOUND_VARIABLE_562 Int)) (> BOUND_VARIABLE_561 BOUND_VARIABLE_562)) ((_ tuple.select 8) t) (nullable.some 100))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_576 Bool) (BOUND_VARIABLE_577 Bool)) (and BOUND_VARIABLE_576 BOUND_VARIABLE_577)) (nullable.lift (lambda ((BOUND_VARIABLE_551 String) (BOUND_VARIABLE_552 String)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 1) t) (nullable.some "Charli")) (nullable.lift (lambda ((BOUND_VARIABLE_561 Int) (BOUND_VARIABLE_562 Int)) (> BOUND_VARIABLE_561 BOUND_VARIABLE_562)) ((_ tuple.select 8) t) (nullable.some 100))))))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_618 String) (BOUND_VARIABLE_619 String)) (= BOUND_VARIABLE_618 BOUND_VARIABLE_619)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_618 String) (BOUND_VARIABLE_619 String)) (= BOUND_VARIABLE_618 BOUND_VARIABLE_619)) ((_ tuple.select 1) t) (nullable.some "Charlie")))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_636 Int) (BOUND_VARIABLE_637 Int)) (> BOUND_VARIABLE_636 BOUND_VARIABLE_637)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_636 Int) (BOUND_VARIABLE_637 Int)) (> BOUND_VARIABLE_636 BOUND_VARIABLE_637)) ((_ tuple.select 6) t) (nullable.some 100)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_657 Int) (BOUND_VARIABLE_658 Int)) (= BOUND_VARIABLE_657 BOUND_VARIABLE_658)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_657 Int) (BOUND_VARIABLE_658 Int)) (= BOUND_VARIABLE_657 BOUND_VARIABLE_658)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f4 (bag.filter p3 (bag.union_disjoint (bag.union_disjoint (bag.map leftJoin1 (bag.difference_remove DEPT ((_ table.project 0 1) (bag.filter p0 (table.product DEPT EMP))))) (bag.map rightJoin2 (bag.difference_remove EMP ((_ table.project 2 3 4 5 6 7 8 9 10) (bag.filter p0 (table.product DEPT EMP)))))) (bag.filter p0 (table.product DEPT EMP)))))))
(assert (= q2 (bag.map f8 (bag.filter p7 (table.product ((_ table.project 0 1) (bag.filter p5 DEPT)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p6 EMP)))))))
(check-sat)
;answer: sat
; duration: 7618 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 8) (nullable.some "D") (nullable.some "E") (nullable.some (- 8)) (nullable.some 9) (nullable.some (- 9)) (nullable.some 101) (nullable.some 101) (nullable.some 10)) 1))
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 101) (nullable.some "Charli")) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 1)) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; insert into EMP values(8,'D','E',-8,9,-9,101,101,10)
; insert into DEPT values(101,'Charli')
; SELECT * FROM (SELECT 1 FROM DEPT AS DEPT FULL JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charli' AND EMP.SAL > 100) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL > 100) AS t2 ON t1.DEPTNO = t2.DEPTNO) AS q2;
;(1)

; SELECT * FROM (SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 INNER JOIN (SELECT * FROM EMP AS EMP0 WHERE EMP0.SAL > 100) AS t2 ON t1.DEPTNO = t2.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM DEPT AS DEPT FULL JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charli' AND EMP.SAL > 100) AS q1;

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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (or (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_444 Int) (BOUND_VARIABLE_445 Int)) (= BOUND_VARIABLE_444 BOUND_VARIABLE_445)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_444 Int) (BOUND_VARIABLE_445 Int)) (= BOUND_VARIABLE_444 BOUND_VARIABLE_445)) ((_ tuple.select 6) t) (nullable.some 1000)))) (as nullable.null (Nullable Int)) (nullable.some 1))) (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_467 Int) (BOUND_VARIABLE_468 Int)) (= BOUND_VARIABLE_467 BOUND_VARIABLE_468)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_467 Int) (BOUND_VARIABLE_468 Int)) (= BOUND_VARIABLE_467 BOUND_VARIABLE_468)) ((_ tuple.select 6) t) (nullable.some 2000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_504 Int) (BOUND_VARIABLE_505 Int)) (= BOUND_VARIABLE_504 BOUND_VARIABLE_505)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_504 Int) (BOUND_VARIABLE_505 Int)) (= BOUND_VARIABLE_504 BOUND_VARIABLE_505)) ((_ tuple.select 6) t) (nullable.some 100)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 6) t) (nullable.some 2000)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_523 Bool) (BOUND_VARIABLE_524 Bool)) (or BOUND_VARIABLE_523 BOUND_VARIABLE_524)) (nullable.lift (lambda ((BOUND_VARIABLE_504 Int) (BOUND_VARIABLE_505 Int)) (= BOUND_VARIABLE_504 BOUND_VARIABLE_505)) ((_ tuple.select 6) t) (nullable.some 100)) (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 6) t) (nullable.some 2000)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_504 Int) (BOUND_VARIABLE_505 Int)) (= BOUND_VARIABLE_504 BOUND_VARIABLE_505)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_504 Int) (BOUND_VARIABLE_505 Int)) (= BOUND_VARIABLE_504 BOUND_VARIABLE_505)) ((_ tuple.select 6) t) (nullable.some 100)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 6) t) (nullable.some 2000)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_523 Bool) (BOUND_VARIABLE_524 Bool)) (or BOUND_VARIABLE_523 BOUND_VARIABLE_524)) (nullable.lift (lambda ((BOUND_VARIABLE_504 Int) (BOUND_VARIABLE_505 Int)) (= BOUND_VARIABLE_504 BOUND_VARIABLE_505)) ((_ tuple.select 6) t) (nullable.some 100)) (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 6) t) (nullable.some 2000))))))))))
(assert (= q1 ((_ table.project 6) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 6) (bag.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 169 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 100) (nullable.some 3) (nullable.some (- 3))) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 100)) 1)
; insert into EMP values(0,NULL,'',-1,2,-2,100,3,-3)
; SELECT * FROM (SELECT EMP.SAL FROM EMP AS EMP WHERE CASE WHEN EMP.SAL = 1000 THEN NULL ELSE 1 END IS NULL OR CASE WHEN EMP.SAL = 2000 THEN NULL ELSE 1 END IS NULL) AS q1 EXCEPT ALL SELECT * FROM (SELECT EMP0.SAL FROM EMP AS EMP0 WHERE EMP0.SAL = 100 OR EMP0.SAL = 2000) AS q2;

; SELECT * FROM (SELECT EMP0.SAL FROM EMP AS EMP0 WHERE EMP0.SAL = 100 OR EMP0.SAL = 2000) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.SAL FROM EMP AS EMP WHERE CASE WHEN EMP.SAL = 1000 THEN NULL ELSE 1 END IS NULL OR CASE WHEN EMP.SAL = 2000 THEN NULL ELSE 1 END IS NULL) AS q1;
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (= BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (= BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (bag.union_disjoint ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.union_disjoint ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)))))
(assert (= q2 (bag.union_disjoint (bag.union_disjoint ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10015 ms.
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

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const leftJoin1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_530 Int) (BOUND_VARIABLE_531 Int)) (> BOUND_VARIABLE_530 BOUND_VARIABLE_531)) ((_ tuple.select 8) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_530 Int) (BOUND_VARIABLE_531 Int)) (> BOUND_VARIABLE_530 BOUND_VARIABLE_531)) ((_ tuple.select 8) t) (nullable.some 1000)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_569 Int) (BOUND_VARIABLE_570 Int)) (> BOUND_VARIABLE_569 BOUND_VARIABLE_570)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_569 Int) (BOUND_VARIABLE_570 Int)) (> BOUND_VARIABLE_569 BOUND_VARIABLE_570)) ((_ tuple.select 6) t) (nullable.some 100)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_590 Int) (BOUND_VARIABLE_591 Int)) (= BOUND_VARIABLE_590 BOUND_VARIABLE_591)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_590 Int) (BOUND_VARIABLE_591 Int)) (= BOUND_VARIABLE_590 BOUND_VARIABLE_591)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f3 (bag.filter p2 (bag.union_disjoint (bag.map leftJoin1 (bag.difference_remove DEPT ((_ table.project 0 1) (bag.filter p0 (table.product DEPT EMP))))) (bag.filter p0 (table.product DEPT EMP)))))))
(assert (= q2 (bag.map f6 (bag.filter p5 (table.product DEPT ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)))))))
(check-sat)
;answer: sat
; duration: 8853 ms.
(get-model)
; (
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 1001) (nullable.some "B")) 1))
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some (- 3)) (nullable.some "C") (nullable.some "D") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some 1000) (nullable.some 1001) (nullable.some (- 5))) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 1)) 1)
; insert into DEPT values(1001,'B')
; insert into EMP values(-3,'C','D',4,-4,5,1000,1001,-5)
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_390 Int) (BOUND_VARIABLE_391 Int)) (> BOUND_VARIABLE_390 BOUND_VARIABLE_391)) ((_ tuple.select 0) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_390 Int) (BOUND_VARIABLE_391 Int)) (> BOUND_VARIABLE_390 BOUND_VARIABLE_391)) ((_ tuple.select 0) t) (nullable.some 30)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_441 Int) (BOUND_VARIABLE_442 Int)) (> BOUND_VARIABLE_441 BOUND_VARIABLE_442)) ((_ tuple.select 0) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_441 Int) (BOUND_VARIABLE_442 Int)) (> BOUND_VARIABLE_441 BOUND_VARIABLE_442)) ((_ tuple.select 0) t) (nullable.some 50)))))))
(assert (= q1 (bag.difference_remove ((_ table.project 0 1) (bag.difference_remove ((_ table.project 0 1) (bag.difference_remove ((_ table.project 0 1) (bag (tuple (nullable.some 30) (nullable.some 3)) 1)) ((_ table.project 0 1) (bag.filter p0 (bag (tuple (nullable.some 20) (nullable.some 2)) 1))))) ((_ table.project 0 1) (bag (tuple (nullable.some 40) (nullable.some 4)) 1)))) ((_ table.project 0 1) (bag.filter p1 (bag (tuple (nullable.some 50) (nullable.some 5)) 1))))))
(assert (= q2 (bag.difference_remove ((_ table.project 0 1) (bag (tuple (nullable.some 30) (nullable.some 4)) 1)) ((_ table.project 0 1) (bag (tuple (nullable.some 40) (nullable.some 40)) 1)))))
(check-sat)
;answer: sat
; duration: 58 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 30) (nullable.some 3)) 1)
; q2
(get-value (q2))
; (bag (tuple (nullable.some 30) (nullable.some 4)) 1)
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
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 6) t) ((_ tuple.select 5) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_520 Int) (BOUND_VARIABLE_521 Int)) (+ BOUND_VARIABLE_520 BOUND_VARIABLE_521)) ((_ tuple.select 7) t) (nullable.lift (lambda ((BOUND_VARIABLE_513 Int) (BOUND_VARIABLE_514 Int)) (- BOUND_VARIABLE_513 BOUND_VARIABLE_514)) (nullable.some 5) (nullable.some 5)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_588 Int) (BOUND_VARIABLE_589 Int)) (= BOUND_VARIABLE_588 BOUND_VARIABLE_589)) ((_ tuple.select 2) t) ((_ tuple.select 12) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_588 Int) (BOUND_VARIABLE_589 Int)) (= BOUND_VARIABLE_588 BOUND_VARIABLE_589)) ((_ tuple.select 2) t) ((_ tuple.select 12) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_676 Int) (BOUND_VARIABLE_677 Int)) (= BOUND_VARIABLE_676 BOUND_VARIABLE_677)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_670 Int) (BOUND_VARIABLE_671 Int)) (+ BOUND_VARIABLE_670 BOUND_VARIABLE_671)) (nullable.some 7) (nullable.some 8)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_676 Int) (BOUND_VARIABLE_677 Int)) (= BOUND_VARIABLE_676 BOUND_VARIABLE_677)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_670 Int) (BOUND_VARIABLE_671 Int)) (+ BOUND_VARIABLE_670 BOUND_VARIABLE_671)) (nullable.some 7) (nullable.some 8)))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_688 Int) (BOUND_VARIABLE_689 Int)) (= BOUND_VARIABLE_688 BOUND_VARIABLE_689)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_682 Int) (BOUND_VARIABLE_683 Int)) (+ BOUND_VARIABLE_682 BOUND_VARIABLE_683)) (nullable.some 8) (nullable.some 7)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_688 Int) (BOUND_VARIABLE_689 Int)) (= BOUND_VARIABLE_688 BOUND_VARIABLE_689)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_682 Int) (BOUND_VARIABLE_683 Int)) (+ BOUND_VARIABLE_682 BOUND_VARIABLE_683)) (nullable.some 8) (nullable.some 7)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_719 Bool) (BOUND_VARIABLE_720 Bool) (BOUND_VARIABLE_721 Bool)) (and BOUND_VARIABLE_719 BOUND_VARIABLE_720 BOUND_VARIABLE_721)) (nullable.lift (lambda ((BOUND_VARIABLE_676 Int) (BOUND_VARIABLE_677 Int)) (= BOUND_VARIABLE_676 BOUND_VARIABLE_677)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_670 Int) (BOUND_VARIABLE_671 Int)) (+ BOUND_VARIABLE_670 BOUND_VARIABLE_671)) (nullable.some 7) (nullable.some 8))) (nullable.lift (lambda ((BOUND_VARIABLE_688 Int) (BOUND_VARIABLE_689 Int)) (= BOUND_VARIABLE_688 BOUND_VARIABLE_689)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_682 Int) (BOUND_VARIABLE_683 Int)) (+ BOUND_VARIABLE_682 BOUND_VARIABLE_683)) (nullable.some 8) (nullable.some 7))) (nullable.lift (lambda ((BOUND_VARIABLE_704 Int) (BOUND_VARIABLE_705 Int)) (= BOUND_VARIABLE_704 BOUND_VARIABLE_705)) ((_ tuple.select 0) t) (ite (and (nullable.is_some (nullable.some (nullable.is_some (nullable.some 2)))) (nullable.val (nullable.some (nullable.is_some (nullable.some 2))))) (nullable.some 15) (as nullable.null (Nullable Int)))))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_676 Int) (BOUND_VARIABLE_677 Int)) (= BOUND_VARIABLE_676 BOUND_VARIABLE_677)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_670 Int) (BOUND_VARIABLE_671 Int)) (+ BOUND_VARIABLE_670 BOUND_VARIABLE_671)) (nullable.some 7) (nullable.some 8)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_676 Int) (BOUND_VARIABLE_677 Int)) (= BOUND_VARIABLE_676 BOUND_VARIABLE_677)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_670 Int) (BOUND_VARIABLE_671 Int)) (+ BOUND_VARIABLE_670 BOUND_VARIABLE_671)) (nullable.some 7) (nullable.some 8)))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_688 Int) (BOUND_VARIABLE_689 Int)) (= BOUND_VARIABLE_688 BOUND_VARIABLE_689)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_682 Int) (BOUND_VARIABLE_683 Int)) (+ BOUND_VARIABLE_682 BOUND_VARIABLE_683)) (nullable.some 8) (nullable.some 7)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_688 Int) (BOUND_VARIABLE_689 Int)) (= BOUND_VARIABLE_688 BOUND_VARIABLE_689)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_682 Int) (BOUND_VARIABLE_683 Int)) (+ BOUND_VARIABLE_682 BOUND_VARIABLE_683)) (nullable.some 8) (nullable.some 7)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_719 Bool) (BOUND_VARIABLE_720 Bool) (BOUND_VARIABLE_721 Bool)) (and BOUND_VARIABLE_719 BOUND_VARIABLE_720 BOUND_VARIABLE_721)) (nullable.lift (lambda ((BOUND_VARIABLE_676 Int) (BOUND_VARIABLE_677 Int)) (= BOUND_VARIABLE_676 BOUND_VARIABLE_677)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_670 Int) (BOUND_VARIABLE_671 Int)) (+ BOUND_VARIABLE_670 BOUND_VARIABLE_671)) (nullable.some 7) (nullable.some 8))) (nullable.lift (lambda ((BOUND_VARIABLE_688 Int) (BOUND_VARIABLE_689 Int)) (= BOUND_VARIABLE_688 BOUND_VARIABLE_689)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_682 Int) (BOUND_VARIABLE_683 Int)) (+ BOUND_VARIABLE_682 BOUND_VARIABLE_683)) (nullable.some 8) (nullable.some 7))) (nullable.lift (lambda ((BOUND_VARIABLE_704 Int) (BOUND_VARIABLE_705 Int)) (= BOUND_VARIABLE_704 BOUND_VARIABLE_705)) ((_ tuple.select 0) t) (ite (and (nullable.is_some (nullable.some (nullable.is_some (nullable.some 2)))) (nullable.val (nullable.some (nullable.is_some (nullable.some 2))))) (nullable.some 15) (as nullable.null (Nullable Int))))))))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_766 Int) (BOUND_VARIABLE_767 Int)) (+ BOUND_VARIABLE_766 BOUND_VARIABLE_767)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_781 Int) (BOUND_VARIABLE_782 Int)) (+ BOUND_VARIABLE_781 BOUND_VARIABLE_782)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_775 Int) (BOUND_VARIABLE_776 Int)) (+ BOUND_VARIABLE_775 BOUND_VARIABLE_776)) (nullable.some 3) (nullable.some 3))) (nullable.lift (lambda ((BOUND_VARIABLE_795 Int) (BOUND_VARIABLE_796 Int)) (+ BOUND_VARIABLE_795 BOUND_VARIABLE_796)) (nullable.lift (lambda ((BOUND_VARIABLE_789 Int) (BOUND_VARIABLE_790 Int)) (+ BOUND_VARIABLE_789 BOUND_VARIABLE_790)) (nullable.some 5) (nullable.some 6)) ((_ tuple.select 0) t)) (as nullable.null (Nullable Int)) (nullable.some 2) (nullable.lift (lambda ((BOUND_VARIABLE_801 Int) (BOUND_VARIABLE_802 Int)) (+ BOUND_VARIABLE_801 BOUND_VARIABLE_802)) (nullable.some 7) (nullable.some 8))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 3) (nullable.some 22) (nullable.some 26) (as nullable.null (Nullable Int)) (nullable.some 2) (nullable.some 15)))))
(assert (= q1 (bag.map f4 (bag.filter p3 ((_ table.project 0 1 3 4 5 6 7 8 9 10 11) (bag.filter p2 (table.product (bag.map f0 DEPT) (bag.map f1 EMP))))))))
(assert (= q2 (bag.map f6 (bag.filter p5 (bag (tuple (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0)) 1)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10021 ms.
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

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_512 Int) (BOUND_VARIABLE_513 Int)) (= BOUND_VARIABLE_512 BOUND_VARIABLE_513)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_512 Int) (BOUND_VARIABLE_513 Int)) (= BOUND_VARIABLE_512 BOUND_VARIABLE_513)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_536 Int) (BOUND_VARIABLE_537 Int)) (= BOUND_VARIABLE_536 BOUND_VARIABLE_537)) ((_ tuple.select 11) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_536 Int) (BOUND_VARIABLE_537 Int)) (= BOUND_VARIABLE_536 BOUND_VARIABLE_537)) ((_ tuple.select 11) t) (nullable.some 10))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_551 Bool) (BOUND_VARIABLE_552 Bool)) (and BOUND_VARIABLE_551 BOUND_VARIABLE_552)) (nullable.lift (lambda ((BOUND_VARIABLE_512 Int) (BOUND_VARIABLE_513 Int)) (= BOUND_VARIABLE_512 BOUND_VARIABLE_513)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_536 Int) (BOUND_VARIABLE_537 Int)) (= BOUND_VARIABLE_536 BOUND_VARIABLE_537)) ((_ tuple.select 11) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_512 Int) (BOUND_VARIABLE_513 Int)) (= BOUND_VARIABLE_512 BOUND_VARIABLE_513)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_512 Int) (BOUND_VARIABLE_513 Int)) (= BOUND_VARIABLE_512 BOUND_VARIABLE_513)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_536 Int) (BOUND_VARIABLE_537 Int)) (= BOUND_VARIABLE_536 BOUND_VARIABLE_537)) ((_ tuple.select 11) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_536 Int) (BOUND_VARIABLE_537 Int)) (= BOUND_VARIABLE_536 BOUND_VARIABLE_537)) ((_ tuple.select 11) t) (nullable.some 10))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_551 Bool) (BOUND_VARIABLE_552 Bool)) (and BOUND_VARIABLE_551 BOUND_VARIABLE_552)) (nullable.lift (lambda ((BOUND_VARIABLE_512 Int) (BOUND_VARIABLE_513 Int)) (= BOUND_VARIABLE_512 BOUND_VARIABLE_513)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_536 Int) (BOUND_VARIABLE_537 Int)) (= BOUND_VARIABLE_536 BOUND_VARIABLE_537)) ((_ tuple.select 11) t) (nullable.some 10))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_574 Int) (BOUND_VARIABLE_575 Int)) (= BOUND_VARIABLE_574 BOUND_VARIABLE_575)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_574 Int) (BOUND_VARIABLE_575 Int)) (= BOUND_VARIABLE_574 BOUND_VARIABLE_575)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (>= BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (>= BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_656 Int) (BOUND_VARIABLE_657 Int)) (= BOUND_VARIABLE_656 BOUND_VARIABLE_657)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_656 Int) (BOUND_VARIABLE_657 Int)) (= BOUND_VARIABLE_656 BOUND_VARIABLE_657)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p2 ((_ table.project 9 1) (bag.filter p1 (table.product EMP (bag.map f0 DEPT))))))))
(assert (= q2 ((_ table.project 9 1) (bag.filter p4 (table.product EMP ((_ table.project 0 1) (bag.filter p3 DEPT)))))))
(check-sat)
;answer: sat
; duration: 4113 ms.
(get-model)
; (
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 11) (nullable.some "F")) 1))
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some (- 3)) (nullable.some "D") (nullable.some "E") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 11) (nullable.some 6)) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 11) (nullable.some "D")) 1)
; insert into DEPT values(11,'F')
; insert into EMP values(-3,'D','E',4,-4,5,-5,11,6)
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (>= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (>= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (= BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (= BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (bag.union_max ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.union_max ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)))))
(assert (= q2 (bag.union_max (bag.union_max ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)))))
(check-sat)
;answer: sat
; duration: 1827 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag.union_disjoint (bag (tuple (nullable.some (- 9)) (nullable.some "E") (nullable.some "F") (nullable.some (- 10)) (nullable.some (- 11)) (nullable.some 12) (nullable.some (- 12)) (nullable.some 11) (nullable.some 13)) 1) (bag.union_disjoint (bag (tuple (nullable.some (- 16)) (nullable.some "I") (nullable.some "J") (nullable.some 17) (nullable.some (- 17)) (nullable.some 18) (nullable.some (- 18)) (nullable.some 10) (nullable.some 19)) 1) (bag (tuple (nullable.some 23) (nullable.some "M") (nullable.some "N") (nullable.some (- 23)) (nullable.some 24) (nullable.some (- 24)) (nullable.some 25) (nullable.some 10) (nullable.some (- 25))) 1))))
; )
; q1
(get-value (q1))
; (bag.union_disjoint (bag (tuple (nullable.some (- 16)) (nullable.some "I") (nullable.some "J") (nullable.some 17) (nullable.some (- 17)) (nullable.some 18) (nullable.some (- 18)) (nullable.some 10) (nullable.some 19)) 1) (bag (tuple (nullable.some 23) (nullable.some "M") (nullable.some "N") (nullable.some (- 23)) (nullable.some 24) (nullable.some (- 24)) (nullable.some 25) (nullable.some 10) (nullable.some (- 25))) 1))
; q2
(get-value (q2))
; (bag.union_disjoint (bag (tuple (nullable.some (- 9)) (nullable.some "E") (nullable.some "F") (nullable.some (- 10)) (nullable.some (- 11)) (nullable.some 12) (nullable.some (- 12)) (nullable.some 11) (nullable.some 13)) 1) (bag.union_disjoint (bag (tuple (nullable.some (- 16)) (nullable.some "I") (nullable.some "J") (nullable.some 17) (nullable.some (- 17)) (nullable.some 18) (nullable.some (- 18)) (nullable.some 10) (nullable.some 19)) 1) (bag (tuple (nullable.some 23) (nullable.some "M") (nullable.some "N") (nullable.some (- 23)) (nullable.some 24) (nullable.some (- 24)) (nullable.some 25) (nullable.some 10) (nullable.some (- 25))) 1)))
; insert into EMP values(-9,'E','F',-10,-11,12,-12,11,13),(-16,'I','J',17,-17,18,-18,10,19),(23,'M','N',-23,24,-24,25,10,-25)
; SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 10 UNION SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS q2;

; SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 10 UNION SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS q1;
;(-9,E,F,-10,-11,12,-12,11,13)

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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_461 Bool) (BOUND_VARIABLE_462 Bool) (BOUND_VARIABLE_463 Bool)) (or BOUND_VARIABLE_461 BOUND_VARIABLE_462 BOUND_VARIABLE_463)) (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_448 Int) (BOUND_VARIABLE_449 Int)) (> BOUND_VARIABLE_448 BOUND_VARIABLE_449)) ((_ tuple.select 5) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_461 Bool) (BOUND_VARIABLE_462 Bool) (BOUND_VARIABLE_463 Bool)) (or BOUND_VARIABLE_461 BOUND_VARIABLE_462 BOUND_VARIABLE_463)) (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_448 Int) (BOUND_VARIABLE_449 Int)) (> BOUND_VARIABLE_448 BOUND_VARIABLE_449)) ((_ tuple.select 5) t) (nullable.some 10))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_552 Int) (BOUND_VARIABLE_553 Int)) (= BOUND_VARIABLE_552 BOUND_VARIABLE_553)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_552 Int) (BOUND_VARIABLE_553 Int)) (= BOUND_VARIABLE_552 BOUND_VARIABLE_553)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_590 Int) (BOUND_VARIABLE_591 Int)) (>= BOUND_VARIABLE_590 BOUND_VARIABLE_591)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_590 Int) (BOUND_VARIABLE_591 Int)) (>= BOUND_VARIABLE_590 BOUND_VARIABLE_591)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_596 Int) (BOUND_VARIABLE_597 Int)) (= BOUND_VARIABLE_596 BOUND_VARIABLE_597)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_596 Int) (BOUND_VARIABLE_597 Int)) (= BOUND_VARIABLE_596 BOUND_VARIABLE_597)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_615 Bool) (BOUND_VARIABLE_616 Bool) (BOUND_VARIABLE_617 Bool)) (or BOUND_VARIABLE_615 BOUND_VARIABLE_616 BOUND_VARIABLE_617)) (nullable.lift (lambda ((BOUND_VARIABLE_590 Int) (BOUND_VARIABLE_591 Int)) (>= BOUND_VARIABLE_590 BOUND_VARIABLE_591)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_596 Int) (BOUND_VARIABLE_597 Int)) (= BOUND_VARIABLE_596 BOUND_VARIABLE_597)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_603 Int) (BOUND_VARIABLE_604 Int)) (> BOUND_VARIABLE_603 BOUND_VARIABLE_604)) ((_ tuple.select 5) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_590 Int) (BOUND_VARIABLE_591 Int)) (>= BOUND_VARIABLE_590 BOUND_VARIABLE_591)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_590 Int) (BOUND_VARIABLE_591 Int)) (>= BOUND_VARIABLE_590 BOUND_VARIABLE_591)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_596 Int) (BOUND_VARIABLE_597 Int)) (= BOUND_VARIABLE_596 BOUND_VARIABLE_597)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_596 Int) (BOUND_VARIABLE_597 Int)) (= BOUND_VARIABLE_596 BOUND_VARIABLE_597)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_615 Bool) (BOUND_VARIABLE_616 Bool) (BOUND_VARIABLE_617 Bool)) (or BOUND_VARIABLE_615 BOUND_VARIABLE_616 BOUND_VARIABLE_617)) (nullable.lift (lambda ((BOUND_VARIABLE_590 Int) (BOUND_VARIABLE_591 Int)) (>= BOUND_VARIABLE_590 BOUND_VARIABLE_591)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_596 Int) (BOUND_VARIABLE_597 Int)) (= BOUND_VARIABLE_596 BOUND_VARIABLE_597)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_603 Int) (BOUND_VARIABLE_604 Int)) (> BOUND_VARIABLE_603 BOUND_VARIABLE_604)) ((_ tuple.select 5) t) (nullable.some 10))))))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_637 Int) (BOUND_VARIABLE_638 Int)) (= BOUND_VARIABLE_637 BOUND_VARIABLE_638)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_637 Int) (BOUND_VARIABLE_638 Int)) (= BOUND_VARIABLE_637 BOUND_VARIABLE_638)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f2 (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) EMP)))))
(assert (= q2 (bag.map f5 (bag.filter p4 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) EMP)))))
(check-sat)
;answer: sat
; duration: 6669 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some (- 9)) (nullable.some "E") (nullable.some "F") (nullable.some 10) (nullable.some (- 10)) (as nullable.null (Nullable Int)) (nullable.some (- 11)) (nullable.some 8) (nullable.some (- 12))) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 1)) 1)
; insert into EMP values(-9,'E','F',10,-10,NULL,-11,8,-12)
; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 OR EMP.DEPTNO = 9 OR EMP.COMM > 10) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7 OR EMP1.DEPTNO = 9 OR EMP1.COMM > 10) AS t1 INNER JOIN EMP AS EMP2 ON t1.DEPTNO = EMP2.DEPTNO) AS q2;

; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7 OR EMP1.DEPTNO = 9 OR EMP1.COMM > 10) AS t1 INNER JOIN EMP AS EMP2 ON t1.DEPTNO = EMP2.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 OR EMP.DEPTNO = 9 OR EMP.COMM > 10) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO) AS q1;
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
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_398 Int) (BOUND_VARIABLE_399 Int)) (> BOUND_VARIABLE_398 BOUND_VARIABLE_399)) (nullable.lift (lambda ((BOUND_VARIABLE_389 Int) (BOUND_VARIABLE_390 Int)) (+ BOUND_VARIABLE_389 BOUND_VARIABLE_390)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_398 Int) (BOUND_VARIABLE_399 Int)) (> BOUND_VARIABLE_398 BOUND_VARIABLE_399)) (nullable.lift (lambda ((BOUND_VARIABLE_389 Int) (BOUND_VARIABLE_390 Int)) (+ BOUND_VARIABLE_389 BOUND_VARIABLE_390)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 0)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_448 Int) (BOUND_VARIABLE_449 Int)) (+ BOUND_VARIABLE_448 BOUND_VARIABLE_449)) (nullable.lift (lambda ((BOUND_VARIABLE_442 Int) (BOUND_VARIABLE_443 Int)) (+ BOUND_VARIABLE_442 BOUND_VARIABLE_443)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 0) t))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_483 Int) (BOUND_VARIABLE_484 Int)) (+ BOUND_VARIABLE_483 BOUND_VARIABLE_484)) (nullable.lift (lambda ((BOUND_VARIABLE_477 Int) (BOUND_VARIABLE_478 Int)) (+ BOUND_VARIABLE_477 BOUND_VARIABLE_478)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 0) t))))))
(assert (= q1 (bag.map f1 (bag.filter p0 (bag.union_disjoint (bag (tuple (nullable.some 10) (nullable.some 1)) 1) (bag (tuple (nullable.some 30) (nullable.some 3)) 1))))))
(assert (= q2 (bag.map f3 (bag.filter p2 (bag (tuple (nullable.some 0) (nullable.some 0)) 1)))))
(check-sat)
;answer: sat
; duration: 71 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (bag.union_disjoint (bag (tuple (nullable.some 21)) 1) (bag (tuple (nullable.some 63)) 1))
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_460 Bool) (BOUND_VARIABLE_461 Bool) (BOUND_VARIABLE_462 Bool)) (or BOUND_VARIABLE_460 BOUND_VARIABLE_461 BOUND_VARIABLE_462)) (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_447 Int) (BOUND_VARIABLE_448 Int)) (> BOUND_VARIABLE_447 BOUND_VARIABLE_448)) ((_ tuple.select 7) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_460 Bool) (BOUND_VARIABLE_461 Bool) (BOUND_VARIABLE_462 Bool)) (or BOUND_VARIABLE_460 BOUND_VARIABLE_461 BOUND_VARIABLE_462)) (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_447 Int) (BOUND_VARIABLE_448 Int)) (> BOUND_VARIABLE_447 BOUND_VARIABLE_448)) ((_ tuple.select 7) t) (nullable.some 10))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_551 Int) (BOUND_VARIABLE_552 Int)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_551 Int) (BOUND_VARIABLE_552 Int)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_589 Int) (BOUND_VARIABLE_590 Int)) (>= BOUND_VARIABLE_589 BOUND_VARIABLE_590)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_589 Int) (BOUND_VARIABLE_590 Int)) (>= BOUND_VARIABLE_589 BOUND_VARIABLE_590)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_595 Int) (BOUND_VARIABLE_596 Int)) (= BOUND_VARIABLE_595 BOUND_VARIABLE_596)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_595 Int) (BOUND_VARIABLE_596 Int)) (= BOUND_VARIABLE_595 BOUND_VARIABLE_596)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_613 Bool) (BOUND_VARIABLE_614 Bool) (BOUND_VARIABLE_615 Bool)) (or BOUND_VARIABLE_613 BOUND_VARIABLE_614 BOUND_VARIABLE_615)) (nullable.lift (lambda ((BOUND_VARIABLE_589 Int) (BOUND_VARIABLE_590 Int)) (>= BOUND_VARIABLE_589 BOUND_VARIABLE_590)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_595 Int) (BOUND_VARIABLE_596 Int)) (= BOUND_VARIABLE_595 BOUND_VARIABLE_596)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_601 Int) (BOUND_VARIABLE_602 Int)) (> BOUND_VARIABLE_601 BOUND_VARIABLE_602)) ((_ tuple.select 7) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_589 Int) (BOUND_VARIABLE_590 Int)) (>= BOUND_VARIABLE_589 BOUND_VARIABLE_590)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_589 Int) (BOUND_VARIABLE_590 Int)) (>= BOUND_VARIABLE_589 BOUND_VARIABLE_590)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_595 Int) (BOUND_VARIABLE_596 Int)) (= BOUND_VARIABLE_595 BOUND_VARIABLE_596)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_595 Int) (BOUND_VARIABLE_596 Int)) (= BOUND_VARIABLE_595 BOUND_VARIABLE_596)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_613 Bool) (BOUND_VARIABLE_614 Bool) (BOUND_VARIABLE_615 Bool)) (or BOUND_VARIABLE_613 BOUND_VARIABLE_614 BOUND_VARIABLE_615)) (nullable.lift (lambda ((BOUND_VARIABLE_589 Int) (BOUND_VARIABLE_590 Int)) (>= BOUND_VARIABLE_589 BOUND_VARIABLE_590)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_595 Int) (BOUND_VARIABLE_596 Int)) (= BOUND_VARIABLE_595 BOUND_VARIABLE_596)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_601 Int) (BOUND_VARIABLE_602 Int)) (> BOUND_VARIABLE_601 BOUND_VARIABLE_602)) ((_ tuple.select 7) t) (nullable.some 10))))))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_633 Int) (BOUND_VARIABLE_634 Int)) (>= BOUND_VARIABLE_633 BOUND_VARIABLE_634)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_633 Int) (BOUND_VARIABLE_634 Int)) (>= BOUND_VARIABLE_633 BOUND_VARIABLE_634)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_639 Int) (BOUND_VARIABLE_640 Int)) (= BOUND_VARIABLE_639 BOUND_VARIABLE_640)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_639 Int) (BOUND_VARIABLE_640 Int)) (= BOUND_VARIABLE_639 BOUND_VARIABLE_640)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_657 Bool) (BOUND_VARIABLE_658 Bool) (BOUND_VARIABLE_659 Bool)) (or BOUND_VARIABLE_657 BOUND_VARIABLE_658 BOUND_VARIABLE_659)) (nullable.lift (lambda ((BOUND_VARIABLE_633 Int) (BOUND_VARIABLE_634 Int)) (>= BOUND_VARIABLE_633 BOUND_VARIABLE_634)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_639 Int) (BOUND_VARIABLE_640 Int)) (= BOUND_VARIABLE_639 BOUND_VARIABLE_640)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_645 Int) (BOUND_VARIABLE_646 Int)) (> BOUND_VARIABLE_645 BOUND_VARIABLE_646)) ((_ tuple.select 7) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_633 Int) (BOUND_VARIABLE_634 Int)) (>= BOUND_VARIABLE_633 BOUND_VARIABLE_634)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_633 Int) (BOUND_VARIABLE_634 Int)) (>= BOUND_VARIABLE_633 BOUND_VARIABLE_634)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_639 Int) (BOUND_VARIABLE_640 Int)) (= BOUND_VARIABLE_639 BOUND_VARIABLE_640)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_639 Int) (BOUND_VARIABLE_640 Int)) (= BOUND_VARIABLE_639 BOUND_VARIABLE_640)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_657 Bool) (BOUND_VARIABLE_658 Bool) (BOUND_VARIABLE_659 Bool)) (or BOUND_VARIABLE_657 BOUND_VARIABLE_658 BOUND_VARIABLE_659)) (nullable.lift (lambda ((BOUND_VARIABLE_633 Int) (BOUND_VARIABLE_634 Int)) (>= BOUND_VARIABLE_633 BOUND_VARIABLE_634)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_639 Int) (BOUND_VARIABLE_640 Int)) (= BOUND_VARIABLE_639 BOUND_VARIABLE_640)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_645 Int) (BOUND_VARIABLE_646 Int)) (> BOUND_VARIABLE_645 BOUND_VARIABLE_646)) ((_ tuple.select 7) t) (nullable.some 10))))))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_679 Int) (BOUND_VARIABLE_680 Int)) (= BOUND_VARIABLE_679 BOUND_VARIABLE_680)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_679 Int) (BOUND_VARIABLE_680 Int)) (= BOUND_VARIABLE_679 BOUND_VARIABLE_680)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f2 (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) EMP)))))
(assert (= q2 (bag.map f6 (bag.filter p5 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)))))))
(check-sat)
;answer: sat
; duration: 9639 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some (- 10)) (nullable.some "E") (nullable.some "F") (nullable.some (- 11)) (nullable.some 12) (nullable.some (- 12)) (nullable.some 13) (nullable.some 8) (nullable.some (- 13))) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 1)) 1)
; insert into EMP values(-10,'E','F',-11,12,-12,13,8,-13)
; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 OR EMP.DEPTNO = 9 OR EMP.DEPTNO > 10) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7 OR EMP1.DEPTNO = 9 OR EMP1.DEPTNO > 10) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 7 OR EMP2.DEPTNO = 9 OR EMP2.DEPTNO > 10) AS t2 ON t1.DEPTNO = t2.DEPTNO) AS q2;

; SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO >= 7 OR EMP1.DEPTNO = 9 OR EMP1.DEPTNO > 10) AS t1 INNER JOIN (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 7 OR EMP2.DEPTNO = 9 OR EMP2.DEPTNO > 10) AS t2 ON t1.DEPTNO = t2.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 7 OR EMP.DEPTNO = 9 OR EMP.DEPTNO > 10) AS t INNER JOIN EMP AS EMP0 ON t.DEPTNO = EMP0.DEPTNO) AS q1;
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_462 Int) (BOUND_VARIABLE_463 Int)) (> BOUND_VARIABLE_462 BOUND_VARIABLE_463)) (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (+ BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 5)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_462 Int) (BOUND_VARIABLE_463 Int)) (> BOUND_VARIABLE_462 BOUND_VARIABLE_463)) (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (+ BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 5)) ((_ tuple.select 0) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_479 Int) (BOUND_VARIABLE_480 Int)) (= BOUND_VARIABLE_479 BOUND_VARIABLE_480)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_479 Int) (BOUND_VARIABLE_480 Int)) (= BOUND_VARIABLE_479 BOUND_VARIABLE_480)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_498 Int) (BOUND_VARIABLE_499 Int)) (>= BOUND_VARIABLE_498 BOUND_VARIABLE_499)) (nullable.some 15) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_498 Int) (BOUND_VARIABLE_499 Int)) (>= BOUND_VARIABLE_498 BOUND_VARIABLE_499)) (nullable.some 15) ((_ tuple.select 0) t)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP))))))
(check-sat)
;answer: sat
; duration: 322 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 15) (nullable.some "C") (nullable.some "D") (nullable.some 6) (nullable.some (- 6)) (nullable.some 7) (nullable.some (- 7)) (nullable.some 10) (nullable.some 8)) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 15) (nullable.some "C") (nullable.some "D") (nullable.some 6) (nullable.some (- 6)) (nullable.some 7) (nullable.some (- 7)) (nullable.some 10) (nullable.some 8)) 1)
; insert into EMP values(15,'C','D',6,-6,7,-7,10,8)
; SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10) AS t WHERE t.DEPTNO + 5 > t.EMPNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 10) AS t1 WHERE 15 >= t1.EMPNO) AS q2;

; SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 10) AS t1 WHERE 15 >= t1.EMPNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10) AS t WHERE t.DEPTNO + 5 > t.EMPNO) AS q1;
;(15,C,D,6,-6,7,-7,10,8)

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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 5) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 5) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (= BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (= BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_532 Int) (BOUND_VARIABLE_533 Int)) (>= BOUND_VARIABLE_532 BOUND_VARIABLE_533)) ((_ tuple.select 5) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_532 Int) (BOUND_VARIABLE_533 Int)) (>= BOUND_VARIABLE_532 BOUND_VARIABLE_533)) ((_ tuple.select 5) t) (nullable.some 7)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_549 Int) (BOUND_VARIABLE_550 Int)) (>= BOUND_VARIABLE_549 BOUND_VARIABLE_550)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_549 Int) (BOUND_VARIABLE_550 Int)) (>= BOUND_VARIABLE_549 BOUND_VARIABLE_550)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_569 Int) (BOUND_VARIABLE_570 Int)) (= BOUND_VARIABLE_569 BOUND_VARIABLE_570)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_569 Int) (BOUND_VARIABLE_570 Int)) (= BOUND_VARIABLE_569 BOUND_VARIABLE_570)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f2 (bag.filter p1 (table.product ((_ table.project 5) (bag.filter p0 EMP)) EMP)))))
(assert (= q2 (bag.map f6 (bag.filter p5 (table.product ((_ table.project 5) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10015 ms.
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_473 Int) (BOUND_VARIABLE_474 Int)) (= BOUND_VARIABLE_473 BOUND_VARIABLE_474)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_473 Int) (BOUND_VARIABLE_474 Int)) (= BOUND_VARIABLE_473 BOUND_VARIABLE_474)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (>= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (>= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_527 Int) (BOUND_VARIABLE_528 Int)) (= BOUND_VARIABLE_527 BOUND_VARIABLE_528)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_527 Int) (BOUND_VARIABLE_528 Int)) (= BOUND_VARIABLE_527 BOUND_VARIABLE_528)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (bag.union_max ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.inter_min ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)))))))
(assert (= q2 (bag.union_max ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.inter_min ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)))))))
(check-sat)
;answer: sat
; duration: 2751 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag.union_disjoint (bag (tuple (nullable.some 4) (nullable.some "A") (nullable.some "B") (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (nullable.some 30) (nullable.some (- 6))) 1) (bag.union_disjoint (bag (tuple (nullable.some 11) (nullable.some "E") (nullable.some "F") (nullable.some (- 11)) (nullable.some 12) (nullable.some (- 12)) (nullable.some 13) (nullable.some 30) (nullable.some (- 13))) 1) (bag.union_disjoint (bag (tuple (nullable.some 14) (nullable.some "G") (nullable.some "H") (nullable.some (- 14)) (nullable.some 15) (nullable.some (- 15)) (nullable.some 16) (nullable.some 10) (nullable.some (- 16))) 1) (bag.union_disjoint (bag (tuple (nullable.some 17) (nullable.some "I") (nullable.some "J") (nullable.some (- 17)) (nullable.some 18) (nullable.some (- 18)) (nullable.some 19) (nullable.some 30) (nullable.some (- 19))) 1) (bag.union_disjoint (bag (tuple (nullable.some 20) (nullable.some "K") (nullable.some "L") (nullable.some (- 20)) (nullable.some 21) (nullable.some (- 21)) (nullable.some 22) (nullable.some 30) (nullable.some (- 22))) 1) (bag.union_disjoint (bag (tuple (nullable.some 23) (nullable.some "M") (nullable.some "N") (nullable.some (- 23)) (nullable.some 24) (nullable.some (- 24)) (nullable.some 25) (nullable.some 30) (nullable.some (- 25))) 1) (bag.union_disjoint (bag (tuple (nullable.some 26) (nullable.some "O") (nullable.some "P") (nullable.some (- 26)) (nullable.some 27) (nullable.some (- 27)) (nullable.some 28) (nullable.some 30) (nullable.some (- 28))) 1) (bag.union_disjoint (bag (tuple (nullable.some 29) (nullable.some "Q") (nullable.some "R") (nullable.some (- 29)) (nullable.some (- 30)) (nullable.some 31) (nullable.some (- 31)) (nullable.some 30) (nullable.some 32)) 1) (bag (tuple (nullable.some (- 32)) (nullable.some "S") (nullable.some "T") (nullable.some 33) (nullable.some (- 33)) (nullable.some 34) (nullable.some (- 34)) (nullable.some 30) (nullable.some 35)) 1))))))))))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 14) (nullable.some "G") (nullable.some "H") (nullable.some (- 14)) (nullable.some 15) (nullable.some (- 15)) (nullable.some 16) (nullable.some 10) (nullable.some (- 16))) 1)
; q2
(get-value (q2))
; (bag.union_disjoint (bag (tuple (nullable.some 4) (nullable.some "A") (nullable.some "B") (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (nullable.some 30) (nullable.some (- 6))) 1) (bag.union_disjoint (bag (tuple (nullable.some 11) (nullable.some "E") (nullable.some "F") (nullable.some (- 11)) (nullable.some 12) (nullable.some (- 12)) (nullable.some 13) (nullable.some 30) (nullable.some (- 13))) 1) (bag.union_disjoint (bag (tuple (nullable.some 14) (nullable.some "G") (nullable.some "H") (nullable.some (- 14)) (nullable.some 15) (nullable.some (- 15)) (nullable.some 16) (nullable.some 10) (nullable.some (- 16))) 1) (bag.union_disjoint (bag (tuple (nullable.some 17) (nullable.some "I") (nullable.some "J") (nullable.some (- 17)) (nullable.some 18) (nullable.some (- 18)) (nullable.some 19) (nullable.some 30) (nullable.some (- 19))) 1) (bag.union_disjoint (bag (tuple (nullable.some 20) (nullable.some "K") (nullable.some "L") (nullable.some (- 20)) (nullable.some 21) (nullable.some (- 21)) (nullable.some 22) (nullable.some 30) (nullable.some (- 22))) 1) (bag.union_disjoint (bag (tuple (nullable.some 23) (nullable.some "M") (nullable.some "N") (nullable.some (- 23)) (nullable.some 24) (nullable.some (- 24)) (nullable.some 25) (nullable.some 30) (nullable.some (- 25))) 1) (bag.union_disjoint (bag (tuple (nullable.some 26) (nullable.some "O") (nullable.some "P") (nullable.some (- 26)) (nullable.some 27) (nullable.some (- 27)) (nullable.some 28) (nullable.some 30) (nullable.some (- 28))) 1) (bag.union_disjoint (bag (tuple (nullable.some 29) (nullable.some "Q") (nullable.some "R") (nullable.some (- 29)) (nullable.some (- 30)) (nullable.some 31) (nullable.some (- 31)) (nullable.some 30) (nullable.some 32)) 1) (bag (tuple (nullable.some (- 32)) (nullable.some "S") (nullable.some "T") (nullable.some 33) (nullable.some (- 33)) (nullable.some 34) (nullable.some (- 34)) (nullable.some 30) (nullable.some 35)) 1)))))))))
; insert into EMP values(4,'A','B',-4,5,-5,6,30,-6),(11,'E','F',-11,12,-12,13,30,-13),(14,'G','H',-14,15,-15,16,10,-16),(17,'I','J',-17,18,-18,19,30,-19),(20,'K','L',-20,21,-21,22,30,-22),(23,'M','N',-23,24,-24,25,30,-25),(26,'O','P',-26,27,-27,28,30,-28),(29,'Q','R',-29,-30,31,-31,30,32),(-32,'S','T',33,-33,34,-34,30,35)
; SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS t2) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 10 UNION SELECT * FROM (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS t7) AS q2;

; SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 10 UNION SELECT * FROM (SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS t7) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20 INTERSECT SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS t2) AS q1;
;(20,K,L,-20,21,-21,22,30,-22)
;(26,O,P,-26,27,-27,28,30,-28)
;(29,Q,R,-29,-30,31,-31,30,32)
;(11,E,F,-11,12,-12,13,30,-13)
;(17,I,J,-17,18,-18,19,30,-19)
;(4,A,B,-4,5,-5,6,30,-6)
;(23,M,N,-23,24,-24,25,30,-25)
;(-32,S,T,33,-33,34,-34,30,35)

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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (ite (and (nullable.is_some (nullable.some (nullable.is_some ((_ tuple.select 0) t)))) (not (nullable.val (nullable.some (nullable.is_some ((_ tuple.select 0) t)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_449 Bool) (BOUND_VARIABLE_450 Bool)) (and BOUND_VARIABLE_449 BOUND_VARIABLE_450)) (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some (nullable.is_some ((_ tuple.select 0) t))))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (ite (and (nullable.is_some (nullable.some (nullable.is_some ((_ tuple.select 0) t)))) (not (nullable.val (nullable.some (nullable.is_some ((_ tuple.select 0) t)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_449 Bool) (BOUND_VARIABLE_450 Bool)) (and BOUND_VARIABLE_449 BOUND_VARIABLE_450)) (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some (nullable.is_some ((_ tuple.select 0) t)))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_484 Int) (BOUND_VARIABLE_485 Int)) (>= BOUND_VARIABLE_484 BOUND_VARIABLE_485)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_484 Int) (BOUND_VARIABLE_485 Int)) (>= BOUND_VARIABLE_484 BOUND_VARIABLE_485)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= q1 ((_ table.project 0) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0) (bag.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 149 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 11) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 0) (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3)) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 11)) 1)
; insert into EMP values(11,NULL,'',0,1,-1,2,-2,3)
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_391 Int) (BOUND_VARIABLE_392 Int)) (>= BOUND_VARIABLE_391 BOUND_VARIABLE_392)) ((_ tuple.select 0) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_391 Int) (BOUND_VARIABLE_392 Int)) (>= BOUND_VARIABLE_391 BOUND_VARIABLE_392)) ((_ tuple.select 0) t) (nullable.some 50)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= q1 (bag.inter_min ((_ table.project 0 1) (bag.inter_min ((_ table.project 0 1) (bag (tuple (nullable.some 50) (nullable.some 3)) 1)) ((_ table.project 0 1) (bag.filter p0 (bag.union_disjoint (bag (tuple (nullable.some 10) (nullable.some 1)) 1) (bag (tuple (nullable.some 50) (nullable.some 3)) 1)))))) ((_ table.project 0 1) (bag (tuple (nullable.some 50) (nullable.some 3)) 1)))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p1 (bag (tuple (nullable.some 0) (nullable.some 0)) 1)))))
(check-sat)
;answer: sat
; duration: 11 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 50) (nullable.some 3)) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable Int))))
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 7) t) (nullable.lift (lambda ((BOUND_VARIABLE_467 Int) (BOUND_VARIABLE_468 Int)) (+ BOUND_VARIABLE_467 BOUND_VARIABLE_468)) ((_ tuple.select 7) t) (nullable.some 1)) (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (+ BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 0) t) ((_ tuple.select 7) t))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_491 Int) (BOUND_VARIABLE_492 Int)) (= BOUND_VARIABLE_491 BOUND_VARIABLE_492)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_491 Int) (BOUND_VARIABLE_492 Int)) (= BOUND_VARIABLE_491 BOUND_VARIABLE_492)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 11) (nullable.some 11) (nullable.lift (lambda ((BOUND_VARIABLE_509 Int) (BOUND_VARIABLE_510 Int)) (+ BOUND_VARIABLE_509 BOUND_VARIABLE_510)) ((_ tuple.select 0) t) (nullable.some 10))))))
(assert (= q1 (bag.map f1 (bag.filter p0 EMP))))
(assert (= q2 (bag.map f3 (bag.filter p2 EMP))))
(check-sat)
;answer: sat
; duration: 458 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 0) (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some 10) (nullable.some (- 2))) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 10) (nullable.some 11) (as nullable.null (Nullable Int))) 1)
; q2
(get-value (q2))
; (bag (tuple (nullable.some 11) (nullable.some 11) (as nullable.null (Nullable Int))) 1)
; insert into EMP values(NULL,NULL,'',0,1,-1,2,10,-2)
; SELECT * FROM (SELECT EMP.DEPTNO, EMP.DEPTNO + 1, EMP.EMPNO + EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO = 10) AS q1 EXCEPT ALL SELECT * FROM (SELECT 11 AS DEPTNO, 11, EMP0.EMPNO + 10 FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 10) AS q2;
;(10,11,NULL)

; SELECT * FROM (SELECT 11 AS DEPTNO, 11, EMP0.EMPNO + 10 FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 10) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.DEPTNO, EMP.DEPTNO + 1, EMP.EMPNO + EMP.DEPTNO FROM EMP AS EMP WHERE EMP.DEPTNO = 10) AS q1;
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (< BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 4))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (< BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 4)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_465 Int) (BOUND_VARIABLE_466 Int)) (> BOUND_VARIABLE_465 BOUND_VARIABLE_466)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_465 Int) (BOUND_VARIABLE_466 Int)) (> BOUND_VARIABLE_465 BOUND_VARIABLE_466)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_501 Int) (BOUND_VARIABLE_502 Int)) (= BOUND_VARIABLE_501 BOUND_VARIABLE_502)) ((_ tuple.select 0) t) ((_ tuple.select 1) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_501 Int) (BOUND_VARIABLE_502 Int)) (= BOUND_VARIABLE_501 BOUND_VARIABLE_502)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_520 Int) (BOUND_VARIABLE_521 Int)) (>= BOUND_VARIABLE_520 BOUND_VARIABLE_521)) ((_ tuple.select 7) t) (nullable.some 4))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_520 Int) (BOUND_VARIABLE_521 Int)) (>= BOUND_VARIABLE_520 BOUND_VARIABLE_521)) ((_ tuple.select 7) t) (nullable.some 4)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_537 Int) (BOUND_VARIABLE_538 Int)) (>= BOUND_VARIABLE_537 BOUND_VARIABLE_538)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_537 Int) (BOUND_VARIABLE_538 Int)) (>= BOUND_VARIABLE_537 BOUND_VARIABLE_538)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (< BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 0) t) (nullable.some 4))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (< BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 0) t) (nullable.some 4)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_576 Int) (BOUND_VARIABLE_577 Int)) (= BOUND_VARIABLE_576 BOUND_VARIABLE_577)) ((_ tuple.select 0) t) ((_ tuple.select 1) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_576 Int) (BOUND_VARIABLE_577 Int)) (= BOUND_VARIABLE_576 BOUND_VARIABLE_577)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p2 (table.product ((_ table.project 7) (bag.filter p0 EMP)) (bag.union_disjoint ((_ table.project 7) (bag.filter p1 EMP)) ((_ table.project 7) EMP)))))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p6 (table.product ((_ table.project 7) (bag.filter p3 EMP)) ((_ table.project 0) (bag.filter p5 (bag.union_disjoint ((_ table.project 7) (bag.filter p4 EMP)) ((_ table.project 7) EMP)))))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10825 ms.
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (>= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (>= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (>= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (>= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (= BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (= BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (bag.inter_min ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.inter_min ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)))))
(assert (= q2 (bag.inter_min (bag.inter_min ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)))))
(check-sat)
;answer: sat
; duration: 1100 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag.union_disjoint (bag (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 20) (nullable.some 3)) 1) (bag.union_disjoint (bag (tuple (nullable.some (- 3)) (nullable.some "A") (nullable.some "B") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 21) (nullable.some 6)) 1) (bag (tuple (nullable.some (- 6)) (nullable.some "C") (nullable.some "D") (nullable.some 7) (nullable.some (- 7)) (nullable.some 8) (nullable.some (- 8)) (nullable.some 30) (nullable.some 9)) 1))))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some (- 6)) (nullable.some "C") (nullable.some "D") (nullable.some 7) (nullable.some (- 7)) (nullable.some 8) (nullable.some (- 8)) (nullable.some 30) (nullable.some 9)) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; insert into EMP values(0,NULL,'',1,-1,2,-2,20,3),(-3,'A','B',4,-4,5,-5,21,6),(-6,'C','D',7,-7,8,-8,30,9)
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

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Bag (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_503 String) (BOUND_VARIABLE_504 String)) (= BOUND_VARIABLE_503 BOUND_VARIABLE_504)) ((_ tuple.select 1) t) (nullable.some "foo"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_503 String) (BOUND_VARIABLE_504 String)) (= BOUND_VARIABLE_503 BOUND_VARIABLE_504)) ((_ tuple.select 1) t) (nullable.some "foo"))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_519 Bool) (BOUND_VARIABLE_520 Bool)) (and BOUND_VARIABLE_519 BOUND_VARIABLE_520)) (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_503 String) (BOUND_VARIABLE_504 String)) (= BOUND_VARIABLE_503 BOUND_VARIABLE_504)) ((_ tuple.select 1) t) (nullable.some "foo")))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_503 String) (BOUND_VARIABLE_504 String)) (= BOUND_VARIABLE_503 BOUND_VARIABLE_504)) ((_ tuple.select 1) t) (nullable.some "foo"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_503 String) (BOUND_VARIABLE_504 String)) (= BOUND_VARIABLE_503 BOUND_VARIABLE_504)) ((_ tuple.select 1) t) (nullable.some "foo"))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_519 Bool) (BOUND_VARIABLE_520 Bool)) (and BOUND_VARIABLE_519 BOUND_VARIABLE_520)) (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_503 String) (BOUND_VARIABLE_504 String)) (= BOUND_VARIABLE_503 BOUND_VARIABLE_504)) ((_ tuple.select 1) t) (nullable.some "foo"))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_556 String) (BOUND_VARIABLE_557 String)) (= BOUND_VARIABLE_556 BOUND_VARIABLE_557)) ((_ tuple.select 1) t) (nullable.some "fo0"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_556 String) (BOUND_VARIABLE_557 String)) (= BOUND_VARIABLE_556 BOUND_VARIABLE_557)) ((_ tuple.select 1) t) (nullable.some "fo0")))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_577 Int) (BOUND_VARIABLE_578 Int)) (= BOUND_VARIABLE_577 BOUND_VARIABLE_578)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_577 Int) (BOUND_VARIABLE_578 Int)) (= BOUND_VARIABLE_577 BOUND_VARIABLE_578)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ table.project 1) (bag.filter p0 (table.product EMP DEPT)))))
(assert (= q2 ((_ table.project 1) (bag.filter p2 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)) DEPT)))))
(check-sat)
;answer: sat
; duration: 647 ms.
(get-model)
; (
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 0) (nullable.some "")) 1))
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 1) (nullable.some "fo0") (nullable.some "A") (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some 0) (nullable.some (- 3))) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable String))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some "fo0")) 1)
; insert into DEPT values(0,'')
; insert into EMP values(1,'fo0','A',-1,2,-2,3,0,-3)
; SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME = 'foo') AS q1 EXCEPT ALL SELECT * FROM (SELECT t1.ENAME FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.ENAME = 'fo0') AS t1 INNER JOIN DEPT AS DEPT0 ON t1.DEPTNO = DEPT0.DEPTNO) AS q2;

; SELECT * FROM (SELECT t1.ENAME FROM (SELECT * FROM EMP AS EMP0 WHERE EMP0.ENAME = 'fo0') AS t1 INNER JOIN DEPT AS DEPT0 ON t1.DEPTNO = DEPT0.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME = 'foo') AS q1;
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_537 String) (BOUND_VARIABLE_538 String)) (= BOUND_VARIABLE_537 BOUND_VARIABLE_538)) ((_ tuple.select 1) t) (nullable.some "Charli"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_537 String) (BOUND_VARIABLE_538 String)) (= BOUND_VARIABLE_537 BOUND_VARIABLE_538)) ((_ tuple.select 1) t) (nullable.some "Charli")))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_577 String) (BOUND_VARIABLE_578 String)) (= BOUND_VARIABLE_577 BOUND_VARIABLE_578)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_577 String) (BOUND_VARIABLE_578 String)) (= BOUND_VARIABLE_577 BOUND_VARIABLE_578)) ((_ tuple.select 1) t) (nullable.some "Charlie")))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_598 Int) (BOUND_VARIABLE_599 Int)) (= BOUND_VARIABLE_598 BOUND_VARIABLE_599)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_598 Int) (BOUND_VARIABLE_599 Int)) (= BOUND_VARIABLE_598 BOUND_VARIABLE_599)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f3 (bag.filter p2 (bag.union_disjoint (bag.map rightJoin1 (bag.difference_remove EMP ((_ table.project 2 3 4 5 6 7 8 9 10) (bag.filter p0 (table.product DEPT EMP))))) (bag.filter p0 (table.product DEPT EMP)))))))
(assert (= q2 (bag.map f6 (bag.filter p5 (table.product ((_ table.project 0 1) (bag.filter p4 DEPT)) EMP)))))
(check-sat)
;answer: sat
; duration: 1776 ms.
(get-model)
; (
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 0) (nullable.some "Charli")) 1))
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some (- 5)) (nullable.some "B") (nullable.some "C") (nullable.some 6) (nullable.some (- 6)) (nullable.some 7) (nullable.some (- 7)) (nullable.some 0) (nullable.some 8)) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 1)) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; insert into DEPT values(0,'Charli')
; insert into EMP values(-5,'B','C',6,-6,7,-7,0,8)
; SELECT * FROM (SELECT 1 FROM DEPT AS DEPT RIGHT JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charli') AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 INNER JOIN EMP AS EMP0 ON t1.DEPTNO = EMP0.DEPTNO) AS q2;
;(1)

; SELECT * FROM (SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 INNER JOIN EMP AS EMP0 ON t1.DEPTNO = EMP0.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM DEPT AS DEPT RIGHT JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charli') AS q1;

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

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_495 Int) (BOUND_VARIABLE_496 Int)) (>= BOUND_VARIABLE_495 BOUND_VARIABLE_496)) (nullable.lift (lambda ((BOUND_VARIABLE_479 Int) (BOUND_VARIABLE_480 Int)) (+ BOUND_VARIABLE_479 BOUND_VARIABLE_480)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_489 Int) (BOUND_VARIABLE_490 Int)) (* BOUND_VARIABLE_489 BOUND_VARIABLE_490)) ((_ tuple.select 9) t) (nullable.some 2)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_495 Int) (BOUND_VARIABLE_496 Int)) (>= BOUND_VARIABLE_495 BOUND_VARIABLE_496)) (nullable.lift (lambda ((BOUND_VARIABLE_479 Int) (BOUND_VARIABLE_480 Int)) (+ BOUND_VARIABLE_479 BOUND_VARIABLE_480)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_489 Int) (BOUND_VARIABLE_490 Int)) (* BOUND_VARIABLE_489 BOUND_VARIABLE_490)) ((_ tuple.select 9) t) (nullable.some 2))))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (nullable.lift (lambda ((BOUND_VARIABLE_565 Int) (BOUND_VARIABLE_566 Int)) (+ BOUND_VARIABLE_565 BOUND_VARIABLE_566)) ((_ tuple.select 0) t) (nullable.some 10))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 6) t) ((_ tuple.select 5) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_629 Int) (BOUND_VARIABLE_630 Int)) (* BOUND_VARIABLE_629 BOUND_VARIABLE_630)) ((_ tuple.select 7) t) (nullable.some 2))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_697 Int) (BOUND_VARIABLE_698 Int)) (= BOUND_VARIABLE_697 BOUND_VARIABLE_698)) ((_ tuple.select 2) t) ((_ tuple.select 12) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_697 Int) (BOUND_VARIABLE_698 Int)) (= BOUND_VARIABLE_697 BOUND_VARIABLE_698)) ((_ tuple.select 2) t) ((_ tuple.select 12) t)))))))
(assert (= q1 ((_ table.project 0 9) (bag.filter p0 (table.product DEPT EMP)))))
(assert (= q2 ((_ table.project 0 10) (bag.filter p3 (table.product (bag.map f1 DEPT) (bag.map f2 EMP))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10029 ms.
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

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_598 Bool) (BOUND_VARIABLE_599 Bool) (BOUND_VARIABLE_600 Bool)) (and BOUND_VARIABLE_598 BOUND_VARIABLE_599 BOUND_VARIABLE_600)) (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)) (nullable.lift (lambda ((BOUND_VARIABLE_582 String) (BOUND_VARIABLE_583 String)) (= BOUND_VARIABLE_582 BOUND_VARIABLE_583)) ((_ tuple.select 10) t) (nullable.some "foo")))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_598 Bool) (BOUND_VARIABLE_599 Bool) (BOUND_VARIABLE_600 Bool)) (and BOUND_VARIABLE_598 BOUND_VARIABLE_599 BOUND_VARIABLE_600)) (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)) (nullable.lift (lambda ((BOUND_VARIABLE_582 String) (BOUND_VARIABLE_583 String)) (= BOUND_VARIABLE_582 BOUND_VARIABLE_583)) ((_ tuple.select 10) t) (nullable.some "foo"))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_636 String) (BOUND_VARIABLE_637 String)) (= BOUND_VARIABLE_636 BOUND_VARIABLE_637)) ((_ tuple.select 1) t) (nullable.some "fo0"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_636 String) (BOUND_VARIABLE_637 String)) (= BOUND_VARIABLE_636 BOUND_VARIABLE_637)) ((_ tuple.select 1) t) (nullable.some "fo0")))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_657 Int) (BOUND_VARIABLE_658 Int)) (= BOUND_VARIABLE_657 BOUND_VARIABLE_658)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_657 Int) (BOUND_VARIABLE_658 Int)) (= BOUND_VARIABLE_657 BOUND_VARIABLE_658)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_676 Int) (BOUND_VARIABLE_677 Int)) (= BOUND_VARIABLE_676 BOUND_VARIABLE_677)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_676 Int) (BOUND_VARIABLE_677 Int)) (= BOUND_VARIABLE_676 BOUND_VARIABLE_677)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)))))))
(assert (= q1 ((_ table.project 1) (bag.filter p0 (table.product (table.product EMP DEPT) EMP)))))
(assert (= q2 ((_ table.project 1) (bag.filter p3 (table.product (bag.filter p2 (table.product EMP ((_ table.project 0 1) (bag.filter p1 DEPT)))) EMP)))))
(check-sat)
;answer: sat
; duration: 1966 ms.
(get-model)
; (
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 0) (nullable.some "fo0")) 1))
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 1) (nullable.some "A") (nullable.some "") (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some 0) (nullable.some (- 3))) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable String))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some "A")) 1)
; insert into DEPT values(0,'fo0')
; insert into EMP values(1,'A','',-1,2,-2,3,0,-3)
; SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = EMP0.DEPTNO AND DEPT.NAME = 'foo') AS q1 EXCEPT ALL SELECT * FROM (SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'fo0') AS t1 ON EMP1.DEPTNO = t1.DEPTNO INNER JOIN EMP AS EMP2 ON t1.DEPTNO = EMP2.DEPTNO) AS q2;

; SELECT * FROM (SELECT EMP1.ENAME FROM EMP AS EMP1 INNER JOIN (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'fo0') AS t1 ON EMP1.DEPTNO = t1.DEPTNO INNER JOIN EMP AS EMP2 ON t1.DEPTNO = EMP2.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT EMP.ENAME FROM EMP AS EMP, DEPT AS DEPT, EMP AS EMP0 WHERE EMP.DEPTNO = DEPT.DEPTNO AND DEPT.DEPTNO = EMP0.DEPTNO AND DEPT.NAME = 'foo') AS q1;
;(A)

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

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_551 String) (BOUND_VARIABLE_552 String)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 1) t) (nullable.some "Charli"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_551 String) (BOUND_VARIABLE_552 String)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 1) t) (nullable.some "Charli")))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_591 String) (BOUND_VARIABLE_592 String)) (= BOUND_VARIABLE_591 BOUND_VARIABLE_592)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_591 String) (BOUND_VARIABLE_592 String)) (= BOUND_VARIABLE_591 BOUND_VARIABLE_592)) ((_ tuple.select 1) t) (nullable.some "Charlie")))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_611 Int) (BOUND_VARIABLE_612 Int)) (= BOUND_VARIABLE_611 BOUND_VARIABLE_612)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_611 Int) (BOUND_VARIABLE_612 Int)) (= BOUND_VARIABLE_611 BOUND_VARIABLE_612)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f4 (bag.filter p3 (bag.union_disjoint (bag.union_disjoint (bag.map leftJoin1 (bag.difference_remove DEPT ((_ table.project 0 1) (bag.filter p0 (table.product DEPT EMP))))) (bag.map rightJoin2 (bag.difference_remove EMP ((_ table.project 2 3 4 5 6 7 8 9 10) (bag.filter p0 (table.product DEPT EMP)))))) (bag.filter p0 (table.product DEPT EMP)))))))
(assert (= q2 (bag.map f8 (bag.union_disjoint (bag.map leftJoin7 (bag.difference_remove ((_ table.project 0 1) (bag.filter p5 DEPT)) ((_ table.project 0 1) (bag.filter p6 (table.product ((_ table.project 0 1) (bag.filter p5 DEPT)) EMP))))) (bag.filter p6 (table.product ((_ table.project 0 1) (bag.filter p5 DEPT)) EMP))))))
(check-sat)
;answer: sat
; duration: 493 ms.
(get-model)
; (
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 0) (nullable.some "Charli")) 1))
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 1)) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; insert into DEPT values(0,'Charli')
; SELECT * FROM (SELECT 1 FROM DEPT AS DEPT FULL JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charli') AS q1 EXCEPT ALL SELECT * FROM (SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 LEFT JOIN EMP AS EMP0 ON t1.DEPTNO = EMP0.DEPTNO) AS q2;
;(1)

; SELECT * FROM (SELECT 1 FROM (SELECT * FROM DEPT AS DEPT0 WHERE DEPT0.NAME = 'Charlie') AS t1 LEFT JOIN EMP AS EMP0 ON t1.DEPTNO = EMP0.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT 1 FROM DEPT AS DEPT FULL JOIN EMP AS EMP ON DEPT.DEPTNO = EMP.DEPTNO WHERE DEPT.NAME = 'Charli') AS q1;

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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (>= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (>= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_465 Int) (BOUND_VARIABLE_466 Int)) (> BOUND_VARIABLE_465 BOUND_VARIABLE_466)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_465 Int) (BOUND_VARIABLE_466 Int)) (> BOUND_VARIABLE_465 BOUND_VARIABLE_466)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_526 Int) (BOUND_VARIABLE_527 Int)) (= BOUND_VARIABLE_526 BOUND_VARIABLE_527)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_526 Int) (BOUND_VARIABLE_527 Int)) (= BOUND_VARIABLE_526 BOUND_VARIABLE_527)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_552 Int) (BOUND_VARIABLE_553 Int)) (> BOUND_VARIABLE_552 BOUND_VARIABLE_553)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_552 Int) (BOUND_VARIABLE_553 Int)) (> BOUND_VARIABLE_552 BOUND_VARIABLE_553)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_569 Int) (BOUND_VARIABLE_570 Int)) (> BOUND_VARIABLE_569 BOUND_VARIABLE_570)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_569 Int) (BOUND_VARIABLE_570 Int)) (> BOUND_VARIABLE_569 BOUND_VARIABLE_570)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_587 Int) (BOUND_VARIABLE_588 Int)) (> BOUND_VARIABLE_587 BOUND_VARIABLE_588)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_587 Int) (BOUND_VARIABLE_588 Int)) (> BOUND_VARIABLE_587 BOUND_VARIABLE_588)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (> BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (> BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 7) t) (nullable.some 10)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_606 Bool) (BOUND_VARIABLE_607 Bool)) (or BOUND_VARIABLE_606 BOUND_VARIABLE_607)) (nullable.lift (lambda ((BOUND_VARIABLE_587 Int) (BOUND_VARIABLE_588 Int)) (> BOUND_VARIABLE_587 BOUND_VARIABLE_588)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (> BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 7) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_587 Int) (BOUND_VARIABLE_588 Int)) (> BOUND_VARIABLE_587 BOUND_VARIABLE_588)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_587 Int) (BOUND_VARIABLE_588 Int)) (> BOUND_VARIABLE_587 BOUND_VARIABLE_588)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (> BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (> BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 7) t) (nullable.some 10)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_606 Bool) (BOUND_VARIABLE_607 Bool)) (or BOUND_VARIABLE_606 BOUND_VARIABLE_607)) (nullable.lift (lambda ((BOUND_VARIABLE_587 Int) (BOUND_VARIABLE_588 Int)) (> BOUND_VARIABLE_587 BOUND_VARIABLE_588)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (> BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 7) t) (nullable.some 10))))))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_629 Int) (BOUND_VARIABLE_630 Int)) (= BOUND_VARIABLE_629 BOUND_VARIABLE_630)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_629 Int) (BOUND_VARIABLE_630 Int)) (= BOUND_VARIABLE_629 BOUND_VARIABLE_630)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f3 (bag.filter p2 (table.product (bag.union_disjoint ((_ table.project 7) (bag.filter p0 EMP)) ((_ table.project 7) (bag.filter p1 EMP))) EMP)))))
(assert (= q2 (bag.map f8 (bag.filter p7 (table.product (bag.union_disjoint ((_ table.project 7) (bag.filter p4 EMP)) ((_ table.project 7) (bag.filter p5 EMP))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p6 EMP)))))))
(check-sat)
;answer: sat
; duration: 1273 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some 7) (nullable.some (- 3))) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 1)) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; insert into EMP values(0,NULL,'',-1,2,-2,3,7,-3)
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const leftJoin2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const leftJoin5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_516 Int) (BOUND_VARIABLE_517 Int)) (= BOUND_VARIABLE_516 BOUND_VARIABLE_517)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_516 Int) (BOUND_VARIABLE_517 Int)) (= BOUND_VARIABLE_516 BOUND_VARIABLE_517)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_557 Int) (BOUND_VARIABLE_558 Int)) (>= BOUND_VARIABLE_557 BOUND_VARIABLE_558)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_557 Int) (BOUND_VARIABLE_558 Int)) (>= BOUND_VARIABLE_557 BOUND_VARIABLE_558)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_574 Int) (BOUND_VARIABLE_575 Int)) (= BOUND_VARIABLE_574 BOUND_VARIABLE_575)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_574 Int) (BOUND_VARIABLE_575 Int)) (= BOUND_VARIABLE_574 BOUND_VARIABLE_575)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= leftJoin5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map leftJoin2 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) DEPT))))) (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) DEPT))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map leftJoin5 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1) (bag.filter p4 DEPT)))))) (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1) (bag.filter p4 DEPT)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10034 ms.
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

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const leftJoin1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const rightJoin4 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_595 Int) (BOUND_VARIABLE_596 Int)) (>= BOUND_VARIABLE_595 BOUND_VARIABLE_596)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_595 Int) (BOUND_VARIABLE_596 Int)) (>= BOUND_VARIABLE_595 BOUND_VARIABLE_596)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f2 (bag.union_disjoint (bag.map leftJoin1 (bag.difference_remove DEPT ((_ table.project 0 1) (bag.filter p0 (table.product DEPT EMP))))) (bag.filter p0 (table.product DEPT EMP))))))
(assert (= q2 (bag.map f5 (bag.union_disjoint (bag.map rightJoin4 (bag.difference_remove DEPT ((_ table.project 9 10) (bag.filter p3 (table.product EMP DEPT))))) (bag.filter p3 (table.product EMP DEPT))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10205 ms.
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= q1 ((_ table.project 6) (table.product (bag.union_max ((_ table.project 0 1 2 3 4 5 6 7 8) EMP) ((_ table.project 0 1 2 3 4 5 6 7 8) EMP)) EMP))))
(assert (= q2 ((_ table.project 6) (bag.union_disjoint ((_ table.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) (table.product EMP EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) (table.product EMP EMP))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 18143 ms.
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (= BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (= BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (bag.union_max ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.union_max ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)))))
(assert (= q2 (bag.union_max (bag.union_disjoint ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)))))
(check-sat)
;answer: sat
; duration: 1200 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag.union_disjoint (bag (tuple (nullable.some (- 6)) (nullable.some "C") (nullable.some "D") (nullable.some 7) (nullable.some (- 7)) (nullable.some 8) (nullable.some (- 8)) (nullable.some 20) (nullable.some 9)) 1) (bag (tuple (nullable.some (- 9)) (nullable.some "E") (nullable.some "F") (nullable.some (- 10)) (nullable.some 11) (nullable.some (- 11)) (nullable.some 12) (nullable.some 10) (nullable.some (- 12))) 1)))
; )
; q1
(get-value (q1))
; (bag.union_disjoint (bag (tuple (nullable.some (- 6)) (nullable.some "C") (nullable.some "D") (nullable.some 7) (nullable.some (- 7)) (nullable.some 8) (nullable.some (- 8)) (nullable.some 20) (nullable.some 9)) 1) (bag (tuple (nullable.some (- 9)) (nullable.some "E") (nullable.some "F") (nullable.some (- 10)) (nullable.some 11) (nullable.some (- 11)) (nullable.some 12) (nullable.some 10) (nullable.some (- 12))) 1))
; q2
(get-value (q2))
; (bag (tuple (nullable.some (- 6)) (nullable.some "C") (nullable.some "D") (nullable.some 7) (nullable.some (- 7)) (nullable.some 8) (nullable.some (- 8)) (nullable.some 20) (nullable.some 9)) 2)
; insert into EMP values(-6,'C','D',7,-7,8,-8,20,9),(-9,'E','F',-10,11,-11,12,10,-12)
; SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO = 20 UNION ALL SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20 UNION SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS q2;
;(-9,E,F,-10,11,-11,12,10,-12)

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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_368 Int) (BOUND_VARIABLE_369 Int)) (> BOUND_VARIABLE_368 BOUND_VARIABLE_369)) (nullable.lift (lambda ((BOUND_VARIABLE_350 Int) (BOUND_VARIABLE_351 Int)) (+ BOUND_VARIABLE_350 BOUND_VARIABLE_351)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_362 Int) (BOUND_VARIABLE_363 Int)) (+ BOUND_VARIABLE_362 BOUND_VARIABLE_363)) (nullable.some 3) (as nullable.null (Nullable Int))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_368 Int) (BOUND_VARIABLE_369 Int)) (> BOUND_VARIABLE_368 BOUND_VARIABLE_369)) (nullable.lift (lambda ((BOUND_VARIABLE_350 Int) (BOUND_VARIABLE_351 Int)) (+ BOUND_VARIABLE_350 BOUND_VARIABLE_351)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_362 Int) (BOUND_VARIABLE_363 Int)) (+ BOUND_VARIABLE_362 BOUND_VARIABLE_363)) (nullable.some 3) (as nullable.null (Nullable Int)))))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 (bag (tuple (nullable.some 1) (nullable.some 2)) 1)))))
(assert (= q2 ((_ table.project 0 1) (bag (tuple (nullable.some 0) (nullable.some 0)) 1))))
(check-sat)
;answer: sat
; duration: 24 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 0) (nullable.some 0)) 1)
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (< BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 3) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (< BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 3) t) (nullable.some 10)))) (nullable.some true) (nullable.some false))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (< BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 3) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (< BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 3) t) (nullable.some 10)))) (nullable.some true) (nullable.some false)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_471 Int) (BOUND_VARIABLE_472 Int)) (<= BOUND_VARIABLE_471 BOUND_VARIABLE_472)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_471 Int) (BOUND_VARIABLE_472 Int)) (<= BOUND_VARIABLE_471 BOUND_VARIABLE_472)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= q1 ((_ table.project 3) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0) (bag.filter p1 ((_ table.project 3) EMP)))))
(check-sat)
;answer: sat
; duration: 136 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 10) (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some (- 2)) (nullable.some 3)) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 10)) 1)
; insert into EMP values(0,NULL,'',10,1,-1,2,-2,3)
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_434 Int) (BOUND_VARIABLE_435 Int)) (= BOUND_VARIABLE_434 BOUND_VARIABLE_435)) ((_ tuple.select 1) t) (nullable.some 200))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_434 Int) (BOUND_VARIABLE_435 Int)) (= BOUND_VARIABLE_434 BOUND_VARIABLE_435)) ((_ tuple.select 1) t) (nullable.some 200)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_471 Int) (BOUND_VARIABLE_472 Int)) (= BOUND_VARIABLE_471 BOUND_VARIABLE_472)) ((_ tuple.select 0) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_471 Int) (BOUND_VARIABLE_472 Int)) (= BOUND_VARIABLE_471 BOUND_VARIABLE_472)) ((_ tuple.select 0) t) (nullable.some 100)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_521 Int) (BOUND_VARIABLE_522 Int)) (= BOUND_VARIABLE_521 BOUND_VARIABLE_522)) ((_ tuple.select 1) t) ((_ tuple.select 2) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_521 Int) (BOUND_VARIABLE_522 Int)) (= BOUND_VARIABLE_521 BOUND_VARIABLE_522)) ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_540 Int) (BOUND_VARIABLE_541 Int)) (>= BOUND_VARIABLE_540 BOUND_VARIABLE_541)) ((_ tuple.select 1) t) (nullable.some 200))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_540 Int) (BOUND_VARIABLE_541 Int)) (>= BOUND_VARIABLE_540 BOUND_VARIABLE_541)) ((_ tuple.select 1) t) (nullable.some 200)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_557 Int) (BOUND_VARIABLE_558 Int)) (= BOUND_VARIABLE_557 BOUND_VARIABLE_558)) ((_ tuple.select 0) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_557 Int) (BOUND_VARIABLE_558 Int)) (= BOUND_VARIABLE_557 BOUND_VARIABLE_558)) ((_ tuple.select 0) t) (nullable.some 100)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_576 Int) (BOUND_VARIABLE_577 Int)) (= BOUND_VARIABLE_576 BOUND_VARIABLE_577)) ((_ tuple.select 1) t) ((_ tuple.select 2) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_576 Int) (BOUND_VARIABLE_577 Int)) (= BOUND_VARIABLE_576 BOUND_VARIABLE_577)) ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))))
(assert (= q1 ((_ table.project 0) (bag.filter p2 (table.product ((_ table.project 0 1) (bag.filter p0 ((_ table.project 6 7) EMP))) ((_ table.project 1) (bag.filter p1 ((_ table.project 6 7) EMP))))))))
(assert (= q2 ((_ table.project 0) (bag.filter p5 (table.product ((_ table.project 0 1) (bag.filter p3 ((_ table.project 6 7) EMP))) ((_ table.project 1) (bag.filter p4 ((_ table.project 6 7) EMP))))))))
(check-sat)
;answer: sat
; duration: 9935 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 0) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 1) (nullable.some (- 1)) (nullable.some 2) (nullable.some 100) (nullable.some 201) (nullable.some (- 2))) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 100)) 1)
; insert into EMP values(0,NULL,'',1,-1,2,100,201,-2)
; SELECT * FROM (SELECT t0.SAL FROM (SELECT * FROM (SELECT EMP.SAL, EMP.DEPTNO FROM EMP AS EMP) AS t WHERE t.DEPTNO = 200) AS t0 INNER JOIN (SELECT t1.DEPTNO FROM (SELECT EMP0.SAL, EMP0.DEPTNO FROM EMP AS EMP0) AS t1 WHERE t1.SAL = 100) AS t3 ON t0.DEPTNO = t3.DEPTNO) AS q1 EXCEPT ALL SELECT * FROM (SELECT t6.SAL FROM (SELECT * FROM (SELECT EMP1.SAL, EMP1.DEPTNO FROM EMP AS EMP1) AS t5 WHERE t5.DEPTNO >= 200) AS t6 INNER JOIN (SELECT t7.DEPTNO FROM (SELECT EMP2.SAL, EMP2.DEPTNO FROM EMP AS EMP2) AS t7 WHERE t7.SAL = 100) AS t9 ON t6.DEPTNO = t9.DEPTNO) AS q2;

; SELECT * FROM (SELECT t6.SAL FROM (SELECT * FROM (SELECT EMP1.SAL, EMP1.DEPTNO FROM EMP AS EMP1) AS t5 WHERE t5.DEPTNO >= 200) AS t6 INNER JOIN (SELECT t7.DEPTNO FROM (SELECT EMP2.SAL, EMP2.DEPTNO FROM EMP AS EMP2) AS t7 WHERE t7.SAL = 100) AS t9 ON t6.DEPTNO = t9.DEPTNO) AS q2 EXCEPT ALL SELECT * FROM (SELECT t0.SAL FROM (SELECT * FROM (SELECT EMP.SAL, EMP.DEPTNO FROM EMP AS EMP) AS t WHERE t.DEPTNO = 200) AS t0 INNER JOIN (SELECT t1.DEPTNO FROM (SELECT EMP0.SAL, EMP0.DEPTNO FROM EMP AS EMP0) AS t1 WHERE t1.SAL = 100) AS t3 ON t0.DEPTNO = t3.DEPTNO) AS q1;
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const leftJoin2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_507 Int) (BOUND_VARIABLE_508 Int)) (= BOUND_VARIABLE_507 BOUND_VARIABLE_508)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_507 Int) (BOUND_VARIABLE_508 Int)) (= BOUND_VARIABLE_507 BOUND_VARIABLE_508)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map leftJoin2 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) DEPT))))) (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) DEPT))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some "")) 1))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10086 ms.
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 6) t) (nullable.some 1000)))) (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_450 Int) (BOUND_VARIABLE_451 Int)) (= BOUND_VARIABLE_450 BOUND_VARIABLE_451)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_450 Int) (BOUND_VARIABLE_451 Int)) (= BOUND_VARIABLE_450 BOUND_VARIABLE_451)) ((_ tuple.select 6) t) (nullable.some 1000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))) (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_473 Int) (BOUND_VARIABLE_474 Int)) (= BOUND_VARIABLE_473 BOUND_VARIABLE_474)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_473 Int) (BOUND_VARIABLE_474 Int)) (= BOUND_VARIABLE_473 BOUND_VARIABLE_474)) ((_ tuple.select 6) t) (nullable.some 2000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 6) t) (nullable.some 1000)))) (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_450 Int) (BOUND_VARIABLE_451 Int)) (= BOUND_VARIABLE_450 BOUND_VARIABLE_451)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_450 Int) (BOUND_VARIABLE_451 Int)) (= BOUND_VARIABLE_450 BOUND_VARIABLE_451)) ((_ tuple.select 6) t) (nullable.some 1000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))) (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_473 Int) (BOUND_VARIABLE_474 Int)) (= BOUND_VARIABLE_473 BOUND_VARIABLE_474)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_473 Int) (BOUND_VARIABLE_474 Int)) (= BOUND_VARIABLE_473 BOUND_VARIABLE_474)) ((_ tuple.select 6) t) (nullable.some 2000)))) (as nullable.null (Nullable Int)) (nullable.some 1))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_518 Int) (BOUND_VARIABLE_519 Int)) (= BOUND_VARIABLE_518 BOUND_VARIABLE_519)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_518 Int) (BOUND_VARIABLE_519 Int)) (= BOUND_VARIABLE_518 BOUND_VARIABLE_519)) ((_ tuple.select 6) t) (nullable.some 100)))) (nullable.lift (lambda ((BOUND_VARIABLE_524 Int) (BOUND_VARIABLE_525 Int)) (= BOUND_VARIABLE_524 BOUND_VARIABLE_525)) ((_ tuple.select 6) t) (nullable.some 1000)) (nullable.lift (lambda ((BOUND_VARIABLE_530 Int) (BOUND_VARIABLE_531 Int)) (= BOUND_VARIABLE_530 BOUND_VARIABLE_531)) ((_ tuple.select 6) t) (nullable.some 2000)))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_518 Int) (BOUND_VARIABLE_519 Int)) (= BOUND_VARIABLE_518 BOUND_VARIABLE_519)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_518 Int) (BOUND_VARIABLE_519 Int)) (= BOUND_VARIABLE_518 BOUND_VARIABLE_519)) ((_ tuple.select 6) t) (nullable.some 100)))) (nullable.lift (lambda ((BOUND_VARIABLE_524 Int) (BOUND_VARIABLE_525 Int)) (= BOUND_VARIABLE_524 BOUND_VARIABLE_525)) ((_ tuple.select 6) t) (nullable.some 1000)) (nullable.lift (lambda ((BOUND_VARIABLE_530 Int) (BOUND_VARIABLE_531 Int)) (= BOUND_VARIABLE_530 BOUND_VARIABLE_531)) ((_ tuple.select 6) t) (nullable.some 2000))))))))
(assert (= q1 ((_ table.project 6) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 6) (bag.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 598 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 4) (nullable.some "A") (nullable.some "B") (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 1000) (nullable.some 6) (nullable.some (- 6))) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 1000)) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int))))
; insert into EMP values(4,'A','B',-4,5,-5,1000,6,-6)
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (> BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (> BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 9)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_519 Int) (BOUND_VARIABLE_520 Int)) (= BOUND_VARIABLE_519 BOUND_VARIABLE_520)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_519 Int) (BOUND_VARIABLE_520 Int)) (= BOUND_VARIABLE_519 BOUND_VARIABLE_520)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_560 Int) (BOUND_VARIABLE_561 Int)) (> BOUND_VARIABLE_560 BOUND_VARIABLE_561)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_560 Int) (BOUND_VARIABLE_561 Int)) (> BOUND_VARIABLE_560 BOUND_VARIABLE_561)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_597 Int) (BOUND_VARIABLE_598 Int)) (>= BOUND_VARIABLE_597 BOUND_VARIABLE_598)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_597 Int) (BOUND_VARIABLE_598 Int)) (>= BOUND_VARIABLE_597 BOUND_VARIABLE_598)) ((_ tuple.select 7) t) (nullable.some 9)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_614 Int) (BOUND_VARIABLE_615 Int)) (>= BOUND_VARIABLE_614 BOUND_VARIABLE_615)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_614 Int) (BOUND_VARIABLE_615 Int)) (>= BOUND_VARIABLE_614 BOUND_VARIABLE_615)) ((_ tuple.select 7) t) (nullable.some 9)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_633 Int) (BOUND_VARIABLE_634 Int)) (= BOUND_VARIABLE_633 BOUND_VARIABLE_634)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_633 Int) (BOUND_VARIABLE_634 Int)) (= BOUND_VARIABLE_633 BOUND_VARIABLE_634)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= rightJoin8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_668 Int) (BOUND_VARIABLE_669 Int)) (>= BOUND_VARIABLE_668 BOUND_VARIABLE_669)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_668 Int) (BOUND_VARIABLE_669 Int)) (>= BOUND_VARIABLE_668 BOUND_VARIABLE_669)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= f10 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f4 (bag.filter p3 (bag.union_disjoint (bag.map rightJoin2 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 9 10 11 12 13 14 15 16 17) (bag.filter p1 (table.product EMP ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))))) (bag.filter p1 (table.product EMP ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)))))))))
(assert (= q2 (bag.map f10 (bag.filter p9 (bag.union_disjoint (bag.map rightJoin8 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p6 EMP)) ((_ table.project 9 10 11 12 13 14 15 16 17) (bag.filter p7 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p6 EMP))))))) (bag.filter p7 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p6 EMP)))))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10023 ms.
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_489 Bool) (BOUND_VARIABLE_490 Bool) (BOUND_VARIABLE_491 Bool)) (and BOUND_VARIABLE_489 BOUND_VARIABLE_490 BOUND_VARIABLE_491)) (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (nullable.lift (lambda ((BOUND_VARIABLE_473 Int) (BOUND_VARIABLE_474 Real)) (> BOUND_VARIABLE_473 BOUND_VARIABLE_474)) (nullable.lift (lambda ((BOUND_VARIABLE_444 Int) (BOUND_VARIABLE_445 Int)) (+ BOUND_VARIABLE_444 BOUND_VARIABLE_445)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (nullable.lift (lambda ((BOUND_VARIABLE_452 Int) (BOUND_VARIABLE_453 Int)) (/ BOUND_VARIABLE_452 BOUND_VARIABLE_453)) ((_ tuple.select 5) t) (nullable.some 2))))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_489 Bool) (BOUND_VARIABLE_490 Bool) (BOUND_VARIABLE_491 Bool)) (and BOUND_VARIABLE_489 BOUND_VARIABLE_490 BOUND_VARIABLE_491)) (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (nullable.lift (lambda ((BOUND_VARIABLE_473 Int) (BOUND_VARIABLE_474 Real)) (> BOUND_VARIABLE_473 BOUND_VARIABLE_474)) (nullable.lift (lambda ((BOUND_VARIABLE_444 Int) (BOUND_VARIABLE_445 Int)) (+ BOUND_VARIABLE_444 BOUND_VARIABLE_445)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (nullable.lift (lambda ((BOUND_VARIABLE_452 Int) (BOUND_VARIABLE_453 Int)) (/ BOUND_VARIABLE_452 BOUND_VARIABLE_453)) ((_ tuple.select 5) t) (nullable.some 2)))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_514 Int) (BOUND_VARIABLE_515 Int)) (= BOUND_VARIABLE_514 BOUND_VARIABLE_515)) ((_ tuple.select 6) t) ((_ tuple.select 7) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_514 Int) (BOUND_VARIABLE_515 Int)) (= BOUND_VARIABLE_514 BOUND_VARIABLE_515)) ((_ tuple.select 6) t) ((_ tuple.select 7) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_598 Int) (BOUND_VARIABLE_599 Int)) (= BOUND_VARIABLE_598 BOUND_VARIABLE_599)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_598 Int) (BOUND_VARIABLE_599 Int)) (= BOUND_VARIABLE_598 BOUND_VARIABLE_599)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_636 Int) (BOUND_VARIABLE_637 Int)) (>= BOUND_VARIABLE_636 BOUND_VARIABLE_637)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_636 Int) (BOUND_VARIABLE_637 Int)) (>= BOUND_VARIABLE_636 BOUND_VARIABLE_637)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_643 Int) (BOUND_VARIABLE_644 Int)) (= BOUND_VARIABLE_643 BOUND_VARIABLE_644)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_643 Int) (BOUND_VARIABLE_644 Int)) (= BOUND_VARIABLE_643 BOUND_VARIABLE_644)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_675 Bool) (BOUND_VARIABLE_676 Bool) (BOUND_VARIABLE_677 Bool)) (and BOUND_VARIABLE_675 BOUND_VARIABLE_676 BOUND_VARIABLE_677)) (nullable.lift (lambda ((BOUND_VARIABLE_636 Int) (BOUND_VARIABLE_637 Int)) (>= BOUND_VARIABLE_636 BOUND_VARIABLE_637)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_643 Int) (BOUND_VARIABLE_644 Int)) (= BOUND_VARIABLE_643 BOUND_VARIABLE_644)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (nullable.lift (lambda ((BOUND_VARIABLE_661 Int) (BOUND_VARIABLE_662 Real)) (> BOUND_VARIABLE_661 BOUND_VARIABLE_662)) (nullable.lift (lambda ((BOUND_VARIABLE_649 Int) (BOUND_VARIABLE_650 Int)) (+ BOUND_VARIABLE_649 BOUND_VARIABLE_650)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (nullable.lift (lambda ((BOUND_VARIABLE_655 Int) (BOUND_VARIABLE_656 Int)) (/ BOUND_VARIABLE_655 BOUND_VARIABLE_656)) ((_ tuple.select 5) t) (nullable.some 2))))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_636 Int) (BOUND_VARIABLE_637 Int)) (>= BOUND_VARIABLE_636 BOUND_VARIABLE_637)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_636 Int) (BOUND_VARIABLE_637 Int)) (>= BOUND_VARIABLE_636 BOUND_VARIABLE_637)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_643 Int) (BOUND_VARIABLE_644 Int)) (= BOUND_VARIABLE_643 BOUND_VARIABLE_644)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_643 Int) (BOUND_VARIABLE_644 Int)) (= BOUND_VARIABLE_643 BOUND_VARIABLE_644)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_675 Bool) (BOUND_VARIABLE_676 Bool) (BOUND_VARIABLE_677 Bool)) (and BOUND_VARIABLE_675 BOUND_VARIABLE_676 BOUND_VARIABLE_677)) (nullable.lift (lambda ((BOUND_VARIABLE_636 Int) (BOUND_VARIABLE_637 Int)) (>= BOUND_VARIABLE_636 BOUND_VARIABLE_637)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_643 Int) (BOUND_VARIABLE_644 Int)) (= BOUND_VARIABLE_643 BOUND_VARIABLE_644)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (nullable.lift (lambda ((BOUND_VARIABLE_661 Int) (BOUND_VARIABLE_662 Real)) (> BOUND_VARIABLE_661 BOUND_VARIABLE_662)) (nullable.lift (lambda ((BOUND_VARIABLE_649 Int) (BOUND_VARIABLE_650 Int)) (+ BOUND_VARIABLE_649 BOUND_VARIABLE_650)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (nullable.lift (lambda ((BOUND_VARIABLE_655 Int) (BOUND_VARIABLE_656 Int)) (/ BOUND_VARIABLE_655 BOUND_VARIABLE_656)) ((_ tuple.select 5) t) (nullable.some 2)))))))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_696 Int) (BOUND_VARIABLE_697 Int)) (= BOUND_VARIABLE_696 BOUND_VARIABLE_697)) ((_ tuple.select 6) t) ((_ tuple.select 7) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_696 Int) (BOUND_VARIABLE_697 Int)) (= BOUND_VARIABLE_696 BOUND_VARIABLE_697)) ((_ tuple.select 6) t) ((_ tuple.select 7) t)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_713 Int) (BOUND_VARIABLE_714 Int)) (>= BOUND_VARIABLE_713 BOUND_VARIABLE_714)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_713 Int) (BOUND_VARIABLE_714 Int)) (>= BOUND_VARIABLE_713 BOUND_VARIABLE_714)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_732 Int) (BOUND_VARIABLE_733 Int)) (= BOUND_VARIABLE_732 BOUND_VARIABLE_733)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_732 Int) (BOUND_VARIABLE_733 Int)) (= BOUND_VARIABLE_732 BOUND_VARIABLE_733)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (bag.map f3 (bag.filter p2 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)))))))
(assert (= q2 (bag.map f8 (bag.filter p7 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p6 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)))))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10169 ms.
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 (bag (tuple (nullable.some 1) (nullable.some 2)) 1)))))
(assert (= q2 ((_ table.project 0 1) (bag (tuple (nullable.some 0) (nullable.some 0)) 1))))
(check-sat)
;answer: sat
; duration: 95 ms.
(get-model)
; (
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 0) (nullable.some 0)) 1)
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= q1 (bag.union_disjoint (bag.map f0 EMP) (bag.map f1 EMP))))
(assert (= q2 (bag.union_disjoint (bag.map f2 EMP) (bag.map f3 EMP))))
(check-sat)
;answer: sat
; duration: 345 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 0) (nullable.some "") (as nullable.null (Nullable String)) (nullable.some (- 1)) (nullable.some (- 2)) (nullable.some 3) (nullable.some (- 3)) (as nullable.null (Nullable Int)) (nullable.some 4)) 1))
; )
; q1
(get-value (q1))
; (bag.union_disjoint (bag (tuple (nullable.some 1) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))) 1) (bag (tuple (nullable.some 2) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))) 1))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 1) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))) 2)
; insert into EMP values(0,'',NULL,-1,-2,3,-3,NULL,4)
; SELECT * FROM (SELECT 2, EMP.DEPTNO, EMP.JOB FROM EMP AS EMP UNION ALL SELECT 1, EMP0.DEPTNO, EMP0.JOB FROM EMP AS EMP0) AS q1 EXCEPT ALL SELECT * FROM (SELECT 1, EMP1.DEPTNO, EMP1.JOB FROM EMP AS EMP1 UNION ALL SELECT 1, EMP2.DEPTNO, EMP2.JOB FROM EMP AS EMP2) AS q2;
;(2,NULL,NULL)

; SELECT * FROM (SELECT 1, EMP1.DEPTNO, EMP1.JOB FROM EMP AS EMP1 UNION ALL SELECT 1, EMP2.DEPTNO, EMP2.JOB FROM EMP AS EMP2) AS q2 EXCEPT ALL SELECT * FROM (SELECT 2, EMP.DEPTNO, EMP.JOB FROM EMP AS EMP UNION ALL SELECT 1, EMP0.DEPTNO, EMP0.JOB FROM EMP AS EMP0) AS q1;
;(1,NULL,NULL)

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
(assert (= q1 (bag.union_max (bag.map f0 EMP) (bag.map f1 EMP))))
(assert (= q2 (bag.map f4 (bag.union_disjoint (bag.map f2 EMP) (bag.map f3 EMP)))))
(check-sat)
;answer: sat
; duration: 227 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 2) (nullable.some 3)) 1)
; q2
(get-value (q2))
; (bag (tuple (nullable.some 2) (nullable.some 3)) 2)
; insert into EMP values(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
; SELECT * FROM (SELECT 2, 3 FROM EMP AS EMP UNION SELECT 2, 3 FROM EMP AS EMP0) AS q1 EXCEPT ALL SELECT * FROM (SELECT 2, 3 FROM (SELECT 2 FROM EMP AS EMP1 UNION ALL SELECT 2 FROM EMP AS EMP2) AS t6) AS q2;

; SELECT * FROM (SELECT 2, 3 FROM (SELECT 2 FROM EMP AS EMP1 UNION ALL SELECT 2 FROM EMP AS EMP2) AS t6) AS q2 EXCEPT ALL SELECT * FROM (SELECT 2, 3 FROM EMP AS EMP UNION SELECT 2, 3 FROM EMP AS EMP0) AS q1;
;(2,3)

;Model soundness: true
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (>= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (>= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_529 Int) (BOUND_VARIABLE_530 Int)) (= BOUND_VARIABLE_529 BOUND_VARIABLE_530)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_529 Int) (BOUND_VARIABLE_530 Int)) (= BOUND_VARIABLE_529 BOUND_VARIABLE_530)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (bag.union_disjoint ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.union_max ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)))))
(assert (= q2 (bag.union_disjoint ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.union_max ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)))) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p5 EMP)))))
(check-sat)
;answer: sat
; duration: 1066 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag.union_disjoint (bag (tuple (nullable.some (- 13)) (nullable.some "G") (nullable.some "H") (nullable.some 14) (nullable.some (- 14)) (nullable.some 15) (nullable.some (- 15)) (nullable.some 10) (nullable.some 16)) 1) (bag (tuple (nullable.some (- 6)) (nullable.some "C") (nullable.some "D") (nullable.some 7) (nullable.some (- 7)) (nullable.some 8) (nullable.some (- 8)) (nullable.some 11) (nullable.some 9)) 1)))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some (- 13)) (nullable.some "G") (nullable.some "H") (nullable.some 14) (nullable.some (- 14)) (nullable.some 15) (nullable.some (- 15)) (nullable.some 10) (nullable.some 16)) 1)
; q2
(get-value (q2))
; (bag.union_disjoint (bag (tuple (nullable.some (- 13)) (nullable.some "G") (nullable.some "H") (nullable.some 14) (nullable.some (- 14)) (nullable.some 15) (nullable.some (- 15)) (nullable.some 10) (nullable.some 16)) 1) (bag (tuple (nullable.some (- 6)) (nullable.some "C") (nullable.some "D") (nullable.some 7) (nullable.some (- 7)) (nullable.some 8) (nullable.some (- 8)) (nullable.some 11) (nullable.some 9)) 1))
; insert into EMP values(-13,'G','H',14,-14,15,-15,10,16),(-6,'C','D',7,-7,8,-8,11,9)
; SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION ALL SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 10 UNION SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20) AS t6 UNION ALL SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS q2;

; SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP2 WHERE EMP2.DEPTNO >= 10 UNION SELECT * FROM EMP AS EMP3 WHERE EMP3.DEPTNO = 20) AS t6 UNION ALL SELECT * FROM EMP AS EMP4 WHERE EMP4.DEPTNO = 30) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM EMP AS EMP WHERE EMP.DEPTNO = 10 UNION SELECT * FROM EMP AS EMP0 WHERE EMP0.DEPTNO = 20) AS t1 UNION ALL SELECT * FROM EMP AS EMP1 WHERE EMP1.DEPTNO = 30) AS q1;
;(-6,C,D,7,-7,8,-8,11,9)

;Model soundness: true
(reset)
; total time: 336362 ms.
; sat answers    : 68
; unsat answers  : 0
; unknown answers: 18
