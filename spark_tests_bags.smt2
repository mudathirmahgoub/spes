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
; duration: 27 ms.
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
; duration: 10014 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_33608 Int) (BOUND_VARIABLE_33609 Int)) (= BOUND_VARIABLE_33608 BOUND_VARIABLE_33609)) ((_ tuple.select 6) t) (nullable.some 3))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_33608 Int) (BOUND_VARIABLE_33609 Int)) (= BOUND_VARIABLE_33608 BOUND_VARIABLE_33609)) ((_ tuple.select 6) t) (nullable.some 3))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_33636 Int) (BOUND_VARIABLE_33637 Int)) (= BOUND_VARIABLE_33636 BOUND_VARIABLE_33637)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_33630 Int) (BOUND_VARIABLE_33631 Int)) (+ BOUND_VARIABLE_33630 BOUND_VARIABLE_33631)) ((_ tuple.select 6) t) (nullable.some 5)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_33636 Int) (BOUND_VARIABLE_33637 Int)) (= BOUND_VARIABLE_33636 BOUND_VARIABLE_33637)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_33630 Int) (BOUND_VARIABLE_33631 Int)) (+ BOUND_VARIABLE_33630 BOUND_VARIABLE_33631)) ((_ tuple.select 6) t) (nullable.some 5))))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_33608 Int) (BOUND_VARIABLE_33609 Int)) (= BOUND_VARIABLE_33608 BOUND_VARIABLE_33609)) ((_ tuple.select 6) t) (nullable.some 3))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_33636 Int) (BOUND_VARIABLE_33637 Int)) (= BOUND_VARIABLE_33636 BOUND_VARIABLE_33637)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_33630 Int) (BOUND_VARIABLE_33631 Int)) (+ BOUND_VARIABLE_33630 BOUND_VARIABLE_33631)) ((_ tuple.select 6) t) (nullable.some 5))))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_33608 Int) (BOUND_VARIABLE_33609 Int)) (= BOUND_VARIABLE_33608 BOUND_VARIABLE_33609)) ((_ tuple.select 6) t) (nullable.some 3))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_33608 Int) (BOUND_VARIABLE_33609 Int)) (= BOUND_VARIABLE_33608 BOUND_VARIABLE_33609)) ((_ tuple.select 6) t) (nullable.some 3))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_33636 Int) (BOUND_VARIABLE_33637 Int)) (= BOUND_VARIABLE_33636 BOUND_VARIABLE_33637)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_33630 Int) (BOUND_VARIABLE_33631 Int)) (+ BOUND_VARIABLE_33630 BOUND_VARIABLE_33631)) ((_ tuple.select 6) t) (nullable.some 5)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_33636 Int) (BOUND_VARIABLE_33637 Int)) (= BOUND_VARIABLE_33636 BOUND_VARIABLE_33637)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_33630 Int) (BOUND_VARIABLE_33631 Int)) (+ BOUND_VARIABLE_33630 BOUND_VARIABLE_33631)) ((_ tuple.select 6) t) (nullable.some 5))))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_33608 Int) (BOUND_VARIABLE_33609 Int)) (= BOUND_VARIABLE_33608 BOUND_VARIABLE_33609)) ((_ tuple.select 6) t) (nullable.some 3))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_33636 Int) (BOUND_VARIABLE_33637 Int)) (= BOUND_VARIABLE_33636 BOUND_VARIABLE_33637)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_33630 Int) (BOUND_VARIABLE_33631 Int)) (+ BOUND_VARIABLE_33630 BOUND_VARIABLE_33631)) ((_ tuple.select 6) t) (nullable.some 5))))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_33676 Int) (BOUND_VARIABLE_33677 Int)) (= BOUND_VARIABLE_33676 BOUND_VARIABLE_33677)) ((_ tuple.select 6) t) (nullable.some 3))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_33676 Int) (BOUND_VARIABLE_33677 Int)) (= BOUND_VARIABLE_33676 BOUND_VARIABLE_33677)) ((_ tuple.select 6) t) (nullable.some 3))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_33683 Int) (BOUND_VARIABLE_33684 Int)) (= BOUND_VARIABLE_33683 BOUND_VARIABLE_33684)) ((_ tuple.select 5) t) (nullable.some 8))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_33683 Int) (BOUND_VARIABLE_33684 Int)) (= BOUND_VARIABLE_33683 BOUND_VARIABLE_33684)) ((_ tuple.select 5) t) (nullable.some 8)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_33676 Int) (BOUND_VARIABLE_33677 Int)) (= BOUND_VARIABLE_33676 BOUND_VARIABLE_33677)) ((_ tuple.select 6) t) (nullable.some 3))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_33683 Int) (BOUND_VARIABLE_33684 Int)) (= BOUND_VARIABLE_33683 BOUND_VARIABLE_33684)) ((_ tuple.select 5) t) (nullable.some 8)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_33676 Int) (BOUND_VARIABLE_33677 Int)) (= BOUND_VARIABLE_33676 BOUND_VARIABLE_33677)) ((_ tuple.select 6) t) (nullable.some 3))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_33676 Int) (BOUND_VARIABLE_33677 Int)) (= BOUND_VARIABLE_33676 BOUND_VARIABLE_33677)) ((_ tuple.select 6) t) (nullable.some 3))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_33683 Int) (BOUND_VARIABLE_33684 Int)) (= BOUND_VARIABLE_33683 BOUND_VARIABLE_33684)) ((_ tuple.select 5) t) (nullable.some 8))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_33683 Int) (BOUND_VARIABLE_33684 Int)) (= BOUND_VARIABLE_33683 BOUND_VARIABLE_33684)) ((_ tuple.select 5) t) (nullable.some 8)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_33676 Int) (BOUND_VARIABLE_33677 Int)) (= BOUND_VARIABLE_33676 BOUND_VARIABLE_33677)) ((_ tuple.select 6) t) (nullable.some 3))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_33683 Int) (BOUND_VARIABLE_33684 Int)) (= BOUND_VARIABLE_33683 BOUND_VARIABLE_33684)) ((_ tuple.select 5) t) (nullable.some 8)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 275 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36730 Int) (BOUND_VARIABLE_36731 Int)) (= BOUND_VARIABLE_36730 BOUND_VARIABLE_36731)) ((_ tuple.select 6) t) (nullable.some 3))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36730 Int) (BOUND_VARIABLE_36731 Int)) (= BOUND_VARIABLE_36730 BOUND_VARIABLE_36731)) ((_ tuple.select 6) t) (nullable.some 3))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36749 Bool)) (not BOUND_VARIABLE_36749)) (nullable.lift (lambda ((BOUND_VARIABLE_36743 Int) (BOUND_VARIABLE_36744 Int)) (= BOUND_VARIABLE_36743 BOUND_VARIABLE_36744)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_36737 Int) (BOUND_VARIABLE_36738 Int)) (+ BOUND_VARIABLE_36737 BOUND_VARIABLE_36738)) ((_ tuple.select 6) t) (nullable.some 5))))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36749 Bool)) (not BOUND_VARIABLE_36749)) (nullable.lift (lambda ((BOUND_VARIABLE_36743 Int) (BOUND_VARIABLE_36744 Int)) (= BOUND_VARIABLE_36743 BOUND_VARIABLE_36744)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_36737 Int) (BOUND_VARIABLE_36738 Int)) (+ BOUND_VARIABLE_36737 BOUND_VARIABLE_36738)) ((_ tuple.select 6) t) (nullable.some 5)))))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_36730 Int) (BOUND_VARIABLE_36731 Int)) (= BOUND_VARIABLE_36730 BOUND_VARIABLE_36731)) ((_ tuple.select 6) t) (nullable.some 3))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_36749 Bool)) (not BOUND_VARIABLE_36749)) (nullable.lift (lambda ((BOUND_VARIABLE_36743 Int) (BOUND_VARIABLE_36744 Int)) (= BOUND_VARIABLE_36743 BOUND_VARIABLE_36744)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_36737 Int) (BOUND_VARIABLE_36738 Int)) (+ BOUND_VARIABLE_36737 BOUND_VARIABLE_36738)) ((_ tuple.select 6) t) (nullable.some 5)))))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36730 Int) (BOUND_VARIABLE_36731 Int)) (= BOUND_VARIABLE_36730 BOUND_VARIABLE_36731)) ((_ tuple.select 6) t) (nullable.some 3))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36730 Int) (BOUND_VARIABLE_36731 Int)) (= BOUND_VARIABLE_36730 BOUND_VARIABLE_36731)) ((_ tuple.select 6) t) (nullable.some 3))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36749 Bool)) (not BOUND_VARIABLE_36749)) (nullable.lift (lambda ((BOUND_VARIABLE_36743 Int) (BOUND_VARIABLE_36744 Int)) (= BOUND_VARIABLE_36743 BOUND_VARIABLE_36744)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_36737 Int) (BOUND_VARIABLE_36738 Int)) (+ BOUND_VARIABLE_36737 BOUND_VARIABLE_36738)) ((_ tuple.select 6) t) (nullable.some 5))))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36749 Bool)) (not BOUND_VARIABLE_36749)) (nullable.lift (lambda ((BOUND_VARIABLE_36743 Int) (BOUND_VARIABLE_36744 Int)) (= BOUND_VARIABLE_36743 BOUND_VARIABLE_36744)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_36737 Int) (BOUND_VARIABLE_36738 Int)) (+ BOUND_VARIABLE_36737 BOUND_VARIABLE_36738)) ((_ tuple.select 6) t) (nullable.some 5)))))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_36730 Int) (BOUND_VARIABLE_36731 Int)) (= BOUND_VARIABLE_36730 BOUND_VARIABLE_36731)) ((_ tuple.select 6) t) (nullable.some 3))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_36749 Bool)) (not BOUND_VARIABLE_36749)) (nullable.lift (lambda ((BOUND_VARIABLE_36743 Int) (BOUND_VARIABLE_36744 Int)) (= BOUND_VARIABLE_36743 BOUND_VARIABLE_36744)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_36737 Int) (BOUND_VARIABLE_36738 Int)) (+ BOUND_VARIABLE_36737 BOUND_VARIABLE_36738)) ((_ tuple.select 6) t) (nullable.some 5)))))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36783 Int) (BOUND_VARIABLE_36784 Int)) (= BOUND_VARIABLE_36783 BOUND_VARIABLE_36784)) ((_ tuple.select 6) t) (nullable.some 3))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36783 Int) (BOUND_VARIABLE_36784 Int)) (= BOUND_VARIABLE_36783 BOUND_VARIABLE_36784)) ((_ tuple.select 6) t) (nullable.some 3))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36796 Bool)) (not BOUND_VARIABLE_36796)) (nullable.lift (lambda ((BOUND_VARIABLE_36790 Int) (BOUND_VARIABLE_36791 Int)) (= BOUND_VARIABLE_36790 BOUND_VARIABLE_36791)) ((_ tuple.select 5) t) (nullable.some 8)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36796 Bool)) (not BOUND_VARIABLE_36796)) (nullable.lift (lambda ((BOUND_VARIABLE_36790 Int) (BOUND_VARIABLE_36791 Int)) (= BOUND_VARIABLE_36790 BOUND_VARIABLE_36791)) ((_ tuple.select 5) t) (nullable.some 8))))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_36783 Int) (BOUND_VARIABLE_36784 Int)) (= BOUND_VARIABLE_36783 BOUND_VARIABLE_36784)) ((_ tuple.select 6) t) (nullable.some 3))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_36796 Bool)) (not BOUND_VARIABLE_36796)) (nullable.lift (lambda ((BOUND_VARIABLE_36790 Int) (BOUND_VARIABLE_36791 Int)) (= BOUND_VARIABLE_36790 BOUND_VARIABLE_36791)) ((_ tuple.select 5) t) (nullable.some 8))))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36783 Int) (BOUND_VARIABLE_36784 Int)) (= BOUND_VARIABLE_36783 BOUND_VARIABLE_36784)) ((_ tuple.select 6) t) (nullable.some 3))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36783 Int) (BOUND_VARIABLE_36784 Int)) (= BOUND_VARIABLE_36783 BOUND_VARIABLE_36784)) ((_ tuple.select 6) t) (nullable.some 3))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36796 Bool)) (not BOUND_VARIABLE_36796)) (nullable.lift (lambda ((BOUND_VARIABLE_36790 Int) (BOUND_VARIABLE_36791 Int)) (= BOUND_VARIABLE_36790 BOUND_VARIABLE_36791)) ((_ tuple.select 5) t) (nullable.some 8)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36796 Bool)) (not BOUND_VARIABLE_36796)) (nullable.lift (lambda ((BOUND_VARIABLE_36790 Int) (BOUND_VARIABLE_36791 Int)) (= BOUND_VARIABLE_36790 BOUND_VARIABLE_36791)) ((_ tuple.select 5) t) (nullable.some 8))))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_36783 Int) (BOUND_VARIABLE_36784 Int)) (= BOUND_VARIABLE_36783 BOUND_VARIABLE_36784)) ((_ tuple.select 6) t) (nullable.some 3))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_36796 Bool)) (not BOUND_VARIABLE_36796)) (nullable.lift (lambda ((BOUND_VARIABLE_36790 Int) (BOUND_VARIABLE_36791 Int)) (= BOUND_VARIABLE_36790 BOUND_VARIABLE_36791)) ((_ tuple.select 5) t) (nullable.some 8))))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 295 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_40597 Int) (BOUND_VARIABLE_40598 Int)) (+ BOUND_VARIABLE_40597 BOUND_VARIABLE_40598)) (nullable.lift (lambda ((BOUND_VARIABLE_40589 Int) (BOUND_VARIABLE_40590 Int)) (+ BOUND_VARIABLE_40589 BOUND_VARIABLE_40590)) (nullable.some (* 1 3)) (nullable.lift (lambda ((BOUND_VARIABLE_40582 Int) (BOUND_VARIABLE_40583 Int)) (+ BOUND_VARIABLE_40582 BOUND_VARIABLE_40583)) ((_ tuple.select 0) t) (nullable.some 2))) (nullable.some (* 3 4)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_40616 Int) (BOUND_VARIABLE_40617 Int)) (+ BOUND_VARIABLE_40616 BOUND_VARIABLE_40617)) ((_ tuple.select 0) t) (nullable.some 17))))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10015 ms.
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
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_84147 Int) (BOUND_VARIABLE_84148 Int)) (= BOUND_VARIABLE_84147 BOUND_VARIABLE_84148)) ((_ tuple.select 0) t) ((_ tuple.select 2) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_84147 Int) (BOUND_VARIABLE_84148 Int)) (= BOUND_VARIABLE_84147 BOUND_VARIABLE_84148)) ((_ tuple.select 0) t) ((_ tuple.select 2) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (= q1 ((_ table.project 0 1) (bag.filter p1 (table.product DEPT ((_ table.project 0) ((_ table.project 0) (bag.filter p0 DEPT))))))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p2 DEPT))))
(check-sat)
;answer: unsat
; duration: 431 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_86669 Int) (BOUND_VARIABLE_86670 Int)) (= BOUND_VARIABLE_86669 BOUND_VARIABLE_86670)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_86669 Int) (BOUND_VARIABLE_86670 Int)) (= BOUND_VARIABLE_86669 BOUND_VARIABLE_86670)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_86675 Int) (BOUND_VARIABLE_86676 Int)) (= BOUND_VARIABLE_86675 BOUND_VARIABLE_86676)) ((_ tuple.select 0) t) (nullable.some 2))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_86675 Int) (BOUND_VARIABLE_86676 Int)) (= BOUND_VARIABLE_86675 BOUND_VARIABLE_86676)) ((_ tuple.select 0) t) (nullable.some 2))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_86669 Int) (BOUND_VARIABLE_86670 Int)) (= BOUND_VARIABLE_86669 BOUND_VARIABLE_86670)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_86669 Int) (BOUND_VARIABLE_86670 Int)) (= BOUND_VARIABLE_86669 BOUND_VARIABLE_86670)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_86675 Int) (BOUND_VARIABLE_86676 Int)) (= BOUND_VARIABLE_86675 BOUND_VARIABLE_86676)) ((_ tuple.select 0) t) (nullable.some 2))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_86675 Int) (BOUND_VARIABLE_86676 Int)) (= BOUND_VARIABLE_86675 BOUND_VARIABLE_86676)) ((_ tuple.select 0) t) (nullable.some 2))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_86703 Int) (BOUND_VARIABLE_86704 Int)) (= BOUND_VARIABLE_86703 BOUND_VARIABLE_86704)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_86703 Int) (BOUND_VARIABLE_86704 Int)) (= BOUND_VARIABLE_86703 BOUND_VARIABLE_86704)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_86709 Int) (BOUND_VARIABLE_86710 Int)) (= BOUND_VARIABLE_86709 BOUND_VARIABLE_86710)) ((_ tuple.select 0) t) (nullable.some 2))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_86709 Int) (BOUND_VARIABLE_86710 Int)) (= BOUND_VARIABLE_86709 BOUND_VARIABLE_86710)) ((_ tuple.select 0) t) (nullable.some 2))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_86703 Int) (BOUND_VARIABLE_86704 Int)) (= BOUND_VARIABLE_86703 BOUND_VARIABLE_86704)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_86703 Int) (BOUND_VARIABLE_86704 Int)) (= BOUND_VARIABLE_86703 BOUND_VARIABLE_86704)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_86709 Int) (BOUND_VARIABLE_86710 Int)) (= BOUND_VARIABLE_86709 BOUND_VARIABLE_86710)) ((_ tuple.select 0) t) (nullable.some 2))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_86709 Int) (BOUND_VARIABLE_86710 Int)) (= BOUND_VARIABLE_86709 BOUND_VARIABLE_86710)) ((_ tuple.select 0) t) (nullable.some 2))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 DEPT))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 195 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_89029 Int) (BOUND_VARIABLE_89030 Int)) (= BOUND_VARIABLE_89029 BOUND_VARIABLE_89030)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_89029 Int) (BOUND_VARIABLE_89030 Int)) (= BOUND_VARIABLE_89029 BOUND_VARIABLE_89030)) ((_ tuple.select 0) t) (nullable.some 1))))) (and (nullable.is_some (nullable.some true)) (not (nullable.val (nullable.some true))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_89029 Int) (BOUND_VARIABLE_89030 Int)) (= BOUND_VARIABLE_89029 BOUND_VARIABLE_89030)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.is_null (nullable.some true))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_89029 Int) (BOUND_VARIABLE_89030 Int)) (= BOUND_VARIABLE_89029 BOUND_VARIABLE_89030)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_89029 Int) (BOUND_VARIABLE_89030 Int)) (= BOUND_VARIABLE_89029 BOUND_VARIABLE_89030)) ((_ tuple.select 0) t) (nullable.some 1))))) (and (nullable.is_some (nullable.some true)) (not (nullable.val (nullable.some true))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_89029 Int) (BOUND_VARIABLE_89030 Int)) (= BOUND_VARIABLE_89029 BOUND_VARIABLE_89030)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.is_null (nullable.some true))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_89061 Int) (BOUND_VARIABLE_89062 Int)) (= BOUND_VARIABLE_89061 BOUND_VARIABLE_89062)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_89061 Int) (BOUND_VARIABLE_89062 Int)) (= BOUND_VARIABLE_89061 BOUND_VARIABLE_89062)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 DEPT))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 135 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_90404 Int) (BOUND_VARIABLE_90405 Int)) (= BOUND_VARIABLE_90404 BOUND_VARIABLE_90405)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_90404 Int) (BOUND_VARIABLE_90405 Int)) (= BOUND_VARIABLE_90404 BOUND_VARIABLE_90405)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false)))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_90404 Int) (BOUND_VARIABLE_90405 Int)) (= BOUND_VARIABLE_90404 BOUND_VARIABLE_90405)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_90404 Int) (BOUND_VARIABLE_90405 Int)) (= BOUND_VARIABLE_90404 BOUND_VARIABLE_90405)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false)))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_90432 Int) (BOUND_VARIABLE_90433 Int)) (= BOUND_VARIABLE_90432 BOUND_VARIABLE_90433)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_90432 Int) (BOUND_VARIABLE_90433 Int)) (= BOUND_VARIABLE_90432 BOUND_VARIABLE_90433)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 DEPT))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 91 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_91647 Int) (BOUND_VARIABLE_91648 Int)) (= BOUND_VARIABLE_91647 BOUND_VARIABLE_91648)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_91647 Int) (BOUND_VARIABLE_91648 Int)) (= BOUND_VARIABLE_91647 BOUND_VARIABLE_91648)) ((_ tuple.select 0) t) (nullable.some 1))))) (and (nullable.is_some (nullable.some false)) (not (nullable.val (nullable.some false))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_91647 Int) (BOUND_VARIABLE_91648 Int)) (= BOUND_VARIABLE_91647 BOUND_VARIABLE_91648)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.is_null (nullable.some false))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_91647 Int) (BOUND_VARIABLE_91648 Int)) (= BOUND_VARIABLE_91647 BOUND_VARIABLE_91648)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_91647 Int) (BOUND_VARIABLE_91648 Int)) (= BOUND_VARIABLE_91647 BOUND_VARIABLE_91648)) ((_ tuple.select 0) t) (nullable.some 1))))) (and (nullable.is_some (nullable.some false)) (not (nullable.val (nullable.some false))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_91647 Int) (BOUND_VARIABLE_91648 Int)) (= BOUND_VARIABLE_91647 BOUND_VARIABLE_91648)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.is_null (nullable.some false))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 DEPT))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 8 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_91718 Int) (BOUND_VARIABLE_91719 Int)) (= BOUND_VARIABLE_91718 BOUND_VARIABLE_91719)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_91718 Int) (BOUND_VARIABLE_91719 Int)) (= BOUND_VARIABLE_91718 BOUND_VARIABLE_91719)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (nullable.some true)) (nullable.val (nullable.some true)))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_91718 Int) (BOUND_VARIABLE_91719 Int)) (= BOUND_VARIABLE_91718 BOUND_VARIABLE_91719)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_91718 Int) (BOUND_VARIABLE_91719 Int)) (= BOUND_VARIABLE_91718 BOUND_VARIABLE_91719)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (nullable.some true)) (nullable.val (nullable.some true)))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 DEPT))))
(assert (= q2 ((_ table.project 0 1) DEPT)))
(check-sat)
;answer: unsat
; duration: 42 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_92199 Int) (BOUND_VARIABLE_92200 Int)) (> BOUND_VARIABLE_92199 BOUND_VARIABLE_92200)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_92199 Int) (BOUND_VARIABLE_92200 Int)) (> BOUND_VARIABLE_92199 BOUND_VARIABLE_92200)) ((_ tuple.select 0) t) (nullable.some 1))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_92205 Int) (BOUND_VARIABLE_92206 Int)) (<= BOUND_VARIABLE_92205 BOUND_VARIABLE_92206)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_92205 Int) (BOUND_VARIABLE_92206 Int)) (<= BOUND_VARIABLE_92205 BOUND_VARIABLE_92206)) ((_ tuple.select 0) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_92199 Int) (BOUND_VARIABLE_92200 Int)) (> BOUND_VARIABLE_92199 BOUND_VARIABLE_92200)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_92205 Int) (BOUND_VARIABLE_92206 Int)) (<= BOUND_VARIABLE_92205 BOUND_VARIABLE_92206)) ((_ tuple.select 0) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_92199 Int) (BOUND_VARIABLE_92200 Int)) (> BOUND_VARIABLE_92199 BOUND_VARIABLE_92200)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_92199 Int) (BOUND_VARIABLE_92200 Int)) (> BOUND_VARIABLE_92199 BOUND_VARIABLE_92200)) ((_ tuple.select 0) t) (nullable.some 1))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_92205 Int) (BOUND_VARIABLE_92206 Int)) (<= BOUND_VARIABLE_92205 BOUND_VARIABLE_92206)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_92205 Int) (BOUND_VARIABLE_92206 Int)) (<= BOUND_VARIABLE_92205 BOUND_VARIABLE_92206)) ((_ tuple.select 0) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_92199 Int) (BOUND_VARIABLE_92200 Int)) (> BOUND_VARIABLE_92199 BOUND_VARIABLE_92200)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_92205 Int) (BOUND_VARIABLE_92206 Int)) (<= BOUND_VARIABLE_92205 BOUND_VARIABLE_92206)) ((_ tuple.select 0) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (ite (nullable.is_null ((_ tuple.select 0) t)) (as nullable.null (Nullable Bool)) (nullable.some false))) (nullable.val (ite (nullable.is_null ((_ tuple.select 0) t)) (as nullable.null (Nullable Bool)) (nullable.some false)))))))
(assert (= q1 ((_ table.project 0) (bag.filter p0 ANON))))
(assert (= q2 ((_ table.project 0) (bag.filter p1 ANON))))
(check-sat)
;answer: unsat
; duration: 88 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_93550 Int) (BOUND_VARIABLE_93551 Int)) (> BOUND_VARIABLE_93550 BOUND_VARIABLE_93551)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_93550 Int) (BOUND_VARIABLE_93551 Int)) (> BOUND_VARIABLE_93550 BOUND_VARIABLE_93551)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_93556 Int) (BOUND_VARIABLE_93557 Int)) (<= BOUND_VARIABLE_93556 BOUND_VARIABLE_93557)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_93556 Int) (BOUND_VARIABLE_93557 Int)) (<= BOUND_VARIABLE_93556 BOUND_VARIABLE_93557)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_93563 Int) (BOUND_VARIABLE_93564 Int)) (> BOUND_VARIABLE_93563 BOUND_VARIABLE_93564)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_93563 Int) (BOUND_VARIABLE_93564 Int)) (> BOUND_VARIABLE_93563 BOUND_VARIABLE_93564)) ((_ tuple.select 0) t) (nullable.some 5))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (not (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_93556 Int) (BOUND_VARIABLE_93557 Int)) (<= BOUND_VARIABLE_93556 BOUND_VARIABLE_93557)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_93556 Int) (BOUND_VARIABLE_93557 Int)) (<= BOUND_VARIABLE_93556 BOUND_VARIABLE_93557)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_93563 Int) (BOUND_VARIABLE_93564 Int)) (> BOUND_VARIABLE_93563 BOUND_VARIABLE_93564)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_93563 Int) (BOUND_VARIABLE_93564 Int)) (> BOUND_VARIABLE_93563 BOUND_VARIABLE_93564)) ((_ tuple.select 0) t) (nullable.some 5))))) (nullable.some true) (as nullable.null (Nullable Bool))))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_93550 Int) (BOUND_VARIABLE_93551 Int)) (> BOUND_VARIABLE_93550 BOUND_VARIABLE_93551)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_93556 Int) (BOUND_VARIABLE_93557 Int)) (<= BOUND_VARIABLE_93556 BOUND_VARIABLE_93557)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_93556 Int) (BOUND_VARIABLE_93557 Int)) (<= BOUND_VARIABLE_93556 BOUND_VARIABLE_93557)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_93563 Int) (BOUND_VARIABLE_93564 Int)) (> BOUND_VARIABLE_93563 BOUND_VARIABLE_93564)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_93563 Int) (BOUND_VARIABLE_93564 Int)) (> BOUND_VARIABLE_93563 BOUND_VARIABLE_93564)) ((_ tuple.select 0) t) (nullable.some 5))))) (nullable.some true) (as nullable.null (Nullable Bool))))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_93550 Int) (BOUND_VARIABLE_93551 Int)) (> BOUND_VARIABLE_93550 BOUND_VARIABLE_93551)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_93550 Int) (BOUND_VARIABLE_93551 Int)) (> BOUND_VARIABLE_93550 BOUND_VARIABLE_93551)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_93556 Int) (BOUND_VARIABLE_93557 Int)) (<= BOUND_VARIABLE_93556 BOUND_VARIABLE_93557)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_93556 Int) (BOUND_VARIABLE_93557 Int)) (<= BOUND_VARIABLE_93556 BOUND_VARIABLE_93557)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_93563 Int) (BOUND_VARIABLE_93564 Int)) (> BOUND_VARIABLE_93563 BOUND_VARIABLE_93564)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_93563 Int) (BOUND_VARIABLE_93564 Int)) (> BOUND_VARIABLE_93563 BOUND_VARIABLE_93564)) ((_ tuple.select 0) t) (nullable.some 5))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (not (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_93556 Int) (BOUND_VARIABLE_93557 Int)) (<= BOUND_VARIABLE_93556 BOUND_VARIABLE_93557)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_93556 Int) (BOUND_VARIABLE_93557 Int)) (<= BOUND_VARIABLE_93556 BOUND_VARIABLE_93557)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_93563 Int) (BOUND_VARIABLE_93564 Int)) (> BOUND_VARIABLE_93563 BOUND_VARIABLE_93564)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_93563 Int) (BOUND_VARIABLE_93564 Int)) (> BOUND_VARIABLE_93563 BOUND_VARIABLE_93564)) ((_ tuple.select 0) t) (nullable.some 5))))) (nullable.some true) (as nullable.null (Nullable Bool))))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_93550 Int) (BOUND_VARIABLE_93551 Int)) (> BOUND_VARIABLE_93550 BOUND_VARIABLE_93551)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_93556 Int) (BOUND_VARIABLE_93557 Int)) (<= BOUND_VARIABLE_93556 BOUND_VARIABLE_93557)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_93556 Int) (BOUND_VARIABLE_93557 Int)) (<= BOUND_VARIABLE_93556 BOUND_VARIABLE_93557)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_93563 Int) (BOUND_VARIABLE_93564 Int)) (> BOUND_VARIABLE_93563 BOUND_VARIABLE_93564)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_93563 Int) (BOUND_VARIABLE_93564 Int)) (> BOUND_VARIABLE_93563 BOUND_VARIABLE_93564)) ((_ tuple.select 0) t) (nullable.some 5))))) (nullable.some true) (as nullable.null (Nullable Bool))))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_93604 Int) (BOUND_VARIABLE_93605 Int)) (> BOUND_VARIABLE_93604 BOUND_VARIABLE_93605)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_93604 Int) (BOUND_VARIABLE_93605 Int)) (> BOUND_VARIABLE_93604 BOUND_VARIABLE_93605)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_93611 Int) (BOUND_VARIABLE_93612 Int)) (> BOUND_VARIABLE_93611 BOUND_VARIABLE_93612)) ((_ tuple.select 0) t) (nullable.some 5))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_93611 Int) (BOUND_VARIABLE_93612 Int)) (> BOUND_VARIABLE_93611 BOUND_VARIABLE_93612)) ((_ tuple.select 0) t) (nullable.some 5)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_93604 Int) (BOUND_VARIABLE_93605 Int)) (> BOUND_VARIABLE_93604 BOUND_VARIABLE_93605)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_93611 Int) (BOUND_VARIABLE_93612 Int)) (> BOUND_VARIABLE_93611 BOUND_VARIABLE_93612)) ((_ tuple.select 0) t) (nullable.some 5)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_93604 Int) (BOUND_VARIABLE_93605 Int)) (> BOUND_VARIABLE_93604 BOUND_VARIABLE_93605)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_93604 Int) (BOUND_VARIABLE_93605 Int)) (> BOUND_VARIABLE_93604 BOUND_VARIABLE_93605)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_93611 Int) (BOUND_VARIABLE_93612 Int)) (> BOUND_VARIABLE_93611 BOUND_VARIABLE_93612)) ((_ tuple.select 0) t) (nullable.some 5))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_93611 Int) (BOUND_VARIABLE_93612 Int)) (> BOUND_VARIABLE_93611 BOUND_VARIABLE_93612)) ((_ tuple.select 0) t) (nullable.some 5)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_93604 Int) (BOUND_VARIABLE_93605 Int)) (> BOUND_VARIABLE_93604 BOUND_VARIABLE_93605)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_93611 Int) (BOUND_VARIABLE_93612 Int)) (> BOUND_VARIABLE_93611 BOUND_VARIABLE_93612)) ((_ tuple.select 0) t) (nullable.some 5)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 163 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_96313 Int) (BOUND_VARIABLE_96314 Int)) (> BOUND_VARIABLE_96313 BOUND_VARIABLE_96314)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_96313 Int) (BOUND_VARIABLE_96314 Int)) (> BOUND_VARIABLE_96313 BOUND_VARIABLE_96314)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_96319 Int) (BOUND_VARIABLE_96320 Int)) (<= BOUND_VARIABLE_96319 BOUND_VARIABLE_96320)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_96319 Int) (BOUND_VARIABLE_96320 Int)) (<= BOUND_VARIABLE_96319 BOUND_VARIABLE_96320)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_96326 Int) (BOUND_VARIABLE_96327 Int)) (> BOUND_VARIABLE_96326 BOUND_VARIABLE_96327)) ((_ tuple.select 0) t) (nullable.some 5))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_96326 Int) (BOUND_VARIABLE_96327 Int)) (> BOUND_VARIABLE_96326 BOUND_VARIABLE_96327)) ((_ tuple.select 0) t) (nullable.some 5)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_96319 Int) (BOUND_VARIABLE_96320 Int)) (<= BOUND_VARIABLE_96319 BOUND_VARIABLE_96320)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_96326 Int) (BOUND_VARIABLE_96327 Int)) (> BOUND_VARIABLE_96326 BOUND_VARIABLE_96327)) ((_ tuple.select 0) t) (nullable.some 5)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_96319 Int) (BOUND_VARIABLE_96320 Int)) (<= BOUND_VARIABLE_96319 BOUND_VARIABLE_96320)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_96319 Int) (BOUND_VARIABLE_96320 Int)) (<= BOUND_VARIABLE_96319 BOUND_VARIABLE_96320)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_96326 Int) (BOUND_VARIABLE_96327 Int)) (> BOUND_VARIABLE_96326 BOUND_VARIABLE_96327)) ((_ tuple.select 0) t) (nullable.some 5))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_96326 Int) (BOUND_VARIABLE_96327 Int)) (> BOUND_VARIABLE_96326 BOUND_VARIABLE_96327)) ((_ tuple.select 0) t) (nullable.some 5)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_96319 Int) (BOUND_VARIABLE_96320 Int)) (<= BOUND_VARIABLE_96319 BOUND_VARIABLE_96320)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_96326 Int) (BOUND_VARIABLE_96327 Int)) (> BOUND_VARIABLE_96326 BOUND_VARIABLE_96327)) ((_ tuple.select 0) t) (nullable.some 5)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_96313 Int) (BOUND_VARIABLE_96314 Int)) (> BOUND_VARIABLE_96313 BOUND_VARIABLE_96314)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_96313 Int) (BOUND_VARIABLE_96314 Int)) (> BOUND_VARIABLE_96313 BOUND_VARIABLE_96314)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_96319 Int) (BOUND_VARIABLE_96320 Int)) (<= BOUND_VARIABLE_96319 BOUND_VARIABLE_96320)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_96319 Int) (BOUND_VARIABLE_96320 Int)) (<= BOUND_VARIABLE_96319 BOUND_VARIABLE_96320)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_96326 Int) (BOUND_VARIABLE_96327 Int)) (> BOUND_VARIABLE_96326 BOUND_VARIABLE_96327)) ((_ tuple.select 0) t) (nullable.some 5))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_96326 Int) (BOUND_VARIABLE_96327 Int)) (> BOUND_VARIABLE_96326 BOUND_VARIABLE_96327)) ((_ tuple.select 0) t) (nullable.some 5)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_96319 Int) (BOUND_VARIABLE_96320 Int)) (<= BOUND_VARIABLE_96319 BOUND_VARIABLE_96320)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_96326 Int) (BOUND_VARIABLE_96327 Int)) (> BOUND_VARIABLE_96326 BOUND_VARIABLE_96327)) ((_ tuple.select 0) t) (nullable.some 5)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_96319 Int) (BOUND_VARIABLE_96320 Int)) (<= BOUND_VARIABLE_96319 BOUND_VARIABLE_96320)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_96319 Int) (BOUND_VARIABLE_96320 Int)) (<= BOUND_VARIABLE_96319 BOUND_VARIABLE_96320)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_96326 Int) (BOUND_VARIABLE_96327 Int)) (> BOUND_VARIABLE_96326 BOUND_VARIABLE_96327)) ((_ tuple.select 0) t) (nullable.some 5))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_96326 Int) (BOUND_VARIABLE_96327 Int)) (> BOUND_VARIABLE_96326 BOUND_VARIABLE_96327)) ((_ tuple.select 0) t) (nullable.some 5)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_96319 Int) (BOUND_VARIABLE_96320 Int)) (<= BOUND_VARIABLE_96319 BOUND_VARIABLE_96320)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_96326 Int) (BOUND_VARIABLE_96327 Int)) (> BOUND_VARIABLE_96326 BOUND_VARIABLE_96327)) ((_ tuple.select 0) t) (nullable.some 5)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_96367 Int) (BOUND_VARIABLE_96368 Int)) (> BOUND_VARIABLE_96367 BOUND_VARIABLE_96368)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_96367 Int) (BOUND_VARIABLE_96368 Int)) (> BOUND_VARIABLE_96367 BOUND_VARIABLE_96368)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_96374 Int) (BOUND_VARIABLE_96375 Int)) (> BOUND_VARIABLE_96374 BOUND_VARIABLE_96375)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_96374 Int) (BOUND_VARIABLE_96375 Int)) (> BOUND_VARIABLE_96374 BOUND_VARIABLE_96375)) ((_ tuple.select 0) t) (nullable.some 5))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_96367 Int) (BOUND_VARIABLE_96368 Int)) (> BOUND_VARIABLE_96367 BOUND_VARIABLE_96368)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_96367 Int) (BOUND_VARIABLE_96368 Int)) (> BOUND_VARIABLE_96367 BOUND_VARIABLE_96368)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_96374 Int) (BOUND_VARIABLE_96375 Int)) (> BOUND_VARIABLE_96374 BOUND_VARIABLE_96375)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_96374 Int) (BOUND_VARIABLE_96375 Int)) (> BOUND_VARIABLE_96374 BOUND_VARIABLE_96375)) ((_ tuple.select 0) t) (nullable.some 5))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 531 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 6) (nullable.some "A") (nullable.some "B") (nullable.some 3) (nullable.some (- 3)) (nullable.some 4) (as nullable.null (Nullable Int)) (nullable.some (- 4)) (nullable.some 5)) 1))
; )
; q1
(get-value (q1))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (bag (tuple (nullable.some 6) (nullable.some "A") (nullable.some "B") (nullable.some 3) (nullable.some (- 3)) (nullable.some 4) (as nullable.null (Nullable Int)) (nullable.some (- 4)) (nullable.some 5)) 1)
; insert into EMP values(6,'A','B',3,-3,4,NULL,-4,5)
; SELECT * FROM (SELECT * FROM emp WHERE emp.sal > 50 OR (emp.sal <= 50 AND emp.empno > 5)) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM emp WHERE emp.sal > 50 OR emp.empno> 5) AS q2;

