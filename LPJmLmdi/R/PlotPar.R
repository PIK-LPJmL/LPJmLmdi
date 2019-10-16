PlotPar <- structure(function(
	##title<< 
	## Plot parameter vs. cost
	##description<<
	## The function takes an object of class 'rescue' (see \code{\link{CombineRescueFiles}}) (alternatively a 'data.frame' as created with \code{\link{Rescue2Df}}) and a 'LPJpar' object and plots different plots of cost vs. parameter value and parameter uncertainties.
	
	rescue.l,
	### a list of class "rescue" (\code{\link{CombineRescueFiles}}) or alternatively a data.frame as created with \code{\link{Rescue2Df}}.
	
	lpjpar,
	### a list of class "LPJpar" (see \code{\link{LPJpar}})
	
	par.name = NULL,
	### name(s) of the parameters that should be plotted	
		
	...
	### further arguments (currently not used)

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{CombineRescueFiles}}
) { 
	if (class(rescue.l) == "rescue") {
		par.optim <- names(rescue.l[[1]]$dpar)
		optim.df <- Rescue2Df(rescue.l, lpjpar)
	} else if (class(rescue.l) == "data.frame") {
		optim.df <- rescue.l
	} else {
		stop("rescue.l should be of class 'rescue' or a 'data.frame'")
	}
	
	# remove columns from parameter table
	rem.ll <- match(c("cost", "ll", "aic", "daic"), colnames(optim.df))
	par.optim <- colnames(optim.df)[-rem.ll]	
	if (is.null(par.name)) par.name <- par.optim
	best <- which.min(optim.df$cost)
	
	# normalized likelihood
	nll <- optim.df$ll / max(optim.df$ll, na.rm=TRUE)
	if (all(is.na(nll))) nll <- optim.df$cost / max(optim.df$cost, na.rm=TRUE)
	
	# loop over parameter names: make plots
	for (i in 1:length(par.name)) {
		nme <- par.name[i]
		g1 <- grep(nme, lpjpar$names)
		g2 <- grep(nme, colnames(optim.df))
		if (length(g1) == 1 & length(g2) == 1) {
			niter <- nrow(optim.df)
			par.all <- optim.df[, g2]
			if (all(is.na(optim.df$daic))) {
			   par.sel <- optim.df[optim.df$cost <= quantile(optim.df$cost, 0.05, na.rm=TRUE), g2]
			} else {
			   par.sel <- optim.df[optim.df$daic <= 2, g2]
			}
			par.prior <- lpjpar$prior[g1]
			par.best <- lpjpar$best[g1]
			par.med <- lpjpar$best.median[g1]
			par.unc.min <- lpjpar$uncertainty.005.min[g1]
			par.unc.max <- lpjpar$uncertainty.005.max[g1]
			par.prior.ll <- optim.df$ll[par.prior == par.all]
			nll.prior <- max(par.prior.ll, na.rm=TRUE) / max(optim.df$ll, na.rm=TRUE)
			
			# initalize plot
			DefaultParL(new=FALSE,  mar=c(3.7, 3.5, 0.2, 0.5), oma=c(0, 0.1, 2, 0.2))
			par(fig=c(0,0.5,0.5,1))
			
			# plot 1: histogram
			brks <- hist(par.all, xlab=nme, ylab="Frequency", main="", breaks=20, col="darkgrey")
			hist(par.sel, breaks=brks$breaks, col="orange", add=TRUE, main="")
			box()
			abline(v=par.med, col="darkorange3", lwd=2)
			abline(v=par.best, col="red", lwd=2)
			abline(v=par.prior, col="blue", lwd=2)
			y0 <- max(brks$counts) * 0.97
			arrows(x0=par.unc.min, y0=y0, x1=par.unc.max, y1=y0, col="red", code=3, angle=90, lwd=2, length=0.05)
			pos <- "topright"
			if (par.best > par.prior) pos <- "topleft"
			legend(pos, c("all", "best (dAIC < 2)"), fill=c("grey", "orange"), bty="n", title="individuals", cex=0.8)
			text(x=c(par.med, par.best, par.prior), y=max(brks$counts)*c(0.5, 0.8, 0.2), c("median", "best", "prior"), col=c("darkorange3", "red", "blue"), srt=90, pos=2)
			mtext(nme, 3, 0.4, font=2, cex=1.4, outer=TRUE)
			
			# plot 2: evolution of parameter
			par(fig=c(0.5,1,0.5,1), new=TRUE)
			o <- order(optim.df$cost, decreasing=TRUE)
			brks <- hist(1:niter, plot=FALSE)$mids
			nclass <- length(brks)
			agg <- cut(1:niter, breaks=seq(1, niter, length=nclass))
			levels(agg) <- brks
			bxp <- boxplot(par.all ~ agg, ylab=nme, xlab="Iterations of genetic optimization", cex=0.5)
			points(x=ncol(bxp$stats), y=par.best, col="red", lwd=2, pch=4, cex=1.5)
			points(x=ncol(bxp$stats), y=par.med, col="darkorange3", lwd=2, pch=4, cex=1.5)
			points(x=1, y=par.prior, col="blue", lwd=2, pch=4, cex=1.5)
			arrows(x0=ncol(bxp$stats), y0=par.unc.min, x1=ncol(bxp$stats), y1=par.unc.max, col="red", code=3, angle=90, lwd=2, length=0.05)
			text(y=c(par.med, par.best, par.prior), x=c(ncol(bxp$stats), ncol(bxp$stats), 1), c("median", "best", "prior"), col=c("darkorange3", "red", "blue"), pos=c(3, 1, 3))		
			
			# plot 3: scatter plot par ~ normalized likelihood
			par(fig=c(0,0.5,0,0.5), new=TRUE)
			xlim1 <- min(c(quantile(par.all, 0.4, na.rm=TRUE), quantile(par.sel, 0.005, na.rm=TRUE), par.best, par.med), na.rm=TRUE)
			xlim2 <- max(c(quantile(par.all, 0.6, na.rm=TRUE), quantile(par.sel, 0.995, na.rm=TRUE), par.best, par.med), na.rm=TRUE)
			xlim <- c(xlim1, xlim2)
			pos <- "topright"
			if (par.best > (xlim[1] + ((xlim[2]-xlim[1])*0.5))) pos <- "topleft"
			plot(1, 1, xlab=nme, ylab="Normalized likelihood", xlim=xlim, ylim=c(min(nll), 1), type="n")
			box()
			b1 <- par.all >= xlim[1] & par.all <= xlim[2]
			points(par.all[b1], nll[b1], cex=0.7, col=c("darkgrey", "orange")[(optim.df$daic[b1] <= 2)+1], pch=20)
			abline(v=par.med, col="darkorange3", lwd=2)
			points(x=par.best, y=1, col="red", lwd=2, pch=4, cex=1.5)
			points(x=par.prior, y=nll.prior, col="blue", lwd=2, pch=4, cex=1.5)
			arrows(x0=par.unc.min, y0=1, x1=par.unc.max, y1=1, col="red", code=3, angle=90, lwd=2, length=0.05)
			box()
			legend(pos, c("all", "best (dAIC < 2)"), col=c("grey", "orange"), title="individuals", cex=0.8, pch=20, bg="white")
			text(x=c(par.med, par.best, par.prior), y=c(0.5, 1, nll.prior), c("median", "best", "prior"), col=c("darkorange3", "red", "blue"), pos=c(1, 1, 3))	
			
			# plot 4: plot.LPJpar
			par(fig=c(0.5,0.65,0,0.5), new=TRUE)
			plot(lpjpar, nme, xaxt="n")
			
			# plot 5: legend
			par(fig=c(0.65,1,0,0.5), new=TRUE, mar=c(3.7, 0, 2.5, 0.1))
			plot.new()
			hess <- lpjpar$uncertainty.hessian[g1]
			if (is.null(hess)) hess <- NA
			txt <- paste(c("prior", "best", "median", "Hessian", "IQR(dAIC)", "Range_95%(dAIC)", "Range(<Q0.05)"), "=", signif(c(par.prior, par.best, par.med, hess, lpjpar$uncertainty.iqr[g1], lpjpar$uncertainty.iqr95[g1], lpjpar$uncertainty.005.max[g1]-lpjpar$uncertainty.005.min[g1]), 4))
			legend("topleft", txt, col=c("blue", "red", "darkorange3", rep("black", 3), "red"), lty=1, bty="n", cex=0.9, lwd=2)
		} else {
			warning(paste("Parameter", nme, "does not exist."))
		}
	}
			
}, ex=function() {
	# files <- c(list.files(pattern="rescue.RData", recursive=TRUE), list.files(pattern="rescue0.RData", recursive=TRUE))
	# rescue.l <- CombineRescueFiles(files, remove=FALSE)
	# PlotPar(rescue.l, lpjpar)
})


