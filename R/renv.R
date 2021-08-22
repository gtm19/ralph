init_renv <- function() {
  renv::init()
  invisible(TRUE)
}

uses_renv <- function() {
  length(renv::status()$library) > 0
}
