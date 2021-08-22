create_package <- function(
  path,
  use_renv = TRUE,
  use_git = TRUE,
  use_testthat = TRUE,
  use_makefile = TRUE,
  readme = c("md", "Rmd")
) {

  readme <- match.arg(readme)

  usethis::create_package(
    path,
    open = TRUE
  )

  # renv: ----
  if (use_renv) {
    init_renv() && usethis::ui_done("renv successfully initialised")
  }

  # testthat: ----
  if(use_testthat) {
    usethis::use_testthat()
  }

  # Makefile: ----
  if (use_makefile) {
    makefile_loc <- system.file("makefiles", "Makefile", package = "ralph")
    file.copy(
      from = makefile_loc,
      to = "."
    )
  }

  # git: ----
  if (use_git) {
    usethis::use_git()
  }

  # readme: ----
  if (
    init_readme(
      path = path,
      use_renv = use_renv,
      readme = readme,
      template = "package-README",
      package = "ralph"
    )
  ) {
    usethis::ui_done("README.{readme} successfully initialised")
  }

  invisible(TRUE)
}

init_renv <- function() {
  usethis::ui_info(
    "Initialising renv"
  )

  renv::init()

  invisible(TRUE)
}

init_readme <- function(
  path,
  use_renv,
  readme,
  template = "package-README",
  package = "ralph"
) {
  readme_data <- list(
    Package = basename(path),
    Renv = use_renv,
    Rmd = identical(readme, "Rmd"),
    Dev = use_renv # TODO: add Makefile to this (and section to readme template)
  )

  usethis::use_template(
    template = template,
    save_as = glue::glue("{path}/README.{readme}"),
    data = readme_data,
    open = FALSE,
    ignore = identical(readme, "Rmd"),
    package = "ralph"
  )

  invisible(TRUE)
}