IntegrationDataset <- structure(function(
	##title<< 
	## Create an object of class 'IntegrationDataset'
	##description<<
	## The function sets up an object of class 'IntegrationDataset' to define a dataset that should be used in model optimization, including dataset properties and the corresponding model output files. The function also reads the data input files as defined in 'data.val.file' and subsets the input data for the grid cells in 'xy'. One or several 'IntegrationDataset's need to be collected in an object of class \code{\link{IntegrationData}} which is used in the \code{\link{RunLPJ}} and \code{\link{OptimizeLPJgenoud}} functions.
	
	name, 
	### name of the dataset or variable
	
	unit="",
	### unit of the variable (same unit as in LPJmL model output file 'model.val.file')
	
	data.val.file,
	### name of file with the observation values, should be a file that can be read with \code{\link{brick}}
	
	data.unc.file,
	### name of file with the data uncertainties or a numeric value if the same uncertainty value should be used for all observations
	
	data.time,
	### a vector of class 'Date' with the time steps of the observations. 
	
	model.time = data.time,
	### a vector of class 'Date' with the time steps for which model results should be read. For example, if data.val.file represents just one value (e.g. long-term mean), the full time period for which the model results should be averaged needs to be defined here. 

	model.val.file,
	### file name of the corresponding model result [e.g. model.val.file="mnpp.bin"] or function without arguments [e.g. model.val.file=function() { ReadLPJ("mnpp.bin", start=1901, end=2009, ...) }]. The option to pass a function allows to perform any calculations on LPJ model results or to combine several LPJ model outputs in order to be comparable with observations. 
	
	xy,
	### a matrix of grid cells that is used in \code{\link{RunLPJ}} and \code{\link{OptimizeLPJgenoud}}. The data in 'data.val.file' and 'data.unc.file' is extracted for these grid cells.	
	
	AggFun=NULL,
	### aggregation function to aggregate model results to the temporal resolution of the observations, for example \code{\link{AggSumMean}} for annual sums and mean over annual sums. If NULL no temporal aggregation	is done.
	
	data.factor=1,
	### scaling factor to be applied to the observation data, e.g. for unit conversions
	
	model.factor=1,
	### scaling factor to be applied to model outputs, e.g. for unit conversions or scaling
	
	cost=TRUE,
	### Should the data stream be included in the computation of the total cost (TRUE) or not (FALSE). In case of FALSE, evaluation plots are produced for this dataset but the dataset is not considered in the compuation of the total cost and therfore not in optimization.
	
	CostFunction=SSE,
	### cost function that should be used for this dataset, default \code{\link{SSE}}
	
	weight=1
	### weighting factor for the dataset in the cost function, cost = CostFunction / number of observations * weight

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{IntegrationData}}
) {

	# read data files and extract for grid cells
	#-------------------------------------------
	
	ncell <- nrow(xy)
	
	# read observations
	data.val.r <- brick(data.val.file)
	if (nlayers(data.val.r) == 1) data.val.r <- raster(data.val.file)
	data.val <- matrix(t(data.val.r[cellFromXY(data.val.r, xy)]), ncol=ncell)
	
	# read values of the uncertainty
	if (is.character(data.unc.file)) {	
		# read values of a data stream from file
		data.unc.r <- brick(data.unc.file)
		if (nlayers(data.unc.r) == 1) data.unc.r <- raster(data.unc.file)
		data.unc <- matrix(t(data.unc.r[cellFromXY(data.unc.r, xy)]), ncol=ncell)
	} else {
		# create raster with constant uncertainty
		data.unc <- data.val
		data.unc[] <- data.unc.file
	}
	
	# grid cell area
	area.r <- raster::area(data.val.r)
	area.v <- extract(area.r, xy)
	
	
	# create IntegrationDataset object
	#---------------------------------
	
	if (is.null(data.factor)) data.factor <- 1

	ds <- list(
		name=name, 
		unit=unit,
		data.val.file=data.val.file,
		data.unc.file=data.unc.file,
		data.time=data.time,
		model.time=model.time,
		model.val.file=model.val.file,
		model.factor=model.factor,
		AggFun=AggFun,
		data.factor=data.factor,
		cost=cost,
		CostFunction=CostFunction,
		weight=weight,
		data.val=data.val*data.factor,
		data.unc=data.unc*data.factor,
		xy=xy,
		area.v=area.v
	)
	class(ds) <- "IntegrationDataset"	
	return(ds)
	### The function returns a list of class 'IntegrationDataset'
}, ex=function() {

# # grid cells for which LPJmL should be run and for which the integration data should be extracted
# xy <- cbind(c(136.75, 137.25, 160.75,168.75), c(45.25, 65.25, 68.75, 63.75))

# # use monthly FAPAR in model-data integration
# fapar <- IntegrationDataset(name="FAPAR", unit="", 
	# data.val.file="GIMMS.FAPAR.1982.2011.nc", 
	# data.unc.file=0.12, 
	# data.time=seq(as.Date("1982-01-01"), as.Date("2011-12-31"), by="month"),
	# model.val.file="mfapar.bin",
	# model.agg=NULL,
	# xy=xy,
	# data.factor=NULL,
	# cost=TRUE,
	# CostFunction=SSE,
	# weight=1)
	
# # use mean annual GPP in model-data integration
# gpp <- IntegrationDataset(name="GPP", unit="gC m-2 yr-1", 
	# data.val.file="MTE.GPP.1982.2011.meanannual.nc", 
	# data.unc.file="MTE.GPPunc.1982.2011.meanannual.nc", 
	# data.time=seq(as.Date("1982-01-01"), as.Date("2011-12-31"), by="month"),
	# model.val.file="mgpp.bin",
	# model.agg=AggSumMean, # sum of each year, mean over all years -> mean annual GPP
	# xy=xy,
	# data.factor=NULL,
	# cost=TRUE,
	# CostFunction=SSE,
	# weight=1)	
	
	
})	

