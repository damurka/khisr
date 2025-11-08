# Check if DHIS2 Credentials are Available

This function checks whether valid credentials are available either in
the provided auth object or in the global auth credentials object.

## Usage

``` r
khis_has_cred(auth = NULL)
```

## Arguments

- auth:

  (Optional) An auth object containing DHIS2 credentials. If not
  provided, the function will check the global auth object for
  credentials.

## Value

A boolean value indicating whether valid credentials are available.

## See also

Other credential functions:
[`khis_base_url()`](https://khisr.damurka.com/dev/reference/khis_base_url.md),
[`khis_cred()`](https://khisr.damurka.com/dev/reference/khis_cred.md),
[`khis_cred_clear()`](https://khisr.damurka.com/dev/reference/khis_cred_clear.md),
[`khis_display_name()`](https://khisr.damurka.com/dev/reference/khis_display_name.md),
[`khis_username()`](https://khisr.damurka.com/dev/reference/khis_username.md)

## Examples

``` r
if (FALSE) { # \dontrun{
    # Set the credentials using global .auth object
    khis_cred(username = 'DHIS2 username',
              password = 'DHIS2 password',
              server = 'https://dhis2-instance/api')

    # Check if credentials are available. Should return TRUE
    khis_has_cred()

    # Clear global credentials
    khis_cred_clear()

    # Check if credentials are available. Should return FALSE
    khis_has_cred()
} # }
```
