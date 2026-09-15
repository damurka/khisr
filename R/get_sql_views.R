#' Get SQL Views Metadata from a DHIS2 Instance
#'
#' @description
#' `r lifecycle::badge("experimental")`
#' `get_sql_views()` lists the SQL views configured on a DHIS2 instance —
#' predefined, admin-authored SQL queries exposed as a data endpoint. Use
#' [get_sql_view_data()] to retrieve the actual data for one of them.
#'
#' @param ... [metadata_filter()] parameters, or their infix-operator
#'   shorthand, to filter the results, and/or other query parameters
#'   supported by your DHIS2 instance's `sqlViews` endpoint.
#' @param retry Number of times to retry the API call in case of failure
#'   (defaults to 2).
#' @param verbosity Level of HTTP information to print during the call.
#' @param timeout Maximum number of seconds to wait for the API response.
#' @param auth Optional. The authentication object.
#' @param call The caller environment.
#'
#' @return A tibble of SQL views (`id`, `name`, `type` — `'VIEW'` for a
#'   materialized view queryable directly, or `'QUERY'` for one that must be
#'   executed first), or `NULL` if none were found. Confirmed live against a
#'   public DHIS2 demo instance.
#'
#' @export
#'
#' @seealso [get_sql_view_data()] for retrieving a view's data.
#'
#' @examplesIf khis_has_cred()
#'
#' get_sql_views()

get_sql_views <- function(..., retry = 2, verbosity = 0, timeout = 60,
                          auth = NULL, call = caller_env()) {

    response <- tryCatch({
        api_get(
            endpoint = 'sqlViews',
            ...,
            fields = 'id,name,type',
            retry = retry,
            verbosity = verbosity,
            timeout = timeout,
            auth = auth,
            call = call
        )
    }, error = function(e) {
        khis_warn(c('x' = 'Error retrieving SQL views:', 'i' = conditionMessage(e)), call = call)
        return(NULL)
    })

    if (is.null(response) || is_empty(response$sqlViews)) {
        khis_warn(c('!' = 'No SQL views found for the specified query.'), call = call)
        return(NULL)
    }

    bind_rows(response$sqlViews)
}

#' Get Data from a DHIS2 SQL View
#'
#' @description
#' `r lifecycle::badge("experimental")`
#' `get_sql_view_data()` retrieves the data produced by a SQL view
#' identified by [get_sql_views()] — a predefined, admin-authored SQL query
#' exposed as a data endpoint.
#'
#' @param sql_view A SQL view id.
#' @param variables Optional. A named character vector of variable
#'   substitutions for a parameterised SQL view, e.g.
#'   `c(orgUnit = 'ImspTQPwCqd')`.
#' @param ... Other query parameters supported by your DHIS2 instance's
#'   `sqlViews` data endpoint.
#' @param retry Number of times to retry the API call in case of failure
#'   (defaults to 2).
#' @param verbosity Level of HTTP information to print during the call.
#' @param timeout Maximum number of seconds to wait for the API response.
#' @param auth Optional. The authentication object.
#' @param call The caller environment.
#'
#' @details
#' A view of type `'QUERY'` (see [get_sql_views()]) is executed on demand;
#' a `'VIEW'` is queried directly. **This function's response shape has not
#' been independently verified live**: every SQL view on the public demo
#' instance used to verify khisr's other functions returned `403 Forbidden`
#' ("not authorised") or `409 Conflict` (referencing an analytics table this
#' particular demo hadn't built) for this account — both account/instance
#' issues rather than request errors. The shape below follows DHIS2's
#' documented `listGrid` structure (shared with a few other legacy DHIS2
#' endpoints), reusing the same `headers`/`rows` parsing as [get_analytics()];
#' confirm it against your own instance before relying on this function in
#' production.
#'
#' @return A tibble of the SQL view's result rows, or `NULL` if none were
#'   retrieved.
#'
#' @export
#'
#' @seealso [get_sql_views()] for listing available SQL views.
#'
#' @examplesIf khis_has_cred()
#'
#' \dontrun{
#' views <- get_sql_views()
#' get_sql_view_data(views$id[1])
#' }

get_sql_view_data <- function(sql_view, variables = NULL, ..., retry = 2,
                              verbosity = 0, timeout = 60, auth = NULL,
                              call = caller_env()) {

    check_scalar_character(sql_view, call = call)
    if (!is.null(variables)) {
        stopifnot(!is.null(names(variables)), all(nzchar(names(variables))))
        variables <- str_c(names(variables), ':', variables)
    }

    response <- tryCatch({
        api_get(
            endpoint = str_c('sqlViews/', sql_view, '/data'),
            var = variables,
            ...,
            retry = retry,
            verbosity = verbosity,
            timeout = timeout,
            auth = auth,
            call = call
        )
    }, error = function(e) {
        khis_warn(c('x' = 'Error retrieving SQL view data:', 'i' = conditionMessage(e)), call = call)
        return(NULL)
    })

    if (is.null(response) || is_empty(response$listGrid$rows)) {
        khis_warn(c('!' = 'No data found for the specified SQL view.'), call = call)
        return(NULL)
    }

    x = NULL # due to NSE notes in R CMD check
    header_names <- map_vec(response$listGrid$headers, ~ pluck(.x, 'name'))

    tibble(x = response$listGrid$rows) %>%
        unnest_wider(x, names_sep = '') %>%
        rename_all(~ header_names)
}
