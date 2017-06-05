#' 
#' \code{DescribeOnTimeFlightPerformanceDataSet} re-creates the
#' inputs based on the column selection of the data 
#' verification report
#' 
#' @examples 
#' DescribeOnTimeFlightPerformanceDataSet()
#' 
DescribeOnTimeFlightPerformanceDataSet <- function() {
  
  dataDir <- getDataDir()
  startYear <- getStartYear()
  endYear <- getEndYear()
  
  for (i in startYear:endYear){
    RDSFileName <- paste(i,
                         "_On_Time_On_Time_Performance_01_Orig.rds",
                         sep = "")
    
    RDSFile <- paste(dataDir,
                     "/",
                     RDSFileName,
                     sep = "")

    RDSFileNameDescibed <- paste(i,
                                 "_On_Time_On_Time_Performance_02_Desc.rds",
                                 sep = "")
    
    RDSFileDescibed <- paste(dataDir,
                             "/",
                             RDSFileNameDescibed,
                             sep = "")
    
    if (file.exists(RDSFile) != TRUE){
      message(RDSFileName,
              " is not available, ",
              "please re-run the preparation scripts!")
    } else {
      
      if (file.exists(RDSFileDescibed) == TRUE){
        message(RDSFileNameDescibed,
                " exists, no further action is required.")
      } else {

        #Read the data file into a variable
        variableName <- paste("AS_", i, sep="")
        assign(variableName, readRDS(file = RDSFile))
        
        #set the required column names
        ColumnNames <- c("Year",
                         "Quarter",
                         "Month",
                         "DayofMonth",
                         "DayOfWeek",
                         "FlightDate",
                         "Carrier",
                         "FlightNum",
                         "Origin",
                         "OriginCityName",
                         "OriginState",
                         "OriginStateName",
                         "Dest",
                         "DestCityName",
                         "DestState",
                         "DestStateName",
                         "CRSDepTime",
                         "DepTimeBlk",
                         "CRSArrTime",
                         "ArrTimeBlk",
                         "CRSElapsedTime",
                         "Distance",
                         "DistanceGroup")
  
        #Move reduces data into a new data set
        describedDataSet <- get(variableName)[, ..ColumnNames]
        
        
        saveRDS(describedDataSet, file = RDSFileDescibed)
        
        #Free up the memory
        rm(list = variableName)
        rm(variableName)
        rm(describedDataSet)
        gc()
        
      } #end of "if (file.exists(RDSFileDescibed) == TRUE)"
      
    } #end of "if (file.exists(RDSFile) != TRUE)"
    
  } #end of "for (i in startYear:endYear)"
  
}
