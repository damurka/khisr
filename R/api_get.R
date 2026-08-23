#' Make an Authenticated API Call to a DHIS2 Server
#'
#' `api_get()` function executes a request to the DHIS2 API server, handling
#' authentication, query parameters, retries, and logging.
#'
#' @param endpoint The DHIS2 API endpoint path to call (e.g., "analytics", "dataElements").
#' @param ... Additional query parameters for the API call.
#' @param retry Number of times to retry the API call in case of failure
#'   (defaults to 2).
#' @param verbosity Level of http information to print during the call:
#'  - 0: No output
#'  - 1: Show headers
#'  - 2: Show headers and bodies
#'  - 3: Show headers, bodies, and curl status message
#' @param timeout Maximum number of seconds to wait for the response (default to 60).
#' @param paging Set if responses should be paginated. (default is FALSE).
#' @param call The execution environment of a currently running function, e.g.,
#'   [caller_env()]. The function will be mentioned in error messages for debugging.
#'
#' @return A parsed JSON object containing the DHIS2 API response data.
#'
#' @details Uses HTTP Basic Authentication with credentials provided using
#'   [khis_cred()]
#'
#' @examplesIf khis_has_cred()
#'
#' analytics_data <- api_get("analytics", startDate = "2023-01-01", endDate = "2023-02-28")
#'
#' @noRd

api_get <- function(endpoint,
                    ...,
                    retry = 2,
                    verbosity = 0,
                    timeout = 60,
                    paging = FALSE,
                    auth = NULL,
                    call = caller_env()) {

    check_required(endpoint, call = call)
    check_scalar_character(endpoint, call = call)
    check_has_credentials(auth = auth, call = call)

    params <- list2(
        ...,
        paging = paging,
        ignoreLimit = 'true'
    )

    api_version <- khis_api_version(auth)
    api_path <- if (is.null(api_version)) 'api' else c('api', api_version)

    resp <- request(khis_base_url(auth)) %>%
        req_url_path_append(api_path, endpoint) %>%
        req_url_query(!!!params, .multi = 'explode') %>%
        req_headers('Accept' = 'application/json') %>%
        req_user_agent('khisr/1.0.6 (https://khisr.damurka.com)') %>%
        req_retry(max_tries = retry, is_transient = is_transient_khis) %>%
        req_timeout(timeout) %>%
        req_auth_khis(auth = auth, call = call) %>%
        req_error(body = handle_error) %>%
        req_perform(verbosity = verbosity, error_call = call) %>%
        resp_body_json()

    return(resp)
}

#' Determine Whether a Failed Response Should Be Retried
#'
#' In addition to httr2's defaults (429, 503), large unpaginated DHIS2
#' responses commonly time out at a reverse proxy in front of the instance,
#' which surfaces as a 502 or 504 rather than a 503. Treat those as
#' transient too, so `retry` actually has a chance to help.
#'
#' @param resp An HTTP response object.
#' @return `TRUE` if the response should be retried.
#' @noRd
is_transient_khis <- function(resp) {
    resp_status(resp) %in% c(429, 502, 503, 504)
}

#' Fetch All Pages of a DHIS2 List Endpoint
#'
#' Some DHIS2 instances cap the number of records a single request can
#' return (via the `keyMaxRestApiCollectionSize` system setting) regardless
#' of the `ignoreLimit` query parameter, silently truncating single-shot
#' requests. `api_get_paged()` walks the endpoint's pager instead, so the
#' full result set is retrieved even on such instances.
#'
#' @inheritParams api_get
#' @param page_size Number of records to request per page (default 1000).
#' @param response_key The name of the JSON array in the response body to
#'   collect across pages. Defaults to `endpoint`, which holds for simple
#'   endpoints (e.g. `dataElements`), but some endpoints have a URL path
#'   that differs from their response key (e.g. the URL path
#'   `tracker/trackedEntities` returns records under the key
#'   `trackedEntities`, not `tracker/trackedEntities`).
#'
#' @return A list of the parsed elements from every page, combined.
#'
#' @noRd
api_get_paged <- function(endpoint,
                          ...,
                          response_key = endpoint,
                          page_size = 1000,
                          retry = 2,
                          verbosity = 0,
                          timeout = 60,
                          auth = NULL,
                          call = caller_env()) {

    page <- 1L
    results <- list()

    repeat {
        response <- api_get(
            endpoint = endpoint,
            ...,
            page = page,
            pageSize = page_size,
            paging = TRUE,
            retry = retry,
            verbosity = verbosity,
            timeout = timeout,
            auth = auth,
            call = call
        )

        items <- response[[response_key]] %||% list()
        results <- c(results, items)

        pager <- response$pager
        if (is.null(pager) ||
            length(items) < page_size ||
            (!is.null(pager$pageCount) && page >= pager$pageCount)) {
            break
        }

        page <- page + 1L
    }

    set_names(list(results), response_key)
}

handle_error <- function(resp) {
    content_type <- resp_content_type(resp)
    url <- resp_url(resp)

    # Handle JSON response
    if (grepl("application/json", content_type, ignore.case = TRUE)) {
        tryCatch({
            parsed_body <- resp_body_json(resp)
            error_message <- parsed_body$message %||% "Unknown error in JSON response."
            return(error_message)
        }, error = function(e) {
            return("Failed to parse JSON response: Invalid or malformed JSON.")
        })
    } else {
        # If not JSON, return a meaningful error message
        return(paste0(
            "Unsupported content type '", content_type, "' received from: ", url,
            ". Only 'application/json' is supported."
        ))
    }
}
