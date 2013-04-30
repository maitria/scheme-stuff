(include "generics#.scm")
(include "iteration#.scm")

(define (csv-reader char-stream)
  (define current-position (first-position char-stream))

  (define (producer)

    (define record '())
    (define current-value '())
    (define in-quotes #f)

    (define (take-field)
      (set! record (cons (list->string (reverse current-value)) record))
      (set! current-value '()))

    (define (advance)
      (set! current-position (position-following current-position)))

    (let loop ()
      (define current-char (car current-position))

      (define (next)
	(advance)
	(loop))

      (cond
	((and (char=? current-char #\")
	      (not in-quotes))
	 (set! in-quotes #t)
	 (next))

	((and (char=? current-char #\")
	      in-quotes)
	 (set! in-quotes #f)
	 (next))

	((and (char=? current-char #\,)
	      (not in-quotes))
	 (take-field)
	 (next))

	((and (char=? current-char #\newline)
	      (not in-quotes))
	 (take-field)
	 (advance)
	 (list->vector (reverse record)))

	(else
	  (set! current-value (cons current-char current-value))
	  (next)))))

  (producer->position producer eof-object?))
