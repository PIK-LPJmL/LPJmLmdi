WriteBIN <- structure(function(
	##title<< 
	## Write a BIN file from SpatialPointsDataFrame
	##description<<
	## The function writes BIN files from a SpatialPointsDataFrame or SpatialPixelsDataFrame. 
	
	data.sp,
	### SpatialPointsDataFrame or SpatialPixelsDataFrame with data
	
	file.bin,
	### binary file name with extension *.bin
		
	size=1, 
	### The number of bytes per element in the byte stream.
		
	...
	### Further arguments (currently not used).
	
	##details<<
	## No details.
	
	##references<< No reference.
	
	##seealso<<
	## \code{\link{ReadBIN}}
	
) {
	# write binary file
	con <- file(file.bin, "wb")	
	writeBin(as.integer(unlist(data.sp@data)), file.bin, size=size)
	close(con)	
	
	# write grid
	file.grid <- gsub(".bin", ".grid", file.bin)
	WriteGrid(coordinates(data.sp), file.grid=file.grid)

	return(file.exists(file.bin))
	### The function returns TRUE if the CLM file was created.
}, ex=function(){

# data.sp <- SpatialPointsDataFrame(lpjinput$grid, as.data.frame(data.m))
# WriteBIN(data.sp, file="data.bin")	

})
