(include "generics#.scm")

(define-generic (length thing))
(define-generic (nth index thing))
(define-generic (set-nth! index thing value))

(add-method (length (list? l))
  (##length l))
(add-method (nth index (list? l))
  (list-ref l index))
(add-method (set-nth! index (list? l) value)
  (let loop ((i index)
	     (l l))
    (cond
      ((= 0 i)
       (set-car! l value))
      ((< i 0)
       (error "SET-NTH! argument must be non-negative"))
      (else
       (loop (- i 1) (cdr l)))))
  #!void)

(add-method (length (vector? v))
  (##vector-length v))
(add-method (nth index (vector? v))
  (vector-ref v index))
(add-method (set-nth! index (vector? v) value)
  (vector-set! v index value))

(add-method (length (string? s))
  (##string-length s))
(add-method (nth index (string? s))
  (string-ref s index))
(add-method (set-nth! index (string? s) value)
  (string-set! s index value))

(define-type indexable-position
  (object read-only:)
  (offset read-only:))

(define (indexable? object)
  (and (method nth 0 object)
       (method length object)))

(add-method (first-position (indexable? object))
  (make-indexable-position object 0))
(add-method (value-at-position (indexable-position? p))
  (nth (indexable-position-offset p) (indexable-position-object p)))
(add-method (position-following (indexable-position? object))
  (let ((next-offset (+ 1 (indexable-position-offset object))))
    (if (= next-offset (length (indexable-position-object object)))
      *end-position*
      (make-indexable-position (indexable-position-object object) next-offset))))
