test_that("khis_cred works correctly using configuration file", {

    expect_error(khis_cred(), class = 'khis_missing_credentials')

    expect_error(
        khis_cred(config_path = 'creds.json', username = 'username'),
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
        class = 'khis_missing_credentials'
    )

    expect_error(
        khis_cred(config_path = '{ "credentials": {}}'),
        class = 'khis_missing_credentials'
    )

    expect_error(
        khis_cred(
            config_path =  system.file("extdata", "no_url_cred_conf.json", package = "khisr")),
        class = 'khis_missing_base_url'
    )

    expect_no_error(
        khis_cred(
            config_path = system.file("extdata", "valid_cred_conf.json", package = "khisr"))
    )

    expect_true(khis_has_cred())

    expect_equal(khis_username(), 'username')

    khis_cred_clear()

    expect_false(khis_has_cred())

    expect_warning(
        khis_cred(username = 'username2',
                  password = 'password2'
        )
    )

    expect_no_error(
        khis_cred(username = 'username2',
                  password = 'password2',
                  base_url="https//play.dhis2.org/demo/api"
        )
    )

    expect_true(khis_has_cred())

    expect_equal(khis_username(), 'username2')

    khis_cred_clear()

    expect_error(
        khis_cred(username = 'username2'),
        class = 'khis_missing_credentials'
    )
})

test_that("req_auth_khis_basic works correctly", {

    expect_error(
        httr2::request('https://example.com') %>% req_auth_khis_basic(),
        class = 'khis_missing_credentials'
    )

    khis_cred(
        config_path = system.file("extdata", "valid_cred_conf.json", package = "khisr"))

    expect_no_error(httr2::request('https://example.com') %>% req_auth_khis_basic())

    khis_cred_clear()
})
