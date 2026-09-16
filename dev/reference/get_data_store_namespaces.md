# Get DHIS2 Data Store Namespaces

**\[experimental\]** `get_data_store_namespaces()` lists the namespaces
in a DHIS2 instance's key/value data store — arbitrary JSON
configuration used by DHIS2 apps (e.g. the Maps app, Tracker Capture).
Use
[`get_data_store_keys()`](https://khisr.damurka.com/dev/reference/get_data_store_keys.md)
and
[`get_data_store_value()`](https://khisr.damurka.com/dev/reference/get_data_store_value.md)
to read a namespace's contents.

## Usage

``` r
get_data_store_namespaces(
  store = c("system", "user"),
  auth = NULL,
  call = caller_env()
)
```

## Arguments

- store:

  Optional. `'system'` (default), the shared instance-wide store, or
  `'user'`, the store private to the authenticated user.

- auth:

  Optional. The authentication object.

- call:

  The caller environment.

## Value

A character vector of namespaces, or `NULL` if none exist. Confirmed
live against a public DHIS2 demo instance.

## See also

[`get_data_store_keys()`](https://khisr.damurka.com/dev/reference/get_data_store_keys.md),
[`get_data_store_value()`](https://khisr.damurka.com/dev/reference/get_data_store_value.md).

## Examples

``` r

get_data_store_namespaces()
#>  [1] "who-dqa"             "bridge"              "CLIMATE_DATA"       
#>  [4] "bulk-load"           "WHO_ICD11_COD"       "dataQualityTool"    
#>  [7] "DHIS2_MAPS_APP_CORE" "tracker-capture"     "analytics"          
#> [10] "Dhis2Transfer"      
```
