CostMDS.KGEw <- structure(function(
	##title<< 
	## Cost function for multiple data streams based on a weighted Kling-Gupta efficiency
	##description<<
	## The function computes for each grid cell and data stream in 'integrationdata' the cost besed on the Kling-Gupta efficiency (KGE, Gupta et al. 2009, J. Hydrology). Thereby each component of KGE is weighted by the uncertainty of the observations (i.e. weighted mean, variance and correlation). See Forkel et al. (in prep.) for the specific use of KGE for multiple data streams.
	
	integrationdata
	### object of class 'integrationdata', see \code{\link{IntegrationData}}
			
	##details<<
	## No details.
	
	##references<< No reference.	
) {
	
	# number of data streams and cells
	nds <- length(integrationdata)
	ds.nms <- unlist(llply(integrationdata, function(ds) ds$name))
	xy <- integrationdata[[1]]$xy
	xy <- integrationdata[[1]]$xy
	xy.nms <- paste(xy[,1], xy[,2])
	ncell <- nrow(xy)
	of.nms <- c("Bias", "Var", "Cor") # 3 KGE components
	nof <- length(of.nms)
	ds.cost <- (1:nds)
	
	# which data stream to use in the total cost
	use.cost.v <- unlist(llply(integrationdata, function(ds) ds$cost)) # boolean flag: use cost in total cost
	use.cost.m <- matrix(use.cost.v, nrow=nds, ncol=nof)

	# area of grid cells
	area.v <- integrationdata[[1]]$area.v
	area.m <- matrix(1, nrow=nds, ncol=ncell, byrow=TRUE)
	area.m <- area.m / rowSums(area.m)
	colnames(area.m) <- xy.nms
	rownames(area.m) <- ds.nms
	
	# weighting factor for data stream	
	weight <- unlist(llply(integrationdata, function(ds) ds$weight)) # weight per data stream
	weight.m <- matrix(weight, nrow=nds, ncol=nof)
	colnames(weight.m) <- of.nms
	rownames(weight.m) <- ds.nms
	
	# number of observations per data stream and cell
	nobs.m <- laply(integrationdata, function(ds) {
		nobs <- colSums(!is.na(ds$data.val), na.rm=TRUE)
		matrix(nobs, ncol=ncell, nrow=1)
	})
	nobs.m <- matrix(nobs.m, nrow=nds, ncol=nof)
	colnames(nobs.m) <- of.nms
	rownames(nobs.m) <- ds.nms	
			
	# calculate cost per data stream and grid cell
	cost.m <- laply(integrationdata, function(ds) {
		obs.m <- ds$data.val
		unc.m <- ds$data.unc
		sim.m <- ds$model.val
		var <- r <- 0
		unc.m[unc.m == 0] <- 0.00000001
		simobs <- na.omit(cbind(as.vector(sim.m), as.vector(obs.m), w=1/as.vector(unc.m)))
		simobs[is.infinite(simobs)] <- NA
		simobs <- na.omit(simobs)
		
		# bias component
		bias <- (MeanW(simobs[,1], w=1/simobs[,3]) / MeanW(simobs[,2], w=1/simobs[,3]) - 1)^2
		
		if (nrow(simobs) > 1) {
		   # variance component
		   var <- (SdW(simobs[,1], w=1/simobs[,3]) / SdW(simobs[,2], w=1/simobs[,3]) - 1)^2
		
		   # if all values are the same, set correlation component to 1
		   r <- 1
		   if (!AllEqual(simobs[,1]) & !AllEqual(simobs[,2])) {
		      r <- try((CorW(simobs[,1], simobs[,2], w=1/simobs[,3]) - 1)^2, silent=TRUE)
		      if (class(r) == "try-error") r <- (cor(simobs[,1], simobs[,2]) - 1)^2		   
		   }
		}

		cost.gc <- matrix(c(bias, var, r), nrow=1, ncol=nof)
		return(cost.gc)
	})	
	colnames(cost.m) <- of.nms
	rownames(cost.m) <- ds.nms

	# weight cost
	costw.m <- cost.m
	
	# total cost per data stream
	cost.ds <- apply(costw.m, 1, function(x) sum(x, na.rm=TRUE))
	names(cost.ds) <- ds.nms
	
	# total cost per metric
	cost.gc <- apply(costw.m, 2, function(x) sum(x, na.rm=TRUE))
	names(cost.gc) <- of.nms

	# fractional cost
	cost.frac <- costw.m / sum(costw.m, na.rm=TRUE)

	# total cost - only for data sets that should be used in total cost
	cost <- sqrt(sum(costw.m * use.cost.m, na.rm=TRUE))
	if (is.infinite(cost) | is.na(cost)) cost <- 1e+20 
	
	# result
	cost.l <- list(
		total = cost,
		per.cell = cost.gc,
		per.ds = cost.ds,
		per.cell.ds = costw.m,
		sse = cost.m,
		nobs = nobs.m,
		weight = weight.m,
		use = use.cost.m,
		area = area.m,
		fractional = cost.frac
	)
	return(cost.l)
	### The function returns a list with the total cost (total), the cost per KGE component (per.cell), per data streams (per.ds), per KGE component and data stream (per.cell.ds), and the fractional contribution of a data stream and KGE component to the total cost (fractional).
}, ex=function() {	

# load(paste0(path.me, "/lpj/LPJmL_131016/out_optim/opt_fpc/OFPC_BO-GI-BM_v1_all_0_59_posterior-best.RData"))
# x <- result.post.lpj$integrationdata
# plot(x, 2)

# cost.see <- CostMDS.SSE(x)
# cost.kge <- CostMDS.KGE(x)
# cost.kgew <- CostMDS.KGEw(x)

# DefaultParL(mfrow=c(1,3))
# barplot(cost.see$per.ds)
# barplot(t(cost.kge$per.cell.ds))
# barplot(t(cost.kgew$per.cell.ds))

})



