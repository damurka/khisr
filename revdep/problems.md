# cancerscreening

<details>

* Version: 1.1.0
* GitHub: https://github.com/damurka/cancerscreening
* Source code: https://github.com/cran/cancerscreening
* Date/Publication: 2024-04-14 12:30:02 UTC
* Number of recursive dependencies: 69

Run `revdepcheck::revdep_details(, "cancerscreening")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in 'cancerscreening-Ex.R' failed
    The error most likely occurred in:
    
    > ### Name: cancerscreening-configuration
    > ### Title: cancerscreening configuration
    > ### Aliases: cancerscreening-configuration with_cancerscreening_quiet
    > ###   local_cancerscreening_quiet
    > 
    > ### ** Examples
    > 
    ...
    Error in `khis_cred()`:
    ✖ Missing DHIS2 api instance
    ! Please provide 'base_url'.
    Backtrace:
        ▆
     1. └─khisr::khis_cred(username = "username", password = "password")
     2.   └─khisr:::khis_abort(...)
     3.     └─cli::cli_abort(message = message, ..., .envir = .envir, call = call)
     4.       └─rlang::abort(...)
    Execution halted
    ```

## In both

*   checking running R code from vignettes ...
    ```
      'cancerscreening.Rmd' using 'UTF-8'... failed
     ERROR
    Errors in running code in vignettes:
    when running code in 'cancerscreening.Rmd'
      ...
    
    > library(cancerscreening)
    
    > cervical_screened <- get_cervical_screened("2022-01-01", 
    +     end_date = "2022-06-30")
    
      When sourcing 'cancerscreening.R':
    Error: ✖ Missing credentials
    ! Please set the credentials by calling `khis_cred()`
    Execution halted
    ```

