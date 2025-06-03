; test name: testEmptyJoinLeft
;Translating sql query: SELECT * FROM (SELECT * FROM EMP AS EMP WHERE FALSE) AS t LEFT JOIN DEPT AS DEPT ON t.DEPTNO = DEPT.DEPTNO
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES (0,'','',0,0,0,0,0,0,0,''))) AS t0
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :check-models true)
(set-option :check-unsat-cores true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 10000)
(set-option :strings-exp true)

(declare-const DEPT (Bag (Tuple (Nullable Int) (Nullable String))))
(declare-const EMP (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int))))
(declare-const p0 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) Bool))
(declare-const q1 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const p1 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)) Bool))
(declare-const q2 (Bag (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(declare-const leftJoin2 (-> (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)) (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String))))
(assert (not (= q1 q2)))
(assert (= p0 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (and (nullable.is_some (nullable.some false)) (nullable.val (nullable.some false))))))
(assert (= p1 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable String)))) (and (nullable.is_some (nullable.lift (lambda ((BOUND_VARIABLE_511 Int) (BOUND_VARIABLE_512 Int)) (= BOUND_VARIABLE_511 BOUND_VARIABLE_512)) ((_ tuple.select 7) t) ((_ tuple.select 9) t))) (nullable.val (nullable.lift (lambda ((BOUND_VARIABLE_511 Int) (BOUND_VARIABLE_512 Int)) (= BOUND_VARIABLE_511 BOUND_VARIABLE_512)) ((_ tuple.select 7) t) ((_ tuple.select 9) t)))))))
(assert (= leftJoin2 (lambda ((t (Tuple (Nullable Int) (Nullable String) (Nullable String) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int) (Nullable Int)))) (tuple ((_ tuple.select 0) t) ((_ tuple.select 1) t) ((_ tuple.select 2) t) ((_ tuple.select 3) t) ((_ tuple.select 4) t) ((_ tuple.select 5) t) ((_ tuple.select 6) t) ((_ tuple.select 7) t) ((_ tuple.select 8) t) (as nullable.null (Nullable Int)) (as nullable.null (Nullable String))))))
(assert (= q1 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag.union_disjoint (bag.map leftJoin2 (bag.difference_remove ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) DEPT))))) (bag.filter p1 (table.product ((_ table.project 0 1 2 3 4 5 6 7 8) (bag.filter p0 EMP)) DEPT))))))
(assert (= q2 ((_ table.project 0 1 2 3 4 5 6 7 8 9 10) (bag (tuple (nullable.some 0) (nullable.some "") (nullable.some "") (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some 0) (nullable.some "")) 1))))
(check-sat)
(get-unsat-core)
;answer: unsat
; duration: 131 ms.
