#' 
#' \code{ExploreWildLifeStrikeDataSet} creates the inputs 
#' for the Data Exploration Report based on the WildLife 
#' strike data set
#' 
#' @param createPNG boolean
#' Flag to decide to create the PNG images or not
#' 
#' @examples 
#' ExploreWildLifeStrikeDataSet(FALSE)
#' 
ExploreWildLifeStrikeDataSet <- function(createPNG) {

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
  
  dataSummaryState <- data.table(
    state = character()
  )

  for (i in startYear:endYear){
    RDSFileName <- paste(i,
                       "_Animal_Strikes_01_Orig.rds",
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
      variableName <- paste("AS_", i, sep="")
      assign(variableName, readRDS(file = RDSFile), envir = .GlobalEnv)
      
      dataSummary <- rbindlist(
        list(
          dataSummary,
          list(
            as.character(i),
            nrow(get(variableName)),
            length(levels(get(variableName)$OPID)),
            length(levels(get(variableName)$ATYPE)),
            length(levels(get(variableName)$AC_CLASS)),
            length(levels(as.factor(get(variableName)$AC_MASS))),
            length(levels(get(variableName)$TYPE_ENG)),
            length(levels(get(variableName)$TIME_OF_DAY)),
            length(levels(get(variableName)$AIRPORT_ID)),
            length(levels(get(variableName)$STATE)),
            length(levels(get(variableName)$PHASE_OF_FLT)),
            length(levels(get(variableName)$SKY)),
            length(levels(get(variableName)$PRECIP)),
            length(levels(get(variableName)$WARNED))
            )
          )
        )
      
      dataSummaryState <- rbindlist(
        list(
          dataSummaryState,
          unique(get(variableName)[,"STATE"], by = c("STATE"))
        )
      )
      
      if (createPNG == TRUE) {
        #Save the plots as PNG files
        saveBarPlotPNG(DataYear = i, 
                       DataSet = "AnimalStrike", 
                       DataField = "AC_CLASS",
                       DataStage = "01_Orig",
                       DataObject = get(variableName))
        saveBarPlotPNG(DataYear = i, 
                       DataSet = "AnimalStrike", 
                       DataField = "AC_MASS", 
                       DataStage = "01_Orig",
                       DataObject = get(variableName))
        saveBarPlotPNG(DataYear = i, 
                       DataSet = "AnimalStrike", 
                       DataField = "TYPE_ENG", 
                       DataStage = "01_Orig",
                       DataObject = get(variableName))
        saveBarPlotPNG(DataYear = i, 
                       DataSet = "AnimalStrike",
                       DataField = "TIME_OF_DAY", 
                       DataStage = "01_Orig",
                       DataObject = get(variableName))
        saveBarPlotPNG(DataYear = i, 
                       DataSet = "AnimalStrike", 
                       DataField = "PHASE_OF_FLT", 
                       DataStage = "01_Orig",
                       DataObject = get(variableName))
        saveBarPlotPNG(DataYear = i, 
                       DataSet = "AnimalStrike", 
                       DataField = "SKY", 
                       DataStage = "01_Orig",
                       DataObject = get(variableName))
        saveBarPlotPNG(DataYear = i,
                       DataSet = "AnimalStrike", 
                       DataField = "PRECIP", 
                       DataStage = "01_Orig",
                       DataObject = get(variableName))
      }
      
      #Free up the memory
      rm(list = variableName, envir = .GlobalEnv)
      rm(variableName)
      gc()
      
    } #end of "if (file.exists(RDSFile) != TRUE)"

  } #end of "for (i in startYear:endYear)"
  
  
  RDSExpFileName <- "01_EXP_Animal_Strikes.rds"
  
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

  RDSExpStateFileName <- "01_EXP_Animal_Strikes_States.rds"
  
  RDSExpStateFile <- paste(dataDir,
                      "/",
                      RDSExpStateFileName,
                      sep = "")
  
  dataSummaryStateFinal <- 
    unique(dataSummaryState[,"state"], by = c("state"))
  
  #dataSummaryStateFinal <- dataSummaryStateFinal[order(state)]

  if (file.exists(RDSExpStateFile) != TRUE) {
    saveRDS(dataSummaryStateFinal, file = RDSExpStateFile)
  } else {
    file.remove(RDSExpStateFile)
    saveRDS(dataSummaryStateFinal, file = RDSExpStateFile)
  }
  

}
