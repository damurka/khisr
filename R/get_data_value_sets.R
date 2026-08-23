#' Get Raw Data Values from a DHIS2 Instance
#'
#' @description
#' `r lifecycle::badge("experimental")`
#' `get_data_value_sets()` retrieves individually entered aggregate data
#' values from DHIS2's `dataValueSets` endpoint — as opposed to
#' [get_analytics()], which returns pre-aggregated, computed values from the
#' analytics tables. Useful for data-quality auditing, or when you need the
#' raw entered values (including who entered them and when) rather than an
#' aggregated view.
#'
#' @param data_elements Optional. A vector of data element ids to scope the
#'   query to.
#' @param data_sets Optional. A vector of data set ids to scope the query to.
#' @param data_element_groups Optional. A vector of data element group ids
#'   to scope the query to.
#' @param org_units Optional. A vector of organisation unit ids to scope the
#'   query to.
#' @param org_unit_group Optional. An organisation unit group id to scope
#'   the query to.
#' @param children Optional. If `TRUE`, also includes data for the
#'   descendants of `org_units`, not just `org_units` itself. DHIS2 defaults
#'   to `FALSE` (exact org units only) when not set.
#' @param periods Optional. A vector of ISO period strings (e.g. `'202501'`).
#'   Required unless `start_date`/`end_date` are given instead.
#' @param start_date,end_date Optional. ISO-8601 dates bounding the query,
#'   as an alternative to `periods`.
#' @param last_updated Optional. ISO-8601 date or datetime string; only
#'   returns data values updated after this point.
#' @param id_scheme Optional. Remaps identifiers in the response (e.g.
#'   `'code'`) instead of the default DHIS2 UIDs.
#' @param ... Other query parameters supported by your DHIS2 instance's
#'   `dataValueSets` endpoint.
#' @param retry Number of times to retry the API call in case of failure
#'   (defaults to 2).
#' @param verbosity Level of HTTP information to print during the call.
#' @param timeout Maximum number of seconds to wait for the DHIS2 API
#'   response.
#' @param auth Optional. The authentication object.
#' @param call The caller environment.
#'
#' @details
#' DHIS2 requires this query to be scoped by at least one of `data_elements`,
#' `data_sets`, or `data_element_groups`; by at least one of `org_units` or
#' `org_unit_group`; and by either `periods` or `start_date`/`end_date`. An
#' unscoped query will be rejected by the server. Confirmed live against a
#' public DHIS2 demo instance: without `children = TRUE`, `org_units` matches
#' only that exact organisation unit, not its descendants — a query that
#' returned 0 values with `org_units` alone returned real data once
#' `children = TRUE` was added.
#'
#' Unlike the metadata and Tracker endpoints, `dataValueSets` is not
#' paginated — it returns the full matching result set in a single response.
#'
#' @return A tibble of data values (`dataElement`, `period`, `orgUnit`,
#'   `categoryOptionCombo`, `attributeOptionCombo`, `value`, `storedBy`,
#'   `created`, `lastUpdated`, `comment`, `followup`), or `NULL` if none were
#'   found.
#'
#' @export
#'
#' @seealso [get_analytics()] for pre-aggregated analytics values,
#'   [get_data_sets_by_level()] for data set reporting-rate metrics.
#'
#' @examplesIf khis_has_cred()
#'
#' # Raw data values for a data set at an org unit and everything below it,
#' # for a single period
#' get_data_value_sets(data_sets = 'VEM58nY22sO',
#'                     org_units = 'W6sNfkJcXGC',
#'                     children = TRUE,
#'                     periods = '202401')

get_data_value_sets <- function(data_elements = NULL,
                                data_sets = NULL,
                                data_element_groups = NULL,
                                org_units = NULL,
                                org_unit_group = NULL,
                                children = NULL,
                                periods = NULL,
                                start_date = NULL,
                                end_date = NULL,
                                last_updated = NULL,
                                id_scheme = NULL,
                                ...,
                                retry = 2,
                                verbosity = 0,
                                timeout = 60,
                                auth = NULL,
                                call = caller_env()) {

    if (!is.null(data_elements)) check_string_vector(data_elements, call = call)
    if (!is.null(data_sets)) check_string_vector(data_sets, call = call)
    if (!is.null(data_element_groups)) check_string_vector(data_element_groups, call = call)
    if (is.null(data_elements) && is.null(data_sets) && is.null(data_element_groups)) {
        khis_abort(
            message = c(
                'x' = 'Missing data scope',
                '!' = 'Provide at least one of {.arg data_elements}, {.arg data_sets}, or {.arg data_element_groups}.'
            ),
            call = call
        )
    }

    if (!is.null(org_units)) check_string_vector(org_units, call = call)
    if (!is.null(org_unit_group)) check_scalar_character(org_unit_group, call = call)
    if (is.null(org_units) && is.null(org_unit_group)) {
        khis_abort(
            message = c(
                'x' = 'Missing organisation unit scope',
                '!' = 'Provide at least one of {.arg org_units} or {.arg org_unit_group}.'
            ),
            call = call
        )
    }

    if (!is.null(periods)) check_string_vector(periods, call = call)
    if (is.null(periods) && (is.null(start_date) || is.null(end_date))) {
        khis_abort(
            message = c(
                'x' = 'Missing period scope',
                '!' = 'Provide either {.arg periods}, or both {.arg start_date} and {.arg end_date}.'
            ),
            call = call
        )
    }
    if (!is.null(start_date)) check_scalar_character(start_date, call = call)
    if (!is.null(end_date)) check_scalar_character(end_date, call = call)
    if (!is.null(children)) stopifnot(is.logical(children), length(children) == 1)

    response <- tryCatch({
        api_get(
            endpoint = 'dataValueSets',
            dataElement = data_elements,
            dataSet = data_sets,
            dataElementGroup = data_element_groups,
            orgUnit = org_units,
            orgUnitGroup = org_unit_group,
            children = children,
            period = periods,
            startDate = start_date,
            endDate = end_date,
            lastUpdated = last_updated,
            idScheme = id_scheme,
            ...,
            retry = retry,
            verbosity = verbosity,
            timeout = timeout,
            auth = auth,
            call = call
        )
    }, error = function(e) {
        khis_warn(c('x' = 'Error retrieving data values:', 'i' = conditionMessage(e)), call = call)
        return(NULL)
    })

    if (is.null(response) || is_empty(response$dataValues)) {
        khis_warn(c('!' = 'No data values found for the specified query.'), call = call)
        return(NULL)
    }

    bind_rows(response$dataValues)
}
