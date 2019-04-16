# context('performABTest_Bayesian.R')
#
#
# df<-data.frame(name=rep(c('A','B'),10),events=rbinom(20,1,0.5))
# #Priors
# a = 2
# b = 2
# prior <- rbeta(10000,2,2)
#
# test_that("check if input is in correct format",{
#   expect_error(performABtest_Bayesian(1),'Wrong format for input')
#   expect_error(performABtest_Bayesian(NULL), 'need to pass in a dataframe')
# })
#
# test_that('dataframe has more than 2 observations for AB testing',{
#   df<-data.frame(name=rep(c('A','B'),1),events=rbinom(2,1,0.5))
#   expect_true(nrow(df) > 2)
# })
#
# test_that('inputs for prior Beta distribution is valid',{
#   a = "Blackbox"
#   b = "Insignificant"
#   expect_true(typeof(a) == 'integer')
#   expect_true(typeof(b) == 'integer')
#   a = -0.5
#   b = -2
#   expect_true(a >= 0)
#   expect_true(b >= 0)
# })
#
#
# test_that('the first column of dataframe is categorical and can have only 2 levels(event a/event b)',{
#   df<-data.frame(name=rep(c('A','B','C'),10),events=rnorm(30,2,0.5))
#   expect_true(typeof(df[,1]) == 'integer')
#   df <- data.frame(name=rep(c('A','B','C'),5),events=rbinom(15,1,0.5))
#   expect_true(nlevels(df[,1]) == 2)
# })
#
# test_that('the second column of dataframe is categorical and can have only 2 levels(Yes/No)',{
#   df<-data.frame(name=rep(c('A','B','C'),10),events=rnorm(30,2,0.5))
#   expect_true(typeof(df[,2])=='integer')
#   df<-data.frame(name=rep(c('A','B','C'),10),events=rbinom(30,2,0.5))
#   expect_true(nlevels(df[,2]) == 2)
# })
#
# test_that('p-value is less than or equal to 1 and greater than 0',{
#   expect_true(performABtest_Bayesian(df)$`p.value`> 0)
#   expect_true(performABtest_Bayesian(df)$`p.value`< 1)
# })
