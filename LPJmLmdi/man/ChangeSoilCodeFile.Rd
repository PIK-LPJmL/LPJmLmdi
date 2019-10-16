\name{ChangeSoilCodeFile}
\alias{ChangeSoilCodeFile}
\title{Change soil code in LPJ soil code file}
\description{The function changes the soil code for the specified grid cells and writes a new LPJ soil code file.}
\usage{ChangeSoilCodeFile(file.soilcode, file.soilcode.new, xy, newcode, 
    file.grid = "cru.grid", ...)}
\arguments{
  \item{file.soilcode}{original soil code file}
  \item{file.soilcode.new}{new soil code file}
  \item{xy}{matrix of grid cells (lon, lat) where the soil code should be changed}
  \item{newcode}{new soil code at each grid cell (vector with length = nrow(xy))}
  \item{file.grid}{grid file for the original soil code file}
  \item{\dots}{further arguments (currently not used)}
}
\details{No details.}

\references{No reference.}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{ReadBIN}}}

