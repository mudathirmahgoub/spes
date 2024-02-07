;-----------------------------------------------------------
; test name: 1
;Translating sql query: SELECT ((1+2)+3) FROM dept
;Translating sql query: SELECT 6 FROM dept
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Bag (Tuple Int)))
(declare-const q2 (Bag (Tuple Int)))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Int)))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Int)))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (+ (+ 1 2) 3)))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple 6))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unsat
; duration: 26 ms.
(reset)
;-----------------------------------------------------------
; test name: 2
;Translating sql query: SELECT (100 + 10 + sal) FROM emp
;Translating sql query: SELECT (110 + sal) FROM emp
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
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_483 Int) (BOUND_VARIABLE_484 Int)) (+ BOUND_VARIABLE_483 BOUND_VARIABLE_484)) (nullable.some (+ 100 10)) ((_ tuple.select 6) t))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_516 Int) (BOUND_VARIABLE_517 Int)) (+ BOUND_VARIABLE_516 BOUND_VARIABLE_517)) (nullable.some 110) ((_ tuple.select 6) t))))))
(assert (= q1 (bag.map f0 EMP)))
(assert (= q2 (bag.map f1 EMP)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10015 ms.
(reset)
;-----------------------------------------------------------
; test name: 3
;Translating sql query: SELECT * FROM emp WHERE sal = 3 AND comm = sal + 5
;Translating sql query: SELECT * FROM emp WHERE sal = 3 AND comm = 8
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_30978 Bool) (BOUND_VARIABLE_30979 Bool)) (and BOUND_VARIABLE_30978 BOUND_VARIABLE_30979)) (nullable.lift (lambda ((BOUND_VARIABLE_30944 Int) (BOUND_VARIABLE_30945 Int)) (= BOUND_VARIABLE_30944 BOUND_VARIABLE_30945)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_30972 Int) (BOUND_VARIABLE_30973 Int)) (= BOUND_VARIABLE_30972 BOUND_VARIABLE_30973)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_30966 Int) (BOUND_VARIABLE_30967 Int)) (+ BOUND_VARIABLE_30966 BOUND_VARIABLE_30967)) ((_ tuple.select 6) t) (nullable.some 5))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_31013 Bool) (BOUND_VARIABLE_31014 Bool)) (and BOUND_VARIABLE_31013 BOUND_VARIABLE_31014)) (nullable.lift (lambda ((BOUND_VARIABLE_31000 Int) (BOUND_VARIABLE_31001 Int)) (= BOUND_VARIABLE_31000 BOUND_VARIABLE_31001)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_31007 Int) (BOUND_VARIABLE_31008 Int)) (= BOUND_VARIABLE_31007 BOUND_VARIABLE_31008)) ((_ tuple.select 5) t) (nullable.some 8)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 199 ms.
(reset)
;-----------------------------------------------------------
; test name: 4
;Translating sql query: SELECT * FROM emp WHERE sal = 3 AND NOT(comm = sal + 5)
;Translating sql query: SELECT * FROM emp WHERE sal = 3 AND NOT(comm = 8)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_33273 Bool) (BOUND_VARIABLE_33274 Bool)) (and BOUND_VARIABLE_33273 BOUND_VARIABLE_33274)) (nullable.lift (lambda ((BOUND_VARIABLE_33249 Int) (BOUND_VARIABLE_33250 Int)) (= BOUND_VARIABLE_33249 BOUND_VARIABLE_33250)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_33268 Bool)) (not BOUND_VARIABLE_33268)) (nullable.lift (lambda ((BOUND_VARIABLE_33262 Int) (BOUND_VARIABLE_33263 Int)) (= BOUND_VARIABLE_33262 BOUND_VARIABLE_33263)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_33256 Int) (BOUND_VARIABLE_33257 Int)) (+ BOUND_VARIABLE_33256 BOUND_VARIABLE_33257)) ((_ tuple.select 6) t) (nullable.some 5)))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_33308 Bool) (BOUND_VARIABLE_33309 Bool)) (and BOUND_VARIABLE_33308 BOUND_VARIABLE_33309)) (nullable.lift (lambda ((BOUND_VARIABLE_33290 Int) (BOUND_VARIABLE_33291 Int)) (= BOUND_VARIABLE_33290 BOUND_VARIABLE_33291)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_33303 Bool)) (not BOUND_VARIABLE_33303)) (nullable.lift (lambda ((BOUND_VARIABLE_33297 Int) (BOUND_VARIABLE_33298 Int)) (= BOUND_VARIABLE_33297 BOUND_VARIABLE_33298)) ((_ tuple.select 5) t) (nullable.some 8))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 203 ms.
(reset)
;-----------------------------------------------------------
; test name: 5
;Translating sql query: SELECT (1*3+(deptno+2)+3*4) FROM dept
;Translating sql query: SELECT deptno+17 from dept
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
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_35921 Int) (BOUND_VARIABLE_35922 Int)) (+ BOUND_VARIABLE_35921 BOUND_VARIABLE_35922)) (nullable.lift (lambda ((BOUND_VARIABLE_35913 Int) (BOUND_VARIABLE_35914 Int)) (+ BOUND_VARIABLE_35913 BOUND_VARIABLE_35914)) (nullable.some (* 1 3)) (nullable.lift (lambda ((BOUND_VARIABLE_35906 Int) (BOUND_VARIABLE_35907 Int)) (+ BOUND_VARIABLE_35906 BOUND_VARIABLE_35907)) ((_ tuple.select 0) t) (nullable.some 2))) (nullable.some (* 3 4)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_35941 Int) (BOUND_VARIABLE_35942 Int)) (+ BOUND_VARIABLE_35941 BOUND_VARIABLE_35942)) ((_ tuple.select 0) t) (nullable.some 17))))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10017 ms.
(reset)
;-----------------------------------------------------------
; test name: 6
;Translating sql query: SELECT * FROM dept WHERE deptno IN (SELECT deptno FROM dept WHERE FALSE)
;Translating sql query: SELECT * FROM dept WHERE FALSE
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_79154 Int) (BOUND_VARIABLE_79155 Int)) (= BOUND_VARIABLE_79154 BOUND_VARIABLE_79155)) ((_ tuple.select 0) t) ((_ tuple.select 2) t))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (= q1 ((_ table.project 0 1) (bag.filter p1 (table.product DEPT ((_ table.project 0) ((_ table.project 0) (bag.filter p0 DEPT))))))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p2 DEPT))))
(check-sat)
;answer: unsat
; duration: 583 ms.
(reset)
;-----------------------------------------------------------
; test name: 7
;Translating sql query: SELECT * FROM dept WHERE deptno IN (1, 2, 1, 1, 2)
;Translating sql query: SELECT * FROM dept WHERE deptno IN (1, 2)
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_82383 Bool) (BOUND_VARIABLE_82384 Bool)) (or BOUND_VARIABLE_82383 BOUND_VARIABLE_82384)) (nullable.lift (lambda ((BOUND_VARIABLE_82371 Int) (BOUND_VARIABLE_82372 Int)) (= BOUND_VARIABLE_82371 BOUND_VARIABLE_82372)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.lift (lambda ((BOUND_VARIABLE_82377 Int) (BOUND_VARIABLE_82378 Int)) (= BOUND_VARIABLE_82377 BOUND_VARIABLE_82378)) ((_ tuple.select 0) t) (nullable.some 2)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_82413 Bool) (BOUND_VARIABLE_82414 Bool)) (or BOUND_VARIABLE_82413 BOUND_VARIABLE_82414)) (nullable.lift (lambda ((BOUND_VARIABLE_82401 Int) (BOUND_VARIABLE_82402 Int)) (= BOUND_VARIABLE_82401 BOUND_VARIABLE_82402)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.lift (lambda ((BOUND_VARIABLE_82407 Int) (BOUND_VARIABLE_82408 Int)) (= BOUND_VARIABLE_82407 BOUND_VARIABLE_82408)) ((_ tuple.select 0) t) (nullable.some 2)))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 DEPT))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 122 ms.
(reset)
;-----------------------------------------------------------
; test name: 8
;Translating sql query: SELECT * FROM dept AS dept WHERE dept.deptno = 1 AND TRUE
;Translating sql query: SELECT * FROM dept AS dept WHERE dept.deptno = 1
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_84201 Bool) (BOUND_VARIABLE_84202 Bool)) (and BOUND_VARIABLE_84201 BOUND_VARIABLE_84202)) (nullable.lift (lambda ((BOUND_VARIABLE_84195 Int) (BOUND_VARIABLE_84196 Int)) (= BOUND_VARIABLE_84195 BOUND_VARIABLE_84196)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some true))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_84218 Int) (BOUND_VARIABLE_84219 Int)) (= BOUND_VARIABLE_84218 BOUND_VARIABLE_84219)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 DEPT))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 151 ms.
(reset)
;-----------------------------------------------------------
; test name: 9
;Translating sql query: SELECT * FROM dept AS dept WHERE dept.deptno = 1 OR FALSE
;Translating sql query: SELECT * FROM dept AS dept WHERE dept.deptno = 1
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_85445 Bool) (BOUND_VARIABLE_85446 Bool)) (or BOUND_VARIABLE_85445 BOUND_VARIABLE_85446)) (nullable.lift (lambda ((BOUND_VARIABLE_85438 Int) (BOUND_VARIABLE_85439 Int)) (= BOUND_VARIABLE_85438 BOUND_VARIABLE_85439)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some false))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_85463 Int) (BOUND_VARIABLE_85464 Int)) (= BOUND_VARIABLE_85463 BOUND_VARIABLE_85464)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 DEPT))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 88 ms.
(reset)
;-----------------------------------------------------------
; test name: 10
;Translating sql query: SELECT * FROM dept AS dept WHERE dept.deptno = 1 AND FALSE
;Translating sql query: SELECT * FROM dept AS dept WHERE FALSE
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_86673 Bool) (BOUND_VARIABLE_86674 Bool)) (and BOUND_VARIABLE_86673 BOUND_VARIABLE_86674)) (nullable.lift (lambda ((BOUND_VARIABLE_86667 Int) (BOUND_VARIABLE_86668 Int)) (= BOUND_VARIABLE_86667 BOUND_VARIABLE_86668)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some false))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 DEPT))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p1 DEPT))))
(check-sat)
;answer: sat
; duration: 117 ms.
(get-model)
; (
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 1) (nullable.some "")) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 1) (nullable.some "")) 1)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String))))
; insert into DEPT values(1,'')
; SELECT * FROM (SELECT * FROM dept AS dept WHERE dept.deptno = 1 AND FALSE) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM dept AS dept WHERE FALSE) AS q2;

; SELECT * FROM (SELECT * FROM dept AS dept WHERE FALSE) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM dept AS dept WHERE dept.deptno = 1 AND FALSE) AS q1;

;Model soundness: false
(reset)
;-----------------------------------------------------------
; test name: 11
;Translating sql query: SELECT * FROM dept AS dept WHERE dept.deptno = 1 OR TRUE
;Translating sql query: SELECT * FROM dept AS dept WHERE TRUE
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_88307 Bool) (BOUND_VARIABLE_88308 Bool)) (or BOUND_VARIABLE_88307 BOUND_VARIABLE_88308)) (nullable.lift (lambda ((BOUND_VARIABLE_88301 Int) (BOUND_VARIABLE_88302 Int)) (= BOUND_VARIABLE_88301 BOUND_VARIABLE_88302)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some true))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 DEPT))))
(assert (= q2 ((_ table.project 0 1) DEPT)))
(check-sat)
;answer: sat
; duration: 60 ms.
(get-model)
; (
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String))))
; q2
(get-value (q2))
; (bag (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))) 1)
; insert into DEPT values(NULL,NULL)
; SELECT * FROM (SELECT * FROM dept AS dept WHERE dept.deptno = 1 OR TRUE) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM dept AS dept WHERE TRUE) AS q2;

; SELECT * FROM (SELECT * FROM dept AS dept WHERE TRUE) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM dept AS dept WHERE dept.deptno = 1 OR TRUE) AS q1;

