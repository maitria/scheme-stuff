(include "generics#.scm")
(include "iteration#.scm")

(define *end-position* '())

(define-generic (first-position object))
(define-generic (position-following position))
(define end-position? null?)

(define (iterable? thing)
  (method first-position thing))

(define position? list?)

(define (for-each proc iterable)
  (let loop ((position (first-position iterable)))
    (if (end-position? position)
      #!void
      (begin
	(proc (car position))
	(loop (position-following position))))))

(add-method (first-position (list? object))
  object)
(add-method (position-following (list? object))
  (cdr object))
