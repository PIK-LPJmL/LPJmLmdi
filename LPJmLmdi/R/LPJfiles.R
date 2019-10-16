LPJfiles <- structure(function(
	##title<< 
	## Create an object of class 'LPJfiles'
	##description<<
	## The function creates a list of class 'LPJfiles' that defines all paths, input files, and configurations files for a LPJ run.
	
	path.lpj,
	### path where LPJ is installed
	
	path.tmp,
	### path for temporary outputs 
	
	path.out,
	### path for results
	
	sim.start.year,
	### start year of the LPJ simulation as defined in lpjml.conf
	
	sim.end.year=NA,
	### last year of the LPJ simulation as defined in lpjml.conf
	
	lpj.conf,
	### template for LPJ configuration file (create a template from lpjml.conf)
	
	param.conf,
	### template for parameter configuration file (create a template from param.conf)
	
	pft.par,
	### template file for PFT-specific parameters (create a template from pft.par)
	
	param.par,
	### template file for global parameters (create a template from param.par)
	
	input.conf,
	### template file for input data (create a template from input.conf)
	
	input,
	### a data.frame of LPJ input files with 2 columns. The first coumn defines the flag as in written in the input.conf template file and the second column the file name, e.g. data.frame(name=c("GRID_FILE", "TMP_FILE"), file=c("cru.grid", "temp.bin"))
	
	...
	### further arguments (currently not used)
		
	##details<<
	## No details.
	
	##references<< No reference.	
) {

	# make list of class LPJfiles
	lpjfiles <- list(
		path.lpj = path.lpj,
		path.tmp = path.tmp,
		path.out = path.out,
		sim.start.year = sim.start.year,
		sim.end.year = sim.end.year,
		lpj.conf = lpj.conf,
		param.conf = param.conf,
		pft.par = pft.par,
		param.par = param.par,
		input.conf = input.conf,
		input = input)
	class(lpjfiles) <- "LPJfiles"	
	
	# check if file exists
	files <- unlist(llply(lpjfiles, function(l) {
		if (is.character(l)) return(l)
		if (is.data.frame(l)) return(as.character(l$file))
	}))
	bool <- file.exists(files)
	if (any(!bool)) stop(paste(files[!bool], "does not exist."))
	
	return(lpjfiles)
})
