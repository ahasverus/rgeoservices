## Tests check_if_in_france() ----

fake_function <- function(longitude, latitude) {
  check_if_in_france(x = longitude, y = latitude)
}

bad_coords  <- c(-3.7037902, 40.4167754)
good_coords <- c( 3.5960877, 44.3269017)

test_that("Test check_if_in_france() - Error (direct use)", {
  
  expect_error(check_if_in_france(x = bad_coords[1], y = bad_coords[2]), 
               "This function only works with French (mainland) location",
               fixed = TRUE)
})


test_that("Test check_if_in_france() - Error (indirect use)", {
  
  expect_error(fake_function(bad_coords[1], bad_coords[2]), 
               "This function only works with French (mainland) location",
               fixed = TRUE)
})


test_that("Test check_if_in_france() - Success (direct use)", {
  
  expect_invisible(check_if_in_france(good_coords[1], good_coords[2]))
  expect_null(x <- check_if_in_france(good_coords[1], good_coords[2]))
})


test_that("Test check_if_in_france() - Success (indirect use)", {
  
  expect_invisible(fake_function(good_coords[1], good_coords[2]))
  expect_null(x <- fake_function(good_coords[1], good_coords[2]))
})
