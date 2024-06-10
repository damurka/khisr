## Patch Resubmission

This patch release (v1.0.4) addresses issues identified in the **r-oldrel-macos-arm64**and **r-oldrel-macos-x86_64** flavours. In the previous version (v1.0.3), these flavours are evaluating code in `khisr.Rmd` vignette pages without a decryption key. To address this, an `eval` condition has been placed on each code block to explicitly enforce the requirement for a decryption key.

## R CMD check results

0 errors | 0 warnings | 0 note

## revdepcheck results

We checked 1 reverse dependencies, comparing R CMD check results across CRAN and dev versions of this package.

 * We saw 0 new problems
 * We failed to check 0 packages
