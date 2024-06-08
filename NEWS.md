# khisr (development version)

## Breaking Changes

* Made the package generic to support any DHIS2 instance and updated the documentation accordingly.

* Modified  the `khis_cred()` to require the `base_url` argument and have no default value.

## New features

* Introduced experimental functions for enhanced data retrieval:
    - `get_data_elements_with_category_options()`: Fetch data elements along with their associated category option values.
    - `get_organisations_by_level()`: Retrieve organizations filtered by level.
    - `get_data_sets_by_level()`: Obtain analytics table data
    - `get_data_sets_by_level()`: Retrieve data set reporting rate metrics.
    
* Added the `khis_base_url()` to obtain the DHIS2 API URL.

* Introduced `get_organisation_unit_levels()` to retrieve the available organisation levels in the DHIS2 instance.

# khisr 1.0.2

* Updated the `khis_cred_clear()` to reset the `base_url` back to KHIS API.

* Updated the `khis_cred()` to allow `base_url` be set from the config file.

# khisr 1.0.1

* Initial CRAN submission.
