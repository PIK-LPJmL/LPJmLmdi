\name{StartingValues}
\alias{StartingValues}
\title{Get starting values for genoud from *.pro file}
\description{The function extracts the best individuals trhat occured during a genoud optimization from a *.pro file. These best individuals can be used as starting values if a optimization is restarted. This function is called within \code{\link{OptimizeLPJgenoud}} is a restart is performed.}
\usage{StartingValues(file.optresult, pop.size = NULL, ...)}
\arguments{
  \item{file.optresult}{genoud *.pro file with optimization results}
  \item{pop.size}{population size}
  \item{\dots}{further arguments (not used)}
}
\details{No details.}

\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{OptimizeLPJgenoud}}	}

