#' Histogram server module (ggplot2)
#'
#' @description
#' This module function is an adapted version of `histogramServer()` from the [Case study: histogram](https://mastering-shiny.org/scaling-modules.html#case-study-histogram) section of Mastering Shiny.
#'
#' @param id shiny module server id
#'
#' @return shiny server module
#' @export gghistServer
#'
#' @importFrom shiny tagList numericInput NS plotOutput renderPlot
#' @importFrom shiny is.reactive moduleServer bindEvent req
#' @importFrom shiny renderPrint
#' @importFrom purrr set_names as_vector
#' @importFrom ggplot2 ggplot aes geom_histogram labs theme_minimal
#'
gghistServer <- function(id, x, title = reactive("Histogram")) {
    stopifnot(shiny::is.reactive(x))
    stopifnot(shiny::is.reactive(title))

  shiny::moduleServer(id, function(input, output, session) {

    output$hist <- shiny::renderPlot({
      shiny::req(x())
      plot_var <- purrr::as_vector(x())
      if (is.numeric(plot_var)) {
      ggplot2::ggplot(
        mapping =
          ggplot2::aes(plot_var)) +
          ggplot2::geom_histogram(bins = input$bins) +
          ggplot2::labs(
            title = paste0(title(), " [bins = ", input$bins, "]"),
            y = "Count",
            x = names(x())) +
          ggplot2::theme_minimal()
      } else {
        NULL
      }
    }, res = 124) |>
      shiny::bindEvent(c(x(), input$bins),
        ignoreNULL = TRUE)

    output$data <- shiny::renderPrint({
      shiny::req(x())
      skim_var <- purrr::as_vector(x())
      df_skim(skim_var)
    }, width = 50)

  })
}
