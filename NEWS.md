# khisr (development version)

## New features

* **Added Tracker API support**: `get_tracked_entities()`, `get_events()`,
  and `get_enrollments()` retrieve tracked entity instances, program-stage
  events, and program enrollments from DHIS2's Tracker API
  (`/api/tracker/...`), with automatic pagination. Added
  `tracked_entity_filter()`, plus matching infix operators (`%.teq%`,
  `%.tin%`, `%.tsw%`, etc.), for filtering tracked entities by attribute
  value (`trackedEntities` is the only tracker endpoint DHIS2 documents
  filter support for — `get_events()` deliberately has no `filter` argument
  since there is no documented way to filter events by data element value).
  `metadata_filter()` and its infix operators (`%.eq%`, `%.in%`, etc.) are
  for a different DHIS2 API and are not interchangeable with tracked entity
  filters — several operators aren't supported by the Tracker API, and `in`
  uses a different value-joining convention. `get_tracked_entities()` now
  errors on such a filter instead of silently sending malformed syntax to
  the server, and `get_events()`/`get_enrollments()` reject any `filter`
  argument outright, since DHIS2 doesn't document filter support there.

## Bug fixes

* **Fixed a crash when passing extra arguments to `get_analytics_by_level()`
  or `get_data_sets_by_level()`**: `...` was being blindly forwarded into
  internal metadata lookups that don't accept it, causing an "unused
  argument" error any time a caller supplied additional query options (the
  exact usage the docs invited). `...` is now only forwarded to the
  underlying `analytics` query; `auth` is now an explicit, documented
  argument on both functions.
* **Fixed `relocate(id)` and `id %.in% ...` NSE usages** that relied on
  `dplyr::id()` (removed in dplyr 1.2.0) to satisfy `R CMD check`'s global
  variable check — the reason khisr was archived from CRAN.
* **Fixed a bug where a failed metadata request produced a garbled,
  recursive error** instead of the actual failure reason, making
  instance-specific failures (auth errors, timeouts, etc.) very hard to
  diagnose.

## Robustness for large / restrictive DHIS2 instances

* **Large metadata and organisation-unit lists are now fetched with real
  pagination** instead of relying solely on `ignoreLimit=true`, which some
  instances cap or ignore via `keyMaxRestApiCollectionSize` — previously
  this could silently truncate results.
* **ID filters (`element_ids`, `dataset_ids`, `org_ids`) are now chunked
  consistently** across `get_organisations_by_level()`,
  `get_data_elements_with_category_options()`, and `get_data_sets_by_level()`
  to avoid hitting URL/header length limits on instances behind stricter
  proxies or WAFs.
* **Retries now cover 502/504 Gateway Timeout**, in addition to the
  previous 429/503, since large unpaginated responses commonly time out at
  a reverse proxy in front of the DHIS2 instance.
* **`khis_cred()`'s `api_version` argument is now functional**: requests
  can be pinned to a specific DHIS2 API version (e.g. `api_version = "40"`)
  to guard against behavioural differences between DHIS2 core versions.
  Added `khis_api_version()` to read back the pinned version.

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
