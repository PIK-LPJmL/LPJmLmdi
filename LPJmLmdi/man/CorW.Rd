\name{CorW}
\alias{CorW}
\title{Weighted correlation}
\description{Compute the correlation.}
\usage{CorW(x, y, w = rep(1, length(x)))}
\arguments{
  \item{x}{a vector of x values}
  \item{y}{a vector of y values}
  \item{w}{vector of weights}
}
\details{No details.}

\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{ObjFct}}}
\examples{

x <- 1:5
y <- x * -1 + rnorm(5)
cor(x, y)
CorW(x, y, w=c(1, 1, 1, 2, 2))
}
