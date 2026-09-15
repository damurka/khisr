test_that("get_event_analytics_aggregate function works", {

    expect_error(get_event_analytics_aggregate())
    expect_error(get_event_analytics_aggregate(program = 123))
    expect_error(get_event_analytics_aggregate(program = 'a', stage = 123))

    skip_if_no_cred()
    skip_if_offline()

    expect_no_error(
        get_event_analytics_aggregate(program = 'PREnRHSp3be',
                                      stage = 'mj1stImcUCi',
                                      ou %.d% 'USER_ORGUNIT',
                                      pe %.d% 'LAST_12_MONTHS')
    )
})
