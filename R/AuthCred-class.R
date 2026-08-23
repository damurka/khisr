#' Create an AuthCred
#'
#' Constructor function for objects of class [AuthCred].
#'
#' @param username The DHIS2 username to be used in API calls
#' @param password The DHIS2 password to be used in API calls.
#' @param token A DHIS2 Personal Access Token, as an alternative to
#'   `username`/`password`.
#' @param base_url The DHIS2 base_url to be used in API calls.
#'
#' @return An object of class [AuthCred]
#' @noRd

init_AuthCred <- function(username = NULL,
                          password = NULL,
                          token = NULL,
                          base_url = NULL,
                          api_version = NULL,
                          profile = NULL) {
    AuthCred$new(
        username = username,
        password = password,
        token = token,
        base_url = base_url,
        api_version = api_version,
        profile = profile
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
    #' @field token A DHIS2 Personal Access Token.
    token = NULL,
    #' @field base_url The URL to the server.
    base_url = NULL,
    #' @field api_version The DHIS2 API version to pin requests to (optional).
    api_version = NULL,
    #' @field profile Profile.
    profile = NULL,

    #' @description Create a new AuthCred
    #' @details For more details on the parameters, see [init_AuthCred()]
    initialize = function(username = NULL,
                          password = NULL,
                          token = NULL,
                          base_url = NULL,
                          api_version = NULL,
                          profile = NULL) {

        stopifnot(
            is.null(username) || is_scalar_character(username),
            is.null(password) || is_scalar_character(password),
            is.null(token) || is_scalar_character(token),
            is.null(base_url) || is_scalar_character(base_url),
            is.null(api_version) || is_scalar_character(api_version) || is_scalar_integerish(api_version),
            is.null(profile) || inherits(profile, "Profile")
        )

        self$username <- username
        self$password <- password
        self$token <- token
        self$base_url <- base_url
        self$api_version <- if (is.null(api_version)) NULL else as.character(api_version)
        self$profile <- profile

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
    #' @description Get the Personal Access Token
    get_token = function() {
        self$token
    },
    #' @description Set the DHIS2 Personal Access Token
    #' @param value The DHIS2 Personal Access Token
    set_token = function(value) {
        stopifnot(is.null(value) || is_scalar_character(value))
        self$token <- value
        invisible(self)
    },
    #' @description Clear the Personal Access Token
    clear_token = function() {
        self$set_token(NULL)
    },
    #' @description Get the base URL API
    get_base_url = function() {
        self$base_url
    },
    #' @description Set the base URL
    #' @param value The base URL
    set_base_url = function(value) {
        stopifnot(is.null(value) || is_scalar_character(value))
        self$base_url <- value
        invisible(self)
    },
    #' @description Get the pinned API version
    get_api_version = function() {
        self$api_version
    },
    #' @description Set the DHIS2 API version to pin requests to
    #' @param value The DHIS2 API version (e.g. `"40"`), or `NULL` to unpin
    set_api_version = function(value) {
        stopifnot(is.null(value) || is_scalar_character(value) || is_scalar_integerish(value))
        self$api_version <- if (is.null(value)) NULL else as.character(value)
        invisible(self)
    },
    #' @description Get profiles
    get_profile = function() {
        self$profile
    },
    #' @description Set profiles
    #' @param profile User profiles
    set_profile = function(profile) {
        stopifnot(is.null(profile) || inherits(profile, "Profile"))
        self$profile <- profile
        invisible(self)
    },
    #' @description Report if we have valid credentials
    has_cred = function() {
        has_basic <- !is.null(self$username) && is_scalar_character(self$username) &&
            !is.null(self$password) && is_scalar_character(self$password)
        has_token <- !is.null(self$token) && is_scalar_character(self$token)

        (has_basic || has_token) &&
        !is.null(self$base_url) && is_scalar_character(self$base_url)
    },
    #' @description Report if we have valid credentials
    has_valid_cred = function() {
        !is.null(self$profile) && inherits(self$profile, "Profile")
    }
))
