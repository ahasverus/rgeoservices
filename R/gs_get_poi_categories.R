#' Get point of interest categories
#' 
#' @description
#' Queries the Geoservices (IGN) API using the **/geocode** endpoint to 
#' list accepted categories of points of interest (POI) such as cityhall, 
#' museum, lake, etc. This service uses the IGN BD TOPO® database.
#' 
#' The API documentation is available [here](https://geoservices.ign.fr/documentation/services/services-geoplateforme/geocodage).
#' 
#' @return A `data.frame` with two columns: `type` and `category` name.
#' 
#' @export
#' 
#' @examples
#' \dontrun{
#' # Get accepted values for POI categories (Geocode API) ----
#' 
#' gs_get_poi_categories()
#' } 

gs_get_poi_categories <- function() {

  ## Prepare request ----

  api_endpoint <- gs_base_url() |> 
    httr2::request() |> 
    httr2::req_url_path_append("geocodage", "getCapabilities")


  ## Send request ----

  http_response <- api_endpoint |> 
    httr2::req_perform()


  ## Parse content ----
  
  http_content <- http_response |> 
    httr2::resp_body_json()

  categories <- http_content[["indexes"]][[2]][["fields"]][[1]][["values"]]

  tmp <- lapply(categories, function(x) {
    data.frame("category" = unlist(x))
  }) |> 
    do.call(rbind.data.frame, args = _)

  tmp <- data.frame(type = rownames(tmp), tmp)

  tmp$"type" <- gsub("\\.[0-9]{1,}$", "", tmp$"type")

  categories <- data.frame("type"     = names(categories), 
                           "category" = names(categories))

  categories <- rbind(categories, tmp)
  categories <- categories[with(categories, order(type, category)), ]

  rownames(categories) <- NULL

  categories
}
