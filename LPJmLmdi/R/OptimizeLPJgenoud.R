OptimizeLPJgenoud <- structure(function(
	##title<< 
	## Optimize LPJ using the GENOUD optimizer (genetic optimization using derivatives)
	##description<<
	## This function performs an optimization of LPJmL model parameters for the specified grid cells unsing the GENOUD genetic optimization algorithm.

	xy,
	### matrix of grid cell coordinates to run LPJ
	
	name,
	### name of the experiment (basic file name for all outputs)
	
	lpjpar,
	### data.frame of class \code{\link{LPJpar}} that define all LPJ parameter values, ranges, and names
	
	par.optim,
	### names of the parameters that should be optimized
	
	lpjfiles,
	### list of class \code{\link{LPJfiles}} that define all LPJ directories, input files, configuration template files
	
	lpjcmd = "srun ./bin/lpjml",
	### How you usually run the LPJ model at the console: 'srun ./bin/lpjml' or './bin/lpjml'	
	
	copy.input = TRUE,
	### Should LPJ input data be copied to the directory for temporary output? This might speed up computations if the directory is on the same machine where the program runs. 
	
	integrationdata,
	### list of integration data and information

	plot=TRUE,
	### plot diagnostic graphics of optimization results?
	
	pop.size=1000,
	### population size, see \code{\link{genoud}}
	
	max.generations=20,
	### max number of generations, see \code{\link{genoud}}
	
	wait.generations=19,
	### How many generations should genoud wait before returning an optimum, see \code{\link{genoud}}
	
	BFGSburnin=18,
	### The number of generations before the L-BFGS-B algorithm is first used, see \code{\link{genoud}}
	
	calc.jacob=FALSE,
	### Should the Hessian and Jacobian matrix be computed (yes = TRUE, no = FALSE)?
	
	restart=0,
	### Where to re-start the optimization? 0 = start at the beginning, 1 = continue with existing genoud optimization, 2 = start after genoud and post-process results. 
	
	path.rescue=NULL,
	### directory where the resuce files from each iteration of a previous optimization are saved. This is needed if restart > 0.
	
	restart.jacob=FALSE,
	### Should the Hessian and Jacobian matrix be recomputed if restart > 0 (yes = TRUE, no = FALSE)? Works only if calc.jacob is TRUE.
		
	nodes=1,
	### use parallel computing? How many nodes to use?
		
	maxAutoRestart=5,
	### maximum number of automatic restarts of the optimization if an error occurs within genoud()
	
	runonly=FALSE,
	### run only the model with prior parameters set but don't perform optimization. Produces only results of prior model run.
	
	warnings = TRUE,
	### print all LPJmL warning messages during optimization?
	
	new.spinup4post=TRUE,
	### What spinup conditions should be used for the posterior ('posterior-best' and 'posterior-median')  model runs? If TRUE, a new spinup is computed based on the optimized parameters. If FALSE, the posterior model runs are started from the spinup conditions of the prior model run (like the runs during optimization).
	
	CostMDS = CostMDS.SSE
	### cost function for multiple data streams to calculate total cost, cost per data stream, and eventually cost per grid cell. See \code{\link{CostMDS.SSE}} (default) or \code{\link{CostMDS.KGE}}
	
) {

	
	#--------------------------------
	# prepare optimization experiment
	#--------------------------------
		
	# select parameters to be optimized
	lpjpar <- CheckLPJpar(lpjpar, correct=FALSE)
	par.optim <- unique(par.optim)
	par.optim <- sort(par.optim) # order alphabetically
	which.par.opt <- match(par.optim, lpjpar$names)
	bool <- is.na(which.par.opt)
	if (any(bool)) stop(paste0("Parameter '", par.optim[bool], "' does not exist in lpjpar. Check 'par.optim'."))
	
	# get LPJ cell number from coordinates
	xy <- cbind(as.numeric(xy[,1]), as.numeric(xy[,2])) 
	grid.l <- GridProperties(lpjfiles)
	lpjfiles$grid <- grid.l
	cell <- extract(grid.l$grid, xy) - 1
	ncell <- length(cell)
	cell.startend <- c(cell[1], cell[ncell])
		
	# directory for optimization results
	# path.optresult <- paste(lpjfiles$path.out, "/", name, "_", cell.startend[1], "_", cell.startend[2], sep="")
	path.optresult <- paste(lpjfiles$path.out, "/", name, sep="")
	path.optresult <- gsub("//", "/", path.optresult)
	dir.create(path.optresult)
	
	# file for optimization results
	# file.optresult <- paste(path.optresult, "/", name, "_", cell.startend[1], "_", cell.startend[2], ".pro", sep="")
	file.optresult <- paste(path.optresult, "/", name, ".pro", sep="")	
	file.optresult <- gsub("//", "/", file.optresult)
	file.optsetup <- gsub(".pro", "_optsetup.RData", file.optresult, fixed=TRUE)
	
	# prepare restart
	if (restart > 0 & !is.null(path.rescue) & !runonly) {
		# check if file opt result exists if optimization should be restarted
		if (!file.exists(path.rescue)) {
			restart <- 0
			message(paste("OptimizeLPJgenoud: restart changed to 0 because", file.optresult, "does not exist.", Sys.time()))
		} else {
			# prepare rescue files
			message(paste("OptimizeLPJgenoud: Read rescue files from previous optimization for restart.", Sys.time()))
			file.restart <- CreateRestartFromRescue(path.rescue, pop.size)$file
			system(paste("cp", file.restart, file.optresult))
		}
	}
	
	# save optimization setup file
	setwd(lpjfiles$path.out)
	save(xy, name, pop.size, max.generations, wait.generations, BFGSburnin, cell, file.optresult, lpjpar, par.optim, lpjfiles, integrationdata, which.par.opt, CostMDS, file=file.optsetup)	
	file.copy(file.optsetup, gsub(".RData", "_backup.RData", file.optsetup, fixed=TRUE))
	
		
	# print information about optimization experiment
	if (runonly) {
		message(paste(
			" ",
			"------------------------------------------------------------------",
			"-- OptimizeLPJgenoud ---------------------------------------------",
			paste("-- start at ", Sys.time()),
			"-- Run LPJmL with prior parameters",
			paste("name                :", name), 
			paste("number grid cells   :", nrow(xy)),
			paste("first grid cell     : ", paste(xy[1,], collapse=" E, "), " N", sep=""),
			paste("last grid cell      : ", paste(xy[nrow(xy),], collapse=" E, "), " N", sep=""),
			paste("opt. setup file     :", file.optsetup), 
			paste("population file     :", file.optresult)[!runonly], 
			"------------------------------------------------------------------",
			"\n",
			sep="\n"))

	} else {
		message(paste(
			" ",
			"------------------------------------------------------------------",
			"-- OptimizeLPJgenoud ---------------------------------------------",
			paste("-- start at ", Sys.time()),
			"-- Information about optimization experiment",
			paste("name                :", name), 
			paste("number grid cells   :", nrow(xy)),
			paste("first grid cell     : ", paste(xy[1,], collapse=" E, "), " N", sep=""),
			paste("last grid cell      : ", paste(xy[nrow(xy),], collapse=" E, "), " N", sep=""),
			paste("pop.size            :", pop.size)[restart<2],
			paste("max.generations     :", max.generations)[restart<2], 
			paste("wait.generations    :", wait.generations)[restart<2],
			paste("BFGSburnin          :", BFGSburnin)[restart<2], 
			paste("restart             :", c("start new optimization", "continue with previous GENOUD optimization", "continue after GENOUD")[restart+1]), 
			paste("opt. setup file     :", file.optsetup), 
			paste("population file     :", file.optresult), 
			paste("parameters          :", paste(lpjpar$names[which.par.opt], collapse=", ")),
			"------------------------------------------------------------------",
			"\n",
			sep="\n"))
	}
		
		
	#-----------------
	# check parameters
	#-----------------
		
	# prior and best guess initial parameters
	npar <- length(lpjpar$prior)
	
	# create scaled parameters
	dlpjpar <- LPJpar(par.prior=rep(1, npar), par.lower=(lpjpar$lower / lpjpar$prior), par.upper=(lpjpar$upper / lpjpar$prior), par.pftspecif=lpjpar$pftspecif, par.names=lpjpar$names, correct=TRUE)
	
	# write parameter files with prior parameters
	setwd(path.optresult)
	WriteLPJpar(lpjpar, file=gsub(".pro", "", file.optresult, fixed=TRUE), pft.par=lpjfiles$pft.par, param.par=lpjfiles$param.par)
	
	
	#----------------------
	# check integrationdata
	#----------------------
	
	# subset integrationdata for time period of model run
	integrationdata <- llply(integrationdata, function(ds) {
	   years.ds <- format(ds$data.time, "%Y")
	   
	   # cut data if it starts before first year of model run
	   if (!is.na(lpjfiles$sim.start.year)) {
	      bool <- years.ds < lpjfiles$sim.start.year
	      if (any(bool)) {
	         ds$data.time <- ds$data.time[!bool]
	         ds$data.val <- matrix(ds$data.val[!bool, ], ncol=ncell, nrow=length(ds$data.time))
	         ds$data.unc <- matrix(ds$data.unc[!bool, ], ncol=ncell, nrow=length(ds$data.time))
	      }
	   }
	   
	   # cut data if it ends after last year of model run
	   if (!is.na(lpjfiles$sim.end.year)) {
	      bool <- years.ds > lpjfiles$sim.end.year
	      if (any(bool)) {
	         ds$data.time <- ds$data.time[!bool]
	         ds$data.val <- matrix(ds$data.val[!bool, ], ncol=ncell, nrow=length(ds$data.time))
	         ds$data.unc <- matrix(ds$data.unc[!bool, ], ncol=ncell, nrow=length(ds$data.time))
	      }
	   }	   
	   return(ds)
	})
	
	
	#---------------------------------------------------------------
	# define directory for temporary outputs and copy LPJ input data 
	#---------------------------------------------------------------

	# path for temporary output
	path.tmp.out.act <- tempfile(system("whoami", intern=TRUE), tmpdir=lpjfiles$path.tmp)
	path.tmp.out.act <- gsub("//", "/", path.tmp.out.act)
	dir.create(path.tmp.out.act)
	# file.optresult.tmp <- paste(path.tmp.out.act, "/", name, "_", cell.startend[1], "_", cell.startend[2], ".pro", sep="")
	file.optresult.tmp <- paste(path.tmp.out.act, "/", name, ".pro", sep="")
	
	# path for rescue files in case of optimization
	lpjfiles$path.rescue <- gsub(".pro", "_rescue", file.optresult, fixed=TRUE)
	dir.create(lpjfiles$path.rescue)
	
	# copy input files to temporary directory
	if (copy.input) {
		files <- as.character(unlist(lpjfiles$input$file))
		files.tmp <- llply(strsplit(files, "/"), function(x) paste(path.tmp.out.act, x[length(x)], sep="/") )
		bool <- file.copy(files, unlist(files.tmp))
		
		# modify lpjfiles list 
		lpjfiles$input$file <- files.tmp
	}
	

	#---------------------------
	# spinup model and run prior
	#---------------------------
	
	# path for results of actual grid cell
	# path <- paste(path.tmp.out.act, "/", name, "_OPTFILE_", cell.startend[1], "_", cell.startend[2], sep="")
	path <- paste(path.tmp.out.act, "/", name, "_OPTFILE", sep="")
	path <- gsub("//", "/", path)
	dir.create(path)
	if (!file.exists(path)) stop(paste("OptimizeLPJgenoud: Cannot create and access temporary working directory ", path.tmp.out.act, ". Check permissions.", sep=""))

	# run spinup for new grid cells and return result of prior model
	message(paste("OptimizeLPJgenoud: Starting LPJ spinup.", Sys.time()))
	if (plot) pdf(gsub(".pro", "_prior.pdf", file.optresult, fixed=TRUE), width=9.75, height=10)
	result.prior.lpj <- RunLPJ(dpar=dlpjpar$prior, lpjpar=lpjpar, which.par.opt=1:npar, lpjfiles=lpjfiles, path=path, integrationdata=integrationdata, xy, name=name, lpjcmd=lpjcmd, newcell=TRUE, plot=plot, getresult=TRUE, warnings=warnings, clean=1, clean.path=TRUE, CostMDS=CostMDS)
	if (plot) dummy <- plot(result.prior.lpj, what="annual")	
	if (plot) dummy <- plot(result.prior.lpj, what="monthly")	
	if (plot) dummy <- plot(result.prior.lpj, what="grid")	
	if (plot) dev.off()
	cost.prior <- result.prior.lpj$cost
	
	# save outputs from prior model run
	setwd(lpjfiles$path.out)
	save(result.prior.lpj, file=gsub(".pro", "_prior.RData", file.optresult, fixed=TRUE))
	
	# number of observations 
	nobs.ds <- llply(integrationdata, function(ds) sum(!is.na(ds$data.val)))
	nobs.ds <- nobs.ds[unlist(llply(integrationdata, function(ds) ds$cost))]
	nobs <- sum(unlist(nobs.ds))

	# initialize empty result objects
	hessian <- matrix(NA, length(which.par.opt), length(which.par.opt))
	jacobian <- matrix(NA, 1, length(which.par.opt))
	
	if (!runonly) { # do optimization and uncertainty calculation only if runonly == FALSE
		
		#---------------------------------------------
		# prepare cluster nodes for parallel computing
		#---------------------------------------------
		
		# check if parallel computing should be done based on required nodes
		parallel <- TRUE
		if (nodes <= 1 | restart == 2) parallel <- FALSE
		
		# export all objects to cluster nodes
		if (parallel) {
			balance <- FALSE
			message(paste("OptimizeLPJgenoud: Start preparing cluster nodes for parallel computing.", Sys.time()))
			require(parallel)
			# require(doSnow)
			
			# check memory use
			setwd(lpjfiles$path.out)
			use.df <- CheckMemoryUsage()
			message(paste("  Actual memory usage per node:", signif(sum(use.df$GB), 4), "GB, see file 'memory_usage.txt' for details."))
			rm(use.df)
			
			# initialize cluster
			cluster <- makeCluster(nodes)
			
			# load packages on all nodes
			clusterEvalQ(cluster, {
				library(raster)
				library(ncdf)
				library(plyr)
				NULL
			})
			
			# export required objects to cluster nodes
			clusterExport(cluster, ls(envir=.GlobalEnv), envir=.GlobalEnv)
			clusterExport(cluster, ls(), envir=environment())

			message(paste("OptimizeLPJgenoud: Finished preparing cluster nodes for parallel computing.", Sys.time()))
			
		} else {
			cluster <- FALSE
			balance <- FALSE
		}

		
		#-----------------------------	
		# perform genetic optimization
		#-----------------------------	
	
		# start new genoud optimization or restart? Create starting values
		niter.todo <- wait.generations * pop.size # number of iterations to to
		nkeep <- niter.todo * 0.01 # keep best 10% of result files
		if (restart == 0) {
			share.type <- 0
			starting.values <- dlpjpar$prior[which.par.opt]	# prior as only starting value
			niter.init <- 0 # how many iterations are already done?
		} else if (restart == 1) {
			share.type <- 1
			setwd(lpjfiles$path.out)
			starting.values <- StartingValues(file.optresult, pop.size) # prior, best, other best
			niter.init <- starting.values$niter # how many iterations are already done?
			starting.values <- starting.values$start
		}
		
		
		# do genoud optimization - and try to automatically restart if an error occurs
		#-----------------------------------------------------------------------------
		
		if (restart < 2) { # only if restart is 0 or 1
			message(paste("OptimizeLPJgenoud: Start GENOUD optimization.", Sys.time()))
			
			# try to restart optimization in case of an error, 
			restart.optim <- TRUE
			file.pro <- file.optresult
			i <- 1
			while (restart.optim & i <= maxAutoRestart) {
				i <- i + 1
				
				
				# genetic optimization
				#---------------------
				
				opt.genetic <- try(genoud(fn=RunLPJ, nvars=length(which.par.opt), pop.size=pop.size, max.generations=max.generations, wait.generations=wait.generations, hard.generation.limit=TRUE, Domains=cbind(dlpjpar$lower[which.par.opt], dlpjpar$upper[which.par.opt]), boundary.enforcement=2, starting.values=starting.values, gradient.check=FALSE, BFGS=TRUE, BFGSburnin=BFGSburnin, optim.method="L-BFGS-B", hessian=FALSE, share.type=share.type, project.path=file.pro, control=list(reltol=1e-7, maxit=100), P9=0, cluster=cluster, lpjpar=lpjpar, which.par.opt=which.par.opt, lpjfiles=lpjfiles, path=path, integrationdata=integrationdata, xy=xy, name=name, lpjcmd=lpjcmd, newcell=FALSE, plot=FALSE, clean.path=TRUE, warnings=warnings, CostMDS=CostMDS, nkeep=nkeep))
				

				# combine all restart and pro files in one pro file
				#--------------------------------------------------
				
				# create restart file from rescue files
				Sys.sleep(5)
				restart.l <- CreateRestartFromRescue(as.character(lpjfiles$path.rescue), pop.size)
				system(paste("cp", restart.l$file, file.optresult)) 

				
				# automatically restart optimization if an error occured
				#-------------------------------------------------------
				
				if (class(opt.genetic) == "try-error") {
				
					# new pro file in case of restart
					file.pro <- gsub(".pro", paste0("_restart_", i-1, ".pro"), file.optresult, fixed=TRUE)
					system(paste("cp", restart.l$file, file.pro)) 
					
					# set new values for genoud for restart
					share.type <- 1
					niter.done <- restart.l$pop.total - niter.init # number of done iterations
					niter.miss <- niter.todo - niter.done # number of missing iterations
					niter.miss <- max(c(0, niter.miss))
					
					# finish optimization if enough iterations were done or above maxAutoRestart
					if (i > (maxAutoRestart + 1) | niter.miss == 0) {
						message(paste("OptimizeLPJgenoud: Error occured during GENOUD optimization. Start post-processing.", Sys.time()))
						restart <- 2
						restart.optim <- FALSE

					} else {
					# else restart optimization
						dBFGSburnin <- BFGSburnin - max.generations 
						max.generations <- ceiling(niter.miss / pop.size) # new number of max generations
						max.generations <- max(c(2, max.generations))
						wait.generations <- max.generations - 1
						BFGSburnin <- max.generations + dBFGSburnin
						BFGSburnin[BFGSburnin < 1] <- 1
						
						# get starting values (prior, best from previous optimization, median from previous optimization)
						setwd(lpjfiles$path.out)
						starting.values <- StartingValues(file.optresult, pop.size)$start
						
						message(paste(
							"-----------------------------------------------------------------------",
							"OptimizeLPJgenoud: Error occured. Restart the optimization :",
							paste("  number of done iterations    :", niter.done), 
							paste("  number of missing iterations :", niter.miss), 
							"  Settings for restart :",
							paste("  pop.size            :", pop.size), 
							paste("  max.generations     :", max.generations), 
							paste("  wait.generations    :", wait.generations),
							paste("  BFGSburnin          :", BFGSburnin), 
							paste("  new population file :", file.pro),
							Sys.time(),
							"-----------------------------------------------------------------------",
							"\n",
							sep="\n"))
					} # end if else
					
				} else { # in case of no try-error, save optimization result				
					restart.optim <- FALSE
					save(opt.genetic, file=gsub(".pro", "_opt.genetic.RData", file.optresult, fixed=TRUE))
					message(paste("OptimizeLPJgenoud: GENOUD optimization finished.", Sys.time()))
					
				} # end if else try-error
			} # end while over restart
		} # end restart

		
		# stop cluster
		#-------------
		
		if (parallel) {
			stopCluster(cluster)
			message(paste("OptimizeLPJgenoud: Cluster nodes were stopped after all optimizations.", Sys.time()))
		}


		#---------------------------------------------
		# post-processing: start analysis
		#---------------------------------------------
		
		message(paste("OptimizeLPJgenoud: Start analysis of optimization results.", Sys.time()))
		
		
		# read results from all iterations of optimization
		#-------------------------------------------------
		
		setwd(lpjfiles$path.rescue)
		files <- c(list.files(pattern="rescue.RData", recursive=TRUE), list.files(pattern="rescue0.RData", recursive=TRUE))
		rescue.l <- CombineRescueFiles(files, remove=FALSE)	


		# plot cost per data stream ~ indviduals
		#---------------------------------------
			
		pdf(gsub(".pro", "_cost-vs-individuals.pdf", file.optresult, fixed=TRUE), width=8, height=5.5)
		DefaultParL()
		plot(rescue.l, ylim=NULL, only.cost=TRUE)
		plot(rescue.l, ylim=c(0, 10), only.cost=TRUE)
		dev.off()


		# plot barplot of cost
		#---------------------
			
		pdf(gsub(".pro", "_cost-per-datastream.pdf", file.optresult, fixed=TRUE), width=6, height=6)
		BarplotCost(rescue.l, 1)
		BarplotCost(rescue.l, 2)
		dev.off()		
		
		
		# plot PCA of parameters
		#-----------------------
		
		pdf(gsub(".pro", "_parameter-PCA.pdf", file.optresult, fixed=TRUE), width=9, height=7)
		PlotParPCA(rescue.l)
		dev.off()

		
		# prepare opt.genetic object in case of restart
		#----------------------------------------------
		
		optim.df <- Rescue2Df(rescue.l, lpjpar)
		rm(rescue.l)
		
		if (restart == 2) {
			opt.genetic <- Df2optim(optim.df, pop.size) 
			save(opt.genetic, file=gsub(".pro", "_opt.genetic.RData", file.optresult, fixed=TRUE))
		} # end restart

		
		# extract best parameters and parameter uncertainties
		#----------------------------------------------------
		
		lpjpar <- Rescue2LPJpar(optim.df, lpjpar)
		dlpjpar$best <- lpjpar$best / lpjpar$prior
		dlpjpar$best.median <- lpjpar$best.median / lpjpar$prior

		dlpjpar <- CheckLPJpar(dlpjpar, correct=TRUE)
		lpjpar <- CheckLPJpar(lpjpar, correct=TRUE)
		
		
		#--------------------------------------------------------------------
		# compute Jacbian, Hessian and parameter uncertainty based on Hessian 
		#--------------------------------------------------------------------
		
		# calculate Jacobian and Hessian?
		costmin <- opt.genetic$value
		if (calc.jacob) {
			# compute Jacobian at optimized parameters 
			if (restart.jacob | restart == 0 | !file.exists(gsub(".pro", "_jacobian.RData", file.optresult, fixed=TRUE))) {
				message(paste("OptimizeLPJgenoud: Compute Jacobian.", Sys.time()))
				jacobian <- jacobian(RunLPJ, opt.genetic$par, 
					# further parameters for RunLPJ ...
					lpjpar, which.par.opt=which.par.opt, lpjfiles=lpjfiles, path=path, integrationdata=integrationdata, xy=xy, name=name, lpjcmd=lpjcmd, newcell=FALSE, plot=FALSE, getresult=FALSE, clean=1, clean.path=TRUE, CostMDS=CostMDS, nkeep=nkeep, warnings=warnings)
				save(jacobian, file=gsub(".pro", "_jacobian.RData", file.optresult, fixed=TRUE))
			} else {
				load(gsub(".pro", "_jacobian.RData", file.optresult, fixed=TRUE))
			}
			
			if (restart.jacob | restart == 0 | !file.exists(gsub(".pro", "_hessian.RData", file.optresult, fixed=TRUE))) {
				message(paste("OptimizeLPJgenoud: Compute Hessian.", Sys.time()))
				opt.bfgs <- optim(opt.genetic$par, RunLPJ, method="BFGS", hessian=TRUE,
					# further parameters for RunLPJ ...
					lpjpar, which.par.opt=which.par.opt, lpjfiles=lpjfiles, path=path, integrationdata=integrationdata, xy=xy, name=name, lpjcmd=lpjcmd, newcell=FALSE, plot=FALSE, getresult=FALSE, clean=1, clean.path=TRUE, CostMDS=CostMDS, nkeep=nkeep, warnings=warnings)
				hessian <- opt.bfgs$hessian
				costmin <- opt.bfgs$value
				save(hessian, opt.bfgs, costmin, file=gsub(".pro", "_hessian.RData", file.optresult, fixed=TRUE))
				
				# select best parameters: best from BFGS optimization
				dlpjpar$best <- rep(NA, npar)
				dlpjpar$best[which.par.opt] <- opt.bfgs$par
				lpjpar$best <- dlpjpar$best * lpjpar$prior
				names(lpjpar$best) <- lpjpar$names
			} else {
				load(gsub(".pro", "_hessian.RData", file.optresult, fixed=TRUE))
			}			
		} 

		# paramter uncertainty from Hessian
		lpjpar$uncertainty.hessian <- rep(NA, npar)
		keep <- diag(hessian) != 0
		
		# compute covariance matrix from Hessian
		cov.m <- VarCovMatrix(hessian, par.optim)
		
		# compute alternative covariance matrix
		rem.ll <- match(c("cost", "ll", "aic", "daic"), colnames(optim.df))
		if (all(is.na(cov.m))) {
			message(paste("OptimizeLPJgenoud: WARNING! Covariance matrix, uncertainty.hessian and parameter correlation are computed from sampled parameters because Hessian was not or not correctly estimated.", Sys.time()))
			best <- (1:nrow(optim.df))[optim.df$daic <= 2]	
			if (all(is.na(best))) best <- (1:nrow(optim.df))[optim.df$cost <= quantile(optim.df$cost, 0.05)]	
			optim.best.df <- optim.df[best, ]
			w <- 1 - (optim.best.df$cost - min(optim.best.df$cost)) / (max(optim.best.df$cost) - min(optim.best.df$cost))
			m <- optim.best.df[, -rem.ll]
			cov.m <- try(cov.wt(m, w)$cov, silent=TRUE)
			if (class(cov.m) == "try-error") cov.m <- matrix(NA, ncol=ncol(hessian), nrow=ncol(hessian)) 
		}
		
		# compute standard errors
		if (all(is.na(cov.m))) {
			se <- rep(-98, npar) # flag indicates cannot compute standard error because of numerical reasons
			cor.m <- matrix(NA, npar, npar)
		} else {
			se <- StandardError(as.matrix(cov.m), nobs, costmin) * lpjpar$prior[which.par.opt]
			cor.m <- cov2cor(as.matrix(cov.m))	
		}
		lpjpar$uncertainty.hessian[match(names(se), lpjpar$names)] <- se
		lpjpar$uncertainty.hessian[which.par.opt[!keep]] <- -99 # flag indicates parameter has no gradient
		names(lpjpar$uncertainty.hessian) <- lpjpar$names


		#--------------------------------------------------------------------
		# plot parameter distributions, evolution, sensitiviy and correlation
		#--------------------------------------------------------------------
		
		message(paste("OptimizeLPJgenoud: Plot parameters.", Sys.time()))
		
		# write parameter files with prior and posterior parameters
		setwd(path.optresult)
		WriteLPJpar(lpjpar, file=gsub(".pro", "", file.optresult, fixed=TRUE), pft.par=lpjfiles$pft.par, param.par=lpjfiles$param.par)	
		
		if (plot) {
			# plot parameter distributions, evolution, sensitiviy
			pdf(gsub(".pro", "_parameter-dist-unc.pdf", file.optresult, fixed=TRUE), width=9, height=7)
			PlotPar(optim.df, lpjpar)
			dev.off()
			
			# plot parameter correlation
			if (any(!is.na(cor.m))) {
				pdf(gsub(".pro", "_parameter-cor.pdf", file.optresult, fixed=TRUE), width=15, height=15)
				CorrelationMatrixS(cor.m)
				dev.off()
			}
		}

		
		#-------------------------------------------------------	
		# run and plot posterior model with optimized parameters
		#-------------------------------------------------------
		
		message(paste("OptimizeLPJgenoud: Run LPJ with optimized parameters and remove temporary files.", Sys.time()))
		
		# calculate posterior model with best parameter set
		if (plot) pdf(gsub(".pro", "_posterior-best.pdf", file.optresult, fixed=TRUE), width=9.75, height=10)
		result.post.lpj <- RunLPJ(dlpjpar$best, lpjpar=lpjpar, which.par.opt=1:npar, lpjfiles=lpjfiles, path=path, integrationdata=integrationdata, xy, name=name, lpjcmd=lpjcmd, newcell=new.spinup4post, plot=plot, getresult=TRUE, clean=1, clean.path=TRUE, warnings=warnings, CostMDS=CostMDS)
		if (plot) dummy <- plot(result.post.lpj, what="annual")	
		if (plot) dummy <- plot(result.post.lpj, what="monthly")	
		if (plot) dummy <- plot(result.post.lpj, what="grid")	
		if (plot) dev.off()
		cost.post.best <- result.post.lpj$cost
		setwd(lpjfiles$path.out)
		save(result.post.lpj, file=gsub(".pro", "_posterior-best.RData", file.optresult, fixed=TRUE))


		# calculate posterior model with median best parameter set
		if (plot) pdf(gsub(".pro", "_posterior-median.pdf", file.optresult, fixed=TRUE), width=9.75, height=10)
		result.post.lpj <- RunLPJ(dlpjpar$best.median, lpjpar=lpjpar, which.par.opt=1:npar, lpjfiles=lpjfiles, path=path, integrationdata=integrationdata, xy, name=name, lpjcmd=lpjcmd, newcell=new.spinup4post, plot=plot, getresult=TRUE, clean=1, clean.path=TRUE, warnings=warnings, CostMDS=CostMDS)
		if (plot) dummy <- plot(result.post.lpj, what="annual")	
		if (plot) dummy <- plot(result.post.lpj, what="monthly")	
		if (plot) dummy <- plot(result.post.lpj, what="grid")	
		if (plot) dev.off()
		cost.post.med <- result.post.lpj$cost
		setwd(lpjfiles$path.out)
		save(result.post.lpj, file=gsub(".pro", "_posterior-median.RData", file.optresult, fixed=TRUE))
		
		
	} else { # if else runonly	
	
		#------------------------------------------------------------
		# create default/empty result objects in case runonly == TRUE
		#------------------------------------------------------------
			
		result.post.lpj <- result.prior.lpj
		max.generations <- pop.size <- wait.generations <- BFGSburnin <- NA
		cost.post.med <- cost.post.best <- cost.prior 
		lpjpar$dummy <- rep(NA, npar)
		names(lpjpar$dummy) <- lpjpar$names
		lpjpar$best <- lpjpar$best.median <- lpjpar$uncertainty.hessian <- lpjpar$uncertainty.iqr <- lpjpar$uncertainty.iqr95 <- lpjpar$uncertainty.005.min <- lpjpar$uncertainty.005.max <- lpjpar$dummy
		cor.m <- cov.m <- matrix(NA, npar, npar)
	} # end if else runonly
		
	# delete temporary folder
	system(paste("rm -rf", path.tmp.out.act))
	
	
	#--------------------------------------------------
	# plot cost surface between each pair of parameters
	#--------------------------------------------------
	
	if (plot & !runonly) {
		require(fields)
		pdf(gsub(".pro", "_cost-surface.pdf", file.optresult, fixed=TRUE), width=6.5, height=6.5)
		comb <- combn(as.character(lpjpar$names[which.par.opt]), 2)
		for (i in 1:ncol(comb)) {
			par.a <- comb[1, i]
			par.b <- comb[2, i]
			post <- unlist(c(lpjpar$best[grep(par.a, lpjpar$names)[1]], lpjpar$best[grep(par.b, lpjpar$names)[1]]))
			prior <- c(lpjpar$prior[grep(par.a, lpjpar$names)[1]], lpjpar$prior[grep(par.b, lpjpar$names)[1]])
			x <- unlist(optim.df[ , grep(par.a, colnames(optim.df))[1]])
			y <- unlist(optim.df[ , grep(par.b, colnames(optim.df))[1]])
			
			if (!AllEqual(x) & !AllEqual(y)) {
				# convert parameter combinations to raster
				combn.par <- data.frame(x=x, y=y)
				sp <- SpatialPointsDataFrame(combn.par, data.frame(cost=optim.df$cost))
				ext <- extent(lpjpar$lower[grep(par.a, lpjpar$names)], lpjpar$upper[grep(par.a, lpjpar$names)], lpjpar$lower[grep(par.b, lpjpar$names)], lpjpar$upper[grep(par.b, lpjpar$names)])
				r <- raster(ext, ncols=25, nrows=25)
				r <- rasterize(sp, r, "cost", fun=quantile, prob=0.01, na.rm=TRUE)
				
				# plot cost ~ parameter
				brks.q <- c(0, 0.01, 0.05, seq(0.1, 1, 0.1))
				brks <- quantile(c(0, values(r)), brks.q, na.rm=TRUE)
				.fun <- colorRampPalette(rev(brewer.pal(11, "RdYlBu")))
				cols <- .fun(length(brks)-1)
				DefaultParL(mar=c(3.7, 3.5, 2.5, 6))
				image(r, xlab=par.a, ylab=par.b, main=paste("Cost", par.a, "vs.", par.b), breaks=brks, col=cols)
				points(combn.par[optim.df$cost < quantile(optim.df$cost, 0.05), ], pch=16, cex=0.5) # parameter with 95% confidence
				arrows(prior[1], prior[2], post[1], post[2], length=0.1, lwd=2, col="yellow") # change from prior -> posterior
				box()
				lab.breaks <- c("", paste0("Q", brks.q[-1]))
				image.plot(r, zlim=range(brks.q, na.rm=TRUE), legend.only=TRUE, breaks=brks.q, col=cols, legend.shrink=0.9, lab.breaks=lab.breaks, legend.width=1.2)	
			}
		}
		dev.off()
	}
	
	
	#--------------------------------
	# prepare, save and return result
	#--------------------------------
	
	# list with all results
	results.l <- list(
		# coordinates and result file
		xy = xy,
		file.opt = file.optresult,
		file.optsetup = file.optsetup,
		
		# optimization information
		max.generations = max.generations,
		pop.size = pop.size,
		wait.generations = wait.generations,
		BFGSburnin = BFGSburnin,	
		
		# cost
		cost.prior = cost.prior,
		cost.post.best = cost.post.best,
		cost.post.med = cost.post.med,

		# return parameters
		lpjpar = lpjpar,
		
		# Hessian and Jacobian
		hessian = hessian,
		jacobian = jacobian,		
		
		# correlation matrix
		cor.m = cor.m, 
		
		# covariance matrix
		cov.m <- cov.m
	)
	save(results.l, file=gsub(".pro", "_results.RData", file.optresult, fixed=TRUE))
	
	message(paste(
		" ",
		"------------------------------------------------------------------",
		"-- OptimizeLPJgenoud successfully finished. ----------------------",
		paste("-- finished at ", Sys.time()),
		"-- Files with optimization results:",
		paste("path                 :", path.optresult),
		paste("opt. setup file      :", file.optsetup), 
		paste("all results          :", gsub(".pro", "_results.RData", file.optresult, fixed=TRUE)), 
		paste("prior PFT param.     :", paste0(gsub(".pro", "", file.optresult, fixed=TRUE), "_prior_pft.par")), 
		paste("prior global param.  :", paste0(gsub(".pro", "", file.optresult, fixed=TRUE), "_prior_param.par")), 		
		paste("results of prior run :", gsub(".pro", "_prior.RData", file.optresult, fixed=TRUE)), 			
		paste("population file      :", file.optresult)[!runonly], 
		paste("best PFT param.      :", paste0(gsub(".pro", "", file.optresult, fixed=TRUE), "_best_pft.par"))[!runonly], 
		paste("best global param.   :", paste0(gsub(".pro", "", file.optresult, fixed=TRUE), "_best_param.par"))[!runonly], 	
		paste("results of best run  :", gsub(".pro", "_posterior-best.RData", file.optresult, fixed=TRUE))[!runonly],
		paste("Jacobian matrix      :", gsub(".pro", "_jacobian.RData", file.optresult, fixed=TRUE))[!runonly & calc.jacob], 
		paste("Hessian matrix       :", gsub(".pro", "_hessian.RData", file.optresult, fixed=TRUE))[!runonly & calc.jacob], 
		"------------------------------------------------------------------",
		"\n",
		sep="\n"))	

	return(paste("Results in list 'result.l' in", gsub(".pro", "_results.RData", file.optresult, fixed=TRUE)))
})

