init_readme <- function(
  path,
  use_renv,
  use_makefile,
  use_testthat,
  readme,
  template = "package-README"
) {
  readme_data <- list(
    Package = basename(path),
    Renv = use_renv,
    Makefile = use_makefile,
    Tests = use_testthat,
    Rmd = identical(readme, "Rmd"),
    Dev = use_renv || use_makefile || use_testthat
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
