
lib_SOURCES	= $(filter-out %\#.scm,$(wildcard lib/*.scm))
lib_HEADERS	= $(wildcard lib/*\#.scm)

all: scheme-stuff.o1 scheme-stuff\#.scm

scheme-stuff.o1: scheme-stuff.scm $(lib_SOURCES) $(lib_HEADERS)
	rm -f scheme-stuff.o*
	gsc -f scheme-stuff
