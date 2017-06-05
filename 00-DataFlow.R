getwd()
setwd(getMainDir())

source("90-UserDefinedFunctions.R")
suppressPackageStartupMessages(loadLibraries())
suppressPackageStartupMessages(readConfigFile(TRUE))
suppressPackageStartupMessages(loadSourceCodeFunctions())
suppressPackageStartupMessages(wildLifeStrikeDataSet())
suppressPackageStartupMessages(onTimeFlightPerformanceDataSet())
suppressPackageStartupMessages(wildLifeStrikeDataSetSplitByYear())
suppressPackageStartupMessages(onTimeFlightPerformanceDataSetMergeByYear())
suppressPackageStartupMessages(ExploreWildLifeStrikeDataSet())
suppressPackageStartupMessages(ExploreOnTimeFlightPerformanceDataSet())


versionDetails()

backupFiles()

#rm(list=ls())
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


