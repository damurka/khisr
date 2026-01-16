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

| khisr function                                                                                     | DHIS2 API Endpoint        |
|:---------------------------------------------------------------------------------------------------|:--------------------------|
| [`get_categories()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)                  | categories                |
| [`get_category_combos()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)             | categoryCombos            |
| [`get_category_option_combos()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)      | categoryOptionCombos      |
| [`get_category_option_group_sets()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)  | categoryOptionGroupSets   |
| [`get_category_option_groups()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)      | categoryOptionGroups      |
| [`get_category_options()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)            | categoryOptions           |
| [`get_data_element_group_sets()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)     | dataElementGroupSets      |
| [`get_data_element_groups()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)         | dataElementGroups         |
| [`get_data_elements()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)               | dataElements              |
| [`get_data_sets()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)                   | dataSets                  |
| [`get_indicator_group_sets()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)        | indicatorGroupSets        |
| [`get_indicator_groups()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)            | indicatorGroups           |
| [`get_indicators()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)                  | indicators                |
| [`get_option_group_sets()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)           | optionGroupSets           |
| [`get_option_groups()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)               | optionGroups              |
| [`get_option_sets()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)                 | optionSets                |
| [`get_options()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)                     | options                   |
| [`get_organisation_unit_groupsets()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md) | organisationUnitGroupSets |
| [`get_organisation_unit_groups()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)    | organisationUnitGroups    |
| [`get_organisation_units()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)          | organisationUnits         |
| [`get_dimensions()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)                  | dimensions                |
| [`get_user_groups()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)                 | userGroups                |
| [`get_period_types()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)                | periodTypes               |

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

| DHIS2 Operator | Infix Operator | Description                                     |
|:---------------|:---------------|:------------------------------------------------|
| `eq`           | `%.eq%`        | Equality                                        |
| `!eq`          | `%.~eq%`       | Inequality                                      |
| `ieq`          | `%.ieq%`       | Case insensitive string, match exact            |
| `ne`           | `%.ne%`        | Inequality                                      |
| `like`         | `%.Like%`      | Case sensitive string, match anywhere           |
| `!like`        | `%.~Like%`     | Case sensitive string, not match anywhere       |
| `$like`        | `%.^Like%`     | Case sensitive string, match start              |
| `!$like`       | `%.~^Like%`    | Case sensitive string, not match start          |
| `like$`        | `%.Like$%`     | Case sensitive string, match end                |
| `!like$`       | `%.~Like$%`    | Case sensitive string, not match end            |
| `ilike`        | `%.like%`      | Case insensitive string, match anywhere         |
| `!ilike`       | `%.~like%`     | Case insensitive string, not match anywhere     |
| `$ilike`       | `%.^like%`     | Case insensitive string, match start            |
| `!$ilike`      | `%.~^like%`    | Case insensitive string, not match start        |
| `ilike$`       | `%.like$%`     | Case insensitive string, match end              |
| `!ilike$`      | `%.~like$%`    | Case insensitive string, not match end          |
| `gt`           | `%.gt%`        | Greater than                                    |
| `ge`           | `%.ge%`        | Greater than or equal                           |
| `lt`           | `%.lt%`        | Less than                                       |
| `le`           | `%.le%`        | Less than or equal                              |
| `token`        | `%.token%`     | Match on multiple tokens in search property     |
| `!token`       | `%.~token%`    | Not match on multiple tokens in search property |
| `in`           | `%.in%`        | Find objects matching 1 or more values          |
| `!in`          | `%.~in%`       | Find objects not matching 1 or more values      |

### Working with metadata filters

Basic usage of the metadata filter

``` r
# Retrieve organisation units by county (level 2)
county <- get_organisation_units(level %.eq% '2')
county
#> # A tibble: 47 × 2
#>   name                   id         
#>   <chr>                  <chr>      
#> 1 Baringo County         vvOK1BxTbet
#> 2 Bomet County           HMNARUV2CW4
#> 3 Bungoma County         KGHhQ5GLd4k
#> 4 Busia County           Tvf1zgVZ0K4
#> 5 Elgeyo Marakwet County MqnLxQBigG0
#> # ℹ 42 more rows

# Retrieve county by name (Mombasa)
county <- get_organisation_units(level %.eq% '2',
                                 name %.like% 'mombasa')
county
#> # A tibble: 1 × 2
#>   name           id         
#>   <chr>          <chr>      
#> 1 Mombasa County wsBsC6gjHvn

data_element_id <- c('cXe64Yk0QMY', 'XEX93uLsAm2')

# Retrieve data elements by ID using operator in
data_elements <- get_data_elements(id %.in% data_element_id)
data_elements
#> # A tibble: 2 × 2
#>   name         id         
#>   <chr>        <chr>      
#> 1 CBE-Abnormal XEX93uLsAm2
#> 2 CBE-Normal   cXe64Yk0QMY

# Retrieve data elements by filtering using dataElementGroups
data_elements <- get_data_elements(dataElementGroups.name %.like% 'moh 705')
data_elements
#> # A tibble: 96 × 2
#>   name                        id         
#>   <chr>                       <chr>      
#> 1 Abortion                    IrWSgk9GsUm
#> 2 All other diseases          KxT47tbKHsd
#> 3 Anaemia cases               kkUHOwGMawD
#> 4 Arthritis, Joint pains etc. waNhWrS3HL6
#> 5 Asthma                      L82lvvxVaqt
#> # ℹ 91 more rows
```

## Data analytics

The analytics resource in DHIS2 empowers you to access and analyze
aggregated data across various dimensions. To effectively leverage this
resource, let’s explore the key functions and parameters involved:

### Key Functions

- [`get_analytics()`](https://khisr.damurka.com/dev/reference/get_analytics.md):
  Retrieves aggregated data based on specified dimensions and filters.
- [`analytics_dimension()`](https://khisr.damurka.com/dev/reference/analytics-dimension.md):
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

| Dimension ID | Dimensions                                                        |
|:-------------|:------------------------------------------------------------------|
| dx           | Data elements, indicators, data set reporting rate metrics,       |
|              | data element operands, program indicators, program data elements, |
|              | program attributes, validation rules                              |
|              |                                                                   |
| pe           | ISO periods and relative periods (see “date and period format”)   |
|              |                                                                   |
| ou           | Organisation unit hierarchy                                       |
|              | Organisation unit identifiers, keywords USER_ORGUNIT,             |
|              | USER_ORGUNIT_CHILDREN, USER_ORGUNIT_GRANDCHILDREN, LEVEL-,        |
|              | and OU_GROUP-                                                     |
|              |                                                                   |
| co           | Category option combo identifiers (use `all` to get all items)    |
|              |                                                                   |
| ao           | Category option combo identifiers (use `all` to get all items)    |

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
    dx %.d% c('siOyOiOJpI8', 'Lt0FqtnHraW', 'OoakJhWiyZp'),
    pe %.d% 'LAST_YEAR',
    ou %.d% c('qKzosKQPl6G')
)
#> # A tibble: 3 × 4
#>   dx          pe    ou          value
#>   <chr>       <chr> <chr>       <dbl>
#> 1 OoakJhWiyZp 2025  qKzosKQPl6G  3596
#> 2 Lt0FqtnHraW 2025  qKzosKQPl6G 27319
#> 3 siOyOiOJpI8 2025  qKzosKQPl6G 17805

# Using the startDate and endDate with organisation unit keyword 'USER_ORGUNIT'
get_analytics(
    dx %.d% c('siOyOiOJpI8', 'Lt0FqtnHraW', 'OoakJhWiyZp'),
    ou %.d% 'USER_ORGUNIT',
    pe %.d% 'all',
    startDate = '2023-07-01',
    endDate = '2023-12-31'
)
#> # A tibble: 18 × 4
#>   dx          ou          pe       value
#>   <chr>       <chr>       <chr>    <dbl>
#> 1 siOyOiOJpI8 HfVjCurKxh2 202310  753853
#> 2 siOyOiOJpI8 HfVjCurKxh2 202312  653757
#> 3 Lt0FqtnHraW HfVjCurKxh2 202307 1122346
#> 4 OoakJhWiyZp HfVjCurKxh2 202308  367189
#> 5 siOyOiOJpI8 HfVjCurKxh2 202311  671639
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

# showing in the analytics. filter by organisation unit with id 'qKzosKQPl6G'
# and period 'LAST_YEAR'
get_analytics(
    dx %.d% c('siOyOiOJpI8', 'Lt0FqtnHraW', 'OoakJhWiyZp'),
    pe %.f% 'LAST_YEAR',
    ou %.f% 'qKzosKQPl6G'
)
#> # A tibble: 3 × 2
#>   dx          value
#>   <chr>       <dbl>
#> 1 OoakJhWiyZp  3596
#> 2 siOyOiOJpI8 17805
#> 3 Lt0FqtnHraW 27319
```
