ReadBIN <- structure(function(
	##title<< 
	## Read simple binary files without header
	##description<<
	## The function is used to read for example the soil*.bin and drainclass.bin files
	##title<< 
	## Read a CLM file to a SpatialPixelsDataFrame

	file.bin,
	### binary file name with extension *.bin
		
	nbands=1,
	### number of bands per year
	
	size=1,
	### The number of bytes per element in the byte stream.
	
	file.grid=NA,
	### file name of the corresponding grid file
	
	endian.data="little", 
	### endinaess of the data file
	
	endian.grid="little", 
	### endianess of the grid file
	
	data.type=integer(),
	### type of the data
	
	...
	### Further arguments (currently not used).
	
	##details<<
	## No details.
	
	##references<< No reference.
	
	##seealso<<
	## \code{\link{WriteCLM}}
	
) {
	
	# get path and file name
	wd <- getwd()
	file.bin <- unlist(strsplit(file.bin, "/"))
	if (length(file.bin) > 1) {
		path.bin <- paste(file.bin[-length(file.bin)], collapse="/")
		file.bin <- file.bin[length(file.bin)]
		setwd(path.bin)
	} 
	
	# read CRU grid
	if (is.na(file.grid)) {
		file.grid <- c(gsub(".bin", ".grid", file.bin), "cru.grid", "grid.bin")
		file.grid <- file.grid[file.exists(file.grid)][1]
		if (is.na(file.grid)) stop("Cannot find a grid file. Please provide a file name 'file.grid'.")
	}
	grid.data <- ReadGrid(file.grid, endian.grid)
	npixel <- nrow(grid.data)
	
	# read soilcode file	
	con <- file(file.bin, "rb")	
	x <- readBin(con, data.type, n=(npixel * 1 * nbands), size=size, endian=endian.data)
	close(con)
	
	# data.sp <- try(SpatialPixelsDataFrame(grid.data, data=data.frame(x), proj4string=CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"), tolerance=0.5), silent=TRUE)
	# if (class(data.sp) == "try-error") data.sp <- SpatialPointsDataFrame(grid.data, data=data.frame(x), proj4string=CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"))
	data.sp <- SpatialPointsDataFrame(grid.data, data=data.frame(x), proj4string=CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"))
	
	setwd(wd)
	return(data.sp)
}, ex=function() {

# ReadBIN("soil_new_67420.bin")

})
	

       