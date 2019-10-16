PrepareRestartFiles <- structure(function(
	##title<< 
	## Prepare restart files to restart OptimizeLPJgenoud
	##description<<
	## The function prepares all files that are needed to restart OptimizeLPJgenoud
	
	file.optsetup,
	### OptimizeLPJgenoud setup file, ends with "_optsetup.RData"
	
	...
	### further arguments (currently not used)
		
	##details<<
	## No details.
	
	##references<< No reference.

	##seealso<<
	## \code{\link{LPJfiles}}	
) {

	# create file names
	file.optresult <- gsub("_optsetup.RData", ".pro", file.optsetup)
	path.tmp <- unlist(strsplit(file.optresult, "/"))
	path.tmp <- paste(path.tmp[-length(path.tmp)], collapse="/")
	file.optresult <- gsub(path.tmp, "", file.optresult)
	file.optresult <- gsub("/", "", file.optresult)

	wd <- getwd()
	setwd(path.tmp)

	# check if opt.genetic initial file exists else create opt.genetic list and save file
	if (!file.exists(gsub(".pro", "_initial_opt.genetic.RData", file.optresult))) {
		# read population file
		optim.df <- read.table(gsub(".pro", "_initial.pro", file.optresult), comment.char='G') 
		pop.size <- max(optim.df[,1])
		best <- which.min(optim.df[,2])[1]
		npar <- length(3:ncol(optim.df))
		ngen <- nrow(optim.df) / pop.size
		
		# create opt.genetic object
		opt.genetic <- NULL
		opt.genetic$value <- as.vector(unlist(optim.df[best, 2]))
		opt.genetic$par <- as.vector(unlist(optim.df[best, 3:ncol(optim.df)]))
		opt.genetic$gradients <- rep(NA, npar)
		opt.genetic$generations <- ngen	
		opt.genetic$peakgeneration <- rep(1:ngen, each=pop.size)[best]
		opt.genetic$popsize <- pop.size
		opt.genetic$operators <- rep(NA, 9)
		
		save(opt.genetic, file=gsub(".pro", "_initial_opt.genetic.RData", file.optresult))
	}

	# check if opt.genetic file exists else create it
	if (!file.exists(gsub(".pro", "_opt.genetic.RData", file.optresult))) {
		file.copy(gsub(".pro", "_initial_opt.genetic.RData", file.optresult), gsub(".pro", "_opt.genetic.RData", file.optresult))
	}
})





		