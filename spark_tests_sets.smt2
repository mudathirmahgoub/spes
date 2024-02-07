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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple Int)))
(declare-const q2 (Set (Tuple Int)))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Int)))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Int)))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (+ (+ 1 2) 3)))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple 6))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 (set.map f1 DEPT)))
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_483 Int) (BOUND_VARIABLE_484 Int)) (+ BOUND_VARIABLE_483 BOUND_VARIABLE_484)) (nullable.some (+ 100 10)) ((_ tuple.select 6) t))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_516 Int) (BOUND_VARIABLE_517 Int)) (+ BOUND_VARIABLE_516 BOUND_VARIABLE_517)) (nullable.some 110) ((_ tuple.select 6) t))))))
(assert (= q1 (set.map f0 EMP)))
(assert (= q2 (set.map f1 EMP)))
(check-sat)
;answer: unsat
; duration: 30 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_934 Bool) (BOUND_VARIABLE_935 Bool)) (and BOUND_VARIABLE_934 BOUND_VARIABLE_935)) (nullable.lift (lambda ((BOUND_VARIABLE_898 Int) (BOUND_VARIABLE_899 Int)) (= BOUND_VARIABLE_898 BOUND_VARIABLE_899)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_928 Int) (BOUND_VARIABLE_929 Int)) (= BOUND_VARIABLE_928 BOUND_VARIABLE_929)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_922 Int) (BOUND_VARIABLE_923 Int)) (+ BOUND_VARIABLE_922 BOUND_VARIABLE_923)) ((_ tuple.select 6) t) (nullable.some 5))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_934 Bool) (BOUND_VARIABLE_935 Bool)) (and BOUND_VARIABLE_934 BOUND_VARIABLE_935)) (nullable.lift (lambda ((BOUND_VARIABLE_898 Int) (BOUND_VARIABLE_899 Int)) (= BOUND_VARIABLE_898 BOUND_VARIABLE_899)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_928 Int) (BOUND_VARIABLE_929 Int)) (= BOUND_VARIABLE_928 BOUND_VARIABLE_929)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_922 Int) (BOUND_VARIABLE_923 Int)) (+ BOUND_VARIABLE_922 BOUND_VARIABLE_923)) ((_ tuple.select 6) t) (nullable.some 5)))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_972 Bool) (BOUND_VARIABLE_973 Bool)) (and BOUND_VARIABLE_972 BOUND_VARIABLE_973)) (nullable.lift (lambda ((BOUND_VARIABLE_957 Int) (BOUND_VARIABLE_958 Int)) (= BOUND_VARIABLE_957 BOUND_VARIABLE_958)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_966 Int) (BOUND_VARIABLE_967 Int)) (= BOUND_VARIABLE_966 BOUND_VARIABLE_967)) ((_ tuple.select 5) t) (nullable.some 8)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_972 Bool) (BOUND_VARIABLE_973 Bool)) (and BOUND_VARIABLE_972 BOUND_VARIABLE_973)) (nullable.lift (lambda ((BOUND_VARIABLE_957 Int) (BOUND_VARIABLE_958 Int)) (= BOUND_VARIABLE_957 BOUND_VARIABLE_958)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_966 Int) (BOUND_VARIABLE_967 Int)) (= BOUND_VARIABLE_966 BOUND_VARIABLE_967)) ((_ tuple.select 5) t) (nullable.some 8))))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 112 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_2970 Bool) (BOUND_VARIABLE_2971 Bool)) (and BOUND_VARIABLE_2970 BOUND_VARIABLE_2971)) (nullable.lift (lambda ((BOUND_VARIABLE_2946 Int) (BOUND_VARIABLE_2947 Int)) (= BOUND_VARIABLE_2946 BOUND_VARIABLE_2947)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_2965 Bool)) (not BOUND_VARIABLE_2965)) (nullable.lift (lambda ((BOUND_VARIABLE_2959 Int) (BOUND_VARIABLE_2960 Int)) (= BOUND_VARIABLE_2959 BOUND_VARIABLE_2960)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_2953 Int) (BOUND_VARIABLE_2954 Int)) (+ BOUND_VARIABLE_2953 BOUND_VARIABLE_2954)) ((_ tuple.select 6) t) (nullable.some 5)))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_2970 Bool) (BOUND_VARIABLE_2971 Bool)) (and BOUND_VARIABLE_2970 BOUND_VARIABLE_2971)) (nullable.lift (lambda ((BOUND_VARIABLE_2946 Int) (BOUND_VARIABLE_2947 Int)) (= BOUND_VARIABLE_2946 BOUND_VARIABLE_2947)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_2965 Bool)) (not BOUND_VARIABLE_2965)) (nullable.lift (lambda ((BOUND_VARIABLE_2959 Int) (BOUND_VARIABLE_2960 Int)) (= BOUND_VARIABLE_2959 BOUND_VARIABLE_2960)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_2953 Int) (BOUND_VARIABLE_2954 Int)) (+ BOUND_VARIABLE_2953 BOUND_VARIABLE_2954)) ((_ tuple.select 6) t) (nullable.some 5))))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_3007 Bool) (BOUND_VARIABLE_3008 Bool)) (and BOUND_VARIABLE_3007 BOUND_VARIABLE_3008)) (nullable.lift (lambda ((BOUND_VARIABLE_2989 Int) (BOUND_VARIABLE_2990 Int)) (= BOUND_VARIABLE_2989 BOUND_VARIABLE_2990)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_3002 Bool)) (not BOUND_VARIABLE_3002)) (nullable.lift (lambda ((BOUND_VARIABLE_2996 Int) (BOUND_VARIABLE_2997 Int)) (= BOUND_VARIABLE_2996 BOUND_VARIABLE_2997)) ((_ tuple.select 5) t) (nullable.some 8))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_3007 Bool) (BOUND_VARIABLE_3008 Bool)) (and BOUND_VARIABLE_3007 BOUND_VARIABLE_3008)) (nullable.lift (lambda ((BOUND_VARIABLE_2989 Int) (BOUND_VARIABLE_2990 Int)) (= BOUND_VARIABLE_2989 BOUND_VARIABLE_2990)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_3002 Bool)) (not BOUND_VARIABLE_3002)) (nullable.lift (lambda ((BOUND_VARIABLE_2996 Int) (BOUND_VARIABLE_2997 Int)) (= BOUND_VARIABLE_2996 BOUND_VARIABLE_2997)) ((_ tuple.select 5) t) (nullable.some 8)))))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 122 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_5321 Int) (BOUND_VARIABLE_5322 Int)) (+ BOUND_VARIABLE_5321 BOUND_VARIABLE_5322)) (nullable.lift (lambda ((BOUND_VARIABLE_5313 Int) (BOUND_VARIABLE_5314 Int)) (+ BOUND_VARIABLE_5313 BOUND_VARIABLE_5314)) (nullable.some (* 1 3)) (nullable.lift (lambda ((BOUND_VARIABLE_5306 Int) (BOUND_VARIABLE_5307 Int)) (+ BOUND_VARIABLE_5306 BOUND_VARIABLE_5307)) ((_ tuple.select 0) t) (nullable.some 2))) (nullable.some (* 3 4)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_5340 Int) (BOUND_VARIABLE_5341 Int)) (+ BOUND_VARIABLE_5340 BOUND_VARIABLE_5341)) ((_ tuple.select 0) t) (nullable.some 17))))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 (set.map f1 DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10008 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_30130 Int) (BOUND_VARIABLE_30131 Int)) (= BOUND_VARIABLE_30130 BOUND_VARIABLE_30131)) ((_ tuple.select 0) t) ((_ tuple.select 2) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_30130 Int) (BOUND_VARIABLE_30131 Int)) (= BOUND_VARIABLE_30130 BOUND_VARIABLE_30131)) ((_ tuple.select 0) t) ((_ tuple.select 2) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (= q1 ((_ rel.project 0 1) (set.filter p1 (rel.product DEPT ((_ rel.project 0) ((_ rel.project 0) (set.filter p0 DEPT))))))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p2 DEPT))))
(check-sat)
;answer: unsat
; duration: 154 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_30980 Bool) (BOUND_VARIABLE_30981 Bool)) (or BOUND_VARIABLE_30980 BOUND_VARIABLE_30981)) (nullable.lift (lambda ((BOUND_VARIABLE_30968 Int) (BOUND_VARIABLE_30969 Int)) (= BOUND_VARIABLE_30968 BOUND_VARIABLE_30969)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.lift (lambda ((BOUND_VARIABLE_30974 Int) (BOUND_VARIABLE_30975 Int)) (= BOUND_VARIABLE_30974 BOUND_VARIABLE_30975)) ((_ tuple.select 0) t) (nullable.some 2)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_30980 Bool) (BOUND_VARIABLE_30981 Bool)) (or BOUND_VARIABLE_30980 BOUND_VARIABLE_30981)) (nullable.lift (lambda ((BOUND_VARIABLE_30968 Int) (BOUND_VARIABLE_30969 Int)) (= BOUND_VARIABLE_30968 BOUND_VARIABLE_30969)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.lift (lambda ((BOUND_VARIABLE_30974 Int) (BOUND_VARIABLE_30975 Int)) (= BOUND_VARIABLE_30974 BOUND_VARIABLE_30975)) ((_ tuple.select 0) t) (nullable.some 2))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_31012 Bool) (BOUND_VARIABLE_31013 Bool)) (or BOUND_VARIABLE_31012 BOUND_VARIABLE_31013)) (nullable.lift (lambda ((BOUND_VARIABLE_31000 Int) (BOUND_VARIABLE_31001 Int)) (= BOUND_VARIABLE_31000 BOUND_VARIABLE_31001)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.lift (lambda ((BOUND_VARIABLE_31006 Int) (BOUND_VARIABLE_31007 Int)) (= BOUND_VARIABLE_31006 BOUND_VARIABLE_31007)) ((_ tuple.select 0) t) (nullable.some 2)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_31012 Bool) (BOUND_VARIABLE_31013 Bool)) (or BOUND_VARIABLE_31012 BOUND_VARIABLE_31013)) (nullable.lift (lambda ((BOUND_VARIABLE_31000 Int) (BOUND_VARIABLE_31001 Int)) (= BOUND_VARIABLE_31000 BOUND_VARIABLE_31001)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.lift (lambda ((BOUND_VARIABLE_31006 Int) (BOUND_VARIABLE_31007 Int)) (= BOUND_VARIABLE_31006 BOUND_VARIABLE_31007)) ((_ tuple.select 0) t) (nullable.some 2))))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 DEPT))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 78 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_32634 Bool) (BOUND_VARIABLE_32635 Bool)) (and BOUND_VARIABLE_32634 BOUND_VARIABLE_32635)) (nullable.lift (lambda ((BOUND_VARIABLE_32627 Int) (BOUND_VARIABLE_32628 Int)) (= BOUND_VARIABLE_32627 BOUND_VARIABLE_32628)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some true))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_32634 Bool) (BOUND_VARIABLE_32635 Bool)) (and BOUND_VARIABLE_32634 BOUND_VARIABLE_32635)) (nullable.lift (lambda ((BOUND_VARIABLE_32627 Int) (BOUND_VARIABLE_32628 Int)) (= BOUND_VARIABLE_32627 BOUND_VARIABLE_32628)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some true)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_32653 Int) (BOUND_VARIABLE_32654 Int)) (= BOUND_VARIABLE_32653 BOUND_VARIABLE_32654)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_32653 Int) (BOUND_VARIABLE_32654 Int)) (= BOUND_VARIABLE_32653 BOUND_VARIABLE_32654)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 DEPT))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 51 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_33664 Bool) (BOUND_VARIABLE_33665 Bool)) (or BOUND_VARIABLE_33664 BOUND_VARIABLE_33665)) (nullable.lift (lambda ((BOUND_VARIABLE_33657 Int) (BOUND_VARIABLE_33658 Int)) (= BOUND_VARIABLE_33657 BOUND_VARIABLE_33658)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some false))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_33664 Bool) (BOUND_VARIABLE_33665 Bool)) (or BOUND_VARIABLE_33664 BOUND_VARIABLE_33665)) (nullable.lift (lambda ((BOUND_VARIABLE_33657 Int) (BOUND_VARIABLE_33658 Int)) (= BOUND_VARIABLE_33657 BOUND_VARIABLE_33658)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some false)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_33683 Int) (BOUND_VARIABLE_33684 Int)) (= BOUND_VARIABLE_33683 BOUND_VARIABLE_33684)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_33683 Int) (BOUND_VARIABLE_33684 Int)) (= BOUND_VARIABLE_33683 BOUND_VARIABLE_33684)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 DEPT))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 51 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_34695 Bool) (BOUND_VARIABLE_34696 Bool)) (and BOUND_VARIABLE_34695 BOUND_VARIABLE_34696)) (nullable.lift (lambda ((BOUND_VARIABLE_34689 Int) (BOUND_VARIABLE_34690 Int)) (= BOUND_VARIABLE_34689 BOUND_VARIABLE_34690)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some false))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_34695 Bool) (BOUND_VARIABLE_34696 Bool)) (and BOUND_VARIABLE_34695 BOUND_VARIABLE_34696)) (nullable.lift (lambda ((BOUND_VARIABLE_34689 Int) (BOUND_VARIABLE_34690 Int)) (= BOUND_VARIABLE_34689 BOUND_VARIABLE_34690)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some false)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 DEPT))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 25 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_35299 Bool) (BOUND_VARIABLE_35300 Bool)) (or BOUND_VARIABLE_35299 BOUND_VARIABLE_35300)) (nullable.lift (lambda ((BOUND_VARIABLE_35293 Int) (BOUND_VARIABLE_35294 Int)) (= BOUND_VARIABLE_35293 BOUND_VARIABLE_35294)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some true))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_35299 Bool) (BOUND_VARIABLE_35300 Bool)) (or BOUND_VARIABLE_35299 BOUND_VARIABLE_35300)) (nullable.lift (lambda ((BOUND_VARIABLE_35293 Int) (BOUND_VARIABLE_35294 Int)) (= BOUND_VARIABLE_35293 BOUND_VARIABLE_35294)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some true)))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 DEPT))))
(assert (= q2 ((_ rel.project 0 1) DEPT)))
(check-sat)
;answer: sat
; duration: 70 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (as nullable.null (Nullable Int)) (nullable.some ""))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String))))
; q2
(get-value (q2))
; (set.singleton (tuple (as nullable.null (Nullable Int)) (nullable.some "")))
; insert into DEPT values(NULL,'')
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

