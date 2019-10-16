LPJppNBP <- structure(function(
   ##title<< 
   ## Post-process LPJmL model output: calculate NEE
   ##description<<
   ## The function calculates NEE from LPJmL model output

   path, 
   ### directory with LPJmL outputs in *.bin format
   
   start=1982, 
   ### first year for which the data should be converted to NetCDF
   
   end=2011, 
   ### last year for which the data should be converted to NetCDF
   
   sim.start.year=1901,
   ### first year of the simulation
		
	...
	### further arguments (currently not used)
		
	##details<<
	## 
	
	##references<< No reference.	
) {
   
	# input files
	file.rh <- "mrh.bin"
	file.fire <- "mfirec.bin"
	file.npp <- "mnpp.bin"
	file.estab <- "flux_estab.bin"
	file.harvest <- "flux_harvest.bin"
	file.gpp <- "mgpp.bin"


	# read data
	#----------
	
	time <- seq(as.Date(paste(start, "-01-01", sep="")), as.Date(paste(end, "-12-01", sep="")), by="month")

	# read NPP, Rh and establishment flux
	setwd(path)
	rh.sp <- ReadLPJ(file.rh, sim.start.year=sim.start.year, start=start, end=end)
	npp.sp <- ReadLPJ(file.npp, sim.start.year=sim.start.year, start=start, end=end)
	gpp.sp <- ReadLPJ(file.gpp, sim.start.year=sim.start.year, start=start, end=end)
	estab.sp <- ReadLPJ(file.estab, sim.start.year=sim.start.year, start=start, end=end)
	
	# read or creaty empty fire flux in case of simulation without fire
	if (file.exists(file.fire)) {
		fire.sp <- ReadLPJ(file.fire, sim.start.year=sim.start.year, start=start, end=end)
	} else {
		fire.sp <- npp.sp
		fire.sp@data <- as.data.frame(matrix(0, ncol=ncol(fire.sp@data), nrow=nrow(fire.sp@data)))
	}
	
	# read harvest flux or create empty harvest flux in case of simulation without land use
	if (file.exists(file.harvest)) {
		harvest.sp <- ReadLPJ(file.harvest, sim.start.year=sim.start.year, start=start, end=end)
	} else {
		harvest.sp <- estab.sp
		harvest.sp@data <- as.data.frame(matrix(0, ncol=ncol(harvest.sp@data), nrow=nrow(harvest.sp@data)))
	}	
	

	# interpolate estab and harvest to monthly data
	#----------------------------------------------

	InterpolateMonthly <- function(sp) {
		m <- sp@data
		mnew <- matrix(NA, ncol=1, nrow=nrow(m))
		for (i in 1:ncol(m)) {
			mnew <- cbind(mnew, matrix(rep(m[,i], each=12), ncol=12, nrow=nrow(m), byrow=TRUE))
		}
		mnew <- mnew[, -1]
		mnew <- mnew / 12 # distribute among months
		sp2 <- sp
		sp2@data <- as.data.frame(mnew)
		colnames(sp2@data) <- colnames(npp.sp@data)
		return(sp2)
	}

	estab.m.sp <- InterpolateMonthly(estab.sp)
	harvest.m.sp <- InterpolateMonthly(harvest.sp)


	# calculate NBP and NEE
	#----------------------

	# calculate NBP
	nbp.sp <- rh.sp
	nbp.sp@data <- rh.sp@data + fire.sp@data + harvest.m.sp@data - (npp.sp@data + estab.m.sp@data)
	nbp.rb <- brick(as(nbp.sp, "SpatialPixelsDataFrame"))
	WriteNCDF4(list(nbp.rb), "NBP", "gC m-2", "Net biome productivity", time=time, data.name="LPJmL", overwrite=TRUE)


})


