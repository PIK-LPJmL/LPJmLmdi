\name{ReadBIN}
\alias{ReadBIN}
\title{Read simple binary files without header Read a CLM file to a SpatialPixelsDataFrame}
\description{The function is used to read for example the soil*.bin and drainclass.bin files}
\usage{ReadBIN(file.bin, nbands = 1, size = 1, file.grid = NA, endian.data = "little", 
    endian.grid = "little", data.type = integer(), ...)}
\arguments{
  \item{file.bin}{binary file name with extension *.bin}
  \item{nbands}{number of bands per year}
  \item{size}{The number of bytes per element in the byte stream.}
  \item{file.grid}{file name of the corresponding grid file}
  \item{endian.data}{endinaess of the data file}
  \item{endian.grid}{endianess of the grid file}
  \item{data.type}{type of the data}
  \item{\dots}{Further arguments (currently not used).}
}
\details{No details.}

\references{No reference.}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{WriteCLM}}}
\examples{

# ReadBIN("soil_new_67420.bin")

}
