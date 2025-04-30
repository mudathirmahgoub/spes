sat
(
(define-fun EMP () (Set (Tuple (Nullable Int) (Nullable String) (Nullable String))) 
(set.union 
  (set.singleton 
  (tuple (as nullable.null (Nullable Int)) (nullable.some "") (nullable.some "B"))) 
  (set.union 
    (set.singleton (tuple (as nullable.null (Nullable Int)) (nullable.some "") (nullable.some "A"))) 
    (set.singleton 
    (tuple (as nullable.null (Nullable Int)) (nullable.some "") (as nullable.null (Nullable String)))))))
(define-fun q1 () (Set (Tuple (Nullable String) (Nullable Int) (Nullable Int))) 
(set.singleton (tuple (nullable.some "") (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)))))
(define-fun q2 () (Set (Tuple (Nullable String) (Nullable Int) (Nullable Int))) (set.singleton (tuple (as nullable.null (Nullable String)) (as nullable.null (Nullable Int)) (as nullable.null (Nullable Int)))))
)
; emp
; null, "", "B"
; null, "", "A"
; null, "", null
;--------------------
; q1
; "", null, null
