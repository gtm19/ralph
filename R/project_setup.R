#' Create a package, optionally initialising useful stuff
#'
#' @inheritParams usethis::create_package
#'
#' @param use_renv,use_git,use_testthat,use_makefile TRUE/FALSE: do you want
#' to use any/all of these things in your project?
#' @param readme character. Either "md" or "Rmd" - determines the file 
#' extension of your README file
#'
#' @export
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
    usethis::ui_info("Initialising renv")
    init_renv()
    usethis::ui_done("renv successfully initialised")
  }

  # testthat: ----
  if (use_testthat) {
    usethis::ui_info("Initialising testthat")
    init_testthat()
    usethis::ui_done("testthat successfully initialised")
  }

  # Makefile: ----
  if (use_makefile) {
    makefile_loc <- system.file("makefiles", "Makefile", package = "ralph")
    file.copy(
      from = makefile_loc,
      to = "."
    )
    usethis::ui_done("Initial Makefile created")
  }

  # git: ----
  if (use_git) {
    init_git()
    usethis::ui_done("git initialised")
  }

  # readme: ----
  if ({
    usethis::ui_info(
      "Initialising README.{readme}"
    )
    init_readme(
      path = path,
      use_renv = use_renv,
      readme = readme,
      template = "package-README"
    )
  }) {
    usethis::ui_done("README.{readme} successfully initialised")
  }

  invisible(TRUE)
}
