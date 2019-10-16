ReadLPJ <- structure(function(
	##title<< 
	## Read a LPJ binary file
	##description<<
	## The function reads a binary LPJ output file and returns a SpatialPointsDataFrame
	
	file.bin, 
	### binary LPJ output file
	
	file.grid="grid.bin", 
	### binary LPJ grid file
	
	sim.start.year=1901, 
	### first year of the simulation
	
	start=sim.start.year, 
	### first year to read
	
	end=NA, 
	### last year to read, reads until last year if NA
	
	file.annual=c("vegc.bin", "litc.bin", "soilc.bin"), 
	### one of the binary LPJ output files with annual data
	
	size=4, 
	### the number of bytes per element in the byte stream.
	
	data.type=numeric(),
	### data type of the file (default=numeric())
	
	endian="little",
	### endianess of the binary file
	
	...
	### further arguments (currently not used)
		
	##details<<
	## No details.
	
	##references<< No reference.
	
	##seealso<<
	## \code{\link{ReadLPJsim}}
	
) {
	# get information about file
	info <- InfoLPJ(file.bin=file.bin, file.grid=file.grid, file.annual=file.annual, size=size, data.type=data.type)
	if (is.null(info)) return(NULL)
	npixel <- info$npixel				# number of pixels from grid file
	nyear <- info$nyear				# number of years from vegc file
	nbands <- info$nbands				# number of bands
	
	# get end year if it is NA and get number of years
	if (is.na(end)) end <- sim.start.year + nyear - 1
	nyear_first <- start - sim.start.year		# number of years between simulation start and desired end
	nyear_plot <- end - start + 1 			# number of years to return (between start and end)

	# terminate function if resulting object will be too large
	#if (npixel * nbands * nyear_plot > 23679600) return(stop("Object will be to large! Select a shorter time span."))
	
	# open data file connection
	con <- file(file.bin, "rb")

	# skip first years (sim.start.year to start)
	skip <- nyear_first * nbands * npixel * size
	seek(con, where = skip, origin = "start", rw = "read")
		
	# read desired data between start and end
	data <- data.frame(matrix(
		x <- readBin(con, data.type, n=(npixel * nyear_plot * nbands), size=size, endian=endian), 
			nrow=npixel, ncol=(nyear_plot * nbands), byrow=FALSE))
	close(con)

	# create colnames (style: dYEAR-band, e.g. d2000-1)
	names <- NULL
	for (i in start:end) names <- c(names, paste("d", rep(i, nbands), "-", 1:nbands, sep=""))
	colnames(data) <- names

	# convert data to SpatialPixelsDataFrame and return
	proj <- CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0")
	data.sp <- SpatialPointsDataFrame(info$grid, data, proj4string=proj)
	return(data.sp)
	### The function returns a SpatialPointsDataFrame.
}, ex=function() {

# ReadLPJ("mgpp.bin", start=1982, end=2011)

})






