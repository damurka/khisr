#' Get Enrollments from a DHIS2 Instance
#'
#' @description
#' `r lifecycle::badge("experimental")`
#' `get_enrollments()` retrieves program enrollments from the DHIS2 Tracker
#' API.
#'
#' @param program Optional. A program id to scope the query to.
#' @param org_units Optional. A vector of organisation unit ids to scope the
#'   query to.
#' @param org_unit_mode Optional. One of `"SELECTED"`, `"CHILDREN"`,
#'   `"DESCENDANTS"`, `"ACCESSIBLE"`, `"CAPTURE"`, `"ALL"`, controlling how
#'   `org_units` is interpreted. DHIS2 defaults to `"ACCESSIBLE"` when
#'   `org_units` is not provided, and `"SELECTED"` when it is.
#' @param updated_after,updated_before Optional. ISO-8601 date or datetime
#'   strings bounding the enrollment's last-updated timestamp.
#' @param enrolled_after,enrolled_before Optional. ISO-8601 date or datetime
#'   strings bounding the enrollment date (sent as the unprefixed
#'   `enrolledAfter`/`enrolledBefore` query params — the corresponding
#'   [get_tracked_entities()] arguments use `enrollmentEnrolledAfter`/
#'   `enrollmentEnrolledBefore` instead, to disambiguate from a tracked
#'   entity's other nested dates).
#' @param occurred_after,occurred_before Optional. ISO-8601 date or datetime
#'   strings bounding the enrollment's incident/occurred date (sent as the
#'   unprefixed `occurredAfter`/`occurredBefore` query params — the
#'   corresponding [get_tracked_entities()] arguments use
#'   `enrollmentOccurredAfter`/`enrollmentOccurredBefore` instead).
#' @param ... Other query parameters supported by your DHIS2 instance's
#'   Tracker API (e.g. `status`).
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
#' DHIS2 requires an enrollments query to be scoped by at least one of
#' `program` or `org_units`; an unscoped query will be rejected by the
#' server. DHIS2's Tracker API does not document filter support for this
#' endpoint, so a `filter` argument raises an error rather than being
#' silently sent as an unsupported query parameter; use
#' [get_tracked_entities()] with [tracked_entity_filter()] to filter by
#' attribute value instead.
#'
#' The `enrolledAfter`/`enrolledBefore`/`occurredAfter`/`occurredBefore`
#' query parameter names used here (unprefixed, unlike the equivalent
#' [get_tracked_entities()] arguments) are based on the best available
#' documentation and usage examples rather than a directly confirmed
#' parameter table for this specific endpoint — verify against your own
#' instance if these filters don't behave as expected.
#'
#' @return A tibble of enrollments, or `NULL` if none were found.
#'
#' @family tracker functions
#'
#' @export
#'
#' @seealso [get_tracked_entities()], [get_events()]
#'
#' @examplesIf khis_has_cred()
#'
#' # All enrollments in a program at a given org unit
#' get_enrollments(program = 'IpHINAT79UW',
#'                 org_units = 'DiszpKrYNg8',
#'                 org_unit_mode = 'DESCENDANTS')

get_enrollments <- function(program = NULL,
                            org_units = NULL,
                            org_unit_mode = NULL,
                            updated_after = NULL,
                            updated_before = NULL,
                            enrolled_after = NULL,
                            enrolled_before = NULL,
                            occurred_after = NULL,
                            occurred_before = NULL,
                            ...,
                            fields = c('enrollment', 'program', 'trackedEntity', 'orgUnit',
                                      'status', 'enrolledAt', 'occurredAt'),
                            page_size = 500,
                            retry = 2,
                            verbosity = 0,
                            timeout = 60,
                            auth = NULL,
                            call = caller_env()) {

    if (!is.null(program)) check_scalar_character(program, call = call)
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
    reject_tracker_filter(list2(...), fn = 'get_enrollments', call = call)

    fetch_tracker_records(
        'enrollments',
        program = program,
        orgUnits = if (!is.null(org_units)) str_c(org_units, collapse = ',') else NULL,
        orgUnitMode = org_unit_mode,
        updatedAfter = updated_after,
        updatedBefore = updated_before,
        enrolledAfter = enrolled_after,
        enrolledBefore = enrolled_before,
        occurredAfter = occurred_after,
        occurredBefore = occurred_before,
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
