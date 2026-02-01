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
#> # A tibble: 37 × 10
#>    kenya dataset    period     month  year reporting_rate reporting_rate_on_time
#>    <chr> <chr>      <date>     <ord> <dbl>          <dbl>                  <dbl>
#>  1 Kenya MoH 745 C… 2026-02-01 Febr…  2026           0                      0   
#>  2 Kenya MoH 745 C… 2026-01-01 Janu…  2026           0.01                   0.01
#>  3 Kenya MoH 745 C… 2024-10-01 Octo…  2024          69.3                   66.4 
#>  4 Kenya MoH 745 C… 2024-11-01 Nove…  2024          67.5                   61.9 
#>  5 Kenya MoH 745 C… 2023-06-01 June   2023          67.5                   63.1 
#>  6 Kenya MoH 745 C… 2023-05-01 May    2023          65.4                   61.6 
#>  7 Kenya MoH 745 C… 2024-05-01 May    2024          66.8                   62.2 
#>  8 Kenya MoH 745 C… 2025-08-01 Augu…  2025          65.1                   60.2 
#>  9 Kenya MoH 745 C… 2025-09-01 Sept…  2025          67.6                   63.8 
#> 10 Kenya MoH 745 C… 2024-03-01 March  2024          66.4                   62.8 
#> # ℹ 27 more rows
#> # ℹ 3 more variables: actual_reports <dbl>, actual_reports_on_time <dbl>,
#> #   expected_reports <dbl>
```
