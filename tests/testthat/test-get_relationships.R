test_that("get_relationships function works", {

    expect_error(get_relationships())
    expect_error(get_relationships(tracked_entity = 'a', enrollment = 'b'))
    expect_error(get_relationships(tracked_entity = 'a', event = 'b'))
    expect_error(get_relationships(enrollment = 'a', event = 'b'))
    expect_error(get_relationships(tracked_entity = 'a', enrollment = 'b', event = 'c'))
    expect_error(get_relationships(tracked_entity = 123))

    skip_if_no_cred()
    skip_if_offline()

    expect_no_error(get_relationships(tracked_entity = 'qkU5JI6SQcd'))
})
