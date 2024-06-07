#' Create an AuthCred
#'
#' Constructor function for objects of class [AuthCred].
#'
#' @param username The DHIS2 username to be used in API calls
#' @param password The DHIS2 password to be used in API calls.
#'
#' @return An object of class [AuthCred]
#' @noRd

init_AuthCred <- function(username = NA_character_,
                          password = NA_character_,
                          base_url = NA_character_) {
    AuthCred$new(
        username = username,
        password = password,
        base_url = base_url
    )
}

#' Authorization Credential
#'
#' An `AuthCred` object manages the authorization credentials that make request
#' to the DHIS2 API server.
#'
#' @details An `AuthCred` should be created through the constructor function
#' [init_AuthCred()], which has more details on the arguments
#'
#' @param config_path Path to a JSON configuration file.
#' @param username The DHIS2 username.
#' @param password The DHIS2 password.
#'
#' @noRd
AuthCred <- R6::R6Class('AuthCred', list(
    #' @field  config_path Path to a JSON configuration file.
    config_path = NULL,
    #' @field  username The DHIS2 username.
    username = NULL,
    #' @field password The DHIS2 password.
    password = NULL,
    #' @field base_url The URL to the server
    base_url = NULL,

    #' @description Create a new AuthCred
    #' @details For more details on the parameters, see [init_AuthCred()]
    initialize = function(username = NA_character_,
                          password = NA_character_,
                          base_url = NA_character_) {

        stopifnot(
            is.null(username) || is_scalar_character(username),
            is.null(password) || is_scalar_character(password),
            is.null(base_url) || is_scalar_character(base_url)
        )

        self$username <- username
        self$password <- password
        self$base_url <- base_url
        self
    },
    #' @description Get username
    get_username = function() {
        self$username
    },
    #' @description Set the DHIS2 username
    #' @param value The DHIS2 username
    set_username = function(value) {
        stopifnot(is.null(value) || is_scalar_character(value))
        self$username <- value
        invisible(self)
    },
    #' @description Get password
    get_password = function() {
        self$password
    },
    #' @description Set the DHIS2 password
    #' @param value The DHIS2 password
    set_password = function(value) {
        stopifnot(is.null(value) || is_scalar_character(value))
        self$password <- value
        invisible(self)
    },
    #' @description Clear password
    clear_password = function() {
        self$set_password(NULL)
    },
    #' @description Get the base URL API
    get_base_url = function() {
        self$base_url
    },
    #' @description Set the DHIS2 username
    #' @param value The DHIS2 username
    set_base_url = function(value) {
        stopifnot(is.null(value) || is_scalar_character(value))
        self$base_url <- value
        invisible(self)
    },
    #' @description Clear the base URL API
    reset_base_url = function() {
        self$set_base_url(NULL)
    },
    #' @description Report if we have credentials
    has_cred = function() {
        !is.null(self$password) && !is_na(self$password) &&
        !is.null(self$username) && !is_na(self$username) &&
        !is.null(self$base_url) && !is_na(self$base_url)
    }
))
