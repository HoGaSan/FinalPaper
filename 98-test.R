source("90-UserDefinedFunctions.R")
suppressPackageStartupMessages(loadLibraries())
suppressPackageStartupMessages(readConfigFile(TRUE))


    
    
       

    ggplot(data = get(variableName), aes(get(DataField))) +
      ggtitle(paste("Data distribution of ",DataField," in year ", DataYear, sep="")) +
      geom_bar() +
      coord_flip() + 
      xlab("") + 
      ylab("")
    
    
    +
      theme(axis.text.y = element_text(angle = 90, hjust = 1))
      opts(title=) 
    

      
      RDSFileNameSelected <- "06_SEL_Airport.rds"
      
      RDSFileSelected <- paste(dataDir,
                               "/",
                               RDSFileNameSelected,
                               sep = "")
      originalDataSetSel <- readRDS(file = RDSFileSelected)

rm(list = ls())

dataDir <- getDataDir()

i = 1990
RDSFileName <- paste(i,
                     "_On_Time_On_Time_Performance_04_Cle.rds",
                     sep = "")

RDSFileName <- "1990_Animal_Strikes_04_Cle.rds"

RDSFile <- paste(dataDir,
                 "/",
                 RDSFileName,
                 sep = "")

#Read the data file into a variable
variableName <- paste("AS_", i, sep="")
assign(variableName, readRDS(file = RDSFile))


dataSet <- get(variableName)

#DT1 <- dataSet[Origin == "JFK", .N, by = c("Origin", "Year")]
DT1 <- dataSet[, .N, by = c("Origin", "Year")]
names(DT1) <- c("Airport",
                "Year",
                "OriginCount")
setkey(DT1, Airport, Year)

#DT2 <- dataSet[Dest == "JFK", .N, by = c("Dest", "Year")]
DT2 <- dataSet[, .N, by = c("Dest", "Year")]
names(DT2) <- c("Airport",
                "Year",
                "DestinationCount")
setkey(DT2, Airport, Year)

DT3 <- DT1[DT2, flightCount := OriginCount + DestinationCount]
DT3[,c("Airport","Year","flightCount")]

DT1[Airport=="MKC"]

DT3 <- DT1[DT2]


DT4 <- dataSet[, .(.N, max(Distance), min(Distance), sum(Distance)), by = c("Origin", "Year")]
names(DT4) <- c("Airport",
                "Year",
                "OriginMaxDistance")

dataSet[Origin == "BLI",]




OGG
O: 3004
D: 2981
  
LAX
O: 169834
D: 169439
  
JFK
O: 42476
D: 43046







RDSFileName <- "07_CLE_Airport.rds"

RDSFile <- paste(dataDir,
                 "/",
                 RDSFileName,
                 sep = "")


    #Read the data file into a variable
    originalDataSet <- readRDS(file = RDSFile)
    