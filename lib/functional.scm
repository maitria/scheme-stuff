
(define (compose . functions)
  (cond
    ((null? functions)
     (error "COMPOSE must have at least one function"))
    ((null? (cdr functions))
     (car functions))
    (else
     (lambda args
       ((car functions) (apply (apply compose (cdr functions)) args))))))
       
(define (partial f . partial-args)
  (lambda args
    (apply f (append partial-args args))))
