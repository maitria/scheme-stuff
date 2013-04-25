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
  (make-range-position
    (+ (range-position-value p) (range-position-step p))
    (range-position-limit p)
    (range-position-step p)))
(add-method (end-position? (range-position? p))
  (and (range-position-limit p)
       (> (range-position-value p)
	  (range-position-limit p))))
