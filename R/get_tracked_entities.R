#' Get Tracked Entities from a DHIS2 Instance
#'
#' @description
#' `r lifecycle::badge("experimental")`
#' `get_tracked_entities()` retrieves tracked entity instances (e.g. patients,
#' clients) from the DHIS2 Tracker API.
#'
#' @param program Optional. A program id to scope the query to.
#' @param tracked_entity_type Optional. A tracked entity type id to scope the
#'   query to.
#' @param tracked_entities Optional. A vector of specific tracked entity ids
#'   to retrieve.
#' @param org_units Optional. A vector of organisation unit ids to scope the
#'   query to.
#' @param org_unit_mode Optional. One of `"SELECTED"`, `"CHILDREN"`,
#'   `"DESCENDANTS"`, `"ACCESSIBLE"`, `"CAPTURE"`, `"ALL"`, controlling how
#'   `org_units` is interpreted. DHIS2 defaults to `"ACCESSIBLE"` when
#'   `org_units` is not provided, and `"SELECTED"` when it is.
#' @param updated_after,updated_before Optional. ISO-8601 date or datetime
#'   strings bounding the tracked entity's last-updated timestamp.
#' @param enrolled_after,enrolled_before Optional. ISO-8601 date or datetime
#'   strings bounding the tracked entity's enrollment date.
#' @param occurred_after,occurred_before Optional. ISO-8601 date or datetime
#'   strings bounding the tracked entity's enrollment incident/occurred date.
#' @param ... One or more [tracked_entity_filter()] attribute filters (or
#'   its infix operators, e.g. `w75KJ2mc4zz %.teq% 'John'`), and/or other
#'   query parameters supported by your DHIS2 instance's Tracker API.
#'   Build filters with [tracked_entity_filter()] and its own infix
#'   operators, not [metadata_filter()] or its infix operators (`%.eq%`,
#'   `%.in%`, etc.) — those target the DHIS2 metadata API's larger operator
#'   set and, for `in`/`!in`, a different value-joining convention; using
#'   them here raises an error rather than silently sending malformed
#'   filter syntax.
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
#' DHIS2 requires a tracked entities query to be scoped by at least one of
#' `program`, `tracked_entity_type`, `tracked_entities`, or `org_units`;
#' an unscoped query will be rejected by the server. Nested repeating data
#' (e.g. `attributes`, `enrollments`) is returned as a list-column — use
#' [tidyr::unnest_wider()]/[tidyr::unnest_longer()] to flatten it further.
#'
#' @return A tibble of tracked entities, or `NULL` if none were found.
#'
#' @family tracker functions
#'
#' @export
#'
#' @seealso [tracked_entity_filter()] for filtering on attribute values.
#'
#' @examplesIf khis_has_cred()
#'
#' # All tracked entities enrolled in a program at a given org unit
#' get_tracked_entities(program = 'PREnRHSp3be',
#'                      org_units = 'IWp9dQGM0bS',
#'                      org_unit_mode = 'DESCENDANTS')
#'
#' # Tracked entities whose attribute mTYYajEhlPY contains "John"
#' get_tracked_entities(program = 'PREnRHSp3be',
#'                      org_units = 'IWp9dQGM0bS',
#'                      tracked_entity_filter('mTYYajEhlPY', 'like', 'John'))

get_tracked_entities <- function(program = NULL,
                                 ...,
                                 tracked_entity_type = NULL,
                                 tracked_entities = NULL,
                                 org_units = NULL,
                                 org_unit_mode = NULL,
                                 updated_after = NULL,
                                 updated_before = NULL,
                                 enrolled_after = NULL,
                                 enrolled_before = NULL,
                                 occurred_after = NULL,
                                 occurred_before = NULL,
                                 fields = c('trackedEntity', 'trackedEntityType', 'orgUnit',
                                           'createdAt', 'updatedAt', 'inactive'),
                                 page_size = 500,
                                 retry = 2,
                                 verbosity = 0,
                                 timeout = 60,
                                 auth = NULL,
                                 call = caller_env()) {

    if (!is.null(program)) check_scalar_character(program, call = call)
    if (!is.null(tracked_entity_type)) check_scalar_character(tracked_entity_type, call = call)
    if (!is.null(tracked_entities)) check_string_vector(tracked_entities, call = call)
    if (!is.null(org_units)) check_string_vector(org_units, call = call)
    if (!is.null(org_unit_mode)) {
        org_unit_mode <- arg_match(
            org_unit_mode,
            c('SELECTED', 'CHILDREN', 'DESCENDANTS', 'ACCESSIBLE', 'CAPTURE', 'ALL')
        )
    }
    for (date_arg in list(updated_after, updated_before, enrolled_after,
                          enrolled_before, occurred_after, occurred_before)) {
        if (!is.null(date_arg)) check_scalar_character(date_arg, call = call)
    }
    check_tracker_filters(list2(...), call = call)

    fetch_tracker_records(
        'trackedEntities',
        program = program,
        trackedEntityType = tracked_entity_type,
        trackedEntities = if (!is.null(tracked_entities)) str_c(tracked_entities, collapse = ',') else NULL,
        orgUnits = if (!is.null(org_units)) str_c(org_units, collapse = ',') else NULL,
        orgUnitMode = org_unit_mode,
        updatedAfter = updated_after,
        updatedBefore = updated_before,
        enrollmentEnrolledAfter = enrolled_after,
        enrollmentEnrolledBefore = enrolled_before,
        enrollmentOccurredAfter = occurred_after,
        enrollmentOccurredBefore = occurred_before,
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
