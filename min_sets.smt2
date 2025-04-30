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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_399 Int) (BOUND_VARIABLE_400 Int)) (> BOUND_VARIABLE_399 BOUND_VARIABLE_400)) (nullable.lift (lambda ((BOUND_VARIABLE_389 Int) (BOUND_VARIABLE_390 Int)) (+ BOUND_VARIABLE_389 BOUND_VARIABLE_390)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_399 Int) (BOUND_VARIABLE_400 Int)) (> BOUND_VARIABLE_399 BOUND_VARIABLE_400)) (nullable.lift (lambda ((BOUND_VARIABLE_389 Int) (BOUND_VARIABLE_390 Int)) (+ BOUND_VARIABLE_389 BOUND_VARIABLE_390)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 50)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_449 Int) (BOUND_VARIABLE_450 Int)) (+ BOUND_VARIABLE_449 BOUND_VARIABLE_450)) (nullable.lift (lambda ((BOUND_VARIABLE_443 Int) (BOUND_VARIABLE_444 Int)) (+ BOUND_VARIABLE_443 BOUND_VARIABLE_444)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 0) t))))))
(assert (= q1 (set.map f1 (set.filter p0 (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 30) (nullable.some 3))))))))
(assert (= q2 ((_ rel.project 0) (set.minus ((_ rel.project 0) (set.singleton (tuple (nullable.some 0)))) ((_ rel.project 0) (set.singleton (tuple (nullable.some 0))))))))
(check-sat)
;answer: unsat
; duration: 39 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_407 Int) (BOUND_VARIABLE_408 Int)) (> BOUND_VARIABLE_407 BOUND_VARIABLE_408)) (nullable.lift (lambda ((BOUND_VARIABLE_399 Int) (BOUND_VARIABLE_400 Int)) (+ BOUND_VARIABLE_399 BOUND_VARIABLE_400)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_407 Int) (BOUND_VARIABLE_408 Int)) (> BOUND_VARIABLE_407 BOUND_VARIABLE_408)) (nullable.lift (lambda ((BOUND_VARIABLE_399 Int) (BOUND_VARIABLE_400 Int)) (+ BOUND_VARIABLE_399 BOUND_VARIABLE_400)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 30)))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 (set.union ((_ rel.project 0 1) (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 30) (nullable.some 3))))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 20) (nullable.some 2)))))))))
(assert (= q2 ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 30) (nullable.some 3))))))
(check-sat)
;answer: unsat
; duration: 14 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_440 Int) (BOUND_VARIABLE_441 Int)) (= BOUND_VARIABLE_440 BOUND_VARIABLE_441)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_440 Int) (BOUND_VARIABLE_441 Int)) (= BOUND_VARIABLE_440 BOUND_VARIABLE_441)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_464 Bool) (BOUND_VARIABLE_465 Bool) (BOUND_VARIABLE_466 Bool) (BOUND_VARIABLE_467 Bool)) (and BOUND_VARIABLE_464 BOUND_VARIABLE_465 BOUND_VARIABLE_466 BOUND_VARIABLE_467)) (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_440 Int) (BOUND_VARIABLE_441 Int)) (= BOUND_VARIABLE_440 BOUND_VARIABLE_441)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some (nullable.is_null ((_ tuple.select 3) t))) (nullable.lift (lambda ((BOUND_VARIABLE_448 Int) (BOUND_VARIABLE_449 Int)) (= BOUND_VARIABLE_448 BOUND_VARIABLE_449)) ((_ tuple.select 0) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_440 Int) (BOUND_VARIABLE_441 Int)) (= BOUND_VARIABLE_440 BOUND_VARIABLE_441)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_440 Int) (BOUND_VARIABLE_441 Int)) (= BOUND_VARIABLE_440 BOUND_VARIABLE_441)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_464 Bool) (BOUND_VARIABLE_465 Bool) (BOUND_VARIABLE_466 Bool) (BOUND_VARIABLE_467 Bool)) (and BOUND_VARIABLE_464 BOUND_VARIABLE_465 BOUND_VARIABLE_466 BOUND_VARIABLE_467)) (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_440 Int) (BOUND_VARIABLE_441 Int)) (= BOUND_VARIABLE_440 BOUND_VARIABLE_441)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some (nullable.is_null ((_ tuple.select 3) t))) (nullable.lift (lambda ((BOUND_VARIABLE_448 Int) (BOUND_VARIABLE_449 Int)) (= BOUND_VARIABLE_448 BOUND_VARIABLE_449)) ((_ tuple.select 0) t) (nullable.some 10))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_489 Int) (BOUND_VARIABLE_490 Int)) (= BOUND_VARIABLE_489 BOUND_VARIABLE_490)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_489 Int) (BOUND_VARIABLE_490 Int)) (= BOUND_VARIABLE_489 BOUND_VARIABLE_490)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 3) t)))) (not (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 3) t)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_513 Bool) (BOUND_VARIABLE_514 Bool) (BOUND_VARIABLE_515 Bool)) (and BOUND_VARIABLE_513 BOUND_VARIABLE_514 BOUND_VARIABLE_515)) (nullable.lift (lambda ((BOUND_VARIABLE_489 Int) (BOUND_VARIABLE_490 Int)) (= BOUND_VARIABLE_489 BOUND_VARIABLE_490)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.some (nullable.is_null ((_ tuple.select 3) t))) (nullable.lift (lambda ((BOUND_VARIABLE_498 Int) (BOUND_VARIABLE_499 Int)) (= BOUND_VARIABLE_498 BOUND_VARIABLE_499)) ((_ tuple.select 0) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_489 Int) (BOUND_VARIABLE_490 Int)) (= BOUND_VARIABLE_489 BOUND_VARIABLE_490)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_489 Int) (BOUND_VARIABLE_490 Int)) (= BOUND_VARIABLE_489 BOUND_VARIABLE_490)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 3) t)))) (not (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 3) t)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_513 Bool) (BOUND_VARIABLE_514 Bool) (BOUND_VARIABLE_515 Bool)) (and BOUND_VARIABLE_513 BOUND_VARIABLE_514 BOUND_VARIABLE_515)) (nullable.lift (lambda ((BOUND_VARIABLE_489 Int) (BOUND_VARIABLE_490 Int)) (= BOUND_VARIABLE_489 BOUND_VARIABLE_490)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.some (nullable.is_null ((_ tuple.select 3) t))) (nullable.lift (lambda ((BOUND_VARIABLE_498 Int) (BOUND_VARIABLE_499 Int)) (= BOUND_VARIABLE_498 BOUND_VARIABLE_499)) ((_ tuple.select 0) t) (nullable.some 10))))))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 10) ((_ tuple.select 1) t) ((_ tuple.select 2) t) (as nullable.null (Nullable Int)) ((_ tuple.select 4) t) ((_ tuple.select 6) t) ((_ tuple.select 5) t) (nullable.some 7) ((_ tuple.select 8) t)))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 (set.map f2 (set.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 73 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 10) (as nullable.null (Nullable String)) (nullable.some "") (as nullable.null (Nullable Int)) (nullable.some 0) (nullable.some 1) (nullable.some (- 1)) (nullable.some 7) (nullable.some 2))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 10) (as nullable.null (Nullable String)) (nullable.some "") (as nullable.null (Nullable Int)) (nullable.some 0) (nullable.some 1) (nullable.some (- 1)) (nullable.some 7) (nullable.some 2)))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 10) (as nullable.null (Nullable String)) (nullable.some "") (as nullable.null (Nullable Int)) (nullable.some 0) (nullable.some (- 1)) (nullable.some 1) (nullable.some 7) (nullable.some 2)))
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_405 Int) (BOUND_VARIABLE_406 Int)) (< BOUND_VARIABLE_405 BOUND_VARIABLE_406)) (nullable.lift (lambda ((BOUND_VARIABLE_395 Int) (BOUND_VARIABLE_396 Int)) (- BOUND_VARIABLE_395 BOUND_VARIABLE_396)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 21))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_405 Int) (BOUND_VARIABLE_406 Int)) (< BOUND_VARIABLE_405 BOUND_VARIABLE_406)) (nullable.lift (lambda ((BOUND_VARIABLE_395 Int) (BOUND_VARIABLE_396 Int)) (- BOUND_VARIABLE_395 BOUND_VARIABLE_396)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 21)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_455 Int) (BOUND_VARIABLE_456 Int)) (+ BOUND_VARIABLE_455 BOUND_VARIABLE_456)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= q1 (set.map f1 (set.filter p0 (set.union (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 30) (nullable.some 7)))) (set.singleton (tuple (nullable.some 20) (nullable.some 3))))))))
(assert (= q2 ((_ rel.project 0 1 2) (set.union (set.singleton (tuple (nullable.some 11) (nullable.some 1) (nullable.some 10))) (set.singleton (tuple (nullable.some 23) (nullable.some 3) (nullable.some 20)))))))
(check-sat)
;answer: unsat
; duration: 13 ms.
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (= BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (= BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))
(assert (= q2 (set.minus (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))
(check-sat)
;answer: unsat
; duration: 206 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_382 Int) (BOUND_VARIABLE_383 Int)) (> BOUND_VARIABLE_382 BOUND_VARIABLE_383)) ((_ tuple.select 0) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_382 Int) (BOUND_VARIABLE_383 Int)) (> BOUND_VARIABLE_382 BOUND_VARIABLE_383)) ((_ tuple.select 0) t) (nullable.some 30)))))))
(assert (= q1 (set.minus ((_ rel.project 0 1) (set.minus ((_ rel.project 0 1) (set.filter p0 (set.singleton (tuple (nullable.some 30) (nullable.some 3))))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 20) (nullable.some 2)))))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 40) (nullable.some 4)))))))
(assert (= q2 ((_ rel.project 0 1) (set.minus ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 0) (nullable.some 0)))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 0) (nullable.some 0))))))))
(check-sat)
;answer: unsat
; duration: 14 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_400 Int) (BOUND_VARIABLE_401 Int)) (+ BOUND_VARIABLE_400 BOUND_VARIABLE_401)) ((_ tuple.select 0) t) ((_ tuple.select 1) t))))))
(assert (= q1 (set.map f0 (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 20) (nullable.some 3)))))))
(assert (= q2 ((_ rel.project 0) (set.union (set.singleton (tuple (nullable.some 11))) (set.singleton (tuple (nullable.some 23)))))))
(check-sat)
;answer: unsat
; duration: 6 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_407 Int) (BOUND_VARIABLE_408 Int)) (< BOUND_VARIABLE_407 BOUND_VARIABLE_408)) ((_ tuple.select 0) t) (nullable.some 15))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_407 Int) (BOUND_VARIABLE_408 Int)) (< BOUND_VARIABLE_407 BOUND_VARIABLE_408)) ((_ tuple.select 0) t) (nullable.some 15)))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 (set.union (set.singleton (tuple (nullable.some 10) (nullable.some "x"))) (set.singleton (tuple (nullable.some 20) (nullable.some "y"))))))))
(assert (= q2 ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 10) (nullable.some "x"))))))
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_394 Int) (BOUND_VARIABLE_395 Int)) (= BOUND_VARIABLE_394 BOUND_VARIABLE_395)) ((_ tuple.select 0) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_394 Int) (BOUND_VARIABLE_395 Int)) (= BOUND_VARIABLE_394 BOUND_VARIABLE_395)) ((_ tuple.select 0) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_418 Int) (BOUND_VARIABLE_419 Int)) (= BOUND_VARIABLE_418 BOUND_VARIABLE_419)) ((_ tuple.select 0) t) (nullable.some 8))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_418 Int) (BOUND_VARIABLE_419 Int)) (= BOUND_VARIABLE_418 BOUND_VARIABLE_419)) ((_ tuple.select 0) t) (nullable.some 8))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_433 Bool) (BOUND_VARIABLE_434 Bool)) (and BOUND_VARIABLE_433 BOUND_VARIABLE_434)) (nullable.lift (lambda ((BOUND_VARIABLE_394 Int) (BOUND_VARIABLE_395 Int)) (= BOUND_VARIABLE_394 BOUND_VARIABLE_395)) ((_ tuple.select 0) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_418 Int) (BOUND_VARIABLE_419 Int)) (= BOUND_VARIABLE_418 BOUND_VARIABLE_419)) ((_ tuple.select 0) t) (nullable.some 8)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_394 Int) (BOUND_VARIABLE_395 Int)) (= BOUND_VARIABLE_394 BOUND_VARIABLE_395)) ((_ tuple.select 0) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_394 Int) (BOUND_VARIABLE_395 Int)) (= BOUND_VARIABLE_394 BOUND_VARIABLE_395)) ((_ tuple.select 0) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_418 Int) (BOUND_VARIABLE_419 Int)) (= BOUND_VARIABLE_418 BOUND_VARIABLE_419)) ((_ tuple.select 0) t) (nullable.some 8))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_418 Int) (BOUND_VARIABLE_419 Int)) (= BOUND_VARIABLE_418 BOUND_VARIABLE_419)) ((_ tuple.select 0) t) (nullable.some 8))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_433 Bool) (BOUND_VARIABLE_434 Bool)) (and BOUND_VARIABLE_433 BOUND_VARIABLE_434)) (nullable.lift (lambda ((BOUND_VARIABLE_394 Int) (BOUND_VARIABLE_395 Int)) (= BOUND_VARIABLE_394 BOUND_VARIABLE_395)) ((_ tuple.select 0) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_418 Int) (BOUND_VARIABLE_419 Int)) (= BOUND_VARIABLE_418 BOUND_VARIABLE_419)) ((_ tuple.select 0) t) (nullable.some 8))))))))))
(assert (= q1 ((_ rel.project 0) (set.filter p0 DEPT))))
(assert (= q2 ((_ rel.project 0) (set.minus ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 0) (nullable.some 0)))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 0) (nullable.some 0))))))))
(check-sat)
;answer: unsat
; duration: 18 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_527 Int) (BOUND_VARIABLE_528 Int)) (= BOUND_VARIABLE_527 BOUND_VARIABLE_528)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_527 Int) (BOUND_VARIABLE_528 Int)) (= BOUND_VARIABLE_527 BOUND_VARIABLE_528)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ rel.project 1) (set.filter p0 (rel.product EMP DEPT)))))
(assert (= q2 ((_ rel.project 1) (set.filter p1 (rel.product EMP DEPT)))))
(check-sat)
;answer: unsat
; duration: 44 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.some 2) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= q1 (set.union (set.map f0 EMP) (set.map f1 EMP))))
(assert (= q2 (set.map f2 (set.union ((_ rel.project 7 2) EMP) ((_ rel.project 7 2) EMP)))))
(check-sat)
;answer: unsat
; duration: 26 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Bool))))
(declare-const p1 (-> (Tuple (Nullable Bool)) Bool))
(declare-const q2 (Set (Tuple (Nullable Bool))))
(declare-const p3 (-> (Tuple (Nullable Bool)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Bool))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Bool))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (ite (and (nullable.is_some (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_441 Int) (BOUND_VARIABLE_442 Int)) (> BOUND_VARIABLE_441 BOUND_VARIABLE_442)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_441 Int) (BOUND_VARIABLE_442 Int)) (> BOUND_VARIABLE_441 BOUND_VARIABLE_442)) ((_ tuple.select 6) t) (nullable.some 1000)))))) (not (nullable.val (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_441 Int) (BOUND_VARIABLE_442 Int)) (> BOUND_VARIABLE_441 BOUND_VARIABLE_442)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_441 Int) (BOUND_VARIABLE_442 Int)) (> BOUND_VARIABLE_441 BOUND_VARIABLE_442)) ((_ tuple.select 6) t) (nullable.some 1000)))))))) (nullable.some false) (ite (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_463 Bool) (BOUND_VARIABLE_464 Bool)) (and BOUND_VARIABLE_463 BOUND_VARIABLE_464)) (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_441 Int) (BOUND_VARIABLE_442 Int)) (> BOUND_VARIABLE_441 BOUND_VARIABLE_442)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_441 Int) (BOUND_VARIABLE_442 Int)) (> BOUND_VARIABLE_441 BOUND_VARIABLE_442)) ((_ tuple.select 6) t) (nullable.some 1000))))) (as nullable.null (Nullable Bool)))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_482 Bool)) (not BOUND_VARIABLE_482)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_482 Bool)) (not BOUND_VARIABLE_482)) ((_ tuple.select 0) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (ite (and (nullable.is_some (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (> BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (> BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000)))))) (not (nullable.val (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (> BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (> BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000)))))))) (nullable.some false) (ite (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_516 Bool) (BOUND_VARIABLE_517 Bool)) (and BOUND_VARIABLE_516 BOUND_VARIABLE_517)) (nullable.some (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (> BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (> BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000))))) (as nullable.null (Nullable Bool)))))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_532 Bool)) (not BOUND_VARIABLE_532)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_532 Bool)) (not BOUND_VARIABLE_532)) ((_ tuple.select 0) t)))))))
(assert (= q1 ((_ rel.project 0) (set.filter p1 (set.map f0 EMP)))))
(assert (= q2 ((_ rel.project 0) (set.filter p3 (set.map f2 EMP)))))
(check-sat)
;answer: unsat
; duration: 118 ms.
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
(set-option :tlimit-per 20000)
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
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_464 String) (BOUND_VARIABLE_465 String)) (= BOUND_VARIABLE_464 BOUND_VARIABLE_465)) ((_ tuple.select 2) t) ((_ tuple.select 1) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_464 String) (BOUND_VARIABLE_465 String)) (= BOUND_VARIABLE_464 BOUND_VARIABLE_465)) ((_ tuple.select 2) t) ((_ tuple.select 1) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_547 String) (BOUND_VARIABLE_548 String)) (= BOUND_VARIABLE_547 BOUND_VARIABLE_548)) ((_ tuple.select 2) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_547 String) (BOUND_VARIABLE_548 String)) (= BOUND_VARIABLE_547 BOUND_VARIABLE_548)) ((_ tuple.select 2) t) ((_ tuple.select 10) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_571 Bool) (BOUND_VARIABLE_572 Bool)) (and BOUND_VARIABLE_571 BOUND_VARIABLE_572)) (nullable.lift (lambda ((BOUND_VARIABLE_547 String) (BOUND_VARIABLE_548 String)) (= BOUND_VARIABLE_547 BOUND_VARIABLE_548)) ((_ tuple.select 2) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_547 String) (BOUND_VARIABLE_548 String)) (= BOUND_VARIABLE_547 BOUND_VARIABLE_548)) ((_ tuple.select 2) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_547 String) (BOUND_VARIABLE_548 String)) (= BOUND_VARIABLE_547 BOUND_VARIABLE_548)) ((_ tuple.select 2) t) ((_ tuple.select 10) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_571 Bool) (BOUND_VARIABLE_572 Bool)) (and BOUND_VARIABLE_571 BOUND_VARIABLE_572)) (nullable.lift (lambda ((BOUND_VARIABLE_547 String) (BOUND_VARIABLE_548 String)) (= BOUND_VARIABLE_547 BOUND_VARIABLE_548)) ((_ tuple.select 2) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))))))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 2) t)))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_724 String) (BOUND_VARIABLE_725 String)) (= BOUND_VARIABLE_724 BOUND_VARIABLE_725)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_724 String) (BOUND_VARIABLE_725 String)) (= BOUND_VARIABLE_724 BOUND_VARIABLE_725)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_732 Int) (BOUND_VARIABLE_733 Int)) (= BOUND_VARIABLE_732 BOUND_VARIABLE_733)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_732 Int) (BOUND_VARIABLE_733 Int)) (= BOUND_VARIABLE_732 BOUND_VARIABLE_733)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_746 Bool) (BOUND_VARIABLE_747 Bool)) (and BOUND_VARIABLE_746 BOUND_VARIABLE_747)) (nullable.lift (lambda ((BOUND_VARIABLE_724 String) (BOUND_VARIABLE_725 String)) (= BOUND_VARIABLE_724 BOUND_VARIABLE_725)) ((_ tuple.select 9) t) ((_ tuple.select 12) t)) (nullable.lift (lambda ((BOUND_VARIABLE_732 Int) (BOUND_VARIABLE_733 Int)) (= BOUND_VARIABLE_732 BOUND_VARIABLE_733)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_724 String) (BOUND_VARIABLE_725 String)) (= BOUND_VARIABLE_724 BOUND_VARIABLE_725)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_724 String) (BOUND_VARIABLE_725 String)) (= BOUND_VARIABLE_724 BOUND_VARIABLE_725)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_732 Int) (BOUND_VARIABLE_733 Int)) (= BOUND_VARIABLE_732 BOUND_VARIABLE_733)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_732 Int) (BOUND_VARIABLE_733 Int)) (= BOUND_VARIABLE_732 BOUND_VARIABLE_733)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_746 Bool) (BOUND_VARIABLE_747 Bool)) (and BOUND_VARIABLE_746 BOUND_VARIABLE_747)) (nullable.lift (lambda ((BOUND_VARIABLE_724 String) (BOUND_VARIABLE_725 String)) (= BOUND_VARIABLE_724 BOUND_VARIABLE_725)) ((_ tuple.select 9) t) ((_ tuple.select 12) t)) (nullable.lift (lambda ((BOUND_VARIABLE_732 Int) (BOUND_VARIABLE_733 Int)) (= BOUND_VARIABLE_732 BOUND_VARIABLE_733)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))))))))
(assert (= q1 ((_ rel.project 6) (set.filter p2 (rel.product EMP ((_ rel.project 0 1) ((_ rel.project 0 2) (set.filter p1 (set.map f0 DEPT)))))))))
(assert (= q2 ((_ rel.project 6) (set.filter p5 (rel.product (set.map f3 EMP) (set.map f4 DEPT))))))
(check-sat)
;answer: unsat
; duration: 372 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_368 Int) (BOUND_VARIABLE_369 Int)) (> BOUND_VARIABLE_368 BOUND_VARIABLE_369)) (nullable.lift (lambda ((BOUND_VARIABLE_350 Int) (BOUND_VARIABLE_351 Int)) (+ BOUND_VARIABLE_350 BOUND_VARIABLE_351)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_362 Int) (BOUND_VARIABLE_363 Int)) (+ BOUND_VARIABLE_362 BOUND_VARIABLE_363)) (nullable.some 3) (as nullable.null (Nullable Int))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_368 Int) (BOUND_VARIABLE_369 Int)) (> BOUND_VARIABLE_368 BOUND_VARIABLE_369)) (nullable.lift (lambda ((BOUND_VARIABLE_350 Int) (BOUND_VARIABLE_351 Int)) (+ BOUND_VARIABLE_350 BOUND_VARIABLE_351)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_362 Int) (BOUND_VARIABLE_363 Int)) (+ BOUND_VARIABLE_362 BOUND_VARIABLE_363)) (nullable.some 3) (as nullable.null (Nullable Int)))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_442 Int) (BOUND_VARIABLE_443 Int)) (> BOUND_VARIABLE_442 BOUND_VARIABLE_443)) (nullable.lift (lambda ((BOUND_VARIABLE_430 Int) (BOUND_VARIABLE_431 Int)) (+ BOUND_VARIABLE_430 BOUND_VARIABLE_431)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_436 Int) (BOUND_VARIABLE_437 Int)) (+ BOUND_VARIABLE_436 BOUND_VARIABLE_437)) (nullable.some 3) (as nullable.null (Nullable Int))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_442 Int) (BOUND_VARIABLE_443 Int)) (> BOUND_VARIABLE_442 BOUND_VARIABLE_443)) (nullable.lift (lambda ((BOUND_VARIABLE_430 Int) (BOUND_VARIABLE_431 Int)) (+ BOUND_VARIABLE_430 BOUND_VARIABLE_431)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_436 Int) (BOUND_VARIABLE_437 Int)) (+ BOUND_VARIABLE_436 BOUND_VARIABLE_437)) (nullable.some 3) (as nullable.null (Nullable Int)))))))))
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
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 3) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 3) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_464 Int) (BOUND_VARIABLE_465 Int)) (= BOUND_VARIABLE_464 BOUND_VARIABLE_465)) ((_ tuple.select 3) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_464 Int) (BOUND_VARIABLE_465 Int)) (= BOUND_VARIABLE_464 BOUND_VARIABLE_465)) ((_ tuple.select 3) t) (nullable.some 10)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 10)))))
(assert (= q1 ((_ rel.project 3) (set.filter p0 EMP))))
(assert (= q2 (set.map f2 (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 38 ms.
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (= BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (= BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_532 Int) (BOUND_VARIABLE_533 Int)) (> BOUND_VARIABLE_532 BOUND_VARIABLE_533)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_532 Int) (BOUND_VARIABLE_533 Int)) (> BOUND_VARIABLE_532 BOUND_VARIABLE_533)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_551 Int) (BOUND_VARIABLE_552 Int)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_551 Int) (BOUND_VARIABLE_552 Int)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f2 (set.filter p1 (rel.product ((_ rel.project 5) (set.filter p0 EMP)) EMP)))))
(assert (= q2 (set.map f5 (set.filter p4 (rel.product ((_ rel.project 5) (set.filter p3 EMP)) EMP)))))
(check-sat)
;answer: unsat
; duration: 388 ms.
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_518 Int) (BOUND_VARIABLE_519 Int)) (= BOUND_VARIABLE_518 BOUND_VARIABLE_519)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_518 Int) (BOUND_VARIABLE_519 Int)) (= BOUND_VARIABLE_518 BOUND_VARIABLE_519)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_629 Int) (BOUND_VARIABLE_630 Int)) (= BOUND_VARIABLE_629 BOUND_VARIABLE_630)) ((_ tuple.select 16) t) ((_ tuple.select 25) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_629 Int) (BOUND_VARIABLE_630 Int)) (= BOUND_VARIABLE_629 BOUND_VARIABLE_630)) ((_ tuple.select 16) t) ((_ tuple.select 25) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_667 Int) (BOUND_VARIABLE_668 Int)) (> BOUND_VARIABLE_667 BOUND_VARIABLE_668)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_667 Int) (BOUND_VARIABLE_668 Int)) (> BOUND_VARIABLE_667 BOUND_VARIABLE_668)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_684 Int) (BOUND_VARIABLE_685 Int)) (> BOUND_VARIABLE_684 BOUND_VARIABLE_685)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_684 Int) (BOUND_VARIABLE_685 Int)) (> BOUND_VARIABLE_684 BOUND_VARIABLE_685)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_703 Int) (BOUND_VARIABLE_704 Int)) (= BOUND_VARIABLE_703 BOUND_VARIABLE_704)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_703 Int) (BOUND_VARIABLE_704 Int)) (= BOUND_VARIABLE_703 BOUND_VARIABLE_704)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_719 Int) (BOUND_VARIABLE_720 Int)) (> BOUND_VARIABLE_719 BOUND_VARIABLE_720)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_719 Int) (BOUND_VARIABLE_720 Int)) (> BOUND_VARIABLE_719 BOUND_VARIABLE_720)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_738 Int) (BOUND_VARIABLE_739 Int)) (= BOUND_VARIABLE_738 BOUND_VARIABLE_739)) ((_ tuple.select 16) t) ((_ tuple.select 25) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_738 Int) (BOUND_VARIABLE_739 Int)) (= BOUND_VARIABLE_738 BOUND_VARIABLE_739)) ((_ tuple.select 16) t) ((_ tuple.select 25) t)))))))
(assert (= f9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f3 (set.filter p2 (rel.product (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) EMP)) EMP)))))
(assert (= q2 (set.map f9 (set.filter p8 (rel.product (set.filter p6 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p7 EMP)))))))
(check-sat)
;answer: unsat
; duration: 965 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_588 Bool) (BOUND_VARIABLE_589 Bool)) (and BOUND_VARIABLE_588 BOUND_VARIABLE_589)) (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_588 Bool) (BOUND_VARIABLE_589 Bool)) (and BOUND_VARIABLE_588 BOUND_VARIABLE_589)) (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_624 Int) (BOUND_VARIABLE_625 Int)) (= BOUND_VARIABLE_624 BOUND_VARIABLE_625)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_624 Int) (BOUND_VARIABLE_625 Int)) (= BOUND_VARIABLE_624 BOUND_VARIABLE_625)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_643 Int) (BOUND_VARIABLE_644 Int)) (= BOUND_VARIABLE_643 BOUND_VARIABLE_644)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_643 Int) (BOUND_VARIABLE_644 Int)) (= BOUND_VARIABLE_643 BOUND_VARIABLE_644)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)))))))
(assert (= q1 ((_ rel.project 1) (set.filter p0 (rel.product (rel.product EMP DEPT) EMP)))))
(assert (= q2 ((_ rel.project 1) (set.filter p2 (rel.product (set.filter p1 (rel.product EMP DEPT)) EMP)))))
(check-sat)
;answer: unsat
; duration: 194 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Bool)) Bool))
(declare-const q1 (Set (Tuple (Nullable Bool))))
(declare-const p1 (-> (Tuple (Nullable Bool)) Bool))
(declare-const q2 (Set (Tuple (Nullable Bool))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_380 Bool)) (not BOUND_VARIABLE_380)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_380 Bool)) (not BOUND_VARIABLE_380)) ((_ tuple.select 0) t)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Bool)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_401 Bool)) (not BOUND_VARIABLE_401)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_401 Bool)) (not BOUND_VARIABLE_401)) ((_ tuple.select 0) t)))))))
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
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_518 Int) (BOUND_VARIABLE_519 Int)) (= BOUND_VARIABLE_518 BOUND_VARIABLE_519)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_518 Int) (BOUND_VARIABLE_519 Int)) (= BOUND_VARIABLE_518 BOUND_VARIABLE_519)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_556 Int) (BOUND_VARIABLE_557 Int)) (> BOUND_VARIABLE_556 BOUND_VARIABLE_557)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_556 Int) (BOUND_VARIABLE_557 Int)) (> BOUND_VARIABLE_556 BOUND_VARIABLE_557)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (> BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (> BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_592 Int) (BOUND_VARIABLE_593 Int)) (= BOUND_VARIABLE_592 BOUND_VARIABLE_593)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_592 Int) (BOUND_VARIABLE_593 Int)) (= BOUND_VARIABLE_592 BOUND_VARIABLE_593)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f2 (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) EMP)))))
(assert (= q2 (set.map f6 (set.filter p5 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)))))))
(check-sat)
;answer: unsat
; duration: 360 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 8))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 8))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_472 Bool) (BOUND_VARIABLE_473 Bool) (BOUND_VARIABLE_474 Bool) (BOUND_VARIABLE_475 Bool) (BOUND_VARIABLE_476 Bool)) (and BOUND_VARIABLE_472 BOUND_VARIABLE_473 BOUND_VARIABLE_474 BOUND_VARIABLE_475 BOUND_VARIABLE_476)) (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 8)) (nullable.lift (lambda ((BOUND_VARIABLE_448 Int) (BOUND_VARIABLE_449 Int)) (= BOUND_VARIABLE_448 BOUND_VARIABLE_449)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some (nullable.is_null ((_ tuple.select 3) t))) (nullable.lift (lambda ((BOUND_VARIABLE_456 Int) (BOUND_VARIABLE_457 Int)) (= BOUND_VARIABLE_456 BOUND_VARIABLE_457)) ((_ tuple.select 0) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 8))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 8))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_472 Bool) (BOUND_VARIABLE_473 Bool) (BOUND_VARIABLE_474 Bool) (BOUND_VARIABLE_475 Bool) (BOUND_VARIABLE_476 Bool)) (and BOUND_VARIABLE_472 BOUND_VARIABLE_473 BOUND_VARIABLE_474 BOUND_VARIABLE_475 BOUND_VARIABLE_476)) (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 8)) (nullable.lift (lambda ((BOUND_VARIABLE_448 Int) (BOUND_VARIABLE_449 Int)) (= BOUND_VARIABLE_448 BOUND_VARIABLE_449)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some (nullable.is_null ((_ tuple.select 3) t))) (nullable.lift (lambda ((BOUND_VARIABLE_456 Int) (BOUND_VARIABLE_457 Int)) (= BOUND_VARIABLE_456 BOUND_VARIABLE_457)) ((_ tuple.select 0) t) (nullable.some 10))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 10) ((_ tuple.select 1) t) ((_ tuple.select 2) t) (as nullable.null (Nullable Int)) ((_ tuple.select 4) t) ((_ tuple.select 6) t) ((_ tuple.select 5) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 (set.map f2 (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 39 ms.
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
(set-option :tlimit-per 20000)
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
(assert (= p2 (lambda ((t (Tuple (Nullable Int)))) (nullable.is_null ((_ tuple.select 0) t)))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int))))))
(assert (= q1 ((_ rel.project 0) (set.filter p2 ((_ rel.project 0) (set.filter p1 (set.map f0 EMP)))))))
(assert (= q2 (set.map f3 EMP)))
(check-sat)
;answer: unsat
; duration: 19 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (> BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (> BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (<= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (<= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_453 Bool) (BOUND_VARIABLE_454 Bool)) (and BOUND_VARIABLE_453 BOUND_VARIABLE_454)) (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (> BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (<= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 0) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (> BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (> BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (<= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (<= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_453 Bool) (BOUND_VARIABLE_454 Bool)) (and BOUND_VARIABLE_453 BOUND_VARIABLE_454)) (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (> BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (<= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 0) t) (nullable.some 10))))))))))
(assert (= q1 ((_ rel.project 0) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0) (set.minus ((_ rel.project 0) (set.singleton (tuple (nullable.some 0)))) ((_ rel.project 0) (set.singleton (tuple (nullable.some 0))))))))
(check-sat)
;answer: unsat
; duration: 19 ms.
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_574 Int) (BOUND_VARIABLE_575 Int)) (= BOUND_VARIABLE_574 BOUND_VARIABLE_575)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_574 Int) (BOUND_VARIABLE_575 Int)) (= BOUND_VARIABLE_574 BOUND_VARIABLE_575)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_589 Bool) (BOUND_VARIABLE_590 Bool)) (and BOUND_VARIABLE_589 BOUND_VARIABLE_590)) (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_574 Int) (BOUND_VARIABLE_575 Int)) (= BOUND_VARIABLE_574 BOUND_VARIABLE_575)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_574 Int) (BOUND_VARIABLE_575 Int)) (= BOUND_VARIABLE_574 BOUND_VARIABLE_575)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_574 Int) (BOUND_VARIABLE_575 Int)) (= BOUND_VARIABLE_574 BOUND_VARIABLE_575)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_589 Bool) (BOUND_VARIABLE_590 Bool)) (and BOUND_VARIABLE_589 BOUND_VARIABLE_590)) (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_574 Int) (BOUND_VARIABLE_575 Int)) (= BOUND_VARIABLE_574 BOUND_VARIABLE_575)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_625 Int) (BOUND_VARIABLE_626 Int)) (= BOUND_VARIABLE_625 BOUND_VARIABLE_626)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_625 Int) (BOUND_VARIABLE_626 Int)) (= BOUND_VARIABLE_625 BOUND_VARIABLE_626)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_644 Int) (BOUND_VARIABLE_645 Int)) (= BOUND_VARIABLE_644 BOUND_VARIABLE_645)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_644 Int) (BOUND_VARIABLE_645 Int)) (= BOUND_VARIABLE_644 BOUND_VARIABLE_645)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_739 Int) (BOUND_VARIABLE_740 Int)) (= BOUND_VARIABLE_739 BOUND_VARIABLE_740)) ((_ tuple.select 7) t) ((_ tuple.select 20) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_739 Int) (BOUND_VARIABLE_740 Int)) (= BOUND_VARIABLE_739 BOUND_VARIABLE_740)) ((_ tuple.select 7) t) ((_ tuple.select 20) t)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_862 Int) (BOUND_VARIABLE_863 Int)) (= BOUND_VARIABLE_862 BOUND_VARIABLE_863)) ((_ tuple.select 0) t) ((_ tuple.select 22) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_862 Int) (BOUND_VARIABLE_863 Int)) (= BOUND_VARIABLE_862 BOUND_VARIABLE_863)) ((_ tuple.select 0) t) ((_ tuple.select 22) t)))))))
(assert (= q1 ((_ rel.project 1) (set.filter p0 (rel.product (rel.product EMP DEPT) EMP)))))
(assert (= q2 ((_ rel.project 1) (set.filter p4 (rel.product (set.filter p3 (rel.product (set.filter p2 (rel.product (set.filter p1 (rel.product EMP DEPT)) EMP)) DEPT)) EMP)))))
(check-sat)
;answer: unsat
; duration: 474 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (tuple (nullable.some 1)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_533 Int) (BOUND_VARIABLE_534 Int)) (= BOUND_VARIABLE_533 BOUND_VARIABLE_534)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_533 Int) (BOUND_VARIABLE_534 Int)) (= BOUND_VARIABLE_533 BOUND_VARIABLE_534)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f1 (set.filter p0 (rel.product EMP DEPT)))))
(assert (= q2 (set.map f3 (set.filter p2 (rel.product EMP DEPT)))))
(check-sat)
;answer: unsat
; duration: 56 ms.
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_481 Int) (BOUND_VARIABLE_482 Int)) (= BOUND_VARIABLE_481 BOUND_VARIABLE_482)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_481 Int) (BOUND_VARIABLE_482 Int)) (= BOUND_VARIABLE_481 BOUND_VARIABLE_482)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (> BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (> BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_568 Int) (BOUND_VARIABLE_569 Int)) (> BOUND_VARIABLE_568 BOUND_VARIABLE_569)) ((_ tuple.select 16) t) (nullable.some 9))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_568 Int) (BOUND_VARIABLE_569 Int)) (> BOUND_VARIABLE_568 BOUND_VARIABLE_569)) ((_ tuple.select 16) t) (nullable.some 9))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_583 Bool) (BOUND_VARIABLE_584 Bool)) (and BOUND_VARIABLE_583 BOUND_VARIABLE_584)) (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (> BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_568 Int) (BOUND_VARIABLE_569 Int)) (> BOUND_VARIABLE_568 BOUND_VARIABLE_569)) ((_ tuple.select 16) t) (nullable.some 9)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (> BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (> BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_568 Int) (BOUND_VARIABLE_569 Int)) (> BOUND_VARIABLE_568 BOUND_VARIABLE_569)) ((_ tuple.select 16) t) (nullable.some 9))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_568 Int) (BOUND_VARIABLE_569 Int)) (> BOUND_VARIABLE_568 BOUND_VARIABLE_569)) ((_ tuple.select 16) t) (nullable.some 9))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_583 Bool) (BOUND_VARIABLE_584 Bool)) (and BOUND_VARIABLE_583 BOUND_VARIABLE_584)) (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (> BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_568 Int) (BOUND_VARIABLE_569 Int)) (> BOUND_VARIABLE_568 BOUND_VARIABLE_569)) ((_ tuple.select 16) t) (nullable.some 9))))))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_624 Int) (BOUND_VARIABLE_625 Int)) (= BOUND_VARIABLE_624 BOUND_VARIABLE_625)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_624 Int) (BOUND_VARIABLE_625 Int)) (= BOUND_VARIABLE_624 BOUND_VARIABLE_625)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= leftJoin6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_678 Int) (BOUND_VARIABLE_679 Int)) (> BOUND_VARIABLE_678 BOUND_VARIABLE_679)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_678 Int) (BOUND_VARIABLE_679 Int)) (> BOUND_VARIABLE_678 BOUND_VARIABLE_679)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_685 Int) (BOUND_VARIABLE_686 Int)) (> BOUND_VARIABLE_685 BOUND_VARIABLE_686)) ((_ tuple.select 16) t) (nullable.some 9))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_685 Int) (BOUND_VARIABLE_686 Int)) (> BOUND_VARIABLE_685 BOUND_VARIABLE_686)) ((_ tuple.select 16) t) (nullable.some 9))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_699 Bool) (BOUND_VARIABLE_700 Bool)) (and BOUND_VARIABLE_699 BOUND_VARIABLE_700)) (nullable.lift (lambda ((BOUND_VARIABLE_678 Int) (BOUND_VARIABLE_679 Int)) (> BOUND_VARIABLE_678 BOUND_VARIABLE_679)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_685 Int) (BOUND_VARIABLE_686 Int)) (> BOUND_VARIABLE_685 BOUND_VARIABLE_686)) ((_ tuple.select 16) t) (nullable.some 9)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_678 Int) (BOUND_VARIABLE_679 Int)) (> BOUND_VARIABLE_678 BOUND_VARIABLE_679)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_678 Int) (BOUND_VARIABLE_679 Int)) (> BOUND_VARIABLE_678 BOUND_VARIABLE_679)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_685 Int) (BOUND_VARIABLE_686 Int)) (> BOUND_VARIABLE_685 BOUND_VARIABLE_686)) ((_ tuple.select 16) t) (nullable.some 9))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_685 Int) (BOUND_VARIABLE_686 Int)) (> BOUND_VARIABLE_685 BOUND_VARIABLE_686)) ((_ tuple.select 16) t) (nullable.some 9))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_699 Bool) (BOUND_VARIABLE_700 Bool)) (and BOUND_VARIABLE_699 BOUND_VARIABLE_700)) (nullable.lift (lambda ((BOUND_VARIABLE_678 Int) (BOUND_VARIABLE_679 Int)) (> BOUND_VARIABLE_678 BOUND_VARIABLE_679)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_685 Int) (BOUND_VARIABLE_686 Int)) (> BOUND_VARIABLE_685 BOUND_VARIABLE_686)) ((_ tuple.select 16) t) (nullable.some 9))))))))))
(assert (= f9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f4 (set.filter p3 (set.union (set.union (set.map leftJoin1 (set.minus EMP ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 (rel.product EMP EMP))))) (set.map rightJoin2 (set.minus EMP ((_ rel.project 9 10 11 12 13 14 15 16 17) (set.filter p0 (rel.product EMP EMP)))))) (set.filter p0 (rel.product EMP EMP)))))))
(assert (= q2 (set.map f9 (set.filter p8 (set.union (set.union (set.map leftJoin6 (set.minus EMP ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 (rel.product EMP EMP))))) (set.map rightJoin7 (set.minus EMP ((_ rel.project 9 10 11 12 13 14 15 16 17) (set.filter p5 (rel.product EMP EMP)))))) (set.filter p5 (rel.product EMP EMP)))))))
(check-sat)
;answer: unsat
; duration: 585 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
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
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_464 String) (BOUND_VARIABLE_465 String)) (= BOUND_VARIABLE_464 BOUND_VARIABLE_465)) ((_ tuple.select 2) t) ((_ tuple.select 1) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_464 String) (BOUND_VARIABLE_465 String)) (= BOUND_VARIABLE_464 BOUND_VARIABLE_465)) ((_ tuple.select 2) t) ((_ tuple.select 1) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_547 String) (BOUND_VARIABLE_548 String)) (= BOUND_VARIABLE_547 BOUND_VARIABLE_548)) ((_ tuple.select 2) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_547 String) (BOUND_VARIABLE_548 String)) (= BOUND_VARIABLE_547 BOUND_VARIABLE_548)) ((_ tuple.select 2) t) ((_ tuple.select 10) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_571 Bool) (BOUND_VARIABLE_572 Bool)) (and BOUND_VARIABLE_571 BOUND_VARIABLE_572)) (nullable.lift (lambda ((BOUND_VARIABLE_547 String) (BOUND_VARIABLE_548 String)) (= BOUND_VARIABLE_547 BOUND_VARIABLE_548)) ((_ tuple.select 2) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_547 String) (BOUND_VARIABLE_548 String)) (= BOUND_VARIABLE_547 BOUND_VARIABLE_548)) ((_ tuple.select 2) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_547 String) (BOUND_VARIABLE_548 String)) (= BOUND_VARIABLE_547 BOUND_VARIABLE_548)) ((_ tuple.select 2) t) ((_ tuple.select 10) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_571 Bool) (BOUND_VARIABLE_572 Bool)) (and BOUND_VARIABLE_571 BOUND_VARIABLE_572)) (nullable.lift (lambda ((BOUND_VARIABLE_547 String) (BOUND_VARIABLE_548 String)) (= BOUND_VARIABLE_547 BOUND_VARIABLE_548)) ((_ tuple.select 2) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))))))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 1) t)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_650 String) (BOUND_VARIABLE_651 String)) (= BOUND_VARIABLE_650 BOUND_VARIABLE_651)) ((_ tuple.select 9) t) ((_ tuple.select 1) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_650 String) (BOUND_VARIABLE_651 String)) (= BOUND_VARIABLE_650 BOUND_VARIABLE_651)) ((_ tuple.select 9) t) ((_ tuple.select 1) t)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_722 String) (BOUND_VARIABLE_723 String)) (= BOUND_VARIABLE_722 BOUND_VARIABLE_723)) ((_ tuple.select 1) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_722 String) (BOUND_VARIABLE_723 String)) (= BOUND_VARIABLE_722 BOUND_VARIABLE_723)) ((_ tuple.select 1) t) ((_ tuple.select 12) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_730 Int) (BOUND_VARIABLE_731 Int)) (= BOUND_VARIABLE_730 BOUND_VARIABLE_731)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_730 Int) (BOUND_VARIABLE_731 Int)) (= BOUND_VARIABLE_730 BOUND_VARIABLE_731)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_744 Bool) (BOUND_VARIABLE_745 Bool)) (and BOUND_VARIABLE_744 BOUND_VARIABLE_745)) (nullable.lift (lambda ((BOUND_VARIABLE_722 String) (BOUND_VARIABLE_723 String)) (= BOUND_VARIABLE_722 BOUND_VARIABLE_723)) ((_ tuple.select 1) t) ((_ tuple.select 12) t)) (nullable.lift (lambda ((BOUND_VARIABLE_730 Int) (BOUND_VARIABLE_731 Int)) (= BOUND_VARIABLE_730 BOUND_VARIABLE_731)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_722 String) (BOUND_VARIABLE_723 String)) (= BOUND_VARIABLE_722 BOUND_VARIABLE_723)) ((_ tuple.select 1) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_722 String) (BOUND_VARIABLE_723 String)) (= BOUND_VARIABLE_722 BOUND_VARIABLE_723)) ((_ tuple.select 1) t) ((_ tuple.select 12) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_730 Int) (BOUND_VARIABLE_731 Int)) (= BOUND_VARIABLE_730 BOUND_VARIABLE_731)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_730 Int) (BOUND_VARIABLE_731 Int)) (= BOUND_VARIABLE_730 BOUND_VARIABLE_731)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_744 Bool) (BOUND_VARIABLE_745 Bool)) (and BOUND_VARIABLE_744 BOUND_VARIABLE_745)) (nullable.lift (lambda ((BOUND_VARIABLE_722 String) (BOUND_VARIABLE_723 String)) (= BOUND_VARIABLE_722 BOUND_VARIABLE_723)) ((_ tuple.select 1) t) ((_ tuple.select 12) t)) (nullable.lift (lambda ((BOUND_VARIABLE_730 Int) (BOUND_VARIABLE_731 Int)) (= BOUND_VARIABLE_730 BOUND_VARIABLE_731)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))))))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 2) t)))))
(assert (= f7 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_854 String) (BOUND_VARIABLE_855 String)) (= BOUND_VARIABLE_854 BOUND_VARIABLE_855)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_854 String) (BOUND_VARIABLE_855 String)) (= BOUND_VARIABLE_854 BOUND_VARIABLE_855)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_862 Int) (BOUND_VARIABLE_863 Int)) (= BOUND_VARIABLE_862 BOUND_VARIABLE_863)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_862 Int) (BOUND_VARIABLE_863 Int)) (= BOUND_VARIABLE_862 BOUND_VARIABLE_863)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_876 Bool) (BOUND_VARIABLE_877 Bool)) (and BOUND_VARIABLE_876 BOUND_VARIABLE_877)) (nullable.lift (lambda ((BOUND_VARIABLE_854 String) (BOUND_VARIABLE_855 String)) (= BOUND_VARIABLE_854 BOUND_VARIABLE_855)) ((_ tuple.select 9) t) ((_ tuple.select 12) t)) (nullable.lift (lambda ((BOUND_VARIABLE_862 Int) (BOUND_VARIABLE_863 Int)) (= BOUND_VARIABLE_862 BOUND_VARIABLE_863)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_854 String) (BOUND_VARIABLE_855 String)) (= BOUND_VARIABLE_854 BOUND_VARIABLE_855)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_854 String) (BOUND_VARIABLE_855 String)) (= BOUND_VARIABLE_854 BOUND_VARIABLE_855)) ((_ tuple.select 9) t) ((_ tuple.select 12) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_862 Int) (BOUND_VARIABLE_863 Int)) (= BOUND_VARIABLE_862 BOUND_VARIABLE_863)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_862 Int) (BOUND_VARIABLE_863 Int)) (= BOUND_VARIABLE_862 BOUND_VARIABLE_863)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_876 Bool) (BOUND_VARIABLE_877 Bool)) (and BOUND_VARIABLE_876 BOUND_VARIABLE_877)) (nullable.lift (lambda ((BOUND_VARIABLE_854 String) (BOUND_VARIABLE_855 String)) (= BOUND_VARIABLE_854 BOUND_VARIABLE_855)) ((_ tuple.select 9) t) ((_ tuple.select 12) t)) (nullable.lift (lambda ((BOUND_VARIABLE_862 Int) (BOUND_VARIABLE_863 Int)) (= BOUND_VARIABLE_862 BOUND_VARIABLE_863)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))))))))
(assert (= f9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 10) t) ((_ tuple.select 11) t) ((_ tuple.select 1) t)))))
(assert (= f10 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 1) t)))))
(assert (= p11 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1029 String) (BOUND_VARIABLE_1030 String)) (= BOUND_VARIABLE_1029 BOUND_VARIABLE_1030)) ((_ tuple.select 11) t) ((_ tuple.select 14) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1029 String) (BOUND_VARIABLE_1030 String)) (= BOUND_VARIABLE_1029 BOUND_VARIABLE_1030)) ((_ tuple.select 11) t) ((_ tuple.select 14) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1037 Int) (BOUND_VARIABLE_1038 Int)) (= BOUND_VARIABLE_1037 BOUND_VARIABLE_1038)) ((_ tuple.select 0) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1037 Int) (BOUND_VARIABLE_1038 Int)) (= BOUND_VARIABLE_1037 BOUND_VARIABLE_1038)) ((_ tuple.select 0) t) ((_ tuple.select 12) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_1051 Bool) (BOUND_VARIABLE_1052 Bool)) (and BOUND_VARIABLE_1051 BOUND_VARIABLE_1052)) (nullable.lift (lambda ((BOUND_VARIABLE_1029 String) (BOUND_VARIABLE_1030 String)) (= BOUND_VARIABLE_1029 BOUND_VARIABLE_1030)) ((_ tuple.select 11) t) ((_ tuple.select 14) t)) (nullable.lift (lambda ((BOUND_VARIABLE_1037 Int) (BOUND_VARIABLE_1038 Int)) (= BOUND_VARIABLE_1037 BOUND_VARIABLE_1038)) ((_ tuple.select 0) t) ((_ tuple.select 12) t)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1029 String) (BOUND_VARIABLE_1030 String)) (= BOUND_VARIABLE_1029 BOUND_VARIABLE_1030)) ((_ tuple.select 11) t) ((_ tuple.select 14) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1029 String) (BOUND_VARIABLE_1030 String)) (= BOUND_VARIABLE_1029 BOUND_VARIABLE_1030)) ((_ tuple.select 11) t) ((_ tuple.select 14) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1037 Int) (BOUND_VARIABLE_1038 Int)) (= BOUND_VARIABLE_1037 BOUND_VARIABLE_1038)) ((_ tuple.select 0) t) ((_ tuple.select 12) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1037 Int) (BOUND_VARIABLE_1038 Int)) (= BOUND_VARIABLE_1037 BOUND_VARIABLE_1038)) ((_ tuple.select 0) t) ((_ tuple.select 12) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_1051 Bool) (BOUND_VARIABLE_1052 Bool)) (and BOUND_VARIABLE_1051 BOUND_VARIABLE_1052)) (nullable.lift (lambda ((BOUND_VARIABLE_1029 String) (BOUND_VARIABLE_1030 String)) (= BOUND_VARIABLE_1029 BOUND_VARIABLE_1030)) ((_ tuple.select 11) t) ((_ tuple.select 14) t)) (nullable.lift (lambda ((BOUND_VARIABLE_1037 Int) (BOUND_VARIABLE_1038 Int)) (= BOUND_VARIABLE_1037 BOUND_VARIABLE_1038)) ((_ tuple.select 0) t) ((_ tuple.select 12) t))))))))))
(assert (= q1 ((_ rel.project 6) (set.filter p5 (rel.product (set.filter p2 (rel.product EMP ((_ rel.project 0 1) ((_ rel.project 0 2) (set.filter p1 (set.map f0 DEPT)))))) ((_ rel.project 0 1) ((_ rel.project 0 9) (set.filter p4 (set.map f3 EMP)))))))))
(assert (= q2 ((_ rel.project 6) (set.filter p11 (rel.product (set.map f9 (set.filter p8 (rel.product (set.map f6 EMP) (set.map f7 DEPT)))) (set.map f10 EMP))))))
(check-sat)
;answer: unsat
; duration: 1644 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_395 Int) (BOUND_VARIABLE_396 Int)) (= BOUND_VARIABLE_395 BOUND_VARIABLE_396)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_395 Int) (BOUND_VARIABLE_396 Int)) (= BOUND_VARIABLE_395 BOUND_VARIABLE_396)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_431 Int) (BOUND_VARIABLE_432 Int)) (= BOUND_VARIABLE_431 BOUND_VARIABLE_432)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_431 Int) (BOUND_VARIABLE_432 Int)) (= BOUND_VARIABLE_431 BOUND_VARIABLE_432)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_461 Int) (BOUND_VARIABLE_462 Int)) (= BOUND_VARIABLE_461 BOUND_VARIABLE_462)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_461 Int) (BOUND_VARIABLE_462 Int)) (= BOUND_VARIABLE_461 BOUND_VARIABLE_462)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= q1 ((_ rel.project 1) (set.filter p1 ((_ rel.project 0 1) (set.filter p0 DEPT))))))
(assert (= q2 ((_ rel.project 1) (set.filter p2 DEPT))))
(check-sat)
;answer: unsat
; duration: 88 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= q1 ((_ rel.project 6) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP) ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP)))))
(assert (= q2 (set.union ((_ rel.project 6) EMP) ((_ rel.project 6) EMP))))
(check-sat)
;answer: unsat
; duration: 19 ms.
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_473 Int) (BOUND_VARIABLE_474 Int)) (= BOUND_VARIABLE_473 BOUND_VARIABLE_474)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_473 Int) (BOUND_VARIABLE_474 Int)) (= BOUND_VARIABLE_473 BOUND_VARIABLE_474)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_527 Int) (BOUND_VARIABLE_528 Int)) (= BOUND_VARIABLE_527 BOUND_VARIABLE_528)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_527 Int) (BOUND_VARIABLE_528 Int)) (= BOUND_VARIABLE_527 BOUND_VARIABLE_528)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))))
(assert (= q2 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))))
(check-sat)
;answer: unsat
; duration: 110 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_507 Int) (BOUND_VARIABLE_508 Int)) (= BOUND_VARIABLE_507 BOUND_VARIABLE_508)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_507 Int) (BOUND_VARIABLE_508 Int)) (= BOUND_VARIABLE_507 BOUND_VARIABLE_508)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) DEPT)))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.singleton (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some "")))) ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.singleton (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some ""))))))))
(check-sat)
;answer: unsat
; duration: 40 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (ite (and (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 0) t)))) (not (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 0) t)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_449 Bool) (BOUND_VARIABLE_450 Bool)) (and BOUND_VARIABLE_449 BOUND_VARIABLE_450)) (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some (nullable.is_null ((_ tuple.select 0) t))))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (ite (and (nullable.is_some (nullable.some (nullable.is_null ((_ tuple.select 0) t)))) (not (nullable.val (nullable.some (nullable.is_null ((_ tuple.select 0) t)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_449 Bool) (BOUND_VARIABLE_450 Bool)) (and BOUND_VARIABLE_449 BOUND_VARIABLE_450)) (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some (nullable.is_null ((_ tuple.select 0) t)))))))))))
(assert (= q1 ((_ rel.project 0) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0) (set.minus ((_ rel.project 0) (set.singleton (tuple (nullable.some 0)))) ((_ rel.project 0) (set.singleton (tuple (nullable.some 0))))))))
(check-sat)
;answer: unsat
; duration: 16 ms.
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_518 Int) (BOUND_VARIABLE_519 Int)) (= BOUND_VARIABLE_518 BOUND_VARIABLE_519)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_518 Int) (BOUND_VARIABLE_519 Int)) (= BOUND_VARIABLE_518 BOUND_VARIABLE_519)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_556 Int) (BOUND_VARIABLE_557 Int)) (> BOUND_VARIABLE_556 BOUND_VARIABLE_557)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_556 Int) (BOUND_VARIABLE_557 Int)) (> BOUND_VARIABLE_556 BOUND_VARIABLE_557)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (> BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (> BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_592 Int) (BOUND_VARIABLE_593 Int)) (= BOUND_VARIABLE_592 BOUND_VARIABLE_593)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_592 Int) (BOUND_VARIABLE_593 Int)) (= BOUND_VARIABLE_592 BOUND_VARIABLE_593)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f2 (set.filter p1 (rel.product EMP ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)))))))
(assert (= q2 (set.map f6 (set.filter p5 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)))))))
(check-sat)
;answer: unsat
; duration: 360 ms.
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_551 Int) (BOUND_VARIABLE_552 Int)) (> BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 8) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_551 Int) (BOUND_VARIABLE_552 Int)) (> BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 8) t) (nullable.some 100)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_588 Int) (BOUND_VARIABLE_589 Int)) (> BOUND_VARIABLE_588 BOUND_VARIABLE_589)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_588 Int) (BOUND_VARIABLE_589 Int)) (> BOUND_VARIABLE_588 BOUND_VARIABLE_589)) ((_ tuple.select 6) t) (nullable.some 100)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_609 Int) (BOUND_VARIABLE_610 Int)) (= BOUND_VARIABLE_609 BOUND_VARIABLE_610)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_609 Int) (BOUND_VARIABLE_610 Int)) (= BOUND_VARIABLE_609 BOUND_VARIABLE_610)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f4 (set.filter p3 (set.union (set.union (set.map leftJoin1 (set.minus DEPT ((_ rel.project 0 1) (set.filter p0 (rel.product DEPT EMP))))) (set.map rightJoin2 (set.minus EMP ((_ rel.project 2 3 4 5 6 7 8 9 10) (set.filter p0 (rel.product DEPT EMP)))))) (set.filter p0 (rel.product DEPT EMP)))))))
(assert (= q2 (set.map f8 (set.union (set.map rightJoin7 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)) ((_ rel.project 2 3 4 5 6 7 8 9 10) (set.filter p6 (rel.product DEPT ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP))))))) (set.filter p6 (rel.product DEPT ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP))))))))
(check-sat)
;answer: unsat
; duration: 819 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_444 Bool)) (not BOUND_VARIABLE_444)) (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 0) t) (nullable.some 10)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_444 Bool)) (not BOUND_VARIABLE_444)) (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 0) t) (nullable.some 10)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_459 Bool) (BOUND_VARIABLE_460 Bool)) (and BOUND_VARIABLE_459 BOUND_VARIABLE_460)) (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_444 Bool)) (not BOUND_VARIABLE_444)) (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 0) t) (nullable.some 10))))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_444 Bool)) (not BOUND_VARIABLE_444)) (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 0) t) (nullable.some 10)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_444 Bool)) (not BOUND_VARIABLE_444)) (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 0) t) (nullable.some 10)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_459 Bool) (BOUND_VARIABLE_460 Bool)) (and BOUND_VARIABLE_459 BOUND_VARIABLE_460)) (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_444 Bool)) (not BOUND_VARIABLE_444)) (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 0) t) (nullable.some 10)))))))))))
(assert (= q1 ((_ rel.project 0) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0) (set.minus ((_ rel.project 0) (set.singleton (tuple (nullable.some 0)))) ((_ rel.project 0) (set.singleton (tuple (nullable.some 0))))))))
(check-sat)
;answer: unsat
; duration: 32 ms.
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
(set-option :tlimit-per 20000)
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
(assert (= q1 (set.map f1 (set.union (set.map leftJoin0 (set.minus (set.singleton (tuple (nullable.some 1))) ((_ rel.project 0) (rel.product (set.singleton (tuple (nullable.some 1))) (set.singleton (tuple (nullable.some 1))))))) (rel.product (set.singleton (tuple (nullable.some 1))) (set.singleton (tuple (nullable.some 1))))))))
(assert (= q2 (set.map f3 (set.union (set.map leftJoin2 (set.minus (set.singleton (tuple (nullable.some 1))) ((_ rel.project 0) (rel.product (set.singleton (tuple (nullable.some 1))) (set.singleton (tuple (nullable.some 1))))))) (rel.product (set.singleton (tuple (nullable.some 1))) (set.singleton (tuple (nullable.some 1))))))))
(check-sat)
;answer: unsat
; duration: 7 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_481 Int) (BOUND_VARIABLE_482 Int)) (= BOUND_VARIABLE_481 BOUND_VARIABLE_482)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_481 Int) (BOUND_VARIABLE_482 Int)) (= BOUND_VARIABLE_481 BOUND_VARIABLE_482)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_536 Int) (BOUND_VARIABLE_537 Int)) (= BOUND_VARIABLE_536 BOUND_VARIABLE_537)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_536 Int) (BOUND_VARIABLE_537 Int)) (= BOUND_VARIABLE_536 BOUND_VARIABLE_537)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f1 (set.filter p0 (rel.product EMP EMP)))))
(assert (= q2 (set.map f3 (set.filter p2 (rel.product EMP EMP)))))
(check-sat)
;answer: unsat
; duration: 48 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_397 Int) (BOUND_VARIABLE_398 Int)) (< BOUND_VARIABLE_397 BOUND_VARIABLE_398)) (nullable.lift (lambda ((BOUND_VARIABLE_388 Int) (BOUND_VARIABLE_389 Int)) (- BOUND_VARIABLE_388 BOUND_VARIABLE_389)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_397 Int) (BOUND_VARIABLE_398 Int)) (< BOUND_VARIABLE_397 BOUND_VARIABLE_398)) (nullable.lift (lambda ((BOUND_VARIABLE_388 Int) (BOUND_VARIABLE_389 Int)) (- BOUND_VARIABLE_388 BOUND_VARIABLE_389)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 0)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_447 Int) (BOUND_VARIABLE_448 Int)) (+ BOUND_VARIABLE_447 BOUND_VARIABLE_448)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= q1 (set.map f1 (set.filter p0 (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 30) (nullable.some 7))))))))
(assert (= q2 ((_ rel.project 0 1 2) (set.minus ((_ rel.project 0 1 2) (set.singleton (tuple (nullable.some 0) (nullable.some 0) (nullable.some 0)))) ((_ rel.project 0 1 2) (set.singleton (tuple (nullable.some 0) (nullable.some 0) (nullable.some 0))))))))
(check-sat)
;answer: unsat
; duration: 8 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_425 Int) (BOUND_VARIABLE_426 Int)) (= BOUND_VARIABLE_425 BOUND_VARIABLE_426)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_417 Int) (BOUND_VARIABLE_418 Int)) (* BOUND_VARIABLE_417 BOUND_VARIABLE_418)) (nullable.some 10) ((_ tuple.select 5) t)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_425 Int) (BOUND_VARIABLE_426 Int)) (= BOUND_VARIABLE_425 BOUND_VARIABLE_426)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_417 Int) (BOUND_VARIABLE_418 Int)) (* BOUND_VARIABLE_417 BOUND_VARIABLE_418)) (nullable.some 10) ((_ tuple.select 5) t)))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_455 String) (BOUND_VARIABLE_456 String)) (= BOUND_VARIABLE_455 BOUND_VARIABLE_456)) (nullable.lift (lambda ((BOUND_VARIABLE_447 String)) (str.to_upper BOUND_VARIABLE_447)) ((_ tuple.select 1) t)) (nullable.some "FOO"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_455 String) (BOUND_VARIABLE_456 String)) (= BOUND_VARIABLE_455 BOUND_VARIABLE_456)) (nullable.lift (lambda ((BOUND_VARIABLE_447 String)) (str.to_upper BOUND_VARIABLE_447)) ((_ tuple.select 1) t)) (nullable.some "FOO"))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_471 Bool) (BOUND_VARIABLE_472 Bool)) (and BOUND_VARIABLE_471 BOUND_VARIABLE_472)) (nullable.lift (lambda ((BOUND_VARIABLE_425 Int) (BOUND_VARIABLE_426 Int)) (= BOUND_VARIABLE_425 BOUND_VARIABLE_426)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_417 Int) (BOUND_VARIABLE_418 Int)) (* BOUND_VARIABLE_417 BOUND_VARIABLE_418)) (nullable.some 10) ((_ tuple.select 5) t))) (nullable.lift (lambda ((BOUND_VARIABLE_455 String) (BOUND_VARIABLE_456 String)) (= BOUND_VARIABLE_455 BOUND_VARIABLE_456)) (nullable.lift (lambda ((BOUND_VARIABLE_447 String)) (str.to_upper BOUND_VARIABLE_447)) ((_ tuple.select 1) t)) (nullable.some "FOO")))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_425 Int) (BOUND_VARIABLE_426 Int)) (= BOUND_VARIABLE_425 BOUND_VARIABLE_426)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_417 Int) (BOUND_VARIABLE_418 Int)) (* BOUND_VARIABLE_417 BOUND_VARIABLE_418)) (nullable.some 10) ((_ tuple.select 5) t)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_425 Int) (BOUND_VARIABLE_426 Int)) (= BOUND_VARIABLE_425 BOUND_VARIABLE_426)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_417 Int) (BOUND_VARIABLE_418 Int)) (* BOUND_VARIABLE_417 BOUND_VARIABLE_418)) (nullable.some 10) ((_ tuple.select 5) t)))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_455 String) (BOUND_VARIABLE_456 String)) (= BOUND_VARIABLE_455 BOUND_VARIABLE_456)) (nullable.lift (lambda ((BOUND_VARIABLE_447 String)) (str.to_upper BOUND_VARIABLE_447)) ((_ tuple.select 1) t)) (nullable.some "FOO"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_455 String) (BOUND_VARIABLE_456 String)) (= BOUND_VARIABLE_455 BOUND_VARIABLE_456)) (nullable.lift (lambda ((BOUND_VARIABLE_447 String)) (str.to_upper BOUND_VARIABLE_447)) ((_ tuple.select 1) t)) (nullable.some "FOO"))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_471 Bool) (BOUND_VARIABLE_472 Bool)) (and BOUND_VARIABLE_471 BOUND_VARIABLE_472)) (nullable.lift (lambda ((BOUND_VARIABLE_425 Int) (BOUND_VARIABLE_426 Int)) (= BOUND_VARIABLE_425 BOUND_VARIABLE_426)) ((_ tuple.select 6) t) (nullable.lift (lambda ((BOUND_VARIABLE_417 Int) (BOUND_VARIABLE_418 Int)) (* BOUND_VARIABLE_417 BOUND_VARIABLE_418)) (nullable.some 10) ((_ tuple.select 5) t))) (nullable.lift (lambda ((BOUND_VARIABLE_455 String) (BOUND_VARIABLE_456 String)) (= BOUND_VARIABLE_455 BOUND_VARIABLE_456)) (nullable.lift (lambda ((BOUND_VARIABLE_447 String)) (str.to_upper BOUND_VARIABLE_447)) ((_ tuple.select 1) t)) (nullable.some "FOO"))))))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_503 Int) (BOUND_VARIABLE_504 Int)) (+ BOUND_VARIABLE_503 BOUND_VARIABLE_504)) ((_ tuple.select 0) t) ((_ tuple.select 7) t))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_549 Int) (BOUND_VARIABLE_550 Int)) (* BOUND_VARIABLE_549 BOUND_VARIABLE_550)) (nullable.some 10) ((_ tuple.select 3) t)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_549 Int) (BOUND_VARIABLE_550 Int)) (* BOUND_VARIABLE_549 BOUND_VARIABLE_550)) (nullable.some 10) ((_ tuple.select 3) t)))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_567 String) (BOUND_VARIABLE_568 String)) (= BOUND_VARIABLE_567 BOUND_VARIABLE_568)) (nullable.lift (lambda ((BOUND_VARIABLE_562 String)) (str.to_upper BOUND_VARIABLE_562)) ((_ tuple.select 1) t)) (nullable.some "FOO"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_567 String) (BOUND_VARIABLE_568 String)) (= BOUND_VARIABLE_567 BOUND_VARIABLE_568)) (nullable.lift (lambda ((BOUND_VARIABLE_562 String)) (str.to_upper BOUND_VARIABLE_562)) ((_ tuple.select 1) t)) (nullable.some "FOO"))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_581 Bool) (BOUND_VARIABLE_582 Bool)) (and BOUND_VARIABLE_581 BOUND_VARIABLE_582)) (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_549 Int) (BOUND_VARIABLE_550 Int)) (* BOUND_VARIABLE_549 BOUND_VARIABLE_550)) (nullable.some 10) ((_ tuple.select 3) t))) (nullable.lift (lambda ((BOUND_VARIABLE_567 String) (BOUND_VARIABLE_568 String)) (= BOUND_VARIABLE_567 BOUND_VARIABLE_568)) (nullable.lift (lambda ((BOUND_VARIABLE_562 String)) (str.to_upper BOUND_VARIABLE_562)) ((_ tuple.select 1) t)) (nullable.some "FOO")))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_549 Int) (BOUND_VARIABLE_550 Int)) (* BOUND_VARIABLE_549 BOUND_VARIABLE_550)) (nullable.some 10) ((_ tuple.select 3) t)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_549 Int) (BOUND_VARIABLE_550 Int)) (* BOUND_VARIABLE_549 BOUND_VARIABLE_550)) (nullable.some 10) ((_ tuple.select 3) t)))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_567 String) (BOUND_VARIABLE_568 String)) (= BOUND_VARIABLE_567 BOUND_VARIABLE_568)) (nullable.lift (lambda ((BOUND_VARIABLE_562 String)) (str.to_upper BOUND_VARIABLE_562)) ((_ tuple.select 1) t)) (nullable.some "FOO"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_567 String) (BOUND_VARIABLE_568 String)) (= BOUND_VARIABLE_567 BOUND_VARIABLE_568)) (nullable.lift (lambda ((BOUND_VARIABLE_562 String)) (str.to_upper BOUND_VARIABLE_562)) ((_ tuple.select 1) t)) (nullable.some "FOO"))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_581 Bool) (BOUND_VARIABLE_582 Bool)) (and BOUND_VARIABLE_581 BOUND_VARIABLE_582)) (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 2) t) (nullable.lift (lambda ((BOUND_VARIABLE_549 Int) (BOUND_VARIABLE_550 Int)) (* BOUND_VARIABLE_549 BOUND_VARIABLE_550)) (nullable.some 10) ((_ tuple.select 3) t))) (nullable.lift (lambda ((BOUND_VARIABLE_567 String) (BOUND_VARIABLE_568 String)) (= BOUND_VARIABLE_567 BOUND_VARIABLE_568)) (nullable.lift (lambda ((BOUND_VARIABLE_562 String)) (str.to_upper BOUND_VARIABLE_562)) ((_ tuple.select 1) t)) (nullable.some "FOO"))))))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_601 Int) (BOUND_VARIABLE_602 Int)) (+ BOUND_VARIABLE_601 BOUND_VARIABLE_602)) ((_ tuple.select 0) t) ((_ tuple.select 4) t))))))
(assert (= q1 (set.map f1 (set.filter p0 EMP))))
(assert (= q2 (set.map f3 (set.filter p2 ((_ rel.project 0 1 6 5 7) EMP)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 20036 ms.
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_469 Int) (BOUND_VARIABLE_470 Int)) (= BOUND_VARIABLE_469 BOUND_VARIABLE_470)) ((_ tuple.select 0) t) ((_ tuple.select 2) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_469 Int) (BOUND_VARIABLE_470 Int)) (= BOUND_VARIABLE_469 BOUND_VARIABLE_470)) ((_ tuple.select 0) t) ((_ tuple.select 2) t)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_504 Int) (BOUND_VARIABLE_505 Int)) (<= BOUND_VARIABLE_504 BOUND_VARIABLE_505)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_504 Int) (BOUND_VARIABLE_505 Int)) (<= BOUND_VARIABLE_504 BOUND_VARIABLE_505)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_522 Int) (BOUND_VARIABLE_523 Int)) (<= BOUND_VARIABLE_522 BOUND_VARIABLE_523)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_522 Int) (BOUND_VARIABLE_523 Int)) (<= BOUND_VARIABLE_522 BOUND_VARIABLE_523)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_543 Int) (BOUND_VARIABLE_544 Int)) (= BOUND_VARIABLE_543 BOUND_VARIABLE_544)) ((_ tuple.select 0) t) ((_ tuple.select 2) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_543 Int) (BOUND_VARIABLE_544 Int)) (= BOUND_VARIABLE_543 BOUND_VARIABLE_544)) ((_ tuple.select 0) t) ((_ tuple.select 2) t)))))))
(assert (= q1 ((_ rel.project 0 1 2) (set.filter p1 (set.filter p0 (rel.product DEPT ((_ rel.project 7) EMP)))))))
(assert (= q2 ((_ rel.project 0 1 2) (set.filter p3 (rel.product ((_ rel.project 0 1) (set.filter p2 DEPT)) ((_ rel.project 7) EMP))))))
(check-sat)
;answer: unsat
; duration: 280 ms.
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_465 Int) (BOUND_VARIABLE_466 Int)) (> BOUND_VARIABLE_465 BOUND_VARIABLE_466)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_465 Int) (BOUND_VARIABLE_466 Int)) (> BOUND_VARIABLE_465 BOUND_VARIABLE_466)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_486 Int) (BOUND_VARIABLE_487 Int)) (> BOUND_VARIABLE_486 BOUND_VARIABLE_487)) ((_ tuple.select 7) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_486 Int) (BOUND_VARIABLE_487 Int)) (> BOUND_VARIABLE_486 BOUND_VARIABLE_487)) ((_ tuple.select 7) t) (nullable.some 1)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_547 Int) (BOUND_VARIABLE_548 Int)) (= BOUND_VARIABLE_547 BOUND_VARIABLE_548)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_547 Int) (BOUND_VARIABLE_548 Int)) (= BOUND_VARIABLE_547 BOUND_VARIABLE_548)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_572 Int) (BOUND_VARIABLE_573 Int)) (> BOUND_VARIABLE_572 BOUND_VARIABLE_573)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_572 Int) (BOUND_VARIABLE_573 Int)) (> BOUND_VARIABLE_572 BOUND_VARIABLE_573)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_589 Int) (BOUND_VARIABLE_590 Int)) (> BOUND_VARIABLE_589 BOUND_VARIABLE_590)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_589 Int) (BOUND_VARIABLE_590 Int)) (> BOUND_VARIABLE_589 BOUND_VARIABLE_590)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_608 Int) (BOUND_VARIABLE_609 Int)) (> BOUND_VARIABLE_608 BOUND_VARIABLE_609)) ((_ tuple.select 7) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_608 Int) (BOUND_VARIABLE_609 Int)) (> BOUND_VARIABLE_608 BOUND_VARIABLE_609)) ((_ tuple.select 7) t) (nullable.some 1)))))))
(assert (= p8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_626 Int) (BOUND_VARIABLE_627 Int)) (> BOUND_VARIABLE_626 BOUND_VARIABLE_627)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_626 Int) (BOUND_VARIABLE_627 Int)) (> BOUND_VARIABLE_626 BOUND_VARIABLE_627)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_632 Int) (BOUND_VARIABLE_633 Int)) (> BOUND_VARIABLE_632 BOUND_VARIABLE_633)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_632 Int) (BOUND_VARIABLE_633 Int)) (> BOUND_VARIABLE_632 BOUND_VARIABLE_633)) ((_ tuple.select 7) t) (nullable.some 10)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_651 Bool) (BOUND_VARIABLE_652 Bool) (BOUND_VARIABLE_653 Bool)) (or BOUND_VARIABLE_651 BOUND_VARIABLE_652 BOUND_VARIABLE_653)) (nullable.lift (lambda ((BOUND_VARIABLE_626 Int) (BOUND_VARIABLE_627 Int)) (> BOUND_VARIABLE_626 BOUND_VARIABLE_627)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_632 Int) (BOUND_VARIABLE_633 Int)) (> BOUND_VARIABLE_632 BOUND_VARIABLE_633)) ((_ tuple.select 7) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_638 Int) (BOUND_VARIABLE_639 Int)) (> BOUND_VARIABLE_638 BOUND_VARIABLE_639)) ((_ tuple.select 7) t) (nullable.some 1)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_626 Int) (BOUND_VARIABLE_627 Int)) (> BOUND_VARIABLE_626 BOUND_VARIABLE_627)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_626 Int) (BOUND_VARIABLE_627 Int)) (> BOUND_VARIABLE_626 BOUND_VARIABLE_627)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_632 Int) (BOUND_VARIABLE_633 Int)) (> BOUND_VARIABLE_632 BOUND_VARIABLE_633)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_632 Int) (BOUND_VARIABLE_633 Int)) (> BOUND_VARIABLE_632 BOUND_VARIABLE_633)) ((_ tuple.select 7) t) (nullable.some 10)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_651 Bool) (BOUND_VARIABLE_652 Bool) (BOUND_VARIABLE_653 Bool)) (or BOUND_VARIABLE_651 BOUND_VARIABLE_652 BOUND_VARIABLE_653)) (nullable.lift (lambda ((BOUND_VARIABLE_626 Int) (BOUND_VARIABLE_627 Int)) (> BOUND_VARIABLE_626 BOUND_VARIABLE_627)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_632 Int) (BOUND_VARIABLE_633 Int)) (> BOUND_VARIABLE_632 BOUND_VARIABLE_633)) ((_ tuple.select 7) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_638 Int) (BOUND_VARIABLE_639 Int)) (> BOUND_VARIABLE_638 BOUND_VARIABLE_639)) ((_ tuple.select 7) t) (nullable.some 1))))))))))
(assert (= p9 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_675 Int) (BOUND_VARIABLE_676 Int)) (= BOUND_VARIABLE_675 BOUND_VARIABLE_676)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_675 Int) (BOUND_VARIABLE_676 Int)) (= BOUND_VARIABLE_675 BOUND_VARIABLE_676)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f10 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f4 (set.filter p3 (rel.product (set.union ((_ rel.project 0) (set.union ((_ rel.project 7) (set.filter p0 EMP)) ((_ rel.project 7) (set.filter p1 EMP)))) ((_ rel.project 7) (set.filter p2 EMP))) EMP)))))
(assert (= q2 (set.map f10 (set.filter p9 (rel.product (set.union ((_ rel.project 0) (set.union ((_ rel.project 7) (set.filter p5 EMP)) ((_ rel.project 7) (set.filter p6 EMP)))) ((_ rel.project 7) (set.filter p7 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p8 EMP)))))))
(check-sat)
;answer: unsat
; duration: 551 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const rightJoin2 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const rightJoin5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_507 Int) (BOUND_VARIABLE_508 Int)) (= BOUND_VARIABLE_507 BOUND_VARIABLE_508)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_507 Int) (BOUND_VARIABLE_508 Int)) (= BOUND_VARIABLE_507 BOUND_VARIABLE_508)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_628 Int) (BOUND_VARIABLE_629 Int)) (= BOUND_VARIABLE_628 BOUND_VARIABLE_629)) ((_ tuple.select 7) t) ((_ tuple.select 11) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_628 Int) (BOUND_VARIABLE_629 Int)) (= BOUND_VARIABLE_628 BOUND_VARIABLE_629)) ((_ tuple.select 7) t) ((_ tuple.select 11) t)))))))
(assert (= rightJoin5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map rightJoin2 (set.minus DEPT ((_ rel.project 9 10) (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) DEPT))))) (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) DEPT))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map rightJoin5 (set.minus (set.map f3 DEPT) ((_ rel.project 9 10 11) (set.filter p4 (rel.product (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.singleton (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.singleton (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0))))) (set.map f3 DEPT)))))) (set.filter p4 (rel.product (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.singleton (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.singleton (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0))))) (set.map f3 DEPT)))))))
(check-sat)
;answer: unsat
; duration: 250 ms.
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_518 Int) (BOUND_VARIABLE_519 Int)) (= BOUND_VARIABLE_518 BOUND_VARIABLE_519)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_518 Int) (BOUND_VARIABLE_519 Int)) (= BOUND_VARIABLE_518 BOUND_VARIABLE_519)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (> BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 16) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_559 Int) (BOUND_VARIABLE_560 Int)) (> BOUND_VARIABLE_559 BOUND_VARIABLE_560)) ((_ tuple.select 16) t) (nullable.some 9)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_596 Int) (BOUND_VARIABLE_597 Int)) (> BOUND_VARIABLE_596 BOUND_VARIABLE_597)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_596 Int) (BOUND_VARIABLE_597 Int)) (> BOUND_VARIABLE_596 BOUND_VARIABLE_597)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_613 Int) (BOUND_VARIABLE_614 Int)) (> BOUND_VARIABLE_613 BOUND_VARIABLE_614)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_613 Int) (BOUND_VARIABLE_614 Int)) (> BOUND_VARIABLE_613 BOUND_VARIABLE_614)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_632 Int) (BOUND_VARIABLE_633 Int)) (= BOUND_VARIABLE_632 BOUND_VARIABLE_633)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_632 Int) (BOUND_VARIABLE_633 Int)) (= BOUND_VARIABLE_632 BOUND_VARIABLE_633)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= leftJoin8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= p9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_667 Int) (BOUND_VARIABLE_668 Int)) (> BOUND_VARIABLE_667 BOUND_VARIABLE_668)) ((_ tuple.select 16) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_667 Int) (BOUND_VARIABLE_668 Int)) (> BOUND_VARIABLE_667 BOUND_VARIABLE_668)) ((_ tuple.select 16) t) (nullable.some 9)))))))
(assert (= f10 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f4 (set.filter p3 (set.union (set.map leftJoin2 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) EMP))))) (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) EMP)))))))
(assert (= q2 (set.map f10 (set.filter p9 (set.union (set.map leftJoin8 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p7 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 EMP))))))) (set.filter p7 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 EMP)))))))))
(check-sat)
;answer: unsat
; duration: 1365 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const q1 (Set (Tuple (Nullable Bool))))
(declare-const q2 (Set (Tuple (Nullable Bool))))
(declare-const f0 (-> (Tuple (Nullable Int)) (Tuple (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable Int)) (Tuple (Nullable Bool))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int)))) (tuple (nullable.some false)))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int)))) (tuple (nullable.some false)))))
(assert (= q1 (set.map f0 (set.singleton (tuple (nullable.some 0))))))
(assert (= q2 (set.map f1 (set.singleton (tuple (nullable.some 0))))))
(check-sat)
;answer: unsat
; duration: 30 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= q1 ((_ rel.project 6) (rel.product EMP (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP) ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP))))))
(assert (= q2 ((_ rel.project 6) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) (rel.product EMP EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) (rel.product EMP EMP))))))
(check-sat)
;answer: unsat
; duration: 141 ms.
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_551 String) (BOUND_VARIABLE_552 String)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_551 String) (BOUND_VARIABLE_552 String)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 1) t) (nullable.some "Charlie"))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_561 Int) (BOUND_VARIABLE_562 Int)) (> BOUND_VARIABLE_561 BOUND_VARIABLE_562)) ((_ tuple.select 8) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_561 Int) (BOUND_VARIABLE_562 Int)) (> BOUND_VARIABLE_561 BOUND_VARIABLE_562)) ((_ tuple.select 8) t) (nullable.some 100))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_576 Bool) (BOUND_VARIABLE_577 Bool)) (and BOUND_VARIABLE_576 BOUND_VARIABLE_577)) (nullable.lift (lambda ((BOUND_VARIABLE_551 String) (BOUND_VARIABLE_552 String)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 1) t) (nullable.some "Charlie")) (nullable.lift (lambda ((BOUND_VARIABLE_561 Int) (BOUND_VARIABLE_562 Int)) (> BOUND_VARIABLE_561 BOUND_VARIABLE_562)) ((_ tuple.select 8) t) (nullable.some 100)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_551 String) (BOUND_VARIABLE_552 String)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_551 String) (BOUND_VARIABLE_552 String)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 1) t) (nullable.some "Charlie"))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_561 Int) (BOUND_VARIABLE_562 Int)) (> BOUND_VARIABLE_561 BOUND_VARIABLE_562)) ((_ tuple.select 8) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_561 Int) (BOUND_VARIABLE_562 Int)) (> BOUND_VARIABLE_561 BOUND_VARIABLE_562)) ((_ tuple.select 8) t) (nullable.some 100))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_576 Bool) (BOUND_VARIABLE_577 Bool)) (and BOUND_VARIABLE_576 BOUND_VARIABLE_577)) (nullable.lift (lambda ((BOUND_VARIABLE_551 String) (BOUND_VARIABLE_552 String)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 1) t) (nullable.some "Charlie")) (nullable.lift (lambda ((BOUND_VARIABLE_561 Int) (BOUND_VARIABLE_562 Int)) (> BOUND_VARIABLE_561 BOUND_VARIABLE_562)) ((_ tuple.select 8) t) (nullable.some 100))))))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_616 String) (BOUND_VARIABLE_617 String)) (= BOUND_VARIABLE_616 BOUND_VARIABLE_617)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_616 String) (BOUND_VARIABLE_617 String)) (= BOUND_VARIABLE_616 BOUND_VARIABLE_617)) ((_ tuple.select 1) t) (nullable.some "Charlie")))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_634 Int) (BOUND_VARIABLE_635 Int)) (> BOUND_VARIABLE_634 BOUND_VARIABLE_635)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_634 Int) (BOUND_VARIABLE_635 Int)) (> BOUND_VARIABLE_634 BOUND_VARIABLE_635)) ((_ tuple.select 6) t) (nullable.some 100)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_655 Int) (BOUND_VARIABLE_656 Int)) (= BOUND_VARIABLE_655 BOUND_VARIABLE_656)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_655 Int) (BOUND_VARIABLE_656 Int)) (= BOUND_VARIABLE_655 BOUND_VARIABLE_656)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f4 (set.filter p3 (set.union (set.union (set.map leftJoin1 (set.minus DEPT ((_ rel.project 0 1) (set.filter p0 (rel.product DEPT EMP))))) (set.map rightJoin2 (set.minus EMP ((_ rel.project 2 3 4 5 6 7 8 9 10) (set.filter p0 (rel.product DEPT EMP)))))) (set.filter p0 (rel.product DEPT EMP)))))))
(assert (= q2 (set.map f8 (set.filter p7 (rel.product ((_ rel.project 0 1) (set.filter p5 DEPT)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 EMP)))))))
(check-sat)
;answer: unsat
; duration: 865 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (or (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_444 Int) (BOUND_VARIABLE_445 Int)) (= BOUND_VARIABLE_444 BOUND_VARIABLE_445)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_444 Int) (BOUND_VARIABLE_445 Int)) (= BOUND_VARIABLE_444 BOUND_VARIABLE_445)) ((_ tuple.select 6) t) (nullable.some 1000)))) (as nullable.null (Nullable Int)) (nullable.some 1))) (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_467 Int) (BOUND_VARIABLE_468 Int)) (= BOUND_VARIABLE_467 BOUND_VARIABLE_468)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_467 Int) (BOUND_VARIABLE_468 Int)) (= BOUND_VARIABLE_467 BOUND_VARIABLE_468)) ((_ tuple.select 6) t) (nullable.some 2000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (= BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (= BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_508 Int) (BOUND_VARIABLE_509 Int)) (= BOUND_VARIABLE_508 BOUND_VARIABLE_509)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_508 Int) (BOUND_VARIABLE_509 Int)) (= BOUND_VARIABLE_508 BOUND_VARIABLE_509)) ((_ tuple.select 6) t) (nullable.some 2000)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_521 Bool) (BOUND_VARIABLE_522 Bool)) (or BOUND_VARIABLE_521 BOUND_VARIABLE_522)) (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (= BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000)) (nullable.lift (lambda ((BOUND_VARIABLE_508 Int) (BOUND_VARIABLE_509 Int)) (= BOUND_VARIABLE_508 BOUND_VARIABLE_509)) ((_ tuple.select 6) t) (nullable.some 2000)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (= BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (= BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_508 Int) (BOUND_VARIABLE_509 Int)) (= BOUND_VARIABLE_508 BOUND_VARIABLE_509)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_508 Int) (BOUND_VARIABLE_509 Int)) (= BOUND_VARIABLE_508 BOUND_VARIABLE_509)) ((_ tuple.select 6) t) (nullable.some 2000)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_521 Bool) (BOUND_VARIABLE_522 Bool)) (or BOUND_VARIABLE_521 BOUND_VARIABLE_522)) (nullable.lift (lambda ((BOUND_VARIABLE_502 Int) (BOUND_VARIABLE_503 Int)) (= BOUND_VARIABLE_502 BOUND_VARIABLE_503)) ((_ tuple.select 6) t) (nullable.some 1000)) (nullable.lift (lambda ((BOUND_VARIABLE_508 Int) (BOUND_VARIABLE_509 Int)) (= BOUND_VARIABLE_508 BOUND_VARIABLE_509)) ((_ tuple.select 6) t) (nullable.some 2000))))))))))
(assert (= q1 ((_ rel.project 6) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 6) (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 133 ms.
(reset)
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (= BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (= BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))
(assert (= q2 (set.union (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))
(check-sat)
;answer: unsat
; duration: 403 ms.
(reset)
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
(set-option :tlimit-per 20000)
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_530 Int) (BOUND_VARIABLE_531 Int)) (> BOUND_VARIABLE_530 BOUND_VARIABLE_531)) ((_ tuple.select 8) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_530 Int) (BOUND_VARIABLE_531 Int)) (> BOUND_VARIABLE_530 BOUND_VARIABLE_531)) ((_ tuple.select 8) t) (nullable.some 100)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_567 Int) (BOUND_VARIABLE_568 Int)) (> BOUND_VARIABLE_567 BOUND_VARIABLE_568)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_567 Int) (BOUND_VARIABLE_568 Int)) (> BOUND_VARIABLE_567 BOUND_VARIABLE_568)) ((_ tuple.select 6) t) (nullable.some 100)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_588 Int) (BOUND_VARIABLE_589 Int)) (= BOUND_VARIABLE_588 BOUND_VARIABLE_589)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_588 Int) (BOUND_VARIABLE_589 Int)) (= BOUND_VARIABLE_588 BOUND_VARIABLE_589)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f3 (set.filter p2 (set.union (set.map leftJoin1 (set.minus DEPT ((_ rel.project 0 1) (set.filter p0 (rel.product DEPT EMP))))) (set.filter p0 (rel.product DEPT EMP)))))))
(assert (= q2 (set.map f6 (set.filter p5 (rel.product DEPT ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)))))))
(check-sat)
;answer: unsat
; duration: 288 ms.
(reset)
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_390 Int) (BOUND_VARIABLE_391 Int)) (> BOUND_VARIABLE_390 BOUND_VARIABLE_391)) ((_ tuple.select 0) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_390 Int) (BOUND_VARIABLE_391 Int)) (> BOUND_VARIABLE_390 BOUND_VARIABLE_391)) ((_ tuple.select 0) t) (nullable.some 30)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_441 Int) (BOUND_VARIABLE_442 Int)) (> BOUND_VARIABLE_441 BOUND_VARIABLE_442)) ((_ tuple.select 0) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_441 Int) (BOUND_VARIABLE_442 Int)) (> BOUND_VARIABLE_441 BOUND_VARIABLE_442)) ((_ tuple.select 0) t) (nullable.some 50)))))))
(assert (= q1 (set.minus ((_ rel.project 0 1) (set.minus ((_ rel.project 0 1) (set.minus ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 30) (nullable.some 3)))) ((_ rel.project 0 1) (set.filter p0 (set.singleton (tuple (nullable.some 20) (nullable.some 2))))))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 40) (nullable.some 4)))))) ((_ rel.project 0 1) (set.filter p1 (set.singleton (tuple (nullable.some 50) (nullable.some 5))))))))
(assert (= q2 (set.minus ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 30) (nullable.some 3)))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 40) (nullable.some 4)))))))
(check-sat)
;answer: unsat
; duration: 13 ms.
(reset)
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
(set-option :tlimit-per 20000)
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
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 6) t) ((_ tuple.select 5) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_520 Int) (BOUND_VARIABLE_521 Int)) (+ BOUND_VARIABLE_520 BOUND_VARIABLE_521)) ((_ tuple.select 7) t) (nullable.lift (lambda ((BOUND_VARIABLE_513 Int) (BOUND_VARIABLE_514 Int)) (- BOUND_VARIABLE_513 BOUND_VARIABLE_514)) (nullable.some 5) (nullable.some 5)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_588 Int) (BOUND_VARIABLE_589 Int)) (= BOUND_VARIABLE_588 BOUND_VARIABLE_589)) ((_ tuple.select 2) t) ((_ tuple.select 12) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_588 Int) (BOUND_VARIABLE_589 Int)) (= BOUND_VARIABLE_588 BOUND_VARIABLE_589)) ((_ tuple.select 2) t) ((_ tuple.select 12) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_676 Int) (BOUND_VARIABLE_677 Int)) (= BOUND_VARIABLE_676 BOUND_VARIABLE_677)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_670 Int) (BOUND_VARIABLE_671 Int)) (+ BOUND_VARIABLE_670 BOUND_VARIABLE_671)) (nullable.some 7) (nullable.some 8)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_676 Int) (BOUND_VARIABLE_677 Int)) (= BOUND_VARIABLE_676 BOUND_VARIABLE_677)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_670 Int) (BOUND_VARIABLE_671 Int)) (+ BOUND_VARIABLE_670 BOUND_VARIABLE_671)) (nullable.some 7) (nullable.some 8)))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_688 Int) (BOUND_VARIABLE_689 Int)) (= BOUND_VARIABLE_688 BOUND_VARIABLE_689)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_682 Int) (BOUND_VARIABLE_683 Int)) (+ BOUND_VARIABLE_682 BOUND_VARIABLE_683)) (nullable.some 8) (nullable.some 7)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_688 Int) (BOUND_VARIABLE_689 Int)) (= BOUND_VARIABLE_688 BOUND_VARIABLE_689)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_682 Int) (BOUND_VARIABLE_683 Int)) (+ BOUND_VARIABLE_682 BOUND_VARIABLE_683)) (nullable.some 8) (nullable.some 7)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_717 Bool) (BOUND_VARIABLE_718 Bool) (BOUND_VARIABLE_719 Bool)) (and BOUND_VARIABLE_717 BOUND_VARIABLE_718 BOUND_VARIABLE_719)) (nullable.lift (lambda ((BOUND_VARIABLE_676 Int) (BOUND_VARIABLE_677 Int)) (= BOUND_VARIABLE_676 BOUND_VARIABLE_677)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_670 Int) (BOUND_VARIABLE_671 Int)) (+ BOUND_VARIABLE_670 BOUND_VARIABLE_671)) (nullable.some 7) (nullable.some 8))) (nullable.lift (lambda ((BOUND_VARIABLE_688 Int) (BOUND_VARIABLE_689 Int)) (= BOUND_VARIABLE_688 BOUND_VARIABLE_689)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_682 Int) (BOUND_VARIABLE_683 Int)) (+ BOUND_VARIABLE_682 BOUND_VARIABLE_683)) (nullable.some 8) (nullable.some 7))) (nullable.lift (lambda ((BOUND_VARIABLE_702 Int) (BOUND_VARIABLE_703 Int)) (= BOUND_VARIABLE_702 BOUND_VARIABLE_703)) ((_ tuple.select 0) t) (ite (and (nullable.is_some (nullable.some (nullable.is_some (nullable.some 2)))) (nullable.val (nullable.some (nullable.is_some (nullable.some 2))))) (nullable.some 2) (as nullable.null (Nullable Int)))))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_676 Int) (BOUND_VARIABLE_677 Int)) (= BOUND_VARIABLE_676 BOUND_VARIABLE_677)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_670 Int) (BOUND_VARIABLE_671 Int)) (+ BOUND_VARIABLE_670 BOUND_VARIABLE_671)) (nullable.some 7) (nullable.some 8)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_676 Int) (BOUND_VARIABLE_677 Int)) (= BOUND_VARIABLE_676 BOUND_VARIABLE_677)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_670 Int) (BOUND_VARIABLE_671 Int)) (+ BOUND_VARIABLE_670 BOUND_VARIABLE_671)) (nullable.some 7) (nullable.some 8)))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_688 Int) (BOUND_VARIABLE_689 Int)) (= BOUND_VARIABLE_688 BOUND_VARIABLE_689)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_682 Int) (BOUND_VARIABLE_683 Int)) (+ BOUND_VARIABLE_682 BOUND_VARIABLE_683)) (nullable.some 8) (nullable.some 7)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_688 Int) (BOUND_VARIABLE_689 Int)) (= BOUND_VARIABLE_688 BOUND_VARIABLE_689)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_682 Int) (BOUND_VARIABLE_683 Int)) (+ BOUND_VARIABLE_682 BOUND_VARIABLE_683)) (nullable.some 8) (nullable.some 7)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_717 Bool) (BOUND_VARIABLE_718 Bool) (BOUND_VARIABLE_719 Bool)) (and BOUND_VARIABLE_717 BOUND_VARIABLE_718 BOUND_VARIABLE_719)) (nullable.lift (lambda ((BOUND_VARIABLE_676 Int) (BOUND_VARIABLE_677 Int)) (= BOUND_VARIABLE_676 BOUND_VARIABLE_677)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_670 Int) (BOUND_VARIABLE_671 Int)) (+ BOUND_VARIABLE_670 BOUND_VARIABLE_671)) (nullable.some 7) (nullable.some 8))) (nullable.lift (lambda ((BOUND_VARIABLE_688 Int) (BOUND_VARIABLE_689 Int)) (= BOUND_VARIABLE_688 BOUND_VARIABLE_689)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_682 Int) (BOUND_VARIABLE_683 Int)) (+ BOUND_VARIABLE_682 BOUND_VARIABLE_683)) (nullable.some 8) (nullable.some 7))) (nullable.lift (lambda ((BOUND_VARIABLE_702 Int) (BOUND_VARIABLE_703 Int)) (= BOUND_VARIABLE_702 BOUND_VARIABLE_703)) ((_ tuple.select 0) t) (ite (and (nullable.is_some (nullable.some (nullable.is_some (nullable.some 2)))) (nullable.val (nullable.some (nullable.is_some (nullable.some 2))))) (nullable.some 2) (as nullable.null (Nullable Int))))))))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_764 Int) (BOUND_VARIABLE_765 Int)) (+ BOUND_VARIABLE_764 BOUND_VARIABLE_765)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_781 Int) (BOUND_VARIABLE_782 Int)) (+ BOUND_VARIABLE_781 BOUND_VARIABLE_782)) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_775 Int) (BOUND_VARIABLE_776 Int)) (+ BOUND_VARIABLE_775 BOUND_VARIABLE_776)) (nullable.some 3) (nullable.some 4))) (nullable.lift (lambda ((BOUND_VARIABLE_795 Int) (BOUND_VARIABLE_796 Int)) (+ BOUND_VARIABLE_795 BOUND_VARIABLE_796)) (nullable.lift (lambda ((BOUND_VARIABLE_789 Int) (BOUND_VARIABLE_790 Int)) (+ BOUND_VARIABLE_789 BOUND_VARIABLE_790)) (nullable.some 5) (nullable.some 6)) ((_ tuple.select 0) t)) (as nullable.null (Nullable Int)) (nullable.some 2) (nullable.lift (lambda ((BOUND_VARIABLE_801 Int) (BOUND_VARIABLE_802 Int)) (+ BOUND_VARIABLE_801 BOUND_VARIABLE_802)) (nullable.some 7) (nullable.some 8))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 3) (nullable.some 22) (nullable.some 26) (as nullable.null (Nullable Int)) (nullable.some 2) (nullable.some 15)))))
(assert (= q1 (set.map f4 (set.filter p3 ((_ rel.project 0 1 3 4 5 6 7 8 9 10 11) (set.filter p2 (rel.product (set.map f0 DEPT) (set.map f1 EMP))))))))
(assert (= q2 (set.map f6 (set.filter p5 (set.singleton (tuple (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0)))))))
(check-sat)
;answer: unsat
; duration: 35 ms.
(reset)
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_512 Int) (BOUND_VARIABLE_513 Int)) (= BOUND_VARIABLE_512 BOUND_VARIABLE_513)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_512 Int) (BOUND_VARIABLE_513 Int)) (= BOUND_VARIABLE_512 BOUND_VARIABLE_513)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_536 Int) (BOUND_VARIABLE_537 Int)) (= BOUND_VARIABLE_536 BOUND_VARIABLE_537)) ((_ tuple.select 11) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_536 Int) (BOUND_VARIABLE_537 Int)) (= BOUND_VARIABLE_536 BOUND_VARIABLE_537)) ((_ tuple.select 11) t) (nullable.some 10))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_551 Bool) (BOUND_VARIABLE_552 Bool)) (and BOUND_VARIABLE_551 BOUND_VARIABLE_552)) (nullable.lift (lambda ((BOUND_VARIABLE_512 Int) (BOUND_VARIABLE_513 Int)) (= BOUND_VARIABLE_512 BOUND_VARIABLE_513)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_536 Int) (BOUND_VARIABLE_537 Int)) (= BOUND_VARIABLE_536 BOUND_VARIABLE_537)) ((_ tuple.select 11) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_512 Int) (BOUND_VARIABLE_513 Int)) (= BOUND_VARIABLE_512 BOUND_VARIABLE_513)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_512 Int) (BOUND_VARIABLE_513 Int)) (= BOUND_VARIABLE_512 BOUND_VARIABLE_513)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_536 Int) (BOUND_VARIABLE_537 Int)) (= BOUND_VARIABLE_536 BOUND_VARIABLE_537)) ((_ tuple.select 11) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_536 Int) (BOUND_VARIABLE_537 Int)) (= BOUND_VARIABLE_536 BOUND_VARIABLE_537)) ((_ tuple.select 11) t) (nullable.some 10))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_551 Bool) (BOUND_VARIABLE_552 Bool)) (and BOUND_VARIABLE_551 BOUND_VARIABLE_552)) (nullable.lift (lambda ((BOUND_VARIABLE_512 Int) (BOUND_VARIABLE_513 Int)) (= BOUND_VARIABLE_512 BOUND_VARIABLE_513)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_536 Int) (BOUND_VARIABLE_537 Int)) (= BOUND_VARIABLE_536 BOUND_VARIABLE_537)) ((_ tuple.select 11) t) (nullable.some 10))))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_574 Int) (BOUND_VARIABLE_575 Int)) (= BOUND_VARIABLE_574 BOUND_VARIABLE_575)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_574 Int) (BOUND_VARIABLE_575 Int)) (= BOUND_VARIABLE_574 BOUND_VARIABLE_575)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (= BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (= BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_656 Int) (BOUND_VARIABLE_657 Int)) (= BOUND_VARIABLE_656 BOUND_VARIABLE_657)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_656 Int) (BOUND_VARIABLE_657 Int)) (= BOUND_VARIABLE_656 BOUND_VARIABLE_657)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p2 ((_ rel.project 9 1) (set.filter p1 (rel.product EMP (set.map f0 DEPT))))))))
(assert (= q2 ((_ rel.project 9 1) (set.filter p4 (rel.product EMP ((_ rel.project 0 1) (set.filter p3 DEPT)))))))
(check-sat)
;answer: unsat
; duration: 283 ms.
(reset)
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (= BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (= BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))
(assert (= q2 (set.union (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))
(check-sat)
;answer: unsat
; duration: 407 ms.
(reset)
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_461 Bool) (BOUND_VARIABLE_462 Bool) (BOUND_VARIABLE_463 Bool)) (or BOUND_VARIABLE_461 BOUND_VARIABLE_462 BOUND_VARIABLE_463)) (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_448 Int) (BOUND_VARIABLE_449 Int)) (> BOUND_VARIABLE_448 BOUND_VARIABLE_449)) ((_ tuple.select 5) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_461 Bool) (BOUND_VARIABLE_462 Bool) (BOUND_VARIABLE_463 Bool)) (or BOUND_VARIABLE_461 BOUND_VARIABLE_462 BOUND_VARIABLE_463)) (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_448 Int) (BOUND_VARIABLE_449 Int)) (> BOUND_VARIABLE_448 BOUND_VARIABLE_449)) ((_ tuple.select 5) t) (nullable.some 10))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_552 Int) (BOUND_VARIABLE_553 Int)) (= BOUND_VARIABLE_552 BOUND_VARIABLE_553)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_552 Int) (BOUND_VARIABLE_553 Int)) (= BOUND_VARIABLE_552 BOUND_VARIABLE_553)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_590 Int) (BOUND_VARIABLE_591 Int)) (= BOUND_VARIABLE_590 BOUND_VARIABLE_591)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_590 Int) (BOUND_VARIABLE_591 Int)) (= BOUND_VARIABLE_590 BOUND_VARIABLE_591)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_596 Int) (BOUND_VARIABLE_597 Int)) (= BOUND_VARIABLE_596 BOUND_VARIABLE_597)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_596 Int) (BOUND_VARIABLE_597 Int)) (= BOUND_VARIABLE_596 BOUND_VARIABLE_597)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_615 Bool) (BOUND_VARIABLE_616 Bool) (BOUND_VARIABLE_617 Bool)) (or BOUND_VARIABLE_615 BOUND_VARIABLE_616 BOUND_VARIABLE_617)) (nullable.lift (lambda ((BOUND_VARIABLE_590 Int) (BOUND_VARIABLE_591 Int)) (= BOUND_VARIABLE_590 BOUND_VARIABLE_591)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_596 Int) (BOUND_VARIABLE_597 Int)) (= BOUND_VARIABLE_596 BOUND_VARIABLE_597)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_603 Int) (BOUND_VARIABLE_604 Int)) (> BOUND_VARIABLE_603 BOUND_VARIABLE_604)) ((_ tuple.select 5) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_590 Int) (BOUND_VARIABLE_591 Int)) (= BOUND_VARIABLE_590 BOUND_VARIABLE_591)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_590 Int) (BOUND_VARIABLE_591 Int)) (= BOUND_VARIABLE_590 BOUND_VARIABLE_591)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_596 Int) (BOUND_VARIABLE_597 Int)) (= BOUND_VARIABLE_596 BOUND_VARIABLE_597)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_596 Int) (BOUND_VARIABLE_597 Int)) (= BOUND_VARIABLE_596 BOUND_VARIABLE_597)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_615 Bool) (BOUND_VARIABLE_616 Bool) (BOUND_VARIABLE_617 Bool)) (or BOUND_VARIABLE_615 BOUND_VARIABLE_616 BOUND_VARIABLE_617)) (nullable.lift (lambda ((BOUND_VARIABLE_590 Int) (BOUND_VARIABLE_591 Int)) (= BOUND_VARIABLE_590 BOUND_VARIABLE_591)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_596 Int) (BOUND_VARIABLE_597 Int)) (= BOUND_VARIABLE_596 BOUND_VARIABLE_597)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_603 Int) (BOUND_VARIABLE_604 Int)) (> BOUND_VARIABLE_603 BOUND_VARIABLE_604)) ((_ tuple.select 5) t) (nullable.some 10))))))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_637 Int) (BOUND_VARIABLE_638 Int)) (= BOUND_VARIABLE_637 BOUND_VARIABLE_638)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_637 Int) (BOUND_VARIABLE_638 Int)) (= BOUND_VARIABLE_637 BOUND_VARIABLE_638)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f2 (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) EMP)))))
(assert (= q2 (set.map f5 (set.filter p4 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) EMP)))))
(check-sat)
;answer: unsat
; duration: 457 ms.
(reset)
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_399 Int) (BOUND_VARIABLE_400 Int)) (> BOUND_VARIABLE_399 BOUND_VARIABLE_400)) (nullable.lift (lambda ((BOUND_VARIABLE_389 Int) (BOUND_VARIABLE_390 Int)) (+ BOUND_VARIABLE_389 BOUND_VARIABLE_390)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_399 Int) (BOUND_VARIABLE_400 Int)) (> BOUND_VARIABLE_399 BOUND_VARIABLE_400)) (nullable.lift (lambda ((BOUND_VARIABLE_389 Int) (BOUND_VARIABLE_390 Int)) (+ BOUND_VARIABLE_389 BOUND_VARIABLE_390)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) (nullable.some 50)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_449 Int) (BOUND_VARIABLE_450 Int)) (+ BOUND_VARIABLE_449 BOUND_VARIABLE_450)) (nullable.lift (lambda ((BOUND_VARIABLE_443 Int) (BOUND_VARIABLE_444 Int)) (+ BOUND_VARIABLE_443 BOUND_VARIABLE_444)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 0) t))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_479 Int) (BOUND_VARIABLE_480 Int)) (+ BOUND_VARIABLE_479 BOUND_VARIABLE_480)) (nullable.lift (lambda ((BOUND_VARIABLE_473 Int) (BOUND_VARIABLE_474 Int)) (+ BOUND_VARIABLE_473 BOUND_VARIABLE_474)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)) ((_ tuple.select 0) t))))))
(assert (= q1 (set.map f1 (set.filter p0 (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 30) (nullable.some 3))))))))
(assert (= q2 (set.map f2 (set.minus ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 0) (nullable.some 0)))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 0) (nullable.some 0))))))))
(check-sat)
;answer: unsat
; duration: 18 ms.
(reset)
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_460 Bool) (BOUND_VARIABLE_461 Bool) (BOUND_VARIABLE_462 Bool)) (or BOUND_VARIABLE_460 BOUND_VARIABLE_461 BOUND_VARIABLE_462)) (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_447 Int) (BOUND_VARIABLE_448 Int)) (> BOUND_VARIABLE_447 BOUND_VARIABLE_448)) ((_ tuple.select 7) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_460 Bool) (BOUND_VARIABLE_461 Bool) (BOUND_VARIABLE_462 Bool)) (or BOUND_VARIABLE_460 BOUND_VARIABLE_461 BOUND_VARIABLE_462)) (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (= BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_439 Int) (BOUND_VARIABLE_440 Int)) (= BOUND_VARIABLE_439 BOUND_VARIABLE_440)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_447 Int) (BOUND_VARIABLE_448 Int)) (> BOUND_VARIABLE_447 BOUND_VARIABLE_448)) ((_ tuple.select 7) t) (nullable.some 10))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_551 Int) (BOUND_VARIABLE_552 Int)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_551 Int) (BOUND_VARIABLE_552 Int)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_589 Int) (BOUND_VARIABLE_590 Int)) (= BOUND_VARIABLE_589 BOUND_VARIABLE_590)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_589 Int) (BOUND_VARIABLE_590 Int)) (= BOUND_VARIABLE_589 BOUND_VARIABLE_590)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_595 Int) (BOUND_VARIABLE_596 Int)) (= BOUND_VARIABLE_595 BOUND_VARIABLE_596)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_595 Int) (BOUND_VARIABLE_596 Int)) (= BOUND_VARIABLE_595 BOUND_VARIABLE_596)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_613 Bool) (BOUND_VARIABLE_614 Bool) (BOUND_VARIABLE_615 Bool)) (or BOUND_VARIABLE_613 BOUND_VARIABLE_614 BOUND_VARIABLE_615)) (nullable.lift (lambda ((BOUND_VARIABLE_589 Int) (BOUND_VARIABLE_590 Int)) (= BOUND_VARIABLE_589 BOUND_VARIABLE_590)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_595 Int) (BOUND_VARIABLE_596 Int)) (= BOUND_VARIABLE_595 BOUND_VARIABLE_596)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_601 Int) (BOUND_VARIABLE_602 Int)) (> BOUND_VARIABLE_601 BOUND_VARIABLE_602)) ((_ tuple.select 7) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_589 Int) (BOUND_VARIABLE_590 Int)) (= BOUND_VARIABLE_589 BOUND_VARIABLE_590)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_589 Int) (BOUND_VARIABLE_590 Int)) (= BOUND_VARIABLE_589 BOUND_VARIABLE_590)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_595 Int) (BOUND_VARIABLE_596 Int)) (= BOUND_VARIABLE_595 BOUND_VARIABLE_596)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_595 Int) (BOUND_VARIABLE_596 Int)) (= BOUND_VARIABLE_595 BOUND_VARIABLE_596)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_613 Bool) (BOUND_VARIABLE_614 Bool) (BOUND_VARIABLE_615 Bool)) (or BOUND_VARIABLE_613 BOUND_VARIABLE_614 BOUND_VARIABLE_615)) (nullable.lift (lambda ((BOUND_VARIABLE_589 Int) (BOUND_VARIABLE_590 Int)) (= BOUND_VARIABLE_589 BOUND_VARIABLE_590)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_595 Int) (BOUND_VARIABLE_596 Int)) (= BOUND_VARIABLE_595 BOUND_VARIABLE_596)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_601 Int) (BOUND_VARIABLE_602 Int)) (> BOUND_VARIABLE_601 BOUND_VARIABLE_602)) ((_ tuple.select 7) t) (nullable.some 10))))))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_633 Int) (BOUND_VARIABLE_634 Int)) (= BOUND_VARIABLE_633 BOUND_VARIABLE_634)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_633 Int) (BOUND_VARIABLE_634 Int)) (= BOUND_VARIABLE_633 BOUND_VARIABLE_634)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_639 Int) (BOUND_VARIABLE_640 Int)) (= BOUND_VARIABLE_639 BOUND_VARIABLE_640)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_639 Int) (BOUND_VARIABLE_640 Int)) (= BOUND_VARIABLE_639 BOUND_VARIABLE_640)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_657 Bool) (BOUND_VARIABLE_658 Bool) (BOUND_VARIABLE_659 Bool)) (or BOUND_VARIABLE_657 BOUND_VARIABLE_658 BOUND_VARIABLE_659)) (nullable.lift (lambda ((BOUND_VARIABLE_633 Int) (BOUND_VARIABLE_634 Int)) (= BOUND_VARIABLE_633 BOUND_VARIABLE_634)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_639 Int) (BOUND_VARIABLE_640 Int)) (= BOUND_VARIABLE_639 BOUND_VARIABLE_640)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_645 Int) (BOUND_VARIABLE_646 Int)) (> BOUND_VARIABLE_645 BOUND_VARIABLE_646)) ((_ tuple.select 7) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_633 Int) (BOUND_VARIABLE_634 Int)) (= BOUND_VARIABLE_633 BOUND_VARIABLE_634)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_633 Int) (BOUND_VARIABLE_634 Int)) (= BOUND_VARIABLE_633 BOUND_VARIABLE_634)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_639 Int) (BOUND_VARIABLE_640 Int)) (= BOUND_VARIABLE_639 BOUND_VARIABLE_640)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_639 Int) (BOUND_VARIABLE_640 Int)) (= BOUND_VARIABLE_639 BOUND_VARIABLE_640)) ((_ tuple.select 7) t) (nullable.some 9)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_657 Bool) (BOUND_VARIABLE_658 Bool) (BOUND_VARIABLE_659 Bool)) (or BOUND_VARIABLE_657 BOUND_VARIABLE_658 BOUND_VARIABLE_659)) (nullable.lift (lambda ((BOUND_VARIABLE_633 Int) (BOUND_VARIABLE_634 Int)) (= BOUND_VARIABLE_633 BOUND_VARIABLE_634)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_639 Int) (BOUND_VARIABLE_640 Int)) (= BOUND_VARIABLE_639 BOUND_VARIABLE_640)) ((_ tuple.select 7) t) (nullable.some 9)) (nullable.lift (lambda ((BOUND_VARIABLE_645 Int) (BOUND_VARIABLE_646 Int)) (> BOUND_VARIABLE_645 BOUND_VARIABLE_646)) ((_ tuple.select 7) t) (nullable.some 10))))))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_679 Int) (BOUND_VARIABLE_680 Int)) (= BOUND_VARIABLE_679 BOUND_VARIABLE_680)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_679 Int) (BOUND_VARIABLE_680 Int)) (= BOUND_VARIABLE_679 BOUND_VARIABLE_680)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f2 (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) EMP)))))
(assert (= q2 (set.map f6 (set.filter p5 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)))))))
(check-sat)
;answer: unsat
; duration: 665 ms.
(reset)
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_503 String) (BOUND_VARIABLE_504 String)) (= BOUND_VARIABLE_503 BOUND_VARIABLE_504)) ((_ tuple.select 1) t) (nullable.some "foo"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_503 String) (BOUND_VARIABLE_504 String)) (= BOUND_VARIABLE_503 BOUND_VARIABLE_504)) ((_ tuple.select 1) t) (nullable.some "foo"))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_519 Bool) (BOUND_VARIABLE_520 Bool)) (and BOUND_VARIABLE_519 BOUND_VARIABLE_520)) (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_503 String) (BOUND_VARIABLE_504 String)) (= BOUND_VARIABLE_503 BOUND_VARIABLE_504)) ((_ tuple.select 1) t) (nullable.some "foo")))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_503 String) (BOUND_VARIABLE_504 String)) (= BOUND_VARIABLE_503 BOUND_VARIABLE_504)) ((_ tuple.select 1) t) (nullable.some "foo"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_503 String) (BOUND_VARIABLE_504 String)) (= BOUND_VARIABLE_503 BOUND_VARIABLE_504)) ((_ tuple.select 1) t) (nullable.some "foo"))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_519 Bool) (BOUND_VARIABLE_520 Bool)) (and BOUND_VARIABLE_519 BOUND_VARIABLE_520)) (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_503 String) (BOUND_VARIABLE_504 String)) (= BOUND_VARIABLE_503 BOUND_VARIABLE_504)) ((_ tuple.select 1) t) (nullable.some "foo"))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (= BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_571 String) (BOUND_VARIABLE_572 String)) (= BOUND_VARIABLE_571 BOUND_VARIABLE_572)) ((_ tuple.select 1) t) (nullable.some "foo"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_571 String) (BOUND_VARIABLE_572 String)) (= BOUND_VARIABLE_571 BOUND_VARIABLE_572)) ((_ tuple.select 1) t) (nullable.some "foo")))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_614 Int) (BOUND_VARIABLE_615 Int)) (= BOUND_VARIABLE_614 BOUND_VARIABLE_615)) ((_ tuple.select 0) t) ((_ tuple.select 2) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_614 Int) (BOUND_VARIABLE_615 Int)) (= BOUND_VARIABLE_614 BOUND_VARIABLE_615)) ((_ tuple.select 0) t) ((_ tuple.select 2) t)))))))
(assert (= q1 ((_ rel.project 1) (set.filter p0 (rel.product EMP DEPT)))))
(assert (= q2 ((_ rel.project 1) (set.filter p3 (rel.product ((_ rel.project 7 1) (set.filter p2 (set.filter p1 (rel.product EMP DEPT)))) DEPT)))))
(check-sat)
;answer: unsat
; duration: 199 ms.
(reset)
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_462 Int) (BOUND_VARIABLE_463 Int)) (> BOUND_VARIABLE_462 BOUND_VARIABLE_463)) (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (+ BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 5)) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_462 Int) (BOUND_VARIABLE_463 Int)) (> BOUND_VARIABLE_462 BOUND_VARIABLE_463)) (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (+ BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 5)) ((_ tuple.select 0) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_479 Int) (BOUND_VARIABLE_480 Int)) (= BOUND_VARIABLE_479 BOUND_VARIABLE_480)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_479 Int) (BOUND_VARIABLE_480 Int)) (= BOUND_VARIABLE_479 BOUND_VARIABLE_480)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_498 Int) (BOUND_VARIABLE_499 Int)) (> BOUND_VARIABLE_498 BOUND_VARIABLE_499)) (nullable.some 15) ((_ tuple.select 0) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_498 Int) (BOUND_VARIABLE_499 Int)) (> BOUND_VARIABLE_498 BOUND_VARIABLE_499)) (nullable.some 15) ((_ tuple.select 0) t)))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP))))))
(check-sat)
;answer: unsat
; duration: 133 ms.
(reset)
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 5) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 5) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (= BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_506 Int) (BOUND_VARIABLE_507 Int)) (= BOUND_VARIABLE_506 BOUND_VARIABLE_507)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_532 Int) (BOUND_VARIABLE_533 Int)) (> BOUND_VARIABLE_532 BOUND_VARIABLE_533)) ((_ tuple.select 5) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_532 Int) (BOUND_VARIABLE_533 Int)) (> BOUND_VARIABLE_532 BOUND_VARIABLE_533)) ((_ tuple.select 5) t) (nullable.some 7)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_549 Int) (BOUND_VARIABLE_550 Int)) (> BOUND_VARIABLE_549 BOUND_VARIABLE_550)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_549 Int) (BOUND_VARIABLE_550 Int)) (> BOUND_VARIABLE_549 BOUND_VARIABLE_550)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_569 Int) (BOUND_VARIABLE_570 Int)) (= BOUND_VARIABLE_569 BOUND_VARIABLE_570)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_569 Int) (BOUND_VARIABLE_570 Int)) (= BOUND_VARIABLE_569 BOUND_VARIABLE_570)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f2 (set.filter p1 (rel.product ((_ rel.project 5) (set.filter p0 EMP)) EMP)))))
(assert (= q2 (set.map f6 (set.filter p5 (rel.product ((_ rel.project 5) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)))))))
(check-sat)
;answer: unsat
; duration: 475 ms.
(reset)
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_473 Int) (BOUND_VARIABLE_474 Int)) (= BOUND_VARIABLE_473 BOUND_VARIABLE_474)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_473 Int) (BOUND_VARIABLE_474 Int)) (= BOUND_VARIABLE_473 BOUND_VARIABLE_474)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_527 Int) (BOUND_VARIABLE_528 Int)) (= BOUND_VARIABLE_527 BOUND_VARIABLE_528)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_527 Int) (BOUND_VARIABLE_528 Int)) (= BOUND_VARIABLE_527 BOUND_VARIABLE_528)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.inter ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))))
(assert (= q2 (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.inter ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))))
(check-sat)
;answer: unsat
; duration: 173 ms.
(reset)
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (ite (and (nullable.is_some (nullable.some (nullable.is_some ((_ tuple.select 0) t)))) (not (nullable.val (nullable.some (nullable.is_some ((_ tuple.select 0) t)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_449 Bool) (BOUND_VARIABLE_450 Bool)) (and BOUND_VARIABLE_449 BOUND_VARIABLE_450)) (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some (nullable.is_some ((_ tuple.select 0) t))))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))))) (nullable.some false) (ite (and (nullable.is_some (nullable.some (nullable.is_some ((_ tuple.select 0) t)))) (not (nullable.val (nullable.some (nullable.is_some ((_ tuple.select 0) t)))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_449 Bool) (BOUND_VARIABLE_450 Bool)) (and BOUND_VARIABLE_449 BOUND_VARIABLE_450)) (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some (nullable.is_some ((_ tuple.select 0) t)))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_484 Int) (BOUND_VARIABLE_485 Int)) (= BOUND_VARIABLE_484 BOUND_VARIABLE_485)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_484 Int) (BOUND_VARIABLE_485 Int)) (= BOUND_VARIABLE_484 BOUND_VARIABLE_485)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= q1 ((_ rel.project 0) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0) (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 58 ms.
(reset)
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_393 Int) (BOUND_VARIABLE_394 Int)) (> BOUND_VARIABLE_393 BOUND_VARIABLE_394)) ((_ tuple.select 0) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_393 Int) (BOUND_VARIABLE_394 Int)) (> BOUND_VARIABLE_393 BOUND_VARIABLE_394)) ((_ tuple.select 0) t) (nullable.some 50)))))))
(assert (= q1 (set.inter ((_ rel.project 0 1) (set.inter ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 30) (nullable.some 3)))) ((_ rel.project 0 1) (set.filter p0 (set.union (set.singleton (tuple (nullable.some 10) (nullable.some 1))) (set.singleton (tuple (nullable.some 30) (nullable.some 3)))))))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 30) (nullable.some 3)))))))
(assert (= q2 ((_ rel.project 0 1) (set.minus ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 0) (nullable.some 0)))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 0) (nullable.some 0))))))))
(check-sat)
;answer: unsat
; duration: 9 ms.
(reset)
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 7) t) (nullable.lift (lambda ((BOUND_VARIABLE_467 Int) (BOUND_VARIABLE_468 Int)) (+ BOUND_VARIABLE_467 BOUND_VARIABLE_468)) ((_ tuple.select 7) t) (nullable.some 1)) (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (+ BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 0) t) ((_ tuple.select 7) t))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_491 Int) (BOUND_VARIABLE_492 Int)) (= BOUND_VARIABLE_491 BOUND_VARIABLE_492)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_491 Int) (BOUND_VARIABLE_492 Int)) (= BOUND_VARIABLE_491 BOUND_VARIABLE_492)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 10) (nullable.some 11) (nullable.lift (lambda ((BOUND_VARIABLE_509 Int) (BOUND_VARIABLE_510 Int)) (+ BOUND_VARIABLE_509 BOUND_VARIABLE_510)) ((_ tuple.select 0) t) (nullable.some 10))))))
(assert (= q1 (set.map f1 (set.filter p0 EMP))))
(assert (= q2 (set.map f3 (set.filter p2 EMP))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 20016 ms.
(reset)
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (< BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 4))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (< BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 4)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_465 Int) (BOUND_VARIABLE_466 Int)) (> BOUND_VARIABLE_465 BOUND_VARIABLE_466)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_465 Int) (BOUND_VARIABLE_466 Int)) (> BOUND_VARIABLE_465 BOUND_VARIABLE_466)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_501 Int) (BOUND_VARIABLE_502 Int)) (= BOUND_VARIABLE_501 BOUND_VARIABLE_502)) ((_ tuple.select 0) t) ((_ tuple.select 1) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_501 Int) (BOUND_VARIABLE_502 Int)) (= BOUND_VARIABLE_501 BOUND_VARIABLE_502)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_520 Int) (BOUND_VARIABLE_521 Int)) (< BOUND_VARIABLE_520 BOUND_VARIABLE_521)) ((_ tuple.select 7) t) (nullable.some 4))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_520 Int) (BOUND_VARIABLE_521 Int)) (< BOUND_VARIABLE_520 BOUND_VARIABLE_521)) ((_ tuple.select 7) t) (nullable.some 4)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_537 Int) (BOUND_VARIABLE_538 Int)) (> BOUND_VARIABLE_537 BOUND_VARIABLE_538)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_537 Int) (BOUND_VARIABLE_538 Int)) (> BOUND_VARIABLE_537 BOUND_VARIABLE_538)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (< BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 0) t) (nullable.some 4))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_555 Int) (BOUND_VARIABLE_556 Int)) (< BOUND_VARIABLE_555 BOUND_VARIABLE_556)) ((_ tuple.select 0) t) (nullable.some 4)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_576 Int) (BOUND_VARIABLE_577 Int)) (= BOUND_VARIABLE_576 BOUND_VARIABLE_577)) ((_ tuple.select 0) t) ((_ tuple.select 1) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_576 Int) (BOUND_VARIABLE_577 Int)) (= BOUND_VARIABLE_576 BOUND_VARIABLE_577)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p2 (rel.product ((_ rel.project 7) (set.filter p0 EMP)) (set.union ((_ rel.project 7) (set.filter p1 EMP)) ((_ rel.project 7) EMP)))))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p6 (rel.product ((_ rel.project 7) (set.filter p3 EMP)) ((_ rel.project 0) (set.filter p5 (set.union ((_ rel.project 7) (set.filter p4 EMP)) ((_ rel.project 7) EMP)))))))))
(check-sat)
;answer: unsat
; duration: 426 ms.
(reset)
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (= BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (= BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (set.inter ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.inter ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))
(assert (= q2 (set.inter (set.inter ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))
(check-sat)
;answer: unsat
; duration: 98 ms.
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (tuple (nullable.some 1)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_533 Int) (BOUND_VARIABLE_534 Int)) (= BOUND_VARIABLE_533 BOUND_VARIABLE_534)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_533 Int) (BOUND_VARIABLE_534 Int)) (= BOUND_VARIABLE_533 BOUND_VARIABLE_534)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_601 Int) (BOUND_VARIABLE_602 Int)) (= BOUND_VARIABLE_601 BOUND_VARIABLE_602)) ((_ tuple.select 7) t) ((_ tuple.select 11) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_601 Int) (BOUND_VARIABLE_602 Int)) (= BOUND_VARIABLE_601 BOUND_VARIABLE_602)) ((_ tuple.select 7) t) ((_ tuple.select 11) t)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f1 (set.filter p0 (rel.product EMP DEPT)))))
(assert (= q2 (set.map f4 (set.filter p3 (rel.product (set.filter p2 (rel.product EMP DEPT)) DEPT)))))
(check-sat)
;answer: unsat
; duration: 111 ms.
(reset)
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_503 String) (BOUND_VARIABLE_504 String)) (= BOUND_VARIABLE_503 BOUND_VARIABLE_504)) ((_ tuple.select 1) t) (nullable.some "foo"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_503 String) (BOUND_VARIABLE_504 String)) (= BOUND_VARIABLE_503 BOUND_VARIABLE_504)) ((_ tuple.select 1) t) (nullable.some "foo"))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_519 Bool) (BOUND_VARIABLE_520 Bool)) (and BOUND_VARIABLE_519 BOUND_VARIABLE_520)) (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_503 String) (BOUND_VARIABLE_504 String)) (= BOUND_VARIABLE_503 BOUND_VARIABLE_504)) ((_ tuple.select 1) t) (nullable.some "foo")))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_503 String) (BOUND_VARIABLE_504 String)) (= BOUND_VARIABLE_503 BOUND_VARIABLE_504)) ((_ tuple.select 1) t) (nullable.some "foo"))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_503 String) (BOUND_VARIABLE_504 String)) (= BOUND_VARIABLE_503 BOUND_VARIABLE_504)) ((_ tuple.select 1) t) (nullable.some "foo"))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_519 Bool) (BOUND_VARIABLE_520 Bool)) (and BOUND_VARIABLE_519 BOUND_VARIABLE_520)) (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_503 String) (BOUND_VARIABLE_504 String)) (= BOUND_VARIABLE_503 BOUND_VARIABLE_504)) ((_ tuple.select 1) t) (nullable.some "foo"))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_554 String) (BOUND_VARIABLE_555 String)) (= BOUND_VARIABLE_554 BOUND_VARIABLE_555)) ((_ tuple.select 1) t) (nullable.some "foo"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_554 String) (BOUND_VARIABLE_555 String)) (= BOUND_VARIABLE_554 BOUND_VARIABLE_555)) ((_ tuple.select 1) t) (nullable.some "foo")))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_575 Int) (BOUND_VARIABLE_576 Int)) (= BOUND_VARIABLE_575 BOUND_VARIABLE_576)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_575 Int) (BOUND_VARIABLE_576 Int)) (= BOUND_VARIABLE_575 BOUND_VARIABLE_576)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ rel.project 1) (set.filter p0 (rel.product EMP DEPT)))))
(assert (= q2 ((_ rel.project 1) (set.filter p2 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)) DEPT)))))
(check-sat)
;answer: unsat
; duration: 183 ms.
(reset)
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
(set-option :tlimit-per 20000)
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_537 String) (BOUND_VARIABLE_538 String)) (= BOUND_VARIABLE_537 BOUND_VARIABLE_538)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_537 String) (BOUND_VARIABLE_538 String)) (= BOUND_VARIABLE_537 BOUND_VARIABLE_538)) ((_ tuple.select 1) t) (nullable.some "Charlie")))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_575 String) (BOUND_VARIABLE_576 String)) (= BOUND_VARIABLE_575 BOUND_VARIABLE_576)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_575 String) (BOUND_VARIABLE_576 String)) (= BOUND_VARIABLE_575 BOUND_VARIABLE_576)) ((_ tuple.select 1) t) (nullable.some "Charlie")))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_596 Int) (BOUND_VARIABLE_597 Int)) (= BOUND_VARIABLE_596 BOUND_VARIABLE_597)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_596 Int) (BOUND_VARIABLE_597 Int)) (= BOUND_VARIABLE_596 BOUND_VARIABLE_597)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= f6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f3 (set.filter p2 (set.union (set.map rightJoin1 (set.minus EMP ((_ rel.project 2 3 4 5 6 7 8 9 10) (set.filter p0 (rel.product DEPT EMP))))) (set.filter p0 (rel.product DEPT EMP)))))))
(assert (= q2 (set.map f6 (set.filter p5 (rel.product ((_ rel.project 0 1) (set.filter p4 DEPT)) EMP)))))
(check-sat)
;answer: unsat
; duration: 299 ms.
(reset)
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_495 Int) (BOUND_VARIABLE_496 Int)) (= BOUND_VARIABLE_495 BOUND_VARIABLE_496)) (nullable.lift (lambda ((BOUND_VARIABLE_479 Int) (BOUND_VARIABLE_480 Int)) (+ BOUND_VARIABLE_479 BOUND_VARIABLE_480)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_489 Int) (BOUND_VARIABLE_490 Int)) (* BOUND_VARIABLE_489 BOUND_VARIABLE_490)) ((_ tuple.select 9) t) (nullable.some 2)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_495 Int) (BOUND_VARIABLE_496 Int)) (= BOUND_VARIABLE_495 BOUND_VARIABLE_496)) (nullable.lift (lambda ((BOUND_VARIABLE_479 Int) (BOUND_VARIABLE_480 Int)) (+ BOUND_VARIABLE_479 BOUND_VARIABLE_480)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_489 Int) (BOUND_VARIABLE_490 Int)) (* BOUND_VARIABLE_489 BOUND_VARIABLE_490)) ((_ tuple.select 9) t) (nullable.some 2))))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (nullable.lift (lambda ((BOUND_VARIABLE_565 Int) (BOUND_VARIABLE_566 Int)) (+ BOUND_VARIABLE_565 BOUND_VARIABLE_566)) ((_ tuple.select 0) t) (nullable.some 10))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 6) t) ((_ tuple.select 5) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_629 Int) (BOUND_VARIABLE_630 Int)) (* BOUND_VARIABLE_629 BOUND_VARIABLE_630)) ((_ tuple.select 7) t) (nullable.some 2))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_697 Int) (BOUND_VARIABLE_698 Int)) (= BOUND_VARIABLE_697 BOUND_VARIABLE_698)) ((_ tuple.select 2) t) ((_ tuple.select 12) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_697 Int) (BOUND_VARIABLE_698 Int)) (= BOUND_VARIABLE_697 BOUND_VARIABLE_698)) ((_ tuple.select 2) t) ((_ tuple.select 12) t)))))))
(assert (= q1 ((_ rel.project 0 9) (set.filter p0 (rel.product DEPT EMP)))))
(assert (= q2 ((_ rel.project 0 10) (set.filter p3 (rel.product (set.map f1 DEPT) (set.map f2 EMP))))))
(check-sat)
;answer: unsat
; duration: 286 ms.
(reset)
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_598 Bool) (BOUND_VARIABLE_599 Bool) (BOUND_VARIABLE_600 Bool)) (and BOUND_VARIABLE_598 BOUND_VARIABLE_599 BOUND_VARIABLE_600)) (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)) (nullable.lift (lambda ((BOUND_VARIABLE_582 String) (BOUND_VARIABLE_583 String)) (= BOUND_VARIABLE_582 BOUND_VARIABLE_583)) ((_ tuple.select 10) t) (nullable.some "foo")))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_598 Bool) (BOUND_VARIABLE_599 Bool) (BOUND_VARIABLE_600 Bool)) (and BOUND_VARIABLE_598 BOUND_VARIABLE_599 BOUND_VARIABLE_600)) (nullable.lift (lambda ((BOUND_VARIABLE_550 Int) (BOUND_VARIABLE_551 Int)) (= BOUND_VARIABLE_550 BOUND_VARIABLE_551)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_573 Int) (BOUND_VARIABLE_574 Int)) (= BOUND_VARIABLE_573 BOUND_VARIABLE_574)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)) (nullable.lift (lambda ((BOUND_VARIABLE_582 String) (BOUND_VARIABLE_583 String)) (= BOUND_VARIABLE_582 BOUND_VARIABLE_583)) ((_ tuple.select 10) t) (nullable.some "foo"))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_634 String) (BOUND_VARIABLE_635 String)) (= BOUND_VARIABLE_634 BOUND_VARIABLE_635)) ((_ tuple.select 1) t) (nullable.some "foo"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_634 String) (BOUND_VARIABLE_635 String)) (= BOUND_VARIABLE_634 BOUND_VARIABLE_635)) ((_ tuple.select 1) t) (nullable.some "foo")))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_655 Int) (BOUND_VARIABLE_656 Int)) (= BOUND_VARIABLE_655 BOUND_VARIABLE_656)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_655 Int) (BOUND_VARIABLE_656 Int)) (= BOUND_VARIABLE_655 BOUND_VARIABLE_656)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_674 Int) (BOUND_VARIABLE_675 Int)) (= BOUND_VARIABLE_674 BOUND_VARIABLE_675)) ((_ tuple.select 9) t) ((_ tuple.select 18) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_674 Int) (BOUND_VARIABLE_675 Int)) (= BOUND_VARIABLE_674 BOUND_VARIABLE_675)) ((_ tuple.select 9) t) ((_ tuple.select 18) t)))))))
(assert (= q1 ((_ rel.project 1) (set.filter p0 (rel.product (rel.product EMP DEPT) EMP)))))
(assert (= q2 ((_ rel.project 1) (set.filter p3 (rel.product (set.filter p2 (rel.product EMP ((_ rel.project 0 1) (set.filter p1 DEPT)))) EMP)))))
(check-sat)
;answer: unsat
; duration: 417 ms.
(reset)
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_551 String) (BOUND_VARIABLE_552 String)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_551 String) (BOUND_VARIABLE_552 String)) (= BOUND_VARIABLE_551 BOUND_VARIABLE_552)) ((_ tuple.select 1) t) (nullable.some "Charlie")))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_589 String) (BOUND_VARIABLE_590 String)) (= BOUND_VARIABLE_589 BOUND_VARIABLE_590)) ((_ tuple.select 1) t) (nullable.some "Charlie"))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_589 String) (BOUND_VARIABLE_590 String)) (= BOUND_VARIABLE_589 BOUND_VARIABLE_590)) ((_ tuple.select 1) t) (nullable.some "Charlie")))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_609 Int) (BOUND_VARIABLE_610 Int)) (= BOUND_VARIABLE_609 BOUND_VARIABLE_610)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_609 Int) (BOUND_VARIABLE_610 Int)) (= BOUND_VARIABLE_609 BOUND_VARIABLE_610)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f4 (set.filter p3 (set.union (set.union (set.map leftJoin1 (set.minus DEPT ((_ rel.project 0 1) (set.filter p0 (rel.product DEPT EMP))))) (set.map rightJoin2 (set.minus EMP ((_ rel.project 2 3 4 5 6 7 8 9 10) (set.filter p0 (rel.product DEPT EMP)))))) (set.filter p0 (rel.product DEPT EMP)))))))
(assert (= q2 (set.map f8 (set.union (set.map leftJoin7 (set.minus ((_ rel.project 0 1) (set.filter p5 DEPT)) ((_ rel.project 0 1) (set.filter p6 (rel.product ((_ rel.project 0 1) (set.filter p5 DEPT)) EMP))))) (set.filter p6 (rel.product ((_ rel.project 0 1) (set.filter p5 DEPT)) EMP))))))
(check-sat)
;answer: unsat
; duration: 858 ms.
(reset)
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_465 Int) (BOUND_VARIABLE_466 Int)) (> BOUND_VARIABLE_465 BOUND_VARIABLE_466)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_465 Int) (BOUND_VARIABLE_466 Int)) (> BOUND_VARIABLE_465 BOUND_VARIABLE_466)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_526 Int) (BOUND_VARIABLE_527 Int)) (= BOUND_VARIABLE_526 BOUND_VARIABLE_527)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_526 Int) (BOUND_VARIABLE_527 Int)) (= BOUND_VARIABLE_526 BOUND_VARIABLE_527)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_552 Int) (BOUND_VARIABLE_553 Int)) (> BOUND_VARIABLE_552 BOUND_VARIABLE_553)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_552 Int) (BOUND_VARIABLE_553 Int)) (> BOUND_VARIABLE_552 BOUND_VARIABLE_553)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_569 Int) (BOUND_VARIABLE_570 Int)) (> BOUND_VARIABLE_569 BOUND_VARIABLE_570)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_569 Int) (BOUND_VARIABLE_570 Int)) (> BOUND_VARIABLE_569 BOUND_VARIABLE_570)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_587 Int) (BOUND_VARIABLE_588 Int)) (> BOUND_VARIABLE_587 BOUND_VARIABLE_588)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_587 Int) (BOUND_VARIABLE_588 Int)) (> BOUND_VARIABLE_587 BOUND_VARIABLE_588)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (> BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (> BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 7) t) (nullable.some 10)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_606 Bool) (BOUND_VARIABLE_607 Bool)) (or BOUND_VARIABLE_606 BOUND_VARIABLE_607)) (nullable.lift (lambda ((BOUND_VARIABLE_587 Int) (BOUND_VARIABLE_588 Int)) (> BOUND_VARIABLE_587 BOUND_VARIABLE_588)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (> BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 7) t) (nullable.some 10)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_587 Int) (BOUND_VARIABLE_588 Int)) (> BOUND_VARIABLE_587 BOUND_VARIABLE_588)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_587 Int) (BOUND_VARIABLE_588 Int)) (> BOUND_VARIABLE_587 BOUND_VARIABLE_588)) ((_ tuple.select 7) t) (nullable.some 7)))) (nullable.some true) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (> BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (> BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 7) t) (nullable.some 10)))) (nullable.some true) (nullable.lift (lambda ((BOUND_VARIABLE_606 Bool) (BOUND_VARIABLE_607 Bool)) (or BOUND_VARIABLE_606 BOUND_VARIABLE_607)) (nullable.lift (lambda ((BOUND_VARIABLE_587 Int) (BOUND_VARIABLE_588 Int)) (> BOUND_VARIABLE_587 BOUND_VARIABLE_588)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_593 Int) (BOUND_VARIABLE_594 Int)) (> BOUND_VARIABLE_593 BOUND_VARIABLE_594)) ((_ tuple.select 7) t) (nullable.some 10))))))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_629 Int) (BOUND_VARIABLE_630 Int)) (= BOUND_VARIABLE_629 BOUND_VARIABLE_630)) ((_ tuple.select 0) t) ((_ tuple.select 8) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_629 Int) (BOUND_VARIABLE_630 Int)) (= BOUND_VARIABLE_629 BOUND_VARIABLE_630)) ((_ tuple.select 0) t) ((_ tuple.select 8) t)))))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f3 (set.filter p2 (rel.product (set.union ((_ rel.project 7) (set.filter p0 EMP)) ((_ rel.project 7) (set.filter p1 EMP))) EMP)))))
(assert (= q2 (set.map f8 (set.filter p7 (rel.product (set.union ((_ rel.project 7) (set.filter p4 EMP)) ((_ rel.project 7) (set.filter p5 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 EMP)))))))
(check-sat)
;answer: unsat
; duration: 398 ms.
(reset)
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
(set-option :tlimit-per 20000)
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_516 Int) (BOUND_VARIABLE_517 Int)) (= BOUND_VARIABLE_516 BOUND_VARIABLE_517)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_516 Int) (BOUND_VARIABLE_517 Int)) (= BOUND_VARIABLE_516 BOUND_VARIABLE_517)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_557 Int) (BOUND_VARIABLE_558 Int)) (= BOUND_VARIABLE_557 BOUND_VARIABLE_558)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_557 Int) (BOUND_VARIABLE_558 Int)) (= BOUND_VARIABLE_557 BOUND_VARIABLE_558)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_574 Int) (BOUND_VARIABLE_575 Int)) (= BOUND_VARIABLE_574 BOUND_VARIABLE_575)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_574 Int) (BOUND_VARIABLE_575 Int)) (= BOUND_VARIABLE_574 BOUND_VARIABLE_575)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= leftJoin5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map leftJoin2 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) DEPT))))) (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) DEPT))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map leftJoin5 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1) (set.filter p4 DEPT)))))) (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1) (set.filter p4 DEPT)))))))
(check-sat)
;answer: unsat
; duration: 1251 ms.
(reset)
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const leftJoin1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const rightJoin4 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_478 Int) (BOUND_VARIABLE_479 Int)) (= BOUND_VARIABLE_478 BOUND_VARIABLE_479)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_595 Int) (BOUND_VARIABLE_596 Int)) (= BOUND_VARIABLE_595 BOUND_VARIABLE_596)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_595 Int) (BOUND_VARIABLE_596 Int)) (= BOUND_VARIABLE_595 BOUND_VARIABLE_596)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f2 (set.union (set.map leftJoin1 (set.minus DEPT ((_ rel.project 0 1) (set.filter p0 (rel.product DEPT EMP))))) (set.filter p0 (rel.product DEPT EMP))))))
(assert (= q2 (set.map f5 (set.union (set.map rightJoin4 (set.minus DEPT ((_ rel.project 9 10) (set.filter p3 (rel.product EMP DEPT))))) (set.filter p3 (rel.product EMP DEPT))))))
(check-sat)
;answer: unsat
; duration: 302 ms.
(reset)
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= q1 ((_ rel.project 6) (rel.product (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP) ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP)) EMP))))
(assert (= q2 ((_ rel.project 6) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) (rel.product EMP EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) (rel.product EMP EMP))))))
(check-sat)
;answer: unsat
; duration: 124 ms.
(reset)
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (= BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (= BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))
(assert (= q2 (set.union (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))
(check-sat)
;answer: unsat
; duration: 387 ms.
(reset)
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_368 Int) (BOUND_VARIABLE_369 Int)) (> BOUND_VARIABLE_368 BOUND_VARIABLE_369)) (nullable.lift (lambda ((BOUND_VARIABLE_350 Int) (BOUND_VARIABLE_351 Int)) (+ BOUND_VARIABLE_350 BOUND_VARIABLE_351)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_362 Int) (BOUND_VARIABLE_363 Int)) (+ BOUND_VARIABLE_362 BOUND_VARIABLE_363)) (nullable.some 3) (as nullable.null (Nullable Int))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_368 Int) (BOUND_VARIABLE_369 Int)) (> BOUND_VARIABLE_368 BOUND_VARIABLE_369)) (nullable.lift (lambda ((BOUND_VARIABLE_350 Int) (BOUND_VARIABLE_351 Int)) (+ BOUND_VARIABLE_350 BOUND_VARIABLE_351)) (nullable.some 1) (nullable.some 2)) (nullable.lift (lambda ((BOUND_VARIABLE_362 Int) (BOUND_VARIABLE_363 Int)) (+ BOUND_VARIABLE_362 BOUND_VARIABLE_363)) (nullable.some 3) (as nullable.null (Nullable Int)))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 (set.singleton (tuple (nullable.some 1) (nullable.some 2)))))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p1 (set.singleton (tuple (nullable.some 0) (nullable.some 0)))))))
(check-sat)
;answer: unsat
; duration: 12 ms.
(reset)
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (< BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 3) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (< BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 3) t) (nullable.some 10)))) (nullable.some true) (nullable.some false))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (< BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 3) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (< BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 3) t) (nullable.some 10)))) (nullable.some true) (nullable.some false)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_471 Int) (BOUND_VARIABLE_472 Int)) (< BOUND_VARIABLE_471 BOUND_VARIABLE_472)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_471 Int) (BOUND_VARIABLE_472 Int)) (< BOUND_VARIABLE_471 BOUND_VARIABLE_472)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= q1 ((_ rel.project 3) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0) (set.filter p1 ((_ rel.project 3) EMP)))))
(check-sat)
;answer: unsat
; duration: 60 ms.
(reset)
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_434 Int) (BOUND_VARIABLE_435 Int)) (= BOUND_VARIABLE_434 BOUND_VARIABLE_435)) ((_ tuple.select 1) t) (nullable.some 200))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_434 Int) (BOUND_VARIABLE_435 Int)) (= BOUND_VARIABLE_434 BOUND_VARIABLE_435)) ((_ tuple.select 1) t) (nullable.some 200)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_471 Int) (BOUND_VARIABLE_472 Int)) (= BOUND_VARIABLE_471 BOUND_VARIABLE_472)) ((_ tuple.select 0) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_471 Int) (BOUND_VARIABLE_472 Int)) (= BOUND_VARIABLE_471 BOUND_VARIABLE_472)) ((_ tuple.select 0) t) (nullable.some 100)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_521 Int) (BOUND_VARIABLE_522 Int)) (= BOUND_VARIABLE_521 BOUND_VARIABLE_522)) ((_ tuple.select 1) t) ((_ tuple.select 2) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_521 Int) (BOUND_VARIABLE_522 Int)) (= BOUND_VARIABLE_521 BOUND_VARIABLE_522)) ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_540 Int) (BOUND_VARIABLE_541 Int)) (= BOUND_VARIABLE_540 BOUND_VARIABLE_541)) ((_ tuple.select 1) t) (nullable.some 200))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_540 Int) (BOUND_VARIABLE_541 Int)) (= BOUND_VARIABLE_540 BOUND_VARIABLE_541)) ((_ tuple.select 1) t) (nullable.some 200)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_557 Int) (BOUND_VARIABLE_558 Int)) (= BOUND_VARIABLE_557 BOUND_VARIABLE_558)) ((_ tuple.select 0) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_557 Int) (BOUND_VARIABLE_558 Int)) (= BOUND_VARIABLE_557 BOUND_VARIABLE_558)) ((_ tuple.select 0) t) (nullable.some 100)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_576 Int) (BOUND_VARIABLE_577 Int)) (= BOUND_VARIABLE_576 BOUND_VARIABLE_577)) ((_ tuple.select 1) t) ((_ tuple.select 2) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_576 Int) (BOUND_VARIABLE_577 Int)) (= BOUND_VARIABLE_576 BOUND_VARIABLE_577)) ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))))
(assert (= q1 ((_ rel.project 0) (set.filter p2 (rel.product ((_ rel.project 0 1) (set.filter p0 ((_ rel.project 6 7) EMP))) ((_ rel.project 1) (set.filter p1 ((_ rel.project 6 7) EMP))))))))
(assert (= q2 ((_ rel.project 0) (set.filter p5 (rel.product ((_ rel.project 0 1) (set.filter p3 ((_ rel.project 6 7) EMP))) ((_ rel.project 1) (set.filter p4 ((_ rel.project 6 7) EMP))))))))
(check-sat)
;answer: unsat
; duration: 1652 ms.
(reset)
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const leftJoin2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_507 Int) (BOUND_VARIABLE_508 Int)) (= BOUND_VARIABLE_507 BOUND_VARIABLE_508)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_507 Int) (BOUND_VARIABLE_508 Int)) (= BOUND_VARIABLE_507 BOUND_VARIABLE_508)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map leftJoin2 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) DEPT))))) (set.filter p1 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) DEPT))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.singleton (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some "")))) ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.singleton (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some ""))))))))
(check-sat)
;answer: unsat
; duration: 91 ms.
(reset)
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 6) t) (nullable.some 1000)))) (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_450 Int) (BOUND_VARIABLE_451 Int)) (= BOUND_VARIABLE_450 BOUND_VARIABLE_451)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_450 Int) (BOUND_VARIABLE_451 Int)) (= BOUND_VARIABLE_450 BOUND_VARIABLE_451)) ((_ tuple.select 6) t) (nullable.some 1000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))) (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_473 Int) (BOUND_VARIABLE_474 Int)) (= BOUND_VARIABLE_473 BOUND_VARIABLE_474)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_473 Int) (BOUND_VARIABLE_474 Int)) (= BOUND_VARIABLE_473 BOUND_VARIABLE_474)) ((_ tuple.select 6) t) (nullable.some 2000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 6) t) (nullable.some 1000)))) (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_450 Int) (BOUND_VARIABLE_451 Int)) (= BOUND_VARIABLE_450 BOUND_VARIABLE_451)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_450 Int) (BOUND_VARIABLE_451 Int)) (= BOUND_VARIABLE_450 BOUND_VARIABLE_451)) ((_ tuple.select 6) t) (nullable.some 1000)))) (as nullable.null (Nullable Int)) (nullable.some 1)))) (nullable.some (nullable.is_null (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_473 Int) (BOUND_VARIABLE_474 Int)) (= BOUND_VARIABLE_473 BOUND_VARIABLE_474)) ((_ tuple.select 6) t) (nullable.some 2000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_473 Int) (BOUND_VARIABLE_474 Int)) (= BOUND_VARIABLE_473 BOUND_VARIABLE_474)) ((_ tuple.select 6) t) (nullable.some 2000)))) (as nullable.null (Nullable Int)) (nullable.some 1))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_516 Int) (BOUND_VARIABLE_517 Int)) (= BOUND_VARIABLE_516 BOUND_VARIABLE_517)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_516 Int) (BOUND_VARIABLE_517 Int)) (= BOUND_VARIABLE_516 BOUND_VARIABLE_517)) ((_ tuple.select 6) t) (nullable.some 1000)))) (nullable.lift (lambda ((BOUND_VARIABLE_522 Int) (BOUND_VARIABLE_523 Int)) (= BOUND_VARIABLE_522 BOUND_VARIABLE_523)) ((_ tuple.select 6) t) (nullable.some 1000)) (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (= BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 6) t) (nullable.some 2000)))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_516 Int) (BOUND_VARIABLE_517 Int)) (= BOUND_VARIABLE_516 BOUND_VARIABLE_517)) ((_ tuple.select 6) t) (nullable.some 1000))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_516 Int) (BOUND_VARIABLE_517 Int)) (= BOUND_VARIABLE_516 BOUND_VARIABLE_517)) ((_ tuple.select 6) t) (nullable.some 1000)))) (nullable.lift (lambda ((BOUND_VARIABLE_522 Int) (BOUND_VARIABLE_523 Int)) (= BOUND_VARIABLE_522 BOUND_VARIABLE_523)) ((_ tuple.select 6) t) (nullable.some 1000)) (nullable.lift (lambda ((BOUND_VARIABLE_528 Int) (BOUND_VARIABLE_529 Int)) (= BOUND_VARIABLE_528 BOUND_VARIABLE_529)) ((_ tuple.select 6) t) (nullable.some 2000))))))))
(assert (= q1 ((_ rel.project 6) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 6) (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 114 ms.
(reset)
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (> BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (> BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 9)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_519 Int) (BOUND_VARIABLE_520 Int)) (= BOUND_VARIABLE_519 BOUND_VARIABLE_520)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_519 Int) (BOUND_VARIABLE_520 Int)) (= BOUND_VARIABLE_519 BOUND_VARIABLE_520)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= rightJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_560 Int) (BOUND_VARIABLE_561 Int)) (> BOUND_VARIABLE_560 BOUND_VARIABLE_561)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_560 Int) (BOUND_VARIABLE_561 Int)) (> BOUND_VARIABLE_560 BOUND_VARIABLE_561)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_597 Int) (BOUND_VARIABLE_598 Int)) (> BOUND_VARIABLE_597 BOUND_VARIABLE_598)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_597 Int) (BOUND_VARIABLE_598 Int)) (> BOUND_VARIABLE_597 BOUND_VARIABLE_598)) ((_ tuple.select 7) t) (nullable.some 9)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_614 Int) (BOUND_VARIABLE_615 Int)) (> BOUND_VARIABLE_614 BOUND_VARIABLE_615)) ((_ tuple.select 7) t) (nullable.some 9))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_614 Int) (BOUND_VARIABLE_615 Int)) (> BOUND_VARIABLE_614 BOUND_VARIABLE_615)) ((_ tuple.select 7) t) (nullable.some 9)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_633 Int) (BOUND_VARIABLE_634 Int)) (= BOUND_VARIABLE_633 BOUND_VARIABLE_634)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_633 Int) (BOUND_VARIABLE_634 Int)) (= BOUND_VARIABLE_633 BOUND_VARIABLE_634)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= rightJoin8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t)))))
(assert (= p9 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_668 Int) (BOUND_VARIABLE_669 Int)) (> BOUND_VARIABLE_668 BOUND_VARIABLE_669)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_668 Int) (BOUND_VARIABLE_669 Int)) (> BOUND_VARIABLE_668 BOUND_VARIABLE_669)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= f10 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f4 (set.filter p3 (set.union (set.map rightJoin2 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 9 10 11 12 13 14 15 16 17) (set.filter p1 (rel.product EMP ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))))) (set.filter p1 (rel.product EMP ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)))))))))
(assert (= q2 (set.map f10 (set.filter p9 (set.union (set.map rightJoin8 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 EMP)) ((_ rel.project 9 10 11 12 13 14 15 16 17) (set.filter p7 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 EMP))))))) (set.filter p7 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 EMP)))))))))
(check-sat)
;answer: unsat
; duration: 1370 ms.
(reset)
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_489 Bool) (BOUND_VARIABLE_490 Bool) (BOUND_VARIABLE_491 Bool)) (and BOUND_VARIABLE_489 BOUND_VARIABLE_490 BOUND_VARIABLE_491)) (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (nullable.lift (lambda ((BOUND_VARIABLE_473 Int) (BOUND_VARIABLE_474 Real)) (> BOUND_VARIABLE_473 BOUND_VARIABLE_474)) (nullable.lift (lambda ((BOUND_VARIABLE_444 Int) (BOUND_VARIABLE_445 Int)) (+ BOUND_VARIABLE_444 BOUND_VARIABLE_445)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (nullable.lift (lambda ((BOUND_VARIABLE_452 Int) (BOUND_VARIABLE_453 Int)) (/ BOUND_VARIABLE_452 BOUND_VARIABLE_453)) ((_ tuple.select 5) t) (nullable.some 2))))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_489 Bool) (BOUND_VARIABLE_490 Bool) (BOUND_VARIABLE_491 Bool)) (and BOUND_VARIABLE_489 BOUND_VARIABLE_490 BOUND_VARIABLE_491)) (nullable.lift (lambda ((BOUND_VARIABLE_415 Int) (BOUND_VARIABLE_416 Int)) (> BOUND_VARIABLE_415 BOUND_VARIABLE_416)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_438 Int) (BOUND_VARIABLE_439 Int)) (= BOUND_VARIABLE_438 BOUND_VARIABLE_439)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (nullable.lift (lambda ((BOUND_VARIABLE_473 Int) (BOUND_VARIABLE_474 Real)) (> BOUND_VARIABLE_473 BOUND_VARIABLE_474)) (nullable.lift (lambda ((BOUND_VARIABLE_444 Int) (BOUND_VARIABLE_445 Int)) (+ BOUND_VARIABLE_444 BOUND_VARIABLE_445)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (nullable.lift (lambda ((BOUND_VARIABLE_452 Int) (BOUND_VARIABLE_453 Int)) (/ BOUND_VARIABLE_452 BOUND_VARIABLE_453)) ((_ tuple.select 5) t) (nullable.some 2)))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_514 Int) (BOUND_VARIABLE_515 Int)) (= BOUND_VARIABLE_514 BOUND_VARIABLE_515)) ((_ tuple.select 6) t) ((_ tuple.select 7) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_514 Int) (BOUND_VARIABLE_515 Int)) (= BOUND_VARIABLE_514 BOUND_VARIABLE_515)) ((_ tuple.select 6) t) ((_ tuple.select 7) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_598 Int) (BOUND_VARIABLE_599 Int)) (= BOUND_VARIABLE_598 BOUND_VARIABLE_599)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_598 Int) (BOUND_VARIABLE_599 Int)) (= BOUND_VARIABLE_598 BOUND_VARIABLE_599)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_636 Int) (BOUND_VARIABLE_637 Int)) (> BOUND_VARIABLE_636 BOUND_VARIABLE_637)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_636 Int) (BOUND_VARIABLE_637 Int)) (> BOUND_VARIABLE_636 BOUND_VARIABLE_637)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_643 Int) (BOUND_VARIABLE_644 Int)) (= BOUND_VARIABLE_643 BOUND_VARIABLE_644)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_643 Int) (BOUND_VARIABLE_644 Int)) (= BOUND_VARIABLE_643 BOUND_VARIABLE_644)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_675 Bool) (BOUND_VARIABLE_676 Bool) (BOUND_VARIABLE_677 Bool)) (and BOUND_VARIABLE_675 BOUND_VARIABLE_676 BOUND_VARIABLE_677)) (nullable.lift (lambda ((BOUND_VARIABLE_636 Int) (BOUND_VARIABLE_637 Int)) (> BOUND_VARIABLE_636 BOUND_VARIABLE_637)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_643 Int) (BOUND_VARIABLE_644 Int)) (= BOUND_VARIABLE_643 BOUND_VARIABLE_644)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (nullable.lift (lambda ((BOUND_VARIABLE_661 Int) (BOUND_VARIABLE_662 Real)) (> BOUND_VARIABLE_661 BOUND_VARIABLE_662)) (nullable.lift (lambda ((BOUND_VARIABLE_649 Int) (BOUND_VARIABLE_650 Int)) (+ BOUND_VARIABLE_649 BOUND_VARIABLE_650)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (nullable.lift (lambda ((BOUND_VARIABLE_655 Int) (BOUND_VARIABLE_656 Int)) (/ BOUND_VARIABLE_655 BOUND_VARIABLE_656)) ((_ tuple.select 5) t) (nullable.some 2))))))) (nullable.val (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_636 Int) (BOUND_VARIABLE_637 Int)) (> BOUND_VARIABLE_636 BOUND_VARIABLE_637)) ((_ tuple.select 7) t) (nullable.some 7))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_636 Int) (BOUND_VARIABLE_637 Int)) (> BOUND_VARIABLE_636 BOUND_VARIABLE_637)) ((_ tuple.select 7) t) (nullable.some 7))))) (nullable.some false) (ite (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_643 Int) (BOUND_VARIABLE_644 Int)) (= BOUND_VARIABLE_643 BOUND_VARIABLE_644)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_643 Int) (BOUND_VARIABLE_644 Int)) (= BOUND_VARIABLE_643 BOUND_VARIABLE_644)) ((_ tuple.select 5) t) ((_ tuple.select 7) t))))) (nullable.some false) (nullable.lift (lambda ((BOUND_VARIABLE_675 Bool) (BOUND_VARIABLE_676 Bool) (BOUND_VARIABLE_677 Bool)) (and BOUND_VARIABLE_675 BOUND_VARIABLE_676 BOUND_VARIABLE_677)) (nullable.lift (lambda ((BOUND_VARIABLE_636 Int) (BOUND_VARIABLE_637 Int)) (> BOUND_VARIABLE_636 BOUND_VARIABLE_637)) ((_ tuple.select 7) t) (nullable.some 7)) (nullable.lift (lambda ((BOUND_VARIABLE_643 Int) (BOUND_VARIABLE_644 Int)) (= BOUND_VARIABLE_643 BOUND_VARIABLE_644)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (nullable.lift (lambda ((BOUND_VARIABLE_661 Int) (BOUND_VARIABLE_662 Real)) (> BOUND_VARIABLE_661 BOUND_VARIABLE_662)) (nullable.lift (lambda ((BOUND_VARIABLE_649 Int) (BOUND_VARIABLE_650 Int)) (+ BOUND_VARIABLE_649 BOUND_VARIABLE_650)) ((_ tuple.select 5) t) ((_ tuple.select 7) t)) (nullable.lift (lambda ((BOUND_VARIABLE_655 Int) (BOUND_VARIABLE_656 Int)) (/ BOUND_VARIABLE_655 BOUND_VARIABLE_656)) ((_ tuple.select 5) t) (nullable.some 2)))))))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_696 Int) (BOUND_VARIABLE_697 Int)) (= BOUND_VARIABLE_696 BOUND_VARIABLE_697)) ((_ tuple.select 6) t) ((_ tuple.select 7) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_696 Int) (BOUND_VARIABLE_697 Int)) (= BOUND_VARIABLE_696 BOUND_VARIABLE_697)) ((_ tuple.select 6) t) ((_ tuple.select 7) t)))))))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_713 Int) (BOUND_VARIABLE_714 Int)) (> BOUND_VARIABLE_713 BOUND_VARIABLE_714)) ((_ tuple.select 7) t) (nullable.some 7))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_713 Int) (BOUND_VARIABLE_714 Int)) (> BOUND_VARIABLE_713 BOUND_VARIABLE_714)) ((_ tuple.select 7) t) (nullable.some 7)))))))
(assert (= p7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_732 Int) (BOUND_VARIABLE_733 Int)) (= BOUND_VARIABLE_732 BOUND_VARIABLE_733)) ((_ tuple.select 7) t) ((_ tuple.select 16) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_732 Int) (BOUND_VARIABLE_733 Int)) (= BOUND_VARIABLE_732 BOUND_VARIABLE_733)) ((_ tuple.select 7) t) ((_ tuple.select 16) t)))))))
(assert (= f8 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1)))))
(assert (= q1 (set.map f3 (set.filter p2 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))))))
(assert (= q2 (set.map f8 (set.filter p7 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p6 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))))))
(check-sat)
;answer: unsat
; duration: 1021 ms.
(reset)
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
(set-option :tlimit-per 20000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 (set.singleton (tuple (nullable.some 1) (nullable.some 2)))))))
(assert (= q2 ((_ rel.project 0 1) (set.minus ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 0) (nullable.some 0)))) ((_ rel.project 0 1) (set.singleton (tuple (nullable.some 0) (nullable.some 0))))))))
(check-sat)
;answer: unsat
; duration: 24 ms.
(reset)
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
(set-option :tlimit-per 20000)
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
(assert (= f2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 2) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.some 1) ((_ tuple.select 7) t) ((_ tuple.select 2) t)))))
(assert (= q1 (set.union (set.map f0 EMP) (set.map f1 EMP))))
(assert (= q2 (set.union (set.map f2 EMP) (set.map f3 EMP))))
(check-sat)
;answer: unsat
; duration: 27 ms.
(reset)
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
(set-option :tlimit-per 20000)
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
; duration: 12 ms.
(reset)
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
(set-option :tlimit-per 20000)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416 Int) (BOUND_VARIABLE_417 Int)) (= BOUND_VARIABLE_416 BOUND_VARIABLE_417)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_454 Int) (BOUND_VARIABLE_455 Int)) (= BOUND_VARIABLE_454 BOUND_VARIABLE_455)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_475 Int) (BOUND_VARIABLE_476 Int)) (= BOUND_VARIABLE_475 BOUND_VARIABLE_476)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_493 Int) (BOUND_VARIABLE_494 Int)) (= BOUND_VARIABLE_493 BOUND_VARIABLE_494)) ((_ tuple.select 7) t) (nullable.some 10)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_510 Int) (BOUND_VARIABLE_511 Int)) (= BOUND_VARIABLE_510 BOUND_VARIABLE_511)) ((_ tuple.select 7) t) (nullable.some 20)))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_529 Int) (BOUND_VARIABLE_530 Int)) (= BOUND_VARIABLE_529 BOUND_VARIABLE_530)) ((_ tuple.select 7) t) (nullable.some 30))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_529 Int) (BOUND_VARIABLE_530 Int)) (= BOUND_VARIABLE_529 BOUND_VARIABLE_530)) ((_ tuple.select 7) t) (nullable.some 30)))))))
(assert (= q1 (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))
(assert (= q2 (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.union ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)))) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p5 EMP)))))
(check-sat)
;answer: unsat
; duration: 445 ms.
(reset)
; total time: 64553 ms.
; sat answers    : 1
; unsat answers  : 84
; unknown answers: 2
