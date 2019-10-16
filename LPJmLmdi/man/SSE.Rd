\name{SSE}
\alias{SSE}
\title{Sum-of-squared residuals error}
\description{The function implements the sum-of-squared residuals error as cost function}
\usage{SSE(sim, obs, unc)}
\arguments{
  \item{sim}{vector of simulations}
  \item{obs}{vector of observations}
  \item{unc}{vector of observation uncertainties}
}
\details{No details.}

\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}




\examples{

obs <- rnorm(10, 0, 2)
sim <- obs + rnorm(10, 0.05, 0.01)
unc <- 0.01
SSE(sim, obs, unc)

}
