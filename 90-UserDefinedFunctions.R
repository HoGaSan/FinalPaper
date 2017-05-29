#Project functions

#Function name: loadLibraries
#Input: none
#Output: none
#Main use: load the required libraries for the project, if library is not installed, than installs it as well

loadLibraries <- function() {
  if (!require(installr)) {install.packages("installr"); require(installr)}
  if (!require(RODBC)) {install.packages("RODBC"); require(RODBC)}
  if (!require(knitr)) {install.packages("knitr"); require(knitr)}
  if (!require(data.table)) {install.packages("data.table"); require(data.table)}
  if (!require(dplyr)) {install.packages("dplyr"); require(dplyr)}
  if (!require(dtplyr)) {install.packages("dtplyr"); require(dtplyr)}
  if (!require(ggplot2)) {install.packages("ggplot2"); require(ggplot2)}
  if (!require(ReporteRs)) {install.packages("ReporteRs"); require(ReporteRs)}
  if (!require(yaml)) {install.packages("yaml"); require(yaml)}
  
  #update R
  updateR(TRUE)
  
  #update MiKTeX packages
  #system("mpm --update --quiet")
  
  #require(grid)
  #require(lattice)
  #require(ggplot2movies)
  #require(latticeExtra)
}



#Function name: versionDetails
#Input: none
#Output: The version details of the environment used for the project
#Main use: with just one function call have the possibility to provide the environment details into the rmd

versionDetails <- function() {
  
  cat(paste(
    "R Studio version 1.0.143\n\n", 
    version$version.string, " ", version$`svn rev`,"\n\n",
    "Package versions:\n",
    "- RODBC version ", packageVersion("RODBC"),"\n",
    "- knitr version ", packageVersion("knitr"),"\n",
    "- data.table version ", packageVersion("data.table"),"\n",
    "- dplyr version ", packageVersion("dplyr"),"\n",
    "- dtplyr version ", packageVersion("dtplyr"),"\n",
    "- ReporteRs version ", packageVersion("ReporteRs"),"\n",
    "- ReporteRsjars version ", packageVersion("ReporteRsjars"),"\n",
    "- installr version ", packageVersion("installr"),"\n",
    "- stringr version ", packageVersion("stringr"),"\n",
    "- ggplot2 version ", packageVersion("ggplot2"),"\n",
    "- yaml version ", packageVersion("yaml"),"\n\n",
    "Base package versions:\n",
    "- stats version ", packageVersion("stats"),"\n",
    "- graphics version ", packageVersion("graphics"),"\n",
    "- grDevices version ", packageVersion("grDevices"),"\n",
    "- utils version ", packageVersion("utils"),"\n",
    "- datasets version ", packageVersion("datasets"),"\n",
    "- methods version ", packageVersion("methods"),"\n",
    "- base version ", packageVersion("base"),sep=""))
  
}

#Function name: versionDetailsMiKTeX
#Input: none
#Output: The version details of the environment used for the project
#Main use: with just one function call have the possibility to provide the environment details into the rmd

versionDetailsMiKTeX <- function() {
  
  cat(system("mpm --version", intern = TRUE), sep = '\n')
  
}


#Function name: versionDetailsMiKTeXPackages
#Input: none
#Output: The version details of the environment used for the project
#Main use: with just one function call have the possibility to provide the environment details into the rmd

versionDetailsMiKTeXPackages <- function() {
  
  cat(system("mpm --list", intern = TRUE), sep = '\n')
  
}


#Function name: readConfigFile
#Input: none
#Output: none
#Main use: reads the config file to a global variable to use in the session

readConfigFile <- function(a) {
  vName <- "config"
  if (a == TRUE){
    assign(vName, yaml.load_file("91-Config.yaml"), envir = .GlobalEnv)
  }
  else {
    assign(vName, yaml.load_file("../91-Config.yaml"), envir = .GlobalEnv)
  }
}

#Function name: getMainDir
#Input: none
#Output: the main directory from the config file
#Main use: call it whenever you need to get the main directory - might not be the same as the result of getwd()

