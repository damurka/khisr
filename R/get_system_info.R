#' Get DHIS2 Instance System Information
#'
#' @description
#' `r lifecycle::badge("experimental")`
#' `get_system_info()` retrieves information about the connected DHIS2
#' instance itself — version, revision, build time, server date/time zone,
#' and similar — from the `system/info` endpoint. Useful for checking
#' compatibility before relying on version-specific behaviour.
#'
#' @param auth Optional. The authentication object.
#' @param call The caller environment.
#'
#' @return A named list of system information fields (e.g. `version`,
#'   `revision`, `buildTime`, `serverDate`, `contextPath`), as returned by
#'   DHIS2. Confirmed live against a public DHIS2 demo instance.
#'
#' @export
#'
#' @seealso [khis_api_version()] for the API version pinned on the current
#'   credentials.
#'
#' @examplesIf khis_has_cred()
#'
#' get_system_info()

get_system_info <- function(auth = NULL, call = caller_env()) {
    api_get('system/info', auth = auth, call = call)
}
