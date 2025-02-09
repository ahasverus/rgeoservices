## Tests check_numeric_arg() ----

fake_function <- function(y) {
  check_numeric_arg(x = y)
}

test_that("Test check_numeric_arg() - Error (direct use)", {
  
  expect_error(check_numeric_arg(x = iris), 
               "The argument 'iris' must be a numeric",
               fixed = TRUE)

  expect_error(check_numeric_arg(x = "toto"), 
               "The argument '\"toto\"' must be a numeric",
               fixed = TRUE)
  
  expect_error(check_numeric_arg(x = c("toto", "titi")), 
               "The argument 'c(\"toto\", \"titi\")' must be a numeric",
               fixed = TRUE)
})


test_that("Test check_numeric_arg() - Error (indirect use)", {
  
  expect_error(fake_function(y = iris), 
               "The argument 'y' must be a numeric",
               fixed = TRUE)

  expect_error(fake_function(y = "toto"), 
               "The argument 'y' must be a numeric",
               fixed = TRUE)

  expect_error(fake_function(y = c("toto", "titi")), 
               "The argument 'y' must be a numeric",
               fixed = TRUE)
})


test_that("Test check_numeric_arg() - Success (direct use)", {
  
  expect_invisible(check_numeric_arg(56))
  expect_null(x <- check_numeric_arg(56))

  expect_invisible(check_numeric_arg(c(0, 56, 1000)))
  expect_null(x <- check_numeric_arg(c(0, 56, 1000)))

  expect_invisible(check_numeric_arg(c(0, 56, NA)))
  expect_null(x <- check_numeric_arg(c(0, 56, NA)))
})


test_that("Test check_numeric_arg() - Success (indirect use)", {
  
  expect_invisible(fake_function(y = 56))
  expect_null(x <- fake_function(y = 56))

  expect_invisible(fake_function(y = c(0, 56, 1000)))
  expect_null(x <- fake_function(y = c(0, 56, 1000)))

  expect_invisible(fake_function(y = c(0, 56, NA)))
  expect_null(x <- fake_function(y = c(0, 56, NA)))
})
