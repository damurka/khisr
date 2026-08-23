test_that("get_data_elements_with_category_options function works", {

    expect_error(get_data_elements_with_category_options())
    expect_error(get_data_elements_with_category_options(123))

    skip_if_no_cred()
    skip_if_offline()

    expect_warning(get_data_elements_with_category_options('123456'))

    expect_no_error(get_data_elements_with_category_options('lYsfXxCw6Qi'))
})
