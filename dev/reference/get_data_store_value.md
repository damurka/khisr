# Get a Value from a DHIS2 Data Store

**\[experimental\]** `get_data_store_value()` retrieves the JSON value
stored under a namespace/key pair in a DHIS2 instance's key/value data
store. See
[`get_data_store_namespaces()`](https://khisr.damurka.com/dev/reference/get_data_store_namespaces.md).

## Usage

``` r
get_data_store_value(
  namespace,
  key,
  store = c("system", "user"),
  auth = NULL,
  call = caller_env()
)
```

## Arguments

- namespace:

  A data store namespace, as returned by
  [`get_data_store_namespaces()`](https://khisr.damurka.com/dev/reference/get_data_store_namespaces.md).

- key:

  A key within `namespace`, as returned by
  [`get_data_store_keys()`](https://khisr.damurka.com/dev/reference/get_data_store_keys.md).

- store:

  Optional. `'system'` (default) or `'user'`; see
  [`get_data_store_namespaces()`](https://khisr.damurka.com/dev/reference/get_data_store_namespaces.md).

- auth:

  Optional. The authentication object.

- call:

  The caller environment.

## Value

The stored value, parsed from JSON — typically a named list, but shape
varies entirely by what the namespace/key holds. Confirmed live against
a public DHIS2 demo instance.

## See also

[`get_data_store_namespaces()`](https://khisr.damurka.com/dev/reference/get_data_store_namespaces.md),
[`get_data_store_keys()`](https://khisr.damurka.com/dev/reference/get_data_store_keys.md).

## Examples

``` r

namespaces <- get_data_store_namespaces()
keys <- get_data_store_keys(namespaces[1])
get_data_store_value(namespaces[1], keys[1])
#> $groups
#> $groups[[1]]
#> $groups[[1]]$code
#> [1] "G1"
#> 
#> $groups[[1]]$name
#> [1] "General Service Statistics"
#> 
#> $groups[[1]]$members
#> $groups[[1]]$members[[1]]
#> [1] "D21"
#> 
#> 
#> $groups[[1]]$displayName
#> [1] "General Service Statistics"
#> 
#> 
#> $groups[[2]]
#> $groups[[2]]$code
#> [1] "G2"
#> 
#> $groups[[2]]$name
#> [1] "Maternal Health"
#> 
#> $groups[[2]]$members
#> $groups[[2]]$members[[1]]
#> [1] "D1"
#> 
#> $groups[[2]]$members[[2]]
#> [1] "D2"
#> 
#> $groups[[2]]$members[[3]]
#> [1] "D40"
#> 
#> $groups[[2]]$members[[4]]
#> [1] "D29"
#> 
#> $groups[[2]]$members[[5]]
#> [1] "D19"
#> 
#> 
#> $groups[[2]]$displayName
#> [1] "Maternal Health"
#> 
#> 
#> $groups[[3]]
#> $groups[[3]]$code
#> [1] "G3"
#> 
#> $groups[[3]]$name
#> [1] "Immunization"
#> 
#> $groups[[3]]$members
#> $groups[[3]]$members[[1]]
#> [1] "D3"
#> 
#> $groups[[3]]$members[[2]]
#> [1] "D4"
#> 
#> $groups[[3]]$members[[3]]
#> [1] "D10"
#> 
#> $groups[[3]]$members[[4]]
#> [1] "D24"
#> 
#> $groups[[3]]$members[[5]]
#> [1] "D12"
#> 
#> $groups[[3]]$members[[6]]
#> [1] "D13"
#> 
#> $groups[[3]]$members[[7]]
#> [1] "D25"
#> 
#> 
#> $groups[[3]]$displayName
#> [1] "Immunization"
#> 
#> 
#> $groups[[4]]
#> $groups[[4]]$code
#> [1] "G4"
#> 
#> $groups[[4]]$name
#> [1] "HIV/Aids"
#> 
#> $groups[[4]]$members
#> $groups[[4]]$members[[1]]
#> [1] "D6"
#> 
#> $groups[[4]]$members[[2]]
#> [1] "D16"
#> 
#> $groups[[4]]$members[[3]]
#> [1] "D42"
#> 
#> $groups[[4]]$members[[4]]
#> [1] "D26"
#> 
#> $groups[[4]]$members[[5]]
#> [1] "D27"
#> 
#> 
#> $groups[[4]]$displayName
#> [1] "HIV/Aids"
#> 
#> 
#> $groups[[5]]
#> $groups[[5]]$code
#> [1] "G5"
#> 
#> $groups[[5]]$name
#> [1] "TB"
#> 
#> $groups[[5]]$members
#> $groups[[5]]$members[[1]]
#> [1] "D5"
#> 
#> $groups[[5]]$members[[2]]
#> [1] "D30"
#> 
#> $groups[[5]]$members[[3]]
#> [1] "D34"
#> 
#> $groups[[5]]$members[[4]]
#> [1] "D37"
#> 
#> 
#> $groups[[5]]$displayName
#> [1] "TB"
#> 
#> 
#> $groups[[6]]
#> $groups[[6]]$code
#> [1] "G6"
#> 
#> $groups[[6]]$name
#> [1] "TB/HIV"
#> 
#> $groups[[6]]$members
#> $groups[[6]]$members[[1]]
#> [1] "D31"
#> 
#> $groups[[6]]$members[[2]]
#> [1] "D32"
#> 
#> 
#> $groups[[6]]$displayName
#> [1] "TB/HIV"
#> 
#> 
#> $groups[[7]]
#> $groups[[7]]$code
#> [1] "G7"
#> 
#> $groups[[7]]$name
#> [1] "Malaria"
#> 
#> $groups[[7]]$members
#> $groups[[7]]$members[[1]]
#> [1] "D8"
#> 
#> $groups[[7]]$members[[2]]
#> [1] "D9"
#> 
#> $groups[[7]]$members[[3]]
#> [1] "D35"
#> 
#> $groups[[7]]$members[[4]]
#> [1] "D23"
#> 
#> $groups[[7]]$members[[5]]
#> [1] "D41"
#> 
#> $groups[[7]]$members[[6]]
#> [1] "D36"
#> 
#> 
#> $groups[[7]]$displayName
#> [1] "Malaria"
#> 
#> 
#> 
#> $dataSets
#> $dataSets[[1]]
#> $dataSets[[1]]$id
#> [1] "tQc4Gv2Jwco"
#> 
#> $dataSets[[1]]$name
#> [1] "RMNCAH"
#> 
#> $dataSets[[1]]$trend
#> [1] "constant"
#> 
#> $dataSets[[1]]$threshold
#> [1] 90
#> 
#> $dataSets[[1]]$comparison
#> [1] "ou"
#> 
#> $dataSets[[1]]$periodType
#> [1] "Monthly"
#> 
#> $dataSets[[1]]$timelinessThreshold
#> [1] 75
#> 
#> $dataSets[[1]]$consistencyThreshold
#> [1] 33
#> 
#> 
#> $dataSets[[2]]
#> $dataSets[[2]]$id
#> [1] "jqSaKxtj8IA"
#> 
#> $dataSets[[2]]$name
#> [1] "Immunization"
#> 
#> $dataSets[[2]]$trend
#> [1] "constant"
#> 
#> $dataSets[[2]]$threshold
#> [1] 90
#> 
#> $dataSets[[2]]$comparison
#> [1] "ou"
#> 
#> $dataSets[[2]]$periodType
#> [1] "Monthly"
#> 
#> $dataSets[[2]]$timelinessThreshold
#> [1] 75
#> 
#> $dataSets[[2]]$consistencyThreshold
#> [1] 33
#> 
#> 
#> $dataSets[[3]]
#> $dataSets[[3]]$id
#> [1] "O34y2Kyxx6P"
#> 
#> $dataSets[[3]]$name
#> [1] "Malaria burden reduction"
#> 
#> $dataSets[[3]]$trend
#> [1] "constant"
#> 
#> $dataSets[[3]]$threshold
#> [1] 90
#> 
#> $dataSets[[3]]$comparison
#> [1] "ou"
#> 
#> $dataSets[[3]]$periodType
#> [1] "Monthly"
#> 
#> $dataSets[[3]]$timelinessThreshold
#> [1] 75
#> 
#> $dataSets[[3]]$consistencyThreshold
#> [1] 33
#> 
#> 
#> $dataSets[[4]]
#> $dataSets[[4]]$id
#> [1] "XvcWsuHBsGA"
#> 
#> $dataSets[[4]]$name
#> [1] "HIV Monthly "
#> 
#> $dataSets[[4]]$trend
#> [1] "constant"
#> 
#> $dataSets[[4]]$threshold
#> [1] 90
#> 
#> $dataSets[[4]]$comparison
#> [1] "ou"
#> 
#> $dataSets[[4]]$periodType
#> [1] "Monthly"
#> 
#> $dataSets[[4]]$timelinessThreshold
#> [1] 75
#> 
#> $dataSets[[4]]$consistencyThreshold
#> [1] 33
#> 
#> 
#> 
#> $numerators
#> $numerators[[1]]
#> $numerators[[1]]$code
#> [1] "D21"
#> 
#> $numerators[[1]]$core
#> [1] FALSE
#> 
#> $numerators[[1]]$name
#> [1] "OPD visits"
#> 
#> $numerators[[1]]$trend
#> [1] "constant"
#> 
#> $numerators[[1]]$custom
#> [1] FALSE
#> 
#> $numerators[[1]]$dataID
#> NULL
#> 
#> $numerators[[1]]$missing
#> [1] 90
#> 
#> $numerators[[1]]$comparison
#> [1] "ou"
#> 
#> $numerators[[1]]$definition
#> [1] "Total number of outpatient visits"
#> 
#> $numerators[[1]]$consistency
#> [1] 33
#> 
#> $numerators[[1]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[1]]$moderateOutlier
#> [1] 2
#> 
#> 
#> $numerators[[2]]
#> $numerators[[2]]$code
#> [1] "D1"
#> 
#> $numerators[[2]]$core
#> [1] TRUE
#> 
#> $numerators[[2]]$name
#> [1] "ANC 1"
#> 
#> $numerators[[2]]$trend
#> [1] "constant"
#> 
#> $numerators[[2]]$custom
#> [1] FALSE
#> 
#> $numerators[[2]]$dataID
#> [1] "qqc4NnWVFL9"
#> 
#> $numerators[[2]]$missing
#> [1] 90
#> 
#> $numerators[[2]]$dataSetID
#> $numerators[[2]]$dataSetID[[1]]
#> [1] "tQc4Gv2Jwco"
#> 
#> 
#> $numerators[[2]]$comparison
#> [1] "ou"
#> 
#> $numerators[[2]]$definition
#> [1] "Pregnant women attending at least one ANC visit during their pregnancy"
#> 
#> $numerators[[2]]$consistency
#> [1] 33
#> 
#> $numerators[[2]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[2]]$moderateOutlier
#> [1] 2
#> 
#> $numerators[[2]]$dataElementOperandID
#> [1] "qqc4NnWVFL9.MhS0mKLqv9I"
#> 
#> 
#> $numerators[[3]]
#> $numerators[[3]]$code
#> [1] "D40"
#> 
#> $numerators[[3]]$core
#> [1] FALSE
#> 
#> $numerators[[3]]$name
#> [1] "ANC 4"
#> 
#> $numerators[[3]]$trend
#> [1] "constant"
#> 
#> $numerators[[3]]$custom
#> [1] FALSE
#> 
#> $numerators[[3]]$dataID
#> NULL
#> 
#> $numerators[[3]]$missing
#> [1] 90
#> 
#> $numerators[[3]]$comparison
#> [1] "ou"
#> 
#> $numerators[[3]]$definition
#> [1] "Pregnant women attending at least four ANC visit during their pregnancy"
#> 
#> $numerators[[3]]$consistency
#> [1] 33
#> 
#> $numerators[[3]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[3]]$moderateOutlier
#> [1] 2
#> 
#> 
#> $numerators[[4]]
#> $numerators[[4]]$code
#> [1] "D2"
#> 
#> $numerators[[4]]$core
#> [1] FALSE
#> 
#> $numerators[[4]]$name
#> [1] "Institutional deliveries"
#> 
#> $numerators[[4]]$trend
#> [1] "constant"
#> 
#> $numerators[[4]]$custom
#> [1] FALSE
#> 
#> $numerators[[4]]$dataID
#> [1] "iGKV5qlVwYb"
#> 
#> $numerators[[4]]$missing
#> [1] 90
#> 
#> $numerators[[4]]$dataSetID
#> $numerators[[4]]$dataSetID[[1]]
#> [1] "tQc4Gv2Jwco"
#> 
#> 
#> $numerators[[4]]$comparison
#> [1] "ou"
#> 
#> $numerators[[4]]$definition
#> [1] "Deliveries in health facilities"
#> 
#> $numerators[[4]]$consistency
#> [1] 33
#> 
#> $numerators[[4]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[4]]$moderateOutlier
#> [1] 2
#> 
#> $numerators[[4]]$dataElementOperandID
#> [1] "iGKV5qlVwYb.MhS0mKLqv9I"
#> 
#> 
#> $numerators[[5]]
#> $numerators[[5]]$code
#> [1] "D23"
#> 
#> $numerators[[5]]$core
#> [1] FALSE
#> 
#> $numerators[[5]]$name
#> [1] "IPTp 3"
#> 
#> $numerators[[5]]$trend
#> [1] "constant"
#> 
#> $numerators[[5]]$custom
#> [1] FALSE
#> 
#> $numerators[[5]]$dataID
#> NULL
#> 
#> $numerators[[5]]$missing
#> [1] 90
#> 
#> $numerators[[5]]$comparison
#> [1] "ou"
#> 
#> $numerators[[5]]$definition
#> [1] "Pregnant women attending antenatal clinics who received three or more doses of intermittent preventive treatment (IPTp) for malaria."
#> 
#> $numerators[[5]]$consistency
#> [1] 33
#> 
#> $numerators[[5]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[5]]$moderateOutlier
#> [1] 2
#> 
#> 
#> $numerators[[6]]
#> $numerators[[6]]$code
#> [1] "D36"
#> 
#> $numerators[[6]]$core
#> [1] FALSE
#> 
#> $numerators[[6]]$name
#> [1] "IPTp 1"
#> 
#> $numerators[[6]]$trend
#> [1] "constant"
#> 
#> $numerators[[6]]$custom
#> [1] FALSE
#> 
#> $numerators[[6]]$dataID
#> NULL
#> 
#> $numerators[[6]]$missing
#> [1] 90
#> 
#> $numerators[[6]]$comparison
#> [1] "ou"
#> 
#> $numerators[[6]]$definition
#> [1] "Pregnant women attending antenatal clinics who received at least one dose of intermittent preventive treatment (IPTp) for malaria."
#> 
#> $numerators[[6]]$consistency
#> [1] 33
#> 
#> $numerators[[6]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[6]]$moderateOutlier
#> [1] 2
#> 
#> 
#> $numerators[[7]]
#> $numerators[[7]]$code
#> [1] "D3"
#> 
#> $numerators[[7]]$core
#> [1] TRUE
#> 
#> $numerators[[7]]$name
#> [1] "DPT 3"
#> 
#> $numerators[[7]]$trend
#> [1] "constant"
#> 
#> $numerators[[7]]$custom
#> [1] FALSE
#> 
#> $numerators[[7]]$dataID
#> [1] "TWWbtMMWD51"
#> 
#> $numerators[[7]]$missing
#> [1] 90
#> 
#> $numerators[[7]]$dataSetID
#> $numerators[[7]]$dataSetID[[1]]
#> [1] "jqSaKxtj8IA"
#> 
#> 
#> $numerators[[7]]$comparison
#> [1] "ou"
#> 
#> $numerators[[7]]$definition
#> [1] "Children receiving 3rd dose of DPT-containing-vaccine (PENTA)"
#> 
#> $numerators[[7]]$consistency
#> [1] 33
#> 
#> $numerators[[7]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[7]]$moderateOutlier
#> [1] 2
#> 
#> $numerators[[7]]$dataElementOperandID
#> [1] "TWWbtMMWD51.JKuWbG5bWAu"
#> 
#> 
#> $numerators[[8]]
#> $numerators[[8]]$code
#> [1] "D4"
#> 
#> $numerators[[8]]$core
#> [1] FALSE
#> 
#> $numerators[[8]]$name
#> [1] "MCV 1"
#> 
#> $numerators[[8]]$trend
#> [1] "constant"
#> 
#> $numerators[[8]]$custom
#> [1] FALSE
#> 
#> $numerators[[8]]$dataID
#> NULL
#> 
#> $numerators[[8]]$missing
#> [1] 90
#> 
#> $numerators[[8]]$comparison
#> [1] "ou"
#> 
#> $numerators[[8]]$definition
#> [1] "Children receiving 1st dose of MCV."
#> 
#> $numerators[[8]]$consistency
#> [1] 33
#> 
#> $numerators[[8]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[8]]$moderateOutlier
#> [1] 2
#> 
#> 
#> $numerators[[9]]
#> $numerators[[9]]$code
#> [1] "D5"
#> 
#> $numerators[[9]]$core
#> [1] TRUE
#> 
#> $numerators[[9]]$name
#> [1] "TB cases (all forms) notified"
#> 
#> $numerators[[9]]$trend
#> [1] "constant"
#> 
#> $numerators[[9]]$custom
#> [1] FALSE
#> 
#> $numerators[[9]]$dataID
#> NULL
#> 
#> $numerators[[9]]$missing
#> [1] 90
#> 
#> $numerators[[9]]$comparison
#> [1] "ou"
#> 
#> $numerators[[9]]$definition
#> [1] "TB cases (all forms) that have been notified."
#> 
#> $numerators[[9]]$consistency
#> [1] 33
#> 
#> $numerators[[9]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[9]]$moderateOutlier
#> [1] 2
#> 
#> 
#> $numerators[[10]]
#> $numerators[[10]]$code
#> [1] "D37"
#> 
#> $numerators[[10]]$core
#> [1] FALSE
#> 
#> $numerators[[10]]$name
#> [1] "TB cases registered for treatment"
#> 
#> $numerators[[10]]$trend
#> [1] "constant"
#> 
#> $numerators[[10]]$custom
#> [1] FALSE
#> 
#> $numerators[[10]]$dataID
#> NULL
#> 
#> $numerators[[10]]$missing
#> [1] 90
#> 
#> $numerators[[10]]$comparison
#> [1] "ou"
#> 
#> $numerators[[10]]$definition
#> [1] "TB cases registered (for treatment), e.g. as reported in treatment outcome reporting forms."
#> 
#> $numerators[[10]]$consistency
#> [1] 33
#> 
#> $numerators[[10]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[10]]$moderateOutlier
#> [1] 2
#> 
#> 
#> $numerators[[11]]
#> $numerators[[11]]$code
#> [1] "D30"
#> 
#> $numerators[[11]]$core
#> [1] FALSE
#> 
#> $numerators[[11]]$name
#> [1] "TB cases successfully treated"
#> 
#> $numerators[[11]]$trend
#> [1] "constant"
#> 
#> $numerators[[11]]$custom
#> [1] FALSE
#> 
#> $numerators[[11]]$dataID
#> NULL
#> 
#> $numerators[[11]]$missing
#> [1] 90
#> 
#> $numerators[[11]]$comparison
#> [1] "ou"
#> 
#> $numerators[[11]]$definition
#> [1] "TB cases successfully treated (cured plus treatment completed) among TB cases notified to the national health authorities in a specified time period."
#> 
#> $numerators[[11]]$consistency
#> [1] 33
#> 
#> $numerators[[11]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[11]]$moderateOutlier
#> [1] 2
#> 
#> 
#> $numerators[[12]]
#> $numerators[[12]]$code
#> [1] "D31"
#> 
#> $numerators[[12]]$core
#> [1] FALSE
#> 
#> $numerators[[12]]$name
#> [1] "TB cases tested for HIV"
#> 
#> $numerators[[12]]$trend
#> [1] "constant"
#> 
#> $numerators[[12]]$custom
#> [1] FALSE
#> 
#> $numerators[[12]]$dataID
#> NULL
#> 
#> $numerators[[12]]$missing
#> [1] 90
#> 
#> $numerators[[12]]$comparison
#> [1] "ou"
#> 
#> $numerators[[12]]$definition
#> [1] "New and relapse TB patients who had an HIV test recorded in the TB register."
#> 
#> $numerators[[12]]$consistency
#> [1] 33
#> 
#> $numerators[[12]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[12]]$moderateOutlier
#> [1] 2
#> 
#> 
#> $numerators[[13]]
#> $numerators[[13]]$code
#> [1] "D32"
#> 
#> $numerators[[13]]$core
#> [1] FALSE
#> 
#> $numerators[[13]]$name
#> [1] "HIV-positive TB cases initiating ART"
#> 
#> $numerators[[13]]$trend
#> [1] "constant"
#> 
#> $numerators[[13]]$custom
#> [1] FALSE
#> 
#> $numerators[[13]]$dataID
#> NULL
#> 
#> $numerators[[13]]$missing
#> [1] 90
#> 
#> $numerators[[13]]$comparison
#> [1] "ou"
#> 
#> $numerators[[13]]$definition
#> [1] "HIV-positive new and relapse TB patients who received ART during TB treatment"
#> 
#> $numerators[[13]]$consistency
#> [1] 33
#> 
#> $numerators[[13]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[13]]$moderateOutlier
#> [1] 2
#> 
#> 
#> $numerators[[14]]
#> $numerators[[14]]$code
#> [1] "D34"
#> 
#> $numerators[[14]]$core
#> [1] FALSE
#> 
#> $numerators[[14]]$name
#> [1] "MDR-TB cases successfully treated"
#> 
#> $numerators[[14]]$trend
#> [1] "constant"
#> 
#> $numerators[[14]]$custom
#> [1] FALSE
#> 
#> $numerators[[14]]$dataID
#> NULL
#> 
#> $numerators[[14]]$missing
#> [1] 90
#> 
#> $numerators[[14]]$comparison
#> [1] "ou"
#> 
#> $numerators[[14]]$definition
#> [1] "Bacteriologically-confirmed RR and/or MDR-TB cases enrolled on second-line anti-TB treatment during the year of assessment who are successfully treated (cured plus completed treatment)."
#> 
#> $numerators[[14]]$consistency
#> [1] 33
#> 
#> $numerators[[14]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[14]]$moderateOutlier
#> [1] 2
#> 
#> 
#> $numerators[[15]]
#> $numerators[[15]]$code
#> [1] "D8"
#> 
#> $numerators[[15]]$core
#> [1] TRUE
#> 
#> $numerators[[15]]$name
#> [1] "Confirmed malaria cases"
#> 
#> $numerators[[15]]$trend
#> [1] "constant"
#> 
#> $numerators[[15]]$custom
#> [1] FALSE
#> 
#> $numerators[[15]]$dataID
#> [1] "lYsfXxCw6Qi"
#> 
#> $numerators[[15]]$missing
#> [1] 90
#> 
#> $numerators[[15]]$dataSetID
#> $numerators[[15]]$dataSetID[[1]]
#> [1] "O34y2Kyxx6P"
#> 
#> 
#> $numerators[[15]]$comparison
#> [1] "ou"
#> 
#> $numerators[[15]]$definition
#> [1] "Confirmed malaria cases reported."
#> 
#> $numerators[[15]]$consistency
#> [1] 33
#> 
#> $numerators[[15]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[15]]$moderateOutlier
#> [1] 2
#> 
#> $numerators[[15]]$dataElementOperandID
#> [1] "lYsfXxCw6Qi.hF0pQZIn6Ch"
#> 
#> 
#> $numerators[[16]]
#> $numerators[[16]]$code
#> [1] "D41"
#> 
#> $numerators[[16]]$core
#> [1] FALSE
#> 
#> $numerators[[16]]$name
#> [1] "Confirmed malaria treated"
#> 
#> $numerators[[16]]$trend
#> [1] "constant"
#> 
#> $numerators[[16]]$custom
#> [1] FALSE
#> 
#> $numerators[[16]]$dataID
#> [1] "YG5uCKZRilL"
#> 
#> $numerators[[16]]$missing
#> [1] 90
#> 
#> $numerators[[16]]$dataSetID
#> $numerators[[16]]$dataSetID[[1]]
#> [1] "O34y2Kyxx6P"
#> 
#> 
#> $numerators[[16]]$comparison
#> [1] "ou"
#> 
#> $numerators[[16]]$definition
#> [1] "Confirmed malaria cases that received first-line antimalarial treatment."
#> 
#> $numerators[[16]]$consistency
#> [1] 33
#> 
#> $numerators[[16]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[16]]$moderateOutlier
#> [1] 2
#> 
#> $numerators[[16]]$dataElementOperandID
#> [1] "YG5uCKZRilL"
#> 
#> 
#> $numerators[[17]]
#> $numerators[[17]]$code
#> [1] "D9"
#> 
#> $numerators[[17]]$core
#> [1] FALSE
#> 
#> $numerators[[17]]$name
#> [1] "Malaria cases treated"
#> 
#> $numerators[[17]]$trend
#> [1] "constant"
#> 
#> $numerators[[17]]$custom
#> [1] FALSE
#> 
#> $numerators[[17]]$dataID
#> NULL
#> 
#> $numerators[[17]]$missing
#> [1] 90
#> 
#> $numerators[[17]]$comparison
#> [1] "ou"
#> 
#> $numerators[[17]]$definition
#> [1] "Malaria cases (presumed and confirmed) that received first line antimalarial treatment."
#> 
#> $numerators[[17]]$consistency
#> [1] 33
#> 
#> $numerators[[17]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[17]]$moderateOutlier
#> [1] 2
#> 
#> 
#> $numerators[[18]]
#> $numerators[[18]]$code
#> [1] "D35"
#> 
#> $numerators[[18]]$core
#> [1] FALSE
#> 
#> $numerators[[18]]$name
#> [1] "Malaria cases tested"
#> 
#> $numerators[[18]]$trend
#> [1] "constant"
#> 
#> $numerators[[18]]$custom
#> [1] FALSE
#> 
#> $numerators[[18]]$dataID
#> NULL
#> 
#> $numerators[[18]]$missing
#> [1] 90
#> 
#> $numerators[[18]]$comparison
#> [1] "ou"
#> 
#> $numerators[[18]]$definition
#> [1] "Suspected malaria cases that received a parasitological test."
#> 
#> $numerators[[18]]$consistency
#> [1] 33
#> 
#> $numerators[[18]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[18]]$moderateOutlier
#> [1] 2
#> 
#> 
#> $numerators[[19]]
#> $numerators[[19]]$code
#> [1] "D10"
#> 
#> $numerators[[19]]$core
#> [1] FALSE
#> 
#> $numerators[[19]]$name
#> [1] "DPT 1"
#> 
#> $numerators[[19]]$trend
#> [1] "constant"
#> 
#> $numerators[[19]]$custom
#> [1] FALSE
#> 
#> $numerators[[19]]$dataID
#> [1] "hJJlOnVOkV2"
#> 
#> $numerators[[19]]$missing
#> [1] 90
#> 
#> $numerators[[19]]$dataSetID
#> $numerators[[19]]$dataSetID[[1]]
#> [1] "jqSaKxtj8IA"
#> 
#> 
#> $numerators[[19]]$comparison
#> [1] "ou"
#> 
#> $numerators[[19]]$definition
#> [1] "Children receiving 1st dose DPT-containing-vaccine (PENTA)"
#> 
#> $numerators[[19]]$consistency
#> [1] 33
#> 
#> $numerators[[19]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[19]]$moderateOutlier
#> [1] 2
#> 
#> $numerators[[19]]$dataElementOperandID
#> [1] "hJJlOnVOkV2.JKuWbG5bWAu"
#> 
#> 
#> $numerators[[20]]
#> $numerators[[20]]$code
#> [1] "D24"
#> 
#> $numerators[[20]]$core
#> [1] FALSE
#> 
#> $numerators[[20]]$name
#> [1] "DPT 2"
#> 
#> $numerators[[20]]$trend
#> [1] "constant"
#> 
#> $numerators[[20]]$custom
#> [1] FALSE
#> 
#> $numerators[[20]]$dataID
#> [1] "lHnact7BRVU"
#> 
#> $numerators[[20]]$missing
#> [1] 90
#> 
#> $numerators[[20]]$dataSetID
#> $numerators[[20]]$dataSetID[[1]]
#> [1] "jqSaKxtj8IA"
#> 
#> 
#> $numerators[[20]]$comparison
#> [1] "ou"
#> 
#> $numerators[[20]]$definition
#> [1] "Children receiving 2nd dose DPT-containing-vaccine (PENTA)"
#> 
#> $numerators[[20]]$consistency
#> [1] 33
#> 
#> $numerators[[20]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[20]]$moderateOutlier
#> [1] 2
#> 
#> $numerators[[20]]$dataElementOperandID
#> [1] "lHnact7BRVU.JKuWbG5bWAu"
#> 
#> 
#> $numerators[[21]]
#> $numerators[[21]]$code
#> [1] "D12"
#> 
#> $numerators[[21]]$core
#> [1] FALSE
#> 
#> $numerators[[21]]$name
#> [1] "PCV 1"
#> 
#> $numerators[[21]]$trend
#> [1] "constant"
#> 
#> $numerators[[21]]$custom
#> [1] FALSE
#> 
#> $numerators[[21]]$dataID
#> NULL
#> 
#> $numerators[[21]]$missing
#> [1] 90
#> 
#> $numerators[[21]]$comparison
#> [1] "ou"
#> 
#> $numerators[[21]]$definition
#> [1] "Children receiving 1st dose of PCV-vaccine"
#> 
#> $numerators[[21]]$consistency
#> [1] 33
#> 
#> $numerators[[21]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[21]]$moderateOutlier
#> [1] 2
#> 
#> 
#> $numerators[[22]]
#> $numerators[[22]]$code
#> [1] "D25"
#> 
#> $numerators[[22]]$core
#> [1] FALSE
#> 
#> $numerators[[22]]$name
#> [1] "PCV 2"
#> 
#> $numerators[[22]]$trend
#> [1] "constant"
#> 
#> $numerators[[22]]$custom
#> [1] FALSE
#> 
#> $numerators[[22]]$dataID
#> NULL
#> 
#> $numerators[[22]]$missing
#> [1] 90
#> 
#> $numerators[[22]]$comparison
#> [1] "ou"
#> 
#> $numerators[[22]]$definition
#> [1] "Children receiving 2nd dose of PCV-vaccine"
#> 
#> $numerators[[22]]$consistency
#> [1] 33
#> 
#> $numerators[[22]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[22]]$moderateOutlier
#> [1] 2
#> 
#> 
#> $numerators[[23]]
#> $numerators[[23]]$code
#> [1] "D13"
#> 
#> $numerators[[23]]$core
#> [1] FALSE
#> 
#> $numerators[[23]]$name
#> [1] "PCV 3"
#> 
#> $numerators[[23]]$trend
#> [1] "constant"
#> 
#> $numerators[[23]]$custom
#> [1] FALSE
#> 
#> $numerators[[23]]$dataID
#> NULL
#> 
#> $numerators[[23]]$missing
#> [1] 90
#> 
#> $numerators[[23]]$comparison
#> [1] "ou"
#> 
#> $numerators[[23]]$definition
#> [1] "Children receiving 3rd dose of PCV-vaccine"
#> 
#> $numerators[[23]]$consistency
#> [1] 33
#> 
#> $numerators[[23]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[23]]$moderateOutlier
#> [1] 2
#> 
#> 
#> $numerators[[24]]
#> $numerators[[24]]$code
#> [1] "D16"
#> 
#> $numerators[[24]]$core
#> [1] FALSE
#> 
#> $numerators[[24]]$name
#> [1] "PLHIV on ART"
#> 
#> $numerators[[24]]$trend
#> [1] "constant"
#> 
#> $numerators[[24]]$custom
#> [1] FALSE
#> 
#> $numerators[[24]]$dataID
#> NULL
#> 
#> $numerators[[24]]$missing
#> [1] 90
#> 
#> $numerators[[24]]$comparison
#> [1] "ou"
#> 
#> $numerators[[24]]$definition
#> [1] "PLHIV receiving ART"
#> 
#> $numerators[[24]]$consistency
#> [1] 33
#> 
#> $numerators[[24]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[24]]$moderateOutlier
#> [1] 2
#> 
#> 
#> $numerators[[25]]
#> $numerators[[25]]$code
#> [1] "D6"
#> 
#> $numerators[[25]]$core
#> [1] FALSE
#> 
#> $numerators[[25]]$name
#> [1] "Virally supressed ART-clients"
#> 
#> $numerators[[25]]$trend
#> [1] "constant"
#> 
#> $numerators[[25]]$custom
#> [1] FALSE
#> 
#> $numerators[[25]]$dataID
#> NULL
#> 
#> $numerators[[25]]$missing
#> [1] 90
#> 
#> $numerators[[25]]$comparison
#> [1] "ou"
#> 
#> $numerators[[25]]$definition
#> [1] "PLHIV on ART who are virally supressed"
#> 
#> $numerators[[25]]$consistency
#> [1] 33
#> 
#> $numerators[[25]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[25]]$moderateOutlier
#> [1] 2
#> 
#> 
#> $numerators[[26]]
#> $numerators[[26]]$code
#> [1] "D26"
#> 
#> $numerators[[26]]$core
#> [1] FALSE
#> 
#> $numerators[[26]]$name
#> [1] "Retained on ART 12 months after initiation"
#> 
#> $numerators[[26]]$trend
#> [1] "constant"
#> 
#> $numerators[[26]]$custom
#> [1] FALSE
#> 
#> $numerators[[26]]$dataID
#> NULL
#> 
#> $numerators[[26]]$missing
#> [1] 90
#> 
#> $numerators[[26]]$comparison
#> [1] "ou"
#> 
#> $numerators[[26]]$definition
#> [1] "PLHIV still on ART 12 months after initiation (retention)"
#> 
#> $numerators[[26]]$consistency
#> [1] 33
#> 
#> $numerators[[26]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[26]]$moderateOutlier
#> [1] 2
#> 
#> 
#> $numerators[[27]]
#> $numerators[[27]]$code
#> [1] "D27"
#> 
#> $numerators[[27]]$core
#> [1] TRUE
#> 
#> $numerators[[27]]$name
#> [1] "PLHIV in HIV care"
#> 
#> $numerators[[27]]$trend
#> [1] "constant"
#> 
#> $numerators[[27]]$custom
#> [1] FALSE
#> 
#> $numerators[[27]]$dataID
#> [1] "bJty1TJXcPN"
#> 
#> $numerators[[27]]$missing
#> [1] 90
#> 
#> $numerators[[27]]$dataSetID
#> $numerators[[27]]$dataSetID[[1]]
#> [1] "XvcWsuHBsGA"
#> 
#> 
#> $numerators[[27]]$comparison
#> [1] "ou"
#> 
#> $numerators[[27]]$definition
#> [1] "PLHIV receiving HIV care (pre-ART and ART)"
#> 
#> $numerators[[27]]$consistency
#> [1] 33
#> 
#> $numerators[[27]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[27]]$moderateOutlier
#> [1] 2
#> 
#> $numerators[[27]]$dataElementOperandID
#> [1] "bJty1TJXcPN.i6EGYMCUiyp"
#> 
#> 
#> $numerators[[28]]
#> $numerators[[28]]$code
#> [1] "D42"
#> 
#> $numerators[[28]]$core
#> [1] FALSE
#> 
#> $numerators[[28]]$name
#> [1] "Pregnant women on ART (PMTCT)"
#> 
#> $numerators[[28]]$trend
#> [1] "constant"
#> 
#> $numerators[[28]]$custom
#> [1] FALSE
#> 
#> $numerators[[28]]$dataID
#> NULL
#> 
#> $numerators[[28]]$missing
#> [1] 90
#> 
#> $numerators[[28]]$comparison
#> [1] "ou"
#> 
#> $numerators[[28]]$definition
#> [1] "HIV-positive pregnant women on ART (PMTCT)"
#> 
#> $numerators[[28]]$consistency
#> [1] 33
#> 
#> $numerators[[28]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[28]]$moderateOutlier
#> [1] 2
#> 
#> 
#> $numerators[[29]]
#> $numerators[[29]]$code
#> [1] "D29"
#> 
#> $numerators[[29]]$core
#> [1] FALSE
#> 
#> $numerators[[29]]$name
#> [1] "Postpartum care within 2 days (PNC)"
#> 
#> $numerators[[29]]$trend
#> [1] "constant"
#> 
#> $numerators[[29]]$custom
#> [1] FALSE
#> 
#> $numerators[[29]]$dataID
#> NULL
#> 
#> $numerators[[29]]$missing
#> [1] 90
#> 
#> $numerators[[29]]$comparison
#> [1] "ou"
#> 
#> $numerators[[29]]$definition
#> [1] "Mothers and babies who received postpartum care within two days of childbirth"
#> 
#> $numerators[[29]]$consistency
#> [1] 33
#> 
#> $numerators[[29]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[29]]$moderateOutlier
#> [1] 2
#> 
#> 
#> $numerators[[30]]
#> $numerators[[30]]$code
#> [1] "D19"
#> 
#> $numerators[[30]]$core
#> [1] FALSE
#> 
#> $numerators[[30]]$name
#> [1] "Pregnant women receiving TT 1"
#> 
#> $numerators[[30]]$trend
#> [1] "constant"
#> 
#> $numerators[[30]]$custom
#> [1] FALSE
#> 
#> $numerators[[30]]$dataID
#> NULL
#> 
#> $numerators[[30]]$missing
#> [1] 90
#> 
#> $numerators[[30]]$comparison
#> [1] "ou"
#> 
#> $numerators[[30]]$definition
#> [1] "Pregnant women who received the 1st dose of tetanus-toxoid vaccine"
#> 
#> $numerators[[30]]$consistency
#> [1] 33
#> 
#> $numerators[[30]]$extremeOutlier
#> [1] 3
#> 
#> $numerators[[30]]$moderateOutlier
#> [1] 2
#> 
#> 
#> 
#> $lastUpdated
#> [1] "2023-12-12T21:23:54.550Z"
#> 
#> $denominators
#> $denominators[[1]]
#> $denominators[[1]]$code
#> [1] "P1"
#> 
#> $denominators[[1]]$type
#> [1] "un"
#> 
#> $denominators[[1]]$dataID
#> [1] ""
#> 
#> $denominators[[1]]$lowLevel
#> [1] 1
#> 
#> 
#> $denominators[[2]]
#> $denominators[[2]]$code
#> [1] "P2"
#> 
#> $denominators[[2]]$type
#> [1] "plhiv"
#> 
#> $denominators[[2]]$dataID
#> [1] ""
#> 
#> $denominators[[2]]$lowLevel
#> [1] 1
#> 
#> 
#> $denominators[[3]]
#> $denominators[[3]]$code
#> [1] "P3"
#> 
#> $denominators[[3]]$type
#> [1] "lt1"
#> 
#> $denominators[[3]]$dataID
#> [1] ""
#> 
#> $denominators[[3]]$lowLevel
#> [1] 1
#> 
#> 
#> $denominators[[4]]
#> $denominators[[4]]$code
#> [1] "P4"
#> 
#> $denominators[[4]]$type
#> [1] "ep"
#> 
#> $denominators[[4]]$dataID
#> [1] ""
#> 
#> $denominators[[4]]$lowLevel
#> [1] 1
#> 
#> 
#> $denominators[[5]]
#> $denominators[[5]]$code
#> [1] "P5"
#> 
#> $denominators[[5]]$type
#> [1] "total"
#> 
#> $denominators[[5]]$dataID
#> [1] ""
#> 
#> $denominators[[5]]$lowLevel
#> [1] 1
#> 
#> 
#> 
#> $coreIndicators
#> $coreIndicators[[1]]
#> [1] "D1"
#> 
#> $coreIndicators[[2]]
#> [1] "D3"
#> 
#> $coreIndicators[[3]]
#> [1] "D27"
#> 
#> $coreIndicators[[4]]
#> [1] "D5"
#> 
#> $coreIndicators[[5]]
#> [1] "D8"
#> 
#> 
#> $metaDataVersion
#> [1] "1.1"
#> 
#> $externalRelations
#> $externalRelations[[1]]
#> $externalRelations[[1]]$code
#> [1] "ER1"
#> 
#> $externalRelations[[1]]$name
#> [1] "ANC 1 coverage - routine to survey"
#> 
#> $externalRelations[[1]]$level
#> NULL
#> 
#> $externalRelations[[1]]$criteria
#> [1] 33
#> 
#> $externalRelations[[1]]$dataType
#> [1] ""
#> 
#> $externalRelations[[1]]$numerator
#> [1] "D1"
#> 
#> $externalRelations[[1]]$denominator
#> [1] "P4"
#> 
#> $externalRelations[[1]]$externalData
#> [1] ""
#> 
#> 
#> $externalRelations[[2]]
#> $externalRelations[[2]]$code
#> [1] "ER2"
#> 
#> $externalRelations[[2]]$name
#> [1] "DPT 3 coverage - routine to survey"
#> 
#> $externalRelations[[2]]$level
#> NULL
#> 
#> $externalRelations[[2]]$criteria
#> [1] 33
#> 
#> $externalRelations[[2]]$dataType
#> [1] ""
#> 
#> $externalRelations[[2]]$numerator
#> [1] "D3"
#> 
#> $externalRelations[[2]]$denominator
#> [1] "P3"
#> 
#> $externalRelations[[2]]$externalData
#> [1] ""
#> 
#> 
#> $externalRelations[[3]]
#> $externalRelations[[3]]$code
#> [1] "ER3"
#> 
#> $externalRelations[[3]]$name
#> [1] "ART coverage - routine to survey"
#> 
#> $externalRelations[[3]]$level
#> NULL
#> 
#> $externalRelations[[3]]$criteria
#> [1] 33
#> 
#> $externalRelations[[3]]$dataType
#> [1] ""
#> 
#> $externalRelations[[3]]$numerator
#> [1] "D16"
#> 
#> $externalRelations[[3]]$denominator
#> [1] "P2"
#> 
#> $externalRelations[[3]]$externalData
#> [1] ""
#> 
#> 
#> 
#> $numeratorRelations
#> $numeratorRelations[[1]]
#> $numeratorRelations[[1]]$A
#> [1] "D1"
#> 
#> $numeratorRelations[[1]]$B
#> [1] "D19"
#> 
#> $numeratorRelations[[1]]$code
#> [1] "R1"
#> 
#> $numeratorRelations[[1]]$name
#> [1] "ANC 1 - TT1 ratio"
#> 
#> $numeratorRelations[[1]]$type
#> [1] "eq"
#> 
#> $numeratorRelations[[1]]$criteria
#> [1] 10
#> 
#> 
#> $numeratorRelations[[2]]
#> $numeratorRelations[[2]]$A
#> [1] "D1"
#> 
#> $numeratorRelations[[2]]$B
#> [1] "D36"
#> 
#> $numeratorRelations[[2]]$code
#> [1] "R4"
#> 
#> $numeratorRelations[[2]]$name
#> [1] "ANC 1 - IPTp1 ratio"
#> 
#> $numeratorRelations[[2]]$type
#> [1] "eq"
#> 
#> $numeratorRelations[[2]]$criteria
#> [1] 10
#> 
#> 
#> $numeratorRelations[[3]]
#> $numeratorRelations[[3]]$A
#> [1] "D10"
#> 
#> $numeratorRelations[[3]]$B
#> [1] "D3"
#> 
#> $numeratorRelations[[3]]$code
#> [1] "R2"
#> 
#> $numeratorRelations[[3]]$name
#> [1] "DPT 1 to 3 dropout rate"
#> 
#> $numeratorRelations[[3]]$type
#> [1] "do"
#> 
#> $numeratorRelations[[3]]$criteria
#> NULL
#> 
#> 
#> $numeratorRelations[[4]]
#> $numeratorRelations[[4]]$A
#> [1] "D27"
#> 
#> $numeratorRelations[[4]]$B
#> [1] "D16"
#> 
#> $numeratorRelations[[4]]$code
#> [1] "R3"
#> 
#> $numeratorRelations[[4]]$name
#> [1] "PLHIV in care to PLHIV on ART"
#> 
#> $numeratorRelations[[4]]$type
#> [1] "eq"
#> 
#> $numeratorRelations[[4]]$criteria
#> [1] 10
#> 
#> 
#> $numeratorRelations[[5]]
#> $numeratorRelations[[5]]$A
#> [1] "D5"
#> 
#> $numeratorRelations[[5]]$B
#> [1] "D37"
#> 
#> $numeratorRelations[[5]]$code
#> [1] "R5"
#> 
#> $numeratorRelations[[5]]$name
#> [1] "TB cases notified to TB cases registered for treatment"
#> 
#> $numeratorRelations[[5]]$type
#> [1] "eq"
#> 
#> $numeratorRelations[[5]]$criteria
#> [1] 10
#> 
#> 
#> $numeratorRelations[[6]]
#> $numeratorRelations[[6]]$A
#> [1] "D8"
#> 
#> $numeratorRelations[[6]]$B
#> [1] "D41"
#> 
#> $numeratorRelations[[6]]$code
#> [1] "R6"
#> 
#> $numeratorRelations[[6]]$name
#> [1] "Confirmed malaria cases to confirmed malaria cases treated"
#> 
#> $numeratorRelations[[6]]$type
#> [1] "eq"
#> 
#> $numeratorRelations[[6]]$criteria
#> [1] 10
#> 
#> 
#> $numeratorRelations[[7]]
#> $numeratorRelations[[7]]$A
#> [1] "D35"
#> 
#> $numeratorRelations[[7]]$B
#> [1] "D9"
#> 
#> $numeratorRelations[[7]]$code
#> [1] "R7"
#> 
#> $numeratorRelations[[7]]$name
#> [1] "Malaria cases tested to malaria cases treated"
#> 
#> $numeratorRelations[[7]]$type
#> [1] "eq"
#> 
#> $numeratorRelations[[7]]$criteria
#> [1] 10
#> 
#> 
#> 
#> $denominatorRelations
#> $denominatorRelations[[1]]
#> $denominatorRelations[[1]]$A
#> [1] "P5"
#> 
#> $denominatorRelations[[1]]$B
#> [1] "P1"
#> 
#> $denominatorRelations[[1]]$code
#> [1] "PR1"
#> 
#> $denominatorRelations[[1]]$name
#> [1] "Total population - census to UN projection"
#> 
#> $denominatorRelations[[1]]$type
#> [1] "un"
#> 
#> $denominatorRelations[[1]]$criteria
#> [1] 10
#> 
#> 
#> 
```
