# Starting from scratch & Build
#
#`git clone --recursive --single-branch -b master git@url`
#`git remote remove origin`
#`git remote add origin git@url`
#`cd theme && git checkout master`
#make changes
xaringan::inf_mr() #rmarkdown::render('index.Rmd', 'xaringan::moon_reader')
#
#add & commit changes
#
#`git push -u origin master`
#
#after making changes to the submodule
#
#`git push --recurse-submodules=check`
#`cd theme && git push` OR `git push --recurse-submodules=on-demand`

# Git Submodule workflow
#
# to pull in updates from the Submodule Remote Repo
#`git submodule update --remote`

# Deploy site & Setup GitHub Pages Enterprise directory structure
#
#`git checkout -b gh-pages` --> branch that GitHub clones site from
#
#build step --> building static web content files
#
# This allows us to source the filesystem in the main superproject when in the remote
# repo. The magic is all in the build commands below AND the index.Rmd YAML!
# (multiple stylesheet paths) 
library(magrittr)
index_nodeset <- xml2::read_html(x = 'index.html')
link_nodeset <- index_nodeset %>% rvest::html_nodes('head link')
list(link_nodeset, link_nodeset %>% xml2::xml_attr(attr = "href") %>% sub(pattern = "theme/", replacement = "dist/"))  %>% 
  purrr::pwalk(xml2::xml_set_attr, attr = "href")
xml2::write_html(x = index_nodeset, file = "index.html")
file.copy(from = 'theme/src', 'dist', recursive = T)
file.copy(from = 'theme/usr', 'dist', recursive = T)
#
#`git rm .gitmodules` --> remove "gitlink" from branch, this will break link to submodule 
#   HEAD of remote repo 
#`git commit -am "Build webpage files & Remove .gitmodules file - break gitlink"`
#`git push --all` --> deploy site (pushing both branches)
#`git revert HEAD` --> Revert gh-pages branch to previous commit
#   now you can checkout master & merge future changes into gh-pages with no conflict
#   YAY!

#Unfortunately, we cannot set the `extra_dependencies` argument in xaringan because
#it utilizes the arguments of BOTH rmarkdown::html_document() & html_document_base()
#which BOTH contain `extra_dependencies`, so we get a 
#"matched by multiple actual arguments" error
#xaringan::moon_reader()rmarkdown::html_document()rmarkdown::html_document_base()

# Making updates to the theme should be done DIRECTLY to the theme directory 
# i.e. the git submodule
