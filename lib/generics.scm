(include "generics#.scm")

(define (dispatch-generic method-table args)
  (let method-loop ((methods-left method-table))
    (cond
      ((null? methods-left)
       (raise (cons "Cannot find a method which applies to: " args)))
      ((apply (caar methods-left) args)
       (apply (cdar methods-left) args))
      (else
       (method-loop (cdr methods-left))))))

