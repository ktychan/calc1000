include ./guidednotes/Makefile
COURSE="Calc_1000A_F25"

.PHONY: all clean main 

slides: slides.tex polls.tex
	${LATEXMK} -jobname="${COURSE}_%A" slides.tex polls.tex
