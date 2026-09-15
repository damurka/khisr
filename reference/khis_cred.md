# Sets DHIS2 Credentials

`khis_cred()` sets the credentials for accessing a DHIS2 instance.

## Usage

``` r
khis_cred(
  username = NULL,
  password = NULL,
  token = NULL,
  server = NULL,
  api_version = NULL,
  config_path = NULL,
  base_url = deprecated()
)
```

## Arguments

- username:

  The DHIS2 username. Only required if neither `config_path` nor `token`
  is provided.

- password:

  The DHIS2 password. Only required if neither `config_path` nor `token`
  is provided.

- token:

  A DHIS2 [Personal Access
  Token](https://docs.dhis2.org/en/use/user-guides/dhis-core-version-master/working-with-your-account/personal-access-tokens.html),
  as an alternative to `username`/`password`. DHIS2 recommends tokens
  over Basic Authentication for scripts and integrations. Cannot be
  combined with `username`/`password` or `config_path`.

- server:

  The server URL of the DHIS2 instance. Only required if configuration
  file not provided.

- api_version:

  Optional. Pins requests to a specific DHIS2 API version (e.g. `"40"`),
  so calls hit `<server>/api/40/<endpoint>` instead of
  `<server>/api/<endpoint>`. Useful for guarding against behavioural
  differences between DHIS2 core versions across instances. Defaults to
  the server's own default API version when not set.

- config_path:

  An optional path to a configuration file containing either
  `username`/`password` or a `token`. This is considered more secure
  than providing credentials directly in code.

- base_url:

  Deprecated. The base URL of the DHIS2 instance. Use `server` instead.

## Value

Auth object

## Details

This function allows you to set the credentials for interacting with a
DHIS2 server. You can provide `username`/`password` directly, a `token`
directly, or specify a path to a configuration file containing either.
Using a configuration file is recommended for improved security as it
prevents credentials from being stored directly in your code.

Token authentication sends `Authorization: ApiToken <token>`, confirmed
by generating a real token (`POST /api/apiToken`) against a live public
DHIS2 demo instance and using it to authenticate and retrieve real data;
like Basic Authentication's username/password, the token is redacted and
never printed in verbose/debug request output.

## See also

Other credential functions:
[`khis_api_version()`](https://khisr.damurka.com/reference/khis_api_version.md),
[`khis_base_url()`](https://khisr.damurka.com/reference/khis_base_url.md),
[`khis_cred_clear()`](https://khisr.damurka.com/reference/khis_cred_clear.md),
[`khis_display_name()`](https://khisr.damurka.com/reference/khis_display_name.md),
[`khis_has_cred()`](https://khisr.damurka.com/reference/khis_has_cred.md),
[`khis_username()`](https://khisr.damurka.com/reference/khis_username.md)

## Examples

``` r

if (FALSE) { # \dontrun{
    # Option 1: Using a configuration file (recommended)
    # Assuming a configuration file named "credentials.json":
    khis_cred(config_path = "path/to/credentials.json")

    # Option 2: Providing username/password directly (less secure)
    khis_cred(username = "your_username",
              password = "your_password",
              server='https://<dhis2-instance>')

    # Option 3: Providing a Personal Access Token directly (less secure)
    khis_cred(token = "d2pat_...",
              server = 'https://<dhis2-instance>')
} # }
```
