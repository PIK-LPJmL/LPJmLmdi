InfoLPJ <- structure(function(
	##title<< 
	## Information about a LPJmL binary file
	##description<<
	## The function reads information about a LPJ binary output file.
	
	file.bin="fpc.bin", 
	### binary LPJ output file
	
	file.grid="grid.bin", 
	### binary LPJ grid file
	
	file.annual=c("vegc.bin", "litc.bin", "soilc.bin"), 
	### one of the binary LPJ output files with annual data
	
	size=4, 
	### the number of bytes per element in the byte stream.
	
	data.type=numeric(),
	### data type of the file (default=numeric())

	...
	### further arguments (currently not used)
		
	##details<<
	## No details.
	
	##references<< No reference.
	
	##seealso<<
	## \code{\link{ReadLPJ}}
	
) {
	
	check <- FileExistsWait(c(file.bin, file.grid), waitmin=0, waitinterval=0.5, waitmax=1)
	if (any(!check)) return(NULL)
	
	# get number of pixels from grid file
	npixel <- file.info(file.grid)$size / size

	# read grid - get coordinates
	grid.fn <- file(file.grid, "rb")
	grid.data <- matrix(readBin(grid.fn, integer(), n=npixel*2, size=2), ncol=2, byrow=TRUE) / 100
	close(grid.fn)
	ext <- extent(min(grid.data[,1]), max(grid.data[,1]), min(grid.data[,2]), max(grid.data[,2]))

	# get number of years from vegc file
	file.annual.exists <- file.exists(file.annual)
	if (all(!file.annual.exists)) stop("One of the files lic.bin, soilc.bin or vegc.bin should exists.")
	file.annual <- file.annual[file.annual.exists][1]	
	nyear <- file.info(file.annual)$size / size / npixel

	# get number of bands from file
	nbands <- file.info(file.bin)$size / size / npixel / nyear

	info <- list(
		grid = grid.data,
		filename=file.bin,
		npixel=npixel,
		nyear=nyear,
		nbands=nbands,
		extent=ext
	)
	return(info)
	### The function returns a list with information about the LPJ binary file (number of grid cells, number of years, number of bands, spatial extent).
}, ex=function() {

# InfoLPJ("vegc.bin")

})
