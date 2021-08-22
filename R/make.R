init_make <- function() {
  makefile_loc <- system.file("makefiles", "Makefile", package = "ralph")
  file.copy(
    from = makefile_loc,
    to = "."
  )
}
