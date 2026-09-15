test_that("get_complete_data_set_registrations function works", {

    expect_error(get_complete_data_set_registrations())
    expect_error(get_complete_data_set_registrations(data_sets = 123))
    expect_error(get_complete_data_set_registrations(data_sets = 'a', org_units = 123))
    expect_error(get_complete_data_set_registrations(data_sets = 'a', org_units = 'b', periods = 123))
    expect_error(get_complete_data_set_registrations(data_sets = 'a', org_units = 'b', periods = '202301', children = 'yes'))

    skip_if_no_cred()
    skip_if_offline()

    expect_no_error(
        get_complete_data_set_registrations(data_sets = 'VEM58nY22sO',
                                            org_units = 'W6sNfkJcXGC',
                                            children = TRUE,
                                            periods = '202301')
    )
})
