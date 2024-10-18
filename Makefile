SRCS=$(wildcard standalones/*.tex)
COURSE="Calc_1000A_002_F24"

.PHONY: clean standalones lectures main weeks polls exercises

all: main weeks polls

clean:
	latexmk -C
	latexmk -C standalones/*.tex
	latexmk -C outlines/*.tex
	latexmk -C lessons/*.tex
	latexmk -C lectures/*.tex
	rm -rf **/build

standalones/%.pdf: standalones/%.tex
	latexmk -halt-on-error -interaction=nonstopmode $^
	
outlines/%.pdf: outlines/%.tex
	latexmk -halt-on-error -interaction=nonstopmode $^

outlines:
	latexmk outlines/week*.tex

standalones: 
	latexmk standalones/*.tex

exercises:
	latexmk -halt-on-error -interaction=nonstopmode exercises_progressions.tex
	cp -vf build/exercises_progressions.pdf Calc_1000A_002_F24_exercises_progressions.pdf
	
main: standalones main.tex
	latexmk -halt-on-error -interaction=nonstopmode main.tex
	cp -vf build/main.pdf Calc_1000A_002_F24_main.pdf

polls:
	latexmk -halt-on-error -interaction=nonstopmode polls.tex
	cp -vf build/polls.pdf Calc_1000A_002_F24_polls.pdf

weeks: standalones main
	latexmk -halt-on-error -interaction=nonstopmode week*.tex
	cp -vf build/week1.pdf ${COURSE}_week1_fillable.pdf
	cp -vf build/week2.pdf ${COURSE}_week2_fillable.pdf
	cp -vf build/week3.pdf ${COURSE}_week3_fillable.pdf
	cp -vf build/week4.pdf ${COURSE}_week4_fillable.pdf
	cp -vf build/week5.pdf ${COURSE}_week5_fillable.pdf
	cp -vf build/week6.pdf ${COURSE}_week6_fillable.pdf
	cp -vf build/week7.pdf ${COURSE}_week7_fillable.pdf
	cp -vf build/week8.pdf ${COURSE}_week8_fillable.pdf

formulas: 
	latexmk -halt-on-error -interaction=nonstopmode formulas.tex
	cp -vf build/formulas.pdf ${COURSE}_formulas.pdf

usb: polls weeks
	cp -vf ${COURSE}*.pdf /Volumes/KEL/calc1000f24/
	open /Volumes/KEL/calc1000f24/
