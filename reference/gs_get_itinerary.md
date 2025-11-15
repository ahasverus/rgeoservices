# Calculate an itinerary between two locations

Queries the Geoservices (IGN) API using the **/itineraire** endpoint to
calculate an itinerary between two French (mainland) locations. This
service uses the IGN BD TOPO® OSRM to get road data.

The API documentation is available
[here](https://www.geoportail.gouv.fr/depot/swagger/itineraire.html#/Utilisation/routeItineraire-get).

## Usage

``` r
gs_get_itinerary(
  start,
  end,
  intermediates = NULL,
  profile = "car",
  optimization = "fastest",
  time_unit = "minute",
  distance_unit = "kilometer",
  by_feature = FALSE
)
```

## Arguments

- start:

  a vector of two `numeric` values. The longitude and the latitude of
  the location of the departure defined in the WGS84 system. The
  location must belong to Mainland France.

- end:

  a vector of two `numeric` values. The longitude and the latitude of
  the location of the arrival defined in the WGS84 system. The location
  must belong to Mainland France.

- intermediates:

  a `list` of two-numeric vectors (optional). Intermediate points that
  the route must reach.

- profile:

  a `character` of length 1. The means of transport used to calculate
  the itinerary. Possible values: `car` and `pedestrian`.

- optimization:

  a `character` of length 1. Possible values: `fastest` and `shortest`.

- time_unit:

  a `character` of length 1. The time unit of the estimated duration.
  Possible values: `hour`, `minute` and `second`.

- distance_unit:

  a `character` of length 1. The distance unit of the estimated
  distance. Possible values: `meter` and `kilometer`.

- by_feature:

  a `logical`. If `FALSE` (default) returns the itinerary as one single
  `sf LINESTRING`. If `TRUE` returns the itinerary as a collection of
  `sf LINESTRING`, each portion corresponding to a unique road.

## Value

The itinerary as a `sf LINESTRING` object.

## Examples

``` r
if (FALSE) { # \dontrun{
# Get coordinates of Ganges cityhall ----
 
ganges <- gs_get_coordinates(
  query    = "Mairie de Ganges", 
  index    = "poi", 
  category = "mairie",
  limit    = 1
)

ganges <- c(ganges$"longitude", ganges$"latitude")


# Get coordinates of Ales cityhall ----

ales <- gs_get_coordinates(
  query    = "Mairie d'Ales", 
  index    = "poi", 
  category = "mairie",
  limit    = 1
)

ales <- c(ales$"longitude", ales$"latitude")


# Calculate fastest itinerary between the two cities ----

itinerary <- gs_get_itinerary(
  start = ganges,
  end   = ales)


# Same but with information of each road ----

itinerary <- gs_get_itinerary(
  start      = ganges, 
  end        = ales, 
  by_feature = TRUE)


# Get coordinates of Aigremont cityhall ----

aigremont <- gs_get_coordinates(
  query    = "Mairie d'Aigremont", 
  index    = "poi", 
  category = "mairie",
  postcode = 30350,
  limit    = 1
)

aigremont <- c(aigremont$"longitude", aigremont$"latitude")


# Calculate fastest itinerary between the two cities... ----
# ...with a stop at Aigremont, Gard

itinerary <- gs_get_itinerary(
  start         = ganges, 
  end           = ales, 
  intermediates = list(aigremont)
)


# Example for hiking (part of GR70) ----

departure <- gs_get_coordinates(
  query    = "Le Pont de Barre Florac",
  index    = "poi",
  category = "pont"
)

departure <- c(departure$"longitude", departure$"latitude")

arrival <- gs_get_coordinates(
  query    = "Chateau de Saint-Julien-d'Arpaon",
  index    = "poi",
  category = "ruines"
)

arrival <- c(arrival$"longitude", arrival$"latitude")

itinerary <- gs_get_itinerary(
  start         = departure, 
  end           = arrival, 
  profile       = "pedestrian",
  optimization  = NULL,
  intermediates = list(
    c(3.65052, 44.303574)
  )
)
} # }
```
