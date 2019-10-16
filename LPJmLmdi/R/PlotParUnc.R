PlotParUnc <- structure(function(
  ##title<< 
  ## Plot the psoterior parameter uncertainty
  ##description<<
  ## The function takes an object of class \code{\link{LPJpar}} and plots the relative uncertainty of the optimized parameters, i.e. uncertainty_best / uncertainty_prior
  
  lpjpar,
  ### a list of class "LPJpar" (see \code{\link{LPJpar}})
  
  uncertainty = "uncertainty.005",
  ### name of the uncertainty estimate in LPJpar that should be used to compute posterior uncertainties
  
  ylab = "Relative parameter uncertainty", 
  ### label of y-axis
  
  main = NULL,
  ### title of plot
  
  par.name = NULL,
  ### name(s) of the parameters that should be plotted
  
  use.par = TRUE,
  ### use default settings for the graphic window? If FALSE, the internal settings for par() are not used.
  
  legend = TRUE,
  ### plot a legend for PFTs?
  
  srt = 40,
  ### string rotation of parameter names at the x-axis
  
  cex = 1,
  ### size of point symbols
  
  ...
  ### further arguments for plot
  
  ##details<<
  ## No details.
  
  ##references<< No reference.	
  
  ##seealso<<
  ## \code{\link{CombineRescueFiles}}
) { 
  if (class(lpjpar) != "LPJpar") {
    stop("lpjpar should be of class LPJpar")
  }
  
  # colours and symbols for PFTs
  cols <- c("#E41A1C", "#4DAF4A", "#377EB8", "darkgrey")
  cols <- c(global=cols[4], TrBE=cols[1], TrBR=cols[1], TrH=cols[1], 
            TeNE=cols[2], TeBE=cols[2], TeBS=cols[2], TeH=cols[2], 
            BoNE=cols[3], BoNS=cols[3], BoBS=cols[3], PoH=cols[3])
  pchs <- c(global=16, TrBE=19, TrBR=21, TrH=15, 
            TeNE=17, TeBE=19, TeBS=21, TeH=15, 
            BoNE=17, BoNS=24, BoBS=21, PoH=15)
  
  # get uncertainty estimate
  # uncertainty estimate
  unc <- grep(uncertainty, names(lpjpar))
  if (uncertainty != "uncertainty.005") unc <- unc[1]
  has.unc <- !all(is.na(unc))
  if (has.unc) {
    if (length(unc) == 1) { # uncertainty range
      unc <- lpjpar[[unc]]
      unclow <- lpjpar$best - 0.5 * unc
      uncup <- lpjpar$best + 0.5 * unc
      
      bool <- unclow < lpjpar$lower
      bool[is.na(bool)] <- FALSE
      unclow[bool] <- lpjpar$lower[bool]
      uncup[bool] <- unclow[bool] + unc[bool]
      
      bool <- uncup > lpjpar$upper
      bool[is.na(bool)] <- FALSE
      uncup[bool] <- lpjpar$upper[bool]
      unclow[bool] <- uncup[bool] - unc[bool]
    } else if (length(unc) == 2) { # uncertainty lower and upper
      low <- (lpjpar[[unc[1]]])
      up <- (lpjpar[[unc[2]]])
      if (any(na.omit(low > up))) {
        up <- (lpjpar[[unc[1]]])
        low <- (lpjpar[[unc[2]]])			
      }
      unclow <- low
      uncup <- up
    } else {
      warning("Check the selected uncertainty estimate")
      has.unc <- FALSE
    }
  }
  
  # 
  if (is.null(main)) main <- uncertainty
  
  # compute relative uncertainty
  dpar <- abs(lpjpar$best / lpjpar$prior)
  dunc <- abs(uncup - unclow) / abs(lpjpar$upper - lpjpar$lower) 
  names(dunc) <- names(dpar)
  bool <- !is.na(dunc)
  dunc <- dunc[bool]
  dpar <- dpar[bool]
  
  # get names and PFT names
  nms <- strsplit(names(dunc), "_")
  pfts <- laply(nms, function(nme) {
    pft <- nme[length(nme)]
    if (!any(grepl(pft, names(cols)))) pft <- "global"
    return(pft)
  })
  nms <- laply(nms, function(nme) {
    pft <- nme[length(nme)]
    if (any(grepl(pft, names(cols)))) {
      nme <- paste(nme[-length(nme)], collapse="_")
    } else {
      nme <- paste(nme, collapse="_")
    }
    return(nme)
  })
  
  # select only parameters that should be plotted
  if (!is.null(par.name)) {
    m <- NULL
    for (i in 1:length(par.name)) m <- c(m, grep(par.name[i], nms))
    pfts <- pfts[m]
    nms <- nms[m]
    dunc <- dunc[m]
  }
  nms <- as.factor(nms)
  nms2 <- as.integer(nms) 
  
  # aggregate uncertainty for each parameter across PFTs
  dunc.agg <- aggregate(dunc ~ nms2, FUN=mean)
  dunc.agg[,3] <- nms[match(dunc.agg[,1], nms2)]
  dunc.agg <- dunc.agg[order(dunc.agg[,2]), ]
  
  col <- cols[match(pfts, names(cols))]
  pch <- pchs[match(pfts, names(cols))]
  
  if (use.par) DefaultParL(las=0, mar=c(8, 3.8, 2, 0.5), xpd=FALSE)
  
  # plot(1:nrow(dunc.agg), ylim=c(0, 2), xaxt="n", type="n", xlab="", ylab="Parameter best / prior")
  # abline(h=1)
  # points(match(nms2, dunc.agg[,1]), dpar, col=col, pch=pch)
  
  plot(1:nrow(dunc.agg), dunc.agg[,2], xaxt="n", xlab="", type="l", ylim=c(0,1), lwd=2, ylab=ylab, main=main, ...)
  axis(1, 1:nrow(dunc.agg), rep("", nrow(dunc.agg)))
  points(match(nms2, dunc.agg[,1]), dunc, col=col, pch=pch, cex=cex)
  par(xpd=TRUE)
  txt <- as.character(dunc.agg[,3])
  txt <- ifelse(nchar(txt) > 14, paste0(substring(txt, 1, 13), "..."), txt)
  text(1:nrow(dunc.agg), -0.08, txt, srt=srt, adj=c(1,1))
  #par(xpd=FALSE)
  
  m <- match(unique(pfts), names(cols))
  ncol <- 3
  if (length(m) <= 8) ncol <- 2
  if (legend) legend("topleft", names(cols)[m], col=cols[m], pch=pchs[m], ncol=ncol, bty="n", title="PFT", cex=cex)
  
}, ex=function() {
  # PlotParUnc(lpjpar)
})


