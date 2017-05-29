wildLifeStrikeDataSet <- function() {
  #setting the download parameters
  URL <- getWData()
  destfile <- paste(getDataDir(), "wildlife.zip", sep = "/")
  
  method="auto"
  
  #if the file exists then do not download again
  if (file.exists(destfile) != TRUE)
  {
    download.file(URL, destfile, method)
  } else
  {
    message("File exists no download required.")
  }
  
  destdir <- getDataDir()
  
  #unzip the file
  unzip(destfile, exdir = destdir)

  csvfile <- paste(destdir, "/STRIKE_REPORTS (1990-1999).csv", sep="")
  
  if (file.exists(csvfile) != TRUE)
  {
    setwd(getDataDir())
    system(paste("java -jar ", 
                 getDataDir(), 
                 "/access2csv.jar ", 
                 getDataDir(), 
                 "/wildlife.accdb", 
                 sep = ""))
    setwd(getMainDir())
  } else
  {
    message("File exists no extract required.")
  }
  
}
