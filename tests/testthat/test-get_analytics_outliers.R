test_that("get_analytics_outliers function works", {

    expect_error(get_analytics_outliers(org_units = 'a', start_date = 'b', end_date = 'c'))
    expect_error(get_analytics_outliers(data_elements = 123, org_units = 'a', start_date = 'b', end_date = 'c'))
    expect_error(get_analytics_outliers(data_elements = 'a', org_units = 123, start_date = 'b', end_date = 'c'))
    expect_error(get_analytics_outliers(data_elements = 'a', org_units = 'b', start_date = 123, end_date = 'c'))
    expect_error(get_analytics_outliers(data_elements = 'a', org_units = 'b', start_date = 'c', end_date = 123))
    expect_error(get_analytics_outliers(data_elements = 'a', org_units = 'b', start_date = 'c', end_date = 'd', algorithm = 'BOGUS'))

    skip_if_no_cred()
    skip_if_offline()

    # The public demo account used for live testing lacks outlier-detection
    # authority (403 Forbidden regardless of parameters); the function
    # handles that gracefully with two warnings (the specific HTTP failure,
    # then the generic "no data") and a NULL return, rather than an error.
    expect_warning(
        expect_warning(
            result <- get_analytics_outliers(data_elements = 'lYsfXxCw6Qi',
                                             org_units = 'W6sNfkJcXGC',
                                             start_date = '2023-01-01',
                                             end_date = '2023-12-31')
        )
    )
    expect_null(result)
})
