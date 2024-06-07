# This file is the interface between DHIS2 credential storage.

# Initialization happens in .onLoad
.auth <- NULL

#' Sets DHIS2 Credentials
#'
#' `khis_cred()` sets the credentials for accessing a DHIS2 instance.
#'
#' @param config_path An optional path to a configuration file containing username
#'   and password. This is considered more secure than providing credentials directly
#'   in code.
#' @param username The DHIS2 username. Only required if not provided in the
#'   configuration file.
#' @param password The DHIS2 password. Only required if not provided in the
#'   configuration file.
#' @param base_url The base URL of the DHIS2 instance. Defaults to NULL, which is
#'   typically <https://hiskenya.org/api>.
#'
#' @family credential functions
#'
#' @return No return value
#'
#' @export
#'
#' @details
#' This function allows you to set the credentials for interacting with a DHIS2
#' server. You can either provide the username and password directly (less secure)
#' or specify a path to a configuration file containing these credentials. Using
#' a configuration file is recommended for improved security as it prevents
#' credentials from being stored directly in your code.
#'
#' @examples
#'
#' local({
#'     # Option 1: Using a configuration file (recommended)
#'     # Assuming a configuration file named "credentials.json":
#'     # khis_cred(config_path = "path/to/credentials.json")
#'
#'     # Option 2: Providing credentials directly (less secure)
#'     khis_cred(username = "your_username",
#'               password = "your_password",
#'               base_url='https://dhis2-instance/api')
#' })

khis_cred <- function(config_path = NULL,
                      username = NULL,
                      password = NULL,
                      base_url = NULL) {

    #khis_warn(config_path)

    if (is.null(config_path) && is.null(username)) {
        khis_abort(
            message = c(
                'x' = 'Missing credentials',
                '!' = 'Please provide either {.field config_path} or {.field username} and {.field password}.'
            ),
            class = 'khis_missing_credentials'
        )
    }

    if (!(is.null(config_path)) && !(is.null(username))) {
        khis_abort(
            message = c(
                "x" = "{.field config_path} and {.field username} cannot be provided together.",
                "!" = "Remove one and try again!"
            ),
            class = 'khis_multiple_credentials',
            config_path = config_path
        )
    }

    additional <- ''

    if (!is.null(config_path)) {
        # loads credentials from secret file
        credentials <- .load_config_file(config_path)
        password <- credentials[["password"]]
        username <- credentials[["username"]]
        base_url <- credentials[["base_url"]]

        additional <- ' on the configuration file'
    }

    if (!is_scalar_character(password) || nchar(password) == 0 || !is_scalar_character(username) || nchar(username) == 0) {
        khis_abort(
            message = c(
                "x" = "Missing credentials",
                "!" = "Please provide both {.field username} and {.field password}{additional}."
            ),
            class = 'khis_missing_credentials'
        )
    }

    if (!is_scalar_character(base_url) || nchar(base_url) == 0) {
        khis_abort(
            message = c(
                "x" = "Missing DHIS2 api instance",
                "!" = "Please provide {.field base_url}."
            ),
            base_url = base_url,
            class = 'khis_missing_base_url'
        )
    }

    .auth$set_username(username)
    .auth$set_password(password)
    .auth$set_base_url(base_url)

    khis_info(c('i' = 'The credentials have been set.'))

    invisible(TRUE)
}

#' Load Configuration File
#'
#' Loads a JSON configuration file containing credentials for accessing DHIS2
#'   instance.
#'
#' @param config_path Path to the DHIS2 credentials file.
#'
#' @return
#' A parsed list of the configuration file.
#'
#'@noRd

.load_config_file <- function(config_path = NA, call = caller_env()) {
    # Load from a file
    tryCatch({
        data <- jsonlite::fromJSON(config_path)
        if (!is.null(data) && 'credentials' %in% names(data)) {
            return(data[['credentials']])
        }
    }, error = function(e) {
        khis_abort(
            message = c(
                "x" = "Invalid {.field config_path} was provided.",
                "!" = "Check the {.field config_path} and try again!"
            ),

            class = 'khis_invalid_config_path',
            config_path = config_path,
            call = call
        )
    })

    khis_abort(
        message = c(
            "x" = "Invalid {.field config_path} was provided.",
            "!" = "Please check the {.field config_path} file format and try again"
        ),
        class = 'khis_invalid_config_path',
        config_path = config_path,
        call = call
    )
}

