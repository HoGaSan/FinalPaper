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
  if (!require(maps)) {install.packages("maps"); require(maps)}
  if (!require(mapdata)) {install.packages("mapdata"); require(mapdata)}
  if (!require(sp)) {install.packages("sp"); require(sp)}
  if (!require(h2o)) {install.packages("h2o"); require(h2o)}
  
  #update R
  updateR(TRUE)
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
    "- maps version ", packageVersion("maps"),"\n",
    "- mapdata version ", packageVersion("mapdata"),"\n",
    "- sp version ", packageVersion("sp"),"\n",
    "- h2o version ", packageVersion("h2o"),"\n\n",
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
  source("17-DeriveAirportAttributes.R")
  source("18-IntegrateAttributes.R")
  source("19-Model01.R")
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
#' saveBarPlotPNG(1990, "Animal Strike", "State", "01_Origin", DT)
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
    #xlab(labelAxisX) + #set the vertical (coordflip!) axis text
    xlab("") + #set the vertical (coordflip!) axis text
    ylab("") + #set the horizontal (coordflip!) axis text
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
#' \code{saveMapPNG} saves the required state map 
#' the details in the YAML config file
#' 
#' @param DataState string list
#' The name of the state
#' 
#' @param DataObject object
#' The data object to create the map
#' 
#' @examples 
#' saveMapPNG("TX", DT)
#' 
saveMapPNG <- function(DataState, DataObject) {
  currentWorkingDir <- getwd()
  setwd(getDocInputDir())
  
  stateNames <- data.table(
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
      "Missouri",
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
  
  for (actualState in DataState){
    targetFileName <- paste("State_",
                            actualState,
                            "_Airports.png",
                            sep="")
    
    
    plotTitle <- paste("Modeled airports in ",
                       stateNames[state==actualState,
                                  "stateName"],
                       sep="")
    
    if (actualState == "AK"){
      base_map <- map_data("world", "USA:alaska")
    } else if (actualState == "HI") {
      base_map <- map_data("world", "USA:hawaii")
    } else {
      base_map <- map_data("state",
                           tolower(stateNames[state==actualState,
                                              "stateName"])
      )
    }
    
    temp <- DataObject
    rm(temp)
    
    ggplot()  + 
      geom_polygon(data=base_map,
                   aes(x=long, 
                       y=lat, 
                       group=group), 
                   color="darkblue", 
                   fill = "#99CCFF") +
      geom_point(aes(x = DataObject[State==actualState,
                                    long],
                     y = DataObject[State==actualState,
                                    lat],
                     size = DataObject[State==actualState,
                                       StrikeNo]), 
                 color = "#FFCC99") +
      theme_classic() +
      ggtitle(plotTitle) +
      xlab("") +
      ylab("") +
      scale_size_continuous(range = c(1, 6)) +
      theme(
        plot.title = element_text(hjust = 0.5, 
                                  face="bold"),
        legend.position = "none",
        axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        text = element_text(family = "serif")
      )
    
    ggsave(
      targetFileName,
      units = "in", #units are in pixels
      width = 5, #width of the plot in in (should be the same as the height)
      height = 5, #height of the plot in in (should be the same as the width)
      dpi = 72 #nominal resolution in ppi (pixels per inch)
    )
    
  }

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


#' 
#' \code{regeneratePlots} regenerates the plots based on the data sets
#' 
#' @examples 
#' regeneratePlots()
#' 
regeneratePlots <- function(){
  dataDir <- getDataDir()
  startYear <- getStartYear()
  endYear <- getEndYear()
  
  for (i in startYear:endYear){
    RDSFileName_01 <- paste(i,
                         "_Animal_Strikes_01_Orig.rds",
                         sep = "")
    
    RDSFile_01 <- paste(dataDir,
                     "/",
                     RDSFileName_01,
                     sep = "")
    
    #Read the data file into a variable
    variableName_01 <- paste("AS_", i, sep="")
    assign(variableName_01, readRDS(file = RDSFile_01))

    #Save the plots as PNG files
    saveBarPlotPNG(DataYear = i, 
                   DataSet = "AnimalStrike", 
                   DataField = "AC_CLASS",
                   DataStage = "01_Orig",
                   DataObject = get(variableName_01))
    saveBarPlotPNG(DataYear = i, 
                   DataSet = "AnimalStrike", 
                   DataField = "AC_MASS", 
                   DataStage = "01_Orig",
                   DataObject = get(variableName_01))
    saveBarPlotPNG(DataYear = i, 
                   DataSet = "AnimalStrike", 
                   DataField = "TYPE_ENG", 
                   DataStage = "01_Orig",
                   DataObject = get(variableName_01))
    saveBarPlotPNG(DataYear = i, 
                   DataSet = "AnimalStrike",
                   DataField = "TIME_OF_DAY", 
                   DataStage = "01_Orig",
                   DataObject = get(variableName_01))
    saveBarPlotPNG(DataYear = i, 
                   DataSet = "AnimalStrike", 
                   DataField = "PHASE_OF_FLT", 
                   DataStage = "01_Orig",
                   DataObject = get(variableName_01))
    saveBarPlotPNG(DataYear = i, 
                   DataSet = "AnimalStrike", 
                   DataField = "SKY", 
                   DataStage = "01_Orig",
                   DataObject = get(variableName_01))
    saveBarPlotPNG(DataYear = i,
                   DataSet = "AnimalStrike", 
                   DataField = "PRECIP", 
                   DataStage = "01_Orig",
                   DataObject = get(variableName_01))

    #Free up the memory
    rm(list = variableName_01)
    rm(variableName_01)
    gc()
      
    RDSFileName_02 <- paste(i,
                            "_Animal_Strikes_04_Cle.rds",
                            sep = "")
    
    RDSFile_02 <- paste(dataDir,
                        "/",
                        RDSFileName_02,
                        sep = "")
    
    #Read the data file into a variable
    variableName_02 <- paste("AS_", i, sep="")
    assign(variableName_02, readRDS(file = RDSFile_02))
    
    #Save the plots as PNG files
    saveBarPlotPNG(DataYear = i, 
                   DataSet = "AnimalStrike", 
                   DataField = "AC_CLASS",
                   DataStage = "04_Cleaned",
                   DataObject = get(variableName_02))
    saveBarPlotPNG(DataYear = i, 
                   DataSet = "AnimalStrike", 
                   DataField = "AC_MASS", 
                   DataStage = "04_Cleaned",
                   DataObject = get(variableName_02))
    saveBarPlotPNG(DataYear = i, 
                   DataSet = "AnimalStrike", 
                   DataField = "TYPE_ENG", 
                   DataStage = "04_Cleaned",
                   DataObject = get(variableName_02))
    saveBarPlotPNG(DataYear = i, 
                   DataSet = "AnimalStrike",
                   DataField = "TIME_OF_DAY", 
                   DataStage = "04_Cleaned",
                   DataObject = get(variableName_02))
    saveBarPlotPNG(DataYear = i, 
                   DataSet = "AnimalStrike", 
                   DataField = "PHASE_OF_FLT", 
                   DataStage = "04_Cleaned",
                   DataObject = get(variableName_02))
    saveBarPlotPNG(DataYear = i, 
                   DataSet = "AnimalStrike", 
                   DataField = "SKY", 
                   DataStage = "04_Cleaned",
                   DataObject = get(variableName_02))
    saveBarPlotPNG(DataYear = i,
                   DataSet = "AnimalStrike", 
                   DataField = "PRECIP", 
                   DataStage = "04_Cleaned",
                   DataObject = get(variableName_02))
    
    #Free up the memory
    rm(list = variableName_02)
    rm(variableName_02)
    gc()

      
    RDSFileName_03 <- paste(i,
                         "_On_Time_On_Time_Performance_01_Orig.rds",
                         sep = "")
    
    RDSFile_03 <- paste(dataDir,
                     "/",
                     RDSFileName_03,
                     sep = "")
      
    #Read the data file into a variable
    variableName_03 <- paste("FP_", i, sep="")
    assign(variableName_03, readRDS(file = RDSFile_03))
        
    #Save the plots as PNG files
    saveBarPlotPNG(DataYear = i, 
                   DataSet = "FlightData", 
                   DataField = "Carrier", 
                   DataStage = "01_Orig",
                   DataObject = get(variableName_03))
    
    saveBarPlotPNG(DataYear = i, 
                   DataSet = "FlightData", 
                   DataField = "DistanceGroup", 
                   DataStage = "01_Orig",
                   DataObject = get(variableName_03))

    #Free up the memory
    rm(list = variableName_03)
    rm(variableName_03)
    gc()
        

    RDSFileName_04 <- paste(i,
                            "_On_Time_On_Time_Performance_04_Cle.rds",
                            sep = "")
    
    RDSFile_04 <- paste(dataDir,
                        "/",
                        RDSFileName_04,
                        sep = "")
    
    #Read the data file into a variable
    variableName_04 <- paste("FP_", i, sep="")
    assign(variableName_04, readRDS(file = RDSFile_04))
    
    #Save the plots as PNG files
    saveBarPlotPNG(DataYear = i, 
                   DataSet = "FlightData", 
                   DataField = "Carrier", 
                   DataStage = "04_Cleaned",
                   DataObject = get(variableName_04))
    
    saveBarPlotPNG(DataYear = i, 
                   DataSet = "FlightData", 
                   DataField = "DistanceGroup", 
                   DataStage = "04_Cleaned",
                   DataObject = get(variableName_04))
    
    #Free up the memory
    rm(list = variableName_04)
    rm(variableName_04)
    gc()

  } #end of "for (i in startYear:endYear)"

}


#' 
#' \code{convertToDMSNumber} 
#' 
#' @param inputString string
#' The DMS (Degrees Minutes Seconds) input string in the following format:
#' DD-MM-SS.####c
#' 
#' @return the numeric value of the latitude / longitude received 
#' in a character string
#' 
#' @examples 
#' convertToDMSNumber("")
#' 

convertToDMSNumber <- function(inputString){
  
  getDot <- regexpr(pattern ='\\.',inputString)
  getLastChar <- substring(inputString, nchar(as.character(inputString)))
  
  return(
    inputString %>%
      sub('-', 'd', .) %>%
      sub('-', '\'', .) %>%
      substr(. , 1, getDot-1) %>%
      paste(.,'"', getLastChar, sep = "") %>%
      char2dms %>%
      as.numeric
    )
}

#' 
#' \code{saveModelingHistogramPNG} saves the required histogram 
#' 
#' @param FieldName string
#' The field name
#' 
#' @param DataObject object
#' The data to create the plot
#' 
#' @param BinSize number
#' The bin size to be used in the plot
#' 
#' @examples 
#' saveModelingHistogramPNG("Field", DT, 20)
#' 
saveModelingHistogramPNG <- function(FieldName, DataObject, BinSize) {
  currentWorkingDir <- getwd()
  setwd(getDocInputDir())
  targetFileName <- paste("Histogram_of_",
                          FieldName,
                          ".png",
                          sep="")
  
  plotText <- data.table(
    keys = c(
      "StrikeNo",
      "OriginCount",
      "OriginMaxDistance",
      "OriginMinDistance",
      "OriginAvgDistance",
      "DestinationCount",
      "DestinationMaxDistance",
      "DestinationMinDistance",
      "DestinationAvgDistance",
      "ARPElevation",
      "LandAreaCoveredByAirport"
    ),
    texts = c(
      "number of animal strikes",
      "number of flights originated",
      "maximum flight distance originated",
      "minimum flight distance originated",
      "average flight distance originated",
      "number of flights departed",
      "maximum flight distance departed",
      "minimum flight distance departed",
      "average flight distance departed",
      "airport elevation",
      "land covered by the airport"
    )
  )
  
  if (!is.empty(tolower(plotText[keys==FieldName,texts]))) {
    lowerPlotText <- tolower(plotText[keys==FieldName,texts])
    labelAxisX <- plotText[keys==FieldName,texts]
  } else {
    message("Key not found")
    return()
  }
  
  plotTitle <- paste("Histogram of "
                     ,lowerPlotText,
                     sep="")
  
  test <- DataObject

  ggplot(data=modelData, aes(get(FieldName))) +
    geom_histogram(binwidth = BinSize, fill = "#99ccff", color = "white") +
    ggtitle(plotTitle) + #plot title
    xlab("") + #set the vertical (coordflip!) axis text
    ylab("") + #set the horizontal (coordflip!) axis text
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
#' \code{saveModelingHistogramLogPNG} saves the required histogram 
#' 
#' @param FieldName string
#' The field name
#' 
#' @param DataObject object
#' The data to create the plot
#' 
#' @param BinSize number
#' The bin size to be used in the plot
#' 
#' @examples 
#' saveModelingHistogramLogPNG("Field", DT, 20)
#' 
saveModelingHistogramLogPNG <- function(FieldName, DataObject, BinSize) {
  currentWorkingDir <- getwd()
  setwd(getDocInputDir())
  targetFileName <- paste("Histogram_of_log_",
                          FieldName,
                          ".png",
                          sep="")
  
  plotText <- data.table(
    keys = c(
      "StrikeNo",
      "OriginCount",
      "OriginMaxDistance",
      "OriginMinDistance",
      "OriginAvgDistance",
      "DestinationCount",
      "DestinationMaxDistance",
      "DestinationMinDistance",
      "DestinationAvgDistance",
      "ARPElevation",
      "LandAreaCoveredByAirport"
    ),
    texts = c(
      "number of animal strikes",
      "number of flights originated",
      "maximum flight distance originated",
      "minimum flight distance originated",
      "average flight distance originated",
      "number of flights departed",
      "maximum flight distance departed",
      "minimum flight distance departed",
      "average flight distance departed",
      "airport elevation",
      "land covered by the airport"
    )
  )
  
  if (!is.empty(tolower(plotText[keys==FieldName,texts]))) {
    lowerPlotText <- tolower(plotText[keys==FieldName,texts])
    labelAxisX <- plotText[keys==FieldName,texts]
  } else {
    message("Key not found")
    return()
  }
  
  plotTitle <- paste("Histogram of "
                     ,lowerPlotText,
                     " (log)",
                     sep="")
  
  test <- DataObject
  
  ggplot(data=modelData, aes(log(get(FieldName)))) +
    geom_histogram(binwidth = BinSize, fill = "#99ccff", color = "white") +
    ggtitle(plotTitle) + #plot title
    xlab("") + #set the vertical (coordflip!) axis text
    ylab("") + #set the horizontal (coordflip!) axis text
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
#' \code{saveModelingHistogramLogPNG} saves the required histogram 
#' 
#' @param AirlineCode string
#' The code of the airline
#' 
#' @return the airline name in uppercase
#' 
#' @examples 
#' saveModelingHistogramLogPNG("Field", DT, 20)
#' 
getAirlineName <- function(AirlineCode) {
  
  airlines <- data.table(
    CarrierCode = c(
      "9E",
      "AA",
      "AQ",
      "AS",
      "B6",
      "CO",
      "DH",
      "DL",
      "EV",
      "F9",
      "FL",
      "HA",
      "HP",
      "MQ",
      "NK",
      "NW",
      "OH",
      "OO",
      "PA",
      "TW",
      "TZ",
      "UA",
      "US",
      "VX",
      "WN",
      "XE",
      "YV",
      "EA"
    ),
    CarrierName = c(
      "Pinnacle",
      "American Airlines",
      "Aloha Airlines",
      "Alaska Airlines",
      "JetBlue Airways",
      "Continental Airlines",
      "Atlantic Coast Airlines",
      "Delta Air Lines",
      "Atlantic Southeast",
      "Frontier Airlines",
      "AirTran Airways",
      "Hawaiian Air",
      "America West Airlines",
      "American Eagle Airlines",
      "Spirit Airlines",
      "Northwest Airlines",
      "Comair Airlines",
      "SkyWest Airlines",
      "Pan Am",
      "Trans World Airlines",
      "ATA Airlines",
      "United Airlines",
      "US Airways",
      "Virgin America",
      "Southwest Airlines",
      "ExpressJet Airlines",
      "Mesa Airlines",
      "Eastern Airline"
    )
  )
  
  return(toupper(airlines[CarrierCode == AirlineCode,CarrierName]))
  
}