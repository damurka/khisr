#' Get Events from a DHIS2 Instance
#'
#' @description
#' `r lifecycle::badge("experimental")`
#' `get_events()` retrieves tracker program-stage events from the DHIS2
#' Tracker API.
#'
#' @param program Optional. A program id to scope the query to.
#' @param program_stage Optional. A program stage id to scope the query to.
#' @param org_units Optional. A vector of organisation unit ids to scope the
#'   query to.
#' @param org_unit_mode Optional. One of `"SELECTED"`, `"CHILDREN"`,
#'   `"DESCENDANTS"`, `"ACCESSIBLE"`, `"CAPTURE"`, `"ALL"`, controlling how
#'   `org_units` is interpreted. DHIS2 defaults to `"ACCESSIBLE"` when
#'   `org_units` is not provided, and `"SELECTED"` when it is.
#' @param updated_after,updated_before Optional. ISO-8601 date or datetime
#'   strings bounding the event's last-updated timestamp.
#' @param occurred_after,occurred_before Optional. ISO-8601 date or datetime
#'   strings bounding the event's occurred date.
#' @param ... Other query parameters supported by your DHIS2 instance's
#'   Tracker API (e.g. `status`, `assignedUserMode`).
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
#' DHIS2 requires an events query to be scoped by at least one of `program`,
#' `program_stage`, or `org_units`; an unscoped query will be rejected by the
#' server.
#'
#' DHIS2's published Tracker API documentation does not describe a supported
#' way to filter events by data element value (unlike [get_tracked_entities()],
#' which supports attribute filtering via [tracked_entity_filter()]), so a
#' `filter` argument raises an error here rather than being silently sent as
#' an unsupported query parameter. Retrieve the broader event set and filter
#' client-side instead. `dataValues` is returned as a list-column — use
#' [tidyr::unnest_wider()]/[tidyr::unnest_longer()] to flatten it further.
#'
#' @return A tibble of events, or `NULL` if none were found.
#'
#' @family tracker functions
#'
#' @export
#'
#' @seealso [get_tracked_entities()], [get_enrollments()]
#'
#' @examplesIf khis_has_cred()
#'
#' # All events for a program stage at a given org unit
#' get_events(program_stage = 'A03MvHHogjR',
#'            org_units = 'DiszpKrYNg8',
#'            org_unit_mode = 'DESCENDANTS')

get_events <- function(program = NULL,
                       program_stage = NULL,
                       org_units = NULL,
                       org_unit_mode = NULL,
                       updated_after = NULL,
                       updated_before = NULL,
                       occurred_after = NULL,
                       occurred_before = NULL,
                       ...,
                       fields = c('event', 'program', 'programStage', 'orgUnit',
                                 'status', 'occurredAt', 'scheduledAt', 'dataValues'),
                       page_size = 500,
                       retry = 2,
                       verbosity = 0,
                       timeout = 60,
                       auth = NULL,
                       call = caller_env()) {

    if (!is.null(program)) check_scalar_character(program, call = call)
    if (!is.null(program_stage)) check_scalar_character(program_stage, call = call)
    if (!is.null(org_units)) check_string_vector(org_units, call = call)
    if (!is.null(org_unit_mode)) {
        org_unit_mode <- arg_match(
            org_unit_mode,
            c('SELECTED', 'CHILDREN', 'DESCENDANTS', 'ACCESSIBLE', 'CAPTURE', 'ALL')
        )
    }
    for (date_arg in list(updated_after, updated_before, occurred_after, occurred_before)) {
        if (!is.null(date_arg)) check_scalar_character(date_arg, call = call)
    }
    reject_tracker_filter(list2(...), fn = 'get_events', call = call)

    fetch_tracker_records(
        'events',
        program = program,
        programStage = program_stage,
        orgUnits = if (!is.null(org_units)) str_c(org_units, collapse = ',') else NULL,
        orgUnitMode = org_unit_mode,
        updatedAfter = updated_after,
        updatedBefore = updated_before,
        eventOccurredAfter = occurred_after,
        eventOccurredBefore = occurred_before,
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
