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
  if (!require(png)) {install.packages("png"); require(png)}
  if (!require(grid)) {install.packages("grid"); require(grid)}
  if (!require(pander)) {install.packages("pander"); require(pander)}

  #update R
  updateR(TRUE)
  

  #update MiKTeX packages
  #system("mpm --update --quiet")
  
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
    "- yaml version ", packageVersion("yaml"),"\n",
    "- png version ", packageVersion("png"),"\n",
    "- grid version ", packageVersion("grid"),"\n",
    "- pander version ", packageVersion("pander"),"\n\n",
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
  source("03-WildLifeStrikeDataSetSplitByYear.R")
  source("04-OnTimeFlightPerformanceDataSetMergeByYear.R")
  source("05-ExploreWildLifeStrikeDataSet.R")
  source("06-ExploreOnTimeFlightPerformanceDataSet.R")
  source("07-DescribeWildLifeStrikeDataSet.R")
  source("08-DescribeOnTimeFlightPerformanceDataSet.R")
  source("09-SelectWildLifeStrikeDataSet.R")
  source("10-SelectOnTimeFlightPerformanceDataSet.R")
  source("11-CleanupWildLifeStrikeDataSet.R")
  source("12-CleanupOnTimeFlightPerformanceDataSet.R")
  source("13-AirportDataSetDataPreparation.R")
  source("14-DescribeAirportDataSet.R")
  source("15-SelectAirportDataSet.R")
  source("16-CleanupAirportDataSet.R")
  
  #source("17-DeriveAirportAttributes.R")
}


#' 
#' \code{saveBarPlotPNG} saves the required bar plot based on 
#' the details in the YAML config file
#' 
#' @param DataYear integer
#' The year of the data set being used for the plot
#' 
#' @param DataSet string
#' The name of the data set the plot is being created from
#' 
#' @param DataField string
#' The name of the data field the plot is being created from
#' 
#' @param DataStage string
#' The name of the stage of the data
#' 
#' @param DataObject object
#' The data object to create the plot
#' 
#' @examples 
#' saveBarPlotPNG(1990, "Animal Strike", DT)
#' 
saveBarPlotPNG <- function(DataYear, DataSet, DataField, DataStage, DataObject) {
  currentWorkingDir <- getwd()
  setwd(getDocInputDir())
  targetFileName <- paste(DataYear,
                          "_",
                          DataSet,
                          "_",
                          DataField,
                          "_",
                          DataStage,
                          ".png",
                          sep="")
  
  plotText <- data.table(
    keys = c(
      "AC_CLASS",
      "AC_MASS",
      "TYPE_ENG",
      "TIME_OF_DAY",
      "PHASE_OF_FLT",
      "SKY",
      "PRECIP",
      "Carrier",
      "DistanceGroup"
      ),
    texts = c(
      "Aircraft class",
      "Aircraft mass type",
      "Engine type",
      "Time of day",
      "Flight phase",
      "Sky condition",
      "Precipitation",
      "Airline carrier",
      "Flight distance group"
      )
  )
  
  if (!is.empty(tolower(plotText[keys==DataField,texts]))) {
    lowerPlotText <- tolower(plotText[keys==DataField,texts])
    labelAxisX <- plotText[keys==DataField,texts]
  } else {
    message("Key not found")
    return()
  }
  
  plotTitle <- paste("Data distribution of "
                     ,lowerPlotText,
                     " in ",
                     DataYear,
                     sep="")
  
  
  test <- DataObject
  
  ggplot(data = DataObject, aes(get(DataField))) +
    ggtitle(plotTitle) + #plot title
    geom_bar(fill = "#99ccff", color = "#99ccff") + #plotting a bar chart
    coord_flip() + #flip the drawing of the axises --> Y will be the horizontal
    xlab(labelAxisX) + #set the vertical axis text
    ylab("") +
    theme(
      #align title to the center
      plot.title = element_text(hjust = 0.5, face="bold"),
      #set plot background colors
      plot.background = element_rect(fill = "white", colour = "white"),
      #set panel background colors
      panel.background = element_rect(fill = "white", colour = "white"),
      #set the fonts to serif, which is set to Times New Roman
      text = element_text(family = "serif"),
      #change the angle of the axis text
      axis.text.x = element_text(angle=45, hjust=1, vjust=1)
      
    )
  
  ggsave(
    targetFileName,
    units = "in", #units are in pixels
    width = 5, #width of the plot in in (should be the same as the height)
    height = 5, #height of the plot in in (should be the same as the width)
    dpi = 72 #nominal resolution in ppi (pixels per inch)
  )

  setwd(currentWorkingDir)
}


