\name{LPJpp}
\alias{LPJpp}
\title{Post-process LPJmL model output}
\description{The function converts binary LPJmL output files to NetCDF and calculates summary statistics. Please note, climate data operators (CDO) is required.}
\usage{LPJpp(path, start = 1982, end = 2011, sim.start.year = 1901, 
    run.name = "LPJ", run.description = "LPJ run", provider = "M. Forkel, matthias.forkel@geo.tuwien.ac.at", 
    creator = provider, reference = "Sitch et al. 2003 GCB, Gerten et al. 2004 J. Hydrol., Thonicke et al. 2010 BG, Schaphoff et al. 2013 ERL, Forkel et al. 2014 BG", 
    lpj.df = NULL, convert = TRUE, calc.nbp = FALSE, calc.cbalance = FALSE, 
    calc.tau = FALSE, calc.et = FALSE, calc.tree = FALSE, pft.istree = 2:9, 
    mask = NA, ...)}
\arguments{
  \item{path}{directory with LPJmL outputs in *.bin format}
  \item{start}{first year for which the data should be converted to NetCDF}
  \item{end}{last year for which the data should be converted to NetCDF}
  \item{sim.start.year}{first year of the simulation}
  \item{run.name}{name of the LPJmL run (will be part of the file names)}
  \item{run.description}{description of the LPJmL run}
  \item{provider}{name of the provider}
  \item{creator}{name of the creator}
  \item{reference}{
}
  \item{lpj.df}{A data.frame with information about LPJmL outputs that should be post-processed. If NULL, a set of default outputs will post-processed. See details for the required structure of this data.frame.}
  \item{convert}{Convert files in lpj.df to NetCDF?}
  \item{calc.nbp}{Calculate net biome productivity? NBP = Rh + FireC + HarvestC - (NPP + Estab)}
  \item{calc.cbalance}{Calculate global total C stocks, fluxes, balances, and turnover times?}
  \item{calc.tau}{Calculate spatial fields of turnover times?}
  \item{calc.et}{Calculate evapotranspiration? ET = transp + evap + interc}
  \item{calc.tree}{Calculate total tree cover? See also the argument pft.istree}
  \item{pft.istree}{Which bands in fpc.bin represents tree?}
  \item{mask}{A mask in a NetCDF file in order to compute the C fluxes, stocks, balances and turnover times only for specific regions.}
  \item{\dots}{further arguments (currently not used)}
}
\details{The data.frame 'lpj.df' should have the following columns
\itemize{ 
\item{ \code{file} name of binary LPJmL output file (e.g. mgpp.bin)}
\item{ \code{var.name} short name of the variable (e.g. GPP)}
\item{ \code{var.unit} units of the variables in the input file (e.g. "gC m-2")}
\item{ \code{var.longname} (optional) long name of the variable (e.g. "Gross primary production"). If this column is not provided 'var.name' will be used instead.}
\item{ \code{var.agg.fun} (optional) name of a function to aggregate the varibale to annual values (e.g "sum", "mean", "min", "max", or NA (no aggregation)). If this column is not provided, aggregations will be not computed.}
\item{ \code{subset.start} (optional) This can be used to additionally subset the NetCDF files to a shorter time period. Set to a year (e.g. 2000) or NA.}
\item{ \code{subset.end} (optional) This can be used to additionally subset the NetCDF files to a shorter time period. Set to a year (e.g. 2001) or NA. }
\item{ \code{stat.annual} (optional) Set to TRUE to compute statistical values based on annual aggregated data. If this is not provided, statistical values will be not computed}
\item{ \code{stat.monthly} (optional) Set to TRUE to compute statistical values based on monthly data. If this is not provided, statistical values will be not computed}
}}

\references{No reference.	}
\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}





