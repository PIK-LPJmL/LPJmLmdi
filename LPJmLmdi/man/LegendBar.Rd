\name{LegendBar}
\alias{LegendBar}
\title{Add a colour legend bar to a plot}
\description{Adds a colour legend bar to a plot}
\usage{LegendBar(x, y, brks = seq(0, 1, by = 0.2), cols = NULL, brks.txt = NULL, 
    title = "", srt = NULL, col.txt = "black", cex.txt = 1, ...)}
\arguments{
  \item{x}{x coordinates for the legend bar}
  \item{y}{y coordinates for the legend bar}
  \item{brks}{class breaks for the legend bar}
  \item{cols}{colours for each class. If NULL grey scales are used.}
  \item{brks.txt}{text labels for the class breaks. If NULL, 'brks' are used}
  \item{title}{title for the legend bar}
  \item{srt}{rotation of breaks text labels}
  \item{col.txt}{colour for text labels}
  \item{cex.txt}{size of the text labels}
  \item{\dots}{arguments (unused)}
}
\details{No details.}

\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{CRSll}}}
\examples{

plot.new()
LegendBar(x=c(0.1, 0.9), y=c(0.4, 0.6))
LegendBar(x=c(0.1, 0.5), y=c(0.7, 0.8))

brks <- seq(-1, 1, 0.2)
cols <- BreakColors(brks)
LegendBar(x=c(0.6, 1), y=c(0.7, 0.8), brks=brks, cols=cols, title="My title")

LegendBar(x=c(0.2, 0.8), y=c(0.1, 0.2), brks=brks, cols=cols, col.txt="purple", title="purple", srt=90)

}
