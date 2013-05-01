(define (make-producer proc)
  (define restart-proc #f)

  (define (producer)
    (call/cc
      (lambda (return)
        (define (return-and-continue value)
          (set! return (call/cc
                         (lambda (restart)
                           (set! restart-proc restart)
                           (return value)))))
        (if restart-proc
          (restart-proc return)
          (proc return-and-continue)))))

  producer)

(define (producer->position producer end-sentinel?)
  (define (position)
    (delay
      (let ((value (producer)))
	(if (end-sentinel? value)
	  '()
	  (cons value (position))))))
  (position))
