#' Get Relationships from a DHIS2 Instance
#'
#' @description
#' `r lifecycle::badge("experimental")`
#' `get_relationships()` retrieves Tracker relationships — links between two
#' tracker objects (tracked entities, enrollments, or events), such as an
#' index case and a household contact — from DHIS2's Tracker API.
#'
#' @param tracked_entity,enrollment,event Exactly one of these three must be
#'   provided: a tracked entity, enrollment, or event id to retrieve
#'   relationships for.
#' @param ... Other query parameters supported by your DHIS2 instance's
#'   Tracker API.
#' @param fields The DHIS2 field-selector for the columns to return.
#' @param page_size Number of records to request per page (default 500).
#' @param retry Number of times to retry the API call in case of failure
#'   (defaults to 2).
#' @param verbosity Level of HTTP information to print during the call.
#' @param timeout Maximum number of seconds to wait for the DHIS2 API
#'   response.
#' @param auth Optional. The authentication object.
#' @param call The caller environment.
#'
#' @details
#' DHIS2 requires a relationships query to be scoped by exactly one of
#' `tracked_entity`, `enrollment`, or `event` — confirmed live against a
#' public DHIS2 demo instance, where omitting all three returns the exact
#' error `"Missing required parameter 'trackedEntity', 'enrollment' or
#' 'event'."`. Pagination (nested `pager`, same as [get_tracked_entities()]/
#' [get_events()]/[get_enrollments()]) was also confirmed live, but the demo
#' instance tested had no relationship data configured on any program, so
#' the shape of a populated relationship's `from`/`to` fields is not
#' independently verified here — inspect the result and adjust `fields` as
#' needed for your instance.
#'
#' @return A tibble of relationships, or `NULL` if none were found.
#'
#' @export
#'
#' @family tracker functions
#'
#' @seealso [get_tracked_entities()], [get_events()], [get_enrollments()]
#'
#' @examplesIf khis_has_cred()
#'
#' # Relationships for a specific tracked entity
#' get_relationships(tracked_entity = 'qkU5JI6SQcd')

get_relationships <- function(tracked_entity = NULL,
                              enrollment = NULL,
                              event = NULL,
                              ...,
                              fields = c('relationship', 'relationshipType', 'from', 'to', 'createdAt'),
                              page_size = 500,
                              retry = 2,
                              verbosity = 0,
                              timeout = 60,
                              auth = NULL,
                              call = caller_env()) {

    scope <- list(tracked_entity, enrollment, event)
    n_provided <- sum(!vapply(scope, is.null, logical(1)))
    if (n_provided != 1) {
        khis_abort(
            message = c(
                'x' = 'Invalid scope',
                '!' = 'Provide exactly one of {.arg tracked_entity}, {.arg enrollment}, or {.arg event}.'
            ),
            call = call
        )
    }
    if (!is.null(tracked_entity)) check_scalar_character(tracked_entity, call = call)
    if (!is.null(enrollment)) check_scalar_character(enrollment, call = call)
    if (!is.null(event)) check_scalar_character(event, call = call)

    fetch_tracker_records(
        'relationships',
        trackedEntity = tracked_entity,
        enrollment = enrollment,
        event = event,
        ...,
        fields = fields,
        page_size = page_size,
        retry = retry,
        verbosity = verbosity,
        timeout = timeout,
        auth = auth,
        call = call
    )
}
