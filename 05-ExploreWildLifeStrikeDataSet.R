#' 
#' \code{ExploreWildLifeStrikeDataSet} creates the inputs 
#' for the Data Exploration Report based on the WildLife 
#' strike data set
#' 
#' @examples 
#' ExploreWildLifeStrikeDataSet()
#' 
ExploreWildLifeStrikeDataSet <- function() {

  dataDir <- getDataDir()
  startYear <- getStartYear()
  endYear <- getEndYear()

  dataSummary <- data.table(
    dataYear = character(),
    numberOfRecords = integer(),
    factorOPID = integer(),
    factopATYPE = integer(),
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

  for (i in startYear:endYear){
    RDSFileName <- paste(i,
                       "_Animal_Strikes.rds",
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
      assign(variableName, readRDS(file = RDSFile))
      
      dataSummary <- rbindlist(
        list(
          dataSummary,
          list(as.character(i),
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
          ))

      #Save the plots as PNG files
      saveBarPlotPNG(DataYear = i, 
                     DataSet = "AnimalStrike", 
                     DataField = "AC_CLASS", 
                     DataObject = table(get(variableName)$AC_CLASS))
      saveBarPlotPNG(DataYear = i, 
                     DataSet = "AnimalStrike", 
                     DataField = "AC_MASS", 
                     DataObject = table(get(variableName)$AC_MASS))
      saveBarPlotPNG(DataYear = i, 
                     DataSet = "AnimalStrike", 
                     DataField = "TYPE_ENG", 
                     DataObject = table(get(variableName)$TYPE_ENG))
      saveBarPlotPNG(DataYear = i, 
                     DataSet = "AnimalStrike",
                     DataField = "TIME_OF_DAY", 
                     DataObject = table(get(variableName)$TIME_OF_DAY))
      saveBarPlotPNG(DataYear = i, 
                     DataSet = "AnimalStrike", 
                     DataField = "PHASE_OF_FLT", 
                     DataObject = table(get(variableName)$PHASE_OF_FLT))
      saveBarPlotPNG(DataYear = i, 
                     DataSet = "AnimalStrike", 
                     DataField = "SKY", 
                     DataObject = table(get(variableName)$SKY))
      saveBarPlotPNG(DataYear = i,
                     DataSet = "AnimalStrike", 
                     DataField = "PRECIP", 
                     DataObject = table(get(variableName)$PRECIP))
      
      #Free up the memory
      rm(list = variableName)
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

}
