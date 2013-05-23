(include "../scheme-stuff#.scm")
(load "scheme-stuff.o1")
(include "expect.scm")

(expect (equal? '(2 3 4 5) (range from: 2 to: 5)))
