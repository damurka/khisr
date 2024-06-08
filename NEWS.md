# khisr (development version)

* Updated the package to be generic and support any DHIS2 instance and improved 
  the documentation to reflect DHIS2 support.

* Updated the `khis_cred()` to require the `base_url` and have no default value.

* Added the `khis_base_url()` to retrieve the DHIS2 API url.

* Added the function `get_organisation_unit_levels()` to retrieve the levels
  available in the DHIS2 instance

* Added experimental functions to allow retrieval of data in a well formatted
    - `get_data_elements_with_category_options()` - Get data elements along with the 
      with the associated category options values
    - `get_organisations_by_level()` - Gets organisations filtered by the level
    - `get_analytics_by_level()` - Gets Analytics Table Data

# khisr 1.0.2

* Updated the `khis_cred_clear()` to reset the `base_url` back to KHIS API.

* Updated the `khis_cred()` to allow `base_url` be set from the config file.

# khisr 1.0.1

* Initial CRAN submission.
