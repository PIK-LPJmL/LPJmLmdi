RunLPJ <- structure(function(
	##title<< 
	## Run LPJmL from R and get results
	##description<<
	## This function calls LPJmL, reads the results of the model run, computes the cost based on the data sets in \code{\link{IntegrationData}} and the defined cost function (in CostMDS), and returns the simulation results. 
	
	dpar, 				
	### vector of scaling factors for each parameter in 'which.par.opt': parameter = dpar * prior (e.g. if dpar is 1, prior parameters are used in the model run). Optimization is performed on these scaling factors
	
	lpjpar,
	### data.frame of class \code{\link{LPJpar}} that define LPJ parameter values, ranges, and names
		
	which.par.opt,
	### integer vector that indicates which parameters in lpjpar should be optimized
	
	lpjfiles,
	### list of class \code{\link{LPJfiles}} that define all LPJ directories, input files, configuration template files
			
	path=NULL,			
	### path for output files of actual model run
	
	integrationdata,		
	### list of of class \code{\link{IntegrationData}} 
	
	xy,
	### matrix of grid cell coordinates to run LPJ
	
	newcell=FALSE,		
	### calculate new cell and new spinup?
	
	name="LPJmL", 		
	### name of the LPJ run, basic name for all outputs
	
	lpjcmd = "srun ./bin/lpjml",
	### How you usually run the LPJ model at the console: 'srun ./bin/lpjml' or './bin/lpjml'
	
	plot=FALSE,			
	### plot results? see \code{\link{plot.IntegrationData}}
	
	getresult=FALSE,	
	### If TRUE, all model results are returned in a LPJsim object and model results are saved. If FALSE, only the cost function value is returned.
	
	clean=1,
	### clean results and temporay configuration and parameter files? 0 = keep everthing; 1 = delete parameter files, conf files and outputs; 2 = clean additionally input files, soil code files and restart
	
	clean.path=FALSE,
	### Delete output directory 'path' in case it already exists before the model run?
	
	CostMDS = CostMDS.SSE,
	### cost function for multiple data streams
	
	nkeep = 400,
	### number of result files to keep. If more are existing, the ones with highest costs will be deleted
	
	warnings = TRUE
	### print all LPJmL warning messages during optimization?
) { 
	
	# get LPJ cell number from coordinates
	xy <- cbind(as.numeric(xy[,1]), as.numeric(xy[,2])) 
	grid.l <- GridProperties(lpjfiles)
	cell <- extract(grid.l$grid, xy) - 1
	ncell <- length(cell)
	cell.startend <- c(cell[1], cell[ncell])
	
		
	# check and scale parameters
	#---------------------------
		
	# scale parameters
	lpjpar$new <- lpjpar$prior
	lpjpar$new[which.par.opt] <- dpar * lpjpar$prior[which.par.opt]
	lpjpar$new[lpjpar$is.int] <- round(lpjpar$new[lpjpar$is.int], 0)
	names(lpjpar$new) <- lpjpar$names	
	
	# proposed parameters outside allowed range? - return high cost
	cost.l <- list(total=1e+20)
	out.of.range <- ((lpjpar$new < lpjpar$lower) | (lpjpar$new > lpjpar$upper))
	bool <- is.na(out.of.range)
	if (any(bool)) lpjpar$new[bool] <- lpjpar$prior[bool]
	out.of.range <- ((lpjpar$new < lpjpar$lower) | (lpjpar$new > lpjpar$upper))
	
	if (any(out.of.range)) {
		message(paste("Parameter out of range:", lpjpar$names[out.of.range], "new =", signif(lpjpar$new[out.of.range], 5), "lower =", lpjpar$lower[out.of.range], "upper =",  lpjpar$upper[out.of.range], "\n"))
	}
	
	# check parameters - avoid parameter with 0
	lpjpar <- CheckLPJpar(lpjpar, correct=TRUE)
	
	
	# prepare path and files
	#-----------------------
	
	# create main output directory for grid cell and output directory for actual run
	if (is.null(path)) {
		path <- paste(getwd(), "/", name, "_OPTFILE_", cell.startend[1], "_", cell.startend[2], sep="")
	} 
	path <- gsub("//", "/", path)
	if (file.exists(path) & newcell & clean.path) system(paste("rm -rf", path))
	if (!file.exists(path)) dir.create(path)
		
	# create name for files and folders
	idname <- unlist(strsplit(name, ""))
	if (length(idname) > 10) idname <- idname[1:10]
	idname <- paste(idname, collapse="")
	# id <- paste(idname, "_OPTFILE_", cell.startend[1], "_", cell.startend[2], sep="")
	id <- paste(idname, "_OPTFILE", sep="")
	tmp <- paste(gsub(":", "-", gsub(" ", "_", as.character(Sys.time()))), "_", sep="")
	tmp <- gsub("/", "", tempfile(tmp, tmpdir=""))
	outpath.cell <- paste(path, tmp, sep="/")
	outpath.cell <- gsub("//", "/", outpath.cell)
	dir.create(outpath.cell)
	
	# create temporary file names for actual run
	lpj.conf.file.cell <- paste(lpjfiles$path.lpj, "lpj_OPTFILE_", tmp, ".js", sep="")
	lpj.parconf.file.cell <- paste(lpjfiles$path.lpj, "param_OPTFILE_", tmp, ".js", sep="")
	lpj.par.pft.file.cell <- paste(lpjfiles$path.lpj, "par/pft_OPTFILE_", tmp, ".js", sep="")
	lpj.par.file.cell <- paste(lpjfiles$path.lpj, "par/param_OPTFILE_", tmp, ".js", sep="")
	
	# create file names for run of same grid cell
	restart.file.cell <- paste(path, "/restart_", id, ".bin", sep="")
	lpj.soilcode.file.cell <- paste(path, "/soil_OPTFILE.bin", sep="")
	lpj.input.file.cell <- paste(lpjfiles$path.lpj, "input_", id, ".conf", sep="")
	
	# set grid cell number in LPJ configuration file
	names(cell.startend) <- c("CELL_START", "CELL_END")
	setwd(lpjfiles$path.lpj)
	file.tmp <- paste(outpath.cell, "temp.js", sep="/")
	ChangeParamFile(cell.startend, lpjfiles$lpj.conf, file.tmp)	
	
	# set file names in conf file
	newfiles <- c(lpj.parconf.file.cell, outpath.cell, restart.file.cell, lpj.input.file.cell, lpjfiles$sim.start.year, lpjfiles$sim.end.year)
	names(newfiles) <- c("CELL_PARCONF_FILE", "CELL_OUTPATH", "CELL_RESTART_FILE", "CELL_INPUT_FILE", "YEAR_START", "YEAR_END")
	setwd(lpjfiles$path.lpj)
	ChangeParamFile(newfiles, file.tmp, lpj.conf.file.cell, wait=TRUE)
	file.remove(file.tmp)	
	
	# write new parameters to LPJ parameter file: PFT-specific parameters
	setwd(lpjfiles$path.lpj)
	ChangeParamFile(lpjpar$new[lpjpar$pftspecif], lpjfiles$pft.par, lpj.par.pft.file.cell)
		
	# write new parameters to LPJ parameter file: global parameters
	ChangeParamFile(lpjpar$new[!lpjpar$pftspecif], lpjfiles$param.par, lpj.par.file.cell)
		
	# set parameter file names in param.conf file
	newfiles <- c("PAR_PFT_FILE_CELL"=lpj.par.pft.file.cell, "PAR_FILE_CELL"=lpj.par.file.cell)
	ChangeParamFile(newfiles, lpjfiles$param.conf, lpj.parconf.file.cell)

	# in case of new grid cell: update LPJ conf file 
	if (newcell) {
	  # change soil code file: set cells that are not computed to 0
	  file.soilcode <- as.character(unlist(lpjfiles$input$file[grep("SOILCODE_FILE", lpjfiles$input$name)]))
	  file.grid <- as.character(unlist(lpjfiles$input$file[grep("GRID_FILE", lpjfiles$input$name)]))
	  #ChangeSoilCodeFile(file.soilcode=file.soilcode, file.soilcode.new=lpj.soilcode.file.cell, xy, newcode=0, file.grid=file.grid)
	  file.copy(file.soilcode, lpj.soilcode.file.cell)
	  
		# create input file
		setwd(lpjfiles$path.lpj)
		lpj.input.files.cell <- as.character(lpjfiles$input$file)
		names(lpj.input.files.cell) <- as.character(lpjfiles$input$name)
		ChangeParamFile(lpj.input.files.cell, lpjfiles$input.conf, lpj.input.file.cell)
	} 
	system("sync") # force file writing
	
	# check if all LPJ configuration and parameter files are exiting
	check <- FileExistsWait(c(lpj.input.file.cell, lpj.conf.file.cell, lpj.par.pft.file.cell, lpj.par.file.cell, lpj.parconf.file.cell, lpj.soilcode.file.cell), waitmin=0, waitmax=1)
	if (any(!check)) {
		message(paste("FILEWARNING: LPJ configuration files were not written for cell", cell.startend[1], "-", cell.startend[2]), "Return cost=NA")
		return(NA)
	}

	
	# make model runs
	#----------------
	
	if (!any(out.of.range)) {
	

		# spinup model run
		#-----------------
				
		lpjroot <- paste("export LPJROOT=", lpjfiles$path.lpj, sep="")
		system(lpjroot)
		
		check <- file.exists(restart.file.cell)
		if (newcell) {
			system("sync") 
			i <- 1
			while (any(!check) & i <= 2) {	# try to repeat spinup model run (maximum 2 times) if restart file was not written
				lpj1 <- paste("./bin/lpjcheck >", paste0(id, "_lpjcheck.txt"), "-param", lpj.conf.file.cell)
				lpj2 <- paste(lpjcmd, ">", paste0(id, "_lpjspinup.txt"), lpj.conf.file.cell)
				setwd(as.character(lpjfiles$path.lpj))
				system(lpj1, intern=!warnings, ignore.stdout=!warnings)		
				lpj.spinup <- system(lpj2, intern=!warnings, ignore.stdout=!warnings)				
				check <- FileExistsWait(restart.file.cell, waitmin=0, waitmax=2)
				i <- i + 1
			}
			if (any(!check)) {
				message(paste("FILEWARNING: LPJ restart file was not written after 2 spinup model runs for cell ", cell.startend[1], "-", cell.startend[2]), ". Return cost=NA", sep="")
				return(NA)
			}
		}
			
			
		# transient model run
		#--------------------
		
		check <- FALSE
		i <- 1
		while (any(!check) & i <= 2) {	# try to repeat transient model run (maximum 2 times) if output files were not written
			lpj <- paste(lpjcmd, ">", paste0(id, "_lpjrun.txt"), "-DFROM_RESTART", lpj.conf.file.cell)
			setwd(as.character(lpjfiles$path.lpj))
			lpj.trans <- system(lpj, intern=!warnings, ignore.stdout=!warnings)
      system("sync") 
			setwd(outpath.cell)
			files.out <- llply(integrationdata, function(ds) {
				if (!is.function(ds$model.val.file)) return(ds$model.val.file)
				return(NA)				
			})
			check <- FileExistsWait(c(na.omit(unlist(files.out)), "grid.bin"), waitmin=0, waitmax=2)
			i <- i + 1
		}
		
		
		# read model results, plot model vs. data and compute cost
		#---------------------------------------------------------	
		
		# return warnings or error message if LPJ output files don't exist 
		if (any(!check)) {
			# # remove results for actual run
			# setwd(as.character(lpjfiles$path.lpj))
			# file.remove(lpj.conf.file.cell, lpj.parconf.file.cell, lpj.par.pft.file.cell, lpj.par.file.cell)	
			# system(paste("rm -r", outpath.cell))
			
			# save parameters 
			setwd(as.character(lpjfiles$path.lpj))
			save(lpjpar, file=paste(id, "_lpjpar_with-error.RData", sep=""))
			message(paste("You might check this file: ", paste(id, "_lpjpar_with-error.RData", sep=""), sep=""))
		
			# return high cost in case files don't exist 
			if (!getresult) {
				message(paste("LPJ output files don't exists. Return cost =", unlist(cost.l$total), sep=""))
				return(unlist(cost.l$total))
			} else {
				stop("RunLPJ: LPJ output files don't exists.")
			}
		}
		
		# add model outputs to 'IntegrationData'
		setwd(outpath.cell)	
		integrationdata <- ReadLPJ2IntegrationData(integrationdata, xy, lpjfiles)	
	
		# calculate cost	
		cost.l <- CostMDS(integrationdata)	
		
		# plot comparison model-data
		if (plot) plot(integrationdata, CostMDS=CostMDS)
		
		# make list if model results should be returned
		if (getresult) {
			# save all outputs 
			path.save <- NULL
			if (!is.null(lpjfiles$path.rescue)) {
				setwd(outpath.cell)	
				files.out <- list.files()
				# path.save <- tempfile("output_", tmpdir=lpjfiles$path.rescue)
				path.save <- paste(lpjfiles$path.rescue, paste0("output_", round(cost.l$total, 12)), sep="/")
				dir.create(path.save)
				system(paste("cp", paste(files.out, collapse=" "), path.save))
			}
			
			# get model results for observation period
			setwd(outpath.cell)	
			years <- unique(unlist(llply(integrationdata, function(ds) format(ds$data.time, "%Y"))))
			
			start <- max(c(min(as.numeric(years)), lpjfiles$sim.start.year), na.rm=TRUE)
			end <- min(c(max(as.numeric(years)), lpjfiles$sim.end.year), na.rm=TRUE)
			result.lpj <- ReadLPJsim(start=start, end=end, sim.start.year=lpjfiles$sim.start.year)
			result.lpj$cost <- cost.l
			result.lpj$integrationdata <- integrationdata
			result.lpj$dpar <- dpar
			result.lpj$output <- path.save	

			setwd(path.save)
			save(result.lpj, file="result.lpj.RData")
		}		
		
		
		# save rescue and result files for cost and parameter values
	   #----------------------------------------------------------- 
	
	   path.rescue <- unlist(lpjfiles$path.rescue)
	   if (!is.null(path.rescue)) {
		   if (!file.exists(path.rescue)) dir.create(path.rescue)
		
		
		   # save and clean rescue files
		   #----------------------------
		
		   # save rescue file
		   setwd(path.rescue)
		   file.rescue <- paste(gsub(":", "-", gsub(" ", "_", as.character(Sys.time()))), "_", sep="")
		   file.rescue <- gsub("//", "/", tempfile(file.rescue, tmpdir=path.rescue, "_rescue0.RData"))
		   names(dpar) <-  as.character(lpjpar$names[which.par.opt])
		   rescue.l <- list(list(cost=cost.l, dpar=dpar))
		   save(rescue.l, file=file.rescue)
			
		   # combine rescue files if already many are exisiting and delete single files
		   files.rescue <- list.files(pattern="_rescue0.RData")
		   if (length(files.rescue) > 100) {
			   rescue.l <- CombineRescueFiles(files.rescue)
		   }
		
		
		   # save and clean result files
		   #----------------------------
		
		   # save result of iteration
		   setwd(path.rescue)
		   file.new <- paste0("cost_", round(cost.l$total, 12), "_result.RData") # new result file with cost in file name
		
		   files.result <- list.files(pattern="_result.RData") # existing result files
		   files.cost <- as.numeric(unlist(llply(strsplit(files.result, "_"), function(s) s[length(s)-1]))) # get cost
	      files.result <- files.result[order(files.cost)] # existing result files, sort from lowest to highest cost
		   files.cost <- files.cost[order(files.cost)]
		   nfiles <- length(files.result)
		   save.result <- TRUE
		
		   # check if result files should be cleaned-up
		   if (nfiles > nkeep) { # keep only N best
			   file.remove(files.result[(nkeep+1):nfiles])
			   if (cost.l$total > files.cost[1]) save.result <- FALSE # don't save if actual cost is larger than best
		   }
		
		   # save result
		   if (save.result) {
			   result.l <- list(cost=cost.l, dpar=dpar, integrationdata=integrationdata)
			   save(result.l, file=file.new)
		   }		
	   } # end if path.rescue

	} # end if out.of.range
	
	
	# clean temporary files and folders
	#----------------------------------

	# delete all files and results?
	if (clean == 1) {	# remove temporary files and folders for actual run
		setwd(as.character(lpjfiles$path.lpj))
		file.remove(lpj.conf.file.cell, lpj.parconf.file.cell, lpj.par.pft.file.cell, lpj.par.file.cell)	
		system(paste("rm -r", outpath.cell))
	}
	if (clean == 2) {	# remove everthing
		setwd(as.character(lpjfiles$path.lpj))
		file.remove(lpj.conf.file.cell, lpj.parconf.file.cell, lpj.par.pft.file.cell, restart.file.cell, lpj.input.file.cell,lpj.soilcode.file.cell)	
		system(paste("rm -r", path))
	}
	
	
	# return results or total cost
	#-----------------------------
	
	# return model results
	if (getresult) return(result.lpj)	
	
   # return total cost
	cost <- unlist(cost.l$total)
	return(cost)
})
