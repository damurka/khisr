# Package index

## Authorization Credentials

Set and securely store the DHIS2 authorization credentials

- [`khis_cred()`](https://khisr.damurka.com/dev/reference/khis_cred.md)
  : Sets DHIS2 Credentials
- [`khis_has_cred()`](https://khisr.damurka.com/dev/reference/khis_has_cred.md)
  : Check if DHIS2 Credentials are Available
- [`khis_cred_clear()`](https://khisr.damurka.com/dev/reference/khis_cred_clear.md)
  : Clear the Credentials from Memory
- [`khis_username()`](https://khisr.damurka.com/dev/reference/khis_username.md)
  : Retrieve the Configured Username
- [`khis_display_name()`](https://khisr.damurka.com/dev/reference/khis_display_name.md)
  : Retrieve the Configured Display Name
- [`khis_base_url()`](https://khisr.damurka.com/dev/reference/khis_base_url.md)
  : Retrieve the Configured DHIS2 API Base URL
- [`with_khis_quiet()`](https://khisr.damurka.com/dev/reference/khisr-configuration.md)
  [`local_khis_quiet()`](https://khisr.damurka.com/dev/reference/khisr-configuration.md)
  : khisr Configuration

## DHIS2 Metadata

Download metadata information from DHIS2

- [`get_metadata()`](https://khisr.damurka.com/dev/reference/get_metadata.md)
  : Get Metadata from a DHIS2 Instance
- [`get_categories()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  [`get_category_combos()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  [`get_category_option_combos()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  [`get_category_option_group_sets()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  [`get_category_option_groups()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  [`get_category_options()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  [`get_data_element_group_sets()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  [`get_data_element_groups()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  [`get_data_elements()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  [`get_data_sets()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  [`get_user_groups()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  [`get_indicator_group_sets()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  [`get_indicator_groups()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  [`get_indicators()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  [`get_option_group_sets()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  [`get_option_groups()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  [`get_option_sets()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  [`get_options()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  [`get_organisation_unit_groupsets()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  [`get_organisation_unit_groups()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  [`get_organisation_units()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  [`get_organisation_unit_levels()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  [`get_dimensions()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  [`get_period_types()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  [`get_user_profile()`](https://khisr.damurka.com/dev/reference/metadata-helpers.md)
  : DHIS2 Metadata Helper Functions
- [`metadata_filter()`](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  [`` `%.eq%` ``](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  [`` `%.ieq%` ``](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  [`` `%.~eq%` ``](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  [`` `%.ne%` ``](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  [`` `%.Like%` ``](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  [`` `%.~Like%` ``](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  [`` `%.^Like%` ``](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  [`` `%.~^Like%` ``](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  [`` `%.Like$%` ``](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  [`` `%.~Like$%` ``](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  [`` `%.like%` ``](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  [`` `%.~like%` ``](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  [`` `%.^like%` ``](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  [`` `%.~^like%` ``](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  [`` `%.like$%` ``](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  [`` `%.~like$%` ``](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  [`` `%.gt%` ``](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  [`` `%.ge%` ``](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  [`` `%.lt%` ``](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  [`` `%.le%` ``](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  [`` `%.token%` ``](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  [`` `%.~token%` ``](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  [`` `%.in%` ``](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  [`` `%.~in%` ``](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  : Metadata Filter

## DHIS2 Analytics

To access analytical, aggregated data in DHIS2

- [`get_analytics()`](https://khisr.damurka.com/dev/reference/get_analytics.md)
  : Retrieves Disaggregated Analytics Data from DHIS2
- [`analytics_dimension()`](https://khisr.damurka.com/dev/reference/analytics-dimension.md)
  [`` `%.d%` ``](https://khisr.damurka.com/dev/reference/analytics-dimension.md)
  [`` `%.f%` ``](https://khisr.damurka.com/dev/reference/analytics-dimension.md)
  : Analytics Data Dimensions

## Experimental Functions

Experimental functions that formats the data in logical manner

- [`get_analytics_by_level()`](https://khisr.damurka.com/dev/reference/get_analytics_by_level.md)
  **\[experimental\]** : Retrieves Analytics Table Data
- [`get_data_elements_with_category_options()`](https://khisr.damurka.com/dev/reference/get_data_elements_with_category_options.md)
  **\[experimental\]** : Get Data Elements with Category Options
- [`get_data_sets_by_level()`](https://khisr.damurka.com/dev/reference/get_data_sets_by_level.md)
  **\[experimental\]** : Retrieves Data Set Reporting Rate Metrics
- [`get_organisations_by_level()`](https://khisr.damurka.com/dev/reference/get_organisations_by_level.md)
  **\[experimental\]** : Get Organisations by Level
