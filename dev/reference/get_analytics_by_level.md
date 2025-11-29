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

  Other options that can be passed onto DHIS2 API.

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

- [`get_organisations_by_level()`](https://khisr.damurka.com/dev/reference/get_organisations_by_level.md)
  for getting the organisations units

- [`get_data_elements_with_category_options()`](https://khisr.damurka.com/dev/reference/get_data_elements_with_category_options.md)
  for retrieving the data elements

## Examples

``` r
# Clinical Breast Examination data elements
# XEX93uLsAm2 = CBE Abnormal
# cXe64Yk0QMY = CBE Normal
element_id = c('cXe64Yk0QMY', 'XEX93uLsAm2')

# Download data from February 2023 to current date
data <- get_analytics_by_level(element_ids = element_id,
                               start_date = '2023-02-01')
data
#> # A tibble: 329 × 7
#>    value kenya element      category  period     month      year
#>    <dbl> <chr> <chr>        <chr>     <date>     <ord>     <dbl>
#>  1    18 Kenya CBE-Abnormal 56-74 yrs 2024-04-01 April      2024
#>  2   399 Kenya CBE-Abnormal 25-34 yrs 2024-12-01 December   2024
#>  3   137 Kenya CBE-Abnormal 35-39 yrs 2023-06-01 June       2023
#>  4     6 Kenya CBE-Abnormal >75 yrs   2025-02-01 February   2025
#>  5   150 Kenya CBE-Abnormal 35-39 yrs 2023-07-01 July       2023
#>  6   156 Kenya CBE-Abnormal 35-39 yrs 2023-05-01 May        2023
#>  7    35 Kenya CBE-Abnormal 56-74 yrs 2024-05-01 May        2024
#>  8    24 Kenya CBE-Abnormal 56-74 yrs 2024-03-01 March      2024
#>  9 15012 Kenya CBE-Normal   35-39 yrs 2025-09-01 September  2025
#> 10   100 Kenya CBE-Abnormal 35-39 yrs 2023-08-01 August     2023
#> # ℹ 319 more rows
```
