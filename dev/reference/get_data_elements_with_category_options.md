# Get Data Elements with Category Options

**\[experimental\]** `get_data_elements_with_category_options()` fetches
data elements metadata with the category options from the DHIS2 API
server.

## Usage

``` r
get_data_elements_with_category_options(
  element_ids,
  auth = NULL,
  call = caller_env()
)
```

## Arguments

- element_ids:

  The data element identifiers whose details being retrieved

- auth:

  The authentication object

- call:

  The caller environment

## Value

A tibble containing the following columns:

- element_id - The unique identifier for the data element.

- element - The name of the data element.

- category - The category options for the elements

- category_id - The unique identifier for the category options

## Examples

``` r

# Fetch the data element metadata for particular element id
elements <- get_data_elements_with_category_options('lYsfXxCw6Qi')
elements
#> # A tibble: 3 × 4
#>   element                                element_id  category   category_id
#>   <chr>                                  <chr>       <chr>      <chr>      
#> 1 MAL - Malaria confirmed cases reported lYsfXxCw6Qi 15+ years  hF0pQZIn6Ch
#> 2 MAL - Malaria confirmed cases reported lYsfXxCw6Qi 5-14 years rtfSaMjPyq6
#> 3 MAL - Malaria confirmed cases reported lYsfXxCw6Qi 0-4 years  oPcWGgS2Liz
```
