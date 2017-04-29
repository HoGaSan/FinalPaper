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
#Files are available from 1987, but we need them only from 1990
for (i in 1990:2016){
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

#setwd("DataSets")
#setwd("..")
#getwd()

#Unzipping
for (i in 1990:2016){
  for (j in 1:12){
    #zipped file unzipping
    zippedFileName <- paste("On_Time_On_Time_Performance_", i, "_", j, ".zip", sep = "")
    zippedFile <- paste(getwd(), "/DataSets/", zippedFileName, sep = "")
    print(paste("Unzipping: ",zippedFile,sep=""))
    #No overwrite, so if the unzip was done, then it's not done again.
    #Gives warning because of the "readme.html" file, which is there in every zip file.
    unzip(zippedFile, overwrite = FALSE, exdir = paste(getwd(), "/DataSets", sep = ""))
  }
}

#warnings()


#variable creation

for (i in 1990:2016){ #2016
  for (j in 1:12){
    #unzipped file handling
    unzippedFileName <- paste("On_Time_On_Time_Performance_", i, "_", j, ".csv", sep = "")
    unzippedFile <- paste(getwd(), "/DataSets/", unzippedFileName, sep = "")
    variableName <- paste("On_Time_On_Time_Performance_", i, "_", j, sep = "")
    if (file.exists(unzippedFile) == TRUE){
      print(variableName)
      assign(variableName, data.table(read.csv(unzippedFile, header = TRUE)))
    }
  }
}
