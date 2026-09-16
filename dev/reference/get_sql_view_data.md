# Get Data from a DHIS2 SQL View

**\[experimental\]** `get_sql_view_data()` retrieves the data produced
by a SQL view identified by
[`get_sql_views()`](https://khisr.damurka.com/dev/reference/get_sql_views.md)
— a predefined, admin-authored SQL query exposed as a data endpoint.

## Usage

``` r
get_sql_view_data(
  sql_view,
  variables = NULL,
  ...,
  retry = 2,
  verbosity = 0,
  timeout = 60,
  auth = NULL,
  call = caller_env()
)
```

## Arguments

- sql_view:

  A SQL view id.

- variables:

  Optional. A named character vector of variable substitutions for a
  parameterised SQL view, e.g. `c(orgUnit = 'ImspTQPwCqd')`.

- ...:

  Other query parameters supported by your DHIS2 instance's `sqlViews`
  data endpoint.

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

A tibble of the SQL view's result rows, or `NULL` if none were
retrieved.

## Details

A view of type `'QUERY'` (see
[`get_sql_views()`](https://khisr.damurka.com/dev/reference/get_sql_views.md))
is executed on demand; a `'VIEW'` is queried directly. **This function's
response shape has not been independently verified live**: every SQL
view on the public demo instance used to verify khisr's other functions
returned `403 Forbidden` ("not authorised") or `409 Conflict`
(referencing an analytics table this particular demo hadn't built) for
this account — both account/instance issues rather than request errors.
The shape below follows DHIS2's documented `listGrid` structure (shared
with a few other legacy DHIS2 endpoints), reusing the same
`headers`/`rows` parsing as
[`get_analytics()`](https://khisr.damurka.com/dev/reference/get_analytics.md);
confirm it against your own instance before relying on this function in
production.

## See also

[`get_sql_views()`](https://khisr.damurka.com/dev/reference/get_sql_views.md)
for listing available SQL views.

## Examples

``` r

if (FALSE) { # \dontrun{
views <- get_sql_views()
get_sql_view_data(views$id[1])
} # }
```
