# Sets DHIS2 Credentials

`khis_cred()` sets the credentials for accessing a DHIS2 instance.

## Usage

``` r
khis_cred(
  username = NULL,
  password = NULL,
  server = NULL,
  api_version = NULL,
  config_path = NULL,
  base_url = deprecated()
)
```

## Arguments

- username:

  The DHIS2 username. Only required if configuration file not provided.

- password:

  The DHIS2 password. Only required if configuration file not provided.

- server:

  The server URL of the DHIS2 instance. Only required if configuration
  file not provided.

- api_version:

  The API version of the DHIS2 instance (optional).

- config_path:

  An optional path to a configuration file containing username and
  password. This is considered more secure than providing credentials
  directly in code.

- base_url:

  Deprecated. The base URL of the DHIS2 instance. Use `server` instead.

## Value

Auth object

## Details

This function allows you to set the credentials for interacting with a
DHIS2 server. You can either provide the username and password directly
(less secure) or specify a path to a configuration file containing these
credentials. Using a configuration file is recommended for improved
security as it prevents credentials from being stored directly in your
code.

## See also

Other credential functions:
[`khis_base_url()`](https://khisr.damurka.com/dev/reference/khis_base_url.md),
[`khis_cred_clear()`](https://khisr.damurka.com/dev/reference/khis_cred_clear.md),
[`khis_display_name()`](https://khisr.damurka.com/dev/reference/khis_display_name.md),
[`khis_has_cred()`](https://khisr.damurka.com/dev/reference/khis_has_cred.md),
[`khis_username()`](https://khisr.damurka.com/dev/reference/khis_username.md)

## Examples

``` r
if (FALSE) { # \dontrun{
    # Option 1: Using a configuration file (recommended)
    # Assuming a configuration file named "credentials.json":
    khis_cred(config_path = "path/to/credentials.json")

    # Option 2: Providing credentials directly (less secure)
    khis_cred(username = "your_username",
              password = "your_password",
              server='https://<dhis2-instance>')
} # }
```
