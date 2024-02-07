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
; duration: 24 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_34539 Bool) (BOUND_VARIABLE_34540 Bool)) (and BOUND_VARIABLE_34539 BOUND_VARIABLE_34540)) (nullable.lift (lambda ((BOUND_VARIABLE_34505 Int) (BOUND_VARIABLE_34506 Int)) (= BOUND_VARIABLE_34505 BOUND_VARIABLE_34506)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_34533 Int) (BOUND_VARIABLE_34534 Int)) (= BOUND_VARIABLE_34533 BOUND_VARIABLE_34534)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_34527 Int) (BOUND_VARIABLE_34528 Int)) (+ BOUND_VARIABLE_34527 BOUND_VARIABLE_34528)) ((_ tuple.select 6) t) (nullable.some 5))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_34539 Bool) (BOUND_VARIABLE_34540 Bool)) (and BOUND_VARIABLE_34539 BOUND_VARIABLE_34540)) (nullable.lift (lambda ((BOUND_VARIABLE_34505 Int) (BOUND_VARIABLE_34506 Int)) (= BOUND_VARIABLE_34505 BOUND_VARIABLE_34506)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_34533 Int) (BOUND_VARIABLE_34534 Int)) (= BOUND_VARIABLE_34533 BOUND_VARIABLE_34534)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_34527 Int) (BOUND_VARIABLE_34528 Int)) (+ BOUND_VARIABLE_34527 BOUND_VARIABLE_34528)) ((_ tuple.select 6) t) (nullable.some 5)))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_34576 Bool) (BOUND_VARIABLE_34577 Bool)) (and BOUND_VARIABLE_34576 BOUND_VARIABLE_34577)) (nullable.lift (lambda ((BOUND_VARIABLE_34563 Int) (BOUND_VARIABLE_34564 Int)) (= BOUND_VARIABLE_34563 BOUND_VARIABLE_34564)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_34570 Int) (BOUND_VARIABLE_34571 Int)) (= BOUND_VARIABLE_34570 BOUND_VARIABLE_34571)) ((_ tuple.select 5) t) (nullable.some 8)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_34576 Bool) (BOUND_VARIABLE_34577 Bool)) (and BOUND_VARIABLE_34576 BOUND_VARIABLE_34577)) (nullable.lift (lambda ((BOUND_VARIABLE_34563 Int) (BOUND_VARIABLE_34564 Int)) (= BOUND_VARIABLE_34563 BOUND_VARIABLE_34564)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_34570 Int) (BOUND_VARIABLE_34571 Int)) (= BOUND_VARIABLE_34570 BOUND_VARIABLE_34571)) ((_ tuple.select 5) t) (nullable.some 8))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 226 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36831 Bool) (BOUND_VARIABLE_36832 Bool)) (and BOUND_VARIABLE_36831 BOUND_VARIABLE_36832)) (nullable.lift (lambda ((BOUND_VARIABLE_36807 Int) (BOUND_VARIABLE_36808 Int)) (= BOUND_VARIABLE_36807 BOUND_VARIABLE_36808)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_36826 Bool)) (not BOUND_VARIABLE_36826)) (nullable.lift (lambda ((BOUND_VARIABLE_36820 Int) (BOUND_VARIABLE_36821 Int)) (= BOUND_VARIABLE_36820 BOUND_VARIABLE_36821)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_36814 Int) (BOUND_VARIABLE_36815 Int)) (+ BOUND_VARIABLE_36814 BOUND_VARIABLE_36815)) ((_ tuple.select 6) t) (nullable.some 5)))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36831 Bool) (BOUND_VARIABLE_36832 Bool)) (and BOUND_VARIABLE_36831 BOUND_VARIABLE_36832)) (nullable.lift (lambda ((BOUND_VARIABLE_36807 Int) (BOUND_VARIABLE_36808 Int)) (= BOUND_VARIABLE_36807 BOUND_VARIABLE_36808)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_36826 Bool)) (not BOUND_VARIABLE_36826)) (nullable.lift (lambda ((BOUND_VARIABLE_36820 Int) (BOUND_VARIABLE_36821 Int)) (= BOUND_VARIABLE_36820 BOUND_VARIABLE_36821)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_36814 Int) (BOUND_VARIABLE_36815 Int)) (+ BOUND_VARIABLE_36814 BOUND_VARIABLE_36815)) ((_ tuple.select 6) t) (nullable.some 5))))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36869 Bool) (BOUND_VARIABLE_36870 Bool)) (and BOUND_VARIABLE_36869 BOUND_VARIABLE_36870)) (nullable.lift (lambda ((BOUND_VARIABLE_36851 Int) (BOUND_VARIABLE_36852 Int)) (= BOUND_VARIABLE_36851 BOUND_VARIABLE_36852)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_36864 Bool)) (not BOUND_VARIABLE_36864)) (nullable.lift (lambda ((BOUND_VARIABLE_36858 Int) (BOUND_VARIABLE_36859 Int)) (= BOUND_VARIABLE_36858 BOUND_VARIABLE_36859)) ((_ tuple.select 5) t) (nullable.some 8))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36869 Bool) (BOUND_VARIABLE_36870 Bool)) (and BOUND_VARIABLE_36869 BOUND_VARIABLE_36870)) (nullable.lift (lambda ((BOUND_VARIABLE_36851 Int) (BOUND_VARIABLE_36852 Int)) (= BOUND_VARIABLE_36851 BOUND_VARIABLE_36852)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_36864 Bool)) (not BOUND_VARIABLE_36864)) (nullable.lift (lambda ((BOUND_VARIABLE_36858 Int) (BOUND_VARIABLE_36859 Int)) (= BOUND_VARIABLE_36858 BOUND_VARIABLE_36859)) ((_ tuple.select 5) t) (nullable.some 8)))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 158 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_39415 Int) (BOUND_VARIABLE_39416 Int)) (+ BOUND_VARIABLE_39415 BOUND_VARIABLE_39416)) (nullable.lift (lambda ((BOUND_VARIABLE_39407 Int) (BOUND_VARIABLE_39408 Int)) (+ BOUND_VARIABLE_39407 BOUND_VARIABLE_39408)) (nullable.some (* 1 3)) (nullable.lift (lambda ((BOUND_VARIABLE_39400 Int) (BOUND_VARIABLE_39401 Int)) (+ BOUND_VARIABLE_39400 BOUND_VARIABLE_39401)) ((_ tuple.select 0) t) (nullable.some 2))) (nullable.some (* 3 4)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_39434 Int) (BOUND_VARIABLE_39435 Int)) (+ BOUND_VARIABLE_39434 BOUND_VARIABLE_39435)) ((_ tuple.select 0) t) (nullable.some 17))))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10011 ms.
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
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_82122 Int) (BOUND_VARIABLE_82123 Int)) (= BOUND_VARIABLE_82122 BOUND_VARIABLE_82123)) ((_ tuple.select 0) t) ((_ tuple.select 2) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_82122 Int) (BOUND_VARIABLE_82123 Int)) (= BOUND_VARIABLE_82122 BOUND_VARIABLE_82123)) ((_ tuple.select 0) t) ((_ tuple.select 2) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (= q1 ((_ table.project 0 1) (bag.filter p1 (table.product DEPT ((_ table.project 0) ((_ table.project 0) (bag.filter p0 DEPT))))))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p2 DEPT))))
(check-sat)
;answer: unsat
; duration: 467 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_84595 Bool) (BOUND_VARIABLE_84596 Bool)) (or BOUND_VARIABLE_84595 BOUND_VARIABLE_84596)) (nullable.lift (lambda ((BOUND_VARIABLE_84583 Int) (BOUND_VARIABLE_84584 Int)) (= BOUND_VARIABLE_84583 BOUND_VARIABLE_84584)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.lift (lambda ((BOUND_VARIABLE_84589 Int) (BOUND_VARIABLE_84590 Int)) (= BOUND_VARIABLE_84589 BOUND_VARIABLE_84590)) ((_ tuple.select 0) t) (nullable.some 2)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_84595 Bool) (BOUND_VARIABLE_84596 Bool)) (or BOUND_VARIABLE_84595 BOUND_VARIABLE_84596)) (nullable.lift (lambda ((BOUND_VARIABLE_84583 Int) (BOUND_VARIABLE_84584 Int)) (= BOUND_VARIABLE_84583 BOUND_VARIABLE_84584)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.lift (lambda ((BOUND_VARIABLE_84589 Int) (BOUND_VARIABLE_84590 Int)) (= BOUND_VARIABLE_84589 BOUND_VARIABLE_84590)) ((_ tuple.select 0) t) (nullable.some 2))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_84626 Bool) (BOUND_VARIABLE_84627 Bool)) (or BOUND_VARIABLE_84626 BOUND_VARIABLE_84627)) (nullable.lift (lambda ((BOUND_VARIABLE_84614 Int) (BOUND_VARIABLE_84615 Int)) (= BOUND_VARIABLE_84614 BOUND_VARIABLE_84615)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.lift (lambda ((BOUND_VARIABLE_84620 Int) (BOUND_VARIABLE_84621 Int)) (= BOUND_VARIABLE_84620 BOUND_VARIABLE_84621)) ((_ tuple.select 0) t) (nullable.some 2)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_84626 Bool) (BOUND_VARIABLE_84627 Bool)) (or BOUND_VARIABLE_84626 BOUND_VARIABLE_84627)) (nullable.lift (lambda ((BOUND_VARIABLE_84614 Int) (BOUND_VARIABLE_84615 Int)) (= BOUND_VARIABLE_84614 BOUND_VARIABLE_84615)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.lift (lambda ((BOUND_VARIABLE_84620 Int) (BOUND_VARIABLE_84621 Int)) (= BOUND_VARIABLE_84620 BOUND_VARIABLE_84621)) ((_ tuple.select 0) t) (nullable.some 2))))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 DEPT))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 153 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_86515 Bool) (BOUND_VARIABLE_86516 Bool)) (and BOUND_VARIABLE_86515 BOUND_VARIABLE_86516)) (nullable.lift (lambda ((BOUND_VARIABLE_86508 Int) (BOUND_VARIABLE_86509 Int)) (= BOUND_VARIABLE_86508 BOUND_VARIABLE_86509)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some true))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_86515 Bool) (BOUND_VARIABLE_86516 Bool)) (and BOUND_VARIABLE_86515 BOUND_VARIABLE_86516)) (nullable.lift (lambda ((BOUND_VARIABLE_86508 Int) (BOUND_VARIABLE_86509 Int)) (= BOUND_VARIABLE_86508 BOUND_VARIABLE_86509)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some true)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_86535 Int) (BOUND_VARIABLE_86536 Int)) (= BOUND_VARIABLE_86535 BOUND_VARIABLE_86536)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_86535 Int) (BOUND_VARIABLE_86536 Int)) (= BOUND_VARIABLE_86535 BOUND_VARIABLE_86536)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 DEPT))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 88 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_87805 Bool) (BOUND_VARIABLE_87806 Bool)) (or BOUND_VARIABLE_87805 BOUND_VARIABLE_87806)) (nullable.lift (lambda ((BOUND_VARIABLE_87798 Int) (BOUND_VARIABLE_87799 Int)) (= BOUND_VARIABLE_87798 BOUND_VARIABLE_87799)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some false))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_87805 Bool) (BOUND_VARIABLE_87806 Bool)) (or BOUND_VARIABLE_87805 BOUND_VARIABLE_87806)) (nullable.lift (lambda ((BOUND_VARIABLE_87798 Int) (BOUND_VARIABLE_87799 Int)) (= BOUND_VARIABLE_87798 BOUND_VARIABLE_87799)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some false)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_87824 Int) (BOUND_VARIABLE_87825 Int)) (= BOUND_VARIABLE_87824 BOUND_VARIABLE_87825)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_87824 Int) (BOUND_VARIABLE_87825 Int)) (= BOUND_VARIABLE_87824 BOUND_VARIABLE_87825)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 DEPT))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 93 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_89095 Bool) (BOUND_VARIABLE_89096 Bool)) (and BOUND_VARIABLE_89095 BOUND_VARIABLE_89096)) (nullable.lift (lambda ((BOUND_VARIABLE_89089 Int) (BOUND_VARIABLE_89090 Int)) (= BOUND_VARIABLE_89089 BOUND_VARIABLE_89090)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some false))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_89095 Bool) (BOUND_VARIABLE_89096 Bool)) (and BOUND_VARIABLE_89095 BOUND_VARIABLE_89096)) (nullable.lift (lambda ((BOUND_VARIABLE_89089 Int) (BOUND_VARIABLE_89090 Int)) (= BOUND_VARIABLE_89089 BOUND_VARIABLE_89090)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some false)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 DEPT))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 69 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_90000 Bool) (BOUND_VARIABLE_90001 Bool)) (or BOUND_VARIABLE_90000 BOUND_VARIABLE_90001)) (nullable.lift (lambda ((BOUND_VARIABLE_89994 Int) (BOUND_VARIABLE_89995 Int)) (= BOUND_VARIABLE_89994 BOUND_VARIABLE_89995)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some true))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_90000 Bool) (BOUND_VARIABLE_90001 Bool)) (or BOUND_VARIABLE_90000 BOUND_VARIABLE_90001)) (nullable.lift (lambda ((BOUND_VARIABLE_89994 Int) (BOUND_VARIABLE_89995 Int)) (= BOUND_VARIABLE_89994 BOUND_VARIABLE_89995)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some true)))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 DEPT))))
(assert (= q2 ((_ table.project 0 1) DEPT)))
(check-sat)
;answer: sat
; duration: 66 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_90735 Bool) (BOUND_VARIABLE_90736 Bool)) (and BOUND_VARIABLE_90735 BOUND_VARIABLE_90736)) (nullable.lift (lambda ((BOUND_VARIABLE_90723 Int) (BOUND_VARIABLE_90724 Int)) (> BOUND_VARIABLE_90723 BOUND_VARIABLE_90724)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.lift (lambda ((BOUND_VARIABLE_90729 Int) (BOUND_VARIABLE_90730 Int)) (<= BOUND_VARIABLE_90729 BOUND_VARIABLE_90730)) ((_ tuple.select 0) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_90735 Bool) (BOUND_VARIABLE_90736 Bool)) (and BOUND_VARIABLE_90735 BOUND_VARIABLE_90736)) (nullable.lift (lambda ((BOUND_VARIABLE_90723 Int) (BOUND_VARIABLE_90724 Int)) (> BOUND_VARIABLE_90723 BOUND_VARIABLE_90724)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.lift (lambda ((BOUND_VARIABLE_90729 Int) (BOUND_VARIABLE_90730 Int)) (<= BOUND_VARIABLE_90729 BOUND_VARIABLE_90730)) ((_ tuple.select 0) t) (nullable.some 1))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (ite (nullable.is_null ((_ tuple.select 0) t)) (as nullable.null (Nullable Bool)) (nullable.some false))) (nullable.val (ite (nullable.is_null ((_ tuple.select 0) t)) (as nullable.null (Nullable Bool)) (nullable.some false)))))))
(assert (= q1 ((_ table.project 0) (bag.filter p0 ANON))))
(assert (= q2 ((_ table.project 0) (bag.filter p1 ANON))))
(check-sat)
;answer: unsat
; duration: 72 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_91978 Bool) (BOUND_VARIABLE_91979 Bool)) (and BOUND_VARIABLE_91978 BOUND_VARIABLE_91979)) (nullable.lift (lambda ((BOUND_VARIABLE_91953 Int) (BOUND_VARIABLE_91954 Int)) (> BOUND_VARIABLE_91953 BOUND_VARIABLE_91954)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_91972 Bool) (BOUND_VARIABLE_91973 Bool)) (or BOUND_VARIABLE_91972 BOUND_VARIABLE_91973)) (nullable.lift (lambda ((BOUND_VARIABLE_91959 Int) (BOUND_VARIABLE_91960 Int)) (<= BOUND_VARIABLE_91959 BOUND_VARIABLE_91960)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_91966 Int) (BOUND_VARIABLE_91967 Int)) (> BOUND_VARIABLE_91966 BOUND_VARIABLE_91967)) ((_ tuple.select 0) t) (nullable.some 5))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_91978 Bool) (BOUND_VARIABLE_91979 Bool)) (and BOUND_VARIABLE_91978 BOUND_VARIABLE_91979)) (nullable.lift (lambda ((BOUND_VARIABLE_91953 Int) (BOUND_VARIABLE_91954 Int)) (> BOUND_VARIABLE_91953 BOUND_VARIABLE_91954)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_91972 Bool) (BOUND_VARIABLE_91973 Bool)) (or BOUND_VARIABLE_91972 BOUND_VARIABLE_91973)) (nullable.lift (lambda ((BOUND_VARIABLE_91959 Int) (BOUND_VARIABLE_91960 Int)) (<= BOUND_VARIABLE_91959 BOUND_VARIABLE_91960)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_91966 Int) (BOUND_VARIABLE_91967 Int)) (> BOUND_VARIABLE_91966 BOUND_VARIABLE_91967)) ((_ tuple.select 0) t) (nullable.some 5)))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_92010 Bool) (BOUND_VARIABLE_92011 Bool)) (and BOUND_VARIABLE_92010 BOUND_VARIABLE_92011)) (nullable.lift (lambda ((BOUND_VARIABLE_91997 Int) (BOUND_VARIABLE_91998 Int)) (> BOUND_VARIABLE_91997 BOUND_VARIABLE_91998)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_92004 Int) (BOUND_VARIABLE_92005 Int)) (> BOUND_VARIABLE_92004 BOUND_VARIABLE_92005)) ((_ tuple.select 0) t) (nullable.some 5)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_92010 Bool) (BOUND_VARIABLE_92011 Bool)) (and BOUND_VARIABLE_92010 BOUND_VARIABLE_92011)) (nullable.lift (lambda ((BOUND_VARIABLE_91997 Int) (BOUND_VARIABLE_91998 Int)) (> BOUND_VARIABLE_91997 BOUND_VARIABLE_91998)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_92004 Int) (BOUND_VARIABLE_92005 Int)) (> BOUND_VARIABLE_92004 BOUND_VARIABLE_92005)) ((_ tuple.select 0) t) (nullable.some 5))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 197 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_94434 Bool) (BOUND_VARIABLE_94435 Bool)) (or BOUND_VARIABLE_94434 BOUND_VARIABLE_94435)) (nullable.lift (lambda ((BOUND_VARIABLE_94409 Int) (BOUND_VARIABLE_94410 Int)) (> BOUND_VARIABLE_94409 BOUND_VARIABLE_94410)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_94428 Bool) (BOUND_VARIABLE_94429 Bool)) (and BOUND_VARIABLE_94428 BOUND_VARIABLE_94429)) (nullable.lift (lambda ((BOUND_VARIABLE_94415 Int) (BOUND_VARIABLE_94416 Int)) (<= BOUND_VARIABLE_94415 BOUND_VARIABLE_94416)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_94422 Int) (BOUND_VARIABLE_94423 Int)) (> BOUND_VARIABLE_94422 BOUND_VARIABLE_94423)) ((_ tuple.select 0) t) (nullable.some 5))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_94434 Bool) (BOUND_VARIABLE_94435 Bool)) (or BOUND_VARIABLE_94434 BOUND_VARIABLE_94435)) (nullable.lift (lambda ((BOUND_VARIABLE_94409 Int) (BOUND_VARIABLE_94410 Int)) (> BOUND_VARIABLE_94409 BOUND_VARIABLE_94410)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_94428 Bool) (BOUND_VARIABLE_94429 Bool)) (and BOUND_VARIABLE_94428 BOUND_VARIABLE_94429)) (nullable.lift (lambda ((BOUND_VARIABLE_94415 Int) (BOUND_VARIABLE_94416 Int)) (<= BOUND_VARIABLE_94415 BOUND_VARIABLE_94416)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_94422 Int) (BOUND_VARIABLE_94423 Int)) (> BOUND_VARIABLE_94422 BOUND_VARIABLE_94423)) ((_ tuple.select 0) t) (nullable.some 5)))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_94467 Bool) (BOUND_VARIABLE_94468 Bool)) (or BOUND_VARIABLE_94467 BOUND_VARIABLE_94468)) (nullable.lift (lambda ((BOUND_VARIABLE_94454 Int) (BOUND_VARIABLE_94455 Int)) (> BOUND_VARIABLE_94454 BOUND_VARIABLE_94455)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_94461 Int) (BOUND_VARIABLE_94462 Int)) (> BOUND_VARIABLE_94461 BOUND_VARIABLE_94462)) ((_ tuple.select 0) t) (nullable.some 5)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_94467 Bool) (BOUND_VARIABLE_94468 Bool)) (or BOUND_VARIABLE_94467 BOUND_VARIABLE_94468)) (nullable.lift (lambda ((BOUND_VARIABLE_94454 Int) (BOUND_VARIABLE_94455 Int)) (> BOUND_VARIABLE_94454 BOUND_VARIABLE_94455)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_94461 Int) (BOUND_VARIABLE_94462 Int)) (> BOUND_VARIABLE_94461 BOUND_VARIABLE_94462)) ((_ tuple.select 0) t) (nullable.some 5))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 161 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_96949 Bool) (BOUND_VARIABLE_96950 Bool)) (and BOUND_VARIABLE_96949 BOUND_VARIABLE_96950)) (nullable.lift (lambda ((BOUND_VARIABLE_96923 Bool) (BOUND_VARIABLE_96924 Bool) (BOUND_VARIABLE_96925 Bool)) (or BOUND_VARIABLE_96923 BOUND_VARIABLE_96924 BOUND_VARIABLE_96925)) (nullable.lift (lambda ((BOUND_VARIABLE_96902 Int) (BOUND_VARIABLE_96903 Int)) (= BOUND_VARIABLE_96902 BOUND_VARIABLE_96903)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_96910 Int) (BOUND_VARIABLE_96911 Int)) (= BOUND_VARIABLE_96910 BOUND_VARIABLE_96911)) ((_ tuple.select 6) t) (nullable.some 100)) (nullable.lift (lambda ((BOUND_VARIABLE_96917 Int) (BOUND_VARIABLE_96918 Int)) (> BOUND_VARIABLE_96917 BOUND_VARIABLE_96918)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.lift (lambda ((BOUND_VARIABLE_96943 Bool) (BOUND_VARIABLE_96944 Bool)) (or BOUND_VARIABLE_96943 BOUND_VARIABLE_96944)) (nullable.lift (lambda ((BOUND_VARIABLE_96931 Int) (BOUND_VARIABLE_96932 Int)) (= BOUND_VARIABLE_96931 BOUND_VARIABLE_96932)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_96937 Int) (BOUND_VARIABLE_96938 Int)) (= BOUND_VARIABLE_96937 BOUND_VARIABLE_96938)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_96949 Bool) (BOUND_VARIABLE_96950 Bool)) (and BOUND_VARIABLE_96949 BOUND_VARIABLE_96950)) (nullable.lift (lambda ((BOUND_VARIABLE_96923 Bool) (BOUND_VARIABLE_96924 Bool) (BOUND_VARIABLE_96925 Bool)) (or BOUND_VARIABLE_96923 BOUND_VARIABLE_96924 BOUND_VARIABLE_96925)) (nullable.lift (lambda ((BOUND_VARIABLE_96902 Int) (BOUND_VARIABLE_96903 Int)) (= BOUND_VARIABLE_96902 BOUND_VARIABLE_96903)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_96910 Int) (BOUND_VARIABLE_96911 Int)) (= BOUND_VARIABLE_96910 BOUND_VARIABLE_96911)) ((_ tuple.select 6) t) (nullable.some 100)) (nullable.lift (lambda ((BOUND_VARIABLE_96917 Int) (BOUND_VARIABLE_96918 Int)) (> BOUND_VARIABLE_96917 BOUND_VARIABLE_96918)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.lift (lambda ((BOUND_VARIABLE_96943 Bool) (BOUND_VARIABLE_96944 Bool)) (or BOUND_VARIABLE_96943 BOUND_VARIABLE_96944)) (nullable.lift (lambda ((BOUND_VARIABLE_96931 Int) (BOUND_VARIABLE_96932 Int)) (= BOUND_VARIABLE_96931 BOUND_VARIABLE_96932)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_96937 Int) (BOUND_VARIABLE_96938 Int)) (= BOUND_VARIABLE_96937 BOUND_VARIABLE_96938)) ((_ tuple.select 6) t) (nullable.some 100)))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_96980 Bool) (BOUND_VARIABLE_96981 Bool)) (or BOUND_VARIABLE_96980 BOUND_VARIABLE_96981)) (nullable.lift (lambda ((BOUND_VARIABLE_96968 Int) (BOUND_VARIABLE_96969 Int)) (= BOUND_VARIABLE_96968 BOUND_VARIABLE_96969)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_96974 Int) (BOUND_VARIABLE_96975 Int)) (= BOUND_VARIABLE_96974 BOUND_VARIABLE_96975)) ((_ tuple.select 6) t) (nullable.some 100)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_96980 Bool) (BOUND_VARIABLE_96981 Bool)) (or BOUND_VARIABLE_96980 BOUND_VARIABLE_96981)) (nullable.lift (lambda ((BOUND_VARIABLE_96968 Int) (BOUND_VARIABLE_96969 Int)) (= BOUND_VARIABLE_96968 BOUND_VARIABLE_96969)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_96974 Int) (BOUND_VARIABLE_96975 Int)) (= BOUND_VARIABLE_96974 BOUND_VARIABLE_96975)) ((_ tuple.select 6) t) (nullable.some 100))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 506 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_103429 Bool) (BOUND_VARIABLE_103430 Bool)) (or BOUND_VARIABLE_103429 BOUND_VARIABLE_103430)) (nullable.lift (lambda ((BOUND_VARIABLE_103404 Bool) (BOUND_VARIABLE_103405 Bool) (BOUND_VARIABLE_103406 Bool)) (and BOUND_VARIABLE_103404 BOUND_VARIABLE_103405 BOUND_VARIABLE_103406)) (nullable.lift (lambda ((BOUND_VARIABLE_103385 Int) (BOUND_VARIABLE_103386 Int)) (= BOUND_VARIABLE_103385 BOUND_VARIABLE_103386)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_103391 Int) (BOUND_VARIABLE_103392 Int)) (= BOUND_VARIABLE_103391 BOUND_VARIABLE_103392)) ((_ tuple.select 6) t) (nullable.some 100)) (nullable.lift (lambda ((BOUND_VARIABLE_103398 Int) (BOUND_VARIABLE_103399 Int)) (> BOUND_VARIABLE_103398 BOUND_VARIABLE_103399)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.lift (lambda ((BOUND_VARIABLE_103423 Bool) (BOUND_VARIABLE_103424 Bool)) (and BOUND_VARIABLE_103423 BOUND_VARIABLE_103424)) (nullable.lift (lambda ((BOUND_VARIABLE_103411 Int) (BOUND_VARIABLE_103412 Int)) (= BOUND_VARIABLE_103411 BOUND_VARIABLE_103412)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_103417 Int) (BOUND_VARIABLE_103418 Int)) (= BOUND_VARIABLE_103417 BOUND_VARIABLE_103418)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_103429 Bool) (BOUND_VARIABLE_103430 Bool)) (or BOUND_VARIABLE_103429 BOUND_VARIABLE_103430)) (nullable.lift (lambda ((BOUND_VARIABLE_103404 Bool) (BOUND_VARIABLE_103405 Bool) (BOUND_VARIABLE_103406 Bool)) (and BOUND_VARIABLE_103404 BOUND_VARIABLE_103405 BOUND_VARIABLE_103406)) (nullable.lift (lambda ((BOUND_VARIABLE_103385 Int) (BOUND_VARIABLE_103386 Int)) (= BOUND_VARIABLE_103385 BOUND_VARIABLE_103386)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_103391 Int) (BOUND_VARIABLE_103392 Int)) (= BOUND_VARIABLE_103391 BOUND_VARIABLE_103392)) ((_ tuple.select 6) t) (nullable.some 100)) (nullable.lift (lambda ((BOUND_VARIABLE_103398 Int) (BOUND_VARIABLE_103399 Int)) (> BOUND_VARIABLE_103398 BOUND_VARIABLE_103399)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.lift (lambda ((BOUND_VARIABLE_103423 Bool) (BOUND_VARIABLE_103424 Bool)) (and BOUND_VARIABLE_103423 BOUND_VARIABLE_103424)) (nullable.lift (lambda ((BOUND_VARIABLE_103411 Int) (BOUND_VARIABLE_103412 Int)) (= BOUND_VARIABLE_103411 BOUND_VARIABLE_103412)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_103417 Int) (BOUND_VARIABLE_103418 Int)) (= BOUND_VARIABLE_103417 BOUND_VARIABLE_103418)) ((_ tuple.select 6) t) (nullable.some 100)))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_103461 Bool) (BOUND_VARIABLE_103462 Bool)) (and BOUND_VARIABLE_103461 BOUND_VARIABLE_103462)) (nullable.lift (lambda ((BOUND_VARIABLE_103449 Int) (BOUND_VARIABLE_103450 Int)) (= BOUND_VARIABLE_103449 BOUND_VARIABLE_103450)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_103455 Int) (BOUND_VARIABLE_103456 Int)) (= BOUND_VARIABLE_103455 BOUND_VARIABLE_103456)) ((_ tuple.select 6) t) (nullable.some 100)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_103461 Bool) (BOUND_VARIABLE_103462 Bool)) (and BOUND_VARIABLE_103461 BOUND_VARIABLE_103462)) (nullable.lift (lambda ((BOUND_VARIABLE_103449 Int) (BOUND_VARIABLE_103450 Int)) (= BOUND_VARIABLE_103449 BOUND_VARIABLE_103450)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_103455 Int) (BOUND_VARIABLE_103456 Int)) (= BOUND_VARIABLE_103455 BOUND_VARIABLE_103456)) ((_ tuple.select 6) t) (nullable.some 100))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 220 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_106210 Bool) (BOUND_VARIABLE_106211 Bool)) (or BOUND_VARIABLE_106210 BOUND_VARIABLE_106211)) (as nullable.null (Nullable Bool)) (nullable.some (nullable.is_some ((_ tuple.select 0) t))))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple true))))
(assert (= q1_lift_2 (lambda ((t (Tuple (Nullable Bool)))) (tuple ((_ tuple.select 0) t)))))
(assert (= q2_lift_3 (lambda ((t (Tuple Bool))) (tuple (nullable.some ((_ tuple.select 0) t))))))
(assert (= q1 (bag.map q1_lift_2 (bag.map f0 DEPT))))
(assert (= q2 (bag.map q2_lift_3 (bag.map f1 DEPT))))
(check-sat)
;answer: sat
; duration: 221 ms.
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
; duration: 9 ms.
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
; duration: 5 ms.
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
; duration: 6 ms.
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
; duration: 10006 ms.
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
; duration: 10053 ms.
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
; duration: 10054 ms.
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
; duration: 10211 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_221250 Int) (BOUND_VARIABLE_221251 Int)) (= BOUND_VARIABLE_221250 BOUND_VARIABLE_221251)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_221268 Int) (BOUND_VARIABLE_221269 Int)) (= BOUND_VARIABLE_221268 BOUND_VARIABLE_221269)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (= q1_lift_2 (lambda ((t (Tuple Bool))) (tuple (nullable.some ((_ tuple.select 0) t))))))
(assert (= q2_lift_3 (lambda ((t (Tuple (Nullable Bool)))) (tuple ((_ tuple.select 0) t)))))
(assert (= q1 (bag.map q1_lift_2 (bag.map f0 DEPT))))
(assert (= q2 (bag.map q2_lift_3 (bag.map f1 DEPT))))
(check-sat)
;answer: sat
; duration: 282 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_224173 Bool) (BOUND_VARIABLE_224174 Bool)) (and BOUND_VARIABLE_224173 BOUND_VARIABLE_224174)) (nullable.some (nullable.is_null ((_ tuple.select 0) t))) (as nullable.null (Nullable Bool)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_224191 Bool) (BOUND_VARIABLE_224192 Bool)) (and BOUND_VARIABLE_224191 BOUND_VARIABLE_224192)) (nullable.some (nullable.is_null ((_ tuple.select 0) t))) (as nullable.null (Nullable Bool)))))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unsat
; duration: 9 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_224244 Bool) (BOUND_VARIABLE_224245 Bool)) (and BOUND_VARIABLE_224244 BOUND_VARIABLE_224245)) (as nullable.null (Nullable Bool)) (nullable.some (nullable.is_some ((_ tuple.select 0) t))))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_224262 Bool) (BOUND_VARIABLE_224263 Bool)) (and BOUND_VARIABLE_224262 BOUND_VARIABLE_224263)) (nullable.some (nullable.is_some ((_ tuple.select 0) t))) (as nullable.null (Nullable Bool)))))))
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
; duration: 10126 ms.
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
; duration: 10115 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_287082 Int) (BOUND_VARIABLE_287083 Int)) (= BOUND_VARIABLE_287082 BOUND_VARIABLE_287083)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_287100 Int) (BOUND_VARIABLE_287101 Int)) (= BOUND_VARIABLE_287100 BOUND_VARIABLE_287101)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (= q1_lift_2 (lambda ((t (Tuple Bool))) (tuple (nullable.some ((_ tuple.select 0) t))))))
(assert (= q2_lift_3 (lambda ((t (Tuple (Nullable Bool)))) (tuple ((_ tuple.select 0) t)))))
(assert (= q1 (bag.map q1_lift_2 (bag.map f0 DEPT))))
(assert (= q2 (bag.map q2_lift_3 (bag.map f1 DEPT))))
(check-sat)
;answer: sat
; duration: 284 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_290004 Int) (BOUND_VARIABLE_290005 Int)) (= BOUND_VARIABLE_290004 BOUND_VARIABLE_290005)) ((_ tuple.select 0) t) (nullable.some 1))) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_290010 Int) (BOUND_VARIABLE_290011 Int)) (+ BOUND_VARIABLE_290010 BOUND_VARIABLE_290011)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_290029 Int) (BOUND_VARIABLE_290030 Int)) (= BOUND_VARIABLE_290029 BOUND_VARIABLE_290030)) ((_ tuple.select 0) t) (nullable.some 1))) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_290035 Int) (BOUND_VARIABLE_290036 Int)) (+ BOUND_VARIABLE_290035 BOUND_VARIABLE_290036)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10056 ms.
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
; duration: 10179 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_351901 Int) (BOUND_VARIABLE_351902 Int)) (= BOUND_VARIABLE_351901 BOUND_VARIABLE_351902)) ((_ tuple.select 0) t) (nullable.some 1))) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_351907 Int) (BOUND_VARIABLE_351908 Int)) (+ BOUND_VARIABLE_351907 BOUND_VARIABLE_351908)) ((_ tuple.select 0) t) (nullable.some 100)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_351926 Int) (BOUND_VARIABLE_351927 Int)) (= BOUND_VARIABLE_351926 BOUND_VARIABLE_351927)) ((_ tuple.select 0) t) (nullable.some 1))) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_351932 Int) (BOUND_VARIABLE_351933 Int)) (+ BOUND_VARIABLE_351932 BOUND_VARIABLE_351933)) ((_ tuple.select 0) t) (nullable.some 100)))))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10065 ms.
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
; duration: 56 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_380926 Int) (BOUND_VARIABLE_380927 Int)) (= BOUND_VARIABLE_380926 BOUND_VARIABLE_380927)) (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_380917 Int) (BOUND_VARIABLE_380918 Int)) (= BOUND_VARIABLE_380917 BOUND_VARIABLE_380918)) ((_ tuple.select 6) t) (nullable.some 100))) ((_ tuple.select 7) t) (nullable.some 2)) (nullable.some 2))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_380944 Int) (BOUND_VARIABLE_380945 Int)) (= BOUND_VARIABLE_380944 BOUND_VARIABLE_380945)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.lift (lambda ((BOUND_VARIABLE_380951 Int) (BOUND_VARIABLE_380952 Int)) (= BOUND_VARIABLE_380951 BOUND_VARIABLE_380952)) ((_ tuple.select 7) t) (nullable.some 2)) (nullable.some true))))))
(assert (= q1 (bag.map f0 T)))
(assert (= q2 (bag.map f1 T)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10009 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_406254 Int) (BOUND_VARIABLE_406255 Int)) (= BOUND_VARIABLE_406254 BOUND_VARIABLE_406255)) (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_406245 Int) (BOUND_VARIABLE_406246 Int)) (= BOUND_VARIABLE_406245 BOUND_VARIABLE_406246)) ((_ tuple.select 6) t) (nullable.some 100))) ((_ tuple.select 7) t) (nullable.some 2)) (nullable.some 2))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_406271 Int) (BOUND_VARIABLE_406272 Int)) (= BOUND_VARIABLE_406271 BOUND_VARIABLE_406272)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.lift (lambda ((BOUND_VARIABLE_406278 Int) (BOUND_VARIABLE_406279 Int)) (= BOUND_VARIABLE_406278 BOUND_VARIABLE_406279)) ((_ tuple.select 7) t) (nullable.some 2)) (nullable.some true))))))
(assert (= q1 (bag.map f0 T)))
(assert (= q2 (bag.map f1 T)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10059 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.is_null (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_431254 Int) (BOUND_VARIABLE_431255 Int)) (= BOUND_VARIABLE_431254 BOUND_VARIABLE_431255)) ((_ tuple.select 6) t) (nullable.some 100))) ((_ tuple.select 7) t) (nullable.some 2)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple false))))
(assert (= q1 (bag.map f0 T)))
(assert (= q2 (bag.map f1 T)))
(check-sat)
;answer: sat
; duration: 191 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.is_null (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_433409 Int) (BOUND_VARIABLE_433410 Int)) (= BOUND_VARIABLE_433409 BOUND_VARIABLE_433410)) ((_ tuple.select 6) t) (nullable.some 100))) ((_ tuple.select 7) t) (nullable.some 2)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple false))))
(assert (= q1 (bag.map f0 T)))
(assert (= q2 (bag.map f1 T)))
(check-sat)
;answer: sat
; duration: 197 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_435516 Bool)) (not BOUND_VARIABLE_435516)) (as nullable.null (Nullable Bool)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_null (as nullable.null (Nullable Bool))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 8 ms.
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
; duration: 10006 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_464783 String)) (str.to_upper BOUND_VARIABLE_464783)) (nullable.lift (lambda ((BOUND_VARIABLE_464777 String)) (str.to_lower BOUND_VARIABLE_464777)) ((_ tuple.select 1) t)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_464799 String)) (str.to_upper BOUND_VARIABLE_464799)) ((_ tuple.select 1) t))))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10147 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_494130 Bool) (BOUND_VARIABLE_494131 Bool)) (and BOUND_VARIABLE_494130 BOUND_VARIABLE_494131)) (nullable.lift (lambda ((BOUND_VARIABLE_494117 Int) (BOUND_VARIABLE_494118 Int)) (= BOUND_VARIABLE_494117 BOUND_VARIABLE_494118)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_494124 Int) (BOUND_VARIABLE_494125 Int)) (= BOUND_VARIABLE_494124 BOUND_VARIABLE_494125)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_494130 Bool) (BOUND_VARIABLE_494131 Bool)) (and BOUND_VARIABLE_494130 BOUND_VARIABLE_494131)) (nullable.lift (lambda ((BOUND_VARIABLE_494117 Int) (BOUND_VARIABLE_494118 Int)) (= BOUND_VARIABLE_494117 BOUND_VARIABLE_494118)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_494124 Int) (BOUND_VARIABLE_494125 Int)) (= BOUND_VARIABLE_494124 BOUND_VARIABLE_494125)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_494201 Int) (BOUND_VARIABLE_494202 Int)) (= BOUND_VARIABLE_494201 BOUND_VARIABLE_494202)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_494201 Int) (BOUND_VARIABLE_494202 Int)) (= BOUND_VARIABLE_494201 BOUND_VARIABLE_494202)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_494275 Int) (BOUND_VARIABLE_494276 Int)) (= BOUND_VARIABLE_494275 BOUND_VARIABLE_494276)) ((_ tuple.select 0) t) ((_ tuple.select 12) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_494275 Int) (BOUND_VARIABLE_494276 Int)) (= BOUND_VARIABLE_494275 BOUND_VARIABLE_494276)) ((_ tuple.select 0) t) ((_ tuple.select 12) t)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13) (bag.filter p0 (table.product (table.product EMP DEPT) ACCOUNT)))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 12 13 9 10 11) (bag.filter p2 (table.product (bag.filter p1 (table.product EMP ACCOUNT)) DEPT)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10138 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_621803 Int) (BOUND_VARIABLE_621804 Int)) (= BOUND_VARIABLE_621803 BOUND_VARIABLE_621804)) ((_ tuple.select 6) t) ((_ tuple.select 14) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_621803 Int) (BOUND_VARIABLE_621804 Int)) (= BOUND_VARIABLE_621803 BOUND_VARIABLE_621804)) ((_ tuple.select 6) t) ((_ tuple.select 14) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= p2 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_621864 Int) (BOUND_VARIABLE_621865 Int)) (< BOUND_VARIABLE_621864 BOUND_VARIABLE_621865)) ((_ tuple.select 15) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_621864 Int) (BOUND_VARIABLE_621865 Int)) (< BOUND_VARIABLE_621864 BOUND_VARIABLE_621865)) ((_ tuple.select 15) t) (nullable.some 1)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_621899 Int) (BOUND_VARIABLE_621900 Int)) (< BOUND_VARIABLE_621899 BOUND_VARIABLE_621900)) ((_ tuple.select 6) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_621899 Int) (BOUND_VARIABLE_621900 Int)) (< BOUND_VARIABLE_621899 BOUND_VARIABLE_621900)) ((_ tuple.select 6) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p4 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_621963 Int) (BOUND_VARIABLE_621964 Int)) (= BOUND_VARIABLE_621963 BOUND_VARIABLE_621964)) ((_ tuple.select 6) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_621963 Int) (BOUND_VARIABLE_621964 Int)) (= BOUND_VARIABLE_621963 BOUND_VARIABLE_621964)) ((_ tuple.select 6) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ table.project 6 5) (bag.filter p2 (bag.union_disjoint (bag.map leftJoin1 (bag.difference_remove T ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 (table.product T T))))) (bag.filter p0 (table.product T T)))))))
(assert (= q2 ((_ table.project 6 5) (bag.filter p4 (table.product T ((_ table.project 5) (bag.filter p3 T)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10116 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_667549 Int) (BOUND_VARIABLE_667550 Int)) (= BOUND_VARIABLE_667549 BOUND_VARIABLE_667550)) ((_ tuple.select 6) t) ((_ tuple.select 15) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_667549 Int) (BOUND_VARIABLE_667550 Int)) (= BOUND_VARIABLE_667549 BOUND_VARIABLE_667550)) ((_ tuple.select 6) t) ((_ tuple.select 15) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= q1 ((_ table.project 0) ((_ table.project 5) (bag.union_disjoint (bag.map leftJoin1 (bag.difference_remove T ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 (table.product T T))))) (bag.filter p0 (table.product T T)))))))
(assert (= q2 ((_ table.project 0) ((_ table.project 5) T))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10368 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_722516 Int) (BOUND_VARIABLE_722517 Int)) (= BOUND_VARIABLE_722516 BOUND_VARIABLE_722517)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_722516 Int) (BOUND_VARIABLE_722517 Int)) (= BOUND_VARIABLE_722516 BOUND_VARIABLE_722517)) ((_ tuple.select 6) t) (nullable.some 0)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_722536 Int) (BOUND_VARIABLE_722537 Int)) (= BOUND_VARIABLE_722536 BOUND_VARIABLE_722537)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_722536 Int) (BOUND_VARIABLE_722537 Int)) (= BOUND_VARIABLE_722536 BOUND_VARIABLE_722537)) ((_ tuple.select 6) t) (nullable.some 0)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 T))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 T))))
(check-sat)
;answer: unsat
; duration: 366 ms.
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
; duration: 93 ms.
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
; duration: 10062 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_750334 Int) (BOUND_VARIABLE_750335 Int)) (> BOUND_VARIABLE_750334 BOUND_VARIABLE_750335)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_750334 Int) (BOUND_VARIABLE_750335 Int)) (> BOUND_VARIABLE_750334 BOUND_VARIABLE_750335)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_750354 Int) (BOUND_VARIABLE_750355 Int)) (> BOUND_VARIABLE_750354 BOUND_VARIABLE_750355)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_750354 Int) (BOUND_VARIABLE_750355 Int)) (> BOUND_VARIABLE_750354 BOUND_VARIABLE_750355)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (= q1 ((_ table.project 1) (bag.filter p0 ((_ table.project 0 1) DEPT)))))
(assert (= q2 ((_ table.project 1) (bag.filter p1 DEPT))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10094 ms.
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
; duration: 129 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_784858 Int) (BOUND_VARIABLE_784859 Int)) (> BOUND_VARIABLE_784858 BOUND_VARIABLE_784859)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_784858 Int) (BOUND_VARIABLE_784859 Int)) (> BOUND_VARIABLE_784858 BOUND_VARIABLE_784859)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_784887 Bool) (BOUND_VARIABLE_784888 Bool)) (and BOUND_VARIABLE_784887 BOUND_VARIABLE_784888)) (nullable.lift (lambda ((BOUND_VARIABLE_784878 Int) (BOUND_VARIABLE_784879 Int)) (> BOUND_VARIABLE_784878 BOUND_VARIABLE_784879)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_784887 Bool) (BOUND_VARIABLE_784888 Bool)) (and BOUND_VARIABLE_784887 BOUND_VARIABLE_784888)) (nullable.lift (lambda ((BOUND_VARIABLE_784878 Int) (BOUND_VARIABLE_784879 Int)) (> BOUND_VARIABLE_784878 BOUND_VARIABLE_784879)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 DEPT))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 87 ms.
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
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_786351 Bool) (BOUND_VARIABLE_786352 Bool)) (and BOUND_VARIABLE_786351 BOUND_VARIABLE_786352)) (nullable.lift (lambda ((BOUND_VARIABLE_786338 Int) (BOUND_VARIABLE_786339 Int)) (= BOUND_VARIABLE_786338 BOUND_VARIABLE_786339)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_786345 Int) (BOUND_VARIABLE_786346 Int)) (= BOUND_VARIABLE_786345 BOUND_VARIABLE_786346)) ((_ tuple.select 9) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_786351 Bool) (BOUND_VARIABLE_786352 Bool)) (and BOUND_VARIABLE_786351 BOUND_VARIABLE_786352)) (nullable.lift (lambda ((BOUND_VARIABLE_786338 Int) (BOUND_VARIABLE_786339 Int)) (= BOUND_VARIABLE_786338 BOUND_VARIABLE_786339)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_786345 Int) (BOUND_VARIABLE_786346 Int)) (= BOUND_VARIABLE_786345 BOUND_VARIABLE_786346)) ((_ tuple.select 9) t) (nullable.some 1))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_786381 Bool) (BOUND_VARIABLE_786382 Bool)) (and BOUND_VARIABLE_786381 BOUND_VARIABLE_786382)) (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))) (nullable.lift (lambda ((BOUND_VARIABLE_786374 Int) (BOUND_VARIABLE_786375 Int)) (= BOUND_VARIABLE_786374 BOUND_VARIABLE_786375)) ((_ tuple.select 0) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_786381 Bool) (BOUND_VARIABLE_786382 Bool)) (and BOUND_VARIABLE_786381 BOUND_VARIABLE_786382)) (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))) (nullable.lift (lambda ((BOUND_VARIABLE_786374 Int) (BOUND_VARIABLE_786375 Int)) (= BOUND_VARIABLE_786374 BOUND_VARIABLE_786375)) ((_ tuple.select 0) t) (nullable.some 1))))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 0) t)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_786426 Bool) (BOUND_VARIABLE_786427 Bool)) (and BOUND_VARIABLE_786426 BOUND_VARIABLE_786427)) (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))) (nullable.lift (lambda ((BOUND_VARIABLE_786419 Int) (BOUND_VARIABLE_786420 Int)) (= BOUND_VARIABLE_786419 BOUND_VARIABLE_786420)) ((_ tuple.select 0) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_786426 Bool) (BOUND_VARIABLE_786427 Bool)) (and BOUND_VARIABLE_786426 BOUND_VARIABLE_786427)) (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))) (nullable.lift (lambda ((BOUND_VARIABLE_786419 Int) (BOUND_VARIABLE_786420 Int)) (= BOUND_VARIABLE_786419 BOUND_VARIABLE_786420)) ((_ tuple.select 0) t) (nullable.some 1))))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_786460 Bool) (BOUND_VARIABLE_786461 Bool)) (and BOUND_VARIABLE_786460 BOUND_VARIABLE_786461)) (nullable.lift (lambda ((BOUND_VARIABLE_786447 Int) (BOUND_VARIABLE_786448 Int)) (= BOUND_VARIABLE_786447 BOUND_VARIABLE_786448)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_786454 Int) (BOUND_VARIABLE_786455 Int)) (= BOUND_VARIABLE_786454 BOUND_VARIABLE_786455)) ((_ tuple.select 9) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_786460 Bool) (BOUND_VARIABLE_786461 Bool)) (and BOUND_VARIABLE_786460 BOUND_VARIABLE_786461)) (nullable.lift (lambda ((BOUND_VARIABLE_786447 Int) (BOUND_VARIABLE_786448 Int)) (= BOUND_VARIABLE_786447 BOUND_VARIABLE_786448)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_786454 Int) (BOUND_VARIABLE_786455 Int)) (= BOUND_VARIABLE_786454 BOUND_VARIABLE_786455)) ((_ tuple.select 9) t) (nullable.some 1))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 10 11) (bag.filter p1 (table.product (bag.map f0 EMP) DEPT)))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 10 11) (bag.filter p5 (table.product (bag.map f3 (bag.filter p2 EMP)) ((_ table.project 0 1) (bag.filter p4 DEPT)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10072 ms.
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
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_831932 Bool) (BOUND_VARIABLE_831933 Bool)) (and BOUND_VARIABLE_831932 BOUND_VARIABLE_831933)) (nullable.lift (lambda ((BOUND_VARIABLE_831919 Int) (BOUND_VARIABLE_831920 Int)) (= BOUND_VARIABLE_831919 BOUND_VARIABLE_831920)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_831926 Int) (BOUND_VARIABLE_831927 Int)) (= BOUND_VARIABLE_831926 BOUND_VARIABLE_831927)) ((_ tuple.select 9) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_831932 Bool) (BOUND_VARIABLE_831933 Bool)) (and BOUND_VARIABLE_831932 BOUND_VARIABLE_831933)) (nullable.lift (lambda ((BOUND_VARIABLE_831919 Int) (BOUND_VARIABLE_831920 Int)) (= BOUND_VARIABLE_831919 BOUND_VARIABLE_831920)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_831926 Int) (BOUND_VARIABLE_831927 Int)) (= BOUND_VARIABLE_831926 BOUND_VARIABLE_831927)) ((_ tuple.select 9) t) (nullable.some 1))))))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 9) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 0) t)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_832015 Bool) (BOUND_VARIABLE_832016 Bool)) (and BOUND_VARIABLE_832015 BOUND_VARIABLE_832016)) (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))) (nullable.lift (lambda ((BOUND_VARIABLE_832008 Int) (BOUND_VARIABLE_832009 Int)) (= BOUND_VARIABLE_832008 BOUND_VARIABLE_832009)) ((_ tuple.select 0) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_832015 Bool) (BOUND_VARIABLE_832016 Bool)) (and BOUND_VARIABLE_832015 BOUND_VARIABLE_832016)) (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))) (nullable.lift (lambda ((BOUND_VARIABLE_832008 Int) (BOUND_VARIABLE_832009 Int)) (= BOUND_VARIABLE_832008 BOUND_VARIABLE_832009)) ((_ tuple.select 0) t) (nullable.some 1))))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_832049 Bool) (BOUND_VARIABLE_832050 Bool)) (and BOUND_VARIABLE_832049 BOUND_VARIABLE_832050)) (nullable.lift (lambda ((BOUND_VARIABLE_832036 Int) (BOUND_VARIABLE_832037 Int)) (= BOUND_VARIABLE_832036 BOUND_VARIABLE_832037)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_832043 Int) (BOUND_VARIABLE_832044 Int)) (= BOUND_VARIABLE_832043 BOUND_VARIABLE_832044)) ((_ tuple.select 9) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_832049 Bool) (BOUND_VARIABLE_832050 Bool)) (and BOUND_VARIABLE_832049 BOUND_VARIABLE_832050)) (nullable.lift (lambda ((BOUND_VARIABLE_832036 Int) (BOUND_VARIABLE_832037 Int)) (= BOUND_VARIABLE_832036 BOUND_VARIABLE_832037)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_832043 Int) (BOUND_VARIABLE_832044 Int)) (= BOUND_VARIABLE_832043 BOUND_VARIABLE_832044)) ((_ tuple.select 9) t) (nullable.some 1))))))))
(assert (= leftJoin6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 9) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 10 11) (bag.union_disjoint (bag.map leftJoin2 (bag.difference_remove (bag.map f0 EMP) ((_ table.project 0 1 2 3 4 5 6 7 8 9) (bag.filter p1 (table.product (bag.map f0 EMP) DEPT))))) (bag.filter p1 (table.product (bag.map f0 EMP) DEPT))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 10 11) (bag.union_disjoint (bag.map leftJoin6 (bag.difference_remove (bag.map f3 EMP) ((_ table.project 0 1 2 3 4 5 6 7 8 9) (bag.filter p5 (table.product (bag.map f3 EMP) ((_ table.project 0 1) (bag.filter p4 DEPT))))))) (bag.filter p5 (table.product (bag.map f3 EMP) ((_ table.project 0 1) (bag.filter p4 DEPT))))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10179 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_871554 Int) (BOUND_VARIABLE_871555 Int)) (= BOUND_VARIABLE_871554 BOUND_VARIABLE_871555)) ((_ tuple.select 6) t) (nullable.some 3))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_871554 Int) (BOUND_VARIABLE_871555 Int)) (= BOUND_VARIABLE_871554 BOUND_VARIABLE_871555)) ((_ tuple.select 6) t) (nullable.some 3)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_871575 Int) (BOUND_VARIABLE_871576 Int)) (> BOUND_VARIABLE_871575 BOUND_VARIABLE_871576)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_871575 Int) (BOUND_VARIABLE_871576 Int)) (> BOUND_VARIABLE_871575 BOUND_VARIABLE_871576)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_871608 Bool) (BOUND_VARIABLE_871609 Bool)) (and BOUND_VARIABLE_871608 BOUND_VARIABLE_871609)) (nullable.lift (lambda ((BOUND_VARIABLE_871595 Int) (BOUND_VARIABLE_871596 Int)) (= BOUND_VARIABLE_871595 BOUND_VARIABLE_871596)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_871602 Int) (BOUND_VARIABLE_871603 Int)) (> BOUND_VARIABLE_871602 BOUND_VARIABLE_871603)) ((_ tuple.select 0) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_871608 Bool) (BOUND_VARIABLE_871609 Bool)) (and BOUND_VARIABLE_871608 BOUND_VARIABLE_871609)) (nullable.lift (lambda ((BOUND_VARIABLE_871595 Int) (BOUND_VARIABLE_871596 Int)) (= BOUND_VARIABLE_871595 BOUND_VARIABLE_871596)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_871602 Int) (BOUND_VARIABLE_871603 Int)) (> BOUND_VARIABLE_871602 BOUND_VARIABLE_871603)) ((_ tuple.select 0) t) (nullable.some 1))))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p1 ((_ table.project 0 6) (bag.filter p0 EMP))))))
(assert (= q2 ((_ table.project 0 6) (bag.filter p2 EMP))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10176 ms.
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
; duration: 153 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_908900 Int) (BOUND_VARIABLE_908901 Int)) (> BOUND_VARIABLE_908900 BOUND_VARIABLE_908901)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_908900 Int) (BOUND_VARIABLE_908901 Int)) (> BOUND_VARIABLE_908900 BOUND_VARIABLE_908901)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_908920 Int) (BOUND_VARIABLE_908921 Int)) (> BOUND_VARIABLE_908920 BOUND_VARIABLE_908921)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_908920 Int) (BOUND_VARIABLE_908921 Int)) (> BOUND_VARIABLE_908920 BOUND_VARIABLE_908921)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_908939 Int) (BOUND_VARIABLE_908940 Int)) (> BOUND_VARIABLE_908939 BOUND_VARIABLE_908940)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_908939 Int) (BOUND_VARIABLE_908940 Int)) (> BOUND_VARIABLE_908939 BOUND_VARIABLE_908940)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP))))
(check-sat)
;answer: unsat
; duration: 171 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_911098 Int) (BOUND_VARIABLE_911099 Int)) (> BOUND_VARIABLE_911098 BOUND_VARIABLE_911099)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_911098 Int) (BOUND_VARIABLE_911099 Int)) (> BOUND_VARIABLE_911098 BOUND_VARIABLE_911099)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_911130 Bool) (BOUND_VARIABLE_911131 Bool)) (and BOUND_VARIABLE_911130 BOUND_VARIABLE_911131)) (nullable.lift (lambda ((BOUND_VARIABLE_911118 Int) (BOUND_VARIABLE_911119 Int)) (> BOUND_VARIABLE_911118 BOUND_VARIABLE_911119)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_911124 Int) (BOUND_VARIABLE_911125 Int)) (> BOUND_VARIABLE_911124 BOUND_VARIABLE_911125)) ((_ tuple.select 0) t) (nullable.some 0)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_911130 Bool) (BOUND_VARIABLE_911131 Bool)) (and BOUND_VARIABLE_911130 BOUND_VARIABLE_911131)) (nullable.lift (lambda ((BOUND_VARIABLE_911118 Int) (BOUND_VARIABLE_911119 Int)) (> BOUND_VARIABLE_911118 BOUND_VARIABLE_911119)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_911124 Int) (BOUND_VARIABLE_911125 Int)) (> BOUND_VARIABLE_911124 BOUND_VARIABLE_911125)) ((_ tuple.select 0) t) (nullable.some 0))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_911149 Int) (BOUND_VARIABLE_911150 Int)) (> BOUND_VARIABLE_911149 BOUND_VARIABLE_911150)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_911149 Int) (BOUND_VARIABLE_911150 Int)) (> BOUND_VARIABLE_911149 BOUND_VARIABLE_911150)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_911168 Int) (BOUND_VARIABLE_911169 Int)) (> BOUND_VARIABLE_911168 BOUND_VARIABLE_911169)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_911168 Int) (BOUND_VARIABLE_911169 Int)) (> BOUND_VARIABLE_911168 BOUND_VARIABLE_911169)) ((_ tuple.select 0) t) (nullable.some 0)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP))))))
(check-sat)
;answer: unsat
; duration: 335 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_914916 Int) (BOUND_VARIABLE_914917 Int)) (> BOUND_VARIABLE_914916 BOUND_VARIABLE_914917)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_914916 Int) (BOUND_VARIABLE_914917 Int)) (> BOUND_VARIABLE_914916 BOUND_VARIABLE_914917)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_914954 Bool) (BOUND_VARIABLE_914955 Bool) (BOUND_VARIABLE_914956 Bool)) (and BOUND_VARIABLE_914954 BOUND_VARIABLE_914955 BOUND_VARIABLE_914956)) (nullable.lift (lambda ((BOUND_VARIABLE_914935 Int) (BOUND_VARIABLE_914936 Int)) (> BOUND_VARIABLE_914935 BOUND_VARIABLE_914936)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_914941 Int) (BOUND_VARIABLE_914942 Int)) (> BOUND_VARIABLE_914941 BOUND_VARIABLE_914942)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_914948 Int) (BOUND_VARIABLE_914949 Int)) (> BOUND_VARIABLE_914948 BOUND_VARIABLE_914949)) ((_ tuple.select 6) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_914954 Bool) (BOUND_VARIABLE_914955 Bool) (BOUND_VARIABLE_914956 Bool)) (and BOUND_VARIABLE_914954 BOUND_VARIABLE_914955 BOUND_VARIABLE_914956)) (nullable.lift (lambda ((BOUND_VARIABLE_914935 Int) (BOUND_VARIABLE_914936 Int)) (> BOUND_VARIABLE_914935 BOUND_VARIABLE_914936)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_914941 Int) (BOUND_VARIABLE_914942 Int)) (> BOUND_VARIABLE_914941 BOUND_VARIABLE_914942)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_914948 Int) (BOUND_VARIABLE_914949 Int)) (> BOUND_VARIABLE_914948 BOUND_VARIABLE_914949)) ((_ tuple.select 6) t) (nullable.some 1))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_914974 Int) (BOUND_VARIABLE_914975 Int)) (> BOUND_VARIABLE_914974 BOUND_VARIABLE_914975)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_914974 Int) (BOUND_VARIABLE_914975 Int)) (> BOUND_VARIABLE_914974 BOUND_VARIABLE_914975)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_915006 Bool) (BOUND_VARIABLE_915007 Bool)) (and BOUND_VARIABLE_915006 BOUND_VARIABLE_915007)) (nullable.lift (lambda ((BOUND_VARIABLE_914993 Int) (BOUND_VARIABLE_914994 Int)) (> BOUND_VARIABLE_914993 BOUND_VARIABLE_914994)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_915000 Int) (BOUND_VARIABLE_915001 Int)) (> BOUND_VARIABLE_915000 BOUND_VARIABLE_915001)) ((_ tuple.select 6) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_915006 Bool) (BOUND_VARIABLE_915007 Bool)) (and BOUND_VARIABLE_915006 BOUND_VARIABLE_915007)) (nullable.lift (lambda ((BOUND_VARIABLE_914993 Int) (BOUND_VARIABLE_914994 Int)) (> BOUND_VARIABLE_914993 BOUND_VARIABLE_914994)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_915000 Int) (BOUND_VARIABLE_915001 Int)) (> BOUND_VARIABLE_915000 BOUND_VARIABLE_915001)) ((_ tuple.select 6) t) (nullable.some 1))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP))))))
(check-sat)
;answer: unsat
; duration: 408 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_919757 Int) (BOUND_VARIABLE_919758 Int)) (= BOUND_VARIABLE_919757 BOUND_VARIABLE_919758)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_919757 Int) (BOUND_VARIABLE_919758 Int)) (= BOUND_VARIABLE_919757 BOUND_VARIABLE_919758)) ((_ tuple.select 0) t) (nullable.some 0)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_919777 Int) (BOUND_VARIABLE_919778 Int)) (= BOUND_VARIABLE_919777 BOUND_VARIABLE_919778)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_919777 Int) (BOUND_VARIABLE_919778 Int)) (= BOUND_VARIABLE_919777 BOUND_VARIABLE_919778)) ((_ tuple.select 0) t) (nullable.some 0)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_919796 Int) (BOUND_VARIABLE_919797 Int)) (= BOUND_VARIABLE_919796 BOUND_VARIABLE_919797)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_919796 Int) (BOUND_VARIABLE_919797 Int)) (= BOUND_VARIABLE_919796 BOUND_VARIABLE_919797)) ((_ tuple.select 0) t) (nullable.some 0)))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 (bag.union_disjoint ((_ table.project 0 1) DEPT) ((_ table.project 0 1) DEPT))))))
(assert (= q2 (bag.union_disjoint ((_ table.project 0 1) (bag.filter p1 DEPT)) ((_ table.project 0 1) (bag.filter p2 DEPT)))))
(check-sat)
;answer: unsat
; duration: 244 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_922450 Int) (BOUND_VARIABLE_922451 Int)) (> BOUND_VARIABLE_922450 BOUND_VARIABLE_922451)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_922450 Int) (BOUND_VARIABLE_922451 Int)) (> BOUND_VARIABLE_922450 BOUND_VARIABLE_922451)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_922469 Int) (BOUND_VARIABLE_922470 Int)) (> BOUND_VARIABLE_922469 BOUND_VARIABLE_922470)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_922469 Int) (BOUND_VARIABLE_922470 Int)) (> BOUND_VARIABLE_922469 BOUND_VARIABLE_922470)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= q1 ((_ table.project 0) (bag.filter p0 ((_ table.project 0) DEPT)))))
(assert (= q2 ((_ table.project 0) (bag.filter p1 DEPT))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10014 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_955978 Int) (BOUND_VARIABLE_955979 Int)) (> BOUND_VARIABLE_955978 BOUND_VARIABLE_955979)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_955978 Int) (BOUND_VARIABLE_955979 Int)) (> BOUND_VARIABLE_955978 BOUND_VARIABLE_955979)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_955998 Int) (BOUND_VARIABLE_955999 Int)) (> BOUND_VARIABLE_955998 BOUND_VARIABLE_955999)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_955998 Int) (BOUND_VARIABLE_955999 Int)) (> BOUND_VARIABLE_955998 BOUND_VARIABLE_955999)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= q1 ((_ table.project 0) (bag.filter p0 ((_ table.project 0) ((_ table.project 0) DEPT))))))
(assert (= q2 ((_ table.project 0) ((_ table.project 0) (bag.filter p1 DEPT)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10139 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_989287 Int) (BOUND_VARIABLE_989288 Int)) (= BOUND_VARIABLE_989287 BOUND_VARIABLE_989288)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_989287 Int) (BOUND_VARIABLE_989288 Int)) (= BOUND_VARIABLE_989287 BOUND_VARIABLE_989288)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_989348 Bool) (BOUND_VARIABLE_989349 Bool)) (and BOUND_VARIABLE_989348 BOUND_VARIABLE_989349)) (nullable.lift (lambda ((BOUND_VARIABLE_989335 Int) (BOUND_VARIABLE_989336 Int)) (> BOUND_VARIABLE_989335 BOUND_VARIABLE_989336)) ((_ tuple.select 6) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_989342 Int) (BOUND_VARIABLE_989343 Int)) (= BOUND_VARIABLE_989342 BOUND_VARIABLE_989343)) ((_ tuple.select 9) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_989348 Bool) (BOUND_VARIABLE_989349 Bool)) (and BOUND_VARIABLE_989348 BOUND_VARIABLE_989349)) (nullable.lift (lambda ((BOUND_VARIABLE_989335 Int) (BOUND_VARIABLE_989336 Int)) (> BOUND_VARIABLE_989335 BOUND_VARIABLE_989336)) ((_ tuple.select 6) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_989342 Int) (BOUND_VARIABLE_989343 Int)) (= BOUND_VARIABLE_989342 BOUND_VARIABLE_989343)) ((_ tuple.select 9) t) (nullable.some 1))))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_989368 Int) (BOUND_VARIABLE_989369 Int)) (= BOUND_VARIABLE_989368 BOUND_VARIABLE_989369)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_989368 Int) (BOUND_VARIABLE_989369 Int)) (= BOUND_VARIABLE_989368 BOUND_VARIABLE_989369)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_989389 Int) (BOUND_VARIABLE_989390 Int)) (= BOUND_VARIABLE_989389 BOUND_VARIABLE_989390)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_989389 Int) (BOUND_VARIABLE_989390 Int)) (= BOUND_VARIABLE_989389 BOUND_VARIABLE_989390)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_989433 Int) (BOUND_VARIABLE_989434 Int)) (> BOUND_VARIABLE_989433 BOUND_VARIABLE_989434)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_989433 Int) (BOUND_VARIABLE_989434 Int)) (> BOUND_VARIABLE_989433 BOUND_VARIABLE_989434)) ((_ tuple.select 6) t) (nullable.some 0)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p2 (bag.union_disjoint (bag.map rightJoin1 (bag.difference_remove DEPT ((_ table.project 9 10) (bag.filter p0 (table.product EMP DEPT))))) (bag.filter p0 (table.product EMP DEPT)))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p6 (bag.union_disjoint (bag.map rightJoin5 (bag.difference_remove ((_ table.project 0 1) (bag.filter p3 DEPT)) ((_ table.project 9 10) (bag.filter p4 (table.product EMP ((_ table.project 0 1) (bag.filter p3 DEPT))))))) (bag.filter p4 (table.product EMP ((_ table.project 0 1) (bag.filter p3 DEPT)))))))))
(check-sat)
;answer: unsat
; duration: 832 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_994844 Int) (BOUND_VARIABLE_994845 Int)) (= BOUND_VARIABLE_994844 BOUND_VARIABLE_994845)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_994844 Int) (BOUND_VARIABLE_994845 Int)) (= BOUND_VARIABLE_994844 BOUND_VARIABLE_994845)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_994910 Bool) (BOUND_VARIABLE_994911 Bool)) (and BOUND_VARIABLE_994910 BOUND_VARIABLE_994911)) (nullable.lift (lambda ((BOUND_VARIABLE_994897 Int) (BOUND_VARIABLE_994898 Int)) (> BOUND_VARIABLE_994897 BOUND_VARIABLE_994898)) ((_ tuple.select 6) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_994904 Int) (BOUND_VARIABLE_994905 Int)) (= BOUND_VARIABLE_994904 BOUND_VARIABLE_994905)) ((_ tuple.select 9) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_994910 Bool) (BOUND_VARIABLE_994911 Bool)) (and BOUND_VARIABLE_994910 BOUND_VARIABLE_994911)) (nullable.lift (lambda ((BOUND_VARIABLE_994897 Int) (BOUND_VARIABLE_994898 Int)) (> BOUND_VARIABLE_994897 BOUND_VARIABLE_994898)) ((_ tuple.select 6) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_994904 Int) (BOUND_VARIABLE_994905 Int)) (= BOUND_VARIABLE_994904 BOUND_VARIABLE_994905)) ((_ tuple.select 9) t) (nullable.some 1))))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_994929 Int) (BOUND_VARIABLE_994930 Int)) (> BOUND_VARIABLE_994929 BOUND_VARIABLE_994930)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_994929 Int) (BOUND_VARIABLE_994930 Int)) (> BOUND_VARIABLE_994929 BOUND_VARIABLE_994930)) ((_ tuple.select 6) t) (nullable.some 0)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_994950 Int) (BOUND_VARIABLE_994951 Int)) (= BOUND_VARIABLE_994950 BOUND_VARIABLE_994951)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_994950 Int) (BOUND_VARIABLE_994951 Int)) (= BOUND_VARIABLE_994950 BOUND_VARIABLE_994951)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_995001 Int) (BOUND_VARIABLE_995002 Int)) (= BOUND_VARIABLE_995001 BOUND_VARIABLE_995002)) ((_ tuple.select 9) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_995001 Int) (BOUND_VARIABLE_995002 Int)) (= BOUND_VARIABLE_995001 BOUND_VARIABLE_995002)) ((_ tuple.select 9) t) (nullable.some 1)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p2 (bag.union_disjoint (bag.map leftJoin1 (bag.difference_remove EMP ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 (table.product EMP DEPT))))) (bag.filter p0 (table.product EMP DEPT)))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p6 (bag.union_disjoint (bag.map leftJoin5 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) DEPT))))) (bag.filter p4 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) DEPT)))))))
(check-sat)
;answer: unsat
; duration: 616 ms.
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_1000677 Int) (BOUND_VARIABLE_1000678 Int)) (> BOUND_VARIABLE_1000677 BOUND_VARIABLE_1000678)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1000819 Bool) (BOUND_VARIABLE_1000820 Bool) (BOUND_VARIABLE_1000821 Bool)) (and BOUND_VARIABLE_1000819 BOUND_VARIABLE_1000820 BOUND_VARIABLE_1000821)) (nullable.lift (lambda ((BOUND_VARIABLE_1000805 Int) (BOUND_VARIABLE_1000806 Int)) (= BOUND_VARIABLE_1000805 BOUND_VARIABLE_1000806)) ((_ tuple.select 7) t) ((_ tuple.select 10) t)) ((_ tuple.select 9) t) (nullable.lift (lambda ((BOUND_VARIABLE_1000813 Int) (BOUND_VARIABLE_1000814 Int)) (= BOUND_VARIABLE_1000813 BOUND_VARIABLE_1000814)) ((_ tuple.select 12) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1000819 Bool) (BOUND_VARIABLE_1000820 Bool) (BOUND_VARIABLE_1000821 Bool)) (and BOUND_VARIABLE_1000819 BOUND_VARIABLE_1000820 BOUND_VARIABLE_1000821)) (nullable.lift (lambda ((BOUND_VARIABLE_1000805 Int) (BOUND_VARIABLE_1000806 Int)) (= BOUND_VARIABLE_1000805 BOUND_VARIABLE_1000806)) ((_ tuple.select 7) t) ((_ tuple.select 10) t)) ((_ tuple.select 9) t) (nullable.lift (lambda ((BOUND_VARIABLE_1000813 Int) (BOUND_VARIABLE_1000814 Int)) (= BOUND_VARIABLE_1000813 BOUND_VARIABLE_1000814)) ((_ tuple.select 12) t) (nullable.some 1))))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1000840 Int) (BOUND_VARIABLE_1000841 Int)) (> BOUND_VARIABLE_1000840 BOUND_VARIABLE_1000841)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1000840 Int) (BOUND_VARIABLE_1000841 Int)) (> BOUND_VARIABLE_1000840 BOUND_VARIABLE_1000841)) ((_ tuple.select 6) t) (nullable.some 0)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1000859 Int) (BOUND_VARIABLE_1000860 Int)) (= BOUND_VARIABLE_1000859 BOUND_VARIABLE_1000860)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1000859 Int) (BOUND_VARIABLE_1000860 Int)) (= BOUND_VARIABLE_1000859 BOUND_VARIABLE_1000860)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1000880 Int) (BOUND_VARIABLE_1000881 Int)) (= BOUND_VARIABLE_1000880 BOUND_VARIABLE_1000881)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1000880 Int) (BOUND_VARIABLE_1000881 Int)) (= BOUND_VARIABLE_1000880 BOUND_VARIABLE_1000881)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 10 11) (bag.filter p2 (table.product (bag.map f0 EMP) (bag.map f1 DEPT))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p5 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1) (bag.filter p4 DEPT)))))))
(check-sat)
;answer: unsat
; duration: 1359 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_1010182 Int) (BOUND_VARIABLE_1010183 Int)) (> BOUND_VARIABLE_1010182 BOUND_VARIABLE_1010183)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1010227 Bool) (BOUND_VARIABLE_1010228 Bool) (BOUND_VARIABLE_1010229 Bool)) (and BOUND_VARIABLE_1010227 BOUND_VARIABLE_1010228 BOUND_VARIABLE_1010229)) (nullable.lift (lambda ((BOUND_VARIABLE_1010213 Int) (BOUND_VARIABLE_1010214 Int)) (= BOUND_VARIABLE_1010213 BOUND_VARIABLE_1010214)) ((_ tuple.select 7) t) ((_ tuple.select 10) t)) ((_ tuple.select 9) t) (nullable.lift (lambda ((BOUND_VARIABLE_1010221 Int) (BOUND_VARIABLE_1010222 Int)) (= BOUND_VARIABLE_1010221 BOUND_VARIABLE_1010222)) ((_ tuple.select 12) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1010227 Bool) (BOUND_VARIABLE_1010228 Bool) (BOUND_VARIABLE_1010229 Bool)) (and BOUND_VARIABLE_1010227 BOUND_VARIABLE_1010228 BOUND_VARIABLE_1010229)) (nullable.lift (lambda ((BOUND_VARIABLE_1010213 Int) (BOUND_VARIABLE_1010214 Int)) (= BOUND_VARIABLE_1010213 BOUND_VARIABLE_1010214)) ((_ tuple.select 7) t) ((_ tuple.select 10) t)) ((_ tuple.select 9) t) (nullable.lift (lambda ((BOUND_VARIABLE_1010221 Int) (BOUND_VARIABLE_1010222 Int)) (= BOUND_VARIABLE_1010221 BOUND_VARIABLE_1010222)) ((_ tuple.select 12) t) (nullable.some 1))))))))
(assert (= rightJoin3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Bool)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1010278 Int) (BOUND_VARIABLE_1010279 Int)) (> BOUND_VARIABLE_1010278 BOUND_VARIABLE_1010279)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1010278 Int) (BOUND_VARIABLE_1010279 Int)) (> BOUND_VARIABLE_1010278 BOUND_VARIABLE_1010279)) ((_ tuple.select 6) t) (nullable.some 0)))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1010370 Bool) (BOUND_VARIABLE_1010371 Bool)) (and BOUND_VARIABLE_1010370 BOUND_VARIABLE_1010371)) (nullable.lift (lambda ((BOUND_VARIABLE_1010357 Int) (BOUND_VARIABLE_1010358 Int)) (= BOUND_VARIABLE_1010357 BOUND_VARIABLE_1010358)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_1010364 Int) (BOUND_VARIABLE_1010365 Int)) (= BOUND_VARIABLE_1010364 BOUND_VARIABLE_1010365)) ((_ tuple.select 11) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1010370 Bool) (BOUND_VARIABLE_1010371 Bool)) (and BOUND_VARIABLE_1010370 BOUND_VARIABLE_1010371)) (nullable.lift (lambda ((BOUND_VARIABLE_1010357 Int) (BOUND_VARIABLE_1010358 Int)) (= BOUND_VARIABLE_1010357 BOUND_VARIABLE_1010358)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_1010364 Int) (BOUND_VARIABLE_1010365 Int)) (= BOUND_VARIABLE_1010364 BOUND_VARIABLE_1010365)) ((_ tuple.select 11) t) (nullable.some 1))))))))
(assert (= rightJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 10 11) (bag.union_disjoint (bag.map rightJoin3 (bag.difference_remove (bag.map f1 DEPT) ((_ table.project 10 11 12) (bag.filter p2 (table.product (bag.map f0 EMP) (bag.map f1 DEPT)))))) (bag.filter p2 (table.product (bag.map f0 EMP) (bag.map f1 DEPT)))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map rightJoin7 (bag.difference_remove (bag.map f5 DEPT) ((_ table.project 9 10 11) (bag.filter p6 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)) (bag.map f5 DEPT)))))) (bag.filter p6 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)) (bag.map f5 DEPT)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10111 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_1055640 Int) (BOUND_VARIABLE_1055641 Int)) (> BOUND_VARIABLE_1055640 BOUND_VARIABLE_1055641)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1055685 Bool) (BOUND_VARIABLE_1055686 Bool) (BOUND_VARIABLE_1055687 Bool)) (and BOUND_VARIABLE_1055685 BOUND_VARIABLE_1055686 BOUND_VARIABLE_1055687)) (nullable.lift (lambda ((BOUND_VARIABLE_1055671 Int) (BOUND_VARIABLE_1055672 Int)) (= BOUND_VARIABLE_1055671 BOUND_VARIABLE_1055672)) ((_ tuple.select 7) t) ((_ tuple.select 10) t)) ((_ tuple.select 9) t) (nullable.lift (lambda ((BOUND_VARIABLE_1055679 Int) (BOUND_VARIABLE_1055680 Int)) (= BOUND_VARIABLE_1055679 BOUND_VARIABLE_1055680)) ((_ tuple.select 12) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1055685 Bool) (BOUND_VARIABLE_1055686 Bool) (BOUND_VARIABLE_1055687 Bool)) (and BOUND_VARIABLE_1055685 BOUND_VARIABLE_1055686 BOUND_VARIABLE_1055687)) (nullable.lift (lambda ((BOUND_VARIABLE_1055671 Int) (BOUND_VARIABLE_1055672 Int)) (= BOUND_VARIABLE_1055671 BOUND_VARIABLE_1055672)) ((_ tuple.select 7) t) ((_ tuple.select 10) t)) ((_ tuple.select 9) t) (nullable.lift (lambda ((BOUND_VARIABLE_1055679 Int) (BOUND_VARIABLE_1055680 Int)) (= BOUND_VARIABLE_1055679 BOUND_VARIABLE_1055680)) ((_ tuple.select 12) t) (nullable.some 1))))))))
(assert (= leftJoin3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 9) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_1055750 Int) (BOUND_VARIABLE_1055751 Int)) (> BOUND_VARIABLE_1055750 BOUND_VARIABLE_1055751)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1055766 Int) (BOUND_VARIABLE_1055767 Int)) (= BOUND_VARIABLE_1055766 BOUND_VARIABLE_1055767)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1055766 Int) (BOUND_VARIABLE_1055767 Int)) (= BOUND_VARIABLE_1055766 BOUND_VARIABLE_1055767)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1055843 Bool) (BOUND_VARIABLE_1055844 Bool)) (and BOUND_VARIABLE_1055843 BOUND_VARIABLE_1055844)) (nullable.lift (lambda ((BOUND_VARIABLE_1055836 Int) (BOUND_VARIABLE_1055837 Int)) (= BOUND_VARIABLE_1055836 BOUND_VARIABLE_1055837)) ((_ tuple.select 7) t) ((_ tuple.select 10) t)) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1055843 Bool) (BOUND_VARIABLE_1055844 Bool)) (and BOUND_VARIABLE_1055843 BOUND_VARIABLE_1055844)) (nullable.lift (lambda ((BOUND_VARIABLE_1055836 Int) (BOUND_VARIABLE_1055837 Int)) (= BOUND_VARIABLE_1055836 BOUND_VARIABLE_1055837)) ((_ tuple.select 7) t) ((_ tuple.select 10) t)) ((_ tuple.select 9) t)))))))
(assert (= leftJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 9) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 10 11) (bag.union_disjoint (bag.map leftJoin3 (bag.difference_remove (bag.map f0 EMP) ((_ table.project 0 1 2 3 4 5 6 7 8 9) (bag.filter p2 (table.product (bag.map f0 EMP) (bag.map f1 DEPT)))))) (bag.filter p2 (table.product (bag.map f0 EMP) (bag.map f1 DEPT)))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 10 11) (bag.union_disjoint (bag.map leftJoin7 (bag.difference_remove (bag.map f4 EMP) ((_ table.project 0 1 2 3 4 5 6 7 8 9) (bag.filter p6 (table.product (bag.map f4 EMP) ((_ table.project 0 1) (bag.filter p5 DEPT))))))) (bag.filter p6 (table.product (bag.map f4 EMP) ((_ table.project 0 1) (bag.filter p5 DEPT))))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10320 ms.
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
; duration: 280 ms.
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
; duration: 6 ms.
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
; duration: 49 ms.
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
; duration: 119 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1102623 Bool) (BOUND_VARIABLE_1102624 Bool)) (and BOUND_VARIABLE_1102623 BOUND_VARIABLE_1102624)) (as nullable.null (Nullable Bool)) (nullable.some true))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1102623 Bool) (BOUND_VARIABLE_1102624 Bool)) (and BOUND_VARIABLE_1102623 BOUND_VARIABLE_1102624)) (as nullable.null (Nullable Bool)) (nullable.some true)))))))
(assert (= q1 (bag.union_disjoint ((_ table.project 0 1) DEPT) ((_ table.project 0 1) (bag.filter p0 DEPT)))))
(assert (= q2 ((_ table.project 0 1) DEPT)))
(check-sat)
;answer: unsat
; duration: 50 ms.
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
; duration: 44 ms.
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int))))
(declare-const q2 (Bag (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (= q1 (bag.union_disjoint ((_ table.project 0) (bag.filter p0 DEPT)) ((_ table.project 0) EMP))))
(assert (= q2 ((_ table.project 0) EMP)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10007 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1133557 Bool) (BOUND_VARIABLE_1133558 Bool)) (or BOUND_VARIABLE_1133557 BOUND_VARIABLE_1133558)) (nullable.lift (lambda ((BOUND_VARIABLE_1133531 Bool) (BOUND_VARIABLE_1133532 Bool)) (and BOUND_VARIABLE_1133531 BOUND_VARIABLE_1133532)) (nullable.lift (lambda ((BOUND_VARIABLE_1133518 Int) (BOUND_VARIABLE_1133519 Int)) (< BOUND_VARIABLE_1133518 BOUND_VARIABLE_1133519)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1133525 Int) (BOUND_VARIABLE_1133526 Int)) (< BOUND_VARIABLE_1133525 BOUND_VARIABLE_1133526)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1133551 Bool) (BOUND_VARIABLE_1133552 Bool)) (and BOUND_VARIABLE_1133551 BOUND_VARIABLE_1133552)) (nullable.lift (lambda ((BOUND_VARIABLE_1133539 Int) (BOUND_VARIABLE_1133540 Int)) (> BOUND_VARIABLE_1133539 BOUND_VARIABLE_1133540)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_1133545 Int) (BOUND_VARIABLE_1133546 Int)) (> BOUND_VARIABLE_1133545 BOUND_VARIABLE_1133546)) ((_ tuple.select 9) t) (nullable.some 20))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1133557 Bool) (BOUND_VARIABLE_1133558 Bool)) (or BOUND_VARIABLE_1133557 BOUND_VARIABLE_1133558)) (nullable.lift (lambda ((BOUND_VARIABLE_1133531 Bool) (BOUND_VARIABLE_1133532 Bool)) (and BOUND_VARIABLE_1133531 BOUND_VARIABLE_1133532)) (nullable.lift (lambda ((BOUND_VARIABLE_1133518 Int) (BOUND_VARIABLE_1133519 Int)) (< BOUND_VARIABLE_1133518 BOUND_VARIABLE_1133519)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1133525 Int) (BOUND_VARIABLE_1133526 Int)) (< BOUND_VARIABLE_1133525 BOUND_VARIABLE_1133526)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1133551 Bool) (BOUND_VARIABLE_1133552 Bool)) (and BOUND_VARIABLE_1133551 BOUND_VARIABLE_1133552)) (nullable.lift (lambda ((BOUND_VARIABLE_1133539 Int) (BOUND_VARIABLE_1133540 Int)) (> BOUND_VARIABLE_1133539 BOUND_VARIABLE_1133540)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_1133545 Int) (BOUND_VARIABLE_1133546 Int)) (> BOUND_VARIABLE_1133545 BOUND_VARIABLE_1133546)) ((_ tuple.select 9) t) (nullable.some 20)))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1133589 Bool) (BOUND_VARIABLE_1133590 Bool)) (or BOUND_VARIABLE_1133589 BOUND_VARIABLE_1133590)) (nullable.lift (lambda ((BOUND_VARIABLE_1133577 Int) (BOUND_VARIABLE_1133578 Int)) (< BOUND_VARIABLE_1133577 BOUND_VARIABLE_1133578)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1133583 Int) (BOUND_VARIABLE_1133584 Int)) (> BOUND_VARIABLE_1133583 BOUND_VARIABLE_1133584)) ((_ tuple.select 0) t) (nullable.some 20)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1133589 Bool) (BOUND_VARIABLE_1133590 Bool)) (or BOUND_VARIABLE_1133589 BOUND_VARIABLE_1133590)) (nullable.lift (lambda ((BOUND_VARIABLE_1133577 Int) (BOUND_VARIABLE_1133578 Int)) (< BOUND_VARIABLE_1133577 BOUND_VARIABLE_1133578)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1133583 Int) (BOUND_VARIABLE_1133584 Int)) (> BOUND_VARIABLE_1133583 BOUND_VARIABLE_1133584)) ((_ tuple.select 0) t) (nullable.some 20))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1133620 Bool) (BOUND_VARIABLE_1133621 Bool)) (or BOUND_VARIABLE_1133620 BOUND_VARIABLE_1133621)) (nullable.lift (lambda ((BOUND_VARIABLE_1133608 Int) (BOUND_VARIABLE_1133609 Int)) (< BOUND_VARIABLE_1133608 BOUND_VARIABLE_1133609)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1133614 Int) (BOUND_VARIABLE_1133615 Int)) (> BOUND_VARIABLE_1133614 BOUND_VARIABLE_1133615)) ((_ tuple.select 0) t) (nullable.some 20)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1133620 Bool) (BOUND_VARIABLE_1133621 Bool)) (or BOUND_VARIABLE_1133620 BOUND_VARIABLE_1133621)) (nullable.lift (lambda ((BOUND_VARIABLE_1133608 Int) (BOUND_VARIABLE_1133609 Int)) (< BOUND_VARIABLE_1133608 BOUND_VARIABLE_1133609)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1133614 Int) (BOUND_VARIABLE_1133615 Int)) (> BOUND_VARIABLE_1133614 BOUND_VARIABLE_1133615)) ((_ tuple.select 0) t) (nullable.some 20))))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1133677 Bool) (BOUND_VARIABLE_1133678 Bool)) (or BOUND_VARIABLE_1133677 BOUND_VARIABLE_1133678)) (nullable.lift (lambda ((BOUND_VARIABLE_1133653 Bool) (BOUND_VARIABLE_1133654 Bool)) (and BOUND_VARIABLE_1133653 BOUND_VARIABLE_1133654)) (nullable.lift (lambda ((BOUND_VARIABLE_1133640 Int) (BOUND_VARIABLE_1133641 Int)) (< BOUND_VARIABLE_1133640 BOUND_VARIABLE_1133641)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1133647 Int) (BOUND_VARIABLE_1133648 Int)) (< BOUND_VARIABLE_1133647 BOUND_VARIABLE_1133648)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1133671 Bool) (BOUND_VARIABLE_1133672 Bool)) (and BOUND_VARIABLE_1133671 BOUND_VARIABLE_1133672)) (nullable.lift (lambda ((BOUND_VARIABLE_1133659 Int) (BOUND_VARIABLE_1133660 Int)) (> BOUND_VARIABLE_1133659 BOUND_VARIABLE_1133660)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_1133665 Int) (BOUND_VARIABLE_1133666 Int)) (> BOUND_VARIABLE_1133665 BOUND_VARIABLE_1133666)) ((_ tuple.select 9) t) (nullable.some 20))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1133677 Bool) (BOUND_VARIABLE_1133678 Bool)) (or BOUND_VARIABLE_1133677 BOUND_VARIABLE_1133678)) (nullable.lift (lambda ((BOUND_VARIABLE_1133653 Bool) (BOUND_VARIABLE_1133654 Bool)) (and BOUND_VARIABLE_1133653 BOUND_VARIABLE_1133654)) (nullable.lift (lambda ((BOUND_VARIABLE_1133640 Int) (BOUND_VARIABLE_1133641 Int)) (< BOUND_VARIABLE_1133640 BOUND_VARIABLE_1133641)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1133647 Int) (BOUND_VARIABLE_1133648 Int)) (< BOUND_VARIABLE_1133647 BOUND_VARIABLE_1133648)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1133671 Bool) (BOUND_VARIABLE_1133672 Bool)) (and BOUND_VARIABLE_1133671 BOUND_VARIABLE_1133672)) (nullable.lift (lambda ((BOUND_VARIABLE_1133659 Int) (BOUND_VARIABLE_1133660 Int)) (> BOUND_VARIABLE_1133659 BOUND_VARIABLE_1133660)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_1133665 Int) (BOUND_VARIABLE_1133666 Int)) (> BOUND_VARIABLE_1133665 BOUND_VARIABLE_1133666)) ((_ tuple.select 9) t) (nullable.some 20)))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p0 (table.product EMP DEPT)))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p3 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)) ((_ table.project 0 1) (bag.filter p2 DEPT)))))))
(check-sat)
;answer: unsat
; duration: 950 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1142033 Bool) (BOUND_VARIABLE_1142034 Bool)) (or BOUND_VARIABLE_1142033 BOUND_VARIABLE_1142034)) (nullable.lift (lambda ((BOUND_VARIABLE_1142008 Bool) (BOUND_VARIABLE_1142009 Bool)) (and BOUND_VARIABLE_1142008 BOUND_VARIABLE_1142009)) (nullable.lift (lambda ((BOUND_VARIABLE_1141996 Int) (BOUND_VARIABLE_1141997 Int)) (> BOUND_VARIABLE_1141996 BOUND_VARIABLE_1141997)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1142002 Int) (BOUND_VARIABLE_1142003 Int)) (<= BOUND_VARIABLE_1142002 BOUND_VARIABLE_1142003)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.lift (lambda ((BOUND_VARIABLE_1142027 Bool) (BOUND_VARIABLE_1142028 Bool)) (and BOUND_VARIABLE_1142027 BOUND_VARIABLE_1142028)) (nullable.lift (lambda ((BOUND_VARIABLE_1142014 Int) (BOUND_VARIABLE_1142015 Int)) (> BOUND_VARIABLE_1142014 BOUND_VARIABLE_1142015)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_1142021 Int) (BOUND_VARIABLE_1142022 Int)) (> BOUND_VARIABLE_1142021 BOUND_VARIABLE_1142022)) ((_ tuple.select 9) t) (nullable.some 20))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1142033 Bool) (BOUND_VARIABLE_1142034 Bool)) (or BOUND_VARIABLE_1142033 BOUND_VARIABLE_1142034)) (nullable.lift (lambda ((BOUND_VARIABLE_1142008 Bool) (BOUND_VARIABLE_1142009 Bool)) (and BOUND_VARIABLE_1142008 BOUND_VARIABLE_1142009)) (nullable.lift (lambda ((BOUND_VARIABLE_1141996 Int) (BOUND_VARIABLE_1141997 Int)) (> BOUND_VARIABLE_1141996 BOUND_VARIABLE_1141997)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1142002 Int) (BOUND_VARIABLE_1142003 Int)) (<= BOUND_VARIABLE_1142002 BOUND_VARIABLE_1142003)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.lift (lambda ((BOUND_VARIABLE_1142027 Bool) (BOUND_VARIABLE_1142028 Bool)) (and BOUND_VARIABLE_1142027 BOUND_VARIABLE_1142028)) (nullable.lift (lambda ((BOUND_VARIABLE_1142014 Int) (BOUND_VARIABLE_1142015 Int)) (> BOUND_VARIABLE_1142014 BOUND_VARIABLE_1142015)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_1142021 Int) (BOUND_VARIABLE_1142022 Int)) (> BOUND_VARIABLE_1142021 BOUND_VARIABLE_1142022)) ((_ tuple.select 9) t) (nullable.some 20)))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1142077 Bool) (BOUND_VARIABLE_1142078 Bool)) (or BOUND_VARIABLE_1142077 BOUND_VARIABLE_1142078)) (nullable.lift (lambda ((BOUND_VARIABLE_1142065 Bool) (BOUND_VARIABLE_1142066 Bool)) (and BOUND_VARIABLE_1142065 BOUND_VARIABLE_1142066)) (nullable.lift (lambda ((BOUND_VARIABLE_1142053 Int) (BOUND_VARIABLE_1142054 Int)) (> BOUND_VARIABLE_1142053 BOUND_VARIABLE_1142054)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1142059 Int) (BOUND_VARIABLE_1142060 Int)) (<= BOUND_VARIABLE_1142059 BOUND_VARIABLE_1142060)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.lift (lambda ((BOUND_VARIABLE_1142071 Int) (BOUND_VARIABLE_1142072 Int)) (> BOUND_VARIABLE_1142071 BOUND_VARIABLE_1142072)) ((_ tuple.select 0) t) (nullable.some 20)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1142077 Bool) (BOUND_VARIABLE_1142078 Bool)) (or BOUND_VARIABLE_1142077 BOUND_VARIABLE_1142078)) (nullable.lift (lambda ((BOUND_VARIABLE_1142065 Bool) (BOUND_VARIABLE_1142066 Bool)) (and BOUND_VARIABLE_1142065 BOUND_VARIABLE_1142066)) (nullable.lift (lambda ((BOUND_VARIABLE_1142053 Int) (BOUND_VARIABLE_1142054 Int)) (> BOUND_VARIABLE_1142053 BOUND_VARIABLE_1142054)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1142059 Int) (BOUND_VARIABLE_1142060 Int)) (<= BOUND_VARIABLE_1142059 BOUND_VARIABLE_1142060)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.lift (lambda ((BOUND_VARIABLE_1142071 Int) (BOUND_VARIABLE_1142072 Int)) (> BOUND_VARIABLE_1142071 BOUND_VARIABLE_1142072)) ((_ tuple.select 0) t) (nullable.some 20))))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1142134 Bool) (BOUND_VARIABLE_1142135 Bool)) (or BOUND_VARIABLE_1142134 BOUND_VARIABLE_1142135)) (nullable.lift (lambda ((BOUND_VARIABLE_1142109 Bool) (BOUND_VARIABLE_1142110 Bool)) (and BOUND_VARIABLE_1142109 BOUND_VARIABLE_1142110)) (nullable.lift (lambda ((BOUND_VARIABLE_1142097 Int) (BOUND_VARIABLE_1142098 Int)) (> BOUND_VARIABLE_1142097 BOUND_VARIABLE_1142098)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1142103 Int) (BOUND_VARIABLE_1142104 Int)) (<= BOUND_VARIABLE_1142103 BOUND_VARIABLE_1142104)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.lift (lambda ((BOUND_VARIABLE_1142128 Bool) (BOUND_VARIABLE_1142129 Bool)) (and BOUND_VARIABLE_1142128 BOUND_VARIABLE_1142129)) (nullable.lift (lambda ((BOUND_VARIABLE_1142115 Int) (BOUND_VARIABLE_1142116 Int)) (> BOUND_VARIABLE_1142115 BOUND_VARIABLE_1142116)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_1142122 Int) (BOUND_VARIABLE_1142123 Int)) (> BOUND_VARIABLE_1142122 BOUND_VARIABLE_1142123)) ((_ tuple.select 9) t) (nullable.some 20))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1142134 Bool) (BOUND_VARIABLE_1142135 Bool)) (or BOUND_VARIABLE_1142134 BOUND_VARIABLE_1142135)) (nullable.lift (lambda ((BOUND_VARIABLE_1142109 Bool) (BOUND_VARIABLE_1142110 Bool)) (and BOUND_VARIABLE_1142109 BOUND_VARIABLE_1142110)) (nullable.lift (lambda ((BOUND_VARIABLE_1142097 Int) (BOUND_VARIABLE_1142098 Int)) (> BOUND_VARIABLE_1142097 BOUND_VARIABLE_1142098)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1142103 Int) (BOUND_VARIABLE_1142104 Int)) (<= BOUND_VARIABLE_1142103 BOUND_VARIABLE_1142104)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.lift (lambda ((BOUND_VARIABLE_1142128 Bool) (BOUND_VARIABLE_1142129 Bool)) (and BOUND_VARIABLE_1142128 BOUND_VARIABLE_1142129)) (nullable.lift (lambda ((BOUND_VARIABLE_1142115 Int) (BOUND_VARIABLE_1142116 Int)) (> BOUND_VARIABLE_1142115 BOUND_VARIABLE_1142116)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_1142122 Int) (BOUND_VARIABLE_1142123 Int)) (> BOUND_VARIABLE_1142122 BOUND_VARIABLE_1142123)) ((_ tuple.select 9) t) (nullable.some 20)))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p0 (table.product EMP DEPT)))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p2 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)) DEPT)))))
(check-sat)
;answer: unsat
; duration: 807 ms.
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

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const leftJoin4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const leftJoin1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1149788 Bool) (BOUND_VARIABLE_1149789 Bool)) (or BOUND_VARIABLE_1149788 BOUND_VARIABLE_1149789)) (nullable.lift (lambda ((BOUND_VARIABLE_1149764 Bool) (BOUND_VARIABLE_1149765 Bool)) (and BOUND_VARIABLE_1149764 BOUND_VARIABLE_1149765)) (nullable.lift (lambda ((BOUND_VARIABLE_1149751 Int) (BOUND_VARIABLE_1149752 Int)) (< BOUND_VARIABLE_1149751 BOUND_VARIABLE_1149752)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1149758 Int) (BOUND_VARIABLE_1149759 Int)) (< BOUND_VARIABLE_1149758 BOUND_VARIABLE_1149759)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1149782 Bool) (BOUND_VARIABLE_1149783 Bool)) (and BOUND_VARIABLE_1149782 BOUND_VARIABLE_1149783)) (nullable.lift (lambda ((BOUND_VARIABLE_1149770 Int) (BOUND_VARIABLE_1149771 Int)) (> BOUND_VARIABLE_1149770 BOUND_VARIABLE_1149771)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_1149776 Int) (BOUND_VARIABLE_1149777 Int)) (> BOUND_VARIABLE_1149776 BOUND_VARIABLE_1149777)) ((_ tuple.select 9) t) (nullable.some 20))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1149788 Bool) (BOUND_VARIABLE_1149789 Bool)) (or BOUND_VARIABLE_1149788 BOUND_VARIABLE_1149789)) (nullable.lift (lambda ((BOUND_VARIABLE_1149764 Bool) (BOUND_VARIABLE_1149765 Bool)) (and BOUND_VARIABLE_1149764 BOUND_VARIABLE_1149765)) (nullable.lift (lambda ((BOUND_VARIABLE_1149751 Int) (BOUND_VARIABLE_1149752 Int)) (< BOUND_VARIABLE_1149751 BOUND_VARIABLE_1149752)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1149758 Int) (BOUND_VARIABLE_1149759 Int)) (< BOUND_VARIABLE_1149758 BOUND_VARIABLE_1149759)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1149782 Bool) (BOUND_VARIABLE_1149783 Bool)) (and BOUND_VARIABLE_1149782 BOUND_VARIABLE_1149783)) (nullable.lift (lambda ((BOUND_VARIABLE_1149770 Int) (BOUND_VARIABLE_1149771 Int)) (> BOUND_VARIABLE_1149770 BOUND_VARIABLE_1149771)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_1149776 Int) (BOUND_VARIABLE_1149777 Int)) (> BOUND_VARIABLE_1149776 BOUND_VARIABLE_1149777)) ((_ tuple.select 9) t) (nullable.some 20)))))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1149853 Bool) (BOUND_VARIABLE_1149854 Bool)) (or BOUND_VARIABLE_1149853 BOUND_VARIABLE_1149854)) (nullable.lift (lambda ((BOUND_VARIABLE_1149841 Int) (BOUND_VARIABLE_1149842 Int)) (< BOUND_VARIABLE_1149841 BOUND_VARIABLE_1149842)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1149847 Int) (BOUND_VARIABLE_1149848 Int)) (> BOUND_VARIABLE_1149847 BOUND_VARIABLE_1149848)) ((_ tuple.select 0) t) (nullable.some 20)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1149853 Bool) (BOUND_VARIABLE_1149854 Bool)) (or BOUND_VARIABLE_1149853 BOUND_VARIABLE_1149854)) (nullable.lift (lambda ((BOUND_VARIABLE_1149841 Int) (BOUND_VARIABLE_1149842 Int)) (< BOUND_VARIABLE_1149841 BOUND_VARIABLE_1149842)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1149847 Int) (BOUND_VARIABLE_1149848 Int)) (> BOUND_VARIABLE_1149847 BOUND_VARIABLE_1149848)) ((_ tuple.select 0) t) (nullable.some 20))))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1149910 Bool) (BOUND_VARIABLE_1149911 Bool)) (or BOUND_VARIABLE_1149910 BOUND_VARIABLE_1149911)) (nullable.lift (lambda ((BOUND_VARIABLE_1149886 Bool) (BOUND_VARIABLE_1149887 Bool)) (and BOUND_VARIABLE_1149886 BOUND_VARIABLE_1149887)) (nullable.lift (lambda ((BOUND_VARIABLE_1149873 Int) (BOUND_VARIABLE_1149874 Int)) (< BOUND_VARIABLE_1149873 BOUND_VARIABLE_1149874)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1149880 Int) (BOUND_VARIABLE_1149881 Int)) (< BOUND_VARIABLE_1149880 BOUND_VARIABLE_1149881)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1149904 Bool) (BOUND_VARIABLE_1149905 Bool)) (and BOUND_VARIABLE_1149904 BOUND_VARIABLE_1149905)) (nullable.lift (lambda ((BOUND_VARIABLE_1149892 Int) (BOUND_VARIABLE_1149893 Int)) (> BOUND_VARIABLE_1149892 BOUND_VARIABLE_1149893)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_1149898 Int) (BOUND_VARIABLE_1149899 Int)) (> BOUND_VARIABLE_1149898 BOUND_VARIABLE_1149899)) ((_ tuple.select 9) t) (nullable.some 20))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1149910 Bool) (BOUND_VARIABLE_1149911 Bool)) (or BOUND_VARIABLE_1149910 BOUND_VARIABLE_1149911)) (nullable.lift (lambda ((BOUND_VARIABLE_1149886 Bool) (BOUND_VARIABLE_1149887 Bool)) (and BOUND_VARIABLE_1149886 BOUND_VARIABLE_1149887)) (nullable.lift (lambda ((BOUND_VARIABLE_1149873 Int) (BOUND_VARIABLE_1149874 Int)) (< BOUND_VARIABLE_1149873 BOUND_VARIABLE_1149874)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1149880 Int) (BOUND_VARIABLE_1149881 Int)) (< BOUND_VARIABLE_1149880 BOUND_VARIABLE_1149881)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1149904 Bool) (BOUND_VARIABLE_1149905 Bool)) (and BOUND_VARIABLE_1149904 BOUND_VARIABLE_1149905)) (nullable.lift (lambda ((BOUND_VARIABLE_1149892 Int) (BOUND_VARIABLE_1149893 Int)) (> BOUND_VARIABLE_1149892 BOUND_VARIABLE_1149893)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_1149898 Int) (BOUND_VARIABLE_1149899 Int)) (> BOUND_VARIABLE_1149898 BOUND_VARIABLE_1149899)) ((_ tuple.select 9) t) (nullable.some 20)))))))))
(assert (= leftJoin4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map leftJoin1 (bag.difference_remove EMP ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 (table.product EMP DEPT))))) (bag.filter p0 (table.product EMP DEPT))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map leftJoin4 (bag.difference_remove EMP ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 (table.product EMP ((_ table.project 0 1) (bag.filter p2 DEPT))))))) (bag.filter p3 (table.product EMP ((_ table.project 0 1) (bag.filter p2 DEPT))))))))
(check-sat)
;answer: unsat
; duration: 3702 ms.
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const rightJoin1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const rightJoin4 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167470 Bool) (BOUND_VARIABLE_1167471 Bool)) (or BOUND_VARIABLE_1167470 BOUND_VARIABLE_1167471)) (nullable.lift (lambda ((BOUND_VARIABLE_1167446 Bool) (BOUND_VARIABLE_1167447 Bool)) (and BOUND_VARIABLE_1167446 BOUND_VARIABLE_1167447)) (nullable.lift (lambda ((BOUND_VARIABLE_1167433 Int) (BOUND_VARIABLE_1167434 Int)) (< BOUND_VARIABLE_1167433 BOUND_VARIABLE_1167434)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1167440 Int) (BOUND_VARIABLE_1167441 Int)) (< BOUND_VARIABLE_1167440 BOUND_VARIABLE_1167441)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1167464 Bool) (BOUND_VARIABLE_1167465 Bool)) (and BOUND_VARIABLE_1167464 BOUND_VARIABLE_1167465)) (nullable.lift (lambda ((BOUND_VARIABLE_1167452 Int) (BOUND_VARIABLE_1167453 Int)) (> BOUND_VARIABLE_1167452 BOUND_VARIABLE_1167453)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_1167458 Int) (BOUND_VARIABLE_1167459 Int)) (> BOUND_VARIABLE_1167458 BOUND_VARIABLE_1167459)) ((_ tuple.select 9) t) (nullable.some 20))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167470 Bool) (BOUND_VARIABLE_1167471 Bool)) (or BOUND_VARIABLE_1167470 BOUND_VARIABLE_1167471)) (nullable.lift (lambda ((BOUND_VARIABLE_1167446 Bool) (BOUND_VARIABLE_1167447 Bool)) (and BOUND_VARIABLE_1167446 BOUND_VARIABLE_1167447)) (nullable.lift (lambda ((BOUND_VARIABLE_1167433 Int) (BOUND_VARIABLE_1167434 Int)) (< BOUND_VARIABLE_1167433 BOUND_VARIABLE_1167434)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1167440 Int) (BOUND_VARIABLE_1167441 Int)) (< BOUND_VARIABLE_1167440 BOUND_VARIABLE_1167441)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1167464 Bool) (BOUND_VARIABLE_1167465 Bool)) (and BOUND_VARIABLE_1167464 BOUND_VARIABLE_1167465)) (nullable.lift (lambda ((BOUND_VARIABLE_1167452 Int) (BOUND_VARIABLE_1167453 Int)) (> BOUND_VARIABLE_1167452 BOUND_VARIABLE_1167453)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_1167458 Int) (BOUND_VARIABLE_1167459 Int)) (> BOUND_VARIABLE_1167458 BOUND_VARIABLE_1167459)) ((_ tuple.select 9) t) (nullable.some 20)))))))))
(assert (= rightJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167528 Bool) (BOUND_VARIABLE_1167529 Bool)) (or BOUND_VARIABLE_1167528 BOUND_VARIABLE_1167529)) (nullable.lift (lambda ((BOUND_VARIABLE_1167516 Int) (BOUND_VARIABLE_1167517 Int)) (< BOUND_VARIABLE_1167516 BOUND_VARIABLE_1167517)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1167522 Int) (BOUND_VARIABLE_1167523 Int)) (> BOUND_VARIABLE_1167522 BOUND_VARIABLE_1167523)) ((_ tuple.select 0) t) (nullable.some 20)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167528 Bool) (BOUND_VARIABLE_1167529 Bool)) (or BOUND_VARIABLE_1167528 BOUND_VARIABLE_1167529)) (nullable.lift (lambda ((BOUND_VARIABLE_1167516 Int) (BOUND_VARIABLE_1167517 Int)) (< BOUND_VARIABLE_1167516 BOUND_VARIABLE_1167517)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1167522 Int) (BOUND_VARIABLE_1167523 Int)) (> BOUND_VARIABLE_1167522 BOUND_VARIABLE_1167523)) ((_ tuple.select 0) t) (nullable.some 20))))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167585 Bool) (BOUND_VARIABLE_1167586 Bool)) (or BOUND_VARIABLE_1167585 BOUND_VARIABLE_1167586)) (nullable.lift (lambda ((BOUND_VARIABLE_1167561 Bool) (BOUND_VARIABLE_1167562 Bool)) (and BOUND_VARIABLE_1167561 BOUND_VARIABLE_1167562)) (nullable.lift (lambda ((BOUND_VARIABLE_1167548 Int) (BOUND_VARIABLE_1167549 Int)) (< BOUND_VARIABLE_1167548 BOUND_VARIABLE_1167549)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1167555 Int) (BOUND_VARIABLE_1167556 Int)) (< BOUND_VARIABLE_1167555 BOUND_VARIABLE_1167556)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1167579 Bool) (BOUND_VARIABLE_1167580 Bool)) (and BOUND_VARIABLE_1167579 BOUND_VARIABLE_1167580)) (nullable.lift (lambda ((BOUND_VARIABLE_1167567 Int) (BOUND_VARIABLE_1167568 Int)) (> BOUND_VARIABLE_1167567 BOUND_VARIABLE_1167568)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_1167573 Int) (BOUND_VARIABLE_1167574 Int)) (> BOUND_VARIABLE_1167573 BOUND_VARIABLE_1167574)) ((_ tuple.select 9) t) (nullable.some 20))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167585 Bool) (BOUND_VARIABLE_1167586 Bool)) (or BOUND_VARIABLE_1167585 BOUND_VARIABLE_1167586)) (nullable.lift (lambda ((BOUND_VARIABLE_1167561 Bool) (BOUND_VARIABLE_1167562 Bool)) (and BOUND_VARIABLE_1167561 BOUND_VARIABLE_1167562)) (nullable.lift (lambda ((BOUND_VARIABLE_1167548 Int) (BOUND_VARIABLE_1167549 Int)) (< BOUND_VARIABLE_1167548 BOUND_VARIABLE_1167549)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1167555 Int) (BOUND_VARIABLE_1167556 Int)) (< BOUND_VARIABLE_1167555 BOUND_VARIABLE_1167556)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1167579 Bool) (BOUND_VARIABLE_1167580 Bool)) (and BOUND_VARIABLE_1167579 BOUND_VARIABLE_1167580)) (nullable.lift (lambda ((BOUND_VARIABLE_1167567 Int) (BOUND_VARIABLE_1167568 Int)) (> BOUND_VARIABLE_1167567 BOUND_VARIABLE_1167568)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_1167573 Int) (BOUND_VARIABLE_1167574 Int)) (> BOUND_VARIABLE_1167573 BOUND_VARIABLE_1167574)) ((_ tuple.select 9) t) (nullable.some 20)))))))))
(assert (= rightJoin4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map rightJoin1 (bag.difference_remove DEPT ((_ table.project 9 10) (bag.filter p0 (table.product EMP DEPT))))) (bag.filter p0 (table.product EMP DEPT))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map rightJoin4 (bag.difference_remove DEPT ((_ table.project 9 10) (bag.filter p3 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)) DEPT))))) (bag.filter p3 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)) DEPT))))))
(check-sat)
;answer: unsat
; duration: 3543 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1184889 Int) (BOUND_VARIABLE_1184890 Int)) (> BOUND_VARIABLE_1184889 BOUND_VARIABLE_1184890)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1184889 Int) (BOUND_VARIABLE_1184890 Int)) (> BOUND_VARIABLE_1184889 BOUND_VARIABLE_1184890)) ((_ tuple.select 0) t) (nullable.some 0)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1184909 Int) (BOUND_VARIABLE_1184910 Int)) (< BOUND_VARIABLE_1184909 BOUND_VARIABLE_1184910)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1184909 Int) (BOUND_VARIABLE_1184910 Int)) (< BOUND_VARIABLE_1184909 BOUND_VARIABLE_1184910)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1184960 Bool) (BOUND_VARIABLE_1184961 Bool)) (and BOUND_VARIABLE_1184960 BOUND_VARIABLE_1184961)) (nullable.lift (lambda ((BOUND_VARIABLE_1184929 Int) (BOUND_VARIABLE_1184930 Int)) (> BOUND_VARIABLE_1184929 BOUND_VARIABLE_1184930)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_1184955 Bool)) (not BOUND_VARIABLE_1184955)) (ite (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1184941 Int) (BOUND_VARIABLE_1184942 Int)) (< BOUND_VARIABLE_1184941 BOUND_VARIABLE_1184942)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1184948 Int) (BOUND_VARIABLE_1184949 Int)) (< BOUND_VARIABLE_1184948 BOUND_VARIABLE_1184949)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some false))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1184960 Bool) (BOUND_VARIABLE_1184961 Bool)) (and BOUND_VARIABLE_1184960 BOUND_VARIABLE_1184961)) (nullable.lift (lambda ((BOUND_VARIABLE_1184929 Int) (BOUND_VARIABLE_1184930 Int)) (> BOUND_VARIABLE_1184929 BOUND_VARIABLE_1184930)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_1184955 Bool)) (not BOUND_VARIABLE_1184955)) (ite (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1184941 Int) (BOUND_VARIABLE_1184942 Int)) (< BOUND_VARIABLE_1184941 BOUND_VARIABLE_1184942)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1184948 Int) (BOUND_VARIABLE_1184949 Int)) (< BOUND_VARIABLE_1184948 BOUND_VARIABLE_1184949)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some false)))))))))
(assert (= q1 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)))))
(check-sat)
;answer: unsat
; duration: 517 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1189389 Bool) (BOUND_VARIABLE_1189390 Bool)) (and BOUND_VARIABLE_1189389 BOUND_VARIABLE_1189390)) (as nullable.null (Nullable Bool)) (nullable.some true))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1189389 Bool) (BOUND_VARIABLE_1189390 Bool)) (and BOUND_VARIABLE_1189389 BOUND_VARIABLE_1189390)) (as nullable.null (Nullable Bool)) (nullable.some true)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) false)))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 13 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1189476 Bool) (BOUND_VARIABLE_1189477 Bool)) (or BOUND_VARIABLE_1189476 BOUND_VARIABLE_1189477)) (nullable.lift (lambda ((BOUND_VARIABLE_1189470 Int) (BOUND_VARIABLE_1189471 Int)) (= BOUND_VARIABLE_1189470 BOUND_VARIABLE_1189471)) ((_ tuple.select 0) t) (nullable.some 0)) (as nullable.null (Nullable Bool)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1189476 Bool) (BOUND_VARIABLE_1189477 Bool)) (or BOUND_VARIABLE_1189476 BOUND_VARIABLE_1189477)) (nullable.lift (lambda ((BOUND_VARIABLE_1189470 Int) (BOUND_VARIABLE_1189471 Int)) (= BOUND_VARIABLE_1189470 BOUND_VARIABLE_1189471)) ((_ tuple.select 0) t) (nullable.some 0)) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1189501 Bool) (BOUND_VARIABLE_1189502 Bool)) (or BOUND_VARIABLE_1189501 BOUND_VARIABLE_1189502)) (nullable.lift (lambda ((BOUND_VARIABLE_1189495 Int) (BOUND_VARIABLE_1189496 Int)) (= BOUND_VARIABLE_1189495 BOUND_VARIABLE_1189496)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.some false))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1189501 Bool) (BOUND_VARIABLE_1189502 Bool)) (or BOUND_VARIABLE_1189501 BOUND_VARIABLE_1189502)) (nullable.lift (lambda ((BOUND_VARIABLE_1189495 Int) (BOUND_VARIABLE_1189496 Int)) (= BOUND_VARIABLE_1189495 BOUND_VARIABLE_1189496)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.some false)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 193 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1191441 Bool) (BOUND_VARIABLE_1191442 Bool)) (and BOUND_VARIABLE_1191441 BOUND_VARIABLE_1191442)) (nullable.lift (lambda ((BOUND_VARIABLE_1191435 Int) (BOUND_VARIABLE_1191436 Int)) (> BOUND_VARIABLE_1191435 BOUND_VARIABLE_1191436)) ((_ tuple.select 0) t) (nullable.some 0)) (as nullable.null (Nullable Bool)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1191441 Bool) (BOUND_VARIABLE_1191442 Bool)) (and BOUND_VARIABLE_1191441 BOUND_VARIABLE_1191442)) (nullable.lift (lambda ((BOUND_VARIABLE_1191435 Int) (BOUND_VARIABLE_1191436 Int)) (> BOUND_VARIABLE_1191435 BOUND_VARIABLE_1191436)) ((_ tuple.select 0) t) (nullable.some 0)) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1191467 Bool) (BOUND_VARIABLE_1191468 Bool)) (and BOUND_VARIABLE_1191467 BOUND_VARIABLE_1191468)) (nullable.lift (lambda ((BOUND_VARIABLE_1191461 Int) (BOUND_VARIABLE_1191462 Int)) (> BOUND_VARIABLE_1191461 BOUND_VARIABLE_1191462)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.some false))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1191467 Bool) (BOUND_VARIABLE_1191468 Bool)) (and BOUND_VARIABLE_1191467 BOUND_VARIABLE_1191468)) (nullable.lift (lambda ((BOUND_VARIABLE_1191461 Int) (BOUND_VARIABLE_1191462 Int)) (> BOUND_VARIABLE_1191461 BOUND_VARIABLE_1191462)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.some false)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 74 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1192543 Int) (BOUND_VARIABLE_1192544 Int)) (= BOUND_VARIABLE_1192543 BOUND_VARIABLE_1192544)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.some false) (as nullable.null (Nullable Bool)))) (nullable.val (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1192543 Int) (BOUND_VARIABLE_1192544 Int)) (= BOUND_VARIABLE_1192543 BOUND_VARIABLE_1192544)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.some false) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1192564 Int) (BOUND_VARIABLE_1192565 Int)) (= BOUND_VARIABLE_1192564 BOUND_VARIABLE_1192565)) ((_ tuple.select 0) t) (nullable.some 1))) false false))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 70 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1193536 Int) (BOUND_VARIABLE_1193537 Int)) (= BOUND_VARIABLE_1193536 BOUND_VARIABLE_1193537)) ((_ tuple.select 0) t) (nullable.some 1))) (as nullable.null (Nullable Bool)) (nullable.some true))) (nullable.val (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1193536 Int) (BOUND_VARIABLE_1193537 Int)) (= BOUND_VARIABLE_1193536 BOUND_VARIABLE_1193537)) ((_ tuple.select 0) t) (nullable.some 1))) (as nullable.null (Nullable Bool)) (nullable.some true)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1193557 Int) (BOUND_VARIABLE_1193558 Int)) (= BOUND_VARIABLE_1193557 BOUND_VARIABLE_1193558)) ((_ tuple.select 0) t) (nullable.some 1))) false true))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 108 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1195038 Bool) (BOUND_VARIABLE_1195039 Bool)) (or BOUND_VARIABLE_1195038 BOUND_VARIABLE_1195039)) (nullable.lift (lambda ((BOUND_VARIABLE_1195032 Int) (BOUND_VARIABLE_1195033 Int)) (= BOUND_VARIABLE_1195032 BOUND_VARIABLE_1195033)) ((_ tuple.select 0) t) (nullable.some 1)) (as nullable.null (Nullable Bool)))) (nullable.lift (lambda ((BOUND_VARIABLE_1195045 Int) (BOUND_VARIABLE_1195046 Int)) (< BOUND_VARIABLE_1195045 BOUND_VARIABLE_1195046)) ((_ tuple.select 6) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1195051 Int) (BOUND_VARIABLE_1195052 Int)) (> BOUND_VARIABLE_1195051 BOUND_VARIABLE_1195052)) ((_ tuple.select 6) t) (nullable.some 10)))) (nullable.val (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1195038 Bool) (BOUND_VARIABLE_1195039 Bool)) (or BOUND_VARIABLE_1195038 BOUND_VARIABLE_1195039)) (nullable.lift (lambda ((BOUND_VARIABLE_1195032 Int) (BOUND_VARIABLE_1195033 Int)) (= BOUND_VARIABLE_1195032 BOUND_VARIABLE_1195033)) ((_ tuple.select 0) t) (nullable.some 1)) (as nullable.null (Nullable Bool)))) (nullable.lift (lambda ((BOUND_VARIABLE_1195045 Int) (BOUND_VARIABLE_1195046 Int)) (< BOUND_VARIABLE_1195045 BOUND_VARIABLE_1195046)) ((_ tuple.select 6) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1195051 Int) (BOUND_VARIABLE_1195052 Int)) (> BOUND_VARIABLE_1195051 BOUND_VARIABLE_1195052)) ((_ tuple.select 6) t) (nullable.some 10))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1195078 Bool) (BOUND_VARIABLE_1195079 Bool)) (or BOUND_VARIABLE_1195078 BOUND_VARIABLE_1195079)) (nullable.lift (lambda ((BOUND_VARIABLE_1195072 Int) (BOUND_VARIABLE_1195073 Int)) (= BOUND_VARIABLE_1195072 BOUND_VARIABLE_1195073)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some false))) (nullable.lift (lambda ((BOUND_VARIABLE_1195085 Int) (BOUND_VARIABLE_1195086 Int)) (< BOUND_VARIABLE_1195085 BOUND_VARIABLE_1195086)) ((_ tuple.select 6) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1195091 Int) (BOUND_VARIABLE_1195092 Int)) (> BOUND_VARIABLE_1195091 BOUND_VARIABLE_1195092)) ((_ tuple.select 6) t) (nullable.some 10)))) (nullable.val (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1195078 Bool) (BOUND_VARIABLE_1195079 Bool)) (or BOUND_VARIABLE_1195078 BOUND_VARIABLE_1195079)) (nullable.lift (lambda ((BOUND_VARIABLE_1195072 Int) (BOUND_VARIABLE_1195073 Int)) (= BOUND_VARIABLE_1195072 BOUND_VARIABLE_1195073)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some false))) (nullable.lift (lambda ((BOUND_VARIABLE_1195085 Int) (BOUND_VARIABLE_1195086 Int)) (< BOUND_VARIABLE_1195085 BOUND_VARIABLE_1195086)) ((_ tuple.select 6) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1195091 Int) (BOUND_VARIABLE_1195092 Int)) (> BOUND_VARIABLE_1195091 BOUND_VARIABLE_1195092)) ((_ tuple.select 6) t) (nullable.some 10))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 414 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 1) (nullable.some "A") (nullable.some "B") (nullable.some (- 3)) (nullable.some 4) (nullable.some (- 4)) (nullable.some 1) (nullable.some 5) (nullable.some (- 5))) 1))
; )
; q1
(get-value (q1))
; ((_ table.project 0 1 2 3 4 5 6 7 8) (ite (nullable.val (ite (nullable.val (as nullable.null (Nullable Bool))) (nullable.some true) (nullable.some false))) (bag (tuple (nullable.some 1) (nullable.some "A") (nullable.some "B") (nullable.some (- 3)) (nullable.some 4) (nullable.some (- 4)) (nullable.some 1) (nullable.some 5) (nullable.some (- 5))) 1) (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 1) (nullable.some "A") (nullable.some "B") (nullable.some (- 3)) (nullable.some 4) (nullable.some (- 4)) (nullable.some 1) (nullable.some 5) (nullable.some (- 5))) 1)
; insert into EMP values(1,'A','B',-3,4,-4,1,5,-5)
; SELECT * FROM (SELECT * FROM emp WHERE CASE WHEN empno = 1 OR CAST(NULL AS BOOLEAN) THEN sal < 10 ELSE sal > 10 END) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM emp WHERE CASE WHEN empno = 1 OR FALSE THEN sal < 10 ELSE sal > 10 END) AS q2;

