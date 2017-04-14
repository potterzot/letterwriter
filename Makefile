all: readme letters

#generate all letters
SRC=$(wildcard letters/*.Rmd)
OUT=$(patsubst letters/%.Rmd, output/%.pdf, $(SRC))
letters: $(OUT)

#CLEAN
#remove any output (non-data) files
clean:
	rm -f README.md

cleanall:
	rm -f README.md
	rm -f output/*

#OUTPUT
#Project README
readme: README.Rmd
	R -e "rmarkdown::render('$(<F)')"

#Generate a specific letter
output/%.pdf: letters/%.Rmd
	cd $(<D); R -e "rmarkdown::render('$(<F)', output_format = 'all', output_dir = '../output/')"


#output/$(OUT): $(SRC)
#	cd $(<D); R -e "rmarkdown::render('$(<F)', output_format = 'all', output_dir = '../output/')"

#output/%: $(SRC)
#	cd letters; R -e "lapply($@, rmarkdown::render, output_format = 'all')"
