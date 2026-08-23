test_that("check_date validates dates correctly", {

    expect_error(check_date())
    expect_error(check_date("2024-13-40"))
    expect_error(check_date("not-a-date"))
    expect_error(check_date(12345))
    expect_error(check_date(c("2024-01-01", "2024-02-01")))
    expect_error(check_date(NULL))
    expect_error(check_date(NULL, can_be_null = FALSE))

    expect_no_error(check_date("2024-01-01"))
    expect_no_error(check_date(NULL, can_be_null = TRUE))
})

test_that("check_scalar_character validates scalar strings correctly", {

    expect_error(check_scalar_character())
    expect_error(check_scalar_character(123))
    expect_error(check_scalar_character(c("a", "b")))
    expect_error(check_scalar_character(NULL))
    expect_error(check_scalar_character(NA))

    expect_no_error(check_scalar_character("a"))
    # unlike check_string_vector(), an empty string is not rejected here:
    # is_empty() checks vector length (0), not string content, so a
    # length-1 "" passes
    expect_no_error(check_scalar_character(""))
})

test_that("check_string_vector validates character vectors correctly", {

    expect_error(check_string_vector())
    expect_error(check_string_vector(123))
    expect_error(check_string_vector(NULL))
    expect_error(check_string_vector(NA))
    expect_error(check_string_vector(c("a", NA)))
    expect_error(check_string_vector(c("a", "")))

    expect_no_error(check_string_vector("a"))
    expect_no_error(check_string_vector(c("a", "b")))
})

test_that("check_integerish validates scalar integers correctly", {

    expect_error(check_integerish())
    expect_error(check_integerish(NULL))
    expect_error(check_integerish(NA))
    expect_error(check_integerish(1.5))
    expect_error(check_integerish(c(1, 2)))
    expect_error(check_integerish("1"))

    expect_no_error(check_integerish(1))
    expect_no_error(check_integerish(1L))
})

test_that("check_supported_operator validates operators correctly", {

    expect_error(check_supported_operator("bogus"))
    expect_error(check_supported_operator(""))

    expect_no_error(check_supported_operator("eq"))
    expect_no_error(check_supported_operator("in"))
    expect_no_error(check_supported_operator("!null"))
})

test_that("check_is_valid_url validates urls correctly", {

    expect_error(check_is_valid_url())
    expect_error(check_is_valid_url(""))
    expect_error(check_is_valid_url(123))
    expect_error(check_is_valid_url("not-a-url"))
    expect_error(check_is_valid_url("ftp://example.com"))
    expect_error(check_is_valid_url("https://"))

    expect_true(check_is_valid_url("https://example.com"))
    expect_true(check_is_valid_url("http://example.com"))
})

test_that("chunk_ids splits ids into batches correctly", {

    expect_identical(chunk_ids(character(0)), list())
    expect_identical(chunk_ids(NULL), list())

    single <- chunk_ids("a")
    expect_length(single, 1)
    expect_identical(single[[1]], "a")

    ids <- paste0("id", 1:10)
    chunks <- chunk_ids(ids, chunk_size = 3)
    expect_length(chunks, 4)
    expect_identical(lengths(chunks), c(`1` = 3L, `2` = 3L, `3` = 3L, `4` = 1L))
    expect_identical(unlist(chunks, use.names = FALSE), ids)

    # duplicates are dropped before chunking
    deduped <- chunk_ids(c("a", "b", "a"), chunk_size = 10)
    expect_length(deduped, 1)
    expect_identical(sort(deduped[[1]]), c("a", "b"))
})
