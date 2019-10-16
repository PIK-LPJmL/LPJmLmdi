\name{Cbalance}
\alias{Cbalance}
\title{Calculate global C balance, C fluxes and stocks}
\description{The function takes numeric vectors or NetCDF files with values of C fluxes and stocks, and calculates C balances and turnover times [years] (see details). In case of NetCDF files, global total C fluxes and stocks [PgC year-1] are computed from NetCDF files. Thereby the input data unit needs to be [gC m-2] for stocks and [gC m-2 year-1] for fluxes. However, the argument scale is a multiplier that can be used to convert to the original unit to [gC m-2]. The results are returned as a data.frame (table). If some values or files are not provided (i.e. NA), the function will first try to compute these from other metrics (see details). }
\usage{Cbalance(gpp = NA, npp = NA, ra = NA, rh = NA, reco = NA, firec = NA, 
    estab = NA, harvest = NA, vegc = NA, soilc = NA, litc = NA, 
    scale = 1, ti = NA, mask = NA, ...)}
\arguments{
  \item{gpp}{numeric vector or NetCDF file of gross primary production }
  \item{npp}{numeric vector or NetCDF file of net primary production}
  \item{ra}{numeric vector or NetCDF file of autotrophic respiration}
  \item{rh}{numeric vector or NetCDF file of heterotrophic respiration}
  \item{reco}{numeric vector or NetCDF file of ecosystem respiration}
  \item{firec}{numeric vector or NetCDF file of fire C emissions}
  \item{estab}{numeric vector or NetCDF file of establishment C flux (specific to LPJ)}
  \item{harvest}{numeric vector or NetCDF file of C removal from vegetation through harvest}
  \item{vegc}{numeric vector or NetCDF file of vegetation C stocks (or biomass)}
  \item{soilc}{numeric vector or NetCDF file of soil C stocks}
  \item{litc}{numeric vector or NetCDF file of litter C stocks}
  \item{scale}{multiplier to convert original units to gC m-2 (stocks) or gC m-2 year-1 (fluxes)}
  \item{ti}{time axis of the data. In case of NetCDF files, time will be extracted from the files.}
  \item{mask}{A mask in a NetCDF file in order to compute the C fluxes, stocks, balances and turnover times only for specific regions.}
  \item{\dots}{further arguments (currently not used)}
}
\details{The function computes (global) terrestrial C balances based on given input data. The used terminology is based on Schulze (2006) and Chapin et al. (2006). The following equations are used:
\itemize{ 
\item{ Net primary production NPP = GPP - Ra }
\item{ Ecosystem respiration Reco = Rh + Ra }
\item{ Net ecosystem exchange NEE = Reco - GPP = Rh - NPP}
\item{ Net biome productivity NBP = (GPP + Estab) - (Reco + FireC + Harvest) }
}
Vegetation and total ecosystem turnover times are computed based on the formulas in Carvalhais et al. (2014) and Thurner et al. (2016):
\item{ Vegetation turnover time: TauVeg_NPP = VegC / NPP }
\item{ Vegetation turnover time based on GPP is a approximiation to the real vegetation turnover time (TauVeg_NPP) assuming that NPP is around 50\% of GPP: TauVeg_GPP = VegC / ((GPP+Estab) * 0.5) }
\item{ Total ecosystem turnover time as in Carvalhais et al. (2014): TauEco_GPP = (VegC + SoilC + LitC) / (GPP+Estab) }
\item{ Total ecosystem turnover time based on Reco: TauEco_Reco = (VegC + SoilC + LitC) / Reco }
\item{ Total ecosystem turnover time based on Reco and disturbances: TauEco_Dist = (VegC + SoilC + LitC) / (Reco + FireC + Harvest) }
}}

\references{Carvalhais, N. et al. (2014), Global covariation of carbon turnover times with climate in terrestrial ecosystems, Nature, 514(7521), 213–217, doi:10.1038/nature13731.
Chapin, F. S. et al. (2006), Reconciling Carbon-cycle Concepts, Terminology, and Methods, Ecosystems, 9(7), 1041–1050, doi:10.1007/s10021-005-0105-7.
Schulze, E.-D. (2006), Biological control of the terrestrial carbon sink, Biogeosciences, 3(2), 147–166, doi:10.5194/bg-3-147-2006.
Thurner, M., C. Beer, N. Carvalhais, M. Forkel, M. Santoro, M. Tum, and C. Schmullius (2016), Large‐scale variation in boreal and temperate forest carbon turnover rate is related to climate, Geophysical Research Letters, doi:10.1002/2016GL068794.}
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
