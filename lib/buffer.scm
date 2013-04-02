
(define-type buffer
  string
  offset)

(define (buffer-length b)
  (- (string-length (buffer-string b))
     (buffer-offset b)))

(define (buffer-ref b i)
  (let ((real-offset (+ (buffer-offset b))))
    (if (>= real-offset (buffer-length b))
      #!eof
      (string-ref (buffer-string b) (+ i (buffer-offset b))))))

(define (take-from-buffer b n)
  (let ((s (substring (buffer-string b) (buffer-offset b) (+ n (buffer-offset b)))))
    (buffer-offset-set! b (+ n (buffer-offset b)))
    s))

