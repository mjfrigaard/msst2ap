
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `msst2ap`

<!-- badges: start -->
<!-- badges: end -->

The goal of `msst2ap` (Mastering shiny `shinytest2` app-package) is to
demonstrate how to test a shiny application package using
[`testthat`](https://testthat.r-lib.org/) and
[`shinytest2`](https://rstudio.github.io/shinytest2/)

## Installation

You don’t *have* to install the `msst2ap` package, but you might want to
download it as an example (or read through [this
post](https://mjfrigaard.github.io/posts/test-shiny-p4/) to learn about
it’s contents).

``` r
library(msst2ap)
```

## Utility function tests

There is a single utility function in `msst2ap`: `find_vars()`

    #> tests/testthat/
    #> └── test-find_vars.R

``` r
testthat::test_file("tests/testthat/test-find_vars.R")
```

``` default
#> [ FAIL 0 | WARN 0 | SKIP 0 | PASS 4 ]
```

## `testServer()` tests

The unit tests using `shiny`’s `testServer()` function are below.

### Module server function tests

These modules come from the [Modules chapter of Mastering
Shiny.](https://mastering-shiny.org/scaling-modules.html)

    #> tests/testthat/
    #> ├── test-datasetServer.R
    #> ├── test-selectDataVarServer.R
    #> └── test-selectVarServer.R

``` default
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 1 ]
       datasetServer: dataset$input is NULL 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 2 ]
       datasetServer: dataset$input 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 3 ]
       datasetServer: class(session$returned()) 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 4 ]
       datasetServer: is.matrix(session$returned()) 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 5 ]
       datasetServer: typeof(session$returned()) 
```

``` default
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 1 ]
       selectVarServer: is.reactive(data()) 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 2 ]
       selectVarServer: find_vars() 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 3 ]
       selectVarServer: input$var 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 4 ]
       selectVarServer: session$returned()
```

``` default
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 1 ]
       selectDataVarServer: is.reactive(data) 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 2 ]
       selectDataVarServer: is.reactive(var) 
```

### Standalone app function tests

These apps come from the [Modules chapter of Mastering
Shiny.](https://mastering-shiny.org/scaling-modules.html)

    #> tests/testthat/
    #> ├── test-datasetApp.R
    #> ├── test-selectDataVarApp.R
    #> └── test-selectVarApp.R

``` default
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 1 ]
       datasetApp: input$`dataset-dataset` 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 2 ]
       datasetApp: is.data.frame(data()) 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 3 ]
       datasetApp: names(data()) 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 4 ]
       datasetApp: class(output$data) 
```

``` default
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 1 ]
       selectVarApp: is.reactive(var) 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 2 ]
       selectVarApp: input$`var-var` 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 3 ]
       selectVarApp: is.reactive(data) 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 4 ]
       selectVarApp: is.data.frame(data()) 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 5 ]
       selectVarApp: data()[[input$`var-var`]] 
```

``` default
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 1 ]
       selectDataVarApp: input$`var-var-var` 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 2 ]
       selectDataVarApp: input$`var-data-dataset` 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 3 ]
       selectDataVarApp: is.reactive(var) 
```

``` default
🐝 Your tests are the bee's knees 🐝
```
