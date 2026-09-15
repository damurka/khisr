# Tracked Entity Attribute Filter

Formats a filter on a tracked entity attribute for the DHIS2 Tracker
API's `trackedEntities` endpoint, in the `attribute:operator:value` form
it expects. This is a separate, smaller operator set from
[`metadata_filter()`](https://khisr.damurka.com/reference/metadata-filter.md)
— the two are not interchangeable, and the `in` operator uses a
different value-joining convention (semicolons, no brackets).

## Usage

``` r
tracked_entity_filter(attribute, operator, values, call = caller_env())

attribute %.teq% values

attribute %.tne% values

attribute %.tgt% values

attribute %.tge% values

attribute %.tlt% values

attribute %.tle% values

attribute %.tlike% values

attribute %.tsw% values

attribute %.tew% values

attribute %.tin% values
```

## Arguments

- attribute:

  The tracked entity attribute id to filter on.

- operator:

  The comparison operator to apply.

- values:

  The value(s) to compare against. Not required for `null` and `!null`.

- call:

  The caller environment.

## Value

A spliced list with `filter` in the format `attribute:operator:value`,
suitable for passing straight into
[`get_tracked_entities()`](https://khisr.damurka.com/reference/get_tracked_entities.md).

## Details

As documented for the DHIS2 Tracker API, the supported operators are:

- `eq` - `%.teq%` - Equality

- `ge` - `%.tge%` - Greater than or equal

- `gt` - `%.tgt%` - Greater than

- `le` - `%.tle%` - Less than or equal

- `lt` - `%.tlt%` - Less than

- `ne` - `%.tne%` - Inequality

- `like` - `%.tlike%` - Match anywhere

- `sw` - `%.tsw%` - Starts with

- `ew` - `%.tew%` - Ends with

- `in` - `%.tin%` - Match one or more values

- `null` - (no infix form; call
  `tracked_entity_filter(attr, 'null', NULL)`) - Attribute has no value

- `!null` - (no infix form; call
  `tracked_entity_filter(attr, '!null', NULL)`) - Attribute has a value

The infix operators are shorthand for the equivalent
`tracked_entity_filter()` call, e.g. `w75KJ2mc4zz %.teq% 'John'` is
equivalent to `tracked_entity_filter('w75KJ2mc4zz', 'eq', 'John')`.
`null`/`!null` have no infix form since an infix operator needs a
right-hand value.

This filter is only documented for the `trackedEntities` endpoint.
DHIS2's published Tracker API docs do not describe an equivalent way to
filter `events` or `enrollments`, so
[`get_events()`](https://khisr.damurka.com/reference/get_events.md) and
[`get_enrollments()`](https://khisr.damurka.com/reference/get_enrollments.md)
reject a `filter` argument outright rather than silently sending it as
unsupported query syntax.

[`metadata_filter()`](https://khisr.damurka.com/reference/metadata-filter.md)
and its infix operators (`%.eq%`, `%.in%`, etc.) are for a different
DHIS2 API and are not interchangeable with this function — passing one
to
[`get_tracked_entities()`](https://khisr.damurka.com/reference/get_tracked_entities.md)
raises an error, since several metadata operators (e.g. `ieq`, `token`,
the anchored `like` variants) and the `in`/`!in` value-joining
convention (comma-bracketed vs semicolon) don't match what the Tracker
API expects.

## See also

Other tracker functions:
[`get_enrollments()`](https://khisr.damurka.com/reference/get_enrollments.md),
[`get_events()`](https://khisr.damurka.com/reference/get_events.md),
[`get_relationships()`](https://khisr.damurka.com/reference/get_relationships.md),
[`get_tracked_entities()`](https://khisr.damurka.com/reference/get_tracked_entities.md)

## Examples

``` r

# Tracked entities where attribute w75KJ2mc4zz equals "John"
tracked_entity_filter('w75KJ2mc4zz', 'eq', 'John')
#> <spliced>
#> $filter
#> [1] "w75KJ2mc4zz:eq:John"
#> 

# Tracked entities where attribute w75KJ2mc4zz is one of several values
tracked_entity_filter('w75KJ2mc4zz', 'in', c('John', 'Jane'))
#> <spliced>
#> $filter
#> [1] "w75KJ2mc4zz:in:John;Jane"
#> 

# Equivalent, using the infix operator
w75KJ2mc4zz %.teq% 'John'
#> <spliced>
#> $filter
#> [1] "w75KJ2mc4zz:eq:John"
#> 
```
