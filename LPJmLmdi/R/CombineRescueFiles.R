CombineRescueFiles <- structure(function(
	##title<< 
	## Combine single rescue files into one rescue file
	##description<<
	## Within OptimizeLPJgenoud, RunLPJ creates rescue file ("_.rescue0.RData") that save the parameter vectors and cost of each individual during optimization. These files allow to create restart files to restart OptimizeLPJgenoud (\code{\link{CreateRestartFromRescue}}). During OptimizeLPJgenoud many rescue files can be created. The function CombineRescueFiles reads the individual files, combines the rescue objects, saves it in one "rescue.RData" file, and deletes the single files.
	
	files.rescue,
	### file names
	
	remove = TRUE
	### save new rescue file and delete single rescue files?
			
	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{CreateRestartFromRescue}}, \code{\link{plot.rescue}}
) {
	res <- NULL
	
	if (length(files.rescue) > 1) {	
	# read multiple rescue files and combine in one file
		for (i in 1:length(files.rescue)) {
			load(files.rescue[i])
			if (!exists("rescue.all.l")) rescue.all.l <- rescue.l
			if (exists("rescue.all.l")) rescue.all.l <- c(rescue.all.l, rescue.l)
		}	
		rescue.l <- rescue.all.l
		rm(rescue.all.l)
		
	} else if (length(files.rescue) == 1) {
		# read single rescue file
		load(files.rescue)
	}
	
	# check rescue objects
	use.l <- llply(rescue.l, function(rescue.l) {
		# use only if cost indicates within boundary parameters
		use <- !is.null(rescue.l)
		if (use) use <- rescue.l$cost$total != 1e+20
		return(use)
	})
	rescue.l <- rescue.l[unlist(use.l)]
	
	# remove duplicates
	txt.l <- llply(rescue.l, function(rescue.l) {
		txt <- paste(round(c(rescue.l$cost$total, rescue.l$dpar), 12), collapse="-")
		return(txt)
	})
	rescue.l <- rescue.l[!duplicated(unlist(txt.l))]
	
	# remove duplicated priors
	r <- laply(rescue.l, function(l) length(l$dpar))
	rescue.l <- rescue.l[r == modal(r)]
	
	# save new rescue files and delete previous rescue files
	if (remove) {
		file.rescue <- paste(gsub(":", "-", gsub(" ", "_", as.character(Sys.time()))), "_CmbRscF-", length(rescue.l), "_", sep="")
		file.rescue <- tempfile(file.rescue, getwd(), fileext="_rescue.RData")
		save(rescue.l, file=file.rescue)
		file.remove(files.rescue)
	}
	
	class(rescue.l) <- "rescue"
	return(rescue.l)
	### The function returns a list of class "rescue", whereby each element corresponds to one individual of the genetic optimization with two entries: 'cost' (cost of the individual) and 'dpar' (parameter scaled relative to the prior parameter).
})
