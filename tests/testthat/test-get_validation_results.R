test_that("get_validation_results function works", {

    expect_error(get_validation_results())
    expect_error(get_validation_results(org_units = 123, start_date = 'a', end_date = 'b'))
    expect_error(get_validation_results(org_units = 'a', start_date = 123, end_date = 'b'))
    expect_error(get_validation_results(org_units = 'a', start_date = 'b', end_date = 123))

    skip_if_no_cred()
    skip_if_offline()

    expect_no_error(
        get_validation_results(org_units = 'IWp9dQGM0bS',
                               start_date = '2023-01-01',
                               end_date = '2023-12-31')
    )
})
