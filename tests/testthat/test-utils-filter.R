test_that("Metadata filter format helpers works", {

    expect_error(metadata_filter(1, "in", c(1, 2)))
    expect_error(metadata_filter(c('P1', 'P2'), "in", c(1, 2)))

    # value null if and only if operator is null, !null or empty
    expect_identical(metadata_filter("P", "null", NULL), "P:null")
    expect_identical(metadata_filter("P", "!null", NULL), "P:!null")
    expect_identical(metadata_filter("P", "empty", NULL), "P:empty")
    expect_error(metadata_filter("P", "null", "V"))
    expect_error(metadata_filter("P", "!null", "V"))
    expect_error(metadata_filter("P", "empty", "V"))
    expect_error(metadata_filter("P", "O", NULL))

    # values can have length > 1 only if operator is in or !in
    # and values for in and !in always enclosed in square brackets
    expect_identical(metadata_filter("P", "in", c(1, 2)), "P:in:[1,2]")
    expect_identical(metadata_filter("P", "!in", c("1", "2")), "P:!in:[1,2]")
    expect_identical(metadata_filter("P", "in", 1), "P:in:[1]")
    expect_identical(metadata_filter("P", "!in", "2"), "P:!in:[2]")
    expect_error(metadata_filter("P", "O", c("1", "2")))

    # standard and non standard eval
    expect_identical(id %.eq% "V", "id" %.eq% "V")
    expect_identical(id %.in% c("V1", "V2"), "id" %.in% c("V1", "V2"))

    # %.in% and %.~in%
    expect_identical(P %.in% "V", "P:in:[V]")
    expect_identical(P %.~in% "V", "P:!in:[V]")
    expect_identical(P %.in% c("V_1", "V_2"), "P:in:[V_1,V_2]")
    expect_identical(P %.~in% c("V_1", "V_2"), "P:!in:[V_1,V_2]")

    # %.eq% and %.~eq% and %.ne%
    expect_identical(P %.eq% "V", "P:eq:V")
    expect_identical(P %.ieq% "V", "P:ieq:V")
    expect_identical(P %.~eq% "V", "P:!eq:V")
    expect_identical(P %.ne% "V", "P:ne:V")

    # %.like% and %.~like%
    expect_identical(P %.like% "V", "P:ilike:V")
    expect_identical(P %.~like% "V", "P:!ilike:V")

    # %.like$% and %.~like$%
    expect_identical(P %.like$% "V", "P:ilike$:V")
    expect_identical(P %.~like$% "V", "P:!ilike$:V")

    # %.^like% and %.~^like%
    expect_identical(P %.^like% "V", "P:!ilike:V")
    expect_identical(P %.~^like% "V", "P:!$ilike:V")

    # %.Like$% and %.~Like$%
    expect_identical(P %.Like$% "V", "P:like$:V")
    expect_identical(P %.~Like$% "V", "P:!like$:V")

    # %.^Like% and %.~^Like%
    expect_identical(P %.^Like% "V", "P:$like:V")
    expect_identical(P %.~^Like% "V", "P:!$like:V")

    # %.token% and %.~token%
    expect_identical(P %.token% "V", "P:token:V")
    expect_identical(P %.~token% "V", "P:!token:V")

    # %.le%, %.It% %.ge% %.gt% and %.~.Like%
    expect_identical(P %.le% "V", "P:le:V")
    expect_identical(P %.lt% "V", "P:lt:V")
    expect_identical(P %.ge% "V", "P:ge:V")
    expect_identical(P %.gt% "V", "P:gt:V")
    expect_identical(P %.~Like$% "V", "P:!like$:V")
    expect_identical(P %.~Like% "V", "P:!like:V")

})
