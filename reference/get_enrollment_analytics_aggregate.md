# Get Aggregated (Pivot-Style) Enrollment Analytics from DHIS2

**\[experimental\]** `get_enrollment_analytics_aggregate()` retrieves
totals over Tracker enrollments from DHIS2's
`analytics/enrollments/aggregate/{program}` endpoint. This is a
genuinely different endpoint from
[`get_enrollment_analytics()`](https://khisr.damurka.com/reference/get_enrollment_analytics.md)'s
`analytics/enrollments/query/{program}`: `query` returns line-list style
rows, while `aggregate` returns pivot-table style totals.

## Usage

``` r
get_enrollment_analytics_aggregate(
  program,
  ...,
  return_type = c("uid", "name"),
  retry = 2,
  verbosity = 0,
  timeout = 60,
  auth = NULL,
  call = caller_env()
)
```

## Arguments

- program:

  A program id. Used as a URL path segment, not a query parameter.

- ...:

  One or more
  [`analytics_dimension()`](https://khisr.damurka.com/reference/analytics-dimension.md)
  parameters (e.g. `ou`/`pe` dimensions via `%.d%`/`%.f%`), and/or other
  query parameters supported by your DHIS2 instance's Tracker analytics
  aggregate API.

- return_type:

  Optional. `'uid'` (default) or `'name'` for the identifier scheme used
  in the response.

- retry:

  Number of times to retry the API call in case of failure (defaults to
  2).

- verbosity:

  Level of HTTP information to print during the call.

- timeout:

  Maximum number of seconds to wait for the API response.

- auth:

  Optional. The authentication object.

- call:

  The caller environment.

## Value

A tibble of aggregated enrollment totals, or `NULL` if none was
retrieved.

## Details

The response shares the same `headers`/`rows` shape as
[`get_analytics()`](https://khisr.damurka.com/reference/get_analytics.md).
Confirmed live to be unpaginated, like
[`get_event_analytics_aggregate()`](https://khisr.damurka.com/reference/get_event_analytics_aggregate.md).

## See also

[`get_enrollment_analytics()`](https://khisr.damurka.com/reference/get_enrollment_analytics.md)
for the line-list `query` equivalent,
[`get_event_analytics_aggregate()`](https://khisr.damurka.com/reference/get_event_analytics_aggregate.md)
for the event equivalent.

## Examples

``` r

get_enrollment_analytics_aggregate(program = 'PREnRHSp3be',
                                   ou %.d% 'USER_ORGUNIT',
                                   pe %.d% 'LAST_12_MONTHS')
#> # A tibble: 8 × 3
#>   value ou          pe    
#>   <dbl> <chr>       <chr> 
#> 1    12 IWp9dQGM0bS 202606
#> 2    18 IWp9dQGM0bS 202608
#> 3     8 IWp9dQGM0bS 202604
#> 4     4 IWp9dQGM0bS 202601
#> 5    20 IWp9dQGM0bS 202607
#> 6    14 IWp9dQGM0bS 202605
#> 7     5 IWp9dQGM0bS 202602
#> 8     8 IWp9dQGM0bS 202603
```
