library(ggplot2)
library(ggmap)
library(httr)

context("Testing location_map")

test_that("location_map(yelp_key, category, city) returns a google map", {

  # check that the produced output is a plot
  expect_equal(
    is.ggplot(
      location_map(Sys.getenv("yelp_key"),
                   'cafe',
                   'Vancouver')),
    TRUE)

  # expected errors
  expect_error(location_map(list('dniwufowwfw'),
                            'cafe',
                            'Vancouver'),
               "Error: Yelp key type is not accepted, expected a string instead")
  expect_error(location_map(Sys.getenv("yelp_key"),
                            2,
                            'Vancouver'),
               "Error: Category type is not accepted, expected a string instead")
  expect_error(location_map(Sys.getenv("yelp_key"),
                            'cafe',
                            list('Kelowna')),
               "Error: City name is not accepted, expected a string instead")
  expect_error(location_map('MMhy9cdkwK7WnYx',
                            'cafe',
                            'Kelowna'),
               "Error: Invalid Yelp key")
})
