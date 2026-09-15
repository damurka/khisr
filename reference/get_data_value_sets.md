# Get Raw Data Values from a DHIS2 Instance

**\[experimental\]** `get_data_value_sets()` retrieves individually
entered aggregate data values from DHIS2's `dataValueSets` endpoint — as
opposed to
[`get_analytics()`](https://khisr.damurka.com/reference/get_analytics.md),
which returns pre-aggregated, computed values from the analytics tables.
Useful for data-quality auditing, or when you need the raw entered
values (including who entered them and when) rather than an aggregated
view.

## Usage

``` r
get_data_value_sets(
  data_elements = NULL,
  data_sets = NULL,
  data_element_groups = NULL,
  org_units = NULL,
  org_unit_group = NULL,
  children = NULL,
  periods = NULL,
  start_date = NULL,
  end_date = NULL,
  last_updated = NULL,
  id_scheme = NULL,
  ...,
  retry = 2,
  verbosity = 0,
  timeout = 60,
  auth = NULL,
  call = caller_env()
)
```

## Arguments

- data_elements:

  Optional. A vector of data element ids to scope the query to.

- data_sets:

  Optional. A vector of data set ids to scope the query to.

- data_element_groups:

  Optional. A vector of data element group ids to scope the query to.

- org_units:

  Optional. A vector of organisation unit ids to scope the query to.

- org_unit_group:

  Optional. An organisation unit group id to scope the query to.

- children:

  Optional. If `TRUE`, also includes data for the descendants of
  `org_units`, not just `org_units` itself. DHIS2 defaults to `FALSE`
  (exact org units only) when not set.

- periods:

  Optional. A vector of ISO period strings (e.g. `'202501'`). Required
  unless `start_date`/`end_date` are given instead.

- start_date, end_date:

  Optional. ISO-8601 dates bounding the query, as an alternative to
  `periods`.

- last_updated:

  Optional. ISO-8601 date or datetime string; only returns data values
  updated after this point.

- id_scheme:

  Optional. Remaps identifiers in the response (e.g. `'code'`) instead
  of the default DHIS2 UIDs.

- ...:

  Other query parameters supported by your DHIS2 instance's
  `dataValueSets` endpoint.

- retry:

  Number of times to retry the API call in case of failure (defaults to
  2).

- verbosity:

  Level of HTTP information to print during the call.

- timeout:

  Maximum number of seconds to wait for the DHIS2 API response.

- auth:

  Optional. The authentication object.

- call:

  The caller environment.

## Value

A tibble of data values (`dataElement`, `period`, `orgUnit`,
`categoryOptionCombo`, `attributeOptionCombo`, `value`, `storedBy`,
`created`, `lastUpdated`, `comment`, `followup`), or `NULL` if none were
found.

## Details

DHIS2 requires this query to be scoped by at least one of
`data_elements`, `data_sets`, or `data_element_groups`; by at least one
of `org_units` or `org_unit_group`; and by either `periods` or
`start_date`/`end_date`. An unscoped query will be rejected by the
server. Confirmed live against a public DHIS2 demo instance: without
`children = TRUE`, `org_units` matches only that exact organisation
unit, not its descendants — a query that returned 0 values with
`org_units` alone returned real data once `children = TRUE` was added.

Unlike the metadata and Tracker endpoints, `dataValueSets` is not
paginated — it returns the full matching result set in a single
response.

## See also

[`get_analytics()`](https://khisr.damurka.com/reference/get_analytics.md)
for pre-aggregated analytics values,
[`get_data_sets_by_level()`](https://khisr.damurka.com/reference/get_data_sets_by_level.md)
for data set reporting-rate metrics.

## Examples

``` r

# Raw data values for a data set at an org unit and everything below it,
# for a single period
get_data_value_sets(data_sets = 'VEM58nY22sO',
                    org_units = 'W6sNfkJcXGC',
                    children = TRUE,
                    periods = '202401')
#> # A tibble: 658 × 10
#>    dataElement period orgUnit     categoryOptionCombo attributeOptionCombo value
#>    <chr>       <chr>  <chr>       <chr>               <chr>                <chr>
#>  1 BjDrgVrkBI3 202401 FV43JisquSm hF0pQZIn6Ch         HllvX50cXC0          623  
#>  2 BjDrgVrkBI3 202401 FV43JisquSm oPcWGgS2Liz         HllvX50cXC0          883  
#>  3 BjDrgVrkBI3 202401 FV43JisquSm rtfSaMjPyq6         HllvX50cXC0          197  
#>  4 BjDrgVrkBI3 202401 zZJMzjivp7q hF0pQZIn6Ch         HllvX50cXC0          1191 
#>  5 BjDrgVrkBI3 202401 zZJMzjivp7q rtfSaMjPyq6         HllvX50cXC0          376  
#>  6 BjDrgVrkBI3 202401 qJzrmj5CTmC hF0pQZIn6Ch         HllvX50cXC0          106  
#>  7 BjDrgVrkBI3 202401 qJzrmj5CTmC oPcWGgS2Liz         HllvX50cXC0          34   
#>  8 BjDrgVrkBI3 202401 qJzrmj5CTmC rtfSaMjPyq6         HllvX50cXC0          34   
#>  9 BjDrgVrkBI3 202401 x4QB3b50NtR hF0pQZIn6Ch         HllvX50cXC0          55   
#> 10 BjDrgVrkBI3 202401 x4QB3b50NtR oPcWGgS2Liz         HllvX50cXC0          10   
#> # ℹ 648 more rows
#> # ℹ 4 more variables: storedBy <chr>, created <chr>, lastUpdated <chr>,
#> #   followup <lgl>
```
