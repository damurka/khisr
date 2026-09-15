#' Get Data Value Change History from a DHIS2 Instance
#'
#' @description
#' `r lifecycle::badge("experimental")`
#' `get_data_value_audits()` retrieves the audit trail (who changed a data
#' value, when, and to what) from DHIS2's `audits/dataValue` endpoint.
#'
#' @param data_elements Optional. A vector of data element ids to scope the
#'   query to.
#' @param org_units Optional. A vector of organisation unit ids to scope
#'   the query to.
#' @param periods Optional. A vector of ISO period strings to scope the
#'   query to.
#' @param ... Other query parameters supported by your DHIS2 instance's
#'   `audits/dataValue` endpoint (e.g. `categoryOptionCombo`,
#'   `attributeOptionCombo`).
#' @param retry Number of times to retry the API call in case of failure
#'   (defaults to 2).
#' @param verbosity Level of HTTP information to print during the call.
#' @param timeout Maximum number of seconds to wait for the API response.
#' @param auth Optional. The authentication object.
#' @param call The caller environment.
#'
#' @details
#' Confirmed live against a public DHIS2 demo instance that this endpoint
#' accepts these parameters and returns a valid, empty result — the data
#' value tried had no recorded edit history, so the shape of a populated
#' result is not independently verified.
#'
#' @return A tibble of data value audit records (data element, period, org
#'   unit, category/attribute option combos, value, modified date, audit
#'   type), or `NULL` if none were found.
#'
#' @export
#'
#' @examplesIf khis_has_cred()
#'
#' get_data_value_audits(data_elements = 'lYsfXxCw6Qi',
#'                       org_units = 'W6sNfkJcXGC',
#'                       periods = '202301')

get_data_value_audits <- function(data_elements = NULL,
                                  org_units = NULL,
                                  periods = NULL,
                                  ...,
                                  retry = 2,
                                  verbosity = 0,
                                  timeout = 60,
                                  auth = NULL,
                                  call = caller_env()) {

    if (!is.null(data_elements)) check_string_vector(data_elements, call = call)
    if (!is.null(org_units)) check_string_vector(org_units, call = call)
    if (!is.null(periods)) check_string_vector(periods, call = call)

    response <- tryCatch({
        api_get(
            endpoint = 'audits/dataValue',
            de = data_elements,
            ou = org_units,
            pe = periods,
            ...,
            retry = retry,
            verbosity = verbosity,
            timeout = timeout,
            auth = auth,
            call = call
        )
    }, error = function(e) {
        khis_warn(c('x' = 'Error retrieving data value audits:', 'i' = conditionMessage(e)), call = call)
        return(NULL)
    })

    if (is.null(response) || is_empty(response$dataValueAudits)) {
        khis_warn(c('!' = 'No data value audits found for the specified query.'), call = call)
        return(NULL)
    }

    bind_rows(response$dataValueAudits)
}
