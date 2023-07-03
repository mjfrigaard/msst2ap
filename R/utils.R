#' Custom `skimr::skim()` for numeric variables
#'
#' @description
#' A custom `skimr::skim_with()` for numeric variables.
#'
#' @export df_skim
#'
#' @importFrom skimr skim_with skim sfl
#' @examples
#' require(dplyr)
#' df_skim(dplyr::starwars)
df_skim <- function(df) {
  skims <- list(numeric =
                    skimr::sfl(min = ~ min(., na.rm = TRUE),
                               med = ~ median(., na.rm = TRUE),
                               max = ~ max(., na.rm = TRUE),
                               p0 = NULL, p25 = NULL, p50 = NULL,
                               p75 = NULL, p100 = NULL),
                factor =
                    skimr::sfl(ordered = NULL),
                character =
                    skimr::sfl(min = NULL, max = NULL,
                               whitespace = NULL))
  df_skim <- skimr::skim_with(!!!skims)
  df_skim(df)
}

#' Check if package namespace is loaded, if not load it
#'
#' @param pkg name of package (a character vector)
#' @param quiet logical, print messages
#'
#' @return Package: `'name'` loaded or Loading package: `'name'`
#'
#' @description
#' Check if `pkg` is installed with `isNamespaceLoaded()`. If not, package is
#' installed with `requireNamespace(quietly = TRUE)`.
#'
#'
#' @examples
#' # remove from ns
#' unloadNamespace("fs")
#' unloadNamespace("box")
#' # with single pkg
#' pkg_ns_check("fs")
#' # remove again
#' unloadNamespace("fs")
#' # with multiple pkgs
#' pkgs <- c("fs", "box")
#' pkg_ns_check(pkgs)
pkg_ns_check <- function(pkg, quiet = FALSE) {
  if (isFALSE(quiet)) {
    # with messages
    if (!isNamespaceLoaded(pkg)) {
      if (requireNamespace(pkg, quietly = FALSE)) {
        cat(paste0(pkg, " namespace loaded\n"))
      } else {
        stop(paste0(pkg, " not available"))
      }
    } else {
      cat(paste0("Package ", pkg, " loaded\n"))
    }
  } else {
    # without messages
    if (!isNamespaceLoaded(pkg)) {
      if (requireNamespace(pkg, quietly = TRUE)) {
      } else {
        stop(paste0(pkg, " not available"))
      }
    }
  }
}


#' Inverted versions of `%in%`
#'
#' @export
#'
#' @name not-in
#'
#' @examples
#' 1 %nin% 1:10
#' "A" %nin% 1:10
`%nin%` <- function(x, table) {
  match(x, table, nomatch = 0) == 0
}
