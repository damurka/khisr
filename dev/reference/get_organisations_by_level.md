# Get Organisations by Level

**\[experimental\]** `get_organisations_by_level()` is an experimental
function that retrieves the organisation units along with their parent
units.

## Usage

``` r
get_organisations_by_level(
  level = 1,
  org_ids = NULL,
  auth = NULL,
  call = caller_env()
)
```

## Arguments

- level:

  An integer specifying the desired organisation level (default level
  1).

- org_ids:

  Optional. A vector of organisation identifiers whose details are being
  retrieved.

- auth:

  Optional. The authentication object

- call:

  The call environment.

## Value

A tibble containing the organisation units and their parent units up to
the specified level.

## Examples

``` r
# Fetch all the organisation units metadata
organisations <- get_organisations_by_level(level = 2)
organisations
#> # A tibble: 47 × 3
#>    id          county                 kenya
#>    <chr>       <chr>                  <chr>
#>  1 vvOK1BxTbet Baringo County         Kenya
#>  2 HMNARUV2CW4 Bomet County           Kenya
#>  3 KGHhQ5GLd4k Bungoma County         Kenya
#>  4 Tvf1zgVZ0K4 Busia County           Kenya
#>  5 MqnLxQBigG0 Elgeyo Marakwet County Kenya
#>  6 PFu8alU2KWG Embu County            Kenya
#>  7 uyOrcHZBpW0 Garissa County         Kenya
#>  8 nK0A12Q7MvS Homa Bay County        Kenya
#>  9 bzOfj0iwfDH Isiolo County          Kenya
#> 10 Hsk1YV8kHkT Kajiado County         Kenya
#> # ℹ 37 more rows
```
