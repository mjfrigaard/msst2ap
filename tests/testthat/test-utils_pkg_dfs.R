# testthat::test_that("pkg_inst_check function", {
#   # Test with an installed package
#   test_installed_package <- "stats"
#   testthat::expect_no_error(pkg_inst_check(test_installed_package))
#   test_cmt("pkg_inst_check", "install stats")
#
#   # Test with a non-existent package
#   test_nonexistent_package <- "thispackagedoesnotexist"
#   testthat::expect_warning(pkg_inst_check(test_nonexistent_package),
#     regexp = NA)
#   test_cmt("pkg_inst_check", "install nonexistent_package")
#
#   # Test with multiple packages
#   test_packages <- c("stats", "utils", "thispackagedoesnotexist")
#   testthat::expect_warning(pkg_inst_check(test_packages), regexp = NA)
#   test_cmt("pkg_inst_check", "install stats & nonexistent_package")
# })


testthat::test_that("pkg_inst_check works", {
  withr::local_options(repos = 'http://cran.us.r-project.org',
    if ("box" %in% loadedNamespaces()) {
      remove.packages("box")
    })
  pkg_inst_check("box")
  testthat::expect_true("box" %in% loadedNamespaces())
  unloadNamespace("box")
  test_cmt("pkg_inst_check", "install box")
})

testthat::test_that("pkg_inst_check works", {
  withr::local_options(repos = 'http://cran.us.r-project.org',
    if ("Lahman" %in% loadedNamespaces()) {
      remove.packages("Lahman")
    })
  pkg_inst_check("Lahman")
  testthat::expect_true("Lahman" %in% loadedNamespaces())
  unloadNamespace("Lahman")
  test_cmt("pkg_inst_check", "install Lahman")
})

test_that("pkg_inst_check works", {
  withr::local_options(repos = 'http://cran.us.r-project.org')
  if ("box" %in% loadedNamespaces()) {
    unloadNamespace("box")
  }
  pkg_inst_check("box")
  testthat::expect_true("box" %in% loadedNamespaces())
  unloadNamespace("box")
  test_cmt("pkg_inst_check", "install box")
})
#
# test_that("find_pkg_df_nms works", {
#   withr::local_options(repos='http://cran.us.r-project.org')
#   if ("dplyr" %nin% loadedNamespaces()) {
#   }
#   testthat::expect_equal(
#     object = find_pkg_df_nms("dplyr"),
#     expected = c(band_instruments = "band_instruments",
#       band_instruments2 = "band_instruments2",
#       band_members = "band_members",
#       starwars = "starwars",
#       storms = "storms")
#   )
#   test_cmt("find_pkg_df_nms", "dfs in dplyr")
# })
#
# test_that("find_pkg_df_nms works", {
#   withr::local_options(repos='http://cran.us.r-project.org')
#   if ("stringr" %nin% loadedNamespaces()) {
#     requireNamespace("stringr")
#   }
#   testthat::expect_null(
#     object = find_pkg_df_nms("stringr"))
#   test_cmt("find_pkg_df_nms", "dfs in stringr")
# })
#
#
# test_that("pkg_df_check works", {
#   withr::local_options(repos='http://cran.us.r-project.org')
#   if ("stringr" %nin% loadedNamespaces()) {
#     requireNamespace("stringr")
#   }
#   testthat::expect_false(
#     object = pkg_df_check("stringr"))
#   test_cmt("pkg_df_check", "dfs in stringr")
# })
#
# test_that("pkg_df_check works", {
#   withr::local_options(repos='http://cran.us.r-project.org')
#   if ("dplyr" %nin% loadedNamespaces()) {
#     requireNamespace("dplyr")
#   }
#   testthat::expect_true(
#     object = pkg_df_check("dplyr"))
#   test_cmt("pkg_df_check", "dfs in dplyr")
# })
#
# test_that("find_df_pkgs works", {
#   withr::local_options(repos='http://cran.us.r-project.org')
#   testthat::expect_equal(
#     object = find_df_pkgs(),
#     expected = c(dplyr = "dplyr",
#                  datasets = "datasets"))
#   test_cmt("find_df_pkgs", "datasets & dplyr")
# })
#
#
# test_that("find_df_pkgs works", {
#   withr::local_options(repos='http://cran.us.r-project.org')
#   testthat::expect_equal(
#     object = find_df_pkgs(),
#     expected = c(dplyr = "dplyr",
#                  datasets = "datasets"))
#   test_cmt("find_df_pkgs", "datasets & dplyr")
# })
#
# test_that("get_pkg_df works", {
#   withr::local_options(repos='http://cran.us.r-project.org')
#   testthat::expect_equal(
#     object = get_pkg_df("mtcars", "datasets"),
#     expected = datasets::mtcars)
#   test_cmt("get_pkg_df", "datasets::mtcars")
# })
#
# test_that("get_pkg_df works", {
#   withr::local_options(repos='http://cran.us.r-project.org')
#   testthat::expect_equal(
#     object = get_pkg_df("starwars", "dplyr"),
#     expected = dplyr::starwars)
#   test_cmt("get_pkg_df", "dplyr::starwars")
# })
#
# test_that("get_pkg_df works", {
#   withr::local_options(repos='http://cran.us.r-project.org')
#   testthat::expect_equal(
#     object = get_pkg_df("gss_cat", "forcats"),
#     expected = forcats::gss_cat)
#   test_cmt("get_pkg_df", "forcats::gss_cat")
# })
