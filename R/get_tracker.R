#' Fetch Records From a DHIS2 Tracker List Endpoint
#'
#' Shared engine behind [get_tracked_entities()], [get_events()], and
#' [get_enrollments()]. Handles pagination, response parsing, and unnesting
#' the top-level record fields into columns; nested repeating structures
#' (e.g. `attributes`, `dataValues`, `enrollments`) are left as list-columns
#' for the caller to unnest as needed.
#'
#' @param resource The tracker resource name, used both as the URL path
#'   segment under `/api/tracker/` and as the JSON response key (e.g.
#'   `"trackedEntities"`, `"events"`, `"enrollments"`).
#' @param ... Additional query parameters for the tracker endpoint.
#' @param fields The DHIS2 field-selector string/vector for the `fields`
#'   query parameter.
#' @param page_size Number of records to request per page.
#' @param retry Number of times to retry the API call in case of failure.
#' @param verbosity Level of HTTP information to print during the call.
#' @param timeout Maximum number of seconds to wait for the API response.
#' @param auth Optional. The authentication object.
#' @param call The caller environment.
#'
#' @return A tibble of tracker records, or `NULL` if none were found.
#'
#' @noRd
fetch_tracker_records <- function(resource,
                                  ...,
                                  fields,
                                  page_size = 500,
                                  retry = 2,
                                  verbosity = 0,
                                  timeout = 60,
                                  auth = NULL,
                                  call = caller_env()) {

    check_string_vector(fields, call = call)

    response <- tryCatch({
        api_get_paged(
            endpoint = str_c('tracker/', resource),
            response_key = resource,
            ...,
            fields = str_c(fields, collapse = ','),
            page_size = page_size,
            retry = retry,
            verbosity = verbosity,
            timeout = timeout,
            auth = auth,
            call = call
        )
    }, error = function(e) {
        khis_warn(c('x' = 'Error retrieving tracker data:', 'i' = conditionMessage(e)), call = call)
        return(NULL)
    })

    if (is.null(response)) return(NULL)

    data <- as_tibble(response) %>%
        hoist(resource)

    if (nrow(data) == 0) {
        khis_warn(c('!' = 'No data found for the specified query.'), call = call)
        return(NULL)
    }

    data %>%
        unnest_wider(all_of(resource))
}

#' Validate `filter` Query Values Against the Tracker Operator Whitelist
#'
#' [metadata_filter()] and [tracked_entity_filter()] both splice a `filter`
#' element into `...` in the same `property:operator:value` shape, so a
#' [metadata_filter()] expression (e.g. `%.in%`, `%.ieq%`) would otherwise be
#' silently accepted here and forwarded to the server as malformed or
#' unsupported Tracker filter syntax instead of failing on the client with a
#' clear message.
#'
#' @param dots The `...` args collected via [list2()] from the calling function.
#' @param call The caller environment.
#'
#' @noRd
check_tracker_filters <- function(dots, call = caller_env()) {
    filters <- dots[names(dots) == 'filter']

    for (f in filters) {
        operator <- sub('^[^:]+:([^:]+).*$', '\\1', f)
        value <- sub('^[^:]+:[^:]+:?', '', f)

        # 'in' is a valid keyword on both APIs, but metadata_filter()'s
        # comma-bracketed value syntax ("[a,b]") is not what the Tracker API
        # expects (semicolon-separated, no brackets) — a keyword-only check
        # would miss this.
        bad_in_syntax <- identical(operator, 'in') && grepl('^\\[.*\\]$', value)

        if (!(operator %in% tracker_filter_operators) || bad_in_syntax) {
            khis_abort(
                message = c(
                    'x' = '{.val {f}} is not valid tracked entity filter syntax',
                    '!' = 'Build tracked entity filters with {.fun tracked_entity_filter}.',
                    'i' = '{.fun metadata_filter} and its infix operators (e.g. {.code %.eq%}, {.code %.in%}) target a different DHIS2 API and are not interchangeable with tracked entity filters.'
                ),
                call = call
            )
        }
    }

    invisible(TRUE)
}

#' Reject a `filter` Query Value on Tracker Endpoints That Don't Support It
#'
#' DHIS2's Tracker API only documents attribute filtering for the
#' `trackedEntities` endpoint. A [metadata_filter()] or
#' [tracked_entity_filter()] expression passed into [get_events()] or
#' [get_enrollments()] would otherwise be silently sent as an unsupported
#' `filter` query parameter, so this fails fast instead.
#'
#' @inheritParams check_tracker_filters
#' @param fn The name of the calling function, for the error message.
#'
#' @noRd
reject_tracker_filter <- function(dots, fn, call = caller_env()) {
    if ('filter' %in% names(dots)) {
        khis_abort(
            message = c(
                'x' = "DHIS2's Tracker API does not document filter support for {.fun {fn}}",
                '!' = 'Use {.fun get_tracked_entities} with {.fun tracked_entity_filter} to filter by attribute value, or pass an instance-specific parameter directly through {.code ...}.'
            ),
            call = call
        )
    }

    invisible(TRUE)
}
