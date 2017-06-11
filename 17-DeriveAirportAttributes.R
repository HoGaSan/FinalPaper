#' 
#' \code{DeriveAirportAttributes} created airport specific attribures 
#' based on the flight performance data set
#' 
#' @examples 
#' DeriveAirportAttributes()
#' 
DeriveAirportAttributes <- function() {
  
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
