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

test_that("tracked entity infix operators work and match the base function", {

    # standard and non standard eval
    expect_identical(A %.teq% "V", "A" %.teq% "V")
    expect_identical(A %.tin% c("V1", "V2"), "A" %.tin% c("V1", "V2"))

    expect_identical(A %.teq% "V", tracked_entity_filter("A", "eq", "V"))
    expect_identical(A %.tne% "V", tracked_entity_filter("A", "ne", "V"))
    expect_identical(A %.tgt% "V", tracked_entity_filter("A", "gt", "V"))
    expect_identical(A %.tge% "V", tracked_entity_filter("A", "ge", "V"))
    expect_identical(A %.tlt% "V", tracked_entity_filter("A", "lt", "V"))
    expect_identical(A %.tle% "V", tracked_entity_filter("A", "le", "V"))
    expect_identical(A %.tlike% "V", tracked_entity_filter("A", "like", "V"))
    expect_identical(A %.tsw% "V", tracked_entity_filter("A", "sw", "V"))
    expect_identical(A %.tew% "V", tracked_entity_filter("A", "ew", "V"))
    expect_identical(A %.tin% c("V1", "V2"), tracked_entity_filter("A", "in", c("V1", "V2")))

    # in joins with semicolons, not comma+brackets like %.in%
    expect_identical(A %.tin% c("V1", "V2"), splice(list2(filter = "A:in:V1;V2")))

    # filters built via the infix operators pass check_tracker_filters(), the
    # same as filters built via tracked_entity_filter() directly
    expect_no_error(khisr:::check_tracker_filters(list2(A %.teq% "V")))
    expect_no_error(khisr:::check_tracker_filters(list2(A %.tin% c("V1", "V2"))))
})
