# Starting from scratch & Build
#
#`git clone --recursive --single-branch -b master git@url`
#`git remote remove origin`
#`git remote add origin git@url`
#`cd theme && git checkout master`
#`mv n-repo-name.Rproj new-name.Rproj`
#make changes
xaringan::inf_mr()
#add & commit changes
#`git push -u origin master`

# Building static web content files
#
# This allows us to source the filesystem in the main superproject when in the remote
# repo. The magic is all in build command below AND the index.Rmd YALM!
# (multiple stylesheet paths) 
fs::dir_copy(path = 'theme/src', 'dist/src')
fs::dir_copy(path = 'theme/usr', 'dist/usr')
xaringan::moon_reader()
#`git push --recurse-submodules=check`
#`cd theme && git push` OR `git push --recursive-submodules=on-demand`

# Git Submodule workflow
#
# to pull in updates from the Submodule Remote Repo
#`git submodule update --remote`

# Deploy site & Setup GitHub Pages Enterprise directory structure
#
#`git checkout -b gh-pages` --> branch that GitHub clones site from
#`git rm .gitmodules` --> remove "gitlink" from branch, this will break link to submodule 
#   HEAD of remote repo 
#`git commit -m "Remove .gitmodules file - break gitlink"`
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
