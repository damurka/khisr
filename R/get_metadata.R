#' Get Metadata from a KHIS
#'
#' `get_metadata` retrieves metadata for a specified endpoint of KHIS
#'
#' @param endpoint The KHIS API endpoint for the metadata of interest
#'   (e.g. dataElements, organisationUnits).
#' @param ... One or more [metadata filters](metadata-filter) in key-value pairs.
#' @param fields The specific columns to be returned in the tibble.
#' @param retry Number of times to retry the API call in case of failure
#'   (defaults to 2).
#' @param verbosity Level of HTTP information to print during the call:
#'   - 0: No output
#'   - 1: Show headers
#'   - 2: Show headers and bodies
#'   - 3: Show headers, bodies, and CURL status message.
#' @param timeout Maximum number of seconds to wait for the API response.
#'
#' @return A tibble with the KHIS metadata response.
#'
#' @export
#'
#' @examplesIf khis_has_cred()
#'
#' # Get the categories metadata
#' get_metadata('categories')
#'
#' # Get the datasets metadata with fields 'id,name,organisationUnits' and filter
#' # only the datasets with id 'WWh5hbCmvND'
#' get_metadata('dataSets',
#'              fields = 'id,name,organisationUnits[id,name,path]',
#'              id %.eq% 'WWh5hbCmvND')
#'
#' # Get data elements filtered by dataElementgroups id
#' get_metadata('dataElements',
#'              dataElementGroups.id %.eq% 'IXd7DXxZqzL',
#'              fields = ':all')

get_metadata <- function(endpoint,
                         ...,
                         fields = c('id', 'name'),
                         retry = 2,
                         verbosity = 0,
                         timeout = 60) {

    check_scalar_character(endpoint)
    check_string_vector(fields)

    response <- api_get(
        endpoint = endpoint,
        ...,
        fields = str_c(fields, collapse=','),
        retry = retry,
        verbosity = verbosity,
        timeout = timeout
    )

    data <- as_tibble(response) %>%
        hoist(endpoint)

    if (nrow(data) == 0) {
        khis_warn(c('!' = 'The table is empty'))
        return(NULL)
    }

    data <- data %>% unnest_wider(endpoint)
    return(data)
}
