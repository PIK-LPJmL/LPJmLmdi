VarCovMatrix <- structure(function(
	##title<< 
	## Compute variance-covariance matrix
	##description<<
	## The function computes the variance-covariance matrix from the hessian matrix. Parameters that have a hessian = 0 (in sensitive parameters) area removed from the matrix before calculating the variance-covariance matrix.

	hessian, 
	### Hessian matrix
	
	nms=paste("P", 1:n, sep="")
	### names of the parameters (rows and columns in the matrix
	
	##details<<
	## No details.
	
	##references<< No reference.		
) {

	n <- ncol(hessian)
	result <- matrix(NA, ncol=n, nrow=n) 
	colnames(result) <- nms
	rownames(result) <- nms	
	dimnames(hessian) <- list(nms, nms)
	
	if (any(is.na(hessian))) return(result)
	
	# compute uncertainty if matrix is invertable
	rem <- NULL
	issingular <- FALSE
	if (det(hessian) == 0) {	# check if determinant is 0
		issingular <- TRUE	# matrix is singular
		
		# check if any diagonal element is 0 / remove these rows and columns
		isnull <- (diag(hessian) == 0)
		if (any(isnull)) {
			rem <- (1:ncol(hessian))[isnull]
			hessian <- hessian[-rem, -rem]
			if (!is.matrix(hessian)) hessian <- matrix(hessian)
			if (det(hessian) != 0) issingular <- FALSE
		}	
	} 
	
	# invert matrix and compute standard error
	if (!issingular) {
		# function to invert hessian and compute standard errors
		f <- function(hessian) {
			vc <- qr.solve(hessian)	# variance-covariance matrix
			colnames(vc) <- colnames(hessian)
			rownames(vc) <- colnames(hessian)
			return(vc)
		}
		
		vc <- tryCatch({
			f(hessian)
		}, warning = function(w) {
			f(hessian)
		}, error = function(e) {
			warning("Hessian cannot be inverted.")
			return(result)
		}, finally = function(x) {
			return(result)
		})
		pos <- match(colnames(vc), colnames(result))
		result[pos, pos] <- vc
	} 
	return(result)
})	