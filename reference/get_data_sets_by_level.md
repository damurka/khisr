# Retrieves Data Set Reporting Rate Metrics

**\[experimental\]** `get_data_sets_by_level()` fetches the data set
reporting metrics. The metric can be REPORTING_RATE,
REPORTING_RATE_ON_TIME, ACTUAL_REPORTS, ACTUAL_REPORTS_ON_TIME,
EXPECTED_REPORTS.

## Usage

``` r
get_data_sets_by_level(
  dataset_ids,
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

- dataset_ids:

  Required vector of data sets IDs for which to retrieve data. Required.

- start_date:

  Optional start date to retrieve data. It is required and in the format
  `YYYY-MM-dd`.

- end_date:

  Optional ending date for data retrieval (default is the current date).

- level:

  Required desired organisation level of data (default: level 1) .

- org_ids:

  Optional list of organization units IDs to be filtered.

- ...:

  Other analytics query options passed onto the DHIS2 `analytics`
  endpoint (e.g. additional dimension/filter arguments). Not forwarded
  to the organisation unit or data set metadata lookups this function
  also performs.

- auth:

  Optional. The authentication object.

- call:

  The caller environment.

## Value

A tibble with detailed information, including:

- Geographical identifiers (country, subnational, district, facility,
  depending on level)

- Reporting period (month, year, fiscal year)

- The reporting metric can be REPORTING_RATE, REPORTING_RATE_ON_TIME,
  ACTUAL_REPORTS, ACTUAL_REPORTS_ON_TIME, EXPECTED_REPORTS.

## See also

- [`get_organisations_by_level()`](https://khisr.damurka.com/reference/get_organisations_by_level.md)
  for getting the organisations units

- [`get_data_sets()`](https://khisr.damurka.com/reference/metadata-helpers.md)
  for retrieving the data sets

## Examples

``` r
# The Malaria elimination dataset
dataset_id = c('VEM58nY22sO')

# Download data from February 2023 to current date
data <- get_data_sets_by_level(dataset_ids = dataset_id,
                               start_date = '2023-02-01')
data
#> # A tibble: 44 × 10
#>    country dataset  period     month  year reporting_rate reporting_rate_on_time
#>    <chr>   <chr>    <date>     <ord> <dbl>          <dbl>                  <dbl>
#>  1 Lao PDR Malaria… 2024-12-01 Dece…  2024           83.1                   83.1
#>  2 Lao PDR Malaria… 2026-07-01 July   2026           86.3                   86.3
#>  3 Lao PDR Malaria… 2024-11-01 Nove…  2024           83.2                   83.2
#>  4 Lao PDR Malaria… 2026-06-01 June   2026           86.1                   86.1
#>  5 Lao PDR Malaria… 2026-08-01 Augu…  2026           86.3                   86.3
#>  6 Lao PDR Malaria… 2024-02-01 Febr…  2024           75.7                   75.7
#>  7 Lao PDR Malaria… 2024-10-01 Octo…  2024           79.1                   79.1
#>  8 Lao PDR Malaria… 2026-05-01 May    2026           85.9                   85.9
#>  9 Lao PDR Malaria… 2026-09-01 Sept…  2026           86.4                   86.4
#> 10 Lao PDR Malaria… 2024-03-01 March  2024           75.9                   75.9
#> # ℹ 34 more rows
#> # ℹ 3 more variables: actual_reports <dbl>, actual_reports_on_time <dbl>,
#> #   expected_reports <dbl>
```
