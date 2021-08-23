test_that("uses_git returns a boolean", {
  testthat::expect_type(uses_git(), "logical")
})
