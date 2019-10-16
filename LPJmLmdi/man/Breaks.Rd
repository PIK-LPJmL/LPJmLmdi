\name{Breaks}
\alias{Breaks}
\title{Class breaks for plotting}
\description{Calculates class breakpoints based on quantiles.}
\usage{Breaks(x, n = 12, quantile = c(0.01, 0.99), zero.min = FALSE, 
    ...)}
\arguments{
  \item{x}{numeric vector}
  \item{n}{number of breaks}
  \item{quantile}{lower and upper quantiles that should be used to exclude outliers}
  \item{zero.min}{should the minimum break be at 0?	}
  \item{\dots}{Further arguments (unused)}
}
\details{No details.}
\value{The function returns a vector of values.}
\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{BreakColours}}}
\examples{

Breaks(rnorm(100, 50, 30))
Breaks(runif(100, 10, 30))
Breaks(rlnorm(100))

}
