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
; duration: 25 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_898 Int) (BOUND_VARIABLE_899 Int)) (= BOUND_VARIABLE_898 BOUND_VARIABLE_899)) ((_ tuple.select 6) t) (nullable.some 3))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_898 Int) (BOUND_VARIABLE_899 Int)) (= BOUND_VARIABLE_898 BOUND_VARIABLE_899)) ((_ tuple.select 6) t) (nullable.some 3))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_928 Int) (BOUND_VARIABLE_929 Int)) (= BOUND_VARIABLE_928 BOUND_VARIABLE_929)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_922 Int) (BOUND_VARIABLE_923 Int)) (+ BOUND_VARIABLE_922 BOUND_VARIABLE_923)) ((_ tuple.select 6) t) (nullable.some 5)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_928 Int) (BOUND_VARIABLE_929 Int)) (= BOUND_VARIABLE_928 BOUND_VARIABLE_929)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_922 Int) (BOUND_VARIABLE_923 Int)) (+ BOUND_VARIABLE_922 BOUND_VARIABLE_923)) ((_ tuple.select 6) t) (nullable.some 5))))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_898 Int) (BOUND_VARIABLE_899 Int)) (= BOUND_VARIABLE_898 BOUND_VARIABLE_899)) ((_ tuple.select 6) t) (nullable.some 3))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_928 Int) (BOUND_VARIABLE_929 Int)) (= BOUND_VARIABLE_928 BOUND_VARIABLE_929)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_922 Int) (BOUND_VARIABLE_923 Int)) (+ BOUND_VARIABLE_922 BOUND_VARIABLE_923)) ((_ tuple.select 6) t) (nullable.some 5))))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_898 Int) (BOUND_VARIABLE_899 Int)) (= BOUND_VARIABLE_898 BOUND_VARIABLE_899)) ((_ tuple.select 6) t) (nullable.some 3))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_898 Int) (BOUND_VARIABLE_899 Int)) (= BOUND_VARIABLE_898 BOUND_VARIABLE_899)) ((_ tuple.select 6) t) (nullable.some 3))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_928 Int) (BOUND_VARIABLE_929 Int)) (= BOUND_VARIABLE_928 BOUND_VARIABLE_929)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_922 Int) (BOUND_VARIABLE_923 Int)) (+ BOUND_VARIABLE_922 BOUND_VARIABLE_923)) ((_ tuple.select 6) t) (nullable.some 5)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_928 Int) (BOUND_VARIABLE_929 Int)) (= BOUND_VARIABLE_928 BOUND_VARIABLE_929)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_922 Int) (BOUND_VARIABLE_923 Int)) (+ BOUND_VARIABLE_922 BOUND_VARIABLE_923)) ((_ tuple.select 6) t) (nullable.some 5))))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_898 Int) (BOUND_VARIABLE_899 Int)) (= BOUND_VARIABLE_898 BOUND_VARIABLE_899)) ((_ tuple.select 6) t) (nullable.some 3))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_928 Int) (BOUND_VARIABLE_929 Int)) (= BOUND_VARIABLE_928 BOUND_VARIABLE_929)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_922 Int) (BOUND_VARIABLE_923 Int)) (+ BOUND_VARIABLE_922 BOUND_VARIABLE_923)) ((_ tuple.select 6) t) (nullable.some 5))))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_967 Int) (BOUND_VARIABLE_968 Int)) (= BOUND_VARIABLE_967 BOUND_VARIABLE_968)) ((_ tuple.select 6) t) (nullable.some 3))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_967 Int) (BOUND_VARIABLE_968 Int)) (= BOUND_VARIABLE_967 BOUND_VARIABLE_968)) ((_ tuple.select 6) t) (nullable.some 3))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_976 Int) (BOUND_VARIABLE_977 Int)) (= BOUND_VARIABLE_976 BOUND_VARIABLE_977)) ((_ tuple.select 5) t) (nullable.some 8))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_976 Int) (BOUND_VARIABLE_977 Int)) (= BOUND_VARIABLE_976 BOUND_VARIABLE_977)) ((_ tuple.select 5) t) (nullable.some 8)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_967 Int) (BOUND_VARIABLE_968 Int)) (= BOUND_VARIABLE_967 BOUND_VARIABLE_968)) ((_ tuple.select 6) t) (nullable.some 3))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_976 Int) (BOUND_VARIABLE_977 Int)) (= BOUND_VARIABLE_976 BOUND_VARIABLE_977)) ((_ tuple.select 5) t) (nullable.some 8)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_967 Int) (BOUND_VARIABLE_968 Int)) (= BOUND_VARIABLE_967 BOUND_VARIABLE_968)) ((_ tuple.select 6) t) (nullable.some 3))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_967 Int) (BOUND_VARIABLE_968 Int)) (= BOUND_VARIABLE_967 BOUND_VARIABLE_968)) ((_ tuple.select 6) t) (nullable.some 3))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_976 Int) (BOUND_VARIABLE_977 Int)) (= BOUND_VARIABLE_976 BOUND_VARIABLE_977)) ((_ tuple.select 5) t) (nullable.some 8))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_976 Int) (BOUND_VARIABLE_977 Int)) (= BOUND_VARIABLE_976 BOUND_VARIABLE_977)) ((_ tuple.select 5) t) (nullable.some 8)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_967 Int) (BOUND_VARIABLE_968 Int)) (= BOUND_VARIABLE_967 BOUND_VARIABLE_968)) ((_ tuple.select 6) t) (nullable.some 3))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_976 Int) (BOUND_VARIABLE_977 Int)) (= BOUND_VARIABLE_976 BOUND_VARIABLE_977)) ((_ tuple.select 5) t) (nullable.some 8)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 227 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_3880 Int) (BOUND_VARIABLE_3881 Int)) (= BOUND_VARIABLE_3880 BOUND_VARIABLE_3881)) ((_ tuple.select 6) t) (nullable.some 3))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_3880 Int) (BOUND_VARIABLE_3881 Int)) (= BOUND_VARIABLE_3880 BOUND_VARIABLE_3881)) ((_ tuple.select 6) t) (nullable.some 3))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_3899 Bool)) (not BOUND_VARIABLE_3899)) (nullable.lift (lambda ((BOUND_VARIABLE_3893 Int) (BOUND_VARIABLE_3894 Int)) (= BOUND_VARIABLE_3893 BOUND_VARIABLE_3894)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_3887 Int) (BOUND_VARIABLE_3888 Int)) (+ BOUND_VARIABLE_3887 BOUND_VARIABLE_3888)) ((_ tuple.select 6) t) (nullable.some 5))))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_3899 Bool)) (not BOUND_VARIABLE_3899)) (nullable.lift (lambda ((BOUND_VARIABLE_3893 Int) (BOUND_VARIABLE_3894 Int)) (= BOUND_VARIABLE_3893 BOUND_VARIABLE_3894)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_3887 Int) (BOUND_VARIABLE_3888 Int)) (+ BOUND_VARIABLE_3887 BOUND_VARIABLE_3888)) ((_ tuple.select 6) t) (nullable.some 5)))))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_3880 Int) (BOUND_VARIABLE_3881 Int)) (= BOUND_VARIABLE_3880 BOUND_VARIABLE_3881)) ((_ tuple.select 6) t) (nullable.some 3))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_3899 Bool)) (not BOUND_VARIABLE_3899)) (nullable.lift (lambda ((BOUND_VARIABLE_3893 Int) (BOUND_VARIABLE_3894 Int)) (= BOUND_VARIABLE_3893 BOUND_VARIABLE_3894)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_3887 Int) (BOUND_VARIABLE_3888 Int)) (+ BOUND_VARIABLE_3887 BOUND_VARIABLE_3888)) ((_ tuple.select 6) t) (nullable.some 5)))))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_3880 Int) (BOUND_VARIABLE_3881 Int)) (= BOUND_VARIABLE_3880 BOUND_VARIABLE_3881)) ((_ tuple.select 6) t) (nullable.some 3))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_3880 Int) (BOUND_VARIABLE_3881 Int)) (= BOUND_VARIABLE_3880 BOUND_VARIABLE_3881)) ((_ tuple.select 6) t) (nullable.some 3))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_3899 Bool)) (not BOUND_VARIABLE_3899)) (nullable.lift (lambda ((BOUND_VARIABLE_3893 Int) (BOUND_VARIABLE_3894 Int)) (= BOUND_VARIABLE_3893 BOUND_VARIABLE_3894)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_3887 Int) (BOUND_VARIABLE_3888 Int)) (+ BOUND_VARIABLE_3887 BOUND_VARIABLE_3888)) ((_ tuple.select 6) t) (nullable.some 5))))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_3899 Bool)) (not BOUND_VARIABLE_3899)) (nullable.lift (lambda ((BOUND_VARIABLE_3893 Int) (BOUND_VARIABLE_3894 Int)) (= BOUND_VARIABLE_3893 BOUND_VARIABLE_3894)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_3887 Int) (BOUND_VARIABLE_3888 Int)) (+ BOUND_VARIABLE_3887 BOUND_VARIABLE_3888)) ((_ tuple.select 6) t) (nullable.some 5)))))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_3880 Int) (BOUND_VARIABLE_3881 Int)) (= BOUND_VARIABLE_3880 BOUND_VARIABLE_3881)) ((_ tuple.select 6) t) (nullable.some 3))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_3899 Bool)) (not BOUND_VARIABLE_3899)) (nullable.lift (lambda ((BOUND_VARIABLE_3893 Int) (BOUND_VARIABLE_3894 Int)) (= BOUND_VARIABLE_3893 BOUND_VARIABLE_3894)) ((_ tuple.select 5) t) (nullable.lift (lambda ((BOUND_VARIABLE_3887 Int) (BOUND_VARIABLE_3888 Int)) (+ BOUND_VARIABLE_3887 BOUND_VARIABLE_3888)) ((_ tuple.select 6) t) (nullable.some 5)))))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_3932 Int) (BOUND_VARIABLE_3933 Int)) (= BOUND_VARIABLE_3932 BOUND_VARIABLE_3933)) ((_ tuple.select 6) t) (nullable.some 3))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_3932 Int) (BOUND_VARIABLE_3933 Int)) (= BOUND_VARIABLE_3932 BOUND_VARIABLE_3933)) ((_ tuple.select 6) t) (nullable.some 3))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_3945 Bool)) (not BOUND_VARIABLE_3945)) (nullable.lift (lambda ((BOUND_VARIABLE_3939 Int) (BOUND_VARIABLE_3940 Int)) (= BOUND_VARIABLE_3939 BOUND_VARIABLE_3940)) ((_ tuple.select 5) t) (nullable.some 8)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_3945 Bool)) (not BOUND_VARIABLE_3945)) (nullable.lift (lambda ((BOUND_VARIABLE_3939 Int) (BOUND_VARIABLE_3940 Int)) (= BOUND_VARIABLE_3939 BOUND_VARIABLE_3940)) ((_ tuple.select 5) t) (nullable.some 8))))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_3932 Int) (BOUND_VARIABLE_3933 Int)) (= BOUND_VARIABLE_3932 BOUND_VARIABLE_3933)) ((_ tuple.select 6) t) (nullable.some 3))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_3945 Bool)) (not BOUND_VARIABLE_3945)) (nullable.lift (lambda ((BOUND_VARIABLE_3939 Int) (BOUND_VARIABLE_3940 Int)) (= BOUND_VARIABLE_3939 BOUND_VARIABLE_3940)) ((_ tuple.select 5) t) (nullable.some 8))))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_3932 Int) (BOUND_VARIABLE_3933 Int)) (= BOUND_VARIABLE_3932 BOUND_VARIABLE_3933)) ((_ tuple.select 6) t) (nullable.some 3))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_3932 Int) (BOUND_VARIABLE_3933 Int)) (= BOUND_VARIABLE_3932 BOUND_VARIABLE_3933)) ((_ tuple.select 6) t) (nullable.some 3))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_3945 Bool)) (not BOUND_VARIABLE_3945)) (nullable.lift (lambda ((BOUND_VARIABLE_3939 Int) (BOUND_VARIABLE_3940 Int)) (= BOUND_VARIABLE_3939 BOUND_VARIABLE_3940)) ((_ tuple.select 5) t) (nullable.some 8)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_3945 Bool)) (not BOUND_VARIABLE_3945)) (nullable.lift (lambda ((BOUND_VARIABLE_3939 Int) (BOUND_VARIABLE_3940 Int)) (= BOUND_VARIABLE_3939 BOUND_VARIABLE_3940)) ((_ tuple.select 5) t) (nullable.some 8))))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_3932 Int) (BOUND_VARIABLE_3933 Int)) (= BOUND_VARIABLE_3932 BOUND_VARIABLE_3933)) ((_ tuple.select 6) t) (nullable.some 3))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_3945 Bool)) (not BOUND_VARIABLE_3945)) (nullable.lift (lambda ((BOUND_VARIABLE_3939 Int) (BOUND_VARIABLE_3940 Int)) (= BOUND_VARIABLE_3939 BOUND_VARIABLE_3940)) ((_ tuple.select 5) t) (nullable.some 8))))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 255 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_7225 Int) (BOUND_VARIABLE_7226 Int)) (+ BOUND_VARIABLE_7225 BOUND_VARIABLE_7226)) (nullable.lift (lambda ((BOUND_VARIABLE_7217 Int) (BOUND_VARIABLE_7218 Int)) (+ BOUND_VARIABLE_7217 BOUND_VARIABLE_7218)) (nullable.some (* 1 3)) (nullable.lift (lambda ((BOUND_VARIABLE_7210 Int) (BOUND_VARIABLE_7211 Int)) (+ BOUND_VARIABLE_7210 BOUND_VARIABLE_7211)) ((_ tuple.select 0) t) (nullable.some 2))) (nullable.some (* 3 4)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_7244 Int) (BOUND_VARIABLE_7245 Int)) (+ BOUND_VARIABLE_7244 BOUND_VARIABLE_7245)) ((_ tuple.select 0) t) (nullable.some 17))))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 (set.map f1 DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10022 ms.
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
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_29846 Int) (BOUND_VARIABLE_29847 Int)) (= BOUND_VARIABLE_29846 BOUND_VARIABLE_29847)) ((_ tuple.select 0) t) ((_ tuple.select 2) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_29846 Int) (BOUND_VARIABLE_29847 Int)) (= BOUND_VARIABLE_29846 BOUND_VARIABLE_29847)) ((_ tuple.select 0) t) ((_ tuple.select 2) t)))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (= q1 ((_ rel.project 0 1) (set.filter p1 (rel.product DEPT ((_ rel.project 0) ((_ rel.project 0) (set.filter p0 DEPT))))))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p2 DEPT))))
(check-sat)
;answer: unsat
; duration: 104 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_30676 Int) (BOUND_VARIABLE_30677 Int)) (= BOUND_VARIABLE_30676 BOUND_VARIABLE_30677)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_30676 Int) (BOUND_VARIABLE_30677 Int)) (= BOUND_VARIABLE_30676 BOUND_VARIABLE_30677)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_30682 Int) (BOUND_VARIABLE_30683 Int)) (= BOUND_VARIABLE_30682 BOUND_VARIABLE_30683)) ((_ tuple.select 0) t) (nullable.some 2))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_30682 Int) (BOUND_VARIABLE_30683 Int)) (= BOUND_VARIABLE_30682 BOUND_VARIABLE_30683)) ((_ tuple.select 0) t) (nullable.some 2))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_30676 Int) (BOUND_VARIABLE_30677 Int)) (= BOUND_VARIABLE_30676 BOUND_VARIABLE_30677)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_30676 Int) (BOUND_VARIABLE_30677 Int)) (= BOUND_VARIABLE_30676 BOUND_VARIABLE_30677)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_30682 Int) (BOUND_VARIABLE_30683 Int)) (= BOUND_VARIABLE_30682 BOUND_VARIABLE_30683)) ((_ tuple.select 0) t) (nullable.some 2))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_30682 Int) (BOUND_VARIABLE_30683 Int)) (= BOUND_VARIABLE_30682 BOUND_VARIABLE_30683)) ((_ tuple.select 0) t) (nullable.some 2))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_30709 Int) (BOUND_VARIABLE_30710 Int)) (= BOUND_VARIABLE_30709 BOUND_VARIABLE_30710)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_30709 Int) (BOUND_VARIABLE_30710 Int)) (= BOUND_VARIABLE_30709 BOUND_VARIABLE_30710)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_30715 Int) (BOUND_VARIABLE_30716 Int)) (= BOUND_VARIABLE_30715 BOUND_VARIABLE_30716)) ((_ tuple.select 0) t) (nullable.some 2))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_30715 Int) (BOUND_VARIABLE_30716 Int)) (= BOUND_VARIABLE_30715 BOUND_VARIABLE_30716)) ((_ tuple.select 0) t) (nullable.some 2))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_30709 Int) (BOUND_VARIABLE_30710 Int)) (= BOUND_VARIABLE_30709 BOUND_VARIABLE_30710)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_30709 Int) (BOUND_VARIABLE_30710 Int)) (= BOUND_VARIABLE_30709 BOUND_VARIABLE_30710)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_30715 Int) (BOUND_VARIABLE_30716 Int)) (= BOUND_VARIABLE_30715 BOUND_VARIABLE_30716)) ((_ tuple.select 0) t) (nullable.some 2))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_30715 Int) (BOUND_VARIABLE_30716 Int)) (= BOUND_VARIABLE_30715 BOUND_VARIABLE_30716)) ((_ tuple.select 0) t) (nullable.some 2))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 DEPT))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 186 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_32769 Int) (BOUND_VARIABLE_32770 Int)) (= BOUND_VARIABLE_32769 BOUND_VARIABLE_32770)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_32769 Int) (BOUND_VARIABLE_32770 Int)) (= BOUND_VARIABLE_32769 BOUND_VARIABLE_32770)) ((_ tuple.select 0) t) (nullable.some 1))))) (and (nullable.is_some (nullable.some true)) (not (nullable.val (nullable.some true))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_32769 Int) (BOUND_VARIABLE_32770 Int)) (= BOUND_VARIABLE_32769 BOUND_VARIABLE_32770)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.is_null (nullable.some true))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_32769 Int) (BOUND_VARIABLE_32770 Int)) (= BOUND_VARIABLE_32769 BOUND_VARIABLE_32770)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_32769 Int) (BOUND_VARIABLE_32770 Int)) (= BOUND_VARIABLE_32769 BOUND_VARIABLE_32770)) ((_ tuple.select 0) t) (nullable.some 1))))) (and (nullable.is_some (nullable.some true)) (not (nullable.val (nullable.some true))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_32769 Int) (BOUND_VARIABLE_32770 Int)) (= BOUND_VARIABLE_32769 BOUND_VARIABLE_32770)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.is_null (nullable.some true))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_32803 Int) (BOUND_VARIABLE_32804 Int)) (= BOUND_VARIABLE_32803 BOUND_VARIABLE_32804)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_32803 Int) (BOUND_VARIABLE_32804 Int)) (= BOUND_VARIABLE_32803 BOUND_VARIABLE_32804)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 DEPT))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 64 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_33884 Int) (BOUND_VARIABLE_33885 Int)) (= BOUND_VARIABLE_33884 BOUND_VARIABLE_33885)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_33884 Int) (BOUND_VARIABLE_33885 Int)) (= BOUND_VARIABLE_33884 BOUND_VARIABLE_33885)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false)))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_33884 Int) (BOUND_VARIABLE_33885 Int)) (= BOUND_VARIABLE_33884 BOUND_VARIABLE_33885)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_33884 Int) (BOUND_VARIABLE_33885 Int)) (= BOUND_VARIABLE_33884 BOUND_VARIABLE_33885)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false)))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_33911 Int) (BOUND_VARIABLE_33912 Int)) (= BOUND_VARIABLE_33911 BOUND_VARIABLE_33912)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_33911 Int) (BOUND_VARIABLE_33912 Int)) (= BOUND_VARIABLE_33911 BOUND_VARIABLE_33912)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 DEPT))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 62 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_34903 Int) (BOUND_VARIABLE_34904 Int)) (= BOUND_VARIABLE_34903 BOUND_VARIABLE_34904)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_34903 Int) (BOUND_VARIABLE_34904 Int)) (= BOUND_VARIABLE_34903 BOUND_VARIABLE_34904)) ((_ tuple.select 0) t) (nullable.some 1))))) (and (nullable.is_some (nullable.some false)) (not (nullable.val (nullable.some false))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_34903 Int) (BOUND_VARIABLE_34904 Int)) (= BOUND_VARIABLE_34903 BOUND_VARIABLE_34904)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.is_null (nullable.some false))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_34903 Int) (BOUND_VARIABLE_34904 Int)) (= BOUND_VARIABLE_34903 BOUND_VARIABLE_34904)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_34903 Int) (BOUND_VARIABLE_34904 Int)) (= BOUND_VARIABLE_34903 BOUND_VARIABLE_34904)) ((_ tuple.select 0) t) (nullable.some 1))))) (and (nullable.is_some (nullable.some false)) (not (nullable.val (nullable.some false))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_34903 Int) (BOUND_VARIABLE_34904 Int)) (= BOUND_VARIABLE_34903 BOUND_VARIABLE_34904)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.is_null (nullable.some false))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 DEPT))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 9 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_34974 Int) (BOUND_VARIABLE_34975 Int)) (= BOUND_VARIABLE_34974 BOUND_VARIABLE_34975)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_34974 Int) (BOUND_VARIABLE_34975 Int)) (= BOUND_VARIABLE_34974 BOUND_VARIABLE_34975)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (nullable.some true)) (nullable.val (nullable.some true)))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_34974 Int) (BOUND_VARIABLE_34975 Int)) (= BOUND_VARIABLE_34974 BOUND_VARIABLE_34975)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_34974 Int) (BOUND_VARIABLE_34975 Int)) (= BOUND_VARIABLE_34974 BOUND_VARIABLE_34975)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (nullable.some true)) (nullable.val (nullable.some true)))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 DEPT))))
(assert (= q2 ((_ rel.project 0 1) DEPT)))
(check-sat)
;answer: unsat
; duration: 17 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_35271 Int) (BOUND_VARIABLE_35272 Int)) (> BOUND_VARIABLE_35271 BOUND_VARIABLE_35272)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_35271 Int) (BOUND_VARIABLE_35272 Int)) (> BOUND_VARIABLE_35271 BOUND_VARIABLE_35272)) ((_ tuple.select 0) t) (nullable.some 1))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_35277 Int) (BOUND_VARIABLE_35278 Int)) (<= BOUND_VARIABLE_35277 BOUND_VARIABLE_35278)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_35277 Int) (BOUND_VARIABLE_35278 Int)) (<= BOUND_VARIABLE_35277 BOUND_VARIABLE_35278)) ((_ tuple.select 0) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_35271 Int) (BOUND_VARIABLE_35272 Int)) (> BOUND_VARIABLE_35271 BOUND_VARIABLE_35272)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_35277 Int) (BOUND_VARIABLE_35278 Int)) (<= BOUND_VARIABLE_35277 BOUND_VARIABLE_35278)) ((_ tuple.select 0) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_35271 Int) (BOUND_VARIABLE_35272 Int)) (> BOUND_VARIABLE_35271 BOUND_VARIABLE_35272)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_35271 Int) (BOUND_VARIABLE_35272 Int)) (> BOUND_VARIABLE_35271 BOUND_VARIABLE_35272)) ((_ tuple.select 0) t) (nullable.some 1))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_35277 Int) (BOUND_VARIABLE_35278 Int)) (<= BOUND_VARIABLE_35277 BOUND_VARIABLE_35278)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_35277 Int) (BOUND_VARIABLE_35278 Int)) (<= BOUND_VARIABLE_35277 BOUND_VARIABLE_35278)) ((_ tuple.select 0) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_35271 Int) (BOUND_VARIABLE_35272 Int)) (> BOUND_VARIABLE_35271 BOUND_VARIABLE_35272)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_35277 Int) (BOUND_VARIABLE_35278 Int)) (<= BOUND_VARIABLE_35277 BOUND_VARIABLE_35278)) ((_ tuple.select 0) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (ite (nullable.is_null ((_ tuple.select 0) t)) (as nullable.null (Nullable Bool)) (nullable.some false))) (nullable.val (ite (nullable.is_null ((_ tuple.select 0) t)) (as nullable.null (Nullable Bool)) (nullable.some false)))))))
(assert (= q1 ((_ rel.project 0) (set.filter p0 ANON))))
(assert (= q2 ((_ rel.project 0) (set.filter p1 ANON))))
(check-sat)
;answer: unsat
; duration: 48 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36358 Int) (BOUND_VARIABLE_36359 Int)) (> BOUND_VARIABLE_36358 BOUND_VARIABLE_36359)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36358 Int) (BOUND_VARIABLE_36359 Int)) (> BOUND_VARIABLE_36358 BOUND_VARIABLE_36359)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36364 Int) (BOUND_VARIABLE_36365 Int)) (<= BOUND_VARIABLE_36364 BOUND_VARIABLE_36365)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36364 Int) (BOUND_VARIABLE_36365 Int)) (<= BOUND_VARIABLE_36364 BOUND_VARIABLE_36365)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36371 Int) (BOUND_VARIABLE_36372 Int)) (> BOUND_VARIABLE_36371 BOUND_VARIABLE_36372)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36371 Int) (BOUND_VARIABLE_36372 Int)) (> BOUND_VARIABLE_36371 BOUND_VARIABLE_36372)) ((_ tuple.select 0) t) (nullable.some 5))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (not (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36364 Int) (BOUND_VARIABLE_36365 Int)) (<= BOUND_VARIABLE_36364 BOUND_VARIABLE_36365)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36364 Int) (BOUND_VARIABLE_36365 Int)) (<= BOUND_VARIABLE_36364 BOUND_VARIABLE_36365)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36371 Int) (BOUND_VARIABLE_36372 Int)) (> BOUND_VARIABLE_36371 BOUND_VARIABLE_36372)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36371 Int) (BOUND_VARIABLE_36372 Int)) (> BOUND_VARIABLE_36371 BOUND_VARIABLE_36372)) ((_ tuple.select 0) t) (nullable.some 5))))) (nullable.some true) (as nullable.null (Nullable Bool))))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_36358 Int) (BOUND_VARIABLE_36359 Int)) (> BOUND_VARIABLE_36358 BOUND_VARIABLE_36359)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36364 Int) (BOUND_VARIABLE_36365 Int)) (<= BOUND_VARIABLE_36364 BOUND_VARIABLE_36365)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36364 Int) (BOUND_VARIABLE_36365 Int)) (<= BOUND_VARIABLE_36364 BOUND_VARIABLE_36365)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36371 Int) (BOUND_VARIABLE_36372 Int)) (> BOUND_VARIABLE_36371 BOUND_VARIABLE_36372)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36371 Int) (BOUND_VARIABLE_36372 Int)) (> BOUND_VARIABLE_36371 BOUND_VARIABLE_36372)) ((_ tuple.select 0) t) (nullable.some 5))))) (nullable.some true) (as nullable.null (Nullable Bool))))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36358 Int) (BOUND_VARIABLE_36359 Int)) (> BOUND_VARIABLE_36358 BOUND_VARIABLE_36359)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36358 Int) (BOUND_VARIABLE_36359 Int)) (> BOUND_VARIABLE_36358 BOUND_VARIABLE_36359)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36364 Int) (BOUND_VARIABLE_36365 Int)) (<= BOUND_VARIABLE_36364 BOUND_VARIABLE_36365)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36364 Int) (BOUND_VARIABLE_36365 Int)) (<= BOUND_VARIABLE_36364 BOUND_VARIABLE_36365)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36371 Int) (BOUND_VARIABLE_36372 Int)) (> BOUND_VARIABLE_36371 BOUND_VARIABLE_36372)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36371 Int) (BOUND_VARIABLE_36372 Int)) (> BOUND_VARIABLE_36371 BOUND_VARIABLE_36372)) ((_ tuple.select 0) t) (nullable.some 5))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (not (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36364 Int) (BOUND_VARIABLE_36365 Int)) (<= BOUND_VARIABLE_36364 BOUND_VARIABLE_36365)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36364 Int) (BOUND_VARIABLE_36365 Int)) (<= BOUND_VARIABLE_36364 BOUND_VARIABLE_36365)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36371 Int) (BOUND_VARIABLE_36372 Int)) (> BOUND_VARIABLE_36371 BOUND_VARIABLE_36372)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36371 Int) (BOUND_VARIABLE_36372 Int)) (> BOUND_VARIABLE_36371 BOUND_VARIABLE_36372)) ((_ tuple.select 0) t) (nullable.some 5))))) (nullable.some true) (as nullable.null (Nullable Bool))))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_36358 Int) (BOUND_VARIABLE_36359 Int)) (> BOUND_VARIABLE_36358 BOUND_VARIABLE_36359)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36364 Int) (BOUND_VARIABLE_36365 Int)) (<= BOUND_VARIABLE_36364 BOUND_VARIABLE_36365)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36364 Int) (BOUND_VARIABLE_36365 Int)) (<= BOUND_VARIABLE_36364 BOUND_VARIABLE_36365)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36371 Int) (BOUND_VARIABLE_36372 Int)) (> BOUND_VARIABLE_36371 BOUND_VARIABLE_36372)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36371 Int) (BOUND_VARIABLE_36372 Int)) (> BOUND_VARIABLE_36371 BOUND_VARIABLE_36372)) ((_ tuple.select 0) t) (nullable.some 5))))) (nullable.some true) (as nullable.null (Nullable Bool))))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36413 Int) (BOUND_VARIABLE_36414 Int)) (> BOUND_VARIABLE_36413 BOUND_VARIABLE_36414)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36413 Int) (BOUND_VARIABLE_36414 Int)) (> BOUND_VARIABLE_36413 BOUND_VARIABLE_36414)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36420 Int) (BOUND_VARIABLE_36421 Int)) (> BOUND_VARIABLE_36420 BOUND_VARIABLE_36421)) ((_ tuple.select 0) t) (nullable.some 5))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36420 Int) (BOUND_VARIABLE_36421 Int)) (> BOUND_VARIABLE_36420 BOUND_VARIABLE_36421)) ((_ tuple.select 0) t) (nullable.some 5)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_36413 Int) (BOUND_VARIABLE_36414 Int)) (> BOUND_VARIABLE_36413 BOUND_VARIABLE_36414)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_36420 Int) (BOUND_VARIABLE_36421 Int)) (> BOUND_VARIABLE_36420 BOUND_VARIABLE_36421)) ((_ tuple.select 0) t) (nullable.some 5)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36413 Int) (BOUND_VARIABLE_36414 Int)) (> BOUND_VARIABLE_36413 BOUND_VARIABLE_36414)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36413 Int) (BOUND_VARIABLE_36414 Int)) (> BOUND_VARIABLE_36413 BOUND_VARIABLE_36414)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_36420 Int) (BOUND_VARIABLE_36421 Int)) (> BOUND_VARIABLE_36420 BOUND_VARIABLE_36421)) ((_ tuple.select 0) t) (nullable.some 5))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_36420 Int) (BOUND_VARIABLE_36421 Int)) (> BOUND_VARIABLE_36420 BOUND_VARIABLE_36421)) ((_ tuple.select 0) t) (nullable.some 5)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_36413 Int) (BOUND_VARIABLE_36414 Int)) (> BOUND_VARIABLE_36413 BOUND_VARIABLE_36414)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_36420 Int) (BOUND_VARIABLE_36421 Int)) (> BOUND_VARIABLE_36420 BOUND_VARIABLE_36421)) ((_ tuple.select 0) t) (nullable.some 5)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 173 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_38904 Int) (BOUND_VARIABLE_38905 Int)) (> BOUND_VARIABLE_38904 BOUND_VARIABLE_38905)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_38904 Int) (BOUND_VARIABLE_38905 Int)) (> BOUND_VARIABLE_38904 BOUND_VARIABLE_38905)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_38910 Int) (BOUND_VARIABLE_38911 Int)) (<= BOUND_VARIABLE_38910 BOUND_VARIABLE_38911)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_38910 Int) (BOUND_VARIABLE_38911 Int)) (<= BOUND_VARIABLE_38910 BOUND_VARIABLE_38911)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_38917 Int) (BOUND_VARIABLE_38918 Int)) (> BOUND_VARIABLE_38917 BOUND_VARIABLE_38918)) ((_ tuple.select 0) t) (nullable.some 5))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_38917 Int) (BOUND_VARIABLE_38918 Int)) (> BOUND_VARIABLE_38917 BOUND_VARIABLE_38918)) ((_ tuple.select 0) t) (nullable.some 5)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_38910 Int) (BOUND_VARIABLE_38911 Int)) (<= BOUND_VARIABLE_38910 BOUND_VARIABLE_38911)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_38917 Int) (BOUND_VARIABLE_38918 Int)) (> BOUND_VARIABLE_38917 BOUND_VARIABLE_38918)) ((_ tuple.select 0) t) (nullable.some 5)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_38910 Int) (BOUND_VARIABLE_38911 Int)) (<= BOUND_VARIABLE_38910 BOUND_VARIABLE_38911)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_38910 Int) (BOUND_VARIABLE_38911 Int)) (<= BOUND_VARIABLE_38910 BOUND_VARIABLE_38911)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_38917 Int) (BOUND_VARIABLE_38918 Int)) (> BOUND_VARIABLE_38917 BOUND_VARIABLE_38918)) ((_ tuple.select 0) t) (nullable.some 5))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_38917 Int) (BOUND_VARIABLE_38918 Int)) (> BOUND_VARIABLE_38917 BOUND_VARIABLE_38918)) ((_ tuple.select 0) t) (nullable.some 5)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_38910 Int) (BOUND_VARIABLE_38911 Int)) (<= BOUND_VARIABLE_38910 BOUND_VARIABLE_38911)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_38917 Int) (BOUND_VARIABLE_38918 Int)) (> BOUND_VARIABLE_38917 BOUND_VARIABLE_38918)) ((_ tuple.select 0) t) (nullable.some 5)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_38904 Int) (BOUND_VARIABLE_38905 Int)) (> BOUND_VARIABLE_38904 BOUND_VARIABLE_38905)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_38904 Int) (BOUND_VARIABLE_38905 Int)) (> BOUND_VARIABLE_38904 BOUND_VARIABLE_38905)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_38910 Int) (BOUND_VARIABLE_38911 Int)) (<= BOUND_VARIABLE_38910 BOUND_VARIABLE_38911)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_38910 Int) (BOUND_VARIABLE_38911 Int)) (<= BOUND_VARIABLE_38910 BOUND_VARIABLE_38911)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_38917 Int) (BOUND_VARIABLE_38918 Int)) (> BOUND_VARIABLE_38917 BOUND_VARIABLE_38918)) ((_ tuple.select 0) t) (nullable.some 5))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_38917 Int) (BOUND_VARIABLE_38918 Int)) (> BOUND_VARIABLE_38917 BOUND_VARIABLE_38918)) ((_ tuple.select 0) t) (nullable.some 5)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_38910 Int) (BOUND_VARIABLE_38911 Int)) (<= BOUND_VARIABLE_38910 BOUND_VARIABLE_38911)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_38917 Int) (BOUND_VARIABLE_38918 Int)) (> BOUND_VARIABLE_38917 BOUND_VARIABLE_38918)) ((_ tuple.select 0) t) (nullable.some 5)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_38910 Int) (BOUND_VARIABLE_38911 Int)) (<= BOUND_VARIABLE_38910 BOUND_VARIABLE_38911)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_38910 Int) (BOUND_VARIABLE_38911 Int)) (<= BOUND_VARIABLE_38910 BOUND_VARIABLE_38911)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_38917 Int) (BOUND_VARIABLE_38918 Int)) (> BOUND_VARIABLE_38917 BOUND_VARIABLE_38918)) ((_ tuple.select 0) t) (nullable.some 5))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_38917 Int) (BOUND_VARIABLE_38918 Int)) (> BOUND_VARIABLE_38917 BOUND_VARIABLE_38918)) ((_ tuple.select 0) t) (nullable.some 5)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_38910 Int) (BOUND_VARIABLE_38911 Int)) (<= BOUND_VARIABLE_38910 BOUND_VARIABLE_38911)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_38917 Int) (BOUND_VARIABLE_38918 Int)) (> BOUND_VARIABLE_38917 BOUND_VARIABLE_38918)) ((_ tuple.select 0) t) (nullable.some 5)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_38958 Int) (BOUND_VARIABLE_38959 Int)) (> BOUND_VARIABLE_38958 BOUND_VARIABLE_38959)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_38958 Int) (BOUND_VARIABLE_38959 Int)) (> BOUND_VARIABLE_38958 BOUND_VARIABLE_38959)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_38965 Int) (BOUND_VARIABLE_38966 Int)) (> BOUND_VARIABLE_38965 BOUND_VARIABLE_38966)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_38965 Int) (BOUND_VARIABLE_38966 Int)) (> BOUND_VARIABLE_38965 BOUND_VARIABLE_38966)) ((_ tuple.select 0) t) (nullable.some 5))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_38958 Int) (BOUND_VARIABLE_38959 Int)) (> BOUND_VARIABLE_38958 BOUND_VARIABLE_38959)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_38958 Int) (BOUND_VARIABLE_38959 Int)) (> BOUND_VARIABLE_38958 BOUND_VARIABLE_38959)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_38965 Int) (BOUND_VARIABLE_38966 Int)) (> BOUND_VARIABLE_38965 BOUND_VARIABLE_38966)) ((_ tuple.select 0) t) (nullable.some 5))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_38965 Int) (BOUND_VARIABLE_38966 Int)) (> BOUND_VARIABLE_38965 BOUND_VARIABLE_38966)) ((_ tuple.select 0) t) (nullable.some 5))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
(check-sat)
;answer: sat
; duration: 388 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 6) (nullable.some "A") (nullable.some "B") (nullable.some 3) (nullable.some (- 3)) (nullable.some 4) (as nullable.null (Nullable Int)) (nullable.some (- 4)) (nullable.some 5))))
; )
; q1
(get-value (q1))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some 6) (nullable.some "A") (nullable.some "B") (nullable.some 3) (nullable.some (- 3)) (nullable.some 4) (as nullable.null (Nullable Int)) (nullable.some (- 4)) (nullable.some 5)))
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43761 Int) (BOUND_VARIABLE_43762 Int)) (= BOUND_VARIABLE_43761 BOUND_VARIABLE_43762)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43761 Int) (BOUND_VARIABLE_43762 Int)) (= BOUND_VARIABLE_43761 BOUND_VARIABLE_43762)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43768 Int) (BOUND_VARIABLE_43769 Int)) (= BOUND_VARIABLE_43768 BOUND_VARIABLE_43769)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43768 Int) (BOUND_VARIABLE_43769 Int)) (= BOUND_VARIABLE_43768 BOUND_VARIABLE_43769)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (not (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43761 Int) (BOUND_VARIABLE_43762 Int)) (= BOUND_VARIABLE_43761 BOUND_VARIABLE_43762)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43761 Int) (BOUND_VARIABLE_43762 Int)) (= BOUND_VARIABLE_43761 BOUND_VARIABLE_43762)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43768 Int) (BOUND_VARIABLE_43769 Int)) (= BOUND_VARIABLE_43768 BOUND_VARIABLE_43769)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43768 Int) (BOUND_VARIABLE_43769 Int)) (= BOUND_VARIABLE_43768 BOUND_VARIABLE_43769)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool)))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43789 Int) (BOUND_VARIABLE_43790 Int)) (= BOUND_VARIABLE_43789 BOUND_VARIABLE_43790)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43789 Int) (BOUND_VARIABLE_43790 Int)) (= BOUND_VARIABLE_43789 BOUND_VARIABLE_43790)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43795 Int) (BOUND_VARIABLE_43796 Int)) (= BOUND_VARIABLE_43795 BOUND_VARIABLE_43796)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43795 Int) (BOUND_VARIABLE_43796 Int)) (= BOUND_VARIABLE_43795 BOUND_VARIABLE_43796)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (not (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43789 Int) (BOUND_VARIABLE_43790 Int)) (= BOUND_VARIABLE_43789 BOUND_VARIABLE_43790)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43789 Int) (BOUND_VARIABLE_43790 Int)) (= BOUND_VARIABLE_43789 BOUND_VARIABLE_43790)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43795 Int) (BOUND_VARIABLE_43796 Int)) (= BOUND_VARIABLE_43795 BOUND_VARIABLE_43796)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43795 Int) (BOUND_VARIABLE_43796 Int)) (= BOUND_VARIABLE_43795 BOUND_VARIABLE_43796)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool))))))) (nullable.some false) (ite (or (nullable.is_null (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43761 Int) (BOUND_VARIABLE_43762 Int)) (= BOUND_VARIABLE_43761 BOUND_VARIABLE_43762)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43761 Int) (BOUND_VARIABLE_43762 Int)) (= BOUND_VARIABLE_43761 BOUND_VARIABLE_43762)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43768 Int) (BOUND_VARIABLE_43769 Int)) (= BOUND_VARIABLE_43768 BOUND_VARIABLE_43769)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43768 Int) (BOUND_VARIABLE_43769 Int)) (= BOUND_VARIABLE_43768 BOUND_VARIABLE_43769)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.is_null (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43789 Int) (BOUND_VARIABLE_43790 Int)) (= BOUND_VARIABLE_43789 BOUND_VARIABLE_43790)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43789 Int) (BOUND_VARIABLE_43790 Int)) (= BOUND_VARIABLE_43789 BOUND_VARIABLE_43790)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43795 Int) (BOUND_VARIABLE_43796 Int)) (= BOUND_VARIABLE_43795 BOUND_VARIABLE_43796)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43795 Int) (BOUND_VARIABLE_43796 Int)) (= BOUND_VARIABLE_43795 BOUND_VARIABLE_43796)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool))))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43761 Int) (BOUND_VARIABLE_43762 Int)) (= BOUND_VARIABLE_43761 BOUND_VARIABLE_43762)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43761 Int) (BOUND_VARIABLE_43762 Int)) (= BOUND_VARIABLE_43761 BOUND_VARIABLE_43762)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43768 Int) (BOUND_VARIABLE_43769 Int)) (= BOUND_VARIABLE_43768 BOUND_VARIABLE_43769)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43768 Int) (BOUND_VARIABLE_43769 Int)) (= BOUND_VARIABLE_43768 BOUND_VARIABLE_43769)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (not (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43761 Int) (BOUND_VARIABLE_43762 Int)) (= BOUND_VARIABLE_43761 BOUND_VARIABLE_43762)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43761 Int) (BOUND_VARIABLE_43762 Int)) (= BOUND_VARIABLE_43761 BOUND_VARIABLE_43762)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43768 Int) (BOUND_VARIABLE_43769 Int)) (= BOUND_VARIABLE_43768 BOUND_VARIABLE_43769)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43768 Int) (BOUND_VARIABLE_43769 Int)) (= BOUND_VARIABLE_43768 BOUND_VARIABLE_43769)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool)))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43789 Int) (BOUND_VARIABLE_43790 Int)) (= BOUND_VARIABLE_43789 BOUND_VARIABLE_43790)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43789 Int) (BOUND_VARIABLE_43790 Int)) (= BOUND_VARIABLE_43789 BOUND_VARIABLE_43790)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43795 Int) (BOUND_VARIABLE_43796 Int)) (= BOUND_VARIABLE_43795 BOUND_VARIABLE_43796)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43795 Int) (BOUND_VARIABLE_43796 Int)) (= BOUND_VARIABLE_43795 BOUND_VARIABLE_43796)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (not (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43789 Int) (BOUND_VARIABLE_43790 Int)) (= BOUND_VARIABLE_43789 BOUND_VARIABLE_43790)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43789 Int) (BOUND_VARIABLE_43790 Int)) (= BOUND_VARIABLE_43789 BOUND_VARIABLE_43790)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43795 Int) (BOUND_VARIABLE_43796 Int)) (= BOUND_VARIABLE_43795 BOUND_VARIABLE_43796)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43795 Int) (BOUND_VARIABLE_43796 Int)) (= BOUND_VARIABLE_43795 BOUND_VARIABLE_43796)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool))))))) (nullable.some false) (ite (or (nullable.is_null (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43761 Int) (BOUND_VARIABLE_43762 Int)) (= BOUND_VARIABLE_43761 BOUND_VARIABLE_43762)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43761 Int) (BOUND_VARIABLE_43762 Int)) (= BOUND_VARIABLE_43761 BOUND_VARIABLE_43762)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43768 Int) (BOUND_VARIABLE_43769 Int)) (= BOUND_VARIABLE_43768 BOUND_VARIABLE_43769)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43768 Int) (BOUND_VARIABLE_43769 Int)) (= BOUND_VARIABLE_43768 BOUND_VARIABLE_43769)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.is_null (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43789 Int) (BOUND_VARIABLE_43790 Int)) (= BOUND_VARIABLE_43789 BOUND_VARIABLE_43790)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43789 Int) (BOUND_VARIABLE_43790 Int)) (= BOUND_VARIABLE_43789 BOUND_VARIABLE_43790)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43795 Int) (BOUND_VARIABLE_43796 Int)) (= BOUND_VARIABLE_43795 BOUND_VARIABLE_43796)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43795 Int) (BOUND_VARIABLE_43796 Int)) (= BOUND_VARIABLE_43795 BOUND_VARIABLE_43796)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool))))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43837 Int) (BOUND_VARIABLE_43838 Int)) (= BOUND_VARIABLE_43837 BOUND_VARIABLE_43838)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43837 Int) (BOUND_VARIABLE_43838 Int)) (= BOUND_VARIABLE_43837 BOUND_VARIABLE_43838)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43843 Int) (BOUND_VARIABLE_43844 Int)) (= BOUND_VARIABLE_43843 BOUND_VARIABLE_43844)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43843 Int) (BOUND_VARIABLE_43844 Int)) (= BOUND_VARIABLE_43843 BOUND_VARIABLE_43844)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43837 Int) (BOUND_VARIABLE_43838 Int)) (= BOUND_VARIABLE_43837 BOUND_VARIABLE_43838)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43837 Int) (BOUND_VARIABLE_43838 Int)) (= BOUND_VARIABLE_43837 BOUND_VARIABLE_43838)) ((_ tuple.select 6) t) (nullable.some 50)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_43843 Int) (BOUND_VARIABLE_43844 Int)) (= BOUND_VARIABLE_43843 BOUND_VARIABLE_43844)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_43843 Int) (BOUND_VARIABLE_43844 Int)) (= BOUND_VARIABLE_43843 BOUND_VARIABLE_43844)) ((_ tuple.select 6) t) (nullable.some 100))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_47070 Int) (BOUND_VARIABLE_47071 Int)) (= BOUND_VARIABLE_47070 BOUND_VARIABLE_47071)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_47070 Int) (BOUND_VARIABLE_47071 Int)) (= BOUND_VARIABLE_47070 BOUND_VARIABLE_47071)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_47076 Int) (BOUND_VARIABLE_47077 Int)) (= BOUND_VARIABLE_47076 BOUND_VARIABLE_47077)) ((_ tuple.select 6) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_47076 Int) (BOUND_VARIABLE_47077 Int)) (= BOUND_VARIABLE_47076 BOUND_VARIABLE_47077)) ((_ tuple.select 6) t) (nullable.some 100)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_47070 Int) (BOUND_VARIABLE_47071 Int)) (= BOUND_VARIABLE_47070 BOUND_VARIABLE_47071)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_47076 Int) (BOUND_VARIABLE_47077 Int)) (= BOUND_VARIABLE_47076 BOUND_VARIABLE_47077)) ((_ tuple.select 6) t) (nullable.some 100)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_47070 Int) (BOUND_VARIABLE_47071 Int)) (= BOUND_VARIABLE_47070 BOUND_VARIABLE_47071)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_47070 Int) (BOUND_VARIABLE_47071 Int)) (= BOUND_VARIABLE_47070 BOUND_VARIABLE_47071)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_47076 Int) (BOUND_VARIABLE_47077 Int)) (= BOUND_VARIABLE_47076 BOUND_VARIABLE_47077)) ((_ tuple.select 6) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_47076 Int) (BOUND_VARIABLE_47077 Int)) (= BOUND_VARIABLE_47076 BOUND_VARIABLE_47077)) ((_ tuple.select 6) t) (nullable.some 100)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_47070 Int) (BOUND_VARIABLE_47071 Int)) (= BOUND_VARIABLE_47070 BOUND_VARIABLE_47071)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_47076 Int) (BOUND_VARIABLE_47077 Int)) (= BOUND_VARIABLE_47076 BOUND_VARIABLE_47077)) ((_ tuple.select 6) t) (nullable.some 100)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_47103 Int) (BOUND_VARIABLE_47104 Int)) (= BOUND_VARIABLE_47103 BOUND_VARIABLE_47104)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_47103 Int) (BOUND_VARIABLE_47104 Int)) (= BOUND_VARIABLE_47103 BOUND_VARIABLE_47104)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_47109 Int) (BOUND_VARIABLE_47110 Int)) (= BOUND_VARIABLE_47109 BOUND_VARIABLE_47110)) ((_ tuple.select 6) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_47109 Int) (BOUND_VARIABLE_47110 Int)) (= BOUND_VARIABLE_47109 BOUND_VARIABLE_47110)) ((_ tuple.select 6) t) (nullable.some 100)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_47103 Int) (BOUND_VARIABLE_47104 Int)) (= BOUND_VARIABLE_47103 BOUND_VARIABLE_47104)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_47109 Int) (BOUND_VARIABLE_47110 Int)) (= BOUND_VARIABLE_47109 BOUND_VARIABLE_47110)) ((_ tuple.select 6) t) (nullable.some 100)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_47103 Int) (BOUND_VARIABLE_47104 Int)) (= BOUND_VARIABLE_47103 BOUND_VARIABLE_47104)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_47103 Int) (BOUND_VARIABLE_47104 Int)) (= BOUND_VARIABLE_47103 BOUND_VARIABLE_47104)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_47109 Int) (BOUND_VARIABLE_47110 Int)) (= BOUND_VARIABLE_47109 BOUND_VARIABLE_47110)) ((_ tuple.select 6) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_47109 Int) (BOUND_VARIABLE_47110 Int)) (= BOUND_VARIABLE_47109 BOUND_VARIABLE_47110)) ((_ tuple.select 6) t) (nullable.some 100)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_47103 Int) (BOUND_VARIABLE_47104 Int)) (= BOUND_VARIABLE_47103 BOUND_VARIABLE_47104)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_47109 Int) (BOUND_VARIABLE_47110 Int)) (= BOUND_VARIABLE_47109 BOUND_VARIABLE_47110)) ((_ tuple.select 6) t) (nullable.some 100)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_47070 Int) (BOUND_VARIABLE_47071 Int)) (= BOUND_VARIABLE_47070 BOUND_VARIABLE_47071)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_47070 Int) (BOUND_VARIABLE_47071 Int)) (= BOUND_VARIABLE_47070 BOUND_VARIABLE_47071)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_47076 Int) (BOUND_VARIABLE_47077 Int)) (= BOUND_VARIABLE_47076 BOUND_VARIABLE_47077)) ((_ tuple.select 6) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_47076 Int) (BOUND_VARIABLE_47077 Int)) (= BOUND_VARIABLE_47076 BOUND_VARIABLE_47077)) ((_ tuple.select 6) t) (nullable.some 100)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_47070 Int) (BOUND_VARIABLE_47071 Int)) (= BOUND_VARIABLE_47070 BOUND_VARIABLE_47071)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_47076 Int) (BOUND_VARIABLE_47077 Int)) (= BOUND_VARIABLE_47076 BOUND_VARIABLE_47077)) ((_ tuple.select 6) t) (nullable.some 100)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_47070 Int) (BOUND_VARIABLE_47071 Int)) (= BOUND_VARIABLE_47070 BOUND_VARIABLE_47071)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_47070 Int) (BOUND_VARIABLE_47071 Int)) (= BOUND_VARIABLE_47070 BOUND_VARIABLE_47071)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_47076 Int) (BOUND_VARIABLE_47077 Int)) (= BOUND_VARIABLE_47076 BOUND_VARIABLE_47077)) ((_ tuple.select 6) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_47076 Int) (BOUND_VARIABLE_47077 Int)) (= BOUND_VARIABLE_47076 BOUND_VARIABLE_47077)) ((_ tuple.select 6) t) (nullable.some 100)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_47070 Int) (BOUND_VARIABLE_47071 Int)) (= BOUND_VARIABLE_47070 BOUND_VARIABLE_47071)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_47076 Int) (BOUND_VARIABLE_47077 Int)) (= BOUND_VARIABLE_47076 BOUND_VARIABLE_47077)) ((_ tuple.select 6) t) (nullable.some 100)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_47103 Int) (BOUND_VARIABLE_47104 Int)) (= BOUND_VARIABLE_47103 BOUND_VARIABLE_47104)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_47103 Int) (BOUND_VARIABLE_47104 Int)) (= BOUND_VARIABLE_47103 BOUND_VARIABLE_47104)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_47109 Int) (BOUND_VARIABLE_47110 Int)) (= BOUND_VARIABLE_47109 BOUND_VARIABLE_47110)) ((_ tuple.select 6) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_47109 Int) (BOUND_VARIABLE_47110 Int)) (= BOUND_VARIABLE_47109 BOUND_VARIABLE_47110)) ((_ tuple.select 6) t) (nullable.some 100)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_47103 Int) (BOUND_VARIABLE_47104 Int)) (= BOUND_VARIABLE_47103 BOUND_VARIABLE_47104)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_47109 Int) (BOUND_VARIABLE_47110 Int)) (= BOUND_VARIABLE_47109 BOUND_VARIABLE_47110)) ((_ tuple.select 6) t) (nullable.some 100)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_47103 Int) (BOUND_VARIABLE_47104 Int)) (= BOUND_VARIABLE_47103 BOUND_VARIABLE_47104)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_47103 Int) (BOUND_VARIABLE_47104 Int)) (= BOUND_VARIABLE_47103 BOUND_VARIABLE_47104)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_47109 Int) (BOUND_VARIABLE_47110 Int)) (= BOUND_VARIABLE_47109 BOUND_VARIABLE_47110)) ((_ tuple.select 6) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_47109 Int) (BOUND_VARIABLE_47110 Int)) (= BOUND_VARIABLE_47109 BOUND_VARIABLE_47110)) ((_ tuple.select 6) t) (nullable.some 100)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_47103 Int) (BOUND_VARIABLE_47104 Int)) (= BOUND_VARIABLE_47103 BOUND_VARIABLE_47104)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_47109 Int) (BOUND_VARIABLE_47110 Int)) (= BOUND_VARIABLE_47109 BOUND_VARIABLE_47110)) ((_ tuple.select 6) t) (nullable.some 100)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_47150 Int) (BOUND_VARIABLE_47151 Int)) (= BOUND_VARIABLE_47150 BOUND_VARIABLE_47151)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_47150 Int) (BOUND_VARIABLE_47151 Int)) (= BOUND_VARIABLE_47150 BOUND_VARIABLE_47151)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_47156 Int) (BOUND_VARIABLE_47157 Int)) (= BOUND_VARIABLE_47156 BOUND_VARIABLE_47157)) ((_ tuple.select 6) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_47156 Int) (BOUND_VARIABLE_47157 Int)) (= BOUND_VARIABLE_47156 BOUND_VARIABLE_47157)) ((_ tuple.select 6) t) (nullable.some 100)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_47150 Int) (BOUND_VARIABLE_47151 Int)) (= BOUND_VARIABLE_47150 BOUND_VARIABLE_47151)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_47156 Int) (BOUND_VARIABLE_47157 Int)) (= BOUND_VARIABLE_47156 BOUND_VARIABLE_47157)) ((_ tuple.select 6) t) (nullable.some 100)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_47150 Int) (BOUND_VARIABLE_47151 Int)) (= BOUND_VARIABLE_47150 BOUND_VARIABLE_47151)) ((_ tuple.select 6) t) (nullable.some 50))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_47150 Int) (BOUND_VARIABLE_47151 Int)) (= BOUND_VARIABLE_47150 BOUND_VARIABLE_47151)) ((_ tuple.select 6) t) (nullable.some 50))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_47156 Int) (BOUND_VARIABLE_47157 Int)) (= BOUND_VARIABLE_47156 BOUND_VARIABLE_47157)) ((_ tuple.select 6) t) (nullable.some 100))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_47156 Int) (BOUND_VARIABLE_47157 Int)) (= BOUND_VARIABLE_47156 BOUND_VARIABLE_47157)) ((_ tuple.select 6) t) (nullable.some 100)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_47150 Int) (BOUND_VARIABLE_47151 Int)) (= BOUND_VARIABLE_47150 BOUND_VARIABLE_47151)) ((_ tuple.select 6) t) (nullable.some 50))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_47156 Int) (BOUND_VARIABLE_47157 Int)) (= BOUND_VARIABLE_47156 BOUND_VARIABLE_47157)) ((_ tuple.select 6) t) (nullable.some 100)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 133 ms.
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
; duration: 11 ms.
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
; duration: 5 ms.
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
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple false))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple false))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 (set.map f1 DEPT)))
(check-sat)
;answer: unsat
; duration: 6 ms.
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
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple true))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple true))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 (set.map f1 DEPT)))
(check-sat)
;answer: unsat
; duration: 4 ms.
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
; duration: 12 ms.
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
; duration: 13 ms.
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
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Bool))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_50252 Int) (BOUND_VARIABLE_50253 Int)) (= BOUND_VARIABLE_50252 BOUND_VARIABLE_50253)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_50281 Int) (BOUND_VARIABLE_50282 Int)) (= BOUND_VARIABLE_50281 BOUND_VARIABLE_50282)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 (set.map f1 DEPT)))
(check-sat)
;answer: unsat
; duration: 76 ms.
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
; duration: 6 ms.
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
(assert (not (= q1 q2)))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Bool))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Bool))))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 (set.map f1 DEPT)))
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
; duration: 12 ms.
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
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Bool))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_51380 Int) (BOUND_VARIABLE_51381 Int)) (= BOUND_VARIABLE_51380 BOUND_VARIABLE_51381)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_51396 Int) (BOUND_VARIABLE_51397 Int)) (= BOUND_VARIABLE_51396 BOUND_VARIABLE_51397)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 (set.map f1 DEPT)))
(check-sat)
;answer: unsat
; duration: 39 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_52091 Int) (BOUND_VARIABLE_52092 Int)) (= BOUND_VARIABLE_52091 BOUND_VARIABLE_52092)) ((_ tuple.select 0) t) (nullable.some 1))) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_52097 Int) (BOUND_VARIABLE_52098 Int)) (+ BOUND_VARIABLE_52097 BOUND_VARIABLE_52098)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_52115 Int) (BOUND_VARIABLE_52116 Int)) (= BOUND_VARIABLE_52115 BOUND_VARIABLE_52116)) ((_ tuple.select 0) t) (nullable.some 1))) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_52121 Int) (BOUND_VARIABLE_52122 Int)) (+ BOUND_VARIABLE_52121 BOUND_VARIABLE_52122)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 (set.map f1 DEPT)))
(check-sat)
;answer: unsat
; duration: 37 ms.
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
; duration: 12 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_53033 Int) (BOUND_VARIABLE_53034 Int)) (= BOUND_VARIABLE_53033 BOUND_VARIABLE_53034)) ((_ tuple.select 0) t) (nullable.some 1))) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_53039 Int) (BOUND_VARIABLE_53040 Int)) (+ BOUND_VARIABLE_53039 BOUND_VARIABLE_53040)) ((_ tuple.select 0) t) (nullable.some 100)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_53057 Int) (BOUND_VARIABLE_53058 Int)) (= BOUND_VARIABLE_53057 BOUND_VARIABLE_53058)) ((_ tuple.select 0) t) (nullable.some 1))) ((_ tuple.select 0) t) (nullable.lift (lambda ((BOUND_VARIABLE_53063 Int) (BOUND_VARIABLE_53064 Int)) (+ BOUND_VARIABLE_53063 BOUND_VARIABLE_53064)) ((_ tuple.select 0) t) (nullable.some 100)))))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 (set.map f1 DEPT)))
(check-sat)
;answer: unsat
; duration: 38 ms.
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
; duration: 5 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_53882 Int) (BOUND_VARIABLE_53883 Int)) (= BOUND_VARIABLE_53882 BOUND_VARIABLE_53883)) (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_53873 Int) (BOUND_VARIABLE_53874 Int)) (= BOUND_VARIABLE_53873 BOUND_VARIABLE_53874)) ((_ tuple.select 6) t) (nullable.some 100))) ((_ tuple.select 7) t) (nullable.some 2)) (nullable.some 2))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_53899 Int) (BOUND_VARIABLE_53900 Int)) (= BOUND_VARIABLE_53899 BOUND_VARIABLE_53900)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.lift (lambda ((BOUND_VARIABLE_53906 Int) (BOUND_VARIABLE_53907 Int)) (= BOUND_VARIABLE_53906 BOUND_VARIABLE_53907)) ((_ tuple.select 7) t) (nullable.some 2)) (nullable.some true))))))
(assert (= q1 (set.map f0 T)))
(assert (= q2 (set.map f1 T)))
(check-sat)
;answer: unsat
; duration: 112 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_55614 Int) (BOUND_VARIABLE_55615 Int)) (= BOUND_VARIABLE_55614 BOUND_VARIABLE_55615)) (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_55605 Int) (BOUND_VARIABLE_55606 Int)) (= BOUND_VARIABLE_55605 BOUND_VARIABLE_55606)) ((_ tuple.select 6) t) (nullable.some 100))) ((_ tuple.select 7) t) (nullable.some 2)) (nullable.some 2))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_55630 Int) (BOUND_VARIABLE_55631 Int)) (= BOUND_VARIABLE_55630 BOUND_VARIABLE_55631)) ((_ tuple.select 6) t) (nullable.some 100))) (nullable.lift (lambda ((BOUND_VARIABLE_55637 Int) (BOUND_VARIABLE_55638 Int)) (= BOUND_VARIABLE_55637 BOUND_VARIABLE_55638)) ((_ tuple.select 7) t) (nullable.some 2)) (nullable.some true))))))
(assert (= q1 (set.map f0 T)))
(assert (= q2 (set.map f1 T)))
(check-sat)
;answer: unsat
; duration: 152 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.is_null (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_57398 Int) (BOUND_VARIABLE_57399 Int)) (= BOUND_VARIABLE_57398 BOUND_VARIABLE_57399)) ((_ tuple.select 6) t) (nullable.some 100))) ((_ tuple.select 7) t) (nullable.some 2)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple false))))
(assert (= q1 (set.map f0 T)))
(assert (= q2 (set.map f1 T)))
(check-sat)
;answer: sat
; duration: 57 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.is_null (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_58447 Int) (BOUND_VARIABLE_58448 Int)) (= BOUND_VARIABLE_58447 BOUND_VARIABLE_58448)) ((_ tuple.select 6) t) (nullable.some 100))) ((_ tuple.select 7) t) (nullable.some 2)))))))
(assert (= f1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple false))))
(assert (= q1 (set.map f0 T)))
(assert (= q2 (set.map f1 T)))
(check-sat)
;answer: sat
; duration: 59 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_59372 Bool)) (not BOUND_VARIABLE_59372)) (as nullable.null (Nullable Bool)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (nullable.is_null (as nullable.null (Nullable Bool))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
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
; duration: 12 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_59612 String)) (str.to_upper BOUND_VARIABLE_59612)) (nullable.lift (lambda ((BOUND_VARIABLE_59606 String)) (str.to_lower BOUND_VARIABLE_59606)) ((_ tuple.select 1) t)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_59627 String)) (str.to_upper BOUND_VARIABLE_59627)) ((_ tuple.select 1) t))))))
(assert (= q1 (set.map f0 DEPT)))
(assert (= q2 (set.map f1 DEPT)))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10025 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const ACCOUNT (Set (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable Int))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_85285 Int) (BOUND_VARIABLE_85286 Int)) (= BOUND_VARIABLE_85285 BOUND_VARIABLE_85286)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_85285 Int) (BOUND_VARIABLE_85286 Int)) (= BOUND_VARIABLE_85285 BOUND_VARIABLE_85286)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_85292 Int) (BOUND_VARIABLE_85293 Int)) (= BOUND_VARIABLE_85292 BOUND_VARIABLE_85293)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_85292 Int) (BOUND_VARIABLE_85293 Int)) (= BOUND_VARIABLE_85292 BOUND_VARIABLE_85293)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_85285 Int) (BOUND_VARIABLE_85286 Int)) (= BOUND_VARIABLE_85285 BOUND_VARIABLE_85286)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_85292 Int) (BOUND_VARIABLE_85293 Int)) (= BOUND_VARIABLE_85292 BOUND_VARIABLE_85293)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_85285 Int) (BOUND_VARIABLE_85286 Int)) (= BOUND_VARIABLE_85285 BOUND_VARIABLE_85286)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_85285 Int) (BOUND_VARIABLE_85286 Int)) (= BOUND_VARIABLE_85285 BOUND_VARIABLE_85286)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_85292 Int) (BOUND_VARIABLE_85293 Int)) (= BOUND_VARIABLE_85292 BOUND_VARIABLE_85293)) ((_ tuple.select 0) t) ((_ tuple.select 11) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_85292 Int) (BOUND_VARIABLE_85293 Int)) (= BOUND_VARIABLE_85292 BOUND_VARIABLE_85293)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_85285 Int) (BOUND_VARIABLE_85286 Int)) (= BOUND_VARIABLE_85285 BOUND_VARIABLE_85286)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_85292 Int) (BOUND_VARIABLE_85293 Int)) (= BOUND_VARIABLE_85292 BOUND_VARIABLE_85293)) ((_ tuple.select 0) t) ((_ tuple.select 11) t)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_85377 Int) (BOUND_VARIABLE_85378 Int)) (= BOUND_VARIABLE_85377 BOUND_VARIABLE_85378)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_85377 Int) (BOUND_VARIABLE_85378 Int)) (= BOUND_VARIABLE_85377 BOUND_VARIABLE_85378)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_85451 Int) (BOUND_VARIABLE_85452 Int)) (= BOUND_VARIABLE_85451 BOUND_VARIABLE_85452)) ((_ tuple.select 0) t) ((_ tuple.select 12) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_85451 Int) (BOUND_VARIABLE_85452 Int)) (= BOUND_VARIABLE_85451 BOUND_VARIABLE_85452)) ((_ tuple.select 0) t) ((_ tuple.select 12) t)))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10 11 12 13) (set.filter p0 (rel.product (rel.product EMP DEPT) ACCOUNT)))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 12 13 9 10 11) (set.filter p2 (rel.product (set.filter p1 (rel.product EMP ACCOUNT)) DEPT)))))
(check-sat)
;answer: unsat
; duration: 287 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_87668 Int) (BOUND_VARIABLE_87669 Int)) (= BOUND_VARIABLE_87668 BOUND_VARIABLE_87669)) ((_ tuple.select 6) t) ((_ tuple.select 14) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_87668 Int) (BOUND_VARIABLE_87669 Int)) (= BOUND_VARIABLE_87668 BOUND_VARIABLE_87669)) ((_ tuple.select 6) t) ((_ tuple.select 14) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= p2 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_87728 Int) (BOUND_VARIABLE_87729 Int)) (< BOUND_VARIABLE_87728 BOUND_VARIABLE_87729)) ((_ tuple.select 15) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_87728 Int) (BOUND_VARIABLE_87729 Int)) (< BOUND_VARIABLE_87728 BOUND_VARIABLE_87729)) ((_ tuple.select 15) t) (nullable.some 1)))))))
(assert (= p3 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_87763 Int) (BOUND_VARIABLE_87764 Int)) (< BOUND_VARIABLE_87763 BOUND_VARIABLE_87764)) ((_ tuple.select 6) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_87763 Int) (BOUND_VARIABLE_87764 Int)) (< BOUND_VARIABLE_87763 BOUND_VARIABLE_87764)) ((_ tuple.select 6) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p4 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_87827 Int) (BOUND_VARIABLE_87828 Int)) (= BOUND_VARIABLE_87827 BOUND_VARIABLE_87828)) ((_ tuple.select 6) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_87827 Int) (BOUND_VARIABLE_87828 Int)) (= BOUND_VARIABLE_87827 BOUND_VARIABLE_87828)) ((_ tuple.select 6) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ rel.project 6 5) (set.filter p2 (set.union (set.map leftJoin1 (set.minus T ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 (rel.product T T))))) (set.filter p0 (rel.product T T)))))))
(assert (= q2 ((_ rel.project 6 5) (set.filter p4 (rel.product T ((_ rel.project 5) (set.filter p3 T)))))))
(check-sat)
;answer: unsat
; duration: 6541 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_128193 Int) (BOUND_VARIABLE_128194 Int)) (= BOUND_VARIABLE_128193 BOUND_VARIABLE_128194)) ((_ tuple.select 6) t) ((_ tuple.select 15) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_128193 Int) (BOUND_VARIABLE_128194 Int)) (= BOUND_VARIABLE_128193 BOUND_VARIABLE_128194)) ((_ tuple.select 6) t) ((_ tuple.select 15) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int))))))
(assert (= q1 ((_ rel.project 0) ((_ rel.project 5) (set.union (set.map leftJoin1 (set.minus T ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 (rel.product T T))))) (set.filter p0 (rel.product T T)))))))
(assert (= q2 ((_ rel.project 0) ((_ rel.project 5) T))))
(check-sat)
;answer: unsat
; duration: 414 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_130848 Int) (BOUND_VARIABLE_130849 Int)) (= BOUND_VARIABLE_130848 BOUND_VARIABLE_130849)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_130848 Int) (BOUND_VARIABLE_130849 Int)) (= BOUND_VARIABLE_130848 BOUND_VARIABLE_130849)) ((_ tuple.select 6) t) (nullable.some 0)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_130867 Int) (BOUND_VARIABLE_130868 Int)) (= BOUND_VARIABLE_130867 BOUND_VARIABLE_130868)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_130867 Int) (BOUND_VARIABLE_130868 Int)) (= BOUND_VARIABLE_130867 BOUND_VARIABLE_130868)) ((_ tuple.select 6) t) (nullable.some 0)))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 T))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 T))))
(check-sat)
;answer: unsat
; duration: 133 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= q1 ((_ rel.project 0 1) ((_ rel.project 0 1) (set.union ((_ rel.project 0 1) DEPT) ((_ rel.project 0 1) DEPT))))))
(assert (= q2 ((_ rel.project 0 1) ((_ rel.project 0 1) DEPT))))
(check-sat)
;answer: unsat
; duration: 20 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_132623 Int) (BOUND_VARIABLE_132624 Int)) (> BOUND_VARIABLE_132623 BOUND_VARIABLE_132624)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_132623 Int) (BOUND_VARIABLE_132624 Int)) (> BOUND_VARIABLE_132623 BOUND_VARIABLE_132624)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_132642 Int) (BOUND_VARIABLE_132643 Int)) (> BOUND_VARIABLE_132642 BOUND_VARIABLE_132643)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_132642 Int) (BOUND_VARIABLE_132643 Int)) (> BOUND_VARIABLE_132642 BOUND_VARIABLE_132643)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (= q1 ((_ rel.project 1) (set.filter p0 ((_ rel.project 0 1) DEPT)))))
(assert (= q2 ((_ rel.project 1) (set.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 79 ms.
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
; duration: 7 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_133833 Int) (BOUND_VARIABLE_133834 Int)) (> BOUND_VARIABLE_133833 BOUND_VARIABLE_133834)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_133833 Int) (BOUND_VARIABLE_133834 Int)) (> BOUND_VARIABLE_133833 BOUND_VARIABLE_133834)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_133852 Int) (BOUND_VARIABLE_133853 Int)) (> BOUND_VARIABLE_133852 BOUND_VARIABLE_133853)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_133852 Int) (BOUND_VARIABLE_133853 Int)) (> BOUND_VARIABLE_133852 BOUND_VARIABLE_133853)) ((_ tuple.select 0) t) (nullable.some 1))))) (and (nullable.is_some (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (not (nullable.val (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_133852 Int) (BOUND_VARIABLE_133853 Int)) (> BOUND_VARIABLE_133852 BOUND_VARIABLE_133853)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.is_null (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_133852 Int) (BOUND_VARIABLE_133853 Int)) (> BOUND_VARIABLE_133852 BOUND_VARIABLE_133853)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_133852 Int) (BOUND_VARIABLE_133853 Int)) (> BOUND_VARIABLE_133852 BOUND_VARIABLE_133853)) ((_ tuple.select 0) t) (nullable.some 1))))) (and (nullable.is_some (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (not (nullable.val (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_133852 Int) (BOUND_VARIABLE_133853 Int)) (> BOUND_VARIABLE_133852 BOUND_VARIABLE_133853)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.is_null (nullable.some (not (nullable.is_null ((_ tuple.select 0) t)))))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 DEPT))))
(assert (= q2 ((_ rel.project 0 1) (set.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 71 ms.
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
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_135173 Int) (BOUND_VARIABLE_135174 Int)) (= BOUND_VARIABLE_135173 BOUND_VARIABLE_135174)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_135173 Int) (BOUND_VARIABLE_135174 Int)) (= BOUND_VARIABLE_135173 BOUND_VARIABLE_135174)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_135180 Int) (BOUND_VARIABLE_135181 Int)) (= BOUND_VARIABLE_135180 BOUND_VARIABLE_135181)) ((_ tuple.select 9) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_135180 Int) (BOUND_VARIABLE_135181 Int)) (= BOUND_VARIABLE_135180 BOUND_VARIABLE_135181)) ((_ tuple.select 9) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_135173 Int) (BOUND_VARIABLE_135174 Int)) (= BOUND_VARIABLE_135173 BOUND_VARIABLE_135174)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_135180 Int) (BOUND_VARIABLE_135181 Int)) (= BOUND_VARIABLE_135180 BOUND_VARIABLE_135181)) ((_ tuple.select 9) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_135173 Int) (BOUND_VARIABLE_135174 Int)) (= BOUND_VARIABLE_135173 BOUND_VARIABLE_135174)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_135173 Int) (BOUND_VARIABLE_135174 Int)) (= BOUND_VARIABLE_135173 BOUND_VARIABLE_135174)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_135180 Int) (BOUND_VARIABLE_135181 Int)) (= BOUND_VARIABLE_135180 BOUND_VARIABLE_135181)) ((_ tuple.select 9) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_135180 Int) (BOUND_VARIABLE_135181 Int)) (= BOUND_VARIABLE_135180 BOUND_VARIABLE_135181)) ((_ tuple.select 9) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_135173 Int) (BOUND_VARIABLE_135174 Int)) (= BOUND_VARIABLE_135173 BOUND_VARIABLE_135174)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_135180 Int) (BOUND_VARIABLE_135181 Int)) (= BOUND_VARIABLE_135180 BOUND_VARIABLE_135181)) ((_ tuple.select 9) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (not (nullable.val (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_135217 Int) (BOUND_VARIABLE_135218 Int)) (= BOUND_VARIABLE_135217 BOUND_VARIABLE_135218)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_135217 Int) (BOUND_VARIABLE_135218 Int)) (= BOUND_VARIABLE_135217 BOUND_VARIABLE_135218)) ((_ tuple.select 0) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_135217 Int) (BOUND_VARIABLE_135218 Int)) (= BOUND_VARIABLE_135217 BOUND_VARIABLE_135218)) ((_ tuple.select 0) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (not (nullable.val (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_135217 Int) (BOUND_VARIABLE_135218 Int)) (= BOUND_VARIABLE_135217 BOUND_VARIABLE_135218)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_135217 Int) (BOUND_VARIABLE_135218 Int)) (= BOUND_VARIABLE_135217 BOUND_VARIABLE_135218)) ((_ tuple.select 0) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_135217 Int) (BOUND_VARIABLE_135218 Int)) (= BOUND_VARIABLE_135217 BOUND_VARIABLE_135218)) ((_ tuple.select 0) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 0) t)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (not (nullable.val (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_135270 Int) (BOUND_VARIABLE_135271 Int)) (= BOUND_VARIABLE_135270 BOUND_VARIABLE_135271)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_135270 Int) (BOUND_VARIABLE_135271 Int)) (= BOUND_VARIABLE_135270 BOUND_VARIABLE_135271)) ((_ tuple.select 0) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_135270 Int) (BOUND_VARIABLE_135271 Int)) (= BOUND_VARIABLE_135270 BOUND_VARIABLE_135271)) ((_ tuple.select 0) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (not (nullable.val (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_135270 Int) (BOUND_VARIABLE_135271 Int)) (= BOUND_VARIABLE_135270 BOUND_VARIABLE_135271)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_135270 Int) (BOUND_VARIABLE_135271 Int)) (= BOUND_VARIABLE_135270 BOUND_VARIABLE_135271)) ((_ tuple.select 0) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_135270 Int) (BOUND_VARIABLE_135271 Int)) (= BOUND_VARIABLE_135270 BOUND_VARIABLE_135271)) ((_ tuple.select 0) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_135306 Int) (BOUND_VARIABLE_135307 Int)) (= BOUND_VARIABLE_135306 BOUND_VARIABLE_135307)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_135306 Int) (BOUND_VARIABLE_135307 Int)) (= BOUND_VARIABLE_135306 BOUND_VARIABLE_135307)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_135313 Int) (BOUND_VARIABLE_135314 Int)) (= BOUND_VARIABLE_135313 BOUND_VARIABLE_135314)) ((_ tuple.select 9) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_135313 Int) (BOUND_VARIABLE_135314 Int)) (= BOUND_VARIABLE_135313 BOUND_VARIABLE_135314)) ((_ tuple.select 9) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_135306 Int) (BOUND_VARIABLE_135307 Int)) (= BOUND_VARIABLE_135306 BOUND_VARIABLE_135307)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_135313 Int) (BOUND_VARIABLE_135314 Int)) (= BOUND_VARIABLE_135313 BOUND_VARIABLE_135314)) ((_ tuple.select 9) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_135306 Int) (BOUND_VARIABLE_135307 Int)) (= BOUND_VARIABLE_135306 BOUND_VARIABLE_135307)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_135306 Int) (BOUND_VARIABLE_135307 Int)) (= BOUND_VARIABLE_135306 BOUND_VARIABLE_135307)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_135313 Int) (BOUND_VARIABLE_135314 Int)) (= BOUND_VARIABLE_135313 BOUND_VARIABLE_135314)) ((_ tuple.select 9) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_135313 Int) (BOUND_VARIABLE_135314 Int)) (= BOUND_VARIABLE_135313 BOUND_VARIABLE_135314)) ((_ tuple.select 9) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_135306 Int) (BOUND_VARIABLE_135307 Int)) (= BOUND_VARIABLE_135306 BOUND_VARIABLE_135307)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_135313 Int) (BOUND_VARIABLE_135314 Int)) (= BOUND_VARIABLE_135313 BOUND_VARIABLE_135314)) ((_ tuple.select 9) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 10 11) (set.filter p1 (rel.product (set.map f0 EMP) DEPT)))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 10 11) (set.filter p5 (rel.product (set.map f3 (set.filter p2 EMP)) ((_ rel.project 0 1) (set.filter p4 DEPT)))))))
(check-sat)
;answer: unsat
; duration: 1003 ms.
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
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_143212 Int) (BOUND_VARIABLE_143213 Int)) (= BOUND_VARIABLE_143212 BOUND_VARIABLE_143213)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_143212 Int) (BOUND_VARIABLE_143213 Int)) (= BOUND_VARIABLE_143212 BOUND_VARIABLE_143213)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_143219 Int) (BOUND_VARIABLE_143220 Int)) (= BOUND_VARIABLE_143219 BOUND_VARIABLE_143220)) ((_ tuple.select 9) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_143219 Int) (BOUND_VARIABLE_143220 Int)) (= BOUND_VARIABLE_143219 BOUND_VARIABLE_143220)) ((_ tuple.select 9) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_143212 Int) (BOUND_VARIABLE_143213 Int)) (= BOUND_VARIABLE_143212 BOUND_VARIABLE_143213)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_143219 Int) (BOUND_VARIABLE_143220 Int)) (= BOUND_VARIABLE_143219 BOUND_VARIABLE_143220)) ((_ tuple.select 9) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_143212 Int) (BOUND_VARIABLE_143213 Int)) (= BOUND_VARIABLE_143212 BOUND_VARIABLE_143213)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_143212 Int) (BOUND_VARIABLE_143213 Int)) (= BOUND_VARIABLE_143212 BOUND_VARIABLE_143213)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_143219 Int) (BOUND_VARIABLE_143220 Int)) (= BOUND_VARIABLE_143219 BOUND_VARIABLE_143220)) ((_ tuple.select 9) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_143219 Int) (BOUND_VARIABLE_143220 Int)) (= BOUND_VARIABLE_143219 BOUND_VARIABLE_143220)) ((_ tuple.select 9) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_143212 Int) (BOUND_VARIABLE_143213 Int)) (= BOUND_VARIABLE_143212 BOUND_VARIABLE_143213)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_143219 Int) (BOUND_VARIABLE_143220 Int)) (= BOUND_VARIABLE_143219 BOUND_VARIABLE_143220)) ((_ tuple.select 9) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 9) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= f3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 0) t)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (not (nullable.val (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_143309 Int) (BOUND_VARIABLE_143310 Int)) (= BOUND_VARIABLE_143309 BOUND_VARIABLE_143310)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_143309 Int) (BOUND_VARIABLE_143310 Int)) (= BOUND_VARIABLE_143309 BOUND_VARIABLE_143310)) ((_ tuple.select 0) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_143309 Int) (BOUND_VARIABLE_143310 Int)) (= BOUND_VARIABLE_143309 BOUND_VARIABLE_143310)) ((_ tuple.select 0) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (not (nullable.val (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_143309 Int) (BOUND_VARIABLE_143310 Int)) (= BOUND_VARIABLE_143309 BOUND_VARIABLE_143310)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_143309 Int) (BOUND_VARIABLE_143310 Int)) (= BOUND_VARIABLE_143309 BOUND_VARIABLE_143310)) ((_ tuple.select 0) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.some (not (nullable.is_null ((_ tuple.select 0) t))))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_143309 Int) (BOUND_VARIABLE_143310 Int)) (= BOUND_VARIABLE_143309 BOUND_VARIABLE_143310)) ((_ tuple.select 0) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_143345 Int) (BOUND_VARIABLE_143346 Int)) (= BOUND_VARIABLE_143345 BOUND_VARIABLE_143346)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_143345 Int) (BOUND_VARIABLE_143346 Int)) (= BOUND_VARIABLE_143345 BOUND_VARIABLE_143346)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_143352 Int) (BOUND_VARIABLE_143353 Int)) (= BOUND_VARIABLE_143352 BOUND_VARIABLE_143353)) ((_ tuple.select 9) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_143352 Int) (BOUND_VARIABLE_143353 Int)) (= BOUND_VARIABLE_143352 BOUND_VARIABLE_143353)) ((_ tuple.select 9) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_143345 Int) (BOUND_VARIABLE_143346 Int)) (= BOUND_VARIABLE_143345 BOUND_VARIABLE_143346)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_143352 Int) (BOUND_VARIABLE_143353 Int)) (= BOUND_VARIABLE_143352 BOUND_VARIABLE_143353)) ((_ tuple.select 9) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_143345 Int) (BOUND_VARIABLE_143346 Int)) (= BOUND_VARIABLE_143345 BOUND_VARIABLE_143346)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_143345 Int) (BOUND_VARIABLE_143346 Int)) (= BOUND_VARIABLE_143345 BOUND_VARIABLE_143346)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_143352 Int) (BOUND_VARIABLE_143353 Int)) (= BOUND_VARIABLE_143352 BOUND_VARIABLE_143353)) ((_ tuple.select 9) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_143352 Int) (BOUND_VARIABLE_143353 Int)) (= BOUND_VARIABLE_143352 BOUND_VARIABLE_143353)) ((_ tuple.select 9) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_143345 Int) (BOUND_VARIABLE_143346 Int)) (= BOUND_VARIABLE_143345 BOUND_VARIABLE_143346)) ((_ tuple.select 0) t) ((_ tuple.select 10) t))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_143352 Int) (BOUND_VARIABLE_143353 Int)) (= BOUND_VARIABLE_143352 BOUND_VARIABLE_143353)) ((_ tuple.select 9) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= leftJoin6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 9) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 10 11) (set.union (set.map leftJoin2 (set.minus (set.map f0 EMP) ((_ rel.project 0 1 2 3 4 5 6 7 8 9) (set.filter p1 (rel.product (set.map f0 EMP) DEPT))))) (set.filter p1 (rel.product (set.map f0 EMP) DEPT))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 10 11) (set.union (set.map leftJoin6 (set.minus (set.map f3 EMP) ((_ rel.project 0 1 2 3 4 5 6 7 8 9) (set.filter p5 (rel.product (set.map f3 EMP) ((_ rel.project 0 1) (set.filter p4 DEPT))))))) (set.filter p5 (rel.product (set.map f3 EMP) ((_ rel.project 0 1) (set.filter p4 DEPT))))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10047 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_186675 Int) (BOUND_VARIABLE_186676 Int)) (= BOUND_VARIABLE_186675 BOUND_VARIABLE_186676)) ((_ tuple.select 6) t) (nullable.some 3))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_186675 Int) (BOUND_VARIABLE_186676 Int)) (= BOUND_VARIABLE_186675 BOUND_VARIABLE_186676)) ((_ tuple.select 6) t) (nullable.some 3)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_186696 Int) (BOUND_VARIABLE_186697 Int)) (> BOUND_VARIABLE_186696 BOUND_VARIABLE_186697)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_186696 Int) (BOUND_VARIABLE_186697 Int)) (> BOUND_VARIABLE_186696 BOUND_VARIABLE_186697)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_186716 Int) (BOUND_VARIABLE_186717 Int)) (= BOUND_VARIABLE_186716 BOUND_VARIABLE_186717)) ((_ tuple.select 6) t) (nullable.some 3))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_186716 Int) (BOUND_VARIABLE_186717 Int)) (= BOUND_VARIABLE_186716 BOUND_VARIABLE_186717)) ((_ tuple.select 6) t) (nullable.some 3))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_186723 Int) (BOUND_VARIABLE_186724 Int)) (> BOUND_VARIABLE_186723 BOUND_VARIABLE_186724)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_186723 Int) (BOUND_VARIABLE_186724 Int)) (> BOUND_VARIABLE_186723 BOUND_VARIABLE_186724)) ((_ tuple.select 0) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_186716 Int) (BOUND_VARIABLE_186717 Int)) (= BOUND_VARIABLE_186716 BOUND_VARIABLE_186717)) ((_ tuple.select 6) t) (nullable.some 3))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_186723 Int) (BOUND_VARIABLE_186724 Int)) (> BOUND_VARIABLE_186723 BOUND_VARIABLE_186724)) ((_ tuple.select 0) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_186716 Int) (BOUND_VARIABLE_186717 Int)) (= BOUND_VARIABLE_186716 BOUND_VARIABLE_186717)) ((_ tuple.select 6) t) (nullable.some 3))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_186716 Int) (BOUND_VARIABLE_186717 Int)) (= BOUND_VARIABLE_186716 BOUND_VARIABLE_186717)) ((_ tuple.select 6) t) (nullable.some 3))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_186723 Int) (BOUND_VARIABLE_186724 Int)) (> BOUND_VARIABLE_186723 BOUND_VARIABLE_186724)) ((_ tuple.select 0) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_186723 Int) (BOUND_VARIABLE_186724 Int)) (> BOUND_VARIABLE_186723 BOUND_VARIABLE_186724)) ((_ tuple.select 0) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_186716 Int) (BOUND_VARIABLE_186717 Int)) (= BOUND_VARIABLE_186716 BOUND_VARIABLE_186717)) ((_ tuple.select 6) t) (nullable.some 3))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_186723 Int) (BOUND_VARIABLE_186724 Int)) (> BOUND_VARIABLE_186723 BOUND_VARIABLE_186724)) ((_ tuple.select 0) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p1 ((_ rel.project 0 6) (set.filter p0 EMP))))))
(assert (= q2 ((_ rel.project 0 6) (set.filter p2 EMP))))
(check-sat)
;answer: unsat
; duration: 279 ms.
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
; duration: 9 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_189095 Int) (BOUND_VARIABLE_189096 Int)) (> BOUND_VARIABLE_189095 BOUND_VARIABLE_189096)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_189095 Int) (BOUND_VARIABLE_189096 Int)) (> BOUND_VARIABLE_189095 BOUND_VARIABLE_189096)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_189114 Int) (BOUND_VARIABLE_189115 Int)) (> BOUND_VARIABLE_189114 BOUND_VARIABLE_189115)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_189114 Int) (BOUND_VARIABLE_189115 Int)) (> BOUND_VARIABLE_189114 BOUND_VARIABLE_189115)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_189133 Int) (BOUND_VARIABLE_189134 Int)) (> BOUND_VARIABLE_189133 BOUND_VARIABLE_189134)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_189133 Int) (BOUND_VARIABLE_189134 Int)) (> BOUND_VARIABLE_189133 BOUND_VARIABLE_189134)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP))))
(check-sat)
;answer: unsat
; duration: 161 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_190815 Int) (BOUND_VARIABLE_190816 Int)) (> BOUND_VARIABLE_190815 BOUND_VARIABLE_190816)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_190815 Int) (BOUND_VARIABLE_190816 Int)) (> BOUND_VARIABLE_190815 BOUND_VARIABLE_190816)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_190835 Int) (BOUND_VARIABLE_190836 Int)) (> BOUND_VARIABLE_190835 BOUND_VARIABLE_190836)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_190835 Int) (BOUND_VARIABLE_190836 Int)) (> BOUND_VARIABLE_190835 BOUND_VARIABLE_190836)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_190841 Int) (BOUND_VARIABLE_190842 Int)) (> BOUND_VARIABLE_190841 BOUND_VARIABLE_190842)) ((_ tuple.select 0) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_190841 Int) (BOUND_VARIABLE_190842 Int)) (> BOUND_VARIABLE_190841 BOUND_VARIABLE_190842)) ((_ tuple.select 0) t) (nullable.some 0)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_190835 Int) (BOUND_VARIABLE_190836 Int)) (> BOUND_VARIABLE_190835 BOUND_VARIABLE_190836)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_190841 Int) (BOUND_VARIABLE_190842 Int)) (> BOUND_VARIABLE_190841 BOUND_VARIABLE_190842)) ((_ tuple.select 0) t) (nullable.some 0)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_190835 Int) (BOUND_VARIABLE_190836 Int)) (> BOUND_VARIABLE_190835 BOUND_VARIABLE_190836)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_190835 Int) (BOUND_VARIABLE_190836 Int)) (> BOUND_VARIABLE_190835 BOUND_VARIABLE_190836)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_190841 Int) (BOUND_VARIABLE_190842 Int)) (> BOUND_VARIABLE_190841 BOUND_VARIABLE_190842)) ((_ tuple.select 0) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_190841 Int) (BOUND_VARIABLE_190842 Int)) (> BOUND_VARIABLE_190841 BOUND_VARIABLE_190842)) ((_ tuple.select 0) t) (nullable.some 0)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_190835 Int) (BOUND_VARIABLE_190836 Int)) (> BOUND_VARIABLE_190835 BOUND_VARIABLE_190836)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_190841 Int) (BOUND_VARIABLE_190842 Int)) (> BOUND_VARIABLE_190841 BOUND_VARIABLE_190842)) ((_ tuple.select 0) t) (nullable.some 0)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_190874 Int) (BOUND_VARIABLE_190875 Int)) (> BOUND_VARIABLE_190874 BOUND_VARIABLE_190875)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_190874 Int) (BOUND_VARIABLE_190875 Int)) (> BOUND_VARIABLE_190874 BOUND_VARIABLE_190875)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_190893 Int) (BOUND_VARIABLE_190894 Int)) (> BOUND_VARIABLE_190893 BOUND_VARIABLE_190894)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_190893 Int) (BOUND_VARIABLE_190894 Int)) (> BOUND_VARIABLE_190893 BOUND_VARIABLE_190894)) ((_ tuple.select 0) t) (nullable.some 0)))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP))))))
(check-sat)
;answer: unsat
; duration: 223 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_194126 Int) (BOUND_VARIABLE_194127 Int)) (> BOUND_VARIABLE_194126 BOUND_VARIABLE_194127)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_194126 Int) (BOUND_VARIABLE_194127 Int)) (> BOUND_VARIABLE_194126 BOUND_VARIABLE_194127)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_194145 Int) (BOUND_VARIABLE_194146 Int)) (> BOUND_VARIABLE_194145 BOUND_VARIABLE_194146)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_194145 Int) (BOUND_VARIABLE_194146 Int)) (> BOUND_VARIABLE_194145 BOUND_VARIABLE_194146)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_194151 Int) (BOUND_VARIABLE_194152 Int)) (> BOUND_VARIABLE_194151 BOUND_VARIABLE_194152)) ((_ tuple.select 0) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_194151 Int) (BOUND_VARIABLE_194152 Int)) (> BOUND_VARIABLE_194151 BOUND_VARIABLE_194152)) ((_ tuple.select 0) t) (nullable.some 0)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_194145 Int) (BOUND_VARIABLE_194146 Int)) (> BOUND_VARIABLE_194145 BOUND_VARIABLE_194146)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_194151 Int) (BOUND_VARIABLE_194152 Int)) (> BOUND_VARIABLE_194151 BOUND_VARIABLE_194152)) ((_ tuple.select 0) t) (nullable.some 0)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_194145 Int) (BOUND_VARIABLE_194146 Int)) (> BOUND_VARIABLE_194145 BOUND_VARIABLE_194146)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_194145 Int) (BOUND_VARIABLE_194146 Int)) (> BOUND_VARIABLE_194145 BOUND_VARIABLE_194146)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_194151 Int) (BOUND_VARIABLE_194152 Int)) (> BOUND_VARIABLE_194151 BOUND_VARIABLE_194152)) ((_ tuple.select 0) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_194151 Int) (BOUND_VARIABLE_194152 Int)) (> BOUND_VARIABLE_194151 BOUND_VARIABLE_194152)) ((_ tuple.select 0) t) (nullable.some 0)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_194145 Int) (BOUND_VARIABLE_194146 Int)) (> BOUND_VARIABLE_194145 BOUND_VARIABLE_194146)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_194151 Int) (BOUND_VARIABLE_194152 Int)) (> BOUND_VARIABLE_194151 BOUND_VARIABLE_194152)) ((_ tuple.select 0) t) (nullable.some 0)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_194191 Int) (BOUND_VARIABLE_194192 Int)) (> BOUND_VARIABLE_194191 BOUND_VARIABLE_194192)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_194191 Int) (BOUND_VARIABLE_194192 Int)) (> BOUND_VARIABLE_194191 BOUND_VARIABLE_194192)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_194210 Int) (BOUND_VARIABLE_194211 Int)) (> BOUND_VARIABLE_194210 BOUND_VARIABLE_194211)) ((_ tuple.select 0) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_194210 Int) (BOUND_VARIABLE_194211 Int)) (> BOUND_VARIABLE_194210 BOUND_VARIABLE_194211)) ((_ tuple.select 0) t) (nullable.some 0))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_194217 Int) (BOUND_VARIABLE_194218 Int)) (> BOUND_VARIABLE_194217 BOUND_VARIABLE_194218)) ((_ tuple.select 6) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_194217 Int) (BOUND_VARIABLE_194218 Int)) (> BOUND_VARIABLE_194217 BOUND_VARIABLE_194218)) ((_ tuple.select 6) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_194210 Int) (BOUND_VARIABLE_194211 Int)) (> BOUND_VARIABLE_194210 BOUND_VARIABLE_194211)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_194217 Int) (BOUND_VARIABLE_194218 Int)) (> BOUND_VARIABLE_194217 BOUND_VARIABLE_194218)) ((_ tuple.select 6) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_194210 Int) (BOUND_VARIABLE_194211 Int)) (> BOUND_VARIABLE_194210 BOUND_VARIABLE_194211)) ((_ tuple.select 0) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_194210 Int) (BOUND_VARIABLE_194211 Int)) (> BOUND_VARIABLE_194210 BOUND_VARIABLE_194211)) ((_ tuple.select 0) t) (nullable.some 0))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_194217 Int) (BOUND_VARIABLE_194218 Int)) (> BOUND_VARIABLE_194217 BOUND_VARIABLE_194218)) ((_ tuple.select 6) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_194217 Int) (BOUND_VARIABLE_194218 Int)) (> BOUND_VARIABLE_194217 BOUND_VARIABLE_194218)) ((_ tuple.select 6) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_194210 Int) (BOUND_VARIABLE_194211 Int)) (> BOUND_VARIABLE_194210 BOUND_VARIABLE_194211)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_194217 Int) (BOUND_VARIABLE_194218 Int)) (> BOUND_VARIABLE_194217 BOUND_VARIABLE_194218)) ((_ tuple.select 6) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP))))))
(check-sat)
;answer: unknown (INCOMPLETE)
; duration: 756 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_203640 Int) (BOUND_VARIABLE_203641 Int)) (= BOUND_VARIABLE_203640 BOUND_VARIABLE_203641)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_203640 Int) (BOUND_VARIABLE_203641 Int)) (= BOUND_VARIABLE_203640 BOUND_VARIABLE_203641)) ((_ tuple.select 0) t) (nullable.some 0)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_203660 Int) (BOUND_VARIABLE_203661 Int)) (= BOUND_VARIABLE_203660 BOUND_VARIABLE_203661)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_203660 Int) (BOUND_VARIABLE_203661 Int)) (= BOUND_VARIABLE_203660 BOUND_VARIABLE_203661)) ((_ tuple.select 0) t) (nullable.some 0)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_203679 Int) (BOUND_VARIABLE_203680 Int)) (= BOUND_VARIABLE_203679 BOUND_VARIABLE_203680)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_203679 Int) (BOUND_VARIABLE_203680 Int)) (= BOUND_VARIABLE_203679 BOUND_VARIABLE_203680)) ((_ tuple.select 0) t) (nullable.some 0)))))))
(assert (= q1 ((_ rel.project 0 1) (set.filter p0 (set.union ((_ rel.project 0 1) DEPT) ((_ rel.project 0 1) DEPT))))))
(assert (= q2 (set.union ((_ rel.project 0 1) (set.filter p1 DEPT)) ((_ rel.project 0 1) (set.filter p2 DEPT)))))
(check-sat)
;answer: unsat
; duration: 196 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_205216 Int) (BOUND_VARIABLE_205217 Int)) (> BOUND_VARIABLE_205216 BOUND_VARIABLE_205217)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_205216 Int) (BOUND_VARIABLE_205217 Int)) (> BOUND_VARIABLE_205216 BOUND_VARIABLE_205217)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_205235 Int) (BOUND_VARIABLE_205236 Int)) (> BOUND_VARIABLE_205235 BOUND_VARIABLE_205236)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_205235 Int) (BOUND_VARIABLE_205236 Int)) (> BOUND_VARIABLE_205235 BOUND_VARIABLE_205236)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (= q1 ((_ rel.project 0) (set.filter p0 ((_ rel.project 0) DEPT)))))
(assert (= q2 ((_ rel.project 0) (set.filter p1 DEPT))))
(check-sat)
;answer: unsat
; duration: 68 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_206108 Int) (BOUND_VARIABLE_206109 Int)) (> BOUND_VARIABLE_206108 BOUND_VARIABLE_206109)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_206108 Int) (BOUND_VARIABLE_206109 Int)) (> BOUND_VARIABLE_206108 BOUND_VARIABLE_206109)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_206127 Int) (BOUND_VARIABLE_206128 Int)) (> BOUND_VARIABLE_206127 BOUND_VARIABLE_206128)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_206127 Int) (BOUND_VARIABLE_206128 Int)) (> BOUND_VARIABLE_206127 BOUND_VARIABLE_206128)) ((_ tuple.select 0) t) (nullable.some 10)))))))
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const p6 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const rightJoin1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const rightJoin5 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_207180 Int) (BOUND_VARIABLE_207181 Int)) (= BOUND_VARIABLE_207180 BOUND_VARIABLE_207181)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_207180 Int) (BOUND_VARIABLE_207181 Int)) (= BOUND_VARIABLE_207180 BOUND_VARIABLE_207181)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_207227 Int) (BOUND_VARIABLE_207228 Int)) (> BOUND_VARIABLE_207227 BOUND_VARIABLE_207228)) ((_ tuple.select 6) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_207227 Int) (BOUND_VARIABLE_207228 Int)) (> BOUND_VARIABLE_207227 BOUND_VARIABLE_207228)) ((_ tuple.select 6) t) (nullable.some 0))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_207234 Int) (BOUND_VARIABLE_207235 Int)) (= BOUND_VARIABLE_207234 BOUND_VARIABLE_207235)) ((_ tuple.select 9) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_207234 Int) (BOUND_VARIABLE_207235 Int)) (= BOUND_VARIABLE_207234 BOUND_VARIABLE_207235)) ((_ tuple.select 9) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_207227 Int) (BOUND_VARIABLE_207228 Int)) (> BOUND_VARIABLE_207227 BOUND_VARIABLE_207228)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_207234 Int) (BOUND_VARIABLE_207235 Int)) (= BOUND_VARIABLE_207234 BOUND_VARIABLE_207235)) ((_ tuple.select 9) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_207227 Int) (BOUND_VARIABLE_207228 Int)) (> BOUND_VARIABLE_207227 BOUND_VARIABLE_207228)) ((_ tuple.select 6) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_207227 Int) (BOUND_VARIABLE_207228 Int)) (> BOUND_VARIABLE_207227 BOUND_VARIABLE_207228)) ((_ tuple.select 6) t) (nullable.some 0))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_207234 Int) (BOUND_VARIABLE_207235 Int)) (= BOUND_VARIABLE_207234 BOUND_VARIABLE_207235)) ((_ tuple.select 9) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_207234 Int) (BOUND_VARIABLE_207235 Int)) (= BOUND_VARIABLE_207234 BOUND_VARIABLE_207235)) ((_ tuple.select 9) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_207227 Int) (BOUND_VARIABLE_207228 Int)) (> BOUND_VARIABLE_207227 BOUND_VARIABLE_207228)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_207234 Int) (BOUND_VARIABLE_207235 Int)) (= BOUND_VARIABLE_207234 BOUND_VARIABLE_207235)) ((_ tuple.select 9) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_207268 Int) (BOUND_VARIABLE_207269 Int)) (= BOUND_VARIABLE_207268 BOUND_VARIABLE_207269)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_207268 Int) (BOUND_VARIABLE_207269 Int)) (= BOUND_VARIABLE_207268 BOUND_VARIABLE_207269)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_207289 Int) (BOUND_VARIABLE_207290 Int)) (= BOUND_VARIABLE_207289 BOUND_VARIABLE_207290)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_207289 Int) (BOUND_VARIABLE_207290 Int)) (= BOUND_VARIABLE_207289 BOUND_VARIABLE_207290)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= rightJoin5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_207333 Int) (BOUND_VARIABLE_207334 Int)) (> BOUND_VARIABLE_207333 BOUND_VARIABLE_207334)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_207333 Int) (BOUND_VARIABLE_207334 Int)) (> BOUND_VARIABLE_207333 BOUND_VARIABLE_207334)) ((_ tuple.select 6) t) (nullable.some 0)))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p2 (set.union (set.map rightJoin1 (set.minus DEPT ((_ rel.project 9 10) (set.filter p0 (rel.product EMP DEPT))))) (set.filter p0 (rel.product EMP DEPT)))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p6 (set.union (set.map rightJoin5 (set.minus ((_ rel.project 0 1) (set.filter p3 DEPT)) ((_ rel.project 9 10) (set.filter p4 (rel.product EMP ((_ rel.project 0 1) (set.filter p3 DEPT))))))) (set.filter p4 (rel.product EMP ((_ rel.project 0 1) (set.filter p3 DEPT)))))))))
(check-sat)
;answer: unsat
; duration: 1361 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_216287 Int) (BOUND_VARIABLE_216288 Int)) (= BOUND_VARIABLE_216287 BOUND_VARIABLE_216288)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_216287 Int) (BOUND_VARIABLE_216288 Int)) (= BOUND_VARIABLE_216287 BOUND_VARIABLE_216288)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_216340 Int) (BOUND_VARIABLE_216341 Int)) (> BOUND_VARIABLE_216340 BOUND_VARIABLE_216341)) ((_ tuple.select 6) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_216340 Int) (BOUND_VARIABLE_216341 Int)) (> BOUND_VARIABLE_216340 BOUND_VARIABLE_216341)) ((_ tuple.select 6) t) (nullable.some 0))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_216347 Int) (BOUND_VARIABLE_216348 Int)) (= BOUND_VARIABLE_216347 BOUND_VARIABLE_216348)) ((_ tuple.select 9) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_216347 Int) (BOUND_VARIABLE_216348 Int)) (= BOUND_VARIABLE_216347 BOUND_VARIABLE_216348)) ((_ tuple.select 9) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_216340 Int) (BOUND_VARIABLE_216341 Int)) (> BOUND_VARIABLE_216340 BOUND_VARIABLE_216341)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_216347 Int) (BOUND_VARIABLE_216348 Int)) (= BOUND_VARIABLE_216347 BOUND_VARIABLE_216348)) ((_ tuple.select 9) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_216340 Int) (BOUND_VARIABLE_216341 Int)) (> BOUND_VARIABLE_216340 BOUND_VARIABLE_216341)) ((_ tuple.select 6) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_216340 Int) (BOUND_VARIABLE_216341 Int)) (> BOUND_VARIABLE_216340 BOUND_VARIABLE_216341)) ((_ tuple.select 6) t) (nullable.some 0))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_216347 Int) (BOUND_VARIABLE_216348 Int)) (= BOUND_VARIABLE_216347 BOUND_VARIABLE_216348)) ((_ tuple.select 9) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_216347 Int) (BOUND_VARIABLE_216348 Int)) (= BOUND_VARIABLE_216347 BOUND_VARIABLE_216348)) ((_ tuple.select 9) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_216340 Int) (BOUND_VARIABLE_216341 Int)) (> BOUND_VARIABLE_216340 BOUND_VARIABLE_216341)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_216347 Int) (BOUND_VARIABLE_216348 Int)) (= BOUND_VARIABLE_216347 BOUND_VARIABLE_216348)) ((_ tuple.select 9) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_216380 Int) (BOUND_VARIABLE_216381 Int)) (> BOUND_VARIABLE_216380 BOUND_VARIABLE_216381)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_216380 Int) (BOUND_VARIABLE_216381 Int)) (> BOUND_VARIABLE_216380 BOUND_VARIABLE_216381)) ((_ tuple.select 6) t) (nullable.some 0)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_216401 Int) (BOUND_VARIABLE_216402 Int)) (= BOUND_VARIABLE_216401 BOUND_VARIABLE_216402)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_216401 Int) (BOUND_VARIABLE_216402 Int)) (= BOUND_VARIABLE_216401 BOUND_VARIABLE_216402)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_216452 Int) (BOUND_VARIABLE_216453 Int)) (= BOUND_VARIABLE_216452 BOUND_VARIABLE_216453)) ((_ tuple.select 9) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_216452 Int) (BOUND_VARIABLE_216453 Int)) (= BOUND_VARIABLE_216452 BOUND_VARIABLE_216453)) ((_ tuple.select 9) t) (nullable.some 1)))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p2 (set.union (set.map leftJoin1 (set.minus EMP ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 (rel.product EMP DEPT))))) (set.filter p0 (rel.product EMP DEPT)))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p6 (set.union (set.map leftJoin5 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) DEPT))))) (set.filter p4 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) DEPT)))))))
(check-sat)
;answer: unsat
; duration: 1722 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const p4 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p5 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const f0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool))))
(declare-const f1 (-> (Tuple (Nullable Int) (Nullable String)) (Tuple (Nullable Int) (Nullable String) (Nullable Int))))
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_227117 Int) (BOUND_VARIABLE_227118 Int)) (> BOUND_VARIABLE_227117 BOUND_VARIABLE_227118)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_227245 Int) (BOUND_VARIABLE_227246 Int)) (= BOUND_VARIABLE_227245 BOUND_VARIABLE_227246)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_227245 Int) (BOUND_VARIABLE_227246 Int)) (= BOUND_VARIABLE_227245 BOUND_VARIABLE_227246)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))))) (and (nullable.is_some ((_ tuple.select 9) t)) (not (nullable.val ((_ tuple.select 9) t))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_227245 Int) (BOUND_VARIABLE_227246 Int)) (= BOUND_VARIABLE_227245 BOUND_VARIABLE_227246)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (nullable.is_null ((_ tuple.select 9) t))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_227245 Int) (BOUND_VARIABLE_227246 Int)) (= BOUND_VARIABLE_227245 BOUND_VARIABLE_227246)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_227245 Int) (BOUND_VARIABLE_227246 Int)) (= BOUND_VARIABLE_227245 BOUND_VARIABLE_227246)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))))) (and (nullable.is_some ((_ tuple.select 9) t)) (not (nullable.val ((_ tuple.select 9) t))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_227245 Int) (BOUND_VARIABLE_227246 Int)) (= BOUND_VARIABLE_227245 BOUND_VARIABLE_227246)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (nullable.is_null ((_ tuple.select 9) t))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_227287 Int) (BOUND_VARIABLE_227288 Int)) (> BOUND_VARIABLE_227287 BOUND_VARIABLE_227288)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_227287 Int) (BOUND_VARIABLE_227288 Int)) (> BOUND_VARIABLE_227287 BOUND_VARIABLE_227288)) ((_ tuple.select 6) t) (nullable.some 0)))))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_227306 Int) (BOUND_VARIABLE_227307 Int)) (= BOUND_VARIABLE_227306 BOUND_VARIABLE_227307)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_227306 Int) (BOUND_VARIABLE_227307 Int)) (= BOUND_VARIABLE_227306 BOUND_VARIABLE_227307)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_227327 Int) (BOUND_VARIABLE_227328 Int)) (= BOUND_VARIABLE_227327 BOUND_VARIABLE_227328)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_227327 Int) (BOUND_VARIABLE_227328 Int)) (= BOUND_VARIABLE_227327 BOUND_VARIABLE_227328)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 10 11) (set.filter p2 (rel.product (set.map f0 EMP) (set.map f1 DEPT))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p5 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 EMP)) ((_ rel.project 0 1) (set.filter p4 DEPT)))))))
(check-sat)
;answer: sat
; duration: 560 ms.
(get-model)
; (
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 0) (nullable.some "C"))))
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some 6) (nullable.some "D") (nullable.some "E") (nullable.some (- 6)) (nullable.some 7) (nullable.some (- 7)) (nullable.some 1) (nullable.some 0) (nullable.some 8))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some 6) (nullable.some "D") (nullable.some "E") (nullable.some (- 6)) (nullable.some 7) (nullable.some (- 7)) (nullable.some 1) (nullable.some 0) (nullable.some 8) (nullable.some 0) (nullable.some "C")))
; q2
(get-value (q2))
; (as set.empty (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
; insert into DEPT values(0,'C')
; insert into EMP values(6,'D','E',-6,7,-7,1,0,8)
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_233051 Int) (BOUND_VARIABLE_233052 Int)) (> BOUND_VARIABLE_233051 BOUND_VARIABLE_233052)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_233082 Int) (BOUND_VARIABLE_233083 Int)) (= BOUND_VARIABLE_233082 BOUND_VARIABLE_233083)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_233082 Int) (BOUND_VARIABLE_233083 Int)) (= BOUND_VARIABLE_233082 BOUND_VARIABLE_233083)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))))) (and (nullable.is_some ((_ tuple.select 9) t)) (not (nullable.val ((_ tuple.select 9) t))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_233082 Int) (BOUND_VARIABLE_233083 Int)) (= BOUND_VARIABLE_233082 BOUND_VARIABLE_233083)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (nullable.is_null ((_ tuple.select 9) t))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_233082 Int) (BOUND_VARIABLE_233083 Int)) (= BOUND_VARIABLE_233082 BOUND_VARIABLE_233083)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_233082 Int) (BOUND_VARIABLE_233083 Int)) (= BOUND_VARIABLE_233082 BOUND_VARIABLE_233083)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))))) (and (nullable.is_some ((_ tuple.select 9) t)) (not (nullable.val ((_ tuple.select 9) t))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_233082 Int) (BOUND_VARIABLE_233083 Int)) (= BOUND_VARIABLE_233082 BOUND_VARIABLE_233083)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (nullable.is_null ((_ tuple.select 9) t))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= rightJoin3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Bool)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))
(assert (= p4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_233154 Int) (BOUND_VARIABLE_233155 Int)) (> BOUND_VARIABLE_233154 BOUND_VARIABLE_233155)) ((_ tuple.select 6) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_233154 Int) (BOUND_VARIABLE_233155 Int)) (> BOUND_VARIABLE_233154 BOUND_VARIABLE_233155)) ((_ tuple.select 6) t) (nullable.some 0)))))))
(assert (= f5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_233186 Int) (BOUND_VARIABLE_233187 Int)) (= BOUND_VARIABLE_233186 BOUND_VARIABLE_233187)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_233186 Int) (BOUND_VARIABLE_233187 Int)) (= BOUND_VARIABLE_233186 BOUND_VARIABLE_233187)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_233193 Int) (BOUND_VARIABLE_233194 Int)) (= BOUND_VARIABLE_233193 BOUND_VARIABLE_233194)) ((_ tuple.select 11) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_233193 Int) (BOUND_VARIABLE_233194 Int)) (= BOUND_VARIABLE_233193 BOUND_VARIABLE_233194)) ((_ tuple.select 11) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_233186 Int) (BOUND_VARIABLE_233187 Int)) (= BOUND_VARIABLE_233186 BOUND_VARIABLE_233187)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_233193 Int) (BOUND_VARIABLE_233194 Int)) (= BOUND_VARIABLE_233193 BOUND_VARIABLE_233194)) ((_ tuple.select 11) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_233186 Int) (BOUND_VARIABLE_233187 Int)) (= BOUND_VARIABLE_233186 BOUND_VARIABLE_233187)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_233186 Int) (BOUND_VARIABLE_233187 Int)) (= BOUND_VARIABLE_233186 BOUND_VARIABLE_233187)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_233193 Int) (BOUND_VARIABLE_233194 Int)) (= BOUND_VARIABLE_233193 BOUND_VARIABLE_233194)) ((_ tuple.select 11) t) (nullable.some 1))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_233193 Int) (BOUND_VARIABLE_233194 Int)) (= BOUND_VARIABLE_233193 BOUND_VARIABLE_233194)) ((_ tuple.select 11) t) (nullable.some 1)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_233186 Int) (BOUND_VARIABLE_233187 Int)) (= BOUND_VARIABLE_233186 BOUND_VARIABLE_233187)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_233193 Int) (BOUND_VARIABLE_233194 Int)) (= BOUND_VARIABLE_233193 BOUND_VARIABLE_233194)) ((_ tuple.select 11) t) (nullable.some 1)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= rightJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable Int)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t)))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 10 11) (set.union (set.map rightJoin3 (set.minus (set.map f1 DEPT) ((_ rel.project 10 11 12) (set.filter p2 (rel.product (set.map f0 EMP) (set.map f1 DEPT)))))) (set.filter p2 (rel.product (set.map f0 EMP) (set.map f1 DEPT)))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map rightJoin7 (set.minus (set.map f5 DEPT) ((_ rel.project 9 10 11) (set.filter p6 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)) (set.map f5 DEPT)))))) (set.filter p6 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p4 EMP)) (set.map f5 DEPT)))))))
(check-sat)
;answer: unknown (TIMEOUT)
; duration: 10026 ms.
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_262267 Int) (BOUND_VARIABLE_262268 Int)) (> BOUND_VARIABLE_262267 BOUND_VARIABLE_262268)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 0) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_262298 Int) (BOUND_VARIABLE_262299 Int)) (= BOUND_VARIABLE_262298 BOUND_VARIABLE_262299)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_262298 Int) (BOUND_VARIABLE_262299 Int)) (= BOUND_VARIABLE_262298 BOUND_VARIABLE_262299)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))))) (and (nullable.is_some ((_ tuple.select 9) t)) (not (nullable.val ((_ tuple.select 9) t))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_262298 Int) (BOUND_VARIABLE_262299 Int)) (= BOUND_VARIABLE_262298 BOUND_VARIABLE_262299)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (nullable.is_null ((_ tuple.select 9) t))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_262298 Int) (BOUND_VARIABLE_262299 Int)) (= BOUND_VARIABLE_262298 BOUND_VARIABLE_262299)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_262298 Int) (BOUND_VARIABLE_262299 Int)) (= BOUND_VARIABLE_262298 BOUND_VARIABLE_262299)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))))) (and (nullable.is_some ((_ tuple.select 9) t)) (not (nullable.val ((_ tuple.select 9) t))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_262298 Int) (BOUND_VARIABLE_262299 Int)) (= BOUND_VARIABLE_262298 BOUND_VARIABLE_262299)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (nullable.is_null ((_ tuple.select 9) t))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= leftJoin3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 9) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int))))))
(assert (= f4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (nullable.lift (lambda ((BOUND_VARIABLE_262384 Int) (BOUND_VARIABLE_262385 Int)) (> BOUND_VARIABLE_262384 BOUND_VARIABLE_262385)) ((_ tuple.select 6) t) (nullable.some 0))))))
(assert (= p5 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_262400 Int) (BOUND_VARIABLE_262401 Int)) (= BOUND_VARIABLE_262400 BOUND_VARIABLE_262401)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_262400 Int) (BOUND_VARIABLE_262401 Int)) (= BOUND_VARIABLE_262400 BOUND_VARIABLE_262401)) ((_ tuple.select 0) t) (nullable.some 1)))))))
(assert (not (= q1 q2)))
(assert (= p6 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_262470 Int) (BOUND_VARIABLE_262471 Int)) (= BOUND_VARIABLE_262470 BOUND_VARIABLE_262471)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_262470 Int) (BOUND_VARIABLE_262471 Int)) (= BOUND_VARIABLE_262470 BOUND_VARIABLE_262471)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))))) (and (nullable.is_some ((_ tuple.select 9) t)) (not (nullable.val ((_ tuple.select 9) t))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_262470 Int) (BOUND_VARIABLE_262471 Int)) (= BOUND_VARIABLE_262470 BOUND_VARIABLE_262471)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (nullable.is_null ((_ tuple.select 9) t))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_262470 Int) (BOUND_VARIABLE_262471 Int)) (= BOUND_VARIABLE_262470 BOUND_VARIABLE_262471)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_262470 Int) (BOUND_VARIABLE_262471 Int)) (= BOUND_VARIABLE_262470 BOUND_VARIABLE_262471)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))))) (and (nullable.is_some ((_ tuple.select 9) t)) (not (nullable.val ((_ tuple.select 9) t))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_262470 Int) (BOUND_VARIABLE_262471 Int)) (= BOUND_VARIABLE_262470 BOUND_VARIABLE_262471)) ((_ tuple.select 7) t) ((_ tuple.select 10) t))) (nullable.is_null ((_ tuple.select 9) t))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= leftJoin7 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Bool)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) ((_ tuple.select 9) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 10 11) (set.union (set.map leftJoin3 (set.minus (set.map f0 EMP) ((_ rel.project 0 1 2 3 4 5 6 7 8 9) (set.filter p2 (rel.product (set.map f0 EMP) (set.map f1 DEPT)))))) (set.filter p2 (rel.product (set.map f0 EMP) (set.map f1 DEPT)))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 10 11) (set.union (set.map leftJoin7 (set.minus (set.map f4 EMP) ((_ rel.project 0 1 2 3 4 5 6 7 8 9) (set.filter p6 (rel.product (set.map f4 EMP) ((_ rel.project 0 1) (set.filter p5 DEPT))))))) (set.filter p6 (rel.product (set.map f4 EMP) ((_ rel.project 0 1) (set.filter p5 DEPT))))))))
(check-sat)
;answer: sat
; duration: 743 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.singleton (tuple (nullable.some (- 1)) (nullable.some "") (nullable.some "A") (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some 1) (nullable.some 0) (nullable.some (- 3)))))
; (define-fun DEPT () (Set (Tuple (Nullable Int) (Nullable String))) (set.singleton (tuple (nullable.some 0) (nullable.some "B"))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (nullable.some (- 1)) (nullable.some "") (nullable.some "A") (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some 1) (nullable.some 0) (nullable.some (- 3)) (nullable.some 0) (nullable.some "B")))
; q2
(get-value (q2))
; (set.singleton (tuple (nullable.some (- 1)) (nullable.some "") (nullable.some "A") (nullable.some 2) (nullable.some (- 2)) (nullable.some 3) (nullable.some 1) (nullable.some 0) (nullable.some (- 3)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))
; insert into EMP values(-1,'','A',2,-2,3,1,0,-3)
; insert into DEPT values(0,'B')
; SELECT * FROM (SELECT * FROM emp LEFT JOIN dept ON emp.deptno = dept.deptno AND emp.sal > 0 AND dept.deptno = 1) AS q1 EXCEPT ALL SELECT * FROM (SELECT * FROM emp LEFT JOIN (SELECT * FROM dept WHERE dept.deptno = 1) t0 ON emp.deptno = t0.deptno AND emp.sal > 0) AS q2;

; SELECT * FROM (SELECT * FROM emp LEFT JOIN (SELECT * FROM dept WHERE dept.deptno = 1) t0 ON emp.deptno = t0.deptno AND emp.sal > 0) AS q2 EXCEPT ALL SELECT * FROM (SELECT * FROM emp LEFT JOIN dept ON emp.deptno = dept.deptno AND emp.sal > 0 AND dept.deptno = 1) AS q1;

;Model soundness: false
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
; duration: 16 ms.
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
; duration: 8 ms.
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
; duration: 5 ms.
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
; duration: 25 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool))))) (and (nullable.is_some (nullable.some true)) (not (nullable.val (nullable.some true))))) (nullable.some false) (ite (or (nullable.is_null (as nullable.null (Nullable Bool))) (nullable.is_null (nullable.some true))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool))))) (and (nullable.is_some (nullable.some true)) (not (nullable.val (nullable.some true))))) (nullable.some false) (ite (or (nullable.is_null (as nullable.null (Nullable Bool))) (nullable.is_null (nullable.some true))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
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
; duration: 24 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int))))
(declare-const q2 (Set (Tuple (Nullable Int))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) false)))
(assert (= q1 (set.union ((_ rel.project 0) (set.filter p0 DEPT)) ((_ rel.project 0) EMP))))
(assert (= q2 ((_ rel.project 0) EMP)))
(check-sat)
;answer: unsat
; duration: 20 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_269885 Int) (BOUND_VARIABLE_269886 Int)) (< BOUND_VARIABLE_269885 BOUND_VARIABLE_269886)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_269885 Int) (BOUND_VARIABLE_269886 Int)) (< BOUND_VARIABLE_269885 BOUND_VARIABLE_269886)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_269892 Int) (BOUND_VARIABLE_269893 Int)) (< BOUND_VARIABLE_269892 BOUND_VARIABLE_269893)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_269892 Int) (BOUND_VARIABLE_269893 Int)) (< BOUND_VARIABLE_269892 BOUND_VARIABLE_269893)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_269885 Int) (BOUND_VARIABLE_269886 Int)) (< BOUND_VARIABLE_269885 BOUND_VARIABLE_269886)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_269892 Int) (BOUND_VARIABLE_269893 Int)) (< BOUND_VARIABLE_269892 BOUND_VARIABLE_269893)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_269885 Int) (BOUND_VARIABLE_269886 Int)) (< BOUND_VARIABLE_269885 BOUND_VARIABLE_269886)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_269885 Int) (BOUND_VARIABLE_269886 Int)) (< BOUND_VARIABLE_269885 BOUND_VARIABLE_269886)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_269892 Int) (BOUND_VARIABLE_269893 Int)) (< BOUND_VARIABLE_269892 BOUND_VARIABLE_269893)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_269892 Int) (BOUND_VARIABLE_269893 Int)) (< BOUND_VARIABLE_269892 BOUND_VARIABLE_269893)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_269885 Int) (BOUND_VARIABLE_269886 Int)) (< BOUND_VARIABLE_269885 BOUND_VARIABLE_269886)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_269892 Int) (BOUND_VARIABLE_269893 Int)) (< BOUND_VARIABLE_269892 BOUND_VARIABLE_269893)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_269914 Int) (BOUND_VARIABLE_269915 Int)) (> BOUND_VARIABLE_269914 BOUND_VARIABLE_269915)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_269914 Int) (BOUND_VARIABLE_269915 Int)) (> BOUND_VARIABLE_269914 BOUND_VARIABLE_269915)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_269920 Int) (BOUND_VARIABLE_269921 Int)) (> BOUND_VARIABLE_269920 BOUND_VARIABLE_269921)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_269920 Int) (BOUND_VARIABLE_269921 Int)) (> BOUND_VARIABLE_269920 BOUND_VARIABLE_269921)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_269914 Int) (BOUND_VARIABLE_269915 Int)) (> BOUND_VARIABLE_269914 BOUND_VARIABLE_269915)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_269920 Int) (BOUND_VARIABLE_269921 Int)) (> BOUND_VARIABLE_269920 BOUND_VARIABLE_269921)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_269914 Int) (BOUND_VARIABLE_269915 Int)) (> BOUND_VARIABLE_269914 BOUND_VARIABLE_269915)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_269914 Int) (BOUND_VARIABLE_269915 Int)) (> BOUND_VARIABLE_269914 BOUND_VARIABLE_269915)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_269920 Int) (BOUND_VARIABLE_269921 Int)) (> BOUND_VARIABLE_269920 BOUND_VARIABLE_269921)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_269920 Int) (BOUND_VARIABLE_269921 Int)) (> BOUND_VARIABLE_269920 BOUND_VARIABLE_269921)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_269914 Int) (BOUND_VARIABLE_269915 Int)) (> BOUND_VARIABLE_269914 BOUND_VARIABLE_269915)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_269920 Int) (BOUND_VARIABLE_269921 Int)) (> BOUND_VARIABLE_269920 BOUND_VARIABLE_269921)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_269885 Int) (BOUND_VARIABLE_269886 Int)) (< BOUND_VARIABLE_269885 BOUND_VARIABLE_269886)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_269885 Int) (BOUND_VARIABLE_269886 Int)) (< BOUND_VARIABLE_269885 BOUND_VARIABLE_269886)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_269892 Int) (BOUND_VARIABLE_269893 Int)) (< BOUND_VARIABLE_269892 BOUND_VARIABLE_269893)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_269892 Int) (BOUND_VARIABLE_269893 Int)) (< BOUND_VARIABLE_269892 BOUND_VARIABLE_269893)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_269885 Int) (BOUND_VARIABLE_269886 Int)) (< BOUND_VARIABLE_269885 BOUND_VARIABLE_269886)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_269892 Int) (BOUND_VARIABLE_269893 Int)) (< BOUND_VARIABLE_269892 BOUND_VARIABLE_269893)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_269885 Int) (BOUND_VARIABLE_269886 Int)) (< BOUND_VARIABLE_269885 BOUND_VARIABLE_269886)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_269885 Int) (BOUND_VARIABLE_269886 Int)) (< BOUND_VARIABLE_269885 BOUND_VARIABLE_269886)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_269892 Int) (BOUND_VARIABLE_269893 Int)) (< BOUND_VARIABLE_269892 BOUND_VARIABLE_269893)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_269892 Int) (BOUND_VARIABLE_269893 Int)) (< BOUND_VARIABLE_269892 BOUND_VARIABLE_269893)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_269885 Int) (BOUND_VARIABLE_269886 Int)) (< BOUND_VARIABLE_269885 BOUND_VARIABLE_269886)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_269892 Int) (BOUND_VARIABLE_269893 Int)) (< BOUND_VARIABLE_269892 BOUND_VARIABLE_269893)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_269914 Int) (BOUND_VARIABLE_269915 Int)) (> BOUND_VARIABLE_269914 BOUND_VARIABLE_269915)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_269914 Int) (BOUND_VARIABLE_269915 Int)) (> BOUND_VARIABLE_269914 BOUND_VARIABLE_269915)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_269920 Int) (BOUND_VARIABLE_269921 Int)) (> BOUND_VARIABLE_269920 BOUND_VARIABLE_269921)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_269920 Int) (BOUND_VARIABLE_269921 Int)) (> BOUND_VARIABLE_269920 BOUND_VARIABLE_269921)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_269914 Int) (BOUND_VARIABLE_269915 Int)) (> BOUND_VARIABLE_269914 BOUND_VARIABLE_269915)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_269920 Int) (BOUND_VARIABLE_269921 Int)) (> BOUND_VARIABLE_269920 BOUND_VARIABLE_269921)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_269914 Int) (BOUND_VARIABLE_269915 Int)) (> BOUND_VARIABLE_269914 BOUND_VARIABLE_269915)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_269914 Int) (BOUND_VARIABLE_269915 Int)) (> BOUND_VARIABLE_269914 BOUND_VARIABLE_269915)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_269920 Int) (BOUND_VARIABLE_269921 Int)) (> BOUND_VARIABLE_269920 BOUND_VARIABLE_269921)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_269920 Int) (BOUND_VARIABLE_269921 Int)) (> BOUND_VARIABLE_269920 BOUND_VARIABLE_269921)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_269914 Int) (BOUND_VARIABLE_269915 Int)) (> BOUND_VARIABLE_269914 BOUND_VARIABLE_269915)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_269920 Int) (BOUND_VARIABLE_269921 Int)) (> BOUND_VARIABLE_269920 BOUND_VARIABLE_269921)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_269961 Int) (BOUND_VARIABLE_269962 Int)) (< BOUND_VARIABLE_269961 BOUND_VARIABLE_269962)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_269961 Int) (BOUND_VARIABLE_269962 Int)) (< BOUND_VARIABLE_269961 BOUND_VARIABLE_269962)) ((_ tuple.select 0) t) (nullable.some 10)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_269967 Int) (BOUND_VARIABLE_269968 Int)) (> BOUND_VARIABLE_269967 BOUND_VARIABLE_269968)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_269967 Int) (BOUND_VARIABLE_269968 Int)) (> BOUND_VARIABLE_269967 BOUND_VARIABLE_269968)) ((_ tuple.select 0) t) (nullable.some 20))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_269961 Int) (BOUND_VARIABLE_269962 Int)) (< BOUND_VARIABLE_269961 BOUND_VARIABLE_269962)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_269961 Int) (BOUND_VARIABLE_269962 Int)) (< BOUND_VARIABLE_269961 BOUND_VARIABLE_269962)) ((_ tuple.select 0) t) (nullable.some 10)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_269967 Int) (BOUND_VARIABLE_269968 Int)) (> BOUND_VARIABLE_269967 BOUND_VARIABLE_269968)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_269967 Int) (BOUND_VARIABLE_269968 Int)) (> BOUND_VARIABLE_269967 BOUND_VARIABLE_269968)) ((_ tuple.select 0) t) (nullable.some 20))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_269994 Int) (BOUND_VARIABLE_269995 Int)) (< BOUND_VARIABLE_269994 BOUND_VARIABLE_269995)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_269994 Int) (BOUND_VARIABLE_269995 Int)) (< BOUND_VARIABLE_269994 BOUND_VARIABLE_269995)) ((_ tuple.select 0) t) (nullable.some 10)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_270000 Int) (BOUND_VARIABLE_270001 Int)) (> BOUND_VARIABLE_270000 BOUND_VARIABLE_270001)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_270000 Int) (BOUND_VARIABLE_270001 Int)) (> BOUND_VARIABLE_270000 BOUND_VARIABLE_270001)) ((_ tuple.select 0) t) (nullable.some 20))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_269994 Int) (BOUND_VARIABLE_269995 Int)) (< BOUND_VARIABLE_269994 BOUND_VARIABLE_269995)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_269994 Int) (BOUND_VARIABLE_269995 Int)) (< BOUND_VARIABLE_269994 BOUND_VARIABLE_269995)) ((_ tuple.select 0) t) (nullable.some 10)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_270000 Int) (BOUND_VARIABLE_270001 Int)) (> BOUND_VARIABLE_270000 BOUND_VARIABLE_270001)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_270000 Int) (BOUND_VARIABLE_270001 Int)) (> BOUND_VARIABLE_270000 BOUND_VARIABLE_270001)) ((_ tuple.select 0) t) (nullable.some 20))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_270028 Int) (BOUND_VARIABLE_270029 Int)) (< BOUND_VARIABLE_270028 BOUND_VARIABLE_270029)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_270028 Int) (BOUND_VARIABLE_270029 Int)) (< BOUND_VARIABLE_270028 BOUND_VARIABLE_270029)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_270035 Int) (BOUND_VARIABLE_270036 Int)) (< BOUND_VARIABLE_270035 BOUND_VARIABLE_270036)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_270035 Int) (BOUND_VARIABLE_270036 Int)) (< BOUND_VARIABLE_270035 BOUND_VARIABLE_270036)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_270028 Int) (BOUND_VARIABLE_270029 Int)) (< BOUND_VARIABLE_270028 BOUND_VARIABLE_270029)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_270035 Int) (BOUND_VARIABLE_270036 Int)) (< BOUND_VARIABLE_270035 BOUND_VARIABLE_270036)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_270028 Int) (BOUND_VARIABLE_270029 Int)) (< BOUND_VARIABLE_270028 BOUND_VARIABLE_270029)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_270028 Int) (BOUND_VARIABLE_270029 Int)) (< BOUND_VARIABLE_270028 BOUND_VARIABLE_270029)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_270035 Int) (BOUND_VARIABLE_270036 Int)) (< BOUND_VARIABLE_270035 BOUND_VARIABLE_270036)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_270035 Int) (BOUND_VARIABLE_270036 Int)) (< BOUND_VARIABLE_270035 BOUND_VARIABLE_270036)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_270028 Int) (BOUND_VARIABLE_270029 Int)) (< BOUND_VARIABLE_270028 BOUND_VARIABLE_270029)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_270035 Int) (BOUND_VARIABLE_270036 Int)) (< BOUND_VARIABLE_270035 BOUND_VARIABLE_270036)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_270055 Int) (BOUND_VARIABLE_270056 Int)) (> BOUND_VARIABLE_270055 BOUND_VARIABLE_270056)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_270055 Int) (BOUND_VARIABLE_270056 Int)) (> BOUND_VARIABLE_270055 BOUND_VARIABLE_270056)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_270061 Int) (BOUND_VARIABLE_270062 Int)) (> BOUND_VARIABLE_270061 BOUND_VARIABLE_270062)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_270061 Int) (BOUND_VARIABLE_270062 Int)) (> BOUND_VARIABLE_270061 BOUND_VARIABLE_270062)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_270055 Int) (BOUND_VARIABLE_270056 Int)) (> BOUND_VARIABLE_270055 BOUND_VARIABLE_270056)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_270061 Int) (BOUND_VARIABLE_270062 Int)) (> BOUND_VARIABLE_270061 BOUND_VARIABLE_270062)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_270055 Int) (BOUND_VARIABLE_270056 Int)) (> BOUND_VARIABLE_270055 BOUND_VARIABLE_270056)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_270055 Int) (BOUND_VARIABLE_270056 Int)) (> BOUND_VARIABLE_270055 BOUND_VARIABLE_270056)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_270061 Int) (BOUND_VARIABLE_270062 Int)) (> BOUND_VARIABLE_270061 BOUND_VARIABLE_270062)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_270061 Int) (BOUND_VARIABLE_270062 Int)) (> BOUND_VARIABLE_270061 BOUND_VARIABLE_270062)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_270055 Int) (BOUND_VARIABLE_270056 Int)) (> BOUND_VARIABLE_270055 BOUND_VARIABLE_270056)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_270061 Int) (BOUND_VARIABLE_270062 Int)) (> BOUND_VARIABLE_270061 BOUND_VARIABLE_270062)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_270028 Int) (BOUND_VARIABLE_270029 Int)) (< BOUND_VARIABLE_270028 BOUND_VARIABLE_270029)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_270028 Int) (BOUND_VARIABLE_270029 Int)) (< BOUND_VARIABLE_270028 BOUND_VARIABLE_270029)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_270035 Int) (BOUND_VARIABLE_270036 Int)) (< BOUND_VARIABLE_270035 BOUND_VARIABLE_270036)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_270035 Int) (BOUND_VARIABLE_270036 Int)) (< BOUND_VARIABLE_270035 BOUND_VARIABLE_270036)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_270028 Int) (BOUND_VARIABLE_270029 Int)) (< BOUND_VARIABLE_270028 BOUND_VARIABLE_270029)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_270035 Int) (BOUND_VARIABLE_270036 Int)) (< BOUND_VARIABLE_270035 BOUND_VARIABLE_270036)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_270028 Int) (BOUND_VARIABLE_270029 Int)) (< BOUND_VARIABLE_270028 BOUND_VARIABLE_270029)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_270028 Int) (BOUND_VARIABLE_270029 Int)) (< BOUND_VARIABLE_270028 BOUND_VARIABLE_270029)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_270035 Int) (BOUND_VARIABLE_270036 Int)) (< BOUND_VARIABLE_270035 BOUND_VARIABLE_270036)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_270035 Int) (BOUND_VARIABLE_270036 Int)) (< BOUND_VARIABLE_270035 BOUND_VARIABLE_270036)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_270028 Int) (BOUND_VARIABLE_270029 Int)) (< BOUND_VARIABLE_270028 BOUND_VARIABLE_270029)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_270035 Int) (BOUND_VARIABLE_270036 Int)) (< BOUND_VARIABLE_270035 BOUND_VARIABLE_270036)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_270055 Int) (BOUND_VARIABLE_270056 Int)) (> BOUND_VARIABLE_270055 BOUND_VARIABLE_270056)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_270055 Int) (BOUND_VARIABLE_270056 Int)) (> BOUND_VARIABLE_270055 BOUND_VARIABLE_270056)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_270061 Int) (BOUND_VARIABLE_270062 Int)) (> BOUND_VARIABLE_270061 BOUND_VARIABLE_270062)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_270061 Int) (BOUND_VARIABLE_270062 Int)) (> BOUND_VARIABLE_270061 BOUND_VARIABLE_270062)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_270055 Int) (BOUND_VARIABLE_270056 Int)) (> BOUND_VARIABLE_270055 BOUND_VARIABLE_270056)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_270061 Int) (BOUND_VARIABLE_270062 Int)) (> BOUND_VARIABLE_270061 BOUND_VARIABLE_270062)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_270055 Int) (BOUND_VARIABLE_270056 Int)) (> BOUND_VARIABLE_270055 BOUND_VARIABLE_270056)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_270055 Int) (BOUND_VARIABLE_270056 Int)) (> BOUND_VARIABLE_270055 BOUND_VARIABLE_270056)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_270061 Int) (BOUND_VARIABLE_270062 Int)) (> BOUND_VARIABLE_270061 BOUND_VARIABLE_270062)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_270061 Int) (BOUND_VARIABLE_270062 Int)) (> BOUND_VARIABLE_270061 BOUND_VARIABLE_270062)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_270055 Int) (BOUND_VARIABLE_270056 Int)) (> BOUND_VARIABLE_270055 BOUND_VARIABLE_270056)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_270061 Int) (BOUND_VARIABLE_270062 Int)) (> BOUND_VARIABLE_270061 BOUND_VARIABLE_270062)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p0 (rel.product EMP DEPT)))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p3 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)) ((_ rel.project 0 1) (set.filter p2 DEPT)))))))
(check-sat)
;answer: unsat
; duration: 779 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277165 Int) (BOUND_VARIABLE_277166 Int)) (> BOUND_VARIABLE_277165 BOUND_VARIABLE_277166)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277165 Int) (BOUND_VARIABLE_277166 Int)) (> BOUND_VARIABLE_277165 BOUND_VARIABLE_277166)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277171 Int) (BOUND_VARIABLE_277172 Int)) (<= BOUND_VARIABLE_277171 BOUND_VARIABLE_277172)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277171 Int) (BOUND_VARIABLE_277172 Int)) (<= BOUND_VARIABLE_277171 BOUND_VARIABLE_277172)) ((_ tuple.select 0) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277165 Int) (BOUND_VARIABLE_277166 Int)) (> BOUND_VARIABLE_277165 BOUND_VARIABLE_277166)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277171 Int) (BOUND_VARIABLE_277172 Int)) (<= BOUND_VARIABLE_277171 BOUND_VARIABLE_277172)) ((_ tuple.select 0) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277165 Int) (BOUND_VARIABLE_277166 Int)) (> BOUND_VARIABLE_277165 BOUND_VARIABLE_277166)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277165 Int) (BOUND_VARIABLE_277166 Int)) (> BOUND_VARIABLE_277165 BOUND_VARIABLE_277166)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277171 Int) (BOUND_VARIABLE_277172 Int)) (<= BOUND_VARIABLE_277171 BOUND_VARIABLE_277172)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277171 Int) (BOUND_VARIABLE_277172 Int)) (<= BOUND_VARIABLE_277171 BOUND_VARIABLE_277172)) ((_ tuple.select 0) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277165 Int) (BOUND_VARIABLE_277166 Int)) (> BOUND_VARIABLE_277165 BOUND_VARIABLE_277166)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277171 Int) (BOUND_VARIABLE_277172 Int)) (<= BOUND_VARIABLE_277171 BOUND_VARIABLE_277172)) ((_ tuple.select 0) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277191 Int) (BOUND_VARIABLE_277192 Int)) (> BOUND_VARIABLE_277191 BOUND_VARIABLE_277192)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277191 Int) (BOUND_VARIABLE_277192 Int)) (> BOUND_VARIABLE_277191 BOUND_VARIABLE_277192)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277198 Int) (BOUND_VARIABLE_277199 Int)) (> BOUND_VARIABLE_277198 BOUND_VARIABLE_277199)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277198 Int) (BOUND_VARIABLE_277199 Int)) (> BOUND_VARIABLE_277198 BOUND_VARIABLE_277199)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277191 Int) (BOUND_VARIABLE_277192 Int)) (> BOUND_VARIABLE_277191 BOUND_VARIABLE_277192)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277198 Int) (BOUND_VARIABLE_277199 Int)) (> BOUND_VARIABLE_277198 BOUND_VARIABLE_277199)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277191 Int) (BOUND_VARIABLE_277192 Int)) (> BOUND_VARIABLE_277191 BOUND_VARIABLE_277192)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277191 Int) (BOUND_VARIABLE_277192 Int)) (> BOUND_VARIABLE_277191 BOUND_VARIABLE_277192)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277198 Int) (BOUND_VARIABLE_277199 Int)) (> BOUND_VARIABLE_277198 BOUND_VARIABLE_277199)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277198 Int) (BOUND_VARIABLE_277199 Int)) (> BOUND_VARIABLE_277198 BOUND_VARIABLE_277199)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277191 Int) (BOUND_VARIABLE_277192 Int)) (> BOUND_VARIABLE_277191 BOUND_VARIABLE_277192)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277198 Int) (BOUND_VARIABLE_277199 Int)) (> BOUND_VARIABLE_277198 BOUND_VARIABLE_277199)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277165 Int) (BOUND_VARIABLE_277166 Int)) (> BOUND_VARIABLE_277165 BOUND_VARIABLE_277166)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277165 Int) (BOUND_VARIABLE_277166 Int)) (> BOUND_VARIABLE_277165 BOUND_VARIABLE_277166)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277171 Int) (BOUND_VARIABLE_277172 Int)) (<= BOUND_VARIABLE_277171 BOUND_VARIABLE_277172)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277171 Int) (BOUND_VARIABLE_277172 Int)) (<= BOUND_VARIABLE_277171 BOUND_VARIABLE_277172)) ((_ tuple.select 0) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277165 Int) (BOUND_VARIABLE_277166 Int)) (> BOUND_VARIABLE_277165 BOUND_VARIABLE_277166)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277171 Int) (BOUND_VARIABLE_277172 Int)) (<= BOUND_VARIABLE_277171 BOUND_VARIABLE_277172)) ((_ tuple.select 0) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277165 Int) (BOUND_VARIABLE_277166 Int)) (> BOUND_VARIABLE_277165 BOUND_VARIABLE_277166)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277165 Int) (BOUND_VARIABLE_277166 Int)) (> BOUND_VARIABLE_277165 BOUND_VARIABLE_277166)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277171 Int) (BOUND_VARIABLE_277172 Int)) (<= BOUND_VARIABLE_277171 BOUND_VARIABLE_277172)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277171 Int) (BOUND_VARIABLE_277172 Int)) (<= BOUND_VARIABLE_277171 BOUND_VARIABLE_277172)) ((_ tuple.select 0) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277165 Int) (BOUND_VARIABLE_277166 Int)) (> BOUND_VARIABLE_277165 BOUND_VARIABLE_277166)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277171 Int) (BOUND_VARIABLE_277172 Int)) (<= BOUND_VARIABLE_277171 BOUND_VARIABLE_277172)) ((_ tuple.select 0) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277191 Int) (BOUND_VARIABLE_277192 Int)) (> BOUND_VARIABLE_277191 BOUND_VARIABLE_277192)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277191 Int) (BOUND_VARIABLE_277192 Int)) (> BOUND_VARIABLE_277191 BOUND_VARIABLE_277192)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277198 Int) (BOUND_VARIABLE_277199 Int)) (> BOUND_VARIABLE_277198 BOUND_VARIABLE_277199)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277198 Int) (BOUND_VARIABLE_277199 Int)) (> BOUND_VARIABLE_277198 BOUND_VARIABLE_277199)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277191 Int) (BOUND_VARIABLE_277192 Int)) (> BOUND_VARIABLE_277191 BOUND_VARIABLE_277192)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277198 Int) (BOUND_VARIABLE_277199 Int)) (> BOUND_VARIABLE_277198 BOUND_VARIABLE_277199)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277191 Int) (BOUND_VARIABLE_277192 Int)) (> BOUND_VARIABLE_277191 BOUND_VARIABLE_277192)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277191 Int) (BOUND_VARIABLE_277192 Int)) (> BOUND_VARIABLE_277191 BOUND_VARIABLE_277192)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277198 Int) (BOUND_VARIABLE_277199 Int)) (> BOUND_VARIABLE_277198 BOUND_VARIABLE_277199)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277198 Int) (BOUND_VARIABLE_277199 Int)) (> BOUND_VARIABLE_277198 BOUND_VARIABLE_277199)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277191 Int) (BOUND_VARIABLE_277192 Int)) (> BOUND_VARIABLE_277191 BOUND_VARIABLE_277192)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277198 Int) (BOUND_VARIABLE_277199 Int)) (> BOUND_VARIABLE_277198 BOUND_VARIABLE_277199)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277240 Int) (BOUND_VARIABLE_277241 Int)) (> BOUND_VARIABLE_277240 BOUND_VARIABLE_277241)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277240 Int) (BOUND_VARIABLE_277241 Int)) (> BOUND_VARIABLE_277240 BOUND_VARIABLE_277241)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277246 Int) (BOUND_VARIABLE_277247 Int)) (<= BOUND_VARIABLE_277246 BOUND_VARIABLE_277247)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277246 Int) (BOUND_VARIABLE_277247 Int)) (<= BOUND_VARIABLE_277246 BOUND_VARIABLE_277247)) ((_ tuple.select 0) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277240 Int) (BOUND_VARIABLE_277241 Int)) (> BOUND_VARIABLE_277240 BOUND_VARIABLE_277241)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277246 Int) (BOUND_VARIABLE_277247 Int)) (<= BOUND_VARIABLE_277246 BOUND_VARIABLE_277247)) ((_ tuple.select 0) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277240 Int) (BOUND_VARIABLE_277241 Int)) (> BOUND_VARIABLE_277240 BOUND_VARIABLE_277241)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277240 Int) (BOUND_VARIABLE_277241 Int)) (> BOUND_VARIABLE_277240 BOUND_VARIABLE_277241)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277246 Int) (BOUND_VARIABLE_277247 Int)) (<= BOUND_VARIABLE_277246 BOUND_VARIABLE_277247)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277246 Int) (BOUND_VARIABLE_277247 Int)) (<= BOUND_VARIABLE_277246 BOUND_VARIABLE_277247)) ((_ tuple.select 0) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277240 Int) (BOUND_VARIABLE_277241 Int)) (> BOUND_VARIABLE_277240 BOUND_VARIABLE_277241)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277246 Int) (BOUND_VARIABLE_277247 Int)) (<= BOUND_VARIABLE_277246 BOUND_VARIABLE_277247)) ((_ tuple.select 0) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277266 Int) (BOUND_VARIABLE_277267 Int)) (> BOUND_VARIABLE_277266 BOUND_VARIABLE_277267)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277266 Int) (BOUND_VARIABLE_277267 Int)) (> BOUND_VARIABLE_277266 BOUND_VARIABLE_277267)) ((_ tuple.select 0) t) (nullable.some 20))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277240 Int) (BOUND_VARIABLE_277241 Int)) (> BOUND_VARIABLE_277240 BOUND_VARIABLE_277241)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277240 Int) (BOUND_VARIABLE_277241 Int)) (> BOUND_VARIABLE_277240 BOUND_VARIABLE_277241)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277246 Int) (BOUND_VARIABLE_277247 Int)) (<= BOUND_VARIABLE_277246 BOUND_VARIABLE_277247)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277246 Int) (BOUND_VARIABLE_277247 Int)) (<= BOUND_VARIABLE_277246 BOUND_VARIABLE_277247)) ((_ tuple.select 0) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277240 Int) (BOUND_VARIABLE_277241 Int)) (> BOUND_VARIABLE_277240 BOUND_VARIABLE_277241)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277246 Int) (BOUND_VARIABLE_277247 Int)) (<= BOUND_VARIABLE_277246 BOUND_VARIABLE_277247)) ((_ tuple.select 0) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277240 Int) (BOUND_VARIABLE_277241 Int)) (> BOUND_VARIABLE_277240 BOUND_VARIABLE_277241)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277240 Int) (BOUND_VARIABLE_277241 Int)) (> BOUND_VARIABLE_277240 BOUND_VARIABLE_277241)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277246 Int) (BOUND_VARIABLE_277247 Int)) (<= BOUND_VARIABLE_277246 BOUND_VARIABLE_277247)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277246 Int) (BOUND_VARIABLE_277247 Int)) (<= BOUND_VARIABLE_277246 BOUND_VARIABLE_277247)) ((_ tuple.select 0) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277240 Int) (BOUND_VARIABLE_277241 Int)) (> BOUND_VARIABLE_277240 BOUND_VARIABLE_277241)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277246 Int) (BOUND_VARIABLE_277247 Int)) (<= BOUND_VARIABLE_277246 BOUND_VARIABLE_277247)) ((_ tuple.select 0) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277266 Int) (BOUND_VARIABLE_277267 Int)) (> BOUND_VARIABLE_277266 BOUND_VARIABLE_277267)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277266 Int) (BOUND_VARIABLE_277267 Int)) (> BOUND_VARIABLE_277266 BOUND_VARIABLE_277267)) ((_ tuple.select 0) t) (nullable.some 20))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277294 Int) (BOUND_VARIABLE_277295 Int)) (> BOUND_VARIABLE_277294 BOUND_VARIABLE_277295)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277294 Int) (BOUND_VARIABLE_277295 Int)) (> BOUND_VARIABLE_277294 BOUND_VARIABLE_277295)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277300 Int) (BOUND_VARIABLE_277301 Int)) (<= BOUND_VARIABLE_277300 BOUND_VARIABLE_277301)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277300 Int) (BOUND_VARIABLE_277301 Int)) (<= BOUND_VARIABLE_277300 BOUND_VARIABLE_277301)) ((_ tuple.select 0) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277294 Int) (BOUND_VARIABLE_277295 Int)) (> BOUND_VARIABLE_277294 BOUND_VARIABLE_277295)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277300 Int) (BOUND_VARIABLE_277301 Int)) (<= BOUND_VARIABLE_277300 BOUND_VARIABLE_277301)) ((_ tuple.select 0) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277294 Int) (BOUND_VARIABLE_277295 Int)) (> BOUND_VARIABLE_277294 BOUND_VARIABLE_277295)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277294 Int) (BOUND_VARIABLE_277295 Int)) (> BOUND_VARIABLE_277294 BOUND_VARIABLE_277295)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277300 Int) (BOUND_VARIABLE_277301 Int)) (<= BOUND_VARIABLE_277300 BOUND_VARIABLE_277301)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277300 Int) (BOUND_VARIABLE_277301 Int)) (<= BOUND_VARIABLE_277300 BOUND_VARIABLE_277301)) ((_ tuple.select 0) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277294 Int) (BOUND_VARIABLE_277295 Int)) (> BOUND_VARIABLE_277294 BOUND_VARIABLE_277295)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277300 Int) (BOUND_VARIABLE_277301 Int)) (<= BOUND_VARIABLE_277300 BOUND_VARIABLE_277301)) ((_ tuple.select 0) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277320 Int) (BOUND_VARIABLE_277321 Int)) (> BOUND_VARIABLE_277320 BOUND_VARIABLE_277321)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277320 Int) (BOUND_VARIABLE_277321 Int)) (> BOUND_VARIABLE_277320 BOUND_VARIABLE_277321)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277327 Int) (BOUND_VARIABLE_277328 Int)) (> BOUND_VARIABLE_277327 BOUND_VARIABLE_277328)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277327 Int) (BOUND_VARIABLE_277328 Int)) (> BOUND_VARIABLE_277327 BOUND_VARIABLE_277328)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277320 Int) (BOUND_VARIABLE_277321 Int)) (> BOUND_VARIABLE_277320 BOUND_VARIABLE_277321)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277327 Int) (BOUND_VARIABLE_277328 Int)) (> BOUND_VARIABLE_277327 BOUND_VARIABLE_277328)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277320 Int) (BOUND_VARIABLE_277321 Int)) (> BOUND_VARIABLE_277320 BOUND_VARIABLE_277321)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277320 Int) (BOUND_VARIABLE_277321 Int)) (> BOUND_VARIABLE_277320 BOUND_VARIABLE_277321)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277327 Int) (BOUND_VARIABLE_277328 Int)) (> BOUND_VARIABLE_277327 BOUND_VARIABLE_277328)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277327 Int) (BOUND_VARIABLE_277328 Int)) (> BOUND_VARIABLE_277327 BOUND_VARIABLE_277328)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277320 Int) (BOUND_VARIABLE_277321 Int)) (> BOUND_VARIABLE_277320 BOUND_VARIABLE_277321)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277327 Int) (BOUND_VARIABLE_277328 Int)) (> BOUND_VARIABLE_277327 BOUND_VARIABLE_277328)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277294 Int) (BOUND_VARIABLE_277295 Int)) (> BOUND_VARIABLE_277294 BOUND_VARIABLE_277295)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277294 Int) (BOUND_VARIABLE_277295 Int)) (> BOUND_VARIABLE_277294 BOUND_VARIABLE_277295)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277300 Int) (BOUND_VARIABLE_277301 Int)) (<= BOUND_VARIABLE_277300 BOUND_VARIABLE_277301)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277300 Int) (BOUND_VARIABLE_277301 Int)) (<= BOUND_VARIABLE_277300 BOUND_VARIABLE_277301)) ((_ tuple.select 0) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277294 Int) (BOUND_VARIABLE_277295 Int)) (> BOUND_VARIABLE_277294 BOUND_VARIABLE_277295)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277300 Int) (BOUND_VARIABLE_277301 Int)) (<= BOUND_VARIABLE_277300 BOUND_VARIABLE_277301)) ((_ tuple.select 0) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277294 Int) (BOUND_VARIABLE_277295 Int)) (> BOUND_VARIABLE_277294 BOUND_VARIABLE_277295)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277294 Int) (BOUND_VARIABLE_277295 Int)) (> BOUND_VARIABLE_277294 BOUND_VARIABLE_277295)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277300 Int) (BOUND_VARIABLE_277301 Int)) (<= BOUND_VARIABLE_277300 BOUND_VARIABLE_277301)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277300 Int) (BOUND_VARIABLE_277301 Int)) (<= BOUND_VARIABLE_277300 BOUND_VARIABLE_277301)) ((_ tuple.select 0) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277294 Int) (BOUND_VARIABLE_277295 Int)) (> BOUND_VARIABLE_277294 BOUND_VARIABLE_277295)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277300 Int) (BOUND_VARIABLE_277301 Int)) (<= BOUND_VARIABLE_277300 BOUND_VARIABLE_277301)) ((_ tuple.select 0) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277320 Int) (BOUND_VARIABLE_277321 Int)) (> BOUND_VARIABLE_277320 BOUND_VARIABLE_277321)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277320 Int) (BOUND_VARIABLE_277321 Int)) (> BOUND_VARIABLE_277320 BOUND_VARIABLE_277321)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277327 Int) (BOUND_VARIABLE_277328 Int)) (> BOUND_VARIABLE_277327 BOUND_VARIABLE_277328)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277327 Int) (BOUND_VARIABLE_277328 Int)) (> BOUND_VARIABLE_277327 BOUND_VARIABLE_277328)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277320 Int) (BOUND_VARIABLE_277321 Int)) (> BOUND_VARIABLE_277320 BOUND_VARIABLE_277321)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277327 Int) (BOUND_VARIABLE_277328 Int)) (> BOUND_VARIABLE_277327 BOUND_VARIABLE_277328)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277320 Int) (BOUND_VARIABLE_277321 Int)) (> BOUND_VARIABLE_277320 BOUND_VARIABLE_277321)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277320 Int) (BOUND_VARIABLE_277321 Int)) (> BOUND_VARIABLE_277320 BOUND_VARIABLE_277321)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_277327 Int) (BOUND_VARIABLE_277328 Int)) (> BOUND_VARIABLE_277327 BOUND_VARIABLE_277328)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_277327 Int) (BOUND_VARIABLE_277328 Int)) (> BOUND_VARIABLE_277327 BOUND_VARIABLE_277328)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277320 Int) (BOUND_VARIABLE_277321 Int)) (> BOUND_VARIABLE_277320 BOUND_VARIABLE_277321)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_277327 Int) (BOUND_VARIABLE_277328 Int)) (> BOUND_VARIABLE_277327 BOUND_VARIABLE_277328)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p0 (rel.product EMP DEPT)))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p2 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)) DEPT)))))
(check-sat)
;answer: unsat
; duration: 846 ms.
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

