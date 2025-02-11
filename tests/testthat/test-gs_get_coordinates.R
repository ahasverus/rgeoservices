## Tests gs_get_coordinates() ----

test_that("Test gs_get_coordinates() - Error (query)", {
  
  expect_error(
    gs_get_coordinates(), 
    "The argument 'query' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query = NULL), 
    "The argument 'query' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query = NA), 
    "The argument 'query' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query = ""), 
    "The argument 'query' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query = 34000), 
    "The argument 'query' must be a character",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query = c("Paris", "Marseille")), 
    "The argument 'query' must be of length 1",
    fixed = TRUE
  )
})


test_that("Test gs_get_coordinates() - Error (limit)", {
  
  expect_error(
    gs_get_coordinates(query = "Paris",
                       limit = NULL), 
    "The argument 'limit' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query = "Paris",
                       limit = NA), 
    "The argument 'limit' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query = "Paris",
                       limit = "15"), 
    "The argument 'limit' must be a numeric",
    fixed = TRUE
  )
  
  expect_error(
    gs_get_coordinates(query = "Paris",
                       limit = 2:4), 
    "The argument 'limit' must be of length 1",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query = "Paris",
                       limit = 0), 
    "The argument 'limit' must be strictly positive",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query = "Paris",
                       limit = -10), 
    "The argument 'limit' must be strictly positive",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query = "Paris",
                       limit = 21), 
    "The argument 'limit' must be between 1 and 20",
    fixed = TRUE
  )
})


test_that("Test gs_get_coordinates() - Error (index)", {

  expect_error(
    gs_get_coordinates(query = "Paris",
                       limit = 1,
                       index = NULL), 
    "The argument 'index' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query = "Paris",
                       limit = 1,
                       index = NA), 
    "The argument 'index' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query = "Paris",
                       limit = 1,
                       index = ""), 
    "The argument 'index' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query = "Paris",
                       limit = 1,
                       index = 12), 
    "The argument 'index' must be a character",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query = "Paris",
                       limit = 1,
                       index = c("address", "poi")), 
    "The argument 'index' must be of length 1",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query = "Paris",
                       limit = 1,
                       index = "city"), 
    "The argument 'index' should be one of \"address\", \"poi\"",
    fixed = TRUE
  )
  
})


test_that("Test gs_get_coordinates() - Error (postcode)", {

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "address", 
                       postcode = NA), 
    "The argument 'postcode' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "address", 
                       postcode = ""), 
    "The argument 'postcode' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "address", 
                       postcode = "toto"), 
    "The argument 'postcode' must be a numeric",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "address", 
                       postcode = -75000), 
    "The argument 'postcode' must be strictly positive",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "address", 
                       postcode = c(75000, 75001)), 
    "The argument 'postcode' must be of length 1",
    fixed = TRUE
  )  
})


test_that("Test gs_get_coordinates() - Error (type)", {

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "address", 
                       postcode = 75000,
                       type     = NA), 
    "The argument 'type' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "address", 
                       postcode = 75000,
                       type     = ""), 
    "The argument 'type' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "address", 
                       postcode = 75000,
                       type     = 12), 
    "The argument 'type' must be a character",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "address", 
                       postcode = 75000,
                       type     = c("housenumber", "street")), 
    "The argument 'type' must be of length 1",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "address", 
                       postcode = 75000,
                       type     = "toto"), 
    paste0("The argument 'type' should be one of \"housenumber\", \"street\", ", 
           "\"street\", \"locality\", \"municipality\""),
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "poi", 
                       postcode = 75000,
                       type     = "housenumber"), 
    "Argument 'type' can be used only with index = 'address'",
    fixed = TRUE
  )
})


test_that("Test gs_get_coordinates() - Error (city)", {

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "address", 
                       postcode = 75000,
                       type     = "street",
                       city     = NA), 
    "The argument 'city' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "address", 
                       postcode = 75000,
                       type     = "street",
                       city     = ""), 
    "The argument 'city' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "address", 
                       postcode = 75000,
                       type     = "street",
                       city     = 12), 
    "The argument 'city' must be a character",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "address", 
                       postcode = 75000,
                       type     = "street",
                       city     = c("Paris", "Paris")), 
    "The argument 'city' must be of length 1",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "address", 
                       postcode = 75000,
                       type     = "street",
                       city     = "Paris"), 
    "Please use 'postcode' or 'city' (not both)",
    fixed = TRUE
  )
})