;Model soundness: false
(reset)
;-----------------------------------------------------------
; test name: 12
;Translating sql query: SELECT * FROM ANON WHERE ANON.c > 1 AND ANON.c <= 1
;Translating sql query: SELECT * FROM ANON WHERE CASE WHEN ANON.c IS NULL THEN NULL ELSE FALSE END
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const ANON (Bag (Tuple (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_89024 Bool) (BOUND_VARIABLE_89025 Bool)) (and BOUND_VARIABLE_89024 BOUND_VARIABLE_89025)) (nullable.lift (lambda ((BOUND_VARIABLE_89012 Int) (BOUND_VARIABLE_89013 Int)) (> BOUND_VARIABLE_89012 BOUND_VARIABLE_89013)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.lift (lambda ((BOUND_VARIABLE_89018 Int) (BOUND_VARIABLE_89019 Int)) (<= BOUND_VARIABLE_89018 BOUND_VARIABLE_89019)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int)))) (nullable.is_some (ite (nullable.is_null ((_ tuple.select 0) t)) (as nullable.null (Nullable Bool)) (nullable.some false))))))
(assert (= q1 ((_ table.project 0) (bag.filter p0 ANON))))
(assert (= q2 ((_ table.project 0) (bag.filter p1 ANON))))
(check-sat)
;answer: unsat
; duration: 98 ms.
(reset)
;-----------------------------------------------------------
; test name: 13
;Translating sql query: SELECT * FROM emp WHERE emp.sal > 50 AND (emp.sal <= 50 OR emp.empno > 5)
;Translating sql query: SELECT * FROM emp WHERE emp.sal > 50 AND emp.empno> 5
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_90377 Bool) (BOUND_VARIABLE_90378 Bool)) (and BOUND_VARIABLE_90377 BOUND_VARIABLE_90378)) (nullable.lift (lambda ((BOUND_VARIABLE_90352 Int) (BOUND_VARIABLE_90353 Int)) (> BOUND_VARIABLE_90352 BOUND_VARIABLE_90353)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_90371 Bool) (BOUND_VARIABLE_90372 Bool)) (or BOUND_VARIABLE_90371 BOUND_VARIABLE_90372)) (nullable.lift (lambda ((BOUND_VARIABLE_90358 Int) (BOUND_VARIABLE_90359 Int)) (<= BOUND_VARIABLE_90358 BOUND_VARIABLE_90359)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_90365 Int) (BOUND_VARIABLE_90366 Int)) (> BOUND_VARIABLE_90365 BOUND_VARIABLE_90366)) ((_ tuple.select 0) t) (nullable.some 5))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_90407 Bool) (BOUND_VARIABLE_90408 Bool)) (and BOUND_VARIABLE_90407 BOUND_VARIABLE_90408)) (nullable.lift (lambda ((BOUND_VARIABLE_90394 Int) (BOUND_VARIABLE_90395 Int)) (> BOUND_VARIABLE_90394 BOUND_VARIABLE_90395)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_90401 Int) (BOUND_VARIABLE_90402 Int)) (> BOUND_VARIABLE_90401 BOUND_VARIABLE_90402)) ((_ tuple.select 0) t) (nullable.some 5)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 148 ms.
(reset)
;-----------------------------------------------------------
; test name: 14
;Translating sql query: SELECT * FROM emp WHERE emp.sal > 50 OR (emp.sal <= 50 AND emp.empno > 5)
;Translating sql query: SELECT * FROM emp WHERE emp.sal > 50 OR emp.empno> 5
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_92777 Bool) (BOUND_VARIABLE_92778 Bool)) (or BOUND_VARIABLE_92777 BOUND_VARIABLE_92778)) (nullable.lift (lambda ((BOUND_VARIABLE_92752 Int) (BOUND_VARIABLE_92753 Int)) (> BOUND_VARIABLE_92752 BOUND_VARIABLE_92753)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_92771 Bool) (BOUND_VARIABLE_92772 Bool)) (and BOUND_VARIABLE_92771 BOUND_VARIABLE_92772)) (nullable.lift (lambda ((BOUND_VARIABLE_92758 Int) (BOUND_VARIABLE_92759 Int)) (<= BOUND_VARIABLE_92758 BOUND_VARIABLE_92759)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_92765 Int) (BOUND_VARIABLE_92766 Int)) (> BOUND_VARIABLE_92765 BOUND_VARIABLE_92766)) ((_ tuple.select 0) t) (nullable.some 5))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_92807 Bool) (BOUND_VARIABLE_92808 Bool)) (or BOUND_VARIABLE_92807 BOUND_VARIABLE_92808)) (nullable.lift (lambda ((BOUND_VARIABLE_92794 Int) (BOUND_VARIABLE_92795 Int)) (> BOUND_VARIABLE_92794 BOUND_VARIABLE_92795)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_92801 Int) (BOUND_VARIABLE_92802 Int)) (> BOUND_VARIABLE_92801 BOUND_VARIABLE_92802)) ((_ tuple.select 0) t) (nullable.some 5)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 197 ms.
(reset)
;-----------------------------------------------------------
; test name: 15
;Translating sql query: SELECT * FROM emp AS emp WHERE (emp.sal = 50 OR emp.sal = 100 OR emp.empno > 5) AND (emp.sal = 50 OR emp.sal = 100)
;Translating sql query: SELECT * FROM emp AS emp WHERE emp.sal = 50 OR emp.sal = 100
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_95189 Bool) (BOUND_VARIABLE_95190 Bool)) (and BOUND_VARIABLE_95189 BOUND_VARIABLE_95190)) (nullable.lift (lambda ((BOUND_VARIABLE_95163 Bool) (BOUND_VARIABLE_95164 Bool) (BOUND_VARIABLE_95165 Bool)) (or BOUND_VARIABLE_95163 BOUND_VARIABLE_95164 BOUND_VARIABLE_95165)) (nullable.lift (lambda ((BOUND_VARIABLE_95142 Int) (BOUND_VARIABLE_95143 Int)) (= BOUND_VARIABLE_95142 BOUND_VARIABLE_95143)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_95150 Int) (BOUND_VARIABLE_95151 Int)) (= BOUND_VARIABLE_95150 BOUND_VARIABLE_95151)) ((_ tuple.select 6) t) (nullable.some 100)) (nullable.lift (lambda ((BOUND_VARIABLE_95157 Int) (BOUND_VARIABLE_95158 Int)) (> BOUND_VARIABLE_95157 BOUND_VARIABLE_95158)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.lift (lambda ((BOUND_VARIABLE_95183 Bool) (BOUND_VARIABLE_95184 Bool)) (or BOUND_VARIABLE_95183 BOUND_VARIABLE_95184)) (nullable.lift (lambda ((BOUND_VARIABLE_95171 Int) (BOUND_VARIABLE_95172 Int)) (= BOUND_VARIABLE_95171 BOUND_VARIABLE_95172)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_95177 Int) (BOUND_VARIABLE_95178 Int)) (= BOUND_VARIABLE_95177 BOUND_VARIABLE_95178)) ((_ tuple.select 6) t) (nullable.some 100))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_95218 Bool) (BOUND_VARIABLE_95219 Bool)) (or BOUND_VARIABLE_95218 BOUND_VARIABLE_95219)) (nullable.lift (lambda ((BOUND_VARIABLE_95206 Int) (BOUND_VARIABLE_95207 Int)) (= BOUND_VARIABLE_95206 BOUND_VARIABLE_95207)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_95212 Int) (BOUND_VARIABLE_95213 Int)) (= BOUND_VARIABLE_95212 BOUND_VARIABLE_95213)) ((_ tuple.select 6) t) (nullable.some 100)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 445 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (as nullable.null (Nullable Int)) (nullable.some "A") (nullable.some "B") (nullable.some 3) (nullable.some (- 3)) (nullable.some 4) (nullable.some 50) (nullable.some (- 4)) (nullable.some 5)) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (bag (tuple (as nullable.null (Nullable Int)) (nullable.some "A") (nullable.some "B") (nullable.some 3) (nullable.some (- 3)) (nullable.some 4) (nullable.some 50) (nullable.some (- 4)) (nullable.some 5)) 1)
; insert into EMP values(NULL,'A','B',3,-3,4,50,-4,5)
; SELECT * FROM (SELECT * FROM emp AS emp WHERE (emp.sal = 50 OR emp.sal = 100 OR emp.empno > 5) AND (emp.sal = 50 OR emp.sal = 100)) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM emp AS emp WHERE emp.sal = 50 OR emp.sal = 100) AS q2;

; SELECT * FROM (SELECT * FROM emp AS emp WHERE emp.sal = 50 OR emp.sal = 100) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM emp AS emp WHERE (emp.sal = 50 OR emp.sal = 100 OR emp.empno > 5) AND (emp.sal = 50 OR emp.sal = 100)) AS q1;

;Model soundness: false
(reset)
;-----------------------------------------------------------
; test name: 16
;Translating sql query: SELECT * FROM emp AS emp WHERE (emp.sal = 50 AND emp.sal = 100 AND emp.empno > 5) OR (emp.sal = 50 AND emp.sal = 100)
;Translating sql query: SELECT * FROM emp AS emp WHERE emp.sal = 50 AND emp.sal = 100
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_101485 Bool) (BOUND_VARIABLE_101486 Bool)) (or BOUND_VARIABLE_101485 BOUND_VARIABLE_101486)) (nullable.lift (lambda ((BOUND_VARIABLE_101460 Bool) (BOUND_VARIABLE_101461 Bool) (BOUND_VARIABLE_101462 Bool)) (and BOUND_VARIABLE_101460 BOUND_VARIABLE_101461 BOUND_VARIABLE_101462)) (nullable.lift (lambda ((BOUND_VARIABLE_101441 Int) (BOUND_VARIABLE_101442 Int)) (= BOUND_VARIABLE_101441 BOUND_VARIABLE_101442)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_101447 Int) (BOUND_VARIABLE_101448 Int)) (= BOUND_VARIABLE_101447 BOUND_VARIABLE_101448)) ((_ tuple.select 6) t) (nullable.some 100)) (nullable.lift (lambda ((BOUND_VARIABLE_101454 Int) (BOUND_VARIABLE_101455 Int)) (> BOUND_VARIABLE_101454 BOUND_VARIABLE_101455)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.lift (lambda ((BOUND_VARIABLE_101479 Bool) (BOUND_VARIABLE_101480 Bool)) (and BOUND_VARIABLE_101479 BOUND_VARIABLE_101480)) (nullable.lift (lambda ((BOUND_VARIABLE_101467 Int) (BOUND_VARIABLE_101468 Int)) (= BOUND_VARIABLE_101467 BOUND_VARIABLE_101468)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_101473 Int) (BOUND_VARIABLE_101474 Int)) (= BOUND_VARIABLE_101473 BOUND_VARIABLE_101474)) ((_ tuple.select 6) t) (nullable.some 100))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_101514 Bool) (BOUND_VARIABLE_101515 Bool)) (and BOUND_VARIABLE_101514 BOUND_VARIABLE_101515)) (nullable.lift (lambda ((BOUND_VARIABLE_101502 Int) (BOUND_VARIABLE_101503 Int)) (= BOUND_VARIABLE_101502 BOUND_VARIABLE_101503)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_101508 Int) (BOUND_VARIABLE_101509 Int)) (= BOUND_VARIABLE_101508 BOUND_VARIABLE_101509)) ((_ tuple.select 6) t) (nullable.some 100)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 453 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (as nullable.null (Nullable Int)) (nullable.some "A") (nullable.some "B") (nullable.some 3) (nullable.some (- 3)) (nullable.some 4) (nullable.some 100) (nullable.some (- 4)) (nullable.some 5)) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (bag (tuple (as nullable.null (Nullable Int)) (nullable.some "A") (nullable.some "B") (nullable.some 3) (nullable.some (- 3)) (nullable.some 4) (nullable.some 100) (nullable.some (- 4)) (nullable.some 5)) 1)
; insert into EMP values(NULL,'A','B',3,-3,4,100,-4,5)
; SELECT * FROM (SELECT * FROM emp AS emp WHERE (emp.sal = 50 AND emp.sal = 100 AND emp.empno > 5) OR (emp.sal = 50 AND emp.sal = 100)) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM emp AS emp WHERE emp.sal = 50 AND emp.sal = 100) AS q2;

; SELECT * FROM (SELECT * FROM emp AS emp WHERE emp.sal = 50 AND emp.sal = 100) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM emp AS emp WHERE (emp.sal = 50 AND emp.sal = 100 AND emp.empno > 5) OR (emp.sal = 50 AND emp.sal = 100)) AS q1;

;Model soundness: false
(reset)
;-----------------------------------------------------------
; test name: 17
;Translating sql query: SELECT dept.deptno = dept.deptno FROM dept AS dept
;Translating sql query: SELECT TRUE FROM dept AS dept
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Bag (Tuple (Nullable Bool))))
(declare-const q2 (Bag (Tuple (Nullable Bool))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(declare-const q1_lift_2 (-> (Tuple (Nullable Bool)) (Tuple (Nullable Bool))))
(declare-const q2_lift_3 (-> (Tuple Bool) (Tuple (Nullable Bool))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_107618 Bool) (BOUND_VARIABLE_107619 Bool)) (or BOUND_VARIABLE_107618 BOUND_VARIABLE_107619)) (as nullable.null (Nullable Bool)) (nullable.some (nullable.is_some ((_ tuple.select 0) t))))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple true))))
(assert (= q1_lift_2 (lambda ((t (Tuple (Nullable Bool)))) (tuple ((_ tuple.select 0) t)))))
(assert (= q2_lift_3 (lambda ((t (Tuple Bool))) (tuple (nullable.some ((_ tuple.select 0) t))))))
(assert (= q1 (bag.map q1_lift_2 (bag.map f0 DEPT))))
(assert (= q2 (bag.map q2_lift_3 (bag.map f1 DEPT))))
(check-sat)
;answer: sat
; duration: 247 ms.
(get-model)
; (
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (as nullable.null (Nullable Int)) (nullable.some "A")) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (as nullable.null (Nullable Bool))) 1)
; q2
(get-value (q2))
; (bag (tuple (nullable.some true)) 1)
; insert into DEPT values(NULL,'A')
; SELECT * FROM (SELECT dept.deptno = dept.deptno FROM dept AS dept) AS q1 EXCEPT ALL SELECT * FROM (SELECT TRUE FROM dept AS dept) AS q2;
;(NULL)

; SELECT * FROM (SELECT TRUE FROM dept AS dept) AS q2 EXCEPT ALL SELECT * FROM (SELECT dept.deptno = dept.deptno FROM dept AS dept) AS q1;
;(true)

;Model soundness: true
(reset)
;-----------------------------------------------------------
; test name: 18
;Translating sql query: SELECT (deptno IS NULL) = (deptno IS NULL) FROM dept
;Translating sql query: SELECT TRUE FROM dept
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Bag (Tuple Bool)))
(declare-const q2 (Bag (Tuple Bool)))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple true))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple true))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unsat
; duration: 8 ms.
(reset)
;-----------------------------------------------------------
; test name: 19
;Translating sql query: SELECT (deptno IS NULL) > (deptno IS NULL) FROM dept
;Translating sql query: SELECT FALSE FROM dept
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Bag (Tuple Bool)))
(declare-const q2 (Bag (Tuple Bool)))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple false))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple false))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unsat
; duration: 6 ms.
(reset)
;-----------------------------------------------------------
; test name: 20
;Translating sql query: SELECT (deptno IS NULL) >= (deptno IS NULL) FROM dept
;Translating sql query: SELECT TRUE FROM dept
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Bag (Tuple Bool)))
(declare-const q2 (Bag (Tuple Bool)))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple true))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple true))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unsat
; duration: 5 ms.
(reset)
;-----------------------------------------------------------
; test name: 21
;Translating sql query: SELECT (deptno IS NULL) = TRUE FROM dept
;Translating sql query: SELECT (deptno IS NULL) FROM dept
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Bag (Tuple Bool)))
(declare-const q2 (Bag (Tuple Bool)))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.is_null ((_ tuple.select 0) t))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.is_null ((_ tuple.select 0) t))))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10009 ms.
(reset)
;-----------------------------------------------------------
; test name: 22
;Translating sql query: SELECT (deptno IS NULL) = FALSE FROM dept
;Translating sql query: SELECT NOT(deptno IS NULL) FROM dept
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Bag (Tuple Bool)))
(declare-const q2 (Bag (Tuple Bool)))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.is_some ((_ tuple.select 0) t))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.is_some ((_ tuple.select 0) t))))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10061 ms.
(reset)
;-----------------------------------------------------------
; test name: 23
;Translating sql query: SELECT CASE WHEN 2>1 THEN deptno ELSE deptno + 1 END FROM dept
;Translating sql query: SELECT deptno FROM dept
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
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t)))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 ((_ table.project 0) DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10055 ms.
(reset)
;-----------------------------------------------------------
; test name: 24
;Translating sql query: SELECT CASE WHEN CAST(NULL AS BOOLEAN) THEN '' ELSE name END FROM dept
;Translating sql query: SELECT name FROM dept
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
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable String))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 1) t)))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 ((_ table.project 1) DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10073 ms.
(reset)
;-----------------------------------------------------------
; test name: 25
;Translating sql query: SELECT CASE WHEN deptno = 1 THEN TRUE ELSE FALSE END FROM dept
;Translating sql query: SELECT (deptno = 1) = TRUE FROM dept
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Bag (Tuple (Nullable Bool))))
(declare-const q2 (Bag (Tuple (Nullable Bool))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Bool))))
(declare-const q1_lift_2 (-> (Tuple Bool) (Tuple (Nullable Bool))))
(declare-const q2_lift_3 (-> (Tuple (Nullable Bool)) (Tuple (Nullable Bool))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_213929 Int) (BOUND_VARIABLE_213930 Int)) (= BOUND_VARIABLE_213929 BOUND_VARIABLE_213930)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_213947 Int) (BOUND_VARIABLE_213948 Int)) (= BOUND_VARIABLE_213947 BOUND_VARIABLE_213948)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (= q1_lift_2 (lambda ((t (Tuple Bool))) (tuple (nullable.some ((_ tuple.select 0) t))))))
(assert (= q2_lift_3 (lambda ((t (Tuple (Nullable Bool)))) (tuple ((_ tuple.select 0) t)))))
(assert (= q1 (bag.map q1_lift_2 (bag.map f0 DEPT))))
(assert (= q2 (bag.map q2_lift_3 (bag.map f1 DEPT))))
(check-sat)
;answer: sat
; duration: 305 ms.
(get-model)
; (
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 0) (as nullable.null (Nullable String))) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some true)) 1)
; q2
(get-value (q2))
; (bag (tuple (nullable.some false)) 1)
; insert into DEPT values(0,NULL)
; SELECT * FROM (SELECT CASE WHEN deptno = 1 THEN TRUE ELSE FALSE END FROM dept) AS q1 EXCEPT ALL SELECT * FROM (SELECT (deptno = 1) = TRUE FROM dept) AS q2;

