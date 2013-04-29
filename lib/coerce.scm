(include "generics#.scm")
(include "iteration#.scm")

(define-generic (->list thing))

(add-method (->list (iterable? iterable))
  (define result (cons #f '()))

  (define (add thing)
    (set-cdr! (car result) (list thing))
    (set-car! result (cdr (car result))))

  (set-car! result result)

  (for-each add iterable)
  (cdr result))

