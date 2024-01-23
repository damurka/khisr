analytics_filter <- function(property, operator, values) {
    check_scalar_character(property)
    check_scalar_character(operator)

    values <- str_c(values, collapse = ';')
    if (values == 'all') {
        values <- dots_list('{property}' := operator)
    } else {
        values <- dots_list('{property}' := str_c(operator, ':', values))
    }
    return(splice(values))
}

'%.d%' <- function(operator, values) {
    operator <- as.character(ensym(operator))
    analytics_filter('dimension', operator, values)
}

'%.f%' <- function(operator, values) {
    operator <- as.character(ensym(operator))
    analytics_filter('filter', operator, values)
}


