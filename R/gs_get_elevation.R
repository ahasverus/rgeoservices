#' Retrieve the elevation of French locations
#' 
#' @description
#' Queries the Geoservices (IGN) API using the **/altimetrie** endpoint to 
#' extract the elevation of one or many French (mainland) locations. This 
#' service uses the IGN RGE ALTI® database.
#' 
#' The API documentation is available [here](https://data.geopf.fr/altimetrie/swagger-ui/index.html#/Elevation/get_elevations_1_0_calcul_alti_rest_elevation__output_format__get).
#' 
#' @param longitude a `numeric` vector. The longitude of one or several French 
#'   locations defined in the WGS84 system.
#' 
#' @param latitude a `numeric` vector. The latitude of one or several French 
#'   locations defined in the WGS84 system.
#' 
#' @return A `data.frame` with three columns: `longitude`, `latitude`, and 
#'   `elevation`. The number of rows matches the number of provided locations.
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
#' # Get Florac-Trois-Rivieres, Lozere elevation ----
#' 
#' ele <- gs_get_elevation(longitude = florac$"longitude", 
#'                         latitude  = florac$"latitude")
#' }

gs_get_elevation <- function(longitude, latitude) {
  
  ## Check arguments ----

  check_required_arg(longitude)
  check_numeric_arg(longitude)
  check_if_na(longitude)

  check_required_arg(latitude)
  check_numeric_arg(latitude)
  check_if_na(latitude)
 

  ## Check for metropolitan France location ----

  check_if_in_france(longitude, latitude)

  
  ## Prepare request ----

  api_endpoint <- gs_base_url() |> 
    httr2::request() |> 
    httr2::req_url_path_append("altimetrie", "1.0", "calcul", "alti", "rest", 
                               "elevation.json")

  http_request <- api_endpoint |> 
    httr2::req_url_query(lon       = paste(longitude, collapse = "|"),
                         lat       = paste(latitude, collapse = "|"),
                         resource  = "ign_rge_alti_wld",
                         delimiter = "|",
                         indent    = "false",
                         measures  = "false",
                         zonly     = "false")


  ## Send request ----

  http_response <- http_request |> 
    httr2::req_perform()


  ## Parse content ----
  
  http_content <- http_response |> 
    httr2::resp_body_json()


  ## Extract elevations ----

  http_content <- lapply(http_content[["elevations"]], function(x) {
    data.frame(x["lon"], x["lat"], x["z"])
  })

  http_content <- do.call(rbind.data.frame, http_content)

  colnames(http_content) <- c("longitude", "latitude", "elevation")
  
  http_content
}
