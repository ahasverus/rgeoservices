## Tests gs_get_geocode() ----

test_that("Test gs_get_geocode() - Error (longitude)", {
  
  expect_error(
    gs_get_geocode(), 
    "The argument 'longitude' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = NULL), 
    "The argument 'longitude' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = NA), 
    "The argument 'longitude' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = ""), 
    "The argument 'longitude' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = "toto"), 
    "The argument 'longitude' must be a numeric",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 12:14), 
    "The argument 'longitude' must be of length 1",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = -90,
                   latitude  = 43.59884), 
    "This function only works with French (mainland) location",
    fixed = TRUE
  )
})


test_that("Test gs_get_geocode() - Error (latitude)", {
  
  expect_error(
    gs_get_geocode(longitude = 3.896549), 
    "The argument 'latitude' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = NULL), 
    "The argument 'latitude' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = NA), 
    "The argument 'latitude' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = ""),  
    "The argument 'latitude' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = "toto"),  
    "The argument 'latitude' must be a numeric",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 12:14), 
    "The argument 'latitude' must be of length 1",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = -45), 
    "This function only works with French (mainland) location",
    fixed = TRUE
  )
})


test_that("Test gs_get_geocode() - Error (limit)", {
  
  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = NULL), 
    "The argument 'limit' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     =  NA), 
    "The argument 'limit' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     =  "15"), 
    "The argument 'limit' must be a numeric",
    fixed = TRUE
  )
  
  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 2:4), 
    "The argument 'limit' must be of length 1",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 0), 
    "The argument 'limit' must be strictly positive",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = -10), 
    "The argument 'limit' must be strictly positive",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 21), 
    "The argument 'limit' must be between 1 and 20",
    fixed = TRUE
  )
})


test_that("Test gs_get_geocode() - Error (index)", {

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = NULL), 
    "The argument 'index' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = NA), 
    "The argument 'index' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = ""), 
    "The argument 'index' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = 12), 
    "The argument 'index' must be a character",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = c("address", "poi")), 
    "The argument 'index' must be of length 1",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = "city"), 
    "The argument 'index' should be one of \"address\", \"poi\"",
    fixed = TRUE
  )
})


test_that("Test gs_get_geocode() - Error (postcode)", {

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = "address", 
                   postcode  = NA), 
    "The argument 'postcode' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = "address", 
                   postcode  = ""), 
    "The argument 'postcode' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = "address", 
                   postcode  = "toto"), 
    "The argument 'postcode' must be a numeric",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = "address", 
                   postcode  = -75000), 
    "The argument 'postcode' must be strictly positive",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = "address", 
                   postcode  = c(75000, 75001)), 
    "The argument 'postcode' must be of length 1",
    fixed = TRUE
  )  
})


test_that("Test gs_get_geocode() - Error (type)", {

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = "address", 
                   postcode  = 75000,
                   type      = NA), 
    "The argument 'type' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = "address", 
                   postcode  = 75000,
                   type      = ""), 
    "The argument 'type' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = "address", 
                   postcode  = 75000,
                   type      = 12), 
    "The argument 'type' must be a character",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = "address", 
                   postcode  = 75000,
                   type      = c("housenumber", "street")), 
    "The argument 'type' must be of length 1",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = "address", 
                   postcode  = 75000,
                   type      = "toto"), 
    paste0("The argument 'type' should be one of \"housenumber\", \"street\", ", 
           "\"street\", \"locality\", \"municipality\""),
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = "poi", 
                   postcode  = 75000,
                   type      = "housenumber"), 
    "Argument 'type' can be used only with index = 'address'",
    fixed = TRUE
  )
})


test_that("Test gs_get_geocode() - Error (city)", {

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = "address", 
                   type      = "housenumber",
                   city      = NA), 
    "The argument 'city' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = "address", 
                   type      = "housenumber",
                   city      = ""), 
    "The argument 'city' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = "address", 
                   type      = "housenumber",
                   city      = 12), 
    "The argument 'city' must be a character",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = "address", 
                   type      = "housenumber",
                   city      = c("Paris", "Paris")), 
    "The argument 'city' must be of length 1",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = "address", 
                   postcode  = 75000,
                   type      = "housenumber",
                   city      = "Paris"), 
    "Please use 'postcode' or 'city' (not both)",
    fixed = TRUE
  )
})


test_that("Test gs_get_geocode() - Error (category)", {

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = "poi", 
                   category  = NA), 
    "The argument 'category' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = "poi", 
                   category  = ""), 
    "The argument 'category' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = "poi", 
                   category  = 12), 
    "The argument 'category' must be a character",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = "poi", 
                   category  = c("lac", "lac")), 
    "The argument 'category' must be of length 1",
    fixed = TRUE
  )

  expect_error(
    gs_get_geocode(longitude = 3.896549,
                   latitude  = 43.59884,
                   limit     = 1,
                   index     = "address", 
                   category  = "lac"), 
    "Argument 'category' can be used only with index = 'poi'",
    fixed = TRUE
  )
})

with_mock_dir("gs_get_geocode_error", {

  skip_on_cran()
  skip_if_offline()

  test_that("Test gs_get_geocode() - Error (poi category)", {

    expect_error(
      gs_get_geocode(longitude = 3.896549,
                     latitude  = 43.59884,
                     limit     = 1,
                     index     = "poi", 
                     category  = "toto"), 
      "Unvalid value for 'category'. Please use 'gs_get_poi_categories()'",
      fixed = TRUE
    )
  })
}, simplify = FALSE)


with_mock_dir("gs_get_geocode", {

  skip_on_cran()
  skip_if_offline()

  test_that("Test gs_get_geocode() - Success (default)", {
    
    x <- gs_get_geocode(longitude = 3.896549,
                        latitude  = 43.59884)
    
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) == 10L)
    expect_true(ncol(x) == 16L)
  })


  test_that("Test gs_get_geocode() - Success (limit)", {
    
    x <- gs_get_geocode(longitude = 3.896549,
                        latitude  = 43.59884,
                        limit     = 5)
    
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) ==  5L)
    expect_true(ncol(x) == 16L)
  })


  test_that("Test gs_get_geocode() - Success (index)", {
    
    x <- gs_get_geocode(longitude = 3.896549,
                        latitude  = 43.59884,
                        index     = "poi")
    
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) == 10L)
    expect_true(ncol(x) == 16L)
  })


  test_that("Test gs_get_geocode() - Success (postcode)", {
    
    x <- gs_get_geocode(longitude = 3.896549,
                        latitude  = 43.59884,
                        index     = "poi",
                        postcode  = 34000)
    
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) ==  7L)
    expect_true(ncol(x) == 16L)
  })


  test_that("Test gs_get_geocode() - Success (city)", {
    
    x <- gs_get_geocode(longitude = 3.896549,
                        latitude  = 43.59884,
                        index     = "poi",
                        city      = "Montpellier")
    
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) ==  7L)
    expect_true(ncol(x) == 16L)
  })


  test_that("Test gs_get_geocode() - Success (type)", {
    
    x <- gs_get_geocode(longitude = 3.896549,
                        latitude  = 43.59884,
                        limit     = 5,
                        city      = "Montpellier",
                        type      = "housenumber")
    
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) ==  5L)
    expect_true(ncol(x) == 16L)
  })


  test_that("Test gs_get_geocode() - Success (category)", {
    
    x <- gs_get_geocode(longitude = 3.896549,
                        latitude  = 43.59884,
                        index     = "poi",
                        city      = "Montpellier",
                        category  = "mairie")
    
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) ==  1L)
    expect_true(ncol(x) == 16L)
  })
}, simplify = FALSE)
