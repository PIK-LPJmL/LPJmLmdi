PlotWorld110 <- structure(function(
	##title<< 
	## Plot a world map based on 1:110Mio data

	admin=FALSE, 
	### Plot administrative boundaries?
	
	lakes=TRUE, 
	### Plot lakes?
	
	rivers=TRUE, 
	### Plot rivers?
	
	col=c("black", "blue", "red"), 
	### Colors for (1) coastlines, (2) rivers and (3) administrative boundaries
	
	bg=NA, 
	### background color, default: NA (no background)
	
	...
	### additional arguments to plot
) {
	data(data110) # loads coast110, land110, admin110, rivers110, lakes110
	
	plot(coast110, col=col[1], ...)
	if (!is.na(bg)) plot(land110, add=TRUE, col=bg)
	if (admin == TRUE) plot(admin110, border=col[3], add=TRUE)
	plot(coast110, col=col[1], add=TRUE)
	if (rivers == TRUE) plot(rivers110, col=col[2], add=TRUE)	
	if (lakes == TRUE) plot(lakes110, border=col[2], col="powderblue", add=TRUE)
}, ex=function(){

PlotWorld110()

})