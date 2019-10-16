\name{CostMDS.SSE}
\alias{CostMDS.SSE}
\title{Cost function for multiple data streams based on SSE}
\description{The function computes the cost for each grid cell and data stream in 'integrationdata'. Firstly, the cost per data stream and grid cell is computed using the defined 'CostFunction' for each \code{\link{IntegrationDataset}}. Secondly, the cost is weighted by (1) the dataset-specific weight, (2) the number of observations per grid cell and data streams, and (3) by the grid cell area.}
\usage{CostMDS.SSE(integrationdata)}
\arguments{
  \item{integrationdata}{object of class 'integrationdata', see \code{\link{IntegrationData}}}
}
\details{No details.}
\value{The function returns a list with the total cost, the cost per grid cell, per data streams, per grid cell and data stream, the error as computed with the defined CostFunction, the number of observations per grid cell and data stream, the weighting factors and grid cell area.}
\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}





