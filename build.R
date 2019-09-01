# Cloning & Building Presentation ####
#
#Choose 1 of 2, depending on your setup:
#
#(1) starting from scratch: #### 
#`git clone --recursive --single-branch -b master git@esgovcloud.com:mAndA/mod-mAndA-template.git`
#`git remote remove origin`
#`git remote add origin git@url` (git@url of NEW project)
#`cd theme && git checkout master`
#
#(2) collaborating on a pre-existing repo/presentation: ####
#
#`git clone --recursive`
#`cd theme && git checkout master`
#
#building presentation ####
#make changes
#xaringan::inf_mr() 
#OR
#rmarkdown::render('index.Rmd', 'xaringan::moon_reader')
#
#add & commit changes ####
#
#`git push -u origin master`
#
#after making changes to the submodule:
#
#`git push --recurse-submodules=check`
#`cd theme && git push` THEN `cd .. && git push` 
#OR 
#`git push --recurse-submodules=on-demand`

#### _ ####
# Git Submodule workflow ####
#
#to pull in updates from the Submodule Remote Repo:
#`git submodule update --remote`


#### _ ####
# Deploy site & Setup GitHub Pages Enterprise directory structure ####
#
#after you've pushed the master branch: ####
#
# Again, choose 1 of 2: 
#
#(1) starting from scratch: 
#`git checkout -b gh-pages` --> the branch that GitHub Pages will clone your 
# repo from to build & publish your website 
# It uses Jekyll to build your site
#
#(2) collaborating on a pre-existing repo/presentation:
#`git checkout gh-pages`
#`git merge master`
#
#build step --> building static web content files ####
#
# This allows us to source the filesystem in the main superproject when in the 
# remote repo. The magic is all in the build commands below AND in the 
# index.Rmd YAML! 
# Here, we break the git submodule & copy the theme into a `dist` directory.
# Before this, we change the html <link> elements (using R) to avoid conflicts.
library(magrittr)
index_nodeset <- xml2::read_html(x = 'index.html')
link_nodeset <- index_nodeset %>% rvest::html_nodes('head link')
list(link_nodeset, link_nodeset %>% xml2::xml_attr(attr = "href") %>% 
  sub(pattern = "theme/", replacement = "dist/"))  %>% 
  purrr::pwalk(xml2::xml_set_attr, attr = "href")
xml2::write_html(x = index_nodeset, file = "index.html")
file.copy(from = 'theme/src', 'dist', recursive = T)
file.copy(from = 'theme/usr', 'dist', recursive = T)
#
# Again, choose 1 of 2:
#
#(1) starting from scratch: 
#git add .
#`git rm .gitmodules` --> remove "gitlink" from branch
# this will break link to submodule HEAD of remote repo 
#`git commit -am "Build webpage files & Remove .gitmodules file - break gitlink"`
#`git push --all` --> deploy site (pushing both branches)
#`git revert HEAD` --> Revert gh-pages branch to previous commit
# allows you to checkout master & merge future changes into gh-pages with no conflict
#   YAY!
#(2) collaborating on a pre-existing repo/presentation:
#git add .
#`git commit -am "Build webpage files"`
#`git push --all` --> deploy site (pushing both branches)
#`git revert HEAD` --> Revert gh-pages branch to previous commit
# allows you to checkout master & merge future changes into gh-pages with no conflict

#### _ ####
# Comments ####
#
#Unfortunately, we cannot set the `extra_dependencies` argument in xaringan because
#it utilizes the arguments of BOTH rmarkdown::html_document() & html_document_base()
#which BOTH contain `extra_dependencies`, so we get a 
#"matched by multiple actual arguments" error
#xaringan::moon_reader()rmarkdown::html_document()rmarkdown::html_document_base()
#
# Making updates to the theme should be done DIRECTLY to the theme directory 
# i.e. the git submodule
