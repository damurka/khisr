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
  [`metadata_filter()`](https://khisr.damurka.com/reference/metadata-filter.md)
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
#> # A tibble: 161 × 2
#>    name                           id         
#>    <chr>                          <chr>      
#>  1 AFI - Screening form age group vuZtG77uNSk
#>  2 Age (0 days-59 months)         aJTOeHrkHKt
#>  3 Age (0 days-9 years)           La1iFz5hRWZ
#>  4 Age (0 months-17 years)        LRbLVRPeWhB
#>  5 Age (0 months-9 years)         EOllQxIhJ45
#>  6 Age (0-20+years)               Zh31lLGRQaG
#>  7 Age (0-27 days)                l3PCpU0xXR3
#>  8 Age (0-50+years)               xHd2kREtJIQ
#>  9 Age (0-59 months)              hOERwojXxq7
#> 10 Age (0-9 years)                avoOKxQrkPC
#> # ℹ 151 more rows

# Get the datasets metadata with fields 'id,name,organisationUnits' and filter
# only the datasets with id 'VEM58nY22sO'
get_metadata('dataSets',
             fields = 'id,name,organisationUnits[id,name,path]',
             id %.eq% 'VEM58nY22sO')
#> # A tibble: 1 × 3
#>   name                id          organisationUnits
#>   <chr>               <chr>       <list>           
#> 1 Malaria elimination VEM58nY22sO <list [1,385]>   

# Get data elements filtered by dataElementGroups id
get_metadata('dataElements',
             dataElementGroups.id %.eq% 'WdtYaV7o8QV',
             fields = ':all')
#> # A tibble: 23 × 34
#>    code   name           created lastUpdated translations createdBy    favorites
#>    <chr>  <chr>          <chr>   <chr>       <lgl>        <list>       <lgl>    
#>  1 CH113a CH113a - Chil… 2022-0… 2022-01-10… NA           <named list> NA       
#>  2 CH114  CH114 - House… 2022-0… 2022-01-10… NA           <named list> NA       
#>  3 CH115a CH115a - Hous… 2022-0… 2022-01-10… NA           <named list> NA       
#>  4 CH115b CH115b - Tota… 2022-0… 2022-01-10… NA           <named list> NA       
#>  5 CH116a CH116a - Peop… 2022-0… 2022-01-10… NA           <named list> NA       
#>  6 CH116b CH116b - Indi… 2022-0… 2022-01-10… NA           <named list> NA       
#>  7 CH117  CH117 - Peopl… 2022-0… 2022-01-10… NA           <named list> NA       
#>  8 CH118  CH118 - ITNs … 2022-0… 2022-01-10… NA           <named list> NA       
#>  9 CH119a CH119a - Febr… 2022-0… 2022-01-10… NA           <named list> NA       
#> 10 CH119b CH119b - Febr… 2022-0… 2022-01-10… NA           <named list> NA       
#> # ℹ 13 more rows
#> # ℹ 27 more variables: lastUpdatedBy <list>, sharing <list>, shortName <chr>,
#> #   description <chr>, formName <chr>, dimensionItemType <chr>,
#> #   legendSets <lgl>, aggregationType <chr>, valueType <chr>, domainType <chr>,
#> #   dataSetElements <list>, aggregationLevels <lgl>, zeroIsSignificant <lgl>,
#> #   optionSetValue <lgl>, dimensionItem <chr>, displayShortName <chr>,
#> #   displayDescription <chr>, access <list>, displayName <chr>, …
```
