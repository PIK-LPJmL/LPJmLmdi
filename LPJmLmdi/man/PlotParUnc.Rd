\name{PlotParUnc}
\alias{PlotParUnc}
\title{Plot the psoterior parameter uncertainty}
\description{The function takes an object of class \code{\link{LPJpar}} and plots the relative uncertainty of the optimized parameters, i.e. uncertainty_best / uncertainty_prior}
\usage{PlotParUnc(lpjpar, uncertainty = "uncertainty.005", ylab = "Relative parameter uncertainty", 
    main = NULL, ...)}
\arguments{
  \item{lpjpar}{a list of class "LPJpar" (see \code{\link{LPJpar}})}
  \item{uncertainty}{name of the uncertainty estimate in LPJpar that should be used to compute posterior uncertainties}
  \item{ylab}{label of y-axis}
  \item{main}{title of plot}
  \item{\dots}{further arguments for plot}
}
\details{No details.}

\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{CombineRescueFiles}}}
\examples{
# PlotParUnc(lpjpar)
}
