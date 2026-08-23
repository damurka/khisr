# khisr (development version)

## New features

* **Added `get_data_value_sets()`**: retrieves individually entered raw
  aggregate data values (`/api/dataValueSets`), as opposed to
  [get_analytics()]'s pre-aggregated view — useful for data-quality
  auditing. Confirmed live against a public DHIS2 demo instance, including a
  real gotcha: without `children = TRUE`, `org_units` matches only that
  exact organisation unit, not its descendants, with no error either way.
  `api_get()` now supports vector-valued query parameters generally
  (exploded into repeated params, e.g. `orgUnit=A&orgUnit=B`), which this
  endpoint's genuinely-repeated-param convention needed and no existing
  caller used before.
* **Added `get_relationships()`**: retrieves Tracker relationships
  (`/api/tracker/relationships`) — completes the four-endpoint Tracker data
  family alongside `get_tracked_entities()`/`get_events()`/
  `get_enrollments()`. Confirmed live that the endpoint requires exactly one
  of `tracked_entity`, `enrollment`, or `event`, and shares the same
  pagination shape as the other three; the demo instance tested had no
  relationship data configured on any program, so the shape of a populated
  relationship's `from`/`to` fields is not independently verified.
* **Added `get_event_analytics()`/`get_enrollment_analytics()`**:
  aggregated, dimensional analytics over Tracker data
  (`/api/analytics/events/query/{program}` and `/enrollments/query/{program}`),
  as opposed to `get_events()`/`get_enrollments()`'s raw individual records.
  Confirmed live against a public DHIS2 demo instance: the response shares
  `get_analytics()`'s `headers`/`rows` shape (extracted into a shared
  `parse_analytics_rows()` helper both now use), but paginates via a nested
  `metaData.pager` — a third, distinct pagination shape from both
  `/api/analytics` (unpaginated) and the raw Tracker endpoints (top-level
  `pager`). Confirmed a real, easy-to-miss gotcha: querying the underlying
  DHIS2 endpoint directly without paging through it silently returns only
  the first 50 rows, no error or warning — verified these two functions
  retrieve the full result set (2,782 rows across 28 pages in testing, not
  just the first page) by comparing against a forced small page size.
* **Added Personal Access Token (PAT) support**: `khis_cred()` now accepts a
  `token` argument (or a `token` key in a `config_path` JSON file) as an
  alternative to `username`/`password`, sending
  `Authorization: ApiToken <token>` — DHIS2's own recommended authentication
  method for scripts and integrations. Verified by generating a real token
  against a live public DHIS2 demo instance and using it to authenticate and
  retrieve real data; the token is redacted from verbose/debug request
  output the same way Basic Authentication's password already is.
