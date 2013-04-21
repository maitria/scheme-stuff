
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

(define-type string-seq
  (string read-only:)
  (offset read-only:))

(add-method (seq (string? object))
  (make-string-seq object 0))
(add-method (first (string-seq? object))
  (string-ref (string-seq-string object) (string-seq-offset object)))
(add-method (rest (string-seq? object))
  (make-string-seq (string-seq-string object) (+ 1 (string-seq-offset object))))
(add-method (end? (string-seq? object))
  (= (string-length (string-seq-string object))
     (string-seq-offset object)))

(define-type vector-seq
  (vector read-only:)
  (offset read-only:))

(add-method (seq (vector? object))
  (make-vector-seq object 0))
(add-method (first (vector-seq? object))
  (vector-ref (vector-seq-vector object) (vector-seq-offset object)))
(add-method (rest (vector-seq? object))
  (make-vector-seq (vector-seq-vector object) (+ 1 (vector-seq-offset object))))
(add-method (end? (vector-seq? object))
  (= (vector-length (vector-seq-vector object))
     (vector-seq-offset object)))

(define (for-each proc seqable)
  (let loop ((iterator (seq seqable)))
    (if (end? iterator)
      #!void
      (begin
	(proc (first iterator))
	(loop (rest iterator))))))

