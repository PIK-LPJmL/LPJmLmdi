\name{ReadLPJinput}
\alias{ReadLPJinput}
\title{Read and subset CLM files to LPJinput objects}
\description{The functions reads a CLM file, selects the data according to the provided grid and returns an object of class LPJinput. }
\usage{ReadLPJinput(files, grid = NULL, start = NA, ...)}
\arguments{
  \item{files}{character vector of CLM or binary file names}
  \item{grid}{Matrix of grid cells with 2 columns: longitude and latitude (optional). If NULL the data is returned for the grid of the first CLM file. If a grid is provided the data is subesetted for the specified grid cells.}
  \item{start}{first year to read}
  \item{\dots}{Further arguments to ReadCLM or ReadBIN}
}
\details{No details.}
\value{The function returns a list of class "LPJinput".}
\references{No reference.}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{WriteLPJinput}}}
\examples{

# lpjinput <- ReadLPJinput("cru_ts_3.20.1901.2011.tmp.clm", grid=cbind(c(136.75, 137.25, 160.75,168.75), c(45.25, 65.25, 68.75, 63.75)))
# str(lpjinput)

}
