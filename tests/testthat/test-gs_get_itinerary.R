## Tests gs_get_itinerary() ----

test_that("Test gs_get_itinerary() - Error (start)", {
  
  expect_error(
    gs_get_itinerary(), 
    "The argument 'start' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(start = NULL), 
    "The argument 'start' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(start = NA), 
    "The argument 'start' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(start = ""), 
    "The argument 'start' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(start = "toto"), 
    "The argument 'start' must be a numeric",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(start = 1), 
    "The argument 'start' must be of length 2",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(start = c(-90, 43.59884)), 
    "This function only works with French (mainland) location",
    fixed = TRUE
  )
})


test_that("Test gs_get_itinerary() - Error (end)", {
  
  expect_error(
    gs_get_itinerary(
      start = c(3.708864, 43.93584)
    ), 
    "The argument 'end' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start = c(3.708864, 43.93584), 
      end   = NULL
    ), 
    "The argument 'end' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start = c(3.708864, 43.93584), 
      end   = NA
    ), 
    "The argument 'end' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start = c(3.708864, 43.93584), 
      end   = ""
    ), 
    "The argument 'end' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start = c(3.708864, 43.93584), 
      end   = "toto"
    ), 
    "The argument 'end' must be a numeric",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start = c(3.708864, 43.93584), 
      end   = 1
    ), 
    "The argument 'end' must be of length 2",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start = c(  3.708864, 43.93584), 
      end   = c(-90.000000, 43.59884)
    ), 
    "This function only works with French (mainland) location",
    fixed = TRUE
  )
})


test_that("Test gs_get_itinerary() - Error (intermediates)", {
  
  expect_error(
    gs_get_itinerary(
      start         = c(3.708864, 43.93584), 
      end           = c(4.077405, 44.12519),
      intermediates = NA 
    ), 
    "The argument 'intermediates' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start         = c(3.708864, 43.93584), 
      end           = c(4.077405, 44.12519),
      intermediates = "" 
    ), 
    "The argument 'intermediates' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start         = c(3.708864, 43.93584), 
      end           = c(4.077405, 44.12519),
      intermediates = list()
    ),  
    "The argument 'intermediates' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start         = c(3.708864, 43.93584), 
      end           = c(4.077405, 44.12519),
      intermediates = c(4.121500, 43.96609)
    ),  
    "The argument 'intermediates' must be a list",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start         = c(3.708864, 43.93584), 
      end           = c(4.077405, 44.12519),
      intermediates = list(4.077405)
    ),  
    "Each element of 'intermediates' must be a two-value vector",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start         = c(3.708864, 43.93584), 
      end           = c(4.077405, 44.12519),
      intermediates = list(4.077405, c(4.121500, 43.96609))
    ),  
    "Each element of 'intermediates' must be a two-value vector",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start         = c(3.708864, 43.93584), 
      end           = c(4.077405, 44.12519),
      intermediates = list(c(4.121500, 43.96609, 90))
    ),  
    "Each element of 'intermediates' must be a two-value vector",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start         = c(3.708864, 43.93584), 
      end           = c(4.077405, 44.12519),
      intermediates = list(c(4.121500, 43.96609), c("toto", "titi"))
    ),  
    "Each element of 'intermediates' must be a numeric vector",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start         = c(3.708864, 43.93584), 
      end           = c(4.077405, 44.12519),
      intermediates = list(c(4.121500, 43.96609), c(-90, 45))
    ),  
    "Some 'intermediates' points are out of mainland France",
    fixed = TRUE
  )
})


test_that("Test gs_get_itinerary() - Error (profile)", {

  expect_error(
    gs_get_itinerary(
      start   = c(3.708864, 43.93584), 
      end     = c(4.077405, 44.12519),
      profile = NULL
    ), 
    "The argument 'profile' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start   = c(3.708864, 43.93584), 
      end     = c(4.077405, 44.12519),
      profile = NA
    ), 
    "The argument 'profile' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start   = c(3.708864, 43.93584), 
      end     = c(4.077405, 44.12519),
      profile = 1
    ), 
    "The argument 'profile' must be a character",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start   = c(3.708864, 43.93584), 
      end     = c(4.077405, 44.12519),
      profile = c("car", "pedestrian")
    ), 
    "The argument 'profile' must be of length 1",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start   = c(3.708864, 43.93584), 
      end     = c(4.077405, 44.12519),
      profile = "toto"
    ), 
    "The argument 'profile' should be one of \"car\", \"pedestrian\"",
    fixed = TRUE
  )
})


