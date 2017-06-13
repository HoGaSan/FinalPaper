#' 
#' \code{saveBarPlotPNG2} saves the required bar plot based on 
#' the details in the YAML config file
#' 
#' @param DataYear integer
#' The year of the data set being used for the plot
#' 
#' @param DataSet string
#' The name of the data set the plot is being created from
#' 
#' @param DataField string
#' The name of the data field the plot is being created from
#' 
#' @param DataStage string
#' The name of the stage of the data
#' 
#' @param DataObject object
#' The data object to create the plot
#' 
#' @examples 
#' saveBarPlotPNG2(1990, "Animal Strike", DT)
#' 
saveBarPlotPNG2 <- function(DataYear, DataSet, DataField, DataStage, DataObject) {
  targetFileName <- paste(DataYear,
                          "_",
                          DataSet,
                          "_",
                          DataField,
                          "_",
                          DataStage,
                          ".png",
                          sep="")
  
  plotText <- data.table(
    keys = c(
      "AC_CLASS",
      "AC_MASS",
      "TYPE_ENG",
      "TIME_OF_DAY",
      "PHASE_OF_FLT",
      "SKY",
      "PRECIP",
      "Carrier",
      "DistanceGroup"
      ),
    texts = c(
      "Aircraft class",
      "Aircraft mass type",
      "Engine type",
      "Time of day",
      "Flight phase",
      "Sky condition",
      "Precipitation",
      "Airline carrier",
      "Flight distance group"
      )
  )
  
  if (!is.empty(tolower(plotText[keys==DataField,texts]))) {
    lowerPlotText <- tolower(plotText[keys==DataField,texts])
    labelAxisX <- plotText[keys==DataField,texts]
  } else {
    message("Key not found")
    return()
  }
  
  plotTitle <- paste("Data distribution of "
                     ,lowerPlotText,
                     " in ",
                     DataYear,
                     sep="")
  
  test <- DataObject
  
  ggplot(data = DataObject, aes(get(DataField))) +
    ggtitle(plotTitle) + #plot title
    geom_bar(fill = "#99ccff", color = "#99ccff") + #plotting a bar chart
    coord_flip() + #flip the drawing of the axises --> Y will be the horizontal
    xlab(labelAxisX) + #set the vertical axis text
    ylab("") +
    theme(
      #align title to the center
      plot.title = element_text(hjust = 0.5, face="bold"),
      #set plot background colors
      plot.background = element_rect(fill = "white", colour = "white"),
      #set panel background colors
      panel.background = element_rect(fill = "white", colour = "white"),
      #set the fonts to serif, which is set to Times New Roman
      text = element_text(family = "serif"),
      #change the angle of the axis text
      axis.text.x = element_text(angle=45, hjust=1, vjust=1)
  
      )
  
  ggsave(
    targetFileName,
    units = "in", #units are in pixels
    width = 4.5, #width of the plot in in (should be the same as the height)
    height = 4.5, #height of the plot in in (should be the same as the width)
    dpi = 72 #nominal resolution in ppi (pixels per inch)
    )
  
}