(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p2 (-> (Tuple (Nullable Int) (Nullable String)) Bool))
(declare-const p3 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const leftJoin4 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const leftJoin1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284377 Int) (BOUND_VARIABLE_284378 Int)) (< BOUND_VARIABLE_284377 BOUND_VARIABLE_284378)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284377 Int) (BOUND_VARIABLE_284378 Int)) (< BOUND_VARIABLE_284377 BOUND_VARIABLE_284378)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284384 Int) (BOUND_VARIABLE_284385 Int)) (< BOUND_VARIABLE_284384 BOUND_VARIABLE_284385)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284384 Int) (BOUND_VARIABLE_284385 Int)) (< BOUND_VARIABLE_284384 BOUND_VARIABLE_284385)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284377 Int) (BOUND_VARIABLE_284378 Int)) (< BOUND_VARIABLE_284377 BOUND_VARIABLE_284378)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284384 Int) (BOUND_VARIABLE_284385 Int)) (< BOUND_VARIABLE_284384 BOUND_VARIABLE_284385)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284377 Int) (BOUND_VARIABLE_284378 Int)) (< BOUND_VARIABLE_284377 BOUND_VARIABLE_284378)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284377 Int) (BOUND_VARIABLE_284378 Int)) (< BOUND_VARIABLE_284377 BOUND_VARIABLE_284378)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284384 Int) (BOUND_VARIABLE_284385 Int)) (< BOUND_VARIABLE_284384 BOUND_VARIABLE_284385)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284384 Int) (BOUND_VARIABLE_284385 Int)) (< BOUND_VARIABLE_284384 BOUND_VARIABLE_284385)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284377 Int) (BOUND_VARIABLE_284378 Int)) (< BOUND_VARIABLE_284377 BOUND_VARIABLE_284378)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284384 Int) (BOUND_VARIABLE_284385 Int)) (< BOUND_VARIABLE_284384 BOUND_VARIABLE_284385)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284404 Int) (BOUND_VARIABLE_284405 Int)) (> BOUND_VARIABLE_284404 BOUND_VARIABLE_284405)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284404 Int) (BOUND_VARIABLE_284405 Int)) (> BOUND_VARIABLE_284404 BOUND_VARIABLE_284405)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284410 Int) (BOUND_VARIABLE_284411 Int)) (> BOUND_VARIABLE_284410 BOUND_VARIABLE_284411)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284410 Int) (BOUND_VARIABLE_284411 Int)) (> BOUND_VARIABLE_284410 BOUND_VARIABLE_284411)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284404 Int) (BOUND_VARIABLE_284405 Int)) (> BOUND_VARIABLE_284404 BOUND_VARIABLE_284405)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284410 Int) (BOUND_VARIABLE_284411 Int)) (> BOUND_VARIABLE_284410 BOUND_VARIABLE_284411)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284404 Int) (BOUND_VARIABLE_284405 Int)) (> BOUND_VARIABLE_284404 BOUND_VARIABLE_284405)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284404 Int) (BOUND_VARIABLE_284405 Int)) (> BOUND_VARIABLE_284404 BOUND_VARIABLE_284405)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284410 Int) (BOUND_VARIABLE_284411 Int)) (> BOUND_VARIABLE_284410 BOUND_VARIABLE_284411)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284410 Int) (BOUND_VARIABLE_284411 Int)) (> BOUND_VARIABLE_284410 BOUND_VARIABLE_284411)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284404 Int) (BOUND_VARIABLE_284405 Int)) (> BOUND_VARIABLE_284404 BOUND_VARIABLE_284405)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284410 Int) (BOUND_VARIABLE_284411 Int)) (> BOUND_VARIABLE_284410 BOUND_VARIABLE_284411)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284377 Int) (BOUND_VARIABLE_284378 Int)) (< BOUND_VARIABLE_284377 BOUND_VARIABLE_284378)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284377 Int) (BOUND_VARIABLE_284378 Int)) (< BOUND_VARIABLE_284377 BOUND_VARIABLE_284378)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284384 Int) (BOUND_VARIABLE_284385 Int)) (< BOUND_VARIABLE_284384 BOUND_VARIABLE_284385)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284384 Int) (BOUND_VARIABLE_284385 Int)) (< BOUND_VARIABLE_284384 BOUND_VARIABLE_284385)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284377 Int) (BOUND_VARIABLE_284378 Int)) (< BOUND_VARIABLE_284377 BOUND_VARIABLE_284378)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284384 Int) (BOUND_VARIABLE_284385 Int)) (< BOUND_VARIABLE_284384 BOUND_VARIABLE_284385)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284377 Int) (BOUND_VARIABLE_284378 Int)) (< BOUND_VARIABLE_284377 BOUND_VARIABLE_284378)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284377 Int) (BOUND_VARIABLE_284378 Int)) (< BOUND_VARIABLE_284377 BOUND_VARIABLE_284378)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284384 Int) (BOUND_VARIABLE_284385 Int)) (< BOUND_VARIABLE_284384 BOUND_VARIABLE_284385)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284384 Int) (BOUND_VARIABLE_284385 Int)) (< BOUND_VARIABLE_284384 BOUND_VARIABLE_284385)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284377 Int) (BOUND_VARIABLE_284378 Int)) (< BOUND_VARIABLE_284377 BOUND_VARIABLE_284378)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284384 Int) (BOUND_VARIABLE_284385 Int)) (< BOUND_VARIABLE_284384 BOUND_VARIABLE_284385)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284404 Int) (BOUND_VARIABLE_284405 Int)) (> BOUND_VARIABLE_284404 BOUND_VARIABLE_284405)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284404 Int) (BOUND_VARIABLE_284405 Int)) (> BOUND_VARIABLE_284404 BOUND_VARIABLE_284405)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284410 Int) (BOUND_VARIABLE_284411 Int)) (> BOUND_VARIABLE_284410 BOUND_VARIABLE_284411)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284410 Int) (BOUND_VARIABLE_284411 Int)) (> BOUND_VARIABLE_284410 BOUND_VARIABLE_284411)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284404 Int) (BOUND_VARIABLE_284405 Int)) (> BOUND_VARIABLE_284404 BOUND_VARIABLE_284405)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284410 Int) (BOUND_VARIABLE_284411 Int)) (> BOUND_VARIABLE_284410 BOUND_VARIABLE_284411)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284404 Int) (BOUND_VARIABLE_284405 Int)) (> BOUND_VARIABLE_284404 BOUND_VARIABLE_284405)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284404 Int) (BOUND_VARIABLE_284405 Int)) (> BOUND_VARIABLE_284404 BOUND_VARIABLE_284405)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284410 Int) (BOUND_VARIABLE_284411 Int)) (> BOUND_VARIABLE_284410 BOUND_VARIABLE_284411)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284410 Int) (BOUND_VARIABLE_284411 Int)) (> BOUND_VARIABLE_284410 BOUND_VARIABLE_284411)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284404 Int) (BOUND_VARIABLE_284405 Int)) (> BOUND_VARIABLE_284404 BOUND_VARIABLE_284405)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284410 Int) (BOUND_VARIABLE_284411 Int)) (> BOUND_VARIABLE_284410 BOUND_VARIABLE_284411)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= leftJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284485 Int) (BOUND_VARIABLE_284486 Int)) (< BOUND_VARIABLE_284485 BOUND_VARIABLE_284486)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284485 Int) (BOUND_VARIABLE_284486 Int)) (< BOUND_VARIABLE_284485 BOUND_VARIABLE_284486)) ((_ tuple.select 0) t) (nullable.some 10)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284491 Int) (BOUND_VARIABLE_284492 Int)) (> BOUND_VARIABLE_284491 BOUND_VARIABLE_284492)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284491 Int) (BOUND_VARIABLE_284492 Int)) (> BOUND_VARIABLE_284491 BOUND_VARIABLE_284492)) ((_ tuple.select 0) t) (nullable.some 20))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284485 Int) (BOUND_VARIABLE_284486 Int)) (< BOUND_VARIABLE_284485 BOUND_VARIABLE_284486)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284485 Int) (BOUND_VARIABLE_284486 Int)) (< BOUND_VARIABLE_284485 BOUND_VARIABLE_284486)) ((_ tuple.select 0) t) (nullable.some 10)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284491 Int) (BOUND_VARIABLE_284492 Int)) (> BOUND_VARIABLE_284491 BOUND_VARIABLE_284492)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284491 Int) (BOUND_VARIABLE_284492 Int)) (> BOUND_VARIABLE_284491 BOUND_VARIABLE_284492)) ((_ tuple.select 0) t) (nullable.some 20))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284519 Int) (BOUND_VARIABLE_284520 Int)) (< BOUND_VARIABLE_284519 BOUND_VARIABLE_284520)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284519 Int) (BOUND_VARIABLE_284520 Int)) (< BOUND_VARIABLE_284519 BOUND_VARIABLE_284520)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284526 Int) (BOUND_VARIABLE_284527 Int)) (< BOUND_VARIABLE_284526 BOUND_VARIABLE_284527)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284526 Int) (BOUND_VARIABLE_284527 Int)) (< BOUND_VARIABLE_284526 BOUND_VARIABLE_284527)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284519 Int) (BOUND_VARIABLE_284520 Int)) (< BOUND_VARIABLE_284519 BOUND_VARIABLE_284520)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284526 Int) (BOUND_VARIABLE_284527 Int)) (< BOUND_VARIABLE_284526 BOUND_VARIABLE_284527)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284519 Int) (BOUND_VARIABLE_284520 Int)) (< BOUND_VARIABLE_284519 BOUND_VARIABLE_284520)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284519 Int) (BOUND_VARIABLE_284520 Int)) (< BOUND_VARIABLE_284519 BOUND_VARIABLE_284520)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284526 Int) (BOUND_VARIABLE_284527 Int)) (< BOUND_VARIABLE_284526 BOUND_VARIABLE_284527)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284526 Int) (BOUND_VARIABLE_284527 Int)) (< BOUND_VARIABLE_284526 BOUND_VARIABLE_284527)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284519 Int) (BOUND_VARIABLE_284520 Int)) (< BOUND_VARIABLE_284519 BOUND_VARIABLE_284520)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284526 Int) (BOUND_VARIABLE_284527 Int)) (< BOUND_VARIABLE_284526 BOUND_VARIABLE_284527)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284546 Int) (BOUND_VARIABLE_284547 Int)) (> BOUND_VARIABLE_284546 BOUND_VARIABLE_284547)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284546 Int) (BOUND_VARIABLE_284547 Int)) (> BOUND_VARIABLE_284546 BOUND_VARIABLE_284547)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284552 Int) (BOUND_VARIABLE_284553 Int)) (> BOUND_VARIABLE_284552 BOUND_VARIABLE_284553)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284552 Int) (BOUND_VARIABLE_284553 Int)) (> BOUND_VARIABLE_284552 BOUND_VARIABLE_284553)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284546 Int) (BOUND_VARIABLE_284547 Int)) (> BOUND_VARIABLE_284546 BOUND_VARIABLE_284547)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284552 Int) (BOUND_VARIABLE_284553 Int)) (> BOUND_VARIABLE_284552 BOUND_VARIABLE_284553)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284546 Int) (BOUND_VARIABLE_284547 Int)) (> BOUND_VARIABLE_284546 BOUND_VARIABLE_284547)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284546 Int) (BOUND_VARIABLE_284547 Int)) (> BOUND_VARIABLE_284546 BOUND_VARIABLE_284547)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284552 Int) (BOUND_VARIABLE_284553 Int)) (> BOUND_VARIABLE_284552 BOUND_VARIABLE_284553)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284552 Int) (BOUND_VARIABLE_284553 Int)) (> BOUND_VARIABLE_284552 BOUND_VARIABLE_284553)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284546 Int) (BOUND_VARIABLE_284547 Int)) (> BOUND_VARIABLE_284546 BOUND_VARIABLE_284547)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284552 Int) (BOUND_VARIABLE_284553 Int)) (> BOUND_VARIABLE_284552 BOUND_VARIABLE_284553)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284519 Int) (BOUND_VARIABLE_284520 Int)) (< BOUND_VARIABLE_284519 BOUND_VARIABLE_284520)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284519 Int) (BOUND_VARIABLE_284520 Int)) (< BOUND_VARIABLE_284519 BOUND_VARIABLE_284520)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284526 Int) (BOUND_VARIABLE_284527 Int)) (< BOUND_VARIABLE_284526 BOUND_VARIABLE_284527)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284526 Int) (BOUND_VARIABLE_284527 Int)) (< BOUND_VARIABLE_284526 BOUND_VARIABLE_284527)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284519 Int) (BOUND_VARIABLE_284520 Int)) (< BOUND_VARIABLE_284519 BOUND_VARIABLE_284520)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284526 Int) (BOUND_VARIABLE_284527 Int)) (< BOUND_VARIABLE_284526 BOUND_VARIABLE_284527)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284519 Int) (BOUND_VARIABLE_284520 Int)) (< BOUND_VARIABLE_284519 BOUND_VARIABLE_284520)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284519 Int) (BOUND_VARIABLE_284520 Int)) (< BOUND_VARIABLE_284519 BOUND_VARIABLE_284520)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284526 Int) (BOUND_VARIABLE_284527 Int)) (< BOUND_VARIABLE_284526 BOUND_VARIABLE_284527)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284526 Int) (BOUND_VARIABLE_284527 Int)) (< BOUND_VARIABLE_284526 BOUND_VARIABLE_284527)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284519 Int) (BOUND_VARIABLE_284520 Int)) (< BOUND_VARIABLE_284519 BOUND_VARIABLE_284520)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284526 Int) (BOUND_VARIABLE_284527 Int)) (< BOUND_VARIABLE_284526 BOUND_VARIABLE_284527)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284546 Int) (BOUND_VARIABLE_284547 Int)) (> BOUND_VARIABLE_284546 BOUND_VARIABLE_284547)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284546 Int) (BOUND_VARIABLE_284547 Int)) (> BOUND_VARIABLE_284546 BOUND_VARIABLE_284547)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284552 Int) (BOUND_VARIABLE_284553 Int)) (> BOUND_VARIABLE_284552 BOUND_VARIABLE_284553)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284552 Int) (BOUND_VARIABLE_284553 Int)) (> BOUND_VARIABLE_284552 BOUND_VARIABLE_284553)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284546 Int) (BOUND_VARIABLE_284547 Int)) (> BOUND_VARIABLE_284546 BOUND_VARIABLE_284547)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284552 Int) (BOUND_VARIABLE_284553 Int)) (> BOUND_VARIABLE_284552 BOUND_VARIABLE_284553)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284546 Int) (BOUND_VARIABLE_284547 Int)) (> BOUND_VARIABLE_284546 BOUND_VARIABLE_284547)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284546 Int) (BOUND_VARIABLE_284547 Int)) (> BOUND_VARIABLE_284546 BOUND_VARIABLE_284547)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_284552 Int) (BOUND_VARIABLE_284553 Int)) (> BOUND_VARIABLE_284552 BOUND_VARIABLE_284553)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_284552 Int) (BOUND_VARIABLE_284553 Int)) (> BOUND_VARIABLE_284552 BOUND_VARIABLE_284553)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284546 Int) (BOUND_VARIABLE_284547 Int)) (> BOUND_VARIABLE_284546 BOUND_VARIABLE_284547)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_284552 Int) (BOUND_VARIABLE_284553 Int)) (> BOUND_VARIABLE_284552 BOUND_VARIABLE_284553)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= leftJoin4 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map leftJoin1 (set.minus EMP ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 (rel.product EMP DEPT))))) (set.filter p0 (rel.product EMP DEPT))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map leftJoin4 (set.minus EMP ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p3 (rel.product EMP ((_ rel.project 0 1) (set.filter p2 DEPT))))))) (set.filter p3 (rel.product EMP ((_ rel.project 0 1) (set.filter p2 DEPT))))))))
(check-sat)
;answer: unsat
; duration: 5812 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310485 Int) (BOUND_VARIABLE_310486 Int)) (< BOUND_VARIABLE_310485 BOUND_VARIABLE_310486)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310485 Int) (BOUND_VARIABLE_310486 Int)) (< BOUND_VARIABLE_310485 BOUND_VARIABLE_310486)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310492 Int) (BOUND_VARIABLE_310493 Int)) (< BOUND_VARIABLE_310492 BOUND_VARIABLE_310493)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310492 Int) (BOUND_VARIABLE_310493 Int)) (< BOUND_VARIABLE_310492 BOUND_VARIABLE_310493)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310485 Int) (BOUND_VARIABLE_310486 Int)) (< BOUND_VARIABLE_310485 BOUND_VARIABLE_310486)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310492 Int) (BOUND_VARIABLE_310493 Int)) (< BOUND_VARIABLE_310492 BOUND_VARIABLE_310493)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310485 Int) (BOUND_VARIABLE_310486 Int)) (< BOUND_VARIABLE_310485 BOUND_VARIABLE_310486)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310485 Int) (BOUND_VARIABLE_310486 Int)) (< BOUND_VARIABLE_310485 BOUND_VARIABLE_310486)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310492 Int) (BOUND_VARIABLE_310493 Int)) (< BOUND_VARIABLE_310492 BOUND_VARIABLE_310493)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310492 Int) (BOUND_VARIABLE_310493 Int)) (< BOUND_VARIABLE_310492 BOUND_VARIABLE_310493)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310485 Int) (BOUND_VARIABLE_310486 Int)) (< BOUND_VARIABLE_310485 BOUND_VARIABLE_310486)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310492 Int) (BOUND_VARIABLE_310493 Int)) (< BOUND_VARIABLE_310492 BOUND_VARIABLE_310493)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310512 Int) (BOUND_VARIABLE_310513 Int)) (> BOUND_VARIABLE_310512 BOUND_VARIABLE_310513)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310512 Int) (BOUND_VARIABLE_310513 Int)) (> BOUND_VARIABLE_310512 BOUND_VARIABLE_310513)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310518 Int) (BOUND_VARIABLE_310519 Int)) (> BOUND_VARIABLE_310518 BOUND_VARIABLE_310519)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310518 Int) (BOUND_VARIABLE_310519 Int)) (> BOUND_VARIABLE_310518 BOUND_VARIABLE_310519)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310512 Int) (BOUND_VARIABLE_310513 Int)) (> BOUND_VARIABLE_310512 BOUND_VARIABLE_310513)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310518 Int) (BOUND_VARIABLE_310519 Int)) (> BOUND_VARIABLE_310518 BOUND_VARIABLE_310519)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310512 Int) (BOUND_VARIABLE_310513 Int)) (> BOUND_VARIABLE_310512 BOUND_VARIABLE_310513)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310512 Int) (BOUND_VARIABLE_310513 Int)) (> BOUND_VARIABLE_310512 BOUND_VARIABLE_310513)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310518 Int) (BOUND_VARIABLE_310519 Int)) (> BOUND_VARIABLE_310518 BOUND_VARIABLE_310519)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310518 Int) (BOUND_VARIABLE_310519 Int)) (> BOUND_VARIABLE_310518 BOUND_VARIABLE_310519)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310512 Int) (BOUND_VARIABLE_310513 Int)) (> BOUND_VARIABLE_310512 BOUND_VARIABLE_310513)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310518 Int) (BOUND_VARIABLE_310519 Int)) (> BOUND_VARIABLE_310518 BOUND_VARIABLE_310519)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310485 Int) (BOUND_VARIABLE_310486 Int)) (< BOUND_VARIABLE_310485 BOUND_VARIABLE_310486)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310485 Int) (BOUND_VARIABLE_310486 Int)) (< BOUND_VARIABLE_310485 BOUND_VARIABLE_310486)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310492 Int) (BOUND_VARIABLE_310493 Int)) (< BOUND_VARIABLE_310492 BOUND_VARIABLE_310493)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310492 Int) (BOUND_VARIABLE_310493 Int)) (< BOUND_VARIABLE_310492 BOUND_VARIABLE_310493)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310485 Int) (BOUND_VARIABLE_310486 Int)) (< BOUND_VARIABLE_310485 BOUND_VARIABLE_310486)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310492 Int) (BOUND_VARIABLE_310493 Int)) (< BOUND_VARIABLE_310492 BOUND_VARIABLE_310493)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310485 Int) (BOUND_VARIABLE_310486 Int)) (< BOUND_VARIABLE_310485 BOUND_VARIABLE_310486)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310485 Int) (BOUND_VARIABLE_310486 Int)) (< BOUND_VARIABLE_310485 BOUND_VARIABLE_310486)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310492 Int) (BOUND_VARIABLE_310493 Int)) (< BOUND_VARIABLE_310492 BOUND_VARIABLE_310493)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310492 Int) (BOUND_VARIABLE_310493 Int)) (< BOUND_VARIABLE_310492 BOUND_VARIABLE_310493)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310485 Int) (BOUND_VARIABLE_310486 Int)) (< BOUND_VARIABLE_310485 BOUND_VARIABLE_310486)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310492 Int) (BOUND_VARIABLE_310493 Int)) (< BOUND_VARIABLE_310492 BOUND_VARIABLE_310493)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310512 Int) (BOUND_VARIABLE_310513 Int)) (> BOUND_VARIABLE_310512 BOUND_VARIABLE_310513)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310512 Int) (BOUND_VARIABLE_310513 Int)) (> BOUND_VARIABLE_310512 BOUND_VARIABLE_310513)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310518 Int) (BOUND_VARIABLE_310519 Int)) (> BOUND_VARIABLE_310518 BOUND_VARIABLE_310519)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310518 Int) (BOUND_VARIABLE_310519 Int)) (> BOUND_VARIABLE_310518 BOUND_VARIABLE_310519)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310512 Int) (BOUND_VARIABLE_310513 Int)) (> BOUND_VARIABLE_310512 BOUND_VARIABLE_310513)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310518 Int) (BOUND_VARIABLE_310519 Int)) (> BOUND_VARIABLE_310518 BOUND_VARIABLE_310519)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310512 Int) (BOUND_VARIABLE_310513 Int)) (> BOUND_VARIABLE_310512 BOUND_VARIABLE_310513)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310512 Int) (BOUND_VARIABLE_310513 Int)) (> BOUND_VARIABLE_310512 BOUND_VARIABLE_310513)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310518 Int) (BOUND_VARIABLE_310519 Int)) (> BOUND_VARIABLE_310518 BOUND_VARIABLE_310519)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310518 Int) (BOUND_VARIABLE_310519 Int)) (> BOUND_VARIABLE_310518 BOUND_VARIABLE_310519)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310512 Int) (BOUND_VARIABLE_310513 Int)) (> BOUND_VARIABLE_310512 BOUND_VARIABLE_310513)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310518 Int) (BOUND_VARIABLE_310519 Int)) (> BOUND_VARIABLE_310518 BOUND_VARIABLE_310519)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= rightJoin1 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310586 Int) (BOUND_VARIABLE_310587 Int)) (< BOUND_VARIABLE_310586 BOUND_VARIABLE_310587)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310586 Int) (BOUND_VARIABLE_310587 Int)) (< BOUND_VARIABLE_310586 BOUND_VARIABLE_310587)) ((_ tuple.select 0) t) (nullable.some 10)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310592 Int) (BOUND_VARIABLE_310593 Int)) (> BOUND_VARIABLE_310592 BOUND_VARIABLE_310593)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310592 Int) (BOUND_VARIABLE_310593 Int)) (> BOUND_VARIABLE_310592 BOUND_VARIABLE_310593)) ((_ tuple.select 0) t) (nullable.some 20))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310586 Int) (BOUND_VARIABLE_310587 Int)) (< BOUND_VARIABLE_310586 BOUND_VARIABLE_310587)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310586 Int) (BOUND_VARIABLE_310587 Int)) (< BOUND_VARIABLE_310586 BOUND_VARIABLE_310587)) ((_ tuple.select 0) t) (nullable.some 10)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310592 Int) (BOUND_VARIABLE_310593 Int)) (> BOUND_VARIABLE_310592 BOUND_VARIABLE_310593)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310592 Int) (BOUND_VARIABLE_310593 Int)) (> BOUND_VARIABLE_310592 BOUND_VARIABLE_310593)) ((_ tuple.select 0) t) (nullable.some 20))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p3 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310620 Int) (BOUND_VARIABLE_310621 Int)) (< BOUND_VARIABLE_310620 BOUND_VARIABLE_310621)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310620 Int) (BOUND_VARIABLE_310621 Int)) (< BOUND_VARIABLE_310620 BOUND_VARIABLE_310621)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310627 Int) (BOUND_VARIABLE_310628 Int)) (< BOUND_VARIABLE_310627 BOUND_VARIABLE_310628)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310627 Int) (BOUND_VARIABLE_310628 Int)) (< BOUND_VARIABLE_310627 BOUND_VARIABLE_310628)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310620 Int) (BOUND_VARIABLE_310621 Int)) (< BOUND_VARIABLE_310620 BOUND_VARIABLE_310621)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310627 Int) (BOUND_VARIABLE_310628 Int)) (< BOUND_VARIABLE_310627 BOUND_VARIABLE_310628)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310620 Int) (BOUND_VARIABLE_310621 Int)) (< BOUND_VARIABLE_310620 BOUND_VARIABLE_310621)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310620 Int) (BOUND_VARIABLE_310621 Int)) (< BOUND_VARIABLE_310620 BOUND_VARIABLE_310621)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310627 Int) (BOUND_VARIABLE_310628 Int)) (< BOUND_VARIABLE_310627 BOUND_VARIABLE_310628)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310627 Int) (BOUND_VARIABLE_310628 Int)) (< BOUND_VARIABLE_310627 BOUND_VARIABLE_310628)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310620 Int) (BOUND_VARIABLE_310621 Int)) (< BOUND_VARIABLE_310620 BOUND_VARIABLE_310621)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310627 Int) (BOUND_VARIABLE_310628 Int)) (< BOUND_VARIABLE_310627 BOUND_VARIABLE_310628)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310647 Int) (BOUND_VARIABLE_310648 Int)) (> BOUND_VARIABLE_310647 BOUND_VARIABLE_310648)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310647 Int) (BOUND_VARIABLE_310648 Int)) (> BOUND_VARIABLE_310647 BOUND_VARIABLE_310648)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310653 Int) (BOUND_VARIABLE_310654 Int)) (> BOUND_VARIABLE_310653 BOUND_VARIABLE_310654)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310653 Int) (BOUND_VARIABLE_310654 Int)) (> BOUND_VARIABLE_310653 BOUND_VARIABLE_310654)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310647 Int) (BOUND_VARIABLE_310648 Int)) (> BOUND_VARIABLE_310647 BOUND_VARIABLE_310648)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310653 Int) (BOUND_VARIABLE_310654 Int)) (> BOUND_VARIABLE_310653 BOUND_VARIABLE_310654)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310647 Int) (BOUND_VARIABLE_310648 Int)) (> BOUND_VARIABLE_310647 BOUND_VARIABLE_310648)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310647 Int) (BOUND_VARIABLE_310648 Int)) (> BOUND_VARIABLE_310647 BOUND_VARIABLE_310648)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310653 Int) (BOUND_VARIABLE_310654 Int)) (> BOUND_VARIABLE_310653 BOUND_VARIABLE_310654)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310653 Int) (BOUND_VARIABLE_310654 Int)) (> BOUND_VARIABLE_310653 BOUND_VARIABLE_310654)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310647 Int) (BOUND_VARIABLE_310648 Int)) (> BOUND_VARIABLE_310647 BOUND_VARIABLE_310648)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310653 Int) (BOUND_VARIABLE_310654 Int)) (> BOUND_VARIABLE_310653 BOUND_VARIABLE_310654)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310620 Int) (BOUND_VARIABLE_310621 Int)) (< BOUND_VARIABLE_310620 BOUND_VARIABLE_310621)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310620 Int) (BOUND_VARIABLE_310621 Int)) (< BOUND_VARIABLE_310620 BOUND_VARIABLE_310621)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310627 Int) (BOUND_VARIABLE_310628 Int)) (< BOUND_VARIABLE_310627 BOUND_VARIABLE_310628)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310627 Int) (BOUND_VARIABLE_310628 Int)) (< BOUND_VARIABLE_310627 BOUND_VARIABLE_310628)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310620 Int) (BOUND_VARIABLE_310621 Int)) (< BOUND_VARIABLE_310620 BOUND_VARIABLE_310621)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310627 Int) (BOUND_VARIABLE_310628 Int)) (< BOUND_VARIABLE_310627 BOUND_VARIABLE_310628)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310620 Int) (BOUND_VARIABLE_310621 Int)) (< BOUND_VARIABLE_310620 BOUND_VARIABLE_310621)) ((_ tuple.select 0) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310620 Int) (BOUND_VARIABLE_310621 Int)) (< BOUND_VARIABLE_310620 BOUND_VARIABLE_310621)) ((_ tuple.select 0) t) (nullable.some 10))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310627 Int) (BOUND_VARIABLE_310628 Int)) (< BOUND_VARIABLE_310627 BOUND_VARIABLE_310628)) ((_ tuple.select 9) t) (nullable.some 10))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310627 Int) (BOUND_VARIABLE_310628 Int)) (< BOUND_VARIABLE_310627 BOUND_VARIABLE_310628)) ((_ tuple.select 9) t) (nullable.some 10)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310620 Int) (BOUND_VARIABLE_310621 Int)) (< BOUND_VARIABLE_310620 BOUND_VARIABLE_310621)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310627 Int) (BOUND_VARIABLE_310628 Int)) (< BOUND_VARIABLE_310627 BOUND_VARIABLE_310628)) ((_ tuple.select 9) t) (nullable.some 10)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310647 Int) (BOUND_VARIABLE_310648 Int)) (> BOUND_VARIABLE_310647 BOUND_VARIABLE_310648)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310647 Int) (BOUND_VARIABLE_310648 Int)) (> BOUND_VARIABLE_310647 BOUND_VARIABLE_310648)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310653 Int) (BOUND_VARIABLE_310654 Int)) (> BOUND_VARIABLE_310653 BOUND_VARIABLE_310654)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310653 Int) (BOUND_VARIABLE_310654 Int)) (> BOUND_VARIABLE_310653 BOUND_VARIABLE_310654)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310647 Int) (BOUND_VARIABLE_310648 Int)) (> BOUND_VARIABLE_310647 BOUND_VARIABLE_310648)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310653 Int) (BOUND_VARIABLE_310654 Int)) (> BOUND_VARIABLE_310653 BOUND_VARIABLE_310654)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310647 Int) (BOUND_VARIABLE_310648 Int)) (> BOUND_VARIABLE_310647 BOUND_VARIABLE_310648)) ((_ tuple.select 0) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310647 Int) (BOUND_VARIABLE_310648 Int)) (> BOUND_VARIABLE_310647 BOUND_VARIABLE_310648)) ((_ tuple.select 0) t) (nullable.some 20))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_310653 Int) (BOUND_VARIABLE_310654 Int)) (> BOUND_VARIABLE_310653 BOUND_VARIABLE_310654)) ((_ tuple.select 9) t) (nullable.some 20))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_310653 Int) (BOUND_VARIABLE_310654 Int)) (> BOUND_VARIABLE_310653 BOUND_VARIABLE_310654)) ((_ tuple.select 9) t) (nullable.some 20)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310647 Int) (BOUND_VARIABLE_310648 Int)) (> BOUND_VARIABLE_310647 BOUND_VARIABLE_310648)) ((_ tuple.select 0) t) (nullable.some 20))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_310653 Int) (BOUND_VARIABLE_310654 Int)) (> BOUND_VARIABLE_310653 BOUND_VARIABLE_310654)) ((_ tuple.select 9) t) (nullable.some 20)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= rightJoin4 (lambda ((t (Tuple (Nullable Int) (Nullable String)))) (tuple (as nullable.null (Nullable Int)) (as nullable.null (Nullable String)) (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)) ((_ tuple.select 0) t) ((_ tuple.select 1) t)))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map rightJoin1 (set.minus DEPT ((_ rel.project 9 10) (set.filter p0 (rel.product EMP DEPT))))) (set.filter p0 (rel.product EMP DEPT))))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.union (set.map rightJoin4 (set.minus DEPT ((_ rel.project 9 10) (set.filter p3 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)) DEPT))))) (set.filter p3 (rel.product ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)) DEPT))))))
(check-sat)
;answer: unsat
; duration: 5638 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_336117 Int) (BOUND_VARIABLE_336118 Int)) (> BOUND_VARIABLE_336117 BOUND_VARIABLE_336118)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_336117 Int) (BOUND_VARIABLE_336118 Int)) (> BOUND_VARIABLE_336117 BOUND_VARIABLE_336118)) ((_ tuple.select 0) t) (nullable.some 0)))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_336137 Int) (BOUND_VARIABLE_336138 Int)) (< BOUND_VARIABLE_336137 BOUND_VARIABLE_336138)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_336137 Int) (BOUND_VARIABLE_336138 Int)) (< BOUND_VARIABLE_336137 BOUND_VARIABLE_336138)) ((_ tuple.select 0) t) (nullable.some 10)))))))
(assert (not (= q1 q2)))
(assert (= p2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_336157 Int) (BOUND_VARIABLE_336158 Int)) (> BOUND_VARIABLE_336157 BOUND_VARIABLE_336158)) ((_ tuple.select 0) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_336157 Int) (BOUND_VARIABLE_336158 Int)) (> BOUND_VARIABLE_336157 BOUND_VARIABLE_336158)) ((_ tuple.select 0) t) (nullable.some 0))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_336183 Bool)) (not BOUND_VARIABLE_336183)) (ite (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_336169 Int) (BOUND_VARIABLE_336170 Int)) (< BOUND_VARIABLE_336169 BOUND_VARIABLE_336170)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_336176 Int) (BOUND_VARIABLE_336177 Int)) (< BOUND_VARIABLE_336176 BOUND_VARIABLE_336177)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some false)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_336183 Bool)) (not BOUND_VARIABLE_336183)) (ite (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_336169 Int) (BOUND_VARIABLE_336170 Int)) (< BOUND_VARIABLE_336169 BOUND_VARIABLE_336170)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_336176 Int) (BOUND_VARIABLE_336177 Int)) (< BOUND_VARIABLE_336176 BOUND_VARIABLE_336177)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some false))))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_336157 Int) (BOUND_VARIABLE_336158 Int)) (> BOUND_VARIABLE_336157 BOUND_VARIABLE_336158)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_336183 Bool)) (not BOUND_VARIABLE_336183)) (ite (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_336169 Int) (BOUND_VARIABLE_336170 Int)) (< BOUND_VARIABLE_336169 BOUND_VARIABLE_336170)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_336176 Int) (BOUND_VARIABLE_336177 Int)) (< BOUND_VARIABLE_336176 BOUND_VARIABLE_336177)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some false))))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_336157 Int) (BOUND_VARIABLE_336158 Int)) (> BOUND_VARIABLE_336157 BOUND_VARIABLE_336158)) ((_ tuple.select 0) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_336157 Int) (BOUND_VARIABLE_336158 Int)) (> BOUND_VARIABLE_336157 BOUND_VARIABLE_336158)) ((_ tuple.select 0) t) (nullable.some 0))))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_336183 Bool)) (not BOUND_VARIABLE_336183)) (ite (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_336169 Int) (BOUND_VARIABLE_336170 Int)) (< BOUND_VARIABLE_336169 BOUND_VARIABLE_336170)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_336176 Int) (BOUND_VARIABLE_336177 Int)) (< BOUND_VARIABLE_336176 BOUND_VARIABLE_336177)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some false)))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_336183 Bool)) (not BOUND_VARIABLE_336183)) (ite (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_336169 Int) (BOUND_VARIABLE_336170 Int)) (< BOUND_VARIABLE_336169 BOUND_VARIABLE_336170)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_336176 Int) (BOUND_VARIABLE_336177 Int)) (< BOUND_VARIABLE_336176 BOUND_VARIABLE_336177)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some false))))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_336157 Int) (BOUND_VARIABLE_336158 Int)) (> BOUND_VARIABLE_336157 BOUND_VARIABLE_336158)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_336183 Bool)) (not BOUND_VARIABLE_336183)) (ite (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_336169 Int) (BOUND_VARIABLE_336170 Int)) (< BOUND_VARIABLE_336169 BOUND_VARIABLE_336170)) ((_ tuple.select 0) t) (nullable.some 10))) (nullable.lift (lambda ((BOUND_VARIABLE_336176 Int) (BOUND_VARIABLE_336177 Int)) (< BOUND_VARIABLE_336176 BOUND_VARIABLE_336177)) ((_ tuple.select 0) t) (nullable.some 10)) (nullable.some false))))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= q1 (set.minus ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP)) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP)))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p2 EMP)))))
(check-sat)
;answer: unsat
; duration: 518 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool))))) (and (nullable.is_some (nullable.some true)) (not (nullable.val (nullable.some true))))) (nullable.some false) (ite (or (nullable.is_null (as nullable.null (Nullable Bool))) (nullable.is_null (nullable.some true))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool))))) (and (nullable.is_some (nullable.some true)) (not (nullable.val (nullable.some true))))) (nullable.some false) (ite (or (nullable.is_null (as nullable.null (Nullable Bool))) (nullable.is_null (nullable.some true))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) false)))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 11 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_340084 Int) (BOUND_VARIABLE_340085 Int)) (= BOUND_VARIABLE_340084 BOUND_VARIABLE_340085)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_340084 Int) (BOUND_VARIABLE_340085 Int)) (= BOUND_VARIABLE_340084 BOUND_VARIABLE_340085)) ((_ tuple.select 0) t) (nullable.some 0)))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (nullable.val (as nullable.null (Nullable Bool))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_340084 Int) (BOUND_VARIABLE_340085 Int)) (= BOUND_VARIABLE_340084 BOUND_VARIABLE_340085)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_340084 Int) (BOUND_VARIABLE_340085 Int)) (= BOUND_VARIABLE_340084 BOUND_VARIABLE_340085)) ((_ tuple.select 0) t) (nullable.some 0)))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (nullable.val (as nullable.null (Nullable Bool))))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_340110 Int) (BOUND_VARIABLE_340111 Int)) (= BOUND_VARIABLE_340110 BOUND_VARIABLE_340111)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_340110 Int) (BOUND_VARIABLE_340111 Int)) (= BOUND_VARIABLE_340110 BOUND_VARIABLE_340111)) ((_ tuple.select 0) t) (nullable.some 0)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false)))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_340110 Int) (BOUND_VARIABLE_340111 Int)) (= BOUND_VARIABLE_340110 BOUND_VARIABLE_340111)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_340110 Int) (BOUND_VARIABLE_340111 Int)) (= BOUND_VARIABLE_340110 BOUND_VARIABLE_340111)) ((_ tuple.select 0) t) (nullable.some 0)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false)))) (nullable.some true) (as nullable.null (Nullable Bool))))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 92 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_341567 Int) (BOUND_VARIABLE_341568 Int)) (> BOUND_VARIABLE_341567 BOUND_VARIABLE_341568)) ((_ tuple.select 0) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_341567 Int) (BOUND_VARIABLE_341568 Int)) (> BOUND_VARIABLE_341567 BOUND_VARIABLE_341568)) ((_ tuple.select 0) t) (nullable.some 0))))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_341567 Int) (BOUND_VARIABLE_341568 Int)) (> BOUND_VARIABLE_341567 BOUND_VARIABLE_341568)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.is_null (as nullable.null (Nullable Bool)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_341567 Int) (BOUND_VARIABLE_341568 Int)) (> BOUND_VARIABLE_341567 BOUND_VARIABLE_341568)) ((_ tuple.select 0) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_341567 Int) (BOUND_VARIABLE_341568 Int)) (> BOUND_VARIABLE_341567 BOUND_VARIABLE_341568)) ((_ tuple.select 0) t) (nullable.some 0))))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_341567 Int) (BOUND_VARIABLE_341568 Int)) (> BOUND_VARIABLE_341567 BOUND_VARIABLE_341568)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.is_null (as nullable.null (Nullable Bool)))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_341595 Int) (BOUND_VARIABLE_341596 Int)) (> BOUND_VARIABLE_341595 BOUND_VARIABLE_341596)) ((_ tuple.select 0) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_341595 Int) (BOUND_VARIABLE_341596 Int)) (> BOUND_VARIABLE_341595 BOUND_VARIABLE_341596)) ((_ tuple.select 0) t) (nullable.some 0))))) (and (nullable.is_some (nullable.some false)) (not (nullable.val (nullable.some false))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_341595 Int) (BOUND_VARIABLE_341596 Int)) (> BOUND_VARIABLE_341595 BOUND_VARIABLE_341596)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.is_null (nullable.some false))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_341595 Int) (BOUND_VARIABLE_341596 Int)) (> BOUND_VARIABLE_341595 BOUND_VARIABLE_341596)) ((_ tuple.select 0) t) (nullable.some 0))) (not (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_341595 Int) (BOUND_VARIABLE_341596 Int)) (> BOUND_VARIABLE_341595 BOUND_VARIABLE_341596)) ((_ tuple.select 0) t) (nullable.some 0))))) (and (nullable.is_some (nullable.some false)) (not (nullable.val (nullable.some false))))) (nullable.some false) (ite (or (nullable.is_null (nullable.lift (lambda ((BOUND_VARIABLE_341595 Int) (BOUND_VARIABLE_341596 Int)) (> BOUND_VARIABLE_341595 BOUND_VARIABLE_341596)) ((_ tuple.select 0) t) (nullable.some 0))) (nullable.is_null (nullable.some false))) (as nullable.null (Nullable Bool)) (nullable.some true))))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 38 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_342312 Int) (BOUND_VARIABLE_342313 Int)) (= BOUND_VARIABLE_342312 BOUND_VARIABLE_342313)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.some false) (as nullable.null (Nullable Bool)))) (nullable.val (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_342312 Int) (BOUND_VARIABLE_342313 Int)) (= BOUND_VARIABLE_342312 BOUND_VARIABLE_342313)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.some false) (as nullable.null (Nullable Bool))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_342333 Int) (BOUND_VARIABLE_342334 Int)) (= BOUND_VARIABLE_342333 BOUND_VARIABLE_342334)) ((_ tuple.select 0) t) (nullable.some 1))) false false))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 33 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_342921 Int) (BOUND_VARIABLE_342922 Int)) (= BOUND_VARIABLE_342921 BOUND_VARIABLE_342922)) ((_ tuple.select 0) t) (nullable.some 1))) (as nullable.null (Nullable Bool)) (nullable.some true))) (nullable.val (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_342921 Int) (BOUND_VARIABLE_342922 Int)) (= BOUND_VARIABLE_342921 BOUND_VARIABLE_342922)) ((_ tuple.select 0) t) (nullable.some 1))) (as nullable.null (Nullable Bool)) (nullable.some true)))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (ite (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_342942 Int) (BOUND_VARIABLE_342943 Int)) (= BOUND_VARIABLE_342942 BOUND_VARIABLE_342943)) ((_ tuple.select 0) t) (nullable.some 1))) false true))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 163 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_344225 Int) (BOUND_VARIABLE_344226 Int)) (= BOUND_VARIABLE_344225 BOUND_VARIABLE_344226)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_344225 Int) (BOUND_VARIABLE_344226 Int)) (= BOUND_VARIABLE_344225 BOUND_VARIABLE_344226)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (nullable.val (as nullable.null (Nullable Bool))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.lift (lambda ((BOUND_VARIABLE_344237 Int) (BOUND_VARIABLE_344238 Int)) (< BOUND_VARIABLE_344237 BOUND_VARIABLE_344238)) ((_ tuple.select 6) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_344243 Int) (BOUND_VARIABLE_344244 Int)) (> BOUND_VARIABLE_344243 BOUND_VARIABLE_344244)) ((_ tuple.select 6) t) (nullable.some 10)))) (nullable.val (ite (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_344225 Int) (BOUND_VARIABLE_344226 Int)) (= BOUND_VARIABLE_344225 BOUND_VARIABLE_344226)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_344225 Int) (BOUND_VARIABLE_344226 Int)) (= BOUND_VARIABLE_344225 BOUND_VARIABLE_344226)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (nullable.val (as nullable.null (Nullable Bool))))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.lift (lambda ((BOUND_VARIABLE_344237 Int) (BOUND_VARIABLE_344238 Int)) (< BOUND_VARIABLE_344237 BOUND_VARIABLE_344238)) ((_ tuple.select 6) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_344243 Int) (BOUND_VARIABLE_344244 Int)) (> BOUND_VARIABLE_344243 BOUND_VARIABLE_344244)) ((_ tuple.select 6) t) (nullable.some 10))))))))
(assert (not (= q1 q2)))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_344265 Int) (BOUND_VARIABLE_344266 Int)) (= BOUND_VARIABLE_344265 BOUND_VARIABLE_344266)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_344265 Int) (BOUND_VARIABLE_344266 Int)) (= BOUND_VARIABLE_344265 BOUND_VARIABLE_344266)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false)))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.lift (lambda ((BOUND_VARIABLE_344277 Int) (BOUND_VARIABLE_344278 Int)) (< BOUND_VARIABLE_344277 BOUND_VARIABLE_344278)) ((_ tuple.select 6) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_344283 Int) (BOUND_VARIABLE_344284 Int)) (> BOUND_VARIABLE_344283 BOUND_VARIABLE_344284)) ((_ tuple.select 6) t) (nullable.some 10)))) (nullable.val (ite (nullable.val (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_344265 Int) (BOUND_VARIABLE_344266 Int)) (= BOUND_VARIABLE_344265 BOUND_VARIABLE_344266)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_344265 Int) (BOUND_VARIABLE_344266 Int)) (= BOUND_VARIABLE_344265 BOUND_VARIABLE_344266)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false)))) (nullable.some true) (as nullable.null (Nullable Bool)))) (nullable.lift (lambda ((BOUND_VARIABLE_344277 Int) (BOUND_VARIABLE_344278 Int)) (< BOUND_VARIABLE_344277 BOUND_VARIABLE_344278)) ((_ tuple.select 6) t) (nullable.some 10)) (nullable.lift (lambda ((BOUND_VARIABLE_344283 Int) (BOUND_VARIABLE_344284 Int)) (> BOUND_VARIABLE_344283 BOUND_VARIABLE_344284)) ((_ tuple.select 6) t) (nullable.some 10))))))))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p0 EMP))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8) (set.filter p1 EMP))))
(check-sat)
;answer: unsat
; duration: 860 ms.
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

