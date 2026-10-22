test_that("gateway returns full-precision JSON and ignores platform fields", {
  js <- gateway(model_input = get_default_input(), execution_id = "z",
                callback_url = "https://example.invalid/cb")
  expect_equal(jsonlite::fromJSON(js)$probability, 0.872984032973488,
               tolerance = 1e-12)
  x <- get_default_input(); x$extra <- NULL; x$note <- ""
  expect_equal(model_run(x)$probability, 0.872984032973488, tolerance = 1e-12)
})
