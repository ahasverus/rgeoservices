## Tests check_positive_arg() ----

fake_function <- function(y) {
  check_positive_arg(x = y)
}

test_that("Test check_positive_arg() - Error (direct use)", {
  
  expect_error(check_positive_arg(x = -1), 
               "The argument '-1' must be strictly positive",
               fixed = TRUE)

  expect_error(check_positive_arg(x = 0), 
               "The argument '0' must be strictly positive",
               fixed = TRUE)
  
  expect_error(check_positive_arg(x = -10.001), 
               "The argument '-10.001' must be strictly positive",
               fixed = TRUE)
  
  expect_error(check_positive_arg(x = c(-10.001, 10)), 
               "The argument 'c(-10.001, 10)' must be strictly positive",
               fixed = TRUE)
})


test_that("Test check_positive_arg() - Error (indirect use)", {
  
  expect_error(fake_function(y = -1), 
               "The argument 'y' must be strictly positive",
               fixed = TRUE)

  expect_error(fake_function(y = 0), 
               "The argument 'y' must be strictly positive",
               fixed = TRUE)

  expect_error(fake_function(y = -10.001), 
               "The argument 'y' must be strictly positive",
               fixed = TRUE)
  
  expect_error(fake_function(y = c(-10.001, 10)), 
               "The argument 'y' must be strictly positive",
               fixed = TRUE)
})


test_that("Test check_positive_arg() - Success (direct use)", {
  
  expect_invisible(check_positive_arg(56))
  expect_null(x <- check_positive_arg(56))

  expect_invisible(check_positive_arg(c(56, 1000)))
  expect_null(x <- check_positive_arg(c(56, 1000)))
})


test_that("Test check_positive_arg() - Success (indirect use)", {
  
  expect_invisible(fake_function(y = 56))
  expect_null(x <- fake_function(y = 56))

  expect_invisible(fake_function(y = c(56, 1000)))
  expect_null(x <- fake_function(y = c(56, 1000)))
})
