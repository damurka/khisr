# Retrieves Aggregated Event Analytics Data from DHIS2

**\[experimental\]** `get_event_analytics()` retrieves aggregated,
dimensional analytics over Tracker events from DHIS2's
`analytics/events/query/{program}` endpoint — as opposed to
[`get_events()`](https://khisr.damurka.com/reference/get_events.md),
which returns raw individual event records from the Tracker API. Use
this when you want counts/aggregates across dimensions (e.g. events by
org unit and period), not the underlying records themselves.

## Usage

``` r
get_event_analytics(
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
  [`analytics_dimension()`](https://khisr.damurka.com/reference/analytics-dimension.md)
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

A tibble of aggregated event analytics data, or `NULL` if none was
retrieved.

## Details

The response shares the same `headers`/`rows` shape as
[`get_analytics()`](https://khisr.damurka.com/reference/get_analytics.md),
confirmed live against a public DHIS2 demo instance. Pagination is
automatic, but confirmed live to work differently from every other
paginated function in this package: without an explicit page size, this
endpoint silently returns only the first 50 rows, with no error or
warning — a real risk if you call the underlying DHIS2 endpoint directly
instead of through this function.

## See also

[`get_events()`](https://khisr.damurka.com/reference/get_events.md) for
raw individual event records,
[`get_enrollment_analytics()`](https://khisr.damurka.com/reference/get_enrollment_analytics.md)
for the enrollment equivalent,
[`get_analytics()`](https://khisr.damurka.com/reference/get_analytics.md)
for aggregate (non-Tracker) analytics.

## Examples

``` r

# Events for a program, by org unit, over the last 12 months
get_event_analytics(program = 'PREnRHSp3be',
                    ou %.d% 'USER_ORGUNIT',
                    pe %.d% 'LAST_12_MONTHS')
#> # A tibble: 352 × 21
#>    psi      ps    eventdate storedby createdbydisplayname lastupdatedbydisplay…¹
#>    <chr>    <chr> <chr>     <chr>    <chr>                <chr>                 
#>  1 k9fsx4w… Mh2F… 2026-07-… stefano  Perotti, Stefano (s… Perotti, Stefano (ste…
#>  2 w8JY1dX… Mh2F… 2026-02-… stefano  Perotti, Stefano (s… Perotti, Stefano (ste…
#>  3 uQLiWvf… Mh2F… 2026-05-… stefano  Perotti, Stefano (s… Perotti, Stefano (ste…
#>  4 NizUCOP… Mh2F… 2026-08-… stefano  Perotti, Stefano (s… Perotti, Stefano (ste…
#>  5 FH0lQpM… Mh2F… 2026-06-… stefano  Perotti, Stefano (s… Perotti, Stefano (ste…
#>  6 B0W5OEa… Mh2F… 2026-05-… stefano  Perotti, Stefano (s… Perotti, Stefano (ste…
#>  7 OQvIF6R… Mh2F… 2026-08-… stefano  Perotti, Stefano (s… Perotti, Stefano (ste…
#>  8 UdvY2SN… Mh2F… 2026-05-… stefano  Perotti, Stefano (s… Perotti, Stefano (ste…
#>  9 vXvv8HN… Mh2F… 2026-05-… stefano  Perotti, Stefano (s… Perotti, Stefano (ste…
#> 10 S0sKmLC… Mh2F… 2026-08-… stefano  Perotti, Stefano (s… Perotti, Stefano (ste…
#> # ℹ 342 more rows
#> # ℹ abbreviated name: ¹​lastupdatedbydisplayname
#> # ℹ 15 more variables: lastupdated <chr>, scheduleddate <chr>,
#> #   enrollmentdate <chr>, incidentdate <chr>, tei <chr>, pi <chr>,
#> #   geometry <chr>, longitude <dbl>, latitude <dbl>, ouname <chr>,
#> #   ounamehierarchy <chr>, oucode <chr>, programstatus <chr>,
#> #   eventstatus <chr>, ou <chr>
```
