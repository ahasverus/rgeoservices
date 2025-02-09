## Tests gs_get_elevation() ----

bad_coords  <- c(-3.7037902, 40.4167754)
good_coords <- c( 3.5960877, 44.3269017)

test_that("Test gs_get_elevation() - Error (longitude)", {
  
  expect_error(
    gs_get_elevation(latitude = good_coords[2]), 
    "The argument 'longitude' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_elevation(longitude = NULL,
                     latitude  = good_coords[2]), 
    "The argument 'longitude' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_elevation(longitude = NA,
                     latitude  = good_coords[2]), 
    "The argument 'longitude' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_elevation(longitude = "good_coords",
                     latitude  = good_coords[2]), 
    "The argument 'longitude' must be a numeric",
    fixed = TRUE
  )
})


test_that("Test gs_get_elevation() - Error (latitude)", {

  expect_error(
    gs_get_elevation(longitude = good_coords[1]), 
    "The argument 'latitude' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_elevation(longitude = good_coords[1],
                     latitude  = NULL), 
    "The argument 'latitude' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_elevation(longitude = good_coords[1],
                     latitude  = NA), 
    "The argument 'latitude' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_elevation(longitude = good_coords[1],
                     latitude  = "good_coords"), 
    "The argument 'latitude' must be a numeric",
    fixed = TRUE
  )
})


test_that("Test gs_get_elevation() - Error (coordinates)", {

  expect_error(
    gs_get_elevation(longitude = bad_coords[1],
                     latitude  = bad_coords[2]), 
    "This function only works with French (mainland) location",
    fixed = TRUE
  )
})


with_mock_dir("gs_get_elevation", {

  skip_on_cran()
  skip_if_offline()

  test_that("Test gs_get_elevation() - Success (one location)", {
    
    x <- gs_get_elevation(longitude  = good_coords[1], 
                          latitude   = good_coords[2])
    
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) == 1L)
    expect_true(ncol(x) == 3L)
  })


  test_that("Test gs_get_elevation() - Success (three locations)", {
    
    x <- gs_get_elevation(longitude  = rep(good_coords[1], 3), 
                          latitude   = rep(good_coords[2], 3))
    
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) == 3L)
    expect_true(ncol(x) == 3L)
  })

}, simplify = FALSE)
