#' Calculate an isodistance around a French location
#' 
#' @description
#' Queries the Geoservices (IGN) API using the **/isochrone** endpoint to 
#' calculate an isodistance around a French (mainland) location. This service 
#' uses the IGN BD TOPO® Valhalla to get road data.
#' 
#' An isodistance is an area linking the points accessible by a given means of 
#' transport (argument `profile`) for a given distance (argument `cost_value`).
#' 
#' The API documentation is available [here](https://www.geoportail.gouv.fr/depot/swagger/itineraire.html#/Utilisation/isochrone).
#' 
#' @param longitude a `numeric` of length 1. The longitude of the location 
#'   defined in the WGS84 system. The location must belongs to Mainland France.
#' 
#' @param latitude a `numeric` of length 1. The latitude of the location 
#'   defined in the WGS84 system. The location must belongs to Mainland France.
#' 
#' @param cost_value a `numeric` of length 1. The time used to calculate the 
#'   isodistance. Unit is specified by the argument `distance_unit`. Must be 
#'   strictly positive.
#' 
#' @param profile a `character` of length 1. The means of transport used to 
#'   calculate the isodistance. Possible values: `car` and `pedestrian`.
#' 
#' @param direction a `character` of length 1. The course direction. 
#'   If `direction = "departure"`, the isodistance will be calculated from the 
#'   starting point (defined by `longitude` and `latitude` arguments) and will 
#'   provide the potential arrival points.
#'   If `direction = "arrival"`, the isodistance will provide the potential 
#'   departure points to the arrival point (defined by `longitude` and 
#'   `latitude` arguments).
#' 
#' @param distance_unit a `character` of length 1. The distance unit of the 
#'   argument `cost_value`. Possible values: `hour`, `minute` and `second`.
#' 
#' @return The isodistance as a `sf POLYGON` object.
#' 
#' @export
#' 
#' @examples
#' \dontrun{
#' # Set Florac-Trois-Rivieres, Lozere coordinates ----
#' 
#' florac <- data.frame(longitude  =  3.59608777,
#'                      latitude   = 44.32690171)
#' 
#' 
#' # Isodistance of 10 km around Florac-Trois-Rivieres, Lozere (by car) ----
#' 
#' iso <- gs_get_isodistance(longitude     = florac$"longitude", 
#'                           latitude      = florac$"latitude", 
#'                           cost_value    = 10,
#'                           distance_unit = "kilometer",
#'                           profile       = "car")
#' 
#' 
#' # Convert point to sf object ----
#' 
#' florac <- sf::st_as_sf(florac, coords = 1:2, crs = sf::st_crs(4326))
#' 
#' 
#' # Make map ----
#' 
#' library(ggplot2)
#' 
#' ggplot() +
#'   geom_sf(data = iso,  fill = "red", col = "white") +
#'   geom_sf(data = florac, col = "white", shape = 19) +
#'   theme_bw()
#' }

gs_get_isodistance <- function(longitude, latitude, cost_value, profile = "car", 
                               direction = "departure", 
                               distance_unit = "kilometer") {
  
  ## Check arguments ----

  check_required_arg(longitude)
  check_numeric_arg(longitude)
  check_arg_length(longitude, len = 1L)

  check_required_arg(latitude)
  check_numeric_arg(latitude)
  check_arg_length(latitude, len = 1L)

  check_required_arg(cost_value)
  check_numeric_arg(cost_value)
  check_arg_length(cost_value, len = 1L)
  check_positive_arg(cost_value)

  check_required_arg(profile)
  check_character_arg(profile)
  check_arg_length(profile, len = 1L)
  match_arg(profile, values = c("car", "pedestrian"))

  check_required_arg(direction)
  check_character_arg(direction)
  check_arg_length(direction, len = 1L)
  match_arg(direction, values = c("departure", "arrival"))
  
  check_required_arg(distance_unit)
  check_character_arg(distance_unit)
  check_arg_length(distance_unit, len = 1L)
  match_arg(distance_unit, values = c("meter", "kilometer"))
  

  ## Check for metropolitan France location ----

  check_if_in_france(longitude, latitude)

  
  ## Prepare request ----

  api_endpoint <- gs_base_url() |> 
    httr2::request() |> 
    httr2::req_url_path_append("navigation", "isochrone")

  http_request <- api_endpoint |> 
    httr2::req_url_query(point          = paste(longitude, latitude, sep = ","),
                         resource       = "bdtopo-valhalla",
                         costValue      = cost_value,
                         costType       = "distance",
                         profile        = profile,
                         direction      = direction,
                         geometryFormat = "geojson",
                         distanceUnit   = distance_unit,
                         crs            = "EPSG:4326")


  ## Send request ----

  http_response <- http_request |> 
    httr2::req_perform()


  ## Parse content ----
  
  http_content <- http_response |> 
    httr2::resp_body_json()


  ## Extract polygon coordinates ----

  http_content <- http_content[["geometry"]][["coordinates"]][[1]]
  http_content <- lapply(http_content, unlist)
  http_content <- do.call(rbind.data.frame, http_content)


  ## Convert to sf POLYGON ----
  
  http_content <- http_content |> 
    data.matrix() |> 
    list() |> 
    sf::st_polygon() |> 
    sf::st_sfc() |> 
    sf::st_as_sf(crs = sf::st_crs(4326))

  http_content
}
