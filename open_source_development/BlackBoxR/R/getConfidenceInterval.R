#' compute 95% confidence interval (frequentist approach)
#' assume the input samples follow normal distribution
#'
#' @param vector a numeric vector
#'
#' @return vector a numeric vector with two elements only
#'
#'
#' @export
getConfidenceInterval<-function(vector){
  xbar<-mean(vector)
  n<-length(vector)
  sd<-sd(vector)
  lower<-xbar-1.96*(sd/sqrt(n))
  upper<-xbar+1.96*(sd/sqrt(n))

  return(c(lower,upper))

}