test_that("Test gs_get_itinerary() - Error (optimization)", {

  expect_error(
    gs_get_itinerary(
      start        = c(3.708864, 43.93584), 
      end          = c(4.077405, 44.12519),
      optimization = NA
    ), 
    "The argument 'optimization' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start        = c(3.708864, 43.93584), 
      end          = c(4.077405, 44.12519),
      optimization = 1
    ), 
    "The argument 'optimization' must be a character",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start        = c(3.708864, 43.93584), 
      end          = c(4.077405, 44.12519),
      optimization = c("fastest", "shortest")
    ), 
    "The argument 'optimization' must be of length 1",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start        = c(3.708864, 43.93584), 
      end          = c(4.077405, 44.12519),
      optimization = "toto"
    ), 
    "The argument 'optimization' should be one of \"fastest\", \"shortest\"",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start        = c(3.708864, 43.93584), 
      end          = c(4.077405, 44.12519),
      optimization = "fastest",
      profile      = "pedestrian" 
    ), 
    "The argument 'optimization' is not available for profile = 'pedestrian'",
    fixed = TRUE
  )
})


test_that("Test gs_get_itinerary() - Error (time_unit)", {

  expect_error(
    gs_get_itinerary(
      start     = c(3.708864, 43.93584), 
      end       = c(4.077405, 44.12519),
      time_unit = NULL
    ), 
    "The argument 'time_unit' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start     = c(3.708864, 43.93584), 
      end       = c(4.077405, 44.12519),
      time_unit = NA
    ), 
    "The argument 'time_unit' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start     = c(3.708864, 43.93584), 
      end       = c(4.077405, 44.12519),
      time_unit = 1
    ), 
    "The argument 'time_unit' must be a character",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start     = c(3.708864, 43.93584), 
      end       = c(4.077405, 44.12519),
      time_unit = c("hour", "minute")
    ), 
    "The argument 'time_unit' must be of length 1",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start     = c(3.708864, 43.93584), 
      end       = c(4.077405, 44.12519),
      time_unit = "toto"
    ), 
    "The argument 'time_unit' should be one of \"hour\", \"minute\", \"second\"",
    fixed = TRUE
  )
})


test_that("Test gs_get_itinerary() - Error (distance_unit)", {

  expect_error(
    gs_get_itinerary(
      start         = c(3.708864, 43.93584), 
      end           = c(4.077405, 44.12519),
      distance_unit = NULL
    ), 
    "The argument 'distance_unit' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start         = c(3.708864, 43.93584), 
      end           = c(4.077405, 44.12519),
      distance_unit = NA
    ), 
    "The argument 'distance_unit' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start         = c(3.708864, 43.93584), 
      end           = c(4.077405, 44.12519),
      distance_unit = 1
    ), 
    "The argument 'distance_unit' must be a character",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start         = c(3.708864, 43.93584), 
      end           = c(4.077405, 44.12519),
      distance_unit = c("meter", "kilometer")
    ), 
    "The argument 'distance_unit' must be of length 1",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start         = c(3.708864, 43.93584), 
      end           = c(4.077405, 44.12519),
      distance_unit = "toto"
    ), 
    "The argument 'distance_unit' should be one of \"meter\", \"kilometer\"",
    fixed = TRUE
  )
})


test_that("Test gs_get_itinerary() - Error (by_feature)", {

  expect_error(
    gs_get_itinerary(
      start      = c(3.708864, 43.93584), 
      end        = c(4.077405, 44.12519),
      by_feature = NULL
    ), 
    "The argument 'by_feature' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start      = c(3.708864, 43.93584), 
      end        = c(4.077405, 44.12519),
      by_feature = NA
    ), 
    "The argument 'by_feature' is required",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start      = c(3.708864, 43.93584), 
      end        = c(4.077405, 44.12519),
      by_feature = "toto"
    ), 
    "The argument 'by_feature' must be a logical",
    fixed = TRUE
  )

  expect_error(
    gs_get_itinerary(
      start      = c(3.708864, 43.93584), 
      end        = c(4.077405, 44.12519),
      by_feature = c(TRUE, FALSE)
    ), 
    "The argument 'by_feature' must be of length 1",
    fixed = TRUE
  )
})


