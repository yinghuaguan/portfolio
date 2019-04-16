context('performABTest.R')

library(BlackBoxR)
library(testthat)
library(ggplot2)

test_that("check if input is in correct format",{
  df<-data.frame(name=rep(c('A','B'),1),events=rbinom(2,1,0.5))

  expect_error(performABTest(NULL), "Need to pass in a dataframe")
  expect_error(performABTest(1,0.05),"Parameter inp_data is not a data frame")
  expect_error(performABTest(df,1.5),"False positive rate cannot be greater than 1 or less than 0")
  expect_error(performABTest(df,-1.5),"False positive rate cannot be greater than 1 or less than 0")
  expect_error(performABTest(df,0.05),"Need at least 20 rows as input")

  #greater than 2 types of events for less than 2000 rows
  df <- data.frame(name=rep(c('A','B','C'),5),events=rbinom(15,1,0.5))
  expect_error(performABTest(df,0.05), "Number of events cannot have more than 2 unique values")

  #greater than 2 types of events for less than 2000 rows
  df <- data.frame(name=rep(c('A','B','C'),1000),events=rbinom(3000,1,0.5))
  expect_error(performABTest(df,0.05), "Number of events cannot have more than 2 unique values")

  #event results aren't 0 or 1
  df<-data.frame(name=rep(c('A','B'),10),events=rnorm(20,2,0.5))
  expect_error(performABTest(df,0.05), "The event column cannot have more than 2 levels for AB testing")
})

test_that("Check if output is valid",{
  df<-data.frame(name=rep(c('A','B'),100),events=rbinom(200,1,0.5))
  op <- performABTest(df,0.05)
  p_val <- op[[1]]$p_val


  expect_length(op,3) #Check if op returns list of length 3

  #Check if p-value lies between 0 and 1
  output_check_p_val <- ifelse((p_val > 0 & p_val <= 1),TRUE,FALSE)
  expect_that(output_check_p_val,is_true())

})
