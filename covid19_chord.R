library(tidyverse)
library(dplyr)
library(viridis)
library(patchwork)
library(hrbrthemes)
library(circlize)
library(chorddiag)  


data_long<-read.csv('ncv_transmission_v1.csv')
data_long<-data_long[,c(2,1,3)]

glimpse(data_long)

# parameters
circos.clear()
circos.par(start.degree = 90, gap.degree = 4, track.margin = c(-0.1, 0.1), points.overflow.warning = FALSE)
par(mar = rep(0, 4))

# color palette
mycolor <- viridis(20, alpha = 1, begin = 0, end = 1, option = "D")
mycolor <- mycolor[sample(1:20)]

#set.seed(42)
chordDiagram(
  x = data_long, 
  transparency = 0.25,
  directional = 1,
  direction.type = c("arrows", "diffHeight"), 
  diffHeight  = -0.04,
  annotationTrack = "grid", 
  annotationTrackHeight = c(0.05, 0.1),
  link.arr.type = "big.arrow", 
  link.sort = TRUE, 
  link.largest.ontop = TRUE)


circos.trackPlotRegion(
  track.index = 1, 
  bg.border = NA, 
  panel.fun = function(x, y) {
    
    xlim = get.cell.meta.data("xlim")
    sector.index = get.cell.meta.data("sector.index")
    
    # Add names to the sector. 
    circos.text(
      x = mean(xlim), 
      y = 3.2, 
      labels = sector.index, 
      facing = "downward", 
      cex = 0.9
    )
    
    #Add graduation on axis
    circos.axis(
      h = "top",
      
      major.at = c(40,80), #seq(from = 1, to = xlim[2], by = ifelse(test = xlim[2]==83, yes =82, no =0)),
      col = 'white',
      #minor.ticks = 10,
      #major.tick.percentage =20,
      labels.niceFacing = TRUE)
  }
)