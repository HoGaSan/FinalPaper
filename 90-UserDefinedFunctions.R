#' 
#' \code{loadLibraries} checkes if the required libraries are 
#'  - installed and
#'  - loaded
#' if not, the it installs (if required) and loads them.
#' 
#' @examples 
#' loadLibraries()
#' 
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


#' 
#' \code{versionDetails} provides details about the running environment
#' 
#' @return text with the versions of R, RStudio, and used packages
#' 
#' @examples 
#' versionDetails()
#' 
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


#' 
#' \code{versionDetailsMiKTeX} provides details about the running 
#' environment
#' 
#' @return text with the versions of MiKTeX
#' 
#' @examples 
#' versionDetailsMiKTeX()
#' 
versionDetailsMiKTeX <- function() {
  cat(system("mpm --version", intern = TRUE), sep = '\n')
}


#' 
#' \code{versionDetailsMiKTeXPackages} provides details about the 
#' running environment
#' 
#' @return text with the versions of the installed MiKTeX packages
#' 
#' @examples 
#' versionDetailsMiKTeXPackages()
#' 
versionDetailsMiKTeXPackages <- function() {
  cat(system("mpm --list", intern = TRUE), sep = '\n')
}


#' 
#' \code{readConfigFile} reads the YAML config file into a global 
#' environment variable
#' 
#' @param a boolean
#' The YAML config file is in the working directory or in the parent 
#' directory (i.e. one directory above) 
#' 
#' @examples 
#' readConfigFile(TRUE)
#' 
readConfigFile <- function(a) {
  vName <- "config"
  if (a == TRUE){
    assign(vName, yaml.load_file("91-Config.yaml"), envir = .GlobalEnv)
  }
  else {
    assign(vName, yaml.load_file("../91-Config.yaml"), envir = .GlobalEnv)
  }
}


#' 
#' \code{getMainDir} provides the value of the specific 
#' configuration item
#' 
#' @return the value of the maindir configuration item
#' 
#' @examples 
#' getMainDir()
#' 
getMainDir <- function() {
  return(config$directories$maindir)
}


#' 
#' \code{getBackupDir} provides the value of the specific 
#' configuration item and creates the directory if it does 
#' not exist
#' 
#' @return the value of the backupdir configuration item
#' 
#' @examples 
#' getBackupDir()
#' 
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


#' 
#' \code{getDocDir} provides the value of the specific 
#' configuration item
#' 
#' @return the value of the documents configuration item
#' 
#' @examples 
#' getDocDir()
#' 
getDocDir <- function() {
  return(config$directories$documents)
}


#' 
#' \code{getDocInputDir} provides the value of the specific 
#' configuration item
#' 
#' @return the value of the documentinput configuration item
#' 
#' @examples 
#' getDocInputDir()
#' 
getDocInputDir <- function() {
  return(config$directories$documentinput)
}


#' 
#' \code{getDocOutputDir} provides the value of the specific 
#' configuration item
#' 
#' @return the value of the documentoutput configuration item
#' 
#' @examples 
#' getDocOutputDir()
#' 
getDocOutputDir <- function() {
  return(config$directories$documentoutput)
}


#' 
#' \code{getDataDir} provides the value of the specific 
#' configuration item
#' 
#' @return the value of the datasets configuration item
#' 
#' @examples 
#' getDataDir()
#' 
getDataDir <- function() {
  return(config$directories$datasets)
}


#' 
#' \code{getStartYear} provides the value of the specific 
#' configuration item
#' 
#' @return the value of the startyear configuration item
#' 
#' @examples 
#' getStartYear()
#' 
getStartYear <- function() {
  return(config$years$startyear)
}


#' 
#' \code{getEndYear} provides the value of the specific 
#' configuration item
#' 
#' @return the value of the endyear configuration item
#' 
#' @examples 
#' getEndYear()
#' 
getEndYear <- function() {
  return(config$years$endyear)
}


#' 
#' \code{getStartMonth} provides the value of the specific 
#' configuration item
#' 
#' @return the value of the startmonth configuration item
#' 
#' @examples 
#' getStartMonth()
#' 
getStartMonth <- function() {
  return(config$months$startmonth)
}


#' 
#' \code{getEndMonth} provides the value of the specific 
#' configuration item
#' 
#' @return the value of the endmonth configuration item
#' 
#' @examples 
#' getEndMonth()
#' 
getEndMonth <- function() {
  return(config$months$endmonth)
}


#' 
#' \code{backupFiles} makes a copy of the most important 
#' files to a safe location set by the YAML configuration 
#' file
#' 
#' @examples 
#' backupFiles()
#' 
backupFiles <- function() {
  #Main directory files
  filesMain <- list.files(getMainDir(), full.names = TRUE)
  file.copy(filesMain, getBackupDir(), overwrite = TRUE)
  #Documents folder
  filesDocuments <- list.files(getDocDir(), full.names = TRUE)
  file.copy(filesDocuments,
            file.path(getBackupDir(),
                      "Documents"),
            overwrite = TRUE)
}


#' 
#' \code{getWData} provides the value of the specific 
#' configuration item
#' 
#' @return the value of the wildlife configuration item
#' 
#' @examples 
#' getWData()
#' 
getWData <- function() {
  return(config$sources$wildlife)
}


#' 
#' \code{getFData} provides the value of the specific 
#' configuration item
#' 
#' @return the value of the flightdata configuration item
#' 
#' @examples 
#' getFData()
#' 
getFData <- function() {
  return(config$sources$flightdata)
}


#' 
#' \code{removeDataSetVariables} removes the data set variables 
#' from the memory and calls the garbage collection to free up 
#' memory - currently disabled
#' 
#' @examples 
#' removeDataSetVariables()
#' 
removeDataSetVariables <- function() {
  # rm(list = ls(pattern = "On_Time_On_Time_Performance*",
  #              envir = .GlobalEnv),
  #    envir = .GlobalEnv)
  # rm(list = ls(pattern = "sr_*",
  #              envir = .GlobalEnv),
  #    envir = .GlobalEnv)
  # gc()
}


#' 
#' \code{loadSourceCodeFunctions} makes the functions created 
#' in different R files available for further use and process 
#' management
#' 
#' @examples 
#' loadSourceCodeFunctions()
#' 
loadSourceCodeFunctions <- function() {
  source("01-WildLiveStrikeDataSetDataPreparation.R")
  source("02-OnTimeFlightPerformanceDataSetDataPreparation.R")
  source("03-WildLiveStrikeDataSetDataCleanup.R")
  source("04-OnTimeFlightPerformanceDataSetMergeByYear.R")
}

