(include "generics#.scm")

(declare
  (not inline-primitives)) ; Work around for inlining null? making it strict

(let ((old-for-each for-each))
  (set! for-each (lambda (proc iterable)
		   (old-for-each proc (->list iterable)))))

(define (generic-lazy-map proc iterable)

  (define (lazy-node list-node)
    (delay
      (if (null? list-node)
	'()
	(cons
	  (proc (car list-node))
	  (lazy-node (cdr list-node))))))

  (lazy-node (->list iterable)))

(set! map generic-lazy-map)
