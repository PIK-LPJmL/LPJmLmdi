\name{IntegrationData2Df}
\alias{IntegrationData2Df}
\title{Converts IntegrationData to a data.frame}
\description{The function takes an object of class \code{\link{IntegrationData}} and converts it into a data.frame in long format. The data.frame has the columns 'lon', 'lat', 'time' and 'id' (a combination of lon_lat_time), and columns for each variable in IntegrationData.}
\usage{IntegrationData2Df(x, sim.name = "sim", ...)}
\arguments{
  \item{x}{object of class \code{\link{IntegrationData}}}
  \item{sim.name}{name that should be added to the variables for the simulation (e.g. use 'sim', or something like 'prior' or 'posterior' to create column names like 'FAPAR.sim')}
  \item{\dots}{further arguments (not used)}
}
\details{No details.}
\value{a data.frame}
\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{IntegrationData}}}

