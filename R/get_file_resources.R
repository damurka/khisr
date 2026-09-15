#' Get File Resources Metadata from a DHIS2 Instance
#'
#' @description
#' `r lifecycle::badge("experimental")`
#' `get_file_resources()` lists the metadata of files stored in a DHIS2
#' instance — icons, and files/images attached to tracker attribute values
#' or data values — from the `fileResources` endpoint. This retrieves
#' metadata only (name, content type, size); it does not download file
#' contents.
#'
#' @param ... [metadata_filter()] parameters, or their infix-operator
#'   shorthand, to filter the results, and/or other query parameters
#'   supported by your DHIS2 instance's `fileResources` endpoint.
#' @param retry Number of times to retry the API call in case of failure
#'   (defaults to 2).
#' @param verbosity Level of HTTP information to print during the call.
#' @param timeout Maximum number of seconds to wait for the API response.
#' @param auth Optional. The authentication object.
#' @param call The caller environment.
#'
#' @return A tibble of file resources (`id`, `name`, `contentType`,
#'   `contentLength`), or `NULL` if none were found. Confirmed live against
#'   a public DHIS2 demo instance.
#'
#' @export
#'
#' @examplesIf khis_has_cred()
#'
#' get_file_resources(contentType %.like% 'image')

get_file_resources <- function(..., retry = 2, verbosity = 0, timeout = 60,
                               auth = NULL, call = caller_env()) {

    response <- tryCatch({
        api_get(
            endpoint = 'fileResources',
            ...,
            fields = 'id,name,contentType,contentLength',
            retry = retry,
            verbosity = verbosity,
            timeout = timeout,
            auth = auth,
            call = call
        )
    }, error = function(e) {
        khis_warn(c('x' = 'Error retrieving file resources:', 'i' = conditionMessage(e)), call = call)
        return(NULL)
    })

    if (is.null(response) || is_empty(response$fileResources)) {
        khis_warn(c('!' = 'No file resources found for the specified query.'), call = call)
        return(NULL)
    }

    bind_rows(response$fileResources)
}
