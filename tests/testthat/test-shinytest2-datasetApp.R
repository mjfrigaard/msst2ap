library(shinytest2)

test_that("{shinytest2}: datasetApp", {
  app <- AppDriver$new(msst2ap::datasetApp(), height = 600, width = 800)
  app$set_inputs(`dataset-dataset` = "attitude")
  app$expect_values()
})
