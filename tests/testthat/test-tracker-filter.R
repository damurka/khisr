test_that("tracked_entity_filter format helper works", {

    expect_error(tracked_entity_filter(1, "eq", "V"))
    expect_error(tracked_entity_filter(c('A1', 'A2'), "eq", "V"))
    expect_error(tracked_entity_filter("A", 1, "V"))
    expect_error(tracked_entity_filter("A", "bogus", "V"))

    # null / !null require NULL values
    expect_identical(tracked_entity_filter("A", "null", NULL), splice(list2(filter = "A:null")))
    expect_identical(tracked_entity_filter("A", "!null", NULL), splice(list2(filter = "A:!null")))
    expect_error(tracked_entity_filter("A", "null", "V"))
    expect_error(tracked_entity_filter("A", "!null", "V"))

    # other operators require non-NULL values
    expect_error(tracked_entity_filter("A", "eq", NULL))

    # values can have length > 1 only for the in operator
    expect_error(tracked_entity_filter("A", "eq", c("V1", "V2")))

    # in joins with semicolons, not comma+brackets like metadata_filter()
    expect_identical(tracked_entity_filter("A", "in", c("V1", "V2")), splice(list2(filter = "A:in:V1;V2")))
    expect_identical(tracked_entity_filter("A", "in", "V1"), splice(list2(filter = "A:in:V1")))

    expect_identical(tracked_entity_filter("A", "eq", "V"), splice(list2(filter = "A:eq:V")))
    expect_identical(tracked_entity_filter("A", "sw", "V"), splice(list2(filter = "A:sw:V")))
    expect_identical(tracked_entity_filter("A", "ew", "V"), splice(list2(filter = "A:ew:V")))
    expect_identical(tracked_entity_filter("A", "like", "V"), splice(list2(filter = "A:like:V")))
    expect_identical(tracked_entity_filter("A", "ge", "V"), splice(list2(filter = "A:ge:V")))
    expect_identical(tracked_entity_filter("A", "gt", "V"), splice(list2(filter = "A:gt:V")))
    expect_identical(tracked_entity_filter("A", "le", "V"), splice(list2(filter = "A:le:V")))
    expect_identical(tracked_entity_filter("A", "lt", "V"), splice(list2(filter = "A:lt:V")))
    expect_identical(tracked_entity_filter("A", "ne", "V"), splice(list2(filter = "A:ne:V")))
})
