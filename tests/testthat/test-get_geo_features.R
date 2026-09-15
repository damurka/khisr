test_that("get_geo_features function works", {

    expect_error(get_geo_features(org_units = 123))

    skip_if_no_cred()
    skip_if_offline()

    result <- get_geo_features(org_units = 'LEVEL-2')
    expect_s3_class(result, "tbl_df")
    expect_true(all(c("id", "name", "level", "coordinates") %in% colnames(result)))
})
