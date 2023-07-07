exampleUI <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::textInput(
      inputId = ns("txt"),
      label = "Text"),
    shiny::textOutput(
      outputId = ns("caps"))
  )
}

exampleServer <- function(id) {
    shiny::moduleServer(id, function(input, output, session) {
        # Your server code here

       output$caps <- shiny::renderText({
          shiny::req(input$txt)
          paste0("Did you mean, ", toupper(input$txt), "?")
        })
    })
}

exampleApp <- function() {
  shiny::shinyApp(
    ui = shiny::fluidPage(
      exampleUI("x")
    ),
    server = function(input, output, sessions) {
      exampleServer("x")
    }
  )
}

exampleApp()
