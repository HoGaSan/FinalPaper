source("90-UserDefinedFunctions.R")
suppressPackageStartupMessages(loadLibraries())
suppressPackageStartupMessages(readConfigFile(TRUE))

getwd()

source("97-UDF.R")


RDSFileNameCleaned <- "1990_On_Time_On_Time_Performance_01_Orig.rds"

RDSFile <- paste(dataDir,
                        "/",
                        RDSFileNameCleaned,
                        sep = "")

test <- readRDS(file = RDSFile)

rm(test)

i = 1990

variableName <- paste("AS_", i, sep="")
assign(variableName, readRDS(file = RDSFile), envir = .GlobalEnv)


get(variableName)

substitute(get(variableName))
    
eval(as.symbol(variableName), envir = .GlobalEnv)

saveBarPlotPNG2(DataYear = 1990, DataSet = "AnimalStrike", DataField = "AC_MASS", DataStage = "01_Orig", DataObject = get(variableName))

?dev.off()
dataSet <- readRDS(file = RDSFileCleaned)

rm(dataSet)

DataYear <- 1990
DataField <- "AC_MASS"




targetFileName <- paste(DataYear,
                        "_",
                        "AnimalStrike",
                        "_",
                        "DataField",
                        "_",
                        "01_Orig",
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
} else {
  lowerPlotText <- "Key not found"
}


plotTitle <- paste("Data distribution of ",tolower(plotText[keys==DataField,texts])," in ", DataYear, sep="")
labelAxisX <- plotText[keys==DataField,texts]


png(
  targetFileName, #File name, no directory!
  units = "px", #units are in pixels
  width = 300, #width of the plot in px (should be the same as the height)
  height = 300, #height of the plot in px (should be the same as the width)
  res = 72 #nominal resolution in ppi (pixels per inch)
) 


ggplot(data = dataSet, aes(get(DataField))) +
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

dev.off() 

"#99ccff"

"#56B4E9"

names(pdfFonts())

warnings()

windowsFonts()



assign("last.warning", NULL, envir = baseenv())





+
      theme(axis.text.y = element_text(angle = 90, hjust = 1))


      
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



RDSFileName <- "06_SEL_Airport.rds"

RDSFile <- paste(dataDir,
                 "/",
                 RDSFileName,
                 sep = "")

airports <- readRDS(file = RDSFile)




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
    