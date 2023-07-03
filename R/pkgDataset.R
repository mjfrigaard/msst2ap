#' Package data input module (UI)
#'
#' @param id module id
#' @param pkg packages to install
#'
#' @description
#' This module includes a package argument for installing and loading additional
#' data objects. Its been adapted from the [Getting started: UI input + server output](https://mastering-shiny.org/scaling-modules.html#getting-started-ui-input-server-output)
#' section of Mastering Shiny.
#'
#' @return UI module function
#' @export pkgDatasetInput
#'
#' @importFrom shiny selectInput NS tagList verbatimTextOutput
pkgDatasetInput <- function(id, pkg = NULL) {

  if (!is.null(pkg)) {
      pkg_inst_check(pkg)
      ui_pkgs <- find_df_pkgs()
  } else {
      ui_pkgs <- find_df_pkgs()
  }


  ns <- shiny::NS(id)
  shiny::tagList(
  shiny::selectInput(ns("pkg"),
    label = "Select a package",
    choices = ui_pkgs),
  shiny::selectInput(ns("data"),
    label = "Select data",
    choices = NULL),
  shiny::verbatimTextOutput(ns("out"))
  )
}

#' Package data module (server)
#'
#' @param id module id
#'
#' @return module server function (for package datasets).
#' @export pkgDatasetServer
#'
#' @importFrom shiny moduleServer observe req updateSelectInput
#' @importFrom shiny reactive bindEvent bindCache
pkgDatasetServer <- function(id) {

  shiny::moduleServer(id, function(input, output, session) {

    shiny::observe({
          shiny::req(input$pkg)
         shiny::updateSelectInput(session,
            inputId = "data",
            choices = find_pkg_df_nms(pkg = input$pkg))
         }) |>
       shiny::bindEvent(input$pkg, ignoreNULL = TRUE)

    shiny::reactive({
      shiny::req(input$data, input$pkg)
        get_pkg_df(df = input$data, pkg = input$pkg)
       }) |>
        shiny::bindCache(c(input$data, input$pkg)) |>
        shiny::bindEvent(c(input$data, input$pkg))

  })
}
