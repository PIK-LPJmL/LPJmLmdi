Turnover <- structure(function(
   ##title<< 
   ## Calculate turnover time from stock and flux
   ##description<<
   ## Calculates turnover times.

   stock, 
   ### stock, e.g. biomass
   
   flux, 
   ### flux, e.g. NPP
   
	...
	### further arguments (currently not used)
	
	##details<<
   ## turnover = stock / flux
	
	##references<< No reference.
) { 
   if (length(stock) == 1) {
      tau <- stock / flux
   } else {
      dstock <- c(NA, diff(stock))
      tau <- - stock / (dstock - flux)
   }
   return(tau)
})
