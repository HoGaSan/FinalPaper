#' 
#' \code{ExploreOnTimeFlightPerformanceDataSet} creates
#' the inputs for the Data Exploration Report based on
#' the Flight data set
#' 
#' @param createPNG boolean
#' Flag to decide to create the PNG images or not
#' 
#' @examples 
#' ExploreOnTimeFlightPerformanceDataSet(FALSE)
#' 
ExploreOnTimeFlightPerformanceDataSet <- function(createPNG) {
  
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
  
  dataSummaryOriginState <- data.table(
    originState = character(),
    originStateName = character()
  )
  
  dataSummaryDestState <- data.table(
    destState = character(),
    destStateName = character()
  )
  
  for (i in startYear:endYear){
    RDSFileName <- paste(i,
                         "_On_Time_On_Time_Performance_01_Orig.rds",
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
      
      dataSummary <- rbindlist(
        list(
          dataSummary,
          list(as.character(i),
               nrow(get(variableName)),
               length(levels(get(variableName)$Carrier)),
               length(levels(get(variableName)$Origin)),
               length(levels(get(variableName)$OriginState)),
               length(levels(get(variableName)$Dest)),
               length(levels(get(variableName)$DestState)),
               length(levels(get(variableName)$DepTimeBlk)),
               length(levels(as.factor(get(variableName)$DistanceGroup)))
               )
          )
        )

      dataSummaryOriginState <- rbindlist(
        list(
          dataSummaryOriginState,
          unique(get(variableName)[,c("OriginState",
                                      "OriginStateName")],
                 by = c("OriginState",
                        "OriginStateName"))
          )
        )

      dataSummaryDestState <- rbindlist(
        list(
          dataSummaryDestState,
          unique(get(variableName)[,c("DestState",
                                      "DestStateName")], 
                 by = c("DestState",
                        "DestStateName"))
          )
        )
      
      if (createPNG == TRUE) {
        #Save the plots as PNG files
        saveBarPlotPNG(DataYear = i, 
                       DataSet = "FlightData", 
                       DataField = "Carrier", 
                       DataStage = "01_Orig",
                       DataObject = get(variableName))

        saveBarPlotPNG(DataYear = i, 
                       DataSet = "FlightData", 
                       DataField = "DistanceGroup", 
                       DataStage = "01_Orig",
                       DataObject = get(variableName))
      }

      #Free up the memory
      rm(list = variableName)
      rm(variableName)
      gc()
      
    } #end of "if (file.exists(RDSFile) != TRUE)"
    
  } #end of "for (i in startYear:endYear)"

  RDSExpFileName <- "02_EXP_Flight_Data.rds"
  
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
  
  RDSExpStateFileName <- "02_EXP_Flight_Data_O_States.rds"
  
  RDSExpStateFile <- paste(dataDir,
                           "/",
                           RDSExpStateFileName,
                           sep = "")
  
  dataSummaryOriginState <- 
    unique(dataSummaryOriginState[,c("originState",
                                     "originStateName")],
           by = c("originState",
                  "originStateName"))

  dataSummaryOriginState <- dataSummaryOriginState[order(originState)]
    
  if (file.exists(RDSExpStateFile) != TRUE) {
    saveRDS(dataSummaryOriginState,
            file = RDSExpStateFile)
  } else {
    file.remove(RDSExpStateFile)
    saveRDS(dataSummaryOriginState,
            file = RDSExpStateFile)
  }
  

  RDSExpStateFileName <- "02_EXP_Flight_Data_D_States.rds"
  
  RDSExpStateFile <- paste(dataDir,
                           "/",
                           RDSExpStateFileName,
                           sep = "")
  
  dataSummaryDestState <- 
    unique(dataSummaryDestState[,c("destState",
                                   "destStateName")], 
           by = c("destState",
                  "destStateName"))
  
  dataSummaryDestState <- dataSummaryDestState[order(destState)]
    
  if (file.exists(RDSExpStateFile) != TRUE) {
    saveRDS(dataSummaryDestState,
            file = RDSExpStateFile)
  } else {
    file.remove(RDSExpStateFile)
    saveRDS(dataSummaryDestState,
            file = RDSExpStateFile)
  }

}
