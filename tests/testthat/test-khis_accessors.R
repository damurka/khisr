test_that("khis_base_url, khis_api_version, and khis_display_name work with an explicit auth", {

    auth <- init_AuthCred(username = 'u', password = 'p',
                          base_url = 'https://example.com', api_version = '40')

    expect_equal(khis_base_url(auth = auth), 'https://example.com')
    expect_equal(khis_api_version(auth = auth), '40')
    expect_null(khis_display_name(auth = auth))

    profile <- init_Profile(display_name = 'Jane Doe')
    auth_with_profile <- init_AuthCred(username = 'u', password = 'p',
                                       base_url = 'https://example.com', profile = profile)
    expect_equal(khis_display_name(auth = auth_with_profile), 'Jane Doe')
})

test_that("khis_base_url, khis_api_version, and khis_display_name fall back to the global auth", {

    # Other test files authenticate globally via helper.R and rely on that
    # staying set for their own live assertions, so this checks the
    # no-global-auth behaviour via an explicit empty AuthCred passed through
    # `auth`, rather than calling khis_cred_clear() on the shared global state.
    empty_auth <- init_AuthCred()

    expect_null(khis_base_url(auth = empty_auth))
    expect_null(khis_api_version(auth = empty_auth))
    expect_null(khis_display_name(auth = empty_auth))
})

test_that("with_khis_quiet and local_khis_quiet scope the khis_quiet option", {

    expect_true(is.na(getOption('khis_quiet', default = NA)))

    with_khis_quiet({
        expect_true(getOption('khis_quiet'))
    })
    expect_true(is.na(getOption('khis_quiet', default = NA)))

    local({
        local_khis_quiet()
        expect_true(getOption('khis_quiet'))
    })
    expect_true(is.na(getOption('khis_quiet', default = NA)))
})

test_that("get_user_profile function works", {

    skip_if_no_cred()
    skip_if_offline()

    profile <- get_user_profile()
    expect_type(profile, "list")
    expect_true("username" %in% names(profile))
})
