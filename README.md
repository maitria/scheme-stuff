scheme-stuff
------------

This is my random collection of Scheme stuff.

Building it
============

If Gambit's installed and `gsc` is in the path, you should only need to run
`make`.  *NOTE:* Gambit must be configured with the `--enable-auto-force`
option for some things to work.

Making it Load Automatically
============================

Edit or create `~/.gambcini` and put this in it:

```scheme
(load "~/src/scheme-stuff/scheme-stuff.o1")
(include "~/src/scheme-stuff/scheme-stuff#.scm")
```

Except, of course, that you'll need to change the paths to the location where
you've checked this out.

Generic Functions
=================

This has a simple, useful implementation of generic functions, by way of the
DEFINE-GENERIC and ADD-METHOD macros, which work like so:

```scheme
(define-generic (add a b))
(add-method (add (number? a) (number? b))
  (+ a b))
(add-method (add (string? a) (string? b))
  (string-append a b))

(add 2 5) => 7
(add "hello, " "world!") => "hello, world!"
```

Lazy Sequences
==============

The following generic functions are used to produce lazy sequences:

```scheme
(->list something-iterable) => #<lazy list>
```

Lazy ranges can be produced like so:

```scheme
(range from: 2 to: 200 step: 2)
```

Other Stuff
===========

I'm too lazy to document everything.
