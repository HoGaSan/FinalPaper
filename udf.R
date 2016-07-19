#Project functions

#Function name: loadLibraries
#Input: none
#Output: none
#Main use: load the required libraries for the project

loadLibraries <- function() {
  require(grid)
  require(ggplot2)
  require(lattice)
  require(ggplot2movies)
  #require(latticeExtra)
  #require(knitr)
  #require(data.table)
  #require(dplyr)
}


#Function name: addWatermark
#Input: plot
#Output: plot with watermark
#Main use: adds watermark to the plot

addWatermark <- function(p) {
  labelText <- "Final Paper - Gabor Horvath"
  temp <- ggplot_build(p)
  x_pos <- mean(temp$panel$ranges[[1]]$x.range)
  y_pos <- mean(temp$panel$ranges[[1]]$y.range)
  x_pos1 <- mean(c(temp$panel$ranges[[1]]$x.range[1],x_pos))
  y_pos1 <- mean(c(temp$panel$ranges[[1]]$y.range[2],y_pos))
  x_pos2 <- mean(c(temp$panel$ranges[[1]]$x.range[2],x_pos))
  y_pos2 <- mean(c(temp$panel$ranges[[1]]$y.range[2],y_pos))
  x_pos3 <- mean(c(temp$panel$ranges[[1]]$x.range[1],x_pos))
  y_pos3 <- mean(c(temp$panel$ranges[[1]]$y.range[1],y_pos))
  x_pos4 <- mean(c(temp$panel$ranges[[1]]$x.range[2],x_pos))
  y_pos4 <- mean(c(temp$panel$ranges[[1]]$y.range[1],y_pos))
  watermarked = p + 
    annotate("text", x = x_pos, y = y_pos, label = labelText, size = 12, col="black", fontface = "bold", alpha = 0.1) +
    annotate("text", x = x_pos1, y = y_pos1, label = labelText, size = 7, col="black", fontface = "bold", alpha = 0.05) +
    annotate("text", x = x_pos2, y = y_pos2, label = labelText, size = 7, col="black", fontface = "bold", alpha = 0.05) +
    annotate("text", x = x_pos3, y = y_pos3, label = labelText, size = 7, col="black", fontface = "bold", alpha = 0.05) +
    annotate("text", x = x_pos4, y = y_pos4, label = labelText, size = 7, col="black", fontface = "bold", alpha = 0.05)
  return(watermarked)
}


#Function name: addFlippedWatermark
#Input: plot
#Output: plot with watermark when x and y are flipped using coord_flip()
#Main use: adds watermark to the plot

addFlippedWatermark <- function(p) {
  labelText <- "Final Paper - Gabor Horvath"
  temp <- ggplot_build(p)
  x_pos <- mean(temp$panel$ranges[[1]]$x.range)
  y_pos <- mean(temp$panel$ranges[[1]]$y.range)
  x_pos1 <- mean(c(temp$panel$ranges[[1]]$x.range[1],x_pos))
  y_pos1 <- mean(c(temp$panel$ranges[[1]]$y.range[2],y_pos))
  x_pos2 <- mean(c(temp$panel$ranges[[1]]$x.range[2],x_pos))
  y_pos2 <- mean(c(temp$panel$ranges[[1]]$y.range[2],y_pos))
  x_pos3 <- mean(c(temp$panel$ranges[[1]]$x.range[1],x_pos))
  y_pos3 <- mean(c(temp$panel$ranges[[1]]$y.range[1],y_pos))
  x_pos4 <- mean(c(temp$panel$ranges[[1]]$x.range[2],x_pos))
  y_pos4 <- mean(c(temp$panel$ranges[[1]]$y.range[1],y_pos))
  watermarked = p + 
    annotate("text", y = x_pos, x = y_pos, label = labelText, size = 12, col="black", fontface = "bold", alpha = 0.1) +
    annotate("text", y = x_pos1, x = y_pos1, label = labelText, size = 7, col="black", fontface = "bold", alpha = 0.05) +
    annotate("text", y = x_pos2, x = y_pos2, label = labelText, size = 7, col="black", fontface = "bold", alpha = 0.05) +
    annotate("text", y = x_pos3, x = y_pos3, label = labelText, size = 7, col="black", fontface = "bold", alpha = 0.05) +
    annotate("text", y = x_pos4, x = y_pos4, label = labelText, size = 7, col="black", fontface = "bold", alpha = 0.05)
  return(watermarked)
}


#Function name: addOneWatermark
#Input: plot
#Output: plot with watermark
#Main use: adds watermark to the plot

addOneWatermark <- function(p) {
  labelText <- "Final Paper - Gabor Horvath"
  temp <- ggplot_build(p)
  x_pos <- mean(temp$panel$ranges[[1]]$x.range)
  y_pos <- mean(temp$panel$ranges[[1]]$y.range)
  watermarked = p + 
    annotate("text", x = x_pos, y = y_pos, label = labelText, size = 5, col="black", fontface = "bold", alpha = 0.1)
  return(watermarked)
}


#Function name: addTSWatermark
#Input: plot
#Output: plot with watermark
#Main use: adds watermark to the plot

addTSWatermark <- function(p, d) {
  labelText <- "Final Paper - Gabor Horvath"
  temp <- ggplot_build(p)
  y_pos <- mean(temp$panel$ranges[[1]]$y.range)
  watermarked = p + 
    annotate("text", x = d, y = y_pos, label = labelText, size = 12, col="black", fontface = "bold", alpha = 0.1)
  return(watermarked)
}


#Function name: startJPG
#Input: string - file name
#Output: N/A
#Main use: change the default values for the plots

startJPG <- function(s) {
  jpeg(
    s, #File name, no directory!
    width = 800, #width of the plot in px (should be the same as the height)
    height = 800, #height of the plot in px (should be the same as the width)
    quality = 99, #image quality in percentage, smaller value = higher compression
    res = 72 #nominal resolution in ppi (pixels per inch)
  ) 
}