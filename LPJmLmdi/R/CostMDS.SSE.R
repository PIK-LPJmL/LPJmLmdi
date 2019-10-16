CostMDS.SSE <- structure(function(
	##title<< 
	## Cost function for multiple data streams based on SSE
	##description<<
	## The function computes the cost for each grid cell and data stream in 'integrationdata'. Firstly, the cost per data stream and grid cell is computed using the defined 'CostFunction' for each \code{\link{IntegrationDataset}}. Secondly, the cost is weighted by (1) the dataset-specific weight, (2) the number of observations per grid cell and data streams, and (3) by the grid cell area.
	
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
	xy.nms <- paste(xy[,1], xy[,2])
	ncell <- nrow(xy)
	ds.cost <- (1:nds)
	
	# which data stream to use in the total cost
	use.cost.v <- unlist(llply(integrationdata, function(ds) ds$cost)) # boolean flag: use cost in total cost
	use.cost.m <- matrix(use.cost.v, nrow=nds, ncol=ncell)

	# area-weight of grid cells
	area.v <- integrationdata[[1]]$area.v
	area.m <- matrix(area.v, nrow=nds, ncol=ncell, byrow=TRUE)
	area.m <- area.m / rowSums(area.m)
	colnames(area.m) <- xy.nms
	rownames(area.m) <- ds.nms
	
	# weighting factor for data stream	
	weight <- unlist(llply(integrationdata, function(ds) ds$weight)) # weight per data stream
	weight.m <- matrix(weight, nrow=nds, ncol=ncell)
	colnames(weight.m) <- xy.nms
	rownames(weight.m) <- ds.nms
	
	# number of observations per data stream and cell
	nobs.m <- laply(integrationdata, function(ds) {
	   #bacds <<- ds
		nobs <- colSums(!is.na(ds$data.val), na.rm=TRUE)
		matrix(nobs, ncol=ncell, nrow=1)
	})
	if (!is.matrix(nobs.m)) nobs.m <- matrix(nobs.m, ncol=ncell, nrow=nds)
	colnames(nobs.m) <- xy.nms
	rownames(nobs.m) <- ds.nms	
		
	# calculate cost per data stream and grid cell
	cost.m <- laply(integrationdata, function(ds) {
	   ds <<- ds
		obs.m <- ds$data.val
		unc.m <- ds$data.unc
		sim.m <- ds$model.val
		CostFunction <- ds$CostFunction
		cost.gc <- mapply(function(cell) { 
			do.call(CostFunction, list(sim.m[,cell], obs.m[,cell], unc.m[,cell]))
		}, 1:ncell)
		return(cost.gc)
	})	
	if (!is.matrix(cost.m)) cost.m <- matrix(cost.m, ncol=ncell, nrow=nds)
	colnames(cost.m) <- xy.nms
	rownames(cost.m) <- ds.nms
	
	# weight cost
	costw.m <- (cost.m / nobs.m * weight.m * area.m)
	colnames(costw.m) <- xy.nms
	rownames(costw.m) <- ds.nms
	
	# total cost per data stream
	cost.ds <- rowSums(costw.m, na.rm=TRUE)
	names(cost.ds) <- ds.nms
	
	# total cost per grid cell
	cost.gc <- colSums(costw.m, na.rm=TRUE)
	names(cost.gc) <- xy.nms
	
	# total cost - only for data sets that should be used in total cost
	cost <- sum(costw.m * use.cost.m, na.rm=TRUE)
	if (is.infinite(cost) | is.na(cost)) cost <- 1e+20 
	
	# result
	cost.l <- list(
		total = cost,
		per.cell = cost.gc,
		per.ds = cost.ds,
		per.cell.ds = costw.m,
		costfun = cost.m,
		nobs = nobs.m,
		weight = weight.m,
		use = use.cost.m,
		area = area.m
	)
	return(cost.l)
	### The function returns a list with the total cost, the cost per grid cell, per data streams, per grid cell and data stream, the error as computed with the defined CostFunction, the number of observations per grid cell and data stream, the weighting factors and grid cell area.
})	

