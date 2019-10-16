MeanW <- structure(function(
	##title<< 
	## Weighted mean
	##description<<
	## Compute the weighted mean.
	
	x,
	### a vector
	
	w = rep(1, length(x))
	### vector of weights

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{ObjFct}}
) { 
	sum((w * x), na.rm=TRUE) / sum(w, na.rm=TRUE)
}, ex=function() {

x <- 1:5
mean(x)
MeanW(x, w=c(1, 1, 1, 2, 2))
})


VarW <- structure(function(
	##title<< 
	## Weighted variance
	##description<<
	## Compute the weighted variance.
	
	x,
	### a vector
	
	w = rep(1, length(x))
	### vector of weights

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{ObjFct}}
) { 
	xm <- MeanW(x, w)
	sum((x - xm)^2 * w, na.rm=TRUE) * (1 / (sum(w, na.rm=TRUE) - 1))
}, ex=function() {

x <- 1:5
var(x)
VarW(x, w=c(1, 1, 1, 2, 2))
})


SdW <- structure(function(
	##title<< 
	## Weighted standard deviation
	##description<<
	## Compute the standard deviation.
	
	x,
	### a vector
	
	w = rep(1, length(x))
	### vector of weights

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{ObjFct}}
) { 
	sqrt(VarW(x, w))
}, ex=function() {

x <- 1:5
sd(x)
SdW(x, w=c(1, 1, 1, 2, 2))
})


CorW <- structure(function(
	##title<< 
	## Weighted correlation
	##description<<
	## Compute the correlation.
	
	x,
	### a vector of x values
	
	y,
	### a vector of y values
	
	w = rep(1, length(x))
	### vector of weights

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{ObjFct}}
) { 
	d <- na.omit(cbind(as.vector(x), as.vector(y), as.vector(w)))
	if (nrow(d) == 0) return(as.numeric(NA))
	x <- cbind(d[,1], d[,2])
	wt <- d[,3]
	if (nrow(x) == 0) return(NA)
	cov.wt(x, wt, cor=TRUE)$cor[2,1]
}, ex=function() {

x <- 1:5
y <- x * -1 + rnorm(5)
cor(x, y)
CorW(x, y, w=c(1, 1, 1, 2, 2))
})

