(namespace ("generics#"
  dispatch-generic
  generic-methods-box
  method
  ))

(define-macro (define-generic form)
  `(define ,(car form)
     (let (($methods (box '())))
       (lambda args
	 (dispatch-generic (unbox $methods) args)))))

(define-macro (add-method form . body)
  (let* ((generic-name (car form))
	 (args (cdr form))
	 (arg-name (lambda (arg)
		     (if (pair? arg)
		       (cadr arg)
		       arg)))
	 (arg-names (map arg-name args))
	 (arg-tests (let loop ((args-remaining args)
			       (tests-found '()))
		      (cond
			((null? args-remaining)
			 (reverse tests-found))
			((pair? (car args-remaining))
			 (loop 
			   (cdr args-remaining)
			   (cons (car args-remaining) tests-found)))
			(else
			 (loop
			   (cdr args-remaining)
			   tests-found))))))
    `(let (($methods (generic-methods-box ,generic-name)))
       (set-box! $methods (cons
			    (cons
			      (lambda ,arg-names
				(and ,@arg-tests))
			      (lambda ,arg-names
				,@body))
			    (unbox $methods))))))
