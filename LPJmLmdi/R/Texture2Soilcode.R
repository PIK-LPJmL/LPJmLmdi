Texture2Soilcode <- structure(function(
	##title<< 
	## Convert soil texture to a LPJ soilcode
	##description<<
	## The function takes fractions/percentages of sand, silt and clay and returns the correspondign LPJ soil code. The USDA soil classification is used. The function requires the package "soiltexture".
	
	sand,
	### percentage of sand
	
	silt, 
	### percentage of silt
	
	clay, 
	### percentage of clay
	
	lpj.soilcodes = c("Cl", "SiCl", "SaCl", "ClLo", "SiClLo", "SaClLo", "Lo", "SiLo", "SaLo", "Si", "LoSa", "Sa"), 
	### LPJ soil codes
	
	plot=TRUE,
	### plot soil triangle?
		
	...
	### Further arguments (currently not used).
	
	##details<<
	## No details.
	
	##references<< No reference.
	
	##seealso<<
	## \code{\link{ReadBIN}}
	
) {
	# soil type
	require(soiltexture)
	texture <- data.frame(CLAY=clay, SILT=silt, SAND=sand)
	texture <- texture / rowSums(texture) * 100

	# get soil type of the side
	if (plot) TT.plot(class.sys = "USDA.TT", tri.data=texture, col="red")
	soil.type <- TT.points.in.classes(texture, class.sys = "USDA.TT")
	soil.type

	# LPJ soil code
	soilcode <- match(colnames(soil.type)[apply(soil.type, 1, which.max)], lpj.soilcodes)
	return(soilcode)
	### The function returns the LPJ soilcode
}, ex=function(){

# data.sp <- SpatialPointsDataFrame(lpjinput$grid, as.data.frame(data.m))
# WriteBIN(data.sp, file="data.bin")	

})
