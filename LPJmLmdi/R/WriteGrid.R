WriteGrid <- structure(function(
	##title<< 
	## Write a *.grid file from a matrix of coordiantes or a SpatialPointsDataFrame
	##description<<
	## Writes a grid file for LPJ input data. The functions needs the LPJmL module txt2grid to be installed.
	
	grid,
	### SpatialPointsDataFrame; SpatialPixelsDataFrame, matrix or data.frame with coordinates
	
	file.grid,
	### Grid file name
	
	...
	### Further arguments (currently not used).
	
	##details<<
	## No details.
	
	##references<< No reference.
	
	##seealso<<
	## \code{\link{WriteLPJinput}}
	
) {
	
	if (!is.matrix(grid) | !is.data.frame(grid)) grid <- coordinates(grid)
	file.grid.txt <- paste0(file.grid, ".txt")

	# write grid as txt file
	grid.df <- data.frame(Id=1:nrow(grid), Lon=grid[,1], Lat=grid[,2])
	write.table(grid.df, file=file.grid.txt, sep=",", row.names=FALSE)

	# write grid as binary file
	cmd <- paste("txt2grid", file.grid.txt, file.grid)
	system(cmd)
	file.remove(file.grid.txt)
	return(file.exists(file.grid))
	### The function returns TRUE if the grid file was created.
}, ex=function(){

lon <- c(59.75, 68.25)
lat <- c(61.25, 65.75)
WriteGrid(cbind(lon, lat), "test.grid")

})






	

