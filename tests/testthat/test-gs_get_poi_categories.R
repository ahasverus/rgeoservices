## Tests gs_get_poi_categories() ----

with_mock_dir("gs_get_poi_categories", {

  skip_on_cran()
  skip_if_offline()

  test_that("Test gs_get_poi_categories() - Success", {
    
    x <- gs_get_poi_categories()
    
    expect_true("data.frame" %in% class(x))
    expect_true(ncol(x) == 2L)
    expect_true("type" %in% colnames(x))
    expect_true("category" %in% colnames(x))
  })

}, simplify = FALSE)
