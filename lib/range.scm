
(define (range #!key (from 0) to (step 1))
  (define result '())
  (let loop ((i from))
    (if (> i to)
      (reverse result)
      (begin
        (set! result (cons i result))
        (loop (+ i step))))))

