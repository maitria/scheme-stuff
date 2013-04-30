(include "generics#.scm")
(include "iteration#.scm")

(define *end-position* '())

(define-generic (first-position object))
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
	(loop (cdr position))))))

(add-method (first-position (list? object))
  object)
