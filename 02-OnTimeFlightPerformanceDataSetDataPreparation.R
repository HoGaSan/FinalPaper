#getwd()
#setwd("DataSets")
#setwd("..")
#Files are located: https://www.transtats.bts.gov/PREZIP/
#File naming pattern: On_Time_On_Time_Performance_<year>_<month>.zip
#File name example: On_Time_On_Time_Performance_1989_12.zip
#https://www.transtats.bts.gov/DL_SelectFields.asp?Table_ID=236&DB_Short_Name=On-Time


#Setting the download parameters
#Generating the filenames
#Downloading the files

method="auto"
for (i in 1987:2016){
  for (j in 1:12){
    sourceFile <- paste("On_Time_On_Time_Performance_", i, "_", j, ".zip", sep = "")
    URL <- paste("https://www.transtats.bts.gov/PREZIP/", sourceFile, sep = "")
    destinationFile <- paste(getwd(), "/DataSets/", sourceFile, sep = "")
    
    #if the file exists then do not download again
    if (file.exists(destinationFile) != TRUE)
    {
      message("Downloading ", sourceFile)
      download.file(URL, destinationFile, method)
      Sys.sleep(0.5)
    } else
    {
      message(sourceFile," file exists, no download required.")
    }
  }
}

##OK##############################


#files moved to /tmp/flightData

#unzip the file
destfile2 <- "/app/finalProject/flightData/On_Time_On_Time_Performance_1987_11.zip"
unzip(destfile2, exdir = "/app/finalProject/flightData/")

unzippedfile <- "/app/finalProject/flightData/On_Time_On_Time_Performance_1987_10.csv"

system.time(
On_Time_On_Time_Performance_1987_10 <- data.table(read.csv(unzippedfile, header = TRUE))
)
