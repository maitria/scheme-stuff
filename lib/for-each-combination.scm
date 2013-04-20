
(define (for-each-combination proc . lists)
  (for-each
    (lambda (a)
      (if (null? (cdr lists))
	(proc a)
	(apply for-each-combination
	  (lambda args
	    (apply proc a args))
	  (cdr lists))))
    (car lists)))

