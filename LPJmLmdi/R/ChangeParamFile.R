ChangeParamFile <- structure(function(
	##title<< 
	## Change parameters in a parameter file
	##description<<
	## The function writes values to a parameter file. It requires a 'file.template' in which the positions of the new parameter values are marked with a flag. For example, instead of a parameter of 0.5 for alphaa in a parameter file the flag ALPHAA is written. The function substitutes this flag with the new parameter value in a new file 'file.new'.
	
	newpar, 
	### a named vector with new parameter values
	
	file.template, 
	### file name of the template parameter with flagged parameters
	
	file.new, 
	### file name of the new parameter file
	
	wait=FALSE,
	### If TRUE wait 1 second to check if file.template exists in order to relax slow file writting.

	...
	### further arguments (currently not used)
		
	##details<<
	## The function works only on Unix systems because it is based on 'sed'
	
	##references<< No reference.

) {

	if (wait) {
		check <- FileExistsWait(file.template, waitmin=0, waitinterval=0.5, waitmax=1)
		if (!check) stop(paste(file.template, "does not exist after waiting.", file.new, "is not produced."))
	}
		
	if (length(newpar) == 1) {
		sed <- paste("sed 's;", names(newpar), ";", newpar, ";g' ", file.template, " > ", file.new,
		sep="")
	} else {
		sed <- paste("sed -e", paste(paste("'s;", names(newpar), ";", newpar, ";'", sep=""), collapse=" -e"), "<", file.template, ">", file.new)
	}
	#sed
	system(sed)
}, ex=function() {

# newpar <- c(ALPHAA_BoNE=0.8)
# LPJChangeParamFile(newpar, file.template="pft_template.par", file.new="pft.par")

})





