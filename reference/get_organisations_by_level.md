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
the specified level. For each ancestor level, both a name column (e.g.
`county`) and an id column (e.g. `county_id`) are included, so results
can be joined back to other org-unit-keyed data by id rather than name —
two different org units at the same level can share a name, a real,
known DHIS2 data-quality issue.

## Examples

``` r
# Fetch all the organisation units metadata
organisations <- get_organisations_by_level(level = 2)
organisations
#> # A tibble: 18 × 4
#>    id          province             country country_id 
#>    <chr>       <chr>                <chr>   <chr>      
#>  1 W6sNfkJcXGC 01 Vientiane Capital Lao PDR IWp9dQGM0bS
#>  2 YvLOmtTQD6b 02 Phongsali         Lao PDR IWp9dQGM0bS
#>  3 XKGgynPS1WZ 03 Louangnamtha      Lao PDR IWp9dQGM0bS
#>  4 rO2RVJWHpCe 04 Oudomxai          Lao PDR IWp9dQGM0bS
#>  5 FRmrFTE63D0 05 Bokeo             Lao PDR IWp9dQGM0bS
#>  6 MBZYTqkEgwf 06 Louangphabang     Lao PDR IWp9dQGM0bS
#>  7 hdeC7uX9Cko 07 Houaphan          Lao PDR IWp9dQGM0bS
#>  8 RdNV4tTRNEo 08 Xainyabouli       Lao PDR IWp9dQGM0bS
#>  9 VWGSudnonm5 09 Xiangkhouang      Lao PDR IWp9dQGM0bS
#> 10 quFXhkOJGB4 10 Vientiane         Lao PDR IWp9dQGM0bS
#> 11 vBWtCmNNnCG 11 Bolikhamxai       Lao PDR IWp9dQGM0bS
#> 12 c4HrGRJoarj 12 Khammouan         Lao PDR IWp9dQGM0bS
#> 13 pFCZqWnXtoU 13 Savannakhet       Lao PDR IWp9dQGM0bS
#> 14 TOgZ99Jv0bN 14 Salavan           Lao PDR IWp9dQGM0bS
#> 15 dOhqCNenSjS 15 Xekong            Lao PDR IWp9dQGM0bS
#> 16 sv6c7CpPcrc 16 Champasak         Lao PDR IWp9dQGM0bS
#> 17 hRQsZhmvqgS 17 Attapu            Lao PDR IWp9dQGM0bS
#> 18 K27JzTKmBKh 18 Xaisomboun        Lao PDR IWp9dQGM0bS
```
