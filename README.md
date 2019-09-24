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

- `git clone git@esgovcloud.com:mAndA/mod-mAndA-template.git`

## Setup

Initially, a few manual maintenance commands need to be run.

### Adding New Remote

To make this a repo for the new presentation page:

- `git remote remove origin`
- `git remote add origin git@url` (git@url of NEW project)


### Break gitlink in gh-pages branch

A git submodule needs a "gitlink" to work correctly.

However, to perform the build procedure for these slides, the gitlink must be broken in the `gh-pages` branch so that the GitHub Pages build procedure cannot access the theme repository. When the gitlink is available, GitHub Pages is unable to clone it during the build process because the theme repository is a private repo (if it was public, it WOULD be able to clone it). Thus, we copy files to a distribution directory in our build step to handle this. All that's left to do is to break the gitlink.

To break the gitlink:

- `git checkout gh-pages`
- `git rm .gitmodules`
- `git commit -m "Remove gitlink to theme submodule"`

## Building, Deploying, exporting PDFs

The [`Makefile`](Makefile) in this repo does the magic here. Because there are repetitive tasks required to build, deploy, save, test, and export the slides, we can use [GNU make](https://www.gnu.org/software/make/manual/make.html) to perform these reproducible procedures.

Knit Xaringan slides:

- `make` OR `make all`

Export Slides to PDF:

- `make pdf`

Build slides, Deploy site, and Cleanup gh-pages branch in 1 shot:

- `make cleandist`
