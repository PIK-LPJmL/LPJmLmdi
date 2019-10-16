Breaks <- structure(function(
	##title<< 
	## Class breaks for plotting
	##description<<
	## Calculates class breakpoints based on quantiles.
	
	x, 
	### numeric vector
	
	n=12, 
	### number of breaks
	
	quantile=c(0.01, 0.99), 
	### lower and upper quantiles that should be used to exclude outliers
	
	zero.min=FALSE,
	### should the minimum break be at 0?	
	
	...
	### Further arguments (unused)
	
	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{BreakColours}}
){
	x <- na.omit(as.vector(x))
	
	# are all values the same?
	equal <- FALSE
	if (length(unique(x)) == 1 | length(x) == 0) equal <- TRUE
	
	if (equal) {
	   brks <- c(NA, NA)
	} else {
	   ext <- quantile(x, prob=quantile, na.rm=TRUE)
	   x[x < ext[1]] <- ext[1]
	   x[x > ext[2]] <- ext[2]
	   if (any(ext < 0) & any(ext > 0) & (zero.min == FALSE)) {
		   ext <- max(abs(ext))
		   brks <- c(ext * -1, x, ext)
	   } else {
	      brks <- x
	   }
	   brks <- pretty(brks, n=n)
	}
	return(brks)
	### The function returns a vector of values.
}, ex=function() {

Breaks(rnorm(100, 50, 30))
Breaks(runif(100, 10, 30))
Breaks(rlnorm(100))

})



