\name{WriteLPJinput}
\alias{WriteLPJinput}
\title{Write an object of class 'LPJinput' to CLM files}
\description{The function writes CLM input files for LPJ. }
\usage{WriteLPJinput(lpjinput, files = NULL, path.lpj = NULL, ...)}
\arguments{
  \item{lpjinput}{Object of class 'LPJinput' to be written.}
  \item{files}{names of the output CLM or binary files. }
  \item{path.lpj}{path to LPJ installation}
  \item{\dots}{further arguments (currently not used)}
}
\details{No details.}
\value{The function returns TRUE if the CLM file was created.}
\references{No reference.}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{WriteLPJinput}}}
\examples{

# lpjinput <- ReadLPJinput("cru_ts_3.20.1901.2011.tmp.clm", grid=cbind(c(136.75, 137.25, 160.75,168.75), c(45.25, 65.25, 68.75, 63.75)))
# str(lpjinput)
# WriteLPJinput(lpjinput)

}
