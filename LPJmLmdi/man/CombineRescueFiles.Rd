\name{CombineRescueFiles}
\alias{CombineRescueFiles}
\title{Combine single rescue files into one rescue file}
\description{Within OptimizeLPJgenoud, RunLPJ creates rescue file ("_.rescue0.RData") that save the parameter vectors and cost of each individual during optimization. These files allow to create restart files to restart OptimizeLPJgenoud (\code{\link{CreateRestartFromRescue}}). During OptimizeLPJgenoud many rescue files can be created. The function CombineRescueFiles reads the individual files, combines the rescue objects, saves it in one "rescue.RData" file, and deletes the single files.}
\usage{CombineRescueFiles(files.rescue, remove = TRUE)}
\arguments{
  \item{files.rescue}{file names}
  \item{remove}{save new rescue file and delete single rescue files?}
}
\details{No details.}
\value{The function returns a list of class "rescue", whereby each element corresponds to one individual of the genetic optimization with two entries: 'cost' (cost of the individual) and 'dpar' (parameter scaled relative to the prior parameter).}
\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{CreateRestartFromRescue}}, \code{\link{plot.rescue}}}

