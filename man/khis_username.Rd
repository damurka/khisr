% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/khis_cred.R
\name{khis_username}
\alias{khis_username}
\title{Produces the Configured Username}
\usage{
khis_username()
}
\value{
the username of the user credentials
}
\description{
Produces the Configured Username
}
\examples{

# Set the credentials
khis_cred(username = 'KHIS username', password = 'KHIS password')

# View the username expect 'KHIS username'
khis_username()

# Clear credentials
khis_cred_clear()

# View the username expect 'NULL'
khis_username()
}
\seealso{
Other credential functions: 
\code{\link{khis_cred}()},
\code{\link{khis_cred_clear}()},
\code{\link{khis_has_cred}()}
}
\concept{credential functions}
