\name{InfoLPJ}
\alias{InfoLPJ}
\title{Information about a LPJmL binary file}
\description{The function reads information about a LPJ binary output file.}
\usage{InfoLPJ(file.bin = "fpc.bin", file.grid = "grid.bin", file.annual = c("vegc.bin", 
    "litc.bin", "soilc.bin"), size = 4, data.type = numeric(), 
    ...)}
\arguments{
  \item{file.bin}{binary LPJ output file}
  \item{file.grid}{binary LPJ grid file}
  \item{file.annual}{one of the binary LPJ output files with annual data}
  \item{size}{the number of bytes per element in the byte stream.}
  \item{data.type}{data type of the file (default=numeric())}
  \item{\dots}{further arguments (currently not used)}
}
\details{No details.}
\value{The function returns a list with information about the LPJ binary file (number of grid cells, number of years, number of bands, spatial extent).}
\references{No reference.}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{ReadLPJ}}}
\examples{

# InfoLPJ("vegc.bin")

}
