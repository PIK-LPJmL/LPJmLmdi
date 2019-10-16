\name{WriteCLM}
\alias{WriteCLM}
\title{Write a CLM file from SpatialPointsDataFrame}
\description{The function writes CLM files from a SpatialPointsDataFrame or SpatialPixelsDataFrame. The LPJmL program cru2clm needs to be installed.}
\usage{WriteCLM(data.sp, file.clm, start, nbands, size = 2, scale = 1, 
    na.replace = -9999, path.lpj = NULL, res = 0.5, ...)}
\arguments{
  \item{data.sp}{SpatialPointsDataFrame or SpatialPixelsDataFrame with data}
  \item{file.clm}{CLM file name with extension *.clm}
  \item{start}{integer. First year in data.}
  \item{nbands}{Number of bands per year.}
  \item{size}{The number of bytes per element in the byte stream.}
  \item{scale}{Scaling factor to be written to the header of the CLM file. The factor will be not applied to the data.}
  \item{na.replace}{integer to replace NA values.}
  \item{path.lpj}{path to LPJ installation}
  \item{res}{spatial resolution of the grid cells }
  \item{\dots}{Further arguments (currently not used).}
}
\details{No details.}
\value{The function returns TRUE if the CLM file was created.}
\references{No reference.}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{WriteLPJinput}}}
\examples{

# data.sp <- SpatialPointsDataFrame(lpjinput$grid, as.data.frame(data.m))
# WriteCLM(data.sp, file="data.clm", start=1901, nbands=12, size=2)	

}
