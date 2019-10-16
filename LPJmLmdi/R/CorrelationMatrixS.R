CorrelationMatrixS <- structure(function(
	##title<< 
	## plot a correlation matrix
	##description<<
	##  
	
	data,
	### a correlation matrix or a data.frame (
	
	method = "spearman",
	### method to compute the correlation
	
	iscor=NULL, 
	### Is 'data' a correlation matrix?
	
	main="",
	### main title for the plot
	
	...
	### further arguments for \code{\link{plot}}

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{CombineRescueFiles}}
) { 
	require(fields)
	if (is.null(iscor)) {
		iscor <- FALSE
		if (colnames(data) == rownames(data)) {
			iscor <- TRUE
		} 
	}
	if (!iscor) { 
		m <- as.matrix(data)
		m <- apply(m, 2, as.numeric)
		r <- cor(m, method=method, use="pairwise.complete.obs")
	} else {
		r <- data
	}
	r2 <- r
	for (i in 1:nrow(r2)) r2[i, i] <- NA
	brks <- pretty(r2, 8)
	brks <- pretty(seq(max(abs(brks))*-1, max(abs(brks)), length=10), 8)
	.fun <- colorRampPalette(rev(brewer.pal(11, "RdBu")))
	cols <- .fun(length(brks)-1)
								
	p <- par()
	DefaultParL()
	par(las=2, oma=c(5,5,1,1), mar=c(5, 5, 1, 1), fig=c(0, 0.85, 0, 1), new=FALSE)
	image(r, col=cols, breaks=brks, axes=FALSE, main=main)
	abline(0,1)
	x <- seq(0, 1, length=nrow(r))
	axis(1, at=x, rownames(r))
	axis(2, at=x, rownames(r))
	if (ncol(r) <= 10) {
		xy <- expand.grid(x, x)
		r[is.nan(r)] <- NA
		text(xy[,1], xy[,2], signif(r, 2)) 
	}
	box()
	par(fig=c(0.85, 1, 0, 1), mar=c(0.5, 0.5, 0.5, 3), new=TRUE)
	plot.new()
	image.plot(legend.only=TRUE, col=cols, breaks=brks, zlim=c(-1,1), lab.breaks=brks, smallplot=c(0, 0.3, 0.15, 0.9))
	par(p)
	return(r)
})