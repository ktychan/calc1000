include ./guidednotes/Makefile
COURSE="Calc_1000A_$(shell git rev-parse --abbrev-ref HEAD)"

.PHONY: all clean 

all: build.pdf slides.pdf polls.pdf
	cp build.pdf ${COURSE}_main.pdf
	cp slides.pdf ${COURSE}_slides.pdf
	cp polls.pdf ${COURSE}_polls.pdf
