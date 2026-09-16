# Tracker Data

## Overview

Alongside the [aggregate
data](https://khisr.damurka.com/articles/data-dimensions.html) covered
by
[`get_analytics()`](https://khisr.damurka.com/dev/reference/get_analytics.md),
DHIS2’s **Tracker** stores case-based, person-level data — the kind of
record you’d use for individual patients or clients rather than
facility-level totals. `khisr` provides functions for reading it:

| khisr function | DHIS2 API Endpoint | Retrieves |
|:---|:---|:---|
| [`get_tracked_entities()`](https://khisr.damurka.com/dev/reference/get_tracked_entities.md) | `tracker/trackedEntities` | The people/subjects being tracked |
| [`get_enrollments()`](https://khisr.damurka.com/dev/reference/get_enrollments.md) | `tracker/enrollments` | Their enrollment in a program |
| [`get_events()`](https://khisr.damurka.com/dev/reference/get_events.md) | `tracker/events` | What happened at each program stage visit |
| [`get_relationships()`](https://khisr.damurka.com/dev/reference/get_relationships.md) | `tracker/relationships` | Links between two tracker objects (e.g. an index case and a contact) |
| [`get_event_analytics()`](https://khisr.damurka.com/dev/reference/get_event_analytics.md) | `analytics/events/query` | Aggregated/dimensional analytics over events |
| [`get_enrollment_analytics()`](https://khisr.damurka.com/dev/reference/get_enrollment_analytics.md) | `analytics/enrollments/query` | Aggregated/dimensional analytics over enrollments |

These map onto five core Tracker concepts:

| Concept | Description |
|:---|:---|
| **Tracked Entity** | The subject being followed over time (e.g. a patient or client). Identified by a `trackedEntityType` such as “Person”. |
| **Program** | The case-based program a tracked entity is enrolled in (e.g. a child health programme). |
| **Enrollment** | A tracked entity’s participation in a specific program, with its own enrollment and incident dates. |
| **Event** | A single visit/data-collection point within an enrollment, tied to one `programStage` (e.g. a birth visit) and carrying `dataValues`. |
| **Relationship** | A typed link between two tracker objects, e.g. a TB index case and a household contact. |

All of these functions are and, except for the two analytics-query
functions, share the same scoping, pagination, and error-handling
behaviour.

Every query below needs real program, program stage, and org unit ids,
which are metadata rather than data — look them up with the matching
\[metadata helpers\]\[metadata-helpers\]:

``` r

get_programs()
#> # A tibble: 29 × 2
#>   name                                           id         
#>   <chr>                                          <chr>      
#> 1 AFI - Acute Febrile Illness                    w0qPtIW0JYu
#> 2 Adverse events following immunization (AEFI)   EZkN8vYZwjR
#> 3 Animal Health                                  PREnRHSp3be
#> 4 Anti-Tuberculosis Drug Resistance Survey (DRS) KYzHf1Ta6C4
#> 5 Cancer Registry                                AbPGPdlFWqc
#> # ℹ 24 more rows
get_program_stages()
#> # A tibble: 103 × 2
#>   name                                                        id         
#>   <chr>                                                       <chr>      
#> 1 AEFI                                                        so8YZ9J3MeO
#> 2 Acceptance                                                  INAofuHURWX
#> 3 Admission                                                   pigybbQRpbs
#> 4 Animal exposure                                             JsiWrweuQh5
#> 5 Availability, trainings and medical clearance - RRT Manager HSngsKadeW4
#> # ℹ 98 more rows
get_tracked_entity_types()
#> # A tibble: 6 × 2
#>   name                 id         
#>   <chr>                <chr>      
#> 1 ENTO- Larval habitat qIKI1C8qgbn
#> 2 Focus area           We9I19a3vO1
#> 3 Health Event         DnxQe1mgmlp
#> 4 Health Facility      xzck98PlU28
#> 5 Malaria Case         IjGPYyk56jz
#> # ℹ 1 more row
get_tracked_entity_attributes()
#> # A tibble: 197 × 2
#>   name                             id         
#>   <chr>                            <chr>      
#> 1 AEFI Case ID                     h5FuguPFF2j
#> 2 AFI - Alternate phone number     yIUuFclti50
#> 3 AFI - Highest education received HysEcGdXB1w
#> 4 AFI - Marital status             bDm1t4BanCm
#> 5 AFI - Occupation                 dMyRrx6lb7H
#> # ℹ 192 more rows
```

## Scoping a query

Every Tracker query must be scoped — DHIS2 rejects an unscoped request.
Scope by `program`, and/or by an org unit together with `org_unit_mode`,
which controls how the org unit is interpreted.
[`get_tracked_entities()`](https://khisr.damurka.com/dev/reference/get_tracked_entities.md)
and
[`get_enrollments()`](https://khisr.damurka.com/dev/reference/get_enrollments.md)
take `org_units` — one or more org unit ids — while
[`get_events()`](https://khisr.damurka.com/dev/reference/get_events.md)
takes a single `org_unit` — confirmed live against a DHIS2 instance that
the Tracker API’s `events` endpoint only accepts one org unit, unlike
the other two:

| `org_unit_mode` | Meaning |
|:---|:---|
| `SELECTED` | Only the given org unit(s) (DHIS2’s default when one is set) |
| `CHILDREN` | The given org unit(s) and their immediate children |
| `DESCENDANTS` | The given org unit(s) and all units below them in the hierarchy |
| `ACCESSIBLE` | Everything the authenticated user has access to (default when no org unit is given) |
| `CAPTURE` | Everything the authenticated user can capture data into |
| `ALL` | Every org unit in the instance (typically requires elevated authority) |

``` r

# All tracked entities enrolled in a program, at an org unit and everything below it
get_tracked_entities(
    program = 'PREnRHSp3be',
    org_units = 'IWp9dQGM0bS',
    org_unit_mode = 'DESCENDANTS'
)
#> # A tibble: 270 × 6
#>   trackedEntity trackedEntityType createdAt           updatedAt orgUnit inactive
#>   <chr>         <chr>             <chr>               <chr>     <chr>   <lgl>   
#> 1 qkU5JI6SQcd   DnxQe1mgmlp       2024-06-06T10:40:2… 2024-06-… NRcrkS… FALSE   
#> 2 ytRUQrTYLFz   DnxQe1mgmlp       2024-06-06T10:40:2… 2024-06-… QoGegg… FALSE   
#> 3 xIOlpNNRcNY   DnxQe1mgmlp       2024-06-06T10:40:2… 2024-06-… o0Q54F… FALSE   
#> 4 MNUPROje7ZP   DnxQe1mgmlp       2024-06-06T10:40:2… 2024-06-… wQUe9H… FALSE   
#> 5 rlTI0qJF8fl   DnxQe1mgmlp       2024-06-06T10:40:2… 2024-06-… mNaSC8… FALSE   
#> # ℹ 265 more rows
```

## Retrieving tracked entities

[`get_tracked_entities()`](https://khisr.damurka.com/dev/reference/get_tracked_entities.md)
returns one row per tracked entity. Repeating structures such as
`attributes` and `enrollments` come back as list-columns — use
\[tidyr::unnest_wider()\] or \[tidyr::unnest_longer()\] to flatten the
parts you need.

``` r

entities <- get_tracked_entities(
    program = 'PREnRHSp3be',
    org_units = 'IWp9dQGM0bS',
    org_unit_mode = 'DESCENDANTS',
    fields = c('trackedEntity', 'orgUnit', 'attributes')
)
entities
#> # A tibble: 270 × 3
#>   trackedEntity orgUnit     attributes
#>   <chr>         <chr>       <list>    
#> 1 qkU5JI6SQcd   NRcrkSgDX5G <list [3]>
#> 2 ytRUQrTYLFz   QoGeggHGC30 <list [3]>
#> 3 xIOlpNNRcNY   o0Q54FVyIzn <list [3]>
#> 4 MNUPROje7ZP   wQUe9Hl9pDP <list [3]>
#> 5 rlTI0qJF8fl   mNaSC8nPj12 <list [3]>
#> # ℹ 265 more rows
```

### Filtering by attribute value

[`get_tracked_entities()`](https://khisr.damurka.com/dev/reference/get_tracked_entities.md)
also accepts one or more \[tracked_entity_filter()\] attribute filters,
or their infix-operator shorthand. This is a separate, smaller operator
set from \[metadata_filter()\] — it applies only to the
`trackedEntities` endpoint, and the `in` operator joins values with
semicolons rather than a comma-separated bracket list.
**[`metadata_filter()`](https://khisr.damurka.com/dev/reference/metadata-filter.md)’s
operators (`%.eq%`, `%.in%`, etc.) are not interchangeable with these**
— passing one to
[`get_tracked_entities()`](https://khisr.damurka.com/dev/reference/get_tracked_entities.md)
raises an error rather than sending malformed filter syntax to the
server.

| Operator | Infix operator | Meaning |
|:---|:---|:---|
| `eq` | `%.teq%` | Equality |
| `ne` | `%.tne%` | Inequality |
| `ge` | `%.tge%` | Greater than or equal |
| `gt` | `%.tgt%` | Greater than |
| `le` | `%.tle%` | Less than or equal |
| `lt` | `%.tlt%` | Less than |
| `like` | `%.tlike%` | Match anywhere |
| `sw` | `%.tsw%` | Starts with |
| `ew` | `%.tew%` | Ends with |
| `in` | `%.tin%` | Match one or more values |
| `null` | *(none — pass `NULL` to [`tracked_entity_filter()`](https://khisr.damurka.com/dev/reference/tracked_entity_filter.md))* | Attribute has no value |
| `!null` | *(none — pass `NULL` to [`tracked_entity_filter()`](https://khisr.damurka.com/dev/reference/tracked_entity_filter.md))* | Attribute has a value |

``` r

# Tracked entities whose attribute mTYYajEhlPY starts with "Ann"
get_tracked_entities(
    program = 'PREnRHSp3be',
    org_units = 'IWp9dQGM0bS',
    org_unit_mode = 'DESCENDANTS',
    tracked_entity_filter('mTYYajEhlPY', 'sw', 'John')
)
#> # A tibble: 2 × 6
#>   trackedEntity trackedEntityType createdAt           updatedAt orgUnit inactive
#>   <chr>         <chr>             <chr>               <chr>     <chr>   <lgl>   
#> 1 qkU5JI6SQcd   DnxQe1mgmlp       2024-06-06T10:40:2… 2024-06-… NRcrkS… FALSE   
#> 2 y8m3PCtGLUu   DnxQe1mgmlp       2024-06-06T10:38:4… 2024-06-… JziqEv… FALSE

# Equivalent, using the infix operator
get_tracked_entities(
    program = 'PREnRHSp3be',
    org_units = 'IWp9dQGM0bS',
    org_unit_mode = 'DESCENDANTS',
    mTYYajEhlPY %.tsw% 'John'
)
#> # A tibble: 2 × 6
#>   trackedEntity trackedEntityType createdAt           updatedAt orgUnit inactive
#>   <chr>         <chr>             <chr>               <chr>     <chr>   <lgl>   
#> 1 qkU5JI6SQcd   DnxQe1mgmlp       2024-06-06T10:40:2… 2024-06-… NRcrkS… FALSE   
#> 2 y8m3PCtGLUu   DnxQe1mgmlp       2024-06-06T10:38:4… 2024-06-… JziqEv… FALSE
```

## Retrieving events

[`get_events()`](https://khisr.damurka.com/dev/reference/get_events.md)
returns one row per event, with the data collected at that visit in a
`dataValues` list-column.

``` r

get_events(
    program = 'PREnRHSp3be',
    org_unit = 'NRcrkSgDX5G',
    org_unit_mode = 'DESCENDANTS'
)
#> # A tibble: 4 × 8
#>   event    status program programStage orgUnit occurredAt scheduledAt dataValues
#>   <chr>    <chr>  <chr>   <chr>        <chr>   <chr>      <chr>       <list>    
#> 1 viu095e… COMPL… PREnRH… mj1stImcUCi  NRcrkS… 2026-05-2… 2027-06-06… <list [2]>
#> 2 fSOGbgx… COMPL… PREnRH… AIMTIOnbpFH  NRcrkS… 2026-06-1… 2027-06-06… <list [8]>
#> 3 KMAQJpO… COMPL… PREnRH… Lp3XW1E8MzH  NRcrkS… 2026-05-1… 2027-06-06… <list>    
#> 4 BTIQsyl… COMPL… PREnRH… Mh2FDNOHqBO  NRcrkS… 2026-05-1… 2027-06-06… <list [5]>
```

DHIS2’s Tracker API does not currently document a way to filter events
by data element value the way `trackedEntities` supports attribute
filtering, so
[`get_events()`](https://khisr.damurka.com/dev/reference/get_events.md)
has no `filter` argument. If your instance supports this via an
undocumented parameter, pass it through `...`; otherwise retrieve the
broader event set and filter client-side after unnesting `dataValues`.

## Retrieving enrollments

[`get_enrollments()`](https://khisr.damurka.com/dev/reference/get_enrollments.md)
returns one row per enrollment, useful for questions about who is
enrolled and when, independent of any particular visit.

``` r

get_enrollments(
    program = 'PREnRHSp3be',
    org_units = 'IWp9dQGM0bS',
    org_unit_mode = 'DESCENDANTS'
)
#> # A tibble: 270 × 7
#>   enrollment  trackedEntity program     status orgUnit     enrolledAt occurredAt
#>   <chr>       <chr>         <chr>       <chr>  <chr>       <chr>      <chr>     
#> 1 VszQ0IsJ2xP qkU5JI6SQcd   PREnRHSp3be ACTIVE NRcrkSgDX5G 2026-05-1… 2026-06-0…
#> 2 M8y3vuRdb6G ytRUQrTYLFz   PREnRHSp3be ACTIVE QoGeggHGC30 2026-03-0… 2026-06-0…
#> 3 PBojRJ4RrlW xIOlpNNRcNY   PREnRHSp3be ACTIVE o0Q54FVyIzn 2026-06-2… 2026-06-0…
#> 4 mx2PqVG8Thp MNUPROje7ZP   PREnRHSp3be ACTIVE wQUe9Hl9pDP 2026-10-1… 2026-06-0…
#> 5 km3HmjIcA6P rlTI0qJF8fl   PREnRHSp3be ACTIVE mNaSC8nPj12 2026-05-0… 2026-06-0…
#> # ℹ 265 more rows
```

## Retrieving relationships

[`get_relationships()`](https://khisr.damurka.com/dev/reference/get_relationships.md)
returns links between two tracker objects — for example a TB index case
and a household contact. It’s scoped differently from the other three
functions: provide exactly one of `tracked_entity`, `enrollment`, or
`event` to retrieve that object’s relationships.

``` r

get_relationships(tracked_entity = 'qkU5JI6SQcd')
#> Warning: ! No data found for the specified query.
#> NULL
```

## Aggregated Tracker analytics

For counts and dimensional breakdowns over Tracker data (e.g. events by
org unit and period) rather than the underlying individual records,
[`get_event_analytics()`](https://khisr.damurka.com/dev/reference/get_event_analytics.md)
and
[`get_enrollment_analytics()`](https://khisr.damurka.com/dev/reference/get_enrollment_analytics.md)
query DHIS2’s Tracker analytics engine — the same `%.d%`/`%.f%`
dimension operators used by \[get_analytics()\] apply here too, and
`program` is required as the first argument (used as a URL path segment,
not a dimension):

``` r

get_event_analytics(
    program = 'PREnRHSp3be',
    ou %.d% 'USER_ORGUNIT',
    pe %.d% 'LAST_12_MONTHS'
)
#> # A tibble: 352 × 21
#>   psi       ps    eventdate storedby createdbydisplayname lastupdatedbydisplay…¹
#>   <chr>     <chr> <chr>     <chr>    <chr>                <chr>                 
#> 1 k9fsx4ww… Mh2F… 2026-07-… stefano  Perotti, Stefano (s… Perotti, Stefano (ste…
#> 2 w8JY1dXn… Mh2F… 2026-02-… stefano  Perotti, Stefano (s… Perotti, Stefano (ste…
#> 3 uQLiWvfe… Mh2F… 2026-05-… stefano  Perotti, Stefano (s… Perotti, Stefano (ste…
#> 4 NizUCOPY… Mh2F… 2026-08-… stefano  Perotti, Stefano (s… Perotti, Stefano (ste…
#> 5 FH0lQpMF… Mh2F… 2026-06-… stefano  Perotti, Stefano (s… Perotti, Stefano (ste…
#> # ℹ 347 more rows
#> # ℹ abbreviated name: ¹​lastupdatedbydisplayname
#> # ℹ 15 more variables: lastupdated <chr>, scheduleddate <chr>,
#> #   enrollmentdate <chr>, incidentdate <chr>, tei <chr>, pi <chr>,
#> #   geometry <chr>, longitude <dbl>, latitude <dbl>, ouname <chr>,
#> #   ounamehierarchy <chr>, oucode <chr>, programstatus <chr>,
#> #   eventstatus <chr>, ou <chr>
```

Unlike every other paginated function in this package, this endpoint’s
pager lives in a nested `metaData.pager` field, and — confirmed live
against a public DHIS2 demo instance — silently returns only the first
50 rows with no error or warning if you query the underlying DHIS2
endpoint directly without paging through it.
[`get_event_analytics()`](https://khisr.damurka.com/dev/reference/get_event_analytics.md)/[`get_enrollment_analytics()`](https://khisr.damurka.com/dev/reference/get_enrollment_analytics.md)
handle this automatically.

## Date filters and pagination

All three functions accept `updated_after`/`updated_before`, and
[`get_tracked_entities()`](https://khisr.damurka.com/dev/reference/get_tracked_entities.md)/[`get_enrollments()`](https://khisr.damurka.com/dev/reference/get_enrollments.md)
additionally accept `enrolled_after`/`enrolled_before` and
`occurred_after`/`occurred_before` to bound results by enrollment or
incident date.
[`get_events()`](https://khisr.damurka.com/dev/reference/get_events.md)
accepts `occurred_after`/`occurred_before` for the event’s own occurred
date. The underlying DHIS2 query parameter names on
[`get_events()`](https://khisr.damurka.com/dev/reference/get_events.md)/[`get_enrollments()`](https://khisr.damurka.com/dev/reference/get_enrollments.md)
were confirmed by testing live against a public DHIS2 demo instance —
`enrolled_after`/`occurred_after` measurably narrowed the result set on
both endpoints, and
[`get_events()`](https://khisr.damurka.com/dev/reference/get_events.md)‘s
single-value `org_unit` requirement (unlike the other two functions’
`org_units`) was confirmed the same way: passing more than one org unit
is rejected by the server outright.

Results are paginated automatically — `page_size` (default 500) controls
how many records are requested per page, not the total returned; all
matching pages are fetched and combined into a single tibble.

## Further resources

For the full set of query parameters your DHIS2 instance supports, see
the [DHIS2 Tracker API
documentation](https://docs.dhis2.org/en/develop/using-the-api/dhis-core-version-master/tracker.html).
