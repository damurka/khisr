# DHIS2 Metadata Helper Functions

These functions simplify retrieving data from specific DHIS2 API
endpoints using
[`get_metadata()`](https://khisr.damurka.com/dev/reference/get_metadata.md).

## Usage

``` r
get_categories(...)

get_category_combos(...)

get_category_option_combos(...)

get_category_option_group_sets(...)

get_category_option_groups(...)

get_category_options(...)

get_data_element_group_sets(...)

get_data_element_groups(...)

get_data_elements(...)

get_data_sets(...)

get_user_groups(...)

get_indicator_group_sets(...)

get_indicator_groups(...)

get_indicators(...)

get_option_group_sets(...)

get_option_groups(...)

get_option_sets(...)

get_options(...)

get_organisation_unit_groupsets(...)

get_organisation_unit_groups(...)

get_organisation_units(...)

get_organisation_unit_levels(...)

get_dimensions(...)

get_period_types(...)

get_user_profile()
```

## Arguments

- ...:

  Arguments passed on to
  [`get_metadata`](https://khisr.damurka.com/dev/reference/get_metadata.md)

  `fields`

  :   The specific columns to be returned in the data frame.

  `retry`

  :   Number of times to retry the API call in case of failure (defaults
      to 2).

  `verbosity`

  :   Level of HTTP information to print during the call:

      - 0: No output

      - 1: Show headers

      - 2: Show headers and bodies

      - 3: Show headers, bodies, and CURL status message.

  `timeout`

  :   Maximum number of seconds to wait for the DHIS2 API response.

  `call`

  :   The caller environment

## Value

A tibble containing the DHIS2 metadata response.

## Examples

``` r
if (FALSE) { # khis_has_cred()

# Get all organisation units
get_organisation_units()

# Get all data elements
get_data_elements()

# Get data elements by element ids
get_data_elements(id %.in% c('VR7vdS7P0Gb', 'gQro1y7Rsbq'))

# Get datasets by name with the word 'MOH 705'
get_data_sets(name %.like% 'MOH 705')
}
```
