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

(define-type addressable-position
  (object read-only:)
  (offset read-only:))

(define (addressable? object)
  (and (method nth 0 object)
       (method length object)))

(add-method (first-position (addressable? object))
  (make-addressable-position object 0))
(add-method (value-at-position (addressable-position? p))
  (nth (addressable-position-offset p) (addressable-position-object p)))
(add-method (position-following (addressable-position? object))
  (let ((next-offset (+ 1 (addressable-position-offset object))))
    (if (= next-offset (length (addressable-position-object object)))
      *end-position*
      (make-addressable-position (addressable-position-object object) next-offset))))