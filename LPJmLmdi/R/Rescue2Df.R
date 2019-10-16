Rescue2Df <- structure(function(
	##title<< 
	## Convert a 'rescue' list to a data.frame
	##description<<
	## The function takes an object of class 'rescue' (see \code{\link{CombineRescueFiles}}) and converts it to a data.frame including the total cost value (1st column), the parameter values (next columns), and the log-likelihood, Akaike's Information Criterion (AIC) and AIC differences (last columns). If 'lpjpar' it not specified the function returns just the scaled parameters (e.g. dpar = par / prior) otherwise it returns the parameters in the original units (e.g. par = dpar * prior).
	
	rescue.l,
	### a list of class "rescue", see \code{\link{CombineRescueFiles}}
	
	lpjpar=NULL,
	### a list of class "LPJpar" (see \code{\link{LPJpar}}) to convert the scaled parameters in rescue.l back to the original units (optional)
		
	...
	### further arguments (currently not used)

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{CombineRescueFiles}}
) { 

   # remove duplicated priors
	r <- laply(rescue.l, function(l) length(l$dpar))
	rescue.l <- rescue.l[r == modal(r)]

	# create data.frame
	cost <- unlist(llply(rescue.l, function(x) x$cost$total))
	dpar <- ldply(rescue.l, function(x) x$dpar)
	optim.df <- data.frame(cost, dpar)
	par.optim <- names(rescue.l[[1]]$dpar)
	colnames(optim.df) <- c("cost", par.optim)
	
	# scale parameters to original units
	if (!is.null(lpjpar)) {
		which.par.opt <- match(par.optim, lpjpar$names)
		scale.m <- matrix(c(1, lpjpar$prior[which.par.opt]), ncol=ncol(optim.df), nrow=nrow(optim.df), byrow=TRUE)
		optim.df <- optim.df * scale.m
	}
	
	# compute likelihood and AIC
	optim.df$ll <- exp(-optim.df$cost)	# likelihood
	optim.df$aic <- 2 * length(par.optim) - 2 * log(optim.df$ll)  # Akaike Information Criterion
	aic.min <- min(optim.df$aic)		                              # AIC of best model
	optim.df$daic <- optim.df$aic - aic.min		                      # AIC differences	
	return(optim.df)
	### The function returns a data.frame.
}, ex=function() {
	# files <- c(list.files(pattern="rescue.RData", recursive=TRUE), list.files(pattern="rescue0.RData", recursive=TRUE))
	# rescue.l <- CombineRescueFiles(files, remove=FALSE)
	# optim.df <- Rescue2Df(rescue.l)
	# summary(optim.df)
})


