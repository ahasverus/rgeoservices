# Calculate an isochrone around a French location

Queries the Geoservices (IGN) API using the **/isochrone** endpoint to
calculate an isochrone around a French (mainland) location. This service
uses the IGN BD TOPO® Valhalla to get road data.

An isochrone is an area linking the points accessible by a given means
of transport (argument `profile`) in a given time (argument
`cost_value`).

The API documentation is available
[here](https://www.geoportail.gouv.fr/depot/swagger/itineraire.html#/Utilisation/isochrone).

## Usage

``` r
gs_get_isochrone(
  longitude,
  latitude,
  cost_value,
  profile = "car",
  direction = "departure",
  time_unit = "hour"
)
```

## Arguments

- longitude:

  a `numeric` of length 1. The longitude of the location defined in the
  WGS84 system. The location must belongs to Mainland France.

- latitude:

  a `numeric` of length 1. The latitude of the location defined in the
  WGS84 system. The location must belongs to Mainland France.

- cost_value:

  a `numeric` of length 1. The time used to calculate the isochrone.
  Unit is specified by the argument `time_unit`. Must be strictly
  positive.

- profile:

  a `character` of length 1. The means of transport used to calculate
  the isochrone. Possible values: `car` and `pedestrian`.

- direction:

  a `character` of length 1. The course direction. If
  `direction = "departure"`, the isochrone will be calculated from the
  starting point (defined by `longitude` and `latitude` arguments) and
  will provide the potential arrival points. If `direction = "arrival"`,
  the isochrone will provide the potential departure points to the
  arrival point (defined by `longitude` and `latitude` arguments).

- time_unit:

  a `character` of length 1. The time unit of the argument `cost_value`.
  Possible values: `hour`, `minute` and `second`.

## Value

The isochrone as a `sf POLYGON` object.

## Examples

``` r
if (FALSE) { # \dontrun{
# Set Florac-Trois-Rivieres, Lozere coordinates ----

florac <- data.frame(longitude  =  3.59608777,
                     latitude   = 44.32690171)


# Isochrone of one hour around Florac-Trois-Rivieres, Lozere (by car) ----

iso_car <- gs_get_isochrone(longitude  = florac$"longitude", 
                            latitude   = florac$"latitude", 
                            cost_value = 60,
                            time_unit  = "minute",
                            profile    = "car")


# Isochrone of one hour around Florac-Trois-Rivieres, Lozere (on foot) ----

iso_foot <- gs_get_isochrone(longitude  = florac$"longitude", 
                             latitude   = florac$"latitude", 
                             cost_value = 60,
                             time_unit  = "minute",
                             profile    = "pedestrian")


# Convert point to sf object ----

florac <- sf::st_as_sf(florac, coords = 1:2, crs = sf::st_crs(4326))


# Make map ----

library(ggplot2)

ggplot() +
  geom_sf(data = iso_car,  fill = "red", col = "white") +
  geom_sf(data = iso_foot, fill = "darkgreen", col = "white") +
  geom_sf(data = florac, col = "white", shape = 19) +
  theme_bw()
} # }
```
