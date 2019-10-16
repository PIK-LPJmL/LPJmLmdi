\name{LE2ET}
\alias{LE2ET}
\title{Compute evapotranspiration (ET) from latent heat (LE).}

\usage{LE2ET(le, temp = 20, rho_w = 1000)}
\arguments{
  \item{le}{latent heat (W m-2)}
  \item{temp}{temperature (degC, default 20 degC)}
  \item{rho_w}{
}
}

\value{The function returns evapotranspiration (mm day-1)}
\references{FAO (1998): Crop evapotranspiration - Guidelines for computing crop water requirements - FAO Irrigation and drainage paper 56, http://www.fao.org/docrep/x0490e/x0490e04.htm}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}



\seealso{\code{\link{WriteLPJinput}}}
\examples{
# Example from FAO (1998)
le <- 12 # latent heat that is used to vapourize water (MJ m-2 day-1)
le <- le / 86400 # MJ m-2 day-1  ->  MJ m-2 sec-1 
le <- le * 1E6 # MJ m-2 sec-1 -> W m-2
LE2ET(le=le)

temp <- -30:40
et <- LE2ET(le=le, temp=temp)
plot(temp, et)
}
