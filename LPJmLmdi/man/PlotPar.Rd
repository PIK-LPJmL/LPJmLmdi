\name{PlotPar}
\alias{PlotPar}
\title{Plot parameter vs. cost}
\description{The function takes an object of class 'rescue' (see \code{\link{CombineRescueFiles}}) (alternatively a 'data.frame' as created with \code{\link{Rescue2Df}}) and a 'LPJpar' object and plots different plots of cost vs. parameter value and parameter uncertainties.}
\usage{PlotPar(rescue.l, lpjpar, par.name = NULL, ...)}
\arguments{
  \item{rescue.l}{a list of class "rescue" (\code{\link{CombineRescueFiles}}) or alternatively a data.frame as created with \code{\link{Rescue2Df}}.}
  \item{lpjpar}{a list of class "LPJpar" (see \code{\link{LPJpar}})}
  \item{par.name}{name(s) of the parameters that should be plotted	}
  \item{\dots}{further arguments (currently not used)}
}
\details{No details.}

\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{CombineRescueFiles}}}
\examples{
# files <- c(list.files(pattern="rescue.RData", recursive=TRUE), list.files(pattern="rescue0.RData", recursive=TRUE))
# rescue.l <- CombineRescueFiles(files, remove=FALSE)
# PlotPar(rescue.l, lpjpar)
}
