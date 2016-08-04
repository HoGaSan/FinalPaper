#getwd()
#setwd("DataSets")
#setwd("..")
#Files are located: http://tsdata.bts.gov/PREZIP/
#File naming pattern: On_Time_On_Time_Performance_<year>_<month>.zip
#File name example: On_Time_On_Time_Performance_1989_12.zip

#setting the download parameters
URL <- "http://tsdata.bts.gov/PREZIP/On_Time_On_Time_Performance_1987_10.zip"
destfile <- "./DataSets/On_Time_On_Time_Performance_1987_10.zip"
method="curl"

#if the file exists then do not download again
if (file.exists(destfile) != TRUE)
{
  download.file(URL, destfile, method)
} else
{
  message("File exists no download required.")
}

#unzip the file
unzip(destfile, exdir = "./DataSets")

On_Time_On_Time_Performance_1987_10 <- data.table(read.csv(destfile, header = TRUE))


