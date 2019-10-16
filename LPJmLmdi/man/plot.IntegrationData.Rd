\name{plot.IntegrationData}
\alias{plot.IntegrationData}
\title{Plot an object of class IntegrationData}
\description{The function plots an object of class \code{\link{IntegrationData}}, i.e. it produces a time series plots, scatterplots and a boxplot for the observations and LPJmL model outputs in \code{\link{IntegrationData}}.}
\usage{\method{plot}{IntegrationData}(x, ds = 1:length(x), CostMDS = CostMDS.SSE, 
    fits = "poly3", ...)}
\arguments{
  \item{x}{object of class \code{\link{IntegrationData}}}
  \item{ds}{Which data sets in x should be plotted (integer)}
  \item{CostMDS}{cost function for multiple data streams}
  \item{fits}{Fitting methods that should be used for scatter plots, see \code{\link{MultiFit}}}
  \item{\dots}{further arguments (currently not used)}
}
\details{No details.}

\references{No reference.}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{IntegrationData}}}

