(define (read-all-as-string)
  (define s (make-string 4096))
  (let loop ((c (read-char))
	     (i 0))
    (cond
      ((eof-object? c)
       (substring s 0 i))
      (else
       (if (= i (string-length s))
	 (let ((ns (make-string (* 2 (string-length s)))))
	   (substring-move! s 0 i ns 0)
	   (set! s ns)))
       (string-set! s i c)
       (loop (read-char) (+ i 1))))))

(define (read-file f)
  (with-input-from-file f read-all-as-string))

(add-method (->list (input-port? port))
  (producer->position
    (lambda ()
      (let ((value (read-char port)))
	(if (eof-object? value)
	  (close-input-port port))
	value))
    eof-object?))

(define (dirname path)
  (path-strip-trailing-directory-separator (path-directory path)))

(define basename path-strip-directory)
