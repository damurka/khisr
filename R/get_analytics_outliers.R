#' Get Statistical Outliers from DHIS2 Analytics
#'
#' @description
#' `r lifecycle::badge("experimental")`
#' `get_analytics_outliers()` retrieves data values flagged as statistical
#' outliers by DHIS2's `analytics/outlierDetection` endpoint — useful for
#' data-quality review.
#'
#' @param data_elements Optional. A vector of data element ids to check.
#'   Provide this or `data_sets`.
#' @param data_sets Optional. A vector of data set ids to check. Provide
#'   this or `data_elements`.
#' @param org_units A vector of organisation unit ids to scope the query to.
#' @param start_date,end_date ISO-8601 dates bounding the query.
#' @param algorithm Optional. The detection algorithm: `'Z_SCORE'` (default),
#'   `'MOD_Z_SCORE'`, or `'MIN_MAX'`.
#' @param threshold Optional. The sensitivity threshold for the chosen
#'   algorithm; higher values flag fewer outliers.
#' @param ... Other query parameters supported by your DHIS2 instance's
#'   `analytics/outlierDetection` endpoint (e.g. `maxResults`, `orderBy`).
#' @param retry Number of times to retry the API call in case of failure
#'   (defaults to 2).
#' @param verbosity Level of HTTP information to print during the call.
#' @param timeout Maximum number of seconds to wait for the API response.
#' @param auth Optional. The authentication object.
#' @param call The caller environment.
#'
#' @details
#' Requires either `data_elements` or `data_sets`. **Unlike the rest of this
#' package, this endpoint's response shape has not been independently
#' verified live**: the public demo instance used to verify khisr's other
#' Tracker/analytics functions returned `403 Forbidden` for this endpoint
#' regardless of parameters, which appears to be an account-authority
#' restriction rather than a request error. The field names below follow
#' DHIS2's published API documentation; confirm them against your own
#' instance before relying on this function in production.
#'
#' @return A tibble of outlier values as returned by DHIS2 (typically
#'   including the data element, org unit, period, value, and statistical
#'   bounds that flagged it), or `NULL` if none were found.
#'
#' @export
#'
#' @seealso [get_analytics()] for the underlying aggregated values.
#'
#' @examplesIf khis_has_cred()
#'
#' \dontrun{
#' get_analytics_outliers(data_elements = 'lYsfXxCw6Qi',
#'                        org_units = 'W6sNfkJcXGC',
#'                        start_date = '2023-01-01',
#'                        end_date = '2023-12-31')
#' }

get_analytics_outliers <- function(data_elements = NULL,
                                   data_sets = NULL,
                                   org_units,
                                   start_date,
                                   end_date,
                                   algorithm = NULL,
                                   threshold = NULL,
                                   ...,
                                   retry = 2,
                                   verbosity = 0,
                                   timeout = 60,
                                   auth = NULL,
                                   call = caller_env()) {

    if (!is.null(data_elements)) check_string_vector(data_elements, call = call)
    if (!is.null(data_sets)) check_string_vector(data_sets, call = call)
    if (is.null(data_elements) && is.null(data_sets)) {
        khis_abort(
            message = c(
                'x' = 'Missing data scope',
                '!' = 'Provide either {.arg data_elements} or {.arg data_sets}.'
            ),
            call = call
        )
    }
    check_string_vector(org_units, call = call)
    check_scalar_character(start_date, call = call)
    check_scalar_character(end_date, call = call)
    if (!is.null(algorithm)) {
        algorithm <- arg_match(algorithm, c('Z_SCORE', 'MOD_Z_SCORE', 'MIN_MAX'))
    }

    response <- tryCatch({
        api_get(
            endpoint = 'analytics/outlierDetection',
            de = data_elements,
            ds = data_sets,
            ou = org_units,
            startDate = start_date,
            endDate = end_date,
            algorithm = algorithm,
            threshold = threshold,
            ...,
            retry = retry,
            verbosity = verbosity,
            timeout = timeout,
            auth = auth,
            call = call
        )
    }, error = function(e) {
        khis_warn(c('x' = 'Error retrieving outlier data:', 'i' = conditionMessage(e)), call = call)
        return(NULL)
    })

    if (is.null(response) || is_empty(response$outlierValues)) {
        khis_warn(c('!' = 'No outliers found for the specified query.'), call = call)
        return(NULL)
    }

    bind_rows(response$outlierValues)
}
