\name{plot.LPJpar}
\alias{plot.LPJpar}
\title{Plot parameters in 'LPJpar' object.}

\usage{\method{plot}{LPJpar}(x, par.name = NULL, uncertainty = "uncertainty.005", 
    unc.change = FALSE, col = NULL, ylim = NULL, xlim = NULL, 
    which.pft = NULL, if.opt = FALSE, names = FALSE, opt.val = TRUE, 
    xaxt = "s", add = FALSE, xoff = 0)}
\arguments{
  \item{x}{object of class 'LPJpar'}
  \item{par.name}{name(s) of the parameters that should be plotted}
  \item{uncertainty}{name of the uncertainty estimate in LPJpar that should be used to plot posterior uncertainties}
  \item{unc.change}{plot the change in uncertainty? If TRUE the function plots the fraction of the posterior uncertainty relative to the prior, i.e. uncertainty / abs(upper - lower)}
  \item{col}{vector of colours for PFT-specific parameters}
  \item{ylim}{limits of the y-axis}
  \item{xlim}{limits of the x-axis}
  \item{which.pft}{character vector of PFT names that should be plotted. If NULL all }
  \item{if.opt}{plot parameters only if optimized (i.e. best) parameters are in LPJpar}
  \item{names}{plot PFT names within the plot?	}
  \item{opt.val}{plot value of optimized parameter?}
  \item{xaxt}{x axis type. "n" suppresses the x axis.}
  \item{add}{add to existing plot?}
  \item{xoff}{offset for adjusting in x-direction}
}
\details{No details.}

\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{LPJpar}}, \code{\link{CheckLPJpar}}	}
\examples{
# plot(lpjpar, par.name="ALBEDO_LEAF_TeBS", uncertainty="uncertainty.iqr95")
# plot(lpjpar, par.name="ALBEDO_LEAF", uncertainty="uncertainty.iqr")
# plot(lpjpar, par.name="LIGHTEXTCOEFF", uncertainty="uncertainty.iqr")
# par(mfrow=c(2,2))
# plot(lpjpar, par.name=c("ALPHAA", "LIGHTEXTCOEFF", "ALBEDO_LEAF", "ALBEDO_STEM"))
}
