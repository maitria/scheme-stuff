(namespace ("generics#"
  dispatch-generic
  generic-methods-box
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
       (let (($methods (generic-methods-box ,generic-name)))
	 (set-box! $methods (cons
			      (cons
				(lambda ,arg-names
				  (and ,@args))
				(lambda ,arg-names
				  ,@body))
			      (unbox $methods)))))))
