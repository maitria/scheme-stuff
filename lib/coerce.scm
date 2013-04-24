(include "generics#.scm")

(define-generic (->list thing))

(add-method (->list (list? l))
  l)
(add-method (->list (string? s))
  (string->list s))
(add-method (->list (vector? v))
  (vector->list v))


