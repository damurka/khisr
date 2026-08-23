#' Parse an Analytics-Shaped Response into a Tibble
#'
#' Shared by [get_analytics()] and the Tracker analytics query engine
#' ([fetch_analytics_query()]) — both DHIS2 endpoints return the same
#' `headers`/`rows` envelope (an array of column descriptors, plus an array
#' of raw row arrays), rather than an array of named objects.
#'
#' @param headers The `headers` array from the DHIS2 response (each element
#'   has `name` and `valueType`).
#' @param rows The `rows` array from the DHIS2 response (each element is a
#'   raw, unnamed row array).
#'
#' @return A tibble, or `NULL` if `rows` is empty.
#'
#' @noRd
parse_analytics_rows <- function(headers, rows) {
    x = NULL # due to NSE notes in R CMD check

    if (NROW(rows) == 0) {
        return(NULL)
    }

    header_names <- map_vec(headers, ~ pluck(.x, 'name'))
    value_types <- map_vec(headers, ~ pluck(.x, 'valueType'))
    names(value_types) <- header_names

    tibble(x = rows) %>%
        unnest_wider(x, names_sep = '') %>%
        rename_all(~ header_names) %>%
        mutate(across(everything(), ~ if (value_types[[cur_column()]] == 'NUMBER') as.numeric(.x) else .x))
}

#' Fetch a Paginated DHIS2 Tracker Analytics Query
#'
#' Shared engine behind [get_event_analytics()] and
#' [get_enrollment_analytics()] — DHIS2's `analytics/events/query/{program}`
#' and `analytics/enrollments/query/{program}` endpoints share the same
#' response envelope as `/api/analytics` (a `headers`/`rows` array, not a
#' named-object array), but paginate differently from every other paginated
#' endpoint in this package: the pager lives at `metaData.pager`, not at the
#' top level like the raw Tracker endpoints, and confirmed live against a
#' public DHIS2 demo instance, an unpaginated request silently returns only
#' the first `pageSize` (default 50) rows with no error or warning.
#'
#' @param resource Either `"events"` or `"enrollments"`.
#' @param program A program id; used as a URL path segment
#'   (`analytics/<resource>/query/<program>`), not a query parameter.
#' @param ... One or more [analytics_dimension()] parameters (e.g. `ou`/`pe`
#'   dimensions), and/or other query parameters supported by your DHIS2
#'   instance's Tracker analytics query API.
#' @param return_type Optional. `'uid'` (default) or `'name'` for the
#'   identifier scheme used in the response.
#' @param page_size Number of records to request per page (default 1000).
#' @param retry Number of times to retry the API call in case of failure.
#' @param verbosity Level of HTTP information to print during the call.
#' @param timeout Maximum number of seconds to wait for the API response.
#' @param auth Optional. The authentication object.
#' @param call The caller environment.
#'
#' @return A tibble, or `NULL` if no data was retrieved.
#'
#' @noRd
fetch_analytics_query <- function(resource,
                                  program,
                                  ...,
                                  return_type = c('uid', 'name'),
                                  page_size = 1000,
                                  retry = 2,
                                  verbosity = 0,
                                  timeout = 60,
                                  auth = NULL,
                                  call = caller_env()) {

    return_type <- str_to_upper(arg_match(return_type))
    endpoint <- str_c('analytics/', resource, '/query/', program)

    page <- 1L
    headers <- NULL
    all_rows <- list()

    repeat {
        response <- api_get(
            endpoint,
            ...,
            outputIdScheme = return_type,
            page = page,
            pageSize = page_size,
            retry = retry,
            verbosity = verbosity,
            timeout = timeout,
            auth = auth,
            call = call
        )

        if (is.null(headers)) headers <- response$headers

        rows <- response$rows
        if (NROW(rows) == 0) break
        all_rows <- c(all_rows, rows)

        pager <- response$metaData$pager
        if (is.null(pager) ||
            length(rows) < page_size ||
            (!is.null(pager$pageCount) && page >= pager$pageCount)) {
            break
        }

        page <- page + 1L
    }

    parse_analytics_rows(headers, all_rows)
}
