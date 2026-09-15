# Retrieves Analytics Table Data

**\[experimental\]** `get_analytics_by_level()` fetches data from the
DHIS2 analytics tables for a given period and data element(s), without
performing any aggregation.

## Usage

``` r
get_analytics_by_level(
  element_ids,
  start_date,
  end_date = NULL,
  level = 1,
  org_ids = NULL,
  ...,
  auth = NULL,
  call = caller_env()
)
```

## Arguments

- element_ids:

  Required vector of data element IDs for which to retrieve data.

- start_date:

  Required start date to retrieve data. It is required and in the format
  `YYYY-MM-dd`.

- end_date:

  Optional ending date for data retrieval (default is the current date).

- level:

  The desired organisation level of data (default: level 1)

- org_ids:

  Optional list of organization units IDs to be filtered.

- ...:

  Other analytics query options passed onto the DHIS2 `analytics`
  endpoint (e.g. additional dimension/filter arguments). Not forwarded
  to the organisation unit or data element metadata lookups this
  function also performs.

- auth:

  Optional. The authentication object.

- call:

  The caller environment.

## Value

A tibble with detailed information, including:

- Geographical identifiers (country, subnational, district, facility,
  depending on level)

- Reporting period (month, year, fiscal year)

- Data element names

- Category options

- Reported values

## Details

- Retrieves data directly from DHIS2 analytics tables.

- Supports optional arguments for providing organization lists, data
  elements, and categories.

- Allows specifying DHIS2 session objects, retry attempts, and logging
  verbosity.

## See also

- [`get_organisations_by_level()`](https://khisr.damurka.com/reference/get_organisations_by_level.md)
  for getting the organisations units

- [`get_data_elements_with_category_options()`](https://khisr.damurka.com/reference/get_data_elements_with_category_options.md)
  for retrieving the data elements

## Examples

``` r
# Malaria data elements
# lYsfXxCw6Qi = MAL - Malaria confirmed cases reported
# GxlrIgMyEf4 = MAL - Malaria deaths
element_id = c('lYsfXxCw6Qi', 'GxlrIgMyEf4')

# Download data from February 2023 to current date
data <- get_analytics_by_level(element_ids = element_id,
                               start_date = '2023-02-01')
data
#> # A tibble: 453 × 7
#>    value country element                         category period     month  year
#>    <dbl> <chr>   <chr>                           <chr>    <date>     <ord> <dbl>
#>  1   253 Lao PDR MAL - Malaria deaths            15+ yea… 2025-08-01 Augu…  2025
#>  2   237 Lao PDR MAL - Malaria deaths            15+ yea… 2025-09-01 Sept…  2025
#>  3   189 Lao PDR MAL - Malaria deaths            15+ yea… 2025-07-01 July   2025
#>  4   644 Lao PDR MAL - Malaria confirmed cases … 15+ yea… 2025-07-01 July   2025
#>  5    10 Lao PDR NA                              NA       2026-02-01 Febr…  2026
#>  6   601 Lao PDR MAL - Malaria confirmed cases … 15+ yea… 2025-08-01 Augu…  2025
#>  7   696 Lao PDR MAL - Malaria confirmed cases … 15+ yea… 2025-06-01 June   2025
#>  8     8 Lao PDR NA                              NA       2026-01-01 Janu…  2026
#>  9    10 Lao PDR NA                              NA       2026-03-01 March  2026
#> 10     8 Lao PDR NA                              NA       2026-04-01 April  2026
#> # ℹ 443 more rows
```
