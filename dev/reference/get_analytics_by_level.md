# Retrieves Analytics Table Data

**\[experimental\]** `get_analytics_by_level()` fetches data from the
DHIS2 analytics tables for a given period and data element(s), without
performing any aggregation.

## Usage

``` r
get_analytics_by_level(
  element_ids,
  start_date,
  end_date = NULL,
  level = 1,
  org_ids = NULL,
  ...,
  call = caller_env()
)
```

## Arguments

- element_ids:

  Required vector of data element IDs for which to retrieve data.

- start_date:

  Required start date to retrieve data. It is required and in the format
  `YYYY-MM-dd`.

- end_date:

  Optional ending date for data retrieval (default is the current date).

- level:

  The desired organisation level of data (default: level 1)

- org_ids:

  Optional list of organization units IDs to be filtered.

- ...:

  Other options that can be passed onto DHIS2 API.

- call:

  The caller environment.

## Value

A tibble with detailed information, including:

- Geographical identifiers (country, subnational, district, facility,
  depending on level)

- Reporting period (month, year, fiscal year)

- Data element names

- Category options

- Reported values

## Details

- Retrieves data directly from DHIS2 analytics tables.

- Supports optional arguments for providing organization lists, data
  elements, and categories.

- Allows specifying DHIS2 session objects, retry attempts, and logging
  verbosity.

## See also

