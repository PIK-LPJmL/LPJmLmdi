\name{DefaultParL}
\alias{DefaultParL}
\title{default 'par' settings for plots}
\description{The function calls 'par' with some default settings to improve plots. See \code{\link{par}} for details.}
\usage{DefaultParL(mfrow = c(1, 1), mar = c(3.7, 3.5, 2.5, 0.5), oma = c(0.8, 
    0.1, 0.1, 0.2), mgp = c(2.4, 1, 0), cex = 1.3, cex.lab = cex * 
    1.1, cex.axis = cex * 1.1, cex.main = cex * 1.1, ...)}
\arguments{
  \item{mfrow}{number of rows/columns}
  \item{mar}{margins}
  \item{oma}{outer margins}
  \item{mgp}{margin line for axis title, label and lines}
  \item{cex}{text and symbol size}
  \item{cex.lab}{label size}
  \item{cex.axis}{axis anootation size	}
  \item{cex.main}{title size}
  \item{\dots}{further arguments to \code{\link{par}}}
}
\details{No details.}

\references{No reference.}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{par}}}
\examples{

DefaultParL()
plot(1:10)

}
