## Tests check_arg_length() ----

fake_function <- function(y, len = 1) {
  check_arg_length(x = y, len = len)
}

test_that("Test check_arg_length() - Error (direct use)", {
  
  expect_error(check_arg_length(x = iris), 
               "The argument 'iris' must be of length 1",
               fixed = TRUE)

  expect_error(check_arg_length(x = "toto", len = 2), 
               "The argument '\"toto\"' must be of length 2",
               fixed = TRUE)
  
  expect_error(check_arg_length(x = c("toto", "titi")), 
               "The argument 'c(\"toto\", \"titi\")' must be of length 1",
               fixed = TRUE)
  
  expect_error(check_arg_length(x = 0.001, len = 2), 
               "The argument '0.001' must be of length 2",
               fixed = TRUE)
  
  expect_error(check_arg_length(x = c(0.001, 1000)), 
               "The argument 'c(0.001, 1000)' must be of length 1",
               fixed = TRUE)
  
  expect_error(check_arg_length(x = c(0.001, NA)), 
               "The argument 'c(0.001, NA)' must be of length 1",
               fixed = TRUE)
})


test_that("Test check_arg_length() - Error (indirect use)", {
  
  expect_error(fake_function(y = iris), 
               "The argument 'y' must be of length 1",
               fixed = TRUE)

  expect_error(fake_function(y = "toto", len = 2), 
               "The argument 'y' must be of length 2",
               fixed = TRUE)

  expect_error(fake_function(y = c("toto", "titi")), 
               "The argument 'y' must be of length 1",
               fixed = TRUE)
  
  expect_error(fake_function(y = 0.001, len = 2), 
               "The argument 'y' must be of length 2",
               fixed = TRUE)
  
  expect_error(fake_function(y = c(0.001, 1000)), 
               "The argument 'y' must be of length 1",
               fixed = TRUE)
  
  expect_error(fake_function(y = c(0.001, NA)), 
               "The argument 'y' must be of length 1",
               fixed = TRUE)
})


test_that("Test check_arg_length() - Success (direct use)", {
  
  expect_invisible(check_arg_length(56))
  expect_null(x <- check_arg_length(56))

  expect_invisible(check_arg_length(c(0, 56, 1000), len = 3))
  expect_null(x <- check_arg_length(c(0, 56, 1000), len = 3))

  expect_invisible(check_arg_length(c(0, 56, NA), len = 3))
  expect_null(x <- check_arg_length(c(0, 56, NA), len = 3))
})


test_that("Test check_arg_length() - Success (indirect use)", {
  
  expect_invisible(fake_function(y = 56))
  expect_null(x <- fake_function(y = 56))

  expect_invisible(fake_function(y = c(0, 56, 1000), len = 3))
  expect_null(x <- fake_function(y = c(0, 56, 1000), len = 3))

  expect_invisible(fake_function(y = c(0, 56, NA), len = 3))
  expect_null(x <- fake_function(y = c(0, 56, NA), len = 3))
})
