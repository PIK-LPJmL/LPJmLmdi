ReadCLM <- structure(function(
	##title<< 
	## Read a CLM file to a SpatialPixelsDataFrame

	file.clm,
	### CLM file name with extension *.clm
	
	start=NA,
	### first year to be read
	
	end=NA,
	### last year to be read, reads until last year in case of NA
	
	start.year=NA,
	### first year in the dataset, read from header information in case NA
	
	grid=NULL,
	### a matrix of coordinates (lon, lat) if data should be read only for specific cells, if NULL the data for all grid cells is read
	
	nbands=NA,
	### number of bands per year, read from header information in case NA
	
	size=NA,
	### The number of bytes per element in the byte stream.
	
	file.grid=NA,
	### file name of the corresponding grid file
	
	endian.data=NA, 
	### endinaess of the data file
	
	endian.grid="big", 
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
	file.clm <- unlist(strsplit(file.clm, "/"))
	if (length(file.clm) > 1) {
		path.clm <- paste(file.clm[-length(file.clm)], collapse="/")
		file.clm <- file.clm[length(file.clm)]
	} else {
		path.clm <- getwd()
	}
	
	
	# read grid
	#----------
	
	setwd(path.clm)
	if (is.na(file.grid)) {
		file.grid <- c(paste0(file.clm, ".grid"), "cru.grid", "grid.bin")
		file.grid <- file.grid[file.exists(file.grid)][1]
		if (is.na(file.grid)) stop("Cannot find a grid file. Pleaseprovide a file name 'file.grid'.")
	}
	grid.data <- ReadGrid(file.grid, endian.grid)
	npixel <- nrow(grid.data)
	
	
	# get file information from header 
	#---------------------------------
	
	info <- InfoCLM(file.clm)
	offset <- info$headersize
	file.size <- info$file.size.real
	size.header.diff <- file.size - info$file.size.fromheader
	if (is.na(endian.data)) endian.data <- info$endian
	
	# return error if grid and data has a different number of pixels
	w1 <- FALSE
	if (npixel != info$ncell) {
		w1 <- TRUE
		warning(paste("Number of pixel in grid (n = ", npixel, ") is not equal to the number of pixel in the dataset (n = ", info$ncell, ").", sep=""))
		npixel <- info$ncell
	}	
	
	# check header: return error if header does not agree with file size and start.year, sizeof.data or nbands are not defined
	err1 <- "File has no or incorrect header. Please specifiy the number of bands (nbands), the first year in the data set (start.year) and size."
	# if ((abs(size.header.diff) > 1) & (is.na(nbands) | is.na(start.year) | is.na(size))) stop(err1)
	if ((offset == 0) & (is.na(nbands) | is.na(start.year) | is.na(size))) {
		stop(err1) 
	} else {
		start.year <- info$firstyear
		nyear <- info$nyear
		nbands <- info$nbands
		size <- info$size
	}
	
	
	# calculate start and end years to read the data
	#-----------------------------------------------
	
	if (is.na(start)) start <- start.year 
	if (start < start.year)	start <- start.year
	
	# read all years if grid cells area specified
	start0 <- start
	end0 <- end
	if (!is.null(grid)) {
		start <- start.year
		end <- start.year + nyear - 1
	}	
			
	# calculate first year to return based on start and end
	if (nyear > 1) {
		if (is.na(end)) end <- start.year + nyear - 1
		if (is.na(end0)) end0 <- start.year + nyear - 1
		nyear_first <- start - start.year
		nyear_plot <- end - start + 1 
		# create colnames (style: dYEAR-band, e.g. d2000-1)
		names <- NULL
		for (i in start:end) names <- c(names, paste("d", rep(i, nbands), "-", 1:nbands, sep=""))
		names0 <- NULL
		for (i in start0:end0) names0 <- c(names0, paste("d", rep(i, nbands), "-", 1:nbands, sep=""))
	} else {
		nyear_plot <- 1
		nyear_first <- start - start.year
		names <- 1:nbands
	}
	
	
	# read data for specific grid cells
	#----------------------------------
	
	if (!is.null(grid)) {
	
		# function to read data for specific grid cell
		.ReadXY <- function(xy) {
			# get position of cell in global grid
			cell.pos <- match(paste(xy[1], xy[2]), paste(grid.data[,1], grid.data[,2]))
		
			# calculate first position of cell in file
			skip <- offset + size.header.diff + (cell.pos - 1) * nbands * size
		
			# read cell values for each year
			x.all <- NA
			for (i in 1:nyear_plot) {
				if (i > 1) skip <- skip + (npixel * nbands * size)
			
				con <- file(file.clm, "rb")	
				seek(con, where=skip, origin="start", rw = "read")
				x <- readBin(con, data.type, n=(1 * 1 * nbands), size=size, endian=endian.data)
				close(con)
				x.all <- c(x.all, x)
			}
			x.all <- x.all[-1]
			return(x.all)
		}
	
		# read data
		data.sp <- as.data.frame(t(apply(grid, 1, .ReadXY)))
		data.sp <- data.sp[ ,match(names0, names)]
		colnames(data.sp) <- names0
		grid.data <- grid
		
	} else {
	
	# OR: read data for all grid cells
	#---------------------------------
	
		# read data
		con <- file(file.clm, "rb")
		skip <- nyear_first * nbands * npixel * size + offset + size.header.diff
			
		seek(con, where=skip, origin="start", rw = "read")
		# seek(con)
		
		# read desired data between start and end
		data <- 1:npixel
		for (i in 1:nyear_plot) {	# loop over single years
			x <- data.frame(matrix(
				readBin(con, data.type, n=(npixel * 1 * nbands), size=size, endian=endian.data), 
					nrow=npixel, ncol=(1 * nbands), byrow=TRUE))
					# summary(x)
			data <- cbind(data, x)
		}
		data.sp <- as.data.frame(data[,-1])
		close(con)
		colnames(data.sp) <- names
	}
	
	# return data as SpatialPixelsDataFrame
	if (w1 == FALSE) {
		ll <- CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0")
		data.sp <- SpatialPointsDataFrame(grid.data, data.sp, proj4string=ll)
	}
	# plot(raster(data.sp,1))
	setwd(wd)
	return(data.sp)
})