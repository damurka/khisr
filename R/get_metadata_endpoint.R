#' Get Metadata from Specified Endpoints
#'
#' Wrappers for [get_metadata()] that retrieves data from a specific KHIS API endpoint.
#'
#' @param values The values to filter against.
#' @param by The property on the metadata you want to filter on. The options
#'   include `'id'` (default), `'name'`,  `'code'` and `'shortName`
#' @param fields The specific columns to be returned in the tibble. The default
#'    NULL will return the `"id"` and `"name"`.
#' @inheritDotParams get_metadata retry verbosity timeout
#'
#' @return A tibble with the KHIS metadata response.
#'
#' @export
#'
#' @examplesIf khis_has_cred()
#'
#' # Get the data elements by id
#' get_data_elements(values = c('VR7vdS7P0Gb', 'gQro1y7Rsbq'), by = 'id')
#'
#' @name metadata-endpoint

get_categories <- function(values,
                           by = c('id', 'name', 'code', 'shortName'),
                           fields = NULL,
                           ...) {
    get_metadata_endpoint('categories',
                          values = values,
                          by = by,
                          fields = fields,
                          ...)
}

#' @rdname metadata-endpoint
#' @export

get_category_combos <- function(values,
                                by = c('id', 'name', 'code', 'shortName'),
                                fields = NULL,
                                ...) {
    get_metadata_endpoint('categoryCombos',
                          values = values,
                          by = by,
                          fields = fields,
                          ...)
}

#' @rdname metadata-endpoint
#' @export

get_category_option_combos <- function(values,
                                       by = c('id', 'name', 'code', 'shortName'),
                                       fields = NULL,
                                       ...) {
    get_metadata_endpoint('categoryOptionCombos',
                          values = values,
                          by = by,
                          fields = fields,
                          ...)
}

#' @rdname metadata-endpoint
#' @export

get_category_option_group_sets <- function(values,
                                           by = c('id', 'name', 'code', 'shortName'),
                                           fields = NULL,
                                           ...) {
    get_metadata_endpoint('categoryOptionGroupSets',
                          values = values,
                          by = by,
                          fields = fields,
                          ...)
}

#' @rdname metadata-endpoint
#' @export

get_category_option_groups <- function(values,
                                       by = c('id', 'name', 'code', 'shortName'),
                                       fields = NULL,
                                       ...) {
    get_metadata_endpoint('categoryOptionGroups',
                          values = values,
                          by = by,
                          fields = fields,
                          ...)
}

#' @rdname metadata-endpoint
#' @export

get_category_options <- function(values,
                                by = c('id', 'name', 'code', 'shortName'),
                                fields = NULL,
                                ...) {
    get_metadata_endpoint('categoryOptions',
                          values = values,
                          by = by,
                          fields = fields,
                          ...)
}

#' @rdname metadata-endpoint
#' @export

get_data_element_group_sets <- function(values,
                                        by = c('id', 'name', 'code', 'shortName'),
                                        fields = NULL,
                                        ...) {
    get_metadata_endpoint('dataElementGroupSets',
                          values = values,
                          by = by,
                          fields = fields,
                          ...)
}

#' @rdname metadata-endpoint
#' @export

get_data_element_groups <- function(values,
                                    by = c('id', 'name', 'code', 'shortName'),
                                    fields = NULL,
                                    ...) {
    get_metadata_endpoint('dataElementGroups',
                          values = values,
                          by = by,
                          fields = fields,
                          ...)
}

#' @rdname metadata-endpoint
#' @export

get_data_elements <- function(values,
                              by = c('id', 'name', 'code', 'shortName'),
                              fields = NULL,
                              ...) {
    get_metadata_endpoint('dataElements',
                          values = values,
                          by = by,
                          fields = fields,
                          ...)
}

#' @rdname metadata-endpoint
#' @export

get_data_sets <- function(values,
                          by = c('id', 'name', 'code', 'shortName'),
                          fields = NULL,
                          ...) {
    get_metadata_endpoint('dataSets',
                          values = values,
                          by = by,
                          fields = fields,
                          ...)
}

#' @rdname metadata-endpoint
#' @export

get_user_groups <- function(values,
                            by = c('id', 'name', 'code', 'shortName'),
                            fields = NULL,
                            ...) {
    get_metadata_endpoint('userGroups',
                          values = values,
                          by = by,
                          fields = fields,
                          ...)
}

