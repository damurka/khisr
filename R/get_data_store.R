#' Get DHIS2 Data Store Namespaces
#'
#' @description
#' `r lifecycle::badge("experimental")`
#' `get_data_store_namespaces()` lists the namespaces in a DHIS2 instance's
#' key/value data store — arbitrary JSON configuration used by DHIS2 apps
#' (e.g. the Maps app, Tracker Capture). Use [get_data_store_keys()] and
#' [get_data_store_value()] to read a namespace's contents.
#'
#' @param store Optional. `'system'` (default), the shared instance-wide
#'   store, or `'user'`, the store private to the authenticated user.
#' @param auth Optional. The authentication object.
#' @param call The caller environment.
#'
#' @return A character vector of namespaces, or `NULL` if none exist.
#'   Confirmed live against a public DHIS2 demo instance.
#'
#' @export
#'
#' @seealso [get_data_store_keys()], [get_data_store_value()].
#'
#' @examplesIf khis_has_cred()
#'
#' get_data_store_namespaces()

get_data_store_namespaces <- function(store = c('system', 'user'), auth = NULL, call = caller_env()) {
    store <- arg_match(store)
    response <- api_get(data_store_endpoint(store), auth = auth, call = call)

    if (is_empty(response)) {
        khis_warn(c('!' = 'No data store namespaces found.'), call = call)
        return(NULL)
    }

    unlist(response)
}

#' Get the Keys in a DHIS2 Data Store Namespace
#'
#' @description
#' `r lifecycle::badge("experimental")`
#' `get_data_store_keys()` lists the keys stored under a namespace in a
#' DHIS2 instance's key/value data store. See [get_data_store_namespaces()].
#'
#' @param namespace A data store namespace, as returned by
#'   [get_data_store_namespaces()].
#' @param store Optional. `'system'` (default) or `'user'`; see
#'   [get_data_store_namespaces()].
#' @param auth Optional. The authentication object.
#' @param call The caller environment.
#'
#' @return A character vector of keys, or `NULL` if the namespace has none.
#'   Confirmed live against a public DHIS2 demo instance.
#'
#' @export
#'
#' @seealso [get_data_store_namespaces()], [get_data_store_value()].
#'
#' @examplesIf khis_has_cred()
#'
#' namespaces <- get_data_store_namespaces()
#' get_data_store_keys(namespaces[1])

get_data_store_keys <- function(namespace, store = c('system', 'user'), auth = NULL, call = caller_env()) {
    check_scalar_character(namespace, call = call)
    store <- arg_match(store)
    response <- api_get(str_c(data_store_endpoint(store), '/', namespace), auth = auth, call = call)

    if (is_empty(response)) {
        khis_warn(c('!' = 'No keys found for the specified namespace.'), call = call)
        return(NULL)
    }

    unlist(response)
}

#' Get a Value from a DHIS2 Data Store
#'
#' @description
#' `r lifecycle::badge("experimental")`
#' `get_data_store_value()` retrieves the JSON value stored under a
#' namespace/key pair in a DHIS2 instance's key/value data store. See
#' [get_data_store_namespaces()].
#'
#' @param namespace A data store namespace, as returned by
#'   [get_data_store_namespaces()].
#' @param key A key within `namespace`, as returned by
#'   [get_data_store_keys()].
#' @param store Optional. `'system'` (default) or `'user'`; see
#'   [get_data_store_namespaces()].
#' @param auth Optional. The authentication object.
#' @param call The caller environment.
#'
#' @return The stored value, parsed from JSON — typically a named list, but
#'   shape varies entirely by what the namespace/key holds. Confirmed live
#'   against a public DHIS2 demo instance.
#'
#' @export
#'
#' @seealso [get_data_store_namespaces()], [get_data_store_keys()].
#'
#' @examplesIf khis_has_cred()
#'
#' namespaces <- get_data_store_namespaces()
#' keys <- get_data_store_keys(namespaces[1])
#' get_data_store_value(namespaces[1], keys[1])

get_data_store_value <- function(namespace, key, store = c('system', 'user'), auth = NULL, call = caller_env()) {
    check_scalar_character(namespace, call = call)
    check_scalar_character(key, call = call)
    store <- arg_match(store)
    api_get(str_c(data_store_endpoint(store), '/', namespace, '/', key), auth = auth, call = call)
}

data_store_endpoint <- function(store) {
    if (store == 'user') 'userDataStore' else 'dataStore'
}
