#' Make an API Call to the Kenya Health Information System (KHIS) Server
#'
#' `api_get()` function executes a GET request to the KHIS API server, handling
#' authentication, query parameters, retries, and logging.
#'
#' @param endpoint The API endpoint path to call (e.g., "analytics", "dataElements").
#' @param ... Additional query parameters for the API call.
#' @param retry Number of times to retry the API call in case of failure
#'   (defaults to 2).
#' @param verbosity Level of http information to print during the call:
#'  - 0: No output
#'  - 1: Show headers
#'  - 2: Show headers and bodies
#'  - 3: Show headers, bodies, and curl status message
#' @param timeout Maximum number of seconds to wait
#' @param call The execution environment of a currently running function, e.g.
#'   [caller_env()]. The function will be mentioned in error messages as the
#'   source of the error. See the call argument of [abort()] for more information.
#'
#' @return A parsed JSON object containing the API response data.
#'
#' @details Uses HTTP Basic Authentication with credentials provided using
#'   [khis_cred]
#'
#' @examplesIf khis_has_cred()
#'
#' analytics_data <- .api_get("analytics", startDate = "2023-01-01", endDate = "2023-02-28")
#'
#' @noRd

api_get <- function(endpoint,
                    ...,
                    retry = 2,
                    verbosity = 0,
                    timeout = 60,
                    call = caller_env()) {

    check_required(endpoint, call = call)

    params <- list2(
        ...,
        paging = 'false',
        ignoreLimit = 'true'
    )

    resp <- request(khis_base_url()) %>%
        req_url_path_append(endpoint) %>%
        req_url_query(!!!params) %>%
        req_headers('Accept' = 'application/json') %>%
        req_user_agent('khisr (https://khisr.damurka.com)') %>%
        req_retry(max_tries = retry) %>%
        req_timeout(timeout) %>%
        req_auth_khis_basic() %>%
        req_error(body = ~ khis_abort(c('x'='API Error','!' = '{resp_body_json(.x)}'), call = call)) %>%
        req_perform(verbosity = verbosity) %>%
        resp_body_json()

    return(resp)
}
