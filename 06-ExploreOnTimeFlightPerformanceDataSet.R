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
  documentsInputDir <- getDocInputDir()
  
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
    }
    else {
      #Read the data file into a variable
      variableName <- paste("FP_", i, sep="")
      assign(variableName, readRDS(file = RDSFile))
      
      #TODO:
      #Create analysis graphs, data
      
      
      
      #Free up the memory
      rm(list = variableName)
      rm(variableName)
      gc()
      
    }
    
  } #end of "for (i in startYear:endYear)"
  
}
