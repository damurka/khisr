#' Get Aggregated (Pivot-Style) Event Analytics from DHIS2
#'
#' @description
#' `r lifecycle::badge("experimental")`
#' `get_event_analytics_aggregate()` retrieves totals over Tracker events
#' from DHIS2's `analytics/events/aggregate/{program}` endpoint. This is a
#' genuinely different endpoint from [get_event_analytics()]'s
#' `analytics/events/query/{program}`: `query` returns line-list style rows
#' (one row per matched dimension combination, event-count driven), while
#' `aggregate` returns pivot-table style totals, and supports a `stage`
#' parameter to scope to one program stage.
#'
#' @param program A program id. Used as a URL path segment, not a query
#'   parameter.
#' @param stage Optional. A program stage id to scope the query to.
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
#' Unlike [get_event_analytics()]'s `query` endpoint, this endpoint is
#' confirmed live to be unpaginated (no `metaData.pager`, like
#' `/api/analytics` itself) — it returns the full result set in one request.
#'
#' @return A tibble of aggregated event totals, or `NULL` if none was
#'   retrieved.
#'
#' @export
#'
#' @seealso [get_event_analytics()] for the line-list `query` equivalent,
#'   [get_enrollment_analytics_aggregate()] for the enrollment equivalent.
#'
#' @examplesIf khis_has_cred()
#'
#' get_event_analytics_aggregate(program = 'PREnRHSp3be',
#'                               stage = 'mj1stImcUCi',
#'                               ou %.d% 'USER_ORGUNIT',
#'                               pe %.d% 'LAST_12_MONTHS')

get_event_analytics_aggregate <- function(program,
                                          stage = NULL,
                                          ...,
                                          return_type = c('uid', 'name'),
                                          retry = 2,
                                          verbosity = 0,
                                          timeout = 60,
                                          auth = NULL,
                                          call = caller_env()) {

    check_scalar_character(program, call = call)
    if (!is.null(stage)) check_scalar_character(stage, call = call)
    return_type <- str_to_upper(arg_match(return_type))

    response <- api_get(
        str_c('analytics/events/aggregate/', program),
        stage = stage,
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
