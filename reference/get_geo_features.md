# Get Organisation Unit Geographic Features

**\[experimental\]** `get_geo_features()` retrieves the geographic
features (coordinates/ boundaries) of organisation units from the
`geoFeatures` endpoint — useful for mapping. Confirmed live against a
public DHIS2 demo instance.

## Usage

``` r
get_geo_features(
  org_units,
  ...,
  retry = 2,
  verbosity = 0,
  timeout = 60,
  auth = NULL,
  call = caller_env()
)
```

## Arguments

- org_units:

  A vector of organisation unit ids, or a DHIS2 org-unit keyword such as
  `'LEVEL-2'` or `'USER_ORGUNIT'`.

- ...:

  Other query parameters supported by your DHIS2 instance's
  `geoFeatures` endpoint.

- retry:

  Number of times to retry the API call in case of failure (defaults to
  2).

- verbosity:

  Level of HTTP information to print during the call.

- timeout:

  Maximum number of seconds to wait for the API response.

- auth:

  Optional. The authentication object.

- call:

  The caller environment.

## Value

A tibble with one row per organisation unit: `id`, `name`, `code`,
`level`, `type` (point or polygon), `parent_id`, `parent_name`,
`parent_graph`, `coordinates` (a GeoJSON-style coordinate string),
`has_coordinates_down`, and `has_coordinates_up`. `NULL` if none were
found.

## Details

Confirmed live that `org_units` must be sent as a `ou:`-prefixed
dimension value (e.g. `ou:LEVEL-2` or `ou:<uid1>;<uid2>`) — a bare
comma/semicolon-separated list of ids, without the `ou:` prefix, is
rejected. A `dimensions` field in the raw response (category-dimension
filters applied to the query; empty in every case tested) is dropped
before returning, since an empty list-column in every row otherwise
collapses the whole result to 0 rows.

## Examples

``` r

get_geo_features(org_units = 'LEVEL-2')
#> # A tibble: 18 × 11
#>    id     name  code  has_coordinates_down has_coordinates_up level parent_graph
#>    <chr>  <chr> <chr> <lgl>                <lgl>              <int> <chr>       
#>  1 W6sNf… 01 V… ASIL… TRUE                 FALSE                  2 IWp9dQGM0bS 
#>  2 YvLOm… 02 P… ASIL… TRUE                 FALSE                  2 IWp9dQGM0bS 
#>  3 XKGgy… 03 L… ASIL… TRUE                 FALSE                  2 IWp9dQGM0bS 
#>  4 rO2RV… 04 O… ASIL… TRUE                 FALSE                  2 IWp9dQGM0bS 
#>  5 FRmrF… 05 B… ASIL… TRUE                 FALSE                  2 IWp9dQGM0bS 
#>  6 MBZYT… 06 L… ASIL… TRUE                 FALSE                  2 IWp9dQGM0bS 
#>  7 hdeC7… 07 H… ASIL… TRUE                 FALSE                  2 IWp9dQGM0bS 
#>  8 RdNV4… 08 X… ASIL… TRUE                 FALSE                  2 IWp9dQGM0bS 
#>  9 VWGSu… 09 X… ASIL… TRUE                 FALSE                  2 IWp9dQGM0bS 
#> 10 quFXh… 10 V… ASIL… TRUE                 FALSE                  2 IWp9dQGM0bS 
#> 11 vBWtC… 11 B… ASIL… TRUE                 FALSE                  2 IWp9dQGM0bS 
#> 12 c4HrG… 12 K… ASIL… TRUE                 FALSE                  2 IWp9dQGM0bS 
#> 13 pFCZq… 13 S… ASIL… TRUE                 FALSE                  2 IWp9dQGM0bS 
#> 14 TOgZ9… 14 S… ASIL… TRUE                 FALSE                  2 IWp9dQGM0bS 
#> 15 dOhqC… 15 X… ASIL… TRUE                 FALSE                  2 IWp9dQGM0bS 
#> 16 sv6c7… 16 C… ASIL… TRUE                 FALSE                  2 IWp9dQGM0bS 
#> 17 hRQsZ… 17 A… ASIL… TRUE                 FALSE                  2 IWp9dQGM0bS 
#> 18 K27Jz… 18 X… ASIL… TRUE                 FALSE                  2 IWp9dQGM0bS 
#> # ℹ 4 more variables: parent_id <chr>, parent_name <chr>, type <int>,
#> #   coordinates <chr>
```
