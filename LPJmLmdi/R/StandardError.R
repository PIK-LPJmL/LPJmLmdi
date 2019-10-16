StandardError <- structure(function(
	##title<< 
	## Compute standard errors from a variance-covariance matrix
	##description<<
	## SE = sqrt(diag(vc) * cost^2 / (nobs - npar))
	
	vc,
	### variance-covariance matrix
	
	nobs,
	### number of observations
	
	cost
	### cost function value
			
	##details<<
	## No details.
	
	##references<< No reference.	
) {
	npar <- nrow(vc)
	s2 <- cost^2 / (nobs - npar)
	sqrt(diag(vc) * s2) 	# standard errors
})