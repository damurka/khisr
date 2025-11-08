# Get Data Elements with Category Options

**\[experimental\]** `get_data_elements_with_category_options()` fetches
data elements metadata with the category options from the DHIS2 API
server.

## Usage

``` r
get_data_elements_with_category_options(
  element_ids,
  auth = NULL,
  call = caller_env()
)
```

## Arguments

- element_ids:

  The data element identifiers whose details being retrieved

- auth:

  The authentication object

- call:

  The caller environment

## Value

A tibble containing the following columns:

- element_id - The unique identifier for the data element.

- element - The name of the data element.

- category - The category options for the elements

- category_id - The unique identifier for the category options

## Examples

``` r
# Fetch the data element metadata for particular element id
elements <- get_data_elements_with_category_options('htFuvGJRW1X')
elements
#> # A tibble: 9 × 4
#>   element                                 element_id  category       category_id
#>   <chr>                                   <chr>       <chr>          <chr>      
#> 1 Number of HIV positive clients screened htFuvGJRW1X "Post-treatme… SMt1XYz1xId
#> 2 Number of HIV positive clients screened htFuvGJRW1X " Initial Scr… fxXNsn1ppIe
#> 3 Number of HIV positive clients screened htFuvGJRW1X "Routine Scre… QgiVkhdlO2u
#> 4 Number of HIV positive clients screened htFuvGJRW1X " Initial Scr… bSFRz4appAT
#> 5 Number of HIV positive clients screened htFuvGJRW1X "Post-treatme… p830auWrSqe
#> 6 Number of HIV positive clients screened htFuvGJRW1X "Post-treatme… HOZwYuTL1lz
#> 7 Number of HIV positive clients screened htFuvGJRW1X " Initial Scr… r1itkRYXnZh
#> 8 Number of HIV positive clients screened htFuvGJRW1X "Routine Scre… gLkLCkCx1Ad
#> 9 Number of HIV positive clients screened htFuvGJRW1X "Routine Scre… Qw3yiIgRXob
```
