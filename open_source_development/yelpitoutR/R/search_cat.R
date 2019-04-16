#' Produces a dataframe containing names, ratings and review counts of 50 businesses on Yelp
#
#' @title search_cat
#' @param yelp_key a string representing the Yelp API key
#' @param category a string representing the category of the business
#' @param city a string representing a city name
#' @return a dataframe containing business name, rating and review count
#'
#' @import httr
#'
#' @export
#'
#' @examples
#' search_cat(Sys.getenv("yelp_key"), "cafe", "Vancouver")

search_cat <- function(yelp_key, category, city) {

  # check the type of inputs, we expect Yelp key, category and city name are all strings
  if (is.character(yelp_key) == FALSE) {
    stop("Error: Yelp key type is not accepted, expected a string instead")
  }
  if (is.character(category) == FALSE) {
    stop("Error: Category type is not accepted, expected a string instead")
  }
  if (is.character(city) == FALSE) {
    stop("Error: City name is not accepted, expected a string instead")
  }

  # access the Yelp API
  get_yelp <- GET('https://api.yelp.com/v3/businesses/search',
                  query = list(term = category, location = city, limit = 50),
                  add_headers(Authorization = paste('bearer', yelp_key)))

  # check whether the key is valid for Yelp API
  if (status_code(get_yelp) == 401) {
    stop("Error: Invalid Yelp key")
  }

  tryCatch({

    # get the result and only take name, rating and review count from the business object
    result <- content(get_yelp)

    yelp_list <- lapply(result$businesses,
                        function(x) x[c('name','rating','review_count')])

    # take the results list into a dataframe
    result_df <- data.frame(matrix(unlist(yelp_list),
                                   nrow = 50,
                                   byrow = T),
                            stringsAsFactors = FALSE)
  })

  # rename column names of the dataframe
  names(result_df)<-c('name','rating','review_count')

  # return the result dataframe
  return(result_df)
}
