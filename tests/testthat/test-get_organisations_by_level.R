test_that("get_organisations_by_level function works", {

    expect_error(get_organisations_by_level(level = 1.1))
    expect_error(get_organisations_by_level(level = NULL))
    expect_error(get_organisations_by_level(level = NA))
    expect_error(get_organisations_by_level(level = c(1,2)))
    expect_error(get_organisations_by_level(level = 10))

    expect_error(get_organisations_by_level(org_ids = 123))
    expect_error(get_organisations_by_level(org_ids = ''))

    skip_if_no_cred()
    skip_if_offline()

    expect_warning(get_organisations_by_level(org_ids = '1234'))

    expect_no_error(get_organisations_by_level())
    expect_no_error(get_organisations_by_level(level = 3))
})

test_that("get_organisations_by_level includes ancestor id columns", {

    skip_if_no_cred()
    skip_if_offline()

    level1 <- get_organisations_by_level(level = 1)
    expect_true(all(c('id') %in% colnames(level1)))
    expect_false(any(grepl('_id$', setdiff(colnames(level1), 'id'))))

    level2 <- get_organisations_by_level(level = 2)
    expect_true(any(grepl('_id$', colnames(level2))))
    expect_equal(nrow(level2), length(unique(level2$id)))
})
