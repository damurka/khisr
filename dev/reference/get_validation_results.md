# Get Validation Rule Results from DHIS2

**\[experimental\]** `get_validation_results()` retrieves violated
validation rules for an organisation unit and period range from DHIS2's
`validationResults` endpoint — useful for data-quality review.

## Usage

``` r
get_validation_results(
  org_units,
  start_date,
  end_date,
  ...,
  retry = 2,
  verbosity = 0,
  timeout = 60,
  auth = NULL,
  call = caller_env()
)
```

## Arguments

- org_units:

  A vector of organisation unit ids to scope the query to.

- start_date, end_date:

  ISO-8601 dates bounding the query.

- ...:

  Other query parameters supported by your DHIS2 instance's
  `validationResults` endpoint (e.g. `vrg` to scope to a validation rule
  group).

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

A tibble of validation results (organisation unit, period, validation
rule, and the left/right side values that violated it), or `NULL` if
none were found.

## Details

Confirmed live against a public DHIS2 demo instance that this endpoint
(`/api/validationResults`, not `/api/analytics/validationResults`, which
404s) accepts these parameters and returns a valid, empty result — the
instance tested had no stored validation violations for the org units
and periods tried, so the shape of a populated result is not
independently verified.

## Examples

``` r

get_validation_results(org_units = 'IWp9dQGM0bS',
                       start_date = '2023-01-01',
                       end_date = '2023-12-31')
#> Warning: ! No validation results found for the specified query.
#> NULL
```
