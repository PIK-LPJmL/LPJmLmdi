LegendBar <- structure(function(
  ##title<< 
  ## Add a colour legend bar to a plot
  ##description<<
  ## Adds a colour legend bar to a plot
  
  x,
  ### x coordinates for the legend bar
  
  y,
  ### y coordinates for the legend bar
  
  brks = seq(0, 1, by=0.2), 
  ### class breaks for the legend bar
  
  cols = NULL, 
  ### colours for each class. If NULL grey scales are used.
  
  brks.txt = NULL,
  ### text labels for the class breaks. If NULL, 'brks' are used
  
  title = "",
  ### title for the legend bar
  
  srt = NULL,
  ### rotation of breaks text labels
  
  col.txt = "black",
  ### colour for text labels
  
  cex.txt = 1,
  ### size of the text labels
  
  ...
  ### arguments (unused)
  
  ##details<<
  ## No details.
  
  ##references<< No reference.	
  
  ##seealso<<
  ## \code{\link{CRSll}}
) { 
  xy <- cbind(x, y)
  
  # breaks 
  if (is.null(cols)) cols <- BreakColours(brks)
  if (is.null(brks.txt)) {
    brks.txt <- as.character(brks)
    slen <- sapply(strsplit(brks.txt, ""), FUN=length)
    if (length(brks) > 6 | any(slen > 3)) {
      brks.txt[seq(2, length(brks)-1, by=2)] <- ""
      brks.txt[brks == 0] <- "0"
    } 
  } else {
    brks.txt <- as.character(brks.txt)
  }
  slen <- sapply(strsplit(brks.txt, ""), FUN=length)
  if (any(slen > 3) & length(brks.txt) > 8 & is.null(srt)) srt <- 20
  if (is.null(srt)) srt <- 0 
  
  # text and colour bar
  text(seq(xy[1,1], xy[2,1], length=length(brks)), min(xy[,2]), labels=brks.txt, pos=1, srt=srt, col=col.txt, cex=cex.txt)
  text(mean(xy[,1]), max(xy[,2]), labels=title, pos=3, col=col.txt, cex=cex.txt)
  color.legend(xy[1,1], xy[1,2], xy[2,1], xy[2,2], legend="", rect.col=cols, align="rb")
  par(xpd=FALSE)
}, ex=function() {
  
  plot.new()
  LegendBar(x=c(0.1, 0.9), y=c(0.4, 0.6))
  LegendBar(x=c(0.1, 0.5), y=c(0.7, 0.8))
  
  brks <- seq(-1, 1, 0.2)
  cols <- BreakColors(brks)
  LegendBar(x=c(0.6, 1), y=c(0.7, 0.8), brks=brks, cols=cols, title="My title")
  
  LegendBar(x=c(0.2, 0.8), y=c(0.1, 0.2), brks=brks, cols=cols, col.txt="purple", title="purple", srt=90)
  
})  
