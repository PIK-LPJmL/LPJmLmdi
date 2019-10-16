IntegrationData <- structure(function(
	##title<< 
	## Create an object of class 'IntegrationData'
	##description<<
	## The function takes several objects of class \code{\link{IntegrationDataset}} and converts them to an object 'IntegrationData' that is used in \code{\link{RunLPJ}} and \code{\link{OptimizeLPJgenoud}}. 
	
	...
	### one or several objects of class 'IntegrationDataset'

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{IntegrationDataset}}
) {
	integrationdata <- list(...)
	llply(integrationdata, function(ds) {
		if (class(ds) != "IntegrationDataset") stop(paste(ds$name, "is not of class 'IntegrationDataset'"))
	})
	class(integrationdata) <- "IntegrationData"
	return(integrationdata)
	### The function returns a list of class 'IntegrationData'	
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
	
# integrationdata <- IntegrationData(fapar, gpp)
	
})	

