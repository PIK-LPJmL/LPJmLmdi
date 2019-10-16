\name{RunLPJ}
\alias{RunLPJ}
\title{Run LPJmL from R and get results}
\description{This function calls LPJmL, reads the results of the model run, computes the cost based on the data sets in \code{\link{IntegrationData}} and the defined cost function (in CostMDS), and returns the simulation results. }
\usage{RunLPJ(dpar, lpjpar, which.par.opt, lpjfiles, path = NULL, integrationdata, 
    xy, newcell = FALSE, name = "LPJmL", lpjcmd = "srun ./bin/lpjml", 
    plot = FALSE, getresult = FALSE, clean = 1, clean.path = FALSE, 
    CostMDS = CostMDS.SSE, nkeep = 400, warnings = TRUE)}
\arguments{
  \item{dpar}{vector of scaling factors for each parameter in 'which.par.opt': parameter = dpar * prior (e.g. if dpar is 1, prior parameters are used in the model run). Optimization is performed on these scaling factors}
  \item{lpjpar}{data.frame of class \code{\link{LPJpar}} that define LPJ parameter values, ranges, and names}
  \item{which.par.opt}{integer vector that indicates which parameters in lpjpar should be optimized}
  \item{lpjfiles}{list of class \code{\link{LPJfiles}} that define all LPJ directories, input files, configuration template files}
  \item{path}{path for output files of actual model run}
  \item{integrationdata}{list of of class \code{\link{IntegrationData}} }
  \item{xy}{matrix of grid cell coordinates to run LPJ}
  \item{newcell}{calculate new cell and new spinup?}
  \item{name}{name of the LPJ run, basic name for all outputs}
  \item{lpjcmd}{How you usually run the LPJ model at the console: 'srun ./bin/lpjml' or './bin/lpjml'}
  \item{plot}{plot results? see \code{\link{plot.IntegrationData}}}
  \item{getresult}{If TRUE, all model results are returned in a LPJsim object and model results are saved. If FALSE, only the cost function value is returned.}
  \item{clean}{clean results and temporay configuration and parameter files? 0 = keep everthing; 1 = delete parameter files, conf files and outputs; 2 = clean additionally input files, soil code files and restart}
  \item{clean.path}{Delete output directory 'path' in case it already exists before the model run?}
  \item{CostMDS}{cost function for multiple data streams}
  \item{nkeep}{number of result files to keep. If more are existing, the ones with highest costs will be deleted}
  \item{warnings}{print all LPJmL warning messages during optimization?}
}



\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}





