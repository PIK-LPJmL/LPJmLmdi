plot.IntegrationData <- structure(function(
  ##title<< 
  ## Plot an object of class IntegrationData
  ##description<<
  ## The function plots an object of class \code{\link{IntegrationData}}, i.e. it produces a time series plots, scatterplots and a boxplot for the observations and LPJmL model outputs in \code{\link{IntegrationData}}.
  
  x,
  ### object of class \code{\link{IntegrationData}}
  
  ds=1:length(x),
  ### Which data sets in x should be plotted (integer)
  
  CostMDS = CostMDS.SSE,
  ### cost function for multiple data streams
  
  fits = "poly3",
  ### Fitting methods that should be used for scatter plots, see \code{\link{MultiFit}}
  
  ...
  ### further arguments (currently not used)
  
  ##details<<
  ## No details.
  
  ##references<< No reference.
  
  ##seealso<<
  ## \code{\link{IntegrationData}}
  
) {		
  
  
  # internal function to plot maps
  #-------------------------------
  
  .map <- function(val, title="") {
    brks <- Breaks(val, n=7)
    cols <- BreakColors(brks)
    cols2 <- cols[findInterval(val, brks, all.inside=TRUE)]
    .lim <- function(x, lon=TRUE) {
      lim <- range(x)
      d <- diff(lim)
      lim[1] <- lim[1] - d * 0.3
      lim[2] <- lim[2] + d * 0.3
      if (lon & lim[1] < -180) lim[1] <- -180
      if (lon & lim[2] > 180) lim[2] <- 180
      if (!lon & lim[2] > 90) lim[2] <- 90
      if (!lon) lim[1] <- lim[1] - diff(lim) * 0.2
      lim
    }
    ylim.map <- .lim(xy[,2], lon=FALSE)
    xlim.map <- .lim(xy[,1], lon=TRUE)
    
    # init map
    plot(0, 1, type="n", xlab="Longitude (E)", ylab="Latitude (N)", ylim=ylim.map, xlim=xlim.map)
    PlotWorld110(rivers=FALSE, lakes=FALSE, bg="grey", col=rep("darkgrey", 3), add=TRUE)
    #	mtext(title, 3, 0.2, font=2, cex=1.2)
    
    # add legend
    x <- xlim.map 
    x[2] <- x[1] + diff(x) * 0.5
    y <- ylim.map
    y[1] <- y[1] + diff(ylim.map) * 0.1
    y[2] <- y[1] + diff(ylim.map) * 0.12
    LegendBar(x, y, brks, cols, bg="white", col.txt="purple", cex.txt=0.8, title=title)		
    
    # add values
    points(xy, bg=cols2, pch=21)
    box()
    
  }				
  
  
  # loop over data
  #---------------
  
  integrationdata <- x
  par0 <- par()
  has.sim <- is.matrix(integrationdata[[1]]$model.val)
  if (has.sim) cost.l <- CostMDS(integrationdata)		
  for (d in ds) {
    obs <- integrationdata[[d]]$data.val
    has.cycle <- FALSE
    if (!all(is.na(obs))) {
      if (has.sim) {
        sim <- integrationdata[[d]]$model.val
        res <- sim - obs
      } else {
        sim <- res <- obs
        sim[] <- NA	
        res[] <- NA
      }
      unc <- integrationdata[[d]]$data.unc
      time.ds <- integrationdata[[d]]$data.time
      name.ds <- integrationdata[[d]]$name
      unit.ds <- integrationdata[[d]]$unit
      xy <- integrationdata[[d]]$xy
      
      # limits for y-axis
      ylim <- range(c(obs, sim), na.rm=TRUE)
      d2 <- (ylim[2] - ylim[1]) * 0.2
      ylim[2] <- ylim[2] + d2
      ylim[1] <- ylim[1] - d2
      mn <- min(c(obs, sim), na.rm=TRUE)
      if (mn >= 0 & ylim[1] < 0) ylim[1] <- 0
      
      # is data stream a time series?
      is.ts <- nrow(obs) > 1
      # if (nrow(obs) != length(time.ds)) is.ts <- FALSE
      
      # is a mean seasonal cycle?
      tstep <- diff(time.ds)[1]
      is.msc <- ((nrow(obs) == 12) & (tstep > 27 & tstep < 32)) | ((nrow(obs) == 365) & (tstep > 0.9 & tstep < 1.1))
      if (is.msc) is.ts <- TRUE
      
      # extract time series properties
      if (is.ts) {
        nyears <- as.numeric((max(time.ds) - min(time.ds))/365)
        
        if (is.msc) {
          is.ts <- TRUE
          time.txt <- time.ds <- time.pr <- cycl <- 1:12
          freq <- 12
          freq2 <- "month"
          start <- c(1900, 1)
          has.cycl <- TRUE
        } else {
          start <- as.numeric(c(format(time.ds[1], "%Y"), format(time.ds[1], "%j")))
          freq <- 1
          has.cycl <- FALSE
          col.cycl <- "darkgray"
          if (tstep > 27 & tstep < 32) {
            freq <- 12
            has.cycl <- TRUE
          }
          if (tstep == 1) {
            freq <- 365
            has.cycl <- TRUE
          }
          if (has.cycl) cycl <- as.integer(format(time.ds, "%m"))
        }
        if (has.cycl) {
          col.cycl <- colorRampPalette(c("dodgerblue4", "green", "yellow", "darkorange3", "dodgerblue2"))
          col.cycl <- col.cycl(12)[cycl]					
        }
        
        if (length(time.ds) != nrow(obs)) time.ds <- seq(min(time.ds), max(time.ds), length=nrow(obs))
        
        # x-axis labels (time)
        time.pr <- pretty(time.ds)
        if (is.msc) time.pr <- 1:12
        if (!is.msc) {
          if (nyears > 4) time.txt <- format(time.pr, "%Y")
          if (nyears > 1.2 & nyears <= 4) time.txt <- format(time.pr, "%Y-%m")
          if (nyears <= 1.2) time.txt <- format(time.pr, "%Y-%m-%d")
        }
        
      } else {
        col.cycl <- "darkgray"
      }
      
      # has data multiple locations?
      has.space <- ncol(obs) > 1
      
      
      # plot time series or map
      #------------------------
      
      DefaultParL(fig=c(0, 0.66, 0.66, 1),  mar=c(2.5, 3.5, 1, 0.5), oma=c(0.5, 0.5, 1, 0.5), new=FALSE)
      if (is.ts) { # plot time series
        obs.med <- apply(obs, 1, median, na.rm=TRUE)
        unc.med <- apply(unc, 1, median, na.rm=TRUE)
        sim.med <- apply(sim, 1, median, na.rm=TRUE)
        
        type <- "l"
        if (length(time.ds) < 15 & any(is.na(obs))) type <- "p"
        
        # plot all cells
        matplot(time.ds, obs, col="lightblue", type=type, xaxt="n", lty=1, pch=16, ylim=ylim, xlab="", ylab=paste(name.ds, " (", unit.ds, ")", sep=""))
        if (has.sim) matplot(time.ds, sim, col="orange", add=TRUE, lty=1, type="l")
        
        # add uncertainty only if !has.space
        if (!has.space) {
          matplot(time.ds, obs+unc, col="lightblue", add=TRUE, lty=1, type=type, pch=16)
          matplot(time.ds, obs-unc, col="lightblue", add=TRUE, lty=1, type=type, pch=16)
        }
        
        # add median
        if (type == "l") lines(time.ds, obs.med, col="blue", lwd=2)
        if (type == "p") points(time.ds, obs.med, col="blue", pch=16)
        if (has.sim) lines(time.ds, sim.med, col="red", lwd=2)
        axis(1, time.pr, time.txt)	
        legend("topleft", paste0(name.ds, c(".obs", ".sim")[c(TRUE, has.sim)]), lty=1, lwd=2, col=c("blue", "red"), bty="n")
      } else {
        if (has.space) { # plot map
          par(c(3.8, 3.5, 0.5, 0.5), mar=c(3.8, 3.5, 0.5, 0.5))
          if (has.sim) {
            .map(sim, paste(name.ds, ".sim (", unit.ds, ")", sep=""))	
          } else {
            .map(obs, paste(name.ds, ".obs (", unit.ds, ")", sep=""))	
          }
        } else { # plot nothing
          plot.new()
        }
      }
      mtext(name.ds, 3, line=-0.2, outer=TRUE, font=2, cex=1.5)
      
      
      # plot boxplot
      #-------------
      
      sim[is.na(obs)] <- NA
      par(new=TRUE, fig=c(0.66, 1, 0.66, 1))
      boxplot(list(obs, sim), ylab=paste(name.ds, " (", unit.ds, ")", sep=""), ylim=ylim, names=c("Obs", "Sim"), col=c("blue", "red"))
      boxplot(c(obs-unc, obs+unc), add=TRUE, border="lightblue", xaxt="n", yaxt="n", boxwex=0.6)	
      
      
      if (has.sim) {
        
        # plot residuals as time series or map
        #-------------------------------------
        
        par(new=TRUE, fig=c(0, 0.66, 0.33, 0.66),  mar=c(3.8, 3.5, 0.5, 0.5))
        if (is.ts) { # plot time series
          res.med <- apply(sim, 1, mean, na.rm=TRUE) - apply(obs, 1, mean, na.rm=TRUE)
          matplot(time.ds, res, col="darkgrey", type=type, pch=16, xaxt="n", lty=1, xlab="", ylab=paste(name.ds, ".res (", unit.ds, ")", sep=""))				
          abline(h=0)
          lines(time.ds, res.med, col="black", lwd=2)
          axis(1, time.pr, time.txt)	
        } else {
          if (has.space) { # plot map
            .map(res, paste(name.ds, ".res (", unit.ds, ")", sep=""))			
          } else {
            barplot(res, xlab="", ylab=paste(name.ds, ".res (", unit.ds, ")", sep=""))
            box()
          }
        }
        
        
        # plot scatterplot
        #-----------------
        
        par(new=TRUE, fig=c(0.66, 1, 0.33, 0.66))
        if (is.ts | has.space) {
          ScatterPlot(as.vector(obs), as.vector(sim), xlim=ylim, ylim=ylim, xlab=paste(name.ds, ".obs (", unit.ds, ")", sep=""), ylab=paste(name.ds, ".sim (", unit.ds, ")", sep=""), col.global="black", col.points="grey", fits=fits, nrpoints=0)
          abline(0,1)
        } else {
          plot.new()
        }
        obj <- ObjFct(as.vector(sim), as.vector(obs))
        if (is.ts | has.space) {
          txt <- c(ObjFct2Text(obj, "Cor"), ObjFct2Text(obj, "MEF"), ObjFct2Text(obj, "RMSE"), paste("Cost =", signif(cost.l$per.ds[d])))
        } else {
          txt <- c(ObjFct2Text(obj, "Pbias"), paste("Cost =", signif(cost.l$per.ds[d])))
        }
        legend("topleft", txt, bty="n", cex=1, text.col="red")	
        
        
        # plot map of residuals
        #----------------------
        
        if (is.ts) {
          obs.sp <- apply(obs, 2, mean, na.rm=TRUE)
          sim.sp <- apply(sim, 2, mean, na.rm=TRUE)
          res.sp <- sim.sp - obs.sp
          par(new=TRUE, fig=c(0, 0.66, 0, 0.33))
          .map(res.sp, paste(name.ds, ".mean.res (", unit.ds, ")", sep=""))	
          
        } # end is.ts
        
        
        # plot residuals vs. latitude
        #----------------------------
        
        if (!is.ts & has.space) {
          # vs. latitude
          par(new=TRUE, fig=c(0, 0.33, 0, 0.33))
          ScatterPlot(xy[,2], as.vector(res), xlab="Latitude (N)", ylab=paste(name.ds, ".res (", unit.ds, ")", sep=""), col.global="black", col.points="grey", fits=fits, nrpoints=0)
          abline(h=0)
          if (!AllEqual(as.vector(xy[,2])) & !AllEqual(as.vector(res))) {
            obj <- ObjFct(as.vector(res), as.vector(xy[,2]))$Cor
            legend("topleft", paste("Cor =", signif(obj, 3)), bty="n", cex=1, text.col="red")	
          }
          
          # vs. longitude
          par(new=TRUE, fig=c(0.33, 0.66, 0, 0.33))
          ScatterPlot(xy[,1], as.vector(res), xlab="Longitude (E)", ylab=paste(name.ds, ".res (", unit.ds, ")", sep=""), col.global="black", col.points="grey", fits=fits, nrpoints=0)
          abline(h=0)
          if (!AllEqual(as.vector(xy[,1])) & !AllEqual(as.vector(res))) {
            obj <- ObjFct(as.vector(res), as.vector(xy[,1]))$Cor[1]
            legend("topleft", paste("Cor =", signif(obj, 3)), bty="n", cex=1, text.col="red")	
          }
        }
        
        
        # plot residuals ~ fitted
        #------------------------		
        
        par(new=TRUE, fig=c(0.66, 1, 0, 0.33))
        ScatterPlot(as.vector(sim), as.vector(res), xlab=paste(name.ds, ".sim (", unit.ds, ")", sep=""), ylab=paste(name.ds, ".res (", unit.ds, ")", sep=""), col.global="black", col.points="grey", fits=fits, nrpoints=0)
        abline(h=0)
        if (!AllEqual(as.vector(sim)) & !AllEqual(as.vector(res))) {
          obj <- ObjFct(as.vector(res), as.vector(sim))$Cor[1]
          legend("topleft", paste("Cor =", signif(obj, 3)), bty="n", cex=1, text.col="red")	
        }
        
      } else { # end if (has.sim)
        
        # map of observations
        #--------------------
        
        if (has.space & is.ts) {
          obs.sp <- apply(obs, 2, mean, na.rm=TRUE)
          par(new=TRUE, fig=c(0, 0.66, 0.33, 0.66))
          .map(obs.sp, paste(name.ds, ".mean.obs (", unit.ds, ")", sep=""))	
        }
        
      }
    } # end if is.na	
  } # end loop over data streams
  suppressWarnings(par(par0))
})	
