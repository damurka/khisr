test_that("get_metadata functions works", {

    expect_error(get_metadata())
    expect_error(get_metadata('dataElements', fields = 12))

    skip_if_no_cred()
    skip_if_offline()

    expect_warning(get_metadata('dataElements', name %.eq% 'qwerty'))

    expect_no_error(get_metadata('dataElements', name %.like% 'malaria'))

})
