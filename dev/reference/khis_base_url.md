# Retrieve the Configured DHIS2 API Base URL

This function returns the base URL for the DHIS2 API from the provided
auth object, or falls back to the global auth credentials if `auth` is
not provided.

## Usage

``` r
khis_base_url(auth = NULL)
```

## Arguments

- auth:

  (Optional) An auth object containing the DHIS2 credentials. If not
  provided, the function retrieves the base URL from the global auth
  object.

## Value

The DHIS2 base URL as a string, or `NULL` if no credentials are
available.

## See also

Other credential functions:
[`khis_cred()`](https://khisr.damurka.com/dev/reference/khis_cred.md),
[`khis_cred_clear()`](https://khisr.damurka.com/dev/reference/khis_cred_clear.md),
[`khis_display_name()`](https://khisr.damurka.com/dev/reference/khis_display_name.md),
[`khis_has_cred()`](https://khisr.damurka.com/dev/reference/khis_has_cred.md),
[`khis_username()`](https://khisr.damurka.com/dev/reference/khis_username.md)

## Examples

``` r
if (FALSE) { # \dontrun{
    # Set the credentials using the global .auth object
    khis_cred(username = 'DHIS2 username',
              password = 'DHIS2 password',
              server = 'https://<dhis2-instance>')

    # Retrieve the DHIS2 instance API base URL (expect 'https://<dhis2-instance>')
    khis_base_url()

    # Clear credentials
    khis_cred_clear()

    # Retrieve the base URL again (expect 'NULL')
    khis_base_url()
} # }
```
