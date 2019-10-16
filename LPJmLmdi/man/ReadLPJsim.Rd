\name{ReadLPJsim}
\alias{ReadLPJsim}
\title{Read a LPJ simulation results}
\description{The function reads all binary output files from a LPJ simulation and returns regional aggregated time series.}
\usage{ReadLPJsim(sim.start.year = 1901, start = sim.start.year, end = NA, 
    files = NA, outputvars.par = NULL, ...)}
\arguments{
  \item{sim.start.year}{first year of the simulation}
  \item{start}{first year to read}
  \item{end}{last year to read. If NA, reads until last year}
  \item{files}{Which LPJ binary output files should be read? If NA, all *.bin files in the current directory are read.}
  \item{outputvars.par}{path and file name to the LPJmL 'outputvars.par' file. If NULL the file is searched 1 level above or below the current working directory. 	}
  \item{\dots}{further arguments (currently not used)}
}
\details{No details.}
\value{The function returns a list of class 'LPJsim'}
\references{No reference.}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{ReadLPJ2ts}}}
\examples{

# setwd(path.mylpjresult)
# sim <- ReadLPJsim(start=1982, end=2011)

}
