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


(define (detect proc a-list)
  (let loop ((l a-list))
    (if (null? l)
      #f
      (if (proc (car l))
	(car l)
	(loop (cdr l))))))

(define (fold-left proc initial-value a-list)
  (if (null? a-list)
    initial-value
    (fold-left proc (proc initial-value (car a-list)) (cdr a-list))))
