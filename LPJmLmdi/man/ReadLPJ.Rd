\name{ReadLPJ}
\alias{ReadLPJ}
\title{Read a LPJ binary file}
\description{The function reads a binary LPJ output file and returns a SpatialPointsDataFrame}
\usage{ReadLPJ(file.bin, file.grid = "grid.bin", sim.start.year = 1901, 
    start = sim.start.year, end = NA, file.annual = c("vegc.bin", 
        "litc.bin", "soilc.bin"), size = 4, data.type = numeric(), 
    endian = "little", ...)}
\arguments{
  \item{file.bin}{binary LPJ output file}
  \item{file.grid}{binary LPJ grid file}
  \item{sim.start.year}{first year of the simulation}
  \item{start}{first year to read}
  \item{end}{last year to read, reads until last year if NA}
  \item{file.annual}{one of the binary LPJ output files with annual data}
  \item{size}{the number of bytes per element in the byte stream.}
  \item{data.type}{data type of the file (default=numeric())}
  \item{endian}{endianess of the binary file}
  \item{\dots}{further arguments (currently not used)}
}
\details{No details.}
\value{The function returns a SpatialPointsDataFrame.}
\references{No reference.}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{ReadLPJsim}}}
\examples{

# ReadLPJ("mgpp.bin", start=1982, end=2011)

}
