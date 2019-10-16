\name{CostMDS.KGE}
\alias{CostMDS.KGE}
\title{Cost function for multiple data streams based on Kling-Gupta efficiency}
\description{The function computes for each grid cell and data stream in 'integrationdata' the cost besed on the Kling-Gupta efficiency (KGE, Gupta et al. 2009, J. Hydrology). See Forkel et al. (in prep.) for the specific use of KGE for multiple data streams.}
\usage{CostMDS.KGE(integrationdata)}
\arguments{
  \item{integrationdata}{object of class 'integrationdata', see \code{\link{IntegrationData}}}
}
\details{No details.}
\value{The function returns a list with the total cost (total), the cost per KGE component (per.cell), per data streams (per.ds), per KGE component and data stream (per.cell.ds), and the fractional contribution of a data stream and KGE component to the total cost (fractional).}
\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}