#' Authenticate Request with HTTP Basic Authentication
#'
#' This sets the Authorization header for basic authentication using the username
#'   and password provided.
#'
#' @param req A request
#'
#' @return A modified HTTP request with authorization header
#'
#' @noRd
#'
#' @examples
#' req <- request("http://dhis2.com/api") %>%
#'   req_auth_khis_basic("damurka", "PASSWORD")
#'
#' @seealso [httr2]

req_auth_khis_basic <- function(req, arg = caller_arg(req), call = caller_env()) {

    check_required(req, arg, call)
    check_has_credentials(call)

    httr2::req_auth_basic(req, .auth$username, .auth$password)
}

#' Are There Credentials on Hand?
#'
#' @family credential functions
#'
#' @return a boolean value indicating if the credentials are available
#'
#' @export
#'
#' @examples
#'
#' # Set the credentials
#' #khis_cred(username = 'DHIS2 username',
#' #          password = 'DHIS2 password',
#' #          base_url='https://dhis2-instance/api')
#'
#' # Check if credentials available. Expect TRUE
#' #khis_has_cred()
#'
#' # Clear credentials
#' #khis_cred_clear()
#'
#' # Check if credentials available. Expect FALSE
#' #khis_has_cred()

khis_has_cred <- function() {
    .auth$has_cred()
}

#' Clear the Credentials from Memory
#'
#' @family credential functions
#'
#' @return No return value
#' @export
#'
#' @examples
#'
#' #khis_cred_clear()

khis_cred_clear <- function() {
    .auth$set_username(NULL)
    .auth$clear_password()
    .auth$reset_base_url()
    invisible(TRUE)
}

#' Produces the Configured Username
#'
#' @family credential functions
#'
#' @return the username of the user credentials
#' @export
#'
#' @examples
#'
#' # Set the credentials
#' #khis_cred(username = 'DHIS2 username',
#' #          password = 'DHIS2 password',
#' #          base_url ='https://dhis2-instance/api')
#'
#' # View the username expect 'DHIS2 username'
#' #khis_username()
#'
#' # Clear credentials
#' #khis_cred_clear()
#'
#' # View the username expect 'NULL'
#' #khis_username()

khis_username <- function() {
    .auth$get_username()
}

#' Produces the Configured DHIS2 API Base URI
#'
#' @return the DHIS2 base URI
#' @export
#'
#' @examples
#'
#' # Set the credentials
#' #khis_cred(username = 'DHIS2 username',
#' #          password = 'DHIS2 password',
#' #          base_url = 'https://dhis2-instance/api')
#'
#' # View the DHIS2 instance API expect 'https://dhis2-instance/api'
#' #khis_base_url()
#'
#' # Clear credentials
#' #khis_cred_clear()

khis_base_url <- function() {
   .auth$get_base_url()
}


#' Internal Credentials
#'
#' Internal function used to provide credentials for the testing and documentation
#'   environment
#'
#' @param account The environment to provide credentials. `"docs"` or `"testing"`
#'
#' @return No return value
#' @noRd

khis_cred_internal <- function(account = c('docs', 'testing')) {
    account <- arg_match(account)
    can_decrypt <- secret_has_key('KHIS_KEY')
    online <- !is.null(curl::nslookup('google.com', error = FALSE))
    if (!can_decrypt || !online) {
        khis_abort(
            message = c(
                "Set credential unsuccessful.",
                if (!can_decrypt) {
                    c("x" = "Can't decrypt the {.field {account}} credentials.")
                },
                if (!online) {
                    c("x" = "We don't appear to be online. Or maybe the KHIS is down?")
                }
            ),
            class = 'khis_cred_internal_error',
            can_decrypt = can_decrypt,
            online = online
        )
    }

    if (!is_interactive()) local_khis_quiet()
    filename <- str_glue("khis-{account}.json")

    khis_cred(
        config_path = secret_decrypt_json(
            system.file('secret', filename, package = 'khisr'),
            'KHIS_KEY'
        )
    )

    invisible(TRUE)
}

#' Set Credentials for Documentation
#'
#' @noRd

khis_cred_docs <- function() {
    khis_cred_internal('docs')
}

#' Set Credentials for Testing Environment
#'
#' @noRd

khis_cred_testing <- function() {
    khis_cred_internal('testing')
}

