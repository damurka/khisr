# Metadata Filter

Formats a metadata filter to DHIS 2 comparison operators.

## Usage

``` r
metadata_filter(property, operator, values, call = caller_env())

property %.eq% values

property %.ieq% values

property %.~eq% values

property %.ne% values

property %.Like% values

property %.~Like% values

property %.^Like% values

property %.~^Like% values

property %.Like$% values

property %.~Like$% values

property %.like% values

property %.~like% values

property %.^like% values

property %.~^like% values

property %.like$% values

property %.~like$% values

property %.gt% values

property %.ge% values

property %.lt% values

property %.le% values

property %.token% values

property %.~token% values

property %.in% values

property %.~in% values
```

## Arguments

- property:

  The property on the metadata you want to filter on

- operator:

  The comparison operator you want to perform

- values:

  The value to check against

- call:

  description

## Value

A spliced list with filter in the format property:operator:value

## Details

To filter the metadata there are several filter operations that can be
applied to the returned list of metadata. The format of the filter
itself is straight-forward and follows the pattern
property:operator:value, where property is the property on the metadata
you want to filter on, operator is the comparison operator you want to
perform and value is the value to check against (not all operators
require value). To view the operator see [DHIS 2
Operator](https://docs.dhis2.org/en/develop/using-the-api/dhis-core-version-master/metadata.html#webapi_metadata_object_filter)

- `%.eq%` - Equality

- `%.ieq%` - Case insensitive string, match exact

- `%.~eq%` - Inequality

- `%.ne%` - Inequality

- `%.Like%` - Case sensitive string, match anywhere

- `%.~Like%` - Case sensitive string, not match anywhere

- `%.^Like%` - Case sensitive string, match start

- `%.~^Like%` - Case sensitive string, not match start

- `%.Like$%` - Case sensitive string, match end

- `%.~Like$%` - Case sensitive string, not match end

- `%.like%` - Case insensitive string, match anywhere

- `%.~like%` - Case insensitive string, not match anywhere

- ` %.^like%` - Case insensitive string, match start

- `%.~^like%` - Case insensitive string, not match start

- `%.like$%` - Case insensitive string, match end

- `%.~like$%` - Case insensitive string, not match end

- `%.gt%` - Greater than

- `%.ge%` - Greater than or equal

- `%.lt%` - Less than

- `%.le%` - Less than or equal

- `%.token%` - Match on multiple tokens in search property

- `%.~token%` - Not match on multiple tokens in search property

- `%.in%` - Find objects matching 1 or more values

- `%.~in%` - Find objects not matching 1 or more values

## Examples

``` r
# Generate an equality filter
id %.eq% 'element_id'
#> <spliced>
#> $filter
#> [1] "id:eq:element_id"
#> 

# Finding multiple ids
'id' %.in% c('id1', 'id2', 'id3')
#> <spliced>
#> $filter
#> [1] "id:in:[id1,id2,id3]"
#> 

# Get all data elements which have a data set with id ID1
'dataSetElements.dataSet.id' %.eq% 'ID1'
#> <spliced>
#> $filter
#> [1] "dataSetElements.dataSet.id:eq:ID1"
#> 

# get data elements which are members of the ANC data element group
'dataElementGroups.id' %.eq% 'qfxEYY9xAl6'
#> <spliced>
#> $filter
#> [1] "dataElementGroups.id:eq:qfxEYY9xAl6"
#> 

# Get data elements which have any option set
metadata_filter('optionSet', '!null', NULL)
#> <spliced>
#> $filter
#> [1] "optionSet:!null"
#> 
```
