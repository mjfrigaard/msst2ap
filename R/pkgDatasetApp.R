#' Package Dataset App
#'
#'
#' @description
#' This standalone app function has been adapted from the [Getting started: UI input + server output](https://mastering-shiny.org/scaling-modules.html#getting-started-ui-input-server-output) section of Mastering Shiny.
#'
#' @section Packages:
#' This application includes an argument for entering the packages to display in
#' the `selectInput()` in the UI.
#'
#' @section reactive values:
#' The `renderPrint()` output contains the output from `shiny::reactiveValuesToList()`
#' and contains the`inputId`s for the modules in the application.
#'
#' @return shiny application
#' @export pkgdatasetApp
#'
#' @importFrom shiny tableOutput renderTable shinyApp
#' @importFrom shiny reactiveValuesToList renderPrint verbatimTextOutput
#' @importFrom dplyr select where
pkgdatasetApp <- function(pkg = NULL) {

  ui <- shiny::fluidPage(

    pkgDatasetInput(id = "dataset", pkg = pkg),

    shiny::tableOutput("data"),

    shiny::verbatimTextOutput("vals")


  )

  server <- function(input, output, session) {

    data <- pkgDatasetServer("dataset")

    output$data <- shiny::renderTable(

      # head(data())

      head(
        dplyr::select(data(),
          !dplyr::where(is.list))
        )
      )

    output$vals <- shiny::renderPrint({
      x <- shiny::reactiveValuesToList(input,
                              all.names = TRUE)
      print(x, width = 30, max.levels = NULL)
    }, width = 30)

  }

  shiny::shinyApp(ui, server)

}
