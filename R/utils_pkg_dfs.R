#' Check if a package is installed, if not install it
#'
#'
#' Check if `pkg` is installed with `rlang::is_installed()`. If not, package
#' is installed with `pak::pkg_install()`.
#'
#' @param pkg name of package (a character vector)
#'
#' @export pkg_install_check
#'
#'
#' @importFrom purrr walk
#' @importFrom rlang is_installed
#' @importFrom pak pkg_install
#' @importFrom cli cli_alert_success cli_abort
#'
#' @examples
#' p <- c("emoji", "palmerpenguins")
#'  if (any(p  %in% loadedNamespaces())) {
#'   remove.packages(p)
#'  }
#' pkg_install_check(c("janitor", "snakecase"))
pkg_install_check <- function(pkg) {
  inst_check <- function(x) {
    options(rlib_restart_package_not_found = FALSE)
    if (!rlang::is_installed(pkg = x)) {
      pak::pkg_install(pkg = x,
        ask = FALSE,
        dependencies = NA,
        lib = .libPaths()[[1L]])
      require(package = x, quietly = TRUE,
        lib.loc = .libPaths()[[1L]])
    } else if (rlang::is_installed(pkg = x)) {
      lib <-  .libPaths()[[1L]]
      require(package = x, quietly = TRUE,
        lib.loc = .libPaths()[[1L]])
      cli::cli_alert_success("Package installed")
    } else {
      cli::cli_abort("Package not available")
    }
  }
  purrr::walk(pkg, inst_check)
}

#' Package installation check (base)
#'
#' Check if a package is installed, if not, install it.
#'
#' @param pkg package or packages
#'
#' @return installation success or failure
#' @export pkg_inst_check
#'
#' @importFrom tibble tibble
#' @importFrom stringr str_detect
#' @importFrom purrr walk
#'
#' @examples
#' p <- c("emoji", "palmerpenguins")
#'  if (any(p  %in% loadedNamespaces())) {
#'   remove.packages(p)
#'  }
#' pkg_inst_check(c("janitor", "snakecase"))
pkg_inst_check <- function(pkg, quiet = TRUE) {
  pkg_check <- function(pkg, quiet) {
    if (isFALSE(quiet)) {
      pkg <- as.character(pkg)
      paks_tbl <- tibble::as_tibble(
                      utils::installed.packages())
      if (!any(stringr::str_detect(paks_tbl$Package, pkg))) {
      cat('\nPackage:', pkg, 'Not found, Installing Now...\n')

        install.packages(pkgs = pkg,
          dep = TRUE,
          quiet = TRUE,
          verbose = FALSE)

      } else {
      cat('\nPackage:', pkg, 'Not found, Installing Now...\n')
      }
      cat('\nLoading Package :', pkg, "\n")
        require(pkg, character.only = TRUE)
      # rstudioapi::restartSession()
    } else {
      pkg <- as.character(pkg)
      paks_tbl <- tibble::as_tibble(
                      utils::installed.packages())
      if (!any(stringr::str_detect(paks_tbl$Package, pkg))) {
        install.packages(pkgs = pkg,
          dep = TRUE,
          quiet = TRUE,
          verbose = FALSE)
      } else {
        require(pkg, character.only = TRUE)
      }
    }
  }
  purrr::walk(.x = pkg, .f = pkg_check, quiet = quiet)
}


