PlotParPCA <- structure(function(
	##title<< 
	## plot a PCA of optimized parameters
	##description<<
	## The function takes an object of class 'rescue' (see \code{\link{CombineRescueFiles}}), computes a PCA (principle component analysis) based on the model parameter sets and cost function values of the optimization, and plots PCA results as biplots. 
	
	rescue.l,
	### a list of class "rescue", see \code{\link{CombineRescueFiles}}
		
	...
	### further arguments for \code{\link{plot}}

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{CombineRescueFiles}}, \code{\link{princomp}}
) {  
	op <- par()
	
	r <- laply(rescue.l, function(l) length(l$dpar))
	rescue.l <- rescue.l[r == modal(r)]
	
	# convert optimization results to data.frame
	optim.df <- ldply(rescue.l, function(l) {
		df <- data.frame(matrix(c(l$cost$total, as.vector(l$dpar)), nrow=1)) # , as.vector(l$cost$per.ds)[l$cost$use]
		colnames(df) <- c("cost", names(l$dpar)) #, paste0("cost.", names(l$cost$per.ds)[l$cost$use]))
		return(df)
	})
	if (nrow(optim.df) > 10000) {
		optim.df <- optim.df[order(optim.df$cost), ]
		optim.df <- optim.df[1:10000, ]
	}

	# do PCA
	pc <- princomp(optim.df[,-1], scale=TRUE)
	ld <- loadings(pc)

	# plot PCA
	DefaultParL(mfrow=c(2,3))
	explvar <- cumsum((pc$sdev^2) / sum(pc$sdev^2)) * 100
	barplot(explvar[1:min(c(length(explvar), 9))], ylab="Cumulative explained variance (%)", ylim=c(0, 100))
	box()
	biplot(pc, c(1,2), xlabs=rep(".", nrow(optim.df)))
	biplot(pc, c(1,3), xlabs=rep(".", nrow(optim.df)))
	biplot(pc, c(2,3), xlabs=rep(".", nrow(optim.df)))
	biplot(pc, c(1,4), xlabs=rep(".", nrow(optim.df)))
	biplot(pc, c(2,4), xlabs=rep(".", nrow(optim.df)))
	
	par(op)
	return(pc)
	### The function returns an object of class 'princomp'.
})
