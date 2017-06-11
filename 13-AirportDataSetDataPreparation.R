#' 
#' \code{AirportDataSetDataPreparation} based on the configuration 
#' items checks if the airport data set file has been:
#'  - downloaded
#'  - saved as an R object
#' 
#' @examples 
#' AirportDataSetDataPreparation()
#' 
AirportDataSetDataPreparation <- function() {
  
  dataDir <- getDataDir()
  sourceFile <- paste(dataDir, "NfdcFacilities.xls", sep = "/")
  destFile <- paste(dataDir, "NfdcFacilities.csv", sep = "/")
  
  method="auto"
  
  #if the file exists then do not download again
  if (file.exists(sourceFile) != TRUE) {
    message("Please download the aiport data set file.")
  } else
  {
    RDSFileName <- "04_ORIG_Airport.rds"
    
    RDSFile <- paste(dataDir,
                     "/",
                     RDSFileName,
                     sep = "")
    
    #copy and rename the file
    file.copy(sourceFile, destFile, overwrite = TRUE)
    
    DT <- data.table(read.delim(destFile))
    
    saveRDS(DT, file = RDSFile)
    message(RDSFileName," created.")

  } #end of "if (file.exists(sourceFile) != TRUE)"

}
