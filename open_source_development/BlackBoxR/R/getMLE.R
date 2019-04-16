  #getMLE

  #' @export
  getMLE<-function(distribution = NULL,column = NULL){
    #compute the log likelihood of data given the distribution
    #
    #Args:
    #distribution: type of distribution of the data. for example (bernoulli, poisson). Support for 2 as of now.
    #column: the column is a vector of numeric data over which we perform the maximum likelihood
    #Return: the log likelihood of the data.For example, mean for poisson, probability for bernoulli
    #
    #


  if (is.null(distribution) & is.null(column)) stop("No defaults specified for distribution, vector")
  if (typeof(distribution) == "character" & (is.atomic(column) == FALSE & length(column)>1)) stop("Wrong column type provided; Vector type expected")
  if (typeof(distribution) != "character" & (is.atomic(column) == FALSE | length(column)==1)) stop("Wrong format for both inputs; string,vector of length > 1 expected")
  if (typeof(distribution) == "character" & (is.atomic(column) == FALSE | length(column)==1)) stop("Wrong format for column input;vector of length > 1 expected")
  if (typeof(distribution) != "character" & (is.atomic(column) == TRUE | length(column)>1)) stop("Wrong format for distribution input;string expected")
  if (typeof(distribution) == "character" & (is.atomic(column) == TRUE & length(column)>1 & !is.numeric(column))) stop("Wrong type of vector provided; numeric vector type expected")
  if(xor(tolower(distribution) != "poisson",tolower(distribution) == "bernoulli") & is.atomic(is.atomic(column) == TRUE)) stop("Input values for distribution can only take in values; Bernoulli and Poisson")
  if (typeof(distribution) == "character" & (is.atomic(column) == TRUE & length(column)>1 & is.numeric(column)) & !isTRUE(all(column == floor(column))) & isTRUE(all(column>=0)) ) stop("Column vector must only contain integer values")
  if (typeof(distribution) == "character" & (is.atomic(column) == TRUE & length(column)>1 & is.numeric(column)) & !isTRUE(all(column == floor(column))) & !isTRUE(all(column>=0))) stop("Column vector must only contain positive integer values")
  if (tolower(distribution) == "bernoulli" & (is.atomic(column) == TRUE & length(column)>1 & is.numeric(column)) & isTRUE(all(column == floor(column))) & isTRUE(all(column>=0)) & !isTRUE(all(column == 0 | column ==1))) stop("Column vector for bernoulli must only contain 0's and 1's")



  if (tolower(distribution) == "bernoulli"){

    possible.p <- seq(0, 1, by = 0.001)

    likelihood.results <- optimize(function(p) {log.likelihood.bernoulli(column, p)},
                                   interval = c(0, 1),
                                   maximum = TRUE)
    return(likelihood.results$maximum)
  }

  else if(tolower(distribution) == "poisson"){

    likelihood.results <- mean(column)

    return(likelihood.results)
  }

  return(NULL)
  }


  log.likelihood.bernoulli <- function(sequence, p)
  {
    log.likelihood <- 0

    for (i in 1:length(sequence))
    {
      if (sequence[i] == 1)
      {
        log.likelihood <- log.likelihood + log(p)
      }
      else
      {
        log.likelihood <- log.likelihood + log(1 - p)
      }
    }
    return(log.likelihood)
  }
