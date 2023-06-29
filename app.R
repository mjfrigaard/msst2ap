# run app for package
pkgload::load_all(
  export_all = FALSE,
  helpers = TRUE,
  attach_testthat = TRUE)
library(msst2ap)
# options(shiny.fullstacktrace = TRUE)
msst2ap::pkgDataApp()
# rsconnect::deployApp()