(declare-const ANON (Set (Tuple (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_35893 Bool) (BOUND_VARIABLE_35894 Bool)) (and BOUND_VARIABLE_35893 BOUND_VARIABLE_35894)) (nullable.lift (lambda ((BOUND_VARIABLE_35881 Int) (BOUND_VARIABLE_35882 Int)) (> BOUND_VARIABLE_35881 BOUND_VARIABLE_35882)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.lift (lambda ((BOUND_VARIABLE_35887 Int) (BOUND_VARIABLE_35888 Int)) (<= BOUND_VARIABLE_35887 BOUND_VARIABLE_35888)) ((_ tuple.select 0) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_35893 Bool) (BOUND_VARIABLE_35894 Bool)) (and BOUND_VARIABLE_35893 BOUND_VARIABLE_35894)) (nullable.lift (lambda ((BOUND_VARIABLE_35881 Int) (BOUND_VARIABLE_35882 Int)) (> BOUND_VARIABLE_35881 BOUND_VARIABLE_35882)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.lift (lambda ((BOUND_VARIABLE_35887 Int) (BOUND_VARIABLE_35888 Int)) (<= BOUND_VARIABLE_35887 BOUND_VARIABLE_35888)) ((_ tuple.select 0) t) (nullable.some 1))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (ite (nullable.is_null ((_ tuple.select 0) t)) (as nullable.null (Nullable Bool)) (nullable.some false))) (nullable.val (ite (nullable.is_null ((_ tuple.select 0) t)) (as nullable.null (Nullable Bool)) (nullable.some false)))))))
(assert (= q1 ((_ rel.project 0) (set.filter p0 ANON))))
(assert (= q2 ((_ rel.project 0) (set.filter p1 ANON))))
(check-sat)
;answer: unsat
; duration: 46 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36918 Bool) (BOUND_VARIABLE_36919 Bool)) (and BOUND_VARIABLE_36918 BOUND_VARIABLE_36919)) (nullable.lift (lambda ((BOUND_VARIABLE_36893 Int) (BOUND_VARIABLE_36894 Int)) (> BOUND_VARIABLE_36893 BOUND_VARIABLE_36894)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_36912 Bool) (BOUND_VARIABLE_36913 Bool)) (or BOUND_VARIABLE_36912 BOUND_VARIABLE_36913)) (nullable.lift (lambda ((BOUND_VARIABLE_36899 Int) (BOUND_VARIABLE_36900 Int)) (<= BOUND_VARIABLE_36899 BOUND_VARIABLE_36900)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_36906 Int) (BOUND_VARIABLE_36907 Int)) (> BOUND_VARIABLE_36906 BOUND_VARIABLE_36907)) ((_ tuple.select 0) t) (nullable.some 5))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36918 Bool) (BOUND_VARIABLE_36919 Bool)) (and BOUND_VARIABLE_36918 BOUND_VARIABLE_36919)) (nullable.lift (lambda ((BOUND_VARIABLE_36893 Int) (BOUND_VARIABLE_36894 Int)) (> BOUND_VARIABLE_36893 BOUND_VARIABLE_36894)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_36912 Bool) (BOUND_VARIABLE_36913 Bool)) (or BOUND_VARIABLE_36912 BOUND_VARIABLE_36913)) (nullable.lift (lambda ((BOUND_VARIABLE_36899 Int) (BOUND_VARIABLE_36900 Int)) (<= BOUND_VARIABLE_36899 BOUND_VARIABLE_36900)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_36906 Int) (BOUND_VARIABLE_36907 Int)) (> BOUND_VARIABLE_36906 BOUND_VARIABLE_36907)) ((_ tuple.select 0) t) (nullable.some 5)))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36950 Bool) (BOUND_VARIABLE_36951 Bool)) (and BOUND_VARIABLE_36950 BOUND_VARIABLE_36951)) (nullable.lift (lambda ((BOUND_VARIABLE_36937 Int) (BOUND_VARIABLE_36938 Int)) (> BOUND_VARIABLE_36937 BOUND_VARIABLE_36938)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_36944 Int) (BOUND_VARIABLE_36945 Int)) (> BOUND_VARIABLE_36944 BOUND_VARIABLE_36945)) ((_ tuple.select 0) t) (nullable.some 5)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36950 Bool) (BOUND_VARIABLE_36951 Bool)) (and BOUND_VARIABLE_36950 BOUND_VARIABLE_36951)) (nullable.lift (lambda ((BOUND_VARIABLE_36937 Int) (BOUND_VARIABLE_36938 Int)) (> BOUND_VARIABLE_36937 BOUND_VARIABLE_36938)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_36944 Int) (BOUND_VARIABLE_36945 Int)) (> BOUND_VARIABLE_36944 BOUND_VARIABLE_36945)) ((_ tuple.select 0) t) (nullable.some 5))))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 109 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_39127 Bool) (BOUND_VARIABLE_39128 Bool)) (or BOUND_VARIABLE_39127 BOUND_VARIABLE_39128)) (nullable.lift (lambda ((BOUND_VARIABLE_39102 Int) (BOUND_VARIABLE_39103 Int)) (> BOUND_VARIABLE_39102 BOUND_VARIABLE_39103)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_39121 Bool) (BOUND_VARIABLE_39122 Bool)) (and BOUND_VARIABLE_39121 BOUND_VARIABLE_39122)) (nullable.lift (lambda ((BOUND_VARIABLE_39108 Int) (BOUND_VARIABLE_39109 Int)) (<= BOUND_VARIABLE_39108 BOUND_VARIABLE_39109)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_39115 Int) (BOUND_VARIABLE_39116 Int)) (> BOUND_VARIABLE_39115 BOUND_VARIABLE_39116)) ((_ tuple.select 0) t) (nullable.some 5))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_39127 Bool) (BOUND_VARIABLE_39128 Bool)) (or BOUND_VARIABLE_39127 BOUND_VARIABLE_39128)) (nullable.lift (lambda ((BOUND_VARIABLE_39102 Int) (BOUND_VARIABLE_39103 Int)) (> BOUND_VARIABLE_39102 BOUND_VARIABLE_39103)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_39121 Bool) (BOUND_VARIABLE_39122 Bool)) (and BOUND_VARIABLE_39121 BOUND_VARIABLE_39122)) (nullable.lift (lambda ((BOUND_VARIABLE_39108 Int) (BOUND_VARIABLE_39109 Int)) (<= BOUND_VARIABLE_39108 BOUND_VARIABLE_39109)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_39115 Int) (BOUND_VARIABLE_39116 Int)) (> BOUND_VARIABLE_39115 BOUND_VARIABLE_39116)) ((_ tuple.select 0) t) (nullable.some 5)))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_39159 Bool) (BOUND_VARIABLE_39160 Bool)) (or BOUND_VARIABLE_39159 BOUND_VARIABLE_39160)) (nullable.lift (lambda ((BOUND_VARIABLE_39146 Int) (BOUND_VARIABLE_39147 Int)) (> BOUND_VARIABLE_39146 BOUND_VARIABLE_39147)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_39153 Int) (BOUND_VARIABLE_39154 Int)) (> BOUND_VARIABLE_39153 BOUND_VARIABLE_39154)) ((_ tuple.select 0) t) (nullable.some 5)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_39159 Bool) (BOUND_VARIABLE_39160 Bool)) (or BOUND_VARIABLE_39159 BOUND_VARIABLE_39160)) (nullable.lift (lambda ((BOUND_VARIABLE_39146 Int) (BOUND_VARIABLE_39147 Int)) (> BOUND_VARIABLE_39146 BOUND_VARIABLE_39147)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_39153 Int) (BOUND_VARIABLE_39154 Int)) (> BOUND_VARIABLE_39153 BOUND_VARIABLE_39154)) ((_ tuple.select 0) t) (nullable.some 5))))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 110 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_41433 Bool) (BOUND_VARIABLE_41434 Bool)) (and BOUND_VARIABLE_41433 BOUND_VARIABLE_41434)) (nullable.lift (lambda ((BOUND_VARIABLE_41407 Bool) (BOUND_VARIABLE_41408 Bool) (BOUND_VARIABLE_41409 Bool)) (or BOUND_VARIABLE_41407 BOUND_VARIABLE_41408 BOUND_VARIABLE_41409)) (nullable.lift (lambda ((BOUND_VARIABLE_41387 Int) (BOUND_VARIABLE_41388 Int)) (= BOUND_VARIABLE_41387 BOUND_VARIABLE_41388)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_41394 Int) (BOUND_VARIABLE_41395 Int)) (= BOUND_VARIABLE_41394 BOUND_VARIABLE_41395)) ((_ tuple.select 6) t) (nullable.some 100)) (nullable.lift (lambda ((BOUND_VARIABLE_41401 Int) (BOUND_VARIABLE_41402 Int)) (> BOUND_VARIABLE_41401 BOUND_VARIABLE_41402)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.lift (lambda ((BOUND_VARIABLE_41427 Bool) (BOUND_VARIABLE_41428 Bool)) (or BOUND_VARIABLE_41427 BOUND_VARIABLE_41428)) (nullable.lift (lambda ((BOUND_VARIABLE_41415 Int) (BOUND_VARIABLE_41416 Int)) (= BOUND_VARIABLE_41415 BOUND_VARIABLE_41416)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_41421 Int) (BOUND_VARIABLE_41422 Int)) (= BOUND_VARIABLE_41421 BOUND_VARIABLE_41422)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_41433 Bool) (BOUND_VARIABLE_41434 Bool)) (and BOUND_VARIABLE_41433 BOUND_VARIABLE_41434)) (nullable.lift (lambda ((BOUND_VARIABLE_41407 Bool) (BOUND_VARIABLE_41408 Bool) (BOUND_VARIABLE_41409 Bool)) (or BOUND_VARIABLE_41407 BOUND_VARIABLE_41408 BOUND_VARIABLE_41409)) (nullable.lift (lambda ((BOUND_VARIABLE_41387 Int) (BOUND_VARIABLE_41388 Int)) (= BOUND_VARIABLE_41387 BOUND_VARIABLE_41388)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_41394 Int) (BOUND_VARIABLE_41395 Int)) (= BOUND_VARIABLE_41394 BOUND_VARIABLE_41395)) ((_ tuple.select 6) t) (nullable.some 100)) (nullable.lift (lambda ((BOUND_VARIABLE_41401 Int) (BOUND_VARIABLE_41402 Int)) (> BOUND_VARIABLE_41401 BOUND_VARIABLE_41402)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.lift (lambda ((BOUND_VARIABLE_41427 Bool) (BOUND_VARIABLE_41428 Bool)) (or BOUND_VARIABLE_41427 BOUND_VARIABLE_41428)) (nullable.lift (lambda ((BOUND_VARIABLE_41415 Int) (BOUND_VARIABLE_41416 Int)) (= BOUND_VARIABLE_41415 BOUND_VARIABLE_41416)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_41421 Int) (BOUND_VARIABLE_41422 Int)) (= BOUND_VARIABLE_41421 BOUND_VARIABLE_41422)) ((_ tuple.select 6) t) (nullable.some 100)))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_41464 Bool) (BOUND_VARIABLE_41465 Bool)) (or BOUND_VARIABLE_41464 BOUND_VARIABLE_41465)) (nullable.lift (lambda ((BOUND_VARIABLE_41452 Int) (BOUND_VARIABLE_41453 Int)) (= BOUND_VARIABLE_41452 BOUND_VARIABLE_41453)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_41458 Int) (BOUND_VARIABLE_41459 Int)) (= BOUND_VARIABLE_41458 BOUND_VARIABLE_41459)) ((_ tuple.select 6) t) (nullable.some 100)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_41464 Bool) (BOUND_VARIABLE_41465 Bool)) (or BOUND_VARIABLE_41464 BOUND_VARIABLE_41465)) (nullable.lift (lambda ((BOUND_VARIABLE_41452 Int) (BOUND_VARIABLE_41453 Int)) (= BOUND_VARIABLE_41452 BOUND_VARIABLE_41453)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_41458 Int) (BOUND_VARIABLE_41459 Int)) (= BOUND_VARIABLE_41458 BOUND_VARIABLE_41459)) ((_ tuple.select 6) t) (nullable.some 100))))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 324 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (as nullable.null (Nullable Int)) (nullable.some "A") (nullable.some "B") (nullable.some 3) (nullable.some (- 3)) (nullable.some 4) (nullable.some 100) (nullable.some (- 4)) (nullable.some 5))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (as nullable.null (Nullable Int)) (nullable.some "A") (nullable.some "B") (nullable.some 3) (nullable.some (- 3)) (nullable.some 4) (nullable.some 100) (nullable.some (- 4)) (nullable.some 5)))
; insert into EMP values(NULL,'A','B',3,-3,4,100,-4,5)
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_47618 Bool) (BOUND_VARIABLE_47619 Bool)) (or BOUND_VARIABLE_47618 BOUND_VARIABLE_47619)) (nullable.lift (lambda ((BOUND_VARIABLE_47593 Bool) (BOUND_VARIABLE_47594 Bool) (BOUND_VARIABLE_47595 Bool)) (and BOUND_VARIABLE_47593 BOUND_VARIABLE_47594 BOUND_VARIABLE_47595)) (nullable.lift (lambda ((BOUND_VARIABLE_47574 Int) (BOUND_VARIABLE_47575 Int)) (= BOUND_VARIABLE_47574 BOUND_VARIABLE_47575)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_47580 Int) (BOUND_VARIABLE_47581 Int)) (= BOUND_VARIABLE_47580 BOUND_VARIABLE_47581)) ((_ tuple.select 6) t) (nullable.some 100)) (nullable.lift (lambda ((BOUND_VARIABLE_47587 Int) (BOUND_VARIABLE_47588 Int)) (> BOUND_VARIABLE_47587 BOUND_VARIABLE_47588)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.lift (lambda ((BOUND_VARIABLE_47612 Bool) (BOUND_VARIABLE_47613 Bool)) (and BOUND_VARIABLE_47612 BOUND_VARIABLE_47613)) (nullable.lift (lambda ((BOUND_VARIABLE_47600 Int) (BOUND_VARIABLE_47601 Int)) (= BOUND_VARIABLE_47600 BOUND_VARIABLE_47601)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_47606 Int) (BOUND_VARIABLE_47607 Int)) (= BOUND_VARIABLE_47606 BOUND_VARIABLE_47607)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_47618 Bool) (BOUND_VARIABLE_47619 Bool)) (or BOUND_VARIABLE_47618 BOUND_VARIABLE_47619)) (nullable.lift (lambda ((BOUND_VARIABLE_47593 Bool) (BOUND_VARIABLE_47594 Bool) (BOUND_VARIABLE_47595 Bool)) (and BOUND_VARIABLE_47593 BOUND_VARIABLE_47594 BOUND_VARIABLE_47595)) (nullable.lift (lambda ((BOUND_VARIABLE_47574 Int) (BOUND_VARIABLE_47575 Int)) (= BOUND_VARIABLE_47574 BOUND_VARIABLE_47575)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_47580 Int) (BOUND_VARIABLE_47581 Int)) (= BOUND_VARIABLE_47580 BOUND_VARIABLE_47581)) ((_ tuple.select 6) t) (nullable.some 100)) (nullable.lift (lambda ((BOUND_VARIABLE_47587 Int) (BOUND_VARIABLE_47588 Int)) (> BOUND_VARIABLE_47587 BOUND_VARIABLE_47588)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.lift (lambda ((BOUND_VARIABLE_47612 Bool) (BOUND_VARIABLE_47613 Bool)) (and BOUND_VARIABLE_47612 BOUND_VARIABLE_47613)) (nullable.lift (lambda ((BOUND_VARIABLE_47600 Int) (BOUND_VARIABLE_47601 Int)) (= BOUND_VARIABLE_47600 BOUND_VARIABLE_47601)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_47606 Int) (BOUND_VARIABLE_47607 Int)) (= BOUND_VARIABLE_47606 BOUND_VARIABLE_47607)) ((_ tuple.select 6) t) (nullable.some 100)))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_47650 Bool) (BOUND_VARIABLE_47651 Bool)) (and BOUND_VARIABLE_47650 BOUND_VARIABLE_47651)) (nullable.lift (lambda ((BOUND_VARIABLE_47638 Int) (BOUND_VARIABLE_47639 Int)) (= BOUND_VARIABLE_47638 BOUND_VARIABLE_47639)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_47644 Int) (BOUND_VARIABLE_47645 Int)) (= BOUND_VARIABLE_47644 BOUND_VARIABLE_47645)) ((_ tuple.select 6) t) (nullable.some 100)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_47650 Bool) (BOUND_VARIABLE_47651 Bool)) (and BOUND_VARIABLE_47650 BOUND_VARIABLE_47651)) (nullable.lift (lambda ((BOUND_VARIABLE_47638 Int) (BOUND_VARIABLE_47639 Int)) (= BOUND_VARIABLE_47638 BOUND_VARIABLE_47639)) ((_ tuple.select 6) t) (nullable.some 50)) (nullable.lift (lambda ((BOUND_VARIABLE_47644 Int) (BOUND_VARIABLE_47645 Int)) (= BOUND_VARIABLE_47644 BOUND_VARIABLE_47645)) ((_ tuple.select 6) t) (nullable.some 100))))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 139 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable Bool))))
(declare-const q2 (Set (Tuple (Nullable Bool))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(declare-const q1_lift_2 (-> (Tuple (Nullable Bool)) (Tuple (Nullable Bool))))
(declare-const q2_lift_3 (-> (Tuple Bool) (Tuple (Nullable Bool))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_50051 Bool) (BOUND_VARIABLE_50052 Bool)) (or BOUND_VARIABLE_50051 BOUND_VARIABLE_50052)) (as nullable.null (Nullable Bool)) (nullable.some (nullable.is_some ((_ tuple.select 0) t))))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple true))))
(assert (= q1_lift_2 (lambda ((t (Tuple (Nullable Bool)))) (tuple ((_ tuple.select 0) t)))))
(assert (= q2_lift_3 (lambda ((t (Tuple Bool))) (tuple (nullable.some ((_ tuple.select 0) t))))))
(assert (= q1 (set.map q1_lift_2 (set.map f0 DEPT))))
(assert (= q2 (set.map q2_lift_3 (set.map f1 DEPT))))
(check-sat)
;answer: sat
; duration: 30 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.union (set.singleton (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)))) (set.singleton (tuple (as nullable.null (Nullable Int)) (nullable.some "")))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (as nullable.null (Nullable Bool))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some true)))
; insert into DEPT values(NULL,NULL),(NULL,'')
; SELECT * FROM (SELECT dept.deptno = dept.deptno FROM dept AS dept) AS q1 EXCEPT ALL SELECT * FROM (SELECT TRUE FROM dept AS dept) AS q2;
;(NULL)
;(NULL)