; SELECT * FROM (SELECT * FROM emp WHERE emp.sal > 50 OR emp.empno> 5) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM emp WHERE emp.sal > 50 OR (emp.sal <= 50 AND emp.empno > 5)) AS q1;
;(6,A,B,3,-3,4,NULL,-4,5)

;Model soundness: true
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102079 Int) (BOUND_VARIABLE_102080 Int)) (= BOUND_VARIABLE_102079 BOUND_VARIABLE_102080)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102079 Int) (BOUND_VARIABLE_102080 Int)) (= BOUND_VARIABLE_102079 BOUND_VARIABLE_102080)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102087 Int) (BOUND_VARIABLE_102088 Int)) (= BOUND_VARIABLE_102087 BOUND_VARIABLE_102088)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102087 Int) (BOUND_VARIABLE_102088 Int)) (= BOUND_VARIABLE_102087 BOUND_VARIABLE_102088)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (not (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102079 Int) (BOUND_VARIABLE_102080 Int)) (= BOUND_VARIABLE_102079 BOUND_VARIABLE_102080)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102079 Int) (BOUND_VARIABLE_102080 Int)) (= BOUND_VARIABLE_102079 BOUND_VARIABLE_102080)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102087 Int) (BOUND_VARIABLE_102088 Int)) (= BOUND_VARIABLE_102087 BOUND_VARIABLE_102088)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102087 Int) (BOUND_VARIABLE_102088 Int)) (= BOUND_VARIABLE_102087 BOUND_VARIABLE_102088)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool)))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102108 Int) (BOUND_VARIABLE_102109 Int)) (= BOUND_VARIABLE_102108 BOUND_VARIABLE_102109)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102108 Int) (BOUND_VARIABLE_102109 Int)) (= BOUND_VARIABLE_102108 BOUND_VARIABLE_102109)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102114 Int) (BOUND_VARIABLE_102115 Int)) (= BOUND_VARIABLE_102114 BOUND_VARIABLE_102115)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102114 Int) (BOUND_VARIABLE_102115 Int)) (= BOUND_VARIABLE_102114 BOUND_VARIABLE_102115)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (not (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102108 Int) (BOUND_VARIABLE_102109 Int)) (= BOUND_VARIABLE_102108 BOUND_VARIABLE_102109)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102108 Int) (BOUND_VARIABLE_102109 Int)) (= BOUND_VARIABLE_102108 BOUND_VARIABLE_102109)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102114 Int) (BOUND_VARIABLE_102115 Int)) (= BOUND_VARIABLE_102114 BOUND_VARIABLE_102115)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102114 Int) (BOUND_VARIABLE_102115 Int)) (= BOUND_VARIABLE_102114 BOUND_VARIABLE_102115)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool))))))) (nullable.some false) (ite (or (nullable.is_null (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102079 Int) (BOUND_VARIABLE_102080 Int)) (= BOUND_VARIABLE_102079 BOUND_VARIABLE_102080)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102079 Int) (BOUND_VARIABLE_102080 Int)) (= BOUND_VARIABLE_102079 BOUND_VARIABLE_102080)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102087 Int) (BOUND_VARIABLE_102088 Int)) (= BOUND_VARIABLE_102087 BOUND_VARIABLE_102088)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102087 Int) (BOUND_VARIABLE_102088 Int)) (= BOUND_VARIABLE_102087 BOUND_VARIABLE_102088)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.is_null (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102108 Int) (BOUND_VARIABLE_102109 Int)) (= BOUND_VARIABLE_102108 BOUND_VARIABLE_102109)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102108 Int) (BOUND_VARIABLE_102109 Int)) (= BOUND_VARIABLE_102108 BOUND_VARIABLE_102109)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102114 Int) (BOUND_VARIABLE_102115 Int)) (= BOUND_VARIABLE_102114 BOUND_VARIABLE_102115)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102114 Int) (BOUND_VARIABLE_102115 Int)) (= BOUND_VARIABLE_102114 BOUND_VARIABLE_102115)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool))))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102079 Int) (BOUND_VARIABLE_102080 Int)) (= BOUND_VARIABLE_102079 BOUND_VARIABLE_102080)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102079 Int) (BOUND_VARIABLE_102080 Int)) (= BOUND_VARIABLE_102079 BOUND_VARIABLE_102080)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102087 Int) (BOUND_VARIABLE_102088 Int)) (= BOUND_VARIABLE_102087 BOUND_VARIABLE_102088)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102087 Int) (BOUND_VARIABLE_102088 Int)) (= BOUND_VARIABLE_102087 BOUND_VARIABLE_102088)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (not (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102079 Int) (BOUND_VARIABLE_102080 Int)) (= BOUND_VARIABLE_102079 BOUND_VARIABLE_102080)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102079 Int) (BOUND_VARIABLE_102080 Int)) (= BOUND_VARIABLE_102079 BOUND_VARIABLE_102080)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102087 Int) (BOUND_VARIABLE_102088 Int)) (= BOUND_VARIABLE_102087 BOUND_VARIABLE_102088)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102087 Int) (BOUND_VARIABLE_102088 Int)) (= BOUND_VARIABLE_102087 BOUND_VARIABLE_102088)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool)))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102108 Int) (BOUND_VARIABLE_102109 Int)) (= BOUND_VARIABLE_102108 BOUND_VARIABLE_102109)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102108 Int) (BOUND_VARIABLE_102109 Int)) (= BOUND_VARIABLE_102108 BOUND_VARIABLE_102109)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102114 Int) (BOUND_VARIABLE_102115 Int)) (= BOUND_VARIABLE_102114 BOUND_VARIABLE_102115)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102114 Int) (BOUND_VARIABLE_102115 Int)) (= BOUND_VARIABLE_102114 BOUND_VARIABLE_102115)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (not (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102108 Int) (BOUND_VARIABLE_102109 Int)) (= BOUND_VARIABLE_102108 BOUND_VARIABLE_102109)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102108 Int) (BOUND_VARIABLE_102109 Int)) (= BOUND_VARIABLE_102108 BOUND_VARIABLE_102109)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102114 Int) (BOUND_VARIABLE_102115 Int)) (= BOUND_VARIABLE_102114 BOUND_VARIABLE_102115)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102114 Int) (BOUND_VARIABLE_102115 Int)) (= BOUND_VARIABLE_102114 BOUND_VARIABLE_102115)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool))))))) (nullable.some false) (ite (or (nullable.is_null (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102079 Int) (BOUND_VARIABLE_102080 Int)) (= BOUND_VARIABLE_102079 BOUND_VARIABLE_102080)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102079 Int) (BOUND_VARIABLE_102080 Int)) (= BOUND_VARIABLE_102079 BOUND_VARIABLE_102080)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102087 Int) (BOUND_VARIABLE_102088 Int)) (= BOUND_VARIABLE_102087 BOUND_VARIABLE_102088)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102087 Int) (BOUND_VARIABLE_102088 Int)) (= BOUND_VARIABLE_102087 BOUND_VARIABLE_102088)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.is_null (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102108 Int) (BOUND_VARIABLE_102109 Int)) (= BOUND_VARIABLE_102108 BOUND_VARIABLE_102109)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102108 Int) (BOUND_VARIABLE_102109 Int)) (= BOUND_VARIABLE_102108 BOUND_VARIABLE_102109)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102114 Int) (BOUND_VARIABLE_102115 Int)) (= BOUND_VARIABLE_102114 BOUND_VARIABLE_102115)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102114 Int) (BOUND_VARIABLE_102115 Int)) (= BOUND_VARIABLE_102114 BOUND_VARIABLE_102115)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool))))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102156 Int) (BOUND_VARIABLE_102157 Int)) (= BOUND_VARIABLE_102156 BOUND_VARIABLE_102157)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102156 Int) (BOUND_VARIABLE_102157 Int)) (= BOUND_VARIABLE_102156 BOUND_VARIABLE_102157)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102162 Int) (BOUND_VARIABLE_102163 Int)) (= BOUND_VARIABLE_102162 BOUND_VARIABLE_102163)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102162 Int) (BOUND_VARIABLE_102163 Int)) (= BOUND_VARIABLE_102162 BOUND_VARIABLE_102163)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102156 Int) (BOUND_VARIABLE_102157 Int)) (= BOUND_VARIABLE_102156 BOUND_VARIABLE_102157)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102156 Int) (BOUND_VARIABLE_102157 Int)) (= BOUND_VARIABLE_102156 BOUND_VARIABLE_102157)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_102162 Int) (BOUND_VARIABLE_102163 Int)) (= BOUND_VARIABLE_102162 BOUND_VARIABLE_102163)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_102162 Int) (BOUND_VARIABLE_102163 Int)) (= BOUND_VARIABLE_102162 BOUND_VARIABLE_102163)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 252 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105496 Int) (BOUND_VARIABLE_105497 Int)) (= BOUND_VARIABLE_105496 BOUND_VARIABLE_105497)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105496 Int) (BOUND_VARIABLE_105497 Int)) (= BOUND_VARIABLE_105496 BOUND_VARIABLE_105497)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105502 Int) (BOUND_VARIABLE_105503 Int)) (= BOUND_VARIABLE_105502 BOUND_VARIABLE_105503)) ((_ tuple.select 6) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105502 Int) (BOUND_VARIABLE_105503 Int)) (= BOUND_VARIABLE_105502 BOUND_VARIABLE_105503)) ((_ tuple.select 6) t) (nullable.some 100)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_105496 Int) (BOUND_VARIABLE_105497 Int)) (= BOUND_VARIABLE_105496 BOUND_VARIABLE_105497)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_105502 Int) (BOUND_VARIABLE_105503 Int)) (= BOUND_VARIABLE_105502 BOUND_VARIABLE_105503)) ((_ tuple.select 6) t) (nullable.some 100)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105496 Int) (BOUND_VARIABLE_105497 Int)) (= BOUND_VARIABLE_105496 BOUND_VARIABLE_105497)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105496 Int) (BOUND_VARIABLE_105497 Int)) (= BOUND_VARIABLE_105496 BOUND_VARIABLE_105497)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105502 Int) (BOUND_VARIABLE_105503 Int)) (= BOUND_VARIABLE_105502 BOUND_VARIABLE_105503)) ((_ tuple.select 6) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105502 Int) (BOUND_VARIABLE_105503 Int)) (= BOUND_VARIABLE_105502 BOUND_VARIABLE_105503)) ((_ tuple.select 6) t) (nullable.some 100)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_105496 Int) (BOUND_VARIABLE_105497 Int)) (= BOUND_VARIABLE_105496 BOUND_VARIABLE_105497)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_105502 Int) (BOUND_VARIABLE_105503 Int)) (= BOUND_VARIABLE_105502 BOUND_VARIABLE_105503)) ((_ tuple.select 6) t) (nullable.some 100)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105529 Int) (BOUND_VARIABLE_105530 Int)) (= BOUND_VARIABLE_105529 BOUND_VARIABLE_105530)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105529 Int) (BOUND_VARIABLE_105530 Int)) (= BOUND_VARIABLE_105529 BOUND_VARIABLE_105530)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105535 Int) (BOUND_VARIABLE_105536 Int)) (= BOUND_VARIABLE_105535 BOUND_VARIABLE_105536)) ((_ tuple.select 6) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105535 Int) (BOUND_VARIABLE_105536 Int)) (= BOUND_VARIABLE_105535 BOUND_VARIABLE_105536)) ((_ tuple.select 6) t) (nullable.some 100)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_105529 Int) (BOUND_VARIABLE_105530 Int)) (= BOUND_VARIABLE_105529 BOUND_VARIABLE_105530)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_105535 Int) (BOUND_VARIABLE_105536 Int)) (= BOUND_VARIABLE_105535 BOUND_VARIABLE_105536)) ((_ tuple.select 6) t) (nullable.some 100)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105529 Int) (BOUND_VARIABLE_105530 Int)) (= BOUND_VARIABLE_105529 BOUND_VARIABLE_105530)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105529 Int) (BOUND_VARIABLE_105530 Int)) (= BOUND_VARIABLE_105529 BOUND_VARIABLE_105530)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105535 Int) (BOUND_VARIABLE_105536 Int)) (= BOUND_VARIABLE_105535 BOUND_VARIABLE_105536)) ((_ tuple.select 6) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105535 Int) (BOUND_VARIABLE_105536 Int)) (= BOUND_VARIABLE_105535 BOUND_VARIABLE_105536)) ((_ tuple.select 6) t) (nullable.some 100)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_105529 Int) (BOUND_VARIABLE_105530 Int)) (= BOUND_VARIABLE_105529 BOUND_VARIABLE_105530)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_105535 Int) (BOUND_VARIABLE_105536 Int)) (= BOUND_VARIABLE_105535 BOUND_VARIABLE_105536)) ((_ tuple.select 6) t) (nullable.some 100)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105496 Int) (BOUND_VARIABLE_105497 Int)) (= BOUND_VARIABLE_105496 BOUND_VARIABLE_105497)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105496 Int) (BOUND_VARIABLE_105497 Int)) (= BOUND_VARIABLE_105496 BOUND_VARIABLE_105497)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105502 Int) (BOUND_VARIABLE_105503 Int)) (= BOUND_VARIABLE_105502 BOUND_VARIABLE_105503)) ((_ tuple.select 6) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105502 Int) (BOUND_VARIABLE_105503 Int)) (= BOUND_VARIABLE_105502 BOUND_VARIABLE_105503)) ((_ tuple.select 6) t) (nullable.some 100)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_105496 Int) (BOUND_VARIABLE_105497 Int)) (= BOUND_VARIABLE_105496 BOUND_VARIABLE_105497)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_105502 Int) (BOUND_VARIABLE_105503 Int)) (= BOUND_VARIABLE_105502 BOUND_VARIABLE_105503)) ((_ tuple.select 6) t) (nullable.some 100)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105496 Int) (BOUND_VARIABLE_105497 Int)) (= BOUND_VARIABLE_105496 BOUND_VARIABLE_105497)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105496 Int) (BOUND_VARIABLE_105497 Int)) (= BOUND_VARIABLE_105496 BOUND_VARIABLE_105497)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105502 Int) (BOUND_VARIABLE_105503 Int)) (= BOUND_VARIABLE_105502 BOUND_VARIABLE_105503)) ((_ tuple.select 6) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105502 Int) (BOUND_VARIABLE_105503 Int)) (= BOUND_VARIABLE_105502 BOUND_VARIABLE_105503)) ((_ tuple.select 6) t) (nullable.some 100)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_105496 Int) (BOUND_VARIABLE_105497 Int)) (= BOUND_VARIABLE_105496 BOUND_VARIABLE_105497)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_105502 Int) (BOUND_VARIABLE_105503 Int)) (= BOUND_VARIABLE_105502 BOUND_VARIABLE_105503)) ((_ tuple.select 6) t) (nullable.some 100)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105529 Int) (BOUND_VARIABLE_105530 Int)) (= BOUND_VARIABLE_105529 BOUND_VARIABLE_105530)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105529 Int) (BOUND_VARIABLE_105530 Int)) (= BOUND_VARIABLE_105529 BOUND_VARIABLE_105530)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105535 Int) (BOUND_VARIABLE_105536 Int)) (= BOUND_VARIABLE_105535 BOUND_VARIABLE_105536)) ((_ tuple.select 6) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105535 Int) (BOUND_VARIABLE_105536 Int)) (= BOUND_VARIABLE_105535 BOUND_VARIABLE_105536)) ((_ tuple.select 6) t) (nullable.some 100)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_105529 Int) (BOUND_VARIABLE_105530 Int)) (= BOUND_VARIABLE_105529 BOUND_VARIABLE_105530)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_105535 Int) (BOUND_VARIABLE_105536 Int)) (= BOUND_VARIABLE_105535 BOUND_VARIABLE_105536)) ((_ tuple.select 6) t) (nullable.some 100)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105529 Int) (BOUND_VARIABLE_105530 Int)) (= BOUND_VARIABLE_105529 BOUND_VARIABLE_105530)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105529 Int) (BOUND_VARIABLE_105530 Int)) (= BOUND_VARIABLE_105529 BOUND_VARIABLE_105530)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105535 Int) (BOUND_VARIABLE_105536 Int)) (= BOUND_VARIABLE_105535 BOUND_VARIABLE_105536)) ((_ tuple.select 6) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105535 Int) (BOUND_VARIABLE_105536 Int)) (= BOUND_VARIABLE_105535 BOUND_VARIABLE_105536)) ((_ tuple.select 6) t) (nullable.some 100)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_105529 Int) (BOUND_VARIABLE_105530 Int)) (= BOUND_VARIABLE_105529 BOUND_VARIABLE_105530)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_105535 Int) (BOUND_VARIABLE_105536 Int)) (= BOUND_VARIABLE_105535 BOUND_VARIABLE_105536)) ((_ tuple.select 6) t) (nullable.some 100)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105577 Int) (BOUND_VARIABLE_105578 Int)) (= BOUND_VARIABLE_105577 BOUND_VARIABLE_105578)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105577 Int) (BOUND_VARIABLE_105578 Int)) (= BOUND_VARIABLE_105577 BOUND_VARIABLE_105578)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105583 Int) (BOUND_VARIABLE_105584 Int)) (= BOUND_VARIABLE_105583 BOUND_VARIABLE_105584)) ((_ tuple.select 6) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105583 Int) (BOUND_VARIABLE_105584 Int)) (= BOUND_VARIABLE_105583 BOUND_VARIABLE_105584)) ((_ tuple.select 6) t) (nullable.some 100)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_105577 Int) (BOUND_VARIABLE_105578 Int)) (= BOUND_VARIABLE_105577 BOUND_VARIABLE_105578)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_105583 Int) (BOUND_VARIABLE_105584 Int)) (= BOUND_VARIABLE_105583 BOUND_VARIABLE_105584)) ((_ tuple.select 6) t) (nullable.some 100)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105577 Int) (BOUND_VARIABLE_105578 Int)) (= BOUND_VARIABLE_105577 BOUND_VARIABLE_105578)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105577 Int) (BOUND_VARIABLE_105578 Int)) (= BOUND_VARIABLE_105577 BOUND_VARIABLE_105578)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_105583 Int) (BOUND_VARIABLE_105584 Int)) (= BOUND_VARIABLE_105583 BOUND_VARIABLE_105584)) ((_ tuple.select 6) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_105583 Int) (BOUND_VARIABLE_105584 Int)) (= BOUND_VARIABLE_105583 BOUND_VARIABLE_105584)) ((_ tuple.select 6) t) (nullable.some 100)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_105577 Int) (BOUND_VARIABLE_105578 Int)) (= BOUND_VARIABLE_105577 BOUND_VARIABLE_105578)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_105583 Int) (BOUND_VARIABLE_105584 Int)) (= BOUND_VARIABLE_105583 BOUND_VARIABLE_105584)) ((_ tuple.select 6) t) (nullable.some 100)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 183 ms.
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
; duration: 4 ms.
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
; duration: 10199 ms.
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
; duration: 10293 ms.
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
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Bool))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_175944 Int) (BOUND_VARIABLE_175945 Int)) (= BOUND_VARIABLE_175944 BOUND_VARIABLE_175945)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_175974 Int) (BOUND_VARIABLE_175975 Int)) (= BOUND_VARIABLE_175974 BOUND_VARIABLE_175975)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10094 ms.
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
; duration: 55 ms.
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
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Bool))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Bool))))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unsat
; duration: 5 ms.
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
; duration: 10233 ms.
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
; duration: 10329 ms.
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
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Bool))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_273687 Int) (BOUND_VARIABLE_273688 Int)) (= BOUND_VARIABLE_273687 BOUND_VARIABLE_273688)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_273704 Int) (BOUND_VARIABLE_273705 Int)) (= BOUND_VARIABLE_273704 BOUND_VARIABLE_273705)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10107 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_305342 Int) (BOUND_VARIABLE_305343 Int)) (= BOUND_VARIABLE_305342 BOUND_VARIABLE_305343)) ((_ tuple.select 0) t) (nullable.some 1))) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_305348 Int) (BOUND_VARIABLE_305349 Int)) (+ BOUND_VARIABLE_305348 BOUND_VARIABLE_305349)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_305367 Int) (BOUND_VARIABLE_305368 Int)) (= BOUND_VARIABLE_305367 BOUND_VARIABLE_305368)) ((_ tuple.select 0) t) (nullable.some 1))) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_305373 Int) (BOUND_VARIABLE_305374 Int)) (+ BOUND_VARIABLE_305373 BOUND_VARIABLE_305374)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10059 ms.
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
; duration: 10073 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_363187 Int) (BOUND_VARIABLE_363188 Int)) (= BOUND_VARIABLE_363187 BOUND_VARIABLE_363188)) ((_ tuple.select 0) t) (nullable.some 1))) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_363193 Int) (BOUND_VARIABLE_363194 Int)) (+ BOUND_VARIABLE_363193 BOUND_VARIABLE_363194)) ((_ tuple.select 0) t) (nullable.some 100)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_363212 Int) (BOUND_VARIABLE_363213 Int)) (= BOUND_VARIABLE_363212 BOUND_VARIABLE_363213)) ((_ tuple.select 0) t) (nullable.some 1))) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_363218 Int) (BOUND_VARIABLE_363219 Int)) (+ BOUND_VARIABLE_363218 BOUND_VARIABLE_363219)) ((_ tuple.select 0) t) (nullable.some 100)))))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10064 ms.
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
; duration: 62 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_392506 Int) (BOUND_VARIABLE_392507 Int)) (= BOUND_VARIABLE_392506 BOUND_VARIABLE_392507)) (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_392497 Int) (BOUND_VARIABLE_392498 Int)) (= BOUND_VARIABLE_392497 BOUND_VARIABLE_392498)) ((_ tuple.select 6) t) (nullable.some 100))) ((_ tuple.select 7) t) (nullable.some 2)) (nullable.some 2))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_392524 Int) (BOUND_VARIABLE_392525 Int)) (= BOUND_VARIABLE_392524 BOUND_VARIABLE_392525)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.lift (lambda ((BOUND_VARIABLE_392531 Int) (BOUND_VARIABLE_392532 Int)) (= BOUND_VARIABLE_392531 BOUND_VARIABLE_392532)) ((_ tuple.select 7) t) (nullable.some 2)) (nullable.some true))))))
(assert (= q1 (bag.map f0 T)))
(assert (= q2 (bag.map f1 T)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10008 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_417831 Int) (BOUND_VARIABLE_417832 Int)) (= BOUND_VARIABLE_417831 BOUND_VARIABLE_417832)) (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_417822 Int) (BOUND_VARIABLE_417823 Int)) (= BOUND_VARIABLE_417822 BOUND_VARIABLE_417823)) ((_ tuple.select 6) t) (nullable.some 100))) ((_ tuple.select 7) t) (nullable.some 2)) (nullable.some 2))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_417848 Int) (BOUND_VARIABLE_417849 Int)) (= BOUND_VARIABLE_417848 BOUND_VARIABLE_417849)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.lift (lambda ((BOUND_VARIABLE_417855 Int) (BOUND_VARIABLE_417856 Int)) (= BOUND_VARIABLE_417855 BOUND_VARIABLE_417856)) ((_ tuple.select 7) t) (nullable.some 2)) (nullable.some true))))))
(assert (= q1 (bag.map f0 T)))
(assert (= q2 (bag.map f1 T)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10093 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.is_null (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_442349 Int) (BOUND_VARIABLE_442350 Int)) (= BOUND_VARIABLE_442349 BOUND_VARIABLE_442350)) ((_ tuple.select 6) t) (nullable.some 100))) ((_ tuple.select 7) t) (nullable.some 2)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple false))))
(assert (= q1 (bag.map f0 T)))
(assert (= q2 (bag.map f1 T)))
(check-sat)
;answer: sat
; duration: 199 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.is_null (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_444504 Int) (BOUND_VARIABLE_444505 Int)) (= BOUND_VARIABLE_444504 BOUND_VARIABLE_444505)) ((_ tuple.select 6) t) (nullable.some 100))) ((_ tuple.select 7) t) (nullable.some 2)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple false))))
(assert (= q1 (bag.map f0 T)))
(assert (= q2 (bag.map f1 T)))
(check-sat)
;answer: sat
; duration: 188 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_446604 Bool)) (not BOUND_VARIABLE_446604)) (as nullable.null (Nullable Bool)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_null (as nullable.null (Nullable Bool))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 9 ms.
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
; duration: 10161 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_479916 String)) (str.to_upper BOUND_VARIABLE_479916)) (nullable.lift (lambda ((BOUND_VARIABLE_479910 String)) (str.to_lower BOUND_VARIABLE_479910)) ((_ tuple.select 1) t)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_479932 String)) (str.to_upper BOUND_VARIABLE_479932)) ((_ tuple.select 1) t))))))
(assert (= q1 (bag.map f0 DEPT)))
(assert (= q2 (bag.map f1 DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10122 ms.
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const ACCOUNT (Bag (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_509029 Int) (BOUND_VARIABLE_509030 Int)) (= BOUND_VARIABLE_509029 BOUND_VARIABLE_509030)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_509029 Int) (BOUND_VARIABLE_509030 Int)) (= BOUND_VARIABLE_509029 BOUND_VARIABLE_509030)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_509036 Int) (BOUND_VARIABLE_509037 Int)) (= BOUND_VARIABLE_509036 BOUND_VARIABLE_509037)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_509036 Int) (BOUND_VARIABLE_509037 Int)) (= BOUND_VARIABLE_509036 BOUND_VARIABLE_509037)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_509029 Int) (BOUND_VARIABLE_509030 Int)) (= BOUND_VARIABLE_509029 BOUND_VARIABLE_509030)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_509036 Int) (BOUND_VARIABLE_509037 Int)) (= BOUND_VARIABLE_509036 BOUND_VARIABLE_509037)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_509029 Int) (BOUND_VARIABLE_509030 Int)) (= BOUND_VARIABLE_509029 BOUND_VARIABLE_509030)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_509029 Int) (BOUND_VARIABLE_509030 Int)) (= BOUND_VARIABLE_509029 BOUND_VARIABLE_509030)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_509036 Int) (BOUND_VARIABLE_509037 Int)) (= BOUND_VARIABLE_509036 BOUND_VARIABLE_509037)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_509036 Int) (BOUND_VARIABLE_509037 Int)) (= BOUND_VARIABLE_509036 BOUND_VARIABLE_509037)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_509029 Int) (BOUND_VARIABLE_509030 Int)) (= BOUND_VARIABLE_509029 BOUND_VARIABLE_509030)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_509036 Int) (BOUND_VARIABLE_509037 Int)) (= BOUND_VARIABLE_509036 BOUND_VARIABLE_509037)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_509121 Int) (BOUND_VARIABLE_509122 Int)) (= BOUND_VARIABLE_509121 BOUND_VARIABLE_509122)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_509121 Int) (BOUND_VARIABLE_509122 Int)) (= BOUND_VARIABLE_509121 BOUND_VARIABLE_509122)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_509195 Int) (BOUND_VARIABLE_509196 Int)) (= BOUND_VARIABLE_509195 BOUND_VARIABLE_509196)) ((_ tuple.select 0) t) ((_ tuple.select 12) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_509195 Int) (BOUND_VARIABLE_509196 Int)) (= BOUND_VARIABLE_509195 BOUND_VARIABLE_509196)) ((_ tuple.select 0) t) ((_ tuple.select 12) t)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13) (bag.filter p0 (table.product (table.product EMP DEPT) ACCOUNT)))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 12 13 9 10 11) (bag.filter p2 (table.product (bag.filter p1 (table.product EMP ACCOUNT)) DEPT)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10355 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_637638 Int) (BOUND_VARIABLE_637639 Int)) (= BOUND_VARIABLE_637638 BOUND_VARIABLE_637639)) ((_ tuple.select 6) t) ((_ tuple.select 14) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_637638 Int) (BOUND_VARIABLE_637639 Int)) (= BOUND_VARIABLE_637638 BOUND_VARIABLE_637639)) ((_ tuple.select 6) t) ((_ tuple.select 14) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= p2 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_637699 Int) (BOUND_VARIABLE_637700 Int)) (< BOUND_VARIABLE_637699 BOUND_VARIABLE_637700)) ((_ tuple.select 15) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_637699 Int) (BOUND_VARIABLE_637700 Int)) (< BOUND_VARIABLE_637699 BOUND_VARIABLE_637700)) ((_ tuple.select 15) t) (nullable.some 1)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_637734 Int) (BOUND_VARIABLE_637735 Int)) (< BOUND_VARIABLE_637734 BOUND_VARIABLE_637735)) ((_ tuple.select 6) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_637734 Int) (BOUND_VARIABLE_637735 Int)) (< BOUND_VARIABLE_637734 BOUND_VARIABLE_637735)) ((_ tuple.select 6) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p4 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_637798 Int) (BOUND_VARIABLE_637799 Int)) (= BOUND_VARIABLE_637798 BOUND_VARIABLE_637799)) ((_ tuple.select 6) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_637798 Int) (BOUND_VARIABLE_637799 Int)) (= BOUND_VARIABLE_637798 BOUND_VARIABLE_637799)) ((_ tuple.select 6) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ table.project 6 5) (bag.filter p2 (bag.union_disjoint (bag.map leftJoin1 (bag.difference_remove T ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 (table.product T T))))) (bag.filter p0 (table.product T T)))))))
(assert (= q2 ((_ table.project 6 5) (bag.filter p4 (table.product T ((_ table.project 5) (bag.filter p3 T)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10180 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_684407 Int) (BOUND_VARIABLE_684408 Int)) (= BOUND_VARIABLE_684407 BOUND_VARIABLE_684408)) ((_ tuple.select 6) t) ((_ tuple.select 15) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_684407 Int) (BOUND_VARIABLE_684408 Int)) (= BOUND_VARIABLE_684407 BOUND_VARIABLE_684408)) ((_ tuple.select 6) t) ((_ tuple.select 15) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= q1 ((_ table.project 0) ((_ table.project 5) (bag.union_disjoint (bag.map leftJoin1 (bag.difference_remove T ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 (table.product T T))))) (bag.filter p0 (table.product T T)))))))
(assert (= q2 ((_ table.project 0) ((_ table.project 5) T))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10273 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_738963 Int) (BOUND_VARIABLE_738964 Int)) (= BOUND_VARIABLE_738963 BOUND_VARIABLE_738964)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_738963 Int) (BOUND_VARIABLE_738964 Int)) (= BOUND_VARIABLE_738963 BOUND_VARIABLE_738964)) ((_ tuple.select 6) t) (nullable.some 0)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_738983 Int) (BOUND_VARIABLE_738984 Int)) (= BOUND_VARIABLE_738983 BOUND_VARIABLE_738984)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_738983 Int) (BOUND_VARIABLE_738984 Int)) (= BOUND_VARIABLE_738983 BOUND_VARIABLE_738984)) ((_ tuple.select 6) t) (nullable.some 0)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 T))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 T))))
(check-sat)
;answer: unsat
; duration: 479 ms.
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
; duration: 7 ms.
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
; duration: 187 ms.
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
; duration: 10009 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_766199 Int) (BOUND_VARIABLE_766200 Int)) (> BOUND_VARIABLE_766199 BOUND_VARIABLE_766200)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_766199 Int) (BOUND_VARIABLE_766200 Int)) (> BOUND_VARIABLE_766199 BOUND_VARIABLE_766200)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_766219 Int) (BOUND_VARIABLE_766220 Int)) (> BOUND_VARIABLE_766219 BOUND_VARIABLE_766220)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_766219 Int) (BOUND_VARIABLE_766220 Int)) (> BOUND_VARIABLE_766219 BOUND_VARIABLE_766220)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (= q1 ((_ table.project 1) (bag.filter p0 ((_ table.project 0 1) DEPT)))))
(assert (= q2 ((_ table.project 1) (bag.filter p1 DEPT))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10073 ms.
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
; duration: 225 ms.
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
; duration: 5 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_800140 Int) (BOUND_VARIABLE_800141 Int)) (> BOUND_VARIABLE_800140 BOUND_VARIABLE_800141)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_800140 Int) (BOUND_VARIABLE_800141 Int)) (> BOUND_VARIABLE_800140 BOUND_VARIABLE_800141)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_800160 Int) (BOUND_VARIABLE_800161 Int)) (> BOUND_VARIABLE_800160 BOUND_VARIABLE_800161)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_800160 Int) (BOUND_VARIABLE_800161 Int)) (> BOUND_VARIABLE_800160 BOUND_VARIABLE_800161)) ((_ tuple.select 0) t) (nullable.some 1))))) (and (nullable.is_some (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (not (nullable.val (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_800160 Int) (BOUND_VARIABLE_800161 Int)) (> BOUND_VARIABLE_800160 BOUND_VARIABLE_800161)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.is_null (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_800160 Int) (BOUND_VARIABLE_800161 Int)) (> BOUND_VARIABLE_800160 BOUND_VARIABLE_800161)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_800160 Int) (BOUND_VARIABLE_800161 Int)) (> BOUND_VARIABLE_800160 BOUND_VARIABLE_800161)) ((_ tuple.select 0) t) (nullable.some 1))))) (and (nullable.is_some (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (not (nullable.val (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_800160 Int) (BOUND_VARIABLE_800161 Int)) (> BOUND_VARIABLE_800160 BOUND_VARIABLE_800161)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.is_null (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 DEPT))))
(assert (= q2 ((_ table.project 0 1) (bag.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 101 ms.
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
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_801700 Int) (BOUND_VARIABLE_801701 Int)) (= BOUND_VARIABLE_801700 BOUND_VARIABLE_801701)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_801700 Int) (BOUND_VARIABLE_801701 Int)) (= BOUND_VARIABLE_801700 BOUND_VARIABLE_801701)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_801707 Int) (BOUND_VARIABLE_801708 Int)) (= BOUND_VARIABLE_801707 BOUND_VARIABLE_801708)) ((_ tuple.select 9) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_801707 Int) (BOUND_VARIABLE_801708 Int)) (= BOUND_VARIABLE_801707 BOUND_VARIABLE_801708)) ((_ tuple.select 9) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_801700 Int) (BOUND_VARIABLE_801701 Int)) (= BOUND_VARIABLE_801700 BOUND_VARIABLE_801701)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_801707 Int) (BOUND_VARIABLE_801708 Int)) (= BOUND_VARIABLE_801707 BOUND_VARIABLE_801708)) ((_ tuple.select 9) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_801700 Int) (BOUND_VARIABLE_801701 Int)) (= BOUND_VARIABLE_801700 BOUND_VARIABLE_801701)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_801700 Int) (BOUND_VARIABLE_801701 Int)) (= BOUND_VARIABLE_801700 BOUND_VARIABLE_801701)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_801707 Int) (BOUND_VARIABLE_801708 Int)) (= BOUND_VARIABLE_801707 BOUND_VARIABLE_801708)) ((_ tuple.select 9) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_801707 Int) (BOUND_VARIABLE_801708 Int)) (= BOUND_VARIABLE_801707 BOUND_VARIABLE_801708)) ((_ tuple.select 9) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_801700 Int) (BOUND_VARIABLE_801701 Int)) (= BOUND_VARIABLE_801700 BOUND_VARIABLE_801701)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_801707 Int) (BOUND_VARIABLE_801708 Int)) (= BOUND_VARIABLE_801707 BOUND_VARIABLE_801708)) ((_ tuple.select 9) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (not (nullable.val (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_801744 Int) (BOUND_VARIABLE_801745 Int)) (= BOUND_VARIABLE_801744 BOUND_VARIABLE_801745)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_801744 Int) (BOUND_VARIABLE_801745 Int)) (= BOUND_VARIABLE_801744 BOUND_VARIABLE_801745)) ((_ tuple.select 0) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_801744 Int) (BOUND_VARIABLE_801745 Int)) (= BOUND_VARIABLE_801744 BOUND_VARIABLE_801745)) ((_ tuple.select 0) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (not (nullable.val (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_801744 Int) (BOUND_VARIABLE_801745 Int)) (= BOUND_VARIABLE_801744 BOUND_VARIABLE_801745)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_801744 Int) (BOUND_VARIABLE_801745 Int)) (= BOUND_VARIABLE_801744 BOUND_VARIABLE_801745)) ((_ tuple.select 0) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_801744 Int) (BOUND_VARIABLE_801745 Int)) (= BOUND_VARIABLE_801744 BOUND_VARIABLE_801745)) ((_ tuple.select 0) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 0) t)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (not (nullable.val (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_801797 Int) (BOUND_VARIABLE_801798 Int)) (= BOUND_VARIABLE_801797 BOUND_VARIABLE_801798)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_801797 Int) (BOUND_VARIABLE_801798 Int)) (= BOUND_VARIABLE_801797 BOUND_VARIABLE_801798)) ((_ tuple.select 0) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_801797 Int) (BOUND_VARIABLE_801798 Int)) (= BOUND_VARIABLE_801797 BOUND_VARIABLE_801798)) ((_ tuple.select 0) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (not (nullable.val (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_801797 Int) (BOUND_VARIABLE_801798 Int)) (= BOUND_VARIABLE_801797 BOUND_VARIABLE_801798)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_801797 Int) (BOUND_VARIABLE_801798 Int)) (= BOUND_VARIABLE_801797 BOUND_VARIABLE_801798)) ((_ tuple.select 0) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_801797 Int) (BOUND_VARIABLE_801798 Int)) (= BOUND_VARIABLE_801797 BOUND_VARIABLE_801798)) ((_ tuple.select 0) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_801833 Int) (BOUND_VARIABLE_801834 Int)) (= BOUND_VARIABLE_801833 BOUND_VARIABLE_801834)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_801833 Int) (BOUND_VARIABLE_801834 Int)) (= BOUND_VARIABLE_801833 BOUND_VARIABLE_801834)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_801840 Int) (BOUND_VARIABLE_801841 Int)) (= BOUND_VARIABLE_801840 BOUND_VARIABLE_801841)) ((_ tuple.select 9) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_801840 Int) (BOUND_VARIABLE_801841 Int)) (= BOUND_VARIABLE_801840 BOUND_VARIABLE_801841)) ((_ tuple.select 9) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_801833 Int) (BOUND_VARIABLE_801834 Int)) (= BOUND_VARIABLE_801833 BOUND_VARIABLE_801834)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_801840 Int) (BOUND_VARIABLE_801841 Int)) (= BOUND_VARIABLE_801840 BOUND_VARIABLE_801841)) ((_ tuple.select 9) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_801833 Int) (BOUND_VARIABLE_801834 Int)) (= BOUND_VARIABLE_801833 BOUND_VARIABLE_801834)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_801833 Int) (BOUND_VARIABLE_801834 Int)) (= BOUND_VARIABLE_801833 BOUND_VARIABLE_801834)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_801840 Int) (BOUND_VARIABLE_801841 Int)) (= BOUND_VARIABLE_801840 BOUND_VARIABLE_801841)) ((_ tuple.select 9) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_801840 Int) (BOUND_VARIABLE_801841 Int)) (= BOUND_VARIABLE_801840 BOUND_VARIABLE_801841)) ((_ tuple.select 9) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_801833 Int) (BOUND_VARIABLE_801834 Int)) (= BOUND_VARIABLE_801833 BOUND_VARIABLE_801834)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_801840 Int) (BOUND_VARIABLE_801841 Int)) (= BOUND_VARIABLE_801840 BOUND_VARIABLE_801841)) ((_ tuple.select 9) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 10 11) (bag.filter p1 (table.product (bag.map f0 EMP) DEPT)))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 10 11) (bag.filter p5 (table.product (bag.map f3 (bag.filter p2 EMP)) ((_ table.project 0 1) (bag.filter p4 DEPT)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10025 ms.
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
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_848107 Int) (BOUND_VARIABLE_848108 Int)) (= BOUND_VARIABLE_848107 BOUND_VARIABLE_848108)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_848107 Int) (BOUND_VARIABLE_848108 Int)) (= BOUND_VARIABLE_848107 BOUND_VARIABLE_848108)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_848114 Int) (BOUND_VARIABLE_848115 Int)) (= BOUND_VARIABLE_848114 BOUND_VARIABLE_848115)) ((_ tuple.select 9) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_848114 Int) (BOUND_VARIABLE_848115 Int)) (= BOUND_VARIABLE_848114 BOUND_VARIABLE_848115)) ((_ tuple.select 9) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_848107 Int) (BOUND_VARIABLE_848108 Int)) (= BOUND_VARIABLE_848107 BOUND_VARIABLE_848108)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_848114 Int) (BOUND_VARIABLE_848115 Int)) (= BOUND_VARIABLE_848114 BOUND_VARIABLE_848115)) ((_ tuple.select 9) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_848107 Int) (BOUND_VARIABLE_848108 Int)) (= BOUND_VARIABLE_848107 BOUND_VARIABLE_848108)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_848107 Int) (BOUND_VARIABLE_848108 Int)) (= BOUND_VARIABLE_848107 BOUND_VARIABLE_848108)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_848114 Int) (BOUND_VARIABLE_848115 Int)) (= BOUND_VARIABLE_848114 BOUND_VARIABLE_848115)) ((_ tuple.select 9) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_848114 Int) (BOUND_VARIABLE_848115 Int)) (= BOUND_VARIABLE_848114 BOUND_VARIABLE_848115)) ((_ tuple.select 9) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_848107 Int) (BOUND_VARIABLE_848108 Int)) (= BOUND_VARIABLE_848107 BOUND_VARIABLE_848108)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_848114 Int) (BOUND_VARIABLE_848115 Int)) (= BOUND_VARIABLE_848114 BOUND_VARIABLE_848115)) ((_ tuple.select 9) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 9) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 0) t)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (not (nullable.val (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_848204 Int) (BOUND_VARIABLE_848205 Int)) (= BOUND_VARIABLE_848204 BOUND_VARIABLE_848205)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_848204 Int) (BOUND_VARIABLE_848205 Int)) (= BOUND_VARIABLE_848204 BOUND_VARIABLE_848205)) ((_ tuple.select 0) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_848204 Int) (BOUND_VARIABLE_848205 Int)) (= BOUND_VARIABLE_848204 BOUND_VARIABLE_848205)) ((_ tuple.select 0) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (not (nullable.val (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_848204 Int) (BOUND_VARIABLE_848205 Int)) (= BOUND_VARIABLE_848204 BOUND_VARIABLE_848205)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_848204 Int) (BOUND_VARIABLE_848205 Int)) (= BOUND_VARIABLE_848204 BOUND_VARIABLE_848205)) ((_ tuple.select 0) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_848204 Int) (BOUND_VARIABLE_848205 Int)) (= BOUND_VARIABLE_848204 BOUND_VARIABLE_848205)) ((_ tuple.select 0) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_848240 Int) (BOUND_VARIABLE_848241 Int)) (= BOUND_VARIABLE_848240 BOUND_VARIABLE_848241)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_848240 Int) (BOUND_VARIABLE_848241 Int)) (= BOUND_VARIABLE_848240 BOUND_VARIABLE_848241)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_848247 Int) (BOUND_VARIABLE_848248 Int)) (= BOUND_VARIABLE_848247 BOUND_VARIABLE_848248)) ((_ tuple.select 9) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_848247 Int) (BOUND_VARIABLE_848248 Int)) (= BOUND_VARIABLE_848247 BOUND_VARIABLE_848248)) ((_ tuple.select 9) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_848240 Int) (BOUND_VARIABLE_848241 Int)) (= BOUND_VARIABLE_848240 BOUND_VARIABLE_848241)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_848247 Int) (BOUND_VARIABLE_848248 Int)) (= BOUND_VARIABLE_848247 BOUND_VARIABLE_848248)) ((_ tuple.select 9) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_848240 Int) (BOUND_VARIABLE_848241 Int)) (= BOUND_VARIABLE_848240 BOUND_VARIABLE_848241)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_848240 Int) (BOUND_VARIABLE_848241 Int)) (= BOUND_VARIABLE_848240 BOUND_VARIABLE_848241)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_848247 Int) (BOUND_VARIABLE_848248 Int)) (= BOUND_VARIABLE_848247 BOUND_VARIABLE_848248)) ((_ tuple.select 9) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_848247 Int) (BOUND_VARIABLE_848248 Int)) (= BOUND_VARIABLE_848247 BOUND_VARIABLE_848248)) ((_ tuple.select 9) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_848240 Int) (BOUND_VARIABLE_848241 Int)) (= BOUND_VARIABLE_848240 BOUND_VARIABLE_848241)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_848247 Int) (BOUND_VARIABLE_848248 Int)) (= BOUND_VARIABLE_848247 BOUND_VARIABLE_848248)) ((_ tuple.select 9) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= leftJoin6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 9) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 10 11) (bag.union_disjoint (bag.map leftJoin2 (bag.difference_remove (bag.map f0 EMP) ((_ table.project 0 1 2 3 4 5 6 7 8 9) (bag.filter p1 (table.product (bag.map f0 EMP) DEPT))))) (bag.filter p1 (table.product (bag.map f0 EMP) DEPT))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 10 11) (bag.union_disjoint (bag.map leftJoin6 (bag.difference_remove (bag.map f3 EMP) ((_ table.project 0 1 2 3 4 5 6 7 8 9) (bag.filter p5 (table.product (bag.map f3 EMP) ((_ table.project 0 1) (bag.filter p4 DEPT))))))) (bag.filter p5 (table.product (bag.map f3 EMP) ((_ table.project 0 1) (bag.filter p4 DEPT))))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10260 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_890272 Int) (BOUND_VARIABLE_890273 Int)) (= BOUND_VARIABLE_890272 BOUND_VARIABLE_890273)) ((_ tuple.select 6) t) (nullable.some 3))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_890272 Int) (BOUND_VARIABLE_890273 Int)) (= BOUND_VARIABLE_890272 BOUND_VARIABLE_890273)) ((_ tuple.select 6) t) (nullable.some 3)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_890293 Int) (BOUND_VARIABLE_890294 Int)) (> BOUND_VARIABLE_890293 BOUND_VARIABLE_890294)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_890293 Int) (BOUND_VARIABLE_890294 Int)) (> BOUND_VARIABLE_890293 BOUND_VARIABLE_890294)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_890313 Int) (BOUND_VARIABLE_890314 Int)) (= BOUND_VARIABLE_890313 BOUND_VARIABLE_890314)) ((_ tuple.select 6) t) (nullable.some 3))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_890313 Int) (BOUND_VARIABLE_890314 Int)) (= BOUND_VARIABLE_890313 BOUND_VARIABLE_890314)) ((_ tuple.select 6) t) (nullable.some 3))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_890320 Int) (BOUND_VARIABLE_890321 Int)) (> BOUND_VARIABLE_890320 BOUND_VARIABLE_890321)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_890320 Int) (BOUND_VARIABLE_890321 Int)) (> BOUND_VARIABLE_890320 BOUND_VARIABLE_890321)) ((_ tuple.select 0) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_890313 Int) (BOUND_VARIABLE_890314 Int)) (= BOUND_VARIABLE_890313 BOUND_VARIABLE_890314)) ((_ tuple.select 6) t) (nullable.some 3))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_890320 Int) (BOUND_VARIABLE_890321 Int)) (> BOUND_VARIABLE_890320 BOUND_VARIABLE_890321)) ((_ tuple.select 0) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_890313 Int) (BOUND_VARIABLE_890314 Int)) (= BOUND_VARIABLE_890313 BOUND_VARIABLE_890314)) ((_ tuple.select 6) t) (nullable.some 3))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_890313 Int) (BOUND_VARIABLE_890314 Int)) (= BOUND_VARIABLE_890313 BOUND_VARIABLE_890314)) ((_ tuple.select 6) t) (nullable.some 3))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_890320 Int) (BOUND_VARIABLE_890321 Int)) (> BOUND_VARIABLE_890320 BOUND_VARIABLE_890321)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_890320 Int) (BOUND_VARIABLE_890321 Int)) (> BOUND_VARIABLE_890320 BOUND_VARIABLE_890321)) ((_ tuple.select 0) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_890313 Int) (BOUND_VARIABLE_890314 Int)) (= BOUND_VARIABLE_890313 BOUND_VARIABLE_890314)) ((_ tuple.select 6) t) (nullable.some 3))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_890320 Int) (BOUND_VARIABLE_890321 Int)) (> BOUND_VARIABLE_890320 BOUND_VARIABLE_890321)) ((_ tuple.select 0) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p1 ((_ table.project 0 6) (bag.filter p0 EMP))))))
(assert (= q2 ((_ table.project 0 6) (bag.filter p2 EMP))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10261 ms.
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
; duration: 168 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_924857 Int) (BOUND_VARIABLE_924858 Int)) (> BOUND_VARIABLE_924857 BOUND_VARIABLE_924858)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_924857 Int) (BOUND_VARIABLE_924858 Int)) (> BOUND_VARIABLE_924857 BOUND_VARIABLE_924858)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_924877 Int) (BOUND_VARIABLE_924878 Int)) (> BOUND_VARIABLE_924877 BOUND_VARIABLE_924878)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_924877 Int) (BOUND_VARIABLE_924878 Int)) (> BOUND_VARIABLE_924877 BOUND_VARIABLE_924878)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_924896 Int) (BOUND_VARIABLE_924897 Int)) (> BOUND_VARIABLE_924896 BOUND_VARIABLE_924897)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_924896 Int) (BOUND_VARIABLE_924897 Int)) (> BOUND_VARIABLE_924896 BOUND_VARIABLE_924897)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP))))
(check-sat)
;answer: unsat
; duration: 183 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_927055 Int) (BOUND_VARIABLE_927056 Int)) (> BOUND_VARIABLE_927055 BOUND_VARIABLE_927056)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_927055 Int) (BOUND_VARIABLE_927056 Int)) (> BOUND_VARIABLE_927055 BOUND_VARIABLE_927056)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_927074 Int) (BOUND_VARIABLE_927075 Int)) (> BOUND_VARIABLE_927074 BOUND_VARIABLE_927075)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_927074 Int) (BOUND_VARIABLE_927075 Int)) (> BOUND_VARIABLE_927074 BOUND_VARIABLE_927075)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_927080 Int) (BOUND_VARIABLE_927081 Int)) (> BOUND_VARIABLE_927080 BOUND_VARIABLE_927081)) ((_ tuple.select 0) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_927080 Int) (BOUND_VARIABLE_927081 Int)) (> BOUND_VARIABLE_927080 BOUND_VARIABLE_927081)) ((_ tuple.select 0) t) (nullable.some 0)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_927074 Int) (BOUND_VARIABLE_927075 Int)) (> BOUND_VARIABLE_927074 BOUND_VARIABLE_927075)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_927080 Int) (BOUND_VARIABLE_927081 Int)) (> BOUND_VARIABLE_927080 BOUND_VARIABLE_927081)) ((_ tuple.select 0) t) (nullable.some 0)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_927074 Int) (BOUND_VARIABLE_927075 Int)) (> BOUND_VARIABLE_927074 BOUND_VARIABLE_927075)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_927074 Int) (BOUND_VARIABLE_927075 Int)) (> BOUND_VARIABLE_927074 BOUND_VARIABLE_927075)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_927080 Int) (BOUND_VARIABLE_927081 Int)) (> BOUND_VARIABLE_927080 BOUND_VARIABLE_927081)) ((_ tuple.select 0) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_927080 Int) (BOUND_VARIABLE_927081 Int)) (> BOUND_VARIABLE_927080 BOUND_VARIABLE_927081)) ((_ tuple.select 0) t) (nullable.some 0)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_927074 Int) (BOUND_VARIABLE_927075 Int)) (> BOUND_VARIABLE_927074 BOUND_VARIABLE_927075)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_927080 Int) (BOUND_VARIABLE_927081 Int)) (> BOUND_VARIABLE_927080 BOUND_VARIABLE_927081)) ((_ tuple.select 0) t) (nullable.some 0)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_927113 Int) (BOUND_VARIABLE_927114 Int)) (> BOUND_VARIABLE_927113 BOUND_VARIABLE_927114)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_927113 Int) (BOUND_VARIABLE_927114 Int)) (> BOUND_VARIABLE_927113 BOUND_VARIABLE_927114)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_927132 Int) (BOUND_VARIABLE_927133 Int)) (> BOUND_VARIABLE_927132 BOUND_VARIABLE_927133)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_927132 Int) (BOUND_VARIABLE_927133 Int)) (> BOUND_VARIABLE_927132 BOUND_VARIABLE_927133)) ((_ tuple.select 0) t) (nullable.some 0)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP))))))
(check-sat)
;answer: unsat
; duration: 412 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_931207 Int) (BOUND_VARIABLE_931208 Int)) (> BOUND_VARIABLE_931207 BOUND_VARIABLE_931208)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_931207 Int) (BOUND_VARIABLE_931208 Int)) (> BOUND_VARIABLE_931207 BOUND_VARIABLE_931208)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_931227 Int) (BOUND_VARIABLE_931228 Int)) (> BOUND_VARIABLE_931227 BOUND_VARIABLE_931228)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_931227 Int) (BOUND_VARIABLE_931228 Int)) (> BOUND_VARIABLE_931227 BOUND_VARIABLE_931228)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_931233 Int) (BOUND_VARIABLE_931234 Int)) (> BOUND_VARIABLE_931233 BOUND_VARIABLE_931234)) ((_ tuple.select 0) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_931233 Int) (BOUND_VARIABLE_931234 Int)) (> BOUND_VARIABLE_931233 BOUND_VARIABLE_931234)) ((_ tuple.select 0) t) (nullable.some 0)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_931227 Int) (BOUND_VARIABLE_931228 Int)) (> BOUND_VARIABLE_931227 BOUND_VARIABLE_931228)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_931233 Int) (BOUND_VARIABLE_931234 Int)) (> BOUND_VARIABLE_931233 BOUND_VARIABLE_931234)) ((_ tuple.select 0) t) (nullable.some 0)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_931227 Int) (BOUND_VARIABLE_931228 Int)) (> BOUND_VARIABLE_931227 BOUND_VARIABLE_931228)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_931227 Int) (BOUND_VARIABLE_931228 Int)) (> BOUND_VARIABLE_931227 BOUND_VARIABLE_931228)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_931233 Int) (BOUND_VARIABLE_931234 Int)) (> BOUND_VARIABLE_931233 BOUND_VARIABLE_931234)) ((_ tuple.select 0) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_931233 Int) (BOUND_VARIABLE_931234 Int)) (> BOUND_VARIABLE_931233 BOUND_VARIABLE_931234)) ((_ tuple.select 0) t) (nullable.some 0)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_931227 Int) (BOUND_VARIABLE_931228 Int)) (> BOUND_VARIABLE_931227 BOUND_VARIABLE_931228)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_931233 Int) (BOUND_VARIABLE_931234 Int)) (> BOUND_VARIABLE_931233 BOUND_VARIABLE_931234)) ((_ tuple.select 0) t) (nullable.some 0)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_931273 Int) (BOUND_VARIABLE_931274 Int)) (> BOUND_VARIABLE_931273 BOUND_VARIABLE_931274)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_931273 Int) (BOUND_VARIABLE_931274 Int)) (> BOUND_VARIABLE_931273 BOUND_VARIABLE_931274)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_931292 Int) (BOUND_VARIABLE_931293 Int)) (> BOUND_VARIABLE_931292 BOUND_VARIABLE_931293)) ((_ tuple.select 0) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_931292 Int) (BOUND_VARIABLE_931293 Int)) (> BOUND_VARIABLE_931292 BOUND_VARIABLE_931293)) ((_ tuple.select 0) t) (nullable.some 0))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_931299 Int) (BOUND_VARIABLE_931300 Int)) (> BOUND_VARIABLE_931299 BOUND_VARIABLE_931300)) ((_ tuple.select 6) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_931299 Int) (BOUND_VARIABLE_931300 Int)) (> BOUND_VARIABLE_931299 BOUND_VARIABLE_931300)) ((_ tuple.select 6) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_931292 Int) (BOUND_VARIABLE_931293 Int)) (> BOUND_VARIABLE_931292 BOUND_VARIABLE_931293)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_931299 Int) (BOUND_VARIABLE_931300 Int)) (> BOUND_VARIABLE_931299 BOUND_VARIABLE_931300)) ((_ tuple.select 6) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_931292 Int) (BOUND_VARIABLE_931293 Int)) (> BOUND_VARIABLE_931292 BOUND_VARIABLE_931293)) ((_ tuple.select 0) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_931292 Int) (BOUND_VARIABLE_931293 Int)) (> BOUND_VARIABLE_931292 BOUND_VARIABLE_931293)) ((_ tuple.select 0) t) (nullable.some 0))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_931299 Int) (BOUND_VARIABLE_931300 Int)) (> BOUND_VARIABLE_931299 BOUND_VARIABLE_931300)) ((_ tuple.select 6) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_931299 Int) (BOUND_VARIABLE_931300 Int)) (> BOUND_VARIABLE_931299 BOUND_VARIABLE_931300)) ((_ tuple.select 6) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_931292 Int) (BOUND_VARIABLE_931293 Int)) (> BOUND_VARIABLE_931292 BOUND_VARIABLE_931293)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_931299 Int) (BOUND_VARIABLE_931300 Int)) (> BOUND_VARIABLE_931299 BOUND_VARIABLE_931300)) ((_ tuple.select 6) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP))))))
(check-sat)
;answer: unknown (INCOMPLETE)
; duration: 947 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_941957 Int) (BOUND_VARIABLE_941958 Int)) (= BOUND_VARIABLE_941957 BOUND_VARIABLE_941958)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_941957 Int) (BOUND_VARIABLE_941958 Int)) (= BOUND_VARIABLE_941957 BOUND_VARIABLE_941958)) ((_ tuple.select 0) t) (nullable.some 0)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_941977 Int) (BOUND_VARIABLE_941978 Int)) (= BOUND_VARIABLE_941977 BOUND_VARIABLE_941978)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_941977 Int) (BOUND_VARIABLE_941978 Int)) (= BOUND_VARIABLE_941977 BOUND_VARIABLE_941978)) ((_ tuple.select 0) t) (nullable.some 0)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_941996 Int) (BOUND_VARIABLE_941997 Int)) (= BOUND_VARIABLE_941996 BOUND_VARIABLE_941997)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_941996 Int) (BOUND_VARIABLE_941997 Int)) (= BOUND_VARIABLE_941996 BOUND_VARIABLE_941997)) ((_ tuple.select 0) t) (nullable.some 0)))))))
(assert (= q1 ((_ table.project 0 1) (bag.filter p0 (bag.union_disjoint ((_ table.project 0 1) DEPT) ((_ table.project 0 1) DEPT))))))
(assert (= q2 (bag.union_disjoint ((_ table.project 0 1) (bag.filter p1 DEPT)) ((_ table.project 0 1) (bag.filter p2 DEPT)))))
(check-sat)
;answer: unsat
; duration: 332 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_944654 Int) (BOUND_VARIABLE_944655 Int)) (> BOUND_VARIABLE_944654 BOUND_VARIABLE_944655)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_944654 Int) (BOUND_VARIABLE_944655 Int)) (> BOUND_VARIABLE_944654 BOUND_VARIABLE_944655)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_944673 Int) (BOUND_VARIABLE_944674 Int)) (> BOUND_VARIABLE_944673 BOUND_VARIABLE_944674)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_944673 Int) (BOUND_VARIABLE_944674 Int)) (> BOUND_VARIABLE_944673 BOUND_VARIABLE_944674)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= q1 ((_ table.project 0) (bag.filter p0 ((_ table.project 0) DEPT)))))
(assert (= q2 ((_ table.project 0) (bag.filter p1 DEPT))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10013 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_976291 Int) (BOUND_VARIABLE_976292 Int)) (> BOUND_VARIABLE_976291 BOUND_VARIABLE_976292)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_976291 Int) (BOUND_VARIABLE_976292 Int)) (> BOUND_VARIABLE_976291 BOUND_VARIABLE_976292)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_976311 Int) (BOUND_VARIABLE_976312 Int)) (> BOUND_VARIABLE_976311 BOUND_VARIABLE_976312)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_976311 Int) (BOUND_VARIABLE_976312 Int)) (> BOUND_VARIABLE_976311 BOUND_VARIABLE_976312)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= q1 ((_ table.project 0) (bag.filter p0 ((_ table.project 0) ((_ table.project 0) DEPT))))))
(assert (= q2 ((_ table.project 0) ((_ table.project 0) (bag.filter p1 DEPT)))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10182 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1009566 Int) (BOUND_VARIABLE_1009567 Int)) (= BOUND_VARIABLE_1009566 BOUND_VARIABLE_1009567)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1009566 Int) (BOUND_VARIABLE_1009567 Int)) (= BOUND_VARIABLE_1009566 BOUND_VARIABLE_1009567)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1009614 Int) (BOUND_VARIABLE_1009615 Int)) (> BOUND_VARIABLE_1009614 BOUND_VARIABLE_1009615)) ((_ tuple.select 6) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1009614 Int) (BOUND_VARIABLE_1009615 Int)) (> BOUND_VARIABLE_1009614 BOUND_VARIABLE_1009615)) ((_ tuple.select 6) t) (nullable.some 0))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1009621 Int) (BOUND_VARIABLE_1009622 Int)) (= BOUND_VARIABLE_1009621 BOUND_VARIABLE_1009622)) ((_ tuple.select 9) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1009621 Int) (BOUND_VARIABLE_1009622 Int)) (= BOUND_VARIABLE_1009621 BOUND_VARIABLE_1009622)) ((_ tuple.select 9) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1009614 Int) (BOUND_VARIABLE_1009615 Int)) (> BOUND_VARIABLE_1009614 BOUND_VARIABLE_1009615)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1009621 Int) (BOUND_VARIABLE_1009622 Int)) (= BOUND_VARIABLE_1009621 BOUND_VARIABLE_1009622)) ((_ tuple.select 9) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1009614 Int) (BOUND_VARIABLE_1009615 Int)) (> BOUND_VARIABLE_1009614 BOUND_VARIABLE_1009615)) ((_ tuple.select 6) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1009614 Int) (BOUND_VARIABLE_1009615 Int)) (> BOUND_VARIABLE_1009614 BOUND_VARIABLE_1009615)) ((_ tuple.select 6) t) (nullable.some 0))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1009621 Int) (BOUND_VARIABLE_1009622 Int)) (= BOUND_VARIABLE_1009621 BOUND_VARIABLE_1009622)) ((_ tuple.select 9) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1009621 Int) (BOUND_VARIABLE_1009622 Int)) (= BOUND_VARIABLE_1009621 BOUND_VARIABLE_1009622)) ((_ tuple.select 9) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1009614 Int) (BOUND_VARIABLE_1009615 Int)) (> BOUND_VARIABLE_1009614 BOUND_VARIABLE_1009615)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1009621 Int) (BOUND_VARIABLE_1009622 Int)) (= BOUND_VARIABLE_1009621 BOUND_VARIABLE_1009622)) ((_ tuple.select 9) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1009655 Int) (BOUND_VARIABLE_1009656 Int)) (= BOUND_VARIABLE_1009655 BOUND_VARIABLE_1009656)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1009655 Int) (BOUND_VARIABLE_1009656 Int)) (= BOUND_VARIABLE_1009655 BOUND_VARIABLE_1009656)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1009676 Int) (BOUND_VARIABLE_1009677 Int)) (= BOUND_VARIABLE_1009676 BOUND_VARIABLE_1009677)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1009676 Int) (BOUND_VARIABLE_1009677 Int)) (= BOUND_VARIABLE_1009676 BOUND_VARIABLE_1009677)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1009720 Int) (BOUND_VARIABLE_1009721 Int)) (> BOUND_VARIABLE_1009720 BOUND_VARIABLE_1009721)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1009720 Int) (BOUND_VARIABLE_1009721 Int)) (> BOUND_VARIABLE_1009720 BOUND_VARIABLE_1009721)) ((_ tuple.select 6) t) (nullable.some 0)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p2 (bag.union_disjoint (bag.map rightJoin1 (bag.difference_remove DEPT ((_ table.project 9 10) (bag.filter p0 (table.product EMP DEPT))))) (bag.filter p0 (table.product EMP DEPT)))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p6 (bag.union_disjoint (bag.map rightJoin5 (bag.difference_remove ((_ table.project 0 1) (bag.filter p3 DEPT)) ((_ table.project 9 10) (bag.filter p4 (table.product EMP ((_ table.project 0 1) (bag.filter p3 DEPT))))))) (bag.filter p4 (table.product EMP ((_ table.project 0 1) (bag.filter p3 DEPT)))))))))
(check-sat)
;answer: unsat
; duration: 751 ms.
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

