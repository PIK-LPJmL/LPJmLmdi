\name{plot.rescue}
\alias{plot.rescue}
\title{plot an object of class "rescue" / monitor OptimizeLPJgenoud}
\description{The function plots the cost per data set for all individuals of the genetic optimization from an object of class "rescue". This function can be used to monitor the development of the optimization within OptimizeLPJgenoud. Therefor read the rescue files from your optimization with "rescue.l <- CombineRescueFiles(list.files(pattern=".RData"), remove=FALSE)" and call "plot(rescue.l)". }
\usage{\method{plot}{rescue}(x, ylim = NULL, xlim = NULL, ylab = "Cost", xlab = "Individuals of genetic optimization", 
    only.cost = FALSE, ...)}
\arguments{
  \item{x}{a list of class "rescue", see \code{\link{CombineRescueFiles}}}
  \item{ylim}{limits of the y-axis of the plot}
  \item{xlim}{limits of the x-axis of the plot}
  \item{ylab}{label for the y axis}
  \item{xlab}{label for the x axis}
  \item{only.cost}{plot all integration datasets (TRUE) or only these ones with cost=TRUE}
  \item{\dots}{further arguments for \code{\link{plot}}}
}
\details{No details.}

\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{CombineRescueFiles}}}

