## Patch Resubmission (v1.0.4): Credential Validation Fix

This patch release addresses a credential validation issue identified on the r-oldrel-macos-x86_64 flavor during the previous submission.

**Previously:**

* The `khisr::khis_has_cred()` function only checked for credential presence, not validity. This posed a security risk as it could accept invalid credentials.

**Changes:**

* `khisr::khis_has_cred()` now rigorously validates credentials against the DHIS2 instance, ensuring only valid credentials are accepted. This significantly enhances security.
* The `khisr::khis_cred()` function has been improved to include credential validation and set a profile property used by `khis_has_cred()` for verification.

## R CMD check results

0 errors | 0 warnings | 0 note

## revdepcheck results

We checked 1 reverse dependencies, comparing R CMD check results across CRAN and dev versions of this package.

 * We saw 0 new problems
 * We failed to check 0 packages
