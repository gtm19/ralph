init_git <- function() {
  usethis::use_git()
  invisible(TRUE)
}

uses_git <- function(base_path = proj_get()) {
  tryCatch({
    gert::git_info(repo = base_path)
    TRUE
  },
  error = function(c) {
    FALSE
  })
}