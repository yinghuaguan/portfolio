#performABtest_freq

#' @export
library(ggplot2)

performABTest <- function(inp_data, alpha = 0.05){
  # perform AB testing using the frequentist approach. The method chosen is based on
  # number of rows in the input data frame.
  #
  # Args:
  #   data: dataframe which consists of events and results
  #   alpha: false positive rate
  #
  # Return: a list containing
  #   1. p-value
  #   2. plot of p-values over runs
  #   3. method used to compute p-value
  #
  # source: https://www.inwt-statistics.com/read-blog/ab-testing.html
  # This gave me the idea of plotting p-values across runs to point to the user
  # why they could go wrong if they stop the test when they encounter a significant value.

  # Check to see if data is NULL
  if(is.null(inp_data)){
    stop("Need to pass in a dataframe")
  } else if (!is.data.frame(inp_data)) {
    stop("Parameter inp_data is not a data frame")
  } else if (alpha > 1 | alpha < 0) {
    stop("False positive rate cannot be greater than 1 or less than 0")
  } else if (nlevels(inp_data$name) != 2) {
    stop("Number of events cannot have more than 2 unique values")
  } else if (!all(levels(as.factor(inp_data$events)) %in% c(0,1))) {
    stop("The event column cannot have more than 2 levels for AB testing")
  } else if (nrow(inp_data) < 20) {
    stop("Need at least 20 rows as input")
  }

  # Shuffle the dataframe. This is done so that when Fisher's test is run both events
  # have an equal chance of finding it
  inp_data <- inp_data[sample(nrow(inp_data)),]

  size <- nrow(inp_data)
  # Computing p-values after every observation to prove why it's wrong
  op <- data.frame(index = numeric()
                   ,p_val = numeric()
  )

  # For greater than 2000 rows use the Chi square test or use the Fisher test
  if (size > 2000) {
    method <- "Chi-sq"
    for (i in 1500:size) {
      data <- table(inp_data[1:i,])

      ## Check if rows obatined have 2 levels or not
      if(nlevels(inp_data$name[1:i]) == 2) {
        test_val <- data.frame(index = i,
                               p_val = chisq.test(data)$p.value
        )
        op <- rbind(op,test_val)
      }
    }
  } else if (size <= 2000) {
    method <- "Fishers"
    for (i in 20:size) {
        data <- table(inp_data[1:i,])

        ## Check if rows obatined have 2 levels or not
        if(nlevels(inp_data$name[1:i]) == 2) {
          test_val <- data.frame(index = i,
                                 p_val = fisher.test(data)$p.value
          )
          op <- rbind(op,test_val)
        }
    }
  }


  #create plot of p-values
  p_val_plot <- ggplot(op, aes(x = index, y = p_val)) +
    geom_line() +
    geom_hline(aes(yintercept = alpha),color = "red") +
    scale_y_continuous(name = "p-value", limits = c(0,1)) +
    scale_x_continuous(name = "Observed data points") +
    annotate("text", label = paste("Alpha =",alpha), x = size - size/10, y = alpha + 0.05, color = "black")

  return(list(tail(op,1),p_val_plot,method))

}

