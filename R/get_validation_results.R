#' Get Validation Rule Results from DHIS2
#'
#' @description
#' `r lifecycle::badge("experimental")`
#' `get_validation_results()` retrieves violated validation rules for an
#' organisation unit and period range from DHIS2's `validationResults`
#' endpoint — useful for data-quality review.
#'
#' @param org_units A vector of organisation unit ids to scope the query to.
#' @param start_date,end_date ISO-8601 dates bounding the query.
#' @param ... Other query parameters supported by your DHIS2 instance's
#'   `validationResults` endpoint (e.g. `vrg` to scope to a validation rule
#'   group).
#' @param retry Number of times to retry the API call in case of failure
#'   (defaults to 2).
#' @param verbosity Level of HTTP information to print during the call.
#' @param timeout Maximum number of seconds to wait for the API response.
#' @param auth Optional. The authentication object.
#' @param call The caller environment.
#'
#' @details
#' Confirmed live against a public DHIS2 demo instance that this endpoint
#' (`/api/validationResults`, not `/api/analytics/validationResults`, which
#' 404s) accepts these parameters and returns a valid, empty result —
#' the instance tested had no stored validation violations for the org units
#' and periods tried, so the shape of a populated result is not
#' independently verified.
#'
#' @return A tibble of validation results (organisation unit, period,
#'   validation rule, and the left/right side values that violated it), or
#'   `NULL` if none were found.
#'
#' @export
#'
#' @examplesIf khis_has_cred()
#'
#' get_validation_results(org_units = 'IWp9dQGM0bS',
#'                        start_date = '2023-01-01',
#'                        end_date = '2023-12-31')

get_validation_results <- function(org_units,
                                   start_date,
                                   end_date,
                                   ...,
                                   retry = 2,
                                   verbosity = 0,
                                   timeout = 60,
                                   auth = NULL,
                                   call = caller_env()) {

    check_string_vector(org_units, call = call)
    check_scalar_character(start_date, call = call)
    check_scalar_character(end_date, call = call)

    response <- tryCatch({
        api_get(
            endpoint = 'validationResults',
            ou = org_units,
            startDate = start_date,
            endDate = end_date,
            ...,
            retry = retry,
            verbosity = verbosity,
            timeout = timeout,
            auth = auth,
            call = call
        )
    }, error = function(e) {
        khis_warn(c('x' = 'Error retrieving validation results:', 'i' = conditionMessage(e)), call = call)
        return(NULL)
    })

    if (is.null(response) || is_empty(response$validationResults)) {
        khis_warn(c('!' = 'No validation results found for the specified query.'), call = call)
        return(NULL)
    }

    bind_rows(response$validationResults)
}
