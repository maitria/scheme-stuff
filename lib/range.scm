(define (range #!key (from 0) (to #f) (step 1))
  (delay
    (if (and to (> from to))
      '()
      (cons from (range from: (+ from step) to: to step: step)))))
