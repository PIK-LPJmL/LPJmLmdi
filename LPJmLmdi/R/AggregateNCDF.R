AggregateNCDF <- structure(function(
  ##title<<
  ## Temporal aggregations and statistics on NetCDF files
  ##description<<
  ## Compute temporal aggregations and statistics of data in NetCDF files.
  
  files,
  ### (character) file name or vector file names. In case of multiple file names, it is assumed that each file corresponds to a different time period (i.e. all files are a time series)
  
  fun.agg = sum,
  ### function to be used for temporal aggregations
  
  var.name = NULL,
  ### (character) variable name in NetCDF files for which computations should be done. If NULL, all variables will be processed.
  
  tstep = NULL,
  ### (character) time step of input data: "daily", "ndaily" (period of n days), "monthly", "annual". If NULL tstep will be estimated from the files.
  
  agg.monthly = TRUE,
  ### (boolean) aggregate to monthly data? This will be only done if 'tstep' is daily or ndaily.
  
  agg.annual = TRUE,
  ### (boolean) aggregate to annual data? This will be only done if 'tstep' is < annual.
  
  agg.ndaily = TRUE,
  ### (boolean) aggregate to N-daily periods? This will be only done if 'tstep' is < ndays.
  
  ndays = 7,
  ### (integer) length of period [in days] for N-daily aggregations. For example, a aggregation to 7-daily periods will be done if ndays=7. A period starts always at the 1st January. Please note that a 7-daily aggregation does not necessarily correspond to calendar weeks (see \code{\link{GroupDates}} for details). This aggregation will be only done if 'tstep' is < ndays.
  
  stat.annual = TRUE,
  ### (boolean) compute statistics based on annual data?
  
  stat.monthly = FALSE,
  ### (boolean) compute statistics based on monthly data?
  
  stat.ndaily = FALSE,
  ### (boolean) compute statistics based on N-daily data?
  
  stat.daily = FALSE,
  ### (boolean) compute statistics based on daily data?
  
  msc.monthly = TRUE,
  ### (boolean) compute (mean/median) seasonal cycles on monthly data and monthly anomalies? This computation is based on \code{\link{SeasonalCycleNCDF}} and uses CDO modules.
  
  path.out = NULL,
  ### directory for output files. If NULL, directories will be created within the location of the files, otherwise directories will be created under the specified directory.
  
  path.out.prefix = "img",
  ### prefix for output directory names, directory names are created according to the following pattern 'prefix'_'resolution'_'timestep' (e.g. img_0d25_monthly)
  
  nodes = 1,
  ### How many nodes should be used for parallel processing of files? Parallel computing can be only used if length(files) > 1.
  
  stats = NULL,
  ### statistical metrics to compute
  
  ...
  ### further agruments (unused)
  
  ##details<<
  ##
  
  ##references<<
  ##
  
  ##seealso<<
  ##
  
  ) {
  
  # get directory and directory for outputs
  #----------------------------------------
  
  # directory of input data
  wd <- getwd()
  filestr <- strsplit(files[1], "/")[[1]]
  if (length(filestr) > 1) {
    path <- paste(filestr[-length(filestr)], collapse = "/")
  } else {
    path <- getwd()
    files <- paste0(path, "/", files)
  }
  
  # basic directory for output data
  if (is.null(path.out)) {
    pathstr <- strsplit(path, "/")[[1]]
    path.out <- paste(pathstr, collapse = "/")
  }
  message("AggregateNCDF: Directory for results: ", path.out)
  
  
  # get time and space information from files
  #------------------------------------------
  
  # initalize list for all files that can be produced
  files.l <-
    list(
      daily = NULL,
      daily_stat = NULL,
      ndaily = NULL,
      ndaily_stat = NULL,
      monthly = NULL,
      monthly_stat = NULL,
      annual = NULL,
      annual_stat = NULL
    )
  
  info <- InfoNCDF(files[1])
  files2 <-
    unlist(llply(strsplit(files, "/"), function(file)
      file[length(file)]))
  if (grepl(".", files2[1])) {
    data.name <- strsplit(files2[1], ".", fixed = TRUE)[[1]][1]
  } else {
    data.name <- strsplit(files2[1], "")[[1]]
    data.name <-
      paste(data.name[1:min(c(length(data.name), 10))], collapse = "")
  }
  
  # identify time step
  dt <- mean(diff(info$time)) # difference between time steps
  if (is.na(dt) &
      length(files) > 1)
    dt <- InfoNCDF(files[2])$time - info$time
  if (is.na(dt) &
      length(files) == 1)
    stop("Files have only one time step. Temporal aggregations don't make sense.")
  if (is.null(tstep)) {
    if (dt == 1)
      tstep <- "daily"
    if (dt >= 28 & dt <= 31)
      tstep <- "monthly"
    if (dt >= 365 & dt <= 366)
      tstep <- "annual"
    if (is.null(tstep))
      tstep <- "ndaily"
    message("AggregateNCDF: Identified time step of data is: ", tstep)
  }
  
  if (tstep == "daily")
    files.l$daily <- paste(path, files2, sep = "/")
  if (tstep == "ndaily")
    files.l$ndaily <- paste(path, files2, sep = "/")
  if (tstep == "monthly")
    files.l$monthly <- paste(path, files2, sep = "/")
  if (tstep == "annual")
    files.l$annual <- paste(path, files2, sep = "/")
  
  # identify spatial resolution
  res <- mean(diff(info$lon))
  nrow <- length(info$lat)
  ncol <- length(info$lon)
  
  # variable names
  if (is.null(var.name))
    var.name <- as.character(info$var$name)
  m <- match(var.name, info$var$name)
  var.unit <- as.character(info$var$unit[m])
  var.long <- as.character(info$var$longname[m])
  
  
  # function for temporal aggregation
  #----------------------------------
  
  DoAgg <- function(file, fun.agg, agg = "annual") {
    info <- InfoNCDF(file)
    
    # time and aggregation groups
    ti <- info$time
    cdo <- NULL
    if (agg == "monthly") {
      groups <- format(ti, "%Y-%m")
      ti.agg <- as.Date(paste0(unique(groups), "-01"))
      cdo <- paste0("cdo mon", fun.agg)
    }
    if (agg == "annual") {
      groups <- format(ti, "%Y")
      ti.agg <- as.Date(paste0(unique(groups), "-01-01"))
      cdo <- paste0("cdo year", fun.agg)
    }
    if (agg == "ndaily") {
      agg <- gsub("n", ndays, agg)
      groups <- GroupDates(ti, freq = ndays)
      ti.agg <- unique(groups$group.date)
      groups <- groups$group
    }
    if (grepl("msc", agg)) {
      groups <- format(ti, "%m")
      ti.agg <-
        as.Date(paste0(format(ti, "%Y")[1], unique(groups), "-01"))
      cdo <- paste0("cdo ymon", fun.agg)
    }
    
    # output path
    un <- unique(groups)
    opath <-
      paste0(path.out,
             "/",
             path.out.prefix,
             "_",
             gsub(".", "d", res, fixed = TRUE),
             "_",
             agg)
    if (!file.exists(opath))
      dir.create(opath)
    
    # output path
    ofile <-
      paste0(
        opath,
        "/",
        paste(
          data.name,
          var.name[1],
          nrow,
          ncol,
          un[1],
          un[length(un)],
          agg,
          fun.agg,
          "nc",
          sep = "."
        )
      )
    if (file.exists(ofile))
      file.remove(ofile)
    
    if (!is.null(cdo)) {
      cdo <- paste(cdo, file, ofile)
      system(cdo)
    } else {
      # do aggregations for each variable
      data.l <-
        llply(as.list(1:length(var.name)), function(varid) {
          data.rb <- brick(file, varname = var.name[varid])
          agg.rb <- AggregateTimeRaster(data.rb, groups,  fun.agg)
          agg.rb[is.infinite(agg.rb)] <- NA
          return(agg.rb)
        })
      
      # write raster
      WriteNCDF4(
        data.l,
        time = ti.agg,
        var.name = var.name,
        var.unit = var.unit,
        data.name = data.name,
        var.description = var.long,
        file = ofile,
        overwrite = TRUE
      )
      return(ofile)
    }
    return(ofile)
  } # end DoAgg
  
  
  #---------------------
  # compute aggregations
  #---------------------
  
  # setup cluster for parallel processing
  parallel <- FALSE
  if (nodes > 1 & length(files) > 1) {
    message(paste(
      "AggregateNCDF: Start cluster nodes for parallel computing.",
      Sys.time()
    ))
    cluster <- makeCluster(nodes)
    
    # load packages on all nodes
    clusterEvalQ(cluster, {
      library(raster)
      library(ncdf4)
      library(plyr)
      NULL
    })
    
    # export required objects to cluster nodes
    #clusterExport(cluster, ls(envir=.GlobalEnv), envir=.GlobalEnv)
    clusterExport(cluster, ls(), envir = environment())
  }
  
  # aggregate to monthly time steps
  calc.monthly <-
    (tstep == "daily" | (tstep == "ndaily" & dt < 30))
  if (agg.monthly & calc.monthly) {
    message(paste("AggregateNCDF: Start monthly aggregation.", Sys.time()))
    ofiles <-
      llply(
        as.list(files),
        .fun = DoAgg,
        fun.agg = fun.agg,
        agg = "monthly",
        .parallel = parallel
      )
    files.l$monthly <- unlist(ofiles)
  }
  
  # aggregate to N-daily time steps
  calc.ndaily <-
    (tstep == "daily" | (tstep == "monthly" & dt < ndays))
  if (agg.ndaily & calc.ndaily) {
    message(paste("AggregateNCDF: Start N-daily aggregation.", Sys.time()))
    ofiles <-
      llply(
        as.list(files),
        .fun = DoAgg,
        fun.agg = fun.agg,
        agg = "ndaily",
        .parallel = parallel
      )
    files.l$ndaily <- unlist(ofiles)
  }
  
  # aggregate to annual time steps
  calc.annual <-
    (tstep == "daily" |
       (tstep == "ndaily" & dt < 365) | tstep == "monthly")
  if (agg.annual & calc.annual) {
    message(paste("AggregateNCDF: Start annual aggregation.", Sys.time()))
    ofiles <-
      llply(
        as.list(files),
        .fun = DoAgg,
        fun.agg = fun.agg,
        agg = "annual",
        .parallel = parallel
      )
    files.l$annual <- unlist(ofiles)
  }
  
  
  #---------------------------------
  # compute statistics and anomalies
  #---------------------------------
  
  if (is.null(stats))
    stats <-
    c("mean",
      "median",
      "max",
      "min",
      "range",
      "sd",
      "coefvar",
      "sum",
      "maxtime",
      "mintime")
  
  if (stat.annual & !is.null(files.l$annual)) {
    opath <-
      paste0(
        path.out,
        "/",
        path.out.prefix,
        "_",
        gsub(".", "d", res, fixed = TRUE),
        "_annual_stats"
      )
    message(paste(
      "AggregateNCDF: Start computing annual statistics.",
      Sys.time()
    ))
    files.l$annual_stat <-
      StatisticsNCDF(
        files.l$annual,
        var.name = var.name,
        stats = stats,
        path.out = opath
      )
  }
  
  if (stat.monthly & !is.null(files.l$monthly)) {
    opath <-
      paste0(
        path.out,
        "/",
        path.out.prefix,
        "_",
        gsub(".", "d", res, fixed = TRUE),
        "_monthly_stats"
      )
    message(paste(
      "AggregateNCDF: Start computing monthly statistics.",
      Sys.time()
    ))
    files.l$monthly_stat <-
      StatisticsNCDF(
        files.l$monthly,
        var.name = var.name,
        across.files = FALSE,
        stats = stats,
        path.out = opath
      )
  }
  
  if (stat.ndaily & !is.null(files.l$ndaily)) {
    opath <-
      paste0(
        path.out,
        "/",
        path.out.prefix,
        "_",
        gsub(".", "d", res, fixed = TRUE),
        "_ndaily_stats"
      )
    message(paste(
      "AggregateNCDF: Start computing N-daily statistics.",
      Sys.time()
    ))
    files.l$ndaily_stat <-
      StatisticsNCDF(
        files.l$ndaily,
        var.name = var.name,
        across.files = FALSE,
        stats = stats,
        path.out = opath
      )
  }
  
  if (stat.daily & !is.null(files.l$daily)) {
    opath <-
      paste0(
        path.out,
        "/",
        path.out.prefix,
        "_",
        gsub(".", "d", res, fixed = TRUE),
        "_daily_stats"
      )
    message(paste(
      "AggregateNCDF: Start computing daily statistics.",
      Sys.time()
    ))
    files.l$daily_stat <-
      StatisticsNCDF(
        files.l$daily,
        var.name = var.name,
        across.files = FALSE,
        stats = stats,
        path.out = opath
      )
  }
  
  # close cluster
  if (parallel) {
    stopCluster(cluster)
    message(paste("AggregateNCDF: Stop cluster nodes.", Sys.time()))
  }
  
  
  #-----------------------------------------------
  # compute seasonal cycles and seasonal anomalies
  #-----------------------------------------------
  
  if (msc.monthly & !is.null(files.l$monthly)) {
    files.l$monthly_stat <-
      SeasonalCycleNCDF(files.l$monthly, var.name = var.name)
  }
  
  return(files.l)
})
  