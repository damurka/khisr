test_that("check_tracker_filters accepts tracked_entity_filter() operators", {

    expect_no_error(khisr:::check_tracker_filters(list2(tracked_entity_filter('w75', 'eq', 'John'))))
    expect_no_error(khisr:::check_tracker_filters(list2(tracked_entity_filter('w75', 'in', c('John', 'Jane')))))
    expect_no_error(khisr:::check_tracker_filters(list2(tracked_entity_filter('w75', 'null', NULL))))
    expect_no_error(khisr:::check_tracker_filters(list2()))
})

test_that("check_tracker_filters rejects metadata_filter() operators the Tracker API doesn't support", {

    # 'in' exists in both, but metadata_filter()'s comma-bracket value syntax
    # is not what the Tracker API expects (semicolon-separated, no brackets)
    expect_error(khisr:::check_tracker_filters(list2(w75 %.in% c('John', 'Jane'))))
    expect_error(khisr:::check_tracker_filters(list2(w75 %.~in% 'John')))

    # operators with no Tracker API equivalent at all
    expect_error(khisr:::check_tracker_filters(list2(w75 %.ieq% 'John')))
    expect_error(khisr:::check_tracker_filters(list2(w75 %.~eq% 'John')))
    expect_error(khisr:::check_tracker_filters(list2(w75 %.token% 'John')))
    expect_error(khisr:::check_tracker_filters(list2(w75 %.~token% 'John')))
    expect_error(khisr:::check_tracker_filters(list2(w75 %.^Like% 'John')))
    expect_error(khisr:::check_tracker_filters(list2(w75 %.~^Like% 'John')))
    expect_error(khisr:::check_tracker_filters(list2(w75 %.Like$% 'John')))
    expect_error(khisr:::check_tracker_filters(list2(w75 %.~Like$% 'John')))
    expect_error(khisr:::check_tracker_filters(list2(w75 %.like% 'John')))
    expect_error(khisr:::check_tracker_filters(list2(w75 %.~like% 'John')))
    expect_error(khisr:::check_tracker_filters(list2(w75 %.^like% 'John')))
    expect_error(khisr:::check_tracker_filters(list2(w75 %.~^like% 'John')))
    expect_error(khisr:::check_tracker_filters(list2(w75 %.like$% 'John')))
    expect_error(khisr:::check_tracker_filters(list2(w75 %.~like$% 'John')))
})

test_that("check_tracker_filters accepts metadata_filter() operators that happen to overlap", {

    # eq, ne, gt, ge, lt, le, Like produce the same shape for a single value,
    # so they pass through — they are not guaranteed to mean the same thing
    # server-side, but they are not blocked on syntax grounds
    expect_no_error(khisr:::check_tracker_filters(list2(w75 %.eq% 'John')))
    expect_no_error(khisr:::check_tracker_filters(list2(w75 %.ne% 'John')))
    expect_no_error(khisr:::check_tracker_filters(list2(w75 %.gt% 'John')))
    expect_no_error(khisr:::check_tracker_filters(list2(w75 %.ge% 'John')))
    expect_no_error(khisr:::check_tracker_filters(list2(w75 %.lt% 'John')))
    expect_no_error(khisr:::check_tracker_filters(list2(w75 %.le% 'John')))
    expect_no_error(khisr:::check_tracker_filters(list2(w75 %.Like% 'John')))
})

test_that("reject_tracker_filter blocks any filter argument", {

    expect_error(khisr:::reject_tracker_filter(list2(tracked_entity_filter('w75', 'eq', 'John')), fn = 'get_events'))
    expect_error(khisr:::reject_tracker_filter(list2(w75 %.eq% 'John'), fn = 'get_enrollments'))
    expect_no_error(khisr:::reject_tracker_filter(list2(status = 'ACTIVE'), fn = 'get_events'))
    expect_no_error(khisr:::reject_tracker_filter(list2(), fn = 'get_events'))
})

test_that("get_events and get_enrollments reject any filter argument", {

    expect_error(get_events(w75 %.eq% 'John'))
    expect_error(get_events(tracked_entity_filter('w75', 'eq', 'John')))
    expect_error(get_enrollments(w75 %.eq% 'John'))
    expect_error(get_enrollments(tracked_entity_filter('w75', 'eq', 'John')))
})
