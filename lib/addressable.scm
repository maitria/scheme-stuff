(include "generics#.scm")
(include "addressable#.scm")

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

(define (addressable? object)
  (and (method nth 0 object)
       (method length object)))

(let ((list-method (method ->list '())))

  (add-method (->list (addressable? object))
    (define (position n)
      (delay
	(if (= n (length object))
	  '()
	  (cons
	    (nth n object)
	    (position (+ n 1))))))
    (position 0))

  (add-method (->list (list? object))
    (list-method object)))
