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

# Reindent with latexindent per .latexindent.yaml; it needs a perl with
# YAML::Tiny and File::HomeDir (`conda install latexindent.pl` brings both).
# Narrow it with FILES, e.g. `make format FILES=polls.tex`. Changed files are
# backed up to .aux/latexindent/. The mindmaps are skipped: their TikZ trees
# are aligned by hand, and reindenting would flatten them.
FORMAT_EXCLUDE = standalones/mindmap-%.tex
FILES ?= $(filter-out $(FORMAT_EXCLUDE),$(shell git ls-files '*.tex'))
format:
	@mkdir -p .aux/latexindent
	@for f in $(FILES); do \
	    latexindent -s -wd -l=$(CURDIR)/.latexindent.yaml -c=.aux/latexindent/ -g=/dev/null "$$f"; \
	done
