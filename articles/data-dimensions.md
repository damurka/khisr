# Data Dimensions

## Overview

Metadata in DHIS2 refers to predefined data dimensions that provide
context to data values. This context is essential for classifying,
organizing, and analyzing data, ultimately enabling a better
understanding of the information. The main metadata dimensions in DHIS2
include:

1.  **Organisation Units:** Provide geographical context to data.
2.  **Data Elements:** Define what is being measured.
3.  **Periods:** Specify the temporal dimension of the data.

### Organisation Units (annotated as *ou*)

Organisation units in DHIS2 represent the location or larger
geographical context of the data. They encompass:

- Locations where services are provided (e.g., health facilities,
  schools, community units).
- Administrative units representing geographical areas (e.g., district,
  county, sub-county).

In Kenya, the hierarchy of organisation units starts at the country
level, further subdivided into 47 counties, then into smaller
sub-counties and wards. At the lowest level, there are individual health
facilities and community units, forming a hierarchical tree.

DHIS2 allows the classification of organisation units using criteria
other than administrative hierarchy. This can be achieved through the
use of organisation unit groups and organisation unit group sets.

- **Organisation Unit Groups:** Allow for additional sub-classification
  of organisation units (e.g., by ownership or facility level) other
  than then geographical classification.

``` r

# Retrieves organisation unit groups which belong to the organisation 
# unit group set with the name 'Facility Ownership'
orgs_groups <- get_organisation_unit_groups(
    groupSets.name %.eq% 'Facility Ownership'
)
#> Warning in get_organisation_unit_groups(groupSets.name %.eq% "Facility
#> Ownership"): ! No data found for the specified endpoint.
orgs_groups
#> NULL
```

- **Organisation Unit Group Sets:** Serve as umbrella classifications
  containing individual groups (e.g., *Facility Type Organisation Unit
  Group Set* contains Faith-based Organisation, Ministry of Health, and
  Private Facilities Organisation Unit Groups).

``` r

# Retrieves all the organisation unit group sets
orgs_group_set <- get_organisation_unit_groupsets()
orgs_group_set
#> # A tibble: 32 × 2
#>    name                          id         
#>    <chr>                         <chr>      
#>  1 50 Districts of EPI (P-DLI8)  jH727AfNETY
#>  2 Administrative levels of care dSwpdHITQ85
#>  3 DLI-F Facilities              nB8yUjIepnt
#>  4 DLI-F Facilities (baseline)   aUgQuHtJEZT
#>  5 DLIP6 Reporting Units         BjuC5jWB8Iu
#>  6 Districts & Provinces         fx6DMnqg5Oo
#>  7 EmONC                         V6zTLQBbhgI
#>  8 Functionality                 NUCtvtcCUIZ
#>  9 HIV - STI                     vtYucsXZsGJ
#> 10 HIV - VCT                     r3107KMwLMd
#> # ℹ 22 more rows
```

### Data Elements (annotated as *dx*)

Data elements in DHIS2 define what is being represented by a particular
data value. They act as labels or variables describing the nature of the
data. Examples include counts of malaria cases or the number of women
screened.

Data elements can represent numerical values that can be aggregated
(summed or averaged) from monthly to quarterly values. They can also be
disaggregated (separated into components) or aggregated (summed) from
facility to district to country.

``` r

# Retrieves all the data elements in DHIS2
data_elements <- get_data_elements()
data_elements
#> # A tibble: 6,166 × 2
#>    name                                id         
#>    <chr>                               <chr>      
#>  1 AEFI - AEFI outcome                 yRrSDiR5v1M
#>  2 AEFI - AEFI start date              vNGUuAZA2C2
#>  3 AEFI - AEFI time                    NyCB1VAOfJd
#>  4 AEFI - Abdominal pain               T6tsxbKzikz
#>  5 AEFI - Abscess                      wce39JmsjIK
#>  6 AEFI - Anaphylaxis                  MkIgCrCTFyE
#>  7 AEFI - Batch/lot number (Vaccine 1) LNqkAlvGplL
#>  8 AEFI - Batch/lot number (Vaccine 2) b1rSwGRcY5W
#>  9 AEFI - Batch/lot number (Vaccine 3) YBnFoNouH6f
#> 10 AEFI - Batch/lot number (Vaccine 4) BHAfwo6JPDa
#> # ℹ 6,156 more rows
```

Related data elements are grouped into a logical collection referred to
as **data element groups**. The data element groups do not directly
contain data but reference members data elements. Therefore data element
groups provide a way manage and analyze related data elements.

``` r

# Retrieves all the data element groups
data_element_groups <- get_data_element_groups()
data_element_groups
#> # A tibble: 160 × 2
#>    name                                           id         
#>    <chr>                                          <chr>      
#>  1 AEFI - Adverse Events                          yhXZIbQuxOt
#>  2 Animal Surveillance                            iMNcm8NLZSJ
#>  3 Anti-Tuberculosis Drug Resistance Survey (DRS) SfwwoCbB1m3
#>  4 CBS                                            EEiZFeswMNd
#>  5 CBS - Alert                                    qacwMhz9mxd
#>  6 CCH - Climate/Weather                          U4ClQbCq7Fv
#>  7 CCH - Environment (Weekly)                     VthVLJyDjsx
#>  8 CH - Adolescent Health                         RwfCEp0aoP5
#>  9 CH - Child Health                              byO8RqLkwT5
#> 10 CH - Child protection & interpersonal violence alIVe2Y6WRQ
#> # ℹ 150 more rows
```

### Periods (annotated as *pe*)

Periods are a crucial factor when collecting and analyzing data over
time or creating periodic reports. DHIS2 supports two types of periods:

- **Relative Periods:** Defined in relation to the date of analysis
  (e.g., last year, last month, this quarter).

- **Fixed Periods:** Refer to specific periods (e.g., January 2024, 2020
  to 2024).

The choice of periods depends on the type of insight needed, whether
it’s a specific point in time, a trend over months, or an annual
overview. For more details see [Date and Period
Format](https://khisr.damurka.com/articles/date-format.html)

DHIS2 utilizes a multi-dimensional data model, allowing you to analyze
data across various aspects like data elements, periods, and
organization units. This flexibility empowers you to gain deeper
insights and answer complex questions.

#### Building Analytics Queries:

The good news is, you don’t necessarily need to know the intricate
details of every dimension item when building analytics queries! `khisr`
provides functions to handle these complexities for you.

#### Further Resources:

For deeper dives into specific dimensions and objects, refer to the
comprehensive [DHIS2 API
documentation](https://docs.dhis2.org/en/develop/using-the-api/dhis-core-version-240/analytics.html)

These dimensions describe **aggregate** data — facility/period totals
accessed through
[`get_analytics()`](https://khisr.damurka.com/reference/get_analytics.md).
DHIS2 also has a separate, individual-level data model — tracked
entities, enrollments, and events — with its own dimensions and its own
retrieval functions; see [Tracker
Data](https://khisr.damurka.com/articles/tracker.html).
