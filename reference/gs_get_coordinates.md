# Retrieve coordinates and information of an address

Queries the Geoservices (IGN) API using the **/geocode** endpoint to
extract the coordinates and administrative information of a French
address or point of interest (POI) as cityhall, museum, etc. This
service uses the IGN BD TOPO® database.

The API documentation is available
[here](https://geoservices.ign.fr/documentation/services/services-geoplateforme/geocodage).

## Usage

``` r
gs_get_coordinates(
  query,
  index = "address",
  limit = 10,
  postcode = NULL,
  type = NULL,
  city = NULL,
  category = NULL,
  longitude = NULL,
  latitude = NULL
)
```

## Arguments

- query:

  a `character` of length 1. The address or point of interest to search
  for. See example.

- index:

  a `character` of length 1. The type of location. Possible values:
  `address` and `poi`.

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

- longitude:

  a `numeric` of length 1 (optional). Can be used to filter results
  based on the longitude of a known near point.

- latitude:

  a `numeric` of length 1 (optional). Can be used to filter results
  based on the latitude of a known near point.

## Value

A `data.frame` with the following columns:

- `query`: the user query

- `longitude`: the longitude of the location matching the query

- `latitude`: the latitude of the location matching the query

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

- `score`: the relevance of the match (used to sort results)

Depending of the value of `index` (`address` of `poi`) some columns can
be `NA`.

## Examples

``` r
if (FALSE) { # \dontrun{
# Search by full postal address ----

gs_get_coordinates(query = "1 Place Georges Freche 34000 Montpellier", 
                   index = "address")


# Search by full postal address (better results) ----

gs_get_coordinates(query = "1 Place Georges Freche", 
                   index = "address", 
                   type  = "housenumber",
                   city  = "Montpellier")


# Search by point of interest (building) ----

gs_get_coordinates(query    = "Mairie de Montpellier", 
                   limit    = 10, 
                   index    = "poi", 
                   category = "mairie",
                   citycode = 34000)


# Search by point of interest (lake) ----

dat <- gs_get_coordinates(query    = "Lac d'Annecy", 
                          index    = "poi", 
                          category = "lac")


# Map coordinates ----
xy <- sf::st_as_sf(dat, coords = 2:3, crs = sf::st_crs(4326))

mapview::mapview(xy)
} # } 
```
