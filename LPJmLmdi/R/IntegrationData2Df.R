IntegrationData2Df <- structure(function(
  ##title<< 
  ## Converts IntegrationData to a data.frame
  ##description<<
  ## The function takes an object of class \code{\link{IntegrationData}} and converts it into a data.frame in long format. The data.frame has the columns 'lon', 'lat', 'time' and 'id' (a combination of lon_lat_time), and columns for each variable in IntegrationData.
  
  x,
  ### object of class \code{\link{IntegrationData}}
  
  sim.name = "sim",
  ### name that should be added to the variables for the simulation (e.g. use 'sim', or something like 'prior' or 'posterior' to create column names like 'FAPAR.sim')

  ...
  ### further arguments (not used)
  
  ##details<<
  ## No details.
  
  ##references<< No reference.	
  
  ##seealso<<
  ## \code{\link{IntegrationData}}
) {	

  # has simulations?
  has.sim <- is.matrix(x[[1]]$model.val)
  
  # iterate over all datasets: create data.frame
  data.l <- llply(x, function(ds) {
    .create.df <- function(data, name) {
      data.df <- cbind(time=as.Date(ds$data.time), as.data.frame(data))
      colnames(data.df) <- c("time", paste(ds$xy$lon, ds$xy$lat))
      data.df <- gather(data.df, key=xy, value=Y, -time) %>%
        separate(xy, c("lon", "lat"), sep=" ", convert=TRUE) %>%
        unite(lon, lat, time, col="id", remove=FALSE)
      colnames(data.df) <- c("id", "time", "lon", "lat", name)
      return(data.df)
    }
    data.df <- .create.df(ds$data.val, paste0(ds$name, ".obs"))
    if (has.sim) {
      sim.df <- .create.df(ds$model.val, paste(ds$name, sim.name, sep="."))
      data.df <- merge(data.df, sim.df)
    }
    return(data.df)
  })
  
  # merge all data.frames
  ids <- unique(unlist(llply(data.l, function(df) df$id)))
  all.df <- data.frame(id=ids) %>%
    separate(id, c("lon", "lat", "time"), sep="_", convert=TRUE, remove=FALSE)
  all.df$time <- as.Date(all.df$time)
  for (i in 1:length(data.l)) all.df <- merge(all.df, data.l[[i]], all=TRUE)
 
  return(all.df)
  ### a data.frame
})