#' @rdname metadata-endpoint
#' @export

get_indicator_group_sets <- function(values,
                                     by = c('id', 'name', 'code', 'shortName'),
                                     fields = NULL,
                                     ...) {
    get_metadata_endpoint('indicatorGroupSets',
                          values = values,
                          by = by,
                          fields = fields,
                          ...)
}

#' @rdname metadata-endpoint
#' @export

get_indicator_groups <- function(values,
                                 by = c('id', 'name', 'code', 'shortName'),
                                 fields = NULL,
                                 ...) {
    get_metadata_endpoint('indicatorGroups',
                          values = values,
                          by = by,
                          fields = fields,
                          ...)
}

#' @rdname metadata-endpoint
#' @export

get_indicators <- function(values,
                           by = c('id', 'name', 'code', 'shortName'),
                           fields = NULL,
                           ...) {
    get_metadata_endpoint('indicators',
                          values = values,
                          by = by,
                          fields = fields,
                          ...)
}

#' @rdname metadata-endpoint
#' @export

get_option_group_sets <- function(values,
                                  by = c('id', 'name', 'code', 'shortName'),
                                  fields = NULL,
                                  ...) {
    get_metadata_endpoint('optionGroupSets',
                          values = values,
                          by = by,
                          fields = fields,
                          ...)
}

#' @rdname metadata-endpoint
#' @export

get_option_groups <- function(values,
                              by = c('id', 'name', 'code', 'shortName'),
                              fields = NULL,
                              ...) {
    get_metadata_endpoint('optionGroups',
                          values = values,
                          by = by,
                          fields = fields,
                          ...)
}

#' @rdname metadata-endpoint
#' @export

get_option_sets <- function(values,
                            by = c('id', 'name', 'code', 'shortName'),
                            fields = NULL,
                            ...) {
    get_metadata_endpoint('optionSets',
                          values = values,
                          by = by,
                          fields = fields,
                          ...)
}

#' @rdname metadata-endpoint
#' @export

get_options <- function(values,
                        by = c('id', 'name', 'code', 'shortName'),
                        fields = NULL,
                        ...) {
    get_metadata_endpoint('options',
                          values = values,
                          by = by,
                          fields = fields,
                          ...)
}

#' @rdname metadata-endpoint
#' @export

get_organisation_unit_groupsets <- function(values,
                                            by = c('id', 'name', 'code', 'shortName'),
                                            fields = NULL,
                                            ...) {
    get_metadata_endpoint('organisationUnitGroupSets',
                          values = values,
                          by = by,
                          fields = fields,
                          ...)
}

#' @rdname metadata-endpoint
#' @export

get_organisation_unit_groups <- function(values,
                                         by = c('id', 'name', 'code', 'shortName'),
                                         fields = NULL,
                                         ...) {
    get_metadata_endpoint('organisationUnitGroups',
                          values = values,
                          by = by,
                          fields = fields,
                          ...)
}

#' @rdname metadata-endpoint
#' @export

get_organisation_units <- function(values,
                                   by = c('id', 'name', 'code', 'shortName'),
                                   fields = NULL,
                                   ...) {
    get_metadata_endpoint('organisationUnits',
                          values = values,
                          by = by,
                          fields = fields,
                          ...)
}

#' @rdname metadata-endpoint
#' @export

get_dimensions <- function(values,
                           by = c('id', 'name', 'code', 'shortName'),
                           fields = NULL,
                           ...) {
    get_metadata_endpoint('dimensions',
                          values = values,
                          by = by,
                          fields = fields,
                          ...)
}

get_metadata_endpoint <- function(endpoint,
                                  values,
                                  by = c('id', 'name', 'code', 'shortName'),
                                  fields = NULL,
                                  ...) {
    check_required(endpoint)
    check_string_vector(values)

    default_fields <- if (is_empty(fields)) {
        c(by, 'id', 'name')
    } else if (!any(str_detect(fields, 'name'))) {
        c(by, fields, 'name')
    } else {
        fields
    }
    default_fields <- str_unique(str_replace_all(default_fields, ' ', ''))

    by <- arg_match(by)
    unique_values <- str_unique(values)

    data <- get_metadata(endpoint,
                         fields = default_fields,
                         by %.in% unique_values,
                         ...)
    return(data)
}
