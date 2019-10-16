ReadPRO <- structure(function(
	##title<< 
	## Read *.pro files as produced from GENOUD
	##description<<
	## The function is used within OptimizeLPJgenoud
	
	files.pro
	### file names (*.pro) of genoud optimization results.
			
	##details<<
	## No details.
	
	##references<< No reference.	
) {
				
	# read all pro population files
	optim.df <- ldply(as.list(files.pro), function(file.pro) {
		if (file.info(file.pro)$size > 0) {
			m <- read.table(file.pro, comment.char='G')
			colnames(m) <- paste("X", 1:ncol(m))
			return(m)
		} else {
			return(NULL)
		}
	})
				
	# remove duplicates
	txt <- apply(optim.df, 1, function(x) {
		txt <- round(x[2:length(x)], 8)
		paste(x, collapse="-")
	})
	optim.df <- optim.df[!duplicated(txt), ]
	
	# remove out-of-range individuals
	use <- optim.df[,2] != 1e+20
	optim.df <- optim.df[use, ]
	
	return(optim.df)
	### The function returns a data.frame with number of individual, cost and parameer values
})
			
			
			