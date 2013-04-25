Samatha
=======

#### Copyright David Sprigate 2013 ([CC BY 3.0](creativecommons.org/licenses/by/3.0))

Samatha is a package for rendering HTML in R. It is based on the [Hiccup](http://github.com/weavejester/hiccup) library for [Clojure](clojure.org).

Samatha can render html and generic xml to R strings.  The functions are designed to be nested inside one another.

## Install

Samatha is not currently in a state to be built with devtools


```r
load_all(".")
```

```
## Loading samatha
```


## Documentation

Documentation is not yet available but will be on daspringate.github.com

## Syntax

The central function is html:


```r
# The first argument is the html tag:
html("p")
```

```
## [1] "<p  />"
```

```r
# Any strings after that are concatenated to be the content of the tag:
html("p", "This is a Sentence.", " So is this")
```

```
## [1] "<p>This is a Sentence. So is this</p>"
```

```r
# The opts argument defines html tag attributes
html("span", "bar", opts = list(class = "foo"))
```

```
## [1] "<span class=\"foo\">bar</span>"
```

```r
html("span", opts = list(id = "foo", class = "bar"), "baz")
```

```
## [1] "<span id=\"foo\" class=\"bar\">baz</span>"
```

```r
# Tags can be nested inside of tags and everything ends up concatenated
html("p", "Goodbye", html("strong", "cruel"), "world")
```

```
## [1] "<p>Goodbye<strong>cruel</strong>world</p>"
```

```r
# There are CSS-style shortcuts for setting ID and class
html("p#my-p", html("span.pretty", "hey"))
```

```
## [1] "<p id=\"my-p\"><span class=\"pretty\">hey</span></p>"
```

```r
# You can escape a tag using the (escape-html) function
html("p", html("script", "Do something evil", escape.html.p = TRUE))
```

```
## [1] "<p>&lt;script&gt;Do something evil&lt;/script&gt;</p>"
```


There are also wrappers to generate a range of common html elements...


```r
javascript.tag("Some javascript")  # To wrap the script string in script tags and a CDATA section
```

```
## [1] "<script>//<![CDATA[\nSome javascript\n//]]></script>"
```

```r
link.to("www.google.com", "Google")  # To wrap content in an HTML hyperlink with the supplied URL
```

```
## [1] "<a href=\"www.google.com\">Google</a>"
```

```r
# To wrap content in html hyperlink with the supplied email address.  If
# no content provided the email address is supplied as content:
mail.to("me@me.com")
```

```
## [1] "<a href=\"mailto:me@me.com\">me@me.com</a>"
```

```r
mail.to("me@me.com", "email me")
```

```
## [1] "<a href=\"mailto:me@me.com\">email me</a>"
```

```r
mail.to("me@me.com", "email me", subject = "you are great")
```

```
## [1] "<a href=\"mailto:me@me.com?Subject=you%20are%20great\">email me</a>"
```

```r
# To wrap a list of strings into an unordered list:
elements = list("apples", "oranges", "bananas")
unordered.list(elements)
```

```
## [1] "<ul><li>apples</li><li>oranges</li><li>bananas</li></ul>"
```

```r
ordered.list(elements)  # Ordered list
```

```
## [1] "<ol><li>apples</li><li>oranges</li><li>bananas</li></ol>"
```

```r
image.link("www.beautifulthings.com/12538675", opts = list(alt = "A lovely picture of something"))  # link to an image
```

```
## [1] "<img  src=\"www.beautifulthings.com/12538675\" alt=\"A lovely picture of something\" />"
```


... and functions to include css and js...


```r
include.css(c("mysheeet.css", "sheet2.css", "sheet3.css"))
```

```
## [1] "<link  type=\"text/css\" href=\"mysheeet.css\" rel=\"stylesheet\" />\n<link  type=\"text/css\" href=\"sheet2.css\" rel=\"stylesheet\" />\n<link  type=\"text/css\" href=\"sheet3.css\" rel=\"stylesheet\" />"
```

```r
include.js(c("script1.js", "script2.js", "script3.js"))
```

```
## [1] "<script  type=\"text/javascript\" src=\"script1.js\" />\n<script  type=\"text/javascript\" src=\"script2.js\" />\n<script  type=\"text/javascript\" src=\"script3.js\" />"
```


Still to be implemented:

* Functions for form elements
* Doctype boilerplate






