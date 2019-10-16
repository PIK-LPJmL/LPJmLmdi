WriteLPJinput <- structure(function(
	##title<< 
	## Write an object of class 'LPJinput' to CLM files
	##description<<
	## The function writes CLM input files for LPJ. 
		
	lpjinput,
	### Object of class 'LPJinput' to be written.
	
	files=NULL,
	### names of the output CLM or binary files. 
	
	path.lpj=NULL,
	### path to LPJ installation
	
	...
	### further arguments (currently not used)
		
	##details<<
	## No details.
	
	##references<< No reference.
	
	##seealso<<
	## \code{\link{WriteLPJinput}}
	
) {
	
	# loop over datasets
	ndata <- length(lpjinput$data)
	res <- rep(FALSE, ndata)
	for (i in 1:ndata) {
	
		# get data information
		data.m <- lpjinput$data[[i]]$data
		nbands <- lpjinput$data[[i]]$nbands
		firstyear <- lpjinput$data[[i]]$firstyear
		fmt <- lpjinput$data[[i]]$fmt
		file.clm <- NULL
		if (is.null(file.clm)) file.clm <- files[i]
		if (is.null(file.clm)) file.clm <- lpjinput$data[[i]]$file.new
		if (is.null(file.clm)) stop("Provide file name for the output files.")
		
		# convert data to SpatialPointsDataFrame
		data.sp <- SpatialPointsDataFrame(lpjinput$grid, as.data.frame(data.m))

		# write CLM file and grid file
		if (fmt == "clm") {
			res[i] <- WriteCLM(data.sp, file.clm=file.clm, start=firstyear, nbands=nbands, size=2, path.lpj=path.lpj)	
		} else if (fmt == "bin") {
			res[i] <- WriteBIN(data.sp, file.bin=file.clm, nbands=nbands, size=1, path.lpj=path.lpj)	
		}
	}

	return(res)
	### The function returns TRUE if the CLM file was created.
}, ex=function() {

# lpjinput <- ReadLPJinput("cru_ts_3.20.1901.2011.tmp.clm", grid=cbind(c(136.75, 137.25, 160.75,168.75), c(45.25, 65.25, 68.75, 63.75)))
# str(lpjinput)
# WriteLPJinput(lpjinput)

})
