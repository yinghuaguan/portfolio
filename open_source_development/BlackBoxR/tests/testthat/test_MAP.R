context('getMAP.R')

# a = 2
# b = 2
# column <- rbinom(20,1,0.5)
#
# #Priors
# prior <- rbeta(10000,a,b)
#
# test_that("check if input is in correct format",{
#   expect_error(getMAP(1),'Wrong format for input; numeric binomial vector expected')
#   expect_error(getMAP(NULL), 'need to pass in a column binomial vector')
#   expect_error(getMAP(rbinom(20,1,0.5),c("2","3")),"Type of prior hyperparameter argument is string; numeric type expected")
#   expect_error(getMAP(rbinom(20,1,0.5),c("2",3,"2",3)),"Wrong no of hyperparameter arguments provided; 2 arguments expected")
# })
#
# test_that('dataframe has more than 2 observations for AB testing',{
#   (column=rbinom(2,1,0.5))
#   expect_true(length(column) > 2)
# })
#
# test_that('inputs for prior Beta distribution is valid',{
#   a = "Blackbox"
#   b = "Insignificant"
#   expect_true(typeof(a) == 'integer')
#   expect_true(typeof(b) == 'integer')
#   a = -1.5
#   b = -2.5
#   expect_true(a >= 0)
#   expect_true(b >= 0)
# })
#
#
# test_that('mode returned greater than 0',{
#   output <- getMAP(rbinom(20,2,0.5),c(2,2))
#   expect_true(output > 0)
#   chec_output_type <- typeof(output) == "double"
#   expect_true(chec_output_type)
# })
