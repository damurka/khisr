# Retrieve the Configured DHIS2 API Version

This function returns the API version requests are pinned to, as set via
the `api_version` argument of
[`khis_cred()`](https://khisr.damurka.com/reference/khis_cred.md).
Returns `NULL` when no version is pinned, meaning requests use the
server's own default version.

## Usage

``` r
khis_api_version(auth = NULL)
```

## Arguments

- auth:

  (Optional) An auth object containing the DHIS2 credentials. If not
  provided, the function retrieves the API version from the global auth
  object.

## Value

The pinned DHIS2 API version as a string, or `NULL` if not set.

## See also

Other credential functions:
[`khis_base_url()`](https://khisr.damurka.com/reference/khis_base_url.md),
[`khis_cred()`](https://khisr.damurka.com/reference/khis_cred.md),
[`khis_cred_clear()`](https://khisr.damurka.com/reference/khis_cred_clear.md),
[`khis_display_name()`](https://khisr.damurka.com/reference/khis_display_name.md),
[`khis_has_cred()`](https://khisr.damurka.com/reference/khis_has_cred.md),
[`khis_username()`](https://khisr.damurka.com/reference/khis_username.md)

## Examples

``` r

if (FALSE) { # \dontrun{
    khis_cred(username = 'DHIS2 username',
              password = 'DHIS2 password',
              server = 'https://<dhis2-instance>',
              api_version = '40')

    # Retrieve the pinned API version (expect '40')
    khis_api_version()
} # }
```
