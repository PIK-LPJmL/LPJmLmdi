\name{ReadLPJ2IntegrationData}
\alias{ReadLPJ2IntegrationData}
\title{Read LPJ model results into an of class IntegrationData}
\description{The function reads for each dataset in \code{\link{IntegrationData}} the corresponding model output and performs temporal aggregation.}
\usage{ReadLPJ2IntegrationData(integrationdata, xy, lpjfiles, ...)}
\arguments{
  \item{integrationdata}{object of class \code{\link{IntegrationData}}}
  \item{xy}{matrix of grid cell coordinates to run LPJ}
  \item{lpjfiles}{list of class \code{\link{LPJfiles}} that define all LPJ directories, input files, configuration template files}
  \item{\dots}{further arguments (currently not used)}
}
\details{No details.}
\value{The function returns the same list oc class 'IntegrationData' but with added model outputs.}
\references{No reference.}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{IntegrationData}}}

