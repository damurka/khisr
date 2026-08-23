## Resubmission after archival

This package was archived from CRAN on 2026-03-25 because check problems
were not corrected in time. The check failure was caused by `dplyr::id()`,
which was removed in dplyr 1.2.0 (khisr used it in a couple of internal NSE
workarounds to satisfy `R CMD check`'s global-variable check). This release
removes all use of `dplyr::id()` in favour of standard local NSE-guard
declarations, and has been verified with dplyr 1.2.1 installed (the version
that removed it): `R CMD check` returns 0 errors, 0 warnings, 1 note.

This release also adds several new features (Tracker API support,
Personal Access Token authentication, and additional data/analytics
endpoints) and a number of unrelated bug fixes found during review; see
NEWS.md for details.

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.