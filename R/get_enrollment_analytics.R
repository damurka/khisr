#' Retrieves Aggregated Enrollment Analytics Data from DHIS2
#'
#' @description
#' `r lifecycle::badge("experimental")`
#' `get_enrollment_analytics()` retrieves aggregated, dimensional analytics
#' over Tracker enrollments from DHIS2's
#' `analytics/enrollments/query/{program}` endpoint — as opposed to
#' [get_enrollments()], which returns raw individual enrollment records from
#' the Tracker API. Use this when you want counts/aggregates across
#' dimensions (e.g. enrollments by org unit and period), not the underlying
#' records themselves.
#'
#' @param program A program id. Used as a URL path segment, not a query
#'   parameter.
#' @param ... One or more [analytics_dimension()] parameters (e.g. `ou`/`pe`
#'   dimensions via `%.d%`/`%.f%`), and/or other query parameters supported
#'   by your DHIS2 instance's Tracker analytics query API.
#' @param return_type Optional. `'uid'` (default) or `'name'` for the
#'   identifier scheme used in the response.
#' @param page_size Number of records to request per page (default 1000).
#' @param retry Number of times to retry the API call in case of failure
#'   (defaults to 2).
#' @param verbosity Level of HTTP information to print during the call.
#' @param timeout Maximum number of seconds to wait for the API response.
#' @param auth Optional. The authentication object.
#' @param call The caller environment.
#'
#' @details
#' The response shares the same `headers`/`rows` shape as [get_analytics()].
#' Pagination is automatic; see [get_event_analytics()]'s details for a note
#' on this endpoint family's pagination behaviour (a different, silently
#' truncating shape confirmed live against a public DHIS2 demo instance for
#' the `events` variant, which this function shares the same underlying
#' engine with).
#'
#' @return A tibble of aggregated enrollment analytics data, or `NULL` if
#'   none was retrieved.
#'
#' @export
#'
#' @seealso [get_enrollments()] for raw individual enrollment records,
#'   [get_event_analytics()] for the event equivalent, [get_analytics()] for
#'   aggregate (non-Tracker) analytics.
#'
#' @examplesIf khis_has_cred()
#'
#' # Enrollments for a program, by org unit, over the last year
#' get_enrollment_analytics(program = 'IpHINAT79UW',
#'                          ou %.d% 'USER_ORGUNIT',
#'                          pe %.d% 'LAST_YEAR')

get_enrollment_analytics <- function(program,
                                     ...,
                                     return_type = c('uid', 'name'),
                                     page_size = 1000,
                                     retry = 2,
                                     verbosity = 0,
                                     timeout = 60,
                                     auth = NULL,
                                     call = caller_env()) {

    check_scalar_character(program, call = call)

    fetch_analytics_query(
        'enrollments',
        program,
        ...,
        return_type = return_type,
        page_size = page_size,
        retry = retry,
        verbosity = verbosity,
        timeout = timeout,
        auth = auth,
        call = call
    )
}
