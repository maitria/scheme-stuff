
(define (factors n)
  (define result '())

  (define (divide-and-store factor)
    (if (= (modulo n factor) 0)
      (begin
	(set! n (quotient n factor))
	(set! result (cons factor result))
	#t)
      #f))

  (let two-loop ()
    (if (divide-and-store 2)
      (two-loop)
      #f))

  (let factor-loop ((i 3))
    (cond
      ((> (* i i) n)
       (if (not (= n 1))
	 (set! result (cons n result)))
       (reverse result))

      ((divide-and-store i)
       (factor-loop i))

      (else
       (factor-loop (+ i 2))))))

