
is_testing <- function() {
    identical(Sys.getenv("TESTTHAT"), "true")
}

secret_decrypt_json <- function(path, key) {
    raw <- readBin(path, "raw", file.size(path))
    enc <- rawToChar(raw)
    invisible(secret_decrypt(enc, key = key))
}

# secret_encrypt_json <- function(json, path = NULL, key) {
#     if (!jsonlite::validate(json)) {
#         json <- readChar(json, file.info(json)$size - 1)
#     }
#     enc <- secret_encrypt(json, key = key)
#
#     if(!is.null(path)) {
#         is_string(path)
#         writeBin(enc, path)
#     }
#
#     invisible(enc)
# }

check_scalar_character <- function(x, arg = caller_arg(x), call = caller_env()) {

    check_required(x, arg, call)

    if (!is_scalar_character(x) || is_empty(x)) {
        khis_abort(c('x' = '{.arg {arg}} should be scalar string'),
                   call = call)
    }
}

check_string_vector <- function(vec, arg = caller_arg(vec), call = caller_env()) {

    check_required(vec, arg = arg, call = call)

    is_string <- is_character(vec)
    no_null_na <- !any(is_null(vec) | is.na(vec))
    not_empty <- vec != ""

    if (!all(is_string, no_null_na, not_empty)) {
        khis_abort(
            message = c(
                "x" = "{.arg {arg}} contains invalid values",
                "!" = "Provide values without {.code NA}, {.code NULL} or empty string"
            ),
            call = call
        )
    }
}

check_integerish <- function(vec, arg = caller_arg(vec), call = caller_env()) {
    check_required(vec, arg = arg, call = call)

    is_integer <- is_scalar_integerish(vec)
    no_null_na <- !any(is_null(vec) | is.na(vec))

    if (!all(is_integer, no_null_na)) {
        khis_abort(
            message = c(
                "x" = "{.arg {arg}} is not an integer",
                "!" = "Provide scalar integer value without {.code NA}, {.code NULL}"
            ),
            call = call
        )
    }
}

check_level_supported <- function(level, arg = caller_arg(level), call = caller_env()) {
    org_levels <- get_organisation_unit_levels(fields = "name,level")
    if (!level %in% org_levels$level) {
        khis_abort(
            c(
                'x' = "Invalid level specified",
                "The organisation level is invalid"
            ),
            call = call
        )
    }
    return(org_levels)
}

check_supported_operator <- function(x, arg = caller_arg(x), call = caller_env()) {
    symbols <- c(
        'eq', '!eq', 'ieq', 'ne',
        'like', '!like', '$like', '!$like', 'like$', '!like$',
        'ilike', '!ilike', '$ilike', '!$ilike', 'ilike$', '!ilike$',
        'gt', 'ge', 'lt', 'le',
        'null', '!null', 'empty',
        'token', '!token',
        'in', '!in'
    )

    if (!(x %in% symbols)) {
        khis_abort(
            message = c(
                "x" = "{.arg {arg}} is not a supported operator"
            ),
            call = call
        )
    }
}

check_has_credentials <- function(call = caller_env()) {
    if (!khis_has_cred()) {
        khis_abort(
            message = c(
                "x" = "Missing credentials",
                "!" = "Please set the credentials by calling {.fun khis_cred}"
            ),
            class = 'khis_missing_credentials',
            call = call
        )
    }
}
