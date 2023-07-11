library(shinytest2)
remotes::install_github("rstudio/chromote", force = TRUE, quiet = TRUE)
library(chromote)
testthat::test_that("{shinytest2}: datasetApp", {
  app <- AppDriver$new(msst2ap::datasetApp(), height = 600, width = 800)
  app$set_inputs(`dataset-dataset` = "attitude")
  app_values <- app$get_values()
  testthat::expect_equal(
    object = app_values$input$`dataset-dataset`,
    expected = "attitude")
  app$stop()
})
