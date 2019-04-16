#' Produces a dataframe of max 20 restaurant that can deliver to a select address ordered by review count/price/rating
#
#' @title delivery list
#' @param yelp_key a string representing the Yelp API key
#' @param location a string representing the delivery location, prefer zipcode
#' @param order a string representing the outcome order method
#' @return a dataframe of max 20 restaurant that can deliver to a selected address based on selected order
#' @author Ruoqi xu, Apr 10
#'
#' @import dplyr
#' @import httr
#'
#' @export
#'
#' @examples
#' delivery_list(Sys.getenv("yelp_key"), "98104", "Rating")

delivery_list <- function(yelp_key, location, order) {
#check the type of input, we expect yelp_key, location and order are string.
  if (is.character(yelp_key) == FALSE) {
    stop("Error: Yelp key type is not accepted, expected a string instead")
  }
  if (is.character(location) == FALSE) {
    stop("Error: category type is not accepted, expected a string instead")
  }
  if (is.character(order) == FALSE) {
    stop("Error: order is not accepted, expected a string instead")
  }
#Access the yelp API
  get_yelp <- GET('https://api.yelp.com/v3/transactions/delivery/search',
                  query=list(location=location),add_headers(Authorization=paste('bearer',yelp_key)))
  #input location could be address line or longitude and latitude or zipcode, zipcode is best choice
  #order include 3 choice: Price, Rating, Review_number
  if (status_code(get_yelp) == 401) {
    stop("Error: Invalid Yelp key")
  }
    #take the API content to a data frame
    result<-content(get_yelp)
    yelp_list<-lapply(result$businesses,function(x) x[c('name','price','rating','review_count','display_phone')])
    #If there are no data in API content, return a dataframe only have 1 row
        if (is.null(unlist(yelp_list))){
      result <- data.frame(n=0)
      return(result)
    }
    result<-data.frame(matrix(unlist(yelp_list),ncol = 5,byrow = T))
    #rename the column name of dataframe
    names(result) <- c('Restaurant','Price','Rating','Review_number','Phone_number')
    #if input is price we return dataframe order by Price
    if (order == "Price"){
      result <- result%>% dplyr::arrange(desc(Price))
    }
    #if input is Rating we return dataframe order by Rating
    if (order == "Rating"){
      result <- result%>% dplyr::arrange(desc(Rating))
    }
    #if input is Reviev_number we return dataframe order by number of review
    if (order == "Review_number"){
      result <- result%>% dplyr::arrange(desc(Review_number))
    }
    #return data frame
    return(result)

}