- [`get_organisations_by_level()`](https://khisr.damurka.com/dev/reference/get_organisations_by_level.md)
  for getting the organisations units

- [`get_data_elements_with_category_options()`](https://khisr.damurka.com/dev/reference/get_data_elements_with_category_options.md)
  for retrieving the data elements

## Examples

``` r
# Clinical Breast Examination data elements
# XEX93uLsAm2 = CBE Abnormal
# cXe64Yk0QMY = CBE Normal
element_id = c('cXe64Yk0QMY', 'XEX93uLsAm2')

# Download data from February 2023 to current date
data <- get_analytics_by_level(element_ids = element_id,
                               start_date = '2023-02-01')
#> Error: Failed to perform HTTP request.
#> Caused by error in `curl::curl_fetch_memory()`:
#> ! Timeout was reached [hiskenya.org]:
#> Operation timed out after 60002 milliseconds with 0 bytes received
data
#> function (..., list = character(), package = NULL, lib.loc = NULL, 
#>     verbose = getOption("verbose"), envir = .GlobalEnv, overwrite = TRUE) 
#> {
#>     fileExt <- function(x) {
#>         db <- grepl("\\.[^.]+\\.(gz|bz2|xz)$", x)
#>         ans <- sub(".*\\.", "", x)
#>         ans[db] <- sub(".*\\.([^.]+\\.)(gz|bz2|xz)$", "\\1\\2", 
#>             x[db])
#>         ans
#>     }
#>     my_read_table <- function(...) {
#>         lcc <- Sys.getlocale("LC_COLLATE")
#>         on.exit(Sys.setlocale("LC_COLLATE", lcc))
#>         Sys.setlocale("LC_COLLATE", "C")
#>         read.table(...)
#>     }
#>     stopifnot(is.character(list))
#>     names <- c(as.character(substitute(list(...))[-1L]), list)
#>     if (!is.null(package)) {
#>         if (!is.character(package)) 
#>             stop("'package' must be a character vector or NULL")
#>     }
#>     paths <- find.package(package, lib.loc, verbose = verbose)
#>     if (is.null(lib.loc)) 
#>         paths <- c(path.package(package, TRUE), if (!length(package)) getwd(), 
#>             paths)
#>     paths <- unique(normalizePath(paths[file.exists(paths)]))
#>     paths <- paths[dir.exists(file.path(paths, "data"))]
#>     dataExts <- tools:::.make_file_exts("data")
#>     if (length(names) == 0L) {
#>         db <- matrix(character(), nrow = 0L, ncol = 4L)
#>         for (path in paths) {
#>             entries <- NULL
#>             packageName <- if (file_test("-f", file.path(path, 
#>                 "DESCRIPTION"))) 
#>                 basename(path)
#>             else "."
#>             if (file_test("-f", INDEX <- file.path(path, "Meta", 
#>                 "data.rds"))) {
#>                 entries <- readRDS(INDEX)
#>             }
#>             else {
#>                 dataDir <- file.path(path, "data")
#>                 entries <- tools::list_files_with_type(dataDir, 
#>                   "data")
#>                 if (length(entries)) {
#>                   entries <- unique(tools::file_path_sans_ext(basename(entries)))
#>                   entries <- cbind(entries, "")
#>                 }
#>             }
#>             if (NROW(entries)) {
#>                 if (is.matrix(entries) && ncol(entries) == 2L) 
#>                   db <- rbind(db, cbind(packageName, dirname(path), 
#>                     entries))
#>                 else warning(gettextf("data index for package %s is invalid and will be ignored", 
#>                   sQuote(packageName)), domain = NA, call. = FALSE)
#>             }
#>         }
#>         colnames(db) <- c("Package", "LibPath", "Item", "Title")
#>         footer <- if (missing(package)) 
#>             paste0("Use ", sQuote(paste("data(package =", ".packages(all.available = TRUE))")), 
#>                 "\n", "to list the data sets in all *available* packages.")
#>         else NULL
#>         y <- list(title = "Data sets", header = NULL, results = db, 
#>             footer = footer)
#>         class(y) <- "packageIQR"
#>         return(y)
#>     }
#>     paths <- file.path(paths, "data")
#>     for (name in names) {
#>         found <- FALSE
#>         for (p in paths) {
#>             tmp_env <- if (overwrite) 
#>                 envir
#>             else new.env()
#>             if (file_test("-f", file.path(p, "Rdata.rds"))) {
#>                 rds <- readRDS(file.path(p, "Rdata.rds"))
#>                 if (name %in% names(rds)) {
#>                   found <- TRUE
#>                   if (verbose) 
#>                     message(sprintf("name=%s:\t found in Rdata.rds", 
#>                       name), domain = NA)
#>                   objs <- rds[[name]]
#>                   lazyLoad(file.path(p, "Rdata"), envir = tmp_env, 
#>                     filter = function(x) x %in% objs)
#>                   break
#>                 }
#>                 else if (verbose) 
#>                   message(sprintf("name=%s:\t NOT found in names() of Rdata.rds, i.e.,\n\t%s\n", 
#>                     name, paste(names(rds), collapse = ",")), 
#>                     domain = NA)
#>             }
#>             files <- list.files(p, full.names = TRUE)
#>             files <- files[grep(name, files, fixed = TRUE)]
#>             if (length(files) > 1L) {
#>                 o <- match(fileExt(files), dataExts, nomatch = 100L)
#>                 paths0 <- dirname(files)
#>                 paths0 <- factor(paths0, levels = unique(paths0))
#>                 files <- files[order(paths0, o)]
#>             }
#>             if (length(files)) {
#>                 for (file in files) {
#>                   if (verbose) 
#>                     message("name=", name, ":\t file= ...", .Platform$file.sep, 
#>                       basename(file), "::\t", appendLF = FALSE, 
#>                       domain = NA)
#>                   ext <- fileExt(file)
#>                   if (basename(file) != paste0(name, ".", ext)) 
#>                     found <- FALSE
#>                   else {
#>                     found <- TRUE
#>                     switch(ext, R = , r = {
#>                       library("utils")
#>                       sys.source(file, chdir = TRUE, envir = tmp_env)
#>                     }, RData = , rdata = , rda = load(file, envir = tmp_env), 
#>                       TXT = , txt = , tab = , tab.gz = , tab.bz2 = , 
#>                       tab.xz = , txt.gz = , txt.bz2 = , txt.xz = assign(name, 
#>                         my_read_table(file, header = TRUE, as.is = FALSE), 
#>                         envir = tmp_env), CSV = , csv = , csv.gz = , 
#>                       csv.bz2 = , csv.xz = assign(name, my_read_table(file, 
#>                         header = TRUE, sep = ";", as.is = FALSE), 
#>                         envir = tmp_env), found <- FALSE)
#>                   }
#>                   if (found) 
#>                     break
#>                 }
#>                 if (verbose) 
#>                   message(if (!found) 
#>                     "*NOT* ", "found", domain = NA)
#>             }
#>             if (found) 
#>                 break
#>         }
#>         if (!found) {
#>             warning(gettextf("data set %s not found", sQuote(name)), 
#>                 domain = NA)
#>         }
#>         else if (!overwrite) {
#>             for (o in ls(envir = tmp_env, all.names = TRUE)) {
#>                 if (exists(o, envir = envir, inherits = FALSE)) 
#>                   warning(gettextf("an object named %s already exists and will not be overwritten", 
#>                     sQuote(o)))
#>                 else assign(o, get(o, envir = tmp_env, inherits = FALSE), 
#>                   envir = envir)
#>             }
#>             rm(tmp_env)
#>         }
#>     }
#>     invisible(names)
#> }
#> <bytecode: 0x55653249cd80>
#> <environment: namespace:utils>
```
