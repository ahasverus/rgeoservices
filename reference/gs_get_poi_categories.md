# Get point of interest categories

Queries the Geoservices (IGN) API using the **/geocode** endpoint to
list accepted categories of points of interest (POI) such as cityhall,
museum, lake, etc. This service uses the IGN BD TOPO® database.

The API documentation is available
[here](https://geoservices.ign.fr/documentation/services/services-geoplateforme/geocodage).

## Usage

``` r
gs_get_poi_categories()
```

## Value

A `data.frame` with two columns: `type` and `category` name.

## Examples

``` r
if (FALSE) { # \dontrun{
# Get accepted values for POI categories (Geocode API) ----

gs_get_poi_categories()
} # } 
```
