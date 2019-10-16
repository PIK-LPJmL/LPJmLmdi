BarplotCost <- structure(function(
	##title<< 
	## plot a barplot of the cost change from prior to best parameter set
	##description<<
	## The function plots two barplots that are showing the change in the cost per dataset.
	
	rescue.l,
	### a list of class "rescue", see \code{\link{CombineRescueFiles}}
	
	type = 1:2,
	### plot type: 1 barplot of total cost from prior and best, 2: change of cost per data set 
	
	ylim = NULL,
	### limits of y-axis (works for type = 2)
	
	set.par = TRUE,
	### set par() settings from \code{\link{DefaultParL}}
	
	...
	### further arguments for \code{\link{plot}}

	##details<<
	## No details.
	
	##references<< No reference.	
	
	##seealso<<
	## \code{\link{CombineRescueFiles}}
) { 

	# has KGE metrics?
	kge <- !is.null(rescue.l[[1]]$cost$fractional) 
	if (length(type) > 1) ylim <- NULL
	
   # get cost and identify prior and best parameter sets	
	cost <- unlist(llply(rescue.l, function(l) l$cost$total)) # total cost
	prior <- (1:length(rescue.l))[unlist(llply(rescue.l, function(l) all(l$dpar == 1)))]
	prior <- prior[which.max(cost[prior])]
	best <- which.min(cost)	
	if (is.null(rescue.l[[1]]$cost$use)) {
	   use <- rep(TRUE, length(rescue.l[[1]]$cost$per.cell.ds))
	} else {
	   use <- apply(rescue.l[[1]]$cost$use, 1, sum) > 0
	   if (kge) use <- rep(use, each=3)
	}
	
	# get cost per data stream
	cost.ds <- matrix(laply(rescue.l[c(prior, best)], function(l) {
		# if (all(l$dpar == 1)) cost.prior <<- l$cost$total
		if (kge) { # KGE cost
		   if (is.null(l$cost$use)) l$cost$use <- matrix(TRUE, ncol=ncol(l$cost$per.cell.ds), nrow=nrow(l$cost$per.cell.ds))
		   m <- l$cost$per.cell.ds * l$cost$use
			m <- matrix(t(m), nrow=1)
			colnames(m) <- paste(rep(names(l$cost$per.ds), each=3), names(l$cost$per.cell))
		} else { # SSE cost
			m <- matrix(l$cost$per.ds, nrow=1)
			colnames(m) <- names(l$cost$per.ds)
		}	
		return(m)
	}), nrow=2)
	cost.ds <- cost.ds[,use]
	
	# calculate changes in cost
	if (kge) {
	   nms <- paste(rep(names(rescue.l[[1]]$cost$per.ds), each=3), c("Bias", "Var", "Cor"))[use]
	   #m0 <- cost.ds / sqrt(rowSums(cost.ds))
	   m0 <- cost.ds 
	   m <- data.frame(prior=m0[1,], best=m0[2,], nms=nms)
	   m$diff <- m$best - m$prior
	   m$perc <- m$diff / m$prior * 100
	   m$gr <- unlist(llply(strsplit(nms, " "), function(s) paste0(s[-length(s)], collapse=" ")))
	   
	   # aggregate KGE components per data set
	   m.gr <- aggregate(. ~ gr, m, FUN=sum)
	   m.gr$min <- aggregate(diff ~ gr, m, FUN=min)[,2]
	   m.gr$max <- aggregate(diff ~ gr, m, FUN=max)[,2]
	   m.gr <- m.gr[match(unique(m$gr), m.gr$gr), ]
	   m.gr$perc <- m.gr$diff / m.gr$prior * 100
	   m.gr$txt <- paste(m.gr$gr, "\n", round(m.gr$perc, 0), " %", sep="")
	   
	} else {
	   nms <- names(rescue.l[[1]]$cost$per.ds)[use]
	   m <- data.frame(prior=cost.ds[1,], best=cost.ds[2,], nms=nms)
	   m$diff <- m$best - m$prior
	   m$perc <- m$diff / m$prior * 100
	   m$txt <- paste(m$nms, "\n", round(m$perc, 0), " %", sep="")
	   
	}

	# create colors
	nds <- length(names(rescue.l[[1]]$cost$per.ds))
	cols0 <- brewer.pal(nds, "Set1")
	if (kge) {
		cols <- cols0
		if (length(nms) > 3) {
			cols0 <- col2rgb(cols0)
			cols <- list()
			s <- c(0.7, 0.85, 1)
			for (i in 1:ncol(cols0)) cols[[i]] <- rgb(cols0[1,i]*s, cols0[2,i]*s, cols0[3,i]*s, max=255)
			cols <- unlist(cols)
		}
	} else {
		cols <- cols0
	}
			
   # init plot
	if (set.par) {
	  if (length(type) == 2) DefaultParL(mfrow=c(2,1), mar=c(3, 3.5, 0.1, 0.5))
	  if (length(type) == 1) DefaultParL(mar=c(2, 3.5, 0.5, 0.5))	  
	}
	
	# total cost
	if (1 %in% type) {
	   barplot(as.matrix(m[,1:2]), col=cols, names=c("prior", "best"), ylab="Cost", main="")
	   ncol <- 1
	   if (length(nms) > 9) ncol <- 2
	   legend("topright", nms, fill=cols, bty="n", ncol=2)
	   box()
	}
	
	# change in cost
	if (2 %in% type) {
	  if (is.null(ylim)) {
  	   ylim <- range(m$diff)
  	   if (kge) ylim <- quantile(c(m$diff, m.gr$diff), c(0, 1))
  	   ylim[1] <- ylim[1] - diff(ylim) * 0.08
  	   ylim[2] <- ylim[2] + diff(ylim) * 0.08
  	   if (kge) ylim[1] <- ylim[1] - diff(ylim) * 0.1	    
	  }

	   bp <- barplot(m$diff, col=cols, ylab="Change in cost", las=3, main="", names="", ylim=ylim)
	   abline(h=0)
	   
      # add total cost per datastream
	   if (kge) {
	      # plot barplot per data set
	      xleft <- bp[seq(1, by=3, length=nrow(m.gr))] - diff(bp[1:2]) * 0.47
	      xright <- bp[seq(3, by=3, length=nrow(m.gr))] + diff(bp[1:2]) * 0.47
	      ybottom <- apply(cbind(0, m.gr$diff), 1, min)
	      ytop <- apply(cbind(0, m.gr$diff), 1, max)
	      cols1 <- cols[seq(2, by=3, length=nrow(m.gr))]
	      rect(xleft, ybottom, xright, ytop, col=cols1)
	      barplot(m$diff, col=cols, main="", names="", ylim=ylim, axes=FALSE, add=TRUE)
	      
	      # add text for percentage change in cost
	      xpos <- bp[seq(2, by=3, length=nrow(m.gr))]
	      ypos <- m.gr$diff
	      ypos[m.gr$diff <= 0] <- apply(cbind(m.gr$min, m.gr$diff), 1, min)[m.gr$diff <= 0]
	      ypos[ypos < ylim[1]] <- diff(c(0, ylim[1])) * 0.9
	      ypos[m.gr$diff > 0] <- apply(cbind(m.gr$max, m.gr$diff), 1, max)[m.gr$diff > 0]
	      ypos[ypos > ylim[2]] <- diff(c(0, ylim[2])) * 0.9
	      pos <- c(1,3)[(m.gr$diff > 0) + 1]
	      text(xpos, ypos, m.gr$txt, pos=pos)
	      
	      # add text for KGE components
	      ypos <- apply(cbind(m$diff, 0), 1, mean)
	      text(bp, ypos, c("Bias", "Var", "Cor"), srt=90)
	      
	   } else {
	      pos <- c(3,1)[(m$diff > 0) + 1]
	      text(x=bp, y=m$diff, m$txt, pos=pos)
	   }
	   
	   x <- bp[length(bp)] + diff(bp[1:2]) * 0.8
	   arrows(x, 0, x, ylim[1], col="powderblue", lwd=2)
	   text(x, mean(c(0, ylim[1])), "improvement", srt=90)
      box()
	}
	
	
}, ex=function() {
	# files <- c(list.files(pattern="rescue.RData", recursive=TRUE), list.files(pattern="rescue0.RData", recursive=TRUE))
	# rescue.l <- CombineRescueFiles(files, remove=FALSE)
	# BarplotCost(rescue.l)
})
	
