#' 
#' \code{DescribeWildLifeStrikeDataSet} re-creates the
#' inputs based on the column selection of the data 
#' verification report
#' 
#' @examples 
#' DescribeWildLifeStrikeDataSet()
#' 
DescribeWildLifeStrikeDataSet <- function() {

  dataDir <- getDataDir()
  startYear <- getStartYear()
  endYear <- getEndYear()

  for (i in startYear:endYear){
    RDSFileName <- paste(i,
                       "_Animal_Strikes_01_Orig.rds",
                       sep = "")

    RDSFile <- paste(dataDir,
                   "/",
                   RDSFileName,
                   sep = "")

    RDSFileNameDescibed <- paste(i,
                                 "_Animal_Strikes_02_Desc.rds",
                                 sep = "")
    
    RDSFileDescibed <- paste(dataDir,
                             "/",
                             RDSFileNameDescibed,
                             sep = "")
    
    if (file.exists(RDSFile) != TRUE){
      message(RDSFileName,
              "is not available, ",
              "please re-run the preparation scripts!")
    } else {

      if (file.exists(RDSFileDescibed) == TRUE){
        message(RDSFileNameDescibed,
                " exists, no further action is required.")
      } else {
        
        #Read the data file into a variable
        variableName <- paste("AS_", i, sep="")
        assign(variableName, readRDS(file = RDSFile))
        
        #set the required column names
        ColumnNames <- c("INDEX_NR",
                         "OPID",
                         "OPERATOR",
                         "ATYPE",
                         "AC_CLASS",
                         "AC_MASS",
                         "TYPE_ENG",
                         "REG",
                         "FLT",
                         "INCIDENT_DATE",
                         "INCIDENT_MONTH",
                         "INCIDENT_YEAR",
                         "TIME_OF_DAY",
                         "TIME",
                         "AIRPORT_ID",
                         "AIRPORT",
                         "STATE",
                         "FAAREGION",
                         "ENROUTE",
                         "RUNWAY",
                         "HEIGHT",
                         "SPEED",
                         "DISTANCE",
                         "PHASE_OF_FLT",
                         "SKY",
                         "PRECIP",
                         "WARNED")
        
        #Move reduces data into a new data set
        describedDataSet <- get(variableName)[, ..ColumnNames]
        
        saveRDS(describedDataSet, file = RDSFileDescibed)
  
        #Free up the memory
        rm(list = variableName)
        rm(variableName)
        rm(describedDataSet)
        gc()
      
      } #end of "if (file.exists(RDSFileDescibed) == TRUE)"
      
    } #end of "if (file.exists(RDSFile) != TRUE)"

  } #end of "for (i in startYear:endYear)"

}
