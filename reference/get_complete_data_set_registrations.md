# Get Raw Data Set Completeness Registrations from a DHIS2 Instance

**\[experimental\]** `get_complete_data_set_registrations()` retrieves
the raw completeness-registration records (who marked a data set
complete, and when) from DHIS2's `completeDataSetRegistrations` endpoint
— the raw counterpart to
[`get_data_sets_by_level()`](https://khisr.damurka.com/reference/get_data_sets_by_level.md)'s
aggregated reporting-rate view, the same way
[`get_data_value_sets()`](https://khisr.damurka.com/reference/get_data_value_sets.md)
complements
[`get_analytics()`](https://khisr.damurka.com/reference/get_analytics.md).

## Usage

``` r
get_complete_data_set_registrations(
  data_sets,
  org_units,
  children = NULL,
  periods,
  ...,
  retry = 2,
  verbosity = 0,
  timeout = 60,
  auth = NULL,
  call = caller_env()
)
```

## Arguments

- data_sets:

  A vector of data set ids to scope the query to.

- org_units:

  A vector of organisation unit ids to scope the query to.

- children:

  Optional. If `TRUE`, also includes registrations for the descendants
  of `org_units`, not just `org_units` itself. DHIS2 defaults to `FALSE`
  (exact org units only) when not set.

- periods:

  A vector of ISO period strings (e.g. `'202501'`).

- ...:

  Other query parameters supported by your DHIS2 instance's
  `completeDataSetRegistrations` endpoint.

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

A tibble of registrations (`period`, `dataSet`, `organisationUnit`,
`attributeOptionCombo`, `date`, `storedBy`, `completed`), or `NULL` if
none were found.

## Details

Like `dataValueSets`, this endpoint is not paginated — it returns the
full matching result set in a single response. Confirmed live against a
public DHIS2 demo instance.

## See also

[`get_data_sets_by_level()`](https://khisr.damurka.com/reference/get_data_sets_by_level.md)
for aggregated reporting-rate metrics,
[`get_data_value_sets()`](https://khisr.damurka.com/reference/get_data_value_sets.md)
for the raw data-value equivalent.

## Examples

``` r

get_complete_data_set_registrations(data_sets = 'VEM58nY22sO',
                                    org_units = 'W6sNfkJcXGC',
                                    children = TRUE,
                                    periods = '202301')
#> # A tibble: 16 × 7
#>    period dataSet organisationUnit attributeOptionCombo date  storedBy completed
#>    <chr>  <chr>   <chr>            <chr>                <chr> <chr>    <lgl>    
#>  1 202301 VEM58n… xxBxJFWXtrL      HllvX50cXC0          2023… automat… TRUE     
#>  2 202301 VEM58n… C9ncRif5rMV      HllvX50cXC0          2023… automat… TRUE     
#>  3 202301 VEM58n… v3HIu78Y4Wf      HllvX50cXC0          2023… automat… TRUE     
#>  4 202301 VEM58n… rmJxaV9ggj7      HllvX50cXC0          2022… automat… TRUE     
#>  5 202301 VEM58n… NMDH3yjPLSx      HllvX50cXC0          2022… automat… TRUE     
#>  6 202301 VEM58n… stZjLrN1xcG      HllvX50cXC0          2022… automat… TRUE     
#>  7 202301 VEM58n… FV43JisquSm      HllvX50cXC0          2023… automat… TRUE     
#>  8 202301 VEM58n… zZJMzjivp7q      HllvX50cXC0          2023… automat… TRUE     
#>  9 202301 VEM58n… x4QB3b50NtR      HllvX50cXC0          2022… automat… TRUE     
#> 10 202301 VEM58n… GkJ20Hb7A0o      HllvX50cXC0          2022… automat… TRUE     
#> 11 202301 VEM58n… JKmnoq8c2DK      HllvX50cXC0          2022… automat… TRUE     
#> 12 202301 VEM58n… M8XzhGmQ0ii      HllvX50cXC0          2022… automat… TRUE     
#> 13 202301 VEM58n… OIPTqLl7c3s      HllvX50cXC0          2022… automat… TRUE     
#> 14 202301 VEM58n… CselRxCm5BO      HllvX50cXC0          2022… automat… TRUE     
#> 15 202301 VEM58n… Hu9VkXah8RX      HllvX50cXC0          2022… automat… TRUE     
#> 16 202301 VEM58n… y7jFepm7IF6      HllvX50cXC0          2023… automat… TRUE     
```
