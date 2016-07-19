#getwd()
#setwd("DataSets")
#setwd("..")
#File location: http://wildlife.faa.gov/downloads/wildlife.zip

#setting the download parameters
URL <- "http://wildlife.faa.gov/downloads/wildlife.zip"
destfile <- "./DataSets/wildlife.zip"
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

#Convert Access database tables to csv files using the access2csv from "https://github.com/AccelerationNet/access2csv"
setwd("DataSets")
#getwd()
system("java -jar access2csv.jar wildlife.accdb")
setwd("..")
#getwd()

#Read files to data frames --> data tables
sr_1990_1999 <- data.table(read.csv("./DataSets/STRIKE_REPORTS (1990-1999).csv", header = FALSE))
sr_2000_2009 <- data.table(read.csv("./DataSets/STRIKE_REPORTS (2000-2009).csv", header = FALSE))
sr_2010_Current <- data.table(read.csv("./DataSets/STRIKE_REPORTS (2010-Current).csv", header = FALSE))
srb_1990_Current <- data.table(read.csv("./DataSets/STRIKE_REPORTS_BASH (1990-Current).csv", header = FALSE))



