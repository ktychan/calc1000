LATEXMK=latexmk -halt-on-error -interaction=nonstopmode
COURSE="Calc_1000A_002_F24"

.PHONY: all clean standalones main publish

all: publish

clean:
	rm -rf **/build
	rm -rf standalones/build
	rm -rf publish/*.tex publish/build

standalones: 
	${LATEXMK} standalones/*.tex

appendix: 
	${LATEXMK} -jobname="${COURSE}_appendix_%A" appendix/*.tex
	cp -vf appendix/build/${COURSE}_*.pdf ./

main: standalones
	rm -rf publish/*.tex
	${LATEXMK} main.tex
	${LATEXMK} -jobname="${COURSE}_%A" polls.tex
	${LATEXMK} -c -jobname="${COURSE}_%A" polls.tex

publish: main
	${LATEXMK} -jobname="${COURSE}_%A" publish/*.tex
