#' 
#' \code{ExploreOnTimeFlightPerformanceDataSet} creates
#' the inputs for the Data Exploration Report based on
#' the Flight data set
#' 
#' @examples 
#' ExploreOnTimeFlightPerformanceDataSet()
#' 
ExploreOnTimeFlightPerformanceDataSet <- function() {
  
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
  
  for (i in startYear:endYear){
    RDSFileName <- paste(i,
                         "_On_Time_On_Time_Performance.rds",
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
      
      #TODO:
      #Create analysis graphs, data

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
          )))

      #Save the plots as PNG files
      saveBarPlotPNG(DataYear = i, 
                     DataSet = "FlightData", 
                     DataField = "Carrier", 
                     DataObject = table(get(variableName)$Carrier))

      saveBarPlotPNG(DataYear = i, 
                     DataSet = "FlightData", 
                     DataField = "DistanceGroup", 
                     DataObject = table(get(variableName)$DistanceGroup))

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

}
