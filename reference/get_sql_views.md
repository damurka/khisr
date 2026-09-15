# Get SQL Views Metadata from a DHIS2 Instance

**\[experimental\]** `get_sql_views()` lists the SQL views configured on
a DHIS2 instance — predefined, admin-authored SQL queries exposed as a
data endpoint. Use
[`get_sql_view_data()`](https://khisr.damurka.com/reference/get_sql_view_data.md)
to retrieve the actual data for one of them.

## Usage

``` r
get_sql_views(
  ...,
  retry = 2,
  verbosity = 0,
  timeout = 60,
  auth = NULL,
  call = caller_env()
)
```

## Arguments

- ...:

  [`metadata_filter()`](https://khisr.damurka.com/reference/metadata-filter.md)
  parameters, or their infix-operator shorthand, to filter the results,
  and/or other query parameters supported by your DHIS2 instance's
  `sqlViews` endpoint.

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

A tibble of SQL views (`id`, `name`, `type` — `'VIEW'` for a
materialized view queryable directly, or `'QUERY'` for one that must be
executed first), or `NULL` if none were found. Confirmed live against a
public DHIS2 demo instance.

## See also

[`get_sql_view_data()`](https://khisr.damurka.com/reference/get_sql_view_data.md)
for retrieving a view's data.

## Examples

``` r

get_sql_views()
#> # A tibble: 134 × 3
#>    name                                                              type  id   
#>    <chr>                                                             <chr> <chr>
#>  1 "Anacod export"                                                   QUERY XpI2…
#>  2 "DRS - Line list"                                                 VIEW  VKcy…
#>  3 "TB CS - T2A mapping - Case notification (quarterly)"             QUERY sskL…
#>  4 "[Data] Aggregate data by data set, data element, month (pivot t… QUERY fYro…
#>  5 "[Data] Aggregate data values by data set and orgunit level"      QUERY kchB…
#>  6 "[Data] Aggregate data values by dataset 202207-202312"           QUERY PUFB…
#>  7 "[Data] Events by program 202207-202312"                          QUERY Kdo8…
#>  8 "[Data] Events by programme and orgunit level"                    QUERY Z4o0…
#>  9 "[Data] Events with start/end dates"                              QUERY LxUL…
#> 10 "[Data] Tracker date diffs from enrollment to event"              QUERY trvx…
#> # ℹ 124 more rows
```
