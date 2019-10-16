\name{OptimizeLPJgenoud}
\alias{OptimizeLPJgenoud}
\title{Optimize LPJ using the GENOUD optimizer (genetic optimization using derivatives)}
\description{This function performs an optimization of LPJmL model parameters for the specified grid cells unsing the GENOUD genetic optimization algorithm.}
\usage{OptimizeLPJgenoud(xy, name, lpjpar, par.optim, lpjfiles, lpjcmd = "srun ./bin/lpjml", 
    copy.input = TRUE, integrationdata, plot = TRUE, pop.size = 1000, 
    max.generations = 20, wait.generations = 19, BFGSburnin = 18, 
    calc.jacob = FALSE, restart = 0, path.rescue = NULL, restart.jacob = FALSE, 
    nodes = 1, maxAutoRestart = 5, runonly = FALSE, warnings = TRUE, 
    new.spinup4post = TRUE, CostMDS = CostMDS.SSE)}
\arguments{
  \item{xy}{matrix of grid cell coordinates to run LPJ}
  \item{name}{name of the experiment (basic file name for all outputs)}
  \item{lpjpar}{data.frame of class \code{\link{LPJpar}} that define all LPJ parameter values, ranges, and names}
  \item{par.optim}{names of the parameters that should be optimized}
  \item{lpjfiles}{list of class \code{\link{LPJfiles}} that define all LPJ directories, input files, configuration template files}
  \item{lpjcmd}{How you usually run the LPJ model at the console: 'srun ./bin/lpjml' or './bin/lpjml'	}
  \item{copy.input}{Should LPJ input data be copied to the directory for temporary output? This might speed up computations if the directory is on the same machine where the program runs. }
  \item{integrationdata}{list of integration data and information}
  \item{plot}{plot diagnostic graphics of optimization results?}
  \item{pop.size}{population size, see \code{\link{genoud}}}
  \item{max.generations}{max number of generations, see \code{\link{genoud}}}
  \item{wait.generations}{How many generations should genoud wait before returning an optimum, see \code{\link{genoud}}}
  \item{BFGSburnin}{The number of generations before the L-BFGS-B algorithm is first used, see \code{\link{genoud}}}
  \item{calc.jacob}{Should the Hessian and Jacobian matrix be computed (yes = TRUE, no = FALSE)?}
  \item{restart}{Where to re-start the optimization? 0 = start at the beginning, 1 = continue with existing genoud optimization, 2 = start after genoud and post-process results. }
  \item{path.rescue}{directory where the resuce files from each iteration of a previous optimization are saved. This is needed if restart > 0.}
  \item{restart.jacob}{Should the Hessian and Jacobian matrix be recomputed if restart > 0 (yes = TRUE, no = FALSE)? Works only if calc.jacob is TRUE.}
  \item{nodes}{use parallel computing? How many nodes to use?}
  \item{maxAutoRestart}{maximum number of automatic restarts of the optimization if an error occurs within genoud()}
  \item{runonly}{run only the model with prior parameters set but don't perform optimization. Produces only results of prior model run.}
  \item{warnings}{print all LPJmL warning messages during optimization?}
  \item{new.spinup4post}{What spinup conditions should be used for the posterior ('posterior-best' and 'posterior-median')  model runs? If TRUE, a new spinup is computed based on the optimized parameters. If FALSE, the posterior model runs are started from the spinup conditions of the prior model run (like the runs during optimization).}
  \item{CostMDS}{cost function for multiple data streams to calculate total cost, cost per data stream, and eventually cost per grid cell. See \code{\link{CostMDS.SSE}} (default) or \code{\link{CostMDS.KGE}}}
}



\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}





