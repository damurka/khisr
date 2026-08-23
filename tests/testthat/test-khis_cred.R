test_that("khis_cred works correctly using configuration file", {

    skip_if_offline()

    expect_error(khis_cred(), class = 'khis_missing_credentials')

    expect_error(
        khis_cred(config_path = 'creds.json', username = 'username'),
        class = 'khis_multiple_credentials'
    )

    expect_error(
        khis_cred(config_path = 'creds.json', password = 'password'),
        class = 'khis_multiple_credentials'
    )

    expect_error(
        khis_cred(config_path ='does-not-exist.json'),
        class = 'khis_invalid_config_path'
    )

    expect_error(khis_cred(
        config_path = system.file("extdata", "empty_cred_conf.json", package = "khisr")),
        class = 'khis_invalid_config_path'
    )

    expect_error(
        khis_cred(config_path = system.file("extdata", "blank_cred_conf.json", package = "khisr")),
        class = 'khis_invalid_credentials'
    )

    expect_error(
        khis_cred(config_path = '{ "credentials": {}}'),
        class = 'khis_invalid_credentials'
    )

    # expect_error(
    #     khis_cred(
    #         config_path =  system.file("extdata", "no_url_cred_conf.json", package = "khisr")),
    #     class = 'khis_missing_base_url'
    # )

    skip_if_server_error()

    expect_no_error(
        khis_cred(
            config_path = system.file("extdata", "valid_cred_conf.json", package = "khisr"))
    )

    expect_true(khis_has_cred())

    expect_equal(khis_username(), 'dodoma')

    khis_cred_clear()

    expect_false(khis_has_cred())

    expect_error(
        khis_cred(username = 'username2',
                  password = 'password2',
                  server = NULL
        )
    )

    expect_no_error(
        khis_cred(username = 'dodoma',
                  password = 'Ytrewq!23456',
                  server="https://test.hiskenya.org"
        )
    )

    expect_true(khis_has_cred())

    expect_equal(khis_username(), 'dodoma')

    khis_cred_clear()

    expect_error(
        khis_cred(username = 'username2'),
        class = 'khis_invalid_credentials'
    )
})

test_that("khis_cred works correctly with a Personal Access Token", {

    skip_if_offline()

    expect_error(
        khis_cred(token = 'sometoken', username = 'username'),
        class = 'khis_multiple_credentials'
    )

    expect_error(
        khis_cred(token = 'sometoken', password = 'password'),
        class = 'khis_multiple_credentials'
    )

    expect_error(
        khis_cred(config_path = 'creds.json', token = 'sometoken'),
        class = 'khis_multiple_credentials'
    )

    expect_error(
        khis_cred(token = '', server = 'https://test.hiskenya.org'),
        class = 'khis_invalid_credentials'
    )

    expect_error(
        khis_cred(token = 123, server = 'https://test.hiskenya.org'),
        class = 'khis_invalid_credentials'
    )
})

test_that("req_auth_khis works correctly", {

    expect_error(
        httr2::request('https://example.com') %>% req_auth_khis(),
        class = 'khis_missing_credentials'
    )

    skip_if_server_error()

    khis_cred(
        config_path = system.file("extdata", "valid_cred_conf.json", package = "khisr"))

    expect_no_error(httr2::request('https://example.com') %>% req_auth_khis())

    khis_cred_clear()
})

test_that("req_auth_khis uses a Personal Access Token when configured", {

    auth <- khisr:::init_AuthCred(token = "d2pat_test", base_url = "https://example.com")
    req <- httr2::request('https://example.com') %>% req_auth_khis(auth = auth)

    # req_headers_redacted() stores the value behind a weak reference rather
    # than as a plain string, so it never appears in verbose/debug output or
    # a printed request; this is httr2's supported way to check that
    expect_false(is.character(req$headers$Authorization))
    expect_identical(
        capture.output(print(req))[grep("Authorization", capture.output(print(req)))],
        "* Authorization: <REDACTED>"
    )
})