; SELECT * FROM (SELECT * FROM emp WHERE CASE WHEN empno = 1 OR FALSE THEN sal < 10 ELSE sal > 10 END) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM emp WHERE CASE WHEN empno = 1 OR CAST(NULL AS BOOLEAN) THEN sal < 10 ELSE sal > 10 END) AS q1;

;Model soundness: false
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1199338 Bool)) (not BOUND_VARIABLE_1199338)) (nullable.lift (lambda ((BOUND_VARIABLE_1199332 Bool) (BOUND_VARIABLE_1199333 Bool)) (or BOUND_VARIABLE_1199332 BOUND_VARIABLE_1199333)) (nullable.lift (lambda ((BOUND_VARIABLE_1199320 Int) (BOUND_VARIABLE_1199321 Int)) (= BOUND_VARIABLE_1199320 BOUND_VARIABLE_1199321)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_1199326 Int) (BOUND_VARIABLE_1199327 Int)) (= BOUND_VARIABLE_1199326 BOUND_VARIABLE_1199327)) ((_ tuple.select 0) t) (as nullable.null (Nullable Int)))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1199338 Bool)) (not BOUND_VARIABLE_1199338)) (nullable.lift (lambda ((BOUND_VARIABLE_1199332 Bool) (BOUND_VARIABLE_1199333 Bool)) (or BOUND_VARIABLE_1199332 BOUND_VARIABLE_1199333)) (nullable.lift (lambda ((BOUND_VARIABLE_1199320 Int) (BOUND_VARIABLE_1199321 Int)) (= BOUND_VARIABLE_1199320 BOUND_VARIABLE_1199321)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_1199326 Int) (BOUND_VARIABLE_1199327 Int)) (= BOUND_VARIABLE_1199326 BOUND_VARIABLE_1199327)) ((_ tuple.select 0) t) (as nullable.null (Nullable Int))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) false)))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p0 (table.product EMP DEPT)))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p1 (table.product EMP DEPT)))))
(check-sat)
;answer: unsat
; duration: 13 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1199423 Bool) (BOUND_VARIABLE_1199424 Bool)) (and BOUND_VARIABLE_1199423 BOUND_VARIABLE_1199424)) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.lift (lambda ((BOUND_VARIABLE_1199429 Bool) (BOUND_VARIABLE_1199430 Bool)) (or BOUND_VARIABLE_1199429 BOUND_VARIABLE_1199430)) (nullable.some false) (as nullable.null (Nullable Bool))) (nullable.lift (lambda ((BOUND_VARIABLE_1199435 Bool) (BOUND_VARIABLE_1199436 Bool)) (and BOUND_VARIABLE_1199435 BOUND_VARIABLE_1199436)) (as nullable.null (Nullable Bool)) (as nullable.null (Nullable Bool))))) (nullable.val (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1199423 Bool) (BOUND_VARIABLE_1199424 Bool)) (and BOUND_VARIABLE_1199423 BOUND_VARIABLE_1199424)) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.lift (lambda ((BOUND_VARIABLE_1199429 Bool) (BOUND_VARIABLE_1199430 Bool)) (or BOUND_VARIABLE_1199429 BOUND_VARIABLE_1199430)) (nullable.some false) (as nullable.null (Nullable Bool))) (nullable.lift (lambda ((BOUND_VARIABLE_1199435 Bool) (BOUND_VARIABLE_1199436 Bool)) (and BOUND_VARIABLE_1199435 BOUND_VARIABLE_1199436)) (as nullable.null (Nullable Bool)) (as nullable.null (Nullable Bool)))))))))
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_1199538 Bool) (BOUND_VARIABLE_1199539 Bool)) (or BOUND_VARIABLE_1199538 BOUND_VARIABLE_1199539)) (nullable.lift (lambda ((BOUND_VARIABLE_1199532 Int) (BOUND_VARIABLE_1199533 Int)) (= BOUND_VARIABLE_1199532 BOUND_VARIABLE_1199533)) ((_ tuple.select 0) t) (nullable.some 1)) (as nullable.null (Nullable Bool)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_1199556 Int) (BOUND_VARIABLE_1199557 Int)) (= BOUND_VARIABLE_1199556 BOUND_VARIABLE_1199557)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (= q1 (bag.map f0 EMP)))
(assert (= q2 (bag.map f1 EMP)))
(check-sat)
;answer: sat
; duration: 306 ms.
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
; total time: 302753 ms.
; sat answers    : 11
; unsat answers  : 49
; unknown answers: 28
