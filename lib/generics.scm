(include "generics#.scm")

(define (dispatch-generic method-table args)
  (let method-loop ((methods-left method-table))
    (cond
      ((null? methods-left)
       (error (string-append
		"generic has no method which accepts "
		(object->string args))))
      ((apply (caar methods-left) args)
       (apply (cdar methods-left) args))
      (else
       (method-loop (cdr methods-left))))))

(define (generic-methods-box generic)
  (cond
    ((##interp-procedure? generic)
     (##vector-ref (##interp-procedure-rte generic) 1))
    ((##closure? generic)
     (##closure-ref generic 1))
    (else
     (error (string-append (object->string generic) " is not a generic")))))
