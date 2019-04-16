#getMAP

#' @export
getMAP<-function(column,prior_hyperparameters){
  #calculate the maximum a posteriori (MAP) estimation. MAP estimate is the mode of the posterior. MAP is proportional to likelihood function and prior.
  # It is called the denormalized posterior.
  #Args:
  #column: the column is a vector of numerical binomial data. Support for only binomial currently. We will be using Beta-Binomia Conjugacy as an example
  #for first time learners
  #prior_hyperparameters: optional argument. Provided by the user as a numeric vector. If not, we will assume a prior.
  #Return: the MAP estimate of the posterior.
  #
  #
  return(NULL)
}
