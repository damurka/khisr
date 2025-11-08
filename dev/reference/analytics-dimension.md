# Analytics Data Dimensions

Constructs a dimensions expression for analytics queries based on
specified property, operator, and values.

## Usage

``` r
analytics_dimension(property, operator, values)

operator %.d% values

operator %.f% values
```

## Arguments

- property:

  A character string representing whether its dimension or filter. It
  only accepts `'dimension'`, `'filter'`.

- operator:

  A character string representing the property to filter on (e.g.,
  `'dx'`, `'pe'`, `'ou'`).

- values:

  A vector of values or semi-colon separated string items.

## Value

A spliced list with filter in the format property=operator:value

## Details

DHIS2 organizes data using multiple dimensions, each with a unique
identifier and a set of items that represent specific data points within
that dimension.

- Data elements (dx): Indicators, data set reporting rate metrics, data
  element operands, program indicators, program data elements, program
  attributes, validation rules.

- Periods (pe): ISO periods (e.g., 202401) and relative periods (e.g.,
  LAST_WEEK).

- Organisation unit hierarchy (ou): Specific health facilities,
  districts, countries, and keywords for user location or its sub-units.

- Category option combinations (co): Category option combo identifiers.

- Attribute option combinations (ao): Category option combo identifiers.

- Categories: Category option identifiers.

- Data element group sets: Data element group identifiers.

- Organisation unit group sets: Organisation unit group identifiers.

The infix operator used for filter and dimension includes:

- `%.d%`: Infix operator for constructing dimension filters. Equivalent
  to calling `analytics_dimension("dimension", ...)`.

- `%.f%`: Infix operator for constructing filter filters. Equivalent to
  calling `analytics_dimension("filter", ...)`.

## Examples

``` r
# Create a dimension for data element "DE_1234"
analytics_dimension('dimension', "dx", "DE_1234")
#> <spliced>
#> $dimension
#> [1] "dx:DE_1234"
#> 

# Equivalent to the expression above
dx %.d% "DE_1234"
#> <spliced>
#> $dimension
#> [1] "dx:DE_1234"
#> 

# Create a filter dimension for the period of January 2024
pe %.f% "202401"
#> <spliced>
#> $filter
#> [1] "pe:202401"
#> 

# Create filter dimension for periods "202401" and "202402":
analytics_dimension("filter", "pe", c("202401", "202402"))
#> <spliced>
#> $filter
#> [1] "pe:202401;202402"
#> 
```
