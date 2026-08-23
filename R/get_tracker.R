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
