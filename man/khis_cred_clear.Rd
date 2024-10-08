% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/khis_cred.R
\name{khis_cred_clear}
\alias{khis_cred_clear}
\title{Clear the Credentials from Memory}
\usage{
khis_cred_clear(auth = NULL)
}
\arguments{
\item{auth}{(Optional) An authentication object from which to clear credentials.
If not provided, the credentials in the global auth object will be cleared.}
}
\value{
No return value, called for side effects.
}
\description{
This function clears the DHIS2 credentials from memory. If an auth object is
provided, it clears the credentials from that object. If no \code{auth} object is
provided, it clears the global auth credentials.
}
\examples{

# Clear credentials from the global .auth object
khis_cred_clear()
}
\seealso{
Other credential functions: 
\code{\link{khis_base_url}()},
\code{\link{khis_cred}()},
\code{\link{khis_display_name}()},
\code{\link{khis_has_cred}()},
\code{\link{khis_username}()}
}
\concept{credential functions}
