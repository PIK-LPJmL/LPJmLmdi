\name{GridProperties}
\alias{GridProperties}
\title{Derive grid properties from an object of class 'LPJfiles'}
\description{The function reads the grid of the input files in 'LPJfiles' and computes the area per grid cell.}
\usage{GridProperties(lpjfiles, res = 0.5, ...)}
\arguments{
  \item{lpjfiles}{list of class 'LPJinput'}
  \item{res}{resolution of LPJmL}
  \item{\dots}{further arguments (currently not used)}
}
\details{No details.}
\value{the function returns a list with 'grid' (raster of grid cells), 'area' (vector of grid cell area) and 'ncell' (number of grid cells)}
\references{No reference.}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{LPJfiles}}	}

