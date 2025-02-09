## Tests gs_get_isodistance() ----

bad_coords  <- c(-3.7037902, 40.4167754)
good_coords <- c( 3.5960877, 44.3269017)

test_that("Test gs_get_isodistance() - Error (longitude)", {
  
  expect_error(
    gs_get_isodistance(latitude   = good_coords[2],
                       cost_value = 1), 
    "The argument 'longitude' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude  = NULL,
                       latitude   = good_coords[2],
                       cost_value = 1), 
    "The argument 'longitude' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude  = NA,
                       latitude   = good_coords[2],
                       cost_value = 1), 
    "The argument 'longitude' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude  = "good_coords",
                       latitude   = good_coords[2],
                       cost_value = 1), 
    "The argument 'longitude' must be a numeric",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude  = good_coords,
                       latitude   = good_coords[2],
                       cost_value = 1), 
    "The argument 'longitude' must be of length 1",
    fixed = TRUE
  )
})


test_that("Test gs_get_isodistance() - Error (latitude)", {

  expect_error(
    gs_get_isodistance(longitude  = good_coords[1],
                       cost_value = 1), 
    "The argument 'latitude' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude  = good_coords[1],
                       latitude   = NULL,
                       cost_value = 1), 
    "The argument 'latitude' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude  = good_coords[1],
                       latitude   = NA,
                       cost_value = 1), 
    "The argument 'latitude' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude  = good_coords[1],
                       latitude   = "good_coords",
                       cost_value = 1), 
    "The argument 'latitude' must be a numeric",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude  = good_coords[1],
                       latitude   = good_coords,
                       cost_value = 1), 
    "The argument 'latitude' must be of length 1",
    fixed = TRUE
  )
})


test_that("Test gs_get_isodistance() - Error (cost_value)", {

  expect_error(
    gs_get_isodistance(longitude  = good_coords[1],
                       latitude   = good_coords[2]), 
    "The argument 'cost_value' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude  = good_coords[1],
                       latitude   = good_coords[2],
                       cost_value = NULL), 
    "The argument 'cost_value' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude  = good_coords[1],
                       latitude   = good_coords[2],
                       cost_value = NA), 
    "The argument 'cost_value' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude  = good_coords[1],
                       latitude   = good_coords[2],
                       cost_value = "large"), 
    "The argument 'cost_value' must be a numeric",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude  = good_coords[1],
                       latitude   = good_coords[2],
                       cost_value = c(1, 30)), 
    "The argument 'cost_value' must be of length 1",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude  = good_coords[1],
                       latitude   = good_coords[2],
                       cost_value = 0), 
    "The argument 'cost_value' must be strictly positive",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude  = good_coords[1],
                       latitude   = good_coords[2],
                       cost_value = -10), 
    "The argument 'cost_value' must be strictly positive",
    fixed = TRUE
  )
})


test_that("Test gs_get_isodistance() - Error (profile)", {

  expect_error(
    gs_get_isodistance(longitude  = good_coords[1],
                       latitude   = good_coords[2],
                       cost_value = 1,
                       profile    = NULL), 
    "The argument 'profile' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude  = good_coords[1],
                       latitude   = good_coords[2],
                       cost_value = 1,
                       profile    = NA), 
    "The argument 'profile' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude  = good_coords[1],
                       latitude   = good_coords[2],
                       cost_value = 1,
                       profile    = 1), 
    "The argument 'profile' must be a character",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude  = good_coords[1],
                       latitude   = good_coords[2],
                       cost_value = 1,
                       profile    = c("car", "pedestrian")), 
    "The argument 'profile' must be of length 1",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude  = good_coords[1],
                       latitude   = good_coords[2],
                       cost_value = 1,
                       profile    = "toto"), 
    "The argument 'profile' should be one of \"car\", \"pedestrian\"",
    fixed = TRUE
  )
})


test_that("Test gs_get_isodistance() - Error (direction)", {

  expect_error(
    gs_get_isodistance(longitude  = good_coords[1],
                       latitude   = good_coords[2],
                       cost_value = 1,
                       profile    = "car",
                       direction  = NULL), 
    "The argument 'direction' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude  = good_coords[1],
                       latitude   = good_coords[2],
                       cost_value = 1,
                       profile    = "car",
                       direction  = NA), 
    "The argument 'direction' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude  = good_coords[1],
                       latitude   = good_coords[2],
                       cost_value = 1,
                       profile    = "car",
                       direction  = 1), 
    "The argument 'direction' must be a character",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude  = good_coords[1],
                       latitude   = good_coords[2],
                       cost_value = 1,
                       profile    = "car",
                       direction  = c("arrival", "departure")), 
    "The argument 'direction' must be of length 1",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude  = good_coords[1],
                       latitude   = good_coords[2],
                       cost_value = 1,
                       profile    = "car",
                       direction  = "toto"), 
    "The argument 'direction' should be one of \"departure\", \"arrival\"",
    fixed = TRUE
  )
})


