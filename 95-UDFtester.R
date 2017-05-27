source("90-UserDefinedFunctions.R")
suppressPackageStartupMessages(loadLibraries())
suppressPackageStartupMessages(readConfigFile(TRUE))
source("01-WildLiveStrikeDataSetDataPreparation.R")
suppressPackageStartupMessages(wildLifeStrikeDataSet())
source("02-OnTimeFlightPerformanceDataSetDataPreparation.R")
suppressPackageStartupMessages(onTimeFlightPerformanceDataSet())
source("03-WildLiveStrikeDataSetDataCleanup.R")
suppressPackageStartupMessages(wildLifeStrikeDataSetDataCleanup())

versionDetails()

backupFiles()

#gc()