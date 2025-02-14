## Tests check_logical_arg() ----

fake_function <- function(y) {
  check_logical_arg(x = y)
}

test_that("Test check_logical_arg() - Error (direct use)", {
  
  expect_error(check_logical_arg(x = iris), 
               "The argument 'iris' must be a logical",
               fixed = TRUE)

  expect_error(check_logical_arg(x = 2L), 
               "The argument '2L' must be a logical",
               fixed = TRUE)
  
  expect_error(check_logical_arg(x = -0.001), 
               "The argument '-0.001' must be a logical",
               fixed = TRUE)
  
  expect_error(check_logical_arg(x = 1:3), 
               "The argument '1:3' must be a logical",
               fixed = TRUE)
})


test_that("Test check_logical_arg() - Error (indirect use)", {
  
  expect_error(fake_function(y = iris), 
               "The argument 'y' must be a logical",
               fixed = TRUE)

  expect_error(fake_function(y = 2L), 
               "The argument 'y' must be a logical",
               fixed = TRUE)

  expect_error(fake_function(y = -0.001), 
               "The argument 'y' must be a logical",
               fixed = TRUE)
  
  expect_error(fake_function(y = 1:3), 
               "The argument 'y' must be a logical",
               fixed = TRUE)
})


test_that("Test check_logical_arg() - Success (direct use)", {
  
  expect_invisible(check_logical_arg(TRUE))
  expect_null(x <- check_logical_arg(TRUE))

  expect_invisible(check_logical_arg(c(FALSE, TRUE, TRUE)))
  expect_null(x <- check_logical_arg(c(FALSE, TRUE, TRUE)))

  expect_invisible(check_logical_arg(c(FALSE, TRUE, NA)))
  expect_null(x <- check_logical_arg(c(FALSE, TRUE, NA)))
})


test_that("Test check_logical_arg() - Success (indirect use)", {
  
  expect_invisible(fake_function(y = TRUE))
  expect_null(x <- fake_function(y = TRUE))

  expect_invisible(fake_function(y = c(FALSE, TRUE, TRUE)))
  expect_null(x <- fake_function(y = c(FALSE, TRUE, TRUE)))

  expect_invisible(fake_function(y = c(FALSE, TRUE, NA)))
  expect_null(x <- fake_function(y = c(FALSE, TRUE, NA)))
})
