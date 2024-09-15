SRCS=$(wildcard standalones/*.tex)
COURSE="Calc_1000A_002_F24"

.PHONY: clean standalones lectures all main week1

clean:
	latexmk -C
	rm -rf standalones/build
	rm -rf outlines/build
	rm -rf lectures/build
	rm -rf build

standalones/%.pdf: standalones/%.tex
	latexmk -halt-on-error -interaction=nonstopmode $^
	
outlines/%.pdf: outlines/%.tex
	latexmk -halt-on-error -interaction=nonstopmode $^

outlines:
	latexmk outlines/week*.tex

standalones: 
	latexmk standalones/*.tex

main: standalones main.tex
	latexmk -halt-on-error -interaction=nonstopmode main.tex
	cp -f build/main.pdf Calc_1000A_002_F24_main.pdf

week1: standalones main
	latexmk -halt-on-error -interaction=nonstopmode week1.tex
	cp -f build/week1.pdf ${COURSE}_week1_fillable.pdf

week2: standalones main
	latexmk -halt-on-error -interaction=nonstopmode week2.tex
	cp -f build/week2.pdf ${COURSE}_week2_fillable.pdf

week3: standalones main
	latexmk -halt-on-error -interaction=nonstopmode week3.tex
	cp -f build/week3.pdf ${COURSE}_week3_fillable.pdf

