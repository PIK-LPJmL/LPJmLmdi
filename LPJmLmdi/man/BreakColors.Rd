\name{BreakColors}
\alias{BreakColors}
\title{Colours from class breaks}
\description{Creates colour palettes from a vector of class breaks}
\usage{BreakColors(x, pal = NULL, rev = FALSE, cols = NULL, ...)}
\arguments{
  \item{x}{numeric vector of class breaks}
  \item{pal}{name of a colour palette from \code{\link{brewer.pal}}}
  \item{rev}{should the colour palette be reversed?}
  \item{cols}{alternatively, a colour vector to be interpolated}
  \item{\dots}{Further arguments (unused)}
}
\details{No details.}
\value{The function returns a vector of colours.}
\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{BreakColours}}}
\examples{

brks1 <- seq(0, 10, 2)
cols1 <- BreakColours(brks1)

brks2 <- seq(-100, 100, 25)
cols2 <- BreakColours(brks2)

brks3 <- seq(-100, 100, 25)
cols3 <- BreakColours(brks3, pal="BrBG")

brks4 <- seq(0, 10, 1)
cols4 <- BreakColours(brks4, cols=c("red", "green", "blue"), rev=TRUE)

MapRb()
LegendBarRb(brks=brks1, cols=cols1)
LegendBarRb(brks=brks2, cols=cols2, pos="top", lon = c(-180, 180), lat = c(-20, -15))
LegendBarRb(brks=brks3, cols=cols3, pos="inside", lon = c(-180, 180), lat = c(15, 20))
LegendBarRb(brks=brks4, cols=cols4, pos="inside", lon = c(-180, 180), lat = c(30, 35))

}
