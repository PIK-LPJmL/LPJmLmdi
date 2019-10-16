plot.rescue <- structure(function(
	##title<< 
	## plot an object of class "rescue" / monitor OptimizeLPJgenoud
	##description<<
	## The function plots the cost per data set for all individuals of the genetic optimization from an object of class "rescue". This function can be used to monitor the development of the optimization within OptimizeLPJgenoud. Therefor read the rescue files from your optimization with "rescue.l <- CombineRescueFiles(list.files(pattern=".RData"), remove=FALSE)" and call "plot(rescue.l)". 
	
	x,
	### a list of class "rescue", see \code{\link{CombineRescueFiles}}
	
	ylim=NULL,
	### limits of the y-axis of the plot
	
	xlim=NULL,
	### limits of the x-axis of the plot
	
	ylab="Cost",
	### label for the y axis
	
	xlab="Individuals of genetic optimization",
	### label for the x axis
	
	only.cost=FALSE,
	### plot all integration datasets (TRUE) or only these ones with cost=TRUE
	
	...
	### further arguments for \code{\link{plot}}

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{CombineRescueFiles}}
) { 

	rescue.l <- x
	
	# has KGE metrics?
	kge <- !is.null(rescue.l[[1]]$cost$fractional) 
	if (kge) nms <- paste(rep(names(rescue.l[[1]]$cost$per.ds), each=3), names(rescue.l[[1]]$cost$per.cell))
	if (!kge) nms <- names(rescue.l[[1]]$cost$per.ds)

	# get cost per data stream
	cost.ds <- laply(rescue.l, function(l) {
		# if (all(l$dpar == 1)) cost.prior <<- l$cost$total
		if (kge) { # KGE cost
			m <- t(l$cost$fractional * l$cost$total)
			#m <- t(l$cost$per.cell.ds)
			m <- matrix(m, nrow=1)
		} else { # SSE cost
			m <- matrix(l$cost$per.ds, nrow=1)
		}	
		return(m)
	})

	# select only data streams that are included in cost function or all
	if (only.cost) {
		if (is.null(rescue.l[[1]]$cost$use)) {
	      use <- rep(TRUE, length(rescue.l[[1]]$cost$per.cell.ds))
	   } else {
        use <- apply(rescue.l[[1]]$cost$use, 1, sum) > 0
	   }
	
		cost <- unlist(llply(rescue.l, function(l) l$cost$total)) # total cost
		cost.ds <- matrix(cost.ds[,use], nrow=length(cost))
		if (kge) nms <- paste(rep(names(rescue.l[[1]]$cost$per.ds), each=3)[rep(use, each=3)], names(rescue.l[[1]]$cost$per.cell))
		if (!kge) nms <- names(rescue.l[[1]]$cost$per.ds)[use]
	} else {
	   if (!kge) cost <- rowSums(cost.ds)
	   if (kge) cost <- sqrt(rowSums(cost.ds))
	}
	
	# get prior parameter set
	isprior <- unlist(llply(rescue.l, function(l) all(l$dpar == 1)))
	
	# prepare matrix for plotting
	o <- order(cost, decreasing=TRUE)
	cost <- cost[o]
	isprior <- isprior[o]
	cost.ds <- matrix(cost.ds[o, ], nrow=length(cost))
	cost.ds <- (cost.ds * cost) / rowSums(cost.ds) 
	nds <- length(nms)

	# rescue.l[[isprior]]  cost.ds[isprior,]  cost.ds[nrow(cost.ds),]

	# create colors
	cols0 <- brewer.pal(nds, "Set1")
	if (kge) {
		cols0 <- col2rgb(cols0)
		cols <- list()
		s <- c(0.7, 0.85, 1)
		for (i in 1:ncol(cols0)) cols[[i]] <- rgb(cols0[1,i]*s, cols0[2,i]*s, cols0[3,i]*s, max=255)
		cols <- unlist(cols)
	} else {
		cols <- cols0
	}

	# prepare data for plot
	cost.plot <- cost.ds
	cost.plot <- matrix(apply(cost.plot, 1, cumsum), ncol=length(cost))
	cost.plot <- t(cost.plot)
	if (is.null(ylim)) ylim <- c(0, quantile(cost.plot, 0.95, na.rm=TRUE))
	if (is.null(xlim)) xlim <- c(0, nrow(cost.plot))
	
	# init plot
	plot(cost, xlim=xlim, ylim=ylim, pch=16, ylab=ylab, xlab=xlab) #, ...) # 	
	for (i in ncol(cost.plot):1) {
		if (nrow(cost.plot) < 15000) { 	# plot as polygon
			x <- c(1:nrow(cost.plot), nrow(cost.plot):1)
			y <- c(cost.plot[,i], rep(0, nrow(cost.plot)))
			polygon(x, y, col=cols[i], border=NA)
		} else {						# plot as lines -> faster
			x <- 1:nrow(cost.plot)
			y <- cost.plot[,i]
			points(x, y, col=cols[i], type="h", lwd=0.5)
		}
	}
	
	# add prior
	prior.cost <- max(cost[which(isprior)])
	prior <- which(cost == prior.cost)
	best <- nrow(cost.plot)
	for (i in ncol(cost.plot):1) {
	   points(x=prior, y=cost.plot[prior,i], pch=21, lwd=2, col=cols[i], type="h")
	}
	abline(v=prior, h=prior.cost, lty=2)
	text(x=prior, y=0, "prior", pos=3)
	text(x=best, y=0, "best", pos=3)
	points(x=rep(prior, nds), y=cost.plot[prior,], pch=21, cex=1.5, bg=cols, col="black")
	points(x=rep(best, nds), y=cost.plot[best,], pch=21, cex=1.5, bg=cols, col="black")
	
	text(2, ylim[2], paste("max =", "\n", round(max(cost), 2)), pos=1)
	legend("topright", nms, fill=cols, ncol=min(c(nds, 4)), bg="white", title="Component of cost")
	box()
	
})

