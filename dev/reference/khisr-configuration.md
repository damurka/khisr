# khisr Configuration

Some aspects of khisr behaviour can be controlled via an option.

Temporarily suppress messages by enabling quiet mode within the provided
code block.

Temporarily suppress messages within the specified environment.

## Usage

``` r
with_khis_quiet(code)

local_khis_quiet(env = parent.frame())
```

## Arguments

- code:

  Code to execute quietly

- env:

  The environment to use for scoping.

## Value

No return value, called for side effects

No return value, called for side effects

No return value, called for side effects.

## Messages

The `khis_quiet` option can be used to suppress messages form khisr. By
default, khisr always messages, i.e. it is *not* quiet.

set `khis_quiet` to `TRUE` to suppress message, by one of these means,
in order of decreasing scope:

- Put `options(khis_quiet = TRUE)` in the start-up file, such as
  `.Rprofile`, or in your R script.

- Use `local_khis_quiet()` to silence khisr in a specific scope.

- Use `with_khis_quite` to run small bit of code silently.

`local_khis_quiet` and `with_khis` follow the conventions of the
[withr](https://withr.r-lib.org) package.

## Examples

``` r
if (FALSE) { # \dontrun{
    # message: "The credentials have been set."
    khis_cred(username = 'username',
              password = 'password',
              server = 'https://<dhis2-instance>')

    # suppress messages for a small amount of code
    with_khis_quiet(
        khis_cred(username = 'username',
                  password = 'password',
                  server = 'https://<dhis2-instance>')
    )
} # }

if (FALSE) { # \dontrun{
    # message: "The credentials have been set."
    khis_cred(username = 'username',
              password = 'password',
              server = 'https://<dhis2-instance>')

    # suppress messages for a in a specific scope
    local_khis_quiet()

    # no message
    khis_cred(username = 'username',
              password = 'password',
              server = 'https://<dhis2-instance>')

    # clear credentials
    khis_cred_clear()
} # }
```
