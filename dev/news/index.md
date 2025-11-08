# Changelog

## khisr (development version)

## khisr 1.0.6

CRAN release: 2024-10-06

### New Features

- **Introduced `server` argument**: The `server` argument now accepts
  the server URL without the `/api` suffix, simplifying the
  configuration of DHIS2 credentials and API calls.

### Deprecations

- **Deprecated `base_url` in
  [`khis_cred()`](https://khisr.damurka.com/dev/reference/khis_cred.md)**:
  The `base_url` argument is now deprecated in favour of the new
  `server` argument.
- **Deprecated default `base_url` value**: The default value previously
  used for the `base_url` argument is no longer supported. Users should
  provide an explicit `server` URL moving forward.

### Enhancements

- **Improved testing**: Test coverage has been enhanced to automatically
  skip tests when the target server is unreachable or down, ensuring
  smoother testing workflows in offline or server downtime conditions.

## khisr 1.0.5

CRAN release: 2024-06-27

- **Improved Authentication**: Now supports optional authentication for
  API calls using the `auth` argument. This strengthens security by
  allowing you to control access to your data.

- **Clearer Error Messages**: Provides more informative error messages
  to help you identify and troubleshoot issues more efficiently.

## khisr 1.0.4

CRAN release: 2024-06-10

- Improved Credential Handling:
  - [`khis_has_cred()`](https://khisr.damurka.com/dev/reference/khis_has_cred.md):
    Now ensures credentials are valid before returning TRUE, preventing
    unauthorized access.
  - [`khis_cred()`](https://khisr.damurka.com/dev/reference/khis_cred.md):
    Includes validation to accept only valid credentials, reducing
    errors.

## khisr 1.0.3

CRAN release: 2024-06-08

### New features

- Introduced experimental functions for enhanced data retrieval:

  - [`get_data_elements_with_category_options()`](https://khisr.damurka.com/dev/reference/get_data_elements_with_category_options.md):
    Fetch data elements along with their associated category option
    values.
  - [`get_organisations_by_level()`](https://khisr.damurka.com/dev/reference/get_organisations_by_level.md):
    Retrieve organizations filtered by level.
  - [`get_analytics_by_level()`](https://khisr.damurka.com/dev/reference/get_analytics_by_level.md):
    Obtain analytics table data
  - [`get_data_sets_by_level()`](https://khisr.damurka.com/dev/reference/get_data_sets_by_level.md):
    Retrieve data set reporting rate metrics.

- Added the
  [`khis_base_url()`](https://khisr.damurka.com/dev/reference/khis_base_url.md)
  to obtain the DHIS2 API URL.

- Introduced
  [`get_organisation_unit_levels()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  to retrieve the available organisation levels in the DHIS2 instance.

### Minor improvements and fixes

- Made the package generic to support any DHIS2 instance and updated the
  documentation accordingly.

- Modified the
  [`khis_cred()`](https://khisr.damurka.com/dev/reference/khis_cred.md)
  to require the `base_url` argument and deprecated the default value.

## khisr 1.0.2

CRAN release: 2024-04-14

- Updated the
  [`khis_cred_clear()`](https://khisr.damurka.com/dev/reference/khis_cred_clear.md)
  to reset the `base_url` back to KHIS API.

- Updated the
  [`khis_cred()`](https://khisr.damurka.com/dev/reference/khis_cred.md)
  to allow `base_url` be set from the config file.

## khisr 1.0.1

CRAN release: 2024-02-05

- Initial CRAN submission.
