# Retrieve the elevation of French locations

Queries the Geoservices (IGN) API using the **/altimetrie** endpoint to
extract the elevation of one or many French (mainland) locations. This
service uses the IGN RGE ALTI® database.

The API documentation is available
[here](https://data.geopf.fr/altimetrie/swagger-ui/index.html#/Elevation/get_elevations_1_0_calcul_alti_rest_elevation__output_format__get).

## Usage

``` r
gs_get_elevation(longitude, latitude)
```

## Arguments

- longitude:

  a `numeric` vector. The longitude of one or several French locations
  defined in the WGS84 system.

- latitude:

  a `numeric` vector. The latitude of one or several French locations
  defined in the WGS84 system.

## Value

A `data.frame` with three columns: `longitude`, `latitude`, and
`elevation`. The number of rows matches the number of provided
locations.

## Examples

``` r
if (FALSE) { # \dontrun{
# Set Florac-Trois-Rivieres, Lozere coordinates ----

florac <- data.frame(longitude  =  3.59608777,
                     latitude   = 44.32690171)


# Get Florac-Trois-Rivieres, Lozere elevation ----

ele <- gs_get_elevation(longitude = florac$"longitude", 
                        latitude  = florac$"latitude")
} # }
```
