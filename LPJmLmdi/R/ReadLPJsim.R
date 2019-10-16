ReadLPJsim <- structure(function(
  ##title<< 
  ## Read a LPJ simulation results
  ##description<<
  ## The function reads all binary output files from a LPJ simulation and returns regional aggregated time series.
  
  sim.start.year=1901, 
  ### first year of the simulation
  
  start=sim.start.year, 
  ### first year to read
  
  end=NA, 
  ### last year to read. If NA, reads until last year
  
  files=NA,
  ### Which LPJ binary output files should be read? If NA, all *.bin files in the current directory are read.
  
  outputvars.par=NULL, 
  ### path and file name to the LPJmL 'outputvars.par' file. If NULL the file is searched 1 level above or below the current working directory. 	
  
  ...
  ### further arguments (currently not used)
  
  ##details<<
  ## No details.
  
  ##references<< No reference.
  
  ##seealso<<
  ## \code{\link{ReadLPJ2ts}}
  
) {
  
  # list all LPJmL output files
  if (is.na(files)) {
    files <- list.files(pattern=".bin")
    files <- files[-grep("grid.bin", files)]
  }
  files <- files[!grepl("seasonality.bin", files)]
  files <- files[file.exists(files)]
  
  # remove older files from reading - likely from different model run
  filei <- file.info(files)
  ti <- filei$mtime[grep("vegc.bin", files)]
  bool <- abs(filei$mtime - ti) > 60*3
  if (any(bool)) {
    warnings(paste0("These files are older and might be not from the same model run: ", " \n   ", paste(files[bool], collapse=", "), " \n   ", "Files are excluded from reading."))
    files <- files[!bool]
  }
  names <- gsub(".bin", "", files)	
  
  # get grid
  info <- InfoLPJ(files[1])
  npixel <- info$npixel
  grid.data <- info$grid
  
  # read time series
  data.l <- llply(as.list(files), .fun=function(file) {
    # bac <<- file
    ReadLPJ2ts(file, sim.start.year=sim.start.year, start=start, end=end)
  })
  names(data.l) <- names
  
  # get information for output files/variables
  if (is.null(outputvars.par)) outputvars.par <- list.files("../..", "outputvars.par", recursive=TRUE, full.names=TRUE)
  if (length(outputvars.par) == 0) outputvars.par <- NULL
  if (!is.null(outputvars.par)) {
    if (!file.exists(outputvars.par)) outputvars.par <- NULL
  } 
  if (length(outputvars.par) == 0) outputvars.par <- NULL
  if (!is.null(outputvars.par)) {
    # read "outputvars.par" to get meta-information
    output.df <- ReadOutputvars(outputvars.par=outputvars.par)
    info.df <- ldply(as.list(files), .fun=function(file) {
      g <- grep(gsub(".bin", "", file), output.df$id)
      if (length(g) == 0) g <- grep(toupper(gsub(".bin", "", file)), output.df$id)
      if (length(g) == 0) g <- grep(gsub(".bin", "", file), output.df$name)
      if (length(g) == 0) g <- grep(toupper(gsub(".bin", "", file)), output.df$name)
      if (length(g) == 0) g <- grep(gsub("d", "d_", (gsub(".bin", "", file))), output.df$name)
      if (length(g) == 0) {
        df <- data.frame(id=file, name=gsub(".bin", "", file), name2="", description="", unit="", scale=1, file=file)
      } else {
        df <- output.df[g[1],]
        df$file <- file
      }
      return(df)
    })
    
    # apply scaling factor
    data.l <- llply(as.list(1:length(data.l)), function(id) {
      data.l[[id]] * 1/info.df$scale[id]
    })
    names(data.l) <- names
  } else {
    message("File 'outputvars.par' not found. Read LPJ output without meta-information.")
    info.df <- data.frame(id=files, name=gsub(".bin", "", files), name2="", description="", unit="", scale=1)
  }
  
  lpj.l <- list(data=data.l, grid=grid.data, info=info.df)
  class(lpj.l) <- "LPJsim"
  return(lpj.l)
  ### The function returns a list of class 'LPJsim'
}, ex=function() {
  
  # setwd(path.mylpjresult)
  # sim <- ReadLPJsim(start=1982, end=2011)
  
})

