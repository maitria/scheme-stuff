(include "generics#.scm")
(include "iteration#.scm")

(define *end-position* '())

(define-generic (first-position object))
(define-generic (value-at-position position))
(define-generic (position-following position))
(define end-position? null?)

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

(define-type string-position
  (string read-only:)
  (offset read-only:))

(add-method (first-position (string? object))
  (make-string-position object 0))
(add-method (value-at-position (string-position? object))
  (string-ref (string-position-string object) (string-position-offset object)))
(add-method (position-following (string-position? object))
  (let ((next-offset (+ 1 (string-position-offset object))))
    (if (= next-offset (string-length (string-position-string object)))
      *end-position*
      (make-string-position (string-position-string object) next-offset))))

(define-type vector-position
  (vector read-only:)
  (offset read-only:))

(add-method (first-position (vector? object))
  (make-vector-position object 0))
(add-method (value-at-position (vector-position? object))
  (vector-ref (vector-position-vector object) (vector-position-offset object)))
(add-method (position-following (vector-position? object))
  (let ((next-offset (+ 1 (vector-position-offset object))))
    (if (= (vector-length object) next-offset)
      *end-position*
      (make-vector-position (vector-position-vector object) next-offset))))

