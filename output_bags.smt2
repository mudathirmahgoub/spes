;-----------------------------------------------------------
; test name: testEmptyFilterProjectUnion
;Translating sql query: SELECT * FROM (SELECT * FROM (VALUES  (10, 1),  (30, 3)) AS t UNION ALL SELECT * FROM (VALUES  (20, 2)) AS t0) AS t1 WHERE t1.EXPR$0 + t1.EXPR$1 > 30
;Translating sql query: SELECT * FROM (VALUES  (30, 3)) AS t3
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const p0 (-> (Tuple Int Int) Bool))
(assert (not (= ((_ table.project 0 1) (bag.filter p0 (bag.union_disjoint ((_ table.project 0 1) (bag.union_disjoint (bag (tuple 10 1) 1) (bag (tuple 30 3) 1))) ((_ table.project 0 1) (bag (tuple 20 2) 1))))) ((_ table.project 0 1) (bag (tuple 30 3) 1)))))
(assert (= p0 (lambda ((t (Tuple Int Int))) (> (+ ((_ tuple.select 0) t) ((_ tuple.select 1) t)) 30))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testEmptyMinus2
;Translating sql query: SELECT * FROM (SELECT * FROM (SELECT * FROM (VALUES  (30, 3)) AS t EXCEPT SELECT * FROM (VALUES  (20, 2)) AS t0 WHERE t0.EXPR$0 > 30) AS t2 EXCEPT SELECT * FROM (VALUES  (40, 4)) AS t3) AS t4 EXCEPT SELECT * FROM (VALUES  (50, 5)) AS t5 WHERE t5.EXPR$0 > 50
;Translating sql query: SELECT * FROM (VALUES  (30, 3)) AS t8 EXCEPT SELECT * FROM (VALUES  (40, 4)) AS t9
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const p0 (-> (Tuple Int Int) Bool))
(declare-const p1 (-> (Tuple Int Int) Bool))
(assert (= p0 (lambda ((t (Tuple Int Int))) (> ((_ tuple.select 0) t) 30))))
(assert (not (= (bag.difference_remove ((_ table.project 0 1) (bag.difference_remove ((_ table.project 0 1) (bag.difference_remove ((_ table.project 0 1) (bag (tuple 30 3) 1)) ((_ table.project 0 1) (bag.filter p0 (bag (tuple 20 2) 1))))) ((_ table.project 0 1) (bag (tuple 40 4) 1)))) ((_ table.project 0 1) (bag.filter p1 (bag (tuple 50 5) 1)))) (bag.difference_remove ((_ table.project 0 1) (bag (tuple 30 3) 1)) ((_ table.project 0 1) (bag (tuple 40 4) 1))))))
(assert (= p1 (lambda ((t (Tuple Int Int))) (> ((_ tuple.select 0) t) 50))))
(check-sat)
;answer: unsat
;-----------------------------------------------------------
; test name: testReduceConstantsCalc
;Translating sql query: SELECT * FROM (SELECT UPPER(SUBSTRING(t6.X FROM 1 FOR 2) || SUBSTRING(t6.X FROM 3)) AS U, SUBSTRING(t6.X FROM 1 FOR 1) AS S FROM (SELECT * FROM (SELECT 'table' AS X FROM (VALUES  (TRUE)) AS t UNION SELECT 'view' FROM (VALUES  (TRUE)) AS t1) AS t3 UNION SELECT 'foreign table' FROM (VALUES  (TRUE)) AS t4) AS t6) AS t7 WHERE t7.U = 'TABLE'
;Translating sql query: SELECT 'TABLE' AS U, 't' AS S FROM (VALUES  (TRUE)) AS t9
(set-logic HO_ALL)
(set-option :fmf-bound true)
(set-option :uf-lazy-ll true)
(set-option :strings-exp true)
(declare-const p4 (-> (Tuple String String) Bool))
(declare-const f0 (-> (Tuple Bool) (Tuple String)))
(declare-const f1 (-> (Tuple Bool) (Tuple String)))
(declare-const f2 (-> (Tuple Bool) (Tuple String)))
(declare-const f3 (-> (Tuple String) (Tuple String String)))
(declare-const f5 (-> (Tuple Bool) (Tuple String String)))
(assert (= f0 (lambda ((t (Tuple Bool))) (tuple "table"))))
(assert (= f1 (lambda ((t (Tuple Bool))) (tuple "view"))))
(assert (= f2 (lambda ((t (Tuple Bool))) (tuple "foreign table"))))
(assert (= f3 (lambda ((t (Tuple String))) (tuple (str.to_upper (str.++ (str.substr ((_ tuple.select 0) t) 0 2) (str.substr ((_ tuple.select 0) t) 2 (str.len ((_ tuple.select 0) t))))) (str.substr ((_ tuple.select 0) t) 0 1)))))
(assert (not (= ((_ table.project 0 1) (bag.filter p4 (bag.map f3 (bag.union_max ((_ table.project 0) (bag.union_max (bag.map f0 (bag (tuple true) 1)) (bag.map f1 (bag (tuple true) 1)))) (bag.map f2 (bag (tuple true) 1)))))) (bag.map f5 (bag (tuple true) 1)))))
(assert (= p4 (lambda ((t (Tuple String String))) (= ((_ tuple.select 0) t) "TABLE"))))
(assert (= f5 (lambda ((t (Tuple Bool))) (tuple "TABLE" "t"))))
(check-sat)
;answer: unsat