; SELECT * FROM (SELECT (deptno = 1) = TRUE FROM dept) AS q2 EXCEPT ALL SELECT * FROM (SELECT CASE WHEN deptno = 1 THEN TRUE ELSE FALSE END FROM dept) AS q1;

;Model soundness: false
(reset)
;-----------------------------------------------------------
; test name: 26
;Translating sql query: SELECT CASE WHEN deptno IS NULL THEN null ELSE FALSE END FROM dept
;Translating sql query: SELECT deptno IS NULL AND CAST(null AS BOOLEAN) FROM dept
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Bag (Tuple (Nullable Bool))))
(declare-const q2 (Bag (Tuple (Nullable Bool))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Bool))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_216979 Bool) (BOUND_VARIABLE_216980 Bool)) (and BOUND_VARIABLE_216979 BOUND_VARIABLE_216980)) (nullable.some (nullable.is_null ((_ tuple.select 0) t))) (as nullable.null (Nullable Bool)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_216998 Bool) (BOUND_VARIABLE_216999 Bool)) (and BOUND_VARIABLE_216998 BOUND_VARIABLE_216999)) (nullable.some (nullable.is_null ((_ tuple.select 0) t))) (as nullable.null (Nullable Bool)))))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unsat
; duration: 11 ms.
(reset)
;-----------------------------------------------------------
; test name: 27
;Translating sql query: SELECT CASE WHEN deptno IS NULL THEN FALSE ELSE null END FROM dept
;Translating sql query: SELECT NOT(deptno IS NULL) AND CAST(null AS BOOLEAN) FROM dept
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Bag (Tuple (Nullable Bool))))
(declare-const q2 (Bag (Tuple (Nullable Bool))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Bool))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_217051 Bool) (BOUND_VARIABLE_217052 Bool)) (and BOUND_VARIABLE_217051 BOUND_VARIABLE_217052)) (as nullable.null (Nullable Bool)) (nullable.some (nullable.is_some ((_ tuple.select 0) t))))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_217069 Bool) (BOUND_VARIABLE_217070 Bool)) (and BOUND_VARIABLE_217069 BOUND_VARIABLE_217070)) (nullable.some (nullable.is_some ((_ tuple.select 0) t))) (as nullable.null (Nullable Bool)))))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unsat
; duration: 7 ms.
(reset)
;-----------------------------------------------------------
; test name: 28
;Translating sql query: SELECT CASE WHEN deptno = 1 THEN name ELSE name END FROM dept
;Translating sql query: SELECT name FROM dept
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
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable String))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 1) t)))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 ((_ table.project 1) DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10007 ms.
(reset)
;-----------------------------------------------------------
; test name: 29
;Translating sql query: SELECT CASE WHEN (2>1) THEN deptno ELSE deptno + 1 END FROM dept
;Translating sql query: SELECT deptno FROM dept
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
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t)))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 ((_ table.project 0) DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10076 ms.
(reset)
;-----------------------------------------------------------
; test name: 30
;Translating sql query: SELECT CASE WHEN deptno = 1 THEN TRUE ELSE FALSE END FROM dept
;Translating sql query: SELECT (deptno = 1) = TRUE FROM dept
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Bag (Tuple (Nullable Bool))))
(declare-const q2 (Bag (Tuple (Nullable Bool))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Bool))))
(declare-const q1_lift_2 (-> (Tuple Bool) (Tuple (Nullable Bool))))
(declare-const q2_lift_3 (-> (Tuple (Nullable Bool)) (Tuple (Nullable Bool))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_273682 Int) (BOUND_VARIABLE_273683 Int)) (= BOUND_VARIABLE_273682 BOUND_VARIABLE_273683)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_273700 Int) (BOUND_VARIABLE_273701 Int)) (= BOUND_VARIABLE_273700 BOUND_VARIABLE_273701)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (= q1_lift_2 (lambda ((t (Tuple Bool))) (tuple (nullable.some ((_ tuple.select 0) t))))))
(assert (= q2_lift_3 (lambda ((t (Tuple (Nullable Bool)))) (tuple ((_ tuple.select 0) t)))))
(assert (= q1 (bag.map q1_lift_2 (bag.map f0 DEPT))))
(assert (= q2 (bag.map q2_lift_3 (bag.map f1 DEPT))))
(check-sat)
;answer: sat
; duration: 352 ms.
(get-model)
; (
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 0) (as nullable.null (Nullable String))) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some true)) 1)
; q2
(get-value (q2))
; (bag (tuple (nullable.some false)) 1)
; insert into DEPT values(0,NULL)
; SELECT * FROM (SELECT CASE WHEN deptno = 1 THEN TRUE ELSE FALSE END FROM dept) AS q1 EXCEPT ALL SELECT * FROM (SELECT (deptno = 1) = TRUE FROM dept) AS q2;

; SELECT * FROM (SELECT (deptno = 1) = TRUE FROM dept) AS q2 EXCEPT ALL SELECT * FROM (SELECT CASE WHEN deptno = 1 THEN TRUE ELSE FALSE END FROM dept) AS q1;

;Model soundness: false
(reset)
;-----------------------------------------------------------
; test name: 31
;Translating sql query: SELECT CASE WHEN deptno = 1 THEN deptno WHEN FALSE THEN deptno +1 ELSE deptno+1 END FROM dept
;Translating sql query: SELECT CASE WHEN deptno = 1 THEN deptno ELSE deptno+1 END FROM dept
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
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_276676 Int) (BOUND_VARIABLE_276677 Int)) (= BOUND_VARIABLE_276676 BOUND_VARIABLE_276677)) ((_ tuple.select 0) t) (nullable.some 1))) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_276682 Int) (BOUND_VARIABLE_276683 Int)) (+ BOUND_VARIABLE_276682 BOUND_VARIABLE_276683)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_276701 Int) (BOUND_VARIABLE_276702 Int)) (= BOUND_VARIABLE_276701 BOUND_VARIABLE_276702)) ((_ tuple.select 0) t) (nullable.some 1))) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_276707 Int) (BOUND_VARIABLE_276708 Int)) (+ BOUND_VARIABLE_276707 BOUND_VARIABLE_276708)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10016 ms.
(reset)
;-----------------------------------------------------------
; test name: 32
;Translating sql query: SELECT CASE WHEN TRUE THEN deptno WHEN deptno = 1 THEN deptno+1 ELSE deptno+2 END FROM dept
;Translating sql query: SELECT deptno FROM dept
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
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t)))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 ((_ table.project 0) DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10078 ms.
(reset)
;-----------------------------------------------------------
; test name: 33
;Translating sql query: SELECT CASE WHEN deptno = 1 THEN deptno WHEN TRUE THEN deptno + 100 WHEN deptno = 10 THEN 10 ELSE deptno + 1 END FROM dept
;Translating sql query: SELECT CASE WHEN deptno = 1 THEN deptno WHEN TRUE THEN deptno + 100 END FROM dept
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
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_332657 Int) (BOUND_VARIABLE_332658 Int)) (= BOUND_VARIABLE_332657 BOUND_VARIABLE_332658)) ((_ tuple.select 0) t) (nullable.some 1))) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_332663 Int) (BOUND_VARIABLE_332664 Int)) (+ BOUND_VARIABLE_332663 BOUND_VARIABLE_332664)) ((_ tuple.select 0) t) (nullable.some 100)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_332682 Int) (BOUND_VARIABLE_332683 Int)) (= BOUND_VARIABLE_332682 BOUND_VARIABLE_332683)) ((_ tuple.select 0) t) (nullable.some 1))) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_332688 Int) (BOUND_VARIABLE_332689 Int)) (+ BOUND_VARIABLE_332688 BOUND_VARIABLE_332689)) ((_ tuple.select 0) t) (nullable.some 100)))))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10072 ms.
(reset)
;-----------------------------------------------------------
; test name: 34
;Translating sql query: SELECT CASE WHEN deptno = 1 THEN deptno WHEN name = 'Charlie' THEN deptno ELSE deptno END FROM dept
;Translating sql query: SELECT deptno FROM dept
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
(assert (not (= q1 q2)))
(assert (= q1 ((_ table.project 0) DEPT)))
(assert (= q2 ((_ table.project 0) DEPT)))
(check-sat)
;answer: unsat
; duration: 73 ms.
(reset)
;-----------------------------------------------------------
; test name: 35
;Translating sql query: SELECT (CASE WHEN F0_C1=100 THEN F1_C2 ELSE 2 END)=2 FROM T
;Translating sql query: SELECT CASE WHEN F0_C1=100 THEN F1_C2=2 ELSE 2=2 END FROM T
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const T (Bag (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Bool))))
(declare-const q2 (Bag (Tuple (Nullable Bool))))
(declare-const f0 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Bool))))
(assert (= f0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_361696 Int) (BOUND_VARIABLE_361697 Int)) (= BOUND_VARIABLE_361696 BOUND_VARIABLE_361697)) (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_361687 Int) (BOUND_VARIABLE_361688 Int)) (= BOUND_VARIABLE_361687 BOUND_VARIABLE_361688)) ((_ tuple.select 6) t) (nullable.some 100))) ((_ tuple.select 7) t) (nullable.some 2)) (nullable.some 2))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_361714 Int) (BOUND_VARIABLE_361715 Int)) (= BOUND_VARIABLE_361714 BOUND_VARIABLE_361715)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.lift (lambda ((BOUND_VARIABLE_361721 Int) (BOUND_VARIABLE_361722 Int)) (= BOUND_VARIABLE_361721 BOUND_VARIABLE_361722)) ((_ tuple.select 7) t) (nullable.some 2)) (nullable.some true))))))
(assert (= q1 (bag.map f0 T)))
(assert (= q2 (bag.map f1 T)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10012 ms.
(reset)
;-----------------------------------------------------------
; test name: 36
;Translating sql query: SELECT (CASE WHEN F0_C1=100 THEN F1_C2 ELSE 2 END) = 2 FROM T
;Translating sql query: SELECT CASE WHEN F0_C1=100 THEN F1_C2 = 2 ELSE 2 = 2 END FROM T
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const T (Bag (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple (Nullable Bool))))
(declare-const q2 (Bag (Tuple (Nullable Bool))))
(declare-const f0 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Bool))))
(assert (= f0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_386052 Int) (BOUND_VARIABLE_386053 Int)) (= BOUND_VARIABLE_386052 BOUND_VARIABLE_386053)) (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_386043 Int) (BOUND_VARIABLE_386044 Int)) (= BOUND_VARIABLE_386043 BOUND_VARIABLE_386044)) ((_ tuple.select 6) t) (nullable.some 100))) ((_ tuple.select 7) t) (nullable.some 2)) (nullable.some 2))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_386069 Int) (BOUND_VARIABLE_386070 Int)) (= BOUND_VARIABLE_386069 BOUND_VARIABLE_386070)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.lift (lambda ((BOUND_VARIABLE_386076 Int) (BOUND_VARIABLE_386077 Int)) (= BOUND_VARIABLE_386076 BOUND_VARIABLE_386077)) ((_ tuple.select 7) t) (nullable.some 2)) (nullable.some true))))))
(assert (= q1 (bag.map f0 T)))
(assert (= q2 (bag.map f1 T)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10092 ms.
(reset)
;-----------------------------------------------------------
; test name: 37
;Translating sql query: SELECT CASE WHEN F0_C1=100 THEN F1_C2 ELSE 2 END IS NULL FROM T
;Translating sql query: SELECT CASE WHEN F0_C1=100 THEN F1_C2 IS NULL ELSE 2 IS NULL END FROM T
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const T (Bag (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple Bool)))
(declare-const q2 (Bag (Tuple Bool)))
(declare-const f0 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple Bool)))
(declare-const f1 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple Bool)))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.is_null (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_410115 Int) (BOUND_VARIABLE_410116 Int)) (= BOUND_VARIABLE_410115 BOUND_VARIABLE_410116)) ((_ tuple.select 6) t) (nullable.some 100))) ((_ tuple.select 7) t) (nullable.some 2)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple false))))
(assert (= q1 (bag.map f0 T)))
(assert (= q2 (bag.map f1 T)))
(check-sat)
;answer: sat
; duration: 219 ms.
(get-model)
; (
; (define-fun T () (Bag (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some "A") (nullable.some "B") (nullable.some (- 3)) (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (nullable.some (- 5))) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.is_null (ite (nullable.val (as nullable.null (Nullable Bool))) (as nullable.null (Nullable Int)) (nullable.some 2)))) 1)
; q2
(get-value (q2))
; (bag (tuple false) 1)
; insert into T values('A','B',-3,4,-4,5,NULL,NULL,-5)
(reset)
;-----------------------------------------------------------
; test name: 38
;Translating sql query: SELECT (CASE WHEN F0_C1=100 THEN F1_C2 ELSE 2 END) IS NULL FROM T
;Translating sql query: SELECT CASE WHEN F0_C1=100 THEN F1_C2 IS NULL ELSE 2 IS NULL END FROM T
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const T (Bag (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Bag (Tuple Bool)))
(declare-const q2 (Bag (Tuple Bool)))
(declare-const f0 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple Bool)))
(declare-const f1 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple Bool)))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.is_null (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_412270 Int) (BOUND_VARIABLE_412271 Int)) (= BOUND_VARIABLE_412270 BOUND_VARIABLE_412271)) ((_ tuple.select 6) t) (nullable.some 100))) ((_ tuple.select 7) t) (nullable.some 2)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple false))))
(assert (= q1 (bag.map f0 T)))
(assert (= q2 (bag.map f1 T)))
(check-sat)
;answer: sat
; duration: 176 ms.
(get-model)
; (
; (define-fun T () (Bag (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some "A") (nullable.some "B") (nullable.some (- 3)) (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (nullable.some (- 5))) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.is_null (ite (nullable.val (as nullable.null (Nullable Bool))) (as nullable.null (Nullable Int)) (nullable.some 2)))) 1)
; q2
(get-value (q2))
; (bag (tuple false) 1)
; insert into T values('A','B',-3,4,-4,5,NULL,NULL,-5)
(reset)
;-----------------------------------------------------------
; test name: 41
;Translating sql query: SELECT * FROM EMP WHERE (NOT(CAST (null AS BOOLEAN))) IS NULL
;Translating sql query: SELECT * FROM EMP WHERE (CAST(null AS BOOLEAN)) IS NULL
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_414327 Bool)) (not BOUND_VARIABLE_414327)) (as nullable.null (Nullable Bool)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_null (as nullable.null (Nullable Bool))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 17 ms.
(reset)
;-----------------------------------------------------------
; test name: 43
;Translating sql query: SELECT CAST(deptno AS int) FROM dept
;Translating sql query: SELECT deptno FROM dept
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
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t)))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 ((_ table.project 0) DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10010 ms.
(reset)
;-----------------------------------------------------------
; test name: 45
;Translating sql query: SELECT UPPER(LOWER(name)) FROM dept
;Translating sql query: SELECT UPPER(name) FROM dept
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
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable String))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable String))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_442826 String)) (str.to_upper BOUND_VARIABLE_442826)) (nullable.lift (lambda ((BOUND_VARIABLE_442820 String)) (str.to_lower BOUND_VARIABLE_442820)) ((_ tuple.select 1) t)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_442842 String)) (str.to_upper BOUND_VARIABLE_442842)) ((_ tuple.select 1) t))))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10086 ms.
(reset)
;-----------------------------------------------------------
; test name: 48
;Translating sql query: SELECT * FROM emp AS emp, dept AS dept, account AS account WHERE emp.empno = dept.deptno AND emp.empno = account.acctno
;Translating sql query: SELECT emp.*, dept.*, account.* FROM emp AS emp INNER JOIN account AS account ON emp.empno = account.acctno INNER JOIN dept AS dept ON emp.empno = dept.deptno
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const ACCOUNT (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable String)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_471511 Bool) (BOUND_VARIABLE_471512 Bool)) (and BOUND_VARIABLE_471511 BOUND_VARIABLE_471512)) (nullable.lift (lambda ((BOUND_VARIABLE_471498 Int) (BOUND_VARIABLE_471499 Int)) (= BOUND_VARIABLE_471498 BOUND_VARIABLE_471499)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_471505 Int) (BOUND_VARIABLE_471506 Int)) (= BOUND_VARIABLE_471505 BOUND_VARIABLE_471506)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_471580 Int) (BOUND_VARIABLE_471581 Int)) (= BOUND_VARIABLE_471580 BOUND_VARIABLE_471581)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_471652 Int) (BOUND_VARIABLE_471653 Int)) (= BOUND_VARIABLE_471652 BOUND_VARIABLE_471653)) ((_ tuple.select 0) t) ((_ tuple.select 12) t))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13) (bag.filter p0 (table.product (table.product EMP DEPT) ACCOUNT)))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 12 13 9 10 11) (bag.filter p2 (table.product (bag.filter p1 (table.product EMP ACCOUNT)) DEPT)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10397 ms.
(reset)
;-----------------------------------------------------------
; test name: 49
;Translating sql query: SELECT T1.F0_C1, T1.F1_C0 FROM T AS T1 LEFT JOIN T AS T2 ON T1.F0_C1 = T2.F1_C0 WHERE T2.F0_C1 < 1
;Translating sql query: SELECT T1.F0_C1, T1.F1_C0 FROM T AS T1 INNER JOIN (SELECT F1_C0 FROM T WHERE F0_C1 < 1) AS T2 ON T1.F0_C1 = T2.F1_C0
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const T (Bag (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const leftJoin1 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_595186 Int) (BOUND_VARIABLE_595187 Int)) (= BOUND_VARIABLE_595186 BOUND_VARIABLE_595187)) ((_ tuple.select 6) t) ((_ tuple.select 14) t))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= p2 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_595245 Int) (BOUND_VARIABLE_595246 Int)) (< BOUND_VARIABLE_595245 BOUND_VARIABLE_595246)) ((_ tuple.select 15) t) (nullable.some 1))))))
(assert (= p3 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_595278 Int) (BOUND_VARIABLE_595279 Int)) (< BOUND_VARIABLE_595278 BOUND_VARIABLE_595279)) ((_ tuple.select 6) t) (nullable.some 1))))))
(assert (not (= q1 q2)))
(assert (= p4 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_595340 Int) (BOUND_VARIABLE_595341 Int)) (= BOUND_VARIABLE_595340 BOUND_VARIABLE_595341)) ((_ tuple.select 6) t) ((_ tuple.select 9) t))))))
(assert (= q1 ((_ table.project 6 5) (bag.filter p2 (bag.union_disjoint (bag.map leftJoin1 (bag.difference_remove T ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 (table.product T T))))) (bag.filter p0 (table.product T T)))))))
(assert (= q2 ((_ table.project 6 5) (bag.filter p4 (table.product T ((_ table.project 5) (bag.filter p3 T)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10228 ms.
(reset)
;-----------------------------------------------------------
; test name: 50
;Translating sql query: SELECT DISTINCT T1.F1_C0 FROM T AS T1 LEFT JOIN T AS T2 ON T1.F0_C1 = T2.F0_C1
;Translating sql query: SELECT DISTINCT T1.F1_C0 FROM T AS T1
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const T (Bag (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(declare-const leftJoin1 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_638538 Int) (BOUND_VARIABLE_638539 Int)) (= BOUND_VARIABLE_638538 BOUND_VARIABLE_638539)) ((_ tuple.select 6) t) ((_ tuple.select 15) t))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= q1 ((_ table.project 0) ((_ table.project 5) (bag.union_disjoint (bag.map leftJoin1 (bag.difference_remove T ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 (table.product T T))))) (bag.filter p0 (table.product T T)))))))
(assert (= q2 ((_ table.project 0) ((_ table.project 5) T))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10414 ms.
(reset)
;-----------------------------------------------------------
; test name: 52
;Translating sql query: SELECT * FROM T WHERE F0_C1 = -0
;Translating sql query: SELECT * FROM T WHERE F0_C1 = 0
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const T (Bag (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_692460 Int) (BOUND_VARIABLE_692461 Int)) (= BOUND_VARIABLE_692460 BOUND_VARIABLE_692461)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_692478 Int) (BOUND_VARIABLE_692479 Int)) (= BOUND_VARIABLE_692478 BOUND_VARIABLE_692479)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 T))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 T))))
(check-sat)
;answer: unsat
; duration: 462 ms.
(reset)
;-----------------------------------------------------------
; test name: 59
;Translating sql query: SELECT dept.deptno AS deptno, dept.name AS name FROM dept AS dept
;Translating sql query: SELECT dept.deptno, dept.name FROM dept AS dept
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= q1 ((_ table.project 0 1) DEPT)))
(assert (= q2 ((_ table.project 0 1) DEPT)))
(check-sat)
;answer: unsat
; duration: 8 ms.
(reset)
;-----------------------------------------------------------
; test name: 60
;Translating sql query: SELECT DISTINCT * FROM ((SELECT * FROM dept as dept0) UNION ALL (SELECT * FROM dept as dept1)) t0
;Translating sql query: SELECT DISTINCT * FROM dept as dept0
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= q1 ((_ table.project 0 1) ((_ table.project 0 1) (bag.union_disjoint ((_ table.project 0 1) DEPT) ((_ table.project 0 1) DEPT))))))
(assert (= q2 ((_ table.project 0 1) ((_ table.project 0 1) DEPT))))
(check-sat)
;answer: sat
; duration: 95 ms.
(get-model)
; (
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))) 2)
; q2
(get-value (q2))
; (bag (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))) 1)
; insert into DEPT values(NULL,NULL)
; SELECT * FROM (SELECT DISTINCT * FROM ((SELECT * FROM dept as dept0) UNION ALL (SELECT * FROM dept as dept1)) t0) AS q1 EXCEPT ALL SELECT * FROM (SELECT DISTINCT * FROM dept as dept0) AS q2;

