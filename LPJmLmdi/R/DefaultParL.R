DefaultParL <- structure(function(
	##title<< 
	## default 'par' settings for plots
	##description<<
	## The function calls 'par' with some default settings to improve plots. See \code{\link{par}} for details.
	
	mfrow=c(1,1), 
	### number of rows/columns
	
	mar=c(3.7, 3.5, 2.5, 0.5), 
	### margins
	
	oma=c(0.8, 0.1, 0.1, 0.2), 
	### outer margins
	
	mgp=c(2.4, 1, 0),
	### margin line for axis title, label and lines
    
	cex=1.3, 
	### text and symbol size
	
	cex.lab=cex*1.1, 
	### label size
	
	cex.axis=cex*1.1,
	### axis anootation size	
	
	cex.main=cex*1.1, 
	### title size
	
	...
	### further arguments to \code{\link{par}}
		
	##details<<
	## No details.
	
	##references<< No reference.
	
	##seealso<<
	## \code{\link{par}}
	
) {
	par(mfrow=mfrow, mar=mar, mgp=mgp, cex.lab=cex.lab, cex.axis=cex.axis, cex.main=cex.main, oma=oma, ...)
	
}, ex=function() {

DefaultParL()
plot(1:10)

})	