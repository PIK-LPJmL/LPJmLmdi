\name{AggMeanMean}
\alias{AggMeanMean}
\title{Temporal aggregation: first mean, then mean = mean over all values}
\description{This function can be provided to \code{\link{IntegrationDataset}} to aggregate model results to the temporal resolution of the observations.}
\usage{AggMeanMean(x, agg)}
\arguments{
  \item{x}{full time series}
  \item{agg}{vector of grouping elements (years)}
}
\details{No details.}
\value{The function returns a the aggregated result.}
\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{IntegrationDataset}}}

