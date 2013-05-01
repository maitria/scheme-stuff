(include "generics#.scm")
(include "iteration#.scm")

(define-generic (first-position object))

(define (iterable? thing)
  (method first-position thing))

(define position? list?)

(define (for-each proc iterable)

  ; Prevent a bug in 4.6.8 with --enable-auto-force and inlining primitives
  (declare
    (not inline-primitives))

  (let loop ((position (first-position iterable)))
    (if (null? position)
      #!void
      (begin
	(proc (car position))
	(loop (cdr position))))))

(add-method (first-position (list? object))
  object)
