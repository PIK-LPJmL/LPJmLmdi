Rescue2LPJpar <- structure(function(
	##title<< 
	## Add information from a 'rescue' list to an 'LPJpar' object
	##description<<
	## The function takes an object of class 'rescue' (see \code{\link{CombineRescueFiles}}) (alternatively a 'data.frame' as created with \code{\link{Rescue2Df}}) and a 'LPJpar' (see \code{\link{LPJpar}}) object. Then it extracts the best parameter set, the median of the best parameter sets (defined based on dAIC <= 2), and various uncertainty measures and adds them to the 'LPJpar' object.
	
	rescue.l,
	### a list of class "rescue" (\code{\link{CombineRescueFiles}}) or alternatively a data.frame as created with \code{\link{Rescue2Df}}.
	
	lpjpar,
	### a list of class "LPJpar" (\code{\link{LPJpar}})
		
	...
	### further arguments (currently not used)

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{CombineRescueFiles}}
) { 
	if (class(rescue.l) == "rescue") {
		par.optim <- names(rescue.l[[1]]$dpar)
		optim.df <- Rescue2Df(rescue.l, lpjpar)
	} else if (class(rescue.l) == "data.frame") {
		optim.df <- rescue.l
	} else {
		stop("rescue.l should be of class 'rescue' or a 'data.frame'")
	}
	rem.ll <- match(c("cost", "ll", "aic", "daic"), colnames(optim.df))
	par.optim <- colnames(optim.df)[-rem.ll]
	
	# select best models according to maximum AIC difference of 2 (Bunham & Anderson 70)
	if (all(is.na(optim.df$daic))) {
		best <- (1:nrow(optim.df))[optim.df$cost <= quantile(optim.df$cost, 0.05, na.rm=TRUE)]
	} else {
		best <- (1:nrow(optim.df))[optim.df$daic <= 2]
	}
	optim.best.df <- optim.df[best, ]

	# select best parameters: best from optimization
	which.par.opt <- match(par.optim, lpjpar$names)	
	lpjpar$best <- lpjpar$prior
	lpjpar$best[which.par.opt] <- unlist(optim.df[which.min(optim.df$cost), -rem.ll])
	names(lpjpar$best) <- as.character(lpjpar$names)

	# select best parameters: median from best genes
	lpjpar$best.median <- lpjpar$prior
	lpjpar$best.median[which.par.opt] <- apply(optim.best.df, 2, median, na.rm=TRUE)[-rem.ll]
	names(lpjpar$best.median) <- lpjpar$names
	
	# uncertainty as inter-quartile range from best individuals
	lpjpar$uncertainty.iqr <- rep(NA, length(lpjpar$prior))
	lpjpar$uncertainty.iqr[which.par.opt] <- apply(optim.best.df, 2, IQR, na.rm=TRUE)[-rem.ll]
	names(lpjpar$uncertainty.iqr) <- lpjpar$names

	# uncertainty as inter-quantile range 0.025-0.975 (central 95 %) from best individuals
	lpjpar$uncertainty.iqr95 <- rep(NA, length(lpjpar$prior))
	lpjpar$uncertainty.iqr95[which.par.opt] <- apply(optim.best.df, 2, FUN=function(x) { diff(quantile(x, c(0.025, 0.975), na.rm=TRUE)) })[-rem.ll]
	names(lpjpar$uncertainty.iqr95) <- lpjpar$names
		
	# uncertainty as range of parameters with cost < quantile 0.05
	cost.trs <- quantile(optim.df$cost, 0.05)
	optim.q005.df <- subset(optim.df, cost <= cost.trs)
	lpjpar$uncertainty.005.min <- lpjpar$uncertainty.005.max <- rep(NA, length(lpjpar$prior))
	lpjpar$uncertainty.005.min[which.par.opt] <- apply(optim.q005.df[,-rem.ll], 2, FUN=min, na.rm=TRUE)
	lpjpar$uncertainty.005.max[which.par.opt] <- apply(optim.q005.df[,-rem.ll], 2, FUN=max, na.rm=TRUE)
		
	return(lpjpar)
	### The function returns the provided 'LPJpar' object with the following additional slots:
	### \itemize{ 
	### \item{ \code{best} Best parameter set }
	### \item{ \code{best.median} median of best parameter sets (based on all parameter sets with dAIC <= 2) }
	### \item{ \code{uncertainty.iqr} uncertainty of parameters as the inter-quartile range of the best parameter sets }
	### \item{ \code{uncertainty.iqr95} uncertainty of parameters as the central 95% inter-quantile range (0.975-0.025) of the best parameter sets }
	### \item{ \code{uncertainty.005.min} lower parameter uncertainty estimate based on the minimum parameter value from all parameter sets for which the cost <= quantile(cost, 0.05) }
	### \item{ \code{uncertainty.005.max} upper parameter uncertainty estimate based on the maximum parameter value from all parameter sets for which the cost <= quantile(cost, 0.05) }
	### }	
}, ex=function() {
	# files <- c(list.files(pattern="rescue.RData", recursive=TRUE), list.files(pattern="rescue0.RData", recursive=TRUE))
	# rescue.l <- CombineRescueFiles(files, remove=FALSE)
	# lpjpar2 <- Rescue2LPJpar(rescue.l, lpjpar)
	# str(lpjpar2)
	# plot(lpjpar2, "ALPHAA", "uncertainty.iqr95")
	# plot(lpjpar2, "TMIN_BASE", "uncertainty.iqr95")
})





