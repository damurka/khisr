# Retrieve the Configured Username

This function returns the username from the configured credentials. If
an auth object is provided, it retrieves the username from that object.
Otherwise, it retrieves the username from the global auth object.

## Usage

``` r
khis_username(auth = NULL)
```

## Arguments

- auth:

  (Optional) An auth object. If not provided, the function will retrieve
  the username from the global auth credentials.

## Value

The username as a string, or `NULL` if no credentials are available.

## See also

Other credential functions:
[`khis_base_url()`](https://khisr.damurka.com/dev/reference/khis_base_url.md),
[`khis_cred()`](https://khisr.damurka.com/dev/reference/khis_cred.md),
[`khis_cred_clear()`](https://khisr.damurka.com/dev/reference/khis_cred_clear.md),
[`khis_display_name()`](https://khisr.damurka.com/dev/reference/khis_display_name.md),
[`khis_has_cred()`](https://khisr.damurka.com/dev/reference/khis_has_cred.md)

## Examples

``` r
if (FALSE) { # \dontrun{
    # Set the credentials using global .auth object
    khis_cred(username = 'DHIS2 username',
              password = 'DHIS2 password',
              server = 'https://<dhis2-instance>')

    # View the username (expect 'DHIS2 username')
    khis_username()

    # Clear credentials
    khis_cred_clear()

    # View the username (expect 'NULL')
    khis_username()
} # }
```
