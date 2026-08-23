test_that("get_events function works", {

    expect_error(get_events(program = 123))
    expect_error(get_events(program_stage = 123))
    expect_error(get_events(org_unit = 123))
    expect_error(get_events(org_unit = c('a', 'b')))
    expect_error(get_events(org_unit_mode = 'BOGUS'))
    expect_error(get_events(occurred_after = 123))

    skip_if_no_cred()
    skip_if_offline()

    expect_no_error(
        get_events(program = 'IpHINAT79UW',
                  org_unit = 'DiszpKrYNg8',
                  org_unit_mode = 'DESCENDANTS')
    )
})
