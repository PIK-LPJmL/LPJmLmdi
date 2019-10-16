AggSumMean <- structure(function(
	##title<< 
	## Temporal aggregation: first sum, then mean
	##description<<
	## This function can be provided to \code{\link{IntegrationDataset}} to aggregate model results to the temporal resolution of the observations.
	
	x,
	### full time series
	
	agg
	### vector of grouping elements (years)

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{IntegrationDataset}}
) {
	mean(aggregate(x, list(agg), FUN=sum, na.rm=TRUE)$x)
	### The function returns a the aggregated result.
})


AggMeanMean <- structure(function(
	##title<< 
	## Temporal aggregation: first mean, then mean = mean over all values
	##description<<
	## This function can be provided to \code{\link{IntegrationDataset}} to aggregate model results to the temporal resolution of the observations.
	
	x,
	### full time series
	
	agg
	### vector of grouping elements (years)

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{IntegrationDataset}}
) {
	mean(aggregate(x, list(agg), FUN=mean, na.rm=TRUE)$x)
	### The function returns a the aggregated result.
})


AggMeanNULL <- structure(function(
	##title<< 
	## Temporal aggregation: first mean, then nothing = mean per group
	##description<<
	## This function can be provided to \code{\link{IntegrationDataset}} to aggregate model results to the temporal resolution of the observations.
	
	x,
	### full time series
	
	agg
	### vector of grouping elements (years)

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{IntegrationDataset}}
) {
	x2 <- aggregate(x, list(agg), FUN=mean, na.rm=TRUE)
	x2 <- x2[match(unique(agg), x2[,1]), 2]
	return(x2)
	### The function returns a the aggregated result.
})


AggSumNULL <- structure(function(
	##title<< 
	## Temporal aggregation: first sum, then nothing = sum per group
	##description<<
	## This function can be provided to \code{\link{IntegrationDataset}} to aggregate model results to the temporal resolution of the observations.
	
	x,
	### full time series
	
	agg
	### vector of grouping elements (years)

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{IntegrationDataset}}
) {
	x2 <- aggregate(x, list(agg), FUN=sum, na.rm=TRUE)
	x2 <- x2[match(unique(agg), x2[,1]), 2]
	return(x2)
	### The function returns a the aggregated result.
})


AggQ09NULL <- structure(function(
	##title<< 
	## Temporal aggregation: aggregate by using quantile with prob=0.9
	##description<<
	## This function can be provided to \code{\link{IntegrationDataset}} to aggregate model results to the temporal resolution of the observations.
	
	x,
	### full time series
	
	agg
	### vector of grouping elements (years)

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{IntegrationDataset}}
) {
	x2 <- aggregate(x, list(agg), FUN=quantile, prob=0.9, na.rm=TRUE)
	x2 <- x2[match(unique(agg), x2[,1]), 2]
	return(x2)
	### The function returns a the aggregated result.
})


AggMaxNULL <- structure(function(
	##title<< 
	## Temporal aggregation: aggregate by using annual maximum
	##description<<
	## This function can be provided to \code{\link{IntegrationDataset}} to aggregate model results to the temporal resolution of the observations.
	
	x,
	### full time series
	
	agg
	### vector of grouping elements (years)

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{IntegrationDataset}}
) {
	x2 <- aggregate(x, list(agg), FUN=max, na.rm=TRUE)
	x2 <- x2[match(unique(agg), x2[,1]), 2]
	return(x2)
	### The function returns a the aggregated result.
})


AggMSC <- structure(function(
	##title<< 
	## Temporal aggregation: mean seasonal cycle
	##description<<
	## This function can be provided to \code{\link{IntegrationDataset}} to aggregate model results to the temporal resolution of the observations.
	
	x,
	### full time series
	
	agg
	### vector of grouping elements (years)

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{IntegrationDataset}}
) {
	nyear <- length(unique(agg)) # number of years
	nmonths <- length(agg) / nyear # number of months per year
	agg2 <- rep(1:nmonths, length=length(x)) # aggregation vector
	aggregate(x, list(agg2), FUN=mean, na.rm=TRUE)$x
	### The function returns the mean seasonal cycle
})



AggNULLMean <- structure(function(
	##title<< 
	## Temporal aggregation: mean over all values
	##description<<
	## This function can be provided to \code{\link{IntegrationDataset}} to aggregate model results to the temporal resolution of the observations.
	
	x,
	### full time series
	
	agg
	### vector of grouping elements (years)

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{IntegrationDataset}}
) {
	mean(x, na.rm=TRUE)
	### The function returns a the aggregated result.
})


AggFPCPoH <- structure(function(
	##title<< 
	## Temporal aggregation for PoH PFT: get PoH from vector of all PFTs, average over years
	##description<<
	## This function can be provided to \code{\link{IntegrationDataset}} to aggregate model results to the temporal resolution of the observations.
	
	x,
	### full time series
	
	agg
	### vector of grouping elements (years)

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{IntegrationDataset}}
) {
	mean(x[seq(12, 12*length(agg), by=12)], na.rm=TRUE)
	### The function returns a the aggregated result.
})


