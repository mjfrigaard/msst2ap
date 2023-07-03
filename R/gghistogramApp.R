#' ggplot2 Histogram App
#'
#'
#' @description
#' This module function has been adapted from the [Case study: histogram](https://mastering-shiny.org/scaling-modules.html#case-study-histogram) section of Mastering Shiny.
#'
#' @section Histogram App:
#' The `gghistogramApp()` is built using the `pkgDatasetInput()`/`pkgDatasetServer()`,
#' `selectVarInput()`/`selectVarServer()` and `histogramOutput()`/`gghistogramServer()`
#'  modules.
#'
#' @param pkg packages listing `data.frame`s
#' @return shiny app
#'
#'
#' @export ggHistogramApp
#'
#' @importFrom shiny fluidPage sidebarLayout sidebarPanel
#' @importFrom shiny mainPanel
#'
#' @examples
#' ggHistogramApp(pkg = c("dplyr", "palmerpenguins"))
ggHistogramApp <- function(pkg = NULL) {
  ui <- shiny::fluidPage(
    shiny::sidebarLayout(
      shiny::sidebarPanel(

        pkgDatasetInput(id = "pkgDataset", pkg = pkg),

        selectVarInput(id = "selectVar"),

        shiny::verbatimTextOutput("vals")

      ),
      shiny::mainPanel(

        histogramOutput(id = "gghistogram")

      )
    )
  )

  server <- function(input, output, session) {

    data <- pkgDatasetServer(id = "pkgDataset")

    x <- selectVarServer(id = "selectVar", data)

    gghistogramServer(id = "gghistogram", x = x)

    output$vals <- shiny::renderPrint({
      vals <- shiny::reactiveValuesToList(input, all.names = TRUE)
      print(vals)
    })

  }
  shiny::shinyApp(ui, server)
}
