#' Operators the DHIS2 Tracker API documents for `trackedEntities` filters.
#' Deliberately a different, smaller set than [metadata_filter()]'s — see
#' [tracked_entity_filter()] for why the two are not interchangeable.
#' @noRd
tracker_filter_operators <- c('eq', 'ge', 'gt', 'le', 'lt', 'ne', 'like', 'sw', 'ew', 'in', 'null', '!null')

#' Tracked Entity Attribute Filter
#'
#' Formats a filter on a tracked entity attribute for the DHIS2 Tracker API's
#' `trackedEntities` endpoint, in the `attribute:operator:value` form it
#' expects. This is a separate, smaller operator set from [metadata_filter()]
#' — the two are not interchangeable, and the `in` operator uses a different
#' value-joining convention (semicolons, no brackets).
#'
#' @details
#' As documented for the DHIS2 Tracker API, the supported operators are:
#'
#' * `eq`    - Equality
#' * `ge`    - Greater than or equal
#' * `gt`    - Greater than
#' * `le`    - Less than or equal
#' * `lt`    - Less than
#' * `ne`    - Inequality
#' * `like`  - Match anywhere
#' * `sw`    - Starts with
#' * `ew`    - Ends with
#' * `in`    - Match one or more values
#' * `null`  - Attribute has no value
#' * `!null` - Attribute has a value
#'
#' This filter is only documented for the `trackedEntities` endpoint. DHIS2's
#' published Tracker API docs do not describe an equivalent way to filter
#' `events` or `enrollments`, so [get_events()] and [get_enrollments()]
#' reject a `filter` argument outright rather than silently sending it as
#' unsupported query syntax.
#'
#' [metadata_filter()] and its infix operators (`%.eq%`, `%.in%`, etc.) are
#' for a different DHIS2 API and are not interchangeable with this function
#' — passing one to [get_tracked_entities()] raises an error, since several
#' metadata operators (e.g. `ieq`, `token`, the anchored `like` variants) and
#' the `in`/`!in` value-joining convention (comma-bracketed vs semicolon)
#' don't match what the Tracker API expects.
#'
#' @param attribute The tracked entity attribute id to filter on.
#' @param operator The comparison operator to apply.
#' @param values The value(s) to compare against. Not required for `null`
#'   and `!null`.
#' @param call The caller environment.
#'
#' @return A spliced list with `filter` in the format `attribute:operator:value`,
#'   suitable for passing straight into [get_tracked_entities()].
#'
#' @examples
#'
#' # Tracked entities where attribute w75KJ2mc4zz equals "John"
#' tracked_entity_filter('w75KJ2mc4zz', 'eq', 'John')
#'
#' # Tracked entities where attribute w75KJ2mc4zz is one of several values
#' tracked_entity_filter('w75KJ2mc4zz', 'in', c('John', 'Jane'))
#'
#' @family tracker functions
#'
#' @export

tracked_entity_filter <- function(attribute,
                                  operator,
                                  values,
                                  call = caller_env()) {

    check_scalar_character(attribute, arg = caller_arg(attribute), call = call)
    check_scalar_character(operator, arg = caller_arg(operator), call = call)

    if (!(operator %in% tracker_filter_operators)) {
        khis_abort(
            message = c('x' = '{.arg {caller_arg(operator)}} is not a supported tracked entity filter operator'),
            call = call
        )
    }

    if (operator %in% c('null', '!null')) {
        if (!is_empty(values)) {
            khis_abort(
                message = c(
                    'x' = '{.arg {caller_arg(values)}} must be {.code NULL}',
                    '!' = '{.code NULL} values are required for the {.val null} and {.val !null} operators'
                ),
                call = call
            )
        }
        return(splice(list2(filter = str_c(attribute, ':', operator))))
    }

    check_required(values, arg = caller_arg(values), call = call)
    if (is_empty(values) || any(is.na(values))) {
        khis_abort(
            message = c('x' = '{.arg {caller_arg(values)}} cannot be {.code NULL} or {.code NA}'),
            call = call
        )
    }

    values <- unique(values)
    if (length(values) > 1 && operator != 'in') {
        khis_abort(
            message = c('x' = 'A vector of values is only supported for the {.val in} operator'),
            call = call
        )
    }

    value_str <- if (operator == 'in') str_c(values, collapse = ';') else values

    splice(list2(filter = str_c(attribute, ':', operator, ':', value_str)))
}
