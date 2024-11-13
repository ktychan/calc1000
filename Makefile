COURSE="Calc_1000A_002_F24"
LATEXMK=latexmk -halt-on-error -interaction=nonstopmode

.PHONY: clean standalones main

all: main 

standalones: 
	${LATEXMK} standalones/*.tex

appendix: 
	${LATEXMK} -jobname="${COURSE}_appendix_%A" appendix/*.tex
	cp -vf appendix/build/${COURSE}_*.pdf ./

main: standalones
	${LATEXMK} main.tex
	${LATEXMK} -jobname="${COURSE}_%A" polls.tex
	${LATEXMK} -jobname="${COURSE}_%A_fillable" week*.tex