* **Added Tracker API support**: `get_tracked_entities()`, `get_events()`,
  and `get_enrollments()` retrieve tracked entity instances, program-stage
  events, and program enrollments from DHIS2's Tracker API
  (`/api/tracker/...`), with automatic pagination. See the
  [Tracker Data](https://khisr.damurka.com/articles/tracker.html) article.
  Query parameter names and behaviour (pagination, org-unit scoping rules,
  date-filter parameter names) were all tested live against a public DHIS2
  demo instance rather than assumed from documentation alone.
* **Added `tracked_entity_filter()`**, plus matching infix operators
  (`%.teq%`, `%.tin%`, `%.tsw%`, etc.), for filtering tracked entities by
  attribute value. `trackedEntities` is the only tracker endpoint DHIS2
  documents filter support for, so `get_events()`/`get_enrollments()` reject
  any `filter` argument outright rather than silently sending it as
  unsupported query syntax.
* `metadata_filter()` and its infix operators (`%.eq%`, `%.in%`, etc.) are
  for a different DHIS2 API and are **not** interchangeable with tracked
  entity filters — several operators aren't supported by the Tracker API,
  and `in` uses a different value-joining convention.
  `get_tracked_entities()` now errors on such a filter instead of silently
  sending malformed syntax to the server.
* **`get_events()`'s `org_units` argument is now `org_unit` (singular)**:
  the Tracker API's `events` endpoint only accepts a single org unit via
  `orgUnit` — passing more than one via the plural `orgUnits` (which
  `get_tracked_entities()`/`get_enrollments()` both use correctly) was
  silently rejected by the server as if no org unit had been given at all.
* `get_events()`'s `occurred_after`/`occurred_before` and
  `get_enrollments()`'s `enrolled_after`/`enrolled_before`/`occurred_after`/
  `occurred_before` now send the unprefixed `occurredAfter`/`occurredBefore`/
  `enrolledAfter`/`enrolledBefore` query parameters appropriate to those
  endpoints, rather than the `eventOccurredAfter`/`enrollmentEnrolledAfter`/
  `enrollmentOccurredAfter` forms that are specific to
  `get_tracked_entities()`'s nested-date disambiguation.
* **Added metadata helpers for Tracker configuration**: `get_programs()`,
  `get_program_stages()`, `get_tracked_entity_types()`,
  `get_tracked_entity_attributes()`, and `get_relationship_types()`, matching
  the existing `get_metadata()`-based helper pattern.

* **`get_organisations_by_level()` now derives ancestor columns from the
  `ancestors[id,name,level]` field** instead of hand-built nested
  `parent[name[...]]` field queries, and includes an id column for every
  ancestor level (e.g. `country_id`, `province_id`), not just a name column.
  Verified live against a public DHIS2 demo instance that `ancestors[]`
  returns the full ancestor chain in one request regardless of depth (a
  level-4 org unit's `ancestors` array had all 3 ancestor levels, not just
  its immediate parent), and that the id columns let results be joined back
  to other org-unit-keyed data reliably even when two org units at the same
  level share a name — a real, known DHIS2 data-quality issue that name-only
  joins were silently vulnerable to.

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

## Documentation

* Reviewed all documentation for accuracy, not just what changed in this
  release. Fixed several pre-existing issues found along the way: a
  placeholder `@param call description` in `metadata_filter()`'s docs, a
  stale `khis_has_cred()` example still using the deprecated
  `server = '.../api'` form, a mislabeled `ao` analytics dimension, and a
  broken vignette table (multi-line pipe-table rows aren't valid GFM and
  were rendering as garbled extra rows). Also fixed an `AuthCred$set_profile()`
  validation check that was a bare expression rather than wrapped in
  `stopifnot()`, so it silently never enforced anything.
* Added a [Tracker Data](https://khisr.damurka.com/articles/tracker.html)
  article, and cross-linked it from the Getting Started, Data Dimensions,
  and Date/Period Format articles and the README, since Tracker's
  individual-level data model and its date-argument format (plain ISO-8601,
  not the `pe` dimension's period codes) are easy to conflate with the
  aggregate/Analytics content those articles otherwise focus on.

## Test coverage

* Several `test-get_*_by_level.R`/`test-get_metadata*.R` files called
  `skip_if_no_cred()`/`skip_if_offline()` *before* input-validation
  assertions that never touch the network, so those assertions never ran in
  any environment without live DHIS2 credentials — including CI runs where
  the credential secret isn't available (e.g. pull requests from forks).
  Reordered so offline-safe assertions always run; only the assertions that
  need a real server response stay behind the skip guards.
* Added `test-utils.R`, directly covering `check_date()`, `check_integerish()`,
  `check_is_valid_url()`, `check_supported_operator()`,
  `check_scalar_character()`, `check_string_vector()`, and `chunk_ids()`,
  none of which had dedicated tests before (only incidental coverage via
  higher-level functions, most of which need network). Found and documented
  a real inconsistency along the way: `check_scalar_character()` accepts an
  empty string, unlike `check_string_vector()`, which explicitly rejects one.

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
