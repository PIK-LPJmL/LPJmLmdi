WriteLPJpar <- structure(function(
	##title<< 
	## Writes an object of class 'LPJpar' as parameter file or table.
	##description<<
	## The function takes a 'LPJpar' object and writes 1) LPJ parameter files and 2) write *.txt files with parameter values in a table format.
	
	x,
	### object of class 'LPJpar'
	
	file = "LPJpar",
	### basic file name for all output files, e.g. name of the optimization experiment
	
	pft.par=NULL,
	### template file for PFT-specific parameters (create a template from pft.par). If NULL, parameter files will be not written but only parameter tables.
	
	param.par=NULL,
	### template file for global parameters (create a template from param.par). If NULL, parameter files will be not written but only parameter tables.
	
	param.only=TRUE,
	### write only parameters to table (TRUE) or also parameter prior ranges (FALSE)?
	
	...
	### further arguments for CheckLPJpar
		
	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{LPJpar}}, \code{\link{CheckLPJpar}}	
) {

	file.pftpar.prior <- file.pftpar.best <- file.pftpar.median <- file.parampar.prior <- file.parampar.best <- file.parampar.median <- file.tab.prior <- file.tab.best <- file.tab.median <- NA
	has.best <- !is.null(x$best)
	has.median <- !is.null(x$best.median)
	
	
	# write PFT-specific parameter files
	#-----------------------------------
	
	if (!is.null(pft.par)) {

		# prior parameter
		file.pftpar.prior <- paste0(file, "_prior_pft.js")
		ChangeParamFile(x$prior, pft.par, file.pftpar.prior) 
		
		# posterior best
		if (has.best) {
			file.pftpar.best <- paste0(file, "_best_pft.js")
			ChangeParamFile(x$best, pft.par, file.pftpar.best) 		
		}

		# posterior best median
		if (has.median) {
			file.pftpar.median <- paste0(file, "_median_pft.js")
			ChangeParamFile(x$best.median, pft.par, file.pftpar.median) 		
		}			
	}
	
	
	# write global parameter files
	#-----------------------------
	
	if (!is.null(param.par)) {
		
		# prior parameter
		file.parampar.prior <- paste0(file, "_prior_param.js")
		ChangeParamFile(x$prior[!x$pftspecif], param.par, file.parampar.prior) 
		
		# posterior best
		if (has.best) {
			file.parampar.best <- paste0(file, "_best_param.js")
			ChangeParamFile(x$best[!x$pftspecif], param.par, file.parampar.best) 		
		}	
		
		# posterior best median
		if (has.median) {
			file.parampar.median <- paste0(file, "_median_param.js")
			ChangeParamFile(x$best.median[!x$pftspecif], param.par, file.parampar.median) 		
		}	
	}
		
	
	# write parameter tables
	#-----------------------
	
	# get unique PFT names
	txt.l <- strsplit(as.character(x$names[x$pftspecif]), "_")
	pfts <- c(unique(unlist(llply(txt.l, function(txt) txt[length(txt)]))), "global")
	
	# get unique parameter names
	params <- unique(x$names)
	for (i in 1:length(pfts)) params <- gsub(paste("_", pfts[i], sep=""), "", params)
	params <- unique(params)

	# initialize table
	table.prior.df <- table.best.df <- table.median.df <- data.frame(parameter=params, matrix(NA, ncol=length(pfts), nrow=length(params)))
	colnames(table.prior.df) <- colnames(table.best.df) <- colnames(table.median.df) <- c("parameter", as.character(pfts))

	# fill table with parameter values
	for (i in 1:length(x$names)) {
		# get parameter and name of the PFT
		param <- as.character(x$names[i])
		param <- unlist(strsplit(param, "_"))
		if (length(param) > 1) {
			pft <- param[length(param)]
			param <- param[-length(param)]
			param <- paste(param, collapse="_")
			prior <- x$prior[i]
			if (has.best) best <- x$best[i]
			if (has.median) med <- x$best.median[i]
			prior.rge <- paste("(", paste(signif(c(x$lower[i], x$upper[i]), 3), collapse="-"), ")", sep="")
			if (!param.only) {
				prior <- paste(as.character(signif(prior, 3)), prior.rge)
				# best <- paste(as.character(signif(best, 3)), rge)
			}
		} else {
			pft <- "global"
		}
		
		# copy parameter value into table
		table.prior.df[grep(param, table.prior.df$parameter), grep(pft, colnames(table.prior.df))] <- round(prior, 3)
		if (has.best) table.best.df[grep(param, table.best.df$parameter), grep(pft, colnames(table.best.df))] <- round(best, 3)
		if (has.median) table.median.df[grep(param, table.median.df$parameter), grep(pft, colnames(table.median.df))] <- round(med, 3)
	}
	
	file.tab.prior <- paste0(file, "_table_prior.txt")
	write.table(table.prior.df, file=file.tab.prior, row.names=FALSE)
	if (has.best) {
		file.tab.best <- paste0(file, "_table_best.txt")
		write.table(table.best.df, file=file.tab.best, row.names=FALSE)
	}
	if (has.median) {
		file.tab.median <- paste0(file, "_table_median.txt")
		write.table(table.median.df, file=file.tab.median, row.names=FALSE)
	}
	
	result <- data.frame(
		file = c(file.pftpar.prior, file.pftpar.best, file.pftpar.median, file.parampar.prior, file.parampar.best, file.parampar.median, file.tab.prior, file.tab.best, file.tab.median),
		description = c("LPJmL PFT prior parameter file", "LPJmL PFT best posterior parameter file", "LPJmL PFT median of best posterior parameter file", "LPJmL global prior parameter file", "LPJmL global best posterior parameter file", "LPJmL global median of best posterior parameter file", "Prior parameter table", "Best posterior parameter table", "Median of best posterior parameter table"))
	result <- na.omit(result)
	return(result)
	### The function returns a data.frame with an overview of the written files
})


