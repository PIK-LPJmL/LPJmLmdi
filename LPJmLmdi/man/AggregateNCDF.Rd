\name{AggregateNCDF}
\alias{AggregateNCDF}
\title{Temporal aggregations and statistics on NetCDF files}
\description{Compute temporal aggregations and statistics of data in NetCDF files.}
\usage{AggregateNCDF(files, fun.agg = sum, var.name = NULL, tstep = NULL, 
    agg.monthly = TRUE, agg.annual = TRUE, agg.ndaily = TRUE, 
    ndays = 7, stat.annual = TRUE, stat.monthly = FALSE, stat.ndaily = FALSE, 
    stat.daily = FALSE, msc.monthly = TRUE, path.out = NULL, 
    path.out.prefix = "img", nodes = 1, stats = NULL, ...)}
\arguments{
  \item{files}{(character) file name or vector file names. In case of multiple file names, it is assumed that each file corresponds to a different time period (i.e. all files are a time series)}
  \item{fun.agg}{function to be used for temporal aggregations}
  \item{var.name}{(character) variable name in NetCDF files for which computations should be done. If NULL, all variables will be processed.}
  \item{tstep}{(character) time step of input data: "daily", "ndaily" (period of n days), "monthly", "annual". If NULL tstep will be estimated from the files.}
  \item{agg.monthly}{(boolean) aggregate to monthly data? This will be only done if 'tstep' is daily or ndaily.}
  \item{agg.annual}{(boolean) aggregate to annual data? This will be only done if 'tstep' is < annual.}
  \item{agg.ndaily}{(boolean) aggregate to N-daily periods? This will be only done if 'tstep' is < ndays.}
  \item{ndays}{(integer) length of period [in days] for N-daily aggregations. For example, a aggregation to 7-daily periods will be done if ndays=7. A period starts always at the 1st January. Please note that a 7-daily aggregation does not necessarily correspond to calendar weeks (see \code{\link{GroupDates}} for details). This aggregation will be only done if 'tstep' is < ndays.}
  \item{stat.annual}{(boolean) compute statistics based on annual data?}
  \item{stat.monthly}{(boolean) compute statistics based on monthly data?}
  \item{stat.ndaily}{(boolean) compute statistics based on N-daily data?}
  \item{stat.daily}{(boolean) compute statistics based on daily data?}
  \item{msc.monthly}{(boolean) compute (mean/median) seasonal cycles on monthly data and monthly anomalies? This computation is based on \code{\link{SeasonalCycleNCDF}} and uses CDO modules.}
  \item{path.out}{directory for output files. If NULL, directories will be created within the location of the files, otherwise directories will be created under the specified directory.}
  \item{path.out.prefix}{prefix for output directory names, directory names are created according to the following pattern 'prefix'_'resolution'_'timestep' (e.g. img_0d25_monthly)}
  \item{nodes}{How many nodes should be used for parallel processing of files? Parallel computing can be only used if length(files) > 1.}
  \item{stats}{statistical metrics to compute}
  \item{\dots}{further agruments (unused)}
}



\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}





