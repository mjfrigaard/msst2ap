#' ggplot2 Histogram App
#'
#'
#' @description
#' This module function has been adapted from the [Case study: histogram](https://mastering-shiny.org/scaling-modules.html#case-study-histogram) section of Mastering Shiny.
#'
#' @section Histogram App:
#' The `gghistogramApp()` is built using the `pkgDataInput()`/`pkgDataServer()`,
#' `selectVarInput()`/`selectVarServer()` and `histogramOutput()`/`gghistServer()`
#'  modules.
#'
#' @param pkg packages listing `data.frame`s
#' @return shiny app
#'
#'
#' @export gghistApp
#'
#' @importFrom shiny fluidPage sidebarLayout sidebarPanel
#' @importFrom shiny mainPanel
#'
#' @examples
#' gghistApp(pkg = c("dplyr", "palmerpenguins"))
gghistApp <- function(pkg = NULL) {

  if (!is.null(pkg)) {
      pkg_inst_check(pkg)
  }

  ui <- shiny::fluidPage(
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        pkgDataInput(id = "pkg", pkg = pkg),
        selectVarInput(id = "var")
      ),

      shiny::mainPanel(
        histogramOutput(id = "hist"),

        shiny::verbatimTextOutput("vals")

      )
    )
  )

  server <- function(input, output, session) {
    data <- pkgDataServer(id = "pkg")
    x <- selectVarServer(id = "var", data)
    gghistServer(id = "hist", x = x)

    output$vals <- shiny::renderPrint({
      vals <- shiny::reactiveValuesToList(input, all.names = TRUE)
      print(vals)
    })

  }
  shiny::shinyApp(ui, server)
}
