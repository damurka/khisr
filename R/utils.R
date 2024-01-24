
is_testing <- function() {
    identical(Sys.getenv("TESTTHAT"), "true")
}

secret_decrypt_json <- function(path, key) {
    raw <- readBin(path, "raw", file.size(path))
    enc <- rawToChar(raw)
    invisible(secret_decrypt(enc, key = key))
}

check_scalar_character <- function(x, arg = caller_arg(x), call = caller_env()) {

    check_required(x, arg, call)

    if (!is_scalar_character(x) || nchar(x) == 0) {
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
