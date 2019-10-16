\name{VarW}
\alias{VarW}
\title{Weighted variance}
\description{Compute the weighted variance.}
\usage{VarW(x, w = rep(1, length(x)))}
\arguments{
  \item{x}{a vector}
  \item{w}{vector of weights}
}
\details{No details.}

\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{ObjFct}}}
\examples{

x <- 1:5
var(x)
VarW(x, w=c(1, 1, 1, 2, 2))
}
