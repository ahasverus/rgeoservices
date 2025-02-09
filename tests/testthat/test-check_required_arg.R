## Tests check_required_arg() ----

fake_function <- function(y) {
  check_required_arg(x = y)
}

test_that("Test check_required_arg() - Error (direct use)", {
  
  expect_error(check_required_arg(), 
               "The argument '' is required",
               fixed = TRUE)

  expect_error(check_required_arg(x = NULL), 
               "The argument 'NULL' is required",
               fixed = TRUE)
  
  expect_error(check_required_arg(x = character(0)), 
               "The argument 'character(0)' is required",
               fixed = TRUE)

  expect_error(check_required_arg(x = numeric(0)), 
               "The argument 'numeric(0)' is required",
               fixed = TRUE)
  
  expect_error(check_required_arg(x = NA), 
               "The argument 'NA' is required",
               fixed = TRUE)
  
  expect_error(check_required_arg(x = rep(NA, 3)), 
               "The argument 'rep(NA, 3)' is required",
               fixed = TRUE)
  
  expect_error(check_required_arg(x = ""), 
               "The argument '\"\"' is required",
               fixed = TRUE)
  
  expect_error(check_required_arg(x = rep("", 3)), 
               "The argument 'rep(\"\", 3)' is required",
               fixed = TRUE)
})


test_that("Test check_required_arg() - Error (indirect use)", {
  
  expect_error(fake_function(), 
               "The argument 'y' is required",
               fixed = TRUE)

  expect_error(fake_function(y = NULL), 
               "The argument 'y' is required",
               fixed = TRUE)

  expect_error(fake_function(y = character(0)), 
               "The argument 'y' is required",
               fixed = TRUE)

  expect_error(fake_function(y = numeric(0)), 
               "The argument 'y' is required",
               fixed = TRUE)
  
  expect_error(fake_function(y = NA), 
               "The argument 'y' is required",
               fixed = TRUE)
  
  expect_error(fake_function(y = rep(NA, 3)), 
               "The argument 'y' is required",
               fixed = TRUE)
  
  expect_error(fake_function(y = ""), 
               "The argument 'y' is required",
               fixed = TRUE)
  
  expect_error(fake_function(y = rep("", 3)), 
               "The argument 'y' is required",
               fixed = TRUE)
})


test_that("Test check_required_arg() - Success (direct use)", {
  
  expect_invisible(check_required_arg(56))
  expect_null(x <- check_required_arg(56))

  expect_invisible(check_required_arg(c(0, 56, 1000)))
  expect_null(x <- check_required_arg(c(0, 56, 1000)))

  expect_invisible(check_required_arg(c(0, 56, NA)))
  expect_null(x <- check_required_arg(c(0, 56, NA)))

  expect_invisible(check_required_arg("AAA"))
  expect_null(x <- check_required_arg("AAA"))

  expect_invisible(check_required_arg(c("AAA", "BBB", "CCC")))
  expect_null(x <- check_required_arg(c("AAA", "BBB", "CCC")))

  expect_invisible(check_required_arg(c("AAA", "BBB", "")))
  expect_null(x <- check_required_arg(c("AAA", "BBB", "")))

  expect_invisible(check_required_arg(c("AAA", "BBB", "", NA)))
  expect_null(x <- check_required_arg(c("AAA", "BBB", "", NA)))
})


test_that("Test check_required_arg() - Success (indirect use)", {
  
  expect_invisible(fake_function(y = 56))
  expect_null(x <- fake_function(y = 56))

  expect_invisible(fake_function(y = c(0, 56, 1000)))
  expect_null(x <- fake_function(y = c(0, 56, 1000)))

  expect_invisible(fake_function(y = c(0, 56, NA)))
  expect_null(x <- fake_function(y = c(0, 56, NA)))

  expect_invisible(fake_function(y = "AAA"))
  expect_null(x <- fake_function(y = "AAA"))

  expect_invisible(fake_function(y = c("AAA", "BBB", "CCC")))
  expect_null(x <- fake_function(y = c("AAA", "BBB", "CCC")))

  expect_invisible(fake_function(y = c("AAA", "BBB", "")))
  expect_null(x <- fake_function(y = c("AAA", "BBB", "")))

  expect_invisible(fake_function(y = c("AAA", "BBB", "", NA)))
  expect_null(x <- fake_function(y = c("AAA", "BBB", "", NA)))
})
