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

