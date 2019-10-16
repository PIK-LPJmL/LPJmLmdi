\name{SdW}
\alias{SdW}
\title{Weighted standard deviation}
\description{Compute the standard deviation.}
\usage{SdW(x, w = rep(1, length(x)))}
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
sd(x)
SdW(x, w=c(1, 1, 1, 2, 2))
}
