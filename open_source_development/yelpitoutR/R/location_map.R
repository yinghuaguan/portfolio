#' Produces a google map visualization of top 5 businesses (ordered by review count)
#
#' @title location map
#' @param yelp_key a string representing the Yelp API key
#' @param category a string representing the category of the business
#' @param city a string representing a city name
#' @return a google map visualization of the top 5 business based on review counts
#' @author Linsey Yao, Apr 10
#'
#' @import ggmap
#' @import ggplot2
#' @importFrom utils head
#' @import magrittr
#' @import dplyr
#' @import httr
#'
#' @export
#'
#' @examples
#' location_map(Sys.getenv("yelp_key"), "cafe", "Vancouver")

location_map <- function(yelp_key, category, city) {

  # check the input, we expect them to be strings
  if (is.character(yelp_key) == FALSE) {
    stop("Error: Yelp key type is not accepted, expected a string instead")
  }
  if (is.character(category) == FALSE) {
    stop("Error: Category type is not accepted, expected a string instead")
  }
  if (is.character(city) == FALSE) {
    stop("Error: City name is not accepted, expected a string instead")
  }

  # Access Yelp API
  get_yelp <- GET('https://api.yelp.com/v3/businesses/search',
                  query = list(term = category, location = city, limit = 50),
                  add_headers(Authorization = paste('bearer', yelp_key)))

  # check whether the Yelp key is available
  if (status_code(get_yelp) == 401) {
    stop("Error: Invalid Yelp key")
  }

  tryCatch({
    # get the contents
    result <- content(get_yelp)

    # extract the expected columns
    yelp_list <- lapply(result$businesses,
                        function(x) x[c('name', 'review_count', 'coordinates')])

    # make a data frame to store the information
    result_df <- data.frame(matrix(unlist(yelp_list),
                                   nrow = 50,
                                   byrow = T),
                            stringsAsFactors = FALSE)

    # change the column names
    names(result_df) <- c('name', 'review_count', 'latitude', 'longitude')

    # change the type of columns
    result_df$review_count <- as.integer(result_df$review_count)
    result_df$longitude <- as.numeric(result_df$longitude)
    result_df$latitude <- as.numeric(result_df$latitude)

    # rearrange the data frame ordered by review counts
    top_results <- result_df %>% dplyr::arrange(desc(review_count)) %>% head(5)

    # get the Google map
    local_map <- ggmap::get_map(location = c(lon = mean(top_results$longitude),
                                             lat = mean(top_results$latitude)),
                                zoom = 13,
                                maptype = "hybrid",
                                scale = 2)
    # make the expected plot
    ggmap::ggmap(local_map) +
      ggplot2::geom_point(data = top_results,
                          aes(x = longitude, y = latitude, fill = "red", alpha = 0.9),
                          size = 4,
                          shape = 21) +
      ggplot2::guides(fill = FALSE,
                      alpha = FALSE,
                      size = FALSE)})

}
