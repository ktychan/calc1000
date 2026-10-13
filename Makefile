# vim:number
include ./guidednotes/Makefile
COURSE="Calc_1000A_$(shell git rev-parse --abbrev-ref HEAD)"

.PHONY: all clean format

.DEFAULT_GOAL := all
all: build.pdf slides.pdf polls.pdf
	cp build.pdf ${COURSE}_main.pdf
	cp slides.pdf ${COURSE}_slides.pdf
	cp polls.pdf ${COURSE}_polls.pdf

clean:
	rm -f {*,**/*}.pdf
	rm -f {*,**/*}.synctex.gz
	rm -rf **/.aux build

# Reindent with latexindent per .latexindent.yaml. `conda install
# latexindent.pl` puts the script and the perl modules it needs in the active
# env, and only that env's perl can find them; a shell can show (sage) yet put
# /usr/bin/perl first on PATH, so call the env's perl directly. Without an env
# that has latexindent.pl, fall back to whatever latexindent is on PATH.
# Narrow it with FILES, e.g. `make format FILES=polls.tex`. Changed files are
# backed up to .aux/latexindent/. The mindmaps are skipped: their TikZ trees
# are aligned by hand, and reindenting would flatten them.
CONDA_LATEXINDENT = $(wildcard $(CONDA_PREFIX)/bin/latexindent.pl)
LATEXINDENT ?= $(if $(CONDA_LATEXINDENT),$(CONDA_PREFIX)/bin/perl $(CONDA_LATEXINDENT),latexindent)
FORMAT_EXCLUDE = standalones/mindmap-%.tex
FILES ?= $(filter-out $(FORMAT_EXCLUDE),$(shell git ls-files '*.tex'))
format:
	@mkdir -p .aux/latexindent
	@for f in $(FILES); do \
	    $(LATEXINDENT) -s -wd -l=$(CURDIR)/.latexindent.yaml -c=.aux/latexindent/ -g=/dev/null "$$f"; \
	done
