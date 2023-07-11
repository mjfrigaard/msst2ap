library(shinytest2)

testthat::test_that("{shinytest2}: selectDataVarApp", {
  app <- AppDriver$new(msst2ap::selectDataVarApp(), height = 600, width = 800)
  app$view()
  app$stop()
})
