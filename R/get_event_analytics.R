#' Retrieves Aggregated Event Analytics Data from DHIS2
#'
#' @description
#' `r lifecycle::badge("experimental")`
#' `get_event_analytics()` retrieves aggregated, dimensional analytics over
#' Tracker events from DHIS2's `analytics/events/query/{program}` endpoint —
#' as opposed to [get_events()], which returns raw individual event records
#' from the Tracker API. Use this when you want counts/aggregates across
#' dimensions (e.g. events by org unit and period), not the underlying
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
#' The response shares the same `headers`/`rows` shape as [get_analytics()],
#' confirmed live against a public DHIS2 demo instance. Pagination is
#' automatic, but confirmed live to work differently from every other
#' paginated function in this package: without an explicit page size, this
#' endpoint silently returns only the first 50 rows, with no error or
#' warning — a real risk if you call the underlying DHIS2 endpoint directly
#' instead of through this function.
#'
#' @return A tibble of aggregated event analytics data, or `NULL` if none
#'   was retrieved.
#'
#' @export
#'
#' @seealso [get_events()] for raw individual event records,
#'   [get_enrollment_analytics()] for the enrollment equivalent,
#'   [get_analytics()] for aggregate (non-Tracker) analytics.
#'
#' @examplesIf khis_has_cred()
#'
#' # Events for a program, by org unit, over the last year
#' get_event_analytics(program = 'IpHINAT79UW',
#'                     ou %.d% 'USER_ORGUNIT',
#'                     pe %.d% 'LAST_YEAR')

get_event_analytics <- function(program,
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
        'events',
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
