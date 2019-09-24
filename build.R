#build step --> building static web content files ####
#
# This allows us to source the filesystem in the main superproject when in the 
# remote repo. The magic is all in the build commands below AND in the 
# index.Rmd YAML! 
# The prereqs break the gitlink to the git submodule.
# Here, we copy the theme into a `dist` directory.
# Before this, we change the html <link> & <script> elements (using R) to soure `dist`.

library(magrittr)
index_nodeset <- xml2::read_html(x = 'index.html')
css_nodeset <- index_nodeset %>% rvest::html_nodes('head link')
list(css_nodeset, css_nodeset %>% xml2::xml_attr(attr = "href") %>% 
       sub(pattern = "theme/", replacement = "dist/"))  %>% 
  purrr::pwalk(xml2::xml_set_attr, attr = "href")
js_nodeset <- index_nodeset %>% rvest::html_nodes('body script') %>% `[`(1)
list(js_nodeset, js_nodeset %>% xml2::xml_attr(attr = "src") %>% 
       sub(pattern = "theme/", replacement = "dist/"))  %>% 
  purrr::pwalk(xml2::xml_set_attr, attr = "src")
xml2::write_html(x = index_nodeset, file = "index.html")
file.copy(from = 'theme/src', 'dist', recursive = T)
file.copy(from = 'theme/usr', 'dist', recursive = T)

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
