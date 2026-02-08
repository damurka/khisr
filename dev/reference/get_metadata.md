# Get Metadata from a DHIS2 Instance

`get_metadata` retrieves metadata for a specified endpoint of a DHIS2
instance.

## Usage

``` r
get_metadata(
  endpoint,
  ...,
  fields = c("id", "name"),
  retry = 2,
  verbosity = 0,
  timeout = 60,
  call = caller_env()
)
```

## Arguments

- endpoint:

  The DHIS2 API endpoint for the metadata of interest (e.g.,
  `dataElements`, `organisationUnits` endpoints).

- ...:

  One or more
  [`metadata_filter()`](https://khisr.damurka.com/dev/reference/metadata-filter.md)
  parameters in key-value pairs.

- fields:

  The specific columns to be returned in the data frame.

- retry:

  Number of times to retry the API call in case of failure (defaults to
  2).

- verbosity:

  Level of HTTP information to print during the call:

  - 0: No output

  - 1: Show headers

  - 2: Show headers and bodies

  - 3: Show headers, bodies, and CURL status message.

- timeout:

  Maximum number of seconds to wait for the DHIS2 API response.

- call:

  The caller environment

## Value

A tibble containing the DHIS2 metadata response.

## Examples

``` r
# Get the categories metadata
get_metadata('categories')
#> # A tibble: 543 × 2
#>    name                                     id         
#>    <chr>                                    <chr>      
#>  1 "0-3mths, 4-6mths, 7-18mths"             JI1bCqQ77r1
#>  2 "1st,2nd"                                NChHyaAC6ls
#>  3 "2-5yrs"                                 KY9t7YJtAJI
#>  4 "3. Immunology"                          LQeahngW60z
#>  5 "6-10 yrs"                               eLTXvFcuiRN
#>  6 "6-10yrs"                                eZsIWKswsN5
#>  7 "717 Operations(Booked&Operated) "       OzZClNVHXLV
#>  8 "749 Total Isolates"                     mXj1e4ycMBt
#>  9 "751_Child exclusively  breastfed"       oNDNLvqbXtN
#> 10 "751_Early  initiation to breastfeeding" hghdXcQVx7R
#> # ℹ 533 more rows

# Get the datasets metadata with fields 'id,name,organisationUnits' and filter
# only the datasets with id 'WWh5hbCmvND'
get_metadata('dataSets',
             fields = 'id,name,organisationUnits[id,name,path]',
             id %.eq% 'WWh5hbCmvND')
#> # A tibble: 1 × 3
#>   name                                                  id     organisationUnits
#>   <chr>                                                 <chr>  <list>           
#> 1 MoH 745 Cancer Screening Program Monthly Summary Form WWh5h… <list [7,013]>   

# Get data elements filtered by dataElementGroups id
get_metadata('dataElements',
             dataElementGroups.id %.eq% 'IXd7DXxZqzL',
             fields = ':all')
#> # A tibble: 31 × 35
#>    href       name  created lastUpdated translations externalAccess publicAccess
#>    <chr>      <chr> <chr>   <chr>       <lgl>        <lgl>          <chr>       
#>  1 https://h… CBE-… 2020-0… 2020-07-14… NA           FALSE          rw------    
#>  2 https://h… CBE-… 2020-0… 2020-07-14… NA           FALSE          rw------    
#>  3 https://h… Colo… 2020-0… 2020-07-14… NA           FALSE          rw------    
#>  4 https://h… Colo… 2020-0… 2020-07-14… NA           FALSE          rw------    
#>  5 https://h… Colo… 2020-0… 2020-07-14… NA           FALSE          rw------    
#>  6 https://h… Colo… 2020-0… 2020-07-14… NA           FALSE          rw------    
#>  7 https://h… FOBT… 2020-0… 2021-10-08… NA           FALSE          rw------    
#>  8 https://h… FOBT… 2020-0… 2021-10-08… NA           FALSE          rw------    
#>  9 https://h… Mamm… 2020-0… 2020-07-14… NA           FALSE          rw------    
#> 10 https://h… Mamm… 2020-0… 2020-07-14… NA           FALSE          rw------    
#> # ℹ 21 more rows
#> # ℹ 28 more variables: createdBy <list>, userGroupAccesses <lgl>,
#> #   userAccesses <lgl>, access <list>, favorites <lgl>, lastUpdatedBy <list>,
#> #   sharing <list>, shortName <chr>, dimensionItemType <chr>, legendSets <lgl>,
#> #   aggregationType <chr>, valueType <chr>, domainType <chr>,
#> #   dataSetElements <list>, aggregationLevels <lgl>, zeroIsSignificant <lgl>,
#> #   optionSetValue <lgl>, dimensionItem <chr>, displayShortName <chr>, …
```
