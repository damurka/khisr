## ----include = FALSE----------------------------------------------------------
auth_success <- tryCatch(
  khisr:::khis_cred_docs(),
  khis_cred_internal_error = function(e) e
)

knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  error = TRUE,
  purl = khisr::khis_has_cred(),
  eval = khisr::khis_has_cred()
)

library(khisr)

