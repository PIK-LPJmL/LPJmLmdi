InfoCLM <- structure(function(
	##title<< 
	## Returns information about a CLM file

	file.clm,
	### CLM file name with extension *.clm
	
	endian="little",
	### endianess of the file
	
	...
	### Further arguments (currently not used).
	
	##details<<
	## No details.
	
	##references<< No reference.
	
	##seealso<<
	## \code{\link{WriteLPJinput}}
	
) {
	
	file.size <- file.info(file.clm)$size

	# get filename from first position
	file.f <- file(file.clm, "rb")
	name <- readBin(file.f, character(), n=1, size=1, endian=endian)[1]
	#close(file.f)
	
	# calculate length of name character string
	name <- gsub("\001", "", name)
	name <- gsub("\002", "", name)
	name <- gsub("\003", "", name)
	skip <- length(unlist(strsplit(name, ""))) * 1
	
	# initial estimate size of data
	size <- 4
	
	# read other header information
	if (skip == 0) {
		# return NA and set headersize to 0 if header does'nt exist
		x <- rep(NA, 10)
		headersize <- 0
	} else {
		# get other header information
		x <- readBin(file.f, integer(), n=7, size=size, endian=endian)
		# read header again if order value in the header is unrealistic: try natural size
		if ((x[2] > 2) | (x[2] < 1)) {
			seek(file.f, skip, origin="start", rw="r")
			x <- readBin(file.f, integer(), n=7, endian=endian)
		}
		headersize <- skip + 7 * size
	}
	close(file.f)
	
	# check if header information is consistent with file size and return warning
	if (headersize == 0) warning("File has no header.")
	
	# check if header information is valid - if not read file again with endian "big"
	if (x[6] > 70000) {
		info <- InfoCLM(file.clm, "big")
	} else {
	
		size <- (file.size - headersize) / x[4] / x[7] / x[6]
		size2 <- round(size)
		suppressWarnings(file.size.fromheader <- (headersize + x[4] * x[7] * x[6] * size2))
		if (is.na(file.size.fromheader)) file.size.fromheader <- file.size
		if (file.size.fromheader != file.size) warning("File size does not correspond to header information.")
		
		# return list with header and file information
		info <- list(filename=file.clm,
			name=name,
			version=x[1],
			order=x[2],
			firstyear=x[3],			
			nyear=x[4],
			firstcell=x[5],
			ncell=x[6],
			nbands=x[7],
			size=round(size),
			headersize=headersize,
			file.size.real=file.size,
			file.size.fromheader=file.size.fromheader,
			endian=endian
		)
	}

	return(info)
})