; SELECT * FROM (SELECT DISTINCT * FROM dept as dept0) AS q2 EXCEPT ALL SELECT * FROM (SELECT DISTINCT * FROM ((SELECT * FROM dept as dept0) UNION ALL (SELECT * FROM dept as dept1)) t0) AS q1;

;Model soundness: false
(reset)
;-----------------------------------------------------------
; test name: 63
;Translating sql query: SELECT t0.name FROM ((SELECT * FROM dept as dept0) UNION ALL (SELECT * FROM dept as dept1)) t0
;Translating sql query: SELECT t0.name FROM ((SELECT dept0.name FROM dept as dept0) UNION ALL (SELECT dept1.name FROM dept as dept1)) t0
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
(assert (not (= q1 q2)))
(assert (= q1 ((_ table.project 1) (bag.union_disjoint ((_ table.project 0 1) DEPT) ((_ table.project 0 1) DEPT)))))
(assert (= q2 ((_ table.project 0) (bag.union_disjoint ((_ table.project 1) DEPT) ((_ table.project 1) DEPT)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10010 ms.
(reset)
;-----------------------------------------------------------
; test name: 65
;Translating sql query: SELECT dept0.name FROM (SELECT dept.deptno, dept.name FROM dept AS dept) dept0 WHERE dept0.deptno > 1
;Translating sql query: SELECT dept.name FROM dept AS dept WHERE dept.deptno > 1
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_718675 Int) (BOUND_VARIABLE_718676 Int)) (> BOUND_VARIABLE_718675 BOUND_VARIABLE_718676)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_718693 Int) (BOUND_VARIABLE_718694 Int)) (> BOUND_VARIABLE_718693 BOUND_VARIABLE_718694)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (= q1 ((_ table.project 1) (bag.filter p0 ((_ table.project 0 1) DEPT)))))
(assert (= q2 ((_ table.project 1) (bag.filter p1 DEPT))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10122 ms.
(reset)
;-----------------------------------------------------------
; test name: 66
;Translating sql query: SELECT t0.c1 FROM (SELECT 1 AS c1, 2 AS c2 FROM dept AS dept) AS t0
;Translating sql query: SELECT 1 AS c1 FROM dept AS dept
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Bag (Tuple Int)))
(declare-const q2 (Bag (Tuple Int)))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Int)))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Int)))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple 1))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple 1))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unsat
; duration: 106 ms.
(reset)
;-----------------------------------------------------------
; test name: 67
;Translating sql query: SELECT t0.name FROM (SELECT dept.name, dept.deptno FROM dept AS dept) AS t0
;Translating sql query: SELECT dept.name FROM dept AS dept
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
(assert (not (= q1 q2)))
(assert (= q1 ((_ table.project 1) DEPT)))
(assert (= q2 ((_ table.project 1) DEPT)))
(check-sat)
;answer: unsat
; duration: 4 ms.
(reset)
;-----------------------------------------------------------
; test name: 68
;Translating sql query: SELECT * FROM dept WHERE deptno > 1
;Translating sql query: SELECT * FROM dept WHERE deptno > 1 AND NOT(deptno IS NULL)
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_749800 Int) (BOUND_VARIABLE_749801 Int)) (> BOUND_VARIABLE_749800 BOUND_VARIABLE_749801)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_749827 Bool) (BOUND_VARIABLE_749828 Bool)) (and BOUND_VARIABLE_749827 BOUND_VARIABLE_749828)) (nullable.lift (lambda ((BOUND_VARIABLE_749818 Int) (BOUND_VARIABLE_749819 Int)) (> BOUND_VARIABLE_749818 BOUND_VARIABLE_749819)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 DEPT))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 85 ms.
(reset)
;-----------------------------------------------------------
; test name: 69
;Translating sql query: SELECT * FROM emp INNER JOIN dept ON emp.empno = dept.deptno AND emp.empno = 1
;Translating sql query: SELECT * FROM (SELECT * FROM emp WHERE NOT empno IS NULL AND empno = 1) emp0 INNER JOIN (SELECT * FROM dept WHERE NOT deptno IS NULL AND deptno = 1) dept0 ON emp0.empno = dept0.deptno AND emp0.empno = 1
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
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 0) t)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_751183 Bool) (BOUND_VARIABLE_751184 Bool)) (and BOUND_VARIABLE_751183 BOUND_VARIABLE_751184)) (nullable.lift (lambda ((BOUND_VARIABLE_751170 Int) (BOUND_VARIABLE_751171 Int)) (= BOUND_VARIABLE_751170 BOUND_VARIABLE_751171)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_751177 Int) (BOUND_VARIABLE_751178 Int)) (= BOUND_VARIABLE_751177 BOUND_VARIABLE_751178)) ((_ tuple.select 9) t) (nullable.some 1)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_751211 Bool) (BOUND_VARIABLE_751212 Bool)) (and BOUND_VARIABLE_751211 BOUND_VARIABLE_751212)) (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))) (nullable.lift (lambda ((BOUND_VARIABLE_751204 Int) (BOUND_VARIABLE_751205 Int)) (= BOUND_VARIABLE_751204 BOUND_VARIABLE_751205)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 0) t)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_751254 Bool) (BOUND_VARIABLE_751255 Bool)) (and BOUND_VARIABLE_751254 BOUND_VARIABLE_751255)) (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))) (nullable.lift (lambda ((BOUND_VARIABLE_751247 Int) (BOUND_VARIABLE_751248 Int)) (= BOUND_VARIABLE_751247 BOUND_VARIABLE_751248)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_751286 Bool) (BOUND_VARIABLE_751287 Bool)) (and BOUND_VARIABLE_751286 BOUND_VARIABLE_751287)) (nullable.lift (lambda ((BOUND_VARIABLE_751273 Int) (BOUND_VARIABLE_751274 Int)) (= BOUND_VARIABLE_751273 BOUND_VARIABLE_751274)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_751280 Int) (BOUND_VARIABLE_751281 Int)) (= BOUND_VARIABLE_751280 BOUND_VARIABLE_751281)) ((_ tuple.select 9) t) (nullable.some 1)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 10 11) (bag.filter p1 (table.product (bag.map f0 EMP) DEPT)))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 10 11) (bag.filter p5 (table.product (bag.map f3 (bag.filter p2 EMP)) ((_ table.project 0 1) (bag.filter p4 DEPT)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10031 ms.
(reset)
;-----------------------------------------------------------
; test name: 70
;Translating sql query: SELECT * FROM emp LEFT JOIN dept ON emp.empno = dept.deptno AND emp.empno = 1
;Translating sql query: SELECT * FROM emp emp0 LEFT JOIN (SELECT * FROM dept WHERE NOT deptno IS NULL AND deptno = 1) dept0 ON emp0.empno = dept0.deptno AND emp0.empno = 1
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
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const leftJoin2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const leftJoin6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 0) t)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_794815 Bool) (BOUND_VARIABLE_794816 Bool)) (and BOUND_VARIABLE_794815 BOUND_VARIABLE_794816)) (nullable.lift (lambda ((BOUND_VARIABLE_794802 Int) (BOUND_VARIABLE_794803 Int)) (= BOUND_VARIABLE_794802 BOUND_VARIABLE_794803)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_794809 Int) (BOUND_VARIABLE_794810 Int)) (= BOUND_VARIABLE_794809 BOUND_VARIABLE_794810)) ((_ tuple.select 9) t) (nullable.some 1)))))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 9) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 0) t)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_794896 Bool) (BOUND_VARIABLE_794897 Bool)) (and BOUND_VARIABLE_794896 BOUND_VARIABLE_794897)) (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))) (nullable.lift (lambda ((BOUND_VARIABLE_794889 Int) (BOUND_VARIABLE_794890 Int)) (= BOUND_VARIABLE_794889 BOUND_VARIABLE_794890)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_794928 Bool) (BOUND_VARIABLE_794929 Bool)) (and BOUND_VARIABLE_794928 BOUND_VARIABLE_794929)) (nullable.lift (lambda ((BOUND_VARIABLE_794915 Int) (BOUND_VARIABLE_794916 Int)) (= BOUND_VARIABLE_794915 BOUND_VARIABLE_794916)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_794922 Int) (BOUND_VARIABLE_794923 Int)) (= BOUND_VARIABLE_794922 BOUND_VARIABLE_794923)) ((_ tuple.select 9) t) (nullable.some 1)))))))
(assert (= leftJoin6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 9) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 10 11) (bag.union_disjoint (bag.map leftJoin2 (bag.difference_remove (bag.map f0 EMP) ((_ table.project 0 1 2 3 4 5 6 7 8 9) (bag.filter p1 (table.product (bag.map f0 EMP) DEPT))))) (bag.filter p1 (table.product (bag.map f0 EMP) DEPT))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 10 11) (bag.union_disjoint (bag.map leftJoin6 (bag.difference_remove (bag.map f3 EMP) ((_ table.project 0 1 2 3 4 5 6 7 8 9) (bag.filter p5 (table.product (bag.map f3 EMP) ((_ table.project 0 1) (bag.filter p4 DEPT))))))) (bag.filter p5 (table.product (bag.map f3 EMP) ((_ table.project 0 1) (bag.filter p4 DEPT))))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10288 ms.
(reset)
;-----------------------------------------------------------
; test name: 71
;Translating sql query: SELECT tmp.empno, tmp.sal FROM (SELECT emp.empno, emp.sal FROM emp AS emp WHERE emp.sal = 3) AS tmp WHERE tmp.empno > 1
;Translating sql query: SELECT tmp.empno, tmp.sal FROM (SELECT emp.empno, emp.sal FROM emp AS emp WHERE emp.sal = 3 AND emp.empno > 1) AS tmp
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
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_837222 Int) (BOUND_VARIABLE_837223 Int)) (= BOUND_VARIABLE_837222 BOUND_VARIABLE_837223)) ((_ tuple.select 6) t) (nullable.some 3))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_837241 Int) (BOUND_VARIABLE_837242 Int)) (> BOUND_VARIABLE_837241 BOUND_VARIABLE_837242)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_837272 Bool) (BOUND_VARIABLE_837273 Bool)) (and BOUND_VARIABLE_837272 BOUND_VARIABLE_837273)) (nullable.lift (lambda ((BOUND_VARIABLE_837259 Int) (BOUND_VARIABLE_837260 Int)) (= BOUND_VARIABLE_837259 BOUND_VARIABLE_837260)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_837266 Int) (BOUND_VARIABLE_837267 Int)) (> BOUND_VARIABLE_837266 BOUND_VARIABLE_837267)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p1 ((_ table.project 0 6) (bag.filter p0 EMP))))))
(assert (= q2 ((_ table.project 0 6) (bag.filter p2 EMP))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10246 ms.
(reset)
;-----------------------------------------------------------
; test name: 77
;Translating sql query: SELECT * FROM emp AS emp WHERE TRUE
;Translating sql query: SELECT * FROM emp AS emp
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
(assert (not (= q1 q2)))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) EMP)))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) EMP)))
(check-sat)
;answer: unsat
; duration: 223 ms.
(reset)
;-----------------------------------------------------------
; test name: 78
;Translating sql query: SELECT * FROM (SELECT * FROM emp AS emp WHERE emp.empno > 10) t0 WHERE t0.empno > 10
;Translating sql query: SELECT * FROM (SELECT * FROM emp AS emp WHERE emp.empno > 10) t0
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_871803 Int) (BOUND_VARIABLE_871804 Int)) (> BOUND_VARIABLE_871803 BOUND_VARIABLE_871804)) ((_ tuple.select 0) t) (nullable.some 10))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_871821 Int) (BOUND_VARIABLE_871822 Int)) (> BOUND_VARIABLE_871821 BOUND_VARIABLE_871822)) ((_ tuple.select 0) t) (nullable.some 10))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_871838 Int) (BOUND_VARIABLE_871839 Int)) (> BOUND_VARIABLE_871838 BOUND_VARIABLE_871839)) ((_ tuple.select 0) t) (nullable.some 10))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP))))
(check-sat)
;answer: unsat
; duration: 184 ms.
(reset)
;-----------------------------------------------------------
; test name: 79
;Translating sql query: SELECT * FROM (SELECT * FROM emp AS emp WHERE emp.empno > 10) t0 WHERE t0.empno > 10 AND t0.empno > 0
;Translating sql query: SELECT * FROM (SELECT * FROM emp AS emp WHERE emp.empno > 10) t0 WHERE t0.empno > 0
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_873864 Int) (BOUND_VARIABLE_873865 Int)) (> BOUND_VARIABLE_873864 BOUND_VARIABLE_873865)) ((_ tuple.select 0) t) (nullable.some 10))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_873893 Bool) (BOUND_VARIABLE_873894 Bool)) (and BOUND_VARIABLE_873893 BOUND_VARIABLE_873894)) (nullable.lift (lambda ((BOUND_VARIABLE_873881 Int) (BOUND_VARIABLE_873882 Int)) (> BOUND_VARIABLE_873881 BOUND_VARIABLE_873882)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_873887 Int) (BOUND_VARIABLE_873888 Int)) (> BOUND_VARIABLE_873887 BOUND_VARIABLE_873888)) ((_ tuple.select 0) t) (nullable.some 0)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_873910 Int) (BOUND_VARIABLE_873911 Int)) (> BOUND_VARIABLE_873910 BOUND_VARIABLE_873911)) ((_ tuple.select 0) t) (nullable.some 10))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_873927 Int) (BOUND_VARIABLE_873928 Int)) (> BOUND_VARIABLE_873927 BOUND_VARIABLE_873928)) ((_ tuple.select 0) t) (nullable.some 0))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP))))))
(check-sat)
;answer: unsat
; duration: 373 ms.
(reset)
;-----------------------------------------------------------
; test name: 80
;Translating sql query: SELECT * FROM (SELECT * FROM emp AS emp WHERE emp.empno > 10) t0 WHERE t0.empno > 10 AND t0.empno > 0 AND t0.sal > 1
;Translating sql query: SELECT * FROM (SELECT * FROM emp AS emp WHERE emp.empno > 10) t0 WHERE t0.empno > 0 AND t0.sal > 1
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_877535 Int) (BOUND_VARIABLE_877536 Int)) (> BOUND_VARIABLE_877535 BOUND_VARIABLE_877536)) ((_ tuple.select 0) t) (nullable.some 10))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_877572 Bool) (BOUND_VARIABLE_877573 Bool) (BOUND_VARIABLE_877574 Bool)) (and BOUND_VARIABLE_877572 BOUND_VARIABLE_877573 BOUND_VARIABLE_877574)) (nullable.lift (lambda ((BOUND_VARIABLE_877553 Int) (BOUND_VARIABLE_877554 Int)) (> BOUND_VARIABLE_877553 BOUND_VARIABLE_877554)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_877559 Int) (BOUND_VARIABLE_877560 Int)) (> BOUND_VARIABLE_877559 BOUND_VARIABLE_877560)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_877566 Int) (BOUND_VARIABLE_877567 Int)) (> BOUND_VARIABLE_877566 BOUND_VARIABLE_877567)) ((_ tuple.select 6) t) (nullable.some 1)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_877590 Int) (BOUND_VARIABLE_877591 Int)) (> BOUND_VARIABLE_877590 BOUND_VARIABLE_877591)) ((_ tuple.select 0) t) (nullable.some 10))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_877620 Bool) (BOUND_VARIABLE_877621 Bool)) (and BOUND_VARIABLE_877620 BOUND_VARIABLE_877621)) (nullable.lift (lambda ((BOUND_VARIABLE_877607 Int) (BOUND_VARIABLE_877608 Int)) (> BOUND_VARIABLE_877607 BOUND_VARIABLE_877608)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_877614 Int) (BOUND_VARIABLE_877615 Int)) (> BOUND_VARIABLE_877614 BOUND_VARIABLE_877615)) ((_ tuple.select 6) t) (nullable.some 1)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP))))))
(check-sat)
;answer: unsat
; duration: 414 ms.
(reset)
;-----------------------------------------------------------
; test name: 81
;Translating sql query: SELECT * FROM (SELECT * FROM dept AS dept UNION ALL SELECT * FROM dept AS dept0) t0 WHERE t0.deptno = 0
;Translating sql query: SELECT * FROM dept AS dept WHERE dept.deptno = 0 UNION ALL SELECT * FROM dept AS dept0 WHERE dept0.deptno = 0
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_882327 Int) (BOUND_VARIABLE_882328 Int)) (= BOUND_VARIABLE_882327 BOUND_VARIABLE_882328)) ((_ tuple.select 0) t) (nullable.some 0))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_882345 Int) (BOUND_VARIABLE_882346 Int)) (= BOUND_VARIABLE_882345 BOUND_VARIABLE_882346)) ((_ tuple.select 0) t) (nullable.some 0))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_882362 Int) (BOUND_VARIABLE_882363 Int)) (= BOUND_VARIABLE_882362 BOUND_VARIABLE_882363)) ((_ tuple.select 0) t) (nullable.some 0))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 (bag.union_disjoint ((_ table.project 0 1) DEPT) ((_ table.project 0 1) DEPT))))))
(assert (= q2 (bag.union_disjoint ((_ table.project 0 1) (bag.filter p1 DEPT)) ((_ table.project 0 1) (bag.filter p2 DEPT)))))
(check-sat)
;answer: unsat
; duration: 326 ms.
(reset)
;-----------------------------------------------------------
; test name: 83
;Translating sql query: SELECT * FROM (SELECT dept.deptno FROM dept AS dept) t0 WHERE t0.deptno > 10
;Translating sql query: SELECT dept.deptno FROM dept AS dept WHERE dept.deptno > 10
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_884725 Int) (BOUND_VARIABLE_884726 Int)) (> BOUND_VARIABLE_884725 BOUND_VARIABLE_884726)) ((_ tuple.select 0) t) (nullable.some 10))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_884742 Int) (BOUND_VARIABLE_884743 Int)) (> BOUND_VARIABLE_884742 BOUND_VARIABLE_884743)) ((_ tuple.select 0) t) (nullable.some 10))))))
(assert (= q1 ((_ table.project 0) (bag.filter p0 ((_ table.project 0) DEPT)))))
(assert (= q2 ((_ table.project 0) (bag.filter p1 DEPT))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10015 ms.
(reset)
;-----------------------------------------------------------
; test name: 84
;Translating sql query: SELECT * FROM (SELECT DISTINCT dept.deptno FROM dept AS dept) t0 WHERE t0.deptno > 10
;Translating sql query: SELECT DISTINCT dept.deptno FROM dept AS dept WHERE dept.deptno > 10
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_915080 Int) (BOUND_VARIABLE_915081 Int)) (> BOUND_VARIABLE_915080 BOUND_VARIABLE_915081)) ((_ tuple.select 0) t) (nullable.some 10))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_915098 Int) (BOUND_VARIABLE_915099 Int)) (> BOUND_VARIABLE_915098 BOUND_VARIABLE_915099)) ((_ tuple.select 0) t) (nullable.some 10))))))
(assert (= q1 ((_ table.project 0) (bag.filter p0 ((_ table.project 0) ((_ table.project 0) DEPT))))))
(assert (= q2 ((_ table.project 0) ((_ table.project 0) (bag.filter p1 DEPT)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10110 ms.
(reset)
;-----------------------------------------------------------
; test name: 86
;Translating sql query: SELECT * FROM emp RIGHT JOIN dept ON emp.deptno = dept.deptno WHERE emp.sal > 0 AND dept.deptno = 1
;Translating sql query: SELECT * FROM emp RIGHT JOIN (SELECT * FROM dept WHERE dept.deptno = 1) t0 ON emp.deptno = t0.deptno WHERE emp.sal > 0
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const rightJoin1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const rightJoin5 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_945970 Int) (BOUND_VARIABLE_945971 Int)) (= BOUND_VARIABLE_945970 BOUND_VARIABLE_945971)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))))
(assert (= rightJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_946029 Bool) (BOUND_VARIABLE_946030 Bool)) (and BOUND_VARIABLE_946029 BOUND_VARIABLE_946030)) (nullable.lift (lambda ((BOUND_VARIABLE_946016 Int) (BOUND_VARIABLE_946017 Int)) (> BOUND_VARIABLE_946016 BOUND_VARIABLE_946017)) ((_ tuple.select 6) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_946023 Int) (BOUND_VARIABLE_946024 Int)) (= BOUND_VARIABLE_946023 BOUND_VARIABLE_946024)) ((_ tuple.select 9) t) (nullable.some 1)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_946047 Int) (BOUND_VARIABLE_946048 Int)) (= BOUND_VARIABLE_946047 BOUND_VARIABLE_946048)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_946066 Int) (BOUND_VARIABLE_946067 Int)) (= BOUND_VARIABLE_946066 BOUND_VARIABLE_946067)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))))
(assert (= rightJoin5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_946108 Int) (BOUND_VARIABLE_946109 Int)) (> BOUND_VARIABLE_946108 BOUND_VARIABLE_946109)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p2 (bag.union_disjoint (bag.map rightJoin1 (bag.difference_remove DEPT ((_ table.project 9 10) (bag.filter p0 (table.product EMP DEPT))))) (bag.filter p0 (table.product EMP DEPT)))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p6 (bag.union_disjoint (bag.map rightJoin5 (bag.difference_remove ((_ table.project 0 1) (bag.filter p3 DEPT)) ((_ table.project 9 10) (bag.filter p4 (table.product EMP ((_ table.project 0 1) (bag.filter p3 DEPT))))))) (bag.filter p4 (table.product EMP ((_ table.project 0 1) (bag.filter p3 DEPT)))))))))
(check-sat)
;answer: unsat
; duration: 719 ms.
(reset)
;-----------------------------------------------------------
; test name: 87
;Translating sql query: SELECT * FROM emp LEFT JOIN dept ON emp.deptno = dept.deptno WHERE emp.sal > 0 AND dept.deptno = 1
;Translating sql query: SELECT * FROM (SELECT * FROM emp WHERE emp.sal > 0) t0 LEFT JOIN dept ON t0.deptno = dept.deptno WHERE dept.deptno = 1
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
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const leftJoin1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const leftJoin5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_951237 Int) (BOUND_VARIABLE_951238 Int)) (= BOUND_VARIABLE_951237 BOUND_VARIABLE_951238)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_951301 Bool) (BOUND_VARIABLE_951302 Bool)) (and BOUND_VARIABLE_951301 BOUND_VARIABLE_951302)) (nullable.lift (lambda ((BOUND_VARIABLE_951288 Int) (BOUND_VARIABLE_951289 Int)) (> BOUND_VARIABLE_951288 BOUND_VARIABLE_951289)) ((_ tuple.select 6) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_951295 Int) (BOUND_VARIABLE_951296 Int)) (= BOUND_VARIABLE_951295 BOUND_VARIABLE_951296)) ((_ tuple.select 9) t) (nullable.some 1)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_951318 Int) (BOUND_VARIABLE_951319 Int)) (> BOUND_VARIABLE_951318 BOUND_VARIABLE_951319)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_951337 Int) (BOUND_VARIABLE_951338 Int)) (= BOUND_VARIABLE_951337 BOUND_VARIABLE_951338)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))))
(assert (= leftJoin5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_951386 Int) (BOUND_VARIABLE_951387 Int)) (= BOUND_VARIABLE_951386 BOUND_VARIABLE_951387)) ((_ tuple.select 9) t) (nullable.some 1))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p2 (bag.union_disjoint (bag.map leftJoin1 (bag.difference_remove EMP ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 (table.product EMP DEPT))))) (bag.filter p0 (table.product EMP DEPT)))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p6 (bag.union_disjoint (bag.map leftJoin5 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) DEPT))))) (bag.filter p4 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) DEPT)))))))
(check-sat)
;answer: unsat
; duration: 631 ms.
(reset)
;-----------------------------------------------------------
; test name: 88
;Translating sql query: SELECT * FROM emp AS emp INNER JOIN dept AS dept ON emp.deptno = dept.deptno AND emp.sal > 0 AND dept.deptno = 1
;Translating sql query: SELECT * FROM (SELECT * FROM emp AS emp WHERE emp.sal > 0) t0 INNER JOIN (SELECT * FROM dept AS dept WHERE dept.deptno = 1) t1 ON t0.deptno = t1.deptno
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
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_956715 Int) (BOUND_VARIABLE_956716 Int)) (> BOUND_VARIABLE_956715 BOUND_VARIABLE_956716)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_956856 Bool) (BOUND_VARIABLE_956857 Bool) (BOUND_VARIABLE_956858 Bool)) (and BOUND_VARIABLE_956856 BOUND_VARIABLE_956857 BOUND_VARIABLE_956858)) (nullable.lift (lambda ((BOUND_VARIABLE_956842 Int) (BOUND_VARIABLE_956843 Int)) (= BOUND_VARIABLE_956842 BOUND_VARIABLE_956843)) ((_ tuple.select 7) t) ((_ tuple.select 10) t)) ((_ tuple.select 9) t) (nullable.lift (lambda ((BOUND_VARIABLE_956850 Int) (BOUND_VARIABLE_956851 Int)) (= BOUND_VARIABLE_956850 BOUND_VARIABLE_956851)) ((_ tuple.select 12) t) (nullable.some 1)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_956875 Int) (BOUND_VARIABLE_956876 Int)) (> BOUND_VARIABLE_956875 BOUND_VARIABLE_956876)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_956892 Int) (BOUND_VARIABLE_956893 Int)) (= BOUND_VARIABLE_956892 BOUND_VARIABLE_956893)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_956911 Int) (BOUND_VARIABLE_956912 Int)) (= BOUND_VARIABLE_956911 BOUND_VARIABLE_956912)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 10 11) (bag.filter p2 (table.product (bag.map f0 EMP) (bag.map f1 DEPT))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p5 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1) (bag.filter p4 DEPT)))))))
(check-sat)
;answer: unsat
; duration: 2034 ms.
(reset)
;-----------------------------------------------------------
; test name: 89
;Translating sql query: SELECT * FROM emp RIGHT JOIN dept ON emp.deptno = dept.deptno AND emp.sal > 0 AND dept.deptno = 1
;Translating sql query: SELECT * FROM (SELECT * FROM emp WHERE emp.sal > 0) t0 RIGHT JOIN dept ON t0.deptno = dept.deptno AND dept.deptno = 1
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
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const rightJoin3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const f5 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_967792 Int) (BOUND_VARIABLE_967793 Int)) (> BOUND_VARIABLE_967792 BOUND_VARIABLE_967793)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_967837 Bool) (BOUND_VARIABLE_967838 Bool) (BOUND_VARIABLE_967839 Bool)) (and BOUND_VARIABLE_967837 BOUND_VARIABLE_967838 BOUND_VARIABLE_967839)) (nullable.lift (lambda ((BOUND_VARIABLE_967823 Int) (BOUND_VARIABLE_967824 Int)) (= BOUND_VARIABLE_967823 BOUND_VARIABLE_967824)) ((_ tuple.select 7) t) ((_ tuple.select 10) t)) ((_ tuple.select 9) t) (nullable.lift (lambda ((BOUND_VARIABLE_967831 Int) (BOUND_VARIABLE_967832 Int)) (= BOUND_VARIABLE_967831 BOUND_VARIABLE_967832)) ((_ tuple.select 12) t) (nullable.some 1)))))))
(assert (= rightJoin3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Bool)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_967886 Int) (BOUND_VARIABLE_967887 Int)) (> BOUND_VARIABLE_967886 BOUND_VARIABLE_967887)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_967976 Bool) (BOUND_VARIABLE_967977 Bool)) (and BOUND_VARIABLE_967976 BOUND_VARIABLE_967977)) (nullable.lift (lambda ((BOUND_VARIABLE_967963 Int) (BOUND_VARIABLE_967964 Int)) (= BOUND_VARIABLE_967963 BOUND_VARIABLE_967964)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_967970 Int) (BOUND_VARIABLE_967971 Int)) (= BOUND_VARIABLE_967970 BOUND_VARIABLE_967971)) ((_ tuple.select 11) t) (nullable.some 1)))))))
(assert (= rightJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 10 11) (bag.union_disjoint (bag.map rightJoin3 (bag.difference_remove (bag.map f1 DEPT) ((_ table.project 10 11 12) (bag.filter p2 (table.product (bag.map f0 EMP) (bag.map f1 DEPT)))))) (bag.filter p2 (table.product (bag.map f0 EMP) (bag.map f1 DEPT)))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map rightJoin7 (bag.difference_remove (bag.map f5 DEPT) ((_ table.project 9 10 11) (bag.filter p6 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)) (bag.map f5 DEPT)))))) (bag.filter p6 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)) (bag.map f5 DEPT)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10198 ms.
(reset)
;-----------------------------------------------------------
; test name: 90
;Translating sql query: SELECT * FROM emp LEFT JOIN dept ON emp.deptno = dept.deptno AND emp.sal > 0 AND dept.deptno = 1
;Translating sql query: SELECT * FROM emp LEFT JOIN (SELECT * FROM dept WHERE dept.deptno = 1) t0 ON emp.deptno = t0.deptno AND emp.sal > 0
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
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String)) Bool))
(declare-const leftJoin3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const leftJoin7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_1012185 Int) (BOUND_VARIABLE_1012186 Int)) (> BOUND_VARIABLE_1012185 BOUND_VARIABLE_1012186)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1012230 Bool) (BOUND_VARIABLE_1012231 Bool) (BOUND_VARIABLE_1012232 Bool)) (and BOUND_VARIABLE_1012230 BOUND_VARIABLE_1012231 BOUND_VARIABLE_1012232)) (nullable.lift (lambda ((BOUND_VARIABLE_1012216 Int) (BOUND_VARIABLE_1012217 Int)) (= BOUND_VARIABLE_1012216 BOUND_VARIABLE_1012217)) ((_ tuple.select 7) t) ((_ tuple.select 10) t)) ((_ tuple.select 9) t) (nullable.lift (lambda ((BOUND_VARIABLE_1012224 Int) (BOUND_VARIABLE_1012225 Int)) (= BOUND_VARIABLE_1012224 BOUND_VARIABLE_1012225)) ((_ tuple.select 12) t) (nullable.some 1)))))))
(assert (= leftJoin3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 9) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_1012293 Int) (BOUND_VARIABLE_1012294 Int)) (> BOUND_VARIABLE_1012293 BOUND_VARIABLE_1012294)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1012309 Int) (BOUND_VARIABLE_1012310 Int)) (= BOUND_VARIABLE_1012309 BOUND_VARIABLE_1012310)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1012384 Bool) (BOUND_VARIABLE_1012385 Bool)) (and BOUND_VARIABLE_1012384 BOUND_VARIABLE_1012385)) (nullable.lift (lambda ((BOUND_VARIABLE_1012377 Int) (BOUND_VARIABLE_1012378 Int)) (= BOUND_VARIABLE_1012377 BOUND_VARIABLE_1012378)) ((_ tuple.select 7) t) ((_ tuple.select 10) t)) ((_ tuple.select 9) t))))))
(assert (= leftJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 9) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 10 11) (bag.union_disjoint (bag.map leftJoin3 (bag.difference_remove (bag.map f0 EMP) ((_ table.project 0 1 2 3 4 5 6 7 8 9) (bag.filter p2 (table.product (bag.map f0 EMP) (bag.map f1 DEPT)))))) (bag.filter p2 (table.product (bag.map f0 EMP) (bag.map f1 DEPT)))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 10 11) (bag.union_disjoint (bag.map leftJoin7 (bag.difference_remove (bag.map f4 EMP) ((_ table.project 0 1 2 3 4 5 6 7 8 9) (bag.filter p6 (table.product (bag.map f4 EMP) ((_ table.project 0 1) (bag.filter p5 DEPT))))))) (bag.filter p6 (table.product (bag.map f4 EMP) ((_ table.project 0 1) (bag.filter p5 DEPT))))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10312 ms.
(reset)
;-----------------------------------------------------------
; test name: 92
;Translating sql query: SELECT c1 FROM (VALUES (1, 2)) AS t0(c1, c2)
;Translating sql query: SELECT * FROM (VALUES (1)) AS t0(c1)
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const q1 (Bag (Tuple Int)))
(declare-const q2 (Bag (Tuple Int)))
(assert (not (= q1 q2)))
(assert (= q1 ((_ table.project 0) (bag (tuple 1 2) 1))))
(assert (= q2 ((_ table.project 0) (bag (tuple 1) 1))))
(check-sat)
;answer: unsat
; duration: 321 ms.
(reset)
;-----------------------------------------------------------
; test name: 93
;Translating sql query: SELECT * FROM (VALUES (1, 2), (3, 3)) AS t0(c1, c2) WHERE t0.c1 = t0.c2
;Translating sql query: SELECT * FROM (VALUES (3, 3)) AS t0(c1, c2)
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const p0 (-> (Tuple Int Int) Bool))
(declare-const q1 (Bag (Tuple Int Int)))
(declare-const q2 (Bag (Tuple Int Int)))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple Int Int))) (= ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 (bag.union_disjoint (bag (tuple 1 2) 1) (bag (tuple 3 3) 1))))))
(assert (= q2 ((_ table.project 0 1) (bag (tuple 3 3) 1))))
(check-sat)
;answer: unsat
; duration: 15 ms.
(reset)
;-----------------------------------------------------------
; test name: 98
;Translating sql query: SELECT * FROM dept AS dept WHERE FALSE UNION ALL SELECT * FROM dept AS dept0 WHERE FALSE
;Translating sql query: SELECT * FROM dept AS dept WHERE FALSE
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (= q1 (bag.union_disjoint ((_ table.project 0 1) (bag.filter p0 DEPT)) ((_ table.project 0 1) (bag.filter p1 DEPT)))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p2 DEPT))))
(check-sat)
;answer: unsat
; duration: 62 ms.
(reset)
;-----------------------------------------------------------
; test name: 99
;Translating sql query: SELECT * FROM dept AS dept UNION ALL SELECT * FROM dept AS dept0 WHERE FALSE
;Translating sql query: SELECT * FROM dept AS dept
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (= q1 (bag.union_disjoint ((_ table.project 0 1) DEPT) ((_ table.project 0 1) (bag.filter p0 DEPT)))))
(assert (= q2 ((_ table.project 0 1) DEPT)))
(check-sat)
;answer: unsat
; duration: 51 ms.
(reset)
;-----------------------------------------------------------
; test name: 100
;Translating sql query: SELECT * FROM dept UNION ALL SELECT * FROM dept WHERE CAST(NULL AS BOOLEAN) AND TRUE
;Translating sql query: SELECT * FROM dept
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1058798 Bool) (BOUND_VARIABLE_1058799 Bool)) (and BOUND_VARIABLE_1058798 BOUND_VARIABLE_1058799)) (as nullable.null (Nullable Bool)) (nullable.some true))))))
(assert (= q1 (bag.union_disjoint ((_ table.project 0 1) DEPT) ((_ table.project 0 1) (bag.filter p0 DEPT)))))
(assert (= q2 ((_ table.project 0 1) DEPT)))
(check-sat)
;answer: unsat
; duration: 54 ms.
(reset)
;-----------------------------------------------------------
; test name: 101
;Translating sql query: SELECT * FROM dept AS dept UNION ALL SELECT * FROM dept AS dept0 UNION ALL SELECT * FROM dept AS dept1 WHERE FALSE
;Translating sql query: SELECT * FROM dept AS dept UNION ALL SELECT * FROM dept AS dept0
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (= q1 (bag.union_disjoint (bag.union_disjoint ((_ table.project 0 1) DEPT) ((_ table.project 0 1) DEPT)) ((_ table.project 0 1) (bag.filter p0 DEPT)))))
(assert (= q2 (bag.union_disjoint ((_ table.project 0 1) DEPT) ((_ table.project 0 1) DEPT))))
(check-sat)
;answer: unsat
; duration: 47 ms.
(reset)
;-----------------------------------------------------------
; test name: 102
;Translating sql query: SELECT dept.deptno FROM dept AS dept WHERE FALSE UNION ALL SELECT emp.empno FROM emp AS emp
;Translating sql query: SELECT emp.empno AS deptno FROM emp AS emp
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
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (= q1 (bag.union_disjoint ((_ table.project 0) (bag.filter p0 DEPT)) ((_ table.project 0) EMP))))
(assert (= q2 ((_ table.project 0) EMP)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10084 ms.
(reset)
;-----------------------------------------------------------
; test name: 104
;Translating sql query: SELECT * FROM emp AS emp INNER JOIN dept AS dept ON (emp.empno < 10 AND dept.deptno < 10) OR (emp.empno > 20 AND dept.deptno > 20)
;Translating sql query: SELECT * FROM (SELECT * FROM emp AS emp WHERE emp.empno < 10 OR emp.empno > 20) emp0 INNER JOIN (SELECT * FROM dept AS dept WHERE dept.deptno < 10 OR dept.deptno > 20) dept0 ON (emp0.empno < 10 AND dept0.deptno < 10) OR (emp0.empno > 20 AND dept0.deptno > 20)
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1089177 Bool) (BOUND_VARIABLE_1089178 Bool)) (or BOUND_VARIABLE_1089177 BOUND_VARIABLE_1089178)) (nullable.lift (lambda ((BOUND_VARIABLE_1089151 Bool) (BOUND_VARIABLE_1089152 Bool)) (and BOUND_VARIABLE_1089151 BOUND_VARIABLE_1089152)) (nullable.lift (lambda ((BOUND_VARIABLE_1089138 Int) (BOUND_VARIABLE_1089139 Int)) (< BOUND_VARIABLE_1089138 BOUND_VARIABLE_1089139)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1089145 Int) (BOUND_VARIABLE_1089146 Int)) (< BOUND_VARIABLE_1089145 BOUND_VARIABLE_1089146)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1089171 Bool) (BOUND_VARIABLE_1089172 Bool)) (and BOUND_VARIABLE_1089171 BOUND_VARIABLE_1089172)) (nullable.lift (lambda ((BOUND_VARIABLE_1089159 Int) (BOUND_VARIABLE_1089160 Int)) (> BOUND_VARIABLE_1089159 BOUND_VARIABLE_1089160)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_1089165 Int) (BOUND_VARIABLE_1089166 Int)) (> BOUND_VARIABLE_1089165 BOUND_VARIABLE_1089166)) ((_ tuple.select 9) t) (nullable.some 20))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1089207 Bool) (BOUND_VARIABLE_1089208 Bool)) (or BOUND_VARIABLE_1089207 BOUND_VARIABLE_1089208)) (nullable.lift (lambda ((BOUND_VARIABLE_1089195 Int) (BOUND_VARIABLE_1089196 Int)) (< BOUND_VARIABLE_1089195 BOUND_VARIABLE_1089196)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1089201 Int) (BOUND_VARIABLE_1089202 Int)) (> BOUND_VARIABLE_1089201 BOUND_VARIABLE_1089202)) ((_ tuple.select 0) t) (nullable.some 20)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1089236 Bool) (BOUND_VARIABLE_1089237 Bool)) (or BOUND_VARIABLE_1089236 BOUND_VARIABLE_1089237)) (nullable.lift (lambda ((BOUND_VARIABLE_1089224 Int) (BOUND_VARIABLE_1089225 Int)) (< BOUND_VARIABLE_1089224 BOUND_VARIABLE_1089225)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1089230 Int) (BOUND_VARIABLE_1089231 Int)) (> BOUND_VARIABLE_1089230 BOUND_VARIABLE_1089231)) ((_ tuple.select 0) t) (nullable.some 20)))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1089291 Bool) (BOUND_VARIABLE_1089292 Bool)) (or BOUND_VARIABLE_1089291 BOUND_VARIABLE_1089292)) (nullable.lift (lambda ((BOUND_VARIABLE_1089267 Bool) (BOUND_VARIABLE_1089268 Bool)) (and BOUND_VARIABLE_1089267 BOUND_VARIABLE_1089268)) (nullable.lift (lambda ((BOUND_VARIABLE_1089254 Int) (BOUND_VARIABLE_1089255 Int)) (< BOUND_VARIABLE_1089254 BOUND_VARIABLE_1089255)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1089261 Int) (BOUND_VARIABLE_1089262 Int)) (< BOUND_VARIABLE_1089261 BOUND_VARIABLE_1089262)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1089285 Bool) (BOUND_VARIABLE_1089286 Bool)) (and BOUND_VARIABLE_1089285 BOUND_VARIABLE_1089286)) (nullable.lift (lambda ((BOUND_VARIABLE_1089273 Int) (BOUND_VARIABLE_1089274 Int)) (> BOUND_VARIABLE_1089273 BOUND_VARIABLE_1089274)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_1089279 Int) (BOUND_VARIABLE_1089280 Int)) (> BOUND_VARIABLE_1089279 BOUND_VARIABLE_1089280)) ((_ tuple.select 9) t) (nullable.some 20))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p0 (table.product EMP DEPT)))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p3 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)) ((_ table.project 0 1) (bag.filter p2 DEPT)))))))
(check-sat)
;answer: unsat
; duration: 1095 ms.
(reset)
;-----------------------------------------------------------
; test name: 105
;Translating sql query: SELECT * FROM emp AS emp INNER JOIN dept AS dept ON (emp.empno > 10 AND emp.empno <= 20) OR (emp.empno > 20 AND dept.deptno > 20)
;Translating sql query: SELECT * FROM (SELECT * FROM emp AS emp WHERE (emp.empno > 10 AND emp.empno <= 20) OR emp.empno > 20) emp0 INNER JOIN dept AS dept ON (emp0.empno > 10 AND emp0.empno <= 20) OR (emp0.empno > 20 AND dept.deptno > 20)
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
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1097494 Bool) (BOUND_VARIABLE_1097495 Bool)) (or BOUND_VARIABLE_1097494 BOUND_VARIABLE_1097495)) (nullable.lift (lambda ((BOUND_VARIABLE_1097469 Bool) (BOUND_VARIABLE_1097470 Bool)) (and BOUND_VARIABLE_1097469 BOUND_VARIABLE_1097470)) (nullable.lift (lambda ((BOUND_VARIABLE_1097457 Int) (BOUND_VARIABLE_1097458 Int)) (> BOUND_VARIABLE_1097457 BOUND_VARIABLE_1097458)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1097463 Int) (BOUND_VARIABLE_1097464 Int)) (<= BOUND_VARIABLE_1097463 BOUND_VARIABLE_1097464)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.lift (lambda ((BOUND_VARIABLE_1097488 Bool) (BOUND_VARIABLE_1097489 Bool)) (and BOUND_VARIABLE_1097488 BOUND_VARIABLE_1097489)) (nullable.lift (lambda ((BOUND_VARIABLE_1097475 Int) (BOUND_VARIABLE_1097476 Int)) (> BOUND_VARIABLE_1097475 BOUND_VARIABLE_1097476)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_1097482 Int) (BOUND_VARIABLE_1097483 Int)) (> BOUND_VARIABLE_1097482 BOUND_VARIABLE_1097483)) ((_ tuple.select 9) t) (nullable.some 20))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1097536 Bool) (BOUND_VARIABLE_1097537 Bool)) (or BOUND_VARIABLE_1097536 BOUND_VARIABLE_1097537)) (nullable.lift (lambda ((BOUND_VARIABLE_1097524 Bool) (BOUND_VARIABLE_1097525 Bool)) (and BOUND_VARIABLE_1097524 BOUND_VARIABLE_1097525)) (nullable.lift (lambda ((BOUND_VARIABLE_1097512 Int) (BOUND_VARIABLE_1097513 Int)) (> BOUND_VARIABLE_1097512 BOUND_VARIABLE_1097513)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1097518 Int) (BOUND_VARIABLE_1097519 Int)) (<= BOUND_VARIABLE_1097518 BOUND_VARIABLE_1097519)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.lift (lambda ((BOUND_VARIABLE_1097530 Int) (BOUND_VARIABLE_1097531 Int)) (> BOUND_VARIABLE_1097530 BOUND_VARIABLE_1097531)) ((_ tuple.select 0) t) (nullable.some 20)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1097591 Bool) (BOUND_VARIABLE_1097592 Bool)) (or BOUND_VARIABLE_1097591 BOUND_VARIABLE_1097592)) (nullable.lift (lambda ((BOUND_VARIABLE_1097566 Bool) (BOUND_VARIABLE_1097567 Bool)) (and BOUND_VARIABLE_1097566 BOUND_VARIABLE_1097567)) (nullable.lift (lambda ((BOUND_VARIABLE_1097554 Int) (BOUND_VARIABLE_1097555 Int)) (> BOUND_VARIABLE_1097554 BOUND_VARIABLE_1097555)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1097560 Int) (BOUND_VARIABLE_1097561 Int)) (<= BOUND_VARIABLE_1097560 BOUND_VARIABLE_1097561)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.lift (lambda ((BOUND_VARIABLE_1097585 Bool) (BOUND_VARIABLE_1097586 Bool)) (and BOUND_VARIABLE_1097585 BOUND_VARIABLE_1097586)) (nullable.lift (lambda ((BOUND_VARIABLE_1097572 Int) (BOUND_VARIABLE_1097573 Int)) (> BOUND_VARIABLE_1097572 BOUND_VARIABLE_1097573)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_1097579 Int) (BOUND_VARIABLE_1097580 Int)) (> BOUND_VARIABLE_1097579 BOUND_VARIABLE_1097580)) ((_ tuple.select 9) t) (nullable.some 20))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p0 (table.product EMP DEPT)))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p2 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)) DEPT)))))
(check-sat)
;answer: unsat
; duration: 790 ms.
(reset)
;-----------------------------------------------------------
; test name: 106
;Translating sql query: SELECT * FROM emp LEFT JOIN dept ON (emp.empno < 10 AND dept.deptno < 10) OR (emp.empno > 20 AND dept.deptno > 20)
;Translating sql query: SELECT * FROM emp emp0 LEFT JOIN (SELECT * FROM dept WHERE dept.deptno < 10 OR dept.deptno > 20) dept0 ON (emp0.empno < 10 AND dept0.deptno < 10) OR (emp0.empno > 20 AND dept0.deptno > 20)
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const leftJoin4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const leftJoin1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1104513 Bool) (BOUND_VARIABLE_1104514 Bool)) (or BOUND_VARIABLE_1104513 BOUND_VARIABLE_1104514)) (nullable.lift (lambda ((BOUND_VARIABLE_1104489 Bool) (BOUND_VARIABLE_1104490 Bool)) (and BOUND_VARIABLE_1104489 BOUND_VARIABLE_1104490)) (nullable.lift (lambda ((BOUND_VARIABLE_1104476 Int) (BOUND_VARIABLE_1104477 Int)) (< BOUND_VARIABLE_1104476 BOUND_VARIABLE_1104477)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1104483 Int) (BOUND_VARIABLE_1104484 Int)) (< BOUND_VARIABLE_1104483 BOUND_VARIABLE_1104484)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1104507 Bool) (BOUND_VARIABLE_1104508 Bool)) (and BOUND_VARIABLE_1104507 BOUND_VARIABLE_1104508)) (nullable.lift (lambda ((BOUND_VARIABLE_1104495 Int) (BOUND_VARIABLE_1104496 Int)) (> BOUND_VARIABLE_1104495 BOUND_VARIABLE_1104496)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_1104501 Int) (BOUND_VARIABLE_1104502 Int)) (> BOUND_VARIABLE_1104501 BOUND_VARIABLE_1104502)) ((_ tuple.select 9) t) (nullable.some 20))))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1104576 Bool) (BOUND_VARIABLE_1104577 Bool)) (or BOUND_VARIABLE_1104576 BOUND_VARIABLE_1104577)) (nullable.lift (lambda ((BOUND_VARIABLE_1104564 Int) (BOUND_VARIABLE_1104565 Int)) (< BOUND_VARIABLE_1104564 BOUND_VARIABLE_1104565)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1104570 Int) (BOUND_VARIABLE_1104571 Int)) (> BOUND_VARIABLE_1104570 BOUND_VARIABLE_1104571)) ((_ tuple.select 0) t) (nullable.some 20)))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1104631 Bool) (BOUND_VARIABLE_1104632 Bool)) (or BOUND_VARIABLE_1104631 BOUND_VARIABLE_1104632)) (nullable.lift (lambda ((BOUND_VARIABLE_1104607 Bool) (BOUND_VARIABLE_1104608 Bool)) (and BOUND_VARIABLE_1104607 BOUND_VARIABLE_1104608)) (nullable.lift (lambda ((BOUND_VARIABLE_1104594 Int) (BOUND_VARIABLE_1104595 Int)) (< BOUND_VARIABLE_1104594 BOUND_VARIABLE_1104595)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1104601 Int) (BOUND_VARIABLE_1104602 Int)) (< BOUND_VARIABLE_1104601 BOUND_VARIABLE_1104602)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1104625 Bool) (BOUND_VARIABLE_1104626 Bool)) (and BOUND_VARIABLE_1104625 BOUND_VARIABLE_1104626)) (nullable.lift (lambda ((BOUND_VARIABLE_1104613 Int) (BOUND_VARIABLE_1104614 Int)) (> BOUND_VARIABLE_1104613 BOUND_VARIABLE_1104614)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_1104619 Int) (BOUND_VARIABLE_1104620 Int)) (> BOUND_VARIABLE_1104619 BOUND_VARIABLE_1104620)) ((_ tuple.select 9) t) (nullable.some 20))))))))
(assert (= leftJoin4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map leftJoin1 (bag.difference_remove EMP ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 (table.product EMP DEPT))))) (bag.filter p0 (table.product EMP DEPT))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map leftJoin4 (bag.difference_remove EMP ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 (table.product EMP ((_ table.project 0 1) (bag.filter p2 DEPT))))))) (bag.filter p3 (table.product EMP ((_ table.project 0 1) (bag.filter p2 DEPT))))))))
(check-sat)
;answer: unsat
; duration: 3595 ms.
(reset)
;-----------------------------------------------------------
; test name: 107
;Translating sql query: SELECT * FROM emp RIGHT JOIN dept ON (emp.empno < 10 AND dept.deptno < 10) OR (emp.empno > 20 AND dept.deptno > 20)
;Translating sql query: SELECT * FROM (SELECT * FROM emp WHERE emp.empno < 10 OR emp.empno > 20) emp0 RIGHT JOIN dept dept0 ON (emp0.empno < 10 AND dept0.deptno < 10) OR (emp0.empno > 20 AND dept0.deptno > 20)
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
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const rightJoin1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const rightJoin4 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1121573 Bool) (BOUND_VARIABLE_1121574 Bool)) (or BOUND_VARIABLE_1121573 BOUND_VARIABLE_1121574)) (nullable.lift (lambda ((BOUND_VARIABLE_1121549 Bool) (BOUND_VARIABLE_1121550 Bool)) (and BOUND_VARIABLE_1121549 BOUND_VARIABLE_1121550)) (nullable.lift (lambda ((BOUND_VARIABLE_1121536 Int) (BOUND_VARIABLE_1121537 Int)) (< BOUND_VARIABLE_1121536 BOUND_VARIABLE_1121537)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1121543 Int) (BOUND_VARIABLE_1121544 Int)) (< BOUND_VARIABLE_1121543 BOUND_VARIABLE_1121544)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1121567 Bool) (BOUND_VARIABLE_1121568 Bool)) (and BOUND_VARIABLE_1121567 BOUND_VARIABLE_1121568)) (nullable.lift (lambda ((BOUND_VARIABLE_1121555 Int) (BOUND_VARIABLE_1121556 Int)) (> BOUND_VARIABLE_1121555 BOUND_VARIABLE_1121556)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_1121561 Int) (BOUND_VARIABLE_1121562 Int)) (> BOUND_VARIABLE_1121561 BOUND_VARIABLE_1121562)) ((_ tuple.select 9) t) (nullable.some 20))))))))
(assert (= rightJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1121629 Bool) (BOUND_VARIABLE_1121630 Bool)) (or BOUND_VARIABLE_1121629 BOUND_VARIABLE_1121630)) (nullable.lift (lambda ((BOUND_VARIABLE_1121617 Int) (BOUND_VARIABLE_1121618 Int)) (< BOUND_VARIABLE_1121617 BOUND_VARIABLE_1121618)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1121623 Int) (BOUND_VARIABLE_1121624 Int)) (> BOUND_VARIABLE_1121623 BOUND_VARIABLE_1121624)) ((_ tuple.select 0) t) (nullable.some 20)))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1121684 Bool) (BOUND_VARIABLE_1121685 Bool)) (or BOUND_VARIABLE_1121684 BOUND_VARIABLE_1121685)) (nullable.lift (lambda ((BOUND_VARIABLE_1121660 Bool) (BOUND_VARIABLE_1121661 Bool)) (and BOUND_VARIABLE_1121660 BOUND_VARIABLE_1121661)) (nullable.lift (lambda ((BOUND_VARIABLE_1121647 Int) (BOUND_VARIABLE_1121648 Int)) (< BOUND_VARIABLE_1121647 BOUND_VARIABLE_1121648)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1121654 Int) (BOUND_VARIABLE_1121655 Int)) (< BOUND_VARIABLE_1121654 BOUND_VARIABLE_1121655)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1121678 Bool) (BOUND_VARIABLE_1121679 Bool)) (and BOUND_VARIABLE_1121678 BOUND_VARIABLE_1121679)) (nullable.lift (lambda ((BOUND_VARIABLE_1121666 Int) (BOUND_VARIABLE_1121667 Int)) (> BOUND_VARIABLE_1121666 BOUND_VARIABLE_1121667)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_1121672 Int) (BOUND_VARIABLE_1121673 Int)) (> BOUND_VARIABLE_1121672 BOUND_VARIABLE_1121673)) ((_ tuple.select 9) t) (nullable.some 20))))))))
(assert (= rightJoin4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map rightJoin1 (bag.difference_remove DEPT ((_ table.project 9 10) (bag.filter p0 (table.product EMP DEPT))))) (bag.filter p0 (table.product EMP DEPT))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map rightJoin4 (bag.difference_remove DEPT ((_ table.project 9 10) (bag.filter p3 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)) DEPT))))) (bag.filter p3 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)) DEPT))))))
(check-sat)
;answer: unsat
; duration: 3548 ms.
(reset)
;-----------------------------------------------------------
; test name: 109
;Translating sql query: SELECT * FROM emp WHERE empno > 0 EXCEPT SELECT * FROM emp WHERE empno < 10
;Translating sql query: SELECT DISTINCT * FROM emp WHERE empno > 0 AND NOT COALESCE(empno < 10, FALSE)
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1138264 Int) (BOUND_VARIABLE_1138265 Int)) (> BOUND_VARIABLE_1138264 BOUND_VARIABLE_1138265)) ((_ tuple.select 0) t) (nullable.some 0))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1138282 Int) (BOUND_VARIABLE_1138283 Int)) (< BOUND_VARIABLE_1138282 BOUND_VARIABLE_1138283)) ((_ tuple.select 0) t) (nullable.some 10))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1138331 Bool) (BOUND_VARIABLE_1138332 Bool)) (and BOUND_VARIABLE_1138331 BOUND_VARIABLE_1138332)) (nullable.lift (lambda ((BOUND_VARIABLE_1138300 Int) (BOUND_VARIABLE_1138301 Int)) (> BOUND_VARIABLE_1138300 BOUND_VARIABLE_1138301)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_1138326 Bool)) (not BOUND_VARIABLE_1138326)) (ite (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1138312 Int) (BOUND_VARIABLE_1138313 Int)) (< BOUND_VARIABLE_1138312 BOUND_VARIABLE_1138313)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1138319 Int) (BOUND_VARIABLE_1138320 Int)) (< BOUND_VARIABLE_1138319 BOUND_VARIABLE_1138320)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some false))))))))
(assert (= q1 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)))))
(check-sat)
;answer: unknown (INCOMPLETE)
; duration: 519 ms.
(reset)
;-----------------------------------------------------------
; test name: 110
;Translating sql query: SELECT * FROM emp WHERE CAST(NULL AS BOOLEAN) AND TRUE
;Translating sql query: SELECT * FROM emp WHERE FALSE
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1143115 Bool) (BOUND_VARIABLE_1143116 Bool)) (and BOUND_VARIABLE_1143115 BOUND_VARIABLE_1143116)) (as nullable.null (Nullable Bool)) (nullable.some true))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) false)))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 18 ms.
(reset)
;-----------------------------------------------------------
; test name: 111
;Translating sql query: SELECT * FROM emp WHERE (empno = 0) OR CAST(NULL AS BOOLEAN)
;Translating sql query: SELECT * FROM emp WHERE (empno = 0) OR FALSE
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1143199 Bool) (BOUND_VARIABLE_1143200 Bool)) (or BOUND_VARIABLE_1143199 BOUND_VARIABLE_1143200)) (nullable.lift (lambda ((BOUND_VARIABLE_1143193 Int) (BOUND_VARIABLE_1143194 Int)) (= BOUND_VARIABLE_1143193 BOUND_VARIABLE_1143194)) ((_ tuple.select 0) t) (nullable.some 0)) (as nullable.null (Nullable Bool)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1143222 Bool) (BOUND_VARIABLE_1143223 Bool)) (or BOUND_VARIABLE_1143222 BOUND_VARIABLE_1143223)) (nullable.lift (lambda ((BOUND_VARIABLE_1143216 Int) (BOUND_VARIABLE_1143217 Int)) (= BOUND_VARIABLE_1143216 BOUND_VARIABLE_1143217)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.some false))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 224 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 0) (nullable.some "A") (nullable.some "B") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (nullable.some (- 6))) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 0) (nullable.some "A") (nullable.some "B") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (nullable.some (- 6))) 1)
; insert into EMP values(0,'A','B',4,-4,5,-5,6,-6)
; SELECT * FROM (SELECT * FROM emp WHERE (empno = 0) OR CAST(NULL AS BOOLEAN)) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM emp WHERE (empno = 0) OR FALSE) AS q2;