(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const leftJoin1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const leftJoin5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1015254 Int) (BOUND_VARIABLE_1015255 Int)) (= BOUND_VARIABLE_1015254 BOUND_VARIABLE_1015255)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1015254 Int) (BOUND_VARIABLE_1015255 Int)) (= BOUND_VARIABLE_1015254 BOUND_VARIABLE_1015255)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1015307 Int) (BOUND_VARIABLE_1015308 Int)) (> BOUND_VARIABLE_1015307 BOUND_VARIABLE_1015308)) ((_ tuple.select 6) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1015307 Int) (BOUND_VARIABLE_1015308 Int)) (> BOUND_VARIABLE_1015307 BOUND_VARIABLE_1015308)) ((_ tuple.select 6) t) (nullable.some 0))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1015314 Int) (BOUND_VARIABLE_1015315 Int)) (= BOUND_VARIABLE_1015314 BOUND_VARIABLE_1015315)) ((_ tuple.select 9) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1015314 Int) (BOUND_VARIABLE_1015315 Int)) (= BOUND_VARIABLE_1015314 BOUND_VARIABLE_1015315)) ((_ tuple.select 9) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1015307 Int) (BOUND_VARIABLE_1015308 Int)) (> BOUND_VARIABLE_1015307 BOUND_VARIABLE_1015308)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1015314 Int) (BOUND_VARIABLE_1015315 Int)) (= BOUND_VARIABLE_1015314 BOUND_VARIABLE_1015315)) ((_ tuple.select 9) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1015307 Int) (BOUND_VARIABLE_1015308 Int)) (> BOUND_VARIABLE_1015307 BOUND_VARIABLE_1015308)) ((_ tuple.select 6) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1015307 Int) (BOUND_VARIABLE_1015308 Int)) (> BOUND_VARIABLE_1015307 BOUND_VARIABLE_1015308)) ((_ tuple.select 6) t) (nullable.some 0))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1015314 Int) (BOUND_VARIABLE_1015315 Int)) (= BOUND_VARIABLE_1015314 BOUND_VARIABLE_1015315)) ((_ tuple.select 9) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1015314 Int) (BOUND_VARIABLE_1015315 Int)) (= BOUND_VARIABLE_1015314 BOUND_VARIABLE_1015315)) ((_ tuple.select 9) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1015307 Int) (BOUND_VARIABLE_1015308 Int)) (> BOUND_VARIABLE_1015307 BOUND_VARIABLE_1015308)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1015314 Int) (BOUND_VARIABLE_1015315 Int)) (= BOUND_VARIABLE_1015314 BOUND_VARIABLE_1015315)) ((_ tuple.select 9) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1015347 Int) (BOUND_VARIABLE_1015348 Int)) (> BOUND_VARIABLE_1015347 BOUND_VARIABLE_1015348)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1015347 Int) (BOUND_VARIABLE_1015348 Int)) (> BOUND_VARIABLE_1015347 BOUND_VARIABLE_1015348)) ((_ tuple.select 6) t) (nullable.some 0)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1015368 Int) (BOUND_VARIABLE_1015369 Int)) (= BOUND_VARIABLE_1015368 BOUND_VARIABLE_1015369)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1015368 Int) (BOUND_VARIABLE_1015369 Int)) (= BOUND_VARIABLE_1015368 BOUND_VARIABLE_1015369)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1015419 Int) (BOUND_VARIABLE_1015420 Int)) (= BOUND_VARIABLE_1015419 BOUND_VARIABLE_1015420)) ((_ tuple.select 9) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1015419 Int) (BOUND_VARIABLE_1015420 Int)) (= BOUND_VARIABLE_1015419 BOUND_VARIABLE_1015420)) ((_ tuple.select 9) t) (nullable.some 1)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p2 (bag.union_disjoint (bag.map leftJoin1 (bag.difference_remove EMP ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 (table.product EMP DEPT))))) (bag.filter p0 (table.product EMP DEPT)))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p6 (bag.union_disjoint (bag.map leftJoin5 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) DEPT))))) (bag.filter p4 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) DEPT)))))))
(check-sat)
;answer: unsat
; duration: 648 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_1021149 Int) (BOUND_VARIABLE_1021150 Int)) (> BOUND_VARIABLE_1021149 BOUND_VARIABLE_1021150)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1021276 Int) (BOUND_VARIABLE_1021277 Int)) (= BOUND_VARIABLE_1021276 BOUND_VARIABLE_1021277)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1021276 Int) (BOUND_VARIABLE_1021277 Int)) (= BOUND_VARIABLE_1021276 BOUND_VARIABLE_1021277)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))))) (and (nullable.is_some ((_ tuple.select 9) t)) (not (nullable.val ((_ tuple.select 9) t))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1021276 Int) (BOUND_VARIABLE_1021277 Int)) (= BOUND_VARIABLE_1021276 BOUND_VARIABLE_1021277)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (nullable.is_null ((_ tuple.select 9) t))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1021276 Int) (BOUND_VARIABLE_1021277 Int)) (= BOUND_VARIABLE_1021276 BOUND_VARIABLE_1021277)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1021276 Int) (BOUND_VARIABLE_1021277 Int)) (= BOUND_VARIABLE_1021276 BOUND_VARIABLE_1021277)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))))) (and (nullable.is_some ((_ tuple.select 9) t)) (not (nullable.val ((_ tuple.select 9) t))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1021276 Int) (BOUND_VARIABLE_1021277 Int)) (= BOUND_VARIABLE_1021276 BOUND_VARIABLE_1021277)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (nullable.is_null ((_ tuple.select 9) t))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1021318 Int) (BOUND_VARIABLE_1021319 Int)) (> BOUND_VARIABLE_1021318 BOUND_VARIABLE_1021319)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1021318 Int) (BOUND_VARIABLE_1021319 Int)) (> BOUND_VARIABLE_1021318 BOUND_VARIABLE_1021319)) ((_ tuple.select 6) t) (nullable.some 0)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1021337 Int) (BOUND_VARIABLE_1021338 Int)) (= BOUND_VARIABLE_1021337 BOUND_VARIABLE_1021338)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1021337 Int) (BOUND_VARIABLE_1021338 Int)) (= BOUND_VARIABLE_1021337 BOUND_VARIABLE_1021338)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1021358 Int) (BOUND_VARIABLE_1021359 Int)) (= BOUND_VARIABLE_1021358 BOUND_VARIABLE_1021359)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1021358 Int) (BOUND_VARIABLE_1021359 Int)) (= BOUND_VARIABLE_1021358 BOUND_VARIABLE_1021359)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 10 11) (bag.filter p2 (table.product (bag.map f0 EMP) (bag.map f1 DEPT))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p5 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 EMP)) ((_ table.project 0 1) (bag.filter p4 DEPT)))))))
(check-sat)
;answer: sat
; duration: 1781 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some (- 1)) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some 1) (nullable.some 0) (nullable.some (- 3))) 2))
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 0) (nullable.some "A")) 3))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some (- 1)) (as nullable.null (Nullable String)) (nullable.some "") (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some 1) (nullable.some 0) (nullable.some (- 3)) (nullable.some 0) (nullable.some "A")) 6)
; q2
(get-value (q2))
; (as bag.empty (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
; insert into EMP values(-1,NULL,'',2,-2,3,1,0,-3),(-1,NULL,'',2,-2,3,1,0,-3)
; insert into DEPT values(0,'A'),(0,'A'),(0,'A')
; SELECT * FROM (SELECT * FROM emp AS emp INNER JOIN dept AS dept ON emp.deptno = dept.deptno AND emp.sal > 0 AND dept.deptno = 1) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM emp AS emp WHERE emp.sal > 0) t0 INNER JOIN (SELECT * FROM dept AS dept WHERE dept.deptno = 1) t1 ON t0.deptno = t1.deptno) AS q2;

