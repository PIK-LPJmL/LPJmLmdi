\name{plot.LPJsim}
\alias{plot.LPJsim}
\title{Plots a LPJsim object}
\description{The function plots a LPJsim object: monthly, annual time series or map of grid cells}
\usage{\method{plot}{LPJsim}(x, what = "annual", start = NA, end = NA, omit0 = TRUE, 
    AggFun = AggMeanNULL, ...)}
\arguments{
  \item{x}{an object of class 'LPJsim'}
  \item{what}{What type of plot should be created? 'annual' for yearly time series, 'monthly' for monthly time series, 'daily' for daily time series, and 'grid' for a map of grid cells}
  \item{start}{first year for time series plot}
  \item{end}{last year for time series plot}
  \item{omit0}{omit variables from plotting that are only 0?}
  \item{AggFun}{aggregation function to aggregate results to the temporal resolution as selected in 'what', for example \code{\link{AggMeanNULL}} for monthly or annual means, \code{\link{AggSumNULL}} for monthly or annual sums.}
  \item{\dots}{further arguments (currently not used)}
}
\details{No details.}

\references{No reference.}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{ReadLPJ2ts}}, \code{\link{ReadLPJsim}}}
\examples{

# setwd(path.mylpjresult)
# sim <- ReadLPJ2ts(start=1982, end=2011)
# plot(sim, what="annual")

}
