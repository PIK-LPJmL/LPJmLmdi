\name{PlotParPCA}
\alias{PlotParPCA}
\title{plot a PCA of optimized parameters}
\description{The function takes an object of class 'rescue' (see \code{\link{CombineRescueFiles}}), computes a PCA (principle component analysis) based on the model parameter sets and cost function values of the optimization, and plots PCA results as biplots. }
\usage{PlotParPCA(rescue.l, ...)}
\arguments{
  \item{rescue.l}{a list of class "rescue", see \code{\link{CombineRescueFiles}}}
  \item{\dots}{further arguments for \code{\link{plot}}}
}
\details{No details.}
\value{The function returns an object of class 'princomp'.}
\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{CombineRescueFiles}}, \code{\link{princomp}}}

