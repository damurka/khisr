# Get Tracked Entities from a DHIS2 Instance

**\[experimental\]** `get_tracked_entities()` retrieves tracked entity
instances (e.g. patients, clients) from the DHIS2 Tracker API.

## Usage

``` r
get_tracked_entities(
  program = NULL,
  ...,
  tracked_entity_type = NULL,
  tracked_entities = NULL,
  org_units = NULL,
  org_unit_mode = NULL,
  updated_after = NULL,
  updated_before = NULL,
  enrolled_after = NULL,
  enrolled_before = NULL,
  occurred_after = NULL,
  occurred_before = NULL,
  fields = c("trackedEntity", "trackedEntityType", "orgUnit", "createdAt", "updatedAt",
    "inactive"),
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

- ...:

  One or more
  [`tracked_entity_filter()`](https://khisr.damurka.com/dev/reference/tracked_entity_filter.md)
  attribute filters (or its infix operators, e.g.
  `w75KJ2mc4zz %.teq% 'John'`), and/or other query parameters supported
  by your DHIS2 instance's Tracker API. Build filters with
  [`tracked_entity_filter()`](https://khisr.damurka.com/dev/reference/tracked_entity_filter.md)
  and its own infix operators, not
  [`metadata_filter()`](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  or its infix operators (`%.eq%`, `%.in%`, etc.) — those target the
  DHIS2 metadata API's larger operator set and, for `in`/`!in`, a
  different value-joining convention; using them here raises an error
  rather than silently sending malformed filter syntax.

- tracked_entity_type:

  Optional. A tracked entity type id to scope the query to.

- tracked_entities:

  Optional. A vector of specific tracked entity ids to retrieve.

- org_units:

  Optional. A vector of organisation unit ids to scope the query to.

- org_unit_mode:

  Optional. One of `"SELECTED"`, `"CHILDREN"`, `"DESCENDANTS"`,
  `"ACCESSIBLE"`, `"CAPTURE"`, `"ALL"`, controlling how `org_units` is
  interpreted. DHIS2 defaults to `"ACCESSIBLE"` when `org_units` is not
  provided, and `"SELECTED"` when it is.

- updated_after, updated_before:

  Optional. ISO-8601 date or datetime strings bounding the tracked
  entity's last-updated timestamp.

- enrolled_after, enrolled_before:

  Optional. ISO-8601 date or datetime strings bounding the tracked
  entity's enrollment date.

- occurred_after, occurred_before:

  Optional. ISO-8601 date or datetime strings bounding the tracked
  entity's enrollment incident/occurred date.

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

A tibble of tracked entities, or `NULL` if none were found.

## Details

DHIS2 requires a tracked entities query to be scoped by at least one of
`program`, `tracked_entity_type`, `tracked_entities`, or `org_units`; an
unscoped query will be rejected by the server. Nested repeating data
(e.g. `attributes`, `enrollments`) is returned as a list-column — use
[`tidyr::unnest_wider()`](https://tidyr.tidyverse.org/reference/unnest_wider.html)/[`tidyr::unnest_longer()`](https://tidyr.tidyverse.org/reference/unnest_longer.html)
to flatten it further.

## See also

[`tracked_entity_filter()`](https://khisr.damurka.com/dev/reference/tracked_entity_filter.md)
for filtering on attribute values.

Other tracker functions:
[`get_enrollments()`](https://khisr.damurka.com/dev/reference/get_enrollments.md),
[`get_events()`](https://khisr.damurka.com/dev/reference/get_events.md),
[`get_relationships()`](https://khisr.damurka.com/dev/reference/get_relationships.md),
[`tracked_entity_filter()`](https://khisr.damurka.com/dev/reference/tracked_entity_filter.md)

## Examples

``` r

# All tracked entities enrolled in a program at a given org unit
get_tracked_entities(program = 'PREnRHSp3be',
                     org_units = 'IWp9dQGM0bS',
                     org_unit_mode = 'DESCENDANTS')
#> # A tibble: 270 × 6
#>    trackedEntity trackedEntityType createdAt          updatedAt orgUnit inactive
#>    <chr>         <chr>             <chr>              <chr>     <chr>   <lgl>   
#>  1 qkU5JI6SQcd   DnxQe1mgmlp       2024-06-06T10:40:… 2024-06-… NRcrkS… FALSE   
#>  2 ytRUQrTYLFz   DnxQe1mgmlp       2024-06-06T10:40:… 2024-06-… QoGegg… FALSE   
#>  3 xIOlpNNRcNY   DnxQe1mgmlp       2024-06-06T10:40:… 2024-06-… o0Q54F… FALSE   
#>  4 MNUPROje7ZP   DnxQe1mgmlp       2024-06-06T10:40:… 2024-06-… wQUe9H… FALSE   
#>  5 rlTI0qJF8fl   DnxQe1mgmlp       2024-06-06T10:40:… 2024-06-… mNaSC8… FALSE   
#>  6 NKktLYq4wea   DnxQe1mgmlp       2024-06-06T10:40:… 2024-06-… aJOpUu… FALSE   
#>  7 xwZRdamQoGx   DnxQe1mgmlp       2024-06-06T10:40:… 2024-06-… hfVWi2… FALSE   
#>  8 nZZf0IJzkIe   DnxQe1mgmlp       2024-06-06T10:40:… 2024-06-… XHCI8A… FALSE   
#>  9 kA4Fcarkd9T   DnxQe1mgmlp       2024-06-06T10:40:… 2024-06-… LpTkKu… FALSE   
#> 10 Z746P0ZnrFQ   DnxQe1mgmlp       2024-06-06T10:40:… 2024-06-… rYTEjU… FALSE   
#> # ℹ 260 more rows

# Tracked entities whose attribute mTYYajEhlPY contains "John"
get_tracked_entities(program = 'PREnRHSp3be',
                     org_units = 'IWp9dQGM0bS',
                     tracked_entity_filter('mTYYajEhlPY', 'like', 'John'))
#> Warning: ! No data found for the specified query.
#> NULL
```
