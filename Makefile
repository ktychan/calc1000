LATEXMK=latexmk -halt-on-error -interaction=nonstopmode
COURSE="Calc_1000A_002_F25"

.PHONY: all clean standalones main publish

all: publish

clean:
	rm -rf **/.aux
	rm -rf publish

standalones: 
	${LATEXMK} standalones/plot_net_area.tex
	${LATEXMK} standalones/*.tex

main: standalones
	rm -rf publish/*.tex
	mkdir -p publish
	${LATEXMK} main.tex
	${LATEXMK} -jobname="${COURSE}_%A" slides.tex main.tex

publish: main
	${LATEXMK} -jobname="${COURSE}_%A" publish/*.tex
