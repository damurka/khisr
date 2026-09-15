# Get Events from a DHIS2 Instance

**\[experimental\]** `get_events()` retrieves tracker program-stage
events from the DHIS2 Tracker API.

## Usage

``` r
get_events(
  program = NULL,
  program_stage = NULL,
  org_unit = NULL,
  org_unit_mode = NULL,
  updated_after = NULL,
  updated_before = NULL,
  occurred_after = NULL,
  occurred_before = NULL,
  ...,
  fields = c("event", "program", "programStage", "orgUnit", "status", "occurredAt",
    "scheduledAt", "dataValues"),
  page_size = 500,
  retry = 2,
  verbosity = 0,
  timeout = 60,
  auth = NULL,
  call = caller_env()
)
```

## Arguments

- program:

  Optional. A program id to scope the query to.

- program_stage:

  Optional. A program stage id to scope the query to.

- org_unit:

  Optional. A single organisation unit id to scope the query to. Unlike
  [`get_tracked_entities()`](https://khisr.damurka.com/reference/get_tracked_entities.md)/[`get_enrollments()`](https://khisr.damurka.com/reference/get_enrollments.md),
  the `events` endpoint accepts exactly one org unit (sent as the
  singular `orgUnit` query param, confirmed live against a DHIS2 demo
  instance — passing more than one is rejected by the server with a "UID
  must be..." error, not silently truncated).

- org_unit_mode:

  Optional. One of `"SELECTED"`, `"CHILDREN"`, `"DESCENDANTS"`,
  `"ACCESSIBLE"`, `"CAPTURE"`, `"ALL"`, controlling how `org_unit` is
  interpreted. DHIS2 defaults to `"ACCESSIBLE"` when `org_unit` is not
  provided, and `"SELECTED"` when it is.

- updated_after, updated_before:

  Optional. ISO-8601 date or datetime strings bounding the event's
  last-updated timestamp.

- occurred_after, occurred_before:

  Optional. ISO-8601 date or datetime strings bounding the event's
  occurred date (sent as the unprefixed `occurredAfter`/`occurredBefore`
  query params — the corresponding
  [`get_tracked_entities()`](https://khisr.damurka.com/reference/get_tracked_entities.md)
  arguments use `eventOccurredAfter`/ `eventOccurredBefore` instead, to
  disambiguate from a tracked entity's other nested dates).

- ...:

  Other query parameters supported by your DHIS2 instance's Tracker API
  (e.g. `status`, `assignedUserMode`).

- fields:

  The DHIS2 field-selector for the columns to return.

- page_size:

  Number of records to request per page (default 500).

- retry:

  Number of times to retry the API call in case of failure (defaults to
  2).

- verbosity:

  Level of HTTP information to print during the call.

- timeout:

  Maximum number of seconds to wait for the DHIS2 API response.

- auth:

  Optional. The authentication object.

- call:

  The caller environment.

## Value

A tibble of events, or `NULL` if none were found.

## Details

DHIS2 requires an events query to be scoped by at least one of
`program`, `program_stage`, or `org_unit`; an unscoped query will be
rejected by the server.

The `occurredAfter`/`occurredBefore` query parameter names used here
(unprefixed, unlike the equivalent
[`get_tracked_entities()`](https://khisr.damurka.com/reference/get_tracked_entities.md)
arguments) and the single-value `orgUnit` parameter were confirmed by
testing live against a public DHIS2 demo instance.

DHIS2's published Tracker API documentation does not describe a
supported way to filter events by data element value (unlike
[`get_tracked_entities()`](https://khisr.damurka.com/reference/get_tracked_entities.md),
which supports attribute filtering via
[`tracked_entity_filter()`](https://khisr.damurka.com/reference/tracked_entity_filter.md)),
so a `filter` argument raises an error here rather than being silently
sent as an unsupported query parameter. Retrieve the broader event set
and filter client-side instead. `dataValues` is returned as a
list-column — use
[`tidyr::unnest_wider()`](https://tidyr.tidyverse.org/reference/unnest_wider.html)/[`tidyr::unnest_longer()`](https://tidyr.tidyverse.org/reference/unnest_longer.html)
to flatten it further.

## See also

[`get_tracked_entities()`](https://khisr.damurka.com/reference/get_tracked_entities.md),
[`get_enrollments()`](https://khisr.damurka.com/reference/get_enrollments.md)

Other tracker functions:
[`get_enrollments()`](https://khisr.damurka.com/reference/get_enrollments.md),
[`get_relationships()`](https://khisr.damurka.com/reference/get_relationships.md),
[`get_tracked_entities()`](https://khisr.damurka.com/reference/get_tracked_entities.md),
[`tracked_entity_filter()`](https://khisr.damurka.com/reference/tracked_entity_filter.md)

## Examples

``` r

# All events for a program stage at a given org unit
get_events(program_stage = 'mj1stImcUCi',
           org_unit = 'NRcrkSgDX5G',
           org_unit_mode = 'DESCENDANTS')
#> # A tibble: 1 × 8
#>   event    status program programStage orgUnit occurredAt scheduledAt dataValues
#>   <chr>    <chr>  <chr>   <chr>        <chr>   <chr>      <chr>       <list>    
#> 1 viu095e… COMPL… PREnRH… mj1stImcUCi  NRcrkS… 2026-05-2… 2027-06-06… <list [2]>
```
