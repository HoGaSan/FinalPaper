source("90-UserDefinedFunctions.R")
suppressPackageStartupMessages(loadLibraries())
suppressPackageStartupMessages(readConfigFile(TRUE))
suppressPackageStartupMessages(loadSourceCodeFunctions())
suppressPackageStartupMessages(wildLifeStrikeDataSet())
suppressPackageStartupMessages(onTimeFlightPerformanceDataSet())
suppressPackageStartupMessages(wildLifeStrikeDataSetDataCleanup())

versionDetails()

backupFiles()

#gc()