; SELECT * FROM (SELECT TRUE FROM dept AS dept) AS q2 EXCEPT ALL SELECT * FROM (SELECT dept.deptno = dept.deptno FROM dept AS dept) AS q1;
;(true)
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple Bool)))
(declare-const q2 (Set (Tuple Bool)))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple true))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple true))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 (set.map f1 DEPT)))
(check-sat)
;answer: unsat
; duration: 7 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple Bool)))
(declare-const q2 (Set (Tuple Bool)))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple false))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple false))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 (set.map f1 DEPT)))
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple Bool)))
(declare-const q2 (Set (Tuple Bool)))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple true))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple true))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 (set.map f1 DEPT)))
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple Bool)))
(declare-const q2 (Set (Tuple Bool)))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.is_null ((_ tuple.select 0) t))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.is_null ((_ tuple.select 0) t))))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 (set.map f1 DEPT)))
(check-sat)
;answer: unsat
; duration: 17 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple Bool)))
(declare-const q2 (Set (Tuple Bool)))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.is_some ((_ tuple.select 0) t))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.is_some ((_ tuple.select 0) t))))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 (set.map f1 DEPT)))
(check-sat)
;answer: unsat
; duration: 18 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t)))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 ((_ rel.project 0) DEPT)))
(check-sat)
;answer: unsat
; duration: 14 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable String))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable String))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 1) t)))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 ((_ rel.project 1) DEPT)))
(check-sat)
;answer: unsat
; duration: 12 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable Bool))))
(declare-const q2 (Set (Tuple (Nullable Bool))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Bool))))
(declare-const q1_lift_2 (-> (Tuple Bool) (Tuple (Nullable Bool))))
(declare-const q2_lift_3 (-> (Tuple (Nullable Bool)) (Tuple (Nullable Bool))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_51516 Int) (BOUND_VARIABLE_51517 Int)) (= BOUND_VARIABLE_51516 BOUND_VARIABLE_51517)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_51533 Int) (BOUND_VARIABLE_51534 Int)) (= BOUND_VARIABLE_51533 BOUND_VARIABLE_51534)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (= q1_lift_2 (lambda ((t (Tuple Bool))) (tuple (nullable.some ((_ tuple.select 0) t))))))
(assert (= q2_lift_3 (lambda ((t (Tuple (Nullable Bool)))) (tuple ((_ tuple.select 0) t)))))
(assert (= q1 (set.map q1_lift_2 (set.map f0 DEPT))))
(assert (= q2 (set.map q2_lift_3 (set.map f1 DEPT))))
(check-sat)
;answer: sat
; duration: 113 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.union (set.singleton (tuple (nullable.some 1) (nullable.some "B"))) (set.union (set.singleton (tuple (nullable.some 1) (nullable.some "A"))) (set.union (set.singleton (tuple (nullable.some 0) (nullable.some ""))) (set.singleton (tuple (nullable.some 1) (as nullable.null (Nullable String))))))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some true)))
; q2
(get-value (q2))
; (set.union (set.singleton (tuple (nullable.some false))) (set.singleton (tuple (nullable.some true))))
; insert into DEPT values(1,'B'),(1,'A'),(0,''),(1,NULL)
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable Bool))))
(declare-const q2 (Set (Tuple (Nullable Bool))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Bool))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_53204 Bool) (BOUND_VARIABLE_53205 Bool)) (and BOUND_VARIABLE_53204 BOUND_VARIABLE_53205)) (nullable.some (nullable.is_null ((_ tuple.select 0) t))) (as nullable.null (Nullable Bool)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_53222 Bool) (BOUND_VARIABLE_53223 Bool)) (and BOUND_VARIABLE_53222 BOUND_VARIABLE_53223)) (nullable.some (nullable.is_null ((_ tuple.select 0) t))) (as nullable.null (Nullable Bool)))))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 (set.map f1 DEPT)))
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable Bool))))
(declare-const q2 (Set (Tuple (Nullable Bool))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Bool))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_53274 Bool) (BOUND_VARIABLE_53275 Bool)) (and BOUND_VARIABLE_53274 BOUND_VARIABLE_53275)) (as nullable.null (Nullable Bool)) (nullable.some (nullable.is_some ((_ tuple.select 0) t))))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_53292 Bool) (BOUND_VARIABLE_53293 Bool)) (and BOUND_VARIABLE_53292 BOUND_VARIABLE_53293)) (nullable.some (nullable.is_some ((_ tuple.select 0) t))) (as nullable.null (Nullable Bool)))))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 (set.map f1 DEPT)))
(check-sat)
;answer: unsat
; duration: 6 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable String))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable String))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 1) t)))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 ((_ rel.project 1) DEPT)))
(check-sat)
;answer: unsat
; duration: 11 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t)))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 ((_ rel.project 0) DEPT)))
(check-sat)
;answer: unsat
; duration: 11 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable Bool))))
(declare-const q2 (Set (Tuple (Nullable Bool))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Bool)))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Bool))))
(declare-const q1_lift_2 (-> (Tuple Bool) (Tuple (Nullable Bool))))
(declare-const q2_lift_3 (-> (Tuple (Nullable Bool)) (Tuple (Nullable Bool))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_53662 Int) (BOUND_VARIABLE_53663 Int)) (= BOUND_VARIABLE_53662 BOUND_VARIABLE_53663)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_53679 Int) (BOUND_VARIABLE_53680 Int)) (= BOUND_VARIABLE_53679 BOUND_VARIABLE_53680)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (= q1_lift_2 (lambda ((t (Tuple Bool))) (tuple (nullable.some ((_ tuple.select 0) t))))))
(assert (= q2_lift_3 (lambda ((t (Tuple (Nullable Bool)))) (tuple ((_ tuple.select 0) t)))))
(assert (= q1 (set.map q1_lift_2 (set.map f0 DEPT))))
(assert (= q2 (set.map q2_lift_3 (set.map f1 DEPT))))
(check-sat)
;answer: sat
; duration: 142 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.union (set.singleton (tuple (nullable.some 1) (nullable.some "B"))) (set.union (set.singleton (tuple (nullable.some 1) (nullable.some "A"))) (set.union (set.singleton (tuple (nullable.some 0) (nullable.some ""))) (set.singleton (tuple (nullable.some 1) (as nullable.null (Nullable String))))))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some true)))
; q2
(get-value (q2))
; (set.union (set.singleton (tuple (nullable.some false))) (set.singleton (tuple (nullable.some true))))
; insert into DEPT values(1,'B'),(1,'A'),(0,''),(1,NULL)
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_55363 Int) (BOUND_VARIABLE_55364 Int)) (= BOUND_VARIABLE_55363 BOUND_VARIABLE_55364)) ((_ tuple.select 0) t) (nullable.some 1))) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_55369 Int) (BOUND_VARIABLE_55370 Int)) (+ BOUND_VARIABLE_55369 BOUND_VARIABLE_55370)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_55388 Int) (BOUND_VARIABLE_55389 Int)) (= BOUND_VARIABLE_55388 BOUND_VARIABLE_55389)) ((_ tuple.select 0) t) (nullable.some 1))) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_55394 Int) (BOUND_VARIABLE_55395 Int)) (+ BOUND_VARIABLE_55394 BOUND_VARIABLE_55395)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 (set.map f1 DEPT)))
(check-sat)
;answer: unsat
; duration: 49 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t)))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 ((_ rel.project 0) DEPT)))
(check-sat)
;answer: unsat
; duration: 13 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_56308 Int) (BOUND_VARIABLE_56309 Int)) (= BOUND_VARIABLE_56308 BOUND_VARIABLE_56309)) ((_ tuple.select 0) t) (nullable.some 1))) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_56314 Int) (BOUND_VARIABLE_56315 Int)) (+ BOUND_VARIABLE_56314 BOUND_VARIABLE_56315)) ((_ tuple.select 0) t) (nullable.some 100)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_56332 Int) (BOUND_VARIABLE_56333 Int)) (= BOUND_VARIABLE_56332 BOUND_VARIABLE_56333)) ((_ tuple.select 0) t) (nullable.some 1))) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_56338 Int) (BOUND_VARIABLE_56339 Int)) (+ BOUND_VARIABLE_56338 BOUND_VARIABLE_56339)) ((_ tuple.select 0) t) (nullable.some 100)))))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 (set.map f1 DEPT)))
(check-sat)
;answer: unsat
; duration: 37 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= q1 ((_ rel.project 0) DEPT)))
(assert (= q2 ((_ rel.project 0) DEPT)))
(check-sat)
;answer: unsat
; duration: 4 ms.
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

(declare-const T (Set (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Bool))))
(declare-const q2 (Set (Tuple (Nullable Bool))))
(declare-const f0 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Bool))))
(assert (= f0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_57157 Int) (BOUND_VARIABLE_57158 Int)) (= BOUND_VARIABLE_57157 BOUND_VARIABLE_57158)) (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_57148 Int) (BOUND_VARIABLE_57149 Int)) (= BOUND_VARIABLE_57148 BOUND_VARIABLE_57149)) ((_ tuple.select 6) t) (nullable.some 100))) ((_ tuple.select 7) t) (nullable.some 2)) (nullable.some 2))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_57174 Int) (BOUND_VARIABLE_57175 Int)) (= BOUND_VARIABLE_57174 BOUND_VARIABLE_57175)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.lift (lambda ((BOUND_VARIABLE_57181 Int) (BOUND_VARIABLE_57182 Int)) (= BOUND_VARIABLE_57181 BOUND_VARIABLE_57182)) ((_ tuple.select 7) t) (nullable.some 2)) (nullable.some true))))))
(assert (= q1 (set.map f0 T)))
(assert (= q2 (set.map f1 T)))
(check-sat)
;answer: unsat
; duration: 118 ms.
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

(declare-const T (Set (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Bool))))
(declare-const q2 (Set (Tuple (Nullable Bool))))
(declare-const f0 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Bool))))
(assert (= f0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_58890 Int) (BOUND_VARIABLE_58891 Int)) (= BOUND_VARIABLE_58890 BOUND_VARIABLE_58891)) (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_58881 Int) (BOUND_VARIABLE_58882 Int)) (= BOUND_VARIABLE_58881 BOUND_VARIABLE_58882)) ((_ tuple.select 6) t) (nullable.some 100))) ((_ tuple.select 7) t) (nullable.some 2)) (nullable.some 2))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_58906 Int) (BOUND_VARIABLE_58907 Int)) (= BOUND_VARIABLE_58906 BOUND_VARIABLE_58907)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.lift (lambda ((BOUND_VARIABLE_58913 Int) (BOUND_VARIABLE_58914 Int)) (= BOUND_VARIABLE_58913 BOUND_VARIABLE_58914)) ((_ tuple.select 7) t) (nullable.some 2)) (nullable.some true))))))
(assert (= q1 (set.map f0 T)))
(assert (= q2 (set.map f1 T)))
(check-sat)
;answer: unsat
; duration: 113 ms.
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

(declare-const T (Set (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple Bool)))
(declare-const q2 (Set (Tuple Bool)))
(declare-const f0 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple Bool)))
(declare-const f1 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple Bool)))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.is_null (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_60605 Int) (BOUND_VARIABLE_60606 Int)) (= BOUND_VARIABLE_60605 BOUND_VARIABLE_60606)) ((_ tuple.select 6) t) (nullable.some 100))) ((_ tuple.select 7) t) (nullable.some 2)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple false))))
(assert (= q1 (set.map f0 T)))
(assert (= q2 (set.map f1 T)))
(check-sat)
;answer: sat
; duration: 91 ms.
(get-model)
; (
; (define-fun T () (Set (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some "C") (nullable.some "D") (nullable.some 6) (nullable.some (- 6)) (nullable.some 7) (nullable.some (- 7)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (nullable.some 8))) (set.singleton (tuple (nullable.some "A") (nullable.some "B") (nullable.some (- 3)) (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (nullable.some (- 5))))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.is_null (ite (nullable.val (as nullable.null (Nullable Bool))) (as nullable.null (Nullable Int)) (nullable.some 2)))))
; q2
(get-value (q2))
; (set.singleton (tuple false))
; insert into T values('C','D',6,-6,7,-7,NULL,NULL,8),('A','B',-3,4,-4,5,NULL,NULL,-5)
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

(declare-const T (Set (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple Bool)))
(declare-const q2 (Set (Tuple Bool)))
(declare-const f0 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple Bool)))
(declare-const f1 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple Bool)))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.is_null (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_61676 Int) (BOUND_VARIABLE_61677 Int)) (= BOUND_VARIABLE_61676 BOUND_VARIABLE_61677)) ((_ tuple.select 6) t) (nullable.some 100))) ((_ tuple.select 7) t) (nullable.some 2)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple false))))
(assert (= q1 (set.map f0 T)))
(assert (= q2 (set.map f1 T)))
(check-sat)
;answer: sat
; duration: 56 ms.
(get-model)
; (
; (define-fun T () (Set (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some "C") (nullable.some "D") (nullable.some 6) (nullable.some (- 6)) (nullable.some 7) (nullable.some (- 7)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (nullable.some 8))) (set.singleton (tuple (nullable.some "A") (nullable.some "B") (nullable.some (- 3)) (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (nullable.some (- 5))))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.is_null (ite (nullable.val (as nullable.null (Nullable Bool))) (as nullable.null (Nullable Int)) (nullable.some 2)))))
; q2
(get-value (q2))
; (set.singleton (tuple false))
; insert into T values('C','D',6,-6,7,-7,NULL,NULL,8),('A','B',-3,4,-4,5,NULL,NULL,-5)
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_62606 Bool)) (not BOUND_VARIABLE_62606)) (as nullable.null (Nullable Bool)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_null (as nullable.null (Nullable Bool))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t)))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 ((_ rel.project 0) DEPT)))
(check-sat)
;answer: unsat
; duration: 14 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable String))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable String))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable String))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_62846 String)) (str.to_upper BOUND_VARIABLE_62846)) (nullable.lift (lambda ((BOUND_VARIABLE_62840 String)) (str.to_lower BOUND_VARIABLE_62840)) ((_ tuple.select 1) t)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_62861 String)) (str.to_upper BOUND_VARIABLE_62861)) ((_ tuple.select 1) t))))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 (set.map f1 DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10018 ms.
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

(declare-const ACCOUNT (Set (Tuple (Nullable Int) (Nullable String) (Nullable String))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable String)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_90168 Bool) (BOUND_VARIABLE_90169 Bool)) (and BOUND_VARIABLE_90168 BOUND_VARIABLE_90169)) (nullable.lift (lambda ((BOUND_VARIABLE_90155 Int) (BOUND_VARIABLE_90156 Int)) (= BOUND_VARIABLE_90155 BOUND_VARIABLE_90156)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_90162 Int) (BOUND_VARIABLE_90163 Int)) (= BOUND_VARIABLE_90162 BOUND_VARIABLE_90163)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_90168 Bool) (BOUND_VARIABLE_90169 Bool)) (and BOUND_VARIABLE_90168 BOUND_VARIABLE_90169)) (nullable.lift (lambda ((BOUND_VARIABLE_90155 Int) (BOUND_VARIABLE_90156 Int)) (= BOUND_VARIABLE_90155 BOUND_VARIABLE_90156)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_90162 Int) (BOUND_VARIABLE_90163 Int)) (= BOUND_VARIABLE_90162 BOUND_VARIABLE_90163)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_90239 Int) (BOUND_VARIABLE_90240 Int)) (= BOUND_VARIABLE_90239 BOUND_VARIABLE_90240)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_90239 Int) (BOUND_VARIABLE_90240 Int)) (= BOUND_VARIABLE_90239 BOUND_VARIABLE_90240)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_90313 Int) (BOUND_VARIABLE_90314 Int)) (= BOUND_VARIABLE_90313 BOUND_VARIABLE_90314)) ((_ tuple.select 0) t) ((_ tuple.select 12) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_90313 Int) (BOUND_VARIABLE_90314 Int)) (= BOUND_VARIABLE_90313 BOUND_VARIABLE_90314)) ((_ tuple.select 0) t) ((_ tuple.select 12) t)))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13) (set.filter p0 (rel.product (rel.product EMP DEPT) ACCOUNT)))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 12 13 9 10 11) (set.filter p2 (rel.product (set.filter p1 (rel.product EMP ACCOUNT)) DEPT)))))
(check-sat)
;answer: unsat
; duration: 259 ms.
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

(declare-const T (Set (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const leftJoin1 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_92412 Int) (BOUND_VARIABLE_92413 Int)) (= BOUND_VARIABLE_92412 BOUND_VARIABLE_92413)) ((_ tuple.select 6) t) ((_ tuple.select 14) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_92412 Int) (BOUND_VARIABLE_92413 Int)) (= BOUND_VARIABLE_92412 BOUND_VARIABLE_92413)) ((_ tuple.select 6) t) ((_ tuple.select 14) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= p2 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_92472 Int) (BOUND_VARIABLE_92473 Int)) (< BOUND_VARIABLE_92472 BOUND_VARIABLE_92473)) ((_ tuple.select 15) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_92472 Int) (BOUND_VARIABLE_92473 Int)) (< BOUND_VARIABLE_92472 BOUND_VARIABLE_92473)) ((_ tuple.select 15) t) (nullable.some 1)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_92507 Int) (BOUND_VARIABLE_92508 Int)) (< BOUND_VARIABLE_92507 BOUND_VARIABLE_92508)) ((_ tuple.select 6) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_92507 Int) (BOUND_VARIABLE_92508 Int)) (< BOUND_VARIABLE_92507 BOUND_VARIABLE_92508)) ((_ tuple.select 6) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p4 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_92571 Int) (BOUND_VARIABLE_92572 Int)) (= BOUND_VARIABLE_92571 BOUND_VARIABLE_92572)) ((_ tuple.select 6) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_92571 Int) (BOUND_VARIABLE_92572 Int)) (= BOUND_VARIABLE_92571 BOUND_VARIABLE_92572)) ((_ tuple.select 6) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ rel.project 6 5) (set.filter p2 (set.union (set.map leftJoin1 (set.minus T ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 (rel.product T T))))) (set.filter p0 (rel.product T T)))))))
(assert (= q2 ((_ rel.project 6 5) (set.filter p4 (rel.product T ((_ rel.project 5) (set.filter p3 T)))))))
(check-sat)
;answer: unsat
; duration: 5839 ms.
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

(declare-const T (Set (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(declare-const leftJoin1 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_133304 Int) (BOUND_VARIABLE_133305 Int)) (= BOUND_VARIABLE_133304 BOUND_VARIABLE_133305)) ((_ tuple.select 6) t) ((_ tuple.select 15) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_133304 Int) (BOUND_VARIABLE_133305 Int)) (= BOUND_VARIABLE_133304 BOUND_VARIABLE_133305)) ((_ tuple.select 6) t) ((_ tuple.select 15) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= q1 ((_ rel.project 0) ((_ rel.project 5) (set.union (set.map leftJoin1 (set.minus T ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 (rel.product T T))))) (set.filter p0 (rel.product T T)))))))
(assert (= q2 ((_ rel.project 0) ((_ rel.project 5) T))))
(check-sat)
;answer: unsat
; duration: 367 ms.
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

