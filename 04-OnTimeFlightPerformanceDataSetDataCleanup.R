
onTimeFlightPerformanceDataSetDataCleanup <- function() {
  dataDir <- getDataDir()
  startYear <- getStartYear()
  endYear <- getEndYear()
  startMonth <- getStartMonth()
  endMonth <- getEndMonth()

  for (i in startYear:endYear){
    for (j in startMonth:endMonth){
      
      variableName <- paste("On_Time_On_Time_Performance_", i, "_", j, sep = "")
      
      unzippedFileName <- paste(variableName, ".csv", sep = "")
      unzippedFile <- paste(dataDir, "/", unzippedFileName, sep = "")

      #if the variable is available, then do not reassign it
      # if (exists(variableName) != TRUE){
      #   message("Reading ", variableName)
      #   assign(variableName, 
      #          data.table(read.csv(unzippedFile, 
      #                              header = TRUE)), 
      #          envir = .GlobalEnv)
      # } else
      # {
      #   message(variableName," variable exists, no assign is required.")
      # }

      #TODO:
      #- remove unused and/or duplicated columns
      #- annual data set merge
      #- save separate data file for each year --> ?? size
      
        
    } #end of "for (j in startMonth:endMonth)"
  } #end of "for (i in startYear:endYear)"
  
}
