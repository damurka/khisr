# Get Relationships from a DHIS2 Instance

**\[experimental\]** `get_relationships()` retrieves Tracker
relationships — links between two tracker objects (tracked entities,
enrollments, or events), such as an index case and a household contact —
from DHIS2's Tracker API.

## Usage

``` r
get_relationships(
  tracked_entity = NULL,
  enrollment = NULL,
  event = NULL,
  ...,
  fields = c("relationship", "relationshipType", "from", "to", "createdAt"),
  page_size = 500,
  retry = 2,
  verbosity = 0,
  timeout = 60,
  auth = NULL,
  call = caller_env()
)
```

## Arguments

- tracked_entity, enrollment, event:

  Exactly one of these three must be provided: a tracked entity,
  enrollment, or event id to retrieve relationships for.

- ...:

  Other query parameters supported by your DHIS2 instance's Tracker API.

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

A tibble of relationships, or `NULL` if none were found.

## Details

DHIS2 requires a relationships query to be scoped by exactly one of
`tracked_entity`, `enrollment`, or `event` — confirmed live against a
public DHIS2 demo instance, where omitting all three returns the exact
error
`"Missing required parameter 'trackedEntity', 'enrollment' or 'event'."`.
Pagination (nested `pager`, same as
[`get_tracked_entities()`](https://khisr.damurka.com/dev/reference/get_tracked_entities.md)/
[`get_events()`](https://khisr.damurka.com/dev/reference/get_events.md)/[`get_enrollments()`](https://khisr.damurka.com/dev/reference/get_enrollments.md))
was also confirmed live, but the demo instance tested had no
relationship data configured on any program, so the shape of a populated
relationship's `from`/`to` fields is not independently verified here —
inspect the result and adjust `fields` as needed for your instance.

## See also

[`get_tracked_entities()`](https://khisr.damurka.com/dev/reference/get_tracked_entities.md),
[`get_events()`](https://khisr.damurka.com/dev/reference/get_events.md),
[`get_enrollments()`](https://khisr.damurka.com/dev/reference/get_enrollments.md)

Other tracker functions:
[`get_enrollments()`](https://khisr.damurka.com/dev/reference/get_enrollments.md),
[`get_events()`](https://khisr.damurka.com/dev/reference/get_events.md),
[`get_tracked_entities()`](https://khisr.damurka.com/dev/reference/get_tracked_entities.md),
[`tracked_entity_filter()`](https://khisr.damurka.com/dev/reference/tracked_entity_filter.md)

## Examples

``` r

# Relationships for a specific tracked entity
get_relationships(tracked_entity = 'qkU5JI6SQcd')
#> Warning: ! No data found for the specified query.
#> NULL
```
