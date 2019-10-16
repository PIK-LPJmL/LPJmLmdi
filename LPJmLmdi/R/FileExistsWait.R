FileExistsWait <- structure(function(
	##title<< 
	## Iterative checking and waiting for a file.
	##description<<
	## The function repeately checks if a file exists and returns TRUE if the file is existing.
	
	file, 
	### file for which checking and waiting should be applied
	
	waitmin=0, 
	### minimum waiting time (seconds) 
	
	waitinterval=0.5,
	### interval after which the existence of the file should be checked again (seconds)
	
	waitmax=2,
	### maximum waiting time (seconds)
	
	...
	### further arguments (currently not used)
		
	##details<<
	## No details.
	
	##references<< No reference.	
) {
	Sys.sleep(waitmin)	# minimum waiting time
	if (all(file.exists(file))) {
		return(TRUE)
	} else {
		# repeat checking and waiting for file
		n <- as.integer(waitmax / waitinterval)	# maximum number of iterations
		i <- 1
		while (any(!file.exists(file)) & i <= n) {
			Sys.sleep(waitinterval) 
			if (i == 1) message(paste(paste(file[!file.exists(file)], collapse=", "), "does not exist [waiting ...]", "\n"))
			i <- i + 1
		}
		if (all(file.exists(file))) {
			return(TRUE)
		} else {
			message(paste(paste(file[!file.exists(file)], collapse=", "), "does not exist after", waitmax+waitmin, "seconds. Waiting stopped.", "\n"))
			return(FALSE)
		}
	}
}, ex=function() {

FileExistsWait(system.file("external/rlogo.grd", package="raster"))
FileExistsWait("nofile.txt")

})	


