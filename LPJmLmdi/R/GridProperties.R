GridProperties <- structure(function(
	##title<< 
	## Derive grid properties from an object of class 'LPJfiles'
	##description<<
	## The function reads the grid of the input files in 'LPJfiles' and computes the area per grid cell.
	
	lpjfiles,
	### list of class 'LPJinput'
	
	res = 0.5,
	### resolution of LPJmL
	
	...
	### further arguments (currently not used)
		
	##details<<
	## No details.
	
	##references<< No reference.

	##seealso<<
	## \code{\link{LPJfiles}}	
) {

	# is there already grid information
	has.grid <- !is.null(lpjfiles$grid)
	if (!has.grid) {
		grid.pos <- c(grep("grid", lpjfiles$input$name), grep("GRID", lpjfiles$input$name))
		file.grid <- as.character(lpjfiles$input$file[grid.pos])
		grid <- ReadGrid(file.grid)
		ll <- CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0")
		ncell <- nrow(grid)
		grid.sp <- SpatialPointsDataFrame(grid, data=data.frame(id=1:ncell), proj4string=ll)
		ext <- extent(grid.sp)
		res2 <- res / 2
		grid.r <- raster(xmn=ext@xmin-res2, xmx=ext@xmax+res2, ymn=ext@ymin-res2, ymx=ext@ymax+res2)
		res(grid.r) <- c(res, res)
		grid.r[] <- NA
		grid.r[cellFromXY(grid.r, grid)] <- 0:(ncell-1)
		area.r <- raster::area(grid.r)
		area.r <- mask(area.r, grid.r)
		grid <- list(grid=grid.r, area=area.r, ncell=nrow(grid))
	} else {
		grid <- lpjfiles$grid
	}
	return(grid)
	### the function returns a list with 'grid' (raster of grid cells), 'area' (vector of grid cell area) and 'ncell' (number of grid cells)
})