; SELECT * FROM (SELECT * FROM (SELECT * FROM emp AS emp WHERE emp.sal > 0) t0 INNER JOIN (SELECT * FROM dept AS dept WHERE dept.deptno = 1) t1 ON t0.deptno = t1.deptno) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM emp AS emp INNER JOIN dept AS dept ON emp.deptno = dept.deptno AND emp.sal > 0 AND dept.deptno = 1) AS q1;

;Model soundness: false
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

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_1031929 Int) (BOUND_VARIABLE_1031930 Int)) (> BOUND_VARIABLE_1031929 BOUND_VARIABLE_1031930)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1031960 Int) (BOUND_VARIABLE_1031961 Int)) (= BOUND_VARIABLE_1031960 BOUND_VARIABLE_1031961)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1031960 Int) (BOUND_VARIABLE_1031961 Int)) (= BOUND_VARIABLE_1031960 BOUND_VARIABLE_1031961)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))))) (and (nullable.is_some ((_ tuple.select 9) t)) (not (nullable.val ((_ tuple.select 9) t))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1031960 Int) (BOUND_VARIABLE_1031961 Int)) (= BOUND_VARIABLE_1031960 BOUND_VARIABLE_1031961)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (nullable.is_null ((_ tuple.select 9) t))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1031960 Int) (BOUND_VARIABLE_1031961 Int)) (= BOUND_VARIABLE_1031960 BOUND_VARIABLE_1031961)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1031960 Int) (BOUND_VARIABLE_1031961 Int)) (= BOUND_VARIABLE_1031960 BOUND_VARIABLE_1031961)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))))) (and (nullable.is_some ((_ tuple.select 9) t)) (not (nullable.val ((_ tuple.select 9) t))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1031960 Int) (BOUND_VARIABLE_1031961 Int)) (= BOUND_VARIABLE_1031960 BOUND_VARIABLE_1031961)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (nullable.is_null ((_ tuple.select 9) t))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= rightJoin3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Bool)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1032032 Int) (BOUND_VARIABLE_1032033 Int)) (> BOUND_VARIABLE_1032032 BOUND_VARIABLE_1032033)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1032032 Int) (BOUND_VARIABLE_1032033 Int)) (> BOUND_VARIABLE_1032032 BOUND_VARIABLE_1032033)) ((_ tuple.select 6) t) (nullable.some 0)))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1032064 Int) (BOUND_VARIABLE_1032065 Int)) (= BOUND_VARIABLE_1032064 BOUND_VARIABLE_1032065)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1032064 Int) (BOUND_VARIABLE_1032065 Int)) (= BOUND_VARIABLE_1032064 BOUND_VARIABLE_1032065)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1032071 Int) (BOUND_VARIABLE_1032072 Int)) (= BOUND_VARIABLE_1032071 BOUND_VARIABLE_1032072)) ((_ tuple.select 11) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1032071 Int) (BOUND_VARIABLE_1032072 Int)) (= BOUND_VARIABLE_1032071 BOUND_VARIABLE_1032072)) ((_ tuple.select 11) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1032064 Int) (BOUND_VARIABLE_1032065 Int)) (= BOUND_VARIABLE_1032064 BOUND_VARIABLE_1032065)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1032071 Int) (BOUND_VARIABLE_1032072 Int)) (= BOUND_VARIABLE_1032071 BOUND_VARIABLE_1032072)) ((_ tuple.select 11) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1032064 Int) (BOUND_VARIABLE_1032065 Int)) (= BOUND_VARIABLE_1032064 BOUND_VARIABLE_1032065)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1032064 Int) (BOUND_VARIABLE_1032065 Int)) (= BOUND_VARIABLE_1032064 BOUND_VARIABLE_1032065)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1032071 Int) (BOUND_VARIABLE_1032072 Int)) (= BOUND_VARIABLE_1032071 BOUND_VARIABLE_1032072)) ((_ tuple.select 11) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1032071 Int) (BOUND_VARIABLE_1032072 Int)) (= BOUND_VARIABLE_1032071 BOUND_VARIABLE_1032072)) ((_ tuple.select 11) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1032064 Int) (BOUND_VARIABLE_1032065 Int)) (= BOUND_VARIABLE_1032064 BOUND_VARIABLE_1032065)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1032071 Int) (BOUND_VARIABLE_1032072 Int)) (= BOUND_VARIABLE_1032071 BOUND_VARIABLE_1032072)) ((_ tuple.select 11) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= rightJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 10 11) (bag.union_disjoint (bag.map rightJoin3 (bag.difference_remove (bag.map f1 DEPT) ((_ table.project 10 11 12) (bag.filter p2 (table.product (bag.map f0 EMP) (bag.map f1 DEPT)))))) (bag.filter p2 (table.product (bag.map f0 EMP) (bag.map f1 DEPT)))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map rightJoin7 (bag.difference_remove (bag.map f5 DEPT) ((_ table.project 9 10 11) (bag.filter p6 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)) (bag.map f5 DEPT)))))) (bag.filter p6 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p4 EMP)) (bag.map f5 DEPT)))))))
(check-sat)
;answer: sat
; duration: 9178 ms.
(get-model)
; (
; (define-fun DEPT () (Bag (Tuple (Nullable Int) (Nullable String))) (bag (tuple (nullable.some 2) (nullable.some "F")) 1))
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 4) (nullable.some "D") (nullable.some "E") (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 1) (nullable.some 2) (nullable.some 6)) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (nullable.some 4) (nullable.some "D") (nullable.some "E") (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 1) (nullable.some 2) (nullable.some 6) (nullable.some 2) (nullable.some "F")) 1)
; q2
(get-value (q2))
; (bag (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (nullable.some 2) (nullable.some "F")) 1)
; insert into DEPT values(2,'F')
; insert into EMP values(4,'D','E',-4,5,-5,1,2,6)
; SELECT * FROM (SELECT * FROM emp RIGHT JOIN dept ON emp.deptno = dept.deptno AND emp.sal > 0 AND dept.deptno = 1) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM (SELECT * FROM emp WHERE emp.sal > 0) t0 RIGHT JOIN dept ON t0.deptno = dept.deptno AND dept.deptno = 1) AS q2;

