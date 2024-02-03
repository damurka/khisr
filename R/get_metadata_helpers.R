#' Metadata Helper Functions
#'
#' Wrappers for [get_metadata()] that retrieves data from a specific KHIS API endpoint.
#'
#' @param ... One or more metadata filters in key-value pairs.
#' @inheritParams get_metadata
#' @inheritDotParams get_metadata -endpoint
#'
#' @return A tibble with the KHIS metadata response.
#'
#' @export
#'
#' @examplesIf khis_has_cred()
#'
#' # Get all organisation units
#' get_organisation_units()
#'
#' # Get all data elements
#' get_data_elements()
#'
#' # Get data elements by element ids
#' get_data_elements(id %.in% c('VR7vdS7P0Gb', 'gQro1y7Rsbq'))
#'
#' # Get datasets by name with the word 'MOH 705'
#' get_data_sets(name %.like% 'MOH 705')
#'
#' @name metadata-helpers

get_categories <- function(...,
                           fields = c('id', 'name')) {
    get_metadata('categories',
                 ...,
                 fields = fields)
}

#' @rdname metadata-helpers
#' @export

get_category_combos <- function(...,
                                fields = c('id', 'name')) {
    get_metadata('categoryCombos',
                 ...,
                 fields = fields)
}

#' @rdname metadata-helpers
#' @export

get_category_option_combos <- function(...,
                                       fields = c('id', 'name')) {
    get_metadata('categoryOptionCombos',
                 ...,
                 fields = fields)
}

#' @rdname metadata-helpers
#' @export

get_category_option_group_sets <- function(...,
                                           fields = c('id', 'name')) {
    get_metadata('categoryOptionGroupSets',
                 ...,
                 fields = fields)
}

#' @rdname metadata-helpers
#' @export

get_category_option_groups <- function(...,
                                       fields = c('id', 'name')) {
    get_metadata('categoryOptionGroups',
                 ...,
                 fields = fields)
}

#' @rdname metadata-helpers
#' @export

get_category_options <- function(...,
                                 fields = c('id', 'name')) {
    get_metadata('categoryOptions',
                 ...,
                 fields = fields)
}

#' @rdname metadata-helpers
#' @export

get_data_element_group_sets <- function(...,
                                        fields = c('id', 'name')) {
    get_metadata('dataElementGroupSets',
                 ...,
                 fields = fields)
}

#' @rdname metadata-helpers
#' @export

get_data_element_groups <- function(...,
                                    fields = c('id', 'name')) {
    get_metadata('dataElementGroups',
                 ...,
                 fields = fields)
}

#' @rdname metadata-helpers
#' @export

get_data_elements <- function(...,
                              fields = c('id', 'name')) {
    get_metadata('dataElements',
                 ...,
                 fields = fields)
}

#' @rdname metadata-helpers
#' @export

get_data_sets <- function(...,
                          fields = c('id', 'name')) {
    get_metadata('dataSets',
                 ...,
                 fields = fields)
}

#' @rdname metadata-helpers
#' @export

get_user_groups <- function(...,
                            fields = c('id', 'name')) {
    get_metadata('userGroups',
                 ...,
                 fields = fields)
}

#' @rdname metadata-helpers
#' @export

get_indicator_group_sets <- function(...,
                                     fields = c('id', 'name')) {
    get_metadata('indicatorGroupSets',
                 ...,
                 fields = fields)
}

#' @rdname metadata-helpers
#' @export

get_indicator_groups <- function(...,
                                 fields = c('id', 'name')) {
    get_metadata('indicatorGroups',
                 ...,
                 fields = fields)
}

#' @rdname metadata-helpers
#' @export

get_indicators <- function(...,
                           fields = c('id', 'name')) {
    get_metadata('indicators',
                 ...,
                 fields = fields)
}

#' @rdname metadata-helpers
#' @export

get_option_group_sets <- function(...,
                                  fields = c('id', 'name')) {
    get_metadata('optionGroupSets',
                 ...,
                 fields = fields)
}

#' @rdname metadata-helpers
#' @export

get_option_groups <- function(...,
                              fields = c('id', 'name')) {
    get_metadata('optionGroups',
                 ...,
                 fields = fields)
}

#' @rdname metadata-helpers
#' @export

get_option_sets <- function(...,
                            fields = c('id', 'name')) {
    get_metadata('optionSets',
                 ...,
                 fields = fields)
}

#' @rdname metadata-helpers
#' @export

get_options <- function(...,
                        fields = c('id', 'name')) {
    get_metadata('options',
                 ...,
                 fields = fields)
}

#' @rdname metadata-helpers
#' @export

get_organisation_unit_groupsets <- function(...,
                                            fields = c('id', 'name')) {
    get_metadata('organisationUnitGroupSets',
                 ...,
                 fields = fields)
}

#' @rdname metadata-helpers
#' @export

get_organisation_unit_groups <- function(...,
                                         fields = c('id', 'name')) {
    get_metadata('organisationUnitGroups',
                 ...,
                 fields = fields)
}

#' @rdname metadata-helpers
#' @export

get_organisation_units <- function(...,
                                   fields = c('id', 'name')) {
    get_metadata('organisationUnits',
                 ...,
                 fields = fields)
}

#' @rdname metadata-helpers
#' @export

get_dimensions <- function(...,
                           fields = c('id', 'name')) {
    get_metadata('dimensions',
                 ...,
                 fields = fields)
}

#' @rdname metadata-helpers
#' @export

get_period_types <- function(...,
                           fields = c('id', 'name')) {
    get_metadata('periodTypes',
                 ...,
                 fields = fields)
}
