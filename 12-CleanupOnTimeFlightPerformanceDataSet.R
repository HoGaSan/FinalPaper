#' 
#' \code{CleanupOnTimeFlightPerformanceDataSet} cleans up 
#' the data set quality isses based on the data quality 
#' report findings and creates secondary exploration 
#' report for comparism purposes
#' 
#' @param createPNG boolean
#' Flag to decide to create the PNG images or not
#' 
#' @examples 
#' CleanupOnTimeFlightPerformanceDataSet()
#' 
CleanupOnTimeFlightPerformanceDataSet <- function(createPNG) {
  
  dataDir <- getDataDir()
  startYear <- getStartYear()
  endYear <- getEndYear()

  dataSummary <- data.table(
    dataYear = character(),
    numberOfRecords = integer(),
    factorCarrier = integer(),
    factorOrigin = integer(),
    factorOriginState = integer(),
    factorDest = integer(),
    factorDestState = integer(),
    factorDepTimeBlk = integer(),
    factorDistanceGroup = integer()
  )

  dataSummaryOriginAirport <- data.table(
    originAirport = character()
  )
  
  dataSummaryDestinationAirport <- data.table(
    destinationAirport = character()
  )
  
  for (i in startYear:endYear){
    RDSFileName <- paste(i,
                         "_On_Time_On_Time_Performance_03_Sel.rds",
                         sep = "")

    RDSFile <- paste(dataDir,
                     "/",
                     RDSFileName,
                     sep = "")

    RDSFileNameCleaned <- paste(i,
                                "_On_Time_On_Time_Performance_04_Cle.rds",
                                sep = "")
    
    RDSFileCleaned <- paste(dataDir,
                            "/",
                            RDSFileNameCleaned,
                            sep = "")
    
    if (file.exists(RDSFile) != TRUE){
      message(RDSFileName,
              "is not available, ",
              "please re-run the preparation scripts!")
    } else {
      
      if (file.exists(RDSFileCleaned) == TRUE){
        message(RDSFileNameCleaned,
                " exists, no further action is required.")
      } else {
        
        #Read the data file into a variable
        variableName <- paste("FP_", i, sep="")
        assign(variableName, readRDS(file = RDSFile))
        
        
        cleanedDataSet <- get(variableName)
        
        
        #Resetting the factors of the data table
        cleanedDataSet[] <- 
          lapply(cleanedDataSet,
                 function(x) if(is.factor(x)) factor(x) else x)
        
        dataSummary <- rbindlist(
          list(
            dataSummary,
            list(as.character(i),
                 nrow(cleanedDataSet),
                 length(levels(cleanedDataSet$Carrier)),
                 length(levels(cleanedDataSet$Origin)),
                 length(levels(cleanedDataSet$OriginState)),
                 length(levels(cleanedDataSet$Dest)),
                 length(levels(cleanedDataSet$DestState)),
                 length(levels(cleanedDataSet$DepTimeBlk)),
                 length(levels(cleanedDataSet$DistanceGroup))
                 )
            )
          )

        dataSummaryOriginAirport <- rbindlist(
          list(
            dataSummaryOriginAirport,
            unique(cleanedDataSet[,c("Origin")], 
                   by = c("Origin"))
          )
        )
        
        dataSummaryDestinationAirport <- rbindlist(
          list(
            dataSummaryDestinationAirport,
            unique(cleanedDataSet[,c("Dest")], 
                   by = c("Dest"))
          )
        )
        
        if (createPNG == TRUE) {
          
          #Save the plots as PNG files
          saveBarPlotPNG(DataYear = i, 
                         DataSet = "FlightData", 
                         DataField = "Carrier", 
                         DataStage = "04_Cleaned",
                         DataObject = cleanedDataSet)
          
          saveBarPlotPNG(DataYear = i, 
                         DataSet = "FlightData", 
                         DataField = "DistanceGroup", 
                         DataStage = "04_Cleaned",
                         DataObject = cleanedDataSet)
        }

        saveRDS(cleanedDataSet, file = RDSFileCleaned)
        
        #Free up the memory
        rm(list = variableName)
        rm(variableName)
        gc()
        
      } #end of "if (file.exists(RDSFileCleaned) == TRUE)"
      
    } #end of "if (file.exists(RDSFile) != TRUE)"
    
  } #end of "for (i in startYear:endYear)"

  RDSExpFileName <- "03_CLEANED_Flight_Data.rds"
  
  RDSExpFile <- paste(dataDir,
                      "/",
                      RDSExpFileName,
                      sep = "")
  
  if (file.exists(RDSExpFile) != TRUE) {
    saveRDS(dataSummary, file = RDSExpFile)
  } else {
    file.remove(RDSExpFile)
    saveRDS(dataSummary, file = RDSExpFile)
  }

  RDSExpStateFileName <- "03_CLEANED_Flight_Data_O_Airports.rds"
  
  RDSExpStateFile <- paste(dataDir,
                           "/",
                           RDSExpStateFileName,
                           sep = "")
  
  dataSummaryOriginAirport <- 
    unique(dataSummaryOriginAirport[,c("originAirport")],
           by = c("originAirport"))
  
  
  if (file.exists(RDSExpStateFile) != TRUE) {
    saveRDS(dataSummaryOriginAirport,
            file = RDSExpStateFile)
  } else {
    file.remove(RDSExpStateFile)
    saveRDS(dataSummaryOriginAirport,
            file = RDSExpStateFile)
  }
  
  
  RDSExpStateFileName <- "03_CLEANED_Flight_Data_D_Airports.rds"
  
  RDSExpStateFile <- paste(dataDir,
                           "/",
                           RDSExpStateFileName,
                           sep = "")
  
  dataSummaryDestinationAirport <- 
    unique(dataSummaryDestinationAirport[,c("destinationAirport")], 
           by = c("destinationAirport"))
  
  if (file.exists(RDSExpStateFile) != TRUE) {
    saveRDS(dataSummaryDestinationAirport,
            file = RDSExpStateFile)
  } else {
    file.remove(RDSExpStateFile)
    saveRDS(dataSummaryDestinationAirport,
            file = RDSExpStateFile)
  }
  
}
