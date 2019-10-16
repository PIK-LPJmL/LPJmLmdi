LE2ET <- structure(function(
	##title<< 
	## Compute evapotranspiration (ET) from latent heat (LE).

	le,
	### latent heat (W m-2)

	temp = 20,
	### temperature (degC, default 20 degC)

	rho_w = 1000
	# density of water (kg m-3)
		
	##details<<
	##  
	
	##references<< 
	## FAO (1998): Crop evapotranspiration - Guidelines for computing crop water requirements - FAO Irrigation and drainage paper 56, http://www.fao.org/docrep/x0490e/x0490e04.htm
	
	##seealso<<
	## \code{\link{WriteLPJinput}}
	
) {
	# latent heat of vaporization
	lambda_v <- (5.147 * exp(-0.0004643 * temp) - 2.6466) # MJ/kg
	lambda_v <- lambda_v * 1E6 # (J/kg)
	
	# evapotranspiration (m s-1)
	et <- le / (rho_w * lambda_v)
	
	# evapotranspiration (m s-1) -> (mm day-1)
	et <- et * 1000 * 86400
	return(et)
	### The function returns evapotranspiration (mm day-1)
}, ex=function() {
  # Example from FAO (1998)
  le <- 12 # latent heat that is used to vapourize water (MJ m-2 day-1)
  le <- le / 86400 # MJ m-2 day-1  ->  MJ m-2 sec-1 
  le <- le * 1E6 # MJ m-2 sec-1 -> W m-2
  LE2ET(le=le)
  
  temp <- -30:40
  et <- LE2ET(le=le, temp=temp)
  plot(temp, et)
})
