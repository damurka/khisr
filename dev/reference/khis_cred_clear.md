# Clear the Credentials from Memory

This function clears the DHIS2 credentials from memory. If an auth
object is provided, it clears the credentials from that object. If no
`auth` object is provided, it clears the global auth credentials.

## Usage

``` r
khis_cred_clear(auth = NULL)
```

## Arguments

- auth:

  (Optional) An authentication object from which to clear credentials.
  If not provided, the credentials in the global auth object will be
  cleared.

## Value

No return value, called for side effects.

## See also

Other credential functions:
[`khis_base_url()`](https://khisr.damurka.com/dev/reference/khis_base_url.md),
[`khis_cred()`](https://khisr.damurka.com/dev/reference/khis_cred.md),
[`khis_display_name()`](https://khisr.damurka.com/dev/reference/khis_display_name.md),
[`khis_has_cred()`](https://khisr.damurka.com/dev/reference/khis_has_cred.md),
[`khis_username()`](https://khisr.damurka.com/dev/reference/khis_username.md)

## Examples

``` r
# Clear credentials from the global .auth object
khis_cred_clear()
```
