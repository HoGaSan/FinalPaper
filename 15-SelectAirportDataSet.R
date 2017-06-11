#' 
#' \code{SelectAirportDataSet} executes the identified 
#' exclusions and inclusions in the data set validation report
#' 
#' @examples 
#' SelectAirportDataSet()
#' 
SelectAirportDataSet <- function() {

  dataDir <- getDataDir()

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
      
      #Resetting the factors of the data table
      selectedDataSet[] <- 
        lapply(selectedDataSet,
               function(x) if(is.factor(x)) factor(x) else x)

      saveRDS(selectedDataSet, file = RDSFileSelected)

    } #end of "if (file.exists(RDSFileSelected) == TRUE)"
    
  } #end of "if (file.exists(RDSFile) != TRUE)"

}
