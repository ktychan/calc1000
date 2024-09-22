SRCS=$(wildcard standalones/*.tex)
COURSE="Calc_1000A_002_F24"

.PHONY: clean standalones lectures all main week1

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
	cp -f build/exercises_progressions.pdf Calc_1000A_002_F24_exercises_progressions.pdf

polls:
	latexmk -halt-on-error -interaction=nonstopmode polls.tex
	if [[ -d "/Volumes/KEL" ]]; then \ 
	cp -vf build/polls.pdf /Volumes/KEL/calc1000f24/Calc_1000A_002_F24_polls.pdf \ 
	else \ 
	echo "USB is not present. Not copying." \ 
	fi

	

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

week4: standalones main
	latexmk -halt-on-error -interaction=nonstopmode week4.tex
	cp -f build/week4.pdf ${COURSE}_week4_fillable.pdf

