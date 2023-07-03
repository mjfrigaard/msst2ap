
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `msst2ap`

<!-- badges: start -->
<!-- badges: end -->

The goal of `msst2ap` (**M**astering **s**hiny **s**hiny**t**est**2**
**a**pp-**p**ackage) is to demonstrate how to test a shiny app-package
using [`testthat`](https://testthat.r-lib.org/) and
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

The `find_vars()` function comes from [Mastering
Shiny](https://mastering-shiny.org/scaling-modules.html#server-inputs),
and it’s used for filtering variables from a `data.frame`/`tibble` by
type:

``` r
find_vars(data = airquality, filter = is.numeric)
#> [1] "Ozone"   "Solar.R" "Wind"    "Temp"    "Month"   "Day"
```

    #> tests/testthat/
    #> ├── test-utils_find_vars.R
    #> └── test-utils_pkg_dfs.R

``` r
testthat::test_file("tests/testthat/test-utils_find_vars.R")
```

``` default
#> [ FAIL 0 | WARN 0 | SKIP 0 | PASS 4 ]
```

## Package datasets

I’ve added some additional unit tests for the utility functions in the
`ggHistogramApp()`

## `pkg_inst_check()`

`pkg_inst_check` will check if a package is installed, and if not,
install it.

``` r
if ("emoji" %in% loadedNamespaces()) {
  # remove from ns
  remove.packages("emoji")
} else {
  # with single pkg
  pkg_inst_check("emoji")
}
#> Loading required package: emoji
```

``` r
if (any(c("palmerpenguins", "snakecase") %nin% loadedNamespaces())) {
    # with multiple pkgs
    pkgs <- c("palmerpenguins", "snakecase")
    pkg_inst_check(pkgs)
}
#> Loading required package: palmerpenguins
#> Loading required package: snakecase
```

## `find_pkg_df_nms()`

The `find_pkg_df_nms()` function will return a named vector of
`data.frame`s/`tibble`s in a package.

It works with base packages:

``` r
pkg_inst_check("forcats")
find_pkg_df_nms(pkg = "forcats")
#>   gss_cat 
#> "gss_cat"
```

And add-on packages:

``` r
find_pkg_df_nms(pkg = "datasets")
#>         airquality           anscombe             attenu           attitude 
#>       "airquality"         "anscombe"           "attenu"         "attitude" 
#>            beaver1            beaver2                BOD               cars 
#>          "beaver1"          "beaver2"              "BOD"             "cars" 
#>        ChickWeight           chickwts                CO2              DNase 
#>      "ChickWeight"         "chickwts"              "CO2"            "DNase" 
#>              esoph           faithful       Formaldehyde             freeny 
#>            "esoph"         "faithful"     "Formaldehyde"           "freeny" 
#>           Indometh             infert       InsectSprays               iris 
#>         "Indometh"           "infert"     "InsectSprays"             "iris" 
#>   LifeCycleSavings           Loblolly            longley             morley 
#> "LifeCycleSavings"         "Loblolly"          "longley"           "morley" 
#>             mtcars                npk             Orange      OrchardSprays 
#>           "mtcars"              "npk"           "Orange"    "OrchardSprays" 
#>        PlantGrowth           pressure          Puromycin             quakes 
#>      "PlantGrowth"         "pressure"        "Puromycin"           "quakes" 
#>              randu               rock              sleep          stackloss 
#>            "randu"             "rock"            "sleep"        "stackloss" 
#>              swiss             Theoph        ToothGrowth              trees 
#>            "swiss"           "Theoph"      "ToothGrowth"            "trees" 
#>          USArrests     USJudgeRatings         warpbreaks              women 
#>        "USArrests"   "USJudgeRatings"       "warpbreaks"            "women"
```

If there are no `data.frame`s/`tibble`s, it returns nothing.

``` r
find_pkg_df_nms(pkg = "utils")
find_pkg_df_nms(pkg = "stats")
```

## `pkg_df_check()`

`pkg_df_check()` is a helper function that returns a `TRUE`/`FALSE` if
the package contains at least one `data.frame`/`tibble`:

``` r
pkg_df_check("datasets")
#> [1] TRUE
pkg_df_check("stringr")
#> [1] FALSE
```

## `find_df_pkgs()`

`find_df_pkgs()` is the real workhorse of the `msst2ap` package–it
returns the installed packages with `data.frame`s/`tibble`s:

``` r
find_df_pkgs()
#>          forcats   palmerpenguins            emoji         datasets 
#>        "forcats" "palmerpenguins"          "emoji"       "datasets"
```

## `get_pkg_df()`

`get_pkg_df()` is similar to `get()`, but has a slightly more intuitive
API (i.e., only needs the `pkg` and `df`)

``` r
get_pkg_df(df = "starwars", pkg = "dplyr")
#> # A tibble: 87 × 14
#>    name     height  mass hair_color skin_color eye_color birth_year sex   gender
#>    <chr>     <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
#>  1 Luke Sk…    172    77 blond      fair       blue            19   male  mascu…
#>  2 C-3PO       167    75 <NA>       gold       yellow         112   none  mascu…
#>  3 R2-D2        96    32 <NA>       white, bl… red             33   none  mascu…
#>  4 Darth V…    202   136 none       white      yellow          41.9 male  mascu…
#>  5 Leia Or…    150    49 brown      light      brown           19   fema… femin…
#>  6 Owen La…    178   120 brown, gr… light      blue            52   male  mascu…
#>  7 Beru Wh…    165    75 brown      light      blue            47   fema… femin…
#>  8 R5-D4        97    32 <NA>       white, red red             NA   none  mascu…
#>  9 Biggs D…    183    84 black      light      brown           24   male  mascu…
#> 10 Obi-Wan…    182    77 auburn, w… fair       blue-gray       57   male  mascu…
#> # ℹ 77 more rows
#> # ℹ 5 more variables: homeworld <chr>, species <chr>, films <list>,
#> #   vehicles <list>, starships <list>
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