with_mock_dir("gs_get_itinerary", {

  skip_on_cran()
  skip_if_offline()

  test_that("Test gs_get_itinerary() - Success (default)", {
    
    x <- gs_get_itinerary(
      start = c(3.708864, 43.93584), 
      end   = c(4.077405, 44.12519)
    )
    
    expect_true("sf" %in% class(x))
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) == 1L)
    expect_true(ncol(x) == 7L)

    expect_true(as.character(sf::st_geometry_type(x)) == "LINESTRING")
    expect_true(sf::st_crs(x)$"epsg" == 4326)

    expect_true("profile" %in% colnames(x))
    expect_true("optimization" %in% colnames(x))
    expect_true("distance" %in% colnames(x))
    expect_true("duration" %in% colnames(x))
    expect_true("distance_unit" %in% colnames(x))
    expect_true("time_unit" %in% colnames(x))

    expect_equal(x$"profile", "car")
    expect_equal(x$"optimization", "fastest")
    expect_equal(x$"distance_unit", "kilometer")
    expect_equal(x$"time_unit", "minute")
  })


  test_that("Test gs_get_itinerary() - Success (intermediates)", {
    
    x <- gs_get_itinerary(
      start         = c(3.708864, 43.93584), 
      end           = c(4.077405, 44.12519),
      intermediates = list(c(4.121500, 43.96609))
    )
    
    expect_true("sf" %in% class(x))
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) == 1L)
    expect_true(ncol(x) == 7L)

    expect_true(as.character(sf::st_geometry_type(x)) == "LINESTRING")
    expect_true(sf::st_crs(x)$"epsg" == 4326)

    expect_true("profile" %in% colnames(x))
    expect_true("optimization" %in% colnames(x))
    expect_true("distance" %in% colnames(x))
    expect_true("duration" %in% colnames(x))
    expect_true("distance_unit" %in% colnames(x))
    expect_true("time_unit" %in% colnames(x))

    expect_equal(x$"profile", "car")
    expect_equal(x$"optimization", "fastest")
    expect_equal(x$"distance_unit", "kilometer")
    expect_equal(x$"time_unit", "minute")
  })


  test_that("Test gs_get_itinerary() - Success (profile)", {
    
    x <- gs_get_itinerary(
      start        = c(3.708864, 43.93584), 
      end          = c(4.077405, 44.12519),
      profile      = "pedestrian",
      optimization = NULL
    )
    
    expect_true("sf" %in% class(x))
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) == 1L)
    expect_true(ncol(x) == 7L)

    expect_true(as.character(sf::st_geometry_type(x)) == "LINESTRING")
    expect_true(sf::st_crs(x)$"epsg" == 4326)

    expect_true("profile" %in% colnames(x))
    expect_true("optimization" %in% colnames(x))
    expect_true("distance" %in% colnames(x))
    expect_true("duration" %in% colnames(x))
    expect_true("distance_unit" %in% colnames(x))
    expect_true("time_unit" %in% colnames(x))

    expect_equal(x$"profile", "pedestrian")
    expect_equal(x$"optimization", "shortest")
    expect_equal(x$"distance_unit", "kilometer")
    expect_equal(x$"time_unit", "minute")
  })


  test_that("Test gs_get_itinerary() - Success (optimization)", {
    
    x <- gs_get_itinerary(
      start        = c(3.708864, 43.93584), 
      end          = c(4.077405, 44.12519),
      optimization = "shortest"
    )
    
    expect_true("sf" %in% class(x))
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) == 1L)
    expect_true(ncol(x) == 7L)

    expect_true(as.character(sf::st_geometry_type(x)) == "LINESTRING")
    expect_true(sf::st_crs(x)$"epsg" == 4326)

    expect_true("profile" %in% colnames(x))
    expect_true("optimization" %in% colnames(x))
    expect_true("distance" %in% colnames(x))
    expect_true("duration" %in% colnames(x))
    expect_true("distance_unit" %in% colnames(x))
    expect_true("time_unit" %in% colnames(x))

    expect_equal(x$"profile", "car")
    expect_equal(x$"optimization", "shortest")
    expect_equal(x$"distance_unit", "kilometer")
    expect_equal(x$"time_unit", "minute")
  })


  test_that("Test gs_get_itinerary() - Success (time_unit)", {
    
    x <- gs_get_itinerary(
      start     = c(3.708864, 43.93584), 
      end       = c(4.077405, 44.12519),
      time_unit = "hour"
    )
    
    expect_true("sf" %in% class(x))
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) == 1L)
    expect_true(ncol(x) == 7L)

    expect_true(as.character(sf::st_geometry_type(x)) == "LINESTRING")
    expect_true(sf::st_crs(x)$"epsg" == 4326)

    expect_true("profile" %in% colnames(x))
    expect_true("optimization" %in% colnames(x))
    expect_true("distance" %in% colnames(x))
    expect_true("duration" %in% colnames(x))
    expect_true("distance_unit" %in% colnames(x))
    expect_true("time_unit" %in% colnames(x))

    expect_equal(x$"profile", "car")
    expect_equal(x$"optimization", "fastest")
    expect_equal(x$"distance_unit", "kilometer")
    expect_equal(x$"time_unit", "hour")
  })


  test_that("Test gs_get_itinerary() - Success (distance_unit)", {
    
    x <- gs_get_itinerary(
      start         = c(3.708864, 43.93584), 
      end           = c(4.077405, 44.12519),
      distance_unit = "meter"
    )
    
    expect_true("sf" %in% class(x))
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) == 1L)
    expect_true(ncol(x) == 7L)

    expect_true(as.character(sf::st_geometry_type(x)) == "LINESTRING")
    expect_true(sf::st_crs(x)$"epsg" == 4326)

    expect_true("profile" %in% colnames(x))
    expect_true("optimization" %in% colnames(x))
    expect_true("distance" %in% colnames(x))
    expect_true("duration" %in% colnames(x))
    expect_true("distance_unit" %in% colnames(x))
    expect_true("time_unit" %in% colnames(x))

    expect_equal(x$"profile", "car")
    expect_equal(x$"optimization", "fastest")
    expect_equal(x$"distance_unit", "meter")
    expect_equal(x$"time_unit", "minute")
  })


  test_that("Test gs_get_itinerary() - Success (by_feature)", {
    
    x <- gs_get_itinerary(
      start      = c(3.708864, 43.93584), 
      end        = c(4.077405, 44.12519),
      by_feature = TRUE
    )
    
    expect_true("sf" %in% class(x))
    expect_true("data.frame" %in% class(x))
    expect_true(nrow(x) > 1L)
    expect_true(ncol(x) == 11L)

    expect_true(unique(as.character(sf::st_geometry_type(x))) == "LINESTRING")
    expect_true(sf::st_crs(x)$"epsg" == 4326)

    expect_true("profile" %in% colnames(x))
    expect_true("optimization" %in% colnames(x))
    expect_true("distance" %in% colnames(x))
    expect_true("duration" %in% colnames(x))
    expect_true("distance_unit" %in% colnames(x))
    expect_true("time_unit" %in% colnames(x))

    expect_true("name" %in% colnames(x))
    expect_true("cpx_number" %in% colnames(x))
    expect_true("instruction_type" %in% colnames(x))
    expect_true("instruction_modifier" %in% colnames(x))

    expect_true("car" %in% x$"profile")
    expect_true("fastest" %in% x$"optimization")
    expect_true("kilometer" %in% x$"distance_unit")
    expect_true("minute" %in% x$"time_unit")

    y <- gs_get_itinerary(
      start      = c(3.708864, 43.93584), 
      end        = c(4.077405, 44.12519),
      by_feature = FALSE
    )

    expect_true(round(sum(x$"distance")) == round(y$"distance"))
    expect_true(round(sum(x$"duration")) == round(y$"duration"))
  })

}, simplify = FALSE)
