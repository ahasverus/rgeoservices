# Retrieve an address or a point of interest from coordinates

Queries the Geoservices (IGN) API using the **/geocode** endpoint to
retrieve administrative information of a French address or point of
interest (POI) as cityhall, museum, etc from geographical coordinates.
This service uses the IGN BD TOPO® database.

The API documentation is available
[here](https://geoservices.ign.fr/documentation/services/services-geoplateforme/geocodage).

## Usage

``` r
gs_get_geocode(
  longitude,
  latitude,
  index = "address",
  limit = 10,
  postcode = NULL,
  type = NULL,
  city = NULL,
  category = NULL
)
```

## Arguments

- longitude:

  a `numeric` of length 1. The longitude of the location (in WGS84).

- latitude:

  a `numeric` of length 1. The latitude of the location (in WGS84).

- index:

  a `character` of length 1. The type of location to return. Possible
  values: `address` and `poi`.

- limit:

  a `numeric` of length 1. The maximum number of results to return
  (between 1 and 20).

- postcode:

  a `character` of length 1 (optional). Can be used to filter results
  based on the postal code.

- type:

  a `character` of length 1 (optional). Can be used to filter results
  based on the type of address. Possible values : `housenumber`,
  `street`, `locality`, `municipality`. This argument only works if
  `index = 'address'`.

- city:

  a `character` of length 1 (optional). Can be used to filter results
  based on a city name.

- category:

  a `character` of length 1 (optional). Can be used to filter results
  based on the type of POI. Run
  [`gs_get_poi_categories()`](https://ahasverus.github.io/rgeoservices/reference/gs_get_poi_categories.md)
  to get accepted values. This argument only works if `index = 'poi'`.

## Value

A `data.frame` with the following columns:

- `longitude`: the longitude of the matched location

- `latitude`: the latitude of the matched location

- `label`: the label of the location (combination of name, postal &
  city)

- `name`: the name of the location in the BD TOPO® system

- `toponym`: the toponym of the point of interest

- `housenumber`: the housenumber of the address

- `street`: the street name of the address

- `city`: the city of the address

- `postcode`: the postal code of the city

- `citycode`: the COG (INSEE) code of the city

- `context`: a combination of the department and region

- `category`: the type of point of interest

- `distance`: the distance to the provided coordinates (in meters)

- `oldcity`: the old name of the city

- `oldcitycode`: the INSEE code of the old name

- `score`: the relevance of the match (used to sort results)

Depending of the value of `index` (`address` of `poi`) some columns can
be `NA`.

## Examples

``` r
if (FALSE) { # \dontrun{
# Search for a postal address ----

gs_get_geocode(longitude = 3.896549, 
               latitude  = 43.59884, 
               index     = "address")


# Search for a point of interest (building) ----

gs_get_geocode(longitude = 3.896549, 
               latitude  = 43.59884, 
               index     = "poi")


# Search for a point of interest (lake) ----

gs_get_geocode(longitude = 6.186529, 
               latitude  = 45.84561, 
               index     = "poi")
} # } 
```
