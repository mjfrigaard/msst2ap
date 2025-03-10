
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Mastering Shiny Shiny Test 2 App Package (`msst2ap`)

<!-- badges: start -->

<!-- badges: end -->

The goal of `msst2ap` is to demonstrate how to test a shiny app-package
using [`testthat`](https://testthat.r-lib.org/) and
[`shinytest2`](https://rstudio.github.io/shinytest2/)

All examples come from the [Modules chapter of Mastering
Shiny.](https://mastering-shiny.org/scaling-modules.html)

## Installation

You can install `msst2ap` from GitHub using the code below:

``` r
remotes::install_github("mjfrigaard/msst2ap",
  force = TRUE, quiet = TRUE
)
```

``` r
library(msst2ap)
#> Loading required package: shiny
```

## Set up

There are specific instructions for setting up `shinytest2` in the
[`shinytest2-setup.Rmd`
vignette](https://github.com/mjfrigaard/msst2ap/blob/main/vignettes/shinytest2-setup.Rmd).

## Utility function/`testServer()` tests

Tests for the utility functions are in [`unit-tests.Rmd`
vignette](https://github.com/mjfrigaard/msst2ap/blob/main/vignettes/unit-tests.Rmd).
Test for the module server functions and standalone app functions are in
the [`testserver-tests.Rmd`
vignette](https://github.com/mjfrigaard/msst2ap/blob/main/vignettes/testserver-tests.Rmd).

## `shinytest2` tests

The output from `devtools::test()` is below:

``` default
==> devtools::test()

ℹ Testing msst2ap
✔ | F W  S  OK | Context
✔ |          1 | shinytest2-datasetApp [4.8s]                                                   
⠼ |          5 | shinytest2-gghistApp       
⠋ |         11 | shinytest2-gghistApp                                   
⠙ |         12 | shinytest2-gghistApp                       
✔ |         13 | shinytest2-gghistApp [5.1s]                                
✔ |          5 | shinytest2-histogramApp [3.6s]                                                 
✔ |          2 | shinytest2-selectVarApp [2.2s]                                                 
✔ |          1 | shinytest2 [4.2s]                                                              

══ Results ══════════════════════════════════════════════════════════════════
Duration: 19.9 s

[ FAIL 0 | WARN 0 | SKIP 0 | PASS 22 ]

🔥 Your tests are lit 🔥
```

### Known issue

The following warning is given when running `shinytest2` tests in an app
package:

``` default
Warning message:
In shiny::loadSupport(app_dir, renv = renv, globalrenv = globalrenv) :
  Loading R/ subdirectory for Shiny application, but this directory appears to 
contain an R package. Sourcing files in R/ may cause unexpected behavior.
```

Don’t worry–there is an [open issue on
GitHub](https://github.com/rstudio/shinytest2/issues/264) for this!
