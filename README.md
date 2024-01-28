
<!-- README.md is generated from README.Rmd. Please edit that file -->

    Code chunks will not be evaluated, because:
    Set credential unsuccessful.

# khisr <a href="https://khisr.damurka.com"><img src="man/figures/logo.png" align="right" height="139" alt="khisr website" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/damurka/khisr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/damurka/khisr/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/damurka/khisr/branch/main/graph/badge.svg)](https://app.codecov.io/gh/damurka/khisr?branch=main)
<!-- badges: end -->

The khisr package is designed to seamlessly integrate with the Kenya
Health Information System (KHIS), providing R users with a powerful
interface for efficient data retrieval. KHIS is a cornerstone in health
information management in Kenya, and khisr simplifies the process of
accessing and working with KHIS data directly within the R environment.

## Installation

You can install the development version of khisr like so:

``` r
#install.packages('pak')
pak::pak('damurka/khisr')
```

### Load khisr package

``` r
library("khisr")
```

### Auth

khisr will, by default, help you interact with KHIS as an authenticated
user. Before calling any function that makes an API call you need
credentials to [KHIS](https://hiskenya.org). You will be expected to set
this credential to download data.

``` r
# Set the credentials using username and password
khis_cred(username = 'KHIS username', password = 'KHIS password')

# Set credentials using configuration path
khis_cred(config_path = 'path/to/secret.json')
```

After setting the credential you can invoke any function to download
data from the API.

For this overview, we’ve logged into KHIS as a specific user in a hidden
chunk.

## Basic Overview

This is a basic example which shows you how to solve a common problem:

``` r
# Retrieve the organisation units by county (level 2)
counties <- get_organisation_units(level %.eq% '2')
counties

# Retrieve organisation units by name (level included to ensure it refers to county)
kiambu_county <- get_organisation_units(level %.eq% '2', name %.like% 'Kiambu county')
kiambu_county

# Retrieve all data elements by data element group for outpatient (data element group name MOH 705)
moh_705 <- get_data_elements(dataElementGroups.name %.like% 'moh 705')
moh_705

# Filter the data element to element that contain malaria
malaria <- get_data_elements(dataElementGroups.name %.like% 'moh 705', name %.like% 'malaria')
malaria

# Retrieve data for malaria in Kiambu county in the outpatient data element groups
data <- get_analytics(
    dx %.d% unique(malaria$id),
    pe %.d% 'LAST_YEAR',
    ou %.f% kiambu_county$id
)
```

## Code of Conduct

Please note that the khisr project is released with a [Contributor Code
of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
