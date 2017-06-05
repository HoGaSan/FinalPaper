source("90-UserDefinedFunctions.R")
suppressPackageStartupMessages(loadLibraries())
suppressPackageStartupMessages(readConfigFile(TRUE))


firstSetOfColumns <- c("dataYear",
                       "numberOfRecords",
                       "factorOPID",
                       "factopATYPE",
                       "factorAC_CLASS",
                       "factorAC_MASS",
                       "factorTYPE_ENG")

fistSetOfColumnTitles <- c("Year",
                           "# of reports",
                           "Operators",
                           "Aircraft",
                           "Aircraft type",
                           "Aircraft mass type",
                           "Engine type")

printTable(Full = TRUE, DataFile = "01_EXP_Animal_Strikes.rds", ColumnNames = firstSetOfColumns, ColumnTitles = fistSetOfColumnTitles)



setOfColumns <- c("dataYear",
                  "factorTIME_OF_DAY",
                  "factorAIRPORT_ID",
                  "factorSTATE",
                  "factorPHASE_OF_FLT",
                  "factorSKY",
                  "factorPRECIP",
                  "factorWARNED")

setOfColumnTitles <- c("Year",
                       "Time of day",
                       "Airports",
                       "States",
                       "Phase of flight",
                       "Sky",
                       "Precipitation",
                       "Warned")

printTable(Full = FALSE, 
           DataFile = "01_EXP_Animal_Strikes.rds", 
           ColumnNames = setOfColumns, 
           ColumnTitles = setOfColumnTitles)



  dataDir <- getDataDir()
  startYear <- getStartYear()
  endYear <- getEndYear()

i <- 1990
    RDSFileName <- paste(i,
                         "_Animal_Strikes.rds",
                         sep = "")
    
    RDSFile <- paste(dataDir,
                     "/",
                     RDSFileName,
                     sep = "")
 
    
    variableName <- paste("AS_", i, sep="")
    assign(variableName, readRDS(file = RDSFile))

    
    ColumnNames <- c(
    "INDEX_NR",
    "OPID",
    "OPERATOR",
    "ATYPE",
    "AC_CLASS",
    "AC_MASS",
    "TYPE_ENG",
    "REG",
    "FLT",
    "INCIDENT_DATE",
    "INCIDENT_MONTH",
    "INCIDENT_YEAR",
    "TIME_OF_DAY",
    "TIME",
    "AIRPORT_ID",
    "AIRPORT",
    "STATE",
    "FAAREGION",
    "ENROUTE",
    "RUNWAY",
    "HEIGHT",
    "SPEED",
    "DISTANCE",
    "PHASE_OF_FLT",
    "SKY",
    "PRECIP",
    "WARNED")
    
    str(get(variableName))
        
    describedDataSet <- get(variableName)[, ..ColumnNames]
    
    
    
       
    variableName <- paste("AS_", i, sep="")
    assign(variableName, readRDS(file = RDSFile))
    #DataField <- "AC_CLASS"
    DataField <- "TIME_OF_DAY"
    DataYear <- i

    ggplot(data = get(variableName), aes(get(DataField))) +
      ggtitle(paste("Data distribution of ",DataField," in year ", DataYear, sep="")) +
      geom_bar() +
      coord_flip() + 
      xlab("") + 
      ylab("")
    
    
    +
      theme(axis.text.y = element_text(angle = 90, hjust = 1))
      opts(title=) 
    




