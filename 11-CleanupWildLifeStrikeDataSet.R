#' 
#' \code{CleanupWildLifeStrikeDataSet} cleans up the data 
#' set quality isses based on the data quality report 
#' findings and creates secondary exploration report for 
#' comparism purposes
#' 
#' @param createPNG boolean
#' Flag to decide to create the PNG images or not
#' 
#' @examples 
#' CleanupWildLifeStrikeDataSet()
#' 
CleanupWildLifeStrikeDataSet <- function(createPNG) {

  dataDir <- getDataDir()
  startYear <- getStartYear()
  endYear <- getEndYear()

  dataSummary <- data.table(
    dataYear = character(),
    numberOfRecords = integer(),
    factorOPID = integer(),
    factorATYPE = integer(),
    factorAC_CLASS = integer(),
    factorAC_MASS = integer(),
    factorTYPE_ENG = integer(),
    factorTIME_OF_DAY = integer(),
    factorAIRPORT_ID = integer(),
    factorSTATE = integer(),
    factorPHASE_OF_FLT = integer(),
    factorSKY = integer(),
    factorPRECIP = integer(),
    factorWARNED = integer()
  )
  
  dataSummaryAirport <- data.table(
    airport = character()
  )
  
  for (i in startYear:endYear){
    RDSFileName <- paste(i,
                       "_Animal_Strikes_03_Sel.rds",
                       sep = "")

    RDSFile <- paste(dataDir,
                   "/",
                   RDSFileName,
                   sep = "")

    RDSFileNameCleaned <- paste(i,
                                "_Animal_Strikes_04_Cle.rds",
                                sep = "")
    
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
        variableName <- paste("AS_", i, sep="")
        assign(variableName, readRDS(file = RDSFile))
        
        cleanedDataSet <- get(variableName)
  
        #Convert the factor characters to uppercase
        cleanedDataSet[] <- 
          lapply(cleanedDataSet,
                 function(x) if(is.factor(x)) 
                   as.factor(toupper(as.character(x))) else x)
        
        #Change values to plural
        cleanedDataSet[SKY == "SOME CLOUD", SKY:= "SOME CLOUDS"]
        cleanedDataSet[SKY == "NO CLOUD", SKY:= "NO CLOUDS"]
        
        #populate empty factors to none for selected columns
        cleanedDataSet[TIME_OF_DAY == "", TIME_OF_DAY:= "NONE"]
        cleanedDataSet[PHASE_OF_FLT == "", PHASE_OF_FLT:= "NONE"]
        cleanedDataSet[SKY == "", SKY:= "NONE"]
        cleanedDataSet[PRECIP == "", PRECIP:= "NONE"]
        cleanedDataSet[WARNED == "", WARNED:= "NONE"]
        
        #change engine type
        cleanedDataSet[TYPE_ENG == "A/C", TYPE_ENG:= "A"]
        cleanedDataSet[TYPE_ENG == "B/D", TYPE_ENG:= "B"]

        #Resetting the factors of the data table
        cleanedDataSet[] <- 
          lapply(cleanedDataSet,
                 function(x) if(is.factor(x)) factor(x) else x)
        
        dataSummary <- rbindlist(
          list(
            dataSummary,
            list(as.character(i),
                 nrow(cleanedDataSet),
                 length(levels(cleanedDataSet$OPID)),
                 length(levels(cleanedDataSet$ATYPE)),
                 length(levels(cleanedDataSet$AC_CLASS)),
                 length(levels(cleanedDataSet$AC_MASS)),
                 length(levels(cleanedDataSet$TYPE_ENG)),
                 length(levels(cleanedDataSet$TIME_OF_DAY)),
                 length(levels(cleanedDataSet$AIRPORT_ID)),
                 length(levels(cleanedDataSet$STATE)),
                 length(levels(cleanedDataSet$PHASE_OF_FLT)),
                 length(levels(cleanedDataSet$SKY)),
                 length(levels(cleanedDataSet$PRECIP)),
                 length(levels(cleanedDataSet$WARNED))
                 )
            )
        )
        
        dataSummaryAirport <- rbindlist(
          list(
            dataSummaryAirport,
            unique(cleanedDataSet[,c("AIRPORT_ID")], 
                   by = c("AIRPORT_ID"))
          )
        )
        
        
        if (createPNG == TRUE) {
    
          #Save the plots as PNG files
          saveBarPlotPNG(DataYear = i, 
                         DataSet = "AnimalStrike", 
                         DataField = "AC_CLASS", 
                         DataStage = "04_Cleaned",
                         DataObject = cleanedDataSet)
          saveBarPlotPNG(DataYear = i, 
                         DataSet = "AnimalStrike", 
                         DataField = "AC_MASS", 
                         DataStage = "04_Cleaned",
                         DataObject = cleanedDataSet)
          saveBarPlotPNG(DataYear = i, 
                         DataSet = "AnimalStrike", 
                         DataField = "TYPE_ENG", 
                         DataStage = "04_Cleaned",
                         DataObject = cleanedDataSet)
          saveBarPlotPNG(DataYear = i, 
                         DataSet = "AnimalStrike",
                         DataField = "TIME_OF_DAY", 
                         DataStage = "04_Cleaned",
                         DataObject = cleanedDataSet)
          saveBarPlotPNG(DataYear = i, 
                         DataSet = "AnimalStrike", 
                         DataField = "PHASE_OF_FLT", 
                         DataStage = "04_Cleaned",
                         DataObject = cleanedDataSet)
          saveBarPlotPNG(DataYear = i, 
                         DataSet = "AnimalStrike", 
                         DataField = "SKY", 
                         DataStage = "04_Cleaned",
                         DataObject = cleanedDataSet)
          saveBarPlotPNG(DataYear = i,
                         DataSet = "AnimalStrike", 
                         DataField = "PRECIP", 
                         DataStage = "04_Cleaned",
                         DataObject = cleanedDataSet)
        }

        saveRDS(cleanedDataSet, file = RDSFileCleaned)
        
        #Free up the memory
        rm(list = variableName)
        rm(variableName)
        gc()
        
      } #end of "if (file.exists(RDSFileCleaned) == TRUE)"

    } #end of "if (file.exists(RDSFile) != TRUE)"

  } #end of "for (i in startYear:endYear)"
  
  
  RDSExpFileName <- "03_CLEANED_Animal_Strikes.rds"
  
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

  RDSExpFileName <- "03_CLEANED_Animal_Strikes_Airports.rds"
  
  RDSExpFile <- paste(dataDir,
                           "/",
                      RDSExpFileName,
                           sep = "")
  
  dataSummaryAirport <- 
    unique(dataSummaryAirport[,c("airport")],
           by = c("airport"))
  
  
  if (file.exists(RDSExpFile) != TRUE) {
    saveRDS(dataSummaryAirport,
            file = RDSExpFile)
  } else {
    file.remove(RDSExpFile)
    saveRDS(dataSummaryAirport,
            file = RDSExpFile)
  }
  
  
}
