\name{WriteBIN}
\alias{WriteBIN}
\title{Write a BIN file from SpatialPointsDataFrame}
\description{The function writes BIN files from a SpatialPointsDataFrame or SpatialPixelsDataFrame. }
\usage{WriteBIN(data.sp, file.bin, size = 1, ...)}
\arguments{
  \item{data.sp}{SpatialPointsDataFrame or SpatialPixelsDataFrame with data}
  \item{file.bin}{binary file name with extension *.bin}
  \item{size}{The number of bytes per element in the byte stream.}
  \item{\dots}{Further arguments (currently not used).}
}
\details{No details.}
\value{The function returns TRUE if the CLM file was created.}
\references{No reference.}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{ReadBIN}}}
\examples{

# data.sp <- SpatialPointsDataFrame(lpjinput$grid, as.data.frame(data.m))
# WriteBIN(data.sp, file="data.bin")	

}
