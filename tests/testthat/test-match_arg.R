## Tests match_arg() ----

fake_function <- function(y, values) {
  match_arg(x = y, values = values)
}

test_that("Test match_arg() - Error (direct use)", {
  
  expect_error(match_arg(x = "toto", values = c("titi", "tutu")), 
               "The argument '\"toto\"' should be one of \"titi\", \"tutu\"",
               fixed = TRUE)

  expect_error(match_arg(x = "toto", values = c("titi", "tototo")), 
               "The argument '\"toto\"' should be one of \"titi\", \"tototo\"",
               fixed = TRUE)
  
  expect_error(match_arg(x = 15, values = c(10, 12)), 
               "The argument '15' should be one of \"10\", \"12\"",
               fixed = TRUE)
})


test_that("Test match_arg() - Error (indirect use)", {
  
  expect_error(fake_function(y = "toto", values = c("titi", "tutu")), 
               "The argument 'y' should be one of \"titi\", \"tutu\"",
               fixed = TRUE)
  
  expect_error(fake_function(y = "toto", values = c("titi", "tototo")), 
               "The argument 'y' should be one of \"titi\", \"tototo\"",
               fixed = TRUE)

  expect_error(fake_function(y = 15, values = c(10, 12)), 
               "The argument 'y' should be one of \"10\", \"12\"",
               fixed = TRUE)
})


test_that("Test match_arg() - Success (direct use)", {
  
  expect_invisible(match_arg("toto", values = c("toto", "tutu")))
  expect_null(x <- match_arg("toto", values = c("toto", "tutu")))

  expect_invisible(match_arg("toto", values = c("TOTO", "TUTU")))
  expect_null(x <- match_arg("toto", values = c("TOTO", "TUTU")))

  expect_invisible(match_arg(15, values = c(12, 15)))
  expect_null(x <- match_arg(15, values = c(12, 15)))
})


test_that("Test match_arg() - Success (indirect use)", {
  
  expect_invisible(fake_function("toto", values = c("toto", "tutu")))
  expect_null(x <- fake_function("toto", values = c("toto", "tutu")))

  expect_invisible(fake_function("toto", values = c("TOTO", "TUTU")))
  expect_null(x <- fake_function("toto", values = c("TOTO", "TUTU")))

  expect_invisible(fake_function(15, values = c(12, 15)))
  expect_null(x <- fake_function(15, values = c(12, 15)))
})
