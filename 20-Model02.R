#' 
#' \code{BuildModel02} builds the second model
#' 
#' @examples 
#' BuildModel02()
#' 
BuildModel02 <- function() {
  

  dataDir <- getDataDir()
  startYear <- getStartYear()
  endYear <- getEndYear()
  
  
  for (i in startYear:endYear){
    RDSModelFileName <- paste(i,
                              "_On_Time_On_Time_Performance_05_Mod.rds",
                              sep = "")
    
    RDSModelFile <- paste(dataDir,
                          "/",
                          RDSModelFileName,
                          sep = "")
    
    
    if (file.exists(RDSModelFile) != TRUE) {
      message(RDSModelFileName,
              " is not available, ",
              "please re-run the preparation scripts!")
    } else {
      
      #TODO - model creation
      
    } # end of "if (file.exists(RDSModelFile) != TRUE)"

    
  } #end of "for (i in startYear:endYear)"

}