; SELECT * FROM (SELECT * FROM emp WHERE (empno = 0) OR FALSE) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM emp WHERE (empno = 0) OR CAST(NULL AS BOOLEAN)) AS q1;

;Model soundness: false
(reset)
;-----------------------------------------------------------
; test name: 112
;Translating sql query: SELECT * FROM emp WHERE emp.empno > 0 AND CAST(NULL AS BOOLEAN)
;Translating sql query: SELECT * FROM emp WHERE emp.empno > 0 AND FALSE
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1145183 Bool) (BOUND_VARIABLE_1145184 Bool)) (and BOUND_VARIABLE_1145183 BOUND_VARIABLE_1145184)) (nullable.lift (lambda ((BOUND_VARIABLE_1145177 Int) (BOUND_VARIABLE_1145178 Int)) (> BOUND_VARIABLE_1145177 BOUND_VARIABLE_1145178)) ((_ tuple.select 0) t) (nullable.some 0)) (as nullable.null (Nullable Bool)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1145207 Bool) (BOUND_VARIABLE_1145208 Bool)) (and BOUND_VARIABLE_1145207 BOUND_VARIABLE_1145208)) (nullable.lift (lambda ((BOUND_VARIABLE_1145201 Int) (BOUND_VARIABLE_1145202 Int)) (> BOUND_VARIABLE_1145201 BOUND_VARIABLE_1145202)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.some false))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 142 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 1) (nullable.some "A") (nullable.some "B") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (nullable.some (- 6))) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 1) (nullable.some "A") (nullable.some "B") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (nullable.some (- 6))) 1)
; insert into EMP values(1,'A','B',4,-4,5,-5,6,-6)
; SELECT * FROM (SELECT * FROM emp WHERE emp.empno > 0 AND CAST(NULL AS BOOLEAN)) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM emp WHERE emp.empno > 0 AND FALSE) AS q2;

