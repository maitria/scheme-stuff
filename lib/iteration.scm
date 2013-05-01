(include "generics#.scm")

(let ((old-for-each for-each))
  (set! for-each (lambda (proc iterable)
		   (old-for-each proc (->list iterable)))))