(declare-const DEPT (Set (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q1 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_348317 Bool)) (not BOUND_VARIABLE_348317)) (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_348297 Int) (BOUND_VARIABLE_348298 Int)) (= BOUND_VARIABLE_348297 BOUND_VARIABLE_348298)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_348297 Int) (BOUND_VARIABLE_348298 Int)) (= BOUND_VARIABLE_348297 BOUND_VARIABLE_348298)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_348303 Int) (BOUND_VARIABLE_348304 Int)) (= BOUND_VARIABLE_348303 BOUND_VARIABLE_348304)) ((_ tuple.select 0) t) (as nullable.null (Nullable Int)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_348303 Int) (BOUND_VARIABLE_348304 Int)) (= BOUND_VARIABLE_348303 BOUND_VARIABLE_348304)) ((_ tuple.select 0) t) (as nullable.null (Nullable Int)))))) (nullable.some true) (as nullable.null (Nullable Bool))))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_348317 Bool)) (not BOUND_VARIABLE_348317)) (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_348297 Int) (BOUND_VARIABLE_348298 Int)) (= BOUND_VARIABLE_348297 BOUND_VARIABLE_348298)) ((_ tuple.select 0) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_348297 Int) (BOUND_VARIABLE_348298 Int)) (= BOUND_VARIABLE_348297 BOUND_VARIABLE_348298)) ((_ tuple.select 0) t) ((_ tuple.select 9) t)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_348303 Int) (BOUND_VARIABLE_348304 Int)) (= BOUND_VARIABLE_348303 BOUND_VARIABLE_348304)) ((_ tuple.select 0) t) (as nullable.null (Nullable Int)))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_348303 Int) (BOUND_VARIABLE_348304 Int)) (= BOUND_VARIABLE_348303 BOUND_VARIABLE_348304)) ((_ tuple.select 0) t) (as nullable.null (Nullable Int)))))) (nullable.some true) (as nullable.null (Nullable Bool)))))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) false)))
(assert (= q1 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p0 (rel.product EMP DEPT)))))
(assert (= q2 ((_ rel.project 0 1 2 3 4 5 6 7 8 9 10) (set.filter p1 (rel.product EMP DEPT)))))
(check-sat)
;answer: unsat
; duration: 45 ms.
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
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (ite (nullable.val (ite (or (and (nullable.is_some (nullable.some true)) (not (nullable.val (nullable.some true)))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.some true)) (nullable.is_null (as nullable.null (Nullable Bool)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (ite (or (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (nullable.val (as nullable.null (Nullable Bool))))) (nullable.some true) (as nullable.null (Nullable Bool))) (ite (or (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool))))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool)))))) (nullable.some false) (ite (or (nullable.is_null (as nullable.null (Nullable Bool))) (nullable.is_null (as nullable.null (Nullable Bool)))) (as nullable.null (Nullable Bool)) (nullable.some true))))) (nullable.val (ite (nullable.val (ite (or (and (nullable.is_some (nullable.some true)) (not (nullable.val (nullable.some true)))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool)))))) (nullable.some false) (ite (or (nullable.is_null (nullable.some true)) (nullable.is_null (as nullable.null (Nullable Bool)))) (as nullable.null (Nullable Bool)) (nullable.some true)))) (ite (or (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (nullable.val (as nullable.null (Nullable Bool))))) (nullable.some true) (as nullable.null (Nullable Bool))) (ite (or (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool))))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (not (nullable.val (as nullable.null (Nullable Bool)))))) (nullable.some false) (ite (or (nullable.is_null (as nullable.null (Nullable Bool))) (nullable.is_null (as nullable.null (Nullable Bool)))) (as nullable.null (Nullable Bool)) (nullable.some true)))))))))
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
(assert (= f0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (ite (or (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_349245 Int) (BOUND_VARIABLE_349246 Int)) (= BOUND_VARIABLE_349245 BOUND_VARIABLE_349246)) ((_ tuple.select 0) t) (nullable.some 1))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_349245 Int) (BOUND_VARIABLE_349246 Int)) (= BOUND_VARIABLE_349245 BOUND_VARIABLE_349246)) ((_ tuple.select 0) t) (nullable.some 1)))) (and (nullable.is_some (as nullable.null (Nullable Bool))) (nullable.val (as nullable.null (Nullable Bool))))) (nullable.some true) (as nullable.null (Nullable Bool)))))))
(assert (not (= q1 q2)))
(assert (= f1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple (nullable.lift (lambda ((BOUND_VARIABLE_349267 Int) (BOUND_VARIABLE_349268 Int)) (= BOUND_VARIABLE_349267 BOUND_VARIABLE_349268)) ((_ tuple.select 0) t) (nullable.some 1))))))
(assert (= q1 (set.map f0 EMP)))
(assert (= q2 (set.map f1 EMP)))
(check-sat)
;answer: sat
; duration: 203 ms.
(get-model)
; (
; (define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))) (set.union (set.singleton (tuple (as nullable.null (Nullable Int)) (nullable.some "G") (nullable.some "H") (nullable.some (- 13)) (nullable.some 14) (nullable.some (- 14)) (nullable.some 15) (nullable.some (- 15)) (nullable.some 16))) (set.union (set.singleton (tuple (as nullable.null (Nullable Int)) (nullable.some "E") (nullable.some "F") (nullable.some (- 10)) (nullable.some 11) (nullable.some (- 11)) (nullable.some 12) (nullable.some (- 12)) (nullable.some 13))) (set.singleton (tuple (nullable.some 0) (nullable.some "C") (nullable.some "D") (nullable.some (- 7)) (nullable.some 8) (nullable.some (- 8)) (nullable.some 9) (nullable.some (- 9)) (nullable.some 10))))))
; )
; q1
(get-value (q1))
; (set.singleton (tuple (as nullable.null (Nullable Bool))))
; q2
(get-value (q2))
; (set.union (set.singleton (tuple (nullable.some false))) (set.singleton (tuple (as nullable.null (Nullable Bool)))))
; insert into EMP values(NULL,'G','H',-13,14,-14,15,-15,16),(NULL,'E','F',-10,11,-11,12,-12,13),(0,'C','D',-7,8,-8,9,-9,10)
; SELECT * FROM (SELECT TRUE = ((empno = 1) OR CAST(NULL AS BOOLEAN)) FROM emp) AS q1 EXCEPT ALL SELECT * FROM (SELECT TRUE = ((empno = 1) OR FALSE) FROM emp) AS q2;
;(NULL)

; SELECT * FROM (SELECT TRUE = ((empno = 1) OR FALSE) FROM emp) AS q2 EXCEPT ALL SELECT * FROM (SELECT TRUE = ((empno = 1) OR CAST(NULL AS BOOLEAN)) FROM emp) AS q1;
;(false)

;Model soundness: true
(reset)
; total time: 72714 ms.
; sat answers    : 6
; unsat answers  : 77
; unknown answers: 5
