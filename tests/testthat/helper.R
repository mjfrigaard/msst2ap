# test comment helper ----
test_cmt <- function(test, msg) {
  cat("\n\t", glue::glue("  {test}: {msg}"), "\n")
}

# create_tibble ----



# example tbl_maker -----


# map tibble maker
make_tbl <- function(n, type) {
  bld_tbl <- function(n, type) {
    nms <- janitor::make_clean_names(type)
    tbl_maker <- function(n, type) {
      switch(type,
        log = tibble::tibble(log = sample(c(TRUE, FALSE), n, replace = TRUE)),
        dbl = tibble::tibble(dbl = runif(n)),
        int = tibble::tibble(int = sample(1:100, n, replace = TRUE)),
        chr = tibble::tibble(chr = sample(LETTERS, n, replace = TRUE)),
        fct = tibble::tibble(fct = factor(sample(LETTERS[1:4], n, replace = TRUE))),
        ord = tibble::tibble(ord = factor(sample(LETTERS[1:4], n, replace = TRUE), ordered = TRUE)),
        date = tibble::tibble(date = as.Date("2020-01-01") + sample(1:365, n, replace = TRUE)),
        posixct = tibble::tibble(posixct = as.POSIXct("2020-01-01 00:00:00", tz = "UTC") +
                      sample(1:86400, n, replace = TRUE)),
        complex = tibble::tibble(complex = complex(real = rnorm(n), imaginary = rnorm(n))),
        stop("Unsupported type")
      )
    }
    # map tbl_maker
    purrr::map(.x = type, tbl_maker, n = 10) |>
      purrr::list_cbind(name_repair = "unique") |>
      purrr::set_names(nm = nms)
  }
  # quiet bld_tbl
  suppressMessages(
    suppressWarnings(
      bld_tbl(n = n, type = type)
    )
  )
}

make_tbl(n = 10, type = c("log", "log", "fct", "ord"))
