InfoNCDF <- structure(function(
	##title<< 
	## Get information about variables in a NetCDF

	file
	### file name
			
	##details<<
	## 

	##references<< 
	## 
	
	##seealso<<
	## \code{\link{WriteNCDF4}}
	
) { 
   nc <- nc_open(file)
   
   # get variables
   nms <- unlist(llply(nc$var, function(v) v$name))
   units <- unlist(llply(nc$var, function(v) v$units))
   nms2 <- unlist(llply(nc$var, function(v) v$longname))
   
   # get dimensions
   lon <- nc$dim$lon$vals
   lat <- nc$dim$lat$vals 
   ti <- try(as.Date(gsub("days since ", "", nc$dim$time$units)) + nc$dim$time$vals, silent=TRUE)
   if (class(ti) == "try-error") {
      ti <- nc$dim$time$vals
   }
   
   # all dimensions
   dim <- llply(nc$dim, function(dim) {
      return(list(name=dim$name, length=length(dim$vals)))
   })
   
   
   # get global attributes
   glob <- ncatt_get(nc, 0)
   
   nc_close(nc)
   info.l <- list(
      file = file,
      lat = lat,
      lon = lon,
      time = ti,
      dim = dim,
      global = glob,
      var = data.frame(name=nms, unit=units, longname=nms2)
   )
   return(info.l)
   ### The function returns a list with information about the dimensions and variables in the NetCDF file.
})
