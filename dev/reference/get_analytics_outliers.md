# Get Statistical Outliers from DHIS2 Analytics

**\[experimental\]** `get_analytics_outliers()` retrieves data values
flagged as statistical outliers by DHIS2's `analytics/outlierDetection`
endpoint — useful for data-quality review.

## Usage

``` r
get_analytics_outliers(
  data_elements = NULL,
  data_sets = NULL,
  org_units,
  start_date,
  end_date,
  algorithm = NULL,
  threshold = NULL,
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

  Optional. A vector of data element ids to check. Provide this or
  `data_sets`.

- data_sets:

  Optional. A vector of data set ids to check. Provide this or
  `data_elements`.

- org_units:

  A vector of organisation unit ids to scope the query to.

- start_date, end_date:

  ISO-8601 dates bounding the query.

- algorithm:

  Optional. The detection algorithm: `'Z_SCORE'` (default),
  `'MOD_Z_SCORE'`, or `'MIN_MAX'`.

- threshold:

  Optional. The sensitivity threshold for the chosen algorithm; higher
  values flag fewer outliers.

- ...:

  Other query parameters supported by your DHIS2 instance's
  `analytics/outlierDetection` endpoint (e.g. `maxResults`, `orderBy`).

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

A tibble of outlier values as returned by DHIS2 (typically including the
data element, org unit, period, value, and statistical bounds that
flagged it), or `NULL` if none were found.

## Details

Requires either `data_elements` or `data_sets`. **Unlike the rest of
this package, this endpoint's response shape has not been independently
verified live**: the public demo instance used to verify khisr's other
Tracker/analytics functions returned `403 Forbidden` for this endpoint
regardless of parameters, which appears to be an account-authority
restriction rather than a request error. The field names below follow
DHIS2's published API documentation; confirm them against your own
instance before relying on this function in production.

## See also

[`get_analytics()`](https://khisr.damurka.com/dev/reference/get_analytics.md)
for the underlying aggregated values.

## Examples

``` r

if (FALSE) { # \dontrun{
get_analytics_outliers(data_elements = 'lYsfXxCw6Qi',
                       org_units = 'W6sNfkJcXGC',
                       start_date = '2023-01-01',
                       end_date = '2023-12-31')
} # }
```
