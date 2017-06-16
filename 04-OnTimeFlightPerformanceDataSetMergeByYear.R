#' 
#' \code{onTimeFlightPerformanceDataSetMergeByYear} merges the flight data 
#' into RDS files by year, so that working with the data would not consume 
#' all the memory of the running environment
#' 
#' @examples 
#' onTimeFlightPerformanceDataSetMergeByYear()
#' 
onTimeFlightPerformanceDataSetMergeByYear <- function() {
  dataDir <- getDataDir()
  startYear <- getStartYear()
  endYear <- getEndYear()
  startMonth <- getStartMonth()
  endMonth <- getEndMonth()

  for (i in startYear:endYear){
      
    RDSFileName <- paste(i,
                         "_On_Time_On_Time_Performance_01_Orig.rds",
                         sep = "")

    RDSFile <- paste(dataDir,
                     "/",
                     RDSFileName,
                     sep = "")

    #Create the RDS files only if they do not exist yet
    if (file.exists(RDSFile) != TRUE){
      
      for (j in startMonth:endMonth){
        
        variableName <- paste("On_Time_On_Time_Performance_",
                              i,
                              "_",
                              j,
                              sep = "")
  
        unzippedFileName <- paste(variableName,
                                  ".csv",
                                  sep = "")

        unzippedFile <- paste(dataDir,
                              "/",
                              unzippedFileName,
                              sep = "")
        
        assign(variableName,
               data.table(read.csv(unzippedFile,
                                   header = TRUE)))

        if (j == startMonth){
          dataOfWholeYear <- get(variableName)
          rm(list = ls(pattern = "On_Time_On_Time_Performance*"))
          gc()
        } 
        else {
          dataOfWholeYear <- rbindlist(list(dataOfWholeYear,
                                            get(variableName)))
          rm(list = ls(pattern = "On_Time_On_Time_Performance*"))
          gc()
        }
  
      } #end of "for (j in startMonth:endMonth)"
      
      dataOfWholeYear$DistanceGroup <- as.factor(dataOfWholeYear$DistanceGroup)
      
      saveRDS(dataOfWholeYear, file = RDSFile)
      message(RDSFileName," created.")
      
      #free up memory
      rm(dataOfWholeYear)
      gc()

    } 
    else {
      message(RDSFileName,
              " exists, no further action is required.")
    }
      
  } #end of "for (i in startYear:endYear)"
  
}
