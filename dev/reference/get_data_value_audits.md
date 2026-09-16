# Get Data Value Change History from a DHIS2 Instance

**\[experimental\]** `get_data_value_audits()` retrieves the audit trail
(who changed a data value, when, and to what) from DHIS2's
`audits/dataValue` endpoint.

## Usage

``` r
get_data_value_audits(
  data_elements = NULL,
  org_units = NULL,
  periods = NULL,
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

- org_units:

  Optional. A vector of organisation unit ids to scope the query to.

- periods:

  Optional. A vector of ISO period strings to scope the query to.

- ...:

  Other query parameters supported by your DHIS2 instance's
  `audits/dataValue` endpoint (e.g. `categoryOptionCombo`,
  `attributeOptionCombo`).

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

A tibble of data value audit records (data element, period, org unit,
category/attribute option combos, value, modified date, audit type), or
`NULL` if none were found.

## Details

Confirmed live against a public DHIS2 demo instance that this endpoint
accepts these parameters and returns a valid, empty result — the data
value tried had no recorded edit history, so the shape of a populated
result is not independently verified.

## Examples

``` r

get_data_value_audits(data_elements = 'lYsfXxCw6Qi',
                      org_units = 'W6sNfkJcXGC',
                      periods = '202301')
#> Warning: ! No data value audits found for the specified query.
#> NULL
```
