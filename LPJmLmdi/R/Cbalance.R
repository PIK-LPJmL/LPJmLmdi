Cbalance <- structure(function(
   ##title<< 
   ## Calculate global C balance, C fluxes and stocks
   ##description<<
   ## The function takes numeric vectors or NetCDF files with values of C fluxes and stocks, and calculates C balances and turnover times [years] (see details). In case of NetCDF files, global total C fluxes and stocks [PgC year-1] are computed from NetCDF files. Thereby the input data unit needs to be [gC m-2] for stocks and [gC m-2 year-1] for fluxes. However, the argument scale is a multiplier that can be used to convert to the original unit to [gC m-2]. The results are returned as a data.frame (table). If some values or files are not provided (i.e. NA), the function will first try to compute these from other metrics (see details). 

   gpp=NA,
   ### numeric vector or NetCDF file of gross primary production 
   
   npp=NA,
   ### numeric vector or NetCDF file of net primary production
   
   ra=NA,
   ### numeric vector or NetCDF file of autotrophic respiration
   
   rh=NA,
   ### numeric vector or NetCDF file of heterotrophic respiration
   
   reco=NA,
   ### numeric vector or NetCDF file of ecosystem respiration
   
   firec=NA,
   ### numeric vector or NetCDF file of fire C emissions
   
   estab=NA,
   ### numeric vector or NetCDF file of establishment C flux (specific to LPJ)
   
   harvest=NA,
   ### numeric vector or NetCDF file of C removal from vegetation through harvest
   
   vegc=NA,
   ### numeric vector or NetCDF file of vegetation C stocks (or biomass)
   
   soilc=NA,
   ### numeric vector or NetCDF file of soil C stocks
   
   litc=NA,
   ### numeric vector or NetCDF file of litter C stocks
   
   scale=1,
   ### multiplier to convert original units to gC m-2 (stocks) or gC m-2 year-1 (fluxes)
   
   ti=NA,
   ### time axis of the data. In case of NetCDF files, time will be extracted from the files.
   
   mask=NA,
   ### A mask in a NetCDF file in order to compute the C fluxes, stocks, balances and turnover times only for specific regions.
	
	...
	### further arguments (currently not used)
		
	##details<<
	## The function computes (global) terrestrial C balances based on given input data. The used terminology is based on Schulze (2006) and Chapin et al. (2006). The following equations are used:
   ## \itemize{ 
   ## \item{ Net primary production NPP = GPP - Ra }
   ## \item{ Ecosystem respiration Reco = Rh + Ra }
	 ## \item{ Net ecosystem exchange NEE = Reco - GPP = Rh - NPP}
   ## \item{ Net biome productivity NBP = (GPP + Estab) - (Reco + FireC + Harvest) }
   ## }
   ## Vegetation and total ecosystem turnover times are computed based on the formulas in Carvalhais et al. (2014) and Thurner et al. (2016):
   ## \item{ Vegetation turnover time: TauVeg_NPP = VegC / NPP }
   ## \item{ Vegetation turnover time based on GPP is a approximiation to the real vegetation turnover time (TauVeg_NPP) assuming that NPP is around 50% of GPP: TauVeg_GPP = VegC / ((GPP+Estab) * 0.5) }
   ## \item{ Total ecosystem turnover time as in Carvalhais et al. (2014): TauEco_GPP = (VegC + SoilC + LitC) / (GPP+Estab) }
   ## \item{ Total ecosystem turnover time based on Reco: TauEco_Reco = (VegC + SoilC + LitC) / Reco }
	 ## \item{ Total ecosystem turnover time based on Reco and disturbances: TauEco_Dist = (VegC + SoilC + LitC) / (Reco + FireC + Harvest) }
	## }
		
	##references<< 
  ## Carvalhais et al. (2014), Global covariation of carbon turnover times with climate in terrestrial ecosystems, Nature, 514(7521), 213–217, doi:10.1038/nature13731.
  ## Chapin et al. (2006), Reconciling Carbon-cycle Concepts, Terminology, and Methods, Ecosystems, 9(7), 1041–1050, doi:10.1007/s10021-005-0105-7.
  ## Schulze (2006), Biological control of the terrestrial carbon sink, Biogeosciences, 3(2), 147–166, doi:10.5194/bg-3-147-2006.
  ## Thurner, M., C. Beer, N. Carvalhais, M. Forkel, M. Santoro, M. Tum, and C. Schmullius (2016), Large‐scale variation in boreal and temperate forest carbon turnover rate is related to climate, Geophysical Research Letters, doi:10.1002/2016GL068794.

	##seealso<<
	## \code{\link{Turnover}}
) {

   # read files
   #-----------
   
   if (!is.na(mask) & is.character(mask)) mask.r <- raster(mask)
   
   # function to read files and to compute global totals [PgC]
   .read <- function(metric) {
      if (!is.character(metric[1]) | all(is.na(metric))) {
         return(metric)
      } else {
         # read file
         if (!file.exists(metric)) stop(paste(metric, "does not exist."))
         message(paste("Cbalance read:", metric))
         i <- InfoNCDF(metric)
         if (length(i$time) > 1) x <- brick(metric)
         if (length(i$time) == 1) x <- raster(metric)
         
         # mask file
         if (!is.na(mask)) {
            ext <- GetCommonExtent(list(x, mask.r))
            x <- crop(x, ext)
            mask.r <- crop(mask.r, ext)
            x <- raster::mask(x, mask.r)
         }
         
         # apply scalar to convert to [gC m-2]
         x <- x * scale
         
         # multiply with area [gC m-2] -> [gC]
         a <- raster::area(x) * 1000000 # km2 -> m2
         x <- x * a 
         
         # [gC] -> [PgC]
         x <- x * 1/10^15
         
         # spatial aggregation
         s <- cellStats(x, "sum")
         return(s)
      }
   }
   
   # get time information from NetCDF files
   if (all(is.na(ti))) {
      ti <- llply(list(gpp, npp, ra, rh, reco, firec, estab, harvest, vegc, litc, soilc), function(metric) {
         ti <- NA
         if (is.character(metric[1])) {
            if (file.exists(metric)) ti <- InfoNCDF(metric)$time
         }
         return(ti)
      })
      ti <- ti[[which.max(unlist(llply(ti, length)))]]
   }
   
   # read files and compute global totals
   gpp <- .read(gpp)
   npp <- .read(npp)
   ra <- .read(ra)
   rh <- .read(rh)
   reco <- .read(reco)
   firec <- .read(firec)
   estab <- .read(estab)
   harvest <- .read(harvest)
   vegc <- .read(vegc)
   litc <- .read(litc)
   soilc <- .read(soilc)

   
   # check and compute metrics
   #--------------------------

   # make all vectors the same length
   n <- max(length(gpp), length(npp), length(ra), length(rh), length(reco), length(firec), length(estab), length(harvest), length(vegc), length(soilc), length(litc))
   if (length(gpp) < n) gpp <- rep(gpp[1], n)
   if (length(npp) < n) npp <- rep(npp[1], n)
   if (length(ra) < n) ra <- rep(ra[1], n)
   if (length(rh) < n) rh <- rep(rh[1], n)
   if (length(reco) < n) reco <- rep(reco[1], n)
   if (length(firec) < n) firec <- rep(firec[1], n)
   if (length(estab) < n) estab <- rep(estab[1], n)
   if (length(harvest) < n) harvest <- rep(harvest[1], n)
   
   # set time to 1:n if it is still NULL
   if (all(is.na(ti))) ti <- 1:n

   # try to compute metrics iteratively
   for (i in 1:3) { 
      gpp[is.na(gpp)] <- npp[is.na(gpp)] + ra[is.na(gpp)]
      npp[is.na(npp)] <- gpp[is.na(npp)] - ra[is.na(npp)]
      ra[is.na(ra)] <- gpp[is.na(ra)] - npp[is.na(ra)]
      ra[is.na(ra)] <- reco[is.na(ra)] - rh[is.na(ra)]
      reco[is.na(reco)] <- ra[is.na(reco)] + rh[is.na(reco)]
      rh[is.na(rh)] <- reco[is.na(rh)] - ra[is.na(rh)]
   }
   
   # set missing to 0
   gpp[is.na(gpp)] <- 0
   npp[is.na(npp)] <- 0
   ra[is.na(ra)] <- 0
   rh[is.na(rh)] <- 0
   reco[is.na(reco)] <- 0
   firec[is.na(firec)] <- 0
   estab[is.na(estab)] <- 0
   harvest[is.na(harvest)] <- 0
   vegc[is.na(vegc)] <- 0
   litc[is.na(litc)] <- 0
   soilc[is.na(soilc)] <- 0
   
   
   # calculate fluxes and turnover
   #------------------------------
   
   # calculate NEE
   nee <- reco - gpp

   # calculate NBP
   nbp <- (gpp + estab) - (reco + firec + harvest) 
   
   # calculate turnover times
   tauveg_gpp <- Turnover(vegc, (gpp+estab) * 0.5)
   tauveg_npp <- Turnover(vegc, npp)
   taueco_gpp <- Turnover(vegc+litc+soilc, gpp+estab)
   taueco_reco <- Turnover(vegc+litc+soilc, reco)
   taueco_dist <- Turnover(vegc+litc+soilc, reco+firec+harvest) 
   
   
   # prepare data.frame for results
   #-------------------------------

   df <- data.frame(time=ti, GPP=gpp, NPP=npp, Ra=ra, Rh=rh, Reco=reco, FireC=firec, Estab=estab, Harvest=harvest, NEE=nee, NBP=nbp, VegC=vegc, LitC=litc, SoilC=soilc, TauVeg_NPP=tauveg_npp, TauVeg_GPP=tauveg_gpp, TauEco_GPP=taueco_gpp, TauEco_Reco=taueco_reco, TauEco_Dist=taueco_dist)
   
   
   # compute temporal mean values
   #-----------------------------
   
   if (n > 1) {
      # mean of fluxes and stocks
      mean.df <- as.data.frame(t(apply(df[,-1], 2, mean, na.rm=TRUE)))
      
      # recompute trunover times based on mean values
      mean.df <- Cbalance(gpp=mean.df$GPP, npp=mean.df$NPP, ra=mean.df$Ra, rh=mean.df$Rh, firec=mean.df$FireC, estab=mean.df$Estab, harvest=mean.df$Harvest, vegc=mean.df$VegC, litc=mean.df$LitC, soilc=mean.df$SoilC, ti=df$time[1])
      
      df2 <- rbind(df, mean.df)
      df2$time <- c(as.character(df$time, "%Y"), "mean")  
   } else {
      df2 <- df
   }
   rownames(df2) <- 1:nrow(df2)
   class(df2) <- c("Cbalance", "data.frame")
   return(df2)
}, ex=function() {

# with some typical numbers for the global C budget:
cbal <- Cbalance(gpp=123, npp=61, rh=57, firec=2, vegc=400, soilc=2400)
cbal
plot(cbal)

## using time series::
#cbal <- Cbalance(gpp=118:128, npp=(118:128)*rnorm(11, 0.5, 0.1), rh=57, firec=runif(11, 0, 4), harvest=2, vegc=400, soilc=2400)
#cbal
#plot(cbal)


})


