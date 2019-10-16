ReadLPJ2ts <- structure(function(
	##title<< 
	## Read a LPJ binary file and returns a spatial averaged time series
	##description<<
	## The function reads LPJ binary output files *.bin, aggregates (mean) the time series over all grid cells and returns the regional-averaged time series
		
	file.bin,
	### binary LPJ output file
	
	sim.start.year=1901,
	### first year of the simulation
	
	start=sim.start.year, 
	### first year to read
	
	end=NA, 
	### last year to read, reads until last year if NA
	
	...
	### further arguments (currently not used)
		
	##details<<
	## No details.
	
	##references<< No reference.
	
	##seealso<<
	## \code{\link{ReadLPJsim}}
	
) {
	info <- InfoLPJ(file.bin)
	var <- ReadLPJ(file.bin, sim.start.year=sim.start.year, start=start, end=end)@data

	monthly <- annual <- daily <- FALSE
	if (info$nbands == 365) {
		daily <- TRUE
		freq <- 365
	} else if (info$nbands == 12) {
		monthly <- TRUE
		freq <- 12
	} else if (info$nbands == 1) {
		annual <- TRUE
		freq <- 1
	} 
	
	if (file.bin == "fpc.bin" | file.bin == "waterstress.bin" | file.bin == "soilc_layer.bin" | file.bin == "cftfrac.bin" | file.bin == "pft_harvest.pft.bin") {
		freq <- 1
		npft <- info$nbands
		pft.names <- 1:npft
		if (file.bin == "fpc.bin" | file.bin == "cftfrac.bin") {
			if (npft == 10) pft.names <- c("TrBE", "TrBR", "TeNE", "TeBE", "TeBS", "BoNE", "BoBS", "BoNS", "TeH", "TrH")
			if (npft == 11) pft.names <- c("NatStand", "TrBE", "TrBR", "TeNE", "TeBE", "TeBS", "BoNE", "BoBS", "BoNS", "TeH", "TrH")
			if (npft == 12) pft.names <- c("NatStand", "TrBE", "TrBR", "TeNE", "TeBE", "TeBS", "BoNE", "BoBS", "BoNS", "TrH", "TeH", "PoH")
			if (npft == 13) pft.names <- c("TrBE", "TrBR", "TeNE", "TeBE", "TeBS", "BoNE", "BoBS", "BoNS", "TrH", "TrArH", "TeArH", "TeH", "PoH")
			if (npft == 14) pft.names <- c("NatStand", "TrBE", "TrBR", "TeNE", "TeBE", "TeBS", "BoNE", "BoBS", "BoNS", "TrH", "TrArH", "TeArH", "TeH", "PoH")
			if (npft != length(pft.names)) pft.names <- paste("PFT", 1:npft, sep="")
		}
		if (file.bin == "soilc_layer.bin") {
			pft.names <- 1:npft
		}
		fpc.ts <- unlist(colMeans(var, na.rm=TRUE))
		var.ts <- ts(fpc.ts[seq(1, length(fpc.ts), by=npft)], start=c(start))
		for (p in 2:npft) var.ts <- cbind(var.ts, ts(fpc.ts[seq(p, length(fpc.ts), by=npft)], start=c(start)))
		
		# calculate PFTs per grid cell
		if (file.bin == "fpc.bin" & any(grepl("NatStand", pft.names))) {
			var.ts[,2:ncol(var.ts)] <- var.ts[,2:ncol(var.ts)] * var.ts[,1]
			var.ts[var.ts < 0] <- 0
		}
		
		colnames(var.ts) <- pft.names
	} else {
		var.ts <- ts(colMeans(var, na.rm=TRUE), start=c(start, 1), freq=freq)
	}
	return(var.ts)
	### The function returns a time series of class 'ts'.
}, ex=function() {

# gpp <- ReadLPJ2ts("mgpp.bin")

})
