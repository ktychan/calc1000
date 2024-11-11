SRCS=$(wildcard standalones/*.tex)
COURSE="Calc_1000A_002_F24"

.PHONY: clean standalones appendix polls main weeks 

all: main weeks polls

clean:
	latexmk -C
	latexmk -C standalones/*.tex
	latexmk -C outlines/*.tex
	latexmk -C lessons/*.tex

standalones/%.pdf: standalones/%.tex
	latexmk -halt-on-error -interaction=nonstopmode $^
	
outlines/%.pdf: outlines/%.tex
	latexmk -halt-on-error -interaction=nonstopmode $^

outlines:
	latexmk outlines/week*.tex

standalones: 
	latexmk standalones/*.tex

appendix:
	latexmk -halt-on-error -interaction=nonstopmode main.tex appendix/*.tex
	cp -vf appendix/build/slides_critical_numbers.pdf ${COURSE}_appendix_critical_numbers.pdf
	cp -vf appendix/build/slides_optimization.pdf ${COURSE}_appendix_optimization.pdf
	cp -vf appendix/build/exercises_progressions.pdf ${COURSE}_exercises_progressions.pdf

main: standalones appendix main.tex
	cp -vf build/main.pdf ${COURSE}_main.pdf

polls:
	latexmk -halt-on-error -interaction=nonstopmode polls.tex
	cp -vf build/polls.pdf ${COURSE}_polls.pdf

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
	cp -vf build/week9.pdf ${COURSE}_week9_fillable.pdf
	cp -vf build/week10.pdf ${COURSE}_week10_fillable.pdf
	cp -vf build/week11.pdf ${COURSE}_week11_fillable.pdf

formulas: 
	latexmk -halt-on-error -interaction=nonstopmode formulas.tex
	cp -vf build/formulas.pdf ${COURSE}_formulas.pdf

usb: polls weeks
	cp -vf ${COURSE}*.pdf /Volumes/KEL/calc1000f24/
	open /Volumes/KEL/calc1000f24/
