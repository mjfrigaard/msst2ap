
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `msst2ap`

<!-- badges: start -->
<!-- badges: end -->

The goal of `msst2ap` (Mastering shiny `testServer()` app-package) is to
demonstrate how to test a shiny application package using
[`testthat`](https://testthat.r-lib.org/) and
[`shiny::testServer()`](https://search.r-project.org/CRAN/refmans/shiny/html/testServer.html)

## Installation

You don’t *have* to install the `msst2ap` package, but you might want to
download it as an example (or read through [this
post](https://mjfrigaard.github.io/posts/test-shiny-p3/) to learn about
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

    #> tests/testthat/
    #> ├── test-datasetServer.R
    #> ├── test-selectDataVarApp.R
    #> ├── test-selectDataVarServer.R
    #> └── test-selectVarServer.R

``` default
🐝 Your tests are the bee's knees 🐝
```
