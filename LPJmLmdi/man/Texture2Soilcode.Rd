\name{Texture2Soilcode}
\alias{Texture2Soilcode}
\title{Convert soil texture to a LPJ soilcode}
\description{The function takes fractions/percentages of sand, silt and clay and returns the correspondign LPJ soil code. The USDA soil classification is used. The function requires the package "soiltexture".}
\usage{Texture2Soilcode(sand, silt, clay, lpj.soilcodes = c("Cl", "SiCl", 
    "SaCl", "ClLo", "SiClLo", "SaClLo", "Lo", "SiLo", "SaLo", 
    "Si", "LoSa", "Sa"), plot = TRUE, ...)}
\arguments{
  \item{sand}{percentage of sand}
  \item{silt}{percentage of silt}
  \item{clay}{percentage of clay}
  \item{lpj.soilcodes}{LPJ soil codes}
  \item{plot}{plot soil triangle?}
  \item{\dots}{Further arguments (currently not used).}
}
\details{No details.}
\value{The function returns the LPJ soilcode}
\references{No reference.}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{ReadBIN}}}
\examples{

# data.sp <- SpatialPointsDataFrame(lpjinput$grid, as.data.frame(data.m))
# WriteBIN(data.sp, file="data.bin")	

}
