#' Get Formatted Organisations by Level
#'
#' @description
#' `r lifecycle::badge("experimental")`
#' `get_organisations_formatted()` is an experimental function that retrieves
#' the organisation units along with their parent units up to the specified
#' level.
#'
#' @param org_ids Optional. A vector of organisation identifiers whose details
#'   are being retrieved.
#' @param level An integer specifying the desired organisation level.
#'
#' @return A tibble containing the organisation units and their parent units up
#'   to the specified level.
#' @export
#'
#' @examplesIf khis_has_cred()
#' # Fetch all the organisation units metadata
#' organisations <- get_organisations_formatted(level = 2)
#' organisations

get_organisations_formatted <- function(org_ids = NULL, level = 1) {

    name = parent = NULL

    if (!is_scalar_integerish(level)) {
        khis_abort(
            c(
                "x" = "Invalid level"
            )
        )
    }

    org_levels <- get_organisation_unit_levels(fields = "name,level")

    if (!level %in% org_levels$level) {
        khis_abort(
            c(
                'x' = "Invalid level specified",
                "The organisation level is invalid"
            )
        )
    }

    if (!is.null(org_ids)) {
        filters <- split(unique(org_ids), ceiling(seq_along(unique(org_ids))/500))
        orgs <- map(filters,
                    ~ get_organisation_units(id %.in% .x,
                                             level %.eq% level,
                                             fields = generate_fields_string(level)))
        orgs <- bind_rows(orgs)

    } else {
        orgs <- get_organisation_units(level %.eq% level,
                                       fields = generate_fields_string(level))
    }

    if (is_empty(orgs)) {
        return (NULL)
    }

    level_name <- org_levels %>%
        filter(level == !!level) %>%
        pull(name) %>%
        tolower()

    hoist_columns <- generate_hoist_columns(level, org_levels)

    if (!is.null(hoist_columns)) {
        orgs <- orgs %>%
            hoist(parent, !!!hoist_columns) %>%
            select(-any_of('parent'))
    }

    orgs <- orgs %>%
        rename_with(~ level_name, starts_with('name')) %>%
        clean_names()

    return(orgs)
}

generate_fields_string <- function(level) {
    if (level <= 1) {
        return('id,name')
    }

    parent_str <- str_dup(',parent[name', level - 1)
    parent_str <- str_c(parent_str, str_dup(']', level - 1))

    return(paste0('id,name', parent_str))
}

generate_hoist_columns <- function(level, org_levels) {

    name = NULL

    # Determine the hierarchy of the levels
    levels_hierarchy <- org_levels %>%
        arrange(level) %>%
        filter(level < !!level) %>%
        pull(name) %>%
        tolower()

    # Generate the hoist column list dynamically
    if (length(levels_hierarchy) == 0) {
        return(NULL)
    }

    columns <- list2()
    current_level <- NULL
    for (lev in rev(levels_hierarchy)) {
        if (is.null(current_level)) {
            columns[[lev]] <- 'name'
            current_level <- 'parent'
        } else {
            columns[[lev]] <- list2(!!!current_level, 'name')
            current_level <- list2(!!!current_level, 'parent')
        }
    }

    return(columns)
}
