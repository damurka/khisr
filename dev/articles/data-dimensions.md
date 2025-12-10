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
orgs_groups
#> # A tibble: 4 × 2
#>   name                                    id         
#>   <chr>                                   <chr>      
#> 1 Revised Faith Based Organisation (2018) eT1vvFVhLHc
#> 2 Revised Ministry of Health (2018)       AaAF5EmS1fk
#> 3 Revised NGO (2018)                      g58rumvciv2
#> 4 Revised Private(2018)                   aRxa6o8GqZN
```

- **Organisation Unit Group Sets:** Serve as umbrella classifications
  containing individual groups (e.g., *Facility Type Organisation Unit
  Group Set* contains Faith-based Organisation, Ministry of Health, and
  Private Facilities Organisation Unit Groups).

``` r
# Retrieves all the organisation unit group sets
orgs_group_set <- get_organisation_unit_groupsets()
orgs_group_set
#> # A tibble: 18 × 2
#>    name                                           id         
#>    <chr>                                          <chr>      
#>  1 "ART Central Sites"                            tjVYz9cY7I3
#>  2 "ART Facility Type"                            IwvoiaXmT7G
#>  3 "ASAL Counties"                                x8y86riED0O
#>  4 "Beyond Zero Clinics"                          cUiz93K15ZU
#>  5 "Facility Ownership"                           JlW9OiK1eR4
#>  6 "Facility Type"                                FSoqQFDES0U
#>  7 "Health Facilities -Refugee Camp "             f0JZ8v0Zxa3
#>  8 "KEPH Level "                                  sytI3XYbxwE
#>  9 "Malaria Endemic Zones"                        Qhu3PDob3X6
#> 10 "Malaria Epidemiological Zones"                IgwwNhbzeK7
#> 11 "Malaria Vaccine Lake Endemic"                 Vo3q0yjOYFv
#> 12 "NASCOP Region"                                rbvYf4IjcGf
#> 13 "Non-Refugee & Refugee camp Health facilities" ltZ6C4ckNLl
#> 14 "Programme Sponsor"                            OE9Qlwr8XFv
#> 15 "Supply Chain"                                 Vww46znsPsj
#> 16 "TB  Lab Subcounty Store Vers 2022"            gmsEbbTJReq
#> 17 "TB SubCounty Stores"                          R0JQ0AqdsZf
#> 18 "TB Zone"                                      jvksQn3RnbT
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
#> # A tibble: 16,185 × 2
#>    name                                                                    id   
#>    <chr>                                                                   <chr>
#>  1 ""                                                                      ioUh…
#>  2 "0000000 INCOME & EXPENDITURE STATEMENT"                                RvNJ…
#>  3 "1000000 Income/Revenue"                                                zo5v…
#>  4 "10.1 Residential"                                                      tZ3q…
#>  5 "10.1 The facility has a sound fnancial plan that is adequately funded" oYdx…
#>  6 "10.2 Commercial"                                                       PQNa…
#>  7 "10.2 Financial resources are provided and used towards Quality Manage… OnDA…
#>  8 "10.3 Availability of updated fee structure, strategically and promine… UXQg…
#>  9 "10.3 Institutional"                                                    FGHs…
#> 10 "10.4 Facility improvement/ Quality management funds are effciently us… y9ui…
#> # ℹ 16,175 more rows
```

Related data elements are grouped into a logical collection referred to
as **data element groups**. The data element groups do not directly
contain data but reference members data elements. Therefore data element
groups provide a way manage and analyze related data elements.

``` r
# Retrieves all the data element groups
data_element_groups <- get_data_element_groups()
data_element_groups
#> # A tibble: 270 × 2
#>    name                                           id         
#>    <chr>                                          <chr>      
#>  1 "706D Haemovigilance Tool"                     EvSFB0kFshj
#>  2 "751_BFCI FORM "                               Q3ZqDNTgosn
#>  3 "Adverse Events Following Immunization (AEFI)" zHoxBNmNfej
#>  4 "AFP Smear"                                    jjm7ipMtusz
#>  5 "AMR - Acinetobacter Isolates"                 uqIQDfIInK1
#>  6 "AMR - Escherichia coli isolates"              VjgPbuOqvBq
#>  7 "AMR - Klebsiella species isolates"            SMINXpqL0s5
#>  8 "AMR - Pseudomonas aeruginosa isolates"        NpOK7Em3QRk
#>  9 "AMR - Staphylococcus aureus Isolates"         B3VgKffq78S
#> 10 "Antenatal client first visits"                XTHYIz6qsdX
#> # ℹ 260 more rows
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
