LATEXMK=latexmk -halt-on-error -interaction=nonstopmode
COURSE="Calc_1000A_F25"

.PHONY: all clean standalones main publish

all: publish

clean:
	rm -rf **/.aux
	rm -rf **/*.synctex.gz
	rm -rf lessons/*.pdf
	rm -rf appendix/*.pdf
	rm -rf standalones/*.pdf
	rm -rf publish
	rm -rf {main,slides,polls}.pdf ${COURSE}_{main,slides,polls}.pdf

standalones: 
	${LATEXMK} standalones/plot_net_area.tex
	${LATEXMK} standalones/*.tex

appendix:
	${LATEXMK} appendix/*.tex

slides:
	${LATEXMK} -jobname="${COURSE}_%A" slides.tex polls.tex

main: standalones appendix
	rm -rf publish/*.tex
	mkdir -p publish
	${LATEXMK} main.tex
	${LATEXMK} -jobname="${COURSE}_%A" main.tex

publish: main slides
	${LATEXMK} -jobname="${COURSE}_%A" publish/*.tex
