BreakColours <- BreakColors <- structure(function(
	##title<< 
	## Colours from class breaks
	##description<<
	## Creates colour palettes from a vector of class breaks
	
	x, 
	### numeric vector of class breaks
	
	pal = NULL,
	### name of a colour palette from \code{\link{brewer.pal}}
	
	rev = FALSE,
	### should the colour palette be reversed?
	
	cols = NULL,
	### alternatively, a colour vector to be interpolated
	
	...
	### Further arguments (unused)
	
	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{BreakColours}}
){
	if (is.null(pal)) {
	   if (any(x < 0) & any(x > 0)) {
	      pal <- "RdBu"
	   } else {
	      pal <- "OrRd"
	   }
	} 
  if (is.null(cols)) {
    suppressWarnings(cols <- brewer.pal(11, pal))
  }
  if (rev) cols <- rev(cols)
	.fun <- colorRampPalette(cols)
	cols <- .fun(length(x)-1)

	return(cols)
	### The function returns a vector of colours.
}, ex=function() {

brks1 <- seq(0, 10, 2)
cols1 <- BreakColours(brks1)

brks2 <- seq(-100, 100, 25)
cols2 <- BreakColours(brks2)

brks3 <- seq(-100, 100, 25)
cols3 <- BreakColours(brks3, pal="BrBG")

brks4 <- seq(0, 10, 1)
cols4 <- BreakColours(brks4, cols=c("red", "green", "blue"), rev=TRUE)

MapRb()
LegendBarRb(brks=brks1, cols=cols1)
LegendBarRb(brks=brks2, cols=cols2, pos="top", lon = c(-180, 180), lat = c(-20, -15))
LegendBarRb(brks=brks3, cols=cols3, pos="inside", lon = c(-180, 180), lat = c(15, 20))
LegendBarRb(brks=brks4, cols=cols4, pos="inside", lon = c(-180, 180), lat = c(30, 35))

})



