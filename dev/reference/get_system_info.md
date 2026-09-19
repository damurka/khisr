# Get DHIS2 Instance System Information

**\[experimental\]** `get_system_info()` retrieves information about the
connected DHIS2 instance itself — version, revision, build time, server
date/time zone, and similar — from the `system/info` endpoint. Useful
for checking compatibility before relying on version-specific behaviour.

## Usage

``` r
get_system_info(auth = NULL, call = caller_env())
```

## Arguments

- auth:

  Optional. The authentication object.

- call:

  The caller environment.

## Value

A named list of system information fields (e.g. `version`, `revision`,
`buildTime`, `serverDate`, `contextPath`), as returned by DHIS2.
Confirmed live against a public DHIS2 demo instance.

## See also

[`khis_api_version()`](https://khisr.damurka.com/dev/reference/khis_api_version.md)
for the API version pinned on the current credentials.

## Examples

``` r

get_system_info()
#> $contextPath
#> [1] "https://demos.dhis2.org/hmis"
#> 
#> $userAgent
#> [1] "khisr/1.0.8.9000 (https://khisr.damurka.com)"
#> 
#> $calendar
#> [1] "iso8601"
#> 
#> $dateFormat
#> [1] "yyyy-mm-dd"
#> 
#> $serverDate
#> [1] "2026-09-19T13:03:05.305"
#> 
#> $serverTimeZoneId
#> [1] "Europe/Berlin"
#> 
#> $serverTimeZoneDisplayName
#> [1] "Central European Standard Time"
#> 
#> $lastAnalyticsTableSuccess
#> [1] "2026-09-19T02:00:00.094"
#> 
#> $intervalSinceLastAnalyticsTableSuccess
#> [1] "11 h, 3 m, 5 s"
#> 
#> $lastAnalyticsTableRuntime
#> [1] "01:00:40.059"
#> 
#> $databaseInfo
#> $databaseInfo$spatialSupport
#> [1] TRUE
#> 
#> $databaseInfo$time
#> [1] "2026-09-19T13:03:05.305"
#> 
#> 
#> $version
#> [1] "2.41.7"
#> 
#> $revision
#> [1] "6f7e169"
#> 
#> $buildTime
#> [1] "2025-12-15T15:10:10.000"
#> 
#> $encryption
#> [1] FALSE
#> 
#> $emailConfigured
#> [1] TRUE
#> 
#> $redisEnabled
#> [1] FALSE
#> 
#> $systemId
#> [1] "d581d0e5-998d-4f64-9435-37fb00f209e7"
#> 
#> $systemName
#> [1] "DHIS 2"
#> 
#> $instanceBaseUrl
#> [1] "https://demos.dhis2.org/hmis"
#> 
#> $isMetadataVersionEnabled
#> [1] FALSE
#> 
```
