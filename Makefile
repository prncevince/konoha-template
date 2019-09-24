.PHONY: all knit build deploy cleandist pdf

GENERATED_FILES = index.html

knit: $(GENERATED_FILES)

all: knit build deploy cleandist

pages: build deploy cleandist

index.html: index.Rmd
	R --slave -e "rmarkdown::render('index.Rmd', 'xaringan::moon_reader')"

build:
	git checkout gh-pages
	git diff-index --quiet HEAD || git commit -am "Update theme"
	git merge --no-edit -X theirs master
	R --slave -f build.R
	git add .
	git commit -am "Setup GitHub Pages"

deploy:
	git push --all --recurse-submodules=on-demand

cleandist:
	git revert --no-edit HEAD
	git checkout master

extra.html: extra.Rmd
	R --slave -e "rmarkdown::render('extra.Rmd', 'xaringan::moon_reader')"

pdf:
	Rscript --slave \
	-e "pagedown::chrome_print(input = 'index.Rmd', \
	output = 'pdf/mod-mAndA-n-reponame.pdf', options = list())" \
	-e "pagedown::chrome_print(input = 'extra.Rmd', \
	output = 'pdf/extra.pdf')"
