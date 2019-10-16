CheckMemoryUsage <- structure(function(
	##title<< 
	## Check usage of memory by R objects
	##description<<
	## Prints a message about the used memory and writes a file with the used memory per each R object.
  
  ... 
  ### The function has no arguments.
  
  ##details<<
  ##  

) {	
	obj <- unique(c(ls(), ls(envir=.GlobalEnv)))
	siz <- sapply(obj, function(x){object.size(get(x))})
	siz <- sort(siz)
	use.df <- data.frame(obj=names(siz), byte=siz, GB=signif(siz*1e-9, 4))
	rownames(use.df) <- 1:nrow(use.df)
	write.table(use.df, file="memory_usage.txt")
	return(use.df)
	### a data.frame 
})
