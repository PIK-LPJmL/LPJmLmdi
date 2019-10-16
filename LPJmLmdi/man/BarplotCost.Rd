\name{BarplotCost}
\alias{BarplotCost}
\title{plot a barplot of the cost change from prior to best parameter set}
\description{The function plots two barplots that are showing the change in the cost per dataset.}
\usage{BarplotCost(rescue.l, type = 1:2, ylim = NULL, set.par = TRUE, 
    ...)}
\arguments{
  \item{rescue.l}{a list of class "rescue", see \code{\link{CombineRescueFiles}}}
  \item{type}{plot type: 1 barplot of total cost from prior and best, 2: change of cost per data set }
  \item{ylim}{limits of y-axis (works for type = 2)}
  \item{set.par}{set par() settings from \code{\link{DefaultParL}}}
  \item{\dots}{further arguments for \code{\link{plot}}}
}
\details{No details.}

\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{CombineRescueFiles}}}
\examples{
# files <- c(list.files(pattern="rescue.RData", recursive=TRUE), list.files(pattern="rescue0.RData", recursive=TRUE))
# rescue.l <- CombineRescueFiles(files, remove=FALSE)
# BarplotCost(rescue.l)
}
