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

  Other options that can be passed onto DHIS2 API.

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

- [`get_organisations_by_level()`](https://khisr.damurka.com/dev/reference/get_organisations_by_level.md)
  for getting the organisations units

- [`get_data_sets()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  for retrieving the data sets

## Examples

``` r
# The MoH 745 Cancer Screening Program Monthly Summary Form
dataset_id = c('WWh5hbCmvND')

# Download data from February 2023 to current date
data <- get_data_sets_by_level(dataset_ids = dataset_id,
                               start_date = '2023-02-01')
data
#> # A tibble: 34 × 10
#>    kenya dataset    period     month  year reporting_rate reporting_rate_on_time
#>    <chr> <chr>      <date>     <ord> <dbl>          <dbl>                  <dbl>
#>  1 Kenya MoH 745 C… 2024-10-01 Octo…  2024           69.1                   66.1
#>  2 Kenya MoH 745 C… 2024-11-01 Nove…  2024           67.3                   61.7
#>  3 Kenya MoH 745 C… 2023-06-01 June   2023           67.3                   62.9
#>  4 Kenya MoH 745 C… 2023-05-01 May    2023           65.2                   61.4
#>  5 Kenya MoH 745 C… 2024-05-01 May    2024           66.6                   62.0
#>  6 Kenya MoH 745 C… 2025-08-01 Augu…  2025           64.7                   60.0
#>  7 Kenya MoH 745 C… 2025-09-01 Sept…  2025           66.5                   63.7
#>  8 Kenya MoH 745 C… 2024-03-01 March  2024           66.2                   62.6
#>  9 Kenya MoH 745 C… 2024-04-01 April  2024           65.7                   61.3
#> 10 Kenya MoH 745 C… 2023-07-01 July   2023           68.1                   61.0
#> # ℹ 24 more rows
#> # ℹ 3 more variables: actual_reports <dbl>, actual_reports_on_time <dbl>,
#> #   expected_reports <dbl>
```
