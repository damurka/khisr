#' Get Raw Data Set Completeness Registrations from a DHIS2 Instance
#'
#' @description
#' `r lifecycle::badge("experimental")`
#' `get_complete_data_set_registrations()` retrieves the raw
#' completeness-registration records (who marked a data set complete, and
#' when) from DHIS2's `completeDataSetRegistrations` endpoint — the raw
#' counterpart to [get_data_sets_by_level()]'s aggregated reporting-rate
#' view, the same way [get_data_value_sets()] complements [get_analytics()].
#'
#' @param data_sets A vector of data set ids to scope the query to.
#' @param org_units A vector of organisation unit ids to scope the query to.
#' @param children Optional. If `TRUE`, also includes registrations for the
#'   descendants of `org_units`, not just `org_units` itself. DHIS2 defaults
#'   to `FALSE` (exact org units only) when not set.
#' @param periods A vector of ISO period strings (e.g. `'202501'`).
#' @param ... Other query parameters supported by your DHIS2 instance's
#'   `completeDataSetRegistrations` endpoint.
#' @param retry Number of times to retry the API call in case of failure
#'   (defaults to 2).
#' @param verbosity Level of HTTP information to print during the call.
#' @param timeout Maximum number of seconds to wait for the API response.
#' @param auth Optional. The authentication object.
#' @param call The caller environment.
#'
#' @details
#' Like `dataValueSets`, this endpoint is not paginated — it returns the
#' full matching result set in a single response. Confirmed live against a
#' public DHIS2 demo instance.
#'
#' @return A tibble of registrations (`period`, `dataSet`,
#'   `organisationUnit`, `attributeOptionCombo`, `date`, `storedBy`,
#'   `completed`), or `NULL` if none were found.
#'
#' @export
#'
#' @seealso [get_data_sets_by_level()] for aggregated reporting-rate metrics,
#'   [get_data_value_sets()] for the raw data-value equivalent.
#'
#' @examplesIf khis_has_cred()
#'
#' get_complete_data_set_registrations(data_sets = 'VEM58nY22sO',
#'                                     org_units = 'W6sNfkJcXGC',
#'                                     children = TRUE,
#'                                     periods = '202301')

get_complete_data_set_registrations <- function(data_sets,
                                                org_units,
                                                children = NULL,
                                                periods,
                                                ...,
                                                retry = 2,
                                                verbosity = 0,
                                                timeout = 60,
                                                auth = NULL,
                                                call = caller_env()) {

    check_string_vector(data_sets, call = call)
    check_string_vector(org_units, call = call)
    check_string_vector(periods, call = call)
    if (!is.null(children)) stopifnot(is.logical(children), length(children) == 1)

    response <- tryCatch({
        api_get(
            endpoint = 'completeDataSetRegistrations',
            dataSet = data_sets,
            orgUnit = org_units,
            children = children,
            period = periods,
            ...,
            retry = retry,
            verbosity = verbosity,
            timeout = timeout,
            auth = auth,
            call = call
        )
    }, error = function(e) {
        khis_warn(c('x' = 'Error retrieving completeness registrations:', 'i' = conditionMessage(e)), call = call)
        return(NULL)
    })

    if (is.null(response) || is_empty(response$completeDataSetRegistrations)) {
        khis_warn(c('!' = 'No completeness registrations found for the specified query.'), call = call)
        return(NULL)
    }

    bind_rows(response$completeDataSetRegistrations)
}
