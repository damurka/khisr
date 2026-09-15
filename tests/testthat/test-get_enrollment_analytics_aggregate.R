test_that("get_enrollment_analytics_aggregate function works", {

    expect_error(get_enrollment_analytics_aggregate())
    expect_error(get_enrollment_analytics_aggregate(program = 123))

    skip_if_no_cred()
    skip_if_offline()

    expect_no_error(
        get_enrollment_analytics_aggregate(program = 'PREnRHSp3be',
                                           ou %.d% 'USER_ORGUNIT',
                                           pe %.d% 'LAST_12_MONTHS')
    )
})
