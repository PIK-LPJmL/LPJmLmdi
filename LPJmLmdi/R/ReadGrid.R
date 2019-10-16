ReadGrid <- structure(function(
	##title<< 
	## Reads a binary input data grid file.

	file.grid="cru.grid",
	### CLM file name with extension *.clm
	
	endian="little",
	### endianess of the file
	
	...
	### Further arguments (currently not used).
	
	##details<<
	## No details.
	
	##references<< No reference.
	
	##seealso<<
	## \code{\link{ReadCLM}}
	
) {
	is.ok <- FALSE # flag to check if grid is OK (no lat > 90 | < 90)
	iter <- 1
	while (!is.ok & iter <= 2) {

		# open file
		con <- file(file.grid, "rb")

		# get filetype name
		name <- readBin(con, character(), n=1, size=1, endian=endian)

		# skip/read header information - depending on file type version
		if (name == "LPJGRID") { # old LPJGRID files
			close(con)
			con <- file(file.grid, "rb")
			seek(con, where=15, origin = "start", rw = "read")
		} else if (name == "LPJGRID\001") { # new LPJGRID files V1
			x <- readBin(con, integer(), n=15, size=2, endian=endian)
		} else if (name == "LPJGRID\002") { # new LPJGRID files V2
			x <- readBin(con, integer(), n=17, size=2, endian=endian)
		} else if (name == "LPJGRID\003") { # new LPJGRID files V3
		  x <- readBin(con, integer(), n=21, size=2, endian=endian)
		} else {
			stop(paste(file.grid, "is no valid LPJGRID file."))
		}

		# read data
		grid <- readBin(con, integer(), n=(300000*2), size=2, endian=endian) 
		grid <- data.frame(matrix(grid/100, ncol=2, byrow=TRUE))
		close(con)
		
		# check grid - and swap endianness
		if (max(grid[,2]) > 90 | min(grid[,2]) < -90) {
			is.ok <- FALSE
			if (endian == "little") {
				endian <- "big"
			} else {
				endian <- "little"
			}
			iter <- iter + 1
		} else {
			is.ok <- TRUE
		}
		if (iter > 2) warning(paste("Coordinates in", file.grid, "might be wrong. Please check."))
	}
	return(grid)
})