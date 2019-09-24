.PHONY: build deploy cleandist pdf

build:
	git checkout gh-pages
	git commit -am "Update theme"
	git merge --no-edit -X theirs master
	R --slave -f build.R
	git add .
	git commit -am "Setup GitHub Pages"

deploy: build
	git push --all --recurse-submodules=on-demand
	
cleandist: deploy
	git revert --no-edit HEAD
	git checkout master

pdf:
	Rscript --slave \
	-e pagedown::chrome_print(input = "index.Rmd", \
		output = "pdf/mod-mAndA-1-vcrms.pdf", options = list()) \
	-e pagedown::chrome_print(input = "extra.Rmd", \
		output = "pdf/extra.pdf")

index.html: index.Rmd
	R --slave -e rmarkdown::render('index.Rmd', 'xaringan::moon_reader')

extra.html: extra.Rmd
	R --slave -e rmarkdown::render('extra.Rmd', 'xaringan::moon_reader')
