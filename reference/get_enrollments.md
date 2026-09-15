# Get Enrollments from a DHIS2 Instance

**\[experimental\]** `get_enrollments()` retrieves program enrollments
from the DHIS2 Tracker API.

## Usage

``` r
get_enrollments(
  program = NULL,
  org_units = NULL,
  org_unit_mode = NULL,
  updated_after = NULL,
  updated_before = NULL,
  enrolled_after = NULL,
  enrolled_before = NULL,
  occurred_after = NULL,
  occurred_before = NULL,
  ...,
  fields = c("enrollment", "program", "trackedEntity", "orgUnit", "status", "enrolledAt",
    "occurredAt"),
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

- org_units:

  Optional. A vector of organisation unit ids to scope the query to.

- org_unit_mode:

  Optional. One of `"SELECTED"`, `"CHILDREN"`, `"DESCENDANTS"`,
  `"ACCESSIBLE"`, `"CAPTURE"`, `"ALL"`, controlling how `org_units` is
  interpreted. DHIS2 defaults to `"ACCESSIBLE"` when `org_units` is not
  provided, and `"SELECTED"` when it is.

- updated_after, updated_before:

  Optional. ISO-8601 date or datetime strings bounding the enrollment's
  last-updated timestamp.

- enrolled_after, enrolled_before:

  Optional. ISO-8601 date or datetime strings bounding the enrollment
  date (sent as the unprefixed `enrolledAfter`/`enrolledBefore` query
  params — the corresponding
  [`get_tracked_entities()`](https://khisr.damurka.com/reference/get_tracked_entities.md)
  arguments use `enrollmentEnrolledAfter`/ `enrollmentEnrolledBefore`
  instead, to disambiguate from a tracked entity's other nested dates).

- occurred_after, occurred_before:

  Optional. ISO-8601 date or datetime strings bounding the enrollment's
  incident/occurred date (sent as the unprefixed
  `occurredAfter`/`occurredBefore` query params — the corresponding
  [`get_tracked_entities()`](https://khisr.damurka.com/reference/get_tracked_entities.md)
  arguments use `enrollmentOccurredAfter`/`enrollmentOccurredBefore`
  instead).

- ...:

  Other query parameters supported by your DHIS2 instance's Tracker API
  (e.g. `status`).

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

A tibble of enrollments, or `NULL` if none were found.

## Details

DHIS2 requires an enrollments query to be scoped by at least one of
`program` or `org_units`; an unscoped query will be rejected by the
server. DHIS2's Tracker API does not document filter support for this
endpoint, so a `filter` argument raises an error rather than being
silently sent as an unsupported query parameter; use
[`get_tracked_entities()`](https://khisr.damurka.com/reference/get_tracked_entities.md)
with
[`tracked_entity_filter()`](https://khisr.damurka.com/reference/tracked_entity_filter.md)
to filter by attribute value instead.

The `enrolledAfter`/`enrolledBefore`/`occurredAfter`/`occurredBefore`
query parameter names used here (unprefixed, unlike the equivalent
[`get_tracked_entities()`](https://khisr.damurka.com/reference/get_tracked_entities.md)
arguments) were confirmed by testing live against a public DHIS2 demo
instance — `enrolledAfter` measurably narrowed the result set, and
`orgUnits`/`orgUnit` both work for this endpoint (unlike `events`, which
only accepts the singular form).

## See also

[`get_tracked_entities()`](https://khisr.damurka.com/reference/get_tracked_entities.md),
[`get_events()`](https://khisr.damurka.com/reference/get_events.md)

Other tracker functions:
[`get_events()`](https://khisr.damurka.com/reference/get_events.md),
[`get_relationships()`](https://khisr.damurka.com/reference/get_relationships.md),
[`get_tracked_entities()`](https://khisr.damurka.com/reference/get_tracked_entities.md),
[`tracked_entity_filter()`](https://khisr.damurka.com/reference/tracked_entity_filter.md)

## Examples

``` r

# All enrollments in a program at a given org unit
get_enrollments(program = 'PREnRHSp3be',
                org_units = 'IWp9dQGM0bS',
                org_unit_mode = 'DESCENDANTS')
#> # A tibble: 270 × 7
#>    enrollment  trackedEntity program     status orgUnit    enrolledAt occurredAt
#>    <chr>       <chr>         <chr>       <chr>  <chr>      <chr>      <chr>     
#>  1 VszQ0IsJ2xP qkU5JI6SQcd   PREnRHSp3be ACTIVE NRcrkSgDX… 2026-05-1… 2026-06-0…
#>  2 M8y3vuRdb6G ytRUQrTYLFz   PREnRHSp3be ACTIVE QoGeggHGC… 2026-03-0… 2026-06-0…
#>  3 PBojRJ4RrlW xIOlpNNRcNY   PREnRHSp3be ACTIVE o0Q54FVyI… 2026-06-2… 2026-06-0…
#>  4 mx2PqVG8Thp MNUPROje7ZP   PREnRHSp3be ACTIVE wQUe9Hl9p… 2026-10-1… 2026-06-0…
#>  5 km3HmjIcA6P rlTI0qJF8fl   PREnRHSp3be ACTIVE mNaSC8nPj… 2026-05-0… 2026-06-0…
#>  6 T0LZXfQFFXH NKktLYq4wea   PREnRHSp3be ACTIVE aJOpUuXfk… 2026-02-2… 2026-06-0…
#>  7 HuncOYMmMM8 xwZRdamQoGx   PREnRHSp3be ACTIVE hfVWi2pzx… 2026-06-0… 2026-06-0…
#>  8 x1jaCu30DZl nZZf0IJzkIe   PREnRHSp3be ACTIVE XHCI8ACo0… 2026-10-3… 2026-06-0…
#>  9 pEf0OvhHHLt kA4Fcarkd9T   PREnRHSp3be ACTIVE LpTkKutrz… 2026-09-0… 2026-06-0…
#> 10 zWm9yZ7Ci2z Z746P0ZnrFQ   PREnRHSp3be ACTIVE rYTEjUT6w… 2026-10-1… 2026-06-0…
#> # ℹ 260 more rows
```
