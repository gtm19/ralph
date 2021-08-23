init_make <- function() {
  makefile_loc <- system.file("makefiles", "Makefile", package = "ralph")
  file.copy(
    from = makefile_loc,
    to = "."
  )
}

uses_make <- function(base_path = proj_get()) {
  makefile <- file.path(base_path, "Makefile")
  file.exists(makefile)
}
