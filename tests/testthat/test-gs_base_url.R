## Tests gs_base_url() ----

test_that("Test gs_base_url() - Success", {
  
  x <- gs_base_url()

  expect_equal(x, "https://data.geopf.fr")
  expect_equal(class(x), "character")
  expect_equal(length(x), 1L)
})
