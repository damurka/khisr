test_that("get_system_info function works", {

    skip_if_no_cred()
    skip_if_offline()

    info <- get_system_info()
    expect_type(info, "list")
    expect_true("version" %in% names(info))
})
