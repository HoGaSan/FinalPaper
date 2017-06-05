getwd()
setwd(getMainDir())

source("90-UserDefinedFunctions.R")
suppressPackageStartupMessages(loadLibraries()) #load the required libraries
suppressPackageStartupMessages(readConfigFile(TRUE)) #read the config file
suppressPackageStartupMessages(loadSourceCodeFunctions()) #get the file specific functions
suppressPackageStartupMessages(wildLifeStrikeDataSet()) #download and extract the data is required
suppressPackageStartupMessages(onTimeFlightPerformanceDataSet()) #download and extract the data is required
suppressPackageStartupMessages(wildLifeStrikeDataSetSplitByYear()) #Split data by year --> RDS "_01_Orig"
suppressPackageStartupMessages(onTimeFlightPerformanceDataSetMergeByYear()) #Merge data by year --> RDS "_01_Orig"
suppressPackageStartupMessages(ExploreWildLifeStrikeDataSet()) #PNG plot creation
suppressPackageStartupMessages(ExploreOnTimeFlightPerformanceDataSet()) #PNG plot creation
suppressPackageStartupMessages(DescribeWildLifeStrikeDataSet()) #Take required columns --> RDS "_02_Desc"
suppressPackageStartupMessages(DescribeOnTimeFlightPerformanceDataSet()) #Take required columns --> RDS "_02_Desc"
suppressPackageStartupMessages(SelectWildLifeStrikeDataSet()) #Take out not required rows --> RDS "_03_Sel"
suppressPackageStartupMessages(SelectOnTimeFlightPerformanceDataSet()) #Take out not required rows --> RDS "_03_Sel"

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


