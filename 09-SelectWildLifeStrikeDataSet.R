#' 
#' \code{SelectWildLifeStrikeDataSet} executes the identified 
#' exclusions and inclusions in the data set validation report
#' 
#' @examples 
#' SelectWildLifeStrikeDataSet()
#' 
SelectWildLifeStrikeDataSet <- function() {

  dataDir <- getDataDir()
  startYear <- getStartYear()
  endYear <- getEndYear()

  for (i in startYear:endYear){
    RDSFileName <- paste(i,
                       "_Animal_Strikes_02_Desc.rds",
                       sep = "")

    RDSFile <- paste(dataDir,
                   "/",
                   RDSFileName,
                   sep = "")

    RDSFileNameSelected <- paste(i,
                                 "_Animal_Strikes_03_Sel.rds",
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
        variableName <- paste("AS_", i, sep="")
        assign(variableName, readRDS(file = RDSFile))
  
        #OPID column selection
        selectedDataSet <- get(variableName)[!OPID %in% c("PVT",
                                                          "BUS",
                                                          "GOV",
                                                          "MIL",
                                                          "UNKC",
                                                          "UNK"),]
        
        #AC_CLASS selection
        selectedDataSet <- selectedDataSet[!AC_CLASS %in% c("B",
                                                            "C",
                                                            "D",
                                                            "F",
                                                            "I",
                                                            "J",
                                                            "Y",
                                                            "Z",
                                                            ""),]
        #TYPE_ENG selection
        selectedDataSet <- selectedDataSet[!TYPE_ENG %in% c("E",
                                                            "F",
                                                            ""),]

        #STATE selection
        selectedDataSet <- selectedDataSet[STATE %in% getStates(),]
        
        #AC_MASS resetting
        selectedDataSet$AC_MASS <- as.factor(selectedDataSet$AC_MASS)
        
        #Resetting the factors of the data table
        selectedDataSet[] <- 
          lapply(selectedDataSet,
                 function(x) if(is.factor(x)) factor(x) else x)

        saveRDS(selectedDataSet, file = RDSFileSelected)
  
        #Free up the memory
        rm(list = variableName)
        rm(variableName)
        gc()
        
      } #end of "if (file.exists(RDSFileSelected) == TRUE)"
      
    } #end of "if (file.exists(RDSFile) != TRUE)"
    
  } #end of "for (i in startYear:endYear)"

}