getMainDir <- function() {
  return(config$directories$maindir)
}


#Function name: getBackupDir
#Input: none
#Output: the name of the backup directory from the config file, plus the timestamp directory created as part of the function
#Main use: call it whenever you need to get the backup directory

getBackupDir <- function() {
  backupdir <- config$directories$backupdir
  subdir <- Sys.Date()
  returnvalue <- file.path(backupdir, subdir)
  
  if (!file.exists(returnvalue)){
    dir.create(returnvalue)
    dir.create(file.path(returnvalue, "Documents"))
  }
    
  return(returnvalue)

}


#Function name: getDocDir
#Input: none
#Output: the Documents directory from the config file
#Main use: call it whenever you need to get the Documents directory

getDocDir <- function() {
  return(config$directories$documents)
}

#Function name: getDocInputDir
#Input: none
#Output: the Documents directory from the config file
#Main use: call it whenever you need to get the Documents directory

getDocInputDir <- function() {
  return(config$directories$documentinput)
}

#Function name: getDocOutputDir
#Input: none
#Output: the Documents directory from the config file
#Main use: call it whenever you need to get the Documents directory

getDocOutputDir <- function() {
  return(config$directories$documentoutput)
}


#Function name: getDataDir
#Input: none
#Output: the DataSets directory from the config file
#Main use: call it whenever you need to get the DataSets directory

getDataDir <- function() {
  return(config$directories$datasets)
}


#Function name: getStartYear
#Input: none
#Output: start year
#Main use: call it whenever you need to get the start year of the data set to work with

getStartYear <- function() {
  return(config$years$startyear)
}


#Function name: getEndYear
#Input: none
#Output: start year
#Main use: call it whenever you need to get the end year of the data set to work with

getEndYear <- function() {
  return(config$years$endyear)
}


#Function name: getStartMonth
#Input: none
#Output: start year
#Main use: call it whenever you need to get the start month of the data set to work with

getStartMonth <- function() {
  return(config$months$startmonth)
}


#Function name: getEndMonth
#Input: none
#Output: start year
#Main use: call it whenever you need to get the end month of the data set to work with

getEndMonth <- function() {
  return(config$months$endmonth)
}


#Function name: backupFiles
#Input: none
#Output: the name of the backup directory from the config file, plus the timestamp directory created as part of the function
#Main use: call it whenever you need to get the backup directory

backupFiles <- function() {
  
  #Main directoery files
  filesMain <- list.files(getMainDir(), full.names = TRUE)
  file.copy(filesMain, getBackupDir(), overwrite = TRUE)

  #Documents folder
  filesDocuments <- list.files(getDocDir(), full.names = TRUE)
  file.copy(filesDocuments, file.path(getBackupDir(), "Documents"), overwrite = TRUE)
  
}


#Function name: getWData
#Input: none
#Output: the Wildlife Data Set url from the config file
#Main use: call it whenever you need to get the url

getWData <- function() {
  return(config$sources$wildlife)
}


#Function name: getFData
#Input: none
#Output: the Flight Data Set url from the config file
#Main use: call it whenever you need to get the url

getFData <- function() {
  return(config$sources$flightdata)
}



#Function name: removeDataSetVariables
#Input: none
#Output: none
#Main use: call it whenever you need to cleanup the Data Set variables

removeDataSetVariables <- function() {

  #rm(list = ls(pattern = "On_Time_On_Time_Performance*", envir = .GlobalEnv), envir = .GlobalEnv)
  #rm(list = ls(pattern = "sr_*", envir = .GlobalEnv), envir = .GlobalEnv)
  
}

#Function name: loadSourceCodeFunctions
#Input: 
#Output: 
#Main use: 

loadSourceCodeFunctions <- function() {
  
  source("01-WildLiveStrikeDataSetDataPreparation.R")
  source("02-OnTimeFlightPerformanceDataSetDataPreparation.R")
  source("03-WildLiveStrikeDataSetDataCleanup.R")

}

