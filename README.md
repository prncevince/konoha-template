# Template for the Modernizing the M&A Workflow Series
The [Xaringan](https://github.com/yihui/xaringan) slide show template for the Modernizing the M&A Workflow series ("mod-mAndA").

## Description
This repo contains:

- A basic R Markdown file to create the [Xaringan](https://github.com/yihui/xaringan) static content website presentation
- A build script for creating the directory schema for hosting static content on GitHub Pages
- A Makefile to perform misc build tasks
    - Setting up GitHub Pages directories, PDF exports, cleaning GitHub Pages branch
- The Xaringan ["theme"](https://github.com/yihui/xaringan/wiki/Themes) for the mod-mAndA series as a [git submodule](https://git-scm.com/docs/gitsubmodules)
    - CSS & webfonts for styling & creating the Slides
    - The remark.js library (i.e. the ["chakra"](https://cran.r-project.org/web/packages/xaringan/xaringan.pdf#Rfn.moon.Rul.reader.1))
- All other static content that makes up the Xaringan html slides
    - JavaScript libraries
    - A [deck.css file](assets/css/deck.css) that is specific to the slide deck (i.e. not the theme)
    - Images

The repo for the theme is located at [mAndA/mod-mAndA-theme](https://esgovcloud.com/mAndA/mod-mAndA-theme). To navigate to the specific commit that a presentation is using as it's theme, simply click on the "theme" directory in the repository and the link will navigate you to it.

## Getting Started

To get started working on a new presentation:

- `git clone --recursive git@esgovcloud.com:mAndA/mod-mAndA-template.git`

## Setup

Initially, a few manual maintenance commands need to be run.

### Checkout theme's `master` branch

The git clone command clone's the theme submodule at the HEAD position. We need to checkout the master (making sure to `cd` back to the superproject's main directory for the next step).

- `cd theme && git checkout master && cd ..`

### Adding New Remote

To make this a repo for the new presentation page:

- `git remote remove origin`
- `git remote add origin git@url` (git@url of NEW project)

### Break gitlink in gh-pages branch

A git submodule needs a "gitlink" to work correctly.

However, to perform the build procedure for these slides, the gitlink must be broken in the `gh-pages` branch so that the GitHub Pages build procedure cannot access the theme repository. When the gitlink is available, GitHub Pages is unable to clone it during the build process because the theme repository is a private repo (if it was public, it WOULD be able to clone it). Thus, we copy files to a distribution directory in our build step to handle this. All that's left to do is to break the gitlink.

To break the gitlink:

- `git checkout -b gh-pages`
- `git rm .gitmodules`
- `git commit -m "Remove gitlink to theme submodule"`
- `git checkout master`

### Set Upstream branch

This will allow us to use the `make` commands below for pushing initially.
Once you've made the initially changes that you want to the project, go ahead and:

- `git push -u origin master`


## Xaringan Knitting

Xaringan Slides are built into a static website using R Markdown. We name our R Markdown file [index.Rmd](index.Rmd) so that the GitHub Pages Jekyll build engine recognizes it as the index to our site.

Knitting the slides is as simple as:

- `rmarkdown::render('index.Rmd', 'xaringan::moon_reader')`

**OR** to perform continual development on the slides, the Xaringan package provides an RStudio addin that serves them locally & refreshes the page on saved changes using:

- `xaringan::inf_mr()`

## Building, Deploying, & exporting PDFs

The [`Makefile`](Makefile) in this repo does the magic here. Because there are repetitive tasks required to build, deploy, save, test, and export the slides, we can use [GNU make](https://www.gnu.org/software/make/manual/make.html) to perform these reproducible procedures.

Knit Xaringan slides:

- `make` OR `make knit`

Export Slides to PDF:

- `make pdf`

Build slides, Deploy site, and Cleanup gh-pages branch in 1 shot:

- `make pages`

Knit Xaringan slides **& then** `make pages` step above:

- `make all`

## Theme Submodule Workflow

The theme's repository:
    
- https://esgovcloud.com/mAndA/mod-mAndA-theme

The theme is a [git submodule](https://git-scm.com/docs/gitsubmodules). The benefit of this is that it allows us to continually develop the theme throughout the creation of the series. A submodule is simply a repository inside a main super project/repository.

Thus, when `cd`'d into the local git submodule directory, all git commands only apply to the submodule.
Thus, commands such as `git push` & `git pull` made to pull-in new changes from the remote to the local and make updates to the remote from the local are perfectly fine to make.

When NOT `cd`'d into the git submodule directory (i.e. outside the submodule directory & still inside the main project directory), git commands are performed differently.

Pulling in updates can be made via:

- `git submodule foreach git pull`

Pushing the current branch AND the submodule (submodule 1st):

- `git push --recurse-submodules=on-demand`

Pushing the current branch ONLY IF the submodule has already been pushed before it (i.e. there are no changes to push upstream):

- `git push --recurse-submodules=check`
