# Get File Resources Metadata from a DHIS2 Instance

**\[experimental\]** `get_file_resources()` lists the metadata of files
stored in a DHIS2 instance — icons, and files/images attached to tracker
attribute values or data values — from the `fileResources` endpoint.
This retrieves metadata only (name, content type, size); it does not
download file contents.

## Usage

``` r
get_file_resources(
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
  `fileResources` endpoint.

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

A tibble of file resources (`id`, `name`, `contentType`,
`contentLength`), or `NULL` if none were found. Confirmed live against a
public DHIS2 demo instance.

## Examples

``` r

get_file_resources(contentType %.like% 'image')
#> # A tibble: 897 × 4
#>    name                      contentType   contentLength id         
#>    <chr>                     <chr>                 <int> <chr>      
#>  1 icon_2g_negative          image/svg+xml          3630 X1BCKkB1jt6
#>  2 icon_2g_outline           image/svg+xml          3992 Cvi9rSwFmQ6
#>  3 icon_2g_positive          image/svg+xml          3823 wDM3C5EJkyA
#>  4 icon_3g_negative          image/svg+xml          3837 OdfpcgXwTWq
#>  5 icon_3g_outline           image/svg+xml          4193 Mhtg2NvQ7CI
#>  6 icon_3g_positive          image/svg+xml          4005 VmuczNukQvF
#>  7 icon_4x4_negative         image/svg+xml          2943 snuRqbJeFXo
#>  8 icon_4x4_outline          image/svg+xml          4311 R6Akp8AawBw
#>  9 icon_4x4_positive         image/svg+xml          3067 cdc4KSn6pWE
#> 10 icon_agriculture_negative image/svg+xml          2497 WYQraTpYV37
#> # ℹ 887 more rows
```