AggFPCBoNE <- structure(function(
	##title<< 
	## Temporal aggregation for BoNE PFT: get BoNE from vector of all PFTs, average over years
	##description<<
	## This function can be provided to \code{\link{IntegrationDataset}} to aggregate model results to the temporal resolution of the observations.
	
	x,
	### full time series
	
	agg
	### vector of grouping elements (years)

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{IntegrationDataset}}
) {
	mean(x[seq(7, 12*length(agg), by=12)], na.rm=TRUE)
	### The function returns a the aggregated result.
})


AggFPCBoNS <- structure(function(
	##title<< 
	## Temporal aggregation for BoNS PFT: get BoNS from vector of all PFTs, average over years
	##description<<
	## This function can be provided to \code{\link{IntegrationDataset}} to aggregate model results to the temporal resolution of the observations.
	
	x,
	### full time series
	
	agg
	### vector of grouping elements (years)

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{IntegrationDataset}}
) {
	mean(x[seq(9, 12*length(agg), by=12)], na.rm=TRUE)
	### The function returns a the aggregated result.
})


AggFPCBoBS <- structure(function(
	##title<< 
	## Temporal aggregation for BoBS PFT: get BoBS from vector of all PFTs, average over years
	##description<<
	## This function can be provided to \code{\link{IntegrationDataset}} to aggregate model results to the temporal resolution of the observations.
	
	x,
	### full time series
	
	agg
	### vector of grouping elements (years)

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{IntegrationDataset}}
) {
	mean(x[seq(8, 12*length(agg), by=12)], na.rm=TRUE)
	### The function returns a the aggregated result.
})


AggFPCTeBS <- structure(function(
	##title<< 
	## Temporal aggregation for PFTs: get TeBS from vector of all PFTs, average over years
	##description<<
	## This function can be provided to \code{\link{IntegrationDataset}} to aggregate model results to the temporal resolution of the observations.
	
	x,
	### full time series
	
	agg
	### vector of grouping elements (years)

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{IntegrationDataset}}
) {
	mean(x[seq(6, 12*length(agg), by=12)], na.rm=TRUE)
	### The function returns a the aggregated result.
})


AggFPCTeH <- structure(function(
	##title<< 
	## Temporal aggregation for PFTs: get TeH from vector of all PFTs, average over years
	##description<<
	## This function can be provided to \code{\link{IntegrationDataset}} to aggregate model results to the temporal resolution of the observations.
	
	x,
	### full time series
	
	agg
	### vector of grouping elements (years)

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{IntegrationDataset}}
) {
	mean(x[seq(11, 12*length(agg), by=12)], na.rm=TRUE)
	### The function returns a the aggregated result.
})


AggFPCTeBE <- structure(function(
	##title<< 
	## Temporal aggregation for PFTs: get TeBE from vector of all PFTs, average over years
	##description<<
	## This function can be provided to \code{\link{IntegrationDataset}} to aggregate model results to the temporal resolution of the observations.
	
	x,
	### full time series
	
	agg
	### vector of grouping elements (years)

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{IntegrationDataset}}
) {
	mean(x[seq(5, 12*length(agg), by=12)], na.rm=TRUE)
	### The function returns a the aggregated result.
})


AggFPCTeNE <- structure(function(
	##title<< 
	## Temporal aggregation for PFTs: get TeNE from vector of all PFTs, average over years
	##description<<
	## This function can be provided to \code{\link{IntegrationDataset}} to aggregate model results to the temporal resolution of the observations.
	
	x,
	### full time series
	
	agg
	### vector of grouping elements (years)

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{IntegrationDataset}}
) {
	mean(x[seq(4, 12*length(agg), by=12)], na.rm=TRUE)
	### The function returns a the aggregated result.
})


AggFPCTrBE <- structure(function(
	##title<< 
	## Temporal aggregation for PFTs: get TrBE from vector of all PFTs, average over years
	##description<<
	## This function can be provided to \code{\link{IntegrationDataset}} to aggregate model results to the temporal resolution of the observations.
	
	x,
	### full time series
	
	agg
	### vector of grouping elements (years)

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{IntegrationDataset}}
) {
	mean(x[seq(2, 12*length(agg), by=12)], na.rm=TRUE)
	### The function returns a the aggregated result.
})


AggFPCTrBR <- structure(function(
	##title<< 
	## Temporal aggregation for PFTs: get TrBR from vector of all PFTs, average over years
	##description<<
	## This function can be provided to \code{\link{IntegrationDataset}} to aggregate model results to the temporal resolution of the observations.
	
	x,
	### full time series
	
	agg
	### vector of grouping elements (years)

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{IntegrationDataset}}
) {
	mean(x[seq(3, 12*length(agg), by=12)], na.rm=TRUE)
	### The function returns a the aggregated result.
})
