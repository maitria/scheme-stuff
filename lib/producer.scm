
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

