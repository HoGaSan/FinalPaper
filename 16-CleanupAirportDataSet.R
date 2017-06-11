#' 
#' \code{CleanupAirportDataSet} cleans up the data 
#' set quality isses based on the data quality report 
#' findings 
#' 
#' @examples 
#' CleanupAirportDataSet()
#' 
CleanupAirportDataSet <- function() {

  dataDir <- getDataDir()

  RDSFileName <- "06_SEL_Airport.rds"

  RDSFile <- paste(dataDir,
                 "/",
                 RDSFileName,
                 sep = "")

  RDSFileNameCleaned <- "07_CLE_Airport.rds"
  
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
      originalDataSet <- readRDS(file = RDSFile)
      
      cleanedDataSet <- originalDataSet
      cleanedDataSet$LocationID <- cleanedDataSet[,sub('.',
                                                       '',
                                                       LocationID)]
      
      #Resetting the factors of the data table
      cleanedDataSet[] <- 
        lapply(cleanedDataSet,
               function(x) if(is.factor(x)) factor(x) else x)
      
      saveRDS(cleanedDataSet, file = RDSFileCleaned)
      
    } #end of "if (file.exists(RDSFileCleaned) == TRUE)"

  } #end of "if (file.exists(RDSFile) != TRUE)"

}
