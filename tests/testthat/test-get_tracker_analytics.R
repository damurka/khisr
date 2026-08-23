test_that("parse_analytics_rows parses headers/rows into a typed tibble", {

    headers <- list(
        list(name = "dx", valueType = "TEXT"),
        list(name = "value", valueType = "NUMBER")
    )
    rows <- list(
        list("de1", "12"),
        list("de2", "7")
    )

    res <- khisr:::parse_analytics_rows(headers, rows)

    expect_s3_class(res, "tbl_df")
    expect_named(res, c("dx", "value"))
    expect_identical(res$dx, c("de1", "de2"))
    expect_type(res$value, "double")
    expect_identical(res$value, c(12, 7))
})

test_that("parse_analytics_rows returns NULL for an empty result", {

    headers <- list(list(name = "dx", valueType = "TEXT"))

    expect_null(khisr:::parse_analytics_rows(headers, list()))
    expect_null(khisr:::parse_analytics_rows(headers, NULL))
})
