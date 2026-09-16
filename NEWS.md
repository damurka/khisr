# khisr 1.0.8

* Added a link to DHIS2 (`<https://dhis2.org>`) in `Description:`,
  requested by a CRAN reviewer during review of the 1.0.7 submission.

# khisr 1.0.7

This release adds support for DHIS2's Tracker API, Personal Access Token
authentication, and a wide range of new endpoints for analytics, data
quality, and instance metadata — alongside the fix that restores khisr to
CRAN.

## New features

* **Tracker API support**: `get_tracked_entities()`, `get_events()`, and
  `get_enrollments()` retrieve tracked entities, program-stage events, and
  program enrollments, with automatic pagination and attribute-value
  filtering via `tracked_entity_filter()` (and infix operators like
  `%.teq%`, `%.tin%`, `%.tsw%`). `get_relationships()` retrieves links
  between tracker records. Note that `get_events()` takes a single
  `org_unit` (DHIS2's Tracker API only accepts one), while
  `get_tracked_entities()`/`get_enrollments()` take `org_units` (one or
  more). See the new
  [Tracker Data](https://khisr.damurka.com/articles/tracker.html) article.
* **Personal Access Token authentication**: `khis_cred(token = ...)` is now
  a supported alternative to `username`/`password` — DHIS2's own
  recommended method for scripts and integrations.
* **Tracker and event analytics**: `get_event_analytics()` and
  `get_enrollment_analytics()` retrieve dimensional analytics over Tracker
  data; `get_event_analytics_aggregate()`/`get_enrollment_analytics_aggregate()`
  retrieve pivot-table style totals instead.
* **Raw data values and completeness**: `get_data_value_sets()` retrieves
  individually entered data values behind the aggregates, and
  `get_complete_data_set_registrations()` retrieves completeness
  registration records — both useful for data-quality auditing alongside
  the existing `get_analytics()`/`get_data_sets_by_level()`.
* **Data quality checks**: `get_analytics_outliers()` flags statistical
  outliers, `get_validation_results()` retrieves violated validation
  rules, and `get_data_value_audits()` retrieves a data value's change
  history. (These require the DHIS2 account to have the matching
  authority — outlier detection and SQL views in particular are often
  restricted.)
* **Instance and system utilities**: `get_system_info()` (version/build
  info), `get_geo_features()` (org unit coordinates for mapping),
  `get_sql_views()`/`get_sql_view_data()` (predefined SQL views), and
  `get_data_store_namespaces()`/`get_data_store_keys()`/
  `get_data_store_value()` (the key/value data store) round out coverage
  of DHIS2's REST API.
* **New metadata helpers** for Tracker configuration: `get_programs()`,
  `get_program_stages()`, `get_tracked_entity_types()`,
  `get_tracked_entity_attributes()`, `get_relationship_types()`, and
  `get_file_resources()`.
* `get_organisations_by_level()` now includes an id column for every
  ancestor level (e.g. `country_id`, `province_id`) alongside the name, so
  results can be joined back to other data reliably even when two org
  units share a name.

## Bug fixes

* **Fixed the CRAN check failure that got khisr archived**: a couple of
  internal helpers relied on `dplyr::id()`, which was removed in dplyr
  1.2.0.
* Fixed a crash in `get_analytics_by_level()`/`get_data_sets_by_level()`
  when passing extra query options, the exact usage the documentation
  invited.
* Fixed a bug where a failed metadata request produced a garbled, hard to
  read error instead of the actual failure reason.
* Large metadata and organisation-unit lists are now fetched with real
  pagination, instead of relying on a server setting that some instances
  cap or ignore, which could previously truncate results silently.
* Network retries now also cover 502/504 Gateway Timeout errors, common
  behind reverse proxies fronting large DHIS2 instances.
* `khis_cred()`'s `api_version` argument now actually works, letting
  requests be pinned to a specific DHIS2 API version; `khis_api_version()`
  reads back the pinned value.
* Fixed `khis_display_name()` erroring when called with an explicit `auth`
  argument instead of the default global credentials.

# khisr 1.0.6

## New Features
- **Introduced `server` argument**: The `server` argument now accepts the server 
  URL without the `/api` suffix, simplifying the configuration of DHIS2 credentials 
  and API calls.

## Deprecations
- **Deprecated `base_url` in `khis_cred()`**: The `base_url` argument is now 
  deprecated in favour of the new `server` argument. 
- **Deprecated default `base_url` value**: The default value previously used for 
  the `base_url` argument is no longer supported. Users should provide an explicit
  `server` URL moving forward.

## Enhancements
- **Improved testing**: Test coverage has been enhanced to automatically skip 
  tests when the target server is unreachable or down, ensuring smoother testing
  workflows in offline or server downtime conditions.

# khisr 1.0.5

* **Improved Authentication**: Now supports optional authentication for API calls using the `auth` argument. This strengthens security by allowing you to control access to your data.

* **Clearer Error Messages**: Provides more informative error messages to help you identify and troubleshoot issues more efficiently.

# khisr 1.0.4

* Improved Credential Handling:
    - `khis_has_cred()`: Now ensures credentials are valid before returning TRUE, preventing unauthorized access.
    - `khis_cred()`: Includes validation to accept only valid credentials, reducing errors.

# khisr 1.0.3

## New features

* Introduced experimental functions for enhanced data retrieval:
    - `get_data_elements_with_category_options()`: Fetch data elements along with their associated category option values.
    - `get_organisations_by_level()`: Retrieve organizations filtered by level.
    - `get_analytics_by_level()`: Obtain analytics table data
    - `get_data_sets_by_level()`: Retrieve data set reporting rate metrics.
    
* Added the `khis_base_url()` to obtain the DHIS2 API URL.

* Introduced `get_organisation_unit_levels()` to retrieve the available organisation levels in the DHIS2 instance.

## Minor improvements and fixes

* Made the package generic to support any DHIS2 instance and updated the documentation accordingly.

* Modified  the `khis_cred()` to require the `base_url` argument and deprecated the default value.

# khisr 1.0.2

* Updated the `khis_cred_clear()` to reset the `base_url` back to KHIS API.

* Updated the `khis_cred()` to allow `base_url` be set from the config file.

# khisr 1.0.1

* Initial CRAN submission.
