plot.LPJsim <- structure(function(
	##title<< 
	## Plots a LPJsim object
	##description<<
	## The function plots a LPJsim object: monthly, annual time series or map of grid cells
		
	x, 
	### an object of class 'LPJsim'
	
	what="annual", 
	### What type of plot should be created? 'annual' for yearly time series, 'monthly' for monthly time series, 'daily' for daily time series, and 'grid' for a map of grid cells
	
	start=NA, 
	### first year for time series plot
	
	end=NA, 
	### last year for time series plot
	
	omit0=TRUE, 
	### omit variables from plotting that are only 0?
	
	AggFun = AggMeanNULL,
	### aggregation function to aggregate results to the temporal resolution as selected in 'what', for example \code{\link{AggMeanNULL}} for monthly or annual means, \code{\link{AggSumNULL}} for monthly or annual sums.
	
	...
	### further arguments (currently not used)
		
	##details<<
	## No details.
	
	##references<< No reference.
	
	##seealso<<
	## \code{\link{ReadLPJ2ts}}, \code{\link{ReadLPJsim}}
	
) {

	# plot map if what == 'grid'
	if (what == "grid") {
		PlotWorld110()
		points(x$grid, col="red", pch="+", xlab="", ylab="")
		if (nrow(x$grid) == 1) text(x$grid[1,1], x$grid[1,2], paste(x$grid, collapse=", "), col="red", pos=3)
		return(x$grid)
	}
	
	# check frequency daily(365), monthly(12) or annual(1)
	data.l <- x$data
	info.df <- x$info
	freq <- llply(data.l, .fun=frequency)
	
	# scale with factor
	nms <- names(data.l)
	data.l <- llply(as.list(1:length(data.l)), function(id) data.l[[id]] * info.df$scale[id])
	
	# aggregate time series to common resolution
	freq.plot <- 1 # annual
	freq.plot[what == "monthly"] <- 12
	freq.plot[what == "daily"] <- 365
	
	if (!freq.plot %in% unlist(freq)) {
		warning(paste("Frequency", freq.plot, "not included in x. Plot what='annual' instead."))
		freq.plot <- 1
		what <- "annual"
	}
	
	# aggregate data to common resolution
	data.agg.l <- llply(as.list(1:length(data.l)), .fun=function(id) {
		Yt <- data.l[[id]]
		if (freq[[id]] == freq.plot) {
			return(Yt)
		} else if (freq[[id]] > 1 & freq.plot == 1) { # monthly or daily to annual 
			agg <- rep(start(Yt)[1]:end(Yt)[1], each=freq[[id]])
			Yt2 <- AggFun(as.vector(Yt), agg)
			return(Yt2)
		} else if (freq[[id]] == 365 & freq.plot == 12) { # daily to monthly
			ndaymonth <- c(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
			agg <- paste(rep(start(Yt)[1]:end(Yt)[1], each=365), rep(1:12, ndaymonth))
			Yt2 <- AggFun(as.vector(Yt), agg)
			return(Yt2)
		} else { # would require interpolation
			return(0)
		}
	})
	names(data.agg.l) <- nms
	varnames <- NULL
	for (i in 1:length(data.agg.l)) {
		varnames <- c(varnames, paste(names(data.agg.l)[i], colnames(data.agg.l[[i]])))
	}			
	data.ts <- data.agg.l[[1]]
	for (i in 2:length(data.agg.l)) data.ts <- cbind(data.ts, data.agg.l[[i]])
	colnames(data.ts) <- varnames
	
	
	# plot time series
	#-----------------
	
	if (what != "grid") {
		
		# omit variables with only 0 values
		if (omit0) {
			o <- apply(data.ts, 2, mean, na.rm=TRUE)
			ti <- tsp(data.ts)
			data.ts <- data.ts[,(1:ncol(data.ts))[o != 0]]
			data.ts <- ts(data.ts)
			tsp(data.ts) <- ti
		}

		if (is.na(start)) start <- start(data.ts)
		if (is.na(end)) end <- end(data.ts)
		
		# calculate optimal number of rows and columns for the plot
		row <- nds <- ncol(data.ts)
		if (is.null(row)) {
			row <- nds <- 1
		}
		if (row == 0) {
			warning("nothing to plot")
			return(NA)
		}
		col <- 1	
		if (row > 10) {
			col <- 4
			row <- ceiling( ncol(data.ts) / 4 )
		}

		# plot the graphic
		par <- par()
		if (nds == 1) {
			plot(window(data.ts, start=start, end=end), ylab="")
			return(data.ts)
		}
		if (col > 1) DefaultParL(mfrow=c(row, col), mar=c(0.8,4,0,1), oma=c(4,0,2,0.2))
		if (col == 1) DefaultParL(mfrow=c(row, col), mar=c(0.8,4,0,4), oma=c(4,0,2,0))
		i <- 1
		for (r in 1:row) {
			for (c in 1:col) {
				if (i <= nds) {
					plot(window(data.ts[,i], start=start, end=end), ylab="", xaxt="n", yaxt="n")
					grid()
					# plot x axis
					if (r == row) axis(1, pretty(window(time(data.ts), start=start, end=end)), pretty(window(time(data.ts), start=start, end=end)))
					
					# plot y axis
					yax <- pretty(data.ts[,i])
					if (col == 1) {
						if (i %% 2 == 1) {
							axis(2, yax, yax)
							mtext(colnames(data.ts)[i], 2, 2.7)
						}
						if (i %% 2 == 0) {
							axis(4, yax, yax)
							mtext(colnames(data.ts)[i], 4, 2.7)
						}						
					} else {
						axis(2, yax, yax)
						mtext(colnames(data.ts)[i], 2, 2.7)
					}
					box()
					i <- i + 1
				}
			}
		}
		par(par)
		
	return(data.ts)
	}
}, ex=function() {

# setwd(path.mylpjresult)
# sim <- ReadLPJ2ts(start=1982, end=2011)
# plot(sim, what="annual")

})
