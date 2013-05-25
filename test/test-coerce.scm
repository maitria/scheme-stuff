(include "../scheme-stuff#.scm")
(load "scheme-stuff.o1")
(include "expect.scm")

(expect (equal? '(2 3 4) (delay '(2 3 4))))
(expect (equal? '(2 3 4) (->list '(2 3 4))))
(expect (equal? '(2 3 4) (->list (delay '(2 3 4)))))
