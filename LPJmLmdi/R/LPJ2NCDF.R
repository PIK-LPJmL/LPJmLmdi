LPJ2NCDF <- structure(function(
   ##title<< 
   ## Convert binary LPJmL model output files to NetCDF
   ##description<<
   ## The function converts a binary LPJmL output file to NetCDF 

   file, 
   ### file name of LPJmL model output, e.g. "mgpp.bin"
   
   var.name,
   ### variable name, e.g. "GPP"
   
   var.unit,
   ### variable unit, e.g. "gC m-2 mon-1"
   
   start=1982, 
   ### first year for which the data should be converted to NetCDF
   
   end=2011, 
   ### last year for which the data should be converted to NetCDF
   
   sim.start.year=1901,
   ### first year of the simulation
   
   var.longname = var.name,
   ### long variable name, e.g. "gross primary production"
   
   run.name="LPJmL", 
   ### name of the LPJmL run (will be part of the file names)

   run.description="LPJmL run",
   ### description of the LPJmL run

   provider="M. Forkel, matthias.forkel@geo.tuwien.ac.at", 
   ### name of the provider

   creator=provider,
   ### name of the creator
	
	reference="Sitch et al. 2003 GCB, Gerten et al. 2004 J. Hydrol., Thonicke et al. 2010 BG, Schaphoff et al. 2013 ERL, Forkel et al. 2014 BG",

	...
	### further arguments (currently not used)
		
	##details<<
	## No details.
	
	##references<< No reference.	
) {

	# get filename and information for actual variable
	info <- InfoLPJ(file)
	files.nc <- NA
	files.new <- NA

	# define function to read a band for several years for the variable v
	.ReadWrite <- function(band) {
	   if (((end - start) + 1) < 5) { # read all at once if only few years
	      start.read <- start
	      end.read <- end
	   } else {
		   # read data sequentiell: create start years to read the data
		   start.read <- seq(start, end-4, 5)
		   end.read <- start.read + 4
		}
			
		# loop over datasets: read bin, convert to brick and write as NetCDF
		for (y in 1:length(start.read)) {
			# get start and end year to read
			start.y <- start.read[y]
			end.y <- end.read[y]
			if (y == length(start.read)) end.y <- end
				
			# create time vector 
			if ((info$nbands == 12) & (file != "fpc.bin")) {
				time <- seq(as.Date(paste(start.y, "-01-01", sep="")), as.Date(paste(end.y, "-12-01", sep="")), by="month")
			}
			if ((info$nbands == 1) | (file == "fpc.bin")) {
				time <- seq(as.Date(paste(start.y, "-01-01", sep="")), as.Date(paste(end.y, "-01-01", sep="")), by="year")
			}	
			
			if (file == "mburnt_area.bin" | file == "mburntarea.bin") {
				file <- list.files(pattern="mburnt")
				if (length(file) == 0) return("NoFire")
			}
				
			# read LPJ file 
			data.sp <- ReadLPJ(file, start=start.y, end=end.y, sim.start.year=sim.start.year)
				
			# subset bands to read
			if (band == "ALL") {
				which.bands <- 1:ncol(data.sp@data)
				var.name0 <- var.name
			} else {
				nyear <- ncol(data.sp@data) / info$nbands
				which.bands <- seq(band, by=info$nbands, length=nyear)
	   		var.name0 <- paste(var.name, band, sep="_")
			}
			data.sp@data <- data.sp@data[,which.bands]
				
			# convert to RasterBrick
			data.rb <- brick(as(data.sp, "SpatialPixelsDataFrame"))
				
			# write as NetCDF
			nc <- WriteNCDF4(data=list(data.rb), var.name=var.name0, var.unit=var.unit, var.description=var.longname, time=time, data.name=run.name, file.description=run.description, 
				reference=reference, provider=provider, creator=creator, overwrite=TRUE)
			files.nc[y] <- nc
		}
			
		# combine files for time slices in one file
		ofile <- unlist(strsplit(files.nc[1], ".", fixed=TRUE)) 
		ofile[6] <- end
		ofile <- paste(ofile, collapse=".")
		cdo <- paste("cdo mergetime", paste0(files.nc, collapse=" "), ofile)
		system(cdo)

		# delete temporary files
		file.remove(files.nc)
      return(ofile)
	} # end function .ReadWrite

   # read files
	if (file == "fpc.bin") {	# read for fpc.bin all bands individually
		for (band in 1:info$nbands) files.new <- c(files.new, .ReadWrite(band))
	} else { # for other variables read all bands at once
		files.new <- c(files.new, .ReadWrite("ALL"))
	}

	# return file names
	return(na.omit(files.new))	
})


