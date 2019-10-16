\name{ReadLPJ2ts}
\alias{ReadLPJ2ts}
\title{Read a LPJ binary file and returns a spatial averaged time series}
\description{The function reads LPJ binary output files *.bin, aggregates (mean) the time series over all grid cells and returns the regional-averaged time series}
\usage{ReadLPJ2ts(file.bin, sim.start.year = 1901, start = sim.start.year, 
    end = NA, ...)}
\arguments{
  \item{file.bin}{binary LPJ output file}
  \item{sim.start.year}{first year of the simulation}
  \item{start}{first year to read}
  \item{end}{last year to read, reads until last year if NA}
  \item{\dots}{further arguments (currently not used)}
}
\details{No details.}
\value{The function returns a time series of class 'ts'.}
\references{No reference.}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{ReadLPJsim}}}
\examples{

# gpp <- ReadLPJ2ts("mgpp.bin")

}
