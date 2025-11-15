# rgeoservices ![](reference/figures/package-sticker.png)

• [Overview](#overview)  
• [Features](#features)  
• [Installation](#installation)  
• [Get started](#get-started)  
• [Citation](#citation)  
• [Contributing](#contributing)  
• [Acknowledgments](#acknowledgments)

## Overview

The R package `rgeoservices` is a R client streamlining access to the
services provided by the French National Institute of Geographic and
Forest Information (IGN) through its open access
[Geoplatform](https://geoservices.ign.fr/documentation/services/services-geoplateforme).
This Geoplatform can be used to query the IGN BD TOPO® database to
retrieve geographical information (only for France)

## Features

Currently `rgeoservices` can access to the following services:

- **Geocoding service**
  [🌐](https://geoservices.ign.fr/documentation/services/services-geoplateforme/geocodage)

Service used to obtain the geographic coordinates of an address or a
point of interest. The reverse operation is also possible. See the
[`gs_get_geocode()`](https://ahasverus.github.io/rgeoservices/reference/gs_get_geocode.html)
and
[`gs_get_coordinates()`](https://ahasverus.github.io/rgeoservices/reference/gs_get_coordinates.html)
functions.

- **Altimetry service**
  [🌐](https://geoservices.ign.fr/documentation/services/services-geoplateforme/altimetrie)

Service used to obtain the altitude of a geographical point and a
longitudinal profile. See the
[`gs_get_elevation()`](https://ahasverus.github.io/rgeoservices/reference/gs_get_elevation.html)
function.

- **Route planner service**
  [🌐](https://geoservices.ign.fr/documentation/services/services-geoplateforme/itineraire)

Service used to obtain a route between two points. See the
[`gs_get_itinerary()`](https://ahasverus.github.io/rgeoservices/reference/gs_get_itinerary.html)
function.

- **Isochrone/Isodistance service**
  [🌐](https://geoservices.ign.fr/documentation/services/services-geoplateforme/itineraire)

Service used to get to the accessible area within a certain travel
time/distance. See the
[`gs_get_isochrone()`](https://ahasverus.github.io/rgeoservices/reference/gs_get_isochrone.html)
and
[`gs_get_isodistance()`](https://ahasverus.github.io/rgeoservices/reference/gs_get_isodistance.html)
functions.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
## Install 'remotes' package (if not already installed) ----
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

## Install 'rgeoservices' from GitHub ----
remotes::install_github("ahasverus/rgeoservices")
```

Then you can attach the package `rgeoservices`:

``` r
library("rgeoservices")
```

## Get started

For an overview of the main features of `rgeoservices`, please read the
[Reference](https://ahasverus.github.io/rgeoservices/articles/rgeoservices.html)
page.

**N.B.** A vignette will be available soon.

## Citation

Please cite `rgeoservices` as:

> Casajus Nicolas (2025) rgeoservices: A R client for the IGN
> Geoservices API. R package version 0.0.0.9000.
> <https://github.com/ahasverus/rgeoservices/>

## Contributing

All types of contributions are encouraged and valued. For more
information, check out our [Contributor
Guidelines](https://github.com/ahasverus/rgeoservices/blob/main/CONTRIBUTING.md).

Please note that the `rgeoservices` project is released with a
[Contributor Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

## Acknowledgments

I’d like to thank the IGN for making their invaluable data freely
available.
