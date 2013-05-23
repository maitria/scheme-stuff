
lib_SOURCES	= $(filter-out %\#.scm,$(wildcard lib/*.scm))
lib_HEADERS	= $(wildcard lib/*\#.scm)

test_SOURCES	= $(wildcard test/test-*.scm)

test: $(test_PROGRAMS)
	for test in $(test_SOURCES); do gsi -f ./$$test || exit $$?; done

all: scheme-stuff.o1 scheme-stuff\#.scm


scheme-stuff.o1: scheme-stuff.scm $(lib_SOURCES) $(lib_HEADERS)
	rm -f scheme-stuff.o*
	gsc -f scheme-stuff

.PHONY: all test