#' 
#' \code{printTable} prints an rmarkdown table based on the 
#' input variables
#' 
#' @param Full boolean
#' Flag to have the full data set or just the first year to print
#' 
#' @param DataFile string
#' The name of the RDS data file to load the data from
#' 
#' @param ColumnNames string list
#' The name of columns to be extracted from the data table
#' 
#' @param ColumnTitles string list
#' The titles the columns should have in the table
#' 
#' @examples 
#' printTable(
#'   TRUE, 
#'   "example.rds",
#'   c("V1", "V2"),
#'   c("Column1", "Column2")
#' )
#' 
printTable <- function(Full, DataFile, ColumnNames, ColumnTitles) {

  dataDir <- getDataDir()
  
  RDSExpFile <- paste(dataDir,
                      "/",
                      DataFile,
                      sep = "")
  
  dataTable <- readRDS(file = RDSExpFile)
  
  if (Full == TRUE) {
    kable(dataTable[, ..ColumnNames],
          col.names = ColumnTitles,
          align = "c")
  } else {
    kable(dataTable[1, ..ColumnNames],
          col.names = ColumnTitles,
          align = "c")
  }

}

#' 
#' \code{getStates} returns the U.S. state abbreviations
#' 
#' @examples 
#' getStates()
#' 
getStates <- function() {
  return(
    c(
      "AL",
      "AK",
      "AZ",
      "AR",
      "CA",
      "CO",
      "CT",
      "DE",
      "FL",
      "GA",
      "HI",
      "ID",
      "IL",
      "IN",
      "IA",
      "KS",
      "KY",
      "LA",
      "ME",
      "MD",
      "MA",
      "MI",
      "MN",
      "MS",
      "MO",
      "MT",
      "NE",
      "NV",
      "NH",
      "NJ",
      "NM",
      "NY",
      "NC",
      "ND",
      "OH",
      "OK",
      "OR",
      "PA",
      "RI",
      "SC",
      "SD",
      "TN",
      "TX",
      "UT",
      "VT",
      "VA",
      "WA",
      "WV",
      "WI",
      "WY"
      )
    )
}


#' 
#' \code{printStates} prints the U.S. state abbreviations and names
#' in an rmarkdown table
#' 
#' @examples 
#' printStates()
#' 
printStates <- function() {
  
  dataState <- data.table(
    state = c(
      "AL",
      "AK",
      "AZ",
      "AR",
      "CA",
      "CO",
      "CT",
      "DE",
      "FL",
      "GA",
      "HI",
      "ID",
      "IL",
      "IN",
      "IA",
      "KS",
      "KY",
      "LA",
      "ME",
      "MD",
      "MA",
      "MI",
      "MN",
      "MS",
      "MO"
    ),
    stateName = c(
      "Alabama",
      "Alaska",
      "Arizona",
      "Arkansas",
      "California",
      "Colorado",
      "Connecticut",
      "Delaware",
      "Florida",
      "Georgia",
      "Hawaii",
      "Idaho",
      "Illinois",
      "Indiana",
      "Iowa",
      "Kansas",
      "Kentucky",
      "Louisiana",
      "Maine",
      "Maryland",
      "Massachusetts",
      "Michigan",
      "Minnesota",
      "Mississippi",
      "Missouri"
      ),
    e1 = c(
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " "
    ),
    e2 = c(
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " "
    ),
    state2 = c(
      "MT",
      "NE",
      "NV",
      "NH",
      "NJ",
      "NM",
      "NY",
      "NC",
      "ND",
      "OH",
      "OK",
      "OR",
      "PA",
      "RI",
      "SC",
      "SD",
      "TN",
      "TX",
      "UT",
      "VT",
      "VA",
      "WA",
      "WV",
      "WI",
      "WY"
    ),
    stateName2 = c(
      "Montana",
      "Nebraska",
      "Nevada",
      "New Hampshire",
      "New Jersey",
      "New Mexico",
      "New York",
      "North Carolina",
      "North Dakota",
      "Ohio",
      "Oklahoma",
      "Oregon",
      "Pennsylvania",
      "Rhode Island",
      "South Carolina",
      "South Dakota",
      "Tennessee",
      "Texas",
      "Utah",
      "Vermont",
      "Virginia",
      "Washington",
      "West Virginia",
      "Wisconsin",
      "Wyoming"
    )
  )
  
  kable(dataState,
          col.names = c("Abbreviation","Name","","","Abbreviation","Name"),
          align = "c")

}