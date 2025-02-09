## Tests check_if_na() ----

fake_function <- function(y) {
  check_if_na(x = y)
}

test_that("Test check_if_na() - Error (direct use)", {
  
  expect_error(check_if_na(x = c(1, NA)), 
               "The argument 'c(1, NA)' cannot contain missing value",
               fixed = TRUE)

  expect_error(check_if_na(x = c("toto", NA)), 
               "The argument 'c(\"toto\", NA)' cannot contain missing value",
               fixed = TRUE)
})


test_that("Test check_if_na() - Error (indirect use)", {
  
  expect_error(fake_function(y = c(1, NA)), 
               "The argument 'y' cannot contain missing value",
               fixed = TRUE)

  expect_error(fake_function(y = c("toto", NA)), 
               "The argument 'y' cannot contain missing value",
               fixed = TRUE)
})


test_that("Test check_if_na() - Success (direct use)", {
  
  expect_invisible(check_if_na(56))
  expect_null(x <- check_if_na(56))

  expect_invisible(check_if_na(c(56, 1000)))
  expect_null(x <- check_if_na(c(56, 1000)))
})


test_that("Test check_if_na() - Success (indirect use)", {
  
  expect_invisible(fake_function(y = 56))
  expect_null(x <- fake_function(y = 56))

  expect_invisible(fake_function(y = c(56, 1000)))
  expect_null(x <- fake_function(y = c(0, 56, 1000)))
})
