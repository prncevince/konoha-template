.PHONY: build deploy cleandist pdf

build:
	git checkout gh-pages
	git commit -am "Update theme"
	git merge -X theirs master
	R --slave -f build.R

deploy: build
	git add .
	git commit -am "Setup GitHub Pages"
	git push --all --recurse-submodules=on-demand
	
cleandist: deploy
	git revert HEAD
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
