(namespace ("generics#"
  dispatch-generic
  ))

(define-macro (define-generic form)
  (let ((generic-name (car form)))
    `(begin
       (define ,generic-name
         (let (($methods (box '())))
	   (lambda args
	     (dispatch-generic (unbox $methods) args)))))))

(define-macro (add-method form . body)
  (let* ((generic-name (car form))
	 (args (cdr form))
	 (arg-names (map cadr args)))
    `(begin
       (let (($methods (cond
			 ((##interp-procedure? ,generic-name)
			  (##vector-ref (##interp-procedure-rte ,generic-name) 1))
			 ((##closure? ,generic-name)
			  (##closure-ref ,generic-name 1))
			 (else
			  (error "ADD-METHOD called on non-generic")))))
	 (set-box! $methods (cons
			      (cons
				(lambda ,arg-names
				  (and ,@args))
				(lambda ,arg-names
				  ,@body))
			      (unbox $methods)))))))
