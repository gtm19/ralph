init_testthat <- function() {
  usethis::use_testthat()
  invisible(TRUE)
}

uses_tests <- function(base_path = proj_get()) {
  paths <- c(
    file.path(base_path, "inst", "tests"),
    file.path(base_path, "tests", "testthat")
  )

  any(dir.exists(paths))
}
