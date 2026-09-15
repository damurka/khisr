test_that("get_file_resources function works", {

    skip_if_no_cred()
    skip_if_offline()

    result <- get_file_resources(contentType %.like% 'image')
    expect_s3_class(result, "tbl_df")
    expect_true(all(c("id", "name", "contentType", "contentLength") %in% colnames(result)))
})
