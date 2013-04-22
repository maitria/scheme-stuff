(namespace ("generics#"
  dispatch-generic
  ))

(define-macro (define-generic form)
  (let* ((generic-name (car form))
	 (method-table-name (string->symbol
			      (string-append
				"*"
				(symbol->string generic-name)
				"-methods*"))))
  `(begin
     (define ,method-table-name '())
     (define (,generic-name . args)
       (dispatch-generic ,method-table-name args)))))

(define-macro (add-method form . body)
  (let* ((generic-name (car form))
	 (method-table-name (string->symbol
			      (string-append
				"*"
				(symbol->string generic-name)
				"-methods*")))
	 (args (cdr form))
	 (arg-names (map cadr args))
	 (arg-types (map car args)))
    `(begin
       (set! ,method-table-name (cons
				  (cons
				    (lambda ,arg-names
				      (and ,@args))
				    (lambda ,arg-names
				      ,@body))
				  ,method-table-name))
       )))
