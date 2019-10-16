\name{ReadCLM}
\alias{ReadCLM}
\title{Read a CLM file to a SpatialPixelsDataFrame}

\usage{ReadCLM(file.clm, start = NA, end = NA, start.year = NA, grid = NULL, 
    nbands = NA, size = NA, file.grid = NA, endian.data = NA, 
    endian.grid = "big", data.type = integer(), ...)}
\arguments{
  \item{file.clm}{CLM file name with extension *.clm}
  \item{start}{first year to be read}
  \item{end}{last year to be read, reads until last year in case of NA}
  \item{start.year}{first year in the dataset, read from header information in case NA}
  \item{grid}{a matrix of coordinates (lon, lat) if data should be read only for specific cells, if NULL the data for all grid cells is read}
  \item{nbands}{number of bands per year, read from header information in case NA}
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

