\name{WriteGrid}
\alias{WriteGrid}
\title{Write a *.grid file from a matrix of coordiantes or a SpatialPointsDataFrame}
\description{Writes a grid file for LPJ input data. The functions needs the LPJmL module txt2grid to be installed.}
\usage{WriteGrid(grid, file.grid, ...)}
\arguments{
  \item{grid}{SpatialPointsDataFrame; SpatialPixelsDataFrame, matrix or data.frame with coordinates}
  \item{file.grid}{Grid file name}
  \item{\dots}{Further arguments (currently not used).}
}
\details{No details.}
\value{The function returns TRUE if the grid file was created.}
\references{No reference.}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{WriteLPJinput}}}
\examples{

lon <- c(59.75, 68.25)
lat <- c(61.25, 65.75)
WriteGrid(cbind(lon, lat), "test.grid")

}
