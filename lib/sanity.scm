
(let ((original-length length))
  (set! length
    (lambda (o)
      (cond
	((string? o)
	 (string-length o))
	((vector? o)
	 (vector-length o))
	(else
	 (original-length o))))))

