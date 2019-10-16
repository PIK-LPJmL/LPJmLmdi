RegridLPJinput <- structure(function(
  ##title<< 
  ## Regrid or subset LPJmL input 
  ##description<<
  ## Subsets grid cells or regrids LPJmL input files.
  
  files, 
  ### character vector of CLM or binary file names
  
  grid.clm,
  ### old grid *.clm file
  
  grid,
  ### Matrix of new grid cells with 2 columns: longitude and latitude (optional). If NULL the data is returned for the grid of the first CLM file. If a grid is provided the data is subesetted for the specified grid cells.

  path.out,
  ### directory where the new files should be saved

  overwrite = TRUE,
  ### overwrite existing files?
  
  ...
  ### further arguments (currently not used)
  
  ##details<<
  ## No details.
  
  ##references<< No reference.
  
  ##seealso<<
  ## \code{\link{WriteLPJinput}}
  
) {
  dir.create(path.out, recursive=TRUE)
  
  # new file names
  files2 <- laply(strsplit(files, "/"), function(f) paste(path.out, f[length(f)], sep="/"))
  
  # write grid
  grid.txt <- paste0(path.out, "/grid.txt")
  grid.new.clm <- paste0(path.out, "/grid.clm")
  if (ncol(grid) > 2) stop("grid needs only 2 columns: 'lon' and 'lat'")
  write.table(grid, file=grid.txt, sep=",", row.names=FALSE, col.names=FALSE)
 
  bool <- all(file.exists(c(grid.new.clm, files2)))
  if (overwrite | !bool) {
 
    # write new grid clm file
    cmd <- paste("txt2grid -skip 0 -fmt \"%g,%g\"", grid.txt, grid.new.clm)
    system(cmd)

    # regrid input files
    for (i in 1:length(files)) {
      if (names(files)[i] == "SOILCODE_FILE") {
        cmd <- paste("regridsoil", grid.clm, grid.new.clm, files[i], files2[i])
      } else {
        cmd <- paste("regridclm", grid.clm, grid.new.clm, files[i], files2[i])
      }
      system(cmd)
    }
  }
  bool <- file.exists(files2)
  if (any(!bool)) stop("File does not exist.")
  files.df <- data.frame(
    name = c("GRID_FILE", names(files)),
    file = c(grid.new.clm, files2)
  )
  return(files.df)
  ### The function returns TRUE if the CLM file was created.
}, ex=function() {
 # no example
})
