\name{CreateRestartFromRescue}
\alias{CreateRestartFromRescue}
\title{Create a *.pro file from binary rescue files to restart optimization}
\description{The function creates a *.pro file friom binary 'rescue' files. The *.pro file can be used to restart OptimizeLPJgenoud. }
\usage{CreateRestartFromRescue(path.rescue, pop.size)}
\arguments{
  \item{path.rescue}{directory where the resuce files from each iteration of the optimization are saved.}
  \item{pop.size}{(estimated) population size of the genetic optimization}
}
\details{No details.}

\references{No reference.}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{genoudLPJrescue}}	}