(declare-const T (Set (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_135987 Int) (BOUND_VARIABLE_135988 Int)) (= BOUND_VARIABLE_135987 BOUND_VARIABLE_135988)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_135987 Int) (BOUND_VARIABLE_135988 Int)) (= BOUND_VARIABLE_135987 BOUND_VARIABLE_135988)) ((_ tuple.select 6) t) (nullable.some 0)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_136007 Int) (BOUND_VARIABLE_136008 Int)) (= BOUND_VARIABLE_136007 BOUND_VARIABLE_136008)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_136007 Int) (BOUND_VARIABLE_136008 Int)) (= BOUND_VARIABLE_136007 BOUND_VARIABLE_136008)) ((_ tuple.select 6) t) (nullable.some 0)))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 T))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 T))))
(check-sat)
;answer: unsat
; duration: 112 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= q1 ((_ rel.project 0 1) DEPT)))
(assert (= q2 ((_ rel.project 0 1) DEPT)))
(check-sat)
;answer: unsat
; duration: 9 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= q1 ((_ rel.project 0 1) ((_ rel.project 0 1) (set.union ((_ rel.project 0 1) DEPT) ((_ rel.project 0 1) DEPT))))))
(assert (= q2 ((_ rel.project 0 1) ((_ rel.project 0 1) DEPT))))
(check-sat)
;answer: unsat
; duration: 21 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable String))))
(assert (not (= q1 q2)))
(assert (= q1 ((_ rel.project 1) (set.union ((_ rel.project 0 1) DEPT) ((_ rel.project 0 1) DEPT)))))
(assert (= q2 ((_ rel.project 0) (set.union ((_ rel.project 1) DEPT) ((_ rel.project 1) DEPT)))))
(check-sat)
;answer: unsat
; duration: 24 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_137793 Int) (BOUND_VARIABLE_137794 Int)) (> BOUND_VARIABLE_137793 BOUND_VARIABLE_137794)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_137793 Int) (BOUND_VARIABLE_137794 Int)) (> BOUND_VARIABLE_137793 BOUND_VARIABLE_137794)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_137812 Int) (BOUND_VARIABLE_137813 Int)) (> BOUND_VARIABLE_137812 BOUND_VARIABLE_137813)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_137812 Int) (BOUND_VARIABLE_137813 Int)) (> BOUND_VARIABLE_137812 BOUND_VARIABLE_137813)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (= q1 ((_ rel.project 1) (set.filter p0 ((_ rel.project 0 1) DEPT)))))
(assert (= q2 ((_ rel.project 1) (set.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 72 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple Int)))
(declare-const q2 (Set (Tuple Int)))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Int)))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple Int)))
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple 1))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple 1))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 (set.map f1 DEPT)))
(check-sat)
;answer: unsat
; duration: 6 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable String))))
(assert (not (= q1 q2)))
(assert (= q1 ((_ rel.project 1) DEPT)))
(assert (= q2 ((_ rel.project 1) DEPT)))
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_139003 Int) (BOUND_VARIABLE_139004 Int)) (> BOUND_VARIABLE_139003 BOUND_VARIABLE_139004)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_139003 Int) (BOUND_VARIABLE_139004 Int)) (> BOUND_VARIABLE_139003 BOUND_VARIABLE_139004)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_139031 Bool) (BOUND_VARIABLE_139032 Bool)) (and BOUND_VARIABLE_139031 BOUND_VARIABLE_139032)) (nullable.lift (lambda ((BOUND_VARIABLE_139022 Int) (BOUND_VARIABLE_139023 Int)) (> BOUND_VARIABLE_139022 BOUND_VARIABLE_139023)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_139031 Bool) (BOUND_VARIABLE_139032 Bool)) (and BOUND_VARIABLE_139031 BOUND_VARIABLE_139032)) (nullable.lift (lambda ((BOUND_VARIABLE_139022 Int) (BOUND_VARIABLE_139023 Int)) (> BOUND_VARIABLE_139022 BOUND_VARIABLE_139023)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 DEPT))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 56 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 0) t)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_140242 Bool) (BOUND_VARIABLE_140243 Bool)) (and BOUND_VARIABLE_140242 BOUND_VARIABLE_140243)) (nullable.lift (lambda ((BOUND_VARIABLE_140229 Int) (BOUND_VARIABLE_140230 Int)) (= BOUND_VARIABLE_140229 BOUND_VARIABLE_140230)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_140236 Int) (BOUND_VARIABLE_140237 Int)) (= BOUND_VARIABLE_140236 BOUND_VARIABLE_140237)) ((_ tuple.select 9) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_140242 Bool) (BOUND_VARIABLE_140243 Bool)) (and BOUND_VARIABLE_140242 BOUND_VARIABLE_140243)) (nullable.lift (lambda ((BOUND_VARIABLE_140229 Int) (BOUND_VARIABLE_140230 Int)) (= BOUND_VARIABLE_140229 BOUND_VARIABLE_140230)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_140236 Int) (BOUND_VARIABLE_140237 Int)) (= BOUND_VARIABLE_140236 BOUND_VARIABLE_140237)) ((_ tuple.select 9) t) (nullable.some 1))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_140272 Bool) (BOUND_VARIABLE_140273 Bool)) (and BOUND_VARIABLE_140272 BOUND_VARIABLE_140273)) (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))) (nullable.lift (lambda ((BOUND_VARIABLE_140265 Int) (BOUND_VARIABLE_140266 Int)) (= BOUND_VARIABLE_140265 BOUND_VARIABLE_140266)) ((_ tuple.select 0) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_140272 Bool) (BOUND_VARIABLE_140273 Bool)) (and BOUND_VARIABLE_140272 BOUND_VARIABLE_140273)) (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))) (nullable.lift (lambda ((BOUND_VARIABLE_140265 Int) (BOUND_VARIABLE_140266 Int)) (= BOUND_VARIABLE_140265 BOUND_VARIABLE_140266)) ((_ tuple.select 0) t) (nullable.some 1))))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 0) t)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_140317 Bool) (BOUND_VARIABLE_140318 Bool)) (and BOUND_VARIABLE_140317 BOUND_VARIABLE_140318)) (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))) (nullable.lift (lambda ((BOUND_VARIABLE_140310 Int) (BOUND_VARIABLE_140311 Int)) (= BOUND_VARIABLE_140310 BOUND_VARIABLE_140311)) ((_ tuple.select 0) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_140317 Bool) (BOUND_VARIABLE_140318 Bool)) (and BOUND_VARIABLE_140317 BOUND_VARIABLE_140318)) (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))) (nullable.lift (lambda ((BOUND_VARIABLE_140310 Int) (BOUND_VARIABLE_140311 Int)) (= BOUND_VARIABLE_140310 BOUND_VARIABLE_140311)) ((_ tuple.select 0) t) (nullable.some 1))))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_140351 Bool) (BOUND_VARIABLE_140352 Bool)) (and BOUND_VARIABLE_140351 BOUND_VARIABLE_140352)) (nullable.lift (lambda ((BOUND_VARIABLE_140338 Int) (BOUND_VARIABLE_140339 Int)) (= BOUND_VARIABLE_140338 BOUND_VARIABLE_140339)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_140345 Int) (BOUND_VARIABLE_140346 Int)) (= BOUND_VARIABLE_140345 BOUND_VARIABLE_140346)) ((_ tuple.select 9) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_140351 Bool) (BOUND_VARIABLE_140352 Bool)) (and BOUND_VARIABLE_140351 BOUND_VARIABLE_140352)) (nullable.lift (lambda ((BOUND_VARIABLE_140338 Int) (BOUND_VARIABLE_140339 Int)) (= BOUND_VARIABLE_140338 BOUND_VARIABLE_140339)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_140345 Int) (BOUND_VARIABLE_140346 Int)) (= BOUND_VARIABLE_140345 BOUND_VARIABLE_140346)) ((_ tuple.select 9) t) (nullable.some 1))))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 10 11) (set.filter p1 (rel.product (set.map f0 EMP) DEPT)))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 10 11) (set.filter p5 (rel.product (set.map f3 (set.filter p2 EMP)) ((_ rel.project 0 1) (set.filter p4 DEPT)))))))
(check-sat)
;answer: unsat
; duration: 750 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const leftJoin2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const f3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const leftJoin6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 0) t)))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_147884 Bool) (BOUND_VARIABLE_147885 Bool)) (and BOUND_VARIABLE_147884 BOUND_VARIABLE_147885)) (nullable.lift (lambda ((BOUND_VARIABLE_147871 Int) (BOUND_VARIABLE_147872 Int)) (= BOUND_VARIABLE_147871 BOUND_VARIABLE_147872)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_147878 Int) (BOUND_VARIABLE_147879 Int)) (= BOUND_VARIABLE_147878 BOUND_VARIABLE_147879)) ((_ tuple.select 9) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_147884 Bool) (BOUND_VARIABLE_147885 Bool)) (and BOUND_VARIABLE_147884 BOUND_VARIABLE_147885)) (nullable.lift (lambda ((BOUND_VARIABLE_147871 Int) (BOUND_VARIABLE_147872 Int)) (= BOUND_VARIABLE_147871 BOUND_VARIABLE_147872)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_147878 Int) (BOUND_VARIABLE_147879 Int)) (= BOUND_VARIABLE_147878 BOUND_VARIABLE_147879)) ((_ tuple.select 9) t) (nullable.some 1))))))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 9) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 0) t)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_147967 Bool) (BOUND_VARIABLE_147968 Bool)) (and BOUND_VARIABLE_147967 BOUND_VARIABLE_147968)) (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))) (nullable.lift (lambda ((BOUND_VARIABLE_147960 Int) (BOUND_VARIABLE_147961 Int)) (= BOUND_VARIABLE_147960 BOUND_VARIABLE_147961)) ((_ tuple.select 0) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_147967 Bool) (BOUND_VARIABLE_147968 Bool)) (and BOUND_VARIABLE_147967 BOUND_VARIABLE_147968)) (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))) (nullable.lift (lambda ((BOUND_VARIABLE_147960 Int) (BOUND_VARIABLE_147961 Int)) (= BOUND_VARIABLE_147960 BOUND_VARIABLE_147961)) ((_ tuple.select 0) t) (nullable.some 1))))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_148001 Bool) (BOUND_VARIABLE_148002 Bool)) (and BOUND_VARIABLE_148001 BOUND_VARIABLE_148002)) (nullable.lift (lambda ((BOUND_VARIABLE_147988 Int) (BOUND_VARIABLE_147989 Int)) (= BOUND_VARIABLE_147988 BOUND_VARIABLE_147989)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_147995 Int) (BOUND_VARIABLE_147996 Int)) (= BOUND_VARIABLE_147995 BOUND_VARIABLE_147996)) ((_ tuple.select 9) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_148001 Bool) (BOUND_VARIABLE_148002 Bool)) (and BOUND_VARIABLE_148001 BOUND_VARIABLE_148002)) (nullable.lift (lambda ((BOUND_VARIABLE_147988 Int) (BOUND_VARIABLE_147989 Int)) (= BOUND_VARIABLE_147988 BOUND_VARIABLE_147989)) ((_ tuple.select 0) t) ((_ tuple.select 10) t)) (nullable.lift (lambda ((BOUND_VARIABLE_147995 Int) (BOUND_VARIABLE_147996 Int)) (= BOUND_VARIABLE_147995 BOUND_VARIABLE_147996)) ((_ tuple.select 9) t) (nullable.some 1))))))))
(assert (= leftJoin6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 9) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 10 11) (set.union (set.map leftJoin2 (set.minus (set.map f0 EMP) ((_ rel.project 0 1 2 3 4 5 6 7 8 9) (set.filter p1 (rel.product (set.map f0 EMP) DEPT))))) (set.filter p1 (rel.product (set.map f0 EMP) DEPT))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 10 11) (set.union (set.map leftJoin6 (set.minus (set.map f3 EMP) ((_ rel.project 0 1 2 3 4 5 6 7 8 9) (set.filter p5 (rel.product (set.map f3 EMP) ((_ rel.project 0 1) (set.filter p4 DEPT))))))) (set.filter p5 (rel.product (set.map f3 EMP) ((_ rel.project 0 1) (set.filter p4 DEPT))))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10023 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_205034 Int) (BOUND_VARIABLE_205035 Int)) (= BOUND_VARIABLE_205034 BOUND_VARIABLE_205035)) ((_ tuple.select 6) t) (nullable.some 3))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_205034 Int) (BOUND_VARIABLE_205035 Int)) (= BOUND_VARIABLE_205034 BOUND_VARIABLE_205035)) ((_ tuple.select 6) t) (nullable.some 3)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_205055 Int) (BOUND_VARIABLE_205056 Int)) (> BOUND_VARIABLE_205055 BOUND_VARIABLE_205056)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_205055 Int) (BOUND_VARIABLE_205056 Int)) (> BOUND_VARIABLE_205055 BOUND_VARIABLE_205056)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_205088 Bool) (BOUND_VARIABLE_205089 Bool)) (and BOUND_VARIABLE_205088 BOUND_VARIABLE_205089)) (nullable.lift (lambda ((BOUND_VARIABLE_205075 Int) (BOUND_VARIABLE_205076 Int)) (= BOUND_VARIABLE_205075 BOUND_VARIABLE_205076)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_205082 Int) (BOUND_VARIABLE_205083 Int)) (> BOUND_VARIABLE_205082 BOUND_VARIABLE_205083)) ((_ tuple.select 0) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_205088 Bool) (BOUND_VARIABLE_205089 Bool)) (and BOUND_VARIABLE_205088 BOUND_VARIABLE_205089)) (nullable.lift (lambda ((BOUND_VARIABLE_205075 Int) (BOUND_VARIABLE_205076 Int)) (= BOUND_VARIABLE_205075 BOUND_VARIABLE_205076)) ((_ tuple.select 6) t) (nullable.some 3)) (nullable.lift (lambda ((BOUND_VARIABLE_205082 Int) (BOUND_VARIABLE_205083 Int)) (> BOUND_VARIABLE_205082 BOUND_VARIABLE_205083)) ((_ tuple.select 0) t) (nullable.some 1))))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p1 ((_ rel.project 0 6) (set.filter p0 EMP))))))
(assert (= q2 ((_ rel.project 0 6) (set.filter p2 EMP))))
(check-sat)
;answer: unsat
; duration: 353 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP)))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) EMP)))
(check-sat)
;answer: unsat
; duration: 7 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_207244 Int) (BOUND_VARIABLE_207245 Int)) (> BOUND_VARIABLE_207244 BOUND_VARIABLE_207245)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_207244 Int) (BOUND_VARIABLE_207245 Int)) (> BOUND_VARIABLE_207244 BOUND_VARIABLE_207245)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_207264 Int) (BOUND_VARIABLE_207265 Int)) (> BOUND_VARIABLE_207264 BOUND_VARIABLE_207265)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_207264 Int) (BOUND_VARIABLE_207265 Int)) (> BOUND_VARIABLE_207264 BOUND_VARIABLE_207265)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_207283 Int) (BOUND_VARIABLE_207284 Int)) (> BOUND_VARIABLE_207283 BOUND_VARIABLE_207284)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_207283 Int) (BOUND_VARIABLE_207284 Int)) (> BOUND_VARIABLE_207283 BOUND_VARIABLE_207284)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP))))
(check-sat)
;answer: unsat
; duration: 103 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_208883 Int) (BOUND_VARIABLE_208884 Int)) (> BOUND_VARIABLE_208883 BOUND_VARIABLE_208884)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_208883 Int) (BOUND_VARIABLE_208884 Int)) (> BOUND_VARIABLE_208883 BOUND_VARIABLE_208884)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_208914 Bool) (BOUND_VARIABLE_208915 Bool)) (and BOUND_VARIABLE_208914 BOUND_VARIABLE_208915)) (nullable.lift (lambda ((BOUND_VARIABLE_208902 Int) (BOUND_VARIABLE_208903 Int)) (> BOUND_VARIABLE_208902 BOUND_VARIABLE_208903)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_208908 Int) (BOUND_VARIABLE_208909 Int)) (> BOUND_VARIABLE_208908 BOUND_VARIABLE_208909)) ((_ tuple.select 0) t) (nullable.some 0)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_208914 Bool) (BOUND_VARIABLE_208915 Bool)) (and BOUND_VARIABLE_208914 BOUND_VARIABLE_208915)) (nullable.lift (lambda ((BOUND_VARIABLE_208902 Int) (BOUND_VARIABLE_208903 Int)) (> BOUND_VARIABLE_208902 BOUND_VARIABLE_208903)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_208908 Int) (BOUND_VARIABLE_208909 Int)) (> BOUND_VARIABLE_208908 BOUND_VARIABLE_208909)) ((_ tuple.select 0) t) (nullable.some 0))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_208933 Int) (BOUND_VARIABLE_208934 Int)) (> BOUND_VARIABLE_208933 BOUND_VARIABLE_208934)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_208933 Int) (BOUND_VARIABLE_208934 Int)) (> BOUND_VARIABLE_208933 BOUND_VARIABLE_208934)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_208952 Int) (BOUND_VARIABLE_208953 Int)) (> BOUND_VARIABLE_208952 BOUND_VARIABLE_208953)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_208952 Int) (BOUND_VARIABLE_208953 Int)) (> BOUND_VARIABLE_208952 BOUND_VARIABLE_208953)) ((_ tuple.select 0) t) (nullable.some 0)))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP))))))
(check-sat)
;answer: unsat
; duration: 250 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_212054 Int) (BOUND_VARIABLE_212055 Int)) (> BOUND_VARIABLE_212054 BOUND_VARIABLE_212055)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_212054 Int) (BOUND_VARIABLE_212055 Int)) (> BOUND_VARIABLE_212054 BOUND_VARIABLE_212055)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_212092 Bool) (BOUND_VARIABLE_212093 Bool) (BOUND_VARIABLE_212094 Bool)) (and BOUND_VARIABLE_212092 BOUND_VARIABLE_212093 BOUND_VARIABLE_212094)) (nullable.lift (lambda ((BOUND_VARIABLE_212073 Int) (BOUND_VARIABLE_212074 Int)) (> BOUND_VARIABLE_212073 BOUND_VARIABLE_212074)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_212079 Int) (BOUND_VARIABLE_212080 Int)) (> BOUND_VARIABLE_212079 BOUND_VARIABLE_212080)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_212086 Int) (BOUND_VARIABLE_212087 Int)) (> BOUND_VARIABLE_212086 BOUND_VARIABLE_212087)) ((_ tuple.select 6) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_212092 Bool) (BOUND_VARIABLE_212093 Bool) (BOUND_VARIABLE_212094 Bool)) (and BOUND_VARIABLE_212092 BOUND_VARIABLE_212093 BOUND_VARIABLE_212094)) (nullable.lift (lambda ((BOUND_VARIABLE_212073 Int) (BOUND_VARIABLE_212074 Int)) (> BOUND_VARIABLE_212073 BOUND_VARIABLE_212074)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_212079 Int) (BOUND_VARIABLE_212080 Int)) (> BOUND_VARIABLE_212079 BOUND_VARIABLE_212080)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_212086 Int) (BOUND_VARIABLE_212087 Int)) (> BOUND_VARIABLE_212086 BOUND_VARIABLE_212087)) ((_ tuple.select 6) t) (nullable.some 1))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_212112 Int) (BOUND_VARIABLE_212113 Int)) (> BOUND_VARIABLE_212112 BOUND_VARIABLE_212113)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_212112 Int) (BOUND_VARIABLE_212113 Int)) (> BOUND_VARIABLE_212112 BOUND_VARIABLE_212113)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_212144 Bool) (BOUND_VARIABLE_212145 Bool)) (and BOUND_VARIABLE_212144 BOUND_VARIABLE_212145)) (nullable.lift (lambda ((BOUND_VARIABLE_212131 Int) (BOUND_VARIABLE_212132 Int)) (> BOUND_VARIABLE_212131 BOUND_VARIABLE_212132)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_212138 Int) (BOUND_VARIABLE_212139 Int)) (> BOUND_VARIABLE_212138 BOUND_VARIABLE_212139)) ((_ tuple.select 6) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_212144 Bool) (BOUND_VARIABLE_212145 Bool)) (and BOUND_VARIABLE_212144 BOUND_VARIABLE_212145)) (nullable.lift (lambda ((BOUND_VARIABLE_212131 Int) (BOUND_VARIABLE_212132 Int)) (> BOUND_VARIABLE_212131 BOUND_VARIABLE_212132)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_212138 Int) (BOUND_VARIABLE_212139 Int)) (> BOUND_VARIABLE_212138 BOUND_VARIABLE_212139)) ((_ tuple.select 6) t) (nullable.some 1))))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP))))))
(check-sat)
;answer: unsat
; duration: 262 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_216249 Int) (BOUND_VARIABLE_216250 Int)) (= BOUND_VARIABLE_216249 BOUND_VARIABLE_216250)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_216249 Int) (BOUND_VARIABLE_216250 Int)) (= BOUND_VARIABLE_216249 BOUND_VARIABLE_216250)) ((_ tuple.select 0) t) (nullable.some 0)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_216268 Int) (BOUND_VARIABLE_216269 Int)) (= BOUND_VARIABLE_216268 BOUND_VARIABLE_216269)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_216268 Int) (BOUND_VARIABLE_216269 Int)) (= BOUND_VARIABLE_216268 BOUND_VARIABLE_216269)) ((_ tuple.select 0) t) (nullable.some 0)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_216287 Int) (BOUND_VARIABLE_216288 Int)) (= BOUND_VARIABLE_216287 BOUND_VARIABLE_216288)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_216287 Int) (BOUND_VARIABLE_216288 Int)) (= BOUND_VARIABLE_216287 BOUND_VARIABLE_216288)) ((_ tuple.select 0) t) (nullable.some 0)))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 (set.union ((_ rel.project 0 1) DEPT) ((_ rel.project 0 1) DEPT))))))
(assert (= q2 (set.union ((_ rel.project 0 1) (set.filter p1 DEPT)) ((_ rel.project 0 1) (set.filter p2 DEPT)))))
(check-sat)
;answer: unsat
; duration: 159 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_217850 Int) (BOUND_VARIABLE_217851 Int)) (> BOUND_VARIABLE_217850 BOUND_VARIABLE_217851)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_217850 Int) (BOUND_VARIABLE_217851 Int)) (> BOUND_VARIABLE_217850 BOUND_VARIABLE_217851)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_217870 Int) (BOUND_VARIABLE_217871 Int)) (> BOUND_VARIABLE_217870 BOUND_VARIABLE_217871)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_217870 Int) (BOUND_VARIABLE_217871 Int)) (> BOUND_VARIABLE_217870 BOUND_VARIABLE_217871)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= q1 ((_ rel.project 0) (set.filter p0 ((_ rel.project 0) DEPT)))))
(assert (= q2 ((_ rel.project 0) (set.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 60 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_218743 Int) (BOUND_VARIABLE_218744 Int)) (> BOUND_VARIABLE_218743 BOUND_VARIABLE_218744)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_218743 Int) (BOUND_VARIABLE_218744 Int)) (> BOUND_VARIABLE_218743 BOUND_VARIABLE_218744)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_218762 Int) (BOUND_VARIABLE_218763 Int)) (> BOUND_VARIABLE_218762 BOUND_VARIABLE_218763)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_218762 Int) (BOUND_VARIABLE_218763 Int)) (> BOUND_VARIABLE_218762 BOUND_VARIABLE_218763)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= q1 ((_ rel.project 0) (set.filter p0 ((_ rel.project 0) ((_ rel.project 0) DEPT))))))
(assert (= q2 ((_ rel.project 0) ((_ rel.project 0) (set.filter p1 DEPT)))))
(check-sat)
;answer: unsat
; duration: 81 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const rightJoin1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const rightJoin5 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_219815 Int) (BOUND_VARIABLE_219816 Int)) (= BOUND_VARIABLE_219815 BOUND_VARIABLE_219816)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_219815 Int) (BOUND_VARIABLE_219816 Int)) (= BOUND_VARIABLE_219815 BOUND_VARIABLE_219816)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_219875 Bool) (BOUND_VARIABLE_219876 Bool)) (and BOUND_VARIABLE_219875 BOUND_VARIABLE_219876)) (nullable.lift (lambda ((BOUND_VARIABLE_219862 Int) (BOUND_VARIABLE_219863 Int)) (> BOUND_VARIABLE_219862 BOUND_VARIABLE_219863)) ((_ tuple.select 6) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_219869 Int) (BOUND_VARIABLE_219870 Int)) (= BOUND_VARIABLE_219869 BOUND_VARIABLE_219870)) ((_ tuple.select 9) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_219875 Bool) (BOUND_VARIABLE_219876 Bool)) (and BOUND_VARIABLE_219875 BOUND_VARIABLE_219876)) (nullable.lift (lambda ((BOUND_VARIABLE_219862 Int) (BOUND_VARIABLE_219863 Int)) (> BOUND_VARIABLE_219862 BOUND_VARIABLE_219863)) ((_ tuple.select 6) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_219869 Int) (BOUND_VARIABLE_219870 Int)) (= BOUND_VARIABLE_219869 BOUND_VARIABLE_219870)) ((_ tuple.select 9) t) (nullable.some 1))))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_219895 Int) (BOUND_VARIABLE_219896 Int)) (= BOUND_VARIABLE_219895 BOUND_VARIABLE_219896)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_219895 Int) (BOUND_VARIABLE_219896 Int)) (= BOUND_VARIABLE_219895 BOUND_VARIABLE_219896)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_219916 Int) (BOUND_VARIABLE_219917 Int)) (= BOUND_VARIABLE_219916 BOUND_VARIABLE_219917)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_219916 Int) (BOUND_VARIABLE_219917 Int)) (= BOUND_VARIABLE_219916 BOUND_VARIABLE_219917)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_219960 Int) (BOUND_VARIABLE_219961 Int)) (> BOUND_VARIABLE_219960 BOUND_VARIABLE_219961)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_219960 Int) (BOUND_VARIABLE_219961 Int)) (> BOUND_VARIABLE_219960 BOUND_VARIABLE_219961)) ((_ tuple.select 6) t) (nullable.some 0)))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p2 (set.union (set.map rightJoin1 (set.minus DEPT ((_ rel.project 9 10) (set.filter p0 (rel.product EMP DEPT))))) (set.filter p0 (rel.product EMP DEPT)))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p6 (set.union (set.map rightJoin5 (set.minus ((_ rel.project 0 1) (set.filter p3 DEPT)) ((_ rel.project 9 10) (set.filter p4 (rel.product EMP ((_ rel.project 0 1) (set.filter p3 DEPT))))))) (set.filter p4 (rel.product EMP ((_ rel.project 0 1) (set.filter p3 DEPT)))))))))
(check-sat)
;answer: unsat
; duration: 1125 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const leftJoin1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const leftJoin5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_228746 Int) (BOUND_VARIABLE_228747 Int)) (= BOUND_VARIABLE_228746 BOUND_VARIABLE_228747)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_228746 Int) (BOUND_VARIABLE_228747 Int)) (= BOUND_VARIABLE_228746 BOUND_VARIABLE_228747)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_228812 Bool) (BOUND_VARIABLE_228813 Bool)) (and BOUND_VARIABLE_228812 BOUND_VARIABLE_228813)) (nullable.lift (lambda ((BOUND_VARIABLE_228799 Int) (BOUND_VARIABLE_228800 Int)) (> BOUND_VARIABLE_228799 BOUND_VARIABLE_228800)) ((_ tuple.select 6) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_228806 Int) (BOUND_VARIABLE_228807 Int)) (= BOUND_VARIABLE_228806 BOUND_VARIABLE_228807)) ((_ tuple.select 9) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_228812 Bool) (BOUND_VARIABLE_228813 Bool)) (and BOUND_VARIABLE_228812 BOUND_VARIABLE_228813)) (nullable.lift (lambda ((BOUND_VARIABLE_228799 Int) (BOUND_VARIABLE_228800 Int)) (> BOUND_VARIABLE_228799 BOUND_VARIABLE_228800)) ((_ tuple.select 6) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_228806 Int) (BOUND_VARIABLE_228807 Int)) (= BOUND_VARIABLE_228806 BOUND_VARIABLE_228807)) ((_ tuple.select 9) t) (nullable.some 1))))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_228831 Int) (BOUND_VARIABLE_228832 Int)) (> BOUND_VARIABLE_228831 BOUND_VARIABLE_228832)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_228831 Int) (BOUND_VARIABLE_228832 Int)) (> BOUND_VARIABLE_228831 BOUND_VARIABLE_228832)) ((_ tuple.select 6) t) (nullable.some 0)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_228852 Int) (BOUND_VARIABLE_228853 Int)) (= BOUND_VARIABLE_228852 BOUND_VARIABLE_228853)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_228852 Int) (BOUND_VARIABLE_228853 Int)) (= BOUND_VARIABLE_228852 BOUND_VARIABLE_228853)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_228903 Int) (BOUND_VARIABLE_228904 Int)) (= BOUND_VARIABLE_228903 BOUND_VARIABLE_228904)) ((_ tuple.select 9) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_228903 Int) (BOUND_VARIABLE_228904 Int)) (= BOUND_VARIABLE_228903 BOUND_VARIABLE_228904)) ((_ tuple.select 9) t) (nullable.some 1)))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p2 (set.union (set.map leftJoin1 (set.minus EMP ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 (rel.product EMP DEPT))))) (set.filter p0 (rel.product EMP DEPT)))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p6 (set.union (set.map leftJoin5 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) DEPT))))) (set.filter p4 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) DEPT)))))))
(check-sat)
;answer: unsat
; duration: 1428 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_239541 Int) (BOUND_VARIABLE_239542 Int)) (> BOUND_VARIABLE_239541 BOUND_VARIABLE_239542)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_239683 Bool) (BOUND_VARIABLE_239684 Bool) (BOUND_VARIABLE_239685 Bool)) (and BOUND_VARIABLE_239683 BOUND_VARIABLE_239684 BOUND_VARIABLE_239685)) (nullable.lift (lambda ((BOUND_VARIABLE_239669 Int) (BOUND_VARIABLE_239670 Int)) (= BOUND_VARIABLE_239669 BOUND_VARIABLE_239670)) ((_ tuple.select 7) t) ((_ tuple.select 10) t)) ((_ tuple.select 9) t) (nullable.lift (lambda ((BOUND_VARIABLE_239677 Int) (BOUND_VARIABLE_239678 Int)) (= BOUND_VARIABLE_239677 BOUND_VARIABLE_239678)) ((_ tuple.select 12) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_239683 Bool) (BOUND_VARIABLE_239684 Bool) (BOUND_VARIABLE_239685 Bool)) (and BOUND_VARIABLE_239683 BOUND_VARIABLE_239684 BOUND_VARIABLE_239685)) (nullable.lift (lambda ((BOUND_VARIABLE_239669 Int) (BOUND_VARIABLE_239670 Int)) (= BOUND_VARIABLE_239669 BOUND_VARIABLE_239670)) ((_ tuple.select 7) t) ((_ tuple.select 10) t)) ((_ tuple.select 9) t) (nullable.lift (lambda ((BOUND_VARIABLE_239677 Int) (BOUND_VARIABLE_239678 Int)) (= BOUND_VARIABLE_239677 BOUND_VARIABLE_239678)) ((_ tuple.select 12) t) (nullable.some 1))))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_239704 Int) (BOUND_VARIABLE_239705 Int)) (> BOUND_VARIABLE_239704 BOUND_VARIABLE_239705)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_239704 Int) (BOUND_VARIABLE_239705 Int)) (> BOUND_VARIABLE_239704 BOUND_VARIABLE_239705)) ((_ tuple.select 6) t) (nullable.some 0)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_239723 Int) (BOUND_VARIABLE_239724 Int)) (= BOUND_VARIABLE_239723 BOUND_VARIABLE_239724)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_239723 Int) (BOUND_VARIABLE_239724 Int)) (= BOUND_VARIABLE_239723 BOUND_VARIABLE_239724)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_239744 Int) (BOUND_VARIABLE_239745 Int)) (= BOUND_VARIABLE_239744 BOUND_VARIABLE_239745)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_239744 Int) (BOUND_VARIABLE_239745 Int)) (= BOUND_VARIABLE_239744 BOUND_VARIABLE_239745)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 10 11) (set.filter p2 (rel.product (set.map f0 EMP) (set.map f1 DEPT))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p5 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1) (set.filter p4 DEPT)))))))
(check-sat)
;answer: unsat
; duration: 376 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const rightJoin7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const rightJoin3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const f5 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_243942 Int) (BOUND_VARIABLE_243943 Int)) (> BOUND_VARIABLE_243942 BOUND_VARIABLE_243943)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_243986 Bool) (BOUND_VARIABLE_243987 Bool) (BOUND_VARIABLE_243988 Bool)) (and BOUND_VARIABLE_243986 BOUND_VARIABLE_243987 BOUND_VARIABLE_243988)) (nullable.lift (lambda ((BOUND_VARIABLE_243972 Int) (BOUND_VARIABLE_243973 Int)) (= BOUND_VARIABLE_243972 BOUND_VARIABLE_243973)) ((_ tuple.select 7) t) ((_ tuple.select 10) t)) ((_ tuple.select 9) t) (nullable.lift (lambda ((BOUND_VARIABLE_243980 Int) (BOUND_VARIABLE_243981 Int)) (= BOUND_VARIABLE_243980 BOUND_VARIABLE_243981)) ((_ tuple.select 12) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_243986 Bool) (BOUND_VARIABLE_243987 Bool) (BOUND_VARIABLE_243988 Bool)) (and BOUND_VARIABLE_243986 BOUND_VARIABLE_243987 BOUND_VARIABLE_243988)) (nullable.lift (lambda ((BOUND_VARIABLE_243972 Int) (BOUND_VARIABLE_243973 Int)) (= BOUND_VARIABLE_243972 BOUND_VARIABLE_243973)) ((_ tuple.select 7) t) ((_ tuple.select 10) t)) ((_ tuple.select 9) t) (nullable.lift (lambda ((BOUND_VARIABLE_243980 Int) (BOUND_VARIABLE_243981 Int)) (= BOUND_VARIABLE_243980 BOUND_VARIABLE_243981)) ((_ tuple.select 12) t) (nullable.some 1))))))))
(assert (= rightJoin3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Bool)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_244037 Int) (BOUND_VARIABLE_244038 Int)) (> BOUND_VARIABLE_244037 BOUND_VARIABLE_244038)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_244037 Int) (BOUND_VARIABLE_244038 Int)) (> BOUND_VARIABLE_244037 BOUND_VARIABLE_244038)) ((_ tuple.select 6) t) (nullable.some 0)))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_244129 Bool) (BOUND_VARIABLE_244130 Bool)) (and BOUND_VARIABLE_244129 BOUND_VARIABLE_244130)) (nullable.lift (lambda ((BOUND_VARIABLE_244116 Int) (BOUND_VARIABLE_244117 Int)) (= BOUND_VARIABLE_244116 BOUND_VARIABLE_244117)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_244123 Int) (BOUND_VARIABLE_244124 Int)) (= BOUND_VARIABLE_244123 BOUND_VARIABLE_244124)) ((_ tuple.select 11) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_244129 Bool) (BOUND_VARIABLE_244130 Bool)) (and BOUND_VARIABLE_244129 BOUND_VARIABLE_244130)) (nullable.lift (lambda ((BOUND_VARIABLE_244116 Int) (BOUND_VARIABLE_244117 Int)) (= BOUND_VARIABLE_244116 BOUND_VARIABLE_244117)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_244123 Int) (BOUND_VARIABLE_244124 Int)) (= BOUND_VARIABLE_244123 BOUND_VARIABLE_244124)) ((_ tuple.select 11) t) (nullable.some 1))))))))
(assert (= rightJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 10 11) (set.union (set.map rightJoin3 (set.minus (set.map f1 DEPT) ((_ rel.project 10 11 12) (set.filter p2 (rel.product (set.map f0 EMP) (set.map f1 DEPT)))))) (set.filter p2 (rel.product (set.map f0 EMP) (set.map f1 DEPT)))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map rightJoin7 (set.minus (set.map f5 DEPT) ((_ rel.project 9 10 11) (set.filter p6 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)) (set.map f5 DEPT)))))) (set.filter p6 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)) (set.map f5 DEPT)))))))
(check-sat)
;answer: unsat
; duration: 9905 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String)) Bool))
(declare-const leftJoin3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const leftJoin7 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String))))
(declare-const f4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_290044 Int) (BOUND_VARIABLE_290045 Int)) (> BOUND_VARIABLE_290044 BOUND_VARIABLE_290045)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_290089 Bool) (BOUND_VARIABLE_290090 Bool) (BOUND_VARIABLE_290091 Bool)) (and BOUND_VARIABLE_290089 BOUND_VARIABLE_290090 BOUND_VARIABLE_290091)) (nullable.lift (lambda ((BOUND_VARIABLE_290075 Int) (BOUND_VARIABLE_290076 Int)) (= BOUND_VARIABLE_290075 BOUND_VARIABLE_290076)) ((_ tuple.select 7) t) ((_ tuple.select 10) t)) ((_ tuple.select 9) t) (nullable.lift (lambda ((BOUND_VARIABLE_290083 Int) (BOUND_VARIABLE_290084 Int)) (= BOUND_VARIABLE_290083 BOUND_VARIABLE_290084)) ((_ tuple.select 12) t) (nullable.some 1)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_290089 Bool) (BOUND_VARIABLE_290090 Bool) (BOUND_VARIABLE_290091 Bool)) (and BOUND_VARIABLE_290089 BOUND_VARIABLE_290090 BOUND_VARIABLE_290091)) (nullable.lift (lambda ((BOUND_VARIABLE_290075 Int) (BOUND_VARIABLE_290076 Int)) (= BOUND_VARIABLE_290075 BOUND_VARIABLE_290076)) ((_ tuple.select 7) t) ((_ tuple.select 10) t)) ((_ tuple.select 9) t) (nullable.lift (lambda ((BOUND_VARIABLE_290083 Int) (BOUND_VARIABLE_290084 Int)) (= BOUND_VARIABLE_290083 BOUND_VARIABLE_290084)) ((_ tuple.select 12) t) (nullable.some 1))))))))
(assert (= leftJoin3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 9) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_290154 Int) (BOUND_VARIABLE_290155 Int)) (> BOUND_VARIABLE_290154 BOUND_VARIABLE_290155)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_290170 Int) (BOUND_VARIABLE_290171 Int)) (= BOUND_VARIABLE_290170 BOUND_VARIABLE_290171)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_290170 Int) (BOUND_VARIABLE_290171 Int)) (= BOUND_VARIABLE_290170 BOUND_VARIABLE_290171)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_290247 Bool) (BOUND_VARIABLE_290248 Bool)) (and BOUND_VARIABLE_290247 BOUND_VARIABLE_290248)) (nullable.lift (lambda ((BOUND_VARIABLE_290240 Int) (BOUND_VARIABLE_290241 Int)) (= BOUND_VARIABLE_290240 BOUND_VARIABLE_290241)) ((_ tuple.select 7) t) ((_ tuple.select 10) t)) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_290247 Bool) (BOUND_VARIABLE_290248 Bool)) (and BOUND_VARIABLE_290247 BOUND_VARIABLE_290248)) (nullable.lift (lambda ((BOUND_VARIABLE_290240 Int) (BOUND_VARIABLE_290241 Int)) (= BOUND_VARIABLE_290240 BOUND_VARIABLE_290241)) ((_ tuple.select 7) t) ((_ tuple.select 10) t)) ((_ tuple.select 9) t)))))))
(assert (= leftJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 9) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 10 11) (set.union (set.map leftJoin3 (set.minus (set.map f0 EMP) ((_ rel.project 0 1 2 3 4 5 6 7 8 9) (set.filter p2 (rel.product (set.map f0 EMP) (set.map f1 DEPT)))))) (set.filter p2 (rel.product (set.map f0 EMP) (set.map f1 DEPT)))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 10 11) (set.union (set.map leftJoin7 (set.minus (set.map f4 EMP) ((_ rel.project 0 1 2 3 4 5 6 7 8 9) (set.filter p6 (rel.product (set.map f4 EMP) ((_ rel.project 0 1) (set.filter p5 DEPT))))))) (set.filter p6 (rel.product (set.map f4 EMP) ((_ rel.project 0 1) (set.filter p5 DEPT))))))))
(check-sat)
;answer: unsat
; duration: 6901 ms.
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

