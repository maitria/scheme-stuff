(include "iteration#.scm")

(define (combinations . lists)

  (define ending-sentinel (gensym))
  (define (ending-sentinel? o)
    (eq? o ending-sentinel))

  (define state (map
		  (lambda (x)
		    (cons
		      (first-position x)
		      (first-position x)))
		  lists))

  (define (value)
    (if state
      (map car (map car state))
      ending-sentinel))

  (define (next-state state)
    (cond
      ((not state)
       #f)
      ((null? state)
       #f)
      (else
	(let* ((position+1 (cdr (caar state)))
	       (at-end? (null? position+1))
	       (next-position (if at-end?
				(cdar state)
				position+1))
	       (next-state-head (cons
				  next-position
				  (cdar state))))
	  (if at-end?
	    (let ((next-state-tail (next-state (cdr state))))
	      (if next-state-tail
		(cons
		  next-state-head
		  next-state-tail)
		#f))
	    (cons
	      next-state-head
	      (cdr state)))))))

  (define (combination-producer)
    (let ((v (value)))
      (set! state (next-state state))
      v))

  (producer->position combination-producer ending-sentinel?))

