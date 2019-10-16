CheckLPJpar <- structure(function(
	##title<< 
	## Checks LPJ parameters 'LPJpar'
	##description<<
	## The function checks if LPJ parameters are within the lower and upper boundaries or are 0. 
	
	lpjpar,
	### object of class 'LPJpar'
	
	correct=FALSE
	### correct parameter values (TRUE) or return error message?
		
	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{LPJpar}}		
) {

	if (is.null(lpjpar$lower) | is.null(lpjpar$upper) | is.null(lpjpar$prior) | is.null(lpjpar$names)) {
		stop("names, prior, lower and upper need to be defined in 'lpjpar'. See LPJpar.")
	}

	# lower boundaries > upper boundaries?
	bool <- lpjpar$lower > lpjpar$upper
	bool2 <- is.na(bool)
	if (any(bool2)) {
	  stop(paste("Parameter boundaries are not defined for", lpjpar$names[bool2]))
	}
	if (any(bool)) {
		if (correct) {
			df <- cbind(lpjpar$lower, lpjpar$upper, lpjpar$prior, lpjpar$best)
			lpjpar$lower[bool] <- apply(df, 1, min, na.rm=TRUE)[bool]
			lpjpar$upper[bool] <- apply(df, 1, max, na.rm=TRUE)[bool]
		} else {
			stop(paste("Parameter lower boundary > upper boundary:", lpjpar$names[bool]))
		}
	}
	
	# which parameter to check?
	check <- list(prior=lpjpar$prior, best=lpjpar$best, new=lpjpar$new, best.median=lpjpar$best.median)
	
	for (i in 1:length(check)) {
		par <- check[[i]]
		if (!is.null(par)) {
		
			# NA?
			bool <- is.na(par)
			par[bool] <- lpjpar$prior[bool]

			# parameter close to 0?
			bool <- (par > -0.0000001) & (par < 0.0000001)
			if (any(bool)) {
				par[bool] <- 0.0000001
				message(paste("Parameter", names(check)[i], "equal 0 can cause division by 0. Parameter changed to 0.0000001:", paste(lpjpar$names[bool], collapse=" ")))
			}
			
			# parameter < lower?
			bool <- par < lpjpar$lower
			if (any(bool)) {
				if (correct) {
					par[bool] <- lpjpar$lower[bool]
					message(paste("Parameter", names(check)[i], "less than lower boundary. Changed.", paste(lpjpar$names[bool], collapse=" ")))
				} else {
					stop(paste("Parameter", names(check)[i], "less than lower boundary. ", paste(lpjpar$names[bool], collapse=" ")))
				}
			}
			
			# parameter > upper
			bool <- par > lpjpar$upper
			if (any(bool)) {
				if (correct) {
					par[bool] <- lpjpar$upper[bool]
					message(paste("Parameter", names(check)[i], "higher than upper boundary. Changed.", paste(lpjpar$names[bool], collapse=" ")))
				} else {
					stop(paste("Parameter", names(check)[i], "higher than upper boundary. ", paste(lpjpar$names[bool], collapse=" ")))
				}
			}
			
			# set changed values back to LPJpar
			names(par) <- lpjpar$names
			g <- grep(names(check)[i], names(lpjpar))[1]
			lpjpar[[g]] <- par
		}
	} # end of loop over check
			
	class(lpjpar) <- "LPJpar"
	return(lpjpar)
	### the function return an object of class 'LPJpar'
})