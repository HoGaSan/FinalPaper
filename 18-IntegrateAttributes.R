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

  dataDir <- getDataDir()
  startYear <- getStartYear()
  endYear <- getEndYear()
  
  
  RDSFileName <- "07_CLE_Airport.rds"
  RDSFile <- paste(dataDir,
                   "/",
                   RDSFileName,
                   sep = "")
  
  dataSummary <- data.table(
    numberOfFlightRecords = integer(),
    numberOfStrikesLinked = integer()
  )
  
  
  if (file.exists(RDSFile) != TRUE){
    message(RDSFileName,
            " is not available,",
            " please re-run the preparation scripts!")
  } else {
    airportData <- readRDS(file = RDSFile)
  }
  
  for (i in startYear:endYear){
    RDSFlightFileName <- paste(i,
                               "_On_Time_On_Time_Performance_04_Cle.rds",
                               sep = "")
    
    RDSFlightFile <- paste(dataDir,
                           "/",
                           RDSFlightFileName,
                           sep = "")
    
    RDSStrikeFileName <- paste(i,
                               "_Animal_Strikes_04_Cle.rds",
                               sep = "")
    
    RDSStrikeFile <- paste(dataDir,
                           "/",
                           RDSStrikeFileName,
                           sep = "")
    
    if ((file.exists(RDSFlightFile) != TRUE) ||
        (file.exists(RDSStrikeFile) != TRUE)){
      message(RDSFlightFileName,
              " or ",
              RDSStrikeFileName,
              " is not available,",
              " please re-run the preparation scripts!")
    } else {
      
      #Flight data
      variableName <- paste("FP_", i, sep="")
      assign(variableName, readRDS(file = RDSFlightFile))
      flightDataSet <- get(variableName)
      rm(list = variableName)
      rm(variableName)

      #handling carrier changes in the data
      flightDataSet[,UniqueCarrier := substr(UniqueCarrier, 1, 2)]
      
      #adding the name of the carrier to the data
      flightDataSet[,CarrierName := getAirlineName(UniqueCarrier),
                    by = UniqueCarrier]

      #set the airline list
      airlineList <- unique(flightDataSet$CarrierName)
      
      #set the merge key
      flightDataSet[, mergeKeyD := paste(FlightDate,
                                        Dest,
                                        DestState,
                                        CarrierName,
                                        FlightNum,
                                        sep = "_")]

      #set the merge key
      flightDataSet[, mergeKeyO := paste(FlightDate,
                                         Origin,
                                         OriginState,
                                         CarrierName,
                                         FlightNum,
                                         sep = "_")]
      #reset the factors
      flightDataSet[] <- 
        lapply(flightDataSet,
               function(x) if(is.factor(x)) factor(x) else x)
      
      #Strike data
      variableName <- paste("AS_", i, sep="")
      assign(variableName, readRDS(file = RDSStrikeFile))
      strikeDataSet <- get(variableName)
      rm(list = variableName)
      rm(variableName)
      gc()
      
      #date setting
      strikeDataSet[,FlightDate := as.Date(format(as.Date(paste(INCIDENT_YEAR,
                                                                INCIDENT_MONTH,
                                                                INCIDENT_DATE,
                                                                sep = "-")),
                                                  format = "%Y-%m-%d"))]
      #set the required column names
      ColumnNames <- c("OPERATOR",
                       "FLT",
                       "TIME",
                       "AIRPORT_ID",
                       "STATE",
                       "PHASE_OF_FLT",
                       "FlightDate")
      
      #Move reduces data into a new data set
      strikeDataSet <- strikeDataSet[, ..ColumnNames]
      
      #remove those records where the flight number is empty
      strikeDataSet <- strikeDataSet[!FLT=="",]

      #typo handling
      strikeDataSet[OPERATOR == "1US AIRWAYS",
                    OPERATOR := "US AIRWAYS"]
      
      #select only those strike reports which have the airline from the flight data
      strikeDataSet <- strikeDataSet[OPERATOR %in% airlineList,]
      
      #remove those records where the flight phase does not indicate if 
      #the strike has been on the origin or destination airport
      strikeDataSet <- strikeDataSet[!PHASE_OF_FLT %in% c("TAXI",
                                                         "NONE",
                                                         "LOCAL",
                                                         "PARKED"),]
      
      #set airports
      #Origin
      strikeDataSet[PHASE_OF_FLT %in% c("CLIMB",
                                        "TAKE-OFF RUN",
                                        "DEPARTURE"),
                    Origin := airportData[IcaoIdentifier == AIRPORT_ID,
                                          LocationID],
                    by = AIRPORT_ID]
      #Destination
      strikeDataSet[PHASE_OF_FLT %in% c("APPROACH",
                                        "DESCENT",
                                        "LANDING ROLL",
                                        "ARRIVAL"),
                    Dest := airportData[IcaoIdentifier == AIRPORT_ID,
                                        LocationID],
                    by = AIRPORT_ID]
      #setting factors
      strikeDataSet$Origin <- as.factor(strikeDataSet$Origin)
      strikeDataSet$Dest <- as.factor(strikeDataSet$Dest)
      
      #set the merge key
      strikeDataSet[, mergeKeyD := paste(FlightDate,
                                         Dest,
                                         STATE,
                                         OPERATOR,
                                         FLT,
                                         sep = "_")]
      
      #set the merge key
      strikeDataSet[, mergeKeyO := paste(FlightDate,
                                         Origin,
                                         STATE,
                                         OPERATOR,
                                         FLT,
                                         sep = "_")]
      
      
      #Resetting the factors of the data tables
      strikeDataSet[] <- 
        lapply(strikeDataSet,
               function(x) if(is.factor(x)) factor(x) else x)
      
      #Setting the flag for the modelling
      flightDataSet[,strikeFlag := 0]
      flightDataSet[mergeKeyD %in% strikeDataSet$mergeKeyD,
                    strikeFlag := 1]
      flightDataSet[mergeKeyO %in% strikeDataSet$mergeKeyO,
                    strikeFlag := 1]
      
      #set the required column names
      ColumnNames <- c("Year",
                       "Quarter",
                       "Month",
                       "DayofMonth",
                       "DayOfWeek",
                       "FlightDate",
                       "UniqueCarrier",
                       "FlightNum",
                       "Origin",
                       "Dest",
                       "DepTimeBlk",
                       "ArrTimeBlk",
                       "CRSElapsedTime",
                       "Distance",
                       "DistanceGroup",
                       "strikeFlag")
      
      #Move reduces data into a new data set
      flightDataSet <- flightDataSet[, ..ColumnNames]
      
      dataSummary <- rbindlist(
        list(
          dataSummary,
          data.table(
            flightDataSet[,.N],
            flightDataSet[strikeFlag == 1, .N]
          )
        )
      )
      
      #save the data for modeling
      RDSModel02FileName <- paste(i,
                                 "_On_Time_On_Time_Performance_05_Mod.rds",
                                 sep = "")
      RDSModel02File <- paste(dataDir,
                             "/",
                             RDSModel02FileName,
                             sep = "")
      
      saveRDS(flightDataSet, file = RDSModel02File)
      

      
      #TODO: memory cleanup
      rm(strikeDataSet)
      rm(flightDataSet)
      gc()
      

    } # end of "if ((file.exists(RDSFlightFile) != TRUE)
      #          || (file.exists(RDSStrikeFile) != TRUE))"
  
    
  } #end of "for (i in startYear:endYear)"
  
  dataSummaryFinal <- dataSummary[, .(sum(numberOfFlightRecords), sum(numberOfStrikesLinked))]
  names(dataSummaryFinal) <- c("numberOfFlightRecords","numberOfStrikesLinked")
  
  RDSFileName <- "11_Model_02_SummaryData.rds"
  RDSFile <- paste(dataDir,
                   "/",
                   RDSFileName,
                   sep = "")
  
  if (file.exists(RDSFile) != TRUE) {
    saveRDS(dataSummaryFinal, file = RDSFile)
  } else {
    file.remove(RDSFile)
    saveRDS(dataSummaryFinal, file = RDSFile)
  }

}
