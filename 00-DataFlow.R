#rm(list = ls())
getwd()
setwd(getMainDir())

source("90-UserDefinedFunctions.R")
#load the required libraries - 90
  loadLibraries()
#read the config file - 90
  readConfigFile(TRUE)
#get the file specific functions - 90
  loadSourceCodeFunctions()
#download and extract the data is required - 01
  wildLifeStrikeDataSet()
#download and extract the data is required - 02
  onTimeFlightPerformanceDataSet()
#Split data by year --> RDS "_01_Orig" - 03
  wildLifeStrikeDataSetSplitByYear()
#Merge data by year --> RDS "_01_Orig" - 04
  onTimeFlightPerformanceDataSetMergeByYear()
#PNG plot creation - 05
  ExploreWildLifeStrikeDataSet(createPNG = TRUE)
#PNG plot creation - 06
  ExploreOnTimeFlightPerformanceDataSet(createPNG = TRUE)
#Take required columns --> RDS "_02_Desc" - 07
  DescribeWildLifeStrikeDataSet()
#Take required columns --> RDS "_02_Desc" - 08
  DescribeOnTimeFlightPerformanceDataSet()
#Take out not required rows --> RDS "_03_Sel" - 09
  SelectWildLifeStrikeDataSet()
#Take out not required rows --> RDS "_03_Sel" - 10
  SelectOnTimeFlightPerformanceDataSet()
#Cleanup the data --> RDS "_04_Cle" - 11
  CleanupWildLifeStrikeDataSet(createPNG = FALSE)
#Cleanup the data --> RDS "_04_Cle" - 12
  CleanupOnTimeFlightPerformanceDataSet(createPNG = FALSE)
#Airport data preparation - 13 --> ORIG
  AirportDataSetDataPreparation()
#Airport data describe - 14 --> DESC
  DescribeAirportDataSet()
#Airport data select - 15 --> SEL
  SelectAirportDataSet()
#Airport data cleanup - 16 --> CLE
  CleanupAirportDataSet() 
#Derive airport attirbutes - 17 --> DER
  DeriveAirportAttributes()
#Integrate attributes for model 01 - 18 --> "09_Model_01_Data.rds"
  IntegrateAttributesM1()
#Integrate attributes for model 02 - 18 --> "_05_Mod"
  IntegrateAttributesM2()
#Build Model 01 - 19 --> "10_Model_01_*"
  BuildModel01()
#Build Model 02 - 20 --> "12_Model_02_Data.rds"
  BuildModel02Data()

  
regeneratePlots()
backupFiles()

#rm(list=ls())
#gc()



onTimeFlightPerformanceDataSetMergeByYear()
ExploreOnTimeFlightPerformanceDataSet(createPNG = TRUE)
DescribeOnTimeFlightPerformanceDataSet()
SelectOnTimeFlightPerformanceDataSet()
CleanupOnTimeFlightPerformanceDataSet(createPNG = TRUE)

