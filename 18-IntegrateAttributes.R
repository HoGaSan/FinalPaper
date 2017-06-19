#' 
#' \code{IntegrateAttributesM1} integrates the attributes to 
#' be used by the first model
#' 
#' @examples 
#' IntegrateAttributesM1()
#' 
IntegrateAttributesM1 <- function() {
  
  dataDir <- getDataDir()
  
  RDSFileName <- "07_CLE_Airport.rds"
  
  RDSFile <- paste(dataDir,
                   "/",
                   RDSFileName,
                   sep = "")
  
  RDSFileNameDest <- "08_DER_Airport_Destination.rds"
  
  RDSFileDest <- paste(dataDir,
                   "/",
                   RDSFileNameDest,
                   sep = "")
  
  RDSFileNameOrig <- "08_DER_Airport_Origin.rds"
  
  RDSFileOrig <- paste(dataDir,
                   "/",
                   RDSFileNameOrig,
                   sep = "")
  
  RDSFileNameStr <- "08_DER_Airport_Strike.rds"
  
  RDSFileStr <- paste(dataDir,
                   "/",
                   RDSFileNameStr,
                   sep = "")
  

  if ((file.exists(RDSFile) != TRUE) ||
      (file.exists(RDSFileDest) != TRUE) ||
      (file.exists(RDSFileOrig) != TRUE) ||
      (file.exists(RDSFileStr) != TRUE)
      ){
    message(RDSFileName,
            " or ",
            RDSFileNameDest,
            " or ",
            RDSFileNameOrig,
            " or ",
            RDSFileNameStr,
            " is not available, ",
            "please re-run the preparation scripts!")
  } else {
    
    airportData <- readRDS(file = RDSFile)
    setkey(airportData, LocationID)
    airportDestination <- readRDS(file = RDSFileDest)
    setkey(airportDestination, Airport)
    airportOrigin <- readRDS(file = RDSFileOrig)
    setkey(airportOrigin, Airport)
    airportStrike <- readRDS(file = RDSFileStr)
    setkey(airportStrike, Airport)
    
    mergedAirportFlightData <- merge(airportOrigin,
                                     airportDestination,
                                     all = FALSE)
    
    #Resetting the NA values to zero
    mergedAirportFlightData[is.na(mergedAirportFlightData)] <- 0
    
    airportDatawFD <-
      airportData[LocationID %in% mergedAirportFlightData$Airport]
    
    #enrich data with the flight data
    airportDatawFD <- merge(airportDatawFD,
                            mergedAirportFlightData,
                            by.x = "LocationID",
                            by.y = "Airport",
                            all.x = TRUE)
    
    #enrich the data, with the strike data
    airportDatawST <- merge(airportDatawFD,
                            airportStrike,
                            by.x = "LocationID",
                            by.y = "Airport",
                            all.x = TRUE)
    
    airportDatawST[is.na(airportDatawST)] <- 0
    
    #Resetting the factors of the data table
    airportDatawST[] <- 
      lapply(airportDatawST,
             function(x) if(is.factor(x)) factor(x) else x)
    
    
    airportDataForModel01 <- 
      airportDatawST[,c("LocationID",
                        "Region",
                        "State",
                        "City",
                        "FacilityName",
                        "ARPElevation",
                        "LandAreaCoveredByAirport",
                        "OriginCount",
                        "OriginMaxDistance",
                        "OriginMinDistance",
                        "OriginAvgDistance",
                        "DestinationCount",
                        "DestinationMaxDistance",
                        "DestinationMinDistance",
                        "DestinationAvgDistance",
                        "StrikeNo"
                        )
                    ]
    
    #Resetting the factors of the data table
    airportDataForModel01[] <- 
      lapply(airportDataForModel01,
             function(x) if(is.factor(x)) factor(x) else x)
    
    
    RDSFileNameModel01 <- "09_Model_01_Data.rds"
    
    RDSFileModel01 <- paste(dataDir,
                            "/",
                            RDSFileNameModel01,
                            sep = "")
    
    if (file.exists(RDSFileModel01) != TRUE) {
      saveRDS(airportDataForModel01,
              file = RDSFileModel01)
    } else {
      file.remove(RDSFileModel01)
      saveRDS(airportDataForModel01,
              file = RDSFileModel01)
    }
    
    saveMapPNG(airportDatawST$State, airportDatawST)
    
    currentWorkingDir <- getwd()
    setwd(getDocInputDir())
    
    base_map <- map_data("state")

    plotData <- 
      airportDatawST[!State %in% c("AK",
                                   "HI"),
                     sum(StrikeNo),
                     by = "StateName"]
    plotData$StateName <- tolower(plotData$StateName)
    names(plotData) <- c("region",
                         "NumberOfStrikes")
    
    plotDataMapUSA <- 
      merge(statesDT, 
            plotData, 
            by="region", 
            all = TRUE)
    
    plotDataMapUSA <- 
      plotDataMapUSA[plotDataMapUSA$region!="district of columbia",]
    
    targetFileName <- "USA_Airports.png"

    ggplot() + 
      geom_polygon(data=plotDataMapUSA,
                   aes(x=long,
                       y=lat,
                       group = group,
                       color = "white",
                       fill=plotDataMapUSA$NumberOfStrikes),
                   colour="white") +
      scale_fill_continuous(low = "#CBE5FF",
                            high = "#00264C",
                            guide="colorbar") +
      theme_bw() +
      labs(fill = "Number of Strikes",
           x="",
           y="") +
      scale_y_continuous(breaks=c()) + 
      scale_x_continuous(breaks=c()) + 
      theme(panel.border =  element_blank())

    ggsave(
      targetFileName,
      units = "in", #units are in pixels
      width = 10, #width of the plot in in (should be the same as the height)
      height = 7, #height of the plot in in (should be the same as the width)
      dpi = 72 #nominal resolution in ppi (pixels per inch)
    )
    
    setwd(currentWorkingDir)

  } #end of "if (file.exists(RDSFile) != TRUE)"
}



#' 
#' \code{IntegrateAttributesM2} integrates the attributes to 
#' be used by the second model
#' 
#' @examples 
#' IntegrateAttributesM2()
#' 
IntegrateAttributesM2 <- function() {

  #TODO  

}
