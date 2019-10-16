\name{plot.Cbalance}
\alias{plot.Cbalance}
\title{Plots a C balance}
\description{The function takes an object of class \code{\link{Cbalance}} and creates time series plots or barplots.}
\usage{\method{plot}{Cbalance}(x, what = NULL, trend = TRUE, baseunit = "PgC", 
    ylab = NULL, ...)}
\arguments{
  \item{x}{object of class \code{\link{Cbalance}}}
  \item{what}{Which variables of C balance to plot? If NULL, sole plots are generated automatically.}
  \item{trend}{Compute trends?}
  \item{baseunit}{unit of C stocks}
  \item{ylab}{labels for y-axis}
  \item{\dots}{further arguments (currently not used)}
}



\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}




\examples{

# with some typical numbers for the global C budget:
cbal <- Cbalance(gpp=123, npp=61, rh=57, firec=2, vegc=400, soilc=2400)
cbal
plot(cbal)

## using time series::
#cbal <- Cbalance(gpp=118:128, npp=(118:128)*rnorm(11, 0.5, 0.1), rh=57, firec=runif(11, 0, 4), harvest=2, vegc=400, soilc=2400)
#cbal
#plot(cbal)


}
