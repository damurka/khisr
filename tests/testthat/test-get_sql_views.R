test_that("get_sql_views and get_sql_view_data functions work", {

    expect_error(get_sql_view_data())
    expect_error(get_sql_view_data(sql_view = 123))
    expect_error(get_sql_view_data(sql_view = 'a', variables = c('unnamed_value')))

    skip_if_no_cred()
    skip_if_offline()

    views <- get_sql_views()
    expect_s3_class(views, "tbl_df")
    expect_true(all(c("id", "name", "type") %in% colnames(views)))

    # The public demo account used for live testing isn't authorised to read
    # data from any SQL view on the instance (403/409 regardless of which
    # view); the function handles that gracefully with two warnings (the
    # specific HTTP failure, then the generic "no data") and a NULL return,
    # rather than an error.
    expect_warning(expect_warning(result <- get_sql_view_data(views$id[1])))
    expect_null(result)
})