plot.Cbalance <- structure(function(
   ##title<< 
   ## Plots a C balance
   ##description<<
   ## The function takes an object of class \code{\link{Cbalance}} and creates time series plots or barplots.

   x,
   ### object of class \code{\link{Cbalance}}
   
   what=NULL,
   ### Which variables of C balance to plot? If NULL, sole plots are generated automatically.
   
   trend=TRUE, 
   ### Compute trends?
   
   baseunit="PgC", 
   ### unit of C stocks
   
   ylab=NULL,
   ### labels for y-axis
   
	...
	### further arguments (currently not used)
		
	##details<<
	
		
	##references<< 
	## 

) { 

   # function to create units
   .makeUnits <- function(what, baseunit) {
      unit <- rep(baseunit, length(what))
      .unitflux <- function(unit) paste(unit, "yr-1")
      unit[what == "GPP"] <- .unitflux(unit[what == "GPP"])
      unit[what == "NPP"] <- .unitflux(unit[what == "NPP"])
      unit[what == "Ra"] <- .unitflux(unit[what == "Ra"])
      unit[what == "Rh"] <- .unitflux(unit[what == "Rh"])
      unit[what == "Reco"] <- .unitflux(unit[what == "Reco"])
      unit[what == "NEE"] <- .unitflux(unit[what == "NEE"])
      unit[what == "NBP"] <- .unitflux(unit[what == "NBP"])
      unit[grepl("Tau", what)] <- "yr"
      return(unit)
   }
   
   # function to plot time series
   .plotts <- function(x, what, baseunit, ylab=NULL) {
      n <- nrow(x)
      mean.df <- x[n,] # keep mean
      x <- x[-n,] # remove mean
      ti <- as.numeric(x$time)
      unit <- .makeUnits(what, baseunit=baseunit)
      ylim <- range(x[what], na.rm=TRUE)
      ylim[2] <- ylim[2] + diff(ylim) * 0.25
      #if (is.null(ylab)) ylab <- paste0(paste(what, collapse=" | "), " (", unit[1], ")")
      if (is.null(ylab)) ylab <- unit[1]
      cols <- brewer.pal(9, "Set1")[1:length(what)]
      plot(ti, rep(1, length(ti)), type="n", ylim=ylim, ylab=ylab, xlab="")
      trd.txt <- NULL
      for (i in 1:length(what)) {
         if (trend & !AllEqual(unlist(x[what[i]]))) {
            require(greenbrown)
            ts <- ts(unlist(x[what[i]]), start=ti[1], frequency=1)
            trd <- Trend(ts, breaks=0)
            plot(trd, col=cols[i], add=TRUE)
            trd.txt <- c(trd.txt, paste0("d = ", signif(trd$slope, 1) , ", p = ", signif(trd$pval, 1)))
         } else {
            lines(ti, unlist(x[what[i]]), type="l", col=cols[i])
         }
      }
      txt <- paste(what, "mean =", round(mean.df[what], 2))
      if (trend) txt <- paste(txt, trd.txt, sep=", ")
      legend("top", txt, text.col=cols, bty="n")
   }
   
   # function to plot barplot
   .plotbp <- function(x, what, baseunit, ylab=NULL) {
      unit <- .makeUnits(what, baseunit=baseunit)
      ylim <- range(c(0, x[what]), na.rm=TRUE)
      #if (is.null(ylab)) ylab <- paste0(paste(what, collapse=" | "), " (", unit[1], ")")
      if (is.null(ylab)) ylab <- unit[1]
      cols <- brewer.pal(9, "Set1")[1:length(what)]
      bp <- barplot(unlist(x[what]), names=what, ylim=ylim, ylab=ylab, xlab="")
      text(bp, x[what], round(x[what], 2), pos=1)
      box()
   }
   
   n <- nrow(x)
   if (n == 1) {
   
      # plot barplot
      #-----------------
      
      if (!is.null(what)) {
         .plotbp(x, what, baseunit)
      } else {
         op <- par()
         DefaultParL(mfrow=c(3,2))
         .plotbp(x, c("GPP", "Reco"), baseunit)
         .plotbp(x, c("NPP", "Ra", "Rh"), baseunit)
         .plotbp(x, c("NBP"), baseunit)
         .plotbp(x, c("VegC", "SoilC"), baseunit)
         .plotbp(x, c("TauVeg_NPP", "TauVeg_GPP"), baseunit)
         .plotbp(x, c("TauEco_GPP", "TauEco_Reco", "TauEco_Dist"), baseunit)
         par(op)
      }
   
   } else {
      
      # plot time series
      #-----------------
      
      if (!is.null(what)) {
         .plotts(x, what, baseunit)
      } else {
         op <- par()
         DefaultParL(mfrow=c(3,2))
         .plotts(x, c("GPP", "Reco"), baseunit)
         .plotts(x, c("NPP", "Ra", "Rh"), baseunit)
         .plotts(x, c("NBP"), baseunit)
         .plotts(x, c("VegC", "SoilC"), baseunit)
         .plotts(x, c("TauVeg_NPP", "TauVeg_GPP"), baseunit)
         .plotts(x, c("TauEco_GPP", "TauEco_Reco", "TauEco_Dist"), baseunit)
         par(op)
      }
   }
}, ex=function() {

# with some typical numbers for the global C budget:
cbal <- Cbalance(gpp=123, npp=61, rh=57, firec=2, vegc=400, soilc=2400)
cbal
plot(cbal)

## using time series::
#cbal <- Cbalance(gpp=118:128, npp=(118:128)*rnorm(11, 0.5, 0.1), rh=57, firec=runif(11, 0, 4), harvest=2, vegc=400, soilc=2400)
#cbal
#plot(cbal)


})

