(include "generics#.scm")

(define (dispatch-generic method-table args)
  (let ((m (apply method method-table args)))
    (if m
      (apply m args)
      (error (string-append
	       "generic has no method which accepts "
	       (object->string args))))))

(define (generic-methods-box generic)
  (cond
    ((##interp-procedure? generic)
     (##vector-ref (##interp-procedure-rte generic) 1))
    ((##closure? generic)
     (##closure-ref generic 1))
    (else
     (error (string-append (object->string generic) " is not a generic")))))

(define (method generic-or-method-list . args)
  (define method-list (if (list? generic-or-method-list)
			generic-or-method-list
			(unbox (generic-methods-box generic-or-method-list))))
  (let method-loop ((methods-left method-list))
    (cond
      ((null? methods-left)
       #f)
      ((apply (caar methods-left) args)
       (cdar methods-left))
      (else
       (method-loop (cdr methods-left))))))

