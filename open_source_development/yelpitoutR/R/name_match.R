#' Returns name, phone, location and postal code of a business that is the best match based on the name provided.
#
#' @title name_match
#' @param key a string representing the Yelp API key
#' @param name a string representing the name of the business
#' @param city a string representing the city name
#' @param state a string representing the state code
#' @param country a string representing the country code
#' @return a dataframe representing name, phone, location and postal code of a business that is the best match
#' @author Ying Dong, Apr 10
#'
#' @import dplyr
#' @import magrittr
#' @import httr
#'
#' @export
#'
#' @examples
#' name_match(Sys.getenv("yelp_key"), "Starbucks", "Burnaby", "BC", "CA")

name_match <- function(key, name, city, state, country) {

  # check the type of inputs, we expect Yelp key, name, city, state code and country code are all strings
  if (is.character(key) == FALSE) {
    stop("Error: Yelp key type is not accepted, expected a string instead")
  }
  if (is.character(name) == FALSE) {
    stop("Error: Name of the business is not accepted, expected a string instead")
  }
  if (is.character(city) == FALSE) {
    stop("Error: City name is not accepted, expected a string instead")
  }
  if (is.character(state) == FALSE) {
    stop("Error: State name is not accepted, expected a string instead")
  }
  if (is.character(country) == FALSE) {
    stop("Error: Country name is not accepted, expected a string instead")
  }

  # access the Yelp API
  get_yelp <- GET('https://api.yelp.com/v3/businesses/matches/best', query = list(name = name, city = city, state = state, country = country), add_headers(Authorization = paste('bearer', key)))

  # check whether the key is valid for Yelp API
  if (status_code(get_yelp) == 401) {
    stop("Error: Invalid Yelp key")
  }

  tryCatch({

    # get the result and only take name, phone and location from the business object
    result <- content(get_yelp)
    yelp_list <- lapply(result$businesses, function(x) x[c('name', 'phone', 'location')])

    # if there is no result in API content, return a dataframe with only 1 row containing value of 0
    if (is.null(unlist(yelp_list))){
      result_0 <- data.frame(n = 0)
      return(result_0)
    }

    # take the results list into a dataframe and select specified columns
    result_df <- data.frame(matrix(unlist(yelp_list), nrow = 1, byrow = T), stringsAsFactors = FALSE)
    result_df <- result_df %>%
      dplyr::select(X1, X2, X10, X7)

    # rename column names of the dataframe
    names(result_df) <- c('Name', 'Phone', 'Location', 'Postal Code')

    # return the result dataframe
    return(result_df)})
}
