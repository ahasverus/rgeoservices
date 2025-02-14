#' Calculate an itinerary between two locations
#' 
#' @description
#' Queries the Geoservices (IGN) API using the **/itineraire** endpoint to 
#' calculate an itinerary between two French (mainland) locations. This service 
#' uses the IGN BD TOPO® OSRM to get road data.
#' 
#' The API documentation is available [here](https://www.geoportail.gouv.fr/depot/swagger/itineraire.html#/Utilisation/routeItineraire-get).
#' 
#' @param start a vector of two `numeric` values. The longitude and the latitude
#'   of the location of the departure defined in the WGS84 system. 
#'   The location must belong to Mainland France.
#' 
#' @param end a vector of two `numeric` values. The longitude and the latitude
#'   of the location of the arrival defined in the WGS84 system. 
#'   The location must belong to Mainland France.
#' 
#' @param intermediates a `list` of two-numeric vectors (optional). Intermediate
#'   points that the route must reach.
#' 
#' @param profile a `character` of length 1. The means of transport used to 
#'   calculate the itinerary. Possible values: `car` and `pedestrian`.
#' 
#' @param optimization a `character` of length 1. Possible values: `fastest` 
#'   and `shortest`.
#' 
#' @param distance_unit a `character` of length 1. The distance unit of the 
#'   estimated distance. Possible values: `meter` and `kilometer`.
#' 
#' @param time_unit a `character` of length 1. The time unit of the estimated
#'   duration. Possible values: `hour`, `minute` and `second`.
#' 
#' @param by_feature a `logical`. If `FALSE` (default) returns the itinerary as
#'   one single `sf LINESTRING`. If `TRUE` returns the itinerary as a collection
#'   of `sf LINESTRING`, each portion corresponding to a unique road.
#' 
#' @return The itinerary as a `sf LINESTRING` object.
#' 
#' @export
#' 
#' @examples
#' \dontrun{
#' # Get coordinates of Ganges cityhall ----
#'  
#' ganges <- gs_get_coordinates(
#'   query    = "Mairie de Ganges", 
#'   index    = "poi", 
#'   category = "mairie",
#'   limit    = 1
#' )
#' 
#' ganges <- c(ganges$"longitude", ganges$"latitude")
#' 
#' 
#' # Get coordinates of Ales cityhall ----
#' 
#' ales <- gs_get_coordinates(
#'   query    = "Mairie d'Ales", 
#'   index    = "poi", 
#'   category = "mairie",
#'   limit    = 1
#' )
#' 
#' ales <- c(ales$"longitude", ales$"latitude")
#' 
#' 
#' # Calculate fastest itinerary between the two cities ----
#' 
#' itinerary <- gs_get_itinerary(
#'   start = ganges,
#'   end   = ales)
#' 
#' 
#' # Same but with information of each road ----
#' 
#' itinerary <- gs_get_itinerary(
#'   start      = ganges, 
#'   end        = ales, 
#'   by_feature = TRUE)
#' 
#' 
#' # Get coordinates of Aigremont cityhall ----
#' 
#' aigremont <- gs_get_coordinates(
#'   query    = "Mairie d'Aigremont", 
#'   index    = "poi", 
#'   category = "mairie",
#'   postcode = 30350,
#'   limit    = 1
#' )
#' 
#' aigremont <- c(aigremont$"longitude", aigremont$"latitude")
#' 
#' 
#' # Calculate fastest itinerary between the two cities... ----
#' # ...with a stop at Aigremont, Gard
#' 
#' itinerary <- gs_get_itinerary(
#'   start         = ganges, 
#'   end           = ales, 
#'   intermediates = list(aigremont)
#' )
#' 
#' 
#' # Example for hiking (part of GR70) ----
#' 
#' departure <- gs_get_coordinates(
#'   query    = "Le Pont de Barre Florac",
#'   index    = "poi",
#'   category = "pont"
#' )
#' 
#' departure <- c(departure$"longitude", departure$"latitude")
#' 
#' arrival <- gs_get_coordinates(
#'   query    = "Chateau de Saint-Julien-d'Arpaon",
#'   index    = "poi",
#'   category = "ruines"
#' )
#' 
#' arrival <- c(arrival$"longitude", arrival$"latitude")
#' 
#' itinerary <- gs_get_itinerary(
#'   start         = departure, 
#'   end           = arrival, 
#'   profile       = "pedestrian",
#'   optimization  = NULL,
#'   intermediates = list(
#'     c(3.65052, 44.303574)
#'   )
#' )
#' }

