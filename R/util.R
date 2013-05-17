#' Extracts the tag names from a markdown post file
#' tags should be the first line of the file and preceeded with the percent sign
#' tags are delimited by spaces, commas or semicolons
#' @name extract.tags
extract.tags <- function(md.file){
    tags <- readLines(md.file, n = 1)
    if(str_detect(tags, "^%")){
        tags <- str_split(tags, "[[:space:],;%]+")[[1]]
        tags[sapply(tags, nchar) > 0]
    } else NULL
}

#' reads a markdown post file and extracts the title
#' Title is taken as the first line in which the line underneath is a double underline
#' i.e. a h1 tag in markdown
#' n.b. the title must be in this format, not e.g. # This is a title
#' @name extract.title
extract.title <- function(md.file){
    f <- readChar(md.file, n = file.info(md.file)$size)
    str_match(f, "(\n)([^\n.]+)(\n={3,})")[3]
}

#' returns the path to the post in the site
#' @name get.postpath
#' @export
get.postpath <- function(post){
    postnames <- str_match(post, pattern = "([[:digit:]]{4}_[[:digit:]]{2}_[[:digit:]]{2})_(.*)")
    month.dir <- file.path("/posts", 
                           str_replace(str_extract(postnames[2], 
                                                   "[[:digit:]]{4}_[[:digit:]]{2}"), 
                                       "_", "/"))
    file.path(month.dir, 
              str_replace(postnames[3], "\\.md", "\\.html"))
}

#' builds a list of links to all blog posts
#' @name html.postlist
html.postlist <- function(site){
    postlist <- list.files(file.path(site, "template/posts"))
    postlist <- postlist[str_detect(postlist, "\\.md")]
    posttitles <- lapply(postlist, function(x) extract.title(file.path(site, "template/posts",x)))
    postpaths <- lapply(postlist, get.postpath)
    if(!is.null(postlist)){
        postlinks <- lapply(1:length(postlist),
                            function(x) link.to(url = postpaths[[x]],
                                                sprintf("%s", posttitles[[x]])))
        unordered.list(postlinks)
    }
} 

#' renders the contents of a markdown file as an html character vector
#' A wrapper around markdown::markdownToHTML
#' @name include.markdown
include.markdown <- function(md.file){
    markdownToHTML(file=md.file, fragment.only = TRUE)
}

#' renders the contents of a markdown file as an html character vector
#' A wrapper around readChar
#' @name include.textfile
include.textfile <- function(text.file){
    readChar(text.file, nchars = file.info(text.file)$size)
}



