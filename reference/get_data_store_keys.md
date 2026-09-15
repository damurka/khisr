# Get the Keys in a DHIS2 Data Store Namespace

**\[experimental\]** `get_data_store_keys()` lists the keys stored under
a namespace in a DHIS2 instance's key/value data store. See
[`get_data_store_namespaces()`](https://khisr.damurka.com/reference/get_data_store_namespaces.md).

## Usage

``` r
get_data_store_keys(
  namespace,
  store = c("system", "user"),
  auth = NULL,
  call = caller_env()
)
```

## Arguments

- namespace:

  A data store namespace, as returned by
  [`get_data_store_namespaces()`](https://khisr.damurka.com/reference/get_data_store_namespaces.md).

- store:

  Optional. `'system'` (default) or `'user'`; see
  [`get_data_store_namespaces()`](https://khisr.damurka.com/reference/get_data_store_namespaces.md).

- auth:

  Optional. The authentication object.

- call:

  The caller environment.

## Value

A character vector of keys, or `NULL` if the namespace has none.
Confirmed live against a public DHIS2 demo instance.

## See also

[`get_data_store_namespaces()`](https://khisr.damurka.com/reference/get_data_store_namespaces.md),
[`get_data_store_value()`](https://khisr.damurka.com/reference/get_data_store_value.md).

## Examples

``` r

namespaces <- get_data_store_namespaces()
get_data_store_keys(namespaces[1])
#> [1] "configurations"        "configurationsMaurice" "configurationsTOM"    
```
