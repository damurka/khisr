# Get Aggregated (Pivot-Style) Event Analytics from DHIS2

**\[experimental\]** `get_event_analytics_aggregate()` retrieves totals
over Tracker events from DHIS2's `analytics/events/aggregate/{program}`
endpoint. This is a genuinely different endpoint from
[`get_event_analytics()`](https://khisr.damurka.com/dev/reference/get_event_analytics.md)'s
`analytics/events/query/{program}`: `query` returns line-list style rows
(one row per matched dimension combination, event-count driven), while
`aggregate` returns pivot-table style totals, and supports a `stage`
parameter to scope to one program stage.

## Usage

``` r
get_event_analytics_aggregate(
  program,
  stage = NULL,
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

- stage:

  Optional. A program stage id to scope the query to.

- ...:

  One or more
  [`analytics_dimension()`](https://khisr.damurka.com/dev/reference/analytics-dimension.md)
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

A tibble of aggregated event totals, or `NULL` if none was retrieved.

## Details

The response shares the same `headers`/`rows` shape as
[`get_analytics()`](https://khisr.damurka.com/dev/reference/get_analytics.md).
Unlike
[`get_event_analytics()`](https://khisr.damurka.com/dev/reference/get_event_analytics.md)'s
`query` endpoint, this endpoint is confirmed live to be unpaginated (no
`metaData.pager`, like `/api/analytics` itself) — it returns the full
result set in one request.

## See also

[`get_event_analytics()`](https://khisr.damurka.com/dev/reference/get_event_analytics.md)
for the line-list `query` equivalent,
[`get_enrollment_analytics_aggregate()`](https://khisr.damurka.com/dev/reference/get_enrollment_analytics_aggregate.md)
for the enrollment equivalent.

## Examples

``` r

get_event_analytics_aggregate(program = 'PREnRHSp3be',
                              stage = 'mj1stImcUCi',
                              ou %.d% 'USER_ORGUNIT',
                              pe %.d% 'LAST_12_MONTHS')
#> # A tibble: 8 × 3
#>   pe     ou          value
#>   <chr>  <chr>       <dbl>
#> 1 202606 IWp9dQGM0bS     8
#> 2 202602 IWp9dQGM0bS     3
#> 3 202608 IWp9dQGM0bS    23
#> 4 202601 IWp9dQGM0bS     3
#> 5 202603 IWp9dQGM0bS     9
#> 6 202604 IWp9dQGM0bS     7
#> 7 202605 IWp9dQGM0bS    15
#> 8 202607 IWp9dQGM0bS    19
```
