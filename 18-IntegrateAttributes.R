#' 
#' \code{IntegrateAttributesM1} integrates the attributes to 
#' be used by the first model
#' 
#' @examples 
#' IntegrateAttributesM1()
#' 
IntegrateAttributesM1 <- function() {
  
  dataDir <- getDataDir()
  
  #Data:
  #Airports - get the merged airport list from flight data origins, destination airports and the strike data airports
  #Airport attributes based on the flights data
  #airport attributes based on the stike data:
  # - number of strikes by airport
  # - number of strikes by airport by flight phase
  # - number of strikes by airport by day
  # - number of strikes by airport by sky
  
  RDSFileName <- "05_DESC_Airport.rds"
  
  RDSFile <- paste(dataDir,
                   "/",
                   RDSFileName,
                   sep = "")
  
  RDSFileNameSelected <- "06_SEL_Airport.rds"
  
  RDSFileSelected <- paste(dataDir,
                           "/",
                           RDSFileNameSelected,
                           sep = "")
  
  if (file.exists(RDSFile) != TRUE){
    message(RDSFileName,
            "is not available, ",
            "please re-run the preparation scripts!")
  } else {
    
    
    if (file.exists(RDSFileSelected) == TRUE){
      message(RDSFileNameSelected,
              " exists, no further action is required.")
    } else {
      
      #Read the data file into a variable
      originalDataSet <- readRDS(file = RDSFile)
      
      #TYPE column selection
      selectedDataSet <- originalDataSet[Type == "AIRPORT",]
      
      #STATE selection
      selectedDataSet <- selectedDataSet[State %in% getStates(),]
      
      #Merge origin and destination airport data
      RDSFileNameOriginAirport <- "03_CLEANED_Flight_Data_O_Airports.rds"
      
      RDSFileOriginAirport <- paste(dataDir,
                                    "/",
                                    RDSFileNameOriginAirport,
                                    sep = "")
      
      originAirports <- readRDS(file = RDSFileOriginAirport)
      
      names(originAirports) <- c("Airport")
      
      RDSFileNameDestinationAirport <- "03_CLEANED_Flight_Data_D_Airports.rds"
      
      RDSFileDestinationAirport <- paste(dataDir,
                                         "/",
                                         RDSFileNameDestinationAirport,
                                         sep = "")
      
      destinationAirports <- readRDS(file = RDSFileDestinationAirport)
      
      names(destinationAirports) <- c("Airport")
      
      airportListDT <- merge(originAirports, destinationAirports, all=TRUE)
      
      #Get the impacted airport only 
      selectedDataSet <- selectedDataSet[State %in% airportListDT[],]
      
      #Resetting the factors of the data table
      selectedDataSet[] <- 
        lapply(selectedDataSet,
               function(x) if(is.factor(x)) factor(x) else x)
      
      saveRDS(selectedDataSet, file = RDSFileSelected)
      
    } #end of "if (file.exists(RDSFileSelected) == TRUE)"
    
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

  airportAttributes <- data.table(
    airportCode = character(),
    airportName = character(),
    avgOriginated = integer(),
    avgDeparted = integer(),
    maxDistanceOriginated = integer(),
    maxDistanceDeparted = ingeter(),
    avgDistanceOriginated = integer(),
    avgDistanceDeparted = ingeter(),
    minDistanceOriginated = integer(),
    minDistanceDeparted = ingeter()
  )

  airportAttributesByYear <- data.table(
    airportCode = character(),
    airportName = character(),
    dataYear = character(),
    avgOriginated = integer(),
    avgDeparted = integer(),
    maxDistanceOriginated = integer(),
    maxDistanceDeparted = ingeter(),
    avgDistanceOriginated = integer(),
    avgDistanceDeparted = ingeter(),
    minDistanceOriginated = integer(),
    minDistanceDeparted = ingeter()
  )
  
  for (i in startYear:endYear){
    RDSFileName <- paste(i,
                         "_On_Time_On_Time_Performance_04_Cle.rds",
                         sep = "")

    RDSFile <- paste(dataDir,
                     "/",
                     RDSFileName,
                     sep = "")

    if (file.exists(RDSFile) != TRUE){
      message(RDSFileName,
              "is not available, ",
              "please re-run the preparation scripts!")
    } else {
      
      #Read the data file into a variable
      variableName <- paste("FP_", i, sep="")
      assign(variableName, readRDS(file = RDSFile))
      
      
      dataSet <- get(variableName)
      
      #Get the number of flights, minimum, maximum and summary distances
      DT1 <- dataSet[, 
                     .(.N,
                       max(Distance),
                       min(Distance),
                       sum(Distance)), 
                     by = c("Origin", "Year")]
      names(DT1) <- c("Airport",
                      "Year",
                      "OriginCount",
                      "OriginMaxDistance",
                      "OriginMinDistance",
                      "OriginSumDistance")
      setkey(DT1, Airport, Year)
      
      DT2 <- dataSet[, 
                     .(.N,
                       max(Distance),
                       min(Distance),
                       sum(Distance)),
                     by = c("Dest", "Year")]
      names(DT2) <- c("Airport",
                      "Year",
                      "DestinationCount",
                      "DestinationMaxDistance",
                      "DestinationMinDistance",
                      "DestinationSumDistance")
      setkey(DT2, Airport, Year)
      
      DT3 <- DT1[DT2]
      
      
      
      
      
      
      
      # airportAttributesByYear <- rbindlist(
      #   list(
      #     airportAttributesByYear,
      #     dataSet[,]
      #     list(cleanedDataSet
      #          as.character(i),
      #          nrow(cleanedDataSet),
      #          length(levels(cleanedDataSet$Carrier)),
      #          length(levels(cleanedDataSet$Origin)),
      #          length(levels(cleanedDataSet$OriginState)),
      #          length(levels(cleanedDataSet$Dest)),
      #          length(levels(cleanedDataSet$DestState)),
      #          length(levels(cleanedDataSet$DepTimeBlk)),
      #          length(levels(cleanedDataSet$DistanceGroup))
      #          )
      #     )
      #   )
      

      #Free up the memory
      rm(list = variableName)
      rm(variableName)
      gc()
        
    } #end of "if (file.exists(RDSFile) != TRUE)"
    
  } #end of "for (i in startYear:endYear)"

  RDSAirportAttributesName <- paste("04_Airport_Attributes.rds",
                                    sep = "")
  
  RDSAirportAttributes <- paste(dataDir,
                                "/",
                                RDSAirportAttributesName,
                                sep = "")
  
  if (file.exists(RDSAirportAttributes) != TRUE) {
    saveRDS(dataSummary, file = RDSAirportAttributes)
  } else {
    file.remove(RDSAirportAttributes)
    saveRDS(dataSummary, file = RDSAirportAttributes)
  }

}
