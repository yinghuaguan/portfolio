# add tests for delivery_list function
library(testthat)
library(httr)

context("Test delivery_list")

test_that("delivery_list() returns a dataframe of max 20 restaruant that can
          deliver to a selected address based on selected order", {
  # expected outputs:
  # 1
  expect_equal(typeof(delivery_list(Sys.getenv("yelp_key"), "98104", "Rating")), "list")
  # 2
  expect_equal(typeof(delivery_list(Sys.getenv("yelp_key"), "98104", "Price")$Price), "integer")
  # 3
  expect_equal(typeof(delivery_list(Sys.getenv("yelp_key"), "98104", "Rating")$Rating), "integer")
  # 4
  expect_equal(typeof(delivery_list(Sys.getenv("yelp_key"), "98104", "Review_number")$Review_number),"integer")
  # 5
  expect_equal(nrow(delivery_list(Sys.getenv("yelp_key"), "10435", "Review_number")),1)


  # expect_errors:
  ## test if yelp key is string, if not yield error
  # 5
  expect_error(delivery_list(1, "98104", "Rating"), "Error: Yelp key type is not accepted, expected a string instead")

  ## test if location is string, if not yield error
  expect_error(delivery_list(Sys.getenv("yelp_key"), 98104,"Rating"), "Error: category type is not accepted, expected a string instead")

  ## test if order method is string, if not yield error
  expect_error(delivery_list(Sys.getenv("yelp_key"), "98104",6), "Error: order is not accepted, expected a string instead")

  ## test if yelp key can access the yelp api
  # 8
  expect_error(delivery_list("hsFiGl9euSoE1xBAx", "98104", "Rating"),"Error: Invalid Yelp key")
})


