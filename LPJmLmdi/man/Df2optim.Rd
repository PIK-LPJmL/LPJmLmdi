\name{Df2optim}
\alias{Df2optim}
\title{Convert a data.frame to a \code{\link{optim}} list }
\description{The function takes a 'data.frame' as created by \code{\link{Rescue2DF}} and converts it to a list with the same structure like the results of the \code{\link{optim}} and \code{\link{genoud}} functions.}
\usage{Df2optim(optim.df, pop.size = NA, ...)}
\arguments{
  \item{optim.df}{a 'data.frame' as created by \code{\link{Rescue2DF}}}
  \item{pop.size}{used population size. If NA, ngen (number of generations) and peak generation cannot be returned correctly. In this case both estimates will be 1.}
  \item{\dots}{further arguments (currently not used)}
}
\details{No details.}

\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{CombineRescueFiles}}}
\examples{
# files <- c(list.files(pattern="rescue.RData", recursive=TRUE), list.files(pattern="rescue0.RData", recursive=TRUE))
# rescue.l <- CombineRescueFiles(files, remove=FALSE)
# optim.df <- Rescue2Df(rescue.l)
# opt <- Rescue2optim(rescue.l)
# opt
}
