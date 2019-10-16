EstOptimUse <- structure(function(
	##title<< 
	## Estimate optimal number of jobs given a number of cluster nodes

	nodes=16,
	### number of cluster nodes that you want to use
	
	wish=1000
	### approx. number of elements
	
	##details<<
	## No details.
	
	##references<< No reference.
	
	##seealso<<
	## \code{\link{WriteCLM}}
	
) {
	real <- as.integer(ceiling(wish / nodes))
	r <- real * nodes
	return(r)
	### an integer value
})