test_that("Test gs_get_isodistance() - Error (distance_unit)", {

  expect_error(
    gs_get_isodistance(longitude     = good_coords[1],
                       latitude      = good_coords[2],
                       cost_value    = 1,
                       profile       = "car",
                       direction     = "departure",
                       distance_unit = NULL), 
    "The argument 'distance_unit' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude     = good_coords[1],
                       latitude      = good_coords[2],
                       cost_value    = 1,
                       profile       = "car",
                       direction     = "departure",
                       distance_unit = NA), 
    "The argument 'distance_unit' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude     = good_coords[1],
                       latitude      = good_coords[2],
                       cost_value    = 1,
                       profile       = "car",
                       direction     = "departure",
                       distance_unit = 1), 
    "The argument 'distance_unit' must be a character",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude     = good_coords[1],
                       latitude      = good_coords[2],
                       cost_value    = 1,
                       profile       = "car",
                       direction     = "departure",
                       distance_unit = c("meter", "kilometer")), 
    "The argument 'distance_unit' must be of length 1",
    fixed = TRUE
  )

  expect_error(
    gs_get_isodistance(longitude     = good_coords[1],
                       latitude      = good_coords[2],
                       cost_value    = 1,
                       profile       = "car",
                       direction     = "departure",
                       distance_unit = "toto"), 
    "The argument 'distance_unit' should be one of \"meter\", \"kilometer\"",
    fixed = TRUE
  )
})


test_that("Test gs_get_isodistance() - Error (coordinates)", {

  expect_error(
    gs_get_isodistance(longitude  = bad_coords[1],
                       latitude   = bad_coords[2],
                       cost_value = 1), 
    "This function only works with French (mainland) location",
    fixed = TRUE
  )
})


with_mock_dir("gs_get_isodistance", {

  skip_on_cran()
  skip_if_offline()

  test_that("Test gs_get_isodistance() - Success (default)", {
    
    x <- gs_get_isodistance(longitude  = good_coords[1], 
                            latitude   = good_coords[2],
                            cost_value = 10)
    
    expect_true("sf" %in% class(x))
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) == 1L)
    expect_true(ncol(x) == 1L)

    expect_true(as.character(sf::st_geometry_type(x)) == "POLYGON")
    expect_true(sf::st_crs(x)$"epsg" == 4326)

    pts <- data.frame(good_coords[1], good_coords[2]) |> 
      sf::st_as_sf(coords = 1:2, crs = sf::st_crs(4326))

    expect_true(sf::st_intersects(pts, x, sparse = FALSE))
  })


  test_that("Test gs_get_isodistance() - Success (profile)", {
    
    x <- gs_get_isodistance(longitude  = good_coords[1], 
                            latitude   = good_coords[2],
                            cost_value = 10,
                            profile    = "pedestrian")
    
    expect_true("sf" %in% class(x))
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) == 1L)
    expect_true(ncol(x) == 1L)

    expect_true(as.character(sf::st_geometry_type(x)) == "POLYGON")
    expect_true(sf::st_crs(x)$"epsg" == 4326)

    pts <- data.frame(good_coords[1], good_coords[2]) |> 
      sf::st_as_sf(coords = 1:2, crs = sf::st_crs(4326))

    expect_true(sf::st_intersects(pts, x, sparse = FALSE))
  })


  test_that("Test gs_get_isodistance() - Success (direction)", {
    
    x <- gs_get_isodistance(longitude  = good_coords[1], 
                            latitude   = good_coords[2],
                            cost_value = 10,
                            profile    = "pedestrian",
                            direction  = "arrival")
    
    expect_true("sf" %in% class(x))
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) == 1L)
    expect_true(ncol(x) == 1L)

    expect_true(as.character(sf::st_geometry_type(x)) == "POLYGON")
    expect_true(sf::st_crs(x)$"epsg" == 4326)

    pts <- data.frame(good_coords[1], good_coords[2]) |> 
      sf::st_as_sf(coords = 1:2, crs = sf::st_crs(4326))

    expect_true(sf::st_intersects(pts, x, sparse = FALSE))
  })


  test_that("Test gs_get_isodistance() - Success (distance_unit)", {
    
    x <- gs_get_isodistance(longitude     = good_coords[1], 
                            latitude      = good_coords[2],
                            cost_value    = 10000,
                            profile       = "car",
                            direction     = "departure",
                            distance_unit = "meter")
    
    expect_true("sf" %in% class(x))
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) == 1L)
    expect_true(ncol(x) == 1L)

    expect_true(as.character(sf::st_geometry_type(x)) == "POLYGON")
    expect_true(sf::st_crs(x)$"epsg" == 4326)

    pts <- data.frame(good_coords[1], good_coords[2]) |> 
      sf::st_as_sf(coords = 1:2, crs = sf::st_crs(4326))

    expect_true(sf::st_intersects(pts, x, sparse = FALSE))
  })

}, simplify = FALSE)
