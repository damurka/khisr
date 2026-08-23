test_that("get_tracked_entities function works", {

    expect_error(get_tracked_entities(program = 123))
    expect_error(get_tracked_entities(tracked_entity_type = 123))
    expect_error(get_tracked_entities(tracked_entities = 123))
    expect_error(get_tracked_entities(org_units = 123))
    expect_error(get_tracked_entities(org_unit_mode = 'BOGUS'))
    expect_error(get_tracked_entities(updated_after = 123))

    skip_if_no_cred()
    skip_if_offline()

    expect_no_error(
        get_tracked_entities(program = 'PREnRHSp3be',
                             org_units = 'IWp9dQGM0bS',
                             org_unit_mode = 'DESCENDANTS')
    )
})
