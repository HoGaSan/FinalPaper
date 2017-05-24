
onTimeFlightPerformanceDataSet <- function() {
  #setting the download parameters
  readConfigFile(TRUE)
  
  method="auto"
  dataDir <- getDataDir()
  startYear <- getStartYear()
  endYear <- getEndYear()
  startMonth <- getStartMonth()
  endMonth <- getEndMonth()

  for (i in startYear:endYear){
    for (j in startMonth:endMonth){
      
      variableName <- paste("On_Time_On_Time_Performance_", i, "_", j, sep = "")
      
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
        message(sourceFile," file exists, no download is required.")
      }
      
      zippedFileName <- sourceFile
      zippedFile <- destinationFile
      unzippedFileName <- paste(variableName, ".csv", sep = "")
      unzippedFile <- paste(dataDir, "/", unzippedFileName, sep = "")
      
      #if the file exists then do not unzip it again
      if (file.exists(unzippedFile) != TRUE)
      {
        message("Unzipping ", zippedFileName)
        unzip(zippedFile, overwrite = FALSE, exdir = dataDir) #No overwrite, so if the unzip was done (and the if condition is wrong), then it's not done again.
        #Clear warnings to get rid of the unzip warnings created because of the "readme.html" file, which is there in every zip file.
        assign("last.warning", NULL, envir = baseenv())
      } else
      {
        message(unzippedFileName," file exists, no unzip is required.")
      }
      
      #if the variable is available, then do not reassign it
      if (exists(variableName) != TRUE){
        message("Reading ", variableName)
        assign(variableName, data.table(read.csv(unzippedFile, header = TRUE)), envir = .GlobalEnv)
      } else
      {
        message(variableName," variable exists, no assign is required.")
      }
      
    } #end of "for (j in startMonth:endMonth)"
  } #end of "for (i in startYear:endYear)"
  
}