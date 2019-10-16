LPJparList <- structure(function(
	##title<< 
	## Create a list of 'LPJpar' objects
	##description<<
	## The function creates a list of \code{\link{LPJpar}} objects that can be used to compare parameters from different optimization experiments
	
	...
	### objects of class \code{\link{LPJpar}}
	
	##details<<
	## No details.
	
	##references<< No reference.
	
	##seealso<<
	## \code{\link{LPJpar}}
) {

	lpjpar <- list(...)
	class(lpjpar) <- "LPJparList"
	return(lpjpar)
	### The function returns a list of class 'LPJparList'
})


plot.LPJparList <- structure(function(
	##title<< 
	## Plots to compare LPJpar objects
	##description<<
	## The function takes a \code{\link{LPJparList}} object and creates a plot to compare optimized parameters
	
	x,
	### object of class 'LPJparList'
	
	par.name = NULL,
	### name(s) of the parameters that should be plotted
	
   ...
   ### further arguments to \code{\link{plot.LPJpar}}	
				
	##details<<
	## No details.
	
	##references<< No reference.
	
	##seealso<<
	## \code{\link{LPJpar}}, \code{\link{plot.LPJpar}}	
	
) {

	err <- "Select a valid parameter name."
	if (is.null(par.name)) {
		txt.l <- strsplit(as.character(x$names), "_")
		txt.l <- llply(txt.l, function(txt) paste(txt[-length(txt)], collapse="_"))
		par.name <- unique(unlist(txt.l))
		par.name <- par.name[par.name != ""]
	} else {
		if (any(is.na(par.name))) stop(err)
	}
	
	# check lower/upper parameter ranges
	

	# where to place the arrows and points relative to PFT?
	nexp <- length(x)
	xoff <- seq(-0.23, 0.23, length=nexp)
	
	# colors and names for the experiments
	cols <- brewer.pal(max(3, nexp), "Set1")
	
	exp.name <- unlist(llply(x, function(lpjpar) lpjpar$exp.name))
	if (is.null(exp.name)) exp.name <- paste("Exp", 1:nexp)
	
	# loop over parameter names 
	for (i in 1:length(par.name)) {
	   noplot <- all(is.na(x[[1]]$best.median[grep(par.name[i], x[[1]]$names)]))
	   if (!noplot) {
	      ylim <- range(unlist(llply(x, function(lpjpar) {
	         g <- grep(par.name[i], lpjpar$names)
	         c(lpjpar$lower[g], lpjpar$upper[g])
	      })), na.rm=TRUE)
			if (ylim[1] == ylim[2]) ylim[2] <- ylim[2] + 0.1
			ylim[1] <- ylim[1] - (ylim[2] - ylim[1]) * 0.01
			ylim[2] <- ylim[2] + (ylim[2] - ylim[1]) * 0.01
			if (nexp > 3) ylim[2] <- ylim[2] + (ylim[2] - ylim[1]) * 0.12
	   
		   plot(x[[1]], par.name[i], xoff=xoff[1], col=cols[1], ylim=ylim, ...)
		   if (nexp > 1) {
		      for (j in 2:length(x)) {
		         plot(x[[j]], par.name[i], add=TRUE, xoff=xoff[j], col=cols[j], ...)
		      }
		      ncol <- min(nexp, 2)
		      legend("top", exp.name, text.col=cols, bty="n", ncol=ncol)
		   }
		}
	} # end loop over par.name
})


