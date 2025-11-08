# Retrieve the Configured Display Name

This function returns the display name from the configured profile in
the provided auth object. If `auth` is not provided, it falls back to
the global auth credentials.

## Usage

``` r
khis_display_name(auth = NULL)
```

## Arguments

- auth:

  (Optional) An auth object containing DHIS2 credentials. If not
  provided, the function retrieves the display name from the global auth
  object.

## Value

The display name as a string, or `NULL` if no profile or display name is
available.

## See also

Other credential functions:
[`khis_base_url()`](https://khisr.damurka.com/dev/reference/khis_base_url.md),
[`khis_cred()`](https://khisr.damurka.com/dev/reference/khis_cred.md),
[`khis_cred_clear()`](https://khisr.damurka.com/dev/reference/khis_cred_clear.md),
[`khis_has_cred()`](https://khisr.damurka.com/dev/reference/khis_has_cred.md),
[`khis_username()`](https://khisr.damurka.com/dev/reference/khis_username.md)

## Examples

``` r
if (FALSE) { # \dontrun{
    # Set the credentials using global .auth object
    khis_cred(username = 'DHIS2 username',
              password = 'DHIS2 password',
              server = 'https://<dhis2-instance>')

    # Retrieve the display name from the global .auth profile
    khis_display_name()

    # Clear credentials
    khis_cred_clear()

    # Retrieve the display name again (expect 'NULL')
    khis_display_name()
} # }
```
