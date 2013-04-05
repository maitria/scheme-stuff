
lib_SOURCES	= $(wildcard lib/*.scm)

all: scheme-stuff.o1

scheme-stuff.scm: $(lib_SOURCES)
	for s in $(lib_SOURCES); do printf '(include "%s")\n' "$$s"; done >$@

scheme-stuff.o1: scheme-stuff.scm
	rm -f scheme-stuff.o*
	gsc scheme-stuff
