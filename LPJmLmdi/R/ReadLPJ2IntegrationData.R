ReadLPJ2IntegrationData <- structure(function(
	##title<< 
	## Read LPJ model results into an of class IntegrationData
	##description<<
	## The function reads for each dataset in \code{\link{IntegrationData}} the corresponding model output and performs temporal aggregation.
	
	integrationdata,
	### object of class \code{\link{IntegrationData}}
	
	xy,
	### matrix of grid cell coordinates to run LPJ
	
	lpjfiles,
	### list of class \code{\link{LPJfiles}} that define all LPJ directories, input files, configuration template files

	...
	### further arguments (currently not used)
		
	##details<<
	## No details.
	
	##references<< No reference.
	
	##seealso<<
	## \code{\link{IntegrationData}}
			
) {	 
	integrationdata <- llply(integrationdata, function(ds) {
	
		# ds <<- ds
		
	  # get time info
	  model.time <- ds$model.time
	  data.time <- as.Date(ds$data.time)
		years.mod <- format(model.time, "%Y")
		years.dat <- format(data.time, "%Y")
		start <- min(as.numeric(years.mod))
		end <- max(as.numeric(years.mod))
		
		# read model simulation of data stream 
		if (is.function(ds$model.val.file)) {
			model.sp <- do.call(ds$model.val.file, args=list())
		} else {
			model.sp <- ReadLPJ(ds$model.val.file, start=start, end=end, sim.start.year=lpjfiles$sim.start.year)
		}
		ncell <- nrow(xy)
		
		# apply scaling factor
		if (!is.null(ds$model.factor)) model.sp@data <- model.sp@data * ds$model.factor
		
		# change order of grid cells in simulation according to order of observations
		o <- 1
		if (ncell > 1) {
			coord.order.obs <- apply(xy, 1, paste, collapse="_")
			coord.order.sim <- apply(coordinates(model.sp), 1, paste, collapse="_")	
			o <- match(coord.order.obs, coord.order.sim)	
		}
		model.m <- as.matrix(t(model.sp@data[o,]))

		# aggregate model result?
		if (!is.null(ds$AggFun)) {
		  agg <- years.mod
		  years.mod <- unique(years.mod)
		  model.m <- matrix(apply(model.m, 2, FUN=ds$AggFun, agg=agg), ncol=ncell)
		  if (nrow(model.m) == 1) {
		    model.time <- data.time # one value
		  } else if (nrow(model.m) == 12 & nrow(model.m) != length(years.mod)) {
		    model.time <- data.time # mean seasonal cycle
		  } else {
		    model.time <- as.Date(paste0(years.mod, "-01-01")) # annual time series
		  }
		} 

		# match data time and model time
		b <- length(data.time) != length(model.time)
		if (!b) b <- any(data.time != model.time)
		if (b) {
		  m <- match(data.time, model.time) 
		  if (all(is.na(m))) stop(paste0("ReadLPJ2IntegrationData: IntegrationDataset = ", ds$name, ": time steps of data and model do not match."))
		  if (length(m) > 1) {
		    model.m <- model.m[m, ]
		  } else {
		    model.m <- matrix(model.m[m, ], nrow=1, ncol=ncell)
		  }
		}
		ds$model.val <- model.m
		
		# error check
		if (any(dim(ds$model.val) != dim(ds$data.val))) {
			stop(paste0("ReadLPJ2IntegrationData: IntegrationDataset = ", ds$name, ": dimensions of data and model results don't match."))
		}
	
		return(ds)
	})
	class(integrationdata) <- "IntegrationData"
	return(integrationdata)
	### The function returns the same list oc class 'IntegrationData' but with added model outputs.
})

