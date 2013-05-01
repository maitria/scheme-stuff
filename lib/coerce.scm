(include "generics#.scm")

(define-generic (->list thing))

(add-method (->list (list? thing))
  (define (lazy-list-node l)
    (delay
      (if (null? l)
	'()
	(cons
	  (car l)
	  (lazy-list-node (cdr l))))))
  (lazy-list-node thing))