; SELECT * FROM (SELECT * FROM emp WHERE emp.empno > 0 AND FALSE) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM emp WHERE emp.empno > 0 AND CAST(NULL AS BOOLEAN)) AS q1;

;Model soundness: false
(reset)
;-----------------------------------------------------------
; test name: 113
;Translating sql query: SELECT * FROM emp WHERE CASE WHEN empno = 1 THEN FALSE ELSE CAST(NULL AS BOOLEAN) END
;Translating sql query: SELECT * FROM emp WHERE CASE WHEN empno = 1 THEN FALSE ELSE FALSE END
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1147076 Int) (BOUND_VARIABLE_1147077 Int)) (= BOUND_VARIABLE_1147076 BOUND_VARIABLE_1147077)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.some false) (as nullable.null (Nullable Bool)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1147095 Int) (BOUND_VARIABLE_1147096 Int)) (= BOUND_VARIABLE_1147095 BOUND_VARIABLE_1147096)) ((_ tuple.select 0) t) (nullable.some 1))) false false))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 140 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (as nullable.null (Nullable Int)) (nullable.some "A") (nullable.some "B") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (nullable.some (- 6))) 1))
; )
; q1
(get-value (q1))
; ((_ table.project 0 1 2 3 4 5 6 7 8) (ite (nullable.is_some (ite (nullable.val (as nullable.null (Nullable Bool))) (nullable.some false) (as nullable.null (Nullable Bool)))) (bag (tuple (as nullable.null (Nullable Int)) (nullable.some "A") (nullable.some "B") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (nullable.some (- 6))) 1) (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))))
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; insert into EMP values(NULL,'A','B',4,-4,5,-5,6,-6)
; SELECT * FROM (SELECT * FROM emp WHERE CASE WHEN empno = 1 THEN FALSE ELSE CAST(NULL AS BOOLEAN) END) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM emp WHERE CASE WHEN empno = 1 THEN FALSE ELSE FALSE END) AS q2;

