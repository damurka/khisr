# Retrieves Disaggregated Analytics Data from DHIS2

`get_analytics()` retrieves disaggregated data from DHIS2 analytics
tables for a specified period and data element(s), without performing
any aggregation.

## Usage

``` r
get_analytics(
  ...,
  return_type = c("uid", "name"),
  retry = 2,
  verbosity = 0,
  timeout = 60
)
```

## Arguments

- ...:

  One or more
  [`analytics_dimension()`](https://khisr.damurka.com/reference/analytics-dimension.md)
  parameters in key-value pairs. These define the analytics query,
  including data elements, periods, and organization units.

- return_type:

  Optional argument specifying the return format for identifiers.
  defaults to `'uid'`. Choose `'name'` for human readable labels.

- retry:

  Number of times to retry the API call in case of failure (defaults to
  2).

- verbosity:

  Level of HTTP information to print during the call:

  - 0: No output

  - 1: Show headers

  - 2: Show headers and bodies

  - 3: Show headers, bodies, and CURL status message.

- timeout:

  Maximum number of seconds to wait for the API response.

## Value

A tibble containing the disaggregated analytics data, or `NULL` if no
data is retrieved.

## Details

- Retrieves data directly from DHIS2 analytics tables.

- Allows specifying analytics dimensions, return format for identifiers,
  retry attempts, and logging verbosity.

## Examples

``` r

# Malaria data elements
# lYsfXxCw6Qi = MAL - Malaria confirmed cases reported
# GxlrIgMyEf4 = MAL - Malaria deaths
element_id <- c('lYsfXxCw6Qi', 'GxlrIgMyEf4')

# Download data for the last year
data <- get_analytics(dx %.d% element_id, pe %.d% 'LAST_YEAR')
data
#> # A tibble: 2 × 3
#>   dx          pe    value
#>   <chr>       <chr> <dbl>
#> 1 GxlrIgMyEf4 2025   4609
#> 2 lYsfXxCw6Qi 2025   9653
```
