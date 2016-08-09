#getwd()
#setwd("DataSets")
#setwd("..")
#Files are located: http://tsdata.bts.gov/PREZIP/
#File naming pattern: On_Time_On_Time_Performance_<year>_<month>.zip
#File name example: On_Time_On_Time_Performance_1989_12.zip


#Setting the download parameters
#Generating the filenames
#Downloading the files
method="curl"
for (i in 1987:2015){
  for (j in 1:12){
    sourceFile <- paste("On_Time_On_Time_Performance_", i, "_", j, ".zip", sep = "")
    URL <- paste("http://tsdata.bts.gov/PREZIP/", sourceFile, sep = "")
    destinationFile <- paste("./flightData/", sourceFile, sep = "")
    
    #if the file exists then do not download again
    if (file.exists(destinationFile) != TRUE)
    {
      message("Downloading ", sourceFile)
      download.file(URL, destinationFile, method)
      Sys.sleep(2)
    } else
    {
      message(sourceFile," file exists, no download required.")
    }
  }
}

#files moved to /tmp/flightData

#unzip the file
unzip(destfile, exdir = "./DataSets")
destfile2 <- "./DataSets/On_Time_On_Time_Performance_1987_10.csv"

system.time(
On_Time_On_Time_Performance_1987_10 <- data.table(read.csv(destfile2, header = TRUE))
)
