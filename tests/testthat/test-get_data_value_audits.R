test_that("get_data_value_audits function works", {

    expect_error(get_data_value_audits(data_elements = 123))
    expect_error(get_data_value_audits(org_units = 123))
    expect_error(get_data_value_audits(periods = 123))

    skip_if_no_cred()
    skip_if_offline()

    # This demo instance has no recorded edit history for any data value
    # tried.
    expect_warning(
        result <- get_data_value_audits(data_elements = 'lYsfXxCw6Qi',
                                        org_units = 'W6sNfkJcXGC',
                                        periods = '202301')
    )
    expect_null(result)
})