(declare-const q1 (Set (Tuple Int)))
(declare-const q2 (Set (Tuple Int)))
(assert (not (= q1 q2)))
(assert (= q1 ((_ rel.project 0) (set.singleton (tuple 1 2)))))
(assert (= q2 ((_ rel.project 0) (set.singleton (tuple 1)))))
(check-sat)
;answer: unsat
; duration: 118 ms.
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
(declare-const q1 (Set (Tuple Int Int)))
(declare-const q2 (Set (Tuple Int Int)))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple Int Int))) (= ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 (set.union (set.singleton (tuple 1 2)) (set.singleton (tuple 3 3)))))))
(assert (= q2 ((_ rel.project 0 1) (set.singleton (tuple 3 3)))))
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (= q1 (set.union ((_ rel.project 0 1) (set.filter p0 DEPT)) ((_ rel.project 0 1) (set.filter p1 DEPT)))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p2 DEPT))))
(check-sat)
;answer: unsat
; duration: 88 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (= q1 (set.union ((_ rel.project 0 1) DEPT) ((_ rel.project 0 1) (set.filter p0 DEPT)))))
(assert (= q2 ((_ rel.project 0 1) DEPT)))
(check-sat)
;answer: unsat
; duration: 22 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_322107 Bool) (BOUND_VARIABLE_322108 Bool)) (and BOUND_VARIABLE_322107 BOUND_VARIABLE_322108)) (as nullable.null (Nullable Bool)) (nullable.some true))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_322107 Bool) (BOUND_VARIABLE_322108 Bool)) (and BOUND_VARIABLE_322107 BOUND_VARIABLE_322108)) (as nullable.null (Nullable Bool)) (nullable.some true)))))))
(assert (= q1 (set.union ((_ rel.project 0 1) DEPT) ((_ rel.project 0 1) (set.filter p0 DEPT)))))
(assert (= q2 ((_ rel.project 0 1) DEPT)))
(check-sat)
;answer: unsat
; duration: 23 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (= q1 (set.union (set.union ((_ rel.project 0 1) DEPT) ((_ rel.project 0 1) DEPT)) ((_ rel.project 0 1) (set.filter p0 DEPT)))))
(assert (= q2 (set.union ((_ rel.project 0 1) DEPT) ((_ rel.project 0 1) DEPT))))
(check-sat)
;answer: unsat
; duration: 23 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (= q1 (set.union ((_ rel.project 0) (set.filter p0 DEPT)) ((_ rel.project 0) EMP))))
(assert (= q2 ((_ rel.project 0) EMP)))
(check-sat)
;answer: unsat
; duration: 18 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_323187 Bool) (BOUND_VARIABLE_323188 Bool)) (or BOUND_VARIABLE_323187 BOUND_VARIABLE_323188)) (nullable.lift (lambda ((BOUND_VARIABLE_323161 Bool) (BOUND_VARIABLE_323162 Bool)) (and BOUND_VARIABLE_323161 BOUND_VARIABLE_323162)) (nullable.lift (lambda ((BOUND_VARIABLE_323148 Int) (BOUND_VARIABLE_323149 Int)) (< BOUND_VARIABLE_323148 BOUND_VARIABLE_323149)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_323155 Int) (BOUND_VARIABLE_323156 Int)) (< BOUND_VARIABLE_323155 BOUND_VARIABLE_323156)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_323181 Bool) (BOUND_VARIABLE_323182 Bool)) (and BOUND_VARIABLE_323181 BOUND_VARIABLE_323182)) (nullable.lift (lambda ((BOUND_VARIABLE_323169 Int) (BOUND_VARIABLE_323170 Int)) (> BOUND_VARIABLE_323169 BOUND_VARIABLE_323170)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_323175 Int) (BOUND_VARIABLE_323176 Int)) (> BOUND_VARIABLE_323175 BOUND_VARIABLE_323176)) ((_ tuple.select 9) t) (nullable.some 20))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_323187 Bool) (BOUND_VARIABLE_323188 Bool)) (or BOUND_VARIABLE_323187 BOUND_VARIABLE_323188)) (nullable.lift (lambda ((BOUND_VARIABLE_323161 Bool) (BOUND_VARIABLE_323162 Bool)) (and BOUND_VARIABLE_323161 BOUND_VARIABLE_323162)) (nullable.lift (lambda ((BOUND_VARIABLE_323148 Int) (BOUND_VARIABLE_323149 Int)) (< BOUND_VARIABLE_323148 BOUND_VARIABLE_323149)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_323155 Int) (BOUND_VARIABLE_323156 Int)) (< BOUND_VARIABLE_323155 BOUND_VARIABLE_323156)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_323181 Bool) (BOUND_VARIABLE_323182 Bool)) (and BOUND_VARIABLE_323181 BOUND_VARIABLE_323182)) (nullable.lift (lambda ((BOUND_VARIABLE_323169 Int) (BOUND_VARIABLE_323170 Int)) (> BOUND_VARIABLE_323169 BOUND_VARIABLE_323170)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_323175 Int) (BOUND_VARIABLE_323176 Int)) (> BOUND_VARIABLE_323175 BOUND_VARIABLE_323176)) ((_ tuple.select 9) t) (nullable.some 20)))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_323218 Bool) (BOUND_VARIABLE_323219 Bool)) (or BOUND_VARIABLE_323218 BOUND_VARIABLE_323219)) (nullable.lift (lambda ((BOUND_VARIABLE_323206 Int) (BOUND_VARIABLE_323207 Int)) (< BOUND_VARIABLE_323206 BOUND_VARIABLE_323207)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_323212 Int) (BOUND_VARIABLE_323213 Int)) (> BOUND_VARIABLE_323212 BOUND_VARIABLE_323213)) ((_ tuple.select 0) t) (nullable.some 20)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_323218 Bool) (BOUND_VARIABLE_323219 Bool)) (or BOUND_VARIABLE_323218 BOUND_VARIABLE_323219)) (nullable.lift (lambda ((BOUND_VARIABLE_323206 Int) (BOUND_VARIABLE_323207 Int)) (< BOUND_VARIABLE_323206 BOUND_VARIABLE_323207)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_323212 Int) (BOUND_VARIABLE_323213 Int)) (> BOUND_VARIABLE_323212 BOUND_VARIABLE_323213)) ((_ tuple.select 0) t) (nullable.some 20))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_323249 Bool) (BOUND_VARIABLE_323250 Bool)) (or BOUND_VARIABLE_323249 BOUND_VARIABLE_323250)) (nullable.lift (lambda ((BOUND_VARIABLE_323237 Int) (BOUND_VARIABLE_323238 Int)) (< BOUND_VARIABLE_323237 BOUND_VARIABLE_323238)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_323243 Int) (BOUND_VARIABLE_323244 Int)) (> BOUND_VARIABLE_323243 BOUND_VARIABLE_323244)) ((_ tuple.select 0) t) (nullable.some 20)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_323249 Bool) (BOUND_VARIABLE_323250 Bool)) (or BOUND_VARIABLE_323249 BOUND_VARIABLE_323250)) (nullable.lift (lambda ((BOUND_VARIABLE_323237 Int) (BOUND_VARIABLE_323238 Int)) (< BOUND_VARIABLE_323237 BOUND_VARIABLE_323238)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_323243 Int) (BOUND_VARIABLE_323244 Int)) (> BOUND_VARIABLE_323243 BOUND_VARIABLE_323244)) ((_ tuple.select 0) t) (nullable.some 20))))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_323306 Bool) (BOUND_VARIABLE_323307 Bool)) (or BOUND_VARIABLE_323306 BOUND_VARIABLE_323307)) (nullable.lift (lambda ((BOUND_VARIABLE_323282 Bool) (BOUND_VARIABLE_323283 Bool)) (and BOUND_VARIABLE_323282 BOUND_VARIABLE_323283)) (nullable.lift (lambda ((BOUND_VARIABLE_323269 Int) (BOUND_VARIABLE_323270 Int)) (< BOUND_VARIABLE_323269 BOUND_VARIABLE_323270)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_323276 Int) (BOUND_VARIABLE_323277 Int)) (< BOUND_VARIABLE_323276 BOUND_VARIABLE_323277)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_323300 Bool) (BOUND_VARIABLE_323301 Bool)) (and BOUND_VARIABLE_323300 BOUND_VARIABLE_323301)) (nullable.lift (lambda ((BOUND_VARIABLE_323288 Int) (BOUND_VARIABLE_323289 Int)) (> BOUND_VARIABLE_323288 BOUND_VARIABLE_323289)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_323294 Int) (BOUND_VARIABLE_323295 Int)) (> BOUND_VARIABLE_323294 BOUND_VARIABLE_323295)) ((_ tuple.select 9) t) (nullable.some 20))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_323306 Bool) (BOUND_VARIABLE_323307 Bool)) (or BOUND_VARIABLE_323306 BOUND_VARIABLE_323307)) (nullable.lift (lambda ((BOUND_VARIABLE_323282 Bool) (BOUND_VARIABLE_323283 Bool)) (and BOUND_VARIABLE_323282 BOUND_VARIABLE_323283)) (nullable.lift (lambda ((BOUND_VARIABLE_323269 Int) (BOUND_VARIABLE_323270 Int)) (< BOUND_VARIABLE_323269 BOUND_VARIABLE_323270)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_323276 Int) (BOUND_VARIABLE_323277 Int)) (< BOUND_VARIABLE_323276 BOUND_VARIABLE_323277)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_323300 Bool) (BOUND_VARIABLE_323301 Bool)) (and BOUND_VARIABLE_323300 BOUND_VARIABLE_323301)) (nullable.lift (lambda ((BOUND_VARIABLE_323288 Int) (BOUND_VARIABLE_323289 Int)) (> BOUND_VARIABLE_323288 BOUND_VARIABLE_323289)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_323294 Int) (BOUND_VARIABLE_323295 Int)) (> BOUND_VARIABLE_323294 BOUND_VARIABLE_323295)) ((_ tuple.select 9) t) (nullable.some 20)))))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p0 (rel.product EMP DEPT)))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p3 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)) ((_ rel.project 0 1) (set.filter p2 DEPT)))))))
(check-sat)
;answer: unsat
; duration: 325 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_328748 Bool) (BOUND_VARIABLE_328749 Bool)) (or BOUND_VARIABLE_328748 BOUND_VARIABLE_328749)) (nullable.lift (lambda ((BOUND_VARIABLE_328723 Bool) (BOUND_VARIABLE_328724 Bool)) (and BOUND_VARIABLE_328723 BOUND_VARIABLE_328724)) (nullable.lift (lambda ((BOUND_VARIABLE_328711 Int) (BOUND_VARIABLE_328712 Int)) (> BOUND_VARIABLE_328711 BOUND_VARIABLE_328712)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_328717 Int) (BOUND_VARIABLE_328718 Int)) (<= BOUND_VARIABLE_328717 BOUND_VARIABLE_328718)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.lift (lambda ((BOUND_VARIABLE_328742 Bool) (BOUND_VARIABLE_328743 Bool)) (and BOUND_VARIABLE_328742 BOUND_VARIABLE_328743)) (nullable.lift (lambda ((BOUND_VARIABLE_328729 Int) (BOUND_VARIABLE_328730 Int)) (> BOUND_VARIABLE_328729 BOUND_VARIABLE_328730)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_328736 Int) (BOUND_VARIABLE_328737 Int)) (> BOUND_VARIABLE_328736 BOUND_VARIABLE_328737)) ((_ tuple.select 9) t) (nullable.some 20))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_328748 Bool) (BOUND_VARIABLE_328749 Bool)) (or BOUND_VARIABLE_328748 BOUND_VARIABLE_328749)) (nullable.lift (lambda ((BOUND_VARIABLE_328723 Bool) (BOUND_VARIABLE_328724 Bool)) (and BOUND_VARIABLE_328723 BOUND_VARIABLE_328724)) (nullable.lift (lambda ((BOUND_VARIABLE_328711 Int) (BOUND_VARIABLE_328712 Int)) (> BOUND_VARIABLE_328711 BOUND_VARIABLE_328712)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_328717 Int) (BOUND_VARIABLE_328718 Int)) (<= BOUND_VARIABLE_328717 BOUND_VARIABLE_328718)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.lift (lambda ((BOUND_VARIABLE_328742 Bool) (BOUND_VARIABLE_328743 Bool)) (and BOUND_VARIABLE_328742 BOUND_VARIABLE_328743)) (nullable.lift (lambda ((BOUND_VARIABLE_328729 Int) (BOUND_VARIABLE_328730 Int)) (> BOUND_VARIABLE_328729 BOUND_VARIABLE_328730)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_328736 Int) (BOUND_VARIABLE_328737 Int)) (> BOUND_VARIABLE_328736 BOUND_VARIABLE_328737)) ((_ tuple.select 9) t) (nullable.some 20)))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_328792 Bool) (BOUND_VARIABLE_328793 Bool)) (or BOUND_VARIABLE_328792 BOUND_VARIABLE_328793)) (nullable.lift (lambda ((BOUND_VARIABLE_328780 Bool) (BOUND_VARIABLE_328781 Bool)) (and BOUND_VARIABLE_328780 BOUND_VARIABLE_328781)) (nullable.lift (lambda ((BOUND_VARIABLE_328768 Int) (BOUND_VARIABLE_328769 Int)) (> BOUND_VARIABLE_328768 BOUND_VARIABLE_328769)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_328774 Int) (BOUND_VARIABLE_328775 Int)) (<= BOUND_VARIABLE_328774 BOUND_VARIABLE_328775)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.lift (lambda ((BOUND_VARIABLE_328786 Int) (BOUND_VARIABLE_328787 Int)) (> BOUND_VARIABLE_328786 BOUND_VARIABLE_328787)) ((_ tuple.select 0) t) (nullable.some 20)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_328792 Bool) (BOUND_VARIABLE_328793 Bool)) (or BOUND_VARIABLE_328792 BOUND_VARIABLE_328793)) (nullable.lift (lambda ((BOUND_VARIABLE_328780 Bool) (BOUND_VARIABLE_328781 Bool)) (and BOUND_VARIABLE_328780 BOUND_VARIABLE_328781)) (nullable.lift (lambda ((BOUND_VARIABLE_328768 Int) (BOUND_VARIABLE_328769 Int)) (> BOUND_VARIABLE_328768 BOUND_VARIABLE_328769)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_328774 Int) (BOUND_VARIABLE_328775 Int)) (<= BOUND_VARIABLE_328774 BOUND_VARIABLE_328775)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.lift (lambda ((BOUND_VARIABLE_328786 Int) (BOUND_VARIABLE_328787 Int)) (> BOUND_VARIABLE_328786 BOUND_VARIABLE_328787)) ((_ tuple.select 0) t) (nullable.some 20))))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_328849 Bool) (BOUND_VARIABLE_328850 Bool)) (or BOUND_VARIABLE_328849 BOUND_VARIABLE_328850)) (nullable.lift (lambda ((BOUND_VARIABLE_328824 Bool) (BOUND_VARIABLE_328825 Bool)) (and BOUND_VARIABLE_328824 BOUND_VARIABLE_328825)) (nullable.lift (lambda ((BOUND_VARIABLE_328812 Int) (BOUND_VARIABLE_328813 Int)) (> BOUND_VARIABLE_328812 BOUND_VARIABLE_328813)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_328818 Int) (BOUND_VARIABLE_328819 Int)) (<= BOUND_VARIABLE_328818 BOUND_VARIABLE_328819)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.lift (lambda ((BOUND_VARIABLE_328843 Bool) (BOUND_VARIABLE_328844 Bool)) (and BOUND_VARIABLE_328843 BOUND_VARIABLE_328844)) (nullable.lift (lambda ((BOUND_VARIABLE_328830 Int) (BOUND_VARIABLE_328831 Int)) (> BOUND_VARIABLE_328830 BOUND_VARIABLE_328831)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_328837 Int) (BOUND_VARIABLE_328838 Int)) (> BOUND_VARIABLE_328837 BOUND_VARIABLE_328838)) ((_ tuple.select 9) t) (nullable.some 20))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_328849 Bool) (BOUND_VARIABLE_328850 Bool)) (or BOUND_VARIABLE_328849 BOUND_VARIABLE_328850)) (nullable.lift (lambda ((BOUND_VARIABLE_328824 Bool) (BOUND_VARIABLE_328825 Bool)) (and BOUND_VARIABLE_328824 BOUND_VARIABLE_328825)) (nullable.lift (lambda ((BOUND_VARIABLE_328812 Int) (BOUND_VARIABLE_328813 Int)) (> BOUND_VARIABLE_328812 BOUND_VARIABLE_328813)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_328818 Int) (BOUND_VARIABLE_328819 Int)) (<= BOUND_VARIABLE_328818 BOUND_VARIABLE_328819)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.lift (lambda ((BOUND_VARIABLE_328843 Bool) (BOUND_VARIABLE_328844 Bool)) (and BOUND_VARIABLE_328843 BOUND_VARIABLE_328844)) (nullable.lift (lambda ((BOUND_VARIABLE_328830 Int) (BOUND_VARIABLE_328831 Int)) (> BOUND_VARIABLE_328830 BOUND_VARIABLE_328831)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_328837 Int) (BOUND_VARIABLE_328838 Int)) (> BOUND_VARIABLE_328837 BOUND_VARIABLE_328838)) ((_ tuple.select 9) t) (nullable.some 20)))))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p0 (rel.product EMP DEPT)))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p2 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)) DEPT)))))
(check-sat)
;answer: unsat
; duration: 418 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const leftJoin4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const leftJoin1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_333911 Bool) (BOUND_VARIABLE_333912 Bool)) (or BOUND_VARIABLE_333911 BOUND_VARIABLE_333912)) (nullable.lift (lambda ((BOUND_VARIABLE_333887 Bool) (BOUND_VARIABLE_333888 Bool)) (and BOUND_VARIABLE_333887 BOUND_VARIABLE_333888)) (nullable.lift (lambda ((BOUND_VARIABLE_333874 Int) (BOUND_VARIABLE_333875 Int)) (< BOUND_VARIABLE_333874 BOUND_VARIABLE_333875)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_333881 Int) (BOUND_VARIABLE_333882 Int)) (< BOUND_VARIABLE_333881 BOUND_VARIABLE_333882)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_333905 Bool) (BOUND_VARIABLE_333906 Bool)) (and BOUND_VARIABLE_333905 BOUND_VARIABLE_333906)) (nullable.lift (lambda ((BOUND_VARIABLE_333893 Int) (BOUND_VARIABLE_333894 Int)) (> BOUND_VARIABLE_333893 BOUND_VARIABLE_333894)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_333899 Int) (BOUND_VARIABLE_333900 Int)) (> BOUND_VARIABLE_333899 BOUND_VARIABLE_333900)) ((_ tuple.select 9) t) (nullable.some 20))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_333911 Bool) (BOUND_VARIABLE_333912 Bool)) (or BOUND_VARIABLE_333911 BOUND_VARIABLE_333912)) (nullable.lift (lambda ((BOUND_VARIABLE_333887 Bool) (BOUND_VARIABLE_333888 Bool)) (and BOUND_VARIABLE_333887 BOUND_VARIABLE_333888)) (nullable.lift (lambda ((BOUND_VARIABLE_333874 Int) (BOUND_VARIABLE_333875 Int)) (< BOUND_VARIABLE_333874 BOUND_VARIABLE_333875)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_333881 Int) (BOUND_VARIABLE_333882 Int)) (< BOUND_VARIABLE_333881 BOUND_VARIABLE_333882)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_333905 Bool) (BOUND_VARIABLE_333906 Bool)) (and BOUND_VARIABLE_333905 BOUND_VARIABLE_333906)) (nullable.lift (lambda ((BOUND_VARIABLE_333893 Int) (BOUND_VARIABLE_333894 Int)) (> BOUND_VARIABLE_333893 BOUND_VARIABLE_333894)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_333899 Int) (BOUND_VARIABLE_333900 Int)) (> BOUND_VARIABLE_333899 BOUND_VARIABLE_333900)) ((_ tuple.select 9) t) (nullable.some 20)))))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_333975 Bool) (BOUND_VARIABLE_333976 Bool)) (or BOUND_VARIABLE_333975 BOUND_VARIABLE_333976)) (nullable.lift (lambda ((BOUND_VARIABLE_333963 Int) (BOUND_VARIABLE_333964 Int)) (< BOUND_VARIABLE_333963 BOUND_VARIABLE_333964)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_333969 Int) (BOUND_VARIABLE_333970 Int)) (> BOUND_VARIABLE_333969 BOUND_VARIABLE_333970)) ((_ tuple.select 0) t) (nullable.some 20)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_333975 Bool) (BOUND_VARIABLE_333976 Bool)) (or BOUND_VARIABLE_333975 BOUND_VARIABLE_333976)) (nullable.lift (lambda ((BOUND_VARIABLE_333963 Int) (BOUND_VARIABLE_333964 Int)) (< BOUND_VARIABLE_333963 BOUND_VARIABLE_333964)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_333969 Int) (BOUND_VARIABLE_333970 Int)) (> BOUND_VARIABLE_333969 BOUND_VARIABLE_333970)) ((_ tuple.select 0) t) (nullable.some 20))))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_334032 Bool) (BOUND_VARIABLE_334033 Bool)) (or BOUND_VARIABLE_334032 BOUND_VARIABLE_334033)) (nullable.lift (lambda ((BOUND_VARIABLE_334008 Bool) (BOUND_VARIABLE_334009 Bool)) (and BOUND_VARIABLE_334008 BOUND_VARIABLE_334009)) (nullable.lift (lambda ((BOUND_VARIABLE_333995 Int) (BOUND_VARIABLE_333996 Int)) (< BOUND_VARIABLE_333995 BOUND_VARIABLE_333996)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_334002 Int) (BOUND_VARIABLE_334003 Int)) (< BOUND_VARIABLE_334002 BOUND_VARIABLE_334003)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_334026 Bool) (BOUND_VARIABLE_334027 Bool)) (and BOUND_VARIABLE_334026 BOUND_VARIABLE_334027)) (nullable.lift (lambda ((BOUND_VARIABLE_334014 Int) (BOUND_VARIABLE_334015 Int)) (> BOUND_VARIABLE_334014 BOUND_VARIABLE_334015)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_334020 Int) (BOUND_VARIABLE_334021 Int)) (> BOUND_VARIABLE_334020 BOUND_VARIABLE_334021)) ((_ tuple.select 9) t) (nullable.some 20))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_334032 Bool) (BOUND_VARIABLE_334033 Bool)) (or BOUND_VARIABLE_334032 BOUND_VARIABLE_334033)) (nullable.lift (lambda ((BOUND_VARIABLE_334008 Bool) (BOUND_VARIABLE_334009 Bool)) (and BOUND_VARIABLE_334008 BOUND_VARIABLE_334009)) (nullable.lift (lambda ((BOUND_VARIABLE_333995 Int) (BOUND_VARIABLE_333996 Int)) (< BOUND_VARIABLE_333995 BOUND_VARIABLE_333996)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_334002 Int) (BOUND_VARIABLE_334003 Int)) (< BOUND_VARIABLE_334002 BOUND_VARIABLE_334003)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_334026 Bool) (BOUND_VARIABLE_334027 Bool)) (and BOUND_VARIABLE_334026 BOUND_VARIABLE_334027)) (nullable.lift (lambda ((BOUND_VARIABLE_334014 Int) (BOUND_VARIABLE_334015 Int)) (> BOUND_VARIABLE_334014 BOUND_VARIABLE_334015)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_334020 Int) (BOUND_VARIABLE_334021 Int)) (> BOUND_VARIABLE_334020 BOUND_VARIABLE_334021)) ((_ tuple.select 9) t) (nullable.some 20)))))))))
(assert (= leftJoin4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map leftJoin1 (set.minus EMP ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 (rel.product EMP DEPT))))) (set.filter p0 (rel.product EMP DEPT))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map leftJoin4 (set.minus EMP ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 (rel.product EMP ((_ rel.project 0 1) (set.filter p2 DEPT))))))) (set.filter p3 (rel.product EMP ((_ rel.project 0 1) (set.filter p2 DEPT))))))))
(check-sat)
;answer: unsat
; duration: 6440 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const rightJoin1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const rightJoin4 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_376864 Bool) (BOUND_VARIABLE_376865 Bool)) (or BOUND_VARIABLE_376864 BOUND_VARIABLE_376865)) (nullable.lift (lambda ((BOUND_VARIABLE_376840 Bool) (BOUND_VARIABLE_376841 Bool)) (and BOUND_VARIABLE_376840 BOUND_VARIABLE_376841)) (nullable.lift (lambda ((BOUND_VARIABLE_376827 Int) (BOUND_VARIABLE_376828 Int)) (< BOUND_VARIABLE_376827 BOUND_VARIABLE_376828)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_376834 Int) (BOUND_VARIABLE_376835 Int)) (< BOUND_VARIABLE_376834 BOUND_VARIABLE_376835)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_376858 Bool) (BOUND_VARIABLE_376859 Bool)) (and BOUND_VARIABLE_376858 BOUND_VARIABLE_376859)) (nullable.lift (lambda ((BOUND_VARIABLE_376846 Int) (BOUND_VARIABLE_376847 Int)) (> BOUND_VARIABLE_376846 BOUND_VARIABLE_376847)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_376852 Int) (BOUND_VARIABLE_376853 Int)) (> BOUND_VARIABLE_376852 BOUND_VARIABLE_376853)) ((_ tuple.select 9) t) (nullable.some 20))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_376864 Bool) (BOUND_VARIABLE_376865 Bool)) (or BOUND_VARIABLE_376864 BOUND_VARIABLE_376865)) (nullable.lift (lambda ((BOUND_VARIABLE_376840 Bool) (BOUND_VARIABLE_376841 Bool)) (and BOUND_VARIABLE_376840 BOUND_VARIABLE_376841)) (nullable.lift (lambda ((BOUND_VARIABLE_376827 Int) (BOUND_VARIABLE_376828 Int)) (< BOUND_VARIABLE_376827 BOUND_VARIABLE_376828)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_376834 Int) (BOUND_VARIABLE_376835 Int)) (< BOUND_VARIABLE_376834 BOUND_VARIABLE_376835)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_376858 Bool) (BOUND_VARIABLE_376859 Bool)) (and BOUND_VARIABLE_376858 BOUND_VARIABLE_376859)) (nullable.lift (lambda ((BOUND_VARIABLE_376846 Int) (BOUND_VARIABLE_376847 Int)) (> BOUND_VARIABLE_376846 BOUND_VARIABLE_376847)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_376852 Int) (BOUND_VARIABLE_376853 Int)) (> BOUND_VARIABLE_376852 BOUND_VARIABLE_376853)) ((_ tuple.select 9) t) (nullable.some 20)))))))))
(assert (= rightJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_376922 Bool) (BOUND_VARIABLE_376923 Bool)) (or BOUND_VARIABLE_376922 BOUND_VARIABLE_376923)) (nullable.lift (lambda ((BOUND_VARIABLE_376910 Int) (BOUND_VARIABLE_376911 Int)) (< BOUND_VARIABLE_376910 BOUND_VARIABLE_376911)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_376916 Int) (BOUND_VARIABLE_376917 Int)) (> BOUND_VARIABLE_376916 BOUND_VARIABLE_376917)) ((_ tuple.select 0) t) (nullable.some 20)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_376922 Bool) (BOUND_VARIABLE_376923 Bool)) (or BOUND_VARIABLE_376922 BOUND_VARIABLE_376923)) (nullable.lift (lambda ((BOUND_VARIABLE_376910 Int) (BOUND_VARIABLE_376911 Int)) (< BOUND_VARIABLE_376910 BOUND_VARIABLE_376911)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_376916 Int) (BOUND_VARIABLE_376917 Int)) (> BOUND_VARIABLE_376916 BOUND_VARIABLE_376917)) ((_ tuple.select 0) t) (nullable.some 20))))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_376979 Bool) (BOUND_VARIABLE_376980 Bool)) (or BOUND_VARIABLE_376979 BOUND_VARIABLE_376980)) (nullable.lift (lambda ((BOUND_VARIABLE_376955 Bool) (BOUND_VARIABLE_376956 Bool)) (and BOUND_VARIABLE_376955 BOUND_VARIABLE_376956)) (nullable.lift (lambda ((BOUND_VARIABLE_376942 Int) (BOUND_VARIABLE_376943 Int)) (< BOUND_VARIABLE_376942 BOUND_VARIABLE_376943)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_376949 Int) (BOUND_VARIABLE_376950 Int)) (< BOUND_VARIABLE_376949 BOUND_VARIABLE_376950)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_376973 Bool) (BOUND_VARIABLE_376974 Bool)) (and BOUND_VARIABLE_376973 BOUND_VARIABLE_376974)) (nullable.lift (lambda ((BOUND_VARIABLE_376961 Int) (BOUND_VARIABLE_376962 Int)) (> BOUND_VARIABLE_376961 BOUND_VARIABLE_376962)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_376967 Int) (BOUND_VARIABLE_376968 Int)) (> BOUND_VARIABLE_376967 BOUND_VARIABLE_376968)) ((_ tuple.select 9) t) (nullable.some 20))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_376979 Bool) (BOUND_VARIABLE_376980 Bool)) (or BOUND_VARIABLE_376979 BOUND_VARIABLE_376980)) (nullable.lift (lambda ((BOUND_VARIABLE_376955 Bool) (BOUND_VARIABLE_376956 Bool)) (and BOUND_VARIABLE_376955 BOUND_VARIABLE_376956)) (nullable.lift (lambda ((BOUND_VARIABLE_376942 Int) (BOUND_VARIABLE_376943 Int)) (< BOUND_VARIABLE_376942 BOUND_VARIABLE_376943)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_376949 Int) (BOUND_VARIABLE_376950 Int)) (< BOUND_VARIABLE_376949 BOUND_VARIABLE_376950)) ((_ tuple.select 9) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_376973 Bool) (BOUND_VARIABLE_376974 Bool)) (and BOUND_VARIABLE_376973 BOUND_VARIABLE_376974)) (nullable.lift (lambda ((BOUND_VARIABLE_376961 Int) (BOUND_VARIABLE_376962 Int)) (> BOUND_VARIABLE_376961 BOUND_VARIABLE_376962)) ((_ tuple.select 0) t) (nullable.some 20)) (nullable.lift (lambda ((BOUND_VARIABLE_376967 Int) (BOUND_VARIABLE_376968 Int)) (> BOUND_VARIABLE_376967 BOUND_VARIABLE_376968)) ((_ tuple.select 9) t) (nullable.some 20)))))))))
(assert (= rightJoin4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map rightJoin1 (set.minus DEPT ((_ rel.project 9 10) (set.filter p0 (rel.product EMP DEPT))))) (set.filter p0 (rel.product EMP DEPT))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map rightJoin4 (set.minus DEPT ((_ rel.project 9 10) (set.filter p3 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)) DEPT))))) (set.filter p3 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)) DEPT))))))
(check-sat)
;answer: unsat
; duration: 5428 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_412945 Int) (BOUND_VARIABLE_412946 Int)) (> BOUND_VARIABLE_412945 BOUND_VARIABLE_412946)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_412945 Int) (BOUND_VARIABLE_412946 Int)) (> BOUND_VARIABLE_412945 BOUND_VARIABLE_412946)) ((_ tuple.select 0) t) (nullable.some 0)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_412965 Int) (BOUND_VARIABLE_412966 Int)) (< BOUND_VARIABLE_412965 BOUND_VARIABLE_412966)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_412965 Int) (BOUND_VARIABLE_412966 Int)) (< BOUND_VARIABLE_412965 BOUND_VARIABLE_412966)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_413016 Bool) (BOUND_VARIABLE_413017 Bool)) (and BOUND_VARIABLE_413016 BOUND_VARIABLE_413017)) (nullable.lift (lambda ((BOUND_VARIABLE_412985 Int) (BOUND_VARIABLE_412986 Int)) (> BOUND_VARIABLE_412985 BOUND_VARIABLE_412986)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_413011 Bool)) (not BOUND_VARIABLE_413011)) (ite (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_412997 Int) (BOUND_VARIABLE_412998 Int)) (< BOUND_VARIABLE_412997 BOUND_VARIABLE_412998)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_413004 Int) (BOUND_VARIABLE_413005 Int)) (< BOUND_VARIABLE_413004 BOUND_VARIABLE_413005)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some false))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_413016 Bool) (BOUND_VARIABLE_413017 Bool)) (and BOUND_VARIABLE_413016 BOUND_VARIABLE_413017)) (nullable.lift (lambda ((BOUND_VARIABLE_412985 Int) (BOUND_VARIABLE_412986 Int)) (> BOUND_VARIABLE_412985 BOUND_VARIABLE_412986)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.lift (lambda ((BOUND_VARIABLE_413011 Bool)) (not BOUND_VARIABLE_413011)) (ite (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_412997 Int) (BOUND_VARIABLE_412998 Int)) (< BOUND_VARIABLE_412997 BOUND_VARIABLE_412998)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_413004 Int) (BOUND_VARIABLE_413005 Int)) (< BOUND_VARIABLE_413004 BOUND_VARIABLE_413005)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some false)))))))))
(assert (= q1 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))
(check-sat)
;answer: unsat
; duration: 432 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416593 Bool) (BOUND_VARIABLE_416594 Bool)) (and BOUND_VARIABLE_416593 BOUND_VARIABLE_416594)) (as nullable.null (Nullable Bool)) (nullable.some true))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416593 Bool) (BOUND_VARIABLE_416594 Bool)) (and BOUND_VARIABLE_416593 BOUND_VARIABLE_416594)) (as nullable.null (Nullable Bool)) (nullable.some true)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) false)))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 10 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416680 Bool) (BOUND_VARIABLE_416681 Bool)) (or BOUND_VARIABLE_416680 BOUND_VARIABLE_416681)) (nullable.lift (lambda ((BOUND_VARIABLE_416674 Int) (BOUND_VARIABLE_416675 Int)) (= BOUND_VARIABLE_416674 BOUND_VARIABLE_416675)) ((_ tuple.select 0) t) (nullable.some 0)) (as nullable.null (Nullable Bool)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416680 Bool) (BOUND_VARIABLE_416681 Bool)) (or BOUND_VARIABLE_416680 BOUND_VARIABLE_416681)) (nullable.lift (lambda ((BOUND_VARIABLE_416674 Int) (BOUND_VARIABLE_416675 Int)) (= BOUND_VARIABLE_416674 BOUND_VARIABLE_416675)) ((_ tuple.select 0) t) (nullable.some 0)) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_416705 Bool) (BOUND_VARIABLE_416706 Bool)) (or BOUND_VARIABLE_416705 BOUND_VARIABLE_416706)) (nullable.lift (lambda ((BOUND_VARIABLE_416699 Int) (BOUND_VARIABLE_416700 Int)) (= BOUND_VARIABLE_416699 BOUND_VARIABLE_416700)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.some false))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_416705 Bool) (BOUND_VARIABLE_416706 Bool)) (or BOUND_VARIABLE_416705 BOUND_VARIABLE_416706)) (nullable.lift (lambda ((BOUND_VARIABLE_416699 Int) (BOUND_VARIABLE_416700 Int)) (= BOUND_VARIABLE_416699 BOUND_VARIABLE_416700)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.some false)))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 146 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 0) (nullable.some "A") (nullable.some "B") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (nullable.some (- 6)))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 0) (nullable.some "A") (nullable.some "B") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (nullable.some (- 6))))
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_418328 Bool) (BOUND_VARIABLE_418329 Bool)) (and BOUND_VARIABLE_418328 BOUND_VARIABLE_418329)) (nullable.lift (lambda ((BOUND_VARIABLE_418322 Int) (BOUND_VARIABLE_418323 Int)) (> BOUND_VARIABLE_418322 BOUND_VARIABLE_418323)) ((_ tuple.select 0) t) (nullable.some 0)) (as nullable.null (Nullable Bool)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_418328 Bool) (BOUND_VARIABLE_418329 Bool)) (and BOUND_VARIABLE_418328 BOUND_VARIABLE_418329)) (nullable.lift (lambda ((BOUND_VARIABLE_418322 Int) (BOUND_VARIABLE_418323 Int)) (> BOUND_VARIABLE_418322 BOUND_VARIABLE_418323)) ((_ tuple.select 0) t) (nullable.some 0)) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_418354 Bool) (BOUND_VARIABLE_418355 Bool)) (and BOUND_VARIABLE_418354 BOUND_VARIABLE_418355)) (nullable.lift (lambda ((BOUND_VARIABLE_418348 Int) (BOUND_VARIABLE_418349 Int)) (> BOUND_VARIABLE_418348 BOUND_VARIABLE_418349)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.some false))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_418354 Bool) (BOUND_VARIABLE_418355 Bool)) (and BOUND_VARIABLE_418354 BOUND_VARIABLE_418355)) (nullable.lift (lambda ((BOUND_VARIABLE_418348 Int) (BOUND_VARIABLE_418349 Int)) (> BOUND_VARIABLE_418348 BOUND_VARIABLE_418349)) ((_ tuple.select 0) t) (nullable.some 0)) (nullable.some false)))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 40 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_419153 Int) (BOUND_VARIABLE_419154 Int)) (= BOUND_VARIABLE_419153 BOUND_VARIABLE_419154)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.some false) (as nullable.null (Nullable Bool)))) (nullable.val (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_419153 Int) (BOUND_VARIABLE_419154 Int)) (= BOUND_VARIABLE_419153 BOUND_VARIABLE_419154)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.some false) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_419174 Int) (BOUND_VARIABLE_419175 Int)) (= BOUND_VARIABLE_419174 BOUND_VARIABLE_419175)) ((_ tuple.select 0) t) (nullable.some 1))) false false))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 32 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_419763 Int) (BOUND_VARIABLE_419764 Int)) (= BOUND_VARIABLE_419763 BOUND_VARIABLE_419764)) ((_ tuple.select 0) t) (nullable.some 1))) (as nullable.null (Nullable Bool)) (nullable.some true))) (nullable.val (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_419763 Int) (BOUND_VARIABLE_419764 Int)) (= BOUND_VARIABLE_419763 BOUND_VARIABLE_419764)) ((_ tuple.select 0) t) (nullable.some 1))) (as nullable.null (Nullable Bool)) (nullable.some true)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_419784 Int) (BOUND_VARIABLE_419785 Int)) (= BOUND_VARIABLE_419784 BOUND_VARIABLE_419785)) ((_ tuple.select 0) t) (nullable.some 1))) false true))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 81 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_421039 Bool) (BOUND_VARIABLE_421040 Bool)) (or BOUND_VARIABLE_421039 BOUND_VARIABLE_421040)) (nullable.lift (lambda ((BOUND_VARIABLE_421033 Int) (BOUND_VARIABLE_421034 Int)) (= BOUND_VARIABLE_421033 BOUND_VARIABLE_421034)) ((_ tuple.select 0) t) (nullable.some 1)) (as nullable.null (Nullable Bool)))) (nullable.lift (lambda ((BOUND_VARIABLE_421046 Int) (BOUND_VARIABLE_421047 Int)) (< BOUND_VARIABLE_421046 BOUND_VARIABLE_421047)) ((_ tuple.select 6) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_421052 Int) (BOUND_VARIABLE_421053 Int)) (> BOUND_VARIABLE_421052 BOUND_VARIABLE_421053)) ((_ tuple.select 6) t) (nullable.some 10)))) (nullable.val (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_421039 Bool) (BOUND_VARIABLE_421040 Bool)) (or BOUND_VARIABLE_421039 BOUND_VARIABLE_421040)) (nullable.lift (lambda ((BOUND_VARIABLE_421033 Int) (BOUND_VARIABLE_421034 Int)) (= BOUND_VARIABLE_421033 BOUND_VARIABLE_421034)) ((_ tuple.select 0) t) (nullable.some 1)) (as nullable.null (Nullable Bool)))) (nullable.lift (lambda ((BOUND_VARIABLE_421046 Int) (BOUND_VARIABLE_421047 Int)) (< BOUND_VARIABLE_421046 BOUND_VARIABLE_421047)) ((_ tuple.select 6) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_421052 Int) (BOUND_VARIABLE_421053 Int)) (> BOUND_VARIABLE_421052 BOUND_VARIABLE_421053)) ((_ tuple.select 6) t) (nullable.some 10))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_421079 Bool) (BOUND_VARIABLE_421080 Bool)) (or BOUND_VARIABLE_421079 BOUND_VARIABLE_421080)) (nullable.lift (lambda ((BOUND_VARIABLE_421073 Int) (BOUND_VARIABLE_421074 Int)) (= BOUND_VARIABLE_421073 BOUND_VARIABLE_421074)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some false))) (nullable.lift (lambda ((BOUND_VARIABLE_421086 Int) (BOUND_VARIABLE_421087 Int)) (< BOUND_VARIABLE_421086 BOUND_VARIABLE_421087)) ((_ tuple.select 6) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_421092 Int) (BOUND_VARIABLE_421093 Int)) (> BOUND_VARIABLE_421092 BOUND_VARIABLE_421093)) ((_ tuple.select 6) t) (nullable.some 10)))) (nullable.val (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_421079 Bool) (BOUND_VARIABLE_421080 Bool)) (or BOUND_VARIABLE_421079 BOUND_VARIABLE_421080)) (nullable.lift (lambda ((BOUND_VARIABLE_421073 Int) (BOUND_VARIABLE_421074 Int)) (= BOUND_VARIABLE_421073 BOUND_VARIABLE_421074)) ((_ tuple.select 0) t) (nullable.some 1)) (nullable.some false))) (nullable.lift (lambda ((BOUND_VARIABLE_421086 Int) (BOUND_VARIABLE_421087 Int)) (< BOUND_VARIABLE_421086 BOUND_VARIABLE_421087)) ((_ tuple.select 6) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_421092 Int) (BOUND_VARIABLE_421093 Int)) (> BOUND_VARIABLE_421092 BOUND_VARIABLE_421093)) ((_ tuple.select 6) t) (nullable.some 10))))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 202 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 1) (nullable.some "C") (nullable.some "D") (nullable.some 6) (nullable.some (- 6)) (nullable.some 7) (nullable.some 11) (nullable.some (- 7)) (nullable.some 8))))
; )
; q1
(get-value (q1))
; ((_ rel.project 0 1 2 3 4 5 6 7 8) (ite (nullable.val (ite (nullable.val (as nullable.null (Nullable Bool))) (nullable.some false) (nullable.some true))) (set.singleton (tuple (nullable.some 1) (nullable.some "C") (nullable.some "D") (nullable.some 6) (nullable.some (- 6)) (nullable.some 7) (nullable.some 11) (nullable.some (- 7)) (nullable.some 8))) (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; insert into EMP values(1,'C','D',6,-6,7,11,-7,8)
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_424346 Bool)) (not BOUND_VARIABLE_424346)) (nullable.lift (lambda ((BOUND_VARIABLE_424340 Bool) (BOUND_VARIABLE_424341 Bool)) (or BOUND_VARIABLE_424340 BOUND_VARIABLE_424341)) (nullable.lift (lambda ((BOUND_VARIABLE_424328 Int) (BOUND_VARIABLE_424329 Int)) (= BOUND_VARIABLE_424328 BOUND_VARIABLE_424329)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_424334 Int) (BOUND_VARIABLE_424335 Int)) (= BOUND_VARIABLE_424334 BOUND_VARIABLE_424335)) ((_ tuple.select 0) t) (as nullable.null (Nullable Int)))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_424346 Bool)) (not BOUND_VARIABLE_424346)) (nullable.lift (lambda ((BOUND_VARIABLE_424340 Bool) (BOUND_VARIABLE_424341 Bool)) (or BOUND_VARIABLE_424340 BOUND_VARIABLE_424341)) (nullable.lift (lambda ((BOUND_VARIABLE_424328 Int) (BOUND_VARIABLE_424329 Int)) (= BOUND_VARIABLE_424328 BOUND_VARIABLE_424329)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)) (nullable.lift (lambda ((BOUND_VARIABLE_424334 Int) (BOUND_VARIABLE_424335 Int)) (= BOUND_VARIABLE_424334 BOUND_VARIABLE_424335)) ((_ tuple.select 0) t) (as nullable.null (Nullable Int))))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) false)))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p0 (rel.product EMP DEPT)))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p1 (rel.product EMP DEPT)))))
(check-sat)
;answer: unsat
; duration: 82 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_424430 Bool) (BOUND_VARIABLE_424431 Bool)) (and BOUND_VARIABLE_424430 BOUND_VARIABLE_424431)) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.lift (lambda ((BOUND_VARIABLE_424436 Bool) (BOUND_VARIABLE_424437 Bool)) (or BOUND_VARIABLE_424436 BOUND_VARIABLE_424437)) (nullable.some false) (as nullable.null (Nullable Bool))) (nullable.lift (lambda ((BOUND_VARIABLE_424442 Bool) (BOUND_VARIABLE_424443 Bool)) (and BOUND_VARIABLE_424442 BOUND_VARIABLE_424443)) (as nullable.null (Nullable Bool)) (as nullable.null (Nullable Bool))))) (nullable.val (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_424430 Bool) (BOUND_VARIABLE_424431 Bool)) (and BOUND_VARIABLE_424430 BOUND_VARIABLE_424431)) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.lift (lambda ((BOUND_VARIABLE_424436 Bool) (BOUND_VARIABLE_424437 Bool)) (or BOUND_VARIABLE_424436 BOUND_VARIABLE_424437)) (nullable.some false) (as nullable.null (Nullable Bool))) (nullable.lift (lambda ((BOUND_VARIABLE_424442 Bool) (BOUND_VARIABLE_424443 Bool)) (and BOUND_VARIABLE_424442 BOUND_VARIABLE_424443)) (as nullable.null (Nullable Bool)) (as nullable.null (Nullable Bool)))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (ite (and true false) (or false false) (and false false)))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Bool))))
(declare-const q2 (Set (Tuple (Nullable Bool))))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Bool))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_424545 Bool) (BOUND_VARIABLE_424546 Bool)) (or BOUND_VARIABLE_424545 BOUND_VARIABLE_424546)) (nullable.lift (lambda ((BOUND_VARIABLE_424539 Int) (BOUND_VARIABLE_424540 Int)) (= BOUND_VARIABLE_424539 BOUND_VARIABLE_424540)) ((_ tuple.select 0) t) (nullable.some 1)) (as nullable.null (Nullable Bool)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_424563 Int) (BOUND_VARIABLE_424564 Int)) (= BOUND_VARIABLE_424563 BOUND_VARIABLE_424564)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (= q1 (set.map f0 EMP)))
(assert (= q2 (set.map f1 EMP)))
(check-sat)
;answer: sat
; duration: 94 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (nullable.some 1) (nullable.some "G") (nullable.some "H") (nullable.some 13) (nullable.some (- 13)) (nullable.some 14) (nullable.some (- 14)) (nullable.some 15) (nullable.some (- 15)))) (set.union (set.singleton (tuple (nullable.some 1) (nullable.some "E") (nullable.some "F") (nullable.some 10) (nullable.some (- 10)) (nullable.some 11) (nullable.some (- 11)) (nullable.some 12) (nullable.some (- 12)))) (set.union (set.singleton (tuple (as nullable.null (Nullable Int)) (nullable.some "C") (nullable.some "D") (nullable.some 7) (nullable.some (- 7)) (nullable.some 8) (nullable.some (- 8)) (nullable.some 9) (nullable.some (- 9)))) (set.singleton (tuple (nullable.some 1) (nullable.some "A") (nullable.some "B") (nullable.some 4) (nullable.some (- 4)) (nullable.some 5) (nullable.some (- 5)) (nullable.some 6) (nullable.some (- 6))))))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (as nullable.null (Nullable Bool))))
; q2
(get-value (q2))
; (set.union (set.singleton (tuple (nullable.some true))) (set.singleton (tuple (as nullable.null (Nullable Bool)))))
; insert into EMP values(1,'G','H',13,-13,14,-14,15,-15),(1,'E','F',10,-10,11,-11,12,-12),(NULL,'C','D',7,-7,8,-8,9,-9),(1,'A','B',4,-4,5,-5,6,-6)
; SELECT * FROM (SELECT TRUE = ((empno = 1) OR CAST(NULL AS BOOLEAN)) FROM emp) AS q1 EXCEPT ALL SELECT * FROM (SELECT TRUE = ((empno = 1) OR FALSE) FROM emp) AS q2;

; SELECT * FROM (SELECT TRUE = ((empno = 1) OR FALSE) FROM emp) AS q2 EXCEPT ALL SELECT * FROM (SELECT TRUE = ((empno = 1) OR CAST(NULL AS BOOLEAN)) FROM emp) AS q1;

;Model soundness: false
(reset)
; total time: 74964 ms.
; sat answers    : 10
; unsat answers  : 75
; unknown answers: 3
