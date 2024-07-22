SRCS=$(wildcard standalones/*.tex)

.PHONY: clean standalones lectures all

clean:
	latexmk -C
	rm -rf standalones/build
	rm -rf outlines/build
	rm -rf lectures/build
	rm -rf build

standalones/%.pdf: standalones/%.tex
	latexmk -halt-on-error -interaction=nonstopmode $^
	
outlines/%.pdf: outlines/%.tex
	latexmk -halt-on-error -interaction=nonstopmode -jobname="CALC_1000_F24_outlines_%A" $^

main.pdf: standalones main.tex
	latexmk -jobname="CALC_1000_F24_%A" main.tex
	
outlines:
	latexmk -jobname="CALC_1000_F24_%A" outlines/week*.tex

standalones: 
	latexmk standalones/*.tex