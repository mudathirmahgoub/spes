; test name: testReduceConstants2
;Translating sql query: SELECT CAST(CASE WHEN NULL IS NULL THEN 2 IS NULL WHEN 2 IS NULL THEN NULL IS NULL ELSE NULL = 2 END AS BOOLEAN) FROM (VALUES  (0)) AS t
;Translating sql query: SELECT FALSE FROM (VALUES  (0)) AS t2
(set-logic HO_ALL)
(set-option :produce-models true)
(set-option :debug-check-models true)
(set-option :dag-thresh 0)
(set-option :uf-lazy-ll true)
(set-option :fmf-bound true)
(set-option :tlimit-per 6000)
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
; duration: 224 ms.
(reset)
