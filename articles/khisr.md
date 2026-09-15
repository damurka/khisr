# Getting Started

The `khisr` R package simplifies interaction with the District Health
Information System 2 (DHIS2) platform. Designed for researchers and
public health professionals, `khisr` streamlines data retrieval and
analysis, saving you valuable time compared to manual methods.

## Authentication

`khisr` prioritizes security by operating in authenticated mode by
default. This ensures you interact with DHIS2 as a recognized user. To
begin exploring DHIS2 data, you’ll need to establish your credentials.

### Setting Your Credentials:

1.  **Obtain Credentials**: Secure your DHIS2 username and password
    through appropriate channels within the DHIS2 organization.

2.  **Store Credentials Securely**: `khisr` offers a convenient way to
    store your credentials within your R environment. Refer to the
    comprehensive guide, [Set Your
    Credentials](https://khisr.damurka.com/articles/set-your-credentials.html),
    for detailed instructions on setting and managing credentials
    effectively.

``` r

# Set the credentials using username and password
khis_cred(username = 'your-dhis2-username', password = 'your-dhis2-password', server = 'https://<your dhis2 instance>')

# Set the credentials using a Personal Access Token (DHIS2's recommended
# method for scripts and integrations) instead of username/password
khis_cred(token = 'your-dhis2-token', server = 'https://<your dhis2 instance>')

# Set credentials using configuration path
khis_cred(config_path = 'path/to/secret.json')
```

**Note**: Replace placeholders like ‘*your-dhis2-username*’ and
‘*path/to/your/secret.json*’ with your actual credentials and file path.

## Metadata

DHIS2 utilizes metadata to define the structure and meaning of its data.
Explore the [data
dimensions](https://khisr.damurka.com/articles/data-dimensions.html)
resource for a deeper understanding.

### Metadata helpers in khisr

`khisr` provides a set of high-level functions to retrieve details about
various DHIS2 metadata categories. These functions often leverage your R
IDE’s auto-complete feature for faster typing.

The following table summarizes these `khisr` metadata helper functions:

| khisr function | DHIS2 API Endpoint |
|:---|:---|
| [`get_categories()`](https://khisr.damurka.com/reference/metadata-helpers.md) | categories |
| [`get_category_combos()`](https://khisr.damurka.com/reference/metadata-helpers.md) | categoryCombos |
| [`get_category_option_combos()`](https://khisr.damurka.com/reference/metadata-helpers.md) | categoryOptionCombos |
| [`get_category_option_group_sets()`](https://khisr.damurka.com/reference/metadata-helpers.md) | categoryOptionGroupSets |
| [`get_category_option_groups()`](https://khisr.damurka.com/reference/metadata-helpers.md) | categoryOptionGroups |
| [`get_category_options()`](https://khisr.damurka.com/reference/metadata-helpers.md) | categoryOptions |
| [`get_data_element_group_sets()`](https://khisr.damurka.com/reference/metadata-helpers.md) | dataElementGroupSets |
| [`get_data_element_groups()`](https://khisr.damurka.com/reference/metadata-helpers.md) | dataElementGroups |
| [`get_data_elements()`](https://khisr.damurka.com/reference/metadata-helpers.md) | dataElements |
| [`get_data_sets()`](https://khisr.damurka.com/reference/metadata-helpers.md) | dataSets |
| [`get_indicator_group_sets()`](https://khisr.damurka.com/reference/metadata-helpers.md) | indicatorGroupSets |
| [`get_indicator_groups()`](https://khisr.damurka.com/reference/metadata-helpers.md) | indicatorGroups |
| [`get_indicators()`](https://khisr.damurka.com/reference/metadata-helpers.md) | indicators |
| [`get_option_group_sets()`](https://khisr.damurka.com/reference/metadata-helpers.md) | optionGroupSets |
| [`get_option_groups()`](https://khisr.damurka.com/reference/metadata-helpers.md) | optionGroups |
| [`get_option_sets()`](https://khisr.damurka.com/reference/metadata-helpers.md) | optionSets |
| [`get_options()`](https://khisr.damurka.com/reference/metadata-helpers.md) | options |
| [`get_organisation_unit_groupsets()`](https://khisr.damurka.com/reference/metadata-helpers.md) | organisationUnitGroupSets |
| [`get_organisation_unit_groups()`](https://khisr.damurka.com/reference/metadata-helpers.md) | organisationUnitGroups |
| [`get_organisation_units()`](https://khisr.damurka.com/reference/metadata-helpers.md) | organisationUnits |
| [`get_organisation_unit_levels()`](https://khisr.damurka.com/reference/metadata-helpers.md) | organisationUnitLevels |
| [`get_dimensions()`](https://khisr.damurka.com/reference/metadata-helpers.md) | dimensions |
| [`get_user_groups()`](https://khisr.damurka.com/reference/metadata-helpers.md) | userGroups |
| [`get_period_types()`](https://khisr.damurka.com/reference/metadata-helpers.md) | periodTypes |
| [`get_programs()`](https://khisr.damurka.com/reference/metadata-helpers.md) | programs |
| [`get_program_stages()`](https://khisr.damurka.com/reference/metadata-helpers.md) | programStages |
| [`get_tracked_entity_types()`](https://khisr.damurka.com/reference/metadata-helpers.md) | trackedEntityTypes |
| [`get_tracked_entity_attributes()`](https://khisr.damurka.com/reference/metadata-helpers.md) | trackedEntityAttributes |
| [`get_relationship_types()`](https://khisr.damurka.com/reference/metadata-helpers.md) | relationshipTypes |

### Metadata object filter

`khisr` allows you to filter retrieved metadata using a straightforward
approach. The filter format follows the pattern
**property:operator:value**. Here’s a breakdown of the components:

- **property**: The property of the metadata you want to filter on.
- **operator**: The comparison operator you want to perform (examples:
  `eq` for equality, `like` for case-sensitive string matching).
- **value**: The value to use for comparison (not required for all
  operators).

The following table provides a summary of the supported operators:

| DHIS2 Operator | Infix Operator | Description |
|:---|:---|:---|
| `eq` | `%.eq%` | Equality |
| `!eq` | `%.~eq%` | Inequality |
| `ieq` | `%.ieq%` | Case insensitive string, match exact |
| `ne` | `%.ne%` | Inequality |
| `like` | `%.Like%` | Case sensitive string, match anywhere |
| `!like` | `%.~Like%` | Case sensitive string, not match anywhere |
| `$like` | `%.^Like%` | Case sensitive string, match start |
| `!$like` | `%.~^Like%` | Case sensitive string, not match start |
| `like$` | `%.Like$%` | Case sensitive string, match end |
| `!like$` | `%.~Like$%` | Case sensitive string, not match end |
| `ilike` | `%.like%` | Case insensitive string, match anywhere |
| `!ilike` | `%.~like%` | Case insensitive string, not match anywhere |
| `$ilike` | `%.^like%` | Case insensitive string, match start |
| `!$ilike` | `%.~^like%` | Case insensitive string, not match start |
| `ilike$` | `%.like$%` | Case insensitive string, match end |
| `!ilike$` | `%.~like$%` | Case insensitive string, not match end |
| `gt` | `%.gt%` | Greater than |
| `ge` | `%.ge%` | Greater than or equal |
| `lt` | `%.lt%` | Less than |
| `le` | `%.le%` | Less than or equal |
| `token` | `%.token%` | Match on multiple tokens in search property |
| `!token` | `%.~token%` | Not match on multiple tokens in search property |
| `in` | `%.in%` | Find objects matching 1 or more values |
| `!in` | `%.~in%` | Find objects not matching 1 or more values |

### Working with metadata filters

Basic usage of the metadata filter

``` r

# Retrieve organisation units by province (level 2)
province <- get_organisation_units(level %.eq% '2')
province
#> # A tibble: 18 × 2
#>   name                 id         
#>   <chr>                <chr>      
#> 1 01 Vientiane Capital W6sNfkJcXGC
#> 2 02 Phongsali         YvLOmtTQD6b
#> 3 03 Louangnamtha      XKGgynPS1WZ
#> 4 04 Oudomxai          rO2RVJWHpCe
#> 5 05 Bokeo             FRmrFTE63D0
#> # ℹ 13 more rows

# Retrieve province by name (Vientiane Capital)
province <- get_organisation_units(level %.eq% '2',
                                   name %.like% 'vientiane capital')
province
#> # A tibble: 1 × 2
#>   name                 id         
#>   <chr>                <chr>      
#> 1 01 Vientiane Capital W6sNfkJcXGC

data_element_id <- c('lYsfXxCw6Qi', 'GxlrIgMyEf4')

# Retrieve data elements by ID using operator in
data_elements <- get_data_elements(id %.in% data_element_id)
data_elements
#> # A tibble: 2 × 2
#>   name                                   id         
#>   <chr>                                  <chr>      
#> 1 MAL - Malaria confirmed cases reported lYsfXxCw6Qi
#> 2 MAL - Malaria deaths                   GxlrIgMyEf4

# Retrieve data elements by filtering using dataElementGroups
data_elements <- get_data_elements(dataElementGroups.name %.like% 'malaria')
data_elements
#> # A tibble: 316 × 2
#>   name                                                            id         
#>   <chr>                                                           <chr>      
#> 1 CH113a - Children (0-4 y) reporting fever in the last two weeks hzstN9blpky
#> 2 CH114 - Households with at least one ITN                        gRT7NXBCkbB
#> 3 CH115a - Households with at least one ITN for every two persons xjGwK4DRHxh
#> 4 CH115b - Total individuals who live in the household            mn8VQbAjlFU
#> 5 CH116a - People sleeping under an ITN the previous night        UXCgJMwfQiG
#> # ℹ 311 more rows
```

## Data analytics

The analytics resource in DHIS2 empowers you to access and analyze
aggregated data across various dimensions. To effectively leverage this
resource, let’s explore the key functions and parameters involved:

### Key Functions

- [`get_analytics()`](https://khisr.damurka.com/reference/get_analytics.md):
  Retrieves aggregated data based on specified dimensions and filters.
- [`get_data_value_sets()`](https://khisr.damurka.com/reference/get_data_value_sets.md):
  Retrieves the individually entered raw data values behind the
  aggregates — useful for data-quality auditing.
- [`analytics_dimension()`](https://khisr.damurka.com/reference/analytics-dimension.md):
  Constructs dimensions for queries, ensuring accurate data retrieval.
- `%.d%` (infix operator): Convenient shorthand for creating dimension
  filters.
- `%.f%` (infix operator): Convenient shorthand for creating filter
  dimensions.

### Dimension (dx)

The `dimension` query parameter defines which dimensions should be
included in the analytics query. Any number of dimensions can be
specified. The dimension parameter should be repeated for each dimension
to include in the query response. The query response can potentially
contain aggregated values for all combinations of the specified
dimension items. The fixed dimensions are the **data element** *(dx)*
**period (time)** *(pe)* and **organisation unit** *(ou)* dimension. You
can dynamically add dimensions through categories, data element group
sets and organisation unit group sets.

| Dimension ID | Dimensions |
|:---|:---|
| `dx` | Data elements, indicators, data set reporting rate metrics, data element operands, program indicators, program data elements, program attributes, validation rules |
| `pe` | ISO periods and relative periods (see [Date and Period Format](https://khisr.damurka.com/articles/date-format.html)) |
| `ou` | Organisation unit hierarchy: organisation unit identifiers, or keywords `USER_ORGUNIT`, `USER_ORGUNIT_CHILDREN`, `USER_ORGUNIT_GRANDCHILDREN`, `LEVEL-<level>`, and `OU_GROUP-<group-id>` |
| `co` | Category option combo identifiers (use `all` to get all items) |
| `ao` | Attribute option combo identifiers (use `all` to get all items) |

### Filter (filter)

The `filter` parameter defines which dimensions should be used as
filters for the data retrieved in the analytics query. Any number of
filters can be specified. The filter parameter should be repeated for
each filter to use in the query. A filter differs from a dimension in
that the filter dimensions will not be part of the query response
content, and that the aggregated values in the response will be
collapsed on the filter dimensions. In other words, the data in the
response will be aggregated on the filter dimensions, but the filters
will not be included as dimensions in the actual response.

### Constructing Queries

- **Specify Dimensions:** Use the dimensions parameter to define the
  dimensions you want to include in the query response. Leverage the
  infix operators %.d% for concise and readable code.

``` r

# To include a list dimensions for data elements id, dataset ids
dx %.d% c('dimension-id-1', 'dimension-id-2')
#> <spliced>
#> $dimension
#> [1] "dx:dimension-id-1;dimension-id-2"

pe %.d% 'LAST_YEAR'
#> <spliced>
#> $dimension
#> [1] "pe:LAST_YEAR"

ou %.d% 'USER_ORGUNIT'
#> <spliced>
#> $dimension
#> [1] "ou:USER_ORGUNIT"

# showing in the analytics
get_analytics(
    dx %.d% c('lYsfXxCw6Qi', 'vTRrNdOOT9g', 'GxlrIgMyEf4'),
    pe %.d% 'LAST_YEAR',
    ou %.d% c('W6sNfkJcXGC')
)
#> # A tibble: 3 × 4
#>   dx          pe    ou          value
#>   <chr>       <chr> <chr>       <dbl>
#> 1 lYsfXxCw6Qi 2025  W6sNfkJcXGC   120
#> 2 GxlrIgMyEf4 2025  W6sNfkJcXGC   966
#> 3 vTRrNdOOT9g 2025  W6sNfkJcXGC   242

# Using the startDate and endDate with organisation unit keyword 'USER_ORGUNIT'
get_analytics(
    dx %.d% c('lYsfXxCw6Qi', 'vTRrNdOOT9g', 'GxlrIgMyEf4'),
    ou %.d% 'USER_ORGUNIT',
    pe %.d% 'all',
    startDate = '2023-07-01',
    endDate = '2023-12-31'
)
#> # A tibble: 18 × 4
#>   dx          ou          pe     value
#>   <chr>       <chr>       <chr>  <dbl>
#> 1 lYsfXxCw6Qi IWp9dQGM0bS 202308  2685
#> 2 lYsfXxCw6Qi IWp9dQGM0bS 202309  3069
#> 3 GxlrIgMyEf4 IWp9dQGM0bS 202310   178
#> 4 lYsfXxCw6Qi IWp9dQGM0bS 202310  2966
#> 5 GxlrIgMyEf4 IWp9dQGM0bS 202307   206
#> # ℹ 13 more rows
```

- **Apply Filters:** Use the filters parameter to specify dimensions for
  filtering data without including them in the response.

``` r

# Filter by period
pe %.f% 'LAST_YEAR'
#> <spliced>
#> $filter
#> [1] "pe:LAST_YEAR"

# Filter by organisation unit
ou %.f% 'USER_ORGUNIT'
#> <spliced>
#> $filter
#> [1] "ou:USER_ORGUNIT"

# showing in the analytics. filter by organisation unit with id 'W6sNfkJcXGC'
# and period 'LAST_YEAR'
get_analytics(
    dx %.d% c('lYsfXxCw6Qi', 'vTRrNdOOT9g', 'GxlrIgMyEf4'),
    pe %.f% 'LAST_YEAR',
    ou %.f% 'W6sNfkJcXGC'
)
#> # A tibble: 3 × 2
#>   dx          value
#>   <chr>       <dbl>
#> 1 lYsfXxCw6Qi   120
#> 2 vTRrNdOOT9g   242
#> 3 GxlrIgMyEf4   966
```

## Tracker data

Alongside aggregate analytics, DHIS2 also stores case-based,
person-level data through its Tracker API. `khisr` provides
[`get_tracked_entities()`](https://khisr.damurka.com/reference/get_tracked_entities.md),
[`get_enrollments()`](https://khisr.damurka.com/reference/get_enrollments.md),
and [`get_events()`](https://khisr.damurka.com/reference/get_events.md)
for reading it, plus
[`tracked_entity_filter()`](https://khisr.damurka.com/reference/tracked_entity_filter.md)
for filtering tracked entities by attribute value. See [Tracker
Data](https://khisr.damurka.com/articles/tracker.html) for a full guide.

``` r

# Tracked entities enrolled in a program, at an org unit and everything below it
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
