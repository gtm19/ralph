create_package <- function(
  path,
  use_renv = TRUE,
  use_git = TRUE,
  use_testthat = TRUE,
  use_makefile = TRUE
) {
  usethis::create_package(
    path
  )

  if (use_renv) {
    renv::init()
  }
  
  if (use_testthat) {
    usethis::use_testthat()
  }
  
  if (use_makefile) {
    makefile_loc <- system.file("makefiles", "Makefile", package = "ralph")
    file.copy(
      from = makefile_loc,
      to = "."
    )
  }

  if (use_git) {
    usethis::use_git()
  }

  invisible(TRUE)

}
