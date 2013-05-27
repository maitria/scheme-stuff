
(define (fibonacci)
  (define (fib a b)
    (delay
      (cons
	b
	(fib b (+ a b)))))

  (delay
    (cons
      1
      (fib 1 1))))

