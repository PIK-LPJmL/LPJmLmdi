\name{CostMDS.KGEw}
\alias{CostMDS.KGEw}
\title{Cost function for multiple data streams based on a weighted Kling-Gupta efficiency}
\description{The function computes for each grid cell and data stream in 'integrationdata' the cost besed on the Kling-Gupta efficiency (KGE, Gupta et al. 2009, J. Hydrology). Thereby each component of KGE is weighted by the uncertainty of the observations (i.e. weighted mean, variance and correlation). See Forkel et al. (in prep.) for the specific use of KGE for multiple data streams.}
\usage{CostMDS.KGEw(integrationdata)}
\arguments{
  \item{integrationdata}{object of class 'integrationdata', see \code{\link{IntegrationData}}}
}
\details{No details.}
\value{The function returns a list with the total cost (total), the cost per KGE component (per.cell), per data streams (per.ds), per KGE component and data stream (per.cell.ds), and the fractional contribution of a data stream and KGE component to the total cost (fractional).}
\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}




\examples{

# load(paste0(path.me, "/lpj/LPJmL_131016/out_optim/opt_fpc/OFPC_BO-GI-BM_v1_all_0_59_posterior-best.RData"))
# x <- result.post.lpj$integrationdata
# plot(x, 2)

# cost.see <- CostMDS.SSE(x)
# cost.kge <- CostMDS.KGE(x)
# cost.kgew <- CostMDS.KGEw(x)

# DefaultParL(mfrow=c(1,3))
# barplot(cost.see$per.ds)
# barplot(t(cost.kge$per.cell.ds))
# barplot(t(cost.kgew$per.cell.ds))

}
