# Template for the Modernizing the M&A Workflow Series
The [Xaringan](https://github.com/yihui/xaringan) slide show template for the Modernizing the M&A Workflow series ("mod-mAndA"). 

## Description
This contains a base R Markdown file to create the [Xaringan](https://github.com/yihui/xaringan) static content website presentation, a build script, and all other static content (images & JavaScript library specific R Markdown Xaringan extension libraries). 

In addition, this template contains a [git submodule](https://git-scm.com/docs/gitsubmodules), which contains the [Xaringan theme](https://github.com/yihui/xaringan/wiki/Themes) for the mod-mAndA series, which can be found at [mAndA/mod-mAndA-theme](https://esgovcloud.com/mAndA/mod-mAndA-theme).

## Getting Started

To get started working on a presentation:

`git clone --recursive --single-branch -b master git@url`

## Building & Deploying Presentations

Please see [build.R](build.R) since working with submodules is not trivial.

The build.R file goes over how to perform the proper git commands to make creating the presentation / working on the theme easier.
