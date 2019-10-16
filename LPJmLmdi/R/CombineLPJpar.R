CombineLPJpar <- structure(function(
  ##title<< 
  ## Combines several 'LPJpar' objects into one
  ##description<<
  ## The function takes several lpjpar objects and combines them into one LPJpar object
  
  lpjpar.l
  ### a list of \code{\link{LPJpar}} objects
  
  ##details<<
  ## No details.
  
  ##references<< No reference.
  
  ##seealso<<
  ## \code{\link{LPJpar}}
) {
  names <- sort(unique(unlist(llply(lpjpar.l, function(x) x$names))))
  npar <- length(names)
  lpjpar2 <- list(names=names)
  for (i in 1:length(lpjpar.l)) {
    # which parameters were optimized?
    is.opt <- !is.na(lpjpar.l[[i]]$uncertainty.iqr)
    m1 <- match(lpjpar.l[[i]]$names, names)
    m2 <- match(lpjpar.l[[i]]$names[is.opt], names)
    for (j in 2:length(lpjpar.l[[i]])) {
      colmn <- names(lpjpar.l[[i]])[j]
      if (is.null(lpjpar2[[colmn]])) {
        vals <- rep(NA, npar)
      } else {
        vals <- lpjpar2[[colmn]]
      }
      if (colmn == "prior" | colmn == "upper" | colmn == "lower" | colmn == "pftspecif") {
        vals[m1] <- lpjpar.l[[i]][[j]] # take all parameters
        if (colmn == "prior" & i == 1) {
          lpjpar2$best <- lpjpar2$best.median <- vals
        }
      } else {
        vals[m2] <- lpjpar.l[[i]][[j]][is.opt] # take only optimized parameters
      }
      names(vals) <- names
      lpjpar2[[colmn]] <- vals
    }
  }
  class(lpjpar2) <- "LPJpar"
  return(lpjpar2)
  ### The function returns a list of class 'LPJparList'
})