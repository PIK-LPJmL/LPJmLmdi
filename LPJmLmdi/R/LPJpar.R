LPJpar <- structure(function(
	##title<< 
	## Create an object of class 'LPJpar'
	##description<<
	## The function creates a data.frame of class 'LPJpar' that defines the parameters for LPJ runs.
	
	par.prior,
	### parameter vector (prior)
	
	par.lower,
	### lower boundaries for parameters
	
	par.upper,
	### upper boundaries for parameters
	
	par.pftspecif,		
	### Which parameter is PFT specific (TRUE) or global (FALSE)?
	
	par.names,
	### parameter name
	
	is.int = rep(FALSE, length(par.prior)),
	### is parameter a integer?
	
	...
	### further arguments for CheckLPJpar
		
	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{CheckLPJpar}}	
) {

	names(par.prior) <- par.names
	names(par.lower) <- par.names
	names(par.upper) <- par.names
	names(par.pftspecif) <- par.names
	lpjpar <- data.frame(names=par.names, prior=par.prior, lower=par.lower, upper=par.upper, pftspecif=par.pftspecif, is.int=is.int)
	class(lpjpar) <- "LPJpar"
	lpjpar <- CheckLPJpar(lpjpar, ...)
	return(lpjpar)
	### The function returns a list of class 'LPJpar'
})