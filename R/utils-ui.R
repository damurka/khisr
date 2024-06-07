#' Create a Theme for Messages with Bullets
#'
#' @noRd

khis_theme <- function() {
    list(
        span.field = list(transform = single_quote_if_no_color),
        span.fun = list(color = "cyan"),
        # since we're using color so much elsewhere, I think
        # the standard bullet should be "normal" color
        ".bullets .bullet-*" = list(
            "text-exdent" = 2,
            before = function(x) paste0(cli::symbol$bullet, " ")
        )
    )
}

khis_info <- function(message, ..., .envir = parent.frame(), call = caller_env()) {
    quiet <- khis_quiet() %|% is_testing()
    if (quiet) {
        return(invisible())
    }
    cli::cli_div(theme = khis_theme())
    cli::cli_inform(message = message, ..., .envir = .envir, call = call)
}

khis_abort <- function(message, ..., .envir = parent.frame(), call = caller_env()) {
    cli::cli_div(theme = khis_theme())
    cli::cli_abort(message = message, ..., .envir = .envir, call = call)
}

khis_warn <- function(message, ..., .envir = parent.frame(), call = caller_env()) {
    cli::cli_div(theme = khis_theme())
    cli::cli_warn(message = message, ..., .envir = .envir, call = call)
}

single_quote_if_no_color <- function(x) quote_if_no_color(x, "'")

quote_if_no_color <- function(x, quote = "'") {
    # TODO: if a better way appears in cli, use it
    # @gabor says: "if you want to have before and after for the no-color case
    # only, we can have a selector for that, such as:
    # span.field::no-color
    # (but, at the time I write this, cli does not support this yet)
    if (cli::num_ansi_colors() > 1) {
        x
    } else {
        paste0(quote, x, quote)
    }
}

is_testing <- function() {
    identical(Sys.getenv("TESTTHAT"), "true")
}

#' Making khisr quiet vs. loud ----
#'
#' @noRd

khis_quiet <- function() {
    getOption("khis_quiet", default = NA)
}

#' @export
#' @rdname khis-configuration
#' @param code Code to execute quietly
#' @return No return value, called for side effects
#' @examples
#'
#' \dontrun{
#'     # message: "The credentials have been set."
#'     khis_cred(username = 'username',
#'               password = 'password',
#'               base_url = 'https://dhis2-instance/api')
#'
#'     # suppress messages for a small amount of code
#'     with_khis_quiet(
#'         khis_cred(username = 'username',
#'                   password = 'password',
#'                   base_url = 'https://dhis2-instance/api')
#'     )
#' }

with_khis_quiet <- function(code) {
    withr::with_options(list(khis_quiet = TRUE), code = code)
}

#' @export
#' @rdname khis-configuration
#' @param env The environment to use for scoping
#' @return No return value, called for side effects
#' @examples
#'
#' \dontrun{
#'     # message: "The credentials have been set."
#'     khis_cred(username = 'username',
#'               password = 'password',
#'               base_url = 'https://dhis2-instance/api')
#'
#'     # suppress messages for a in a specific scope
#'     local_khis_quiet()
#'
#'     # no message
#'     khis_cred(username = 'username',
#'               password = 'password',
#'               base_url = 'https://dhis2-instance/api')
#'
#'     # clear credentials
#'     khis_cred_clear()
#' }

local_khis_quiet <- function(env = parent.frame()) {
    withr::local_options(list(khis_quiet = TRUE), .local_envir = env)
}

local_khis_loud <- function(env = parent.frame()) {
    withr::local_options(list(khis_quiet = FALSE), .local_envir = env)
}
