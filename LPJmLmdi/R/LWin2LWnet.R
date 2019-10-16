LWin2LWnet <- structure(function(
	##title<< 
	## Compute long-wave net radiation from long-wave incoming radiation and temperature.

	lwin,
	### long-wave incoming radiation (Wm-2)
	
	temp,
	### temperature (degC, conversion to K is done within the function)
	
	emissivity = 0.97
	### emissivity of the surface. Values around 0.97 are valid for various natural surface types (leaves 0.94-0.99, soil 0.93-0.96, water 0.96) (Campbell and Norman 1998, p. 162-163, 177). 
		
	##details<<
	## Long-wave net radiation is computed as the difference between long-wave incoming and long-wave outgoing radiation. Long-wave outgoing radiation is computed based on the Stefan-Boltzmann law and an emissivity factor (LWout = emissivity * sigma * temp^4), whereas sigma is the Stefan-Boltzmann constant (5.67037 * 10^(-8) Wm-2 K-4) (Campbell and Norman 1998, p. 162-163, 177).
	
	##references<< Campbell GS, Norman JM (1998) An Introduction to Environmental Biophysics. Springer New York, New York, NY.
	
	##seealso<<
	## \code{\link{WriteLPJinput}}
	
) {
	sigma <- 5.67037 * 10^(-8) # Stefan-Boltzmann constant
	temp <- temp + 273.15 # degC -> K
	lwout <- sigma * emissivity * (temp^4) 
	lwnet <- lwin - lwout
	return(lwnet)
	### The function returns long-wave net radiation (Wm-2)
}, ex=function() {
	lwin <- 200:380 # long-wave incoming radiation (Wm-2)
	temp <- 0.14 * lwin - 32 + rnorm(length(lwin), 0, 5) # temperature (degC)
	plot(lwin, temp)
	lwnet <- LWin2LWnet(lwin, temp)
	plot(temp, lwnet)
	plot(lwin, lwnet)
})