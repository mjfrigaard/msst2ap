library(shinytest2)

test_that("{shinytest2}: datasetApp", {
  ds_app <- msst2ap::datasetApp()
  app <- AppDriver$new(ds_app)
  app$expect_values()
})
