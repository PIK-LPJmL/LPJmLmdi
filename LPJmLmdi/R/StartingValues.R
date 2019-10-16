StartingValues <- structure(function(
	##title<< 
	## Get starting values for genoud from *.pro file
	##description<<
	## The function extracts the best individuals trhat occured during a genoud optimization from a *.pro file. These best individuals can be used as starting values if a optimization is restarted. This function is called within \code{\link{OptimizeLPJgenoud}} is a restart is performed.
	
	file.optresult,
	### genoud *.pro file with optimization results
	
	pop.size=NULL,
	### population size

	...
	### further arguments (not used)
		
	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{OptimizeLPJgenoud}}	
) {	

	# read previous optimization results
	optim.df <- ReadPRO(file.optresult)
	niter <- nrow(optim.df)
	
	# pop.size
	if (is.null(pop.size)) {
		pop.size <- min(c(20, nrow(optim.df)))
	}		
	
	# best individual from previous optimization
	cost <- optim.df[,2]
	best <- which.min(cost)[1]
	dpar.best <- as.vector(unlist(optim.df[best, 3:ncol(optim.df)]))
	
	# sample from best individuals
	cost.trs <- quantile(cost, 0.1) # threshold of best
	optim.best.df <- optim.df[cost <= cost.trs, ]	
	size <- min(c(20, pop.size, nrow(optim.best.df)))
	dpar.other <- optim.best.df[sample(1:nrow(optim.best.df), size), 3:ncol(optim.best.df)]
	
	# median of best individuals
	dpar.med <- apply(optim.best.df[,3:ncol(optim.best.df)], 2, median)
			
	# parameter vectors to be introduced to genoud: best, some other best, median of best
	starting.values <- list(start=as.matrix(rbind(dpar.best, dpar.other, dpar.med)), niter=niter)
	return(starting.values)
})

