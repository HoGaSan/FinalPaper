#' 
#' \code{SelectOnTimeFlightPerformanceDataSet} executes the identified 
#' exclusions and inclusions in the data set validation report
#' 
#' @examples 
#' SelectOnTimeFlightPerformanceDataSet()
#' 
SelectOnTimeFlightPerformanceDataSet <- function() {
  
  dataDir <- getDataDir()
  startYear <- getStartYear()
  endYear <- getEndYear()

  for (i in startYear:endYear){

    RDSFileName <- paste(i,
                         "_On_Time_On_Time_Performance_02_Desc.rds",
                         sep = "")
    
    RDSFile <- paste(dataDir,
                     "/",
                     RDSFileName,
                     sep = "")
    
    RDSFileNameSelected <- paste(i,
                                 "_On_Time_On_Time_Performance_03_Sel.rds",
                                 sep = "")
    
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
        variableName <- paste("FP_", i, sep="")
        assign(variableName, readRDS(file = RDSFile))
        
        #TODO
        
        if (i == 2016) {
          selectedDataSet <- get(variableName)[Month < 5,]
        } else {
          selectedDataSet <- get(variableName)
        }
        
        
        saveRDS(selectedDataSet, file = RDSFileSelected)
        
        #Free up the memory
        rm(list = variableName)
        rm(variableName)
        gc()
        
      } #end of "if (file.exists(RDSFileSelected) == TRUE)"
      
    } #end of "if (file.exists(RDSFile) != TRUE)"
  
  } #end of "for (i in startYear:endYear)"

}
