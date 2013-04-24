(include "iteration#.scm")

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

(define-type producer-position
  (producer read-only:)
  (value read-only:)
  (end-value-predicate read-only:)
  (next-position))

(define (producer->position producer end-sentinel?)
  (make-producer-position
    producer
    (producer)
    end-sentinel?
    #f))

(add-method (value-at-position (producer-position? p))
  (producer-position-value p))

(add-method (next-position (producer-position? p))
  (let ((cached-next-position (producer-position-next-position p)))
    (cond
      (cached-next-position
	cached-next-position)
      (else
	(let ((next-position (make-producer-position
			       (producer-position-producer p)
			       ((producer-position-producer p))
			       (producer-position-end-value-predicate p)
			       #f)))
	  (producer-position-next-position-set! p next-position)
	  next-position)))))

(add-method (end-position? (producer-position? p))
  ((producer-position-end-value-predicate p) (producer-position-value p)))

