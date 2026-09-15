#' Get Organisation Unit Geographic Features
#'
#' @description
#' `r lifecycle::badge("experimental")`
#' `get_geo_features()` retrieves the geographic features (coordinates/
#' boundaries) of organisation units from the `geoFeatures` endpoint —
#' useful for mapping. Confirmed live against a public DHIS2 demo instance.
#'
#' @param org_units A vector of organisation unit ids, or a DHIS2 org-unit
#'   keyword such as `'LEVEL-2'` or `'USER_ORGUNIT'`.
#' @param ... Other query parameters supported by your DHIS2 instance's
#'   `geoFeatures` endpoint.
#' @param retry Number of times to retry the API call in case of failure
#'   (defaults to 2).
#' @param verbosity Level of HTTP information to print during the call.
#' @param timeout Maximum number of seconds to wait for the API response.
#' @param auth Optional. The authentication object.
#' @param call The caller environment.
#'
#' @details
#' Confirmed live that `org_units` must be sent as a `ou:`-prefixed
#' dimension value (e.g. `ou:LEVEL-2` or `ou:<uid1>;<uid2>`) — a bare
#' comma/semicolon-separated list of ids, without the `ou:` prefix, is
#' rejected. A `dimensions` field in the raw response (category-dimension
#' filters applied to the query; empty in every case tested) is dropped
#' before returning, since an empty list-column in every row otherwise
#' collapses the whole result to 0 rows.
#'
#' @return A tibble with one row per organisation unit: `id`, `name`, `code`,
#'   `level`, `type` (point or polygon), `parent_id`, `parent_name`,
#'   `parent_graph`, `coordinates` (a GeoJSON-style coordinate string),
#'   `has_coordinates_down`, and `has_coordinates_up`. `NULL` if none were
#'   found.
#'
#' @export
#'
#' @examplesIf khis_has_cred()
#'
#' get_geo_features(org_units = 'LEVEL-2')

get_geo_features <- function(org_units, ..., retry = 2, verbosity = 0,
                             timeout = 60, auth = NULL, call = caller_env()) {

    check_string_vector(org_units, call = call)

    response <- tryCatch({
        api_get(
            endpoint = 'geoFeatures',
            ou = str_c('ou:', str_c(org_units, collapse = ';')),
            ...,
            retry = retry,
            verbosity = verbosity,
            timeout = timeout,
            auth = auth,
            call = call
        )
    }, error = function(e) {
        khis_warn(c('x' = 'Error retrieving geographic features:', 'i' = conditionMessage(e)), call = call)
        return(NULL)
    })

    if (is_empty(response)) {
        khis_warn(c('!' = 'No geographic features found for the specified query.'), call = call)
        return(NULL)
    }

    response <- map(response, ~ .x[setdiff(names(.x), 'dimensions')])

    bind_rows(response) %>%
        rename(
            name = "na",
            level = "le",
            type = "ty",
            parent_id = "pi",
            parent_name = "pn",
            parent_graph = "pg",
            coordinates = "co",
            has_coordinates_down = "hcd",
            has_coordinates_up = "hcu"
        ) %>%
        relocate("id", "name")
}
