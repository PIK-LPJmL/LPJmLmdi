\name{ReadOutputvars}
\alias{ReadOutputvars}
\title{Read 'outputvars.par' to get information about LPJmL output}
\description{LPJmL output is defined in par/outputvars.par. This file contains for each variable the id, name, variable name, description, unit, and scale. This file can be used to correctly read LPJmL output. The function is for example used within \code{\link{ReadLPJsim}}.}
\usage{ReadOutputvars(outputvars.par = NULL, ...)}
\arguments{
  \item{outputvars.par}{path and file name to the LPJmL 'outputvars.par' file. If NULL the file is searched 1 level above or below the current working directory. }
  \item{\dots}{further arguments (currently not used)}
}
\details{No details.}
\value{The function returns a time series of class 'ts'.}
\references{No reference.}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{ReadLPJsim}}}
\examples{

# ReadOutputvars()

}
