CreateRestartFromRescue <- structure(function(
	##title<< 
	## Create a *.pro file from binary rescue files to restart optimization
	##description<<
	## The function creates a *.pro file friom binary 'rescue' files. The *.pro file can be used to restart OptimizeLPJgenoud. 
	
	path.rescue,
	### directory where the resuce files from each iteration of the optimization are saved.
	
	pop.size
	### (estimated) population size of the genetic optimization
	
	##details<<
	## No details.
	
	##references<< No reference.

	##seealso<<
	## \code{\link{genoudLPJrescue}}	
) {

	
	# create matrix with cost and parameters from rescue files
	#----------------------------------------------------------
	
	file.rescue.pro <- paste(path.rescue, "/rescue.pro", sep="")
	has.restart.files <- FALSE
	ngenerations <- 1
	pop.total <- 0
	optim0.m <- NULL
	optim1.m <- NULL
	
	# load existing rescue file pro files
	setwd(path.rescue)
	files.pro <- list.files(pattern=".pro")
	if (length(files.pro) > 0) {
		has.restart.files <- TRUE
		optim0.m <- ReadPRO(files.pro)[, -1]
		colnames(optim0.m) <- paste("X", 1:ncol(optim0.m))
		file.remove(files.pro) # delete old rescue pro file
	} 
	
	# combine rescue RData files
	setwd(path.rescue)
	files.rescue <- c(list.files(pattern="_rescue0.RData"), list.files(pattern="rescue.RData"))
	if (length(files.rescue) > 0) {
		has.restart.files <- TRUE
		rescue.all.l <- CombineRescueFiles(files.rescue)	
		n <- laply(rescue.all.l, function(l) length(l$dpar))
		r <- n != modal(n)
		rescue.all.l <- rescue.all.l[!r]
		optim1.m <- laply(rescue.all.l, function(l) {
			cbind(matrix(l$cost$total, 1, 1), matrix(l$dpar, nrow=1, ncol=length(l$dpar)))
		})
		colnames(optim1.m) <- paste("X", 1:ncol(optim1.m))
	}


	# save restart *.pro file
	#--------------------------		
	
	if (has.restart.files) {
		if (is.null(optim0.m) & !is.null(optim1.m)) optim.m <- optim1.m
		if (!is.null(optim0.m) & is.null(optim1.m)) optim.m <- optim0.m
		if (!is.null(optim0.m) & !is.null(optim1.m)) optim.m <- rbind(optim0.m, optim1.m)
		optim.m <- optim.m[order(optim.m[,1], decreasing=TRUE), ]
		
		# check and remove for duplicates
		bool <- duplicated(paste(round(optim.m[,1], 6), round(optim.m[,2], 6)))
		optim.m <- optim.m[!bool, ]
		
		# save optim.m as new pro file
		pop.total <- nrow(optim.m)
		optim.m <- cbind(rep(1:pop.size, length=pop.total), optim.m)
		ngenerations <- floor(pop.total / pop.size)
		nvar <- ncol(optim.m) - 1
		
		# write pro file
		con <- file(file.rescue.pro, "w")
		writeLines(paste("Generation: 0 ", "\t", " Population Size: ", pop.size, " \t ", "Fit Values: 1 ", "\t", " Variables: ", nvar, sep=""), con)
		writeLines("", con)
		close(con)
		write.table(optim.m, file = file.rescue.pro, append = TRUE, sep=" \t ", row.names=FALSE, col.names=FALSE)
	}
	result <- list(file=file.rescue.pro, ngenerations=as.integer(ngenerations), pop.total=pop.total)
	return(result)
	
})
	
