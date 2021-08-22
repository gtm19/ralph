init_renv <- function() {
  renv::init()
  invisible(TRUE)
}

uses_renv <- function() {
  capture.output(lib_length <- length(renv::status()$library))
  lib_length > 0
}