; SELECT * FROM (SELECT * FROM emp WHERE CASE WHEN empno = 1 THEN FALSE ELSE FALSE END) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM emp WHERE CASE WHEN empno = 1 THEN FALSE ELSE CAST(NULL AS BOOLEAN) END) AS q1;

;Model soundness: false
(reset)
;-----------------------------------------------------------
; test name: 114
;Translating sql query: SELECT * FROM emp WHERE CASE WHEN empno = 1 THEN CAST(NULL AS BOOLEAN) ELSE TRUE END
;Translating sql query: SELECT * FROM emp WHERE CASE WHEN empno = 1 THEN FALSE ELSE TRUE END
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1148758 Int) (BOUND_VARIABLE_1148759 Int)) (= BOUND_VARIABLE_1148758 BOUND_VARIABLE_1148759)) ((_ tuple.select 0) t) (nullable.some 1))) (as nullable.null (Nullable Bool)) (nullable.some true))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1148777 Int) (BOUND_VARIABLE_1148778 Int)) (= BOUND_VARIABLE_1148777 BOUND_VARIABLE_1148778)) ((_ tuple.select 0) t) (nullable.some 1))) false true))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 191 ms.
(reset)
;-----------------------------------------------------------
; test name: 115
;Translating sql query: SELECT * FROM emp WHERE CASE WHEN empno = 1 OR CAST(NULL AS BOOLEAN) THEN sal < 10 ELSE sal > 10 END
;Translating sql query: SELECT * FROM emp WHERE CASE WHEN empno = 1 OR FALSE THEN sal < 10 ELSE sal > 10 END
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150158 Bool) (BOUND_VARIABLE_1150159 Bool)) (or BOUND_VARIABLE_1150158 BOUND_VARIABLE_1150159)) (nullable.lift (lambda ((BOUND_VARIABLE_1150152 Int) (BOUND_VARIABLE_1150153 Int)) (= BOUND_VARIABLE_1150152 BOUND_VARIABLE_1150153)) ((_ tuple.select 0) t) (nullable.some 1)) (as nullable.null (Nullable Bool)))) (nullable.lift (lambda ((BOUND_VARIABLE_1150165 Int) (BOUND_VARIABLE_1150166 Int)) (< BOUND_VARIABLE_1150165 BOUND_VARIABLE_1150166)) ((_ tuple.select 6) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1150171 Int) (BOUND_VARIABLE_1150172 Int)) (> BOUND_VARIABLE_1150171 BOUND_VARIABLE_1150172)) ((_ tuple.select 6) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150196 Bool) (BOUND_VARIABLE_1150197 Bool)) (or BOUND_VARIABLE_1150196 BOUND_VARIABLE_1150197)) (nullable.lift (lambda ((BOUND_VARIABLE_1150190 Int) (BOUND_VARIABLE_1150191 Int)) (= BOUND_VARIABLE_1150190 BOUND_VARIABLE_1150191)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some false))) (nullable.lift (lambda ((BOUND_VARIABLE_1150203 Int) (BOUND_VARIABLE_1150204 Int)) (< BOUND_VARIABLE_1150203 BOUND_VARIABLE_1150204)) ((_ tuple.select 6) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1150209 Int) (BOUND_VARIABLE_1150210 Int)) (> BOUND_VARIABLE_1150209 BOUND_VARIABLE_1150210)) ((_ tuple.select 6) t) (nullable.some 10)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 116 ms.
(reset)
;-----------------------------------------------------------
; test name: 116
;Translating sql query: SELECT * FROM emp INNER JOIN dept ON NOT emp.empno IN (dept.deptno, CAST (NULL as int))
;Translating sql query: SELECT * FROM emp INNER JOIN dept ON FALSE
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
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1152012 Bool)) (not BOUND_VARIABLE_1152012)) (nullable.lift (lambda ((BOUND_VARIABLE_1152006 Bool) (BOUND_VARIABLE_1152007 Bool)) (or BOUND_VARIABLE_1152006 BOUND_VARIABLE_1152007)) (nullable.lift (lambda ((BOUND_VARIABLE_1151994 Int) (BOUND_VARIABLE_1151995 Int)) (= BOUND_VARIABLE_1151994 BOUND_VARIABLE_1151995)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_1152000 Int) (BOUND_VARIABLE_1152001 Int)) (= BOUND_VARIABLE_1152000 BOUND_VARIABLE_1152001)) ((_ tuple.select 0) t) (as nullable.null (Nullable Int)))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) false)))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p0 (table.product EMP DEPT)))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p1 (table.product EMP DEPT)))))
(check-sat)
;answer: unsat
; duration: 10 ms.
(reset)
;-----------------------------------------------------------
; test name: 117
;Translating sql query: SELECT * FROM emp WHERE CASE WHEN TRUE AND CAST(NULL AS BOOLEAN) THEN  FALSE OR CAST(NULL AS BOOLEAN) ELSE CAST(NULL AS BOOLEAN) AND CAST(NULL AS BOOLEAN) END
;Translating sql query: SELECT * FROM emp WHERE CASE WHEN TRUE AND FALSE THEN FALSE OR FALSE ELSE FALSE AND FALSE END
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
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_some (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1152091 Bool) (BOUND_VARIABLE_1152092 Bool)) (and BOUND_VARIABLE_1152091 BOUND_VARIABLE_1152092)) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.lift (lambda ((BOUND_VARIABLE_1152097 Bool) (BOUND_VARIABLE_1152098 Bool)) (or BOUND_VARIABLE_1152097 BOUND_VARIABLE_1152098)) (nullable.some false) (as nullable.null (Nullable Bool))) (nullable.lift (lambda ((BOUND_VARIABLE_1152103 Bool) (BOUND_VARIABLE_1152104 Bool)) (and BOUND_VARIABLE_1152103 BOUND_VARIABLE_1152104)) (as nullable.null (Nullable Bool)) (as nullable.null (Nullable Bool))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (ite (and true false) (or false false) (and false false)))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 7 ms.
(reset)
;-----------------------------------------------------------
; test name: 118
;Translating sql query: SELECT TRUE = ((empno = 1) OR CAST(NULL AS BOOLEAN)) FROM emp
;Translating sql query: SELECT TRUE = ((empno = 1) OR FALSE) FROM emp
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
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Bool))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_1152204 Bool) (BOUND_VARIABLE_1152205 Bool)) (or BOUND_VARIABLE_1152204 BOUND_VARIABLE_1152205)) (nullable.lift (lambda ((BOUND_VARIABLE_1152198 Int) (BOUND_VARIABLE_1152199 Int)) (= BOUND_VARIABLE_1152198 BOUND_VARIABLE_1152199)) ((_ tuple.select 0) t) (nullable.some 1)) (as nullable.null (Nullable Bool)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_1152221 Int) (BOUND_VARIABLE_1152222 Int)) (= BOUND_VARIABLE_1152221 BOUND_VARIABLE_1152222)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (= q1 (bag.map f0 EMP)))
(assert (= q2 (bag.map f1 EMP)))
(check-sat)
;answer: sat
; duration: 248 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 1) (nullable.some "A") (nullable.some "B") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (nullable.some (- 6))) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (as nullable.null (Nullable Bool))) 1)
; q2
(get-value (q2))
; (bag (tuple (nullable.some true)) 1)
; insert into EMP values(1,'A','B',4,-4,5,-5,6,-6)
; SELECT * FROM (SELECT TRUE = ((empno = 1) OR CAST(NULL AS BOOLEAN)) FROM emp) AS q1 EXCEPT ALL SELECT * FROM (SELECT TRUE = ((empno = 1) OR FALSE) FROM emp) AS q2;

; SELECT * FROM (SELECT TRUE = ((empno = 1) OR FALSE) FROM emp) AS q2 EXCEPT ALL SELECT * FROM (SELECT TRUE = ((empno = 1) OR CAST(NULL AS BOOLEAN)) FROM emp) AS q1;

;Model soundness: false
(reset)
; total time: 304307 ms.
; sat answers    : 14
; unsat answers  : 45
; unknown answers: 29
