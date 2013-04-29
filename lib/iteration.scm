(include "generics#.scm")
(include "iteration#.scm")

(define *end-position* '())

(define-generic (first-position object))
(define-generic (value-at-position position))
(define-generic (position-following position))
(define end-position? null?)

(define (iterable? thing)
  (method first-position thing))

(define (position? thing)
  (method value-at-position thing))

(define (for-each proc iterable)
  (let loop ((position (first-position iterable)))
    (if (end-position? position)
      #!void
      (begin
	(proc (value-at-position position))
	(loop (position-following position))))))

(add-method (first-position (list? object))
  object)
(add-method (value-at-position (list? object))
  (car object))
(add-method (position-following (list? object))
  (cdr object))
