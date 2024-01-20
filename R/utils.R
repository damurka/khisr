
is_testing <- function() {
    identical(Sys.getenv("TESTTHAT"), "true")
}

khis_abort <- function(message, ..., .envir = parent.frame(), call = caller_env()) {
    cli::cli_abort(message = message, ..., .envir = .envir, call = call)
}

secret_decrypt_json <- function(path, key) {
    raw <- readBin(path, "raw", file.size(path))
    enc <- rawToChar(raw)
    invisible(secret_decrypt(enc, key = key))
}
