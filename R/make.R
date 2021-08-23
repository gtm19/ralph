init_make <- function() {
  makefile_loc <- system.file("makefiles", "Makefile", package = "ralph")
  file.copy(
    from = makefile_loc,
    to = "."
  )

  # Add Makefile to buildignore
  usethis::use_build_ignore("Makefile")

  # Add tar.gz file created by make build to gitignore
  usethis::use_git_ignore("*.tar.gz")

  invisible(TRUE)
}

uses_make <- function(base_path = proj_get()) {
  makefile <- file.path(base_path, "Makefile")
  file.exists(makefile)
}
