
(define (compose function . moar-functions)
  (if (null? moar-functions)
    function
    (lambda args
      (function (apply (apply compose moar-functions) args)))))
       
(define (partial f . partial-args)
  (lambda args
    (apply f (append partial-args args))))