gs_get_itinerary <- function(start, end, intermediates = NULL, profile = "car", 
                             optimization = "fastest", time_unit = "minute", 
                             distance_unit = "kilometer", by_feature = FALSE) {
  

  ## Check arguments ----

  check_required_arg(start)
  check_numeric_arg(start)
  check_arg_length(start, len = 2L)
  check_if_in_france(start[1], start[2])

  check_required_arg(end)
  check_numeric_arg(end)
  check_arg_length(end, len = 2L)
  check_if_in_france(end[1], end[2])

  if (!is.null(intermediates)) {

    check_required_arg(intermediates)

    if (!is.list(intermediates)) {
      stop("The argument 'intermediates' must be a list", call. = FALSE)
    }

    if (any(unlist(lapply(intermediates, length)) != 2)) {
      stop("Each element of 'intermediates' must be a two-value vector", 
           call. = FALSE)
    }

    if (any(unlist(lapply(intermediates, class)) != "numeric")) {
      stop("Each element of 'intermediates' must be a numeric vector", 
           call. = FALSE)
    }

    check_coords <- unlist(
      lapply(intermediates, function(x) {
        tryCatch(check_if_in_france(x[1], x[2]), error = function(e) NA)
      })
    )

    if (any(is.na(check_coords))) {
      stop("Some 'intermediates' points are out of mainland France", 
           call. = FALSE)
    }

    intermediates <- unlist(lapply(intermediates, function(x) {
      paste0(x, collapse = ",")
    }))

  } else {

    intermediates <- ""
  }

  check_required_arg(profile)
  check_character_arg(profile)
  check_arg_length(profile, len = 1L)
  match_arg(profile, values = c("car", "pedestrian"))

  if (!is.null(optimization)) {

    check_required_arg(optimization)
    check_character_arg(optimization)
    check_arg_length(optimization, len = 1L)
    match_arg(optimization, values = c("fastest", "shortest"))

  } else {

    optimization <- ""
  }
  
  if (profile == "pedestrian" && optimization != "") {
    stop("The argument 'optimization' is not available for ", 
         "profile = 'pedestrian'", call. = FALSE)
  }

  check_required_arg(time_unit)
  check_character_arg(time_unit)
  check_arg_length(time_unit, len = 1L)
  match_arg(time_unit, values = c("hour", "minute", "second"))

  check_required_arg(distance_unit)
  check_character_arg(distance_unit)
  check_arg_length(distance_unit, len = 1L)
  match_arg(distance_unit, values = c("meter", "kilometer"))

  check_required_arg(by_feature)
  check_logical_arg(by_feature)
  check_arg_length(by_feature, len = 1L)


  ## Prepare request ----

  api_endpoint <- gs_base_url() |> 
    httr2::request() |> 
    httr2::req_url_path_append("navigation", "itineraire")

  http_request <- api_endpoint |> 
    httr2::req_url_query(resource       = "bdtopo-osrm",
                         start          = paste0(start, collapse = ","),
                         end            = paste0(end, collapse = ","),
                         intermediates  = paste0(intermediates, collapse = "|"),
                         profile        = profile,
                         optimization   = optimization,
                         timeUnit       = time_unit,
                         distanceUnit   = distance_unit,
                         geometryFormat = "geojson",
                         crs            = "EPSG:4326",
                         getSteps       = "true",
                         waysAttributes = "name")


  ## Send request ----

  http_response <- http_request |> 
    httr2::req_perform()


  ## Parse content ----
  
  http_content <- http_response |> 
    httr2::resp_body_json()


  ## Get single feature ----

  if (!by_feature) {

    data <- data.frame(
      "profile"       = http_content$"profile",
      "optimization"  = http_content$"optimization",
      "distance"      = http_content$"distance",
      "duration"      = http_content$"duration",
      "distance_unit" = http_content$"distanceUnit",
      "time_unit"     = http_content$"timeUnit")
  
  
    ## Extract geometry ----
  
    geometry <- lapply(http_content[["geometry"]][["coordinates"]], 
      function(x) {
        matrix(c(x[[1]], x[[2]]), ncol = 2)
    })
    
    geometry <- do.call(rbind, geometry)
  
  
    ## Convert to sf POLYGON ----
    
    geometry <- geometry |> 
      sf::st_linestring() |> 
      sf::st_sfc(crs = sf::st_crs(4326))
  
    sf::st_geometry(data) <- geometry


  ## Get each feature ----
    
  } else {

    features <- http_content[["portions"]][[1]][["steps"]]
    
    data <- data.frame(
      "profile"       = rep(http_content$"profile", length(features)),
      "optimization"  = rep(http_content$"optimization", length(features)),
      "name"          = unlist(
        lapply(features, function(x) { 
          feat <- x[["attributes"]][["name"]][["nom_1_gauche"]]
          if (is.null(feat) || feat == "") feat <- NA
          feat
        })
      ),
      "cpx_number"    = unlist(
        lapply(features, function(x) { 
          feat <- x[["attributes"]][["name"]][["cpx_numero"]]
          if (is.null(feat) || feat == "") feat <- NA
          feat
        })
      ),
      "distance"      = unlist(
        lapply(features, function(x) { 
          feat <- x[["distance"]]
          if (is.null(feat) || feat == "") feat <- NA
          feat
        })
      ),
      "duration"      = unlist(
        lapply(features, function(x) { 
          feat <- x[["duration"]]
          if (is.null(feat) || feat == "") feat <- NA
          feat
        })
      ),
      "instruction_type" = unlist(
        lapply(features, function(x) { 
          feat <- x[["instruction"]][["type"]]
          if (is.null(feat) || feat == "") feat <- NA
          feat
        })
      ),
      "instruction_modifier" = unlist(
        lapply(features, function(x) { 
          feat <- x[["instruction"]][["modifier"]]
          if (is.null(feat) || feat == "") feat <- NA
          feat
        })
      ),
      "distance_unit" = rep(http_content$"distanceUnit", length(features)),
      "time_unit"     = rep(http_content$"timeUnit", length(features))
    )


    ## Extract geometries ----

    geometries <- lapply(features, 
      function(x) {

        geometry <- lapply(x[["geometry"]][["coordinates"]], function(y) {
          matrix(c(y[[1]], y[[2]]), ncol = 2)
        })
        
        geometry <- do.call(rbind, geometry)

        geometry |> 
          sf::st_linestring()
    })
    
    geometries <- sf::st_sfc(geometries)
    
    sf::st_geometry(data) <- geometries
    sf::st_crs(data) <- sf::st_crs(4326)
  }

  data
}
