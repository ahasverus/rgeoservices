## Tests check_character_arg() ----

fake_function <- function(y) {
  check_character_arg(x = y)
}

test_that("Test check_character_arg() - Error (direct use)", {
  
  expect_error(check_character_arg(x = iris), 
               "The argument 'iris' must be a character",
               fixed = TRUE)

  expect_error(check_character_arg(x = 1L), 
               "The argument '1L' must be a character",
               fixed = TRUE)
  
  expect_error(check_character_arg(x = -0.001), 
               "The argument '-0.001' must be a character",
               fixed = TRUE)
  
  expect_error(check_character_arg(x = 1:3), 
               "The argument '1:3' must be a character",
               fixed = TRUE)
})


test_that("Test check_character_arg() - Error (indirect use)", {
  
  expect_error(fake_function(y = iris), 
               "The argument 'y' must be a character",
               fixed = TRUE)

  expect_error(fake_function(y = 1L), 
               "The argument 'y' must be a character",
               fixed = TRUE)

  expect_error(fake_function(y = -0.001), 
               "The argument 'y' must be a character",
               fixed = TRUE)
  
  expect_error(fake_function(y = 1:3), 
               "The argument 'y' must be a character",
               fixed = TRUE)
})


test_that("Test check_character_arg() - Success (direct use)", {
  
  expect_invisible(check_character_arg("AAA"))
  expect_null(x <- check_character_arg("AAA"))

  expect_invisible(check_character_arg(c("AAA", "BBB", "CCC")))
  expect_null(x <- check_character_arg(c("AAA", "BBB", "CCC")))

  expect_invisible(check_character_arg(c("AAA", "BBB", "")))
  expect_null(x <- check_character_arg(c("AAA", "BBB", "")))

  expect_invisible(check_character_arg(c("AAA", "BBB", "", NA)))
  expect_null(x <- check_character_arg(c("AAA", "BBB", "", NA)))
})


test_that("Test check_character_arg() - Success (indirect use)", {
  
  expect_invisible(fake_function(y = "AAA"))
  expect_null(x <- fake_function(y = "AAA"))

  expect_invisible(fake_function(y = c("AAA", "BBB", "CCC")))
  expect_null(x <- fake_function(y = c("AAA", "BBB", "CCC")))

  expect_invisible(fake_function(y = c("AAA", "BBB", "")))
  expect_null(x <- fake_function(y = c("AAA", "BBB", "")))

  expect_invisible(fake_function(y = c("AAA", "BBB", "", NA)))
  expect_null(x <- fake_function(y = c("AAA", "BBB", "", NA)))
})
