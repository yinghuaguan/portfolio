context('getCredibleInterval.R')


#sample
set.seed(1)
sample<-rnorm(5,mean=4,sd=1)


#check valid input
test_that("check if input is in correct format",{
  expect_error(getCredibleInterval(1,2),'argument "sample_dis" is missing, with no default',fixed=TRUE)
  expect_error(getCredibleInterval(), 'argument "prior_dis" is missing, with no default',fixed=TRUE)
  expect_error(getCredibleInterval(sample,c(5,3)), 'sample_dis" is missing, with no default',fixed=TRUE)
})

test_that('vector has at least 1 observation',{
  expect_true(length(sample)>0)
})

test_that('the vector is numeric',{
  expect_true(typeof(sample)=='double'|typeof(sample)=='integer')
})


#check valid output
test_that('the output has two elements only',{
  expect_equal(length(getCredibleInterval(sample,c(3,1),c(4,1))),2)
})



test_that('the output interval is correct',{
  expected_lower<-3.614398
  expected_upper<-4.267719
  expect_true(abs(getCredibleInterval(sample,c(3,1),c(4,1))[1]-expected_lower)<1e-5)
  expect_true(abs(getCredibleInterval(sample,c(3,1),c(4,1))[2]-expected_upper)<1e-5)
})




