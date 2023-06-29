#' Histogram UI module
#'
#' @description
#' This module function comes from the [Case study: histogram](https://mastering-shiny.org/scaling-modules.html#case-study-histogram) section of Mastering Shiny.
#'
#' @param id shiny module ui id
#'
#' @return shiny ui module
#' @export histogramOutput
#'
#' @importFrom shiny tagList numericInput NS plotOutput
histogramOutput <- function(id) {
  shiny::tagList(
    shiny::numericInput(
      shiny::NS(id, "bins"), "bins", 10, min = 1, step = 1),
    shiny::plotOutput(
      shiny::NS(id, "hist")),
    shiny::verbatimTextOutput(
      shiny::NS(id, "vals")
    )
  )
}
