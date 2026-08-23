test_that("get_enrollment_analytics function works", {

    expect_error(get_enrollment_analytics())
    expect_error(get_enrollment_analytics(program = 123))

    skip_if_no_cred()
    skip_if_offline()

    expect_no_error(
        get_enrollment_analytics(program = 'IpHINAT79UW',
                                 ou %.d% 'USER_ORGUNIT',
                                 pe %.d% 'LAST_YEAR')
    )
})
