(include "generics#.scm")
(include "iteration#.scm")

(define-generic (first-position object))
(define-generic (value-at-position position))
(define-generic (position-following position))
(define-generic (end-position? position))

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
(add-method (end-position? (list? object))
  (null? object))

(define-type string-position
  (string read-only:)
  (offset read-only:))

(add-method (first-position (string? object))
  (make-string-position object 0))
(add-method (value-at-position (string-position? object))
  (string-ref (string-position-string object) (string-position-offset object)))
(add-method (position-following (string-position? object))
  (make-string-position (string-position-string object) (+ 1 (string-position-offset object))))
(add-method (end-position? (string-position? object))
  (= (string-length (string-position-string object))
     (string-position-offset object)))

(define-type vector-position
  (vector read-only:)
  (offset read-only:))

(add-method (first-position (vector? object))
  (make-vector-position object 0))
(add-method (value-at-position (vector-position? object))
  (vector-ref (vector-position-vector object) (vector-position-offset object)))
(add-method (position-following (vector-position? object))
  (make-vector-position (vector-position-vector object) (+ 1 (vector-position-offset object))))
(add-method (end-position? (vector-position? object))
  (= (vector-length (vector-position-vector object))
     (vector-position-offset object)))

