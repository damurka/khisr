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

### Additional Functions

- [`khis_has_cred()`](https://khisr.damurka.com/dev/reference/khis_has_cred.md):
  Confirms that your credentials have been set successfully.
- [`khis_username()`](https://khisr.damurka.com/dev/reference/khis_username.md):
  Retrieves the username of the currently logged-in user.
- [`khis_base_url()`](https://khisr.damurka.com/dev/reference/khis_base_url.md):
  Retrieve the base url of the DHIS2 instance being used
- [`khis_cred_clear()`](https://khisr.damurka.com/dev/reference/khis_cred_clear.md):
  Clears the credentials of the currently logged-in user.
