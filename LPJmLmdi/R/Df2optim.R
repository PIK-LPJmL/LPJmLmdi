Df2optim <- structure(function(
	##title<< 
	## Convert a data.frame to a \code{\link{optim}} list 
	##description<<
	## The function takes a 'data.frame' as created by \code{\link{Rescue2DF}} and converts it to a list with the same structure like the results of the \code{\link{optim}} and \code{\link{genoud}} functions.
	
	optim.df,
	### a 'data.frame' as created by \code{\link{Rescue2DF}}
		
	pop.size=NA,
	### used population size. If NA, ngen (number of generations) and peak generation cannot be returned correctly. In this case both estimates will be 1.
		
	...
	### further arguments (currently not used)

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{CombineRescueFiles}}
) { 
	# get information about optimization
	best <- which.min(optim.df$cost)[1]
	rem.ll <- match(c("cost", "ll", "aic", "daic"), colnames(optim.df))
	npar.opt <- ncol(optim.df) - length(rem.ll)
	niter <- nrow(optim.df)
	if (is.na(pop.size)) {
		ngen <- 1
		pop.size <- niter
	} else {
		ngen <- floor(niter / pop.size)
	}
	par.best <- as.vector(unlist(optim.df[best, -rem.ll]))
	names(par.best) <- colnames(optim.df)[-rem.ll]
				
	# create opt.genetic object
	opt.genetic <- NULL
	opt.genetic$value <- optim.df$cost[best]
	opt.genetic$par <- par.best
	opt.genetic$gradients <- rep(NA, npar.opt)
	opt.genetic$generations <- ngen	
	opt.genetic$peakgeneration <- rep(1:ngen, each=pop.size)[best]
	opt.genetic$popsize <- pop.size
	opt.genetic$operators <- rep(NA, 9)
			
	### The function returns a list
	return(opt.genetic)
}, ex=function() {
	# files <- c(list.files(pattern="rescue.RData", recursive=TRUE), list.files(pattern="rescue0.RData", recursive=TRUE))
	# rescue.l <- CombineRescueFiles(files, remove=FALSE)
	# optim.df <- Rescue2Df(rescue.l)
	# opt <- Rescue2optim(rescue.l)
	# opt
})


