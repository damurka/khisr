test_that("get_data_store_namespaces, get_data_store_keys, and get_data_store_value functions work", {

    expect_error(get_data_store_namespaces(store = 'bogus'))
    expect_error(get_data_store_keys(namespace = 123))
    expect_error(get_data_store_value(namespace = 'a', key = 123))
    expect_error(get_data_store_value(namespace = 123, key = 'a'))

    skip_if_no_cred()
    skip_if_offline()

    namespaces <- get_data_store_namespaces()
    expect_type(namespaces, "character")
    expect_true(length(namespaces) > 0)

    keys <- get_data_store_keys(namespaces[1])
    expect_type(keys, "character")
    expect_true(length(keys) > 0)

    value <- get_data_store_value(namespaces[1], keys[1])
    expect_true(is.list(value) || is.character(value) || is.numeric(value))
})
