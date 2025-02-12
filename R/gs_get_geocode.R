#' Retrieve an address or a point of interest from coordinates
#' 
#' @description
#' Queries the Geoservices (IGN) API using the **/geocode** endpoint to 
#' retrieve administrative information of a French address or point of interest 
#' (POI) as cityhall, museum, etc from geographical coordinates. This service 
#' uses the IGN BD TOPO® database.
#' 
#' The API documentation is available [here](https://geoservices.ign.fr/documentation/services/services-geoplateforme/geocodage).
#' 
#' @param longitude a `numeric` of length 1. The longitude of the location 
#'   (in WGS84).
#' 
#' @param latitude a `numeric` of length 1. The latitude of the location 
#'   (in WGS84).
#' 
#' @param limit a `numeric` of length 1. The maximum number of results to 
#'   return (between 1 and 20). 
#' 
#' @param index a `character` of length 1. The type of location to return. 
#'   Possible values: `address` and `poi`.
#' 
#' @param postcode a `numeric` of length 1 (optional). Can be used to filter 
#'   results based on the postal code.
#' 
#' @param type a `character` of length 1 (optional). Can be used to filter 
#'   results based on the type of address. Possible values : `housenumber`, 
#'   `street`, `locality`, `municipality`. This argument only works if 
#'   `index = 'address'`.
#' 
#' @param city a `character` of length 1 (optional). Can be used to filter 
#'   results based on a city name.
#' 
#' @param category a `character` of length 1 (optional). Can be used to filter 
#'   results based on the type of POI. Run `gs_get_poi_categories()` to get
#'   accepted values. This argument only works if `index = 'poi'`.
#' 
#' @return A `data.frame` with the following columns:
#'   - `longitude`: the longitude of the matched location
#'   - `latitude`: the latitude of the matched location
#'   - `label`: the label of the location (combination of name, postal & city)
#'   - `name`: the name of the location in the BD TOPO® system
#'   - `toponym`: the toponym of the point of interest
#'   - `housenumber`: the housenumber of the address
#'   - `street`: the street name of the address
#'   - `city`: the city of the address
#'   - `postcode`: the postal code of the city
#'   - `citycode`: the COG (INSEE) code of the city
#'   - `context`: a combination of the department and region
#'   - `category`: the type of point of interest
#'   - `distance`: the distance to the provided coordinates (in meters)
#'   - `oldcity`: the old name of the city
#'   - `oldcitycode`: the INSEE code of the old name
#'   - `score`: the relevance of the match (used to sort results)
#' 
#' Depending of the value of `index` (`address` of `poi`) some columns can be 
#' `NA`.
#' 
#' @export
#' 
#' @examples
#' \dontrun{
#' # Search for a postal address ----
#' 
#' gs_get_geocode(longitude = 3.896549, 
#'                latitude  = 43.59884, 
#'                index     = "address")
#' 
#' 
#' # Search for a point of interest (building) ----
#' 
#' gs_get_geocode(longitude = 3.896549, 
#'                latitude  = 43.59884, 
#'                index     = "poi")
#' 
#' 
#' # Search for a point of interest (lake) ----
#' 
#' gs_get_geocode(longitude = 6.186529, 
#'                latitude  = 45.84561, 
#'                index     = "poi")
#' } 

gs_get_geocode <- function(longitude, latitude, index = "address", limit = 10, 
                           postcode = NULL, type = NULL, city = NULL, 
                           category = NULL) {

  
  ## Check arguments ----

  check_required_arg(longitude)
  check_numeric_arg(longitude)
  check_arg_length(longitude, len = 1L)
  
  check_required_arg(latitude)
  check_numeric_arg(latitude)
  check_arg_length(latitude, len = 1L)

  check_if_in_france(longitude, latitude)

  check_required_arg(limit)
  check_numeric_arg(limit)
  check_arg_length(limit, len = 1L)
  check_positive_arg(limit)

  if (limit > 20) {
    stop("The argument 'limit' must be between 1 and 20", call. = FALSE)
  }

  check_required_arg(index)
  check_character_arg(index)
  check_arg_length(index, len = 1L)
  match_arg(index, values = c("address", "poi"))


  if (!is.null(postcode)) {

    check_required_arg(postcode)
    check_numeric_arg(postcode)
    check_arg_length(postcode, len = 1L)
    check_positive_arg(postcode)
    
  } else {

    postcode <- ""
  }
  

  if (!is.null(type)) {

    check_required_arg(type)
    check_character_arg(type)
    check_arg_length(type, len = 1L)
    match_arg(type, values = c("housenumber", "street", "street", "locality", 
                               "municipality"))
      
  } else {

    type <- ""
  }


  if (!is.null(city)) {
    
    check_required_arg(city)
    check_character_arg(city)
    check_arg_length(city, len = 1L)
      
  } else {

    city <- ""
  }


  if (!is.null(category)) {

    check_required_arg(category)
    check_character_arg(category)
    check_arg_length(category, len = 1L)

    if (!(category %in% gs_get_poi_categories()$"category")) {
      stop("Unvalid value for 'category'. Please use 'gs_get_poi_categories()'",
           call. = FALSE)
    }
      
  } else {

    category <- ""
  }


  if (index == "poi" && type != "") {
    stop("Argument 'type' can be used only with index = 'address'")
  }

  if (index == "address" && category != "") {
    stop("Argument 'category' can be used only with index = 'poi'")
  }

  if (postcode != "" && city != "") {
    stop("Please use 'postcode' or 'city' (not both)")
  }


  ## Prepare request ----

  api_endpoint <- gs_base_url() |> 
    httr2::request() |> 
    httr2::req_url_path_append("geocodage", "reverse")

  http_request <- api_endpoint |> 
    httr2::req_url_query(lon      = longitude,
                         lat      = latitude,
                         index    = index,
                         limit    = limit,
                         type     = type,
                         category = category,
                         postcode = postcode,
                         city     = city)


  ## Send request ----

  http_response <- http_request |> 
    httr2::req_perform()


  ## Parse content ----
  
  http_content <- http_response |> 
    httr2::resp_body_json()

  
  ## Clean content ----

  http_content <- lapply(http_content[["features"]], function(x) {

    fields <- c("label", "name", "toponym", "housenumber", "street", "city",
                "postcode", "citycode", "context", "category", "distance", 
                "oldcity", "oldcitycode", "score")
    
    data <- data.frame(
      "longitude" = x[["geometry"]][["coordinates"]][[1]],
      "latitude"  = x[["geometry"]][["coordinates"]][[2]]
    )

    for (field in fields) {
      
      value <- paste0(unlist(x[["properties"]][[field]]), collapse = " | ")
      
      if (value == "") value <- NA

      data[field] <- value
    }

    data
  }) |> 
    do.call(rbind.data.frame, args = _)

  http_content
}
