# Retrieves Aggregated Enrollment Analytics Data from DHIS2

**\[experimental\]** `get_enrollment_analytics()` retrieves aggregated,
dimensional analytics over Tracker enrollments from DHIS2's
`analytics/enrollments/query/{program}` endpoint — as opposed to
[`get_enrollments()`](https://khisr.damurka.com/dev/reference/get_enrollments.md),
which returns raw individual enrollment records from the Tracker API.
Use this when you want counts/aggregates across dimensions (e.g.
enrollments by org unit and period), not the underlying records
themselves.

## Usage

``` r
get_enrollment_analytics(
  program,
  ...,
  return_type = c("uid", "name"),
  page_size = 1000,
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
  [`analytics_dimension()`](https://khisr.damurka.com/dev/reference/analytics-dimension.md)
  parameters (e.g. `ou`/`pe` dimensions via `%.d%`/`%.f%`), and/or other
  query parameters supported by your DHIS2 instance's Tracker analytics
  query API.

- return_type:

  Optional. `'uid'` (default) or `'name'` for the identifier scheme used
  in the response.

- page_size:

  Number of records to request per page (default 1000).

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

A tibble of aggregated enrollment analytics data, or `NULL` if none was
retrieved.

## Details

The response shares the same `headers`/`rows` shape as
[`get_analytics()`](https://khisr.damurka.com/dev/reference/get_analytics.md).
Pagination is automatic; see
[`get_event_analytics()`](https://khisr.damurka.com/dev/reference/get_event_analytics.md)'s
details for a note on this endpoint family's pagination behaviour (a
different, silently truncating shape confirmed live against a public
DHIS2 demo instance for the `events` variant, which this function shares
the same underlying engine with).

## See also

[`get_enrollments()`](https://khisr.damurka.com/dev/reference/get_enrollments.md)
for raw individual enrollment records,
[`get_event_analytics()`](https://khisr.damurka.com/dev/reference/get_event_analytics.md)
for the event equivalent,
[`get_analytics()`](https://khisr.damurka.com/dev/reference/get_analytics.md)
for aggregate (non-Tracker) analytics.

## Examples

``` r

# Enrollments for a program, by org unit, over the last 12 months
get_enrollment_analytics(program = 'PREnRHSp3be',
                         ou %.d% 'USER_ORGUNIT',
                         pe %.d% 'LAST_12_MONTHS')
#> # A tibble: 162 × 16
#>    pi          tei     enrollmentdate incidentdate storedby createdbydisplayname
#>    <chr>       <chr>   <chr>          <chr>        <chr>    <chr>               
#>  1 qMBqoFYqgtP OJDIrx… 2026-07-01 00… 2026-06-06 … stefano  Perotti, Stefano (s…
#>  2 HmZ9Jn8ZAa3 nvtThP… 2026-10-16 00… 2026-06-06 … stefano  Perotti, Stefano (s…
#>  3 vARbqJyjbd7 Ke6bkn… 2026-02-18 00… 2026-06-06 … stefano  Perotti, Stefano (s…
#>  4 zGQSVfXF4Ge ZdeOVj… 2026-10-13 00… 2026-06-06 … stefano  Perotti, Stefano (s…
#>  5 rElAXaHNBFK FTivY0… 2026-05-13 00… 2026-06-06 … stefano  Perotti, Stefano (s…
#>  6 Hk7nycj5NOH ELhoTv… 2026-10-25 00… 2026-06-06 … stefano  Perotti, Stefano (s…
#>  7 lMAv6YTrWug YQwGkf… 2026-10-03 00… 2026-06-06 … stefano  Perotti, Stefano (s…
#>  8 XpHBBN7Vr0K NNbtut… 2026-09-07 00… 2026-06-06 … stefano  Perotti, Stefano (s…
#>  9 YK5uJ00bblf xhO85y… 2026-08-01 00… 2026-06-06 … stefano  Perotti, Stefano (s…
#> 10 eQXZZxUwGPf iUZq6l… 2026-09-26 00… 2026-06-06 … stefano  Perotti, Stefano (s…
#> # ℹ 152 more rows
#> # ℹ 10 more variables: lastupdatedbydisplayname <chr>, lastupdated <chr>,
#> #   geometry <chr>, longitude <dbl>, latitude <dbl>, ouname <chr>,
#> #   ounamehierarchy <chr>, oucode <chr>, programstatus <chr>, ou <chr>
```
