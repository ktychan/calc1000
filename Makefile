COURSE="Calc_1000A_002_F24"
LATEXMK=latexmk -halt-on-error -interaction=nonstopmode

.PHONY: all clean standalones main

all: main 

clean:
	rm -r **/build

standalones: 
	${LATEXMK} standalones/*.tex

appendix: 
	${LATEXMK} -jobname="${COURSE}_appendix_%A" appendix/*.tex
	cp -vf appendix/build/${COURSE}_*.pdf ./

main: standalones
	${LATEXMK} main.tex
	${LATEXMK} -jobname="${COURSE}_%A" polls.tex
	${LATEXMK} -jobname="${COURSE}_%A_fillable" week*.tex
	${LATEXMK} -c -jobname="${COURSE}_%A" polls.tex
	${LATEXMK} -c -jobname="${COURSE}_%A_fillable" week*.tex
