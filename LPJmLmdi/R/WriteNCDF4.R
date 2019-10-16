WriteNCDF4 <- structure(function(
	##title<< 
	## Write NetCDF files
	
	##description<<
	## Writes NetCDF files from rasters and makes sure that meta-information is properly defined.
	
	data.l,
	### a single Raster* object or a list of Raster* objects 
		
	var.name, 
	### vector of variable names
	
	var.unit, 
	### vector of variable units
	
	time=as.Date("2000-01-01"), 
	### vector of time steps for each layer.
			
	var.description=var.name,
	### vector of variable descriptions
	
	file=NULL, 
	### file name. If NULL the file name will be created from the variable name and the dimensions of the data.

	data.name=NA, 
	### name of the dataset
	
	region.name=NA,
	### name of the region
	
	file.title=var.name, 
	### title of the file
	
	file.description=var.name, 
	### description of the file
	
	reference="", 
	### reference for the dataset
	
	provider="", 
	### dataset provider
	
	creator="",
	### dataset creator
	
	missval=-9999, 
	### flag for missing/NA values
	
	scale=1, 
	### scaling values for the data
	
	offset=0,
	### offset value
		
	compression=9,
	### If set to an integer between 1 (least compression) and 9 (most compression), this enables compression for the variable as it is written to the file. Turning compression on forces the created file to be in netcdf version 4 format, which will not be compatible with older software that only reads netcdf version 3 files.
	
	overwrite=FALSE
	### overwrite existing file?
			
	##details<<
	## 

	##references<< 
	## 
	
	##seealso<<
	##  
) { 

	# check parameters
	if (is.null(data.l)) stop("Provide a list of Raster* object")
	if (is.null(var.name)) stop("Define 'var.name'")
	if (is.null(var.unit)) stop("Define 'var.unit'")
	
	# conver raster brick 
	rb2l <- function(rb) {
	   l <- vector("list")
	   for (i in 1:nlayers(rb)) l[[i]] <- raster(rb, i)
	   return(l)
	}
	if (length(var.name) > 1 & class(data.l) == "RasterBrick") {
	   data.l <- rb2l(data.l)
	}
	
	if (class(data.l) != "list") data.l <- list(data.l)

   # check time
	if (!is.null(time)) {
      if ((class(time) == "Date") | (class(time) == "POSIXct") | (class(time) == "POSIXlt") ) {
			start <- try(format(time[1], "%Y"), TRUE)
			if (class(start) == "try-error") start <- time[1]
			end <- try(format(time[length(time)], "%Y"), TRUE)
			if (class(end) == "try-error") end <- time[length(time)]
			timestep <- diff(time)
			if (length(timestep) == 0) {
				timestep <- 0
				time2 <- time
			} else {
				timestep <- gsub(" ", "", format(mean(timestep), digits=1))	
				time2 <- try(difftime(time, as.POSIXct(ISOdatetime(1582,10,14,0,0,0)), units="days"), TRUE)
			}
			if (class(time2) == "try-error") time2 <- time
		} else {
			stop("time should be of class Date, POSIXct or POSIXlt.")
		}
	} else {
	   stop("Define time axis 'time'.")
	}

   # define dimensions for NetCDF
   xy <- xyFromCell(data.l[[1]], 1:ncell(data.l[[1]]))
   dlon <- ncdim_def("longitude", "degrees_east", unique(xy[, 1]))
   dlat <- ncdim_def("latitude", "degrees_north", unique(xy[, 2]))
   rdate <- as.numeric(time - as.Date("1582-10-14"))
   dtime <- ncdim_def("time", "days since 1582-10-14 00:00:00", rdate, unlim = TRUE)
   
   if (length(missval) < length(data.l)) missval <- rep(missval, length(data.l))
      
   # define variables 
   ncvars.l <- llply(as.list(1:length(data.l)), function(i) {
      ncvar_def(name=var.name[i], units=var.unit[i], dim=list(dlon, dlat, dtime), missval=missval[i], longname=var.description[i], compression=compression)    
   })
 
 	# create file name and check if file exists
	if (is.null(file)) {
	   nme <- var.name
	   if (length(var.name) > 1) nme <- nme[1]
		file <- paste(data.name, nme, nrow(data.l[[1]]), ncol(data.l[[1]]), region.name, start, end, timestep, "nc", sep=".")
		file <- gsub("NA.", "", file, fixed=TRUE)
	}
	if (file.exists(file) & (overwrite == FALSE)) stop("File 'file' already exists. Use overwrite=TRUE to overwrite it.")
   
   # create NetCDF
   nc <- nc_create(file, ncvars.l)
   
   # write data and set attributes
   if (length(scale) < length(data.l)) scale <- rep(scale[1], length(data.l))
   if (length(offset) < length(data.l)) offset <- rep(offset[1], length(data.l))
   llply(as.list(1:length(data.l)), function(id) {
	   file.tmp <- paste(tempfile(tmpdir=getwd()), ".grd", sep="")
	   
	   # add scale and offset to data
	   data <- data.l[[id]]
	   data[is.na(data)] <- missval[id]
	      if (scale[id] != 1 | offset[id] != 0) {
	         if (nlayers(data) > 5) {
		         data <- calc(data, function(x) { 
			         x <- x * scale[id] + offset[id]
			         return(x) 
		         }, file=file.tmp)
		      } else {
		         data <- data * scale[id] + offset[id]
		      }
		   }
      ncvar_put(nc, var.name[id], values(data))
      suppressWarnings(file.remove(file.tmp))
      
      # write variable-specific attributes to NetCDF file
      ncatt_put(nc, var.name[id], "scale_factor", scale[id], "double")
      ncatt_put(nc, var.name[id], "add_offset", offset[id], "double")
   })
      
	# set global attributes
	ncatt_put(nc, 0, "title", as.character(file.title), "text")
	ncatt_put(nc, 0, "description", as.character(file.description), "text")
	history <- paste(Sys.time(), creator, ": file created from R function WriteNCDF4")
	ncatt_put(nc, 0, "history", as.character(history), "text")
	ncatt_put(nc, 0, "provided_by", as.character(provider), "text")
	ncatt_put(nc, 0, "created_by", as.character(creator), "text")
	ncatt_put(nc, 0, "reference", as.character(reference), "text")
	
   nc_close(nc)
   return(file)
})
   
   
