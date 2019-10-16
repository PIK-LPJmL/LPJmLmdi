plot.LPJpar <- structure(function(
	##title<< 
	## Plot parameters in 'LPJpar' object.
	##description<<
	## 
	
	x,
	### object of class 'LPJpar'
	
	par.name = NULL,
	### name(s) of the parameters that should be plotted
	
	uncertainty="uncertainty.005",
	### name of the uncertainty estimate in LPJpar that should be used to plot posterior uncertainties
	
	unc.change = FALSE,
	### plot the change in uncertainty? If TRUE the function plots the fraction of the posterior uncertainty relative to the prior, i.e. uncertainty / abs(upper - lower)
	
	col = NULL,
	### vector of colours for PFT-specific parameters
	
	ylim = NULL,
	### limits of the y-axis
	
	xlim = NULL,
	### limits of the x-axis
	
	which.pft = NULL,
	### character vector of PFT names that should be plotted. If NULL all 
	
	if.opt = FALSE,
	### plot parameters only if optimized (i.e. best) parameters are in LPJpar

	names = FALSE,
	### plot PFT names within the plot?	
	
	opt.val = TRUE,
	### plot value of optimized parameter?
	
	xaxt = "s",
	### x axis type. "n" suppresses the x axis.
	
	add = FALSE,
	### add to existing plot?
	
	xoff = 0
	### offset for adjusting in x-direction
				
	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{LPJpar}}, \code{\link{CheckLPJpar}}	
	
) {
  
  pft.names <- c("TrBE", "TrBR", "TeNE", "TeBE", "TeBS", "BoNE", "BoBS", "BoNS", "TrH", "TeH", "PoH")

	err <- "Select a valid parameter name."
	if (is.null(par.name)) {
		txt.l <- strsplit(as.character(x$names), "_")
		txt.l <- llply(txt.l, function(txt) {
		  if (txt[length(txt)] %in% pft.names) {
		    txt <- txt[-length(txt)]
		  } 
		  paste(txt, collapse="_")
		})
		par.name <- unique(unlist(txt.l))
		par.name <- par.name[par.name != ""]
		par.name <- sort(par.name)
	} else {
		if (any(is.na(par.name))) stop(err)
	}
	
	# loop over parameter names 
	for (i in 1:length(par.name)) {
	  i <<- i
		pos <- grep(par.name[i], x$names)
		if (length(pos) == 0) stop(err)
		
		# has parameter PFT-specific values?
		txt.l <- strsplit(as.character(x$names[pos]), "_")
		txt.df <- ldply(txt.l, function(txt) data.frame(matrix(as.character(txt), nrow=1)))
		
		if (!AllEqual(txt.df[, ncol(txt.df)])) {
			has.pfts <- TRUE
			pfts <- txt.df[, ncol(txt.df)]		
			npft <- length(pfts)
			nme <- par.name[i]
						
			if (is.null(col)) {
				col <- c(TrBE="#961a1d", TrBR="#facbcd", TeNE="#173218", TeBE="#69bd45", TeBS="#1b5127", BoNE="#a74198", BoBS="#622163", BoNS="#865aa6", TrH="#fecd08", TeH="#f6f068", PoH="#8ad4e2")
				if (length(col) < npft) col <- rainbow(npft)
				if (any(is.na(col))) col <- rainbow(npft)
			}
			col1 <- col[match(pfts, names(col))]
		} else {
			has.pfts <- FALSE
			pfts <- "global"
			npft <- 1
			if (is.null(col)) col1 <- "black"
			nme <- x$names[pos]
		}
		
		# priors
		par.df <- data.frame(
			par = nme, 
			pft = 1:npft, 
			pft.name = pfts,
			col = col1,
			prior = x$prior[pos],
			lower = x$lower[pos],
			upper = x$upper[pos])	

		# best from optimization
		has.best <- !is.null(x$best)
		if (has.best) par.df$best <- x$best[pos]
		
		# uncertainty estimate
		unc <- grep(uncertainty, names(x))
		if (uncertainty != "uncertainty.005") unc <- unc[1]
		has.unc <- !all(is.na(unc))
		if (has.unc) {
			if (length(unc) == 1) { # uncertainty range
				par.df$unc = x[[unc]][pos]
				par.df$unclow <- par.df$best - 0.5 * par.df$unc
				par.df$uncup <- par.df$best + 0.5 * par.df$unc
				
				bool <- par.df$unclow < par.df$lower
				bool[is.na(bool)] <- FALSE
				par.df$unclow[bool] <- par.df$lower[bool]
				par.df$uncup[bool] <- par.df$unclow[bool] + par.df$unc[bool]
				
				bool <- par.df$uncup > par.df$upper
				bool[is.na(bool)] <- FALSE
				par.df$uncup[bool] <- par.df$upper[bool]
				par.df$unclow[bool] <- par.df$uncup[bool] - par.df$unc[bool]
			} else if (length(unc) == 2) { # uncertainty lower and upper
				low <- (x[[unc[1]]])[pos]
				up <- (x[[unc[2]]])[pos]
				if (any(na.omit(low > up))) {
					up <- (x[[unc[1]]])[pos]
					low <- (x[[unc[2]]])[pos]				
				}
				par.df$unclow <- low
				par.df$uncup <- up
			} else {
				warning("Check the selected uncertainty estimate")
				has.unc <- FALSE
			}
		  if (unc.change) par.df$change <- abs(par.df$uncup - par.df$unclow) / abs(par.df$upper - par.df$lower)
		}
		
		# subset only selected PFTs 
		if (has.pfts & !is.null(which.pft)) {
			m <- match(which.pft, par.df$pft.name)
			if (length(m) > 0) {
				par.df <- par.df[m,]
				par.df$col <- as.character(par.df$col)
				par.df$col[is.na(par.df$col)] <- "black"
				pfts <- par.df$pft.name <- which.pft
				npft <- length(which.pft)
				par.df$pft <- 1:npft
			}
		}
		
		# plot only optimized parameters?
		par.nd <- rep(FALSE, nrow(par.df))
		par.nd[par.df$prior == 999 | par.df$prior == -999] <- TRUE
		if (has.best & if.opt) par.nd[is.na(par.df$best.median)] <- TRUE
		par.df$prior[par.nd] <- NA
		par.df$lower[par.nd] <- NA
		par.df$upper[par.nd] <- NA

		# axis ranges for plot
		if (is.null(ylim)) {
			ylim <- range(c(par.df$lower, par.df$upper), na.rm=TRUE)
			if (unc.change) ylim <- c(0,1)
			if (ylim[1] == ylim[2]) ylim[2] <- ylim[2] + 0.1
			ylim[1] <- ylim[1] - (ylim[2] - ylim[1]) * 0.01
			ylim[2] <- ylim[2] + (ylim[2] - ylim[1]) * 0.01
		}
		if (is.null(xlim)) xlim <- c(min(par.df$pft)-0.3, max(par.df$pft)+0.3)
		
		# init plot
		if (!add) {
		  if (unc.change) {
		    plot(change ~ pft, par.df, ylim=ylim, xlim=xlim, type="n", xaxt="n", yaxt="n", ylab=paste("dUncertainty", nme), xlab="") 
		  } else {
		    plot(prior ~ pft, par.df, ylim=ylim, xlim=xlim, type="n", xaxt="n", yaxt="n", ylab=nme, xlab="") 
		    rect(par.df$pft-0.25, par.df$lower, par.df$pft+0.25, par.df$upper, col="lightgray", border="lightgray")
		  }
		   
		   yaxt <- pretty(ylim, 3)
		   axis(2, yaxt, yaxt)
		   if (xaxt != "n") axis(1, at=par.df$pft, par.df$pft.name, las=2)
		   
		} else {
		   rect(par.df$pft+xoff-0.05, par.df$lower, par.df$pft+xoff+0.05, par.df$upper, col="lightgray", border="lightgray")
		}
		
		# change prior -> best
		is.best <- rep(FALSE, npft)
		if (has.best & !unc.change) {
			is.best <- par.df$prior != par.df$best
			suppressWarnings(arrows(x0=par.df$pft[is.best]+xoff, y0=par.df$prior[is.best], x1=par.df$pft[is.best]+xoff, y1=par.df$best[is.best], code=2, length=0.1, lwd=2, col=as.character(par.df$col[is.best]))) # change from prior to best
		}
		
		# prior
		d <- par.df[!is.best,]
		if (!unc.change) points(d$pft+xoff, d$prior, col=as.character(d$col), pch=18) 
		
		# posterior uncertainty
		if (has.unc & !unc.change) {
			suppressWarnings(arrows(x0=par.df$pft+xoff, y0=par.df$unclow, x1=par.df$pft+xoff, y1=par.df$uncup, code=3, angle=90, length=0.1, lty=1, col=as.character(par.df$col)))
		}
		
		# posterior uncertainty
		if (has.unc & unc.change) {
		  points(d$pft+xoff, d$change, col=as.character(d$col), pch=18, cex=2) 
		}
		
		# best individual
		if (has.best & !unc.change) {
		   d <- par.df[is.best,]
		   points(d$pft+xoff, d$best, col=as.character(d$col), pch=16) 
		   
		   # plot value of optimized parameter
		   if (opt.val) {
		     txt <- round(d$best, 2)
		     pos <- rep(1, length(d$best))
		     pos[d$best < mean(ylim)] <- 3
		     text(d$pft+xoff, d$best, txt, pos=pos, srt=20)
		   }
		}
		
		# add names
		if (names & (npft > 1) & !add) {
			text(par.df$pft, y=ylim[1]+diff(ylim)*0.1, par.df$pft.name, col=as.character(par.df$col), srt=45, cex=1.2)
		}
		
		#if (any(par.nd)) text((1:npft)[par.nd], ylim[1], "nd", cex=1.4)
		
		if (length(par.name) > 1) ylim <- xlim <- NULL
		
	} # end loop over par.name
}, ex=function() {
	# plot(lpjpar, par.name="ALBEDO_LEAF_TeBS", uncertainty="uncertainty.iqr95")
	# plot(lpjpar, par.name="ALBEDO_LEAF", uncertainty="uncertainty.iqr")
	# plot(lpjpar, par.name="LIGHTEXTCOEFF", uncertainty="uncertainty.iqr")
	# par(mfrow=c(2,2))
	# plot(lpjpar, par.name=c("ALPHAA", "LIGHTEXTCOEFF", "ALBEDO_LEAF", "ALBEDO_STEM"))
})
	








	

