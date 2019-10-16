ReadLPJinput <- structure(function(
	##title<< 
	## Read and subset CLM files to LPJinput objects
	##description<<
	## The functions reads a CLM file, selects the data according to the provided grid and returns an object of class LPJinput. 
	
	files, 
	### character vector of CLM or binary file names
	
	grid=NULL,
	### Matrix of grid cells with 2 columns: longitude and latitude (optional). If NULL the data is returned for the grid of the first CLM file. If a grid is provided the data is subesetted for the specified grid cells.
	
	start=NA,
	### first year to read
	
	...
	### Further arguments to ReadCLM or ReadBIN
	
	##details<<
	## No details.
	
	##references<< No reference.
	
	##seealso<<
	## \code{\link{WriteLPJinput}}
	
) {
	
	# loop over files
	lpjinput <- NULL
	for (i in 1:length(files)) {
		file.clm <- files[i]
		if (!file.exists(file.clm)) stop(paste(file.clm, "does not exists."))
		
		
		# read CLM or BIN data
		#---------------------
		
		fmt <- unlist(strsplit(file.clm, ".", fixed=TRUE))
		fmt <- fmt[length(fmt)]
		
		pyear <- start
		
		if (fmt == "bin") {
			data.sp <- ReadBIN(file.clm, ...)
			info <- list(filename=file.clm, firstyear=NA, nyear=NA,	nbands=1)
		} else if (fmt == "clm") {
			info <- InfoCLM(file.clm)
			data.sp <- ReadCLM(file.clm, grid=grid, start=start, ...)
			if (is.na(start)) {
				pyear <- info$firstyear
			} else {
				pyear <- start
			}
		} else {
			stop(paste(fmt, "is not implemented in ReadLPJinput as format for LPJ input data."))
		}
		grid0 <- coordinates(data.sp)
		
		
		# select grid cells from data
		#----------------------------
		
		if (!is.null(grid)) {
			# grid as text
			grid1.txt <- paste(grid[,1], grid[,2])
			grid0.txt <- paste(grid0[,1], grid0[,2])
			m <- match(grid1.txt, grid0.txt)
			data.m <- as.matrix(data.sp@data[m, ])
		} else {
			data.m <- as.matrix(data.sp@data)
			grid <- coordinates(data.sp)
		}


		# create object of class lpjinput
		#--------------------------------

		# new data set
		data.l <- list(
			file.orig = info$filename,
			file.new = NA,
			firstyear = pyear,
			nyear = info$nyear,
			nbands = info$nbands,
			fmt = fmt,
			data = data.m
		)

		# create new or add to existing lpjinput
		if (is.null(lpjinput)) { # make new lpjinput
			lpjinput <- list(
				grid = grid,
				data = list(data.l)
			)
			class(lpjinput) <- "LPJinput"
		} else {
			ndata <- length(lpjinput$data)
			lpjinput$data[[ndata+1]] <- data.l
		}
	}
	return(lpjinput)
	### The function returns a list of class "LPJinput".
}, ex=function(){

# lpjinput <- ReadLPJinput("cru_ts_3.20.1901.2011.tmp.clm", grid=cbind(c(136.75, 137.25, 160.75,168.75), c(45.25, 65.25, 68.75, 63.75)))
# str(lpjinput)

})