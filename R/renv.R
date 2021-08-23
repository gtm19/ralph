init_renv <- function() {
  renv::init()
  invisible(TRUE)
}

uses_renv <- function(base_path = proj_get()) {
  utils::capture.output(
    lib_length <- length(renv::status(project = base_path)$library)
  )

  lib_length > 0
}