test_that("Test gs_get_coordinates() - Error (category)", {

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "poi", 
                       category = NA), 
    "The argument 'category' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "poi", 
                       category = ""), 
    "The argument 'category' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "poi", 
                       category = 12), 
    "The argument 'category' must be a character",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "poi", 
                       category = c("lac", "lac")), 
    "The argument 'category' must be of length 1",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "poi", 
                       category = "toto"), 
    "Unvalid value for 'category'. Please use 'gs_get_poi_categories()'",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "address", 
                       category = "lac"), 
    "Argument 'category' can be used only with index = 'poi'",
    fixed = TRUE
  )
})


test_that("Test gs_get_coordinates() - Error (longitude)", {

  expect_error(
    gs_get_coordinates(query     = "Paris",
                       limit     = 1,
                       index     = "poi", 
                       longitude = NA), 
    "The argument 'longitude' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query     = "Paris",
                       limit     = 1,
                       index     = "poi", 
                       longitude = ""), 
    "The argument 'longitude' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query     = "Paris",
                       limit     = 1,
                       index     = "poi", 
                       longitude = "toto"), 
    "The argument 'longitude' must be a numeric",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query     = "Paris",
                       limit     = 1,
                       index     = "poi", 
                       longitude = c(3.3, 2.2)), 
    "The argument 'longitude' must be of length 1",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query     = "Paris",
                       limit     = 1,
                       index     = "poi", 
                       longitude = 2.2), 
    "Please provide both 'longitude' and 'latitude'",
    fixed = TRUE
  )
})


test_that("Test gs_get_coordinates() - Error (latitude)", {

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "poi", 
                       latitude = NA), 
    "The argument 'latitude' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "poi", 
                       latitude = ""), 
    "The argument 'latitude' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "poi", 
                       latitude = "toto"), 
    "The argument 'latitude' must be a numeric",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "poi", 
                       latitude = c(3.3, 2.2)), 
    "The argument 'latitude' must be of length 1",
    fixed = TRUE
  )

  expect_error(
    gs_get_coordinates(query    = "Paris",
                       limit    = 1,
                       index    = "poi", 
                       latitude = 2.2), 
    "Please provide both 'longitude' and 'latitude'",
    fixed = TRUE
  )
})


with_mock_dir("gs_get_coordinates", {

  skip_on_cran()
  skip_if_offline()

  test_that("Test gs_get_coordinates() - Success (default)", {
    
    x <- gs_get_coordinates(query = "1 Place Georges Freche 34000 Montpellier")
    
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) == 10L)
    expect_true(ncol(x) == 14L)
  })


  test_that("Test gs_get_coordinates() - Success (limit)", {
    
    x <- gs_get_coordinates(query = "1 Place Georges Freche 34000 Montpellier",
                            limit = 5)
    
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) ==  5L)
    expect_true(ncol(x) == 14L)
  })


  test_that("Test gs_get_coordinates() - Success (index)", {
    
    x <- gs_get_coordinates(query = "Mairie de Montpellier",
                            index = "poi")
    
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) ==  9L)
    expect_true(ncol(x) == 14L)
  })


  test_that("Test gs_get_coordinates() - Success (postcode)", {
    
    x <- gs_get_coordinates(query    = "Mairie de Montpellier",
                            index    = "poi",
                            postcode = 34000)
    
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) ==  7L)
    expect_true(ncol(x) == 14L)
  })


  test_that("Test gs_get_coordinates() - Success (city)", {
    
    x <- gs_get_coordinates(query = "Mairie de Montpellier",
                            index = "poi",
                            city  = "Montpellier")
    
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) ==  8L)
    expect_true(ncol(x) == 14L)
  })


  test_that("Test gs_get_coordinates() - Success (type)", {
    
    x <- gs_get_coordinates(query = "1 Place Georges Freche",
                            limit = 5,
                            city  = "Montpellier",
                            type  = "housenumber")
    
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) ==  1L)
    expect_true(ncol(x) == 14L)
  })


  test_that("Test gs_get_coordinates() - Success (category)", {
    
    x <- gs_get_coordinates(query    = "Mairie de Montpellier",
                            index    = "poi",
                            city     = "Montpellier",
                            category = "mairie")
    
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) ==  8L)
    expect_true(ncol(x) == 14L)
  })


  test_that("Test gs_get_coordinates() - Success (coords)", {
    
    x <- gs_get_coordinates(query     = "Mairie de Montpellier",
                            index     = "poi",
                            city      = "Montpellier",
                            category  = "mairie",
                            longitude =  3.897,
                            latitude  = 43.628)
    
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) ==  8L)
    expect_true(ncol(x) == 14L)
  })

}, simplify = FALSE)