; SELECT * FROM (SELECT * FROM (SELECT * FROM emp WHERE emp.sal > 0) t0 RIGHT JOIN dept ON t0.deptno = dept.deptno AND dept.deptno = 1) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM emp RIGHT JOIN dept ON emp.deptno = dept.deptno AND emp.sal > 0 AND dept.deptno = 1) AS q1;

;Model soundness: false
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

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_1073192 Int) (BOUND_VARIABLE_1073193 Int)) (> BOUND_VARIABLE_1073192 BOUND_VARIABLE_1073193)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1073223 Int) (BOUND_VARIABLE_1073224 Int)) (= BOUND_VARIABLE_1073223 BOUND_VARIABLE_1073224)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1073223 Int) (BOUND_VARIABLE_1073224 Int)) (= BOUND_VARIABLE_1073223 BOUND_VARIABLE_1073224)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))))) (and (nullable.is_some ((_ tuple.select 9) t)) (not (nullable.val ((_ tuple.select 9) t))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1073223 Int) (BOUND_VARIABLE_1073224 Int)) (= BOUND_VARIABLE_1073223 BOUND_VARIABLE_1073224)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (nullable.is_null ((_ tuple.select 9) t))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1073223 Int) (BOUND_VARIABLE_1073224 Int)) (= BOUND_VARIABLE_1073223 BOUND_VARIABLE_1073224)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1073223 Int) (BOUND_VARIABLE_1073224 Int)) (= BOUND_VARIABLE_1073223 BOUND_VARIABLE_1073224)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))))) (and (nullable.is_some ((_ tuple.select 9) t)) (not (nullable.val ((_ tuple.select 9) t))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1073223 Int) (BOUND_VARIABLE_1073224 Int)) (= BOUND_VARIABLE_1073223 BOUND_VARIABLE_1073224)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (nullable.is_null ((_ tuple.select 9) t))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= leftJoin3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 9) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_1073309 Int) (BOUND_VARIABLE_1073310 Int)) (> BOUND_VARIABLE_1073309 BOUND_VARIABLE_1073310)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1073325 Int) (BOUND_VARIABLE_1073326 Int)) (= BOUND_VARIABLE_1073325 BOUND_VARIABLE_1073326)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1073325 Int) (BOUND_VARIABLE_1073326 Int)) (= BOUND_VARIABLE_1073325 BOUND_VARIABLE_1073326)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1073395 Int) (BOUND_VARIABLE_1073396 Int)) (= BOUND_VARIABLE_1073395 BOUND_VARIABLE_1073396)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1073395 Int) (BOUND_VARIABLE_1073396 Int)) (= BOUND_VARIABLE_1073395 BOUND_VARIABLE_1073396)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))))) (and (nullable.is_some ((_ tuple.select 9) t)) (not (nullable.val ((_ tuple.select 9) t))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1073395 Int) (BOUND_VARIABLE_1073396 Int)) (= BOUND_VARIABLE_1073395 BOUND_VARIABLE_1073396)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (nullable.is_null ((_ tuple.select 9) t))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1073395 Int) (BOUND_VARIABLE_1073396 Int)) (= BOUND_VARIABLE_1073395 BOUND_VARIABLE_1073396)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1073395 Int) (BOUND_VARIABLE_1073396 Int)) (= BOUND_VARIABLE_1073395 BOUND_VARIABLE_1073396)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))))) (and (nullable.is_some ((_ tuple.select 9) t)) (not (nullable.val ((_ tuple.select 9) t))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1073395 Int) (BOUND_VARIABLE_1073396 Int)) (= BOUND_VARIABLE_1073395 BOUND_VARIABLE_1073396)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (nullable.is_null ((_ tuple.select 9) t))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= leftJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 9) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 10 11) (bag.union_disjoint (bag.map leftJoin3 (bag.difference_remove (bag.map f0 EMP) ((_ table.project 0 1 2 3 4 5 6 7 8 9) (bag.filter p2 (table.product (bag.map f0 EMP) (bag.map f1 DEPT)))))) (bag.filter p2 (table.product (bag.map f0 EMP) (bag.map f1 DEPT)))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 10 11) (bag.union_disjoint (bag.map leftJoin7 (bag.difference_remove (bag.map f4 EMP) ((_ table.project 0 1 2 3 4 5 6 7 8 9) (bag.filter p6 (table.product (bag.map f4 EMP) ((_ table.project 0 1) (bag.filter p5 DEPT))))))) (bag.filter p6 (table.product (bag.map f4 EMP) ((_ table.project 0 1) (bag.filter p5 DEPT))))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10528 ms.
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
; duration: 350 ms.
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
; duration: 133 ms.
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
; duration: 52 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool))))) (and (nullable.is_some (nullable.some true)) (not (nullable.val (nullable.some true))))) (nullable.some false) (ite (or (nullable.is_null (as nullable.null (Nullable Bool))) (nullable.is_null (nullable.some true))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool))))) (and (nullable.is_some (nullable.some true)) (not (nullable.val (nullable.some true))))) (nullable.some false) (ite (or (nullable.is_null (as nullable.null (Nullable Bool))) (nullable.is_null (nullable.some true))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= q1 (bag.union_disjoint ((_ table.project 0 1) DEPT) ((_ table.project 0 1) (bag.filter p0 DEPT)))))
(assert (= q2 ((_ table.project 0 1) DEPT)))
(check-sat)
;answer: unsat
; duration: 61 ms.
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
; duration: 48 ms.
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
; duration: 10010 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150504 Int) (BOUND_VARIABLE_1150505 Int)) (< BOUND_VARIABLE_1150504 BOUND_VARIABLE_1150505)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150504 Int) (BOUND_VARIABLE_1150505 Int)) (< BOUND_VARIABLE_1150504 BOUND_VARIABLE_1150505)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150511 Int) (BOUND_VARIABLE_1150512 Int)) (< BOUND_VARIABLE_1150511 BOUND_VARIABLE_1150512)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150511 Int) (BOUND_VARIABLE_1150512 Int)) (< BOUND_VARIABLE_1150511 BOUND_VARIABLE_1150512)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150504 Int) (BOUND_VARIABLE_1150505 Int)) (< BOUND_VARIABLE_1150504 BOUND_VARIABLE_1150505)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150511 Int) (BOUND_VARIABLE_1150512 Int)) (< BOUND_VARIABLE_1150511 BOUND_VARIABLE_1150512)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150504 Int) (BOUND_VARIABLE_1150505 Int)) (< BOUND_VARIABLE_1150504 BOUND_VARIABLE_1150505)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150504 Int) (BOUND_VARIABLE_1150505 Int)) (< BOUND_VARIABLE_1150504 BOUND_VARIABLE_1150505)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150511 Int) (BOUND_VARIABLE_1150512 Int)) (< BOUND_VARIABLE_1150511 BOUND_VARIABLE_1150512)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150511 Int) (BOUND_VARIABLE_1150512 Int)) (< BOUND_VARIABLE_1150511 BOUND_VARIABLE_1150512)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150504 Int) (BOUND_VARIABLE_1150505 Int)) (< BOUND_VARIABLE_1150504 BOUND_VARIABLE_1150505)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150511 Int) (BOUND_VARIABLE_1150512 Int)) (< BOUND_VARIABLE_1150511 BOUND_VARIABLE_1150512)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150533 Int) (BOUND_VARIABLE_1150534 Int)) (> BOUND_VARIABLE_1150533 BOUND_VARIABLE_1150534)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150533 Int) (BOUND_VARIABLE_1150534 Int)) (> BOUND_VARIABLE_1150533 BOUND_VARIABLE_1150534)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150539 Int) (BOUND_VARIABLE_1150540 Int)) (> BOUND_VARIABLE_1150539 BOUND_VARIABLE_1150540)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150539 Int) (BOUND_VARIABLE_1150540 Int)) (> BOUND_VARIABLE_1150539 BOUND_VARIABLE_1150540)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150533 Int) (BOUND_VARIABLE_1150534 Int)) (> BOUND_VARIABLE_1150533 BOUND_VARIABLE_1150534)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150539 Int) (BOUND_VARIABLE_1150540 Int)) (> BOUND_VARIABLE_1150539 BOUND_VARIABLE_1150540)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150533 Int) (BOUND_VARIABLE_1150534 Int)) (> BOUND_VARIABLE_1150533 BOUND_VARIABLE_1150534)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150533 Int) (BOUND_VARIABLE_1150534 Int)) (> BOUND_VARIABLE_1150533 BOUND_VARIABLE_1150534)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150539 Int) (BOUND_VARIABLE_1150540 Int)) (> BOUND_VARIABLE_1150539 BOUND_VARIABLE_1150540)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150539 Int) (BOUND_VARIABLE_1150540 Int)) (> BOUND_VARIABLE_1150539 BOUND_VARIABLE_1150540)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150533 Int) (BOUND_VARIABLE_1150534 Int)) (> BOUND_VARIABLE_1150533 BOUND_VARIABLE_1150534)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150539 Int) (BOUND_VARIABLE_1150540 Int)) (> BOUND_VARIABLE_1150539 BOUND_VARIABLE_1150540)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150504 Int) (BOUND_VARIABLE_1150505 Int)) (< BOUND_VARIABLE_1150504 BOUND_VARIABLE_1150505)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150504 Int) (BOUND_VARIABLE_1150505 Int)) (< BOUND_VARIABLE_1150504 BOUND_VARIABLE_1150505)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150511 Int) (BOUND_VARIABLE_1150512 Int)) (< BOUND_VARIABLE_1150511 BOUND_VARIABLE_1150512)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150511 Int) (BOUND_VARIABLE_1150512 Int)) (< BOUND_VARIABLE_1150511 BOUND_VARIABLE_1150512)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150504 Int) (BOUND_VARIABLE_1150505 Int)) (< BOUND_VARIABLE_1150504 BOUND_VARIABLE_1150505)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150511 Int) (BOUND_VARIABLE_1150512 Int)) (< BOUND_VARIABLE_1150511 BOUND_VARIABLE_1150512)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150504 Int) (BOUND_VARIABLE_1150505 Int)) (< BOUND_VARIABLE_1150504 BOUND_VARIABLE_1150505)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150504 Int) (BOUND_VARIABLE_1150505 Int)) (< BOUND_VARIABLE_1150504 BOUND_VARIABLE_1150505)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150511 Int) (BOUND_VARIABLE_1150512 Int)) (< BOUND_VARIABLE_1150511 BOUND_VARIABLE_1150512)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150511 Int) (BOUND_VARIABLE_1150512 Int)) (< BOUND_VARIABLE_1150511 BOUND_VARIABLE_1150512)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150504 Int) (BOUND_VARIABLE_1150505 Int)) (< BOUND_VARIABLE_1150504 BOUND_VARIABLE_1150505)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150511 Int) (BOUND_VARIABLE_1150512 Int)) (< BOUND_VARIABLE_1150511 BOUND_VARIABLE_1150512)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150533 Int) (BOUND_VARIABLE_1150534 Int)) (> BOUND_VARIABLE_1150533 BOUND_VARIABLE_1150534)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150533 Int) (BOUND_VARIABLE_1150534 Int)) (> BOUND_VARIABLE_1150533 BOUND_VARIABLE_1150534)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150539 Int) (BOUND_VARIABLE_1150540 Int)) (> BOUND_VARIABLE_1150539 BOUND_VARIABLE_1150540)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150539 Int) (BOUND_VARIABLE_1150540 Int)) (> BOUND_VARIABLE_1150539 BOUND_VARIABLE_1150540)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150533 Int) (BOUND_VARIABLE_1150534 Int)) (> BOUND_VARIABLE_1150533 BOUND_VARIABLE_1150534)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150539 Int) (BOUND_VARIABLE_1150540 Int)) (> BOUND_VARIABLE_1150539 BOUND_VARIABLE_1150540)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150533 Int) (BOUND_VARIABLE_1150534 Int)) (> BOUND_VARIABLE_1150533 BOUND_VARIABLE_1150534)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150533 Int) (BOUND_VARIABLE_1150534 Int)) (> BOUND_VARIABLE_1150533 BOUND_VARIABLE_1150534)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150539 Int) (BOUND_VARIABLE_1150540 Int)) (> BOUND_VARIABLE_1150539 BOUND_VARIABLE_1150540)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150539 Int) (BOUND_VARIABLE_1150540 Int)) (> BOUND_VARIABLE_1150539 BOUND_VARIABLE_1150540)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150533 Int) (BOUND_VARIABLE_1150534 Int)) (> BOUND_VARIABLE_1150533 BOUND_VARIABLE_1150534)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150539 Int) (BOUND_VARIABLE_1150540 Int)) (> BOUND_VARIABLE_1150539 BOUND_VARIABLE_1150540)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150581 Int) (BOUND_VARIABLE_1150582 Int)) (< BOUND_VARIABLE_1150581 BOUND_VARIABLE_1150582)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150581 Int) (BOUND_VARIABLE_1150582 Int)) (< BOUND_VARIABLE_1150581 BOUND_VARIABLE_1150582)) ((_ tuple.select 0) t) (nullable.some 10)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150587 Int) (BOUND_VARIABLE_1150588 Int)) (> BOUND_VARIABLE_1150587 BOUND_VARIABLE_1150588)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150587 Int) (BOUND_VARIABLE_1150588 Int)) (> BOUND_VARIABLE_1150587 BOUND_VARIABLE_1150588)) ((_ tuple.select 0) t) (nullable.some 20))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150581 Int) (BOUND_VARIABLE_1150582 Int)) (< BOUND_VARIABLE_1150581 BOUND_VARIABLE_1150582)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150581 Int) (BOUND_VARIABLE_1150582 Int)) (< BOUND_VARIABLE_1150581 BOUND_VARIABLE_1150582)) ((_ tuple.select 0) t) (nullable.some 10)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150587 Int) (BOUND_VARIABLE_1150588 Int)) (> BOUND_VARIABLE_1150587 BOUND_VARIABLE_1150588)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150587 Int) (BOUND_VARIABLE_1150588 Int)) (> BOUND_VARIABLE_1150587 BOUND_VARIABLE_1150588)) ((_ tuple.select 0) t) (nullable.some 20))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150614 Int) (BOUND_VARIABLE_1150615 Int)) (< BOUND_VARIABLE_1150614 BOUND_VARIABLE_1150615)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150614 Int) (BOUND_VARIABLE_1150615 Int)) (< BOUND_VARIABLE_1150614 BOUND_VARIABLE_1150615)) ((_ tuple.select 0) t) (nullable.some 10)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150620 Int) (BOUND_VARIABLE_1150621 Int)) (> BOUND_VARIABLE_1150620 BOUND_VARIABLE_1150621)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150620 Int) (BOUND_VARIABLE_1150621 Int)) (> BOUND_VARIABLE_1150620 BOUND_VARIABLE_1150621)) ((_ tuple.select 0) t) (nullable.some 20))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150614 Int) (BOUND_VARIABLE_1150615 Int)) (< BOUND_VARIABLE_1150614 BOUND_VARIABLE_1150615)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150614 Int) (BOUND_VARIABLE_1150615 Int)) (< BOUND_VARIABLE_1150614 BOUND_VARIABLE_1150615)) ((_ tuple.select 0) t) (nullable.some 10)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150620 Int) (BOUND_VARIABLE_1150621 Int)) (> BOUND_VARIABLE_1150620 BOUND_VARIABLE_1150621)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150620 Int) (BOUND_VARIABLE_1150621 Int)) (> BOUND_VARIABLE_1150620 BOUND_VARIABLE_1150621)) ((_ tuple.select 0) t) (nullable.some 20))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150648 Int) (BOUND_VARIABLE_1150649 Int)) (< BOUND_VARIABLE_1150648 BOUND_VARIABLE_1150649)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150648 Int) (BOUND_VARIABLE_1150649 Int)) (< BOUND_VARIABLE_1150648 BOUND_VARIABLE_1150649)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150655 Int) (BOUND_VARIABLE_1150656 Int)) (< BOUND_VARIABLE_1150655 BOUND_VARIABLE_1150656)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150655 Int) (BOUND_VARIABLE_1150656 Int)) (< BOUND_VARIABLE_1150655 BOUND_VARIABLE_1150656)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150648 Int) (BOUND_VARIABLE_1150649 Int)) (< BOUND_VARIABLE_1150648 BOUND_VARIABLE_1150649)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150655 Int) (BOUND_VARIABLE_1150656 Int)) (< BOUND_VARIABLE_1150655 BOUND_VARIABLE_1150656)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150648 Int) (BOUND_VARIABLE_1150649 Int)) (< BOUND_VARIABLE_1150648 BOUND_VARIABLE_1150649)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150648 Int) (BOUND_VARIABLE_1150649 Int)) (< BOUND_VARIABLE_1150648 BOUND_VARIABLE_1150649)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150655 Int) (BOUND_VARIABLE_1150656 Int)) (< BOUND_VARIABLE_1150655 BOUND_VARIABLE_1150656)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150655 Int) (BOUND_VARIABLE_1150656 Int)) (< BOUND_VARIABLE_1150655 BOUND_VARIABLE_1150656)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150648 Int) (BOUND_VARIABLE_1150649 Int)) (< BOUND_VARIABLE_1150648 BOUND_VARIABLE_1150649)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150655 Int) (BOUND_VARIABLE_1150656 Int)) (< BOUND_VARIABLE_1150655 BOUND_VARIABLE_1150656)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150675 Int) (BOUND_VARIABLE_1150676 Int)) (> BOUND_VARIABLE_1150675 BOUND_VARIABLE_1150676)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150675 Int) (BOUND_VARIABLE_1150676 Int)) (> BOUND_VARIABLE_1150675 BOUND_VARIABLE_1150676)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150681 Int) (BOUND_VARIABLE_1150682 Int)) (> BOUND_VARIABLE_1150681 BOUND_VARIABLE_1150682)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150681 Int) (BOUND_VARIABLE_1150682 Int)) (> BOUND_VARIABLE_1150681 BOUND_VARIABLE_1150682)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150675 Int) (BOUND_VARIABLE_1150676 Int)) (> BOUND_VARIABLE_1150675 BOUND_VARIABLE_1150676)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150681 Int) (BOUND_VARIABLE_1150682 Int)) (> BOUND_VARIABLE_1150681 BOUND_VARIABLE_1150682)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150675 Int) (BOUND_VARIABLE_1150676 Int)) (> BOUND_VARIABLE_1150675 BOUND_VARIABLE_1150676)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150675 Int) (BOUND_VARIABLE_1150676 Int)) (> BOUND_VARIABLE_1150675 BOUND_VARIABLE_1150676)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150681 Int) (BOUND_VARIABLE_1150682 Int)) (> BOUND_VARIABLE_1150681 BOUND_VARIABLE_1150682)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150681 Int) (BOUND_VARIABLE_1150682 Int)) (> BOUND_VARIABLE_1150681 BOUND_VARIABLE_1150682)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150675 Int) (BOUND_VARIABLE_1150676 Int)) (> BOUND_VARIABLE_1150675 BOUND_VARIABLE_1150676)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150681 Int) (BOUND_VARIABLE_1150682 Int)) (> BOUND_VARIABLE_1150681 BOUND_VARIABLE_1150682)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150648 Int) (BOUND_VARIABLE_1150649 Int)) (< BOUND_VARIABLE_1150648 BOUND_VARIABLE_1150649)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150648 Int) (BOUND_VARIABLE_1150649 Int)) (< BOUND_VARIABLE_1150648 BOUND_VARIABLE_1150649)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150655 Int) (BOUND_VARIABLE_1150656 Int)) (< BOUND_VARIABLE_1150655 BOUND_VARIABLE_1150656)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150655 Int) (BOUND_VARIABLE_1150656 Int)) (< BOUND_VARIABLE_1150655 BOUND_VARIABLE_1150656)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150648 Int) (BOUND_VARIABLE_1150649 Int)) (< BOUND_VARIABLE_1150648 BOUND_VARIABLE_1150649)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150655 Int) (BOUND_VARIABLE_1150656 Int)) (< BOUND_VARIABLE_1150655 BOUND_VARIABLE_1150656)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150648 Int) (BOUND_VARIABLE_1150649 Int)) (< BOUND_VARIABLE_1150648 BOUND_VARIABLE_1150649)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150648 Int) (BOUND_VARIABLE_1150649 Int)) (< BOUND_VARIABLE_1150648 BOUND_VARIABLE_1150649)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150655 Int) (BOUND_VARIABLE_1150656 Int)) (< BOUND_VARIABLE_1150655 BOUND_VARIABLE_1150656)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150655 Int) (BOUND_VARIABLE_1150656 Int)) (< BOUND_VARIABLE_1150655 BOUND_VARIABLE_1150656)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150648 Int) (BOUND_VARIABLE_1150649 Int)) (< BOUND_VARIABLE_1150648 BOUND_VARIABLE_1150649)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150655 Int) (BOUND_VARIABLE_1150656 Int)) (< BOUND_VARIABLE_1150655 BOUND_VARIABLE_1150656)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150675 Int) (BOUND_VARIABLE_1150676 Int)) (> BOUND_VARIABLE_1150675 BOUND_VARIABLE_1150676)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150675 Int) (BOUND_VARIABLE_1150676 Int)) (> BOUND_VARIABLE_1150675 BOUND_VARIABLE_1150676)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150681 Int) (BOUND_VARIABLE_1150682 Int)) (> BOUND_VARIABLE_1150681 BOUND_VARIABLE_1150682)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150681 Int) (BOUND_VARIABLE_1150682 Int)) (> BOUND_VARIABLE_1150681 BOUND_VARIABLE_1150682)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150675 Int) (BOUND_VARIABLE_1150676 Int)) (> BOUND_VARIABLE_1150675 BOUND_VARIABLE_1150676)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150681 Int) (BOUND_VARIABLE_1150682 Int)) (> BOUND_VARIABLE_1150681 BOUND_VARIABLE_1150682)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150675 Int) (BOUND_VARIABLE_1150676 Int)) (> BOUND_VARIABLE_1150675 BOUND_VARIABLE_1150676)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150675 Int) (BOUND_VARIABLE_1150676 Int)) (> BOUND_VARIABLE_1150675 BOUND_VARIABLE_1150676)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1150681 Int) (BOUND_VARIABLE_1150682 Int)) (> BOUND_VARIABLE_1150681 BOUND_VARIABLE_1150682)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1150681 Int) (BOUND_VARIABLE_1150682 Int)) (> BOUND_VARIABLE_1150681 BOUND_VARIABLE_1150682)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150675 Int) (BOUND_VARIABLE_1150676 Int)) (> BOUND_VARIABLE_1150675 BOUND_VARIABLE_1150676)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1150681 Int) (BOUND_VARIABLE_1150682 Int)) (> BOUND_VARIABLE_1150681 BOUND_VARIABLE_1150682)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p0 (table.product EMP DEPT)))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p3 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)) ((_ table.project 0 1) (bag.filter p2 DEPT)))))))
(check-sat)
;answer: unsat
; duration: 1344 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159363 Int) (BOUND_VARIABLE_1159364 Int)) (> BOUND_VARIABLE_1159363 BOUND_VARIABLE_1159364)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159363 Int) (BOUND_VARIABLE_1159364 Int)) (> BOUND_VARIABLE_1159363 BOUND_VARIABLE_1159364)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159369 Int) (BOUND_VARIABLE_1159370 Int)) (<= BOUND_VARIABLE_1159369 BOUND_VARIABLE_1159370)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159369 Int) (BOUND_VARIABLE_1159370 Int)) (<= BOUND_VARIABLE_1159369 BOUND_VARIABLE_1159370)) ((_ tuple.select 0) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159363 Int) (BOUND_VARIABLE_1159364 Int)) (> BOUND_VARIABLE_1159363 BOUND_VARIABLE_1159364)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159369 Int) (BOUND_VARIABLE_1159370 Int)) (<= BOUND_VARIABLE_1159369 BOUND_VARIABLE_1159370)) ((_ tuple.select 0) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159363 Int) (BOUND_VARIABLE_1159364 Int)) (> BOUND_VARIABLE_1159363 BOUND_VARIABLE_1159364)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159363 Int) (BOUND_VARIABLE_1159364 Int)) (> BOUND_VARIABLE_1159363 BOUND_VARIABLE_1159364)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159369 Int) (BOUND_VARIABLE_1159370 Int)) (<= BOUND_VARIABLE_1159369 BOUND_VARIABLE_1159370)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159369 Int) (BOUND_VARIABLE_1159370 Int)) (<= BOUND_VARIABLE_1159369 BOUND_VARIABLE_1159370)) ((_ tuple.select 0) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159363 Int) (BOUND_VARIABLE_1159364 Int)) (> BOUND_VARIABLE_1159363 BOUND_VARIABLE_1159364)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159369 Int) (BOUND_VARIABLE_1159370 Int)) (<= BOUND_VARIABLE_1159369 BOUND_VARIABLE_1159370)) ((_ tuple.select 0) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159389 Int) (BOUND_VARIABLE_1159390 Int)) (> BOUND_VARIABLE_1159389 BOUND_VARIABLE_1159390)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159389 Int) (BOUND_VARIABLE_1159390 Int)) (> BOUND_VARIABLE_1159389 BOUND_VARIABLE_1159390)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159396 Int) (BOUND_VARIABLE_1159397 Int)) (> BOUND_VARIABLE_1159396 BOUND_VARIABLE_1159397)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159396 Int) (BOUND_VARIABLE_1159397 Int)) (> BOUND_VARIABLE_1159396 BOUND_VARIABLE_1159397)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159389 Int) (BOUND_VARIABLE_1159390 Int)) (> BOUND_VARIABLE_1159389 BOUND_VARIABLE_1159390)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159396 Int) (BOUND_VARIABLE_1159397 Int)) (> BOUND_VARIABLE_1159396 BOUND_VARIABLE_1159397)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159389 Int) (BOUND_VARIABLE_1159390 Int)) (> BOUND_VARIABLE_1159389 BOUND_VARIABLE_1159390)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159389 Int) (BOUND_VARIABLE_1159390 Int)) (> BOUND_VARIABLE_1159389 BOUND_VARIABLE_1159390)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159396 Int) (BOUND_VARIABLE_1159397 Int)) (> BOUND_VARIABLE_1159396 BOUND_VARIABLE_1159397)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159396 Int) (BOUND_VARIABLE_1159397 Int)) (> BOUND_VARIABLE_1159396 BOUND_VARIABLE_1159397)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159389 Int) (BOUND_VARIABLE_1159390 Int)) (> BOUND_VARIABLE_1159389 BOUND_VARIABLE_1159390)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159396 Int) (BOUND_VARIABLE_1159397 Int)) (> BOUND_VARIABLE_1159396 BOUND_VARIABLE_1159397)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159363 Int) (BOUND_VARIABLE_1159364 Int)) (> BOUND_VARIABLE_1159363 BOUND_VARIABLE_1159364)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159363 Int) (BOUND_VARIABLE_1159364 Int)) (> BOUND_VARIABLE_1159363 BOUND_VARIABLE_1159364)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159369 Int) (BOUND_VARIABLE_1159370 Int)) (<= BOUND_VARIABLE_1159369 BOUND_VARIABLE_1159370)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159369 Int) (BOUND_VARIABLE_1159370 Int)) (<= BOUND_VARIABLE_1159369 BOUND_VARIABLE_1159370)) ((_ tuple.select 0) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159363 Int) (BOUND_VARIABLE_1159364 Int)) (> BOUND_VARIABLE_1159363 BOUND_VARIABLE_1159364)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159369 Int) (BOUND_VARIABLE_1159370 Int)) (<= BOUND_VARIABLE_1159369 BOUND_VARIABLE_1159370)) ((_ tuple.select 0) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159363 Int) (BOUND_VARIABLE_1159364 Int)) (> BOUND_VARIABLE_1159363 BOUND_VARIABLE_1159364)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159363 Int) (BOUND_VARIABLE_1159364 Int)) (> BOUND_VARIABLE_1159363 BOUND_VARIABLE_1159364)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159369 Int) (BOUND_VARIABLE_1159370 Int)) (<= BOUND_VARIABLE_1159369 BOUND_VARIABLE_1159370)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159369 Int) (BOUND_VARIABLE_1159370 Int)) (<= BOUND_VARIABLE_1159369 BOUND_VARIABLE_1159370)) ((_ tuple.select 0) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159363 Int) (BOUND_VARIABLE_1159364 Int)) (> BOUND_VARIABLE_1159363 BOUND_VARIABLE_1159364)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159369 Int) (BOUND_VARIABLE_1159370 Int)) (<= BOUND_VARIABLE_1159369 BOUND_VARIABLE_1159370)) ((_ tuple.select 0) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159389 Int) (BOUND_VARIABLE_1159390 Int)) (> BOUND_VARIABLE_1159389 BOUND_VARIABLE_1159390)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159389 Int) (BOUND_VARIABLE_1159390 Int)) (> BOUND_VARIABLE_1159389 BOUND_VARIABLE_1159390)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159396 Int) (BOUND_VARIABLE_1159397 Int)) (> BOUND_VARIABLE_1159396 BOUND_VARIABLE_1159397)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159396 Int) (BOUND_VARIABLE_1159397 Int)) (> BOUND_VARIABLE_1159396 BOUND_VARIABLE_1159397)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159389 Int) (BOUND_VARIABLE_1159390 Int)) (> BOUND_VARIABLE_1159389 BOUND_VARIABLE_1159390)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159396 Int) (BOUND_VARIABLE_1159397 Int)) (> BOUND_VARIABLE_1159396 BOUND_VARIABLE_1159397)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159389 Int) (BOUND_VARIABLE_1159390 Int)) (> BOUND_VARIABLE_1159389 BOUND_VARIABLE_1159390)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159389 Int) (BOUND_VARIABLE_1159390 Int)) (> BOUND_VARIABLE_1159389 BOUND_VARIABLE_1159390)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159396 Int) (BOUND_VARIABLE_1159397 Int)) (> BOUND_VARIABLE_1159396 BOUND_VARIABLE_1159397)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159396 Int) (BOUND_VARIABLE_1159397 Int)) (> BOUND_VARIABLE_1159396 BOUND_VARIABLE_1159397)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159389 Int) (BOUND_VARIABLE_1159390 Int)) (> BOUND_VARIABLE_1159389 BOUND_VARIABLE_1159390)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159396 Int) (BOUND_VARIABLE_1159397 Int)) (> BOUND_VARIABLE_1159396 BOUND_VARIABLE_1159397)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159438 Int) (BOUND_VARIABLE_1159439 Int)) (> BOUND_VARIABLE_1159438 BOUND_VARIABLE_1159439)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159438 Int) (BOUND_VARIABLE_1159439 Int)) (> BOUND_VARIABLE_1159438 BOUND_VARIABLE_1159439)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159444 Int) (BOUND_VARIABLE_1159445 Int)) (<= BOUND_VARIABLE_1159444 BOUND_VARIABLE_1159445)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159444 Int) (BOUND_VARIABLE_1159445 Int)) (<= BOUND_VARIABLE_1159444 BOUND_VARIABLE_1159445)) ((_ tuple.select 0) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159438 Int) (BOUND_VARIABLE_1159439 Int)) (> BOUND_VARIABLE_1159438 BOUND_VARIABLE_1159439)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159444 Int) (BOUND_VARIABLE_1159445 Int)) (<= BOUND_VARIABLE_1159444 BOUND_VARIABLE_1159445)) ((_ tuple.select 0) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159438 Int) (BOUND_VARIABLE_1159439 Int)) (> BOUND_VARIABLE_1159438 BOUND_VARIABLE_1159439)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159438 Int) (BOUND_VARIABLE_1159439 Int)) (> BOUND_VARIABLE_1159438 BOUND_VARIABLE_1159439)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159444 Int) (BOUND_VARIABLE_1159445 Int)) (<= BOUND_VARIABLE_1159444 BOUND_VARIABLE_1159445)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159444 Int) (BOUND_VARIABLE_1159445 Int)) (<= BOUND_VARIABLE_1159444 BOUND_VARIABLE_1159445)) ((_ tuple.select 0) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159438 Int) (BOUND_VARIABLE_1159439 Int)) (> BOUND_VARIABLE_1159438 BOUND_VARIABLE_1159439)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159444 Int) (BOUND_VARIABLE_1159445 Int)) (<= BOUND_VARIABLE_1159444 BOUND_VARIABLE_1159445)) ((_ tuple.select 0) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159464 Int) (BOUND_VARIABLE_1159465 Int)) (> BOUND_VARIABLE_1159464 BOUND_VARIABLE_1159465)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159464 Int) (BOUND_VARIABLE_1159465 Int)) (> BOUND_VARIABLE_1159464 BOUND_VARIABLE_1159465)) ((_ tuple.select 0) t) (nullable.some 20))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159438 Int) (BOUND_VARIABLE_1159439 Int)) (> BOUND_VARIABLE_1159438 BOUND_VARIABLE_1159439)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159438 Int) (BOUND_VARIABLE_1159439 Int)) (> BOUND_VARIABLE_1159438 BOUND_VARIABLE_1159439)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159444 Int) (BOUND_VARIABLE_1159445 Int)) (<= BOUND_VARIABLE_1159444 BOUND_VARIABLE_1159445)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159444 Int) (BOUND_VARIABLE_1159445 Int)) (<= BOUND_VARIABLE_1159444 BOUND_VARIABLE_1159445)) ((_ tuple.select 0) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159438 Int) (BOUND_VARIABLE_1159439 Int)) (> BOUND_VARIABLE_1159438 BOUND_VARIABLE_1159439)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159444 Int) (BOUND_VARIABLE_1159445 Int)) (<= BOUND_VARIABLE_1159444 BOUND_VARIABLE_1159445)) ((_ tuple.select 0) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159438 Int) (BOUND_VARIABLE_1159439 Int)) (> BOUND_VARIABLE_1159438 BOUND_VARIABLE_1159439)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159438 Int) (BOUND_VARIABLE_1159439 Int)) (> BOUND_VARIABLE_1159438 BOUND_VARIABLE_1159439)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159444 Int) (BOUND_VARIABLE_1159445 Int)) (<= BOUND_VARIABLE_1159444 BOUND_VARIABLE_1159445)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159444 Int) (BOUND_VARIABLE_1159445 Int)) (<= BOUND_VARIABLE_1159444 BOUND_VARIABLE_1159445)) ((_ tuple.select 0) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159438 Int) (BOUND_VARIABLE_1159439 Int)) (> BOUND_VARIABLE_1159438 BOUND_VARIABLE_1159439)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159444 Int) (BOUND_VARIABLE_1159445 Int)) (<= BOUND_VARIABLE_1159444 BOUND_VARIABLE_1159445)) ((_ tuple.select 0) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159464 Int) (BOUND_VARIABLE_1159465 Int)) (> BOUND_VARIABLE_1159464 BOUND_VARIABLE_1159465)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159464 Int) (BOUND_VARIABLE_1159465 Int)) (> BOUND_VARIABLE_1159464 BOUND_VARIABLE_1159465)) ((_ tuple.select 0) t) (nullable.some 20))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159492 Int) (BOUND_VARIABLE_1159493 Int)) (> BOUND_VARIABLE_1159492 BOUND_VARIABLE_1159493)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159492 Int) (BOUND_VARIABLE_1159493 Int)) (> BOUND_VARIABLE_1159492 BOUND_VARIABLE_1159493)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159498 Int) (BOUND_VARIABLE_1159499 Int)) (<= BOUND_VARIABLE_1159498 BOUND_VARIABLE_1159499)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159498 Int) (BOUND_VARIABLE_1159499 Int)) (<= BOUND_VARIABLE_1159498 BOUND_VARIABLE_1159499)) ((_ tuple.select 0) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159492 Int) (BOUND_VARIABLE_1159493 Int)) (> BOUND_VARIABLE_1159492 BOUND_VARIABLE_1159493)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159498 Int) (BOUND_VARIABLE_1159499 Int)) (<= BOUND_VARIABLE_1159498 BOUND_VARIABLE_1159499)) ((_ tuple.select 0) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159492 Int) (BOUND_VARIABLE_1159493 Int)) (> BOUND_VARIABLE_1159492 BOUND_VARIABLE_1159493)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159492 Int) (BOUND_VARIABLE_1159493 Int)) (> BOUND_VARIABLE_1159492 BOUND_VARIABLE_1159493)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159498 Int) (BOUND_VARIABLE_1159499 Int)) (<= BOUND_VARIABLE_1159498 BOUND_VARIABLE_1159499)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159498 Int) (BOUND_VARIABLE_1159499 Int)) (<= BOUND_VARIABLE_1159498 BOUND_VARIABLE_1159499)) ((_ tuple.select 0) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159492 Int) (BOUND_VARIABLE_1159493 Int)) (> BOUND_VARIABLE_1159492 BOUND_VARIABLE_1159493)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159498 Int) (BOUND_VARIABLE_1159499 Int)) (<= BOUND_VARIABLE_1159498 BOUND_VARIABLE_1159499)) ((_ tuple.select 0) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159518 Int) (BOUND_VARIABLE_1159519 Int)) (> BOUND_VARIABLE_1159518 BOUND_VARIABLE_1159519)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159518 Int) (BOUND_VARIABLE_1159519 Int)) (> BOUND_VARIABLE_1159518 BOUND_VARIABLE_1159519)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159525 Int) (BOUND_VARIABLE_1159526 Int)) (> BOUND_VARIABLE_1159525 BOUND_VARIABLE_1159526)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159525 Int) (BOUND_VARIABLE_1159526 Int)) (> BOUND_VARIABLE_1159525 BOUND_VARIABLE_1159526)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159518 Int) (BOUND_VARIABLE_1159519 Int)) (> BOUND_VARIABLE_1159518 BOUND_VARIABLE_1159519)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159525 Int) (BOUND_VARIABLE_1159526 Int)) (> BOUND_VARIABLE_1159525 BOUND_VARIABLE_1159526)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159518 Int) (BOUND_VARIABLE_1159519 Int)) (> BOUND_VARIABLE_1159518 BOUND_VARIABLE_1159519)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159518 Int) (BOUND_VARIABLE_1159519 Int)) (> BOUND_VARIABLE_1159518 BOUND_VARIABLE_1159519)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159525 Int) (BOUND_VARIABLE_1159526 Int)) (> BOUND_VARIABLE_1159525 BOUND_VARIABLE_1159526)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159525 Int) (BOUND_VARIABLE_1159526 Int)) (> BOUND_VARIABLE_1159525 BOUND_VARIABLE_1159526)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159518 Int) (BOUND_VARIABLE_1159519 Int)) (> BOUND_VARIABLE_1159518 BOUND_VARIABLE_1159519)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159525 Int) (BOUND_VARIABLE_1159526 Int)) (> BOUND_VARIABLE_1159525 BOUND_VARIABLE_1159526)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159492 Int) (BOUND_VARIABLE_1159493 Int)) (> BOUND_VARIABLE_1159492 BOUND_VARIABLE_1159493)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159492 Int) (BOUND_VARIABLE_1159493 Int)) (> BOUND_VARIABLE_1159492 BOUND_VARIABLE_1159493)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159498 Int) (BOUND_VARIABLE_1159499 Int)) (<= BOUND_VARIABLE_1159498 BOUND_VARIABLE_1159499)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159498 Int) (BOUND_VARIABLE_1159499 Int)) (<= BOUND_VARIABLE_1159498 BOUND_VARIABLE_1159499)) ((_ tuple.select 0) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159492 Int) (BOUND_VARIABLE_1159493 Int)) (> BOUND_VARIABLE_1159492 BOUND_VARIABLE_1159493)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159498 Int) (BOUND_VARIABLE_1159499 Int)) (<= BOUND_VARIABLE_1159498 BOUND_VARIABLE_1159499)) ((_ tuple.select 0) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159492 Int) (BOUND_VARIABLE_1159493 Int)) (> BOUND_VARIABLE_1159492 BOUND_VARIABLE_1159493)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159492 Int) (BOUND_VARIABLE_1159493 Int)) (> BOUND_VARIABLE_1159492 BOUND_VARIABLE_1159493)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159498 Int) (BOUND_VARIABLE_1159499 Int)) (<= BOUND_VARIABLE_1159498 BOUND_VARIABLE_1159499)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159498 Int) (BOUND_VARIABLE_1159499 Int)) (<= BOUND_VARIABLE_1159498 BOUND_VARIABLE_1159499)) ((_ tuple.select 0) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159492 Int) (BOUND_VARIABLE_1159493 Int)) (> BOUND_VARIABLE_1159492 BOUND_VARIABLE_1159493)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159498 Int) (BOUND_VARIABLE_1159499 Int)) (<= BOUND_VARIABLE_1159498 BOUND_VARIABLE_1159499)) ((_ tuple.select 0) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159518 Int) (BOUND_VARIABLE_1159519 Int)) (> BOUND_VARIABLE_1159518 BOUND_VARIABLE_1159519)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159518 Int) (BOUND_VARIABLE_1159519 Int)) (> BOUND_VARIABLE_1159518 BOUND_VARIABLE_1159519)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159525 Int) (BOUND_VARIABLE_1159526 Int)) (> BOUND_VARIABLE_1159525 BOUND_VARIABLE_1159526)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159525 Int) (BOUND_VARIABLE_1159526 Int)) (> BOUND_VARIABLE_1159525 BOUND_VARIABLE_1159526)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159518 Int) (BOUND_VARIABLE_1159519 Int)) (> BOUND_VARIABLE_1159518 BOUND_VARIABLE_1159519)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159525 Int) (BOUND_VARIABLE_1159526 Int)) (> BOUND_VARIABLE_1159525 BOUND_VARIABLE_1159526)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159518 Int) (BOUND_VARIABLE_1159519 Int)) (> BOUND_VARIABLE_1159518 BOUND_VARIABLE_1159519)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159518 Int) (BOUND_VARIABLE_1159519 Int)) (> BOUND_VARIABLE_1159518 BOUND_VARIABLE_1159519)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1159525 Int) (BOUND_VARIABLE_1159526 Int)) (> BOUND_VARIABLE_1159525 BOUND_VARIABLE_1159526)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1159525 Int) (BOUND_VARIABLE_1159526 Int)) (> BOUND_VARIABLE_1159525 BOUND_VARIABLE_1159526)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159518 Int) (BOUND_VARIABLE_1159519 Int)) (> BOUND_VARIABLE_1159518 BOUND_VARIABLE_1159519)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1159525 Int) (BOUND_VARIABLE_1159526 Int)) (> BOUND_VARIABLE_1159525 BOUND_VARIABLE_1159526)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p0 (table.product EMP DEPT)))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p2 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)) DEPT)))))
(check-sat)
;answer: unsat
; duration: 998 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167284 Int) (BOUND_VARIABLE_1167285 Int)) (< BOUND_VARIABLE_1167284 BOUND_VARIABLE_1167285)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167284 Int) (BOUND_VARIABLE_1167285 Int)) (< BOUND_VARIABLE_1167284 BOUND_VARIABLE_1167285)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167291 Int) (BOUND_VARIABLE_1167292 Int)) (< BOUND_VARIABLE_1167291 BOUND_VARIABLE_1167292)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167291 Int) (BOUND_VARIABLE_1167292 Int)) (< BOUND_VARIABLE_1167291 BOUND_VARIABLE_1167292)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167284 Int) (BOUND_VARIABLE_1167285 Int)) (< BOUND_VARIABLE_1167284 BOUND_VARIABLE_1167285)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167291 Int) (BOUND_VARIABLE_1167292 Int)) (< BOUND_VARIABLE_1167291 BOUND_VARIABLE_1167292)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167284 Int) (BOUND_VARIABLE_1167285 Int)) (< BOUND_VARIABLE_1167284 BOUND_VARIABLE_1167285)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167284 Int) (BOUND_VARIABLE_1167285 Int)) (< BOUND_VARIABLE_1167284 BOUND_VARIABLE_1167285)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167291 Int) (BOUND_VARIABLE_1167292 Int)) (< BOUND_VARIABLE_1167291 BOUND_VARIABLE_1167292)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167291 Int) (BOUND_VARIABLE_1167292 Int)) (< BOUND_VARIABLE_1167291 BOUND_VARIABLE_1167292)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167284 Int) (BOUND_VARIABLE_1167285 Int)) (< BOUND_VARIABLE_1167284 BOUND_VARIABLE_1167285)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167291 Int) (BOUND_VARIABLE_1167292 Int)) (< BOUND_VARIABLE_1167291 BOUND_VARIABLE_1167292)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167311 Int) (BOUND_VARIABLE_1167312 Int)) (> BOUND_VARIABLE_1167311 BOUND_VARIABLE_1167312)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167311 Int) (BOUND_VARIABLE_1167312 Int)) (> BOUND_VARIABLE_1167311 BOUND_VARIABLE_1167312)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167317 Int) (BOUND_VARIABLE_1167318 Int)) (> BOUND_VARIABLE_1167317 BOUND_VARIABLE_1167318)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167317 Int) (BOUND_VARIABLE_1167318 Int)) (> BOUND_VARIABLE_1167317 BOUND_VARIABLE_1167318)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167311 Int) (BOUND_VARIABLE_1167312 Int)) (> BOUND_VARIABLE_1167311 BOUND_VARIABLE_1167312)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167317 Int) (BOUND_VARIABLE_1167318 Int)) (> BOUND_VARIABLE_1167317 BOUND_VARIABLE_1167318)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167311 Int) (BOUND_VARIABLE_1167312 Int)) (> BOUND_VARIABLE_1167311 BOUND_VARIABLE_1167312)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167311 Int) (BOUND_VARIABLE_1167312 Int)) (> BOUND_VARIABLE_1167311 BOUND_VARIABLE_1167312)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167317 Int) (BOUND_VARIABLE_1167318 Int)) (> BOUND_VARIABLE_1167317 BOUND_VARIABLE_1167318)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167317 Int) (BOUND_VARIABLE_1167318 Int)) (> BOUND_VARIABLE_1167317 BOUND_VARIABLE_1167318)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167311 Int) (BOUND_VARIABLE_1167312 Int)) (> BOUND_VARIABLE_1167311 BOUND_VARIABLE_1167312)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167317 Int) (BOUND_VARIABLE_1167318 Int)) (> BOUND_VARIABLE_1167317 BOUND_VARIABLE_1167318)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167284 Int) (BOUND_VARIABLE_1167285 Int)) (< BOUND_VARIABLE_1167284 BOUND_VARIABLE_1167285)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167284 Int) (BOUND_VARIABLE_1167285 Int)) (< BOUND_VARIABLE_1167284 BOUND_VARIABLE_1167285)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167291 Int) (BOUND_VARIABLE_1167292 Int)) (< BOUND_VARIABLE_1167291 BOUND_VARIABLE_1167292)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167291 Int) (BOUND_VARIABLE_1167292 Int)) (< BOUND_VARIABLE_1167291 BOUND_VARIABLE_1167292)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167284 Int) (BOUND_VARIABLE_1167285 Int)) (< BOUND_VARIABLE_1167284 BOUND_VARIABLE_1167285)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167291 Int) (BOUND_VARIABLE_1167292 Int)) (< BOUND_VARIABLE_1167291 BOUND_VARIABLE_1167292)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167284 Int) (BOUND_VARIABLE_1167285 Int)) (< BOUND_VARIABLE_1167284 BOUND_VARIABLE_1167285)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167284 Int) (BOUND_VARIABLE_1167285 Int)) (< BOUND_VARIABLE_1167284 BOUND_VARIABLE_1167285)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167291 Int) (BOUND_VARIABLE_1167292 Int)) (< BOUND_VARIABLE_1167291 BOUND_VARIABLE_1167292)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167291 Int) (BOUND_VARIABLE_1167292 Int)) (< BOUND_VARIABLE_1167291 BOUND_VARIABLE_1167292)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167284 Int) (BOUND_VARIABLE_1167285 Int)) (< BOUND_VARIABLE_1167284 BOUND_VARIABLE_1167285)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167291 Int) (BOUND_VARIABLE_1167292 Int)) (< BOUND_VARIABLE_1167291 BOUND_VARIABLE_1167292)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167311 Int) (BOUND_VARIABLE_1167312 Int)) (> BOUND_VARIABLE_1167311 BOUND_VARIABLE_1167312)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167311 Int) (BOUND_VARIABLE_1167312 Int)) (> BOUND_VARIABLE_1167311 BOUND_VARIABLE_1167312)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167317 Int) (BOUND_VARIABLE_1167318 Int)) (> BOUND_VARIABLE_1167317 BOUND_VARIABLE_1167318)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167317 Int) (BOUND_VARIABLE_1167318 Int)) (> BOUND_VARIABLE_1167317 BOUND_VARIABLE_1167318)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167311 Int) (BOUND_VARIABLE_1167312 Int)) (> BOUND_VARIABLE_1167311 BOUND_VARIABLE_1167312)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167317 Int) (BOUND_VARIABLE_1167318 Int)) (> BOUND_VARIABLE_1167317 BOUND_VARIABLE_1167318)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167311 Int) (BOUND_VARIABLE_1167312 Int)) (> BOUND_VARIABLE_1167311 BOUND_VARIABLE_1167312)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167311 Int) (BOUND_VARIABLE_1167312 Int)) (> BOUND_VARIABLE_1167311 BOUND_VARIABLE_1167312)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167317 Int) (BOUND_VARIABLE_1167318 Int)) (> BOUND_VARIABLE_1167317 BOUND_VARIABLE_1167318)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167317 Int) (BOUND_VARIABLE_1167318 Int)) (> BOUND_VARIABLE_1167317 BOUND_VARIABLE_1167318)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167311 Int) (BOUND_VARIABLE_1167312 Int)) (> BOUND_VARIABLE_1167311 BOUND_VARIABLE_1167312)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167317 Int) (BOUND_VARIABLE_1167318 Int)) (> BOUND_VARIABLE_1167317 BOUND_VARIABLE_1167318)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167392 Int) (BOUND_VARIABLE_1167393 Int)) (< BOUND_VARIABLE_1167392 BOUND_VARIABLE_1167393)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167392 Int) (BOUND_VARIABLE_1167393 Int)) (< BOUND_VARIABLE_1167392 BOUND_VARIABLE_1167393)) ((_ tuple.select 0) t) (nullable.some 10)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167398 Int) (BOUND_VARIABLE_1167399 Int)) (> BOUND_VARIABLE_1167398 BOUND_VARIABLE_1167399)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167398 Int) (BOUND_VARIABLE_1167399 Int)) (> BOUND_VARIABLE_1167398 BOUND_VARIABLE_1167399)) ((_ tuple.select 0) t) (nullable.some 20))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167392 Int) (BOUND_VARIABLE_1167393 Int)) (< BOUND_VARIABLE_1167392 BOUND_VARIABLE_1167393)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167392 Int) (BOUND_VARIABLE_1167393 Int)) (< BOUND_VARIABLE_1167392 BOUND_VARIABLE_1167393)) ((_ tuple.select 0) t) (nullable.some 10)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167398 Int) (BOUND_VARIABLE_1167399 Int)) (> BOUND_VARIABLE_1167398 BOUND_VARIABLE_1167399)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167398 Int) (BOUND_VARIABLE_1167399 Int)) (> BOUND_VARIABLE_1167398 BOUND_VARIABLE_1167399)) ((_ tuple.select 0) t) (nullable.some 20))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167426 Int) (BOUND_VARIABLE_1167427 Int)) (< BOUND_VARIABLE_1167426 BOUND_VARIABLE_1167427)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167426 Int) (BOUND_VARIABLE_1167427 Int)) (< BOUND_VARIABLE_1167426 BOUND_VARIABLE_1167427)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167433 Int) (BOUND_VARIABLE_1167434 Int)) (< BOUND_VARIABLE_1167433 BOUND_VARIABLE_1167434)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167433 Int) (BOUND_VARIABLE_1167434 Int)) (< BOUND_VARIABLE_1167433 BOUND_VARIABLE_1167434)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167426 Int) (BOUND_VARIABLE_1167427 Int)) (< BOUND_VARIABLE_1167426 BOUND_VARIABLE_1167427)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167433 Int) (BOUND_VARIABLE_1167434 Int)) (< BOUND_VARIABLE_1167433 BOUND_VARIABLE_1167434)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167426 Int) (BOUND_VARIABLE_1167427 Int)) (< BOUND_VARIABLE_1167426 BOUND_VARIABLE_1167427)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167426 Int) (BOUND_VARIABLE_1167427 Int)) (< BOUND_VARIABLE_1167426 BOUND_VARIABLE_1167427)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167433 Int) (BOUND_VARIABLE_1167434 Int)) (< BOUND_VARIABLE_1167433 BOUND_VARIABLE_1167434)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167433 Int) (BOUND_VARIABLE_1167434 Int)) (< BOUND_VARIABLE_1167433 BOUND_VARIABLE_1167434)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167426 Int) (BOUND_VARIABLE_1167427 Int)) (< BOUND_VARIABLE_1167426 BOUND_VARIABLE_1167427)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167433 Int) (BOUND_VARIABLE_1167434 Int)) (< BOUND_VARIABLE_1167433 BOUND_VARIABLE_1167434)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167453 Int) (BOUND_VARIABLE_1167454 Int)) (> BOUND_VARIABLE_1167453 BOUND_VARIABLE_1167454)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167453 Int) (BOUND_VARIABLE_1167454 Int)) (> BOUND_VARIABLE_1167453 BOUND_VARIABLE_1167454)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167459 Int) (BOUND_VARIABLE_1167460 Int)) (> BOUND_VARIABLE_1167459 BOUND_VARIABLE_1167460)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167459 Int) (BOUND_VARIABLE_1167460 Int)) (> BOUND_VARIABLE_1167459 BOUND_VARIABLE_1167460)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167453 Int) (BOUND_VARIABLE_1167454 Int)) (> BOUND_VARIABLE_1167453 BOUND_VARIABLE_1167454)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167459 Int) (BOUND_VARIABLE_1167460 Int)) (> BOUND_VARIABLE_1167459 BOUND_VARIABLE_1167460)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167453 Int) (BOUND_VARIABLE_1167454 Int)) (> BOUND_VARIABLE_1167453 BOUND_VARIABLE_1167454)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167453 Int) (BOUND_VARIABLE_1167454 Int)) (> BOUND_VARIABLE_1167453 BOUND_VARIABLE_1167454)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167459 Int) (BOUND_VARIABLE_1167460 Int)) (> BOUND_VARIABLE_1167459 BOUND_VARIABLE_1167460)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167459 Int) (BOUND_VARIABLE_1167460 Int)) (> BOUND_VARIABLE_1167459 BOUND_VARIABLE_1167460)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167453 Int) (BOUND_VARIABLE_1167454 Int)) (> BOUND_VARIABLE_1167453 BOUND_VARIABLE_1167454)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167459 Int) (BOUND_VARIABLE_1167460 Int)) (> BOUND_VARIABLE_1167459 BOUND_VARIABLE_1167460)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167426 Int) (BOUND_VARIABLE_1167427 Int)) (< BOUND_VARIABLE_1167426 BOUND_VARIABLE_1167427)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167426 Int) (BOUND_VARIABLE_1167427 Int)) (< BOUND_VARIABLE_1167426 BOUND_VARIABLE_1167427)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167433 Int) (BOUND_VARIABLE_1167434 Int)) (< BOUND_VARIABLE_1167433 BOUND_VARIABLE_1167434)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167433 Int) (BOUND_VARIABLE_1167434 Int)) (< BOUND_VARIABLE_1167433 BOUND_VARIABLE_1167434)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167426 Int) (BOUND_VARIABLE_1167427 Int)) (< BOUND_VARIABLE_1167426 BOUND_VARIABLE_1167427)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167433 Int) (BOUND_VARIABLE_1167434 Int)) (< BOUND_VARIABLE_1167433 BOUND_VARIABLE_1167434)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167426 Int) (BOUND_VARIABLE_1167427 Int)) (< BOUND_VARIABLE_1167426 BOUND_VARIABLE_1167427)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167426 Int) (BOUND_VARIABLE_1167427 Int)) (< BOUND_VARIABLE_1167426 BOUND_VARIABLE_1167427)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167433 Int) (BOUND_VARIABLE_1167434 Int)) (< BOUND_VARIABLE_1167433 BOUND_VARIABLE_1167434)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167433 Int) (BOUND_VARIABLE_1167434 Int)) (< BOUND_VARIABLE_1167433 BOUND_VARIABLE_1167434)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167426 Int) (BOUND_VARIABLE_1167427 Int)) (< BOUND_VARIABLE_1167426 BOUND_VARIABLE_1167427)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167433 Int) (BOUND_VARIABLE_1167434 Int)) (< BOUND_VARIABLE_1167433 BOUND_VARIABLE_1167434)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167453 Int) (BOUND_VARIABLE_1167454 Int)) (> BOUND_VARIABLE_1167453 BOUND_VARIABLE_1167454)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167453 Int) (BOUND_VARIABLE_1167454 Int)) (> BOUND_VARIABLE_1167453 BOUND_VARIABLE_1167454)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167459 Int) (BOUND_VARIABLE_1167460 Int)) (> BOUND_VARIABLE_1167459 BOUND_VARIABLE_1167460)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167459 Int) (BOUND_VARIABLE_1167460 Int)) (> BOUND_VARIABLE_1167459 BOUND_VARIABLE_1167460)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167453 Int) (BOUND_VARIABLE_1167454 Int)) (> BOUND_VARIABLE_1167453 BOUND_VARIABLE_1167454)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167459 Int) (BOUND_VARIABLE_1167460 Int)) (> BOUND_VARIABLE_1167459 BOUND_VARIABLE_1167460)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167453 Int) (BOUND_VARIABLE_1167454 Int)) (> BOUND_VARIABLE_1167453 BOUND_VARIABLE_1167454)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167453 Int) (BOUND_VARIABLE_1167454 Int)) (> BOUND_VARIABLE_1167453 BOUND_VARIABLE_1167454)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1167459 Int) (BOUND_VARIABLE_1167460 Int)) (> BOUND_VARIABLE_1167459 BOUND_VARIABLE_1167460)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1167459 Int) (BOUND_VARIABLE_1167460 Int)) (> BOUND_VARIABLE_1167459 BOUND_VARIABLE_1167460)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167453 Int) (BOUND_VARIABLE_1167454 Int)) (> BOUND_VARIABLE_1167453 BOUND_VARIABLE_1167454)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1167459 Int) (BOUND_VARIABLE_1167460 Int)) (> BOUND_VARIABLE_1167459 BOUND_VARIABLE_1167460)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= leftJoin4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map leftJoin1 (bag.difference_remove EMP ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 (table.product EMP DEPT))))) (bag.filter p0 (table.product EMP DEPT))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map leftJoin4 (bag.difference_remove EMP ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p3 (table.product EMP ((_ table.project 0 1) (bag.filter p2 DEPT))))))) (bag.filter p3 (table.product EMP ((_ table.project 0 1) (bag.filter p2 DEPT))))))))
(check-sat)
;answer: unsat
; duration: 4475 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186512 Int) (BOUND_VARIABLE_1186513 Int)) (< BOUND_VARIABLE_1186512 BOUND_VARIABLE_1186513)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186512 Int) (BOUND_VARIABLE_1186513 Int)) (< BOUND_VARIABLE_1186512 BOUND_VARIABLE_1186513)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186519 Int) (BOUND_VARIABLE_1186520 Int)) (< BOUND_VARIABLE_1186519 BOUND_VARIABLE_1186520)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186519 Int) (BOUND_VARIABLE_1186520 Int)) (< BOUND_VARIABLE_1186519 BOUND_VARIABLE_1186520)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186512 Int) (BOUND_VARIABLE_1186513 Int)) (< BOUND_VARIABLE_1186512 BOUND_VARIABLE_1186513)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186519 Int) (BOUND_VARIABLE_1186520 Int)) (< BOUND_VARIABLE_1186519 BOUND_VARIABLE_1186520)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186512 Int) (BOUND_VARIABLE_1186513 Int)) (< BOUND_VARIABLE_1186512 BOUND_VARIABLE_1186513)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186512 Int) (BOUND_VARIABLE_1186513 Int)) (< BOUND_VARIABLE_1186512 BOUND_VARIABLE_1186513)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186519 Int) (BOUND_VARIABLE_1186520 Int)) (< BOUND_VARIABLE_1186519 BOUND_VARIABLE_1186520)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186519 Int) (BOUND_VARIABLE_1186520 Int)) (< BOUND_VARIABLE_1186519 BOUND_VARIABLE_1186520)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186512 Int) (BOUND_VARIABLE_1186513 Int)) (< BOUND_VARIABLE_1186512 BOUND_VARIABLE_1186513)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186519 Int) (BOUND_VARIABLE_1186520 Int)) (< BOUND_VARIABLE_1186519 BOUND_VARIABLE_1186520)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186539 Int) (BOUND_VARIABLE_1186540 Int)) (> BOUND_VARIABLE_1186539 BOUND_VARIABLE_1186540)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186539 Int) (BOUND_VARIABLE_1186540 Int)) (> BOUND_VARIABLE_1186539 BOUND_VARIABLE_1186540)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186545 Int) (BOUND_VARIABLE_1186546 Int)) (> BOUND_VARIABLE_1186545 BOUND_VARIABLE_1186546)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186545 Int) (BOUND_VARIABLE_1186546 Int)) (> BOUND_VARIABLE_1186545 BOUND_VARIABLE_1186546)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186539 Int) (BOUND_VARIABLE_1186540 Int)) (> BOUND_VARIABLE_1186539 BOUND_VARIABLE_1186540)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186545 Int) (BOUND_VARIABLE_1186546 Int)) (> BOUND_VARIABLE_1186545 BOUND_VARIABLE_1186546)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186539 Int) (BOUND_VARIABLE_1186540 Int)) (> BOUND_VARIABLE_1186539 BOUND_VARIABLE_1186540)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186539 Int) (BOUND_VARIABLE_1186540 Int)) (> BOUND_VARIABLE_1186539 BOUND_VARIABLE_1186540)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186545 Int) (BOUND_VARIABLE_1186546 Int)) (> BOUND_VARIABLE_1186545 BOUND_VARIABLE_1186546)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186545 Int) (BOUND_VARIABLE_1186546 Int)) (> BOUND_VARIABLE_1186545 BOUND_VARIABLE_1186546)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186539 Int) (BOUND_VARIABLE_1186540 Int)) (> BOUND_VARIABLE_1186539 BOUND_VARIABLE_1186540)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186545 Int) (BOUND_VARIABLE_1186546 Int)) (> BOUND_VARIABLE_1186545 BOUND_VARIABLE_1186546)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186512 Int) (BOUND_VARIABLE_1186513 Int)) (< BOUND_VARIABLE_1186512 BOUND_VARIABLE_1186513)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186512 Int) (BOUND_VARIABLE_1186513 Int)) (< BOUND_VARIABLE_1186512 BOUND_VARIABLE_1186513)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186519 Int) (BOUND_VARIABLE_1186520 Int)) (< BOUND_VARIABLE_1186519 BOUND_VARIABLE_1186520)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186519 Int) (BOUND_VARIABLE_1186520 Int)) (< BOUND_VARIABLE_1186519 BOUND_VARIABLE_1186520)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186512 Int) (BOUND_VARIABLE_1186513 Int)) (< BOUND_VARIABLE_1186512 BOUND_VARIABLE_1186513)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186519 Int) (BOUND_VARIABLE_1186520 Int)) (< BOUND_VARIABLE_1186519 BOUND_VARIABLE_1186520)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186512 Int) (BOUND_VARIABLE_1186513 Int)) (< BOUND_VARIABLE_1186512 BOUND_VARIABLE_1186513)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186512 Int) (BOUND_VARIABLE_1186513 Int)) (< BOUND_VARIABLE_1186512 BOUND_VARIABLE_1186513)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186519 Int) (BOUND_VARIABLE_1186520 Int)) (< BOUND_VARIABLE_1186519 BOUND_VARIABLE_1186520)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186519 Int) (BOUND_VARIABLE_1186520 Int)) (< BOUND_VARIABLE_1186519 BOUND_VARIABLE_1186520)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186512 Int) (BOUND_VARIABLE_1186513 Int)) (< BOUND_VARIABLE_1186512 BOUND_VARIABLE_1186513)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186519 Int) (BOUND_VARIABLE_1186520 Int)) (< BOUND_VARIABLE_1186519 BOUND_VARIABLE_1186520)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186539 Int) (BOUND_VARIABLE_1186540 Int)) (> BOUND_VARIABLE_1186539 BOUND_VARIABLE_1186540)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186539 Int) (BOUND_VARIABLE_1186540 Int)) (> BOUND_VARIABLE_1186539 BOUND_VARIABLE_1186540)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186545 Int) (BOUND_VARIABLE_1186546 Int)) (> BOUND_VARIABLE_1186545 BOUND_VARIABLE_1186546)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186545 Int) (BOUND_VARIABLE_1186546 Int)) (> BOUND_VARIABLE_1186545 BOUND_VARIABLE_1186546)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186539 Int) (BOUND_VARIABLE_1186540 Int)) (> BOUND_VARIABLE_1186539 BOUND_VARIABLE_1186540)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186545 Int) (BOUND_VARIABLE_1186546 Int)) (> BOUND_VARIABLE_1186545 BOUND_VARIABLE_1186546)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186539 Int) (BOUND_VARIABLE_1186540 Int)) (> BOUND_VARIABLE_1186539 BOUND_VARIABLE_1186540)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186539 Int) (BOUND_VARIABLE_1186540 Int)) (> BOUND_VARIABLE_1186539 BOUND_VARIABLE_1186540)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186545 Int) (BOUND_VARIABLE_1186546 Int)) (> BOUND_VARIABLE_1186545 BOUND_VARIABLE_1186546)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186545 Int) (BOUND_VARIABLE_1186546 Int)) (> BOUND_VARIABLE_1186545 BOUND_VARIABLE_1186546)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186539 Int) (BOUND_VARIABLE_1186540 Int)) (> BOUND_VARIABLE_1186539 BOUND_VARIABLE_1186540)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186545 Int) (BOUND_VARIABLE_1186546 Int)) (> BOUND_VARIABLE_1186545 BOUND_VARIABLE_1186546)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= rightJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186613 Int) (BOUND_VARIABLE_1186614 Int)) (< BOUND_VARIABLE_1186613 BOUND_VARIABLE_1186614)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186613 Int) (BOUND_VARIABLE_1186614 Int)) (< BOUND_VARIABLE_1186613 BOUND_VARIABLE_1186614)) ((_ tuple.select 0) t) (nullable.some 10)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186619 Int) (BOUND_VARIABLE_1186620 Int)) (> BOUND_VARIABLE_1186619 BOUND_VARIABLE_1186620)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186619 Int) (BOUND_VARIABLE_1186620 Int)) (> BOUND_VARIABLE_1186619 BOUND_VARIABLE_1186620)) ((_ tuple.select 0) t) (nullable.some 20))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186613 Int) (BOUND_VARIABLE_1186614 Int)) (< BOUND_VARIABLE_1186613 BOUND_VARIABLE_1186614)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186613 Int) (BOUND_VARIABLE_1186614 Int)) (< BOUND_VARIABLE_1186613 BOUND_VARIABLE_1186614)) ((_ tuple.select 0) t) (nullable.some 10)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186619 Int) (BOUND_VARIABLE_1186620 Int)) (> BOUND_VARIABLE_1186619 BOUND_VARIABLE_1186620)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186619 Int) (BOUND_VARIABLE_1186620 Int)) (> BOUND_VARIABLE_1186619 BOUND_VARIABLE_1186620)) ((_ tuple.select 0) t) (nullable.some 20))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186647 Int) (BOUND_VARIABLE_1186648 Int)) (< BOUND_VARIABLE_1186647 BOUND_VARIABLE_1186648)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186647 Int) (BOUND_VARIABLE_1186648 Int)) (< BOUND_VARIABLE_1186647 BOUND_VARIABLE_1186648)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186654 Int) (BOUND_VARIABLE_1186655 Int)) (< BOUND_VARIABLE_1186654 BOUND_VARIABLE_1186655)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186654 Int) (BOUND_VARIABLE_1186655 Int)) (< BOUND_VARIABLE_1186654 BOUND_VARIABLE_1186655)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186647 Int) (BOUND_VARIABLE_1186648 Int)) (< BOUND_VARIABLE_1186647 BOUND_VARIABLE_1186648)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186654 Int) (BOUND_VARIABLE_1186655 Int)) (< BOUND_VARIABLE_1186654 BOUND_VARIABLE_1186655)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186647 Int) (BOUND_VARIABLE_1186648 Int)) (< BOUND_VARIABLE_1186647 BOUND_VARIABLE_1186648)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186647 Int) (BOUND_VARIABLE_1186648 Int)) (< BOUND_VARIABLE_1186647 BOUND_VARIABLE_1186648)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186654 Int) (BOUND_VARIABLE_1186655 Int)) (< BOUND_VARIABLE_1186654 BOUND_VARIABLE_1186655)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186654 Int) (BOUND_VARIABLE_1186655 Int)) (< BOUND_VARIABLE_1186654 BOUND_VARIABLE_1186655)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186647 Int) (BOUND_VARIABLE_1186648 Int)) (< BOUND_VARIABLE_1186647 BOUND_VARIABLE_1186648)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186654 Int) (BOUND_VARIABLE_1186655 Int)) (< BOUND_VARIABLE_1186654 BOUND_VARIABLE_1186655)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186674 Int) (BOUND_VARIABLE_1186675 Int)) (> BOUND_VARIABLE_1186674 BOUND_VARIABLE_1186675)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186674 Int) (BOUND_VARIABLE_1186675 Int)) (> BOUND_VARIABLE_1186674 BOUND_VARIABLE_1186675)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186680 Int) (BOUND_VARIABLE_1186681 Int)) (> BOUND_VARIABLE_1186680 BOUND_VARIABLE_1186681)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186680 Int) (BOUND_VARIABLE_1186681 Int)) (> BOUND_VARIABLE_1186680 BOUND_VARIABLE_1186681)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186674 Int) (BOUND_VARIABLE_1186675 Int)) (> BOUND_VARIABLE_1186674 BOUND_VARIABLE_1186675)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186680 Int) (BOUND_VARIABLE_1186681 Int)) (> BOUND_VARIABLE_1186680 BOUND_VARIABLE_1186681)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186674 Int) (BOUND_VARIABLE_1186675 Int)) (> BOUND_VARIABLE_1186674 BOUND_VARIABLE_1186675)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186674 Int) (BOUND_VARIABLE_1186675 Int)) (> BOUND_VARIABLE_1186674 BOUND_VARIABLE_1186675)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186680 Int) (BOUND_VARIABLE_1186681 Int)) (> BOUND_VARIABLE_1186680 BOUND_VARIABLE_1186681)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186680 Int) (BOUND_VARIABLE_1186681 Int)) (> BOUND_VARIABLE_1186680 BOUND_VARIABLE_1186681)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186674 Int) (BOUND_VARIABLE_1186675 Int)) (> BOUND_VARIABLE_1186674 BOUND_VARIABLE_1186675)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186680 Int) (BOUND_VARIABLE_1186681 Int)) (> BOUND_VARIABLE_1186680 BOUND_VARIABLE_1186681)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186647 Int) (BOUND_VARIABLE_1186648 Int)) (< BOUND_VARIABLE_1186647 BOUND_VARIABLE_1186648)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186647 Int) (BOUND_VARIABLE_1186648 Int)) (< BOUND_VARIABLE_1186647 BOUND_VARIABLE_1186648)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186654 Int) (BOUND_VARIABLE_1186655 Int)) (< BOUND_VARIABLE_1186654 BOUND_VARIABLE_1186655)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186654 Int) (BOUND_VARIABLE_1186655 Int)) (< BOUND_VARIABLE_1186654 BOUND_VARIABLE_1186655)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186647 Int) (BOUND_VARIABLE_1186648 Int)) (< BOUND_VARIABLE_1186647 BOUND_VARIABLE_1186648)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186654 Int) (BOUND_VARIABLE_1186655 Int)) (< BOUND_VARIABLE_1186654 BOUND_VARIABLE_1186655)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186647 Int) (BOUND_VARIABLE_1186648 Int)) (< BOUND_VARIABLE_1186647 BOUND_VARIABLE_1186648)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186647 Int) (BOUND_VARIABLE_1186648 Int)) (< BOUND_VARIABLE_1186647 BOUND_VARIABLE_1186648)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186654 Int) (BOUND_VARIABLE_1186655 Int)) (< BOUND_VARIABLE_1186654 BOUND_VARIABLE_1186655)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186654 Int) (BOUND_VARIABLE_1186655 Int)) (< BOUND_VARIABLE_1186654 BOUND_VARIABLE_1186655)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186647 Int) (BOUND_VARIABLE_1186648 Int)) (< BOUND_VARIABLE_1186647 BOUND_VARIABLE_1186648)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186654 Int) (BOUND_VARIABLE_1186655 Int)) (< BOUND_VARIABLE_1186654 BOUND_VARIABLE_1186655)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186674 Int) (BOUND_VARIABLE_1186675 Int)) (> BOUND_VARIABLE_1186674 BOUND_VARIABLE_1186675)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186674 Int) (BOUND_VARIABLE_1186675 Int)) (> BOUND_VARIABLE_1186674 BOUND_VARIABLE_1186675)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186680 Int) (BOUND_VARIABLE_1186681 Int)) (> BOUND_VARIABLE_1186680 BOUND_VARIABLE_1186681)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186680 Int) (BOUND_VARIABLE_1186681 Int)) (> BOUND_VARIABLE_1186680 BOUND_VARIABLE_1186681)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186674 Int) (BOUND_VARIABLE_1186675 Int)) (> BOUND_VARIABLE_1186674 BOUND_VARIABLE_1186675)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186680 Int) (BOUND_VARIABLE_1186681 Int)) (> BOUND_VARIABLE_1186680 BOUND_VARIABLE_1186681)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186674 Int) (BOUND_VARIABLE_1186675 Int)) (> BOUND_VARIABLE_1186674 BOUND_VARIABLE_1186675)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186674 Int) (BOUND_VARIABLE_1186675 Int)) (> BOUND_VARIABLE_1186674 BOUND_VARIABLE_1186675)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1186680 Int) (BOUND_VARIABLE_1186681 Int)) (> BOUND_VARIABLE_1186680 BOUND_VARIABLE_1186681)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1186680 Int) (BOUND_VARIABLE_1186681 Int)) (> BOUND_VARIABLE_1186680 BOUND_VARIABLE_1186681)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186674 Int) (BOUND_VARIABLE_1186675 Int)) (> BOUND_VARIABLE_1186674 BOUND_VARIABLE_1186675)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1186680 Int) (BOUND_VARIABLE_1186681 Int)) (> BOUND_VARIABLE_1186680 BOUND_VARIABLE_1186681)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= rightJoin4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map rightJoin1 (bag.difference_remove DEPT ((_ table.project 9 10) (bag.filter p0 (table.product EMP DEPT))))) (bag.filter p0 (table.product EMP DEPT))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map rightJoin4 (bag.difference_remove DEPT ((_ table.project 9 10) (bag.filter p3 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)) DEPT))))) (bag.filter p3 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)) DEPT))))))
(check-sat)
;answer: unsat
; duration: 4255 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1205509 Int) (BOUND_VARIABLE_1205510 Int)) (> BOUND_VARIABLE_1205509 BOUND_VARIABLE_1205510)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1205509 Int) (BOUND_VARIABLE_1205510 Int)) (> BOUND_VARIABLE_1205509 BOUND_VARIABLE_1205510)) ((_ tuple.select 0) t) (nullable.some 0)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1205529 Int) (BOUND_VARIABLE_1205530 Int)) (< BOUND_VARIABLE_1205529 BOUND_VARIABLE_1205530)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1205529 Int) (BOUND_VARIABLE_1205530 Int)) (< BOUND_VARIABLE_1205529 BOUND_VARIABLE_1205530)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1205549 Int) (BOUND_VARIABLE_1205550 Int)) (> BOUND_VARIABLE_1205549 BOUND_VARIABLE_1205550)) ((_ tuple.select 0) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1205549 Int) (BOUND_VARIABLE_1205550 Int)) (> BOUND_VARIABLE_1205549 BOUND_VARIABLE_1205550)) ((_ tuple.select 0) t) (nullable.some 0))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1205575 Bool)) (not BOUND_VARIABLE_1205575)) (ite (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1205561 Int) (BOUND_VARIABLE_1205562 Int)) (< BOUND_VARIABLE_1205561 BOUND_VARIABLE_1205562)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1205568 Int) (BOUND_VARIABLE_1205569 Int)) (< BOUND_VARIABLE_1205568 BOUND_VARIABLE_1205569)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some false)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1205575 Bool)) (not BOUND_VARIABLE_1205575)) (ite (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1205561 Int) (BOUND_VARIABLE_1205562 Int)) (< BOUND_VARIABLE_1205561 BOUND_VARIABLE_1205562)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1205568 Int) (BOUND_VARIABLE_1205569 Int)) (< BOUND_VARIABLE_1205568 BOUND_VARIABLE_1205569)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some false))))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1205549 Int) (BOUND_VARIABLE_1205550 Int)) (> BOUND_VARIABLE_1205549 BOUND_VARIABLE_1205550)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1205575 Bool)) (not BOUND_VARIABLE_1205575)) (ite (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1205561 Int) (BOUND_VARIABLE_1205562 Int)) (< BOUND_VARIABLE_1205561 BOUND_VARIABLE_1205562)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1205568 Int) (BOUND_VARIABLE_1205569 Int)) (< BOUND_VARIABLE_1205568 BOUND_VARIABLE_1205569)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some false))))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1205549 Int) (BOUND_VARIABLE_1205550 Int)) (> BOUND_VARIABLE_1205549 BOUND_VARIABLE_1205550)) ((_ tuple.select 0) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1205549 Int) (BOUND_VARIABLE_1205550 Int)) (> BOUND_VARIABLE_1205549 BOUND_VARIABLE_1205550)) ((_ tuple.select 0) t) (nullable.some 0))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1205575 Bool)) (not BOUND_VARIABLE_1205575)) (ite (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1205561 Int) (BOUND_VARIABLE_1205562 Int)) (< BOUND_VARIABLE_1205561 BOUND_VARIABLE_1205562)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1205568 Int) (BOUND_VARIABLE_1205569 Int)) (< BOUND_VARIABLE_1205568 BOUND_VARIABLE_1205569)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some false)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1205575 Bool)) (not BOUND_VARIABLE_1205575)) (ite (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1205561 Int) (BOUND_VARIABLE_1205562 Int)) (< BOUND_VARIABLE_1205561 BOUND_VARIABLE_1205562)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1205568 Int) (BOUND_VARIABLE_1205569 Int)) (< BOUND_VARIABLE_1205568 BOUND_VARIABLE_1205569)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some false))))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1205549 Int) (BOUND_VARIABLE_1205550 Int)) (> BOUND_VARIABLE_1205549 BOUND_VARIABLE_1205550)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1205575 Bool)) (not BOUND_VARIABLE_1205575)) (ite (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1205561 Int) (BOUND_VARIABLE_1205562 Int)) (< BOUND_VARIABLE_1205561 BOUND_VARIABLE_1205562)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_1205568 Int) (BOUND_VARIABLE_1205569 Int)) (< BOUND_VARIABLE_1205568 BOUND_VARIABLE_1205569)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some false))))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= q1 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP)))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p2 EMP)))))
(check-sat)
;answer: unsat
; duration: 593 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool))))) (and (nullable.is_some (nullable.some true)) (not (nullable.val (nullable.some true))))) (nullable.some false) (ite (or (nullable.is_null (as nullable.null (Nullable Bool))) (nullable.is_null (nullable.some true))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool))))) (and (nullable.is_some (nullable.some true)) (not (nullable.val (nullable.some true))))) (nullable.some false) (ite (or (nullable.is_null (as nullable.null (Nullable Bool))) (nullable.is_null (nullable.some true))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) false)))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 97 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1210327 Int) (BOUND_VARIABLE_1210328 Int)) (= BOUND_VARIABLE_1210327 BOUND_VARIABLE_1210328)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1210327 Int) (BOUND_VARIABLE_1210328 Int)) (= BOUND_VARIABLE_1210327 BOUND_VARIABLE_1210328)) ((_ tuple.select 0) t) (nullable.some 0)))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (nullable.val (as nullable.null (Nullable Bool))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1210327 Int) (BOUND_VARIABLE_1210328 Int)) (= BOUND_VARIABLE_1210327 BOUND_VARIABLE_1210328)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1210327 Int) (BOUND_VARIABLE_1210328 Int)) (= BOUND_VARIABLE_1210327 BOUND_VARIABLE_1210328)) ((_ tuple.select 0) t) (nullable.some 0)))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (nullable.val (as nullable.null (Nullable Bool))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1210353 Int) (BOUND_VARIABLE_1210354 Int)) (= BOUND_VARIABLE_1210353 BOUND_VARIABLE_1210354)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1210353 Int) (BOUND_VARIABLE_1210354 Int)) (= BOUND_VARIABLE_1210353 BOUND_VARIABLE_1210354)) ((_ tuple.select 0) t) (nullable.some 0)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false)))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1210353 Int) (BOUND_VARIABLE_1210354 Int)) (= BOUND_VARIABLE_1210353 BOUND_VARIABLE_1210354)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1210353 Int) (BOUND_VARIABLE_1210354 Int)) (= BOUND_VARIABLE_1210353 BOUND_VARIABLE_1210354)) ((_ tuple.select 0) t) (nullable.some 0)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false)))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 134 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1212090 Int) (BOUND_VARIABLE_1212091 Int)) (> BOUND_VARIABLE_1212090 BOUND_VARIABLE_1212091)) ((_ tuple.select 0) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1212090 Int) (BOUND_VARIABLE_1212091 Int)) (> BOUND_VARIABLE_1212090 BOUND_VARIABLE_1212091)) ((_ tuple.select 0) t) (nullable.some 0))))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1212090 Int) (BOUND_VARIABLE_1212091 Int)) (> BOUND_VARIABLE_1212090 BOUND_VARIABLE_1212091)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.is_null (as nullable.null (Nullable Bool)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1212090 Int) (BOUND_VARIABLE_1212091 Int)) (> BOUND_VARIABLE_1212090 BOUND_VARIABLE_1212091)) ((_ tuple.select 0) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1212090 Int) (BOUND_VARIABLE_1212091 Int)) (> BOUND_VARIABLE_1212090 BOUND_VARIABLE_1212091)) ((_ tuple.select 0) t) (nullable.some 0))))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1212090 Int) (BOUND_VARIABLE_1212091 Int)) (> BOUND_VARIABLE_1212090 BOUND_VARIABLE_1212091)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.is_null (as nullable.null (Nullable Bool)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1212118 Int) (BOUND_VARIABLE_1212119 Int)) (> BOUND_VARIABLE_1212118 BOUND_VARIABLE_1212119)) ((_ tuple.select 0) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1212118 Int) (BOUND_VARIABLE_1212119 Int)) (> BOUND_VARIABLE_1212118 BOUND_VARIABLE_1212119)) ((_ tuple.select 0) t) (nullable.some 0))))) (and (nullable.is_some (nullable.some false)) (not (nullable.val (nullable.some false))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1212118 Int) (BOUND_VARIABLE_1212119 Int)) (> BOUND_VARIABLE_1212118 BOUND_VARIABLE_1212119)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.is_null (nullable.some false))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1212118 Int) (BOUND_VARIABLE_1212119 Int)) (> BOUND_VARIABLE_1212118 BOUND_VARIABLE_1212119)) ((_ tuple.select 0) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1212118 Int) (BOUND_VARIABLE_1212119 Int)) (> BOUND_VARIABLE_1212118 BOUND_VARIABLE_1212119)) ((_ tuple.select 0) t) (nullable.some 0))))) (and (nullable.is_some (nullable.some false)) (not (nullable.val (nullable.some false))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_1212118 Int) (BOUND_VARIABLE_1212119 Int)) (> BOUND_VARIABLE_1212118 BOUND_VARIABLE_1212119)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.is_null (nullable.some false))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 79 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1213210 Int) (BOUND_VARIABLE_1213211 Int)) (= BOUND_VARIABLE_1213210 BOUND_VARIABLE_1213211)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.some false) (as nullable.null (Nullable Bool)))) (nullable.val (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1213210 Int) (BOUND_VARIABLE_1213211 Int)) (= BOUND_VARIABLE_1213210 BOUND_VARIABLE_1213211)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.some false) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1213231 Int) (BOUND_VARIABLE_1213232 Int)) (= BOUND_VARIABLE_1213231 BOUND_VARIABLE_1213232)) ((_ tuple.select 0) t) (nullable.some 1))) false false))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 73 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1214201 Int) (BOUND_VARIABLE_1214202 Int)) (= BOUND_VARIABLE_1214201 BOUND_VARIABLE_1214202)) ((_ tuple.select 0) t) (nullable.some 1))) (as nullable.null (Nullable Bool)) (nullable.some true))) (nullable.val (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1214201 Int) (BOUND_VARIABLE_1214202 Int)) (= BOUND_VARIABLE_1214201 BOUND_VARIABLE_1214202)) ((_ tuple.select 0) t) (nullable.some 1))) (as nullable.null (Nullable Bool)) (nullable.some true)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1214222 Int) (BOUND_VARIABLE_1214223 Int)) (= BOUND_VARIABLE_1214222 BOUND_VARIABLE_1214223)) ((_ tuple.select 0) t) (nullable.some 1))) false true))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 203 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1215682 Int) (BOUND_VARIABLE_1215683 Int)) (= BOUND_VARIABLE_1215682 BOUND_VARIABLE_1215683)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1215682 Int) (BOUND_VARIABLE_1215683 Int)) (= BOUND_VARIABLE_1215682 BOUND_VARIABLE_1215683)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (nullable.val (as nullable.null (Nullable Bool))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.lift (lambda ((BOUND_VARIABLE_1215694 Int) (BOUND_VARIABLE_1215695 Int)) (< BOUND_VARIABLE_1215694 BOUND_VARIABLE_1215695)) ((_ tuple.select 6) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1215700 Int) (BOUND_VARIABLE_1215701 Int)) (> BOUND_VARIABLE_1215700 BOUND_VARIABLE_1215701)) ((_ tuple.select 6) t) (nullable.some 10)))) (nullable.val (ite (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1215682 Int) (BOUND_VARIABLE_1215683 Int)) (= BOUND_VARIABLE_1215682 BOUND_VARIABLE_1215683)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1215682 Int) (BOUND_VARIABLE_1215683 Int)) (= BOUND_VARIABLE_1215682 BOUND_VARIABLE_1215683)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (nullable.val (as nullable.null (Nullable Bool))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.lift (lambda ((BOUND_VARIABLE_1215694 Int) (BOUND_VARIABLE_1215695 Int)) (< BOUND_VARIABLE_1215694 BOUND_VARIABLE_1215695)) ((_ tuple.select 6) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1215700 Int) (BOUND_VARIABLE_1215701 Int)) (> BOUND_VARIABLE_1215700 BOUND_VARIABLE_1215701)) ((_ tuple.select 6) t) (nullable.some 10))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1215721 Int) (BOUND_VARIABLE_1215722 Int)) (= BOUND_VARIABLE_1215721 BOUND_VARIABLE_1215722)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1215721 Int) (BOUND_VARIABLE_1215722 Int)) (= BOUND_VARIABLE_1215721 BOUND_VARIABLE_1215722)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false)))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.lift (lambda ((BOUND_VARIABLE_1215733 Int) (BOUND_VARIABLE_1215734 Int)) (< BOUND_VARIABLE_1215733 BOUND_VARIABLE_1215734)) ((_ tuple.select 6) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1215739 Int) (BOUND_VARIABLE_1215740 Int)) (> BOUND_VARIABLE_1215739 BOUND_VARIABLE_1215740)) ((_ tuple.select 6) t) (nullable.some 10)))) (nullable.val (ite (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1215721 Int) (BOUND_VARIABLE_1215722 Int)) (= BOUND_VARIABLE_1215721 BOUND_VARIABLE_1215722)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1215721 Int) (BOUND_VARIABLE_1215722 Int)) (= BOUND_VARIABLE_1215721 BOUND_VARIABLE_1215722)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false)))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.lift (lambda ((BOUND_VARIABLE_1215733 Int) (BOUND_VARIABLE_1215734 Int)) (< BOUND_VARIABLE_1215733 BOUND_VARIABLE_1215734)) ((_ tuple.select 6) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_1215739 Int) (BOUND_VARIABLE_1215740 Int)) (> BOUND_VARIABLE_1215739 BOUND_VARIABLE_1215740)) ((_ tuple.select 6) t) (nullable.some 10))))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 735 ms.
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

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1219502 Bool)) (not BOUND_VARIABLE_1219502)) (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1219482 Int) (BOUND_VARIABLE_1219483 Int)) (= BOUND_VARIABLE_1219482 BOUND_VARIABLE_1219483)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1219482 Int) (BOUND_VARIABLE_1219483 Int)) (= BOUND_VARIABLE_1219482 BOUND_VARIABLE_1219483)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1219488 Int) (BOUND_VARIABLE_1219489 Int)) (= BOUND_VARIABLE_1219488 BOUND_VARIABLE_1219489)) ((_ tuple.select 0) t) (as nullable.null (Nullable Int)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1219488 Int) (BOUND_VARIABLE_1219489 Int)) (= BOUND_VARIABLE_1219488 BOUND_VARIABLE_1219489)) ((_ tuple.select 0) t) (as nullable.null (Nullable Int)))))) (nullable.some true) (as nullable.null (Nullable Bool))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1219502 Bool)) (not BOUND_VARIABLE_1219502)) (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1219482 Int) (BOUND_VARIABLE_1219483 Int)) (= BOUND_VARIABLE_1219482 BOUND_VARIABLE_1219483)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1219482 Int) (BOUND_VARIABLE_1219483 Int)) (= BOUND_VARIABLE_1219482 BOUND_VARIABLE_1219483)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1219488 Int) (BOUND_VARIABLE_1219489 Int)) (= BOUND_VARIABLE_1219488 BOUND_VARIABLE_1219489)) ((_ tuple.select 0) t) (as nullable.null (Nullable Int)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1219488 Int) (BOUND_VARIABLE_1219489 Int)) (= BOUND_VARIABLE_1219488 BOUND_VARIABLE_1219489)) ((_ tuple.select 0) t) (as nullable.null (Nullable Int)))))) (nullable.some true) (as nullable.null (Nullable Bool)))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) false)))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p0 (table.product EMP DEPT)))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.filter p1 (table.product EMP DEPT)))))
(check-sat)
;answer: unsat
; duration: 173 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (nullable.val (ite (or (and (nullable.is_some (nullable.some true)) (not (nullable.val (nullable.some true)))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.some true)) (nullable.is_null (as nullable.null (Nullable Bool)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (ite (or (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (nullable.val (as nullable.null (Nullable Bool))))) (nullable.some true) (as nullable.null (Nullable Bool))) (ite (or (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool))))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool)))))) (nullable.some false) (ite (or (nullable.is_null (as nullable.null (Nullable Bool))) (nullable.is_null (as nullable.null (Nullable Bool)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (nullable.val (ite (nullable.val (ite (or (and (nullable.is_some (nullable.some true)) (not (nullable.val (nullable.some true)))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.some true)) (nullable.is_null (as nullable.null (Nullable Bool)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (ite (or (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (nullable.val (as nullable.null (Nullable Bool))))) (nullable.some true) (as nullable.null (Nullable Bool))) (ite (or (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool))))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool)))))) (nullable.some false) (ite (or (nullable.is_null (as nullable.null (Nullable Bool))) (nullable.is_null (as nullable.null (Nullable Bool)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (ite (and true false) (or false false) (and false false)))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 9 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_1220858 Int) (BOUND_VARIABLE_1220859 Int)) (= BOUND_VARIABLE_1220858 BOUND_VARIABLE_1220859)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_1220858 Int) (BOUND_VARIABLE_1220859 Int)) (= BOUND_VARIABLE_1220858 BOUND_VARIABLE_1220859)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (nullable.val (as nullable.null (Nullable Bool))))) (nullable.some true) (as nullable.null (Nullable Bool)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_1220881 Int) (BOUND_VARIABLE_1220882 Int)) (= BOUND_VARIABLE_1220881 BOUND_VARIABLE_1220882)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (= q1 (bag.map f0 EMP)))
(assert (= q2 (bag.map f1 EMP)))
(check-sat)
;answer: sat
; duration: 236 ms.
(get-model)
; (
; (define-fun EMP () (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (bag (tuple (nullable.some 0) (nullable.some "A") (nullable.some "B") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (nullable.some (- 6))) 1))
; )
; q1
(get-value (q1))
; (bag (tuple (as nullable.null (Nullable Bool))) 1)
; q2
(get-value (q2))
; (bag (tuple (nullable.some false)) 1)
; insert into EMP values(0,'A','B',4,-4,5,-5,6,-6)
; SELECT * FROM (SELECT TRUE = ((empno = 1) OR CAST(NULL AS BOOLEAN)) FROM emp) AS q1 EXCEPT ALL SELECT * FROM (SELECT TRUE = ((empno = 1) OR FALSE) FROM emp) AS q2;
;(NULL)

; SELECT * FROM (SELECT TRUE = ((empno = 1) OR FALSE) FROM emp) AS q2 EXCEPT ALL SELECT * FROM (SELECT TRUE = ((empno = 1) OR CAST(NULL AS BOOLEAN)) FROM emp) AS q1;
;(false)

;Model soundness: true
(reset)
; total time: 306759 ms.
; sat answers    : 7
; unsat answers  : 53
; unknown answers: 28
