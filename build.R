# Starting from scratch & Build
#
#`git clone --recursive git@esgovcloud.com:mAndA/mod-mAndA-template.git`
#`git remote add origin git@url`
#make changes
xaringan::inf_mr()
#add & commit changes
#`git push -u origin master`

# Building website & Deploy
#
# This allows us to source the filesystem in the main superproject when in the remote
# repo. The magic is all in build command below AND the index.Rmd YALM!
# (multiple stylesheet paths) 
fs::dir_copy(path = 'theme/src', 'dist/src')
fs::dir_copy(path = 'theme/usr', 'dist/usr')
xaringan::moon_reader()
#`git push`

# Git Submodule workflow
#
#

#Unfortunately, we cannot set the `extra_dependencies` argument in xaringan because
#it utilizes the arguments of BOTH rmarkdown::html_document() & html_document_base()
#which BOTH contain `extra_dependencies`, so we get a 
#"matched by multiple actual arguments" error
#xaringan::moon_reader()rmarkdown::html_document()rmarkdown::html_document_base()

# Making updates to the theme should be done DIRECTLY to the theme directory 
# i.e. the git submodule

# setup GitHub Pages enterprise directory structure
#`currently NOTHING woop!`