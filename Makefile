
lib_SOURCES	= $(filter-out %\#.scm,$(wildcard lib/*.scm))
lib_HEADERS	= $(wildcard lib/*\#.scm)

all: scheme-stuff.o1 scheme-stuff\#.scm

scheme-stuff.scm: $(lib_SOURCES)
	for s in $(lib_SOURCES); do printf '(include "%s")\n' "$$s"; done >$@

scheme-stuff\#.scm: $(lib_HEADERS)
	for s in $(lib_HEADERS); do printf '(include "%s")\n' "$$s"; done >$@

scheme-stuff.o1: scheme-stuff.scm
	rm -f scheme-stuff.o*
	gsc -f scheme-stuff