#' Find names of data.frame in a package
#'
#' @description
#' Return the names of `data.frame`s in a package.
#'
#'
#' @param pkg name of package
#'
#' @return named vector of data.frames in package
#' @export find_pkg_df_nms
#'
#'
#' @importFrom stringr str_remove_all str_replace_all
#' @importFrom purrr map_vec walk map set_names map2
#'
#' @examples
#' find_pkg_df_nms(pkg = "base")
#' find_pkg_df_nms(pkg = "datasets")
#' find_pkg_df_nms(pkg = "lubridate")
find_pkg_df_nms <- function(pkg) {
  pkg_inst_check(pkg = pkg)
  pkg_pos <- paste0("package:", pkg)
  pkg_nms <- ls(pkg_pos)
  pkg_objs <- purrr::map2(.x = pkg_nms, .y = pkg_pos, .f = get)
  df_nms <- pkg_nms[purrr::map_vec(.x = pkg_objs, .f = is.data.frame)]
  if (length(df_nms) > 0) {
    purrr::set_names(df_nms)
  } else {
    invisible()
  }
}
# find_pkg_df_nms(pkg = "forcats")

#' Check if package contains data.frames
#'
#' @param pkg name of package (a character vector)
#'
#' @return logical (`TRUE` = has data.frame, `FALSE` = no data.frame)
#'
#' @export pkg_df_check
#'
#' @description
#' Returns `TRUE` if package has `data.frame`. If package is not installed,
#' install with `install.packages()`.
#'
#' 1. Check if the package is installed and load it
#'
#' 2. Retrieve the objects in the package
#'
#' 3. Use `purrr::map_lgl()` to apply `is.data.frame()` to each object in the
#'  package. `map_lgl()` returns a logical vector with the same length as
#'  the retrieved package objects.
#'
#'
#' @importFrom stringr str_remove_all str_replace_all
#' @importFrom purrr map_vec walk map set_names map2
#' @importFrom purrr map_lgl
#'
#' @examples
#' pkg_df_check("dplyr")
#' pkg_df_check("stringr")
pkg_df_check <- function(pkg) {
  pkg_inst_check(pkg = pkg)
  pkg_pos <- paste0("package:", pkg)
  pkg_nms <- ls(pkg_pos)
  pkg_objs <- purrr::map2(.x = pkg_nms, .y = pkg_pos, .f = get)
  is_df <- purrr::map_vec(.x = pkg_objs, .f = is.data.frame)
  return(any(is_df))
}

#' Find packages with data.frames
#'
#' @description
#' Return a named character vector of installed package with `data.frame`s.
#'
#'
#'
#' @return named vector of packages with data.frames
#' @export find_df_pkgs
#'
#'
#' @importFrom stringr str_remove_all str_replace_all
#' @importFrom purrr map_vec walk map set_names map2
#'
#' @examples
#' find_df_pkgs()
find_df_pkgs <- function() {
  all_srch_lst <- search()
  all_pkgs <- grep(pattern = "package:", x = all_srch_lst, value = TRUE)
  pkgs <- gsub(
    pattern = ".*:|.GlobalEnv",
    replacement = "",
    x = all_pkgs
  )
  pkgs_chr <- pkgs[nzchar(pkgs)]
  all_pkgs <- `names<-`(pkgs_chr, pkgs_chr)
  df_pkg_set <- purrr::map_vec(.x = all_pkgs, .f = pkg_df_check)
  df_pkgs <- all_pkgs[df_pkg_set]
  return(df_pkgs)
}


#' Get data.frame from package
#'
#' @param df name of dataset
#' @param pkg name of package
#'
#' @return data object
#'
#' @export get_pkg_df
#'
#' @importFrom stringr str_remove_all str_replace_all
#' @importFrom purrr map_vec walk map
#'
#' @examples
#' get_pkg_df("gss_cat", "forcats")
#' get_pkg_df("starwars", "dplyr")
get_pkg_df <- function(df, pkg) {
  pkg_inst_check(pkg = pkg)
  objname <- stringr::str_remove_all(df, " .*")
  e <- loadNamespace(pkg)
  if (!exists(x = df, envir = e)) {
    dataname <- stringr::str_replace_all(df, "^.*\\(|\\)$", "")
    e <- new.env()
    data(list = dataname, package = pkg, envir = e)
  }
  data_obj <- get(objname, envir = e)
  return(data_obj)
}
