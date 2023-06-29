#' Base plot (ggplot2)
#'
#' @param df input dataset (tibble or data.frame)
#' @param x_var x variable
#'
#' @return plot object
#' @export gg_base
#'
#' @importFrom ggplot2 ggplot aes
#'
#' @examples
#' diamonds <- ggplot2::diamonds
#' mini_dmnds <- diamonds[sample(nrow(diamonds), 10000), ]
#' gg_base(df = mini_dmnds, x_var = "carat")
gg_base <- function(df, x_var) {
  ggplot2::ggplot(
    data = df,
    mapping = ggplot2::aes(x = .data[[x_var]])
  )
}

#' Distribution of (x) plot title
#'
#' @param x x variable
#'
#' @return String for plot title
#' @export gg_x_dist_title
#'
#' @importFrom glue glue
#' @importFrom stringr str_replace_all
#' @importFrom snakecase to_title_case
#'
#' @examples
#' diamonds <- ggplot2::diamonds
#' mini_dmnds <- diamonds[sample(nrow(diamonds), 10000), ]
#' gg_base(df = mini_dmnds, x_var = "carat") +
#'   ggplot2::geom_histogram(bins = 30) +
#'   ggplot2::labs(title =
#'       gg_x_dist_title(x = "carat"))
gg_x_dist_title <- function(x) {
  x_chr <- stringr::str_replace_all(
    snakecase::to_title_case(x), "_", " "
  )
  glue::glue("Distribution of {x_chr}")
}

#' Histogram plot (with ggplot2)
#'
#' @param df input dataset (tibble or data.frame)
#' @param x_var x variable (supplied to `ggplot2::aes(x = )`)
#' @param bins from `ggplot2::geom_histogram()` ('Number of bins. Overridden by binwidth. Defaults to 30')
#' @param ... other arguments passed to `ggplot2::geom_histogram()`, outside of `ggplot2::aes()`
#'
#' @return A `ggplot2` plot object
#' @export gg_hist
#'
#' @importFrom ggplot2 ggplot aes geom_histogram
#' @importFrom ggplot2 labs theme_minimal theme
#' @importFrom stringr str_replace_all
#' @importFrom snakecase to_title_case
#'
#' @examples
#' diamonds <- ggplot2::diamonds
#' mini_dmnds <- diamonds[sample(nrow(diamonds), 10000), ]
#' gg_hist(
#'   df = mini_dmnds,
#'   x_var = "carat",
#'   bins = 45,
#'   alpha = 1 / 3,
#'   color = "#772953"
#' ) +
#'   ggplot2::labs(title =
#'       gg_x_dist_title(x = "carat"))
gg_hist <- function(df, x_var, bins, ...) {
  # create base
  base <- gg_base(df = df, x_var = x_var)

  base +
    ggplot2::geom_histogram(bins = bins, ...) +

    ggplot2::labs(
      title = gg_x_dist_title(x = x_var),
      x = stringr::str_replace_all(
        snakecase::to_title_case(x_var), "_", " "
      )) +
    ggplot2::theme_minimal() +
    ggplot2::theme(legend.position = "bottom")
}

#' Histogram server module (ggplot2)
#'
#' @description
#' This module function is an adapted version of `histogramServer()` from the [Case study: histogram](https://mastering-shiny.org/scaling-modules.html#case-study-histogram) section of Mastering Shiny.
#'
#' @param id shiny module server id
#'
#' @return shiny server module
#' @export gghistogramServer
#'
#' @importFrom shiny tagList numericInput NS plotOutput renderPlot req
#' @importFrom tibble tibble
#' @importFrom purrr set_names
#'
gghistogramServer <- function(id, x, title = reactive("Histogram")) {
    stopifnot(shiny::is.reactive(x))
    stopifnot(shiny::is.reactive(title))

  shiny::moduleServer(id, function(input, output, session) {

    output$vals <- shiny::renderPrint({
      shiny::req(is.numeric(x()))
      vals <- shiny::reactiveValuesToList(input, all.names = TRUE)
      print(vals)
    })

    output$hist <- shiny::renderPlot({
      shiny::req(is.numeric(x()))
      d <- tibble::tibble(x()) |>
        purrr::set_names(unique(names(x())))
      x_var <- names(d)
      gg_hist(
        df = d,
        x_var = x_var,
        bins = input$bins) +
        ggplot2::labs(title =
            gg_x_dist_title(x = x_var))

      # main <- paste0(title(), " [", input$bins, "]")
      #
      # hist(x(), breaks = input$bins, main = main)

    }, res = 96)
  })
}
