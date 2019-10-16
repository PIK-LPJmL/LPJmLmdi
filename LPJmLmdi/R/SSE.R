SSE <- structure(function(
	##title<< 
	## Sum-of-squared residuals error
	##description<<
	## The function implements the sum-of-squared residuals error as cost function
	
	sim,
	### vector of simulations
	
	obs,
	### vector of observations
	
	unc
	### vector of observation uncertainties
			
	##details<<
	## No details.
	
	##references<< No reference.	
) {
	b <- is.na(obs) | is.na(unc)
	sim[b] <- NA
	unc[unc == 0] <- NA
	sum( (sim - obs)^2 / (unc^2), na.rm=TRUE)

}, ex=function() {

obs <- rnorm(10, 0, 2)
sim <- obs + rnorm(10, 0.05, 0.01)
unc <- 0.01
SSE(sim, obs, unc)

})	