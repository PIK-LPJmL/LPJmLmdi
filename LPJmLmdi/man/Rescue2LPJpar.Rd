\name{Rescue2LPJpar}
\alias{Rescue2LPJpar}
\title{Add information from a 'rescue' list to an 'LPJpar' object}
\description{The function takes an object of class 'rescue' (see \code{\link{CombineRescueFiles}}) (alternatively a 'data.frame' as created with \code{\link{Rescue2Df}}) and a 'LPJpar' (see \code{\link{LPJpar}}) object. Then it extracts the best parameter set, the median of the best parameter sets (defined based on dAIC <= 2), and various uncertainty measures and adds them to the 'LPJpar' object.}
\usage{Rescue2LPJpar(rescue.l, lpjpar, ...)}
\arguments{
  \item{rescue.l}{a list of class "rescue" (\code{\link{CombineRescueFiles}}) or alternatively a data.frame as created with \code{\link{Rescue2Df}}.}
  \item{lpjpar}{a list of class "LPJpar" (\code{\link{LPJpar}})}
  \item{\dots}{further arguments (currently not used)}
}
\details{No details.}
\value{The function returns the provided 'LPJpar' object with the following additional slots:
\itemize{ 
\item{ \code{best} Best parameter set }
\item{ \code{best.median} median of best parameter sets (based on all parameter sets with dAIC <= 2) }
\item{ \code{uncertainty.iqr} uncertainty of parameters as the inter-quartile range of the best parameter sets }
\item{ \code{uncertainty.iqr95} uncertainty of parameters as the central 95\% inter-quantile range (0.975-0.025) of the best parameter sets }
\item{ \code{uncertainty.005.min} lower parameter uncertainty estimate based on the minimum parameter value from all parameter sets for which the cost <= quantile(cost, 0.05) }
\item{ \code{uncertainty.005.max} upper parameter uncertainty estimate based on the maximum parameter value from all parameter sets for which the cost <= quantile(cost, 0.05) }
}	}
\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{CombineRescueFiles}}}
\examples{
# files <- c(list.files(pattern="rescue.RData", recursive=TRUE), list.files(pattern="rescue0.RData", recursive=TRUE))
# rescue.l <- CombineRescueFiles(files, remove=FALSE)
# lpjpar2 <- Rescue2LPJpar(rescue.l, lpjpar)
# str(lpjpar2)
# plot(lpjpar2, "ALPHAA", "uncertainty.iqr95")
# plot(lpjpar2, "TMIN_BASE", "uncertainty.iqr95")
}
