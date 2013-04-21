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
	 (arg-types (map car args))
	 (type-signature (let loop ((types arg-types)
				    (signature-bits '()))
			   (if (null? types)
			     (apply string-append "<" (reverse (cons ">" signature-bits)))
			     (loop
			       (cdr types)
			       (cons (symbol->string (car types)) 
				     (if (= 0 (length signature-bits))
				       signature-bits
				       (cons "-" signature-bits)))))))
	 (specific-name (string->symbol
			  (string-append
			    (symbol->string generic-name)
			    "-"
			    type-signature)))
	 (predicate-name (string->symbol
			   (string-append
			     (symbol->string specific-name)
			     "?"))))
    `(begin
       (define (,specific-name ,@arg-names)
	 ,@body)
       (define (,predicate-name ,@arg-names)
	 (and ,@args))
       (set! ,method-table-name (cons (cons ,predicate-name ,specific-name)
				      ,method-table-name))
       )))
