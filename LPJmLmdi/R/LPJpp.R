LPJpp <- structure(function(
   ##title<< 
   ## Post-process LPJmL model output
   ##description<<
   ## The function converts binary LPJmL output files to NetCDF and calculates summary statistics. Please note, climate data operators (CDO) is required.

   path, 
   ### directory with LPJmL outputs in *.bin format
   
   start=1982, 
   ### first year for which the data should be converted to NetCDF
   
   end=2011, 
   ### last year for which the data should be converted to NetCDF
   
   sim.start.year=1901,
   ### first year of the simulation
   
   run.name="LPJ", 
   ### name of the LPJmL run (will be part of the file names)

   run.description="LPJ run",
   ### description of the LPJmL run

   provider="M. Forkel, matthias.forkel@geo.tuwien.ac.at", 
   ### name of the provider

   creator=provider,
   ### name of the creator
	
	reference="Sitch et al. 2003 GCB, Gerten et al. 2004 J. Hydrol., Thonicke et al. 2010 BG, Schaphoff et al. 2013 ERL, Forkel et al. 2014 BG",
	
	lpj.df = NULL,
	### A data.frame with information about LPJmL outputs that should be post-processed. If NULL, a set of default outputs will post-processed. See details for the required structure of this data.frame.
	
	convert = TRUE,
	### Convert files in lpj.df to NetCDF?
	
	calc.nbp = FALSE,
	### Calculate net biome productivity? NBP = Rh + FireC + HarvestC - (NPP + Estab)
	
	calc.cbalance = FALSE,
	### Calculate global total C stocks, fluxes, balances, and turnover times?
	
	calc.tau = FALSE,
	### Calculate spatial fields of turnover times?
	
	calc.et = FALSE,
	### Calculate evapotranspiration? ET = transp + evap + interc
	
	calc.tree = FALSE,
	### Calculate total tree cover? See also the argument pft.istree
	
	pft.istree = 2:9,
	### Which bands in fpc.bin represents tree?
	
	mask = NA,
	### A mask in a NetCDF file in order to compute the C fluxes, stocks, balances and turnover times only for specific regions.
	
	...
	### further arguments (currently not used)
		
	##details<<
	## The data.frame 'lpj.df' should have the following columns
   ## \itemize{ 
	## \item{ \code{file} name of binary LPJmL output file (e.g. mgpp.bin)}
   ## \item{ \code{var.name} short name of the variable (e.g. GPP)}
   ## \item{ \code{var.unit} units of the variables in the input file (e.g. "gC m-2")}
   ## \item{ \code{var.longname} (optional) long name of the variable (e.g. "Gross primary production"). If this column is not provided 'var.name' will be used instead.}
   ## \item{ \code{var.agg.fun} (optional) name of a function to aggregate the varibale to annual values (e.g "sum", "mean", "min", "max", or NA (no aggregation)). If this column is not provided, aggregations will be not computed.}
   ## \item{ \code{subset.start} (optional) This can be used to additionally subset the NetCDF files to a shorter time period. Set to a year (e.g. 2000) or NA.}
   ## \item{ \code{subset.end} (optional) This can be used to additionally subset the NetCDF files to a shorter time period. Set to a year (e.g. 2001) or NA. }
   ## \item{ \code{stat.annual} (optional) Set to TRUE to compute statistical values based on annual aggregated data. If this is not provided, statistical values will be not computed}
   ## \item{ \code{stat.monthly} (optional) Set to TRUE to compute statistical values based on monthly data. If this is not provided, statistical values will be not computed}
	## }
	
	##references<< No reference.	
) {

   wd <- getwd()

   # default lpj.df
   lpj0.df <- data.frame(
      file=c("mgpp.bin", "mnpp.bin", "mrh.bin", "mfirec.bin", "vegc.bin", "soilc.bin", "litc.bin", "mfapar.bin", "malbedo.bin", "fpc.bin", "mswc1.bin", "mswc2.bin", "mevap.bin", "mtransp.bin", "minterc.bin", "flux_estab.bin", "flux_harvest.bin"),
      var.name=c("GPP", "NPP", "Rh", "FireC", "VegC", "SoilC", "LitC", "FAPAR", "Albedo", "FPC", "SWC1", "SWC2", "Evap", "Transp", "Interc", "Estab", "Harvest"),
      var.unit=c("gC m-2", "gC m-2", "gC m-2", "gC m-2", "gC m-2", "gC m-2", "gC m-2", "", "", "", "", "", "mm", "mm", "mm", "gC m-2", "gC m-2"),
      var.longname=c("Gross Primary Production", "Net Primary Production", "Heterotrophic respiration", "Fire C emissions", "Biomass", "Soil organic C", "Litter C", "Fraction of absorbed photosynthetic active radition", "Albedo", "Foliar projective cover", "Soil water content in first layer", "Soil water content in second layer", "Soil evaporation", "Transpiration", "Interception", "Estab", "Harvest"),
      var.agg.fun=c("sum", "sum", "sum", "sum", NA, NA, NA, "max", "min", NA, "mean", "mean", "sum", "sum", "sum", NA, NA)
   )

   # check or create lpj.df
   if (!is.null(lpj.df)) {
      bool <- "file" %in% colnames(lpj.df) & "var.name" %in% colnames(lpj.df) & "var.unit" %in% colnames(lpj.df) & "var.longname" %in% colnames(lpj.df) & "var.agg.fun" %in% colnames(lpj.df)
      if (!bool) stop("Columns are missing or wrongly named in 'lpj.df'.'")
   } else {
      lpj.df <- lpj0.df
	}
	
	# process Transp, Interc, and Evap to calculate ET
	if (calc.et) { # required variables to compute ET
	   if (!("Transp" %in% lpj.df$var.name)) lpj.df <- rbind(lpj.df, lpj0.df[grep("Transp", lpj0.df$var.name), ])
	   if (!("Interc" %in% lpj.df$var.name)) lpj.df <- rbind(lpj.df, lpj0.df[grep("Interc", lpj0.df$var.name), ])
	   if (!("Evap" %in% lpj.df$var.name)) lpj.df <- rbind(lpj.df, lpj0.df[grep("Evap", lpj0.df$var.name), ])
	}
	
	
	# add information to lpj.df
	if (is.null(lpj.df$subset.start)) lpj.df$subset.start <- NA
	if (is.null(lpj.df$subsetend)) lpj.df$subset.end <- NA
	if (is.null(lpj.df$longname)) lpj.df$longname <- lpj.df$name
	if (is.null(lpj.df$var.agg.fun)) lpj.df$var.agg.fun <- NA
	if (is.null(lpj.df$stat.annual)) lpj.df$stat.annual <- FALSE
	if (is.null(lpj.df$stat.monthly)) lpj.df$stat.monthly <- FALSE
	
	
	#------------------------------------------------
   # convert for each variable *.bin files to NetCDF
   #------------------------------------------------
   
   message(paste("LPJ post-processing:", path))
   
   # internal function to subset and to compute statistics on subset
   .subset <- function(files.nc, subset.start, subset.end, var.agg.fun, stat.annual, stat.monthly) {
      for (i in 1:length(files.nc)) {
         info <- InfoNCDF(files.nc[i])
         g1 <- grep(subset.start, format(info$time, "%Y"))[1]
         g2 <- grep(subset.end, format(info$time, "%Y"))
         g2 <- g2[length(g2)]
         ofile <- unlist(strsplit(files.nc[i], ".", fixed=TRUE)) 
         ofile[5] <- subset.start
		   ofile[6] <- subset.end
		   ofile <- paste(ofile, collapse=".")
		   file.remove(ofile)
         cdo <- paste0("cdo seltimestep,", paste(g1:g2, collapse=","), " ", files.nc[i], " ", ofile)
         system(cdo)
            
         # aggregation and statistics on subset
         AggregateNCDF(ofile, fun.agg = var.agg.fun, stat.annual = stat.annual, stat.monthly=stat.monthly, msc.monthly=stat.monthly, path.out = path, stats="mean")
      } # end for 
   }

   if (convert) {
	   # get the file names of LPJ outputs
	   setwd(path)
	   files.lpj <- list.files(pattern=".bin")
	   files.lpj <- files.lpj[-grep("grid", files.lpj)]

	   # check if for lpj files meta-information exists: process only files with meta data
	   run.vars <- na.omit(match(files.lpj, lpj.df$file))
	   run.vars <- sort(run.vars)

	   # apply for all variables: convert to NetCDF
	   l <- llply(as.list(run.vars), .fun=function(v) {
	      message(paste("LPJ post-processing:", as.character(lpj.df$var.name[v])))
	
	      # convert to NetCDF
         files.nc <- LPJ2NCDF(file=as.character(lpj.df$file[v]), var.name=as.character(lpj.df$var.name[v]), var.unit=as.character(lpj.df$var.unit[v]), var.longname=as.character(lpj.df$var.longname[v]), start=start, end=end, sim.start.year=sim.start.year, run.name=run.name, run.description=run.description, provider=provider, creator=creator, reference=reference)
         
         # aggregation and statistics
         #if (!is.na(lpj.df$var.agg.fun[v]) | lpj.df$stat.annual[v] | lpj.df$stat.monthly[v]) {
            for (i in 1:length(files.nc)) {
               AggregateNCDF(files.nc[i], fun.agg = as.character(lpj.df$var.agg.fun[v]),
                  stat.annual = lpj.df$stat.annual[v],
	               stat.monthly  = lpj.df$stat.monthly[v],
                  msc.monthly = lpj.df$stat.annual[v],
                  path.out = path, stats="mean")
             }
         #}
         
         # subset and statistics on subset?
         subset.start <- max(c(start, as.character(lpj.df$subset.start[v])), na.rm=TRUE)
         subset.end <- min(c(end, as.character(lpj.df$subset.end[v])), na.rm=TRUE)
         if (subset.start > start | subset.end < end) {
             .subset(files.nc, subset.start, subset.end, var.agg.fun=lpj.df$var.agg.fun[v], stat.annual=lpj.df$stat.annual[v], stat.monthly=lpj.df$stat.monthly[v]) 
         } # end if subset

		   return(na.omit(files.nc))
	   }, .parallel=FALSE)
	} # end if convert
	
	
	#---------------------------------------------------
	# global total C fluxes, stocks, balances and stocks
	#---------------------------------------------------
	
	if (calc.cbalance) {
	   message("LPJ post-processing: calculate global C balance, stocks and fluxes")
	   
	   # function to get NetCDF files of a specific variabe
      .getFile <- function(var) {
         files <- c(list.files(pattern=".annual.sum.nc", recursive=TRUE), list.files(pattern=".365days.nc", recursive=TRUE))
         files <- files[grep(var, files)]
         files <- files[grep(paste(start, end, sep="."), files)]
         if (length(files) == 0) files <- NA
         return(files)
      }
      
      # calculate global C balance
      setwd(path)
      cbal <- Cbalance(gpp=.getFile("GPP"), npp=.getFile("NPP"), rh=.getFile("Rh"), firec=.getFile("FireC"), estab=.getFile("Estab"), harvest=.getFile("Harvest"), vegc=.getFile("VegC"), litc=.getFile("LitC"), soilc=.getFile("SoilC"))
      
      setwd(path)
      write.table(cbal, paste0(run.name, ".Cbalance.global.", start, ".", end, ".table.txt"))
      
      pdf(paste0(run.name, ".Cbalance.global.", start, ".", end, ".ts.pdf"), width=7, height=7)
      plot(cbal)
      dev.off()
      
      # calculate C balance for masked regions
      if (!is.na(mask)) {
         cbal <- Cbalance(gpp=.getFile("GPP"), npp=.getFile("NPP"), rh=.getFile("Rh"), firec=.getFile("FireC"), estab=.getFile("Estab"), harvest=.getFile("Harvest"), vegc=.getFile("VegC"), litc=.getFile("LitC"), soilc=.getFile("SoilC"), mask=mask)
         
         setwd(path)
         write.table(cbal, paste0(run.name, ".Cbalance.masked.", start, ".", end, ".table.txt"))
         
         pdf(paste0(run.name, ".Cbalance.masked.", start, ".", end, ".ts.pdf"), width=7, height=7)
         plot(cbal)
         dev.off()
         
      }
	}
	
	
	#------------------------
	# calculate NetCDF of NBP
	#------------------------
	
	if (calc.nbp) {
	   message("LPJ post-processing: calculate NBP")
	   LPJppNBP(path, start=start, end=end, sim.start.year=sim.start.year)
	   setwd(path)
	   file.nbp <- list.files(pattern="NBP")
	   AggregateNCDF(file.nbp, fun.agg = "sum", stat.annual=TRUE, stat.monthly=FALSE, msc.monthly=TRUE, path.out = path, stats="mean")
	}
	
	
   #-----------------------------
	# calculate evapotranspiration = Transp + Evap + Interc
	#-----------------------------
	
	if (calc.et) {
	   message("LPJ post-processing: calculate ET")
	   # calc ET
		setwd(path)
		file.transp <- list.files(pattern="Transp")
		file.transp <- file.transp[grep(paste(start, end, "30days.nc", sep="."), file.transp)]
		file.evap <- list.files(pattern="Evap")
		file.evap <- file.evap[grep(paste(start, end, "30days.nc", sep="."), file.evap)]
		file.interc <- list.files(pattern="Interc")
		file.interc <- file.interc[grep(paste(start, end, "30days.nc", sep="."), file.interc)]
		file.et <- gsub("Transp", "ET", file.transp)
		cdo <- paste("cdo enssum", paste(c(file.transp, file.evap, file.interc), collapse=" "), file.et)
		system(cdo)
	
		# compute statistics
		setwd(path)
		v <- grep("Transp", lpj.df$var.name)
		if (!is.na(lpj.df$var.agg.fun[v]) | lpj.df$stat.annual[v] | lpj.df$stat.monthly[v]) {
         AggregateNCDF(file.et, fun.agg = as.character(lpj.df$var.agg.fun[v]),
            stat.annual = lpj.df$stat.annual[v],
            stat.monthly  = lpj.df$stat.monthly[v],
            msc.monthly = lpj.df$stat.monthly[v],
            path.out = path, stats="mean")
		}
      
      # subset and statistics on subset?
      subset.start <- max(c(start, lpj.df$subset.start[v]), na.rm=TRUE)
      subset.end <- min(c(end, lpj.df$subset.end[v]), na.rm=TRUE)
      if (subset.start > start | subset.end < end) {
         .subset(file.et, subset.start, subset.end, var.agg.fun=lpj.df$var.agg.fun[v], stat.annual=lpj.df$stat.annual[v], stat.monthly=lpj.df$stat.monthly[v]) 
      }
	}
	
	
	#-------------------------
	# calculate turnover times
	#-------------------------
	
	if (calc.tau) {
	   message("LPJ post-processing: turnover times")
	
	   # function to get NetCDF files of a specific variabe
      .getFile <- function(var) {
         files <- list.files(pattern=".mean.nc", recursive=TRUE)
         files <- files[grep(var, files)]
         if (length(files) == 0) files <- NA
         return(files)
      }

      # add soil and litter C
      file.soilc <- .getFile("SoilC")
      file.litc <- .getFile("LitC")
      cdo <- paste("cdo add", file.soc, file.litc, gsub("SoilC", "SoilLitC", file.soilc))
      system(cdo)
      
      file.vegc <- .getFile("VegC")
      file.npp <- .getFile("NPP")
      file.gpp <- .getFile("GPP")
      file.soc <- .getFile("SoilLitC")
      
      # combinations of fluxes and stocks
      combn.m <- rbind(
         expand.grid(file.vegc, file.gpp),
         expand.grid(file.vegc, file.npp),
         expand.grid(file.soc, file.gpp)
      )
      
      # calculate tau for each combination
      for (i in 1:nrow(combn.m)) {
         stock.r <- raster(as.character(combn.m[i,1]))
         flux.r <- raster(as.character(combn.m[i,2]))
         flux.r[flux.r < 5] <- NA # ignore small fluxes
         tau.r <- stock.r / flux.r
         istock <- InfoNCDF(as.character(combn.m[i,1]))
         iflux <- InfoNCDF(as.character(combn.m[i,2]))
         var.name <- paste("Tau_", istock$var$name[1], format(istock$time, "%Y"), "_", iflux$var$name[1], format(iflux$time, "%Y"), sep="")
         WriteNCDF4(list(tau.r), var.name=var.name, var.unit="years", time=istock$time, data.name=run.name, overwrite=TRUE)
      } # end if for
	} # end if calc tau
	
	
	#---------------------
	# calculate tree cover
	#---------------------
	
	if (calc.tree) {
	   message("LPJ post-processing: calculate tree cover")
		setwd(path)
		# get all FPC files for tree PFTs
		files.fpc <- list.files(pattern="FPC")
		files.fpc <- files.fpc[grepl(paste(start, end, "365days.nc", sep="."), files.fpc)]
		file.lu <- files.fpc[grep("FPC_1.", files.fpc, fixed=TRUE)[1]] 
		
		# select only tree PFTs
		b <- NULL
		for (i in 1:length(pft.istree)) b <- c(b, grep(paste("FPC_", pft.istree[i], sep=""), files.fpc))
		files.fpc <- files.fpc[b]
		files.fpc <- unique(files.fpc)

		# total tree FPC
		file.fpctree <- gsub("FPC_1", "FPCTree", file.lu)
		cdo <- paste("cdo enssum", paste(files.fpc, collapse=" "), file.fpctree)
		system(cdo)
		file.fpctree2 <- gsub("FPC_1", "FPCTree2", file.lu)
		cdo <- paste("cdo setname,Tree", file.fpctree, file.fpctree2) 
		system(cdo)
		
		# correct tree cover by landuse fraction
		file.tree <- gsub("FPC_1", "Tree", file.lu)
		cdo <- paste("cdo mul", file.fpctree2, file.lu, file.tree)
		system(cdo)
		file.remove(c(file.fpctree, file.fpctree2))
		
		# compute statistics
		setwd(path)
		v <- grep("FPC", lpj.df$var.name)
		paste("cdo setname,Tree", file.tree) 
	
	}

	setwd(wd)
})


