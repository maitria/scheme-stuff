(include "iteration#.scm")

(define-type range-position
  (value read-only:)
  (limit read-only:)
  (step read-only:))

(define (range #!key (from 0) (to #f) (step 1))
  (make-range-position from to step))

(add-method (first-position (range-position? p))
  p)
(add-method (value-at-position (range-position? p))
  (range-position-value p))
(add-method (position-following (range-position? p))
  (let ((next-value (+ (range-position-value p) (range-position-step p))))
    (if (> next-value (range-position-limit p))
      *end-position*
      (make-range-position
	next-value
	(range-position-limit p)
	(range-position-step p)))))
