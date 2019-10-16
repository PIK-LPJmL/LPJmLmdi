ChangeSoilCodeFile <- structure(function(
	##title<< 
	## Change soil code in LPJ soil code file
	##description<<
	## The function changes the soil code for the specified grid cells and writes a new LPJ soil code file.
	
	file.soilcode, 
	### original soil code file
	
	file.soilcode.new, 
	### new soil code file
	
	xy, 
	### matrix of grid cells (lon, lat) where the soil code should be changed
	
	newcode, 
	### new soil code at each grid cell (vector with length = nrow(xy))
	
	file.grid="cru.grid",
	### grid file for the original soil code file
	
	...
	### further arguments (currently not used)
		
	##details<<
	## No details.
	
	##references<< No reference.
	
	##seealso<<
	## \code{\link{ReadBIN}}
) {


	# read soilcode file	
	data.sp <- ReadBIN(file.soilcode, file.grid=file.grid)
	grid <- ReadGrid(file.grid)
		
	# check which grid cells to change
	xy.all <- grid
	change <- NULL
	for (i in 1:nrow(xy)) {
		change <- c(change, intersect(which(xy[i,1] == xy.all[,1]), which(xy[i,2] == xy.all[,2])))
	}
	
	# change soilcode values
	if (length(change) > 0) {
		data.sp@data[change, ] <- newcode
		#plot(data.r)
	}
	
	# write new soilcode file
	WriteBIN(data.sp, file.soilcode.new)
})
	

       