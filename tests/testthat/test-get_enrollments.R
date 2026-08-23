test_that("get_enrollments function works", {

    expect_error(get_enrollments(program = 123))
    expect_error(get_enrollments(org_units = 123))
    expect_error(get_enrollments(org_unit_mode = 'BOGUS'))
    expect_error(get_enrollments(enrolled_after = 123))

    skip_if_no_cred()
    skip_if_offline()

    expect_no_error(
        get_enrollments(program = 'IpHINAT79UW',
                        org_units = 'DiszpKrYNg8',
                        org_unit_mode = 'DESCENDANTS')
    )
})
