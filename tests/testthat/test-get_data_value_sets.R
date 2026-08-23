test_that("get_data_value_sets function works", {

    expect_error(get_data_value_sets())
    expect_error(get_data_value_sets(data_elements = 123))
    expect_error(get_data_value_sets(data_sets = 'a', org_units = 123))
    expect_error(get_data_value_sets(data_sets = 'a'))
    expect_error(get_data_value_sets(data_sets = 'a', org_units = 'b'))
    expect_error(get_data_value_sets(data_sets = 'a', org_units = 'b', periods = 123))
    expect_error(get_data_value_sets(data_sets = 'a', org_units = 'b', periods = '202301', children = 'yes'))

    skip_if_no_cred()
    skip_if_offline()

    expect_no_error(
        get_data_value_sets(data_sets = 'WWh5hbCmvND',
                            org_units = 'DiszpKrYNg8',
                            children = TRUE,
                            periods = '202301')
    )
})
