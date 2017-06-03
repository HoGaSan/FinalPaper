source("90-UserDefinedFunctions.R")
suppressPackageStartupMessages(loadLibraries())
suppressPackageStartupMessages(readConfigFile(TRUE))
suppressPackageStartupMessages(loadSourceCodeFunctions())
suppressPackageStartupMessages(wildLifeStrikeDataSet())
suppressPackageStartupMessages(onTimeFlightPerformanceDataSet())
suppressPackageStartupMessages(wildLifeStrikeDataSetSplitByYear())
suppressPackageStartupMessages(onTimeFlightPerformanceDataSetMergeByYear())

versionDetails()

backupFiles()

#gc()

#rm(list = ls(pattern = "sr_*"))

dataDir <- getDataDir()
startYear <- getStartYear()
endYear <- getEndYear()

for (i in startYear:endYear){
  RDSFileName <- paste(i,
                       "_Animal_Strikes.rds",
                       sep = "")
  
  RDSFile <- paste(dataDir,
                   "/",
                   RDSFileName,
                   sep = "")
  
  if (file.exists(RDSFile) == TRUE){
    #file.remove(RDSFile)
    
  }
}


AS1990 <- readRDS(file = paste(dataDir, "/1990_Animal_Strikes.rds", sep=""))
AS1991 <- readRDS(file = paste(dataDir, "/1991_Animal_Strikes.rds", sep=""))
AS1992 <- readRDS(file = paste(dataDir, "/1992_Animal_Strikes.rds", sep=""))
AS1993 <- readRDS(file = paste(dataDir, "/1993_Animal_Strikes.rds", sep=""))
AS1994 <- readRDS(file = paste(dataDir, "/1994_Animal_Strikes.rds", sep=""))
AS1995 <- readRDS(file = paste(dataDir, "/1995_Animal_Strikes.rds", sep=""))
AS1996 <- readRDS(file = paste(dataDir, "/1996_Animal_Strikes.rds", sep=""))
AS1997 <- readRDS(file = paste(dataDir, "/1997_Animal_Strikes.rds", sep=""))
AS1998 <- readRDS(file = paste(dataDir, "/1998_Animal_Strikes.rds", sep=""))
AS1999 <- readRDS(file = paste(dataDir, "/1999_Animal_Strikes.rds", sep=""))

AS2000 <- readRDS(file = paste(dataDir, "/2000_Animal_Strikes.rds", sep=""))
AS2001 <- readRDS(file = paste(dataDir, "/2001_Animal_Strikes.rds", sep=""))
AS2002 <- readRDS(file = paste(dataDir, "/2002_Animal_Strikes.rds", sep=""))
AS2003 <- readRDS(file = paste(dataDir, "/2003_Animal_Strikes.rds", sep=""))
AS2004 <- readRDS(file = paste(dataDir, "/2004_Animal_Strikes.rds", sep=""))
AS2005 <- readRDS(file = paste(dataDir, "/2005_Animal_Strikes.rds", sep=""))
AS2006 <- readRDS(file = paste(dataDir, "/2006_Animal_Strikes.rds", sep=""))
AS2007 <- readRDS(file = paste(dataDir, "/2007_Animal_Strikes.rds", sep=""))
AS2008 <- readRDS(file = paste(dataDir, "/2008_Animal_Strikes.rds", sep=""))
AS2009 <- readRDS(file = paste(dataDir, "/2009_Animal_Strikes.rds", sep=""))

AS2010 <- readRDS(file = paste(dataDir, "/2010_Animal_Strikes.rds", sep=""))
AS2011 <- readRDS(file = paste(dataDir, "/2011_Animal_Strikes.rds", sep=""))
AS2012 <- readRDS(file = paste(dataDir, "/2012_Animal_Strikes.rds", sep=""))
AS2013 <- readRDS(file = paste(dataDir, "/2013_Animal_Strikes.rds", sep=""))
AS2014 <- readRDS(file = paste(dataDir, "/2014_Animal_Strikes.rds", sep=""))
AS2015 <- readRDS(file = paste(dataDir, "/2015_Animal_Strikes.rds", sep=""))
AS2016 <- readRDS(file = paste(dataDir, "/2016_Animal_Strikes.rds", sep=""))
