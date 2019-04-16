require(dplyr)
require(httr)

context("Testing search_cat")

test_that("search_cat() returns name, rating and review count of 50 businesses that are matched based on information provided", {

  # test expected type of the output
  expect_equal(
    is.data.frame(
      search_cat(Sys.getenv("yelp_key"),
                 'cafe',
                 'Vancouver')),
    TRUE)

  # test how the function handles bad inputs

  # test if the key is a string, if not, yield an error
  expect_error(search_cat(list('dniwufowwfw'),
                            'cafe',
                            'Vancouver'),
               "Error: Yelp key type is not accepted, expected a string instead")
  # test if category is a string, if not, yield an error
  expect_error(search_cat(Sys.getenv("yelp_key"),
                            2,
                            'Vancouver'),
               "Error: Category type is not accepted, expected a string instead")
  # test if location is a string, if not, yield an error
  expect_error(search_cat(Sys.getenv("yelp_key"),
                            'cafe',
                            list('Kelowna')),
               "Error: City name is not accepted, expected a string instead")
  # test if yelp key can access the yelp api
  expect_error(search_cat('MMhy9cdkwK7WnYx',
                            'cafe',
                            'Kelowna'),
               "Error: Invalid Yelp key")
})
