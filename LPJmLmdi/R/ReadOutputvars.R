ReadOutputvars <- structure(function(
	##title<< 
	## Read 'outputvars.par' to get information about LPJmL output
	##description<<
	## LPJmL output is defined in par/outputvars.par. This file contains for each variable the id, name, variable name, description, unit, and scale. This file can be used to correctly read LPJmL output. The function is for example used within \code{\link{ReadLPJsim}}.
		
	outputvars.par=NULL, 
	### path and file name to the LPJmL 'outputvars.par' file. If NULL the file is searched 1 level above or below the current working directory. 
		
	...
	### further arguments (currently not used)
		
	##details<<
	## No details.
	
	##references<< No reference.
	
	##seealso<<
	## \code{\link{ReadLPJsim}}
) {
	# search for file 'outputvars.par'
	wd <- getwd()
	if (is.null(outputvars.par)) {
		outputvars.par <- list.files(pattern="outputvars.par", recursive=TRUE)
		if (length(outputvars.par) == 0) {
			setwd("..")
			outputvars.par <- list.files(pattern="outputvars.par", recursive=TRUE)
		}
		if (length(outputvars.par) == 0) stop(paste0("File 'outputvars.par' does not exist within ", getwd(), ". Please provide the correct file name."))
	}
	
	# read file and skip first lines
	suppressWarnings(txt <- readLines(outputvars.par))
	txt <- txt[-c(1:(grep("GRID", txt)-1))]
	s <- strsplit(txt, "\"")[[1]]
	
	# convert to data.frame
	varinfo.df <- ldply(strsplit(txt, "\""), function(s) {
		if (length(s)==1) {
			df <- data.frame(id="COMMENT", name="", name2="", description="", unit="", scale=NA)
		} else {
			df <- data.frame(id=gsub(" ", "", s[1]), name=s[2], name2=s[4], description=s[6], unit=s[8], scale=as.numeric(s[9]))
		}
		return(df)
	})
	varinfo.df <- varinfo.df[-grep("COMMENT", varinfo.df$id),]
	
	setwd(wd)
	return(varinfo.df)
	### The function returns a time series of class 'ts'.
}, ex=function() {

# ReadOutputvars()

})
