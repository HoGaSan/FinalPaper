#' 
#' \code{onTimeFlightPerformanceDataSet} based on the configuration 
#' items checkes if the commercial flight data set files have been:
#'  - downloaded
#'  - uncompressed
#' if not, then execute these tasks.
#' 
#' @examples 
#' onTimeFlightPerformanceDataSet()
#' 
onTimeFlightPerformanceDataSet <- function() {

  method="auto"
  dataDir <- getDataDir()
  startYear <- getStartYear()
  endYear <- getEndYear()
  startMonth <- getStartMonth()
  endMonth <- getEndMonth()

  for (i in startYear:endYear){
    for (j in startMonth:endMonth){
      
      variableName <- paste("On_Time_On_Time_Performance_",
                            i,
                            "_",
                            j,
                            sep = "")
      
      sourceFile <- paste(variableName, ".zip", sep = "")
      URL <- paste(getFData(), sourceFile, sep = "")
      destinationFile <- paste(dataDir, "/", sourceFile, sep = "")
      
      #if the file exists then do not download again
      if (file.exists(destinationFile) != TRUE)
      {
        message("Downloading ", sourceFile)
        download.file(URL, destinationFile, method)
        Sys.sleep(0.1)
      } else
      {
        message(sourceFile,
                " file exists, no download is required.")
      }
      
      zippedFileName <- sourceFile
      zippedFile <- destinationFile
      unzippedFileName <- paste(variableName,
                                ".csv",
                                sep = "")
      unzippedFile <- paste(dataDir, "/", unzippedFileName, sep = "")
      
      #if the file exists then do not unzip it again
      if (file.exists(unzippedFile) != TRUE)
      {
        message("Unzipping ", zippedFileName)
        unzip(zippedFile, 
              overwrite = FALSE, 
              exdir = dataDir) #No overwrite
        #Clear warnings
        assign("last.warning", NULL, envir = baseenv())
      } else
      {
        message(unzippedFileName,
                " file exists, no unzip is required.")
      }

    } #end of "for (j in startMonth:endMonth)"
  } #end of "for (i in startYear:endYear)"
  
}
