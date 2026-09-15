#' Get Aggregated (Pivot-Style) Enrollment Analytics from DHIS2
#'
#' @description
#' `r lifecycle::badge("experimental")`
#' `get_enrollment_analytics_aggregate()` retrieves totals over Tracker
#' enrollments from DHIS2's `analytics/enrollments/aggregate/{program}`
#' endpoint. This is a genuinely different endpoint from
#' [get_enrollment_analytics()]'s `analytics/enrollments/query/{program}`:
#' `query` returns line-list style rows, while `aggregate` returns
#' pivot-table style totals.
#'
#' @param program A program id. Used as a URL path segment, not a query
#'   parameter.
#' @param ... One or more [analytics_dimension()] parameters (e.g. `ou`/`pe`
#'   dimensions via `%.d%`/`%.f%`), and/or other query parameters supported
#'   by your DHIS2 instance's Tracker analytics aggregate API.
#' @param return_type Optional. `'uid'` (default) or `'name'` for the
#'   identifier scheme used in the response.
#' @param retry Number of times to retry the API call in case of failure
#'   (defaults to 2).
#' @param verbosity Level of HTTP information to print during the call.
#' @param timeout Maximum number of seconds to wait for the API response.
#' @param auth Optional. The authentication object.
#' @param call The caller environment.
#'
#' @details
#' The response shares the same `headers`/`rows` shape as [get_analytics()].
#' Confirmed live to be unpaginated, like [get_event_analytics_aggregate()].
#'
#' @return A tibble of aggregated enrollment totals, or `NULL` if none was
#'   retrieved.
#'
#' @export
#'
#' @seealso [get_enrollment_analytics()] for the line-list `query`
#'   equivalent, [get_event_analytics_aggregate()] for the event equivalent.
#'
#' @examplesIf khis_has_cred()
#'
#' get_enrollment_analytics_aggregate(program = 'PREnRHSp3be',
#'                                    ou %.d% 'USER_ORGUNIT',
#'                                    pe %.d% 'LAST_12_MONTHS')

get_enrollment_analytics_aggregate <- function(program,
                                               ...,
                                               return_type = c('uid', 'name'),
                                               retry = 2,
                                               verbosity = 0,
                                               timeout = 60,
                                               auth = NULL,
                                               call = caller_env()) {

    check_scalar_character(program, call = call)
    return_type <- str_to_upper(arg_match(return_type))

    response <- api_get(
        str_c('analytics/enrollments/aggregate/', program),
        ...,
        outputIdScheme = return_type,
        retry = retry,
        verbosity = verbosity,
        timeout = timeout,
        auth = auth,
        call = call
    )

    parse_analytics_rows(response$headers, response$rows)
}
