
(define-generic (seq object))
(define-generic (first seq))
(define-generic (rest seq))
(define-generic (end? seq))

(add-method (seq (list? object))
  object)
(add-method (first (list? object))
  (car object))
(add-method (rest (list? object))
  (cdr object))
(add-method (end? (list? object))
  (null? object))

(define (for-each proc seqable)
  (let loop ((iterator (seq seqable)))
    (if (end? iterator)
      #!void
      (begin
	(proc (first iterator))
	(loop (rest iterator))))))

