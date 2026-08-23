#' Get Organisations by Level
#'
#' @description
#' `r lifecycle::badge("experimental")`
#' `get_organisations_by_level()` is an experimental function that retrieves
#' the organisation units along with their parent units.
#'
#' @param level An integer specifying the desired organisation level (default level 1).
#' @param org_ids Optional. A vector of organisation identifiers whose details
#'   are being retrieved.
#' @param auth Optional. The authentication object
#' @param call The call environment.
#'
#' @return A tibble containing the organisation units and their parent units up
#'   to the specified level. For each ancestor level, both a name column
#'   (e.g. `county`) and an id column (e.g. `county_id`) are included, so
#'   results can be joined back to other org-unit-keyed data by id rather
#'   than name — two different org units at the same level can share a name,
#'   a real, known DHIS2 data-quality issue.
#'
#' @export
#'
#' @examplesIf khis_has_cred()
#' # Fetch all the organisation units metadata
#' organisations <- get_organisations_by_level(level = 2)
#' organisations

get_organisations_by_level <- function(level = 1,
                                       org_ids = NULL,
                                       auth = NULL,
                                       call = caller_env()) {

    name = ancestor_id = ancestor_name = ancestor_level = level_name = id = NULL

    check_integerish(level, call = call)
    org_levels <- check_level_supported(level, auth = auth, call = call)

    fields <- 'id,name,level,ancestors[id,name,level]'

    if (!is.null(org_ids)) {

        check_string_vector(org_ids, call = call)

        filters <- chunk_ids(org_ids)
        orgs <- map(filters,
                    ~ get_organisation_units(id %.in% .x,
                                             level %.eq% level,
                                             fields = fields,
                                             auth = auth,
                                             call = call))
        orgs <- bind_rows(orgs)

    } else {
        orgs <- get_organisation_units(level %.eq% level,
                                       fields = fields,
                                       auth = auth,
                                       call = call)
    }

    if (is_empty(orgs)) {
        return (NULL)
    }

    level_lookup <- org_levels %>%
        mutate(level_name = tolower(name)) %>%
        select(level, level_name)

    own_level_name <- level_lookup %>%
        filter(level == !!level) %>%
        pull(level_name)

    orgs <- orgs %>%
        rename(!!own_level_name := name) %>%
        select(-level)

    # When every row's ancestors[] is an empty JSON array (e.g. level = 1,
    # which has no ancestors by definition), the DHIS2 metadata pipeline
    # collapses the column to a plain NA vector rather than a list-column —
    # lengths() on that returns 1, not 0, so check is.list() first.
    has_ancestors <- is.list(orgs[["ancestors"]]) && any(lengths(orgs[["ancestors"]]) > 0)

    if (!has_ancestors) {
        return(orgs %>%
            select(-"ancestors") %>%
            clean_names() %>%
            relocate(id))
    }

    ancestors_long <- orgs %>%
        select(id, "ancestors") %>%
        unnest_longer("ancestors", keep_empty = TRUE) %>%
        hoist("ancestors", ancestor_id = 'id', ancestor_name = 'name', ancestor_level = 'level') %>%
        filter(!is.na(ancestor_level)) %>%
        left_join(level_lookup, by = c('ancestor_level' = 'level'))

    ancestor_names <- ancestors_long %>%
        select(id, level_name, ancestor_name) %>%
        pivot_wider(names_from = level_name, values_from = ancestor_name)

    ancestor_ids <- ancestors_long %>%
        select(id, level_name, ancestor_id) %>%
        mutate(level_name = str_c(level_name, '_id')) %>%
        pivot_wider(names_from = level_name, values_from = ancestor_id)

    orgs %>%
        select(-"ancestors") %>%
        left_join(ancestor_names, by = 'id') %>%
        left_join(ancestor_ids, by = 'id') %>%
        clean_names() %>%
        relocate(id)
}
