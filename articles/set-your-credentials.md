# Set your credentials

## Setting your credentials

This guide outlines how to set your credentials for accessing data from
a DHIS2 instance. DHIS2 (District Health Information System 2) is a
widely used open-source platform for health data management.To access
the data through the `khisr` package, you need to provide valid
credentials.

The `khisr` package cannot make calls to DHIS2 without credentials, and
incorrect credentials will result in an unauthorized error from DHIS2.

This method is recommended for security reasons as it avoids storing
credentials directly in your code.

``` r

khis_cred(config_path = "/path/to/the/JSON/file.json")
```

The JSON file should have the following format:

``` json
{
  "credentials": {
    "username": "your-dhis2-username",
    "password": "your-dhis2-password",
    "server": "https://<dhis2 api instance>"
  }
}
```

### Alternative Method: Direct Input

If you cannot use a JSON file, you can provide your username and
password directly:

``` r

khis_cred(username = 'your_username', password = 'your_password', server = 'https://<dhis2 api instance>')
```

### Personal Access Tokens

DHIS2 also supports [Personal Access
Tokens](https://docs.dhis2.org/en/use/user-guides/dhis-core-version-master/working-with-your-account/personal-access-tokens.html)
as an alternative to username/password, and recommends them over Basic
Authentication for scripts and integrations — since a token can be
scoped and revoked independently of your account password. Generate one
from your DHIS2 account settings (or `POST /api/apiToken`), then use it
in place of `username`/`password`, either directly:

``` r

khis_cred(token = 'd2pat_...', server = 'https://<dhis2 api instance>')
```

or via the JSON configuration file, using `token` instead of
`username`/`password`:

``` json
{
  "credentials": {
    "token": "d2pat_...",
    "server": "https://<dhis2 api instance>"
  }
}
```

`token` cannot be combined with `username`/`password` — provide one or
the other. When authenticating with a token, \[khis_username()\] returns
`NULL`, since a token isn’t tied to a username the way Basic
Authentication is.

### Additional Functions

- [`khis_has_cred()`](https://khisr.damurka.com/reference/khis_has_cred.md):
  Confirms that your credentials have been set successfully.
- [`khis_username()`](https://khisr.damurka.com/reference/khis_username.md):
  Retrieves the username of the currently logged-in user (`NULL` when
  using a token).
- [`khis_display_name()`](https://khisr.damurka.com/reference/khis_display_name.md):
  Retrieves the display name of the currently logged-in user.
- [`khis_base_url()`](https://khisr.damurka.com/reference/khis_base_url.md):
  Retrieve the base url of the DHIS2 instance being used.
- [`khis_api_version()`](https://khisr.damurka.com/reference/khis_api_version.md):
  Retrieve the DHIS2 API version requests are pinned to, if any (see
  `api_version` in \[khis_cred()\]).
- [`khis_cred_clear()`](https://khisr.damurka.com/reference/khis_cred_clear.md):
  Clears the credentials of the currently logged-in user.
