
<!-- README.md is generated from README.Rmd. Please edit that file -->

# khisr <a href="https://khisr.damurka.com"><img src="man/figures/logo.png" align="right" height="139" alt="khisr website" /></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/khisr)](https://CRAN.R-project.org/package=khisr)
[![R-CMD-check](https://github.com/damurka/khisr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/damurka/khisr/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/damurka/khisr/branch/main/graph/badge.svg)](https://app.codecov.io/gh/damurka/khisr?branch=main)
<!-- badges: end -->

The khisr package is designed to seamlessly integrate with DHIS2,
providing R users with a powerful interface for efficient data
retrieval. DHIS2 is a cornerstone in health information management for
many organisations, and khisr simplifies the process of accessing and
working with DHIS2 data directly within the R environment.

### Key Features

- ***Data Retrieval:*** Easily download and manage data from DHIS2.
- ***Flexible Queries:*** Customize data queries to retrieve specific
  data elements, periods, and organizational units.
- ***Tracker Data:*** Retrieve tracked entities, enrollments, and events
  from DHIS2’s Tracker API.
- ***Secure Access:*** Manage credentials securely, using a
  username/password or a Personal Access Token.

### Use Cases

- Health data analysis for research.
- Monitoring and evaluation of health programs
- Generating reports and dashboards for health information systems.

## Installation

### Stable Release

You can install the release version of khisr from
[CRAN](https://cran.r-project.org/) with:

``` r
install.packages("khisr")
```

### Development Version

And the development version of khisr like so:

``` r
#install.packages('pak')
pak::pak('damurka/khisr')
```

## Usage

### Load khisr package

``` r
library("khisr")
```

### Auth

The khisr package operates in authenticated mode by default. This means
you’ll need to provide credentials before using any functions that
interact with your DHIS2 instance to download data. To ensure secure
access, khisr offers a convenient way to store your credentials within
your R environment. Refer to the following resource for detailed
instructions on setting your credentials: [set you
credentials](https://khisr.damurka.com/articles/set-your-credentials.html)

``` r
# Option 1: Set credentials directly in R (less secure)

khis_cred(username = 'DHIS2 username',
          password = 'DHIS2 password',
          server = 'https://<dhis2 server instance>')

# Option 2: Set credentials from a secure configuration file (recommended)

khis_cred(config_path = 'path/to/secret.json')

# Option 3: Set credentials using a Personal Access Token, DHIS2's
# recommended method for scripts and integrations, in place of
# username/password

khis_cred(token = 'DHIS2 personal access token',
          server = 'https://<dhis2 server instance>')
```

Once you’ve established your credentials, you’re ready to leverage
khisr’s functions to download data from your DHIS2 instance.

For this overview, we’ve logged into DHIS2 as a specific user in a
hidden chunk.

## Basic Overview

This is a basic example which shows you how to solve a common problem:

``` r
# Retrieve the organisation units by province (level 2)
provinces <- get_organisation_units(level %.eq% '2')
provinces
#> # A tibble: 18 × 2
#>    name                 id         
#>    <chr>                <chr>      
#>  1 01 Vientiane Capital W6sNfkJcXGC
#>  2 02 Phongsali         YvLOmtTQD6b
#>  3 03 Louangnamtha      XKGgynPS1WZ
#>  4 04 Oudomxai          rO2RVJWHpCe
#>  5 05 Bokeo             FRmrFTE63D0
#>  6 06 Louangphabang     MBZYTqkEgwf
#>  7 07 Houaphan          hdeC7uX9Cko
#>  8 08 Xainyabouli       RdNV4tTRNEo
#>  9 09 Xiangkhouang      VWGSudnonm5
#> 10 10 Vientiane         quFXhkOJGB4
#> 11 11 Bolikhamxai       vBWtCmNNnCG
#> 12 12 Khammouan         c4HrGRJoarj
#> 13 13 Savannakhet       pFCZqWnXtoU
#> 14 14 Salavan           TOgZ99Jv0bN
#> 15 15 Xekong            dOhqCNenSjS
#> 16 16 Champasak         sv6c7CpPcrc
#> 17 17 Attapu            hRQsZhmvqgS
#> 18 18 Xaisomboun        K27JzTKmBKh

# Retrieve an organisation unit by name (level included to ensure it refers to a province)
vientiane_capital <- get_organisation_units(level %.eq% '2',
                                            name %.like% 'Vientiane Capital')
vientiane_capital
#> # A tibble: 1 × 2
#>   name                 id         
#>   <chr>                <chr>      
#> 1 01 Vientiane Capital W6sNfkJcXGC

# Retrieve all data elements by data element group for malaria
malaria_group <- get_data_elements(dataElementGroups.name %.like% 'malaria')
malaria_group
#> # A tibble: 316 × 2
#>    name                                                            id         
#>    <chr>                                                           <chr>      
#>  1 CH113a - Children (0-4 y) reporting fever in the last two weeks hzstN9blpky
#>  2 CH114 - Households with at least one ITN                        gRT7NXBCkbB
#>  3 CH115a - Households with at least one ITN for every two persons xjGwK4DRHxh
#>  4 CH115b - Total individuals who live in the household            mn8VQbAjlFU
#>  5 CH116a - People sleeping under an ITN the previous night        UXCgJMwfQiG
#>  6 CH116b - Individuals sleeping in the household                  jrbMyDW8Wnb
#>  7 CH117 - People living in an IRS-sprayed house                   UCpIrYTr88q
#>  8 CH118 - ITNs distributed                                        cp0mXP6STEA
#>  9 CH119a - Febrile cased tested by RDT                            rlxpxRQU5m0
#> 10 CH119b - Febrile cases of malaria                               AJhP60PGXKa
#> # ℹ 306 more rows

# Filter the data elements to those reporting on malaria cases and deaths
malaria <- get_data_elements(dataElementGroups.name %.like% 'malaria',
                             name %.like% 'MAL - ') %>%
    filter(name %in% c('MAL - Malaria confirmed cases reported',
                       'MAL - Malaria deaths',
                       'MAL - RDT positive malaria cases',
                       'MAL - Suspected malaria cases'))
malaria
#> # A tibble: 4 × 2
#>   name                                   id         
#>   <chr>                                  <chr>      
#> 1 MAL - Malaria confirmed cases reported lYsfXxCw6Qi
#> 2 MAL - Malaria deaths                   GxlrIgMyEf4
#> 3 MAL - RDT positive malaria cases       vTRrNdOOT9g
#> 4 MAL - Suspected malaria cases          cE8SDxizo5s

# Retrieve data for malaria in Vientiane Capital province
data <- get_analytics(
        dx %.d% malaria$id,
        pe %.d% 'LAST_YEAR',
        ou %.f% vientiane_capital$id
    ) %>%
    left_join(malaria, by = c('dx'='id'))
data
#> # A tibble: 4 × 4
#>   dx          pe    value name                                  
#>   <chr>       <chr> <dbl> <chr>                                 
#> 1 GxlrIgMyEf4 2025    966 MAL - Malaria deaths                  
#> 2 cE8SDxizo5s 2025   1045 MAL - Suspected malaria cases         
#> 3 lYsfXxCw6Qi 2025    120 MAL - Malaria confirmed cases reported
#> 4 vTRrNdOOT9g 2025    242 MAL - RDT positive malaria cases
```

## Tracker Data

Alongside aggregate analytics, khisr also reads DHIS2’s Tracker API —
case-based, person-level data such as tracked entities, enrollments, and
events. See [Tracker
Data](https://khisr.damurka.com/articles/tracker.html) for a full guide.

``` r
# Tracked entities enrolled in a program, at an org unit and everything below it
get_tracked_entities(
    program = 'PREnRHSp3be',
    org_units = 'IWp9dQGM0bS',
    org_unit_mode = 'DESCENDANTS'
)
#> # A tibble: 270 × 6
#>    trackedEntity trackedEntityType createdAt          updatedAt orgUnit inactive
#>    <chr>         <chr>             <chr>              <chr>     <chr>   <lgl>   
#>  1 qkU5JI6SQcd   DnxQe1mgmlp       2024-06-06T10:40:… 2024-06-… NRcrkS… FALSE   
#>  2 ytRUQrTYLFz   DnxQe1mgmlp       2024-06-06T10:40:… 2024-06-… QoGegg… FALSE   
#>  3 xIOlpNNRcNY   DnxQe1mgmlp       2024-06-06T10:40:… 2024-06-… o0Q54F… FALSE   
#>  4 MNUPROje7ZP   DnxQe1mgmlp       2024-06-06T10:40:… 2024-06-… wQUe9H… FALSE   
#>  5 rlTI0qJF8fl   DnxQe1mgmlp       2024-06-06T10:40:… 2024-06-… mNaSC8… FALSE   
#>  6 NKktLYq4wea   DnxQe1mgmlp       2024-06-06T10:40:… 2024-06-… aJOpUu… FALSE   
#>  7 xwZRdamQoGx   DnxQe1mgmlp       2024-06-06T10:40:… 2024-06-… hfVWi2… FALSE   
#>  8 nZZf0IJzkIe   DnxQe1mgmlp       2024-06-06T10:40:… 2024-06-… XHCI8A… FALSE   
#>  9 kA4Fcarkd9T   DnxQe1mgmlp       2024-06-06T10:40:… 2024-06-… LpTkKu… FALSE   
#> 10 Z746P0ZnrFQ   DnxQe1mgmlp       2024-06-06T10:40:… 2024-06-… rYTEjU… FALSE   
#> # ℹ 260 more rows

# Events for a program stage at a given org unit
get_events(
    program_stage = 'mj1stImcUCi',
    org_unit = 'NRcrkSgDX5G',
    org_unit_mode = 'DESCENDANTS'
)
#> # A tibble: 1 × 8
#>   event    status program programStage orgUnit occurredAt scheduledAt dataValues
#>   <chr>    <chr>  <chr>   <chr>        <chr>   <chr>      <chr>       <list>    
#> 1 viu095e… COMPL… PREnRH… mj1stImcUCi  NRcrkS… 2026-05-2… 2027-06-06… <list [2]>
```

## Where to learn more

[Get Started](https://khisr.damurka.com/articles/khisr.html) is a more
extensive general introduction to khisr.

[Tracker Data](https://khisr.damurka.com/articles/tracker.html) covers
retrieving tracked entities, enrollments, and events.

Browse the [articles
index](https://khisr.damurka.com/articles/index.html) to find articles
that cover various topics in more depth.

See the [function index](https://khisr.damurka.com/reference/index.html)
for an organized, exhaustive listing.

## Code of Conduct

Please note that the khisr project is released with a [Contributor Code
of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
