WriteCLM <- structure(function(
	##title<< 
	## Write a CLM file from SpatialPointsDataFrame
	##description<<
	## The function writes CLM files from a SpatialPointsDataFrame or SpatialPixelsDataFrame. The LPJmL program cru2clm needs to be installed.
	
	data.sp,
	### SpatialPointsDataFrame or SpatialPixelsDataFrame with data
	
	file.clm,
	### CLM file name with extension *.clm
	
	start,
	### integer. First year in data.
	
	nbands,
	### Number of bands per year.
	
	size=2, 
	### The number of bytes per element in the byte stream.
	
	scale=1, 
	### Scaling factor to be written to the header of the CLM file. The factor will be not applied to the data.
	
	na.replace=-9999,
	### integer to replace NA values.
	
	path.lpj=NULL,
	### path to LPJ installation
	
	res=0.5,
	### spatial resolution of the grid cells 
	
	...
	### Further arguments (currently not used).
	
	##details<<
	## No details.
	
	##references<< No reference.
	
	##seealso<<
	## \code{\link{WriteLPJinput}}
	
) {

	# check spatial temporal resolution
	coord <- coordinates(data.sp)
	ncell <- nrow(coord)
	data <- data.sp@data
	if (res != 0.5 & res != 0.25) stop(paste("res =", res, "is not supported from WriteCLM.R and lpj/src/utils/cru2clm*"))	
	if (nbands != 12 & nbands != 365 & nbands != 1) stop(paste("nbands =", nbands, "is not supported from WriteCLM.R and lpj/src/utils/cru2clm*"))
	
	# create directory
	wd0 <- getwd()
	s <- unlist(strsplit(file.clm, "/"))
	if (length(s) > 1) {
		path <- paste(s[-length(s)], collapse="/")
		if (!file.exists(path)) dir.create(path, recursive=TRUE)
		setwd(path)
		file.clm <- s[length(s)]
	}
	file.cru <- gsub(".clm", ".cru", file.clm)
	
	# if pixel px to write is NA, write all pixels
	px <- 1:ncell

	# create vectors of years and of bands in years
	nyear <- ncol(data) / nbands
		
	# write binary *.cru file
	con <- file(file.cru, "wb")	
	data.y <- as.matrix(data.sp@data)
	data.y <- as.vector(t(data.y))
	data.y[is.na(data.y)] <- na.replace
	if (size == 2) data.y[data.y > 32767] <- 32766	# set to maximum possible value if size==2
	data.y <- as.integer(round(data.y, 0))
	writeBin(data.y, con, size=size)
	close(con)	

	# convert binary file to clm file	
	cmd0 <- ""
	if (!is.null(path.lpj)) cmd0 <- paste0(path.lpj, "/bin/")
	cmd1 <- paste0(cmd0, "cru2clm")
	#if (res == 0.5 & nbands == 365) cmd1 <- paste0(cmd0, "cru2clm_0d50_daily")
	#if (res == 0.25 & nbands == 12) cmd1 <- paste0(cmd0, "cru2clm_0d25_monthly")
	#if (res == 0.25 & nbands == 365) cmd1 <- paste0(cmd0, "cru2clm_0d25_daily")
	
	cmd1 <- paste(cmd1, paste("-firstyear", start, "-nyear", nyear, "-nbands", nbands, "-ncell", ncell, "-scale", scale, file.cru, file.clm))
	cmd1 <- gsub("//", "/", cmd1)
	system(cmd1)	# runs only on unix system with compiled LPJ code
	
	cmd1 <- paste0(cmd0, paste("setclm order 1", file.clm))
	cmd1 <- gsub("//", "/", cmd1)
	system(cmd1)	# runs only on unix system with compiled LPJ code
	
	cmd1 <- paste0(cmd0, paste("setclm ncell", ncell, file.clm))
	cmd1 <- gsub("//", "/", cmd1)
	system(cmd1)	# runs only on unix system with compiled LPJ code

	# check CLM file
	cmd1 <- paste0(cmd0, paste("printclm -data", file.clm, ">", gsub(".clm", ".check.txt", file.clm)))
	cmd1 <- gsub("//", "/", cmd1)
	system(cmd1)
	
	# delete cru file
	file.remove(file.cru)	
	
	# write grid
	WriteGrid(coord, file.grid=paste0(file.clm, ".grid"))
	
	# x <- ReadCLM(file.clm)
	# plot(raster(x, 1))

	return(file.exists(file.clm))
	### The function returns TRUE if the CLM file was created.
}, ex=function(){

# data.sp <- SpatialPointsDataFrame(lpjinput$grid, as.data.frame(data.m))
# WriteCLM(data.sp, file="data.clm", start=1901, nbands=12, size=2)	

})






	

