context('getMLE.R')


test_that("error message occurs when input is not correct format", {

  expect_error(getMLE(), "No defaults specified for distribution, vector")

  expect_error(getMLE(1,2),"Wrong format for both inputs; string,vector of length > 1 expected")

  expect_error(getMLE("1",2),"Wrong format for column input;vector of length > 1 expected")

  expect_error(getMLE(1,c(2,3,2,3)),"Wrong format for distribution input;string expected")

  expect_error(getMLE("bernoulli",c("2","3","2","3")),"Wrong type of vector provided; numeric vector type expected")

  expect_error(getMLE("poisson",list("2",3,"2",3)),"Wrong column type provided; Vector type expected")

  expect_error(getMLE("poisson",c(2,3.3,2.4,5)),"Column vector must only contain integer values")

  expect_error(getMLE("bernoulli",c(2,3.3,2.4,5)),"Column vector must only contain integer values")

  expect_error(getMLE("poisson",c(-2,3.3,2.4,-5)),"Column vector must only contain positive integer values")

  expect_error(getMLE("bernoulli",c(0,1,2,1,0)),"Column vector for bernoulli must only contain 0's and 1's")

})

test_that("when the input is not from available set of inputs", {
  expect_error(getMLE("binomial",c(2,3,4,6)),"Input values for distribution can only take in values; Bernoulli and Poisson")
})


test_that("when the input is not from available set of inputs", {
  expect_error(getMLE("gamma",c(2,3,4,6)),"Input values for distribution can only take in values; Bernoulli and Poisson")
})


test_that("MLE return for poisson distribution of the right ouput",{
  output <- getMLE("bernoulli",c(1,0,1,1,1,0))
  chec_output_type <- typeof(output) == "double"
  expect_that(chec_output_type, is_true())
})


test_that("MLE returns for bernoulli distribution (log likelihood) between 0 and 1",{
  output <- getMLE("bernoulli",c(1,0,0,1,1,1,1,0))
  output_check <- ifelse(output >= 0 & output <= 1, TRUE, FALSE)
  expect_that(output_check,is_true())
})


test_that("MLE returns for poisson distribution (mean) between >=0",{
    output <- getMLE("poisson",c(1,0,2,3,1,1,1,2))
    output_check_mean <- ifelse(mean(output) >= 0,TRUE,FALSE)
    expect_that(output_check_mean,is_true())
})


test_that("MLE return for poisson distribution of the right ouput",{
  output <- getMLE("poisson",c(1,0,1,1,6,5,4,2))
  chec_output_type <- typeof(output) == "double"
  expect_true(chec_output_type